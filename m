Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E1148382E
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 20:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787775736; cv=pass; b=Y7XQi1AFeRn1XwUCb923fZDOYZWo15slcwFM/qqmr6vgk7IHwprh8YDZsma9FXk6InoRXXGOlvV3+ivMfI+cUNMpvE/4FgRKgsUOYsJwVmM3DpZv36COna4nEkkPXS0bqc4cHHTJQQQYdddK17xLAwiCTqbqR9w/gvL8Ikl2eZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787775736; c=relaxed/simple;
	bh=L4nicArUy3sBy3nVh9y3Yt0LV2goWnN7UEFMNz3Hy8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6et4ImRhn0V09QqWpCcRw1KFYwAF34BzYUMm7lBJWEAKehzKHy5u0C0xciUeL/Yfu4biSOEsK/5SDVCR281aZghsQLv6Rrt//i49HMlIgxQ3iYiWkgiRnAxNUavUCdBJf6Q4TXNum9U+tsSVs94ic5aQW5b5I+kPPUt+51G4YQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qqXNSCs0; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qqXNSCs0"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3856d4015e0so241662a91.2
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 13:22:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787775735; cv=none;
        d=google.com; s=arc-20260327;
        b=AQn+KS115nbwvRGamne3E5qssm2TvAlH59glWsG3hSTkEypeOD8wmGAPNYhnmcABKf
         U19t3/4GjCdZCe1BupfdjXMcr6LZ59FtZuE1ybbq+W7mYCgnx2XKJmuuKerZQa6i8MoG
         YXBpJ/6TdXD/IhrtRcO5oB9XdtO/TX1jKBo9fMva09cxeLfALTO97+HL/7+w1KOsLuJF
         lzQek8DxVLqtG+LPhHvItZP5RaUNleHXrY4uGpWyUPRRO28WAkIP87QikKRzO9fotZzx
         Ief6/4BltqxXK6ege4IwBUFgAMMj5QjTlo2+9k3bnIOG6MZpAh7r7bdc1KwDNDBnrg+y
         gThg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BEAHXUxB2VWuC97VageNwTEoOJOcxIW3TPD295GmCv4=;
        fh=J+hLsZfh/JI8S5LM3w0QZVgu21+fwp/xATgDdePFnKQ=;
        b=LRDXan9qks2HFeYqd1sKMasepPoSvYlSgo18H2tn/4AfwOfURQ4fLf+E/L2yIVa3fO
         XtzIxka8RTaCBSTmt+5N6jCAHwZoUY5a9ytkW/YGFiFCk7H1qX9CKhLeuMxUj53z/IgO
         C9aG3xEVsFXvCModv8mjn5AQgeYCDKze2pYyNT8HTTMC7Tozw0rv7L1lJIdBeobRuwks
         FfiIVC/JUu6CdR0IWyh5VZHAQXfye7uiNyNQwHjc4yX1ChpvQXHubCijHXypGiwQ/WrZ
         lT/HVESfog/rUt2mOyqbVG6e2/jumfZmNUUS827zUUtZV4vwQWCOU2rpDPx34HMZqAs5
         YW7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787775735; x=1788380535; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BEAHXUxB2VWuC97VageNwTEoOJOcxIW3TPD295GmCv4=;
        b=qqXNSCs0s0D8xBSbpHMryxQwuCOBptuBxs8acRV7nm7MljLBBEr0Klwvg1Eqz+8Qna
         jC8q64qeQC5twjGdqzq16fxaeqAnlzI1H455cLG/kAJ8LiVzdmi6gTJ7hW/GerV94VWg
         Oh79heMgHURHlsMXczWlklt+jgsIpv9ttR7ff41Z/6QijrQy/D11/ztkO3HFjtBWfc3r
         NHxcVsKe9wWJ++9oC2HZ5tDAyhd0jWMq/9Ri4eCvQJk12NnfUirSVZGG+ZFCoZU5z6f3
         vIJgVSbHCuTIGCn7m8LV1qo56z8VgI+WNS1QqTJVcdRACgMXYqaEb/rpP2yPvowNT1Bu
         /14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787775735; x=1788380535;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BEAHXUxB2VWuC97VageNwTEoOJOcxIW3TPD295GmCv4=;
        b=RzBHs/IAmjqKRjqj6wMpOoaMVa72pH1CHV2SbhxhXD8nCsZ6ypvECdJcnDOkpG4hO2
         5UHP7z7+lBuC1rQaduszgEDZv6Z11SdOVRPAsfirAf+9ft1yp9hbVJTQo6omGw27HDVw
         EsSLzroBx1MAcTEuyVx/LR5gwYXK+4+MvNfh+NaeKddZ3z0cAK+CtBpfDGHAML0ISxDn
         wWN8C0/CAyFbGElA0gnu/CFPYI9Wscf2E8SRnocGy+98spEdAhtSPfnwWXJm2CXjfORa
         grXyBKmW3J7tfHZQmUbVJFV0U7kBasr76Hrh1oP0HL8e0THnESmK5vTCoY9Sv4tM1ykU
         6TeQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqubh70yMf5QX51QBQz7ckt2aOu9vbXdDgH1CWMETyvFssTqaeGrU1MrJ0L2hriIsl4qM1h0jk=@vger.kernel.org
