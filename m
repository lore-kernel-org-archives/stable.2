Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B549446BE9;
	Mon, 20 Jul 2026 17:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784569208; cv=none; b=i/vZPGYwO3VdGEEG7si4dZIqNNS7EXvqiOiHRj7HS+wnS3Q3uaUkuMbZh4PQZxUVEHFb2hmmAgTDZ8nTaToLyZYjTRSu6GHhFaIuU1FpgfBUnsQ0FnpUcF35oJnPI93KbdwhT50fJgb676h5M947LS732l/VLb/mdPngIkzFwa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784569208; c=relaxed/simple;
	bh=e5OrRvxSiFTa/QC9cW29fVTOig3L9LCGIe18h8M+WF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ToXLFuXAnTJGo+5aBk+kLIbqDPGqr2YK09QXJ2RkKj8aipo3syD0WeGyxv4RS2tyYcYthfJuSY1c2eb4hUt8YH4uxuCHQv+Cphpx/6zttZ3cG5zMtzNwhiNYrgSUAqJ7i5brsV+rvPrWFSEJPvjsvkqJOtBR129rXTysHz6sG9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=lgCPsP91; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="lgCPsP91"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 42292289;
	Mon, 20 Jul 2026 19:39:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1784569145;
	bh=e5OrRvxSiFTa/QC9cW29fVTOig3L9LCGIe18h8M+WF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lgCPsP91d7hkqCuMK8yrsy8hrbbKGZAqer2zMO7QBSMdSuh6Ea3eub82Tk2We03fe
	 sUtlMsf6UTVx45Bv/i2WffIvAA5eq4LyFdcr/vg/UiL2G/pu6X2qoNTjsow1Ko9KZ+
	 vz4NHCeF2tcp5bV6UHmixL+JBx0ExQSaiIGOPPpI=
Date: Mon, 20 Jul 2026 20:40:02 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Christian Hemp <c.hemp@phytec.de>,
	Stefan Riedmueller <s.riedmueller@phytec.de>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Bryan O'Donoghue <bod@kernel.org>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Guoniu Zhou <guoniu.zhou@nxp.com>, linux-media@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 5/6] media: nxp: imx8-isi: Correct color map between
 V4L2 and ISI
Message-ID: <20260720174002.GC50424@killaraus.ideasonboard.com>
References: <20260720-isi-v2-0-45845bc5d4fa@oss.nxp.com>
 <20260720-isi-v2-5-45845bc5d4fa@oss.nxp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260720-isi-v2-5-45845bc5d4fa@oss.nxp.com>

Hi Guoniu,

On Mon, Jul 20, 2026 at 11:34:07AM +0800, Guoniu Zhou wrote:
> Fix the ISI input format for the color map V4L2_PIX_FMT_XBGR32 in
> memory-to-memory mode.
> 
> Fixes: cf21f328fcaf ("media: nxp: Add i.MX8 ISI driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guoniu Zhou <guoniu.zhou@oss.nxp.com>

Tentatively,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

I'm running a build to test this change.

> ---
> Changes in v2:
> - Reword commit description for clarity (Frank Li)
> ---
>  drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c
> index 5eb448f4c26f..05b51b98344b 100644
> --- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c
> +++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c
> @@ -151,7 +151,7 @@ static const struct mxc_isi_format_info mxc_isi_formats[] = {
>  		.fourcc		= V4L2_PIX_FMT_XBGR32,
>  		.type		= MXC_ISI_VIDEO_CAP | MXC_ISI_VIDEO_M2M_OUT
>  				| MXC_ISI_VIDEO_M2M_CAP,
> -		.isi_in_format	= CHNL_MEM_RD_CTRL_IMG_TYPE_XBGR8,
> +		.isi_in_format	= CHNL_MEM_RD_CTRL_IMG_TYPE_XRGB8,
>  		.isi_out_format	= CHNL_IMG_CTRL_FORMAT_XRGB888,
>  		.mem_planes	= 1,
>  		.color_planes	= 1,

-- 
Regards,

Laurent Pinchart
