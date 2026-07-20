Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0122D8796;
	Mon, 20 Jul 2026 21:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784581432; cv=none; b=s82v/7rrADY12TMHwdBbdBlYCFfg7uYCIRTfgo6BCsm5EYncDslwIJRtCo/pmG8vfm3G2wAYtIrxu806nnCA79nk+fvBcmx0tztKla8tfkdg+vtnhQOfW3oBHTvWuGD/AWjvN5MfKDtO0khPWXyLiczizS86+r2H5dRb9RPlYa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784581432; c=relaxed/simple;
	bh=Vow20Z1JLPafCgEs8/gHRfDCbYGdzjMYj1szkVCn+CM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fmb2deX9rBnT5xQnruiBnx54dG0AKIfVil9WY+l6hcAgAE3bAd07QcM3SuAspLQCGuaxAo6E2pgJUH1rJx1OzAzQ2HABVc23e+NFeWwNnT18uRYJzhBBXG4seuWh8nBrgD3pKhTREjI8OpjODrVNRo6BMefvDZHW2i7UU2lgNVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ee3yBIp+; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ee3yBIp+"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id A1F84BB;
	Mon, 20 Jul 2026 23:02:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1784581369;
	bh=Vow20Z1JLPafCgEs8/gHRfDCbYGdzjMYj1szkVCn+CM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ee3yBIp+bJBisa3yefDNA4grWWXvkxPkcYh8o2p0j92ILX1LJ314kX6SwzgNFC/I0
	 wRMBhxcIxBPbXSW3Iqbz4KQQSPUOURDkoNmI9oZ/KwvmRY8zAtLyfXMWgdsAP91uko
	 HooJCrD6EULlMNtw3tfPMsK44SzxuyNIBwmMEGmY=
Date: Tue, 21 Jul 2026 00:03:46 +0300
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
Subject: Re: [PATCH v2 3/6] media: nxp: imx8-isi: Fix per-stream reference
 counting for multiplexed streams
Message-ID: <20260720210346.GD50424@killaraus.ideasonboard.com>
References: <20260720-isi-v2-0-45845bc5d4fa@oss.nxp.com>
 <20260720-isi-v2-3-45845bc5d4fa@oss.nxp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260720-isi-v2-3-45845bc5d4fa@oss.nxp.com>

On Mon, Jul 20, 2026 at 11:34:05AM +0800, Guoniu Zhou wrote:
> The ISI crossbar fails to properly enable multiple streams from different
> virtual channels on the same input pad. Only the first stream gets enabled
> in hardware, subsequent streams are silently ignored.
> 
> The driver uses a single enable_count per input to track the input state.
> When enable_count is non-zero, the code assumes the input is already active
> and skips calling v4l2_subdev_enable_streams() for additional streams:
> 
>   Call 1: enable_streams(stream 0)
>     -> enable_count == 0, enable gasket and stream 0 in hardware
>     -> enable_count = 1
> 
>   Call 2: enable_streams(stream 1)
>     -> enable_count == 1, skip hardware enable (BUG!)
>     -> enable_count = 2
>     -> stream 1 never gets enabled
> 
> Similarly on disable, when enable_count reaches zero, ALL streams are
> disabled regardless of which streams are actually still active.
> 
> Fix this by tracking per-stream state using:
> - enabled_streams (u64 bitmask): tracks which streams are currently enabled
> - enabled_count[] (array): per-stream reference counter to support the same
>   stream being enabled/disabled multiple times
> 
> Now each stream is independently enabled/disabled in hardware based on the
> enabled_streams bitmask, while enabled_count[] provides reference counting
> for scenarios where the same stream is enabled multiple times, such as
> duplicate cases in the ISI stream.
> 
> Fixes: cf21f328fcaf ("media: nxp: Add i.MX8 ISI driver")
> Cc: stable@vger.kernel.org

