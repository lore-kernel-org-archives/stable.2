Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED1038F938
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 08:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787731394; cv=pass; b=AC+L4ovLnvCe6tTo457Gl8CPwWVjTpFN22pDIzjxNbEmwVel8EBg9RKUzxrGKODJYp/3fJeaRmjyCQMR/biZ1kf3uLWRHx5YogQLx5zmei3YP/PEr0FtCJ+n2Vfa0WseZtFeHMyMxewzRrjlsAEd8CpLY1/xi9Rw4n17G8Zunuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787731394; c=relaxed/simple;
	bh=Uf2R5y6Fxk2ATvMgWSnfDriG/hCrxIHMSdfuHilVYAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XG9qHlv5kJHBPhGwtavpaL4fCUP7u7936EQJOob+1Zk5MIgZ3yy2GsI0NaSARU0djQelimxeYc/aplI8+Ycic5YzQRCsGxbpMqKbN1eZiFVXYlfVrp+dT3PlH1HC9wSGTWhplrWZgo86/1FbWBN5r9WXZOsKA5naXDO4VPQ3Y5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6JEdEOi; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6JEdEOi"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-66d1663c00dso552356d50.2
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 01:03:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787731392; cv=none;
        d=google.com; s=arc-20260327;
        b=PLUFLN8ZD2l8Okpp1LIJIm+gere4TRnHcWcy5KJrPC20Kqt6ZBmPuXN+b/slhhz2A/
         x+vPSzxyShQXfF+gDJ0xXjeczY9PNjzxTKGdV1c7KtVU1bNe1Xrrqs4By0o7bN6mYhco
         np38lNYSuPfmaAwHECPJ8ZgZ1TYEVv8II+qjlQ856HrxHnQMkDrNi+fTeiyAiIpPzSKK
         qs89kIbbeEPcmbz0Zd4+viFqrl1fgN05D/pEiKwdVUmtu55WBG5MYMt+4uSpxOBxyNqG
         kvqOQMG63smY2gzMwTZ5s/8wcGmA4Fi66PcGwB9RtXFUWnVa8Il+Du7yn/YSaeQqzth6
         16Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Uf2R5y6Fxk2ATvMgWSnfDriG/hCrxIHMSdfuHilVYAc=;
        fh=G0+k1plx6M4RyR/lcJ+aBVns/FbPZUVSKVr/NyEWWFU=;
        b=VTou+NGxjpF+q0sxdT+d7tGodhqTeuLRkF1iMC5tVWNL8+VLBzvBmTdiF7OP1bD4J1
         u8rXzNvfbL5DPC13sNwBkyYIz1OKyLW+Ps8t9byduh8uY6r9YEs0p5qDwL3G+L7EP+43
         FNU5DQQs4brkf2t1oRex0u/q8WbL46RJ1Sb1rSEvLd5XQ3uf85kbdn+YU3XlIjdHPR6f
         WMrGfPtWDJ9Rj+NWQ3yruyD/kbwqVbD7xqisBVBF2jFZ5akdlKctouUbe7ckdE66liHY
         Q0D9VSwAc1DaGNzpQ/M/sSYTJtsUeCoXLxB3HRCYlo/HK7bEYP+RpfgukhnVmbzd5tIc
         ABow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787731392; x=1788336192; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uf2R5y6Fxk2ATvMgWSnfDriG/hCrxIHMSdfuHilVYAc=;
        b=P6JEdEOiaSnd7C0NRsMzWgFGjiVSzSa7/jwTr7shYLeCNF6Gai0i0AdriR8aAk6lJ/
         sheGb5K9/UMK322hD1VaBnhTBwTcJYD25CazJLil/5yE+zV3/SyF9RF2GUI4rrUGnTcc
         EwmJjIZb+fTly5Obnt9DVY+MvARMmSO38vcjGWGPJ4t3/bJ9V4aUuKf25iQ1bRtIcmOl
         qxSmQtJ8QW3DkVbSFsYH530EXdyWt+OZ52RGimveNInPZf7kRH2/hJJg1mudOYrf0ruP
         nDYFiCFOnhxEIH1HqNhL9++ck44XRzCJMdTOnZJTvONf5jQfTeKy9+NBW55zxq3LGYZz
         ICeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787731392; x=1788336192;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Uf2R5y6Fxk2ATvMgWSnfDriG/hCrxIHMSdfuHilVYAc=;
        b=FbDuZWsdwchYVVE2AkiXwIkT+y07S6UK5RCQlVk0wzJ/MIAd8T7yOQ4TJsFcZ2R6+S
         UUtIa0h2BUrXgPd0jMo94Wnj7cWgKHM2rDrNlE2NOX2be1+ug908xt62nkSjWi8HVRTo
         hDR6Ec4SlzAkxwgPKK+vrH5in8sHCZbHH8DJ/kIAAY+HJkyQKqDVo2+nslWd/UJrxt4c
         hYZZ6z4lmsX4OedQ6VikpfG3D2si1cNhWwvLN5TejRYIn6PXwGh/I1YvvMsSvuDcpvLE
         OMNGtpOHnnbkFGWKNFnBxw0v9soknO3fzQxncWcBkw4z9Idsy1msLB6dlz+dOmK6Pj7Y
         cchQ==
