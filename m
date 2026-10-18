Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4177419303
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 04:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792297898; cv=none; b=VDBkSojjCQLb+WZvy2HNib2E0uC8wtcnLmci7YJem2OrwzRiw13fhQsFz5pqKbbJHLR3/9e2C7hEo1oEykkzyfjnyB/ZAUlVVxI8HsIFfaIkqRCdRZnrkajJ9vEki3ckfVi5ByTHRGnvoTE8hZsccD6HWclX/JhZWnzLeHW+rk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792297898; c=relaxed/simple;
	bh=GfG8xreSC2gYnlnLaGNihyW3nGiw1/JdLmQCZBJjHoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r259CM1xvxEBGXrSQ7yu5VnkVacX5oaefH1U4T9W4jMDD8Dnpyli6reaAnOeZBBffsR0OspnLcef69Ug92LWqYr6dBHr3FUTNH2nAe4p7PDqXaXu0Ymf9Vz0vAkW0ZnTXpi5VpB3PRTDLMFYuQ0tOBxKfTw46EzNClkW4NVjTuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mb9BXWxt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mb9BXWxt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 750251F000C6;
	Sun, 18 Oct 2026 04:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792297892;
	bh=DYBq7xeKvEEfhwWtcg1/NmSK9WIDoGWbifeYKQ6iaPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mb9BXWxt88MpB9qYnzbH95e1QrRQzxEiEgi7/2F/8hxj4Nvv6oj2/BHBk3Qm4gqWL
	 GWeQP4oq2b0cRa2vq/YWt+VON52QmcgZEKdFhblV4sG21cPhx+3wEiJL7g1rSNBGWZ
	 DOZEbwSUVAdSZaOr+LHmaj0c+P27fOkNdwnZBKUVKBPukBo5ykBFnYtk4P3++breFR
	 YZGcdhdHz4Cl+8ot9hRaARiYvlfxC5HqpAX3YTCviIkNyGZ8iborIKNboR1PAQKiyL
	 zuVTGaL39gigLDweKWhWXmrbSyUlNv6nhWP+3qMkdZIIEuciRIZYaqsahz6mAOn8+W
	 LWEfQ2qVRcwDw==
Date: Sun, 18 Oct 2026 07:31:25 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Federico Parola <fparola@amazon.de>
Cc: stable@vger.kernel.org, Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	nh-open-source@amazon.com
Subject: Re: [PATCH 6.18.y 2/2] kho: free phys_bits bitmaps using free_page()
 in __kho_abort()
Message-ID: <atRLncxeTcA2dRD6@kernel.org>
References: <20261015144529.76911-1-fparola@amazon.de>
 <20261015144529.76911-3-fparola@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015144529.76911-3-fparola@amazon.de>

On Thu, Oct 15, 2026 at 02:45:29PM +0000, Federico Parola wrote:
> Commit fa759cd75bce ("kho: allocate metadata directly from the buddy
> allocator") switched the allocation of preserved memory bitmaps to
> get_zeroed_page(), but __kho_abort() still releases them with kfree().
> kfree() on a buddy page that is not a large kmalloc allocation hits the
> WARN_ON_ONCE() in free_large_kmalloc() and returns without freeing it,
> so every aborted finalization leaks all bitmap pages.
> 
> Free the bitmaps with free_page() instead.
> 
> This is a stable-only patch. Upstream fixed it as a side effect of
> commit 99cd2ffac697 ("kho: don't unpreserve memory during abort"), which
> removes the tracking teardown from __kho_abort() altogether. That change
> builds on commit 36f8f7ef7fd2 ("kho: add interfaces to unpreserve
> folios, page ranges, and vmalloc") and commit 70f9133096c8 ("kho: drop
> notifiers"). In 6.18.y, KHO users still preserve memory from the
> KEXEC_KHO_FINALIZE notifier and have no interface to unpreserve it, so
> the teardown on abort is the only way their preservations get dropped.
> Backporting that commit would make preservations outlive every abort,
> so keep the teardown and fix only the mismatched free.
> 
> Fixes: fa759cd75bce ("kho: allocate metadata directly from the buddy allocator")
> Signed-off-by: Federico Parola <fparola@amazon.de>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  kernel/kexec_handover.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> index 9fe5d14f1ec54..9691f6bc2fba7 100644
> --- a/kernel/kexec_handover.c
> +++ b/kernel/kexec_handover.c
> @@ -1054,7 +1054,7 @@ static int __kho_abort(void)
>  		unsigned long phys;
>  
>  		xa_for_each(&physxa->phys_bits, phys, bits)
> -			kfree(bits);
> +			free_page((unsigned long)bits);
>  
>  		xa_destroy(&physxa->phys_bits);
>  		kfree(physxa);
> -- 
> 2.47.3
> 

-- 
Sincerely yours,
Mike.