As far as I understand, only newer SoCs support multi-stream for ISI
inputs (please tell me if that's incorrect). Those SoCs were not
supported when the ISI driver was merged, so I don't think this should
be backported to stable kernels. The subject line should then read
"Implement per-stream ..." instead of "Fix per-stream ..." and the
commit message adapted accordingly.

> Signed-off-by: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
> ---
> Changes in v2:
> - Use fixed-size array for enabled_count instead of dynamic allocation
> - Use BIT_ULL() macro for u64 bitmask operations
> - Use MXC_ISI_MAX_STREAMS (64) as loop boundary instead of num_sources
> - Remove mxc_isi_stream_counters_alloc/free functions
> ---
>  .../media/platform/nxp/imx8-isi/imx8-isi-core.h    |  7 +-
>  .../platform/nxp/imx8-isi/imx8-isi-crossbar.c      | 76 ++++++++++++++++------
>  2 files changed, 63 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h
> index 7547a6559d4c..9adbe2fe7cf8 100644
> --- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h
> +++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h
> @@ -184,8 +184,13 @@ struct mxc_isi_dma_buffer {
>  	dma_addr_t			dma;
>  };
>  
> +/* V4L2 subdev max stream ID is 63, need 64 counters (0-63) */
> +#define MXC_ISI_MAX_STREAMS		64
> +
>  struct mxc_isi_input {
> -	unsigned int			enable_count;
> +	u64				enabled_streams;
> +	/* Per-stream reference counter */
> +	unsigned int			enabled_count[MXC_ISI_MAX_STREAMS];

You can save some memory here by replacing unsigned int with u8. The
counter can never go above the number of ISI outputs, as streams can be
enabled once only.

>  };
>  
>  struct mxc_isi_crossbar {
> diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c
> index 328d08a278ea..64576f6bd45c 100644
> --- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c
> +++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c
> @@ -337,6 +337,8 @@ static int mxc_isi_crossbar_enable_streams(struct v4l2_subdev *sd,
>  	struct mxc_isi_crossbar *xbar = to_isi_crossbar(sd);
>  	struct v4l2_subdev *remote_sd;
>  	struct mxc_isi_input *input;
> +	u64 streams_to_enable;
> +	unsigned long stream;

unsigned int is enough, this is a counter, not a bitmask.

>  	u64 sink_streams;
>  	u32 sink_pad;
>  	u32 remote_pad;
> @@ -350,30 +352,47 @@ static int mxc_isi_crossbar_enable_streams(struct v4l2_subdev *sd,
>  
>  	input = &xbar->inputs[sink_pad];
>  
> -	/*
> -	 * TODO: Track per-stream enable counts to support multiplexed
> -	 * streams.
> -	 */
> -	if (!input->enable_count) {

Let's keep a short comment here:

	/* Enable the gasket when the first stream is enabled for this input. */

> +	if (!input->enabled_streams) {
>  		ret = mxc_isi_crossbar_gasket_enable(xbar, state, remote_sd,
>  						     remote_pad, sink_pad);
>  		if (ret)
>  			return ret;
> +	}
>  
> +	/*
> +	 * Track per-stream enable counts to support multiplexed streams.
> +	 * Only enable streams that are not already enabled.
> +	 */
> +	streams_to_enable = sink_streams & ~input->enabled_streams;
> +
> +	if (streams_to_enable) {
>  		ret = v4l2_subdev_enable_streams(remote_sd, remote_pad,
> -						 sink_streams);
> +						 streams_to_enable);
>  		if (ret) {
>  			dev_err(xbar->isi->dev,
>  				"failed to enable streams 0x%llx on '%s':%u: %d\n",
> -				sink_streams, remote_sd->name, remote_pad, ret);
> -			mxc_isi_crossbar_gasket_disable(xbar, sink_pad);
> -			return ret;
> +				streams_to_enable, remote_sd->name, remote_pad, ret);
> +			goto err_gasket_disable;
>  		}
> +
> +		input->enabled_streams |= streams_to_enable;
>  	}
>  
> -	input->enable_count++;
> +	/* Increment reference count for all requested streams */
> +	for (stream = 0; stream < MXC_ISI_MAX_STREAMS; stream++) {

	for (unsigned int stream = 0; stream < MXC_ISI_MAX_STREAMS; stream++) {

and drop the local variable above.

> +		if (!(sink_streams & BIT_ULL(stream)))
> +			continue;
> +
> +		input->enabled_count[stream]++;
> +	}

Each ISI pipe processes a single stream (the driver uses the
V4L2_SUBDEV_ROUTING_NO_N_TO_1 validation flag, and patch 2/6 ensures
that only stream 0 is accepted on the source side of the crossbar). This
means that that, after translating streams_mask to the sink side,
sink_streams should have a single bit set, and streams_to_enable will
have either 0 or 1 bit set.

If that explanation is correct (please let me know if you disagree),
then this loop can be replaced with

	input->enabled_count[__ffs64(sink_streams)]++;

>  
>  	return 0;
> +
> +err_gasket_disable:
> +	if (!input->enabled_streams)
> +		mxc_isi_crossbar_gasket_disable(xbar, sink_pad);
> +
> +	return ret;
>  }
>  
>  static int mxc_isi_crossbar_disable_streams(struct v4l2_subdev *sd,
> @@ -383,6 +402,8 @@ static int mxc_isi_crossbar_disable_streams(struct v4l2_subdev *sd,
>  	struct mxc_isi_crossbar *xbar = to_isi_crossbar(sd);
>  	struct v4l2_subdev *remote_sd;
>  	struct mxc_isi_input *input;
> +	u64 streams_to_disable = 0;
> +	unsigned long stream;

unsigned int here too.

>  	u64 sink_streams;
>  	u32 sink_pad;
>  	u32 remote_pad;
> @@ -396,19 +417,36 @@ static int mxc_isi_crossbar_disable_streams(struct v4l2_subdev *sd,
>  
>  	input = &xbar->inputs[sink_pad];
>  
> -	input->enable_count--;
> +	/*
> +	 * Decrease the enable count for each stream. Only disable streams
> +	 * whose count reaches zero.
> +	 */
> +	for (stream = 0; stream < MXC_ISI_MAX_STREAMS; stream++) {

	for (unsigned int stream = 0; stream < MXC_ISI_MAX_STREAMS; stream++) {

> +		if (!(sink_streams & BIT_ULL(stream)))
> +			continue;
>  
> -	if (!input->enable_count) {
> -		ret = v4l2_subdev_disable_streams(remote_sd, remote_pad,
> -						  sink_streams);
> -		if (ret)
> -			dev_err(xbar->isi->dev,
> -				"failed to disable streams 0x%llx on '%s':%u: %d\n",
> -				sink_streams, remote_sd->name, remote_pad, ret);
> +		if (!(input->enabled_streams & BIT_ULL(stream)))
> +			continue;
>  
> -		mxc_isi_crossbar_gasket_disable(xbar, sink_pad);
> +		if (--input->enabled_count[stream] == 0)
> +			streams_to_disable |= BIT_ULL(stream);
>  	}

Similarly here, the whole loop could be replaced by

	if (--input->enabled_count[__ffs64(stream)] == 0)
		streams_to_disable |= BIT_ULL(stream);

Another option is to store the information in the mxc_isi_pipe structure
in the form of two new fields:

	unsigned int input;
	unsigned int input_stream;

The fields would be set to the input index and the sink stream mask in
mxc_isi_crossbar_enable_streams():


	struct mxc_isi_pipe *pipe = &xbar->isi->pipes[pad - xbar->num_sources];

	...

	pipe->input = sink_pad;
	pipe->input_stream = sink_streams;

In this function you would then do (completely untested)

	struct mxc_isi_pipe *pipe = &xbar->isi->pipes[pad - xbar->num_sources];

	...

	pipe->input = 0;
	pipe->input_stream = 0;

	/*
	 * Check if any other pipe receives the same input stream. If so we
	 * can't disable it yet, so return immediately.
	 */
	for (i = 0; i < xbar->isi->pdata->num_channels; ++i) {
		struct mxc_isi_pipe *pipe = &xbar->isi->pipes[i];

		if (pipe->input == sink_pad &&
		    pipe->input_stream == sink_streams)
			return 0;
	}

	input->enabled_streams &= ~sink_streams;

The advantage of this is that we won't have to add a 64 entries array to
each input. I'm not too concerned about the memory usage (even if
reducing memory usage is always nice, more for the improvement in cache
locality than for the memory saving itself), but the 64 entries feel a
bit arbitrary.

What do you think is best ?

> +	if (!streams_to_disable)
> +		return 0;
> +
> +	ret = v4l2_subdev_disable_streams(remote_sd, remote_pad,
> +					  streams_to_disable);
> +	if (ret)
> +		dev_err(xbar->isi->dev,
> +			"failed to disable streams 0x%llx on '%s':%u: %d\n",
> +			streams_to_disable, remote_sd->name, remote_pad, ret);
> +
> +	input->enabled_streams &= ~streams_to_disable;
> +
> +	if (!input->enabled_streams)
> +		mxc_isi_crossbar_gasket_disable(xbar, sink_pad);
> +
>  	return ret;
>  }
>  

-- 
Regards,

Laurent Pinchart
