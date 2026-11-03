Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706585;
	b=XxTCCnlVxjsqPW+6DUUn5ewR1v4Ywi1YxLen4CqZ6UexKJIvg4YM73CcPem5ecivtrWb
	 qzqkLdrLRkWzhyFqxvJJx66PBqXJDOyeGzX1bzUtoPqoTIUfuDclvpssDgLRKL2FlEtg2
	 KaNc2SMIEfO7UnojGo+Ayd+QkjjcM/KsgymFpwKKb1+fcgHYbaTh1L//qEVEqqi8lsIEs
	 1fhVA4PKJB7G1eKbMAhhi3Sba+xFqkSFTdseSnAw6ouaae5KFpdczp71CC54Qyf+duyi4
	 iwo6DRue7V2+IvwgszHg8d+4vX/kwv2LNZjmr84hYjhV7lZgJCItyPvd6AVK75MQ0ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706585;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=Q+oLP1OEwtePBrYrElNROHr+q71h1tBToe+zpCw5khE=;
	b=40IYu8Lbenop6eh4Rih+QWReGxzePJo7qj0IcFzggn+s1M/59xDxOIE/ZdBiBFlb7WGp
	 tcMn+kHTL8ys2zx1BMlTnWAdXltBbpplbh3akCuJthvXkDRkJLdCrrrTKkvuk7+v+GTPP
	 bIuCJXzQrd9eq4lNUdCZ0Uz3Kya9A1zio+etGR6fGUOunn8o4tjN6HdH+i6Kio0ikqOAH
	 ReCFWfr/HqBSfG9rWU+7K5PJOYO/m96/Jd2cNeA2njGAaIYuFfbuCYZWZ4+16cYfB8dxz
	 srXssEFXJv5qxCKd4z4KxbKzNmLL1ijxj/fy794/A6rtn5Y+opNx6JYNtiK64uCxCyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JzD9qNM6;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E429606A339
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 11:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E429606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JzD9qNM6
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a549cd7fd2so6079835e9.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 03:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793706584; x=1794311384; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Q+oLP1OEwtePBrYrElNROHr+q71h1tBToe+zpCw5khE=;
        b=JzD9qNM6RpV88GkWHfULKtjSaEAQMrQye1soENW8DfoGD/ljSXfdE+3T7Qirz9b3sZ
         THlInnnrRlzmj+QQwIB0GeazDvKZj5BW35v48UBhOPOWG6UU4JdUPJrQkdcgdRobSGYG
         uBkUTDIbO04E53//4sDn0A4j50vyjIh9wJp91vbXL+hMWZlKD5gJ3Ql7R+htoS5sR/A6
         FW8X78VcsQ8F810onSoLA5GMzFpmBKK0bYYKM16MeIVofoWVa6cHaHfGPt0uU15USrGY
         2U61wKKrNfOFHMGquDGSF0wTiY5/Ulh8ZnLojQu3rUCEIBObGkxptcULHGYIyS4szKpe
         8ndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793706584; x=1794311384;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q+oLP1OEwtePBrYrElNROHr+q71h1tBToe+zpCw5khE=;
        b=dlC8isFhYQIdW2qf5qcX73jCEs5xsCpt4nqK4XQvW857Tf/Zky+nRcsCouOSFmfWzH
         V24mr2HNJ+bjHuS9F7ETcof406H7VyVsRZHtAAl3cPWsGNt4psZ0sv21S4hW0EqoNN4x
         P84O5OrdTV0s9IBo9IGHXcaQvnlVf9hztk+Q5XkVtBPnXz5IC2uTfsILb15QYD7d2cXV
         AkKFV9rMnafn59JFDZ4nOIqu8PKIIdzQxiz9inYXjjWOVcjmFOIbWe9MUc3+ol0MUnea
         KcLPAryinwX0z5g2pzzctwMJasvzY0lf13gsR9r6NF5RumR9hH+8I801upNJ2GZXU5jm
         xeag==
X-Forwarded-Encrypted: i=1; AKwUvBzEz4d1dS083rv5i4xugBQZd/1Sve4FFxwMDUiU5ds4KY49DCFEybENyc6vTBGTTqaVe8zSy24=@vger.kernel.org
X-Gm-Message-State: APuU4Z83B3D0OWuv7rAgZySBrgBmxtwJc7BdG/Vrxmp2B1t8KgSFaP/z
	XnQILP7TzBlpi5FL5atdVdqAVhzkgutQJzdsLoaTkcABIVq2LO5nhqSZ
