Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7D624293C;
	Sun, 30 Aug 2026 18:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788113693; cv=none; b=mSG4623KjLMiVY5epMJl+M5mBF7YlsqIKW056kdTWkk3QM+WN10Pzi0iopllrf1NgNvykRURfFLFOMNtt2Zj+PiI7xlQGm0VboqyYKYFjdPPzIr/m0nXdUfCEw6wwxhnp3mybJyVhZi5mv4X6xBFlc1Jg6qpUj7U7iT0bTVw388=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788113693; c=relaxed/simple;
	bh=z2eITDbHPQloaChdnAzIremnbYRTB6M5RSPRtCi+AjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gOx4cMZTRU86Kv21OfLCNB+btoEZYQDG/PWkxoOM0teJUR/n7oBuEBmpCbTPPg5M7UJJTaoE06R+mFlDhl5XkGEentwX2da+8uQhgMIkIZVe1AnPLpmALmJQ2pnvGVICBUr9oYtKgIhP8PRAo3vGmtJryKuaoWeAXOd9owb9XVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7iC1y6H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7iC1y6H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D9F1F000E9;
	Sun, 30 Aug 2026 18:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788113692;
	bh=R/ExsJARLlh4YfLuTV4QZWOBWCnroOAl4CtLg4Wbva8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e7iC1y6H0Esa9kFZr5h4N5HEyHSq1fV4D0C028OIM5GxG2NOGDRD5QZBrxWRal5oj
	 Q7u6kSz3IwmZRAabxKbdKnu81tpCG8WlZM8WDOVgCi1mIJg/Tg06EiVHEQqBAFag/g
	 9nIjgX5mLSFs61vNnv2D7sxDHWqRUlbp15YQPaGen+y8vIvJdBfpblsNI8TVp1CUxd
	 nEsxCkSR1jq5gYYSjs+DQhUg2O0IJ5fXdzKN4BznUimxYPwPaAC+PPsC8EK5L7NS55
	 M5r50z6y1x/hh+sY7KiflyTCxFZyjmotgs6cnzax6Sd+J/IOYgPtm+amyOgyhyoRw2
	 w0aDJDpvsKDxg==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/damon/core: fix unconditionally skip last region
Date: Sun, 30 Aug 2026 11:14:44 -0700
Message-ID: <20260830181445.104859-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260830063159.6347-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 30 Aug 2026 14:31:50 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

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

Looks good to me!

> 
> Fixes: 50585192bc2e ("mm/damon/schemes: skip already charged targets and regions")
> Cc: <stable@vger.kernel.org> # v5.16.x
> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
