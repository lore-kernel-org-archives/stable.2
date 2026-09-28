Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A37E4FD28C
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 23:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790638134; cv=none; b=cVnrnAxF0m09sqx8Wnb8cciTcJE0VIPcjYcY49tMulE6gqEdkcuvPLKiJyV/T/M7S9K9hktU/29pBkSfdL3BuM45FkMWa44BwYm434FknlfPw87WMAxM82J3p1BDCKbyFREdgsA0jkYfVFJrX5LiNac3pZzo12/sLe8wER3Xbl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790638134; c=relaxed/simple;
	bh=E1RDqU0eTYft3tprCUGhUuNzGlnY7RUwVZlUVJ4GvXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FLwq+Kr3iFEsyuSYO04dOPse3Fc4erkjw1I3iai5LuIJiautJdqiSQFL900UlFNMPx3CQWliEth5KsSXmTHGfFZGVJbMYtqKiu954kN6g3a2aT4U1Xuldcxbixfjx/R0dz9seXdNNcl7nNxvV+WroTUKj2LSEWPWwCfjV+FhIs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlR20X4u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlR20X4u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D3D1F000FF
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 23:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790638133;
	bh=jfNrPFE2/IENfsII90Vt8A6OX76G8R6ZgvMpj6jZeww=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=SlR20X4u9vAyQFfMO92S47QUK9yBB+P7gG41NknqY/af6wpl4Hm/J0ra67LtDoSOQ
	 l/lqYoBHTv9xFC9u8u8MCgosK2Uq3gFezKU11wts4PZajg5JY15YmefbgHZvIAA+iV
	 mZ4839MQbl7MSXEr1Kg5aU0GZbG4Qq0ahNMT/bIpLIyPqzcq2NSj0vtDym5yz6eB/3
	 tMWwJbj8RZW1ptEWS3F/76DFUD/VYDn118KSA3LfSuM1YK+D5fU8/opP8Uz1NEWSt4
	 VhaZ62p9hu6UbyLukHnfM17AgI5o1es/AmU2J0Ny1UKnkGUThgKC3k1vNp/RpMXFZ0
	 CQdKKYncXD9Iw==
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-328664c2da6so3068623eec.1
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 16:28:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByI6Dyvx6UXxQbrmvb5iMXeeUrlvpqotMDEyU3ZexrC5EBy0hAP2yg3JZfr/0n9w6LOp9FNNkw=@vger.kernel.org
X-Gm-Message-State: AFuF++kbBxdyo9W/UK4Mov67qHc0m9Fgtgxs7mvXWSYAPYu/SJlp0ce/
	CrA9Pn8X/GCljJ4it3rBtigoVEYpxuIJ0mSevN6WPSJUCX7RIksDvIo7jJYyJGy42aqbOVPW2TZ
	xpJsumuJ/ltqfx0hzuB/3v1SSAPxdEw==
X-Received: by 2002:a05:701b:4314:b0:143:50a0:56d6 with SMTP id
 a92af1059eb24-146cdfbe26dmr10687171c88.7.1790638132459; Mon, 28 Sep 2026
 16:28:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7a3cbf55bf6a97835ee426eb38c34b2c153437eb.camel@mediatek.com> <20260825100845.438893-1-lihaojie@kylinos.cn>
In-Reply-To: <20260825100845.438893-1-lihaojie@kylinos.cn>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Tue, 29 Sep 2026 07:30:47 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-yXPCDQT4b2s6hEDDQ3Wa-x8bttg136MaZVqtgAs3Nsg@mail.gmail.com>
X-Gm-Features: AclHuK8HNY3IA0QITI8piNzSYqjyY4DjhKThRjLr8iy4Knqan-haBW6sZ5vbbc0
Message-ID: <CAAOTY_-yXPCDQT4b2s6hEDDQ3Wa-x8bttg136MaZVqtgAs3Nsg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/mediatek: Add missing IS_ERR check for ovl_adaptor
 platform device
To: Haojie Li <lihaojie@kylinos.cn>
Cc: ck.hu@mediatek.com, chunkuang.hu@kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, p.zabel@pengutronix.de, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Haojie Li <lihaojie@kylinos.cn> =E6=96=BC 2026=E5=B9=B48=E6=9C=8825=E6=97=
=A5=E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=886:09=E5=AF=AB=E9=81=93=EF=BC=9A
>
> platform_device_register_data() can fail and return an ERR_PTR, but the
> return value is used without checking, leading to an invalid pointer
> being stored in ddp_comp[].dev and passed to component_match_add() and
> mtk_ddp_comp_init(), which could result in a kernel crash.
>
> Add an IS_ERR() check to jump to the error handling path on failure.

Applied to mediatek-drm-fixes [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-fixes

Regards,
Chun-Kuang.

>
> Fixes: 0d9eee9118b7 ("drm/mediatek: Add drm ovl_adaptor sub driver for MT=
8195")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haojie Li <lihaojie@kylinos.cn>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index c86a3f54f35b..b281482ab8c8 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -1112,6 +1112,9 @@ static int mtk_drm_probe(struct platform_device *pd=
ev)
>                                                             PLATFORM_DEVI=
D_AUTO,
>                                                             (void *)priva=
te->mmsys_dev,
>                                                             sizeof(*priva=
te->mmsys_dev));
> +               if (IS_ERR(ovl_adaptor))
> +                       return PTR_ERR(ovl_adaptor);
> +
>                 private->ddp_comp[DDP_COMPONENT_DRM_OVL_ADAPTOR].dev =3D =
&ovl_adaptor->dev;
>                 mtk_ddp_comp_init(dev, NULL, &private->ddp_comp[DDP_COMPO=
NENT_DRM_OVL_ADAPTOR],
>                                   DDP_COMPONENT_DRM_OVL_ADAPTOR);
> --
> 2.25.1
>
