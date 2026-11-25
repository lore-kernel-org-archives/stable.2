Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795616049;
	b=zoq++I906EG7HNs4CAzzmqpovmCVcjZFXH43E8KXSVKkQIwA9H8wNg81g5DDLNxF7uAk
	 s7a77UqKF9ROZDaSg9Q77MyqHdDYiHOrZAUq5P/OM7xThiDg+sYdUUb4Y7iYIuIujoa/C
	 TQBbtNg9jMWzewHkjlVK+6IiSbSogiCef29EqIXJOvZv2fmcFGMtEIo242HGi2SWaHJiK
	 6vEu0jxS3jvNlM02T2XzhOulTC0jxY49lcZe2rJVXNlH6BqRAaGOSQ25rUrVNEcuIODgj
	 UI5Bssbkp+jw+r61+9kaygpMLU6YeXRDnc23sEC9NF+ky2/ykTEyrjea0mDmWpJIV5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616049;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=7yA2Kv81LhtOjCCip8xR6HwdRHowEYFkvy7/rpaMnv4=;
	b=dgXDBmhmb3eJDUIjsQ8hL9XlFAg2JBOmePBCVonNNzKUNFB9tw+7nG6aC6lZJUPrkrv8
	 U6XOEzTwZDAvthooJWGN31fjejwVEdTQ3GRce8XMK9lgt86hxtvIunApT1oBWVtblEBpa
	 7O+LIf0We98L1jyrwrqPU2kam4dt74fY3QK15m1WkvEkfFubS3yZOmIEbXR07T+SlezGK
	 0sFC/1YVUMv0DJIyazMQz64QZXHuOPsC2CO6xYuBDC/G5QW3m4imx45LVmEX4WPiWbJul
	 gG5zh9iBD10dhfbb/jMd/K0j3ahN0NQjKjXZY0UabHg24NuHTfZfcETQ7hNTX08cH5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=pJ0JeBxC;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C96606A323;
	Wed, 25 Nov 2026 14:14:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62C96606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=pJ0JeBxC
Received: from ideasonboard.com (93-46-82-201.ip106.fastwebnet.it [93.46.82.201])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4EB532E0;
	Wed, 25 Nov 2026 15:11:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1795615892;
	bh=5PHtaYjhlZiDW/hanhWKN5A4dP+1izdmQPWAFN2LyqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pJ0JeBxCPpXLgrsoTSR722zqJpwENXnfnUZtnwZjXZEpIx+Cr2LF9/7UQQGIdkD39
	 oAvMb7/DyfiuTYy3bhxiYBfynprmsdtXnijFcFtLQb1Oay0JMzrdROw4qI3jo7l729
	 btKaeZX2jPYsvZjbYAoD8HLrIkPB65Apcrso2tU8=
Date: Wed, 25 Nov 2026 15:14:02 +0100
From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To: David Carlier <devnexen@gmail.com>
Cc: dan.scally@ideasonboard.com, jacopo.mondi@ideasonboard.com, 
	nayden.kanchev@arm.com, mchehab@kernel.org, hverkuil+cisco@kernel.org, linusw@kernel.org, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] media: mali-c55: Serialise the ISP enable in the
 params and stats paths
Message-ID: <awbsm6MQfZaecjcG@zed>
References: <20261125105621.239518-1-devnexen@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261125105621.239518-1-devnexen@gmail.com>

Hi David

On Wed, Nov 25, 2026 at 10:56:06AM +0000, David Carlier wrote:
> Only the capture devices hold isp->capture_lock around the
> mali_c55_pipeline_ready() check and the ISP enable or disable. When the
> last two queues to start are on different video devices, both can see
> a ready pipeline and both enable the ISP. The second call fails with
> -EALREADY and its queue's start_streaming_called flag is cleared, so
> the ISP is never disabled again and every later start fails.
>
> Take capture_lock in the params and stats paths too, and assert that it
> is held in mali_c55_pipeline_ready().
>
> Fixes: d5f281f3dd29 ("media: mali-c55: Add Mali-C55 ISP driver")
> Cc: stable@vger.kernel.org
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
> v2:
> - Add lockdep_assert_held() in mali_c55_pipeline_ready() (Jacopo)

Thanks, if I
--- a/drivers/media/platform/arm/mali-c55/mali-c55-params.c
+++ b/drivers/media/platform/arm/mali-c55/mali-c55-params.c
@@ -894,7 +894,6 @@ static int mali_c55_params_start_streaming(struct vb2_queue *q,
        struct mali_c55 *mali_c55 = params->mali_c55;
        int ret;

-       guard(mutex)(&mali_c55->isp.capture_lock);

        ret = pm_runtime_resume_and_get(mali_c55->dev);
        if (ret)

Then I get the expected splat

# cam -c2 -C
  40.154659] ------------[ cut here ]------------
