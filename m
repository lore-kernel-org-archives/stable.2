Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F9238A706
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 03:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791604754; cv=none; b=AzbDlR0pGx9MIQw9WVf3WZ/7CDuvfjGILXmvkSRsmXk8n8dmZAzwDkFSb2RqDkGZbTK7jJdhOZi0T0EANFUlfrCwgMkIomlG6Jae0PjiwzhF2LIe90gft0HXap2PgHARDHRm2MBq0RPOQhb5xV5YDFCC+Opm1SXiVi5+k5ZfBQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791604754; c=relaxed/simple;
	bh=RC9mnkldnLHKLxUGs9e09WBh6qSGgQVe/M8DUOliYNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdLRA/44QJrdF4hoaPf6NrNZIJelGH1z0cEIOuvueMQSfTZZqcYTcnZ3tOM+nr9ZipUp+7wq0pzCq+16P8t6zO72HvYjvzDkG0kkiDq+GVpowE9RPoOFKX2znlmfkUgdQWvztnAhNnnExflRDpzaq97HX+yLD6DcjLe+qrMuwZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8ubehbt; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8ubehbt"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc4dbda1e5dso73860a12.2
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 20:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791604752; x=1792209552; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C2sBX9RzAUijwlycitpdPIp/C+J3gojjvyNQwGnJMzc=;
        b=I8ubehbtWKh9LMUQGfy7wiPDnvWb+mY85UfhWRJ5tSE5kpXHOi4u3mEXXLWsYbaamZ
         C7HWoFGGTiGRftOPKi+L3+ZOXZiBVbdn/kyJfoiCjHvgPm5A3BlNCtBON6mmAdd+h18v
         4u12keIUgnEloWWjANDKy8RSs5IBegTtHK7gulyNgrxKw7E6hA+wHPWsZuw3OyITn+3X
         df1FYx7rVQEb38jLj55O+FYjXdRcZVrlFcES6mlOKnzvbqCgnCVlkBQS4Y1/39qrlwsD
         2aCtL2ylUcuvWiHgEe8LM1Jywr3c3OIRE+3KdSDVbnv8vg4XDK9BohcUZ8jtAXVmqgU5
         maxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791604752; x=1792209552;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C2sBX9RzAUijwlycitpdPIp/C+J3gojjvyNQwGnJMzc=;
        b=Rt/Mv7wCw07NenxvT0Zau6HwXP/TDnJUjYIs+HHpn0lghD0X2aO9j8axO4yW4BFK/B
         DP+0jnad3IOT3em0/enoR5znDJyITjhpU3z2p1qBKGlbeYWrrCD7lgjHpHZzNSWcL4SE
         DXkkJgu+OlKz9/h9Rs4KvEOTEuaRUp6Vk4Aj/5PV+Opnlltm21bw2YJNglywxp26owDl
         siozhSYLqQrEVVF82Dor0mEMEkILYHiQG+Cc+uPsTo2ozGBC+Kx0mDC2BUq0BSPNUAuB
         pKehJM4HLlTOODfaZti1NM1O5OXNYe09w53qtiepdDo8CQ2Jp8JtlYDi1954FitKJc5D
         OdOg==
X-Forwarded-Encrypted: i=1; AKwUvBygrLzJptILXD4b8aVlo8i98XQedpZQrha7OxVvSzvvdk6t/78+ZceLSd6n8ofVZWq/Eh4bdJU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLWy+9qPmJG+s8LsOCIew9+Bd68Lfi1QDVU6kYBwc+d2c6hkAs+
	qPXjaOWPvknkoicKY67YuzxuWf9byT0Xngl1MuklMnkwWV468Z0u/05m
X-Gm-Gg: AYBFou0K8jIqhsOBjZD4OQSJ5YPdZ53PUDjLV82Hs6ENm2LBKhvQGWEI3ia2MSsHud+
	zKmMaU0n8jKBL8bYut9r+eLWOR0Sy3l4P2/8l0qqSd74U6c5Jp9qr05N8loqvMJqX/DfoEe49j0
	KVQlrcciKSHU6+aoEcIP9OnDQNYOv63E1PJOC3wAip5BYr/FZbcSDCYSxxDCDeC+jkmBmaGV7lc
	UhYMirrHoHVh4yua5xy9c66qP+6yzogLwKZnRIkXsi6nF+DyWnBM6XGqOcoUydOOUrmvp25VbRd
	viZTCK9thMjtYN4TXELVFZbKuubLhucD5GA6vPHhVlBI/+2OKqu8zRiNl/cksyzgHEH9Aywn0sA
	Dp2KudkwuCTHo8nEQNC26lKpNf0q4S/XjOjMG6dGywVzQSmsvitqGE5ENT07clGVNTV8N0Fzi65
	iAsHw7qXAKCkoMXPxLb2xRMtIu9zNrfDY37yx3KCLTfNUZKyk1Ing8Dmc+5wqaue/wvhaDcAL0V
	l7oLyc39fW4mJvprR2Xsc6kFlLJh9/xMA==
