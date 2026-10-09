Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79C939C006
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 21:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791581720; cv=none; b=EBfHmnBa/jw5Ct4jBrQsVcfKfwKy4unXktatVdLX5oioK5ZWcbUWyGRN3eLeGbK7NkwfWkL8SwH7I9dtB2Elj9/Yse4ktShLPut9QANAYfvKQcGb+/NnXGlZfDxSG1DId0lO50psm0y/IKc4vsk9kf6Lp0d6O7Yd5YtquLNpGvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791581720; c=relaxed/simple;
	bh=Wf05kQbcbOkiyKMTmOPnih+WYMI6b4lzX2eT4vVhcsM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sT4TurJ9CziV2+gTGLQu3rG1D2H42YpNLieCO+/E8TBUZmTxhLO5v5LOtsL/vng+wK+unzgLO6M0xDeGNXD52uBXfXRvammtYPNOVi5T3NeGBfudFKbglKdjg5YjFsoGJe7NBB5sP3etBUEVpykpglYvy+MHrUjWk+0GLXfko7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZSFjCFm+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TbB0Ge0l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZSFjCFm+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TbB0Ge0l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791581717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NZbd6xFkyNScCfIhKBOuLvqJ7Rh/HkXO4uKgVfA+mJo=;
	b=ZSFjCFm+d5s8RmO7QFpgykPPICZuJjnwouTO9LdSsj54ZC9nv2ufejTxhnneJlYk093Pzp
	Fjl3R+U29hRZTSnnxAWkEnYX1YMqa04BcVoouuuJXcLGT+nn3fUl0ziT5LQ1bMfx98d5s6
	y2CvdJg453oGbILoZViiKSJruSvJbtQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-F5eHMnVDMwyY6socjcad6A-1; Fri, 9 Oct 2026 21:35:16 +0000
X-MC-Unique: F5eHMnVDMwyY6socjcad6A-1
X-Mimecast-MFC-AGG-ID: F5eHMnVDMwyY6socjcad6A_1791581716
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5338ff2cf14so2606781cf.1
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 14:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791581716; x=1792186516; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=NZbd6xFkyNScCfIhKBOuLvqJ7Rh/HkXO4uKgVfA+mJo=;
        b=TbB0Ge0lPhT3jZFinbZttJN3rLZJrL4anNPfOsS+MjH4ic5FBjXJZbvDIG7mJEL2N3
         wQWscDfHQRupEM2tfFZSf6iWl8RRU54JUaL0Lc2vN6m7m/g4f0OjX4V3sEyIT59d+lW8
         zEGpKgixsawk227DtEhmQkz+mdw6Z1IQm+rHf2UyizCvXk/BgtFVh5SEohv7LrXp+bp2
         8ECmmRSsdFNfoB4wIm7BBIRRdREXWEkNIkxuGrYzWjmJJtO1eBWXIAyv1VHtZiqDVSQc
         kSBO9pQLkGxcj9DOPqfZYW4OdeOJ2iIXrhqwQr01WqTpGEfnmGSJQGU7yp2dujRj9xHK
         zrHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791581716; x=1792186516;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NZbd6xFkyNScCfIhKBOuLvqJ7Rh/HkXO4uKgVfA+mJo=;
        b=ndj7uK3QMTsIjLJ0WLug3SW+/BP+dvhPZ7HS/mwCuORj1bWaC3kI6KasSQYFGVjq+C
         iLu8/mdJ1hUqatM1xpSioGH/Uib/QWq0mQD2XlO5Q8YqunE+ojopu6XM7DgnazzTWLxX
         hJsV874MCzL5BsvM7sqS4x6oPKohaEi4Y9ZvKDytBj31D8ZsRSoI7zl8v6XNqO+iMmjI
         m9g/htCEXH/wX+mFV4Obbo9Ud4lbOvyPcM53YMxmLcNMTdAhKe88HHOqcbI/EOq3+aRN
         Z62V4N1kzqLIvRNxomq9PdVEM7DpSAImA+yikK5jcxIrakpIjZ6n9jsBZEob5aqQU3z+
         jz/w==
X-Forwarded-Encrypted: i=1; AKwUvBytV06D7OoGQHZkKrIXdM97IP/qNMgDf6pMfBdDrS4e1Lh6of3gC5LNS3IEFZhYE+k4ntZ9PlU=@vger.kernel.org
X-Gm-Message-State: AFq9FYL3zqqe4ISe/fXryGEVBevEGAjXduUrYx0gQoPH9N1MWchKxB6I
	O3lACAaUE3usfI4vKZdTRGK0U/4XAP2UjFXXFSGqiIAYVGRJHSAfAHDH0w5mmd+TOmYSw4ODsbl
	yfUszyIsDwWZPR07fbPO8/xwsSsf0bQnnKpYSGkPMR4NhXcwuKOYmKKH3yA==