X-Gm-Gg: AYBFou2zghLitBqZLY2WnAXSptFKmHbjXWfEVtt7Vs9U6YBI6jLGQnoU/W29J/bgTia
	JRiqOvmJsklWFYOcQKGVIsQhY/RnKkGbUNj4lQtnOnCevyQfaqNWBIytFRRQw/o3vQWJ1VKuCsz
	1ygnfzZjmZpVXOZWQY/TUtfwV8O7Ox18gtIFdkjQH8JAqZ3xUXx9ukh4Kktvl1X1x4v7jJVAgTi
	4komS7MhiYg1806tOC0YA37tqf10D15qgFwvgXBXNPPZO8ARMVrNtbYafLhE70twntmzsdy04En
	rihReaEKvw7zKfPVpEBFW6uKP5HVZC2HN/Ad9HMkCaDDl4la4nUTaUAoG53zgmgv90Lzr8YINNT
	jf01HUmsP7Xx9ZUwzrv7VCswNsI8aIC6sphK3NA+25nznmrLsMiQa6bLzXU631tqdLEH3V+Kp4k
	2+xOvPu9JGCvEo9S8RHkcwin8rAjA/NoIb0aXjJyaxQ/mPGzPZmayWXjiMCkr/Ejf44Co9JL2sm
	pRj9nEIQqWHRVS4wrvAWUya80GLGGjpm+Y+BM3BUsA0CG8UIjjJl4AaRiqEF65E+y7ucGRGXksq
	ktt9q8xGOeWXggZP7Xg4VmGqh0q6nvc8YEbQqmu0Xir20ooCa21vXLx4BmJln6nwQZp1Z+wpMyR
	iYd4zavY+
X-Received: by 2002:a05:600c:1387:b0:4a1:88df:8a2a with SMTP id 5b1f17b1804b1-4ac1793e81cmr309764195e9.13.1793706583552;
        Tue, 03 Nov 2026 03:49:43 -0800 (PST)
