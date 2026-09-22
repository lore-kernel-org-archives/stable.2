Received: from sender5-op-o12.zoho.com (sender5-op-o12.zoho.com [165.173.182.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD8E54146E;
	Tue, 22 Sep 2026 12:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790081481; cv=pass; b=bQrP4olxBr/RPIxlMdIM5+vOAqzRH2cPE0Re7VSuvMtOTo9Wa/ityDEWRQo6HgiqnMERMNrhFmjkQDZ7SjeQrnjiFqdyyDVAcb65nM2DYjBbn+78ew6qxyMQcVwv3Q20RbTNLXcBeFFTy2wasy4qZMmUWF+LxtrBf6vQrZGfQcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790081481; c=relaxed/simple;
	bh=CTwaTAUyeqGLemO19yZ/xNgJYa61MdlyRw20ocJaVA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WPjAcNVBzCRY+nfG/Ckv7x0/yS8EzPJ1kxvVhq8+zp+PtIbjOUkw6CHyJnh/lqhM4Iy8JrIb0PN8hM8IsNRFd6RI0cWaIPykIfwZEkQDRTeuEsk8iodcb2X8oHCLfm+KUGCdaQfdYrZqjg0j3aZMAAbKGWnsaXoJTz7Ujn06N1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=IvzuFxMQ; arc=pass smtp.client-ip=165.173.182.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="IvzuFxMQ"
ARC-Seal: i=1; a=rsa-sha256; t=1790081455; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nk34UYnYNbiNUe7h4i5/S6EGbJ8f5dJeQru1ULf9s3oEB1nyzAig2rUIrBbdHeVErR2YOSiVc4ugtIUE2OyC4zGi68C5DLyPZ2K4k7jT8Y+b+MgKEhdB96r/sU074Z4OjbDJOFADq+4Wn7bMTrtb8bI7IRHingVk+xX0HNlXU94=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1790081455; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=729x9mq+5Jmo3wfVIGA83MaaAz3TTKhCqc6Bkj++2Fk=; 
	b=XAQ1pvFubGt2sgI5ya59IIelRMYO+WsLVxcorNPHUUVSzGIJJydavCrPc24CtPdZOsjTC07M9bnO+OOmkeKCvJ+ikq1JsvreKKbtCfwGZv0d0xX3MuoY8a4yYR54PM2tWHq8SukH9dzjpVjNTw+uh8JeL9I4EpGk7PetB+qZ3t4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790081455;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=729x9mq+5Jmo3wfVIGA83MaaAz3TTKhCqc6Bkj++2Fk=;
	b=IvzuFxMQ4zWGthmrST+dpQ2ol/CsautIjd/zPCFIqX7KxbNpVqYrQUUKrC9hg7Ff
	vpH9t/XNPGT86OwWGFqPCE3sYGj0+HiDpR+v6jyULbzQfWNBdSNRx+9lquBMlwknh0g
	/Jb20nBBVoLTee2bQJpTk7dTFpXQTpaJhbiYt8zw=
Received: by smtp.zohomail.com with SMTPS id 1790081453988752.6700177035126;
	Tue, 22 Sep 2026 05:50:53 -0700 (PDT)
Message-ID: <0c358f7e-61b5-46ea-aad8-6671e3924dda@collabora.com>
Date: Tue, 22 Sep 2026 15:50:49 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] media: synopsys: hdmirx: fetch colordepth before
 calculating pixelclock
To: Sascha Hauer <s.hauer@pengutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Shreeya Patel <shreeya.patel@collabora.com>,
 Hans Verkuil <hverkuil@kernel.org>, Dingxian Wen <shawn.wen@rock-chips.com>
Cc: linux-media@vger.kernel.org, kernel@collabora.com,
 linux-kernel@vger.kernel.org, Lucas Sinn <lucas.sinn@wolfvision.net>,
 stable@vger.kernel.org
References: <20260921-hdmirx-fixes-v1-0-495be0beaf93@pengutronix.de>
 <20260921-hdmirx-fixes-v1-1-495be0beaf93@pengutronix.de>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260921-hdmirx-fixes-v1-1-495be0beaf93@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 9/21/26 10:15, Sascha Hauer wrote:
> From: Lucas Sinn <lucas.sinn@wolfvision.net>
> 
> hdmirx_get_detected_timings() divides the TMDS clock by
> hdmirx_dev->color_depth, but nothing on its own path ever sets it. The
> only producer is hdmirx_get_colordepth(), reached solely from
> hdmirx_format_change() at the tail of hdmirx_wait_signal_lock().
> 
> VIDIOC_QUERY_DV_TIMINGS does not come through there. It only refuses to
> proceed while signal_not_lock() is true, and that reads the lock state
> straight out of the hardware, so it can already be false while the work
> ending in hdmirx_format_change() has yet to run. Query the timings in
> that window, on the first lock after a boot, and color_depth is still
> zero from devm_kzalloc().
> 
> The division does not fault. do_div() is plain C on 64 bit and arm64
> compiles it to udiv, which returns zero for a zero divisor. What comes
> out is a pixelclock of zero, and a stitched output frame.
> 
> Read the colordepth where it is used instead.
> 
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Lucas Sinn <lucas.sinn@wolfvision.net>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Fixes: 7b59b132ad43 ("media: platform: synopsys: Add support for HDMI input driver")
> Cc: stable@vger.kernel.org
> ---
>  .../media/platform/synopsys/hdmirx/snps_hdmirx.c   | 71 +++++++++++-----------
>  1 file changed, 36 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c b/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c
> index 25f8ca0d6d946..24ec6138a1fb6 100644
> --- a/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c
> +++ b/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c
> @@ -156,7 +156,6 @@ struct snps_hdmirx_dev {
>  	int num_clks;
>  	u32 edid_blocks_written;
>  	u32 cur_fmt_fourcc;
> -	u32 color_depth;
>  	spinlock_t rst_lock; /* to lock register access */
>  	u8 edid[EDID_NUM_BLOCKS_MAX * EDID_BLOCK_SIZE];
>  };
> @@ -380,6 +379,38 @@ static void hdmirx_toggle_polarity(struct snps_hdmirx_dev *hdmirx_dev)
>  			   VPROC_HSYNC_POL_OVR_EN, 0);
>  }
>  
> +static u32 hdmirx_get_colordepth(struct snps_hdmirx_dev *hdmirx_dev)
> +{
> +	struct v4l2_device *v4l2_dev = &hdmirx_dev->v4l2_dev;
> +	u32 val, color_depth_reg, color_depth;
> +
> +	val = hdmirx_readl(hdmirx_dev, DMA_STATUS11);
> +	color_depth_reg = (val & HDMIRX_COLOR_DEPTH_MASK) >> 3;
> +
> +	switch (color_depth_reg) {
> +	case 0x4:
> +		color_depth = 24;
> +		break;
> +	case 0x5:
> +		color_depth = 30;
> +		break;
> +	case 0x6:
> +		color_depth = 36;
> +		break;
> +	case 0x7:
> +		color_depth = 48;
> +		break;
> +	default:
> +		color_depth = 24;
> +		break;
> +	}
> +
> +	v4l2_dbg(1, debug, v4l2_dev, "%s: color_depth: %d, reg_val:%d\n",
> +		 __func__, color_depth, color_depth_reg);
> +
> +	return color_depth;
> +}
> +
>  /*
>   * When querying DV timings during preview, if the DMA's timing is stable,
>   * we retrieve the timings directly from the DMA. However, if the current
> @@ -393,7 +424,7 @@ static int hdmirx_get_detected_timings(struct snps_hdmirx_dev *hdmirx_dev,
>  	struct v4l2_bt_timings *bt = &timings->bt;
>  	u32 val, tmdsqpclk_freq, pix_clk;
>  	unsigned int num_retries = 0;
> -	u32 field_type, deframer_st;
> +	u32 field_type, deframer_st, color_depth;
>  	u64 tmp_data, tmds_clk;
>  	bool is_dvi_mode;
>  	int ret;
> @@ -414,10 +445,11 @@ static int hdmirx_get_detected_timings(struct snps_hdmirx_dev *hdmirx_dev,
>  	deframer_st = hdmirx_readl(hdmirx_dev, DEFRAMER_STATUS);
>  	is_dvi_mode = !(deframer_st & OPMODE_STS_MASK);
>  
> +	color_depth = hdmirx_get_colordepth(hdmirx_dev);
>  	tmdsqpclk_freq = hdmirx_readl(hdmirx_dev, CMU_TMDSQPCLK_FREQ);
>  	tmds_clk = tmdsqpclk_freq * 4 * 1000;
>  	tmp_data = tmds_clk * 24;
> -	do_div(tmp_data, hdmirx_dev->color_depth);
> +	do_div(tmp_data, color_depth);
>  	pix_clk = tmp_data;
>  	bt->pixelclock = pix_clk;
>  
> @@ -429,7 +461,7 @@ static int hdmirx_get_detected_timings(struct snps_hdmirx_dev *hdmirx_dev,
>  	v4l2_dbg(2, debug, v4l2_dev, "tmds_clk:%llu, pix_clk:%d\n", tmds_clk, pix_clk);
>  	v4l2_dbg(1, debug, v4l2_dev, "interlace:%d, fmt:%d, color:%d, mode:%s\n",
>  		 bt->interlaced, hdmirx_dev->pix_fmt,
> -		 hdmirx_dev->color_depth,
> +		 color_depth,
>  		 is_dvi_mode ? "dvi" : "hdmi");
>  	v4l2_dbg(2, debug, v4l2_dev, "deframer_st:%#x\n", deframer_st);
>  
> @@ -988,36 +1020,6 @@ static void hdmirx_controller_init(struct snps_hdmirx_dev *hdmirx_dev)
>  			   VS_REMAPFILTER_EN_QST | VS_FILTER_ORDER_QST(0x3));
>  }
>  
> -static void hdmirx_get_colordepth(struct snps_hdmirx_dev *hdmirx_dev)
> -{
> -	struct v4l2_device *v4l2_dev = &hdmirx_dev->v4l2_dev;
> -	u32 val, color_depth_reg;
> -
> -	val = hdmirx_readl(hdmirx_dev, DMA_STATUS11);
> -	color_depth_reg = (val & HDMIRX_COLOR_DEPTH_MASK) >> 3;
> -
> -	switch (color_depth_reg) {
> -	case 0x4:
> -		hdmirx_dev->color_depth = 24;
> -		break;
> -	case 0x5:
> -		hdmirx_dev->color_depth = 30;
> -		break;
> -	case 0x6:
> -		hdmirx_dev->color_depth = 36;
> -		break;
> -	case 0x7:
> -		hdmirx_dev->color_depth = 48;
> -		break;
> -	default:
> -		hdmirx_dev->color_depth = 24;
> -		break;
> -	}
> -
> -	v4l2_dbg(1, debug, v4l2_dev, "%s: color_depth: %d, reg_val:%d\n",
> -		 __func__, hdmirx_dev->color_depth, color_depth_reg);
> -}
> -
>  static void hdmirx_get_pix_fmt(struct snps_hdmirx_dev *hdmirx_dev)
>  {
>  	struct v4l2_device *v4l2_dev = &hdmirx_dev->v4l2_dev;
> @@ -1128,7 +1130,6 @@ static void hdmirx_format_change(struct snps_hdmirx_dev *hdmirx_dev)
>  	};
>  
>  	hdmirx_get_pix_fmt(hdmirx_dev);
> -	hdmirx_get_colordepth(hdmirx_dev);
>  	hdmirx_get_avi_infoframe(hdmirx_dev);
>  
>  	v4l2_dbg(1, debug, v4l2_dev, "%s: queue res_chg_event\n", __func__);
> 

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry
