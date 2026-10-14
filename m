Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1DF377A8F
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 19:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792005949; cv=pass; b=RHKylVvdqT9c0yPDtIN4BL+s3K6sVcwaE8zoyAcMuMXFSlh6WHgolOVphLC345FiuWJFgQonlD5KTyMrrRGgpqFqKWNb4flUQZ7s1vOcPSFrkCrzNUD/Z20+zuH+lHygAFid++gUbIMfbKNilm71lr5IcvEDDSfCQRtrpoYRGv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792005949; c=relaxed/simple;
	bh=582l4UN9d8ZpIIQBKyvfoe2ud1OuHObN9VtOBwz13Bg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n2z+7DYCXKmvgLeSUnhuOEOiqx8Y+xKt5yR6cEJgAzuPOIQ+dkOVx6e4Qf5+tIBkgB6HqqDqzAR/60+jsIn9vXV+N5SM9e1Y0SheEdJqb6/uBIYITu4EB+rbg9u1mJbKovG14LqE0Fn4EWOIw2af/TIlXozzWy/GcIimWSlVUQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lf/veVDZ; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lf/veVDZ"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3a777d4f321so38869791fa.0
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 12:25:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792005946; cv=none;
        d=google.com; s=arc-20260327;
        b=eMOhCPup+NY4VU+KmGpciOjimmNXIv4O9UX6Q5vpAlZFAQ/hTvtULhIaUJ/DsDu+jH
         ircXeZWkgpVK7gqF6VqUMf+dvZOU+YYLd/mNZYXR30C+wE48hJ2uhtGiSsJgtN7unLVH
         JTE0Thla1A4PzViwRrF2nlmnFZ1fnD+OWO2ljL36AUySmAOoJmHs3enfUVZVxzxz/vb2
         qw7j+DcTjcsm0KW5AbiQeuTaMGQ1HGlAza4Wai1xeh0w8VBRZueMaRsiYVSAZ5z+HJ/m
         b7Jo1Lvb7fAt6FnyydWfQg3vCN7Kqf/SSLkArDYq1nvvdPzATStbXapmmDAtf84UJceB
         pNbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=582l4UN9d8ZpIIQBKyvfoe2ud1OuHObN9VtOBwz13Bg=;
        fh=8oZah03E2NXVjC8XDtyYDtAgIHDvZr+d49OdI6te3o8=;
        b=fP2yxlpP7lsQUc70cS5kaPdgAnfk/DaxcICuu/bi9OsvE+AGU1xG5AxdIdgZZHmVMg
         SZhexLsif2vCwaAipc3D/3eMwckiOI7ID6yxtG4oZCHcK0CvGwyZM3a+Of0TNvTQW9Yk
         oocf16NWAdU4HVCPREGP5mD6kpcDLcJ+AZ7CWghh0SDtRDV3lTx7OZVf+MR3tFHxrM6Z
         WKemnD0wKHhd+tq6+SmoPBiQji83YEnTWF/iJXagRQyMlUXs74cxDpojmrh68nVRqjHx
         +lm5lfO4GdAjJb8G3Qtz49e8rFVS1EZOZMcuP/IxvmYCi/tlVd65udxAO23A6g+Rv/Bk
         1n8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792005945; x=1792610745; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=582l4UN9d8ZpIIQBKyvfoe2ud1OuHObN9VtOBwz13Bg=;
        b=Lf/veVDZ41zt9JtV37fHQydGMiRhfhYhcI+4p8Rigg1OHh+2WV5OVGC8zMKAJE4exE
         veWcjZwjS24jxWX+M/WWdCjinLxnvs8IMmasa8t0DLaEhjfo7QvP3D735kuPhA+AZ6D5
         suHVZjTUiM3QKhmSjdjP702nqkVLYPXB0OtsoQ9FFNmqjCYlfwuIRwhuUmMZ6U4b/645
         etQGQfscMkcV2x4V7Oow3fO0a40kuCLa5AZyTrHUVPjYht8j8iNrBYvy1rGaZ+ymQkSH
         TH7dne5GfJUOY7BBKN2bqJ0dyvQsFL4uXI9IQdC2d/Lhs7AQUyGCCM2O1mAFaC+zSer3
         Z2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792005945; x=1792610745;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=582l4UN9d8ZpIIQBKyvfoe2ud1OuHObN9VtOBwz13Bg=;
        b=fvsZndQkC6EtBX6fMJz+pYJcxo7cxDKXko10uHDQdQ7/LvFPgT486qdfloe7F9JZof
         wG0q5xBfphCvFChNkV8X/OdYfTtAWjcdzg+xT8GPW9gKIeNaGpKNNjoJAkGXz67fim1x
         IHbrtGkGQhAx5gEy3pXFKoRZnFbPwkotPjQSS8qFaKNDrCb8D3zfyq+bAdPYPaqJy4RB
         Ai8xBXKBOA/lhG3QT9iSW9im3+/klVXGBGLF+ZUc6IpQGLYtdYUz4sp4BCblAB0ScNDz
         fsC7lDUGXYGP0YuGJn4Sc817ZZvIOMXcak9Y8nLzH/XahbOdxoarOv1/DxOJjlAUqAxS
         7A4Q==