X-Received: by 2002:a17:90b:134c:b0:3a0:cbe2:9e0c with SMTP id 98e67ed59e1d1-3ab3b0285d5mr2844887a91.63.1791604752082;
        Fri, 09 Oct 2026 20:59:12 -0700 (PDT)
Received: from localhost (softbank126159121187.bbtec.net. [126.159.121.187])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab338676besm3793206a91.1.2026.10.09.20.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 20:59:11 -0700 (PDT)
Date: Sat, 10 Oct 2026 12:59:09 +0900
From: Zhenyu Wang <zhenyuw.linux@gmail.com>
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: Zhi Wang <zhi.wang.linux@gmail.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Xiaolin Zhang <xiaolin.zhang@intel.com>,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	zhiw@nvidia.com
Subject: Re: [PATCH v1] drm/i915/gvt: Don't replace a DMA mapping that is
 still in use
Message-ID: <asm4DV84UitLCbve@dell-wzy>
References: <20261004212403.208681-1-oss.patchbox@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004212403.208681-1-oss.patchbox@gmail.com>

On Sun, Oct 04, 2026 at 05:22:39PM -0400, Yuho Choi wrote:
> intel_gvt_dma_map_guest_page() unmaps and frees the cache entry of a
> gfn when it is requested with a different size, and maps the page again.
> The entry is still referenced: shadow GTT entries and dma-bufs keep
> using its DMA address after the page is unpinned and the DMA mapping is
> torn down.

I don't think this is *real*, as code would simply destroy entry in
that case, and there won't be on-the-fly dma operation on that, as
guest mem setup is totally before execlist submission, if guest driver
changed mapping by ignoring gvt emulated execlist status, that's just bad...

> When the new mapping gets the same DMA address, their later
> intel_gvt_dma_unmap_guest_page() calls also drop the references of the
> new entry.
> 
> Keep the existing entry instead. A 2M mapping covers a 4K request for
> its first page, so take a reference on it. If the entry is smaller than
> the request, fail and let the caller split the 2M entry into 4K pages,
> as it already does when a 2M mapping cannot be set up.
>

So this change would always force 2M to split into 4K? why?

> Fixes: 7366aeb77cd8 ("drm/i915/gvt: fix incorrect cache entry for guest page mapping")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
> ---
> Compile-tested only (x86_64 defconfig + DRM_I915_GVT_KVMGT, W=1, sparse).
> 
>  drivers/gpu/drm/i915/gvt/kvmgt.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
> index ec62db5cc3675..9a3e305253469 100644
> --- a/drivers/gpu/drm/i915/gvt/kvmgt.c
> +++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
> @@ -1626,19 +1626,15 @@ int intel_gvt_dma_map_guest_page(struct intel_vgpu *vgpu, unsigned long gfn,
>  		ret = __gvt_cache_add(vgpu, gfn, *dma_addr, size);
>  		if (ret)
>  			goto err_unmap;
> -	} else if (entry->size != size) {
> -		/* the same gfn with different size: unmap and re-map */
> -		gvt_dma_unmap_page(vgpu, gfn, entry->dma_addr, entry->size);
> -		__gvt_cache_remove_entry(vgpu, entry);
> -
> -		ret = gvt_dma_map_page(vgpu, gfn, dma_addr, size);
> -		if (ret)
> -			goto err_unlock;
> -
> -		ret = __gvt_cache_add(vgpu, gfn, *dma_addr, size);
> -		if (ret)
> -			goto err_unmap;
> +	} else if (entry->size < size) {
> +		/*
> +		 * The smaller mapping may still be in use, so don't replace
> +		 * it. Fail and let the caller map the range in smaller pages.
> +		 */
> +		ret = -EBUSY;
> +		goto err_unlock;
>  	} else {
> +		/* A mapping of the same or a larger size covers the request */
>  		kref_get(&entry->ref);
>  		*dma_addr = entry->dma_addr;
>  	}
> 
> base-commit: 7704c4c5bb127673b4f0ead839919db573559e38
> -- 
> 2.43.0
