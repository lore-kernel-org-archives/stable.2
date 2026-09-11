Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17951A3160;
	Fri, 11 Sep 2026 14:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789136877; cv=none; b=tVSKT6kYcYeVtEl9lu0H3hgHwp6cwTe7AYIwQifMYhafY6giR82kWs/f3xHjS3I15oE+MbyQdQ7n33hfTmKCviYiTXSwyKaIYulqoD6Yt/LvXW93xHiYpKUKmoDzn0qLGWN7KwDYHxYXZ/54C7Z2Dbh2TSfPtehbSalY0bzHZXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789136877; c=relaxed/simple;
	bh=WzVA3xuZ5JdDGBqQbjJVlTNBllbYsKRQWabRga5ERUE=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=b5GyU4q2mQskvc8L2SMzA9r4IuQUWUeve5kEFgdxqz/HuTO7B5iBvLSvGcQ+0bwKI3eFnBMDhCzMjWWypYa6pRYyDL6hFNzw2Lla1RY7HeyUbyP1aR7u/38DORDuO4GQp4ExG1e4qSUfC//XAp68cQzK6tYFNoP6s579iEAWBcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=bx7OnAGr; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="bx7OnAGr"
Received: from monstersaurus.ideasonboard.com (cpc89244-aztw30-2-0-cust6594.18-1.cable.virginm.net [86.31.185.195])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8510663C;
	Fri, 11 Sep 2026 16:26:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1789136775;
	bh=WzVA3xuZ5JdDGBqQbjJVlTNBllbYsKRQWabRga5ERUE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=bx7OnAGre7KGRBkMjaytz3CoYbubcRbmabeSbTGp8hvXheaK6MZeL8YAqHLSkp6A8
	 bfKDFS6ZTNCkZKeVzsLJiCafbH+E+8Eu+c7SYGvIxU1EFElpCX3z/96SktdqYHUiMz
	 hL3/Ca78PdXrtLWp+crCNB4HLF+GCv9oBxX9xnTk=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260911-imx8mp-demosaicing-bypass-v1-1-5568a7a560a6@ideasonboard.com>
References: <20260911-imx8mp-demosaicing-bypass-v1-1-5568a7a560a6@ideasonboard.com>
Subject: Re: [PATCH] media: rkisp1: Fix Bayer demosaicing bypass
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
To: Dafna Hirschfeld <dafna@fastmail.com>, Heiko Stuebner <heiko@sntech.de>, Jacopo Mondi <jacopo.mondi@ideasonboard.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Paul Elder <paul.elder@ideasonboard.com>, Sakari Ailus <sakari.ailus@linux.intel.com>
Date: Fri, 11 Sep 2026 15:27:50 +0100
Message-ID: <178913687012.1723501.3167773155478207003@ping.linuxembedded.co.uk>
User-Agent: alot/0.9.1

Quoting Jacopo Mondi (2026-09-11 14:56:19)
> The RKISP1_CIF_ISP_DEMOSAIC_BYPASS bit, when set, bypasses the
> demosaicing block on the RkISP1 ISP.
>=20
> The current implementation however clears the bit when demosaicing
> have to be bypassed and sets it when demosaicing has to be enabled,
> effectively inverting the bypass bit handling logic.

Ouch.

> Fix this by setting the bypass bit when disabling the demosaicing block,
> and by clearing it instead when demosaicing has to be performed.
>=20
> The issue never manifested itself as libcamera hasn't an algorithm
> to control Bayer demosaicing bypass yet.
>=20
> Fixes: 6c53a7b68c5d ("media: rkisp1: Implement extensible params support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
> ---
> media: rkisp1: Fix demosaicing bypass
> ---
>  drivers/media/platform/rockchip/rkisp1/rkisp1-params.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-params.c b/dri=
vers/media/platform/rockchip/rkisp1/rkisp1-params.c
> index 042b759eba62..496381962f1b 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-params.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-params.c
> @@ -1854,8 +1854,8 @@ rkisp1_ext_params_bdm(struct rkisp1_params *params,
>         const struct rkisp1_ext_params_bdm_config *bdm =3D &block->bdm;
> =20
>         if (bdm->header.flags & RKISP1_EXT_PARAMS_FL_BLOCK_DISABLE) {
> -               rkisp1_param_clear_bits(params, RKISP1_CIF_ISP_DEMOSAIC,
> -                                       RKISP1_CIF_ISP_DEMOSAIC_BYPASS);
> +               rkisp1_param_set_bits(params, RKISP1_CIF_ISP_DEMOSAIC,
> +                                     RKISP1_CIF_ISP_DEMOSAIC_BYPASS);
>                 return;
>         }
> =20
> @@ -1863,8 +1863,8 @@ rkisp1_ext_params_bdm(struct rkisp1_params *params,
> =20
>         if ((bdm->header.flags & RKISP1_EXT_PARAMS_FL_BLOCK_ENABLE) &&
>             !(params->enabled_blocks & BIT(bdm->header.type)))
> -               rkisp1_param_set_bits(params, RKISP1_CIF_ISP_DEMOSAIC,
> -                                     RKISP1_CIF_ISP_DEMOSAIC_BYPASS);
> +               rkisp1_param_clear_bits(params, RKISP1_CIF_ISP_DEMOSAIC,
> +                                       RKISP1_CIF_ISP_DEMOSAIC_BYPASS);


I think this also opens us up to add mono formats as explicitly
supported by the ISP and potentially set the demosaic defaulting to off
in that instance?

Anyway, Looks sane to me in this order.

Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

>  }
> =20
>  static void
>=20
> ---
> base-commit: 27953c044974baf7e24dee3e9342fe0103dea80c
> change-id: 20260911-imx8mp-demosaicing-bypass-bb284d9cca60
>=20
> Best regards,
> -- =20
> Jacopo Mondi <jacopo.mondi@ideasonboard.com>
>
