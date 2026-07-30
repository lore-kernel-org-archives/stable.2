Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8C837F8DD;
	Thu, 30 Jul 2026 19:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785441042; cv=none; b=QzcfH+HNGfnQHvh7uKNtgofv/+2atzmia7G+PVbP910PB/3s1637HvYQ/XROe0CBKV8yqBzWd1do6QKTkHvCB2I6vjG80xbNUeAVBwZTqmRO1cmjA6BKYuUYEHV0tIl6mZi37utOaKBigfOLqllCjpQbfgG1QxHnCFSXZ8yPaLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785441042; c=relaxed/simple;
	bh=CDQzi7qK+MGW0I1FpfLD8J+mu4Mp6f9WgIwDKn4MXI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzQ6LH9mBhaD48sYvm8sit8boYnXHAZ3Ts+Ziz36haKZA0Y3rvKMnOTjtY7BnmMwexfg7gLQjvO3jwUCAUfkyV7qPvIJKN5d3Otqb0ZkY8kIjKwR45EBc3ZReS1RTliDoBIpn+7jtVhyMa0gTUQij3MQieqJs5y5BHalPTKW6qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=XQbaMcYg; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="XQbaMcYg"
Received: from ideasonboard.com (mob-109-113-25-35.net.vodafone.it [109.113.25.35])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 340718F;
	Thu, 30 Jul 2026 21:49:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1785440972;
	bh=CDQzi7qK+MGW0I1FpfLD8J+mu4Mp6f9WgIwDKn4MXI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XQbaMcYgJfwU6YiaA0kY6vAJfqx6LfP2QtHQbz2wCnQcDuocIvKN2003ZTORXl7ZO
	 NWJakq+2vEK4LJ0h/jSkFJ1Ngwp1nLOutsRVwFYFlaFJwpZwOwAaeNRh8GBftqdgwj
	 uU//gBpJi/N2O0yzEMxlDu2UmnzhlaEJVKfzBciM=
Date: Thu, 30 Jul 2026 21:50:35 +0200
From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: tomm.merciai@gmail.com, linux-renesas-soc@vger.kernel.org, 
	biju.das.jz@bp.renesas.com, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Hans Verkuil <hverkuil+cisco@kernel.org>, Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Sven =?utf-8?Q?P=C3=BCschel?= <s.pueschel@pengutronix.de>, Nas Chung <nas.chung@chipsnmedia.com>, 
	Mehdi Djait <mehdi.djait@linux.intel.com>, Isaac Scott <isaac.scott@ideasonboard.com>, 
	Paul Cercueil <paul@crapouillou.net>, Daniel Scally <dan.scally+renesas@ideasonboard.com>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v5 1/5] media: rzg2l-cru: Align bytesperline to hardware
 DMA stride requirement
Message-ID: <amun-AzHShKFnA7W@zed>
References: <20260729105603.1160966-1-tommaso.merciai.xr@bp.renesas.com>
 <20260729105603.1160966-2-tommaso.merciai.xr@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260729105603.1160966-2-tommaso.merciai.xr@bp.renesas.com>

Hi Tommaso

On Wed, Jul 29, 2026 at 12:55:46PM +0200, Tommaso Merciai wrote:
> The RZ/G3E CRU programs the line stride via the AMnIS register, whose
> IS field encodes the value in units of 128 bytes. If bytesperline is
> not a multiple of 128, the division truncates and the hardware uses a
> wrong stride, causing horizontal banding.
>
> Commit ace92ccef0c9 ("media: platform: rzg2l-cru: Use v4l2_fill_pixfmt()")
> replaced the open-coded aligned calculation with v4l2_fill_pixfmt(),
> which sets no alignment, reintroducing the issue.
>
> Round bytesperline up to RZG2L_CRU_STRIDE_ALIGN and recompute
> sizeimage when info->has_stride is set. RZ/G2L has no AMnIS register
> and keeps the values from v4l2_fill_pixfmt() unchanged.
>
> Fixes: ace92ccef0c9 ("media: platform: rzg2l-cru: Use v4l2_fill_pixfmt()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> ---
> v4->v5:
>  - New patch.
>
>  drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
> index 5185a547461d..91eda5034248 100644
> --- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
> +++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
> @@ -851,6 +851,11 @@ static void rzg2l_cru_format_align(struct rzg2l_cru_dev *cru,
>
>  	v4l2_fill_pixfmt(pix, pix->pixelformat, pix->width, pix->height);
>
> +	if (info->has_stride) {
> +		pix->bytesperline = ALIGN(pix->bytesperline, RZG2L_CRU_STRIDE_ALIGN);
> +		pix->sizeimage = pix->bytesperline * pix->height;
> +	}
> +

Ack! I think this does what is expected for the single planar formats
the CRU supports!

I think after this cycle you could send a patch to replace the above
back-portable change with the usage of v4l2_fill_pixfmt_aligned().

When you do so, could you consider, replacing "has_stride" with a per
struct rzg2l_cru_info .stride field ?

I think it would look nicer as you could here unconditionally align
(assuming the new .stride will be set to 1 for G2L which currently has
.has_stride = 0).

Also, RZG2L_CRU_STRIDE_ALIGN is a bit of a mis-nomer, as only G3E and
V2H has a AMnIS register and alignments constraints as far as I see.

The only other user of 'has_stride' I see is:

 rzg2l_cru_initialize_axi()

	if (info->has_stride) {
		u32 stride = cru->format.bytesperline;
		u32 amnis;

		stride /= RZG2L_CRU_STRIDE_ALIGN;
		amnis = rzg2l_cru_read(cru, AMnIS) & ~AMnIS_IS_MASK;
		rzg2l_cru_write(cru, AMnIS, amnis | AMnIS_IS(stride));
	}

the G2L has no register AMnIS, so we can't write it unconditionally
but rather replace the check with:

        if (info->stride > 1)

As a bonus, if any other variant will get a different stride, it will
be automatically supported.

What do you think ?

In the meantime for this patch
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>

Thanks
  j


>  	dev_dbg(cru->dev, "Format %ux%u bpl: %u size: %u\n",
>  		pix->width, pix->height, pix->bytesperline, pix->sizeimage);
>  }
> --
> 2.54.0
>
>
