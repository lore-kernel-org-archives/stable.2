Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0675B4EDCC9
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 13:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792070824; cv=pass; b=OoVfRgIP7Qi57mKOMq19Ii3Y+uOu+jZ4zuUC9g4uKyPMaYjgFeuQUd+C5Po9xIMIikPeeNME8EoZEIjEHTevO3LkgE2EEC5+VHuEvPlUuKWPQQdw7HbnCLDMPEg5CgTqPFhLps9gtAncc/6yrRzDT+uzSkwH67b6YJ4pCrm4qW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792070824; c=relaxed/simple;
	bh=pjESKFxHFF8WYrcU7Fj9s8eSmOncsNMyBENz8mdE3qQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KPaDnPfcnK8rEnlTNJADB3T5va8wbvYn5knIpVX04K0lUI2G3ItIlH7EOKiBGYxWi+fOoIHV+AYmQluwubx0RslO4+huK+QcsYIeVP7dCjJg8hN4e/f0/DocCVp24L6vjdh3jk7TiDjhYXjz04PSuLw4XfGnCrV3sg5ju8Min8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K04ARffO; arc=pass smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K04ARffO"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-35159e0092aso610697eec.2
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 06:26:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792070818; cv=none;
        d=google.com; s=arc-20260327;
        b=jAEdYP0sTL38sMpsXjxb3xbDuj2H6GVtcOZSIX8aIKri6YGBJzMrO2puqWC/DcpsPh
         CkjI0N6Y541K5g1XKBMWvmhzrTBec234reJrmVaN0qGD4CS+fS8UL9L44LJhmOBsdvqw
         wm42DNqlP3x/NQW6GBp3Dpa4wYheCkuixlLg3bXb4485z/kD4QYeHLJ7ng4h1wQCvdUY
         CtKUV2mfxcRt1AymSCmWcFvVunmnRnfpOd7rpWuY7JQBFP0rTprK+CAW8DxdSCUBgSnQ
         7RmRmLxgMK+GDXSa/JkRWNbP8lo3QtiuI603n8dT1w0aO+bf1La5ZJfonHI49qRKoapn
         1E1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cATmI4j38U/J4hHVR3or+1yt/KGxYmxG3amR1w2998s=;
        fh=16YHjkMLeyiL+A81oHMINazrH/GrJeoXxeXKwAvtOuA=;
        b=bfTXeoGieIl+lDZovvUUzOdYs3S4EMcWFvl+arg2YMNLd+gUsPLcRxwUNEpFVkMjFv
         Dbovx4R1RritZR9TENvO6tVoBtYCcqDXQIz04BhYHSLhVX/MKJXjB7eK+ccSNAFgFze3
         3ZX1FOjBOFMJdPEGXwGJ0i5HDZq6TPTcDP4ypbFQHkO2dQfrBvbVHPS5llZT1tsoXllr
         GfQ1nuXwIwEwYO2KPd6oBbFxL5DUj9BIh2bxMklmeZA0uwkJHOuhLwLhju9XSHa+QNEz
         qqc0VJp1riF2BNRYBqJ0aJVAe4N9dVyp2RD6pKcaH/oxB6disi5q8V4TGhCAOk7a67e/
         q2zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792070818; x=1792675618; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cATmI4j38U/J4hHVR3or+1yt/KGxYmxG3amR1w2998s=;
        b=K04ARffO/nB0Cq4MIyaTsffeg/Oa6a1AKVUbnkQGaTHeMZwZBnrGMZkgozSuceka7y
         w/++Iciski+GpSkN/4wfRiL36uZSAeL/8qjSHDGWQx7/hDas585RQHttea21slqHRtET
         NmZAa58IIE73RdUOzptIjCNXuJpAA3VWyGNfKcOQpPPAHsiyJi8Cbbq9McQAs/M6wSRr
         lAywJmd8S8a4jOKr+7M3r/fo4Gncb8xBCvI+MBv8p9pfiRQHL6ytLBlf6sQQFftWJM2n
         T9ms6oNaFiEZHwrQJt7VVGcmPWO/QhSexq3nRQzOBHlWT5vdeF6XnXnQJX9CPGG4s3qC
         3pUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792070818; x=1792675618;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cATmI4j38U/J4hHVR3or+1yt/KGxYmxG3amR1w2998s=;
        b=I2wyTLg9L9FqgkapTCQhJSLFmmfyEF9aswmnyYLSe4Swp2I2UJnLrdGxly3ZZIeRxg
         PVxCYD8FgOnTzKWY11bxlle4jBO/5DGSYAuylphxaIHDnRP/+z50Psar6GYj3DhL5Hof
         +QFz1RZJdN7kmVNhMz361oLpra3IcsQp2w5/qomOI8KZ3/DU+hH6ZzVsHNQmFIEzcvj1
         Fg36WBKpIjCjIsa3yrV+3/ZAfUekeMXGyNVy54AB8R2V4LEbkcTQPA0k8rDkWQ9lPDmN
         F/duT1n8oAIpXAQsM41n+ai+m5YoPTd5yeAVHLPOZG9jOGpfDGPaIQqGCkykgiPBSL0T
         RNBA==
