Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795209328;
	b=Zh1BFU0zLZ1a47yldh+xs8XsDUpj8pxsNBi4KKCjc5uAess4bSg9pND0v3CtbtAnbhrs
	 zNZxcx6cK7ni1JjnYaniHhzmrXSC+vdCNfxN/5k3k9PLlsSof33Iw2NkDO361tpjrHil8
	 gtINvDcQfwf+qPQo16at6JGYw8LprlpvXuDxBtcRIG9rVeDNM4ef7vWebFAUdeRAdtXPJ
	 LWMKdFdVxS/ktu0kpjntTv36meQpGQoqbdf8ecXONQ10Lfd3UK1tL5fwjahjf1ahPdo+K
	 HbrUeBNM3Jr19HK2E4QrwAfdEivt1rbP8Vv0WawHWPAt19ubWPYZLyvQYJ24ZMPJiiA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795209328;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=jhsdAq68aTOS0woPorboO2Q3We/YdgAlOANjhDh+IIk=;
	b=KqZpbwLUXQcio89Ve0QXTSJRHpptt7Rl8J1v5JZI2Kd0JEyMnHqTeoNPBKAlbPTvCe/i
	 AdXMr83gf2lEu0DUGirGItSlqlYyt+DIKjP7l40moJde2PAd03T9DZnyxhjaGYofc20WQ
	 QSUEJGg7eKV9oZWXP2xzE4JTj6nHebuW5a3u9SV4zEwFuBvT+gr6F3QR6LeXBujbSFGj6
	 AFzXSHHWYkM/8pt/84Vd/kJrx2mCF8oFSyrPR4OKl1t3wc6v1pj1MPNKve74lTrSy77QI
	 wGWXxBVz8yz+86FRA//bz1pFd0I0Fokj3Adg/VQxjc+vcG8dEyktW3TM/HXmpor7u2Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F3CXrXiw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.51
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F04606A696
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 21:15:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58F04606A696
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F3CXrXiw
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5be3ed646a5so1760052e87.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 13:15:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795209320; cv=none;
        d=google.com; s=arc-20260327;
        b=SWXWyFnk6hWsaF4ePrkyShykE8B+9NVhL1zpEgJQEcVVNoKeomDpQSpfCN6UpKr+81
         /YLa2jIEpaUeTFPiA+2OT/jL+iZdolClo8JPEqQTjeqx7fO2LHuMS5cwRq33QeKm6Nyy
         g/Gdkz2KCRHBokSjJLxMDXPOlLOxcUxD+iBNnuUGFE3DEYc9vowjyO0Wxs7Z2GKMSc87
         427sChiwyovHoCvdhL8XTf6Nxf91N6QAK/qoXvDoIUOlqTNkuOag08jICLM5LpvtUdAt
         aqUERAslLh+IIZMq43mEvB7X3p5iHB9WULdfqRlJ6DksIxycWx6zqY9s2oROJ16mMbV0
         Dq1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jhsdAq68aTOS0woPorboO2Q3We/YdgAlOANjhDh+IIk=;
        fh=c1273DvYJC7zWW9oSIW2EWOkjxQLgDBfcttk08kh9Ys=;
        b=UF2Nk402W3zJwqTXSQAC69U9SrGYCakCH20UXm/ghxoFD5OHcH1WVNIzEnM8jKZbLX
         euW0Pw8kpqMbcAw1sLZvsfAQe/XHB90n0lG4krowdQM0ge3J0Zc3wM0UX/ZPCNd/JPlS
         Q3OB1KkaN/252VAlDhmXZ16WUQki64VPFL8EyVkt6EgojZ3q95fS8MGdrL1W4NjQBeSp
         961p4C1Lw3Hajm7U1t0NhM9/CRTEg++XXtXfMAld0Z7Wdei2qSSnR8uiOEZc1d0EkeXq
         5uZ9h+njeR4vdFe02LkpnmUwQ3m5FewaRkAAGbWsbwL2G0njYR+QchrLiVmZuar2BSnS
         RFGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795209320; x=1795814120; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jhsdAq68aTOS0woPorboO2Q3We/YdgAlOANjhDh+IIk=;
        b=F3CXrXiwAmtVGCQYnXua2+PdeK0UoDK/7K9IjEtt7ivLr2Ztl74CaHKGywM8Mecxw8
         MePJWLH4GzSXwP5TpK6cDvYSiJ20/lVCHFpDfUUgO2P6d13crx3oxwipzHJGHF7uJqR8
         ZFUyGEer552HXl+dJz4DtcBoJ2gTq3IOKH0np8s/O3syNymY+BI9NARZQ744dlQ6VKP8
         lqvw8H0cQVXYlVjMcGN4Hiy4mzR0xSvyad3L901zV4NJ8xhyJxw3kpNPc12jJa/AE2X1
         8cPiKrpzZVFn1RaWfZYLzisOISoEdBdxuUBhDEf671pJP7Bh0BY3Xh6xHa6GjWHvDKSU
         ha9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795209320; x=1795814120;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jhsdAq68aTOS0woPorboO2Q3We/YdgAlOANjhDh+IIk=;
        b=Cyw8/LRedXsX9tUbcfzTR+fmoQd+dFRMdw/dTS4cVoYm3OKr4Sg/UVsW3uD2zi7Ovc
         SKV5/+ixlQ2WlQDATuzuzwLdWWn9fkCXxwLPg0vsYoRMQhhC+sQcTNPNGO4Tb3nY0oza
         nPOqI20DlTcHkRcnlviRQYD7HXyJkSXhmuUa4SswPrNZjShrJR/SiyZ5GC8rdAhp9kIN
         wMAfRvv9atWihwo+B33rHGUEITJOnWxAVwI09494vyHcE2fTvd7jrk7azlSdI4EJ0+Vc
         cYpQkXlinTF+3NWu/Hm2OT9skyH1wvhyCPWLbqBtYb0uzBYTljcih97tJtF1cAjSUlpg
         2dgg==