X-Forwarded-Encrypted: i=1; AHgh+RqIz+hkekqWLVHPfgCdqHykGQbxaLsz0DsKZeEzW4VY0UWqELShnmhV1YQUhlF6ORrL1MHnGGU=@vger.kernel.org
X-Gm-Message-State: AFuF++mUv2IjsK1MPB7iGH0JZOw+dwAGjCrEksUjCesfxcE2H9WFwOV5
	ybL1buZdne7bKRGkNAxJ75/7MYcfUVN+6eFGKNwQxaJOP/4RIgebpZ+/dZ0BWsiJ9xoKxMcpip+
	9d0Nvg+K2pwo8QTv4HwjvAoNu9LXUUtk=
X-Gm-Gg: AR+sD11RcK8ApaDzv5p65ic95KXdB3BXJY6xfnPdm6US9izeqWUyKRfgq1KO5v1vdVc
	3Dt/fMcM0OEERmdeQT2GMzbcLNSc/8bOvooxMFu1dvqnIJ4LOftWKwTQMz9zPWl/QHAzeJGH5sN
	lxNxcw6bbnwB7W6Jb0GgnkgCfrDsgfQGGZOgt18MssT1A55cVUQPBVvT7KvEJkJoHL2t0NqpKWz
	pPAF3vkqtgK6syrca6nzLPP7Bld+0+Sh+KqpS/gAmbclBVGBt+FKJ1KsCl5pcQ+Znx9WrRPP8mV
	3XIk3ts/39v+dam0qVh3tIlke0ctsTC/1zq/DUCt2OE7zzI=
X-Received: by 2002:a05:690e:708:b0:66d:fa2:63d0 with SMTP id
 956f58d0204a3-66d2580ca29mr1093286d50.50.1787731392131; Wed, 26 Aug 2026
 01:03:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808094114.2750088-1-lgs201920130244@gmail.com> <822e98eb-8e08-499d-a48e-bf39f985c524@kernel.org>
In-Reply-To: <822e98eb-8e08-499d-a48e-bf39f985c524@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 26 Aug 2026 16:02:59 +0800
X-Gm-Features: AcwNN1UyKWn6NmN_t45sTti2vw38ypw6BLs-mDluZkOKLJ35A28L82oBP9VRI-M
Message-ID: <CANUHTR-UfWT4gw2EZZrYOrOjdwzpcJVnUM1WbkZa=MyR2yDfaw@mail.gmail.com>
Subject: Re: [PATCH] crypto: stm32/hash: fix autosuspend cleanup during teardown
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Thorsten Blum <thorsten.blum@linux.dev>, "lionel.debieve@st.com" <lionel.debieve@st.com>, 
	linux-crypto@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Thu, 20 Aug 2026 at 22:03, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 08/08/2026 11:41, Guangshuo Li wrote:
> > stm32_hash_probe() calls pm_runtime_use_autosuspend(), but neither the
> > probe failure path nor stm32_hash_remove() calls the matching
> > pm_runtime_dont_use_autosuspend() before disabling runtime PM.
> >
> > If the autosuspend delay is set to a negative value while autosuspend
> > is enabled, the runtime PM core increments usage_count to prevent
> > runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> > during teardown, this reference is not dropped and usage_count remains
> > unbalanced.
> >
> > Add the missing pm_runtime_dont_use_autosuspend() calls to both the
> > probe failure and remove paths before disabling runtime PM.
> >
> > This issue was found by manual code inspection.
> >
> > Fixes: 8b4d566de6a5 ("crypto: stm32/hash - Add power management support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
>
> You sent vast amount of patches, all separate, making it very difficult
> to track and respond in efficient way. Do not do that.
>
> Group your work per subsystem.
>
> You were asked to clarify and respond to incorrect fixes statement. I do
> not see how you clarified and responded at all.
>
> Best regards,
> Krzysztof

Sorry about that. I should have replied to the earlier review comments
explicitly, and I also should not have sent so many separate patches.

I will group future patches by subsystem and make sure to respond
clearly to review feedback before resending.

Thanks for pointing this out.

Best regards,
Guangshuo
