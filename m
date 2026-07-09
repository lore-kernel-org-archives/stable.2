Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6573EFD00;
	Thu,  9 Jul 2026 09:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783588764; cv=none; b=jPvAURElufPYKTE19ZZonOh9CwXB+Fa9CelKGf0/WTHekUJGWfrXL9G7DVQeZZnhsodWB8H+w0Ltuod9QkriJ1VawcF6R0IYUS1jgGsJCk+DYIAvU9MincrQvlDVo+vsARdMXTxQxI4z8c02a50gUxGSxM6GdwGc/25RMi5RkJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783588764; c=relaxed/simple;
	bh=ObYn3QHNk0BaSBgjNqJ4Ke8AwT1WjdDdSK5Cm7ewbMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=digSwj2mOc0X7QzI3x9WW15F7qKZqznUfqJH3L+324CwQwBIqmJ24Ib9D0XjFK6T8n1COQsUMIe1RmeIOUaWAIXw1ODkRLme1CAwVgbL29+uZFM1Z33esRsj8RGcaDCnmUdVnCoMVkgWtFTGU8y2hDwwikSZN2jg9LsD5hNn5Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=TWXZTFYP; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="TWXZTFYP"
Received: from ideasonboard.com (net-93-65-100-155.cust.vodafonedsl.it [93.65.100.155])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 44D62448;
	Thu,  9 Jul 2026 11:18:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1783588710;
	bh=ObYn3QHNk0BaSBgjNqJ4Ke8AwT1WjdDdSK5Cm7ewbMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TWXZTFYPaBXjQhPavjeqnF9OsD7IM88r6HZmdfWhXZUTIa0+/eD8tYqMnTe+j6Ajq
	 oaxyI+p0ZksndRta+8EAcojz7V9bYCraCxPKXQxBwVQa/fThhKKemaN402ty5JoyxT
	 MAaiM+/H64K2W+3lqIj0AUuIpoHfGuKCjoK7XRcg=
Date: Thu, 9 Jul 2026 11:19:17 +0200
From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: tomm.merciai@gmail.com, linux-renesas-soc@vger.kernel.org, 
	biju.das.jz@bp.renesas.com, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Hans Verkuil <hverkuil+cisco@kernel.org>, Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mehdi Djait <mehdi.djait@linux.intel.com>, Sven =?utf-8?Q?P=C3=BCschel?= <s.pueschel@pengutronix.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Isaac Scott <isaac.scott@ideasonboard.com>, 
	Paul Cercueil <paul@crapouillou.net>, Daniel Scally <dan.scally+renesas@ideasonboard.com>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3 4/4] media: rzg2l-cru: Align bytesperline to hardware
 DMA stride requirement
Message-ID: <ak9l33lrocjxj1Gd@zed>
References: <20260708161406.396183-1-tommaso.merciai.xr@bp.renesas.com>
 <20260708161406.396183-5-tommaso.merciai.xr@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260708161406.396183-5-tommaso.merciai.xr@bp.renesas.com>

Hi Tommaso

On Wed, Jul 08, 2026 at 06:14:05PM +0200, Tommaso Merciai wrote:
> The RZ/G3E CRU programs the line stride via the AMnIS register, whose
> IS field encodes the value in units of 128 bytes. If bytesperline is

Unrelated, it seems for RGB888 the alignemtn requirement is 384 bytes,
something that doesn't seem handled at the moment ?

> not a multiple of 128, the division truncates and the hardware uses a
> wrong stride, causing horizontal banding.
>
> Commit ace92ccef0c9 ("media: platform: rzg2l-cru: Use v4l2_fill_pixfmt()")
> replaced the open-coded aligned calculation with v4l2_fill_pixfmt(),
> which sets no alignment, reintroducing the issue.
>
> Switch to v4l2_fill_pixfmt_aligned() with RZG2L_CRU_STRIDE_ALIGN when
> info->has_stride is set. RZ/G2L has no AMnIS register and keeps using
> v4l2_fill_pixfmt() unchanged.
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Cc: stable@vger.kernel.org
> Fixes: ace92ccef0c9 ("media: platform: rzg2l-cru: Use v4l2_fill_pixfmt()")
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> ---
> v2->v3:
>  - No changes.
>
> v1->v2:
>  - Collected tag
>  - Add missing Cc stable
>  - Fix s/commit/Commit/ into commit body
>
>  drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
> index 69346a585f9f..478264f26466 100644
> --- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
> +++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
> @@ -860,7 +860,8 @@ static void rzg2l_cru_format_align(struct rzg2l_cru_dev *cru,
>  	v4l_bound_align_image(&pix->width, 320, info->max_width, 1,
>  			      &pix->height, 240, info->max_height, 0, 0);

This doesn't apply on media-committers/next which has

	v4l_bound_align_image(&pix->width, 320, info->max_width, 1,
			      &pix->height, 240, info->max_height, 2, 0);

in this line.

What have I missed ?

>
> -	v4l2_fill_pixfmt(pix, pix->pixelformat, pix->width, pix->height);
> +	v4l2_fill_pixfmt_aligned(pix, pix->pixelformat, pix->width, pix->height,
> +				 info->has_stride ? RZG2L_CRU_STRIDE_ALIGN : 1);

Rebasing apart, this seems correct

Reviewed-by: Jacopo Mondi <jacopo.mondi+renesas@ideasonboard.com>

Thanks
  j

>
>  	dev_dbg(cru->dev, "Format %ux%u bpl: %u size: %u\n",
>  		pix->width, pix->height, pix->bytesperline, pix->sizeimage);
> --
> 2.54.0
>
>
