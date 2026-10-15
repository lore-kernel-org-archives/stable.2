Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15257472079
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 19:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792090906; cv=pass; b=SiBhyP0PY1fImtv2WSknUI2fOCrxDARwLX+jus1FisVbfa/39RJBrXtgBjZlNYMyQtuR4jMLBAQ8ypF+SXG3ZU8HlvixlbFYIzsdxjCQPTGcMeKZqVj3rnY6ZHaZE4eTSKZn7oSq0qv3jhuP5zqDbZ/jeFb1BCoAc2z6nhbkobk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792090906; c=relaxed/simple;
	bh=RwXiSruwpDmT+a5Nq2nfPJV/bpg4QjcH0Roun986rXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=owrFJVAGsFDduVTdpca3qYtXqbMN/NE3bx433FssSWb5zf2kb7Dc0rJMvnrTRzDkxcI48969LWy97x/PF1v9AqL2xCQNgVn0OSB44lXJA+FlS4mr+MLzWrZMacCCTlAIUIMN+8NaPjWJFU4qux4maNWENdMJoGwhGlDaZdM3k0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXthwZz7; arc=pass smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXthwZz7"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-33c10faf6easo604302eec.0
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 12:01:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792090904; cv=none;
        d=google.com; s=arc-20260327;
        b=p+0lSdkb5da7zq9a580unISRyj9IYJPPqXgxxn/KuzqwWwP0qtxASx8sIZ9erkYiNl
         e37M2XzAN4npbS7fKK+fYp419oeNBYdTBYi3em5OlmzxjFWXHclQXb5Q0FrQ1Cjm5HjR
         b2pN9kvzG804fxo6qVPVTDOehqIw7bDeKgHB8m+F4lsJXtPd5YPc2KiNl3FJQ2TxEyu5
         0MAquA1EMzxncq05in7RSQJeFfn+be0vmV8Hpd1UdloJWNLwQkrpwEyGSX50Tbte+xrF
         xWoT7Fq/TvEuPoAUqaDbWum8+mXn7o4UsYHZY7NnX9gbdA/S5KfiinKeteh718/tJQlG
         6l/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GSqlEIsMMPdLgM90yMu9rfnGiqltcVn6qKzNnPCW0EY=;
        fh=s6z+yiw+N3Az32JR8Vk9ses8vbRiA10GFhXg+qAcXus=;
        b=E/UWl+XCbr+NDFw6Kyw0RF6HccrWvm84YxCCEgWiRKV4E7oCoUBaryBNtkauDlrxkY
         YW3oOxC9JURUwiPp0+3flpNzkutKb7KUxxVOmtRdnPJMu67l3LaZVTk8Ne2RYCx+AM5G
         VGn07plhe1fdMCvVCmvONW0sYD9scD/i8Jdt2DPROmPVHo76g2e+y4U2/grEvaohCuW/
         SMYfF5Xj2hmd3LuBFZfel6PH4m5mzLOhbIS4eVSDcld+b3AoqQ/IK2lV3EY6JsekLcMC
         rLFmshIPMQawqj6LKgPydJY/yCEQXWrXazwSyrGzCtvhc0epN56wRJOaVY8U/8gHP0s8
         vc2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792090904; x=1792695704; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GSqlEIsMMPdLgM90yMu9rfnGiqltcVn6qKzNnPCW0EY=;
        b=UXthwZz7cLqaKfLBuoMhsRXkQ4GefBC40jc9+ww9F8QHY1GY3mTLOX/gZ96UZuEAEo
         bvN7vScR1K+vTEb61Pej0BRZ3YLEZW0BOi2B5zBjmyIXdyRpyIcnm9NfNZRIfaGOdm7U
         3TIexg2zxTk/uB6weULLLCBYVAI+DDLHVooQdzepc1V508RgemufPoNUpLC+jlMcEuIy
         Wz7x8ObPi8y9aJneqZU4X8oAioxLmFK6LfDdpw4QqYj0gU2rHNPU1zZWpdnKqeLmiMxb
         cP1nv/rzau7vDBvPjnmcgedaMJ+Ma/Yc8gtiTx8BZAsGj2WI/Z/FMdw8Gy5lR4vW/6eb
         1IQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792090904; x=1792695704;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GSqlEIsMMPdLgM90yMu9rfnGiqltcVn6qKzNnPCW0EY=;
        b=yN598fpOVdewAKROPS/bgKrCSuHnK2ECPBP0MpHWQTHtXtXTYsapsnAORiixv/GCBt
         ZwTvYgv1JKlWhKqAYaqqQJdifUFcfjgfutJijIBRMuTvv0upIGchEsPVUcoFGMoJpE5Q
         wB4HVAqP3S9yut2UR0ucRMHvm+qynV8EMlKtorpHUCmWgOj6cqr8RlAvB/T50xdvDFd4
         RyYmFL6MbcDvSKxhg2s4l2Pj+GHTfDUetijj6iooF8PxzLKsfLPT+k5d0nR+YmNdU2s8
         AM1bPSPWTw73waC8EgWqkjUATpz21snZnqlLNwqOO+JGUaITYLnHkY5VVa48UNWe2aMS
         Oyew==
X-Forwarded-Encrypted: i=1; AKwUvBxf08zLrUF5bEBaNjHsFJGTcCyKZiHa9a+NfRcci9m+UZJn7CXJrempfmPSlPJ+cQJsLVExfGU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKEuusI+SCkDIBiVCetOgSXt4S7RgkxHUw/+24fPae/JvreLFxp
	f91JpQUE13XaAwYlKmaBSJDXmj8/jXfEuY3Rs1ZHLIJChhzJ7DNQw7G6AQXGGBqHoKV/oRiH+Rs
	CBk7QZDAC/F2Cgyxx9SModbm6JvufAas=
