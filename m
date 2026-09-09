Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CF7348C76
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 04:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788929719; cv=none; b=uUrKGwTtfKiXXkRGv9wkIV6/SqQQsYTUrgnoDlgFscMD8fxdg+33wq/UGYxjj39iBf/mScpEhz8BvJ+ua3ibPtPh2tzH362znzW45lare17fFdiiSY2xFbhuLXZJTy1te5GfcYGfgtPaY8tJ7r30U2Kwc2w4GVPQeRB+ubLGYU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788929719; c=relaxed/simple;
	bh=+eMIOvgHayfYPDDVtLYG5C1xZ8kbP/oxxKjGrMESJTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h1EqpywKjd25ut+uRqlYMxJWtZ+2z0wJD0o4mHhEOCylYAljGyRVOr3Jk+p3+cStVX4pTvnHPiLIt6YwKvKzrvB4MCUd+3yv+Sx1dNCmF6LUELb/rKYKZvotP5IQO63O/p6wWDBIYgDceDgqjP+mZ8ksoYkh+xhQ6eRK+yDDMB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UrqoFzLM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UrqoFzLM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 375F51F00A3E;
	Wed,  9 Sep 2026 04:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788929718;
	bh=3cBMbfajk4Mv3rieP4qZrUruKzUHkpzsKkmvlDjSzcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UrqoFzLMQUPsBq1y9UekvQCv0qT8ZUlUKtWQJ0ILScdSIXVwClWLbToksO5ywB1n0
	 7lm6bgZ+WS1ITfRRmke52Ps1Xg9zg4l6CZueRpr/q90JqF56PXqulRqUoWASYwcSYK
	 N3CXAzL+18dkouz1b4lm6NX9HDhAMwdLfBcdSFZGeY+f4JdGq4ykFCgH9RtEa2bwlf
	 uW1seJTAyHWQk8eV93hwLtZGnSIrlaTGJYLTg1+qv/x5rpPOxmQscUAT4/csLxK0Rf
	 uk6/0Rg1gZ5JrMIPrc559tpM3LeeA0xrpsRQD73rjjx5Y9+3j0EiC5T+2+TatdBRWb
	 Jv2kit+TU1CJw==
From: SJ Park <sj@kernel.org>
To: gregkh@linuxfoundation.org
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] mm/damon/core: skip aging from repeated aggressive merging" failed to apply to 5.15-stable tree
Date: Tue,  8 Sep 2026 21:55:10 -0700
Message-ID: <20260909045511.221732-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090841-retying-object-67ca@gregkh>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 08 Sep 2026 14:52:42 +0200 <gregkh@linuxfoundation.org> wrote:

> 
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
[...]
> ------------------ original commit in Linus's tree ------------------
> 
> From 0250dbe08c730d003ef9f484da56ae09a1ea0c4c Mon Sep 17 00:00:00 2001
> From: SJ Park <sj@kernel.org>
> Date: Sun, 12 Jul 2026 09:54:30 -0700
> Subject: [PATCH] mm/damon/core: skip aging from repeated aggressive merging
> 
> The number of DAMON regions could temporarily exceed the user-defined
> maximum number of regions limit for corner cases.  For example, users
> could lower the limit via runtime parameters update.  For such a case,
> kdamond_merge_regions() repeats merging regions in the case doubling the
> merge threshold.  The repeated merge operation could update the age of
> regions multiple times.  This corrupts the monitoring results.  Fix the
> issue by asking the merge operation to skip aging for the corner case.
> 
> The user impact is degradation of the monitoring quality.  The impact
> should be mild, since the degradation is only temporal, and it is not
> common to happen in realistic setups.
> 
> The issue was discovered [1,2] by Sashiko.
> 
> Link: https://lore.kernel.org/20260712165432.87609-1-sj@kernel.org
> Link: https://lore.kernel.org/20260621203548.10718-1-sj@kernel.org [1]
> Link: https://lore.kernel.org/20260709145425.96247-1-sj@kernel.org [2]
> Fixes: 310d6c15e910 ("mm/damon/core: merge regions aggressively when max_nr_regions is unmet")

The broken commit is backported to 5.15.y.  Seems this patch was tried to be
applied on 5.15.y for the reason.  However, this fix also depends on commit
fda504fade7f ("mm/damon/core: account age of target regions"), which is not in
5.15.y.  So, this patch doesn't need to be ported on 5.15.y.


Thanks,
SJ

[...]