X-Gm-Message-State: AFuF++lVRbDchN/LxtSz9oZoH3EVRXwsWgBAA5+GILZWYxwowSqtqrw8
	LFZbHYagC7pNFnuNKMBpmtouFKvquwShCITQm8RSm1Zrl3AU4/8RYPJFDdyzR3+zSMPnMJIc2jW
	KqHtgxua/SD1Wp1/GRGyR97f8D59phsM=
X-Gm-Gg: AR+sD12TUkB3+S/+XRvi1/LejOwBQath5Zz6UFdDd/ZVTT9Wiaec4l/TDLs7bkEee5R
	URZxCjY/SwMqnMGnlHts005sGJPBMrpadKAkC1ULV34uO8apN7ud2uzqQ2TrDX9R7xTrIKZyapA
	EPTy3Df8MhVHo7RP0SkLAym3dUphrI9XvAjYo34xSrvLALwOlbDcegT/YN0UDFjn3n6SEB2UJM1
	jSqSAXPku/PGGzvLAZq+CbOl81UcUXktGwxXV30E60xxoiTk3sV7zybb3gBckqerx8dTmQTyWvq
	9Colhv5H0y+FRAT/F95Pro+g90tLYAyFPx91ram5umOtiYhHEfl7IC+9mssIdYuDxabygEoIp7y
	XjroIh4ICtFxuM1ZpLD2L5J7vEGVPeqY=
X-Received: by 2002:a17:90a:ec8b:b0:396:54a9:8d87 with SMTP id
 98e67ed59e1d1-396976a3e62mr2440677a91.1.1787775734966; Wed, 26 Aug 2026
 13:22:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826185102.2269511-1-mario.limonciello@amd.com>
In-Reply-To: <20260826185102.2269511-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 Aug 2026 16:22:02 -0400
X-Gm-Features: AcwNN1Xv4Dw5HMxryl0YtcgdqHYDqXKXfb2-Aic9flqetBfAx3wECFQmD2BdJPY
Message-ID: <CADnq5_NFjs_i_bgjKjsk1atzZ2VKvoyH9Lx8CagEzSkOxgfsqg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: restrict BAR0 fallback read to SR-IOV VFs only
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org, gloveless@jqluv.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 4:10=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> The BAR0 fallback read path was introduced as a workaround for SR-IOV VFs
> where the VRAM aperture is not available during early init. Restrict this
> workaround to only SR-IOV VFs where it's needed.
>
> Cc: stable@vger.kernel.org
> Reported-by: gloveless@jqluv.com
> Fixes: ea8ac194077d ("drm/amdgpu: reduce early full GPU access during SR-=
IOV init")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 3603f7109703c..251c4aea013fc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -765,6 +765,9 @@ static int amdgpu_device_read_fb_via_bar0(struct amdg=
pu_device *adev,
>         if (!buf || !size)
>                 return -EINVAL;
>
> +       if (!amdgpu_sriov_vf(adev))
> +               return -EINVAL;
> +
>         flags =3D pci_resource_flags(adev->pdev, 0);
>         if ((flags & IORESOURCE_UNSET) || !(flags & IORESOURCE_MEM))
>                 return -EINVAL;
> --
> 2.43.0
>