X-Gm-Gg: AYBFou0w/oDRIT4PfKtGqqiQpprer3M/B/q0mjzuHwSNIUZ9SFpJ4zxc1fAZjChWYOp
	UGZ68et52E+Dhpdar62BlCKr0TMdIwjsqc8ePuQ0Da7UN/KeGjU+97dzoJuP2SOXZoE6TDSpXGn
	GCr0M9JDcy4rV4wLSA9PiiAzxAAYFN38OzLpAdgv0/iVBBfnxvi3+09G4DAkAdHeOUQst0gsBQC
	cF1zrjBLAYmhPMmEKQbFPlMr2k36z3V3zCh47kxQcXnuNLBbbKl8+BHTwH6p5hMbIKZp8YClixL
	hDuP0ieS55C9sqVNHtHfvGvLWUHbXzuQQ4KngD8zgc0v8SB8GBXFoMI5/Jtr13omUPtAW05Kx33
	uOYX0goOYcCMW/rwYbIFqJbVm3eDB4Hqh5e/HuaGO3w==
X-Received: by 2002:a05:7022:b043:10b0:127:def:dd72 with SMTP id
 a92af1059eb24-16a5ce9584bmr43025431c88.2.1792090903859; Thu, 15 Oct 2026
 12:01:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <BN9PR12MB514681E5EDA768CB4497EACFF79D2@BN9PR12MB5146.namprd12.prod.outlook.com>
 <20261015095713.20560-1-qchcio@gmail.com> <20261015095713.20560-4-qchcio@gmail.com>
 <CADnq5_NXGqXy7_Ntcv0aGSQt8Ax48-SgWpSv4rTzNjDL-H_8_Q@mail.gmail.com>
In-Reply-To: <CADnq5_NXGqXy7_Ntcv0aGSQt8Ax48-SgWpSv4rTzNjDL-H_8_Q@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 15 Oct 2026 15:01:32 -0400
X-Gm-Features: AclHuK9bE7jG8TbUbXHQL5KZs85YwSupOtLmmAUNi-mrYhsRs_NLi9NrkI6ruto
Message-ID: <CADnq5_Po1jXiuj7KWW3dWYEGQJmMx68ZMRzyBK7QFZcaL0Y_BA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/amdgpu: reset VI ASIC on Apple boards with
 VRAM at 0
To: Maciej Kucharek <qchcio@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
	christian.koenig@amd.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 9:26=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Thu, Oct 15, 2026 at 9:06=E2=80=AFAM Maciej Kucharek <qchcio@gmail.com=
> wrote:
> >
> > On MacBookPros with switchable graphics, the firmware puts VRAM at MC
> > address 0 when the iGPU is enabled.  A later post (S3 resume, GPU
> > reset) moves VRAM back to the VBIOS default.  gmc_v8_0 reads
> > MC_VM_FB_LOCATION once at init and reprograms it only on SR-IOV.  On
> > bare metal, the driver then keeps using the old layout.
> >
> > vi_reset_quirks[] handles this for the MacBookPro14,3 by PCI ID:
> >
> >   commit a22e5e4f2ebb ("drm/amdgpu: reset VI ASIC on MacBookPro14,3")
> >
> > Add the test that SI and CIK use: an Apple subsystem vendor and VRAM at
> > 0.  Other Polaris MacBookPros then get the same reset at load, for
> > example the MacBookPro13,3 if its firmware leaves VRAM at 0.  These
> > boards are not tested.
> >
> > Keep vi_reset_quirks[].  Its MacBookPro15,1 entries fix a different
> > failure, a module reload after S3:
> >
> >   commit a5be7ad8f5f0 ("drm/amdgpu: reset VI ASIC on MacBookPro15,1")
> >
> > VRAM is not at 0 at that point, so the new test may not cover it.
> >
> > After the reset, FB_BASE is not 0, so the new test does not fire again
> > on a module reload.
> >
> > Only compile-tested.
> >
> > Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> > Cc: stable@vger.kernel.org
> > Assisted-by: Claude:claude-opus-5-5
> > Signed-off-by: Maciej Kucharek <qchcio@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/vi.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdg=
pu/vi.c
> > index a0435fd55..cad6bbfce 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> > @@ -1405,6 +1405,16 @@ static bool vi_need_reset_on_init(struct amdgpu_=
device *adev)
> >         unsigned int i;
> >         u32 clock_cntl, pc;
> >
> > +       /*
> > +        * MacBookPros with switchable graphics put VRAM at 0 when the =
iGPU
> > +        * is enabled.  Any later post (S3 resume, GPU reset) moves it =
back to
> > +        * the vbios default, so reset and post on load to start with t=
he
> > +        * vbios layout.
> > +        */
> > +       if (adev->pdev->subsystem_vendor =3D=3D PCI_VENDOR_ID_APPLE &&
> > +           !(RREG32(mmMC_VM_FB_LOCATION) & MC_VM_FB_LOCATION__FB_BASE_=
MASK))
> > +               return true;
> > +
> >         for (i =3D 0; i < ARRAY_SIZE(vi_reset_quirks); i++)
> >                 if (adev->pdev->device =3D=3D vi_reset_quirks[i].device=
 &&
> >                     adev->pdev->subsystem_vendor =3D=3D vi_reset_quirks=
[i].subsystem_vendor &&
>
> Please drop the now duplicate quirk handling here.

After re-reading your commit message and thinking about it more, I've
decided to take v1.  Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
and applied.

Thanks!

Alex

>
> Thanks,
>
> Alex
>
> > --
> > 2.55.0
> >