X-Forwarded-Encrypted: i=1; AL+hErHpVJPFIb+NKoQFG+9VCNV5VMTs9sVV4eBIrSSbxmDQ4xUUgMLLuzhqx640732L3qxEDy/GyB4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+yQqfv5tJBjsGeBW1Gb/Bnw0x/AwGjw1o+nS/EETsFCvBiwXz9
	SiYQ+gATQfeG8RCDnkmXuqah3kv20yrzyjLiRWSjUhaTNfh4SOnA7Z2p0cr859l7vJ35gwDwaHz
	n2N6APw88f0PA92ABWAlo8dHxePwm8lM=
X-Gm-Gg: AZFdTZcrxJQynYO2E2vKk04D2u6Ab9Sw2lGghwP1FL+g+Bor+14wTI3jzV99SVSxeX1
	u3VX0yDLIYt97fd9ms8oTg9c+MfUg0EH99LT6nkuf22cZoNvDRbeathJL+Ii/jTim9nYG7rPSnu
	gNry6x9R6zEZVHZVtE0XvEPJd3abMInScXNZbiFY0eai9hanve1dKGWsmPqclkR6P8zXJkKgIue
	+roD5S9EXEn93n9L1f6qTIWUgFleqAOvwAA1EZKGT75Pqi1Tw4bxLmhUF61OeetJdM9i7Qz/ALC
	pwZCbyavMjf04tC7xfjuXELri7w1J8yTlsWcdScfoNQyVoWcfF8/3ugKRId/v9agO+4uBWxa8lz
	GW3vt508A7PPERjPqQW2oh2vGOoIjuiNGvPJ9E0jkX8ZBrt6L83lsiw5891B+ZPZh7CVDqw69cK
	JRy/z0ldZFk88t/crUNV49YHFd
X-Received: by 2002:a05:6512:b14:b0:5c1:c4b4:a3e5 with SMTP id
 2adb3069b0e04-5c1c4b4a448mr663384e87.27.1795209320229; Fri, 20 Nov 2026
 13:15:20 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260909210213.946159-1-festevam@gmail.com>
