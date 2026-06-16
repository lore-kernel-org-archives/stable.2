Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD9231E849
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 13:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781616106; cv=none; b=Fkxf79yFBcrecnoDUUhZ4iyP+IStcy5iMiWiA4e7GlXy9R/YQ0n6IEdkOGneW08EmghIH+6yRXz+JkzBf/GKilW3XD5fU055TASUQGVDtugs1HM6WwaThmt2LTEKQrkvZ27DYcngm6ydRIYpTwEGOzZfu1452vrb2w/00/vExUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781616106; c=relaxed/simple;
	bh=/25lRFHJzXfz3Qg6xc2fRPNyUcAKhd8AuFKeOt/8tlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkuP93n0Fr+QolWNjmqC+yVrmhTlqEtIwUDpCnfaxpPkHI+gtrpESCpUkyvkOXODxQqoq8DVA7JLi6OW3mtYd1RNSFvKVAZ2YEnW67l6NZ/lpIzng7l2kvWosIbEAPqSqsaHiJLCVx6N1aQmZIMeyTdOOhYKbOwRumXPCFoko3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S46Mlqy+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S46Mlqy+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477D11F000E9;
	Tue, 16 Jun 2026 13:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781616105;
	bh=ovWYIq7A0I2+8y/bfQSkOWkuLp/PlidpEzuNYYIxknU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S46Mlqy+kRbxXadJ59iCFS1/8Ew29VFwM9TPX/k4R6F6rq7dTh7CsHFoXnm+y0Ic+
	 kBJ7vWFG8sOQIvqXVIo653mA8f7tSBa/yU0CZoXE8JcpRdz3AxJTRvAKd22YAiCkyA
	 nepUl3JOWvlLik56aWxA4m8Okq0p7ShGRkUOA2EI=
Date: Tue, 16 Jun 2026 18:50:40 +0530
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org, christian.koenig@amd.com,
	Honglei Huang <honghuan@amd.com>
Subject: Re: [PATCH] drm/amdgpu: drop retry loop in amdgpu_hmm_range_get_pages
Message-ID: <2026061615-driller-golf-4f34@gregkh>
References: <20260616130531.738887-1-alexander.deucher@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5393
> Reviewed-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> (cherry picked from commit 342981fff32802a819d6fc7cf3c9fedf9f3d9d60)
> Cc: stable@vger.kernel.org
> ---
> 
> This patch is from drm-next and fixes a regression in a patch that
> went to stable.

But this commit isn't in Linus's tree yet so we can't take it, right?

confused,

greg k-h