Received: from [192.168.1.86] (240.red-79-154-229.dynamicip.rima-tde.net. [79.154.229.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abeb77af8csm446345565e9.1.2026.11.03.03.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 03:49:43 -0800 (PST)
Message-ID: <be6a9d3074290c030a6dcf9211a02fe690fb5696.camel@gmail.com>
Subject: Re: [PATCH v3] drm/amdgpu: Only enable HDMI audio if display
 supports it
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Panpan Ren <renpanpan@kylinos.cn>, alexander.deucher@amd.com, 
	christian.koenig@amd.com, simona@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, tzimmermann@suse.de, 
	lijo.lazar@amd.com
Date: Tue, 03 Nov 2026 12:49:42 +0100
In-Reply-To: <20261103061147.25827-1-renpanpan@kylinos.cn>
References: <20261103061147.25827-1-renpanpan@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, 2026-11-03 at 14:11 +0800, Panpan Ren wrote:
> From: renpanpan <renpanpan@kylinos.cn>
>=20
> The amdgpu legacy DCE audio path (dce_v6/v8/v10) unconditionally
> calls
> audio_enable(pin, true) at the end of afmt_setmode(), regardless of
> whether the connected display advertises audio support in its EDID.
>=20
> This causes a phantom HDMI audio output to appear for displays that
> have no audio capability (no basic audio bit, no Audio Data Block in
> EDID), because the GPU sets the AUDIO_ENABLED register bit, which
> drives the HDA codec's ELDV pin sense, making the codec report the
> jack as audio-available.
>=20
> The radeon, nouveau, and dw-hdmi drivers all gate audio enablement on
> the display's audio capability. Apply the same check to amdgpu's DCE
> afmt_setmode functions, while still respecting the
> AMDGPU_AUDIO_ENABLE
> override for users who explicitly force audio on.
>=20
> Fixes: e2cdf640cbb5 ("drm/amdgpu: add display controller
> implementation for si v10")
> Cc: stable@vger.kernel.org
> Signed-off-by: renpanpan <renpanpan@kylinos.cn>

Makes sense, thank you!

Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>


> ---
> Changes in v3:
> - Also gate the initial audio_enable(pin, false) to avoid touching a
> =C2=A0 potentially shared audio pin when the display has no audio support
>=20
> Changes in v2:
> - Respect AMDGPU_AUDIO_ENABLE override for users who force audio on
> - Add Fixes tag and Cc: stable@vger.kernel.org=C2=A0for stable backport
>=20
> =C2=A0drivers/gpu/drm/amd/amdgpu/dce_v10_0.c | 12 ++++++++----
> =C2=A0drivers/gpu/drm/amd/amdgpu/dce_v6_0.c=C2=A0 | 12 ++++++++----
> =C2=A0drivers/gpu/drm/amd/amdgpu/dce_v8_0.c=C2=A0 | 12 ++++++++----
> =C2=A03 files changed, 24 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> index f2977fe6d824..a8f5eb2394c6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> @@ -1555,9 +1555,11 @@ static void dce_v10_0_afmt_setmode(struct
> drm_encoder *encoder,
> =C2=A0		bpc =3D amdgpu_crtc->bpc;
> =C2=A0	}
> =C2=A0
> -	/* disable audio prior to setting up hw */
> +	/* disable audio prior to setting up hw, unless the display
> has no audio */
> =C2=A0	dig->afmt->pin =3D dce_v10_0_audio_get_pin(adev);
> -	dce_v10_0_audio_enable(adev, dig->afmt->pin, false);
> +	if (connector->display_info.has_audio ||
> +	=C2=A0=C2=A0=C2=A0 to_amdgpu_connector(connector)->audio =3D=3D
> AMDGPU_AUDIO_ENABLE)
> +		dce_v10_0_audio_enable(adev, dig->afmt->pin, false);
> =C2=A0
> =C2=A0	dce_v10_0_audio_set_dto(encoder, mode->clock);
> =C2=A0
> @@ -1705,8 +1707,10 @@ static void dce_v10_0_afmt_setmode(struct
> drm_encoder *encoder,
> =C2=A0	WREG32(mmAFMT_RAMP_CONTROL2 + dig->afmt->offset,
> 0x00000001);
> =C2=A0	WREG32(mmAFMT_RAMP_CONTROL3 + dig->afmt->offset,
> 0x00000001);
> =C2=A0
> -	/* enable audio after to setting up hw */
> -	dce_v10_0_audio_enable(adev, dig->afmt->pin, true);
> +	/* Only enable audio if the display supports it or is forced
> on */
> +	if (connector->display_info.has_audio ||
> +	=C2=A0=C2=A0=C2=A0 to_amdgpu_connector(connector)->audio =3D=3D
> AMDGPU_AUDIO_ENABLE)
> +		dce_v10_0_audio_enable(adev, dig->afmt->pin, true);
> =C2=A0}
> =C2=A0
> =C2=A0static void dce_v10_0_afmt_enable(struct drm_encoder *encoder, bool
> enable)
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> index c68de0fe1d7d..3cd9f1bb3a70 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> @@ -1724,8 +1724,10 @@ static void dce_v6_0_afmt_setmode(struct
> drm_encoder *encoder,
> =C2=A0		bpc =3D amdgpu_crtc->bpc;
> =C2=A0	}
> =C2=A0
> -	/* disable audio before setting up hw */
> -	dce_v6_0_audio_enable(adev, dig->afmt->pin, false);
> +	/* disable audio before setting up hw, unless the display
> has no audio */
> +	if (connector->display_info.has_audio ||
> +	=C2=A0=C2=A0=C2=A0 amdgpu_connector->audio =3D=3D AMDGPU_AUDIO_ENABLE)
> +		dce_v6_0_audio_enable(adev, dig->afmt->pin, false);
> =C2=A0
> =C2=A0	dce_v6_0_audio_set_mute(encoder, true);
> =C2=A0	dce_v6_0_audio_write_speaker_allocation(encoder);
> @@ -1748,8 +1750,10 @@ static void dce_v6_0_afmt_setmode(struct
> drm_encoder *encoder,
> =C2=A0		dce_v6_0_audio_dp_enable(encoder, 1);
> =C2=A0	}
> =C2=A0
> -	/* enable audio after setting up hw */
> -	dce_v6_0_audio_enable(adev, dig->afmt->pin, true);
> +	/* Only enable audio if the display supports it or is forced
> on */
> +	if (connector->display_info.has_audio ||
> +	=C2=A0=C2=A0=C2=A0 amdgpu_connector->audio =3D=3D AMDGPU_AUDIO_ENABLE)
> +		dce_v6_0_audio_enable(adev, dig->afmt->pin, true);
> =C2=A0}
> =C2=A0
> =C2=A0static void dce_v6_0_afmt_enable(struct drm_encoder *encoder, bool
> enable)
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> index c3906270f25e..eb1fcf0b39cc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> @@ -1523,9 +1523,11 @@ static void dce_v8_0_afmt_setmode(struct
> drm_encoder *encoder,
> =C2=A0		bpc =3D amdgpu_crtc->bpc;
> =C2=A0	}
> =C2=A0
> -	/* disable audio prior to setting up hw */
> +	/* disable audio prior to setting up hw, unless the display
> has no audio */
> =C2=A0	dig->afmt->pin =3D dce_v8_0_audio_get_pin(adev);
> -	dce_v8_0_audio_enable(adev, dig->afmt->pin, false);
> +	if (connector->display_info.has_audio ||
> +	=C2=A0=C2=A0=C2=A0 to_amdgpu_connector(connector)->audio =3D=3D
> AMDGPU_AUDIO_ENABLE)
> +		dce_v8_0_audio_enable(adev, dig->afmt->pin, false);
> =C2=A0
> =C2=A0	dce_v8_0_audio_set_dto(encoder, mode->clock);
> =C2=A0
> @@ -1653,8 +1655,10 @@ static void dce_v8_0_afmt_setmode(struct
> drm_encoder *encoder,
> =C2=A0	WREG32(mmAFMT_RAMP_CONTROL2 + offset, 0x00000001);
> =C2=A0	WREG32(mmAFMT_RAMP_CONTROL3 + offset, 0x00000001);
> =C2=A0
> -	/* enable audio after setting up hw */
> -	dce_v8_0_audio_enable(adev, dig->afmt->pin, true);
> +	/* Only enable audio if the display supports it or is forced
> on */
> +	if (connector->display_info.has_audio ||
> +	=C2=A0=C2=A0=C2=A0 to_amdgpu_connector(connector)->audio =3D=3D
> AMDGPU_AUDIO_ENABLE)
> +		dce_v8_0_audio_enable(adev, dig->afmt->pin, true);
> =C2=A0}
> =C2=A0
> =C2=A0static void dce_v8_0_afmt_enable(struct drm_encoder *encoder, bool
> enable)
