Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845A74F55DD
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 12:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791893294; cv=none; b=GstmhbgmIHuxH8HOU4iJshzsKJ98FRDv10exKd9oDhVoTbMvu+AAlAhHrI+BVjC++uMl5VzLl05Dr6GxOcW3CpSWM4rru4M9WxpBJtHJ3d37r4zWMGoMQHfWn/e4d2ygUp4zPUXIgoo9awXUl4pVyjQ1hPYd+fnJp2HXE/rYcE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791893294; c=relaxed/simple;
	bh=KNmFxfRLMvsb2Cxyx+GeiN/lH7s+6FEosGllmHaqXfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkhjlBP16vOAOEXalkrJdrgbTw1GwF0A/KUrL+ZcydiMdYrwymV0UCkQjglrkwHICID9IYaI6qUumP8uE4F0mOcJdq8S3A0ATSUU2wlYkL6M0xm9svRPwXXKMMV1QGw24YDdSmMdmbfBureuoYjJ9MO+0CEwa7jOmYdtcaEUM/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gipwyBJn; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gipwyBJn"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-39647aa9d52so1748203a91.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 05:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791893293; x=1792498093; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SL2wq6QLb6u6b9Wwd0Sv7tNMSJxrgLs/vOJ5VBrZl6o=;
        b=gipwyBJnTA9eesuzkkLFp6daVZMk2wRnAc4PbvLBxtAVnOOZ24J2I8SqXkvzf/YYFW
         KKGjd7nJZ0MoVHWu5ThHqlwqBYOjkUJGjnb1ln5HQ/bZnp/+D/39xrkT1NF5a2AjBppV
         zuu46G+QSdtchJDi5i2GtSIem6LAy++El6P/rKjwHIVLcBapH8EmaFKmm7GMBQB6SucS
         5kcA5yDzfhud2G53bXbMq8uj1xVBw9PBwj+SIcxinwwbnuWOerBpjSlTiznhCJgn2lMb
         TGUHPhcMZFTjGV8zUU0z4Unkjhf2FFfuXn2MRxZLQMlJsZh85vF8ZasoHcVYrrRyKT2J
         mU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791893293; x=1792498093;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SL2wq6QLb6u6b9Wwd0Sv7tNMSJxrgLs/vOJ5VBrZl6o=;
        b=lMwR6ddeGNJi7f/2d3HKJrGdvjytmtNFpdPydSAeMqhj2Q8Z/Ra4l2m/gJ0I29C7EI
         YCTZucbrFzZ8EatlDVynFOSyorgd17+7oK+zspPxQiD5cdUNSxete85kDkooWmbREV3X
         3ubA51stcU6h1n30XbSI2QdD4SonUfjTZpUXxxiJGj496/HjFNHm9N6bIR7gPuJiOOlj
         vOby1/bBVybEHwvrS3qc3pxxnSIdqoBcnnJPnhwlMgvNKYSIsk9vI1MUi9HQfD0xIBfa
         LWBlghtoxnbBchPJUTUWZKah7PupHWvRWpk7+1NiZq1kSrf+dsED4DxTfT6yNA+mUW84
         9YZA==
X-Forwarded-Encrypted: i=1; AKwUvByD1xGWe5i8Xnr8O0iNRyw0cAANcmXee4G3znh4yuDCBfhwr9j9wq1Xg9FlA1MzRtKET8AFpck=@vger.kernel.org
X-Gm-Message-State: AFq9FYI31Iwt0Q9scV2Wcc21sblGYdFoWBMV9a6+xupI5thBVChwKBb1
	4wG29lrS5Q1bMRIJ37gEub4x7jOvHMgLnY1Ux0kPJsWToTgI8plmOIfQ
