Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D534C33D0;
	Fri,  2 Oct 2026 14:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790950809; cv=none; b=PcEZXhsnriOeV1ug1jO8tCmg89MG7CyeeVGl3Q47DNnV/NEooH73uNH/zI06Vdkrc8yzhYYUaKbhEogIacAS5W/KTc/suF4iIrwd0PQD5CizeXQgdsy0FWLT5JLGhoBepGxUROOKB64ZmJDVdYWNWMOfywZHfqZGuAu5wO5kaTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790950809; c=relaxed/simple;
	bh=F6637lIoxTqCWLjNqNS62uXNaegqwTce7IZNpXGeX/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jTMtQf09xWOzJdPhcfLIrYd4SGIrvPad75f2XYSZidYkL6dgjO3ZL2K8HOTeeNCmT7h3xQ60s8ph0rrl3S985MeKL1dYCqNavFEcrNT29juyLWd9QtiX2mc+W4yZftVhkO0ItV0sknvYHGq/XKsMrFDpgKyYutn7ucyH3pmfpW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmBm8JVY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmBm8JVY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E25431F0089A;
	Fri,  2 Oct 2026 14:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790950807;
	bh=70bYm59wPawnULmUm1UPkBUthL23ow/yFAgwQlZxiAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SmBm8JVYcUEa0Mu8Fni0mTEjdUSNPVENVMywK86Osj90+nZdGehJnngQHSrXaY0oO
	 2mJ/eS/5pSxmY8oO2b3Uv532r+ymtvSk7ZP9PQsC8/mjA+Ool+R2BDOvsNFaKRXFsB
	 mGGb9nHQGN+HCA1OfGSdnVqfkZfonxt42tv0HKRGnbt6VBxg2TnhMyXk+UAI4mwbhb
	 ULOlC5hIH+v5ejeZO6D0ibJi0zMzbERkH88YFuQPEFTFx3c1xKbuxFpTvyjkDhJRni
	 DexGVXzMK1b/fb+wKGrUTzOzULXeJYUWTc6bm52jYDan1Y7YSv4Uz985NPPa4zkV9b
	 gjM9+3hSosBzA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	damon@lists.linux.dev,
	Liew Rui Yan <aethernet65535@gmail.com>,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.1.y] mm/damon/core: fix unconditionally skip last region
Date: Fri,  2 Oct 2026 10:19:51 -0400
Message-ID: <2026-10-01-1-daily-reply-0007-re-damon-skip-last-region-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930094853.52736-1-sj@kernel.org>
References: <2026092949-surpass-thimble-02a8@gregkh> <20260930094853.52736-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Fix this by only resetting the charge_{target,addr}_from when last region
> is reached, only skipping when it is applied or cannot split.

I'll hold this until the damon_split_region_at() failure handling fix
you mentioned is posted, and then take 6.12, 6.6 and 6.1 together with
it.

-- 
Thanks,
Sasha
