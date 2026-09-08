Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1444552920;
	Tue,  8 Sep 2026 14:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788879109; cv=none; b=G8rnTk81LqzBmDaB7gFmJvIQVMbS8S8B4eRiQEJE1AVzDa57tZ2AUdS/20cmnJeLKp/NAsVVpJTi43o7S5y0Qa56sXxGmjSr3tARVmEgh3PCZyz2qVXrTGt093W3+U1NuFeJWdHOa3s7s6nOuJ3SC5f3u1qjsJ4sIwwrtaYcvzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788879109; c=relaxed/simple;
	bh=DDb3B+lCZQ8XfFJ78ls6+s3lsapUdWh5T7sKrZqoriQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QbPR9Mzu8W8fLfyz/KWhIo0w0AqnX02ARiR+a1v3N4ErIYQn/SaKCHRKqejJXoVrXZoh1wkeHSt4wGptL/qYITbWoUOg2zytdMLFhxcp2m26WrSBvKaw/6mLBQFCt8Xx2FObI7bJukAHclfgN+MxHwazI4BO0O92W57x8Rs5iI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbHDg+F7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbHDg+F7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2E61F00A3A;
	Tue,  8 Sep 2026 14:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788879100;
	bh=5HhwnTeHEt+NjdQZ0IEPNu7Xi23jc3U/hYhWJffOVLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gbHDg+F7o02qr1+zS/Ce/1wGsbRYhWnb9S5/cNXzn6LUnGYfnuDTth5KZAYMF/ONO
	 /6yxAPiuddWLk5FN7T5fQ+Xh9NKmAXDohX/0mdnjjhOF5uzETeXg1dH0MjBJNpsQ7N
	 R1s2H+Uv0se7TarcsK+bV0ylmU54WH/OfiSZt3voHpMXzSkfs3hDJRXiaoMvTF2I20
	 BstKpmA9bcchQ7JWreVjAd2MO7F8jZPaB6zeBd75Y/iWJ48w6rRepNd3ErNiDmkn+Y
	 WuMn39iuoHUKlE3ExBcS68b416nm8s7bRMOcqDTrIImqBimpvzrpqLEIhqcWOXeKVJ
	 lt1JsJdC7NwoQ==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Liew Rui Yan <aethernet65535@gmail.com>,
	stable@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v3] mm/damon/core: fix unconditionally skip last region
Date: Tue,  8 Sep 2026 07:51:32 -0700
Message-ID: <20260908145133.105111-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260908134739.96919-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  8 Sep 2026 06:47:38 -0700 SJ Park <sj@kernel.org> wrote:

> From: Liew Rui Yan <aethernet65535@gmail.com>
> 
> Once quota set, the charge_{target,addr}_from unconditionally skips and
> resets at the last region of the tracked target, so the last region can
> be skipped even when it has not been processed.
> 
> Example:
> 
>     1. Target has 2 regions: R1 (0-100 bytes) and R2 (100-200 bytes).
>     2. Quota is configured to process only 100 bytes per window.
>     3. Window 1: Processes R1 (0-100).  Quota is full.  charge_{target,
>        addr}_from is saved at (Target, 100).
>     4. Window 2: The loop reaches R2.  Because R2 is
>        damon_last_region(t), the old code unconditionally returns true,
>        skipping R2 entirely and resetting the charge_{target,addr}_from.
> 
>     Result: R2 is permanently skipped even though it has never been
>     processed.
> 
> However, it is important to note that this is a very minor issue.  This
> is because it is triggered only when the previous window saved/kept
> charge_{target,addr}_from, and in the next window, all regions except
> the last region were skipped by damos_skip_charged_region().
> 
> Fix this by only resets the charge_{target,addr}_from when last region
> is reached, only skips when it applied or cannot split.

Sashiko found a pre-existing issue that I'm separately working on.  It is no
blocker for this patch.


Thanks,
SJ

[...]