[   40.159731] WARNING: drivers/media/platform/arm/mali-c55/mali-c55-core.c:521 at mali_c55_pipeline_ready+0xb4/0xf4, CPU#0: CameraManager/360

Tested-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>

I'll queue this for the v7.5 PR (which I shall send out by Friday if
possible)


> - Collect Linus's Reviewed-by
>  drivers/media/platform/arm/mali-c55/mali-c55-core.c   | 3 +++
>  drivers/media/platform/arm/mali-c55/mali-c55-params.c | 4 ++++
>  drivers/media/platform/arm/mali-c55/mali-c55-stats.c  | 4 ++++
>  3 files changed, 11 insertions(+)
>
> diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-core.c b/drivers/media/platform/arm/mali-c55/mali-c55-core.c
> index 241a625f7284..bf80935c20d2 100644
> --- a/drivers/media/platform/arm/mali-c55/mali-c55-core.c
> +++ b/drivers/media/platform/arm/mali-c55/mali-c55-core.c
> @@ -13,6 +13,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/iopoll.h>
>  #include <linux/ioport.h>
> +#include <linux/lockdep.h>
>  #include <linux/of.h>
>  #include <linux/of_reserved_mem.h>
>  #include <linux/platform_device.h>
> @@ -510,6 +511,8 @@ bool mali_c55_pipeline_ready(struct mali_c55 *mali_c55)
>  	struct mali_c55_params *params = &mali_c55->params;
>  	struct mali_c55_stats *stats = &mali_c55->stats;
>
> +	lockdep_assert_held(&mali_c55->isp.capture_lock);
> +
>  	/* Only wait for queues connected through enabled media links. */
>  	return (!media_pad_remote_pad_first(&fr->pad) ||
>  		vb2_start_streaming_called(&fr->queue)) &&
> diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-params.c b/drivers/media/platform/arm/mali-c55/mali-c55-params.c
> index 16e895e3488e..6515c78c1bb2 100644
> --- a/drivers/media/platform/arm/mali-c55/mali-c55-params.c
> +++ b/drivers/media/platform/arm/mali-c55/mali-c55-params.c
> @@ -762,6 +762,8 @@ static int mali_c55_params_start_streaming(struct vb2_queue *q,
>  	struct mali_c55 *mali_c55 = params->mali_c55;
>  	int ret;
>
> +	guard(mutex)(&mali_c55->isp.capture_lock);
> +
>  	ret = pm_runtime_resume_and_get(mali_c55->dev);
>  	if (ret)
>  		goto err_return_buffers;
> @@ -796,6 +798,8 @@ static void mali_c55_params_stop_streaming(struct vb2_queue *q)
>  	struct mali_c55 *mali_c55 = params->mali_c55;
>  	struct mali_c55_isp *isp = &mali_c55->isp;
>
> +	guard(mutex)(&isp->capture_lock);
> +
>  	if (mali_c55_pipeline_ready(mali_c55)) {
>  		if (v4l2_subdev_is_streaming(&isp->sd))
>  			v4l2_subdev_disable_streams(&isp->sd,
> diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-stats.c b/drivers/media/platform/arm/mali-c55/mali-c55-stats.c
> index a9c28b090b2a..cbd2a2f77da3 100644
> --- a/drivers/media/platform/arm/mali-c55/mali-c55-stats.c
> +++ b/drivers/media/platform/arm/mali-c55/mali-c55-stats.c
> @@ -146,6 +146,8 @@ static int mali_c55_stats_start_streaming(struct vb2_queue *q,
>  	struct mali_c55 *mali_c55 = stats->mali_c55;
>  	int ret;
>
> +	guard(mutex)(&mali_c55->isp.capture_lock);
> +
>  	ret = pm_runtime_resume_and_get(mali_c55->dev);
>  	if (ret)
>  		goto err_return_buffers;
> @@ -180,6 +182,8 @@ static void mali_c55_stats_stop_streaming(struct vb2_queue *q)
>  	struct mali_c55 *mali_c55 = stats->mali_c55;
>  	struct mali_c55_isp *isp = &mali_c55->isp;
>
> +	guard(mutex)(&isp->capture_lock);
> +
>  	if (mali_c55_pipeline_ready(mali_c55)) {
>  		if (v4l2_subdev_is_streaming(&isp->sd))
>  			v4l2_subdev_disable_streams(&isp->sd,
> --
> 2.55.0
>
