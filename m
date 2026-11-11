Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794430843;
	b=tGcODet3t8ZspBUUmRvl39DuTahIBrspaMoyHz0KKc1pGkePSTBBMZ0GHinY1JWkDu0G
	 IdNBDgbmMVyCMuh3NF/rvNseHMVzhkgQRCn372Wbe1giL0eYwPJFK2yMt/5a6ZdBy8NZY
	 rNx9e+59Ee5glMIaDLvArcnUTxe3XfzPrcy7Vb+ErkUdImbjPsIUi77TiDnea99BSxi1+
	 q/vm3WfaqZyljVkXND8Iqsd+oUnSzXZ/aPfS4EQtPDGaCglnnuYInzfWvIbZL9Lq03SOs
	 E6LIAqO/K4D5FBVuaxY4pxg91Gy7zTMzJC88uZQ6TozgNrEkztW7oAxqLI2QTBgQSDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794430843;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version;
	bh=Bfwzc0Soc5yMmxMHyRdKnO8B25Ja28l1t2oGS6mpFwU=;
	b=YCUbwZvyNV4slIwQuRbJQ9Ne7RNhBOZW686pzj6R0yBQWLy1ac59JxG6hFEhM224qxoW
	 oWpR4kHdnCajhvmPLvOtqcQsofr83EPDnERxmCDadGbfP84qsvjaaCan4meDGXIEJvTJH
	 4nuUiJr0Tv+2/YgjsUrJQtoQPQaM7oyBdZ/MceqZ4O3HJuhddZsfo8pwZ7k1Ct28EWs+7
	 oCb7fwNh+914aU64xo164XH9RL3q7T8KY+4z6E9QbfrRwE3sbFTBYi7dzMZT7QqQ95f5l
	 0ipB1224a4wdahAnR67NncTeGMadsv7rdTzPHotpLD2lPyP0tKixhj4zKdpW9GgR5mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WpcepRv0;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="O2ll/t1I";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52095606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 21:00:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52095606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WpcepRv0;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=O2ll/t1I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794430842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bfwzc0Soc5yMmxMHyRdKnO8B25Ja28l1t2oGS6mpFwU=;
	b=WpcepRv0u/AtqPKOc+NcqzJjSkil8wdWMwxJW1bF795axAad6g/ziaO3ikRhs93e2Pi+JD
	nng9eKLnWU8OPdOyowZ9GoOdlAPfSNwqRjP1Pv+MnI1+0WTCM+G+DgX2cmEM5pdp3yP/x6
	TVaXtAqnpbCrurtU3OEDQW8/AI2XKi8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-SN6aF-NGNoSXIJkNFX8Vfg-1; Wed, 11 Nov 2026 16:00:40 -0500
X-MC-Unique: SN6aF-NGNoSXIJkNFX8Vfg-1
X-Mimecast-MFC-AGG-ID: SN6aF-NGNoSXIJkNFX8Vfg_1794430840
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91eaad6eaeaso68136046d6.1
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 13:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794430840; x=1795035640; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Bfwzc0Soc5yMmxMHyRdKnO8B25Ja28l1t2oGS6mpFwU=;
        b=O2ll/t1ICUS+mLiTv0S3uW83OKD3VQPIXp3VdYcTtgNfta8lXcgm7MgfHkPnHnL+BU
         VqWhGo9rQqdkG+yWSJP8rdTHLIiXysAwuMkfOf6eMdsrJ9gFtGx4Z8w/i6rxIOKetPox
         UU9pi5WoR+M7Dy8BS8DsdDSEEAROuz2/VmbladhR3hi2A0dpF/+TRNxZoXi45TQBMn2D
         PBauJh14rQRhi+QotDP95vOW59XZV79y152vIV5UsUG+1Kh1lJdzZfeTLc1XP780HeQ7
         KWVFQJz7jq9rdkNpkQ/kxUtB1CJ7r/BKwtcNldqCPlAaZG8AzI9QzRlyCKqlaeA65khx
         Kpwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794430840; x=1795035640;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bfwzc0Soc5yMmxMHyRdKnO8B25Ja28l1t2oGS6mpFwU=;
        b=R+rnm7qb6rULsGsNw5VRSDOrRETDyLceRwgVOqTIpXcktGAAqasra4wRekSAr358xE
         lcBECkfSGxXtp1hUpvhP0kJczG1cfQFXhMm2vgktSBSczGHX0Z7fSQOyxo3AfBsDMt7K
         xnvLX0sdsrTzqybZdd3APQRfHsCE3zqceBaxkYtQVk478k1s2Hyjb+ZrM/hl5/iJ327Z
         N9rFXydv6CfHO4Qc/zoDb8QJxr5DAV9VJ2+4w+aepRb/PRyP4ZWuJBNHX9PJWY+Ifpux
         IP3kyAWH93vBcmxhrBEVtO53eYO2AQtQvkQOV5cgdF+q/j1bbEzAmeZVZMWjyOYDbV0Q
         j5Tw==
X-Forwarded-Encrypted: i=1; AL+hErHLvzvVp0bBzWyU5VgP9AnPvfymjBWY2TKEmmFFU/5oWgYN+5l86Y1tRUYXpinfj93zzcjLRz4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8FTbIiEl6Y3z9K4mJ5xiY5YjPJ9isYQAJaCcegfomOMQ5xikCN
	y/boMJTkbPyb0p86aeXTcdArgWaV83my1qzpgUd4u2o9mTqmvdtM35EsNExeOYJOo/yRwMSrRRp
	c4q4QEoPYxx8+OOky5QGsFIvf0VOTVpoFsgdQN7MdjrRP8Y4W4OMCKH2OQg==
