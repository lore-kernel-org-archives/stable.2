Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957842EC0AE
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 13:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781616122; cv=none; b=SzJA5KWOqJLFO7AbBQXS7Lw6XGmIdWOdxD+KKl1PICwfqSkHReKkc0O8lfzMJAayMLiOUwHwXP+Kww0/IOeAX1fcPLRB5jnJyu42Kpaj20PB7gr9iWdPoTWDDNUzvNj29I1wywN/nL/f6jBVnt1r619xyJUdkwr4gXHDS6QUMjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781616122; c=relaxed/simple;
	bh=KRJ/LSYMqs/prOMG2KURVN0AKL9/cb2SXXvclwcslJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUlv5cfXp8J5XWkp79tAudVAYFIt7Jq4XV+UwNKOvet8uW//8WqQZfot2YOkB9jMC/D6K47o2F0pBTwK1HxCEcybthgFiKQMpKV5t4goMpa5e92Z4EaMFC0aBxlM/flwd2Z9iDuqMdjVI3l4tx+JDOJ4R6NGrg2B0RSD9Dn5bfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ICGfevQB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ICGfevQB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F38F1F000E9;
	Tue, 16 Jun 2026 13:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781616121;
	bh=6iG/EZwHxHHh0z5qkMGs9418TozMjPRUI7JpdzRblKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ICGfevQBzKSD6N/KOnlRzRCCg7n0ogl8WzSdy9L+XqrU5djvjM/jYL44K9tl2DdL+
	 mx8ioDik6occBaii5exWSqF464VVxyulDO0P4rML5oYp8x133+ClmNIUq4FKoqPjas
	 ZsaooKRwkcZ91Ww1eb7AfuxbJ1hNIso7oWcT9chk=
Date: Tue, 16 Jun 2026 18:50:56 +0530
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org, christian.koenig@amd.com,
	Honglei Huang <honghuan@amd.com>
Subject: Re: [PATCH] drm/amdgpu: drop retry loop in amdgpu_hmm_range_get_pages
Message-ID: <2026061646-ship-culpable-1e01@gregkh>
References: <20260616130531.738887-1-alexander.deucher@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616130531.738887-1-alexander.deucher@amd.com>

On Tue, Jun 16, 2026 at 09:05:31AM -0400, Alex Deucher wrote:
> From: Honglei Huang <honghuan@amd.com>
> 
> Since commit c08972f55594 ("drm/amdgpu: fix amdgpu_hmm_range_get_pages")
> moved mmu_interval_read_begin() out of the per-chunk loop, the
> captured notifier_seq is no longer refreshed across retries. As a
> result, the existing -EBUSY retry path can never make progress:
> 
>   hmm_range_fault() returns -EBUSY only when
>   mmu_interval_check_retry(notifier, notifier_seq) reports that the
>   sequence is stale. Once the sequence has advanced, the stored seq
>   will never match again, so every subsequent call within the same
>   invocation returns -EBUSY immediately.
> 
> The "goto retry" therefore degenerates into a busy spin that simply
> burns CPU for the full HMM_RANGE_DEFAULT_TIMEOUT (~1s) window before
> finally bailing out with -EAGAIN. This is pure latency with no chance
> of recovery, and it actively hurts the KFD userptr stack: the caller
> ends up blocked for a second while holding mmap_lock, only to return
> -EAGAIN to the restore worker (or to userspace) which would have
> re-driven the operation immediately anyway.
> 
> Drop the retry/timeout entirely and let -EBUSY propagate straight to
> out_free_pfns, where it is already translated to -EAGAIN. Recovery is
> handled at a higher level: the KFD restore_userptr_worker reschedules
> itself, and the userptr ioctl path returns -EAGAIN to userspace.
> 
> No functional regression: the previous behaviour on -EBUSY was already
> to fail with -EAGAIN after a 1s stall; we just skip the stall.
> 
> Fixes: c08972f55594 ("drm/amdgpu: fix amdgpu_hmm_range_get_pages")

This commit is not anywhere...

