Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425483B7B71
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 23:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790896906; cv=none; b=uAVkNoXz0ZYTQgsgKeJI9yt0dS+BHU+a1dXy9YWX2mD7iUrRHHWwWcEd4KMOUKyalNLSaJX0c5hPEm+7y6gaSzd0WzJJt3HcX3pyHfQ7N7SaKE2t3d6vE3k7islDP5/0T2EDxEPVDnkSvtKY8mJrlf3EDfKrKv+hBYvD3/1CHs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790896906; c=relaxed/simple;
	bh=GzPxDp3XcZtoaRjEH8ZVHGvfgC8sY3XjnO0Q01ZZ/Dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=otCZphfB2qDgsupSzDag1uCHrOJHgvLPxTsMxV4pteOv83m3QU1xhBAq37bXtLR+bNCu7K5E79Ae1l+A0s4BdlEVphR27UIN5S0PfOenmO/JThYs9IUtEVA+pY/u97ektSRqftOQoLo8jce4/ZJZnscqK0ovTRILSRUdYXzrWb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Paq0/jFc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Paq0/jFc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB5CD1F00898
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 23:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790896905;
	bh=P2Ct0/bWmZg0045LkT8XFFR+cuxnWwmmUDTjfb+QZ+I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Paq0/jFcHy1N3vQSR8Ap+EoYMiP/a2ijfiCc9AnRW0aIMmF/yssXWVjTz0R7dmwAS
	 oyvLjnvaTsqQyeXa0HQZqrwUnY3BP/Z/uSw01UUZ++gFQR9owLmLfqODsKIYMl7FAO
	 zgQ+h/YxN/USSE5g52BNd5yf3Ld8gESl4qqr138TvCzKkNQkomMYGhTcpm7qHIA0Gk
	 e+VoZM2vAU3yC2h3G21hPsgm7zGqn18P8UJJMyAsKGh44nVvQKq0KOUb1/k5eMdEbb
	 2xTIy+IXPnIzq5xRHjN7G4ZlF49Iqfhh6k58p12bEAdrHloqkvBlEEb1ZpBoYxP+vX
	 8aa9vJ/YHnrpQ==
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144ecebb6cbso2615441c88.3
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 16:21:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzulzJN9WHXdgNijpVkR1EmeH2f2lxK4np/gIMRcIFfg8sIrgQojVfrxzruwpZY1mR5nf1BX64=@vger.kernel.org
X-Gm-Message-State: AFuF++nB+m86Xq4TuvZN+tP7jc3mAEG7NdqILlDrlzWQ+gcU9e6ahJFr
	thvhBY7H8kIaRG8HdFy+FOPYnXnLJbXlJTNc6Gp3pEWItfpmqre+SVIKGrOQeHtg/5UcT2VyjTT
	dd4koaHkDmDD3G8vTSgSMaPv00/H5kg==
X-Received: by 2002:a05:7022:f515:b0:143:297c:82e0 with SMTP id
 a92af1059eb24-14f5bffa779mr757615c88.32.1790896904343; Thu, 01 Oct 2026
 16:21:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921131156.403652-1-lgs201920130244@gmail.com>
In-Reply-To: <20260921131156.403652-1-lgs201920130244@gmail.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Thu, 1 Oct 2026 23:21:30 +0000
X-Gmail-Original-Message-ID: <CAAOTY__kLYfpbyD+nQOmdGPu8Qm_aC5BjsOQzYGVnQvD0WGP_Q@mail.gmail.com>
X-Gm-Features: AclHuK-E9VLgmUd_-lnnf9Q-aBBowJwr-pxvO9-FXnzpDzOztdORiwXC2sJecYk
Message-ID: <CAAOTY__kLYfpbyD+nQOmdGPu8Qm_aC5BjsOQzYGVnQvD0WGP_Q@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: fix ovl adaptor platform device leak
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	"Nancy.Lin" <nancy.lin@mediatek.com>, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Guangshuo:

Guangshuo Li <lgs201920130244@gmail.com> =E6=96=BC 2026=E5=B9=B49=E6=9C=882=
1=E6=97=A5=E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=881:12=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> mtk_drm_probe() creates an OVL adaptor platform device with
> platform_device_register_data() when the display pipeline requires the
> OVL adaptor.
>
> If a later initialization step fails, the probe error path releases
> the DRM resources without unregistering the already registered OVL
> adaptor device. The normal remove path likewise leaves the device
> registered after the DRM driver is unbound.
>
> Keep track of whether the OVL adaptor was successfully registered and
> unregister it on probe failure. Also recover the platform device from
> the stored DDP component device and unregister it during normal
> removal.
>
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.

Applied to mediatek-drm-fixes [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-fixes

Regards,
Chun-Kuang.

>
> Fixes: 0d9eee9118b7 ("drm/mediatek: Add drm ovl_adaptor sub driver for MT=
8195")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index c86a3f54f35b..d176e6496aa7 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -1060,7 +1060,7 @@ static int mtk_drm_probe(struct platform_device *pd=
ev)
>         struct mtk_mmsys_driver_data *mtk_drm_data;
>         struct device_node *node;
>         struct component_match *match =3D NULL;
> -       struct platform_device *ovl_adaptor;
> +       struct platform_device *ovl_adaptor =3D NULL;
>         int ret;
>         int i;
>
> @@ -1205,6 +1205,8 @@ static int mtk_drm_probe(struct platform_device *pd=
ev)
>  err_pm:
>         pm_runtime_disable(dev);
>  err_node:
> +       if (ovl_adaptor)
> +               platform_device_unregister(ovl_adaptor);
>         of_node_put(private->mutex_node);
>         for (i =3D 0; i < DDP_COMPONENT_DRM_ID_MAX; i++)
>                 of_node_put(private->comp_node[i]);
> @@ -1214,9 +1216,15 @@ static int mtk_drm_probe(struct platform_device *p=
dev)
>  static void mtk_drm_remove(struct platform_device *pdev)
>  {
>         struct mtk_drm_private *private =3D platform_get_drvdata(pdev);
> +       struct device *ovl_adaptor_dev;
>         int i;
>
> +       ovl_adaptor_dev =3D
> +               private->ddp_comp[DDP_COMPONENT_DRM_OVL_ADAPTOR].dev;
> +
>         component_master_del(&pdev->dev, &mtk_drm_ops);
> +       if (ovl_adaptor_dev)
> +               platform_device_unregister(to_platform_device(ovl_adaptor=
_dev));
>         pm_runtime_disable(&pdev->dev);
>         of_node_put(private->mutex_node);
>         for (i =3D 0; i < DDP_COMPONENT_DRM_ID_MAX; i++)
> --
> 2.43.0
>