In-Reply-To: <20260909210213.946159-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 20 Nov 2026 18:15:08 -0300
X-Gm-Features: Aa3M54p88NC6g05pV48qVC2p_9ZAScZjtIt_fyZczxzCKvkLyILovNFeQdmLZhk
Message-ID: <CAOMZO5DuwQq_-hMPvpb65drpU40UNWYXQ_ksPW0ACXxaCwOoWw@mail.gmail.com>
Subject: Re: [PATCH] drm/mxsfb: lcdif: Fix use-after-free on unbind
To: marex@denx.de, Luca Ceresoli <luca.ceresoli@bootlin.com>, Liu Ying <victor.liu@nxp.com>
Cc: mripard@kernel.org, imx@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 6:02=E2=80=AFPM Fabio Estevam <festevam@gmail.com> w=
rote:
>
> lcdif allocates its private data, which embeds the CRTC and primary
> plane, and its encoders using devres. These DRM objects are linked into
> the mode_config lists.
>
> Since mode_config cleanup is DRM-managed, it is deferred until the DRM
> device is released. An open DRM file can keep the DRM device alive after
> the platform device has been unbound and devres has freed those objects.
> The later mode_config cleanup then dereferences freed memory.
>
> Allocate the private data with drmm before initializing mode_config so
> that it remains alive until mode_config cleanup has completed. Allocate
> encoders with drmm_plain_encoder_alloc(), which cleans up each encoder
> and removes it from the mode_config list before freeing its memory.
>
> This can be reproduced on i.MX8MP by keeping the DRM card open across an
> LCDIF unbind and closing it afterwards.
>
> Cc: stable@vger.kernel.org
> Fixes: 1c71d925c03a ("drm: lcdif: Switch to drmm_mode_config_init")
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

A gentle ping.



> ---
>  drivers/gpu/drm/mxsfb/lcdif_drv.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/mxsfb/lcdif_drv.c b/drivers/gpu/drm/mxsfb/lc=
dif_drv.c
> index e2173c4d6fc2..7e9f3b205a45 100644
> --- a/drivers/gpu/drm/mxsfb/lcdif_drv.c
> +++ b/drivers/gpu/drm/mxsfb/lcdif_drv.c
> @@ -24,6 +24,7 @@
>  #include <drm/drm_fbdev_dma.h>
>  #include <drm/drm_gem_dma_helper.h>
>  #include <drm/drm_gem_framebuffer_helper.h>
> +#include <drm/drm_managed.h>
>  #include <drm/drm_mode_config.h>
>  #include <drm/drm_module.h>
>  #include <drm/drm_of.h>
> @@ -43,10 +44,6 @@ static const struct drm_mode_config_helper_funcs lcdif=
_mode_config_helpers =3D {
>         .atomic_commit_tail =3D drm_atomic_helper_commit_tail_rpm,
>  };
>
> -static const struct drm_encoder_funcs lcdif_encoder_funcs =3D {
> -       .destroy =3D drm_encoder_cleanup,
> -};
> -
>  static int lcdif_attach_bridge(struct lcdif_drm_private *lcdif)
>  {
>         struct device *dev =3D lcdif->drm->dev;
> @@ -74,19 +71,16 @@ static int lcdif_attach_bridge(struct lcdif_drm_priva=
te *lcdif)
>                                              "Failed to get bridge for en=
dpoint%u\n",
>                                              of_ep.id);
>
> -               encoder =3D devm_kzalloc(dev, sizeof(*encoder), GFP_KERNE=
L);
> -               if (!encoder)
> -                       return dev_err_probe(dev, -ENOMEM,
> -                                            "Failed to allocate encoder =
for endpoint%u\n",
> -                                            of_ep.id);
> -
> -               encoder->possible_crtcs =3D drm_crtc_mask(&lcdif->crtc);
> -               ret =3D drm_encoder_init(lcdif->drm, encoder, &lcdif_enco=
der_funcs,
> -                                      DRM_MODE_ENCODER_NONE, NULL);
> -               if (ret)
> +               encoder =3D drmm_plain_encoder_alloc(lcdif->drm, NULL,
> +                                                  DRM_MODE_ENCODER_NONE,=
 NULL);
> +               if (IS_ERR(encoder)) {
> +                       ret =3D PTR_ERR(encoder);
>                         return dev_err_probe(dev, ret,
>                                              "Failed to initialize encode=
r for endpoint%u\n",
>                                              of_ep.id);
> +               }
> +
> +               encoder->possible_crtcs =3D drm_crtc_mask(&lcdif->crtc);
>
>                 ret =3D drm_bridge_attach(encoder, bridge, NULL, DRM_BRID=
GE_ATTACH_NO_CONNECTOR);
>                 if (ret)
> @@ -131,7 +125,7 @@ static int lcdif_load(struct drm_device *drm)
>         struct lcdif_drm_private *lcdif;
>         int ret;
>
> -       lcdif =3D devm_kzalloc(&pdev->dev, sizeof(*lcdif), GFP_KERNEL);
> +       lcdif =3D drmm_kzalloc(drm, sizeof(*lcdif), GFP_KERNEL);
>         if (!lcdif)
>                 return -ENOMEM;
>
> --
> 2.43.0
>