X-Forwarded-Encrypted: i=1; AKwUvByvUXnTVvyl36m7d81snCAzIOSqVqxxuVh+DPNCj74n2c4FxtBg4JCyf3bea+qUjf99DNcMG84=@vger.kernel.org
X-Gm-Message-State: AFq9FYJydUm4p38lPpeZMIGeQ19koHq3cO6kXHvE9WGV6/W9XzHL5M8H
	gwV2X4BCTcsaOUnksQT4BnM5khRrK1ciyR1F4O2a7SA/6YPXlHPBVCvNlpMZgv8GfsPfPszWtYS
	iLFaGRctJ8q1Iie+A15dgiG+/1dL/hHN8Iz/z
X-Gm-Gg: AYBFou2eMQB3CgMOLkCfgPOo2dTfKuBaJMPAUUjTzG+pk5nwXQfExN+9f4OwUVNi6o7
	lN3+2J/bSJimeSKbB3LiUB+KW9KfLcrAws3VDIjYbQyoBO0ComFg+RxYoEEaXBtpRvKwJKEcYUi
	U3v6590BU7pdXE/0+e6ksW79zFUCRC6QR5xGY4uSIOJReoKHr3/4iLpujx5HHj+UwAp9/Brbqo8
	NXkn6z/zMP7DHyQcuyTNlBmcL5wz+UsS1XFgDvFQcg1LN97bacQLGYUS9SOjC85nDMdhSLHls8u
	rRb4bd4QdJVG51lNqOk9vA4fLvGzNJ5RIVUYBWUZ9+hEDVwE1acmWdt9
X-Received: by 2002:a05:651c:b28:b0:3a9:9b0b:e0e9 with SMTP id
 38308e7fff4ca-3a9c539ad00mr43922551fa.6.1792005945250; Wed, 14 Oct 2026
 12:25:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261004212403.208681-1-oss.patchbox@gmail.com>
 <asm4DV84UitLCbve@dell-wzy> <CAGG=RgApzG=MeZ9xbpeBzqE0i0Q6RCPXtnyS-30JfEDPDKNN0Q@mail.gmail.com>
 <as4fKufR2O21NWk5@dell-wzy>
In-Reply-To: <as4fKufR2O21NWk5@dell-wzy>
From: Yuho Choi <oss.patchbox@gmail.com>
Date: Wed, 14 Oct 2026 15:25:33 -0400
X-Gm-Features: AclHuK8bWEAIT_jes9eLRLNmTdyx38C_iJwbW3y3L5STgV7Y6fOZaRlXyp6RKPU
Message-ID: <CAGG=RgDVsPHjLMTEgoqjh17hfnBUg3WUeca93VrDS7NTshHsOg@mail.gmail.com>
Subject: Re: [PATCH v1] drm/i915/gvt: Don't replace a DMA mapping that is
 still in use
To: Zhenyu Wang <zhenyuw.linux@gmail.com>
Cc: Zhi Wang <zhi.wang.linux@gmail.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Xiaolin Zhang <xiaolin.zhang@intel.com>, 
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, zhiw@nvidia.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Oct 2026 at 08:08, Zhenyu Wang <zhenyuw.linux@gmail.com> wrote:
>
> > You know this code much better than I do, and I can't test it without
> > GVT-g hardware, so I may well be missing something.
>
> I can understand that but I think for any non-trivial change or
> for sensitive part, testing is a must...

Understood. I'll hold this patch until I can test it on GVT-g hardware.

> > The case I had in mind is the guest mapping the same page at both sizes
> > and keeping both, e.g. 2M in the PPGTT of one context and 4K in the GGTT
> > or in another context's PPGTT. If the second request replaces the entry,
> > the first shadow entry seems to keep the old DMA address, as
> > shadow_ppgtt_mm() reuses a PPGTT that is already shadowed. Is that ruled
> > out somewhere? Please let me know if so.
>
> Shadow ppgtt is created by a PV interface, so each context would have
> separate shadow ppgtt or shadow mm. GVT handles guest page's dma
> mapping per-vgpu as for per-VM. But GVT handles context submission in
> order, shadow ppgtt is populated for each submission. I think even in
> your example that possible one page mapped in different context as 4K
> or 2M, it would be remapped as size doesn't match for each submission,
> so no invalide dma address access.
>
> I doubt if i915 could possibly have such case in reality..

It does seem to happen: 7366aeb77cd8 was written after the same gfn was
requested at both 4K and 2M during an OpenCL conformance test.