X-Gm-Gg: AYBFou0Xo1RhD9uBcNAIETbj19Ae2xH1LhApp8x+2icDEEdTUt9UcZUrRf5vtSehEG1
	eLTGXxEEpbsZCAzPLES2hi6hUy/elOJBCv2oP8CU4cJs8tWDP/y36i/vU8eyQhKc9wpK20prMud
	GNWASLgCS3iQPQz1vR3L1Wrsr8SoFmI478Yo3QCPXfiIveG4iGbAQmx6OyJ2C/WuAmsLMS8LCUp
	Ec06EqJuSlMLpft366IgDESbgkYmcKIXgbpbk5MFGvoj/Y4CGEOQMm/osZXXRi2qeoUVqtqrn+g
	R+0oQdDkI/VWN+lVgvYEITm0CdsXVfTd5X94STuQnjwAGJIYYG2piztn67NBSXof9wMfc6hLW6B
	yxcVkdSgF4LWjrFgwKm9Q/dD+88BcagdfYaYGT86TB3RCB6F2++EHR4ugntRvD3wF/maX1r/7SG
	lkytyOB5a0ZcSvkQ==
X-Received: by 2002:a05:622a:590b:b0:536:663d:18ca with SMTP id d75a77b69052e-556c0ea966fmr54823171cf.48.1794430840078;
        Wed, 11 Nov 2026 13:00:40 -0800 (PST)
X-Received: by 2002:a05:622a:590b:b0:536:663d:18ca with SMTP id d75a77b69052e-556c0ea966fmr54822201cf.48.1794430839462;
        Wed, 11 Nov 2026 13:00:39 -0800 (PST)
Received: from [192.168.5.11] (pool-108-49-8-41.bstnma.east.verizon.net. [108.49.8.41])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f03ca6548sm29611306d6.9.2026.11.11.13.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 13:00:38 -0800 (PST)
Message-ID: <5b9d4fa7e29fa7ef780f5a6386de6ce9f6ee7bab.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/disp: Set
 drm_mode_config_funcs.atomic_(check|commit) (attempt 2)
From: lyude@redhat.com
To: airlied@redhat.com, Danilo Krummrich <dakr@kernel.org>, David Airlie
	 <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, Ruben
 Wauters <rubenru09@aol.com>, stable@vger.kernel.org
Date: Wed, 11 Nov 2026 16:00:35 -0500
In-Reply-To: <20261111-nouveau-atomic-fix-v1-1-118e65d3a2f5@redhat.com>
References: <20261111-nouveau-atomic-fix-v1-1-118e65d3a2f5@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Wed, 2026-11-11 at 16:00 +1000, Dave Airlie via B4 Relay wrote:
> From: Dave Airlie <airlied@redhat.com>
>=20
> commit 604826acb3f5 attempted to add these flags but
> commit 6c65db809796 reverted it due to it
> failing on hw from pre-atomic times.
>=20
> So use a second set of functions.
>=20
> original commit msg from Lyude:
> "Apparently we never actually filled these in, despite the fact that
> we do
> in fact technically support atomic modesetting.
>=20
> Since not having these filled in causes us to potentially forget to
> disable
> fbdev and friends during suspend/resume, let's fix it."
>=20
> Reported-by: Ruben Wauters <rubenru09@aol.com>
> Closes: https://gitlab.freedesktop.org/drm/nouveau/-/work_items/517
> Fixes: 6c65db809796 ("Revert "drm/nouveau/disp: Set
> drm_mode_config_funcs.atomic_(check|commit)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dave Airlie <airlied@redhat.com>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nouveau_display.c | 11 ++++++++++-
> =C2=A01 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c
> b/drivers/gpu/drm/nouveau/nouveau_display.c
> index d71dcfc6ee66..07882624a7f6 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_display.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_display.c
> @@ -354,6 +354,11 @@ static const struct drm_mode_config_funcs
> nouveau_mode_config_funcs =3D {
> =C2=A0	.fb_create =3D nouveau_user_framebuffer_create,
> =C2=A0};
> =C2=A0
> +static const struct drm_mode_config_funcs
> nouveau_mode_config_funcs_atomic =3D {
> +	.fb_create =3D nouveau_user_framebuffer_create,
> +	.atomic_commit =3D drm_atomic_helper_commit,
> +	.atomic_check =3D drm_atomic_helper_check,
> +};
> =C2=A0
> =C2=A0struct nouveau_drm_prop_enum_list {
> =C2=A0	u8 gen_mask;
> @@ -654,7 +659,11 @@ nouveau_display_create(struct drm_device *dev)
> =C2=A0	drm_mode_create_scaling_mode_property(dev);
> =C2=A0	drm_mode_create_dvi_i_properties(dev);
> =C2=A0
> -	dev->mode_config.funcs =3D &nouveau_mode_config_funcs;
> +	/* this only gets set if the driver has the ATOMIC flag */
> +	if (drm_drv_uses_atomic_modeset(dev))
> +		dev->mode_config.funcs =3D
> &nouveau_mode_config_funcs_atomic;
> +	else
> +		dev->mode_config.funcs =3D &nouveau_mode_config_funcs;
> =C2=A0
> =C2=A0	dev->mode_config.min_width =3D 0;
> =C2=A0	dev->mode_config.min_height =3D 0;
>=20
> ---
> base-commit: 067c5c24cef23d913b67eaaf71ae67e7169a6620
> change-id: 20261111-nouveau-atomic-fix-7478260ce6a7
>=20
> Best regards,