X-Gm-Gg: AYBFou3OIiseyGqwyck50l0fiJtHdPiSTT6lnXwU9V1ebVQUpJzbLjuU4TnIPGdgNXd
	UAzcW0693/cn5bTRTHghuU+Kj7lFDdiGuesAdUo5NinlDByW2ORrbUdR+GtrW4xHCZ6m/hwnDGG
	Q2Mm9ToO3kYMGhER3TGiLzB5AgS5K0M3mbaMeaTy6IslmNgoGnkvKPYRfst7iWs/HvPVAstfFbW
	oYUihRIQi5LE29LM6a6mBszC65ZTZOpdOuKQXpdkFi2WxANEpG95pMrP8q+VG7VKJ2kDKr+pHlP
	JvOsNKFsFDZMt4BdbclDNXv2w5lvpVOMouHXRGf7o+RtclBkgaaj0n7XSH9RGfO6wkzdvTI=
X-Received: by 2002:a05:622a:58c4:b0:535:a5fb:67fc with SMTP id d75a77b69052e-535a5fb850cmr34635021cf.72.1791581715805;
        Fri, 09 Oct 2026 14:35:15 -0700 (PDT)
X-Received: by 2002:a05:622a:58c4:b0:535:a5fb:67fc with SMTP id d75a77b69052e-535a5fb850cmr34634721cf.72.1791581715415;
        Fri, 09 Oct 2026 14:35:15 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b6fa0f9sm27073771cf.8.2026.10.09.14.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 14:35:13 -0700 (PDT)
Message-ID: <25778dca265f58185917c5948490e76184c778d3.camel@redhat.com>
Subject: Re: [PATCH v3] drm/nouveau: Fix memory leaks in debugfs and hwmon
 init error paths
From: lyude@redhat.com
To: liupeng <liupeng01@kylinos.cn>, dakr@kernel.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, 	airlied@gmail.com, simona@ffwll.ch,
 linux@roeck-us.net, nouveau@karolherbst.de, 	bskeggs@redhat.com,
 dri-devel@lists.freedesktop.org, 	nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, 	linux-hwmon@vger.kernel.org,
 stable@vger.kernel.org
Date: Fri, 09 Oct 2026 17:35:12 -0400
In-Reply-To: <20261009115151.13877-1-liupeng01@kylinos.cn>
References: <ea9a1d374cf3127e5047bc73807ce821022e026e.camel@redhat.com>
	 <20261009115151.13877-1-liupeng01@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push to drm-misc-fixes in a moment

On Fri, 2026-10-09 at 19:51 +0800, liupeng wrote:
> In nouveau_debugfs_init(), if nvif_object_ctor() fails, the
> previously
> allocated drm->debugfs is leaked because the function returns the
> error code directly.
>=20
> In nouveau_hwmon_init(), if hwmon_device_register_with_info() fails,
> the allocated hwmon structure is leaked because the function returns
> the error code directly.
>=20
> Fix both by freeing the allocated memory and clearing the pointer on
> the error paths.
>=20
> Fixes: b126a200e9db ("drm/nouveau/debugfs: we need a ctrl object for
> debugfs")
> Fixes: b9ed919f1c8f ("drm/nouveau/drm/pm: remove everything except
> the hwmon interfaces to THERM")
> Cc: stable@vger.kernel.org
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> Signed-off-by: liupeng <liupeng01@kylinos.cn>
> ---
> Changes in v3:
> - Drop the extra return in nouveau_debugfs_init() as suggested by
> Lyude.
> - Add Reviewed-by tag.
>=20
> =C2=A0drivers/gpu/drm/nouveau/nouveau_debugfs.c | 14 +++++++++++---
> =C2=A0drivers/gpu/drm/nouveau/nouveau_hwmon.c=C2=A0=C2=A0 |=C2=A0 2 ++
> =C2=A02 files changed, 13 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> index 47d5579c568d..338421e52f69 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> @@ -295,13 +295,21 @@ nouveau_drm_debugfs_init(struct drm_minor
> *minor)
> =C2=A0int
> =C2=A0nouveau_debugfs_init(struct nouveau_drm *drm)
> =C2=A0{
> +	int ret;
> +
> =C2=A0	drm->debugfs =3D kzalloc_obj(*drm->debugfs);
> =C2=A0	if (!drm->debugfs)
> =C2=A0		return -ENOMEM;
> =C2=A0
> -	return nvif_object_ctor(&drm->client.device.object,
> "debugfsCtrl", 0,
> -				NVIF_CLASS_CONTROL, NULL, 0,
> -				&drm->debugfs->ctrl);
> +	ret =3D nvif_object_ctor(&drm->client.device.object,
> "debugfsCtrl", 0,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NVIF_CLASS_CONTROL, NULL, 0,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &drm->debugfs->ctrl);
> +	if (ret) {
> +		kfree(drm->debugfs);
> +		drm->debugfs =3D NULL;
> +	}
> +
> +	return ret;
> =C2=A0}
> =C2=A0
> =C2=A0void
> diff --git a/drivers/gpu/drm/nouveau/nouveau_hwmon.c
> b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
> index 726397ab035d..ffbe7f542ab0 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_hwmon.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
> @@ -697,6 +697,8 @@ nouveau_hwmon_init(struct drm_device *dev)
> =C2=A0	if (IS_ERR(hwmon_dev)) {
> =C2=A0		ret =3D PTR_ERR(hwmon_dev);
> =C2=A0		NV_ERROR(drm, "Unable to register hwmon device:
> %d\n", ret);
> +		drm->hwmon =3D NULL;
> +		kfree(hwmon);
> =C2=A0		return ret;
> =C2=A0	}
> =C2=A0

