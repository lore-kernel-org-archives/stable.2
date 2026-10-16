Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5315B2D738F
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 03:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792119745; cv=none; b=sxLdduHk8+4Bi7WPqSEPpQLPDRe5O3w+Sy2+byDyxwKaK84dvBpNTbnDOg2Rs84JpxZiINk58J7rlm4mftb420YZYjwS5L9q8LKc1xbwdPaHTwO+WVfUw1oUcvKxp3EinEY6MKQIMzIawKJz3jsSbYY4rVG9DWyodiQldakL6cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792119745; c=relaxed/simple;
	bh=k34bmAM328BmjAmGoXRDZojOtLNo+D8QFUlnQYlS+/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwYGi5mud8BN6EtlDkAWQdi+Uj/djpkp7Juzwt+v8FvSxkUFqge+XPUjt1uK/yCdNEQeCqbgJexz3A8hPNA/dFPU1t8+kQH80BnCmBJ4ePWUQRISXiDl+FTFb4Ri8hcdgrG8T71Ks5tuzLD8oc4bRvSK+vx/z6gHyOm/GZoOQp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rdq+YOEW; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rdq+YOEW"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc147d86bebso389117a12.0
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 20:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792119744; x=1792724544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WGUCMs28DpPSn+ppcL59RwrFtWtuthKTRyw8zNLj4Wg=;
        b=Rdq+YOEWURF66dDC/ycVbZBUHmqBHxYDWORvSWNpS9cbFSk61KtRdz0TKawgKPJvwd
         dJ0/CZ8YyUT2oDzb4PB0VKkJt0RYcDtkUv1L1pcVoPHgzfytHPOaTSe8tP8dHaheKcHR
         i/OBn8WpIh1msKCyyekf4bbIENNLyNJfjcQtxoeHrWEh2R4B334JJ15+3ccS2fH3l+6N
         YCW4taAgyrsmxoE8kB6FOttSqHIdxCenoh35RmwSCsUkdP4rpCFqFlq6bxICW6jR1gws
         NBR/yDU+8L1ZNyILGYSXAGUe2FXyX0U0QGdrmS1ySfv6VtM4UE6TEopgJP7ZykiYe4tk
         C0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792119744; x=1792724544;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WGUCMs28DpPSn+ppcL59RwrFtWtuthKTRyw8zNLj4Wg=;
        b=I3Ar/SAPXxJuqZ/KDaCk7v1Y6GJuzanNnRMWcYTiwGmCsLyHANmijAuQ1K0zsBtvtb
         CDQrE9iCKNvwoZeBKdZYAYZN9dH9rf+y7KpmSJLJSmGB4G/RaROduQmAj58LIf8rAyZx
         0tmCU2Ok5egQ6Upkwnj8pmB3gWXm6E0WRjdtFoHY+Xbb7acb7GpTBDw9ZEc0vbTopWJt
         IYdmpQAaF6qU75Kd7QyoJFh4MscfMLcUdmQr7IRSsgiH3J1wo28sUs8hT29fFWGM59Mj
         rIGcY0s98z1zdZMz8P9JtbEKiwntP05eUDQt70U4ElIPS4RCA0l6W41u7WNgVygth8KF
         l90A==
X-Forwarded-Encrypted: i=1; AKwUvBx+LLBszLJYfMNx1npsv9OA0KcbLpKa9YPufsrdpsubT7GHSS/qDf+l8n6mBPreBoMPLYmNfyc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKaVxOjqfqy7ZgIbqlIJOGzm2K3tT/kWWp27lt/dZTXXWmxZZ0s
	es6X//UTHZXIvAz4dPF62Uc6GWrbY0TIxzInC0TXOk5OpeT29LDQXttk