X-Gm-Gg: AYBFou29xOMx5j+yW2ZWuX6SG9H9BkJ4K5VgLgBQ+3wsUkn97qLj8G8vSs/C2be0Ll3
	D8jiravpqTvQvQw7MA2dd+14WTccsI9ysBdXHMR0u9AxUDIJ4a2YhPLeVMSLk157ibIhNSCLXUs
	sp/2+C0YvoQCobFwrS7XJCNlHjsiW+gIxaGC0Umii2pHJLeNK3jcOqqvW0uKGeVFvDkc5TZYyC+
	jA7JN0fIzN5GJSUCUUO1IXKGRZWix2kibOhsN6nbDo8R8WNRnNbO4XKZiS9918eYTvpA8YC/5Ni
	8mu91+Rt9ld/y5wV79/QB9hqBxum5HvCOXTbnSvq0B+RUJzkKGOJ00KseyOYfbq8dTvCZNOvRNu
	Lrg1bGEnLWy7RZygecZSqaKs3acgz8VqSA238ZS3fyfdBjAiCLkNQekVklxmNn71cpTvCo2/JcC
	h3v8LjgTFRvReGFimAHoaBX1PEF5PexgL2Gg/ll4ljGMEPeLCjwjN9lcE7MBgHEWdfuJKyVdWFT
	kQZ+cojOaeewPvR2qOWkmIBnEwL4y5iUg==
X-Received: by 2002:a17:90b:384b:b0:3a0:295e:6e61 with SMTP id 98e67ed59e1d1-3ab3a953717mr6170484a91.12.1791893292679;
        Tue, 13 Oct 2026 05:08:12 -0700 (PDT)
Received: from localhost (softbank126159121187.bbtec.net. [126.159.121.187])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab37817414sm21827776a91.2.2026.10.13.05.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 05:08:12 -0700 (PDT)
Date: Tue, 13 Oct 2026 21:08:10 +0900
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
Message-ID: <as4fKufR2O21NWk5@dell-wzy>
References: <20261004212403.208681-1-oss.patchbox@gmail.com>
 <asm4DV84UitLCbve@dell-wzy>
 <CAGG=RgApzG=MeZ9xbpeBzqE0i0Q6RCPXtnyS-30JfEDPDKNN0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGG=RgApzG=MeZ9xbpeBzqE0i0Q6RCPXtnyS-30JfEDPDKNN0Q@mail.gmail.com>

On Mon, Oct 12, 2026 at 12:01:31AM -0400, Yuho Choi wrote:
> Thanks for the review!
> 
> On Fri, 9 Oct 2026 at 23:59, Zhenyu Wang <zhenyuw.linux@gmail.com> wrote:
> >
> > I don't think this is *real*, as code would simply destroy entry in
> > that case, and there won't be on-the-fly dma operation on that, as
> > guest mem setup is totally before execlist submission, if guest driver
> > changed mapping by ignoring gvt emulated execlist status, that's just bad...
> 
> You know this code much better than I do, and I can't test it without
> GVT-g hardware, so I may well be missing something.

I can understand that but I think for any non-trivial change or
for sensitive part, testing is a must...

> 
> The case I had in mind is the guest mapping the same page at both sizes
> and keeping both, e.g. 2M in the PPGTT of one context and 4K in the GGTT
> or in another context's PPGTT. If the second request replaces the entry,
> the first shadow entry seems to keep the old DMA address, as
> shadow_ppgtt_mm() reuses a PPGTT that is already shadowed. Is that ruled
> out somewhere? Please let me know if so.

Shadow ppgtt is created by a PV interface, so each context would have
separate shadow ppgtt or shadow mm. GVT handles guest page's dma
mapping per-vgpu as for per-VM. But GVT handles context submission in
order, shadow ppgtt is populated for each submission. I think even in
your example that possible one page mapped in different context as 4K
or 2M, it would be remapped as size doesn't match for each submission,
so no invalide dma address access.

I doubt if i915 could possibly have such case in reality..

> 
> > So this change would always force 2M to split into 4K? why?
> 
> No, only when a 4K entry for the same gfn is cached at the time of the
> 2M request. With no entry or a 2M entry nothing changes, and a 4K
> request now reuses an existing 2M entry instead of replacing it.