X-Forwarded-Encrypted: i=1; AKwUvByAVrI8WGe+0/QyYR+8Jj/Bogt8U9F8bvWrLZ2HlE4jn5nQR5myBoQ7cZXKEpkXaDX8qAjLUv8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIu2gebnt0wCnGmP5Sg83F2qoeeawra3NjJ76hbjQSj3wNddRwi
	lCM2IpEDqtJI8KZnKWSdp7cyeOLu/RyfL/FE7wEWPOk9B2tVBpFul1WMR3eDYFO9SUveXV2MKr2
	IglFNUhJFuoO3Ntww73xI4h14CGd1Dyc=
X-Gm-Gg: AYBFou0gKl3Ry5bAm6d+BXDQBxdVkMQT8fvYrhKTw1e7qAf4waEQ3sdV9BqFfwLx+9B
	2LQdbr3Jf1Mluj2rqcnw3NIUqJWl+F4sSpONuWeYlMKEZavs89iazjEX76KqQmTN15780OHTER9
	F78qLgorUlI5v1oYArXug4KKUX6Lx/e5pwv/Wd6uht1DnK482tlrN0IyQ0EcmwUkmh5Se+eZqEe
	o4ozZ4uowFCOahI3ljpJXUK0+TrCwEc/VF06mbT8tg1AofzH/9XSm3tyb+Vh+XyZo+WP2d1LZ1a
	X58fGEEx6jM5IIhXo6U0eBM7fUW2LEWC2iPhXdRHznBlTl5Uo1Co8CrMzaqbVZy55B+mU8CVhz7
	SP6JiGaHVFEvjHADLaHW2lOEcz+u236N7Hxd6VCE0+A==
X-Received: by 2002:a05:701b:4515:20b0:144:fd17:3b21 with SMTP id
 a92af1059eb24-16a4e2f6033mr37343435c88.0.1792070817732; Thu, 15 Oct 2026
 06:26:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <BN9PR12MB514681E5EDA768CB4497EACFF79D2@BN9PR12MB5146.namprd12.prod.outlook.com>
 <20261015095713.20560-1-qchcio@gmail.com> <20261015095713.20560-4-qchcio@gmail.com>
In-Reply-To: <20261015095713.20560-4-qchcio@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 15 Oct 2026 09:26:46 -0400
X-Gm-Features: AclHuK8CxSpv9Lg4OM681QE9BoRr-RmsT4lQNJ3FTA7MFQV8hzgXwL1ydnr1ZxE
Message-ID: <CADnq5_NXGqXy7_Ntcv0aGSQt8Ax48-SgWpSv4rTzNjDL-H_8_Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/amdgpu: reset VI ASIC on Apple boards with
 VRAM at 0
To: Maciej Kucharek <qchcio@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
	christian.koenig@amd.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 9:06=E2=80=AFAM Maciej Kucharek <qchcio@gmail.com> =
wrote:
>
> On MacBookPros with switchable graphics, the firmware puts VRAM at MC
> address 0 when the iGPU is enabled.  A later post (S3 resume, GPU
> reset) moves VRAM back to the VBIOS default.  gmc_v8_0 reads
> MC_VM_FB_LOCATION once at init and reprograms it only on SR-IOV.  On
> bare metal, the driver then keeps using the old layout.
>
> vi_reset_quirks[] handles this for the MacBookPro14,3 by PCI ID:
>
>   commit a22e5e4f2ebb ("drm/amdgpu: reset VI ASIC on MacBookPro14,3")
>
> Add the test that SI and CIK use: an Apple subsystem vendor and VRAM at
> 0.  Other Polaris MacBookPros then get the same reset at load, for
> example the MacBookPro13,3 if its firmware leaves VRAM at 0.  These
> boards are not tested.
>
> Keep vi_reset_quirks[].  Its MacBookPro15,1 entries fix a different
> failure, a module reload after S3:
>
>   commit a5be7ad8f5f0 ("drm/amdgpu: reset VI ASIC on MacBookPro15,1")
>
> VRAM is not at 0 at that point, so the new test may not cover it.
>
> After the reset, FB_BASE is not 0, so the new test does not fire again
> on a module reload.
>
> Only compile-tested.
>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Maciej Kucharek <qchcio@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vi.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu=
/vi.c
> index a0435fd55..cad6bbfce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> @@ -1405,6 +1405,16 @@ static bool vi_need_reset_on_init(struct amdgpu_de=
vice *adev)
>         unsigned int i;
>         u32 clock_cntl, pc;
>
> +       /*
> +        * MacBookPros with switchable graphics put VRAM at 0 when the iG=
PU
> +        * is enabled.  Any later post (S3 resume, GPU reset) moves it ba=
ck to
> +        * the vbios default, so reset and post on load to start with the
> +        * vbios layout.
> +        */
> +       if (adev->pdev->subsystem_vendor =3D=3D PCI_VENDOR_ID_APPLE &&
> +           !(RREG32(mmMC_VM_FB_LOCATION) & MC_VM_FB_LOCATION__FB_BASE_MA=
SK))
> +               return true;
> +
>         for (i =3D 0; i < ARRAY_SIZE(vi_reset_quirks); i++)
>                 if (adev->pdev->device =3D=3D vi_reset_quirks[i].device &=
&
>                     adev->pdev->subsystem_vendor =3D=3D vi_reset_quirks[i=
].subsystem_vendor &&

Please drop the now duplicate quirk handling here.

Thanks,

Alex

> --
> 2.55.0
>