X-Gm-Gg: AYBFou3cAqngZJIDp7LvmSSKCKgkXQxJB9OBm0MgdH18IR3yyhHS+QV4EeHg+xDMAXk
	66tBOPSbnqXoyG8vOjs0VPXQBO4ZzTrNk6xUqR9WhE1KvVI7qk2XWXQaoEzsyElUC7NnUgwQ5fp
	z10wSZgVPHQs+brEg5jzE78fjLJqKh8CIdMdb0/pidoY6ttpnP3iLjtReJspBBoBV2sVkT58IlY
	uIgLPoZsE9DT7iRKEKBMXPImh2AsYDuzlnm+9n2iC/vb8j2k1kQtxTzU+ueFHi2qseSfsJEsBhG
	IVCF8me6GtcawTQkjVDe+4g1IzU8yVOby5VouRZSqXZyg/3DPje9ezm1nDruuZBT2g0+0AG8ReV
	sSWA3tD2XpZMDjbINMWBL8cSrOGx5GnNwoVpWYWuSf5M+M2Rrqjpjdbi9ukMHECC8lHPF0uzWC+
	72WPpMh+BnVJZYe5iJX8ZidfbKyZMV2ffIB30H1S5NFeYLLxYZcZIKoeyr7DeCmhHcD+DamH6g1
	7jYpwDn27E6hSg+rgHxdUsGFmzASAQ9iPA3QFFX+rQ3
X-Received: by 2002:a17:90b:4e8f:b0:3ac:9ad9:6afe with SMTP id 98e67ed59e1d1-3acbb8d5b8amr1095002a91.39.1792119743425;
        Thu, 15 Oct 2026 20:02:23 -0700 (PDT)
Received: from localhost (softbank126159121187.bbtec.net. [126.159.121.187])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc43a1e1esm1937126a91.1.2026.10.15.20.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 20:02:22 -0700 (PDT)
Date: Fri, 16 Oct 2026 12:02:20 +0900
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
Message-ID: <atGTvA2zocXGWmbp@dell-wzy>
References: <20261004212403.208681-1-oss.patchbox@gmail.com>
 <asm4DV84UitLCbve@dell-wzy>
 <CAGG=RgApzG=MeZ9xbpeBzqE0i0Q6RCPXtnyS-30JfEDPDKNN0Q@mail.gmail.com>
 <as4fKufR2O21NWk5@dell-wzy>
 <CAGG=RgDVsPHjLMTEgoqjh17hfnBUg3WUeca93VrDS7NTshHsOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGG=RgDVsPHjLMTEgoqjh17hfnBUg3WUeca93VrDS7NTshHsOg@mail.gmail.com>

On Wed, Oct 14, 2026 at 03:25:33PM -0400, Yuho Choi wrote:
> On Tue, 13 Oct 2026 at 08:08, Zhenyu Wang <zhenyuw.linux@gmail.com> wrote:
> >
> > > You know this code much better than I do, and I can't test it without
> > > GVT-g hardware, so I may well be missing something.
> >
> > I can understand that but I think for any non-trivial change or
> > for sensitive part, testing is a must...
> 
> Understood. I'll hold this patch until I can test it on GVT-g hardware.
> 
> > > The case I had in mind is the guest mapping the same page at both sizes
> > > and keeping both, e.g. 2M in the PPGTT of one context and 4K in the GGTT
> > > or in another context's PPGTT. If the second request replaces the entry,
> > > the first shadow entry seems to keep the old DMA address, as
> > > shadow_ppgtt_mm() reuses a PPGTT that is already shadowed. Is that ruled
> > > out somewhere? Please let me know if so.
> >
> > Shadow ppgtt is created by a PV interface, so each context would have
> > separate shadow ppgtt or shadow mm. GVT handles guest page's dma
> > mapping per-vgpu as for per-VM. But GVT handles context submission in
> > order, shadow ppgtt is populated for each submission. I think even in
> > your example that possible one page mapped in different context as 4K
> > or 2M, it would be remapped as size doesn't match for each submission,
> > so no invalide dma address access.
> >
> > I doubt if i915 could possibly have such case in reality..
> 
> It does seem to happen: 7366aeb77cd8 was written after the same gfn was
> requested at both 4K and 2M during an OpenCL conformance test.

ok..so that was actually a fix to remap guest page when populate
shadow ppgtt, it's a little hacky but as for gvt procedure, it works.
Your change might also work but have a penalty to an extra 2M split
with extra dma mapping effort..
