Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795509298;
	b=aLBSB01Q4EDGXiNvvaglVSN/X2uYh5lsALXnMbUx2RJthmSbAInIXUXdAQC8XwJMjLlH
	 MKNjUMQdROOK91nryyDp2gealXPu0uoTuLuEJed0c1nfBT/I+xbxKUUPwX4fUvZkF01vu
	 pis6j+/eVSqRbyiwDui46SneryPLnaBj/QiJ0Sva2dCXy0gAnqnTQtwqusNm4bQedxm4V
	 NcvkI+AagurVir3VixfiMxef2qC+paj6XKDd1YC+mJTyQLWbx6i+E99s3Qv4DLuc85ZEz
	 SQJccoxhoAZZCMR7VjKht01SQqamZojSGLuS3Q0OsvA0Ej1dGHSszUUGsJErfY7x0xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795509298;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=/+C9IDErX90bAu4WHPOk3aBMUel6TJ2TV50UzPHUj/A=;
	b=bF5pq65Tqp47zA8yWQnLZrit3UCdNn7M5j2pOaddeD1ezfdyH2Z0MKZXCf9FNbTRZAN+
	 3Oh2h0SfOJkFJOfSiAHMC+6WlNt/pnbsbHYdE40VE3GsVJKaxyXuNHe5f7TDKpOXU61KE
	 vTnrG6Vfyd4lyojV5j+B7lIsfH32Ig5vyB7zbxRRouqPU2URKPmI7ln5bk7/USyLaKs6b
	 Sek7zZhAZeCwveI62c/B8RZzfC/3czWjT1Prh8op5M+XmZ55kl3uF8ICrWuT7ltQzpW6C
	 RGm+F1qf+RcNPfxHhUS/SYdV2by/P8mPQ9pq5M+dFVMCt6i1PqLRnDRJtNA6Ew6/LdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=n1xnuyXN;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42820606A31E;
	Tue, 24 Nov 2026 08:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42820606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=n1xnuyXN
Received: from ideasonboard.com (unknown [93.65.100.155])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8F93EC4B;
	Tue, 24 Nov 2026 09:32:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1795509142;
	bh=ugyRtjgKK8tDPPuYVG8t/8De6KYQmiKIIQ8VnT3FnWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n1xnuyXN4gYKtsvxBRG56IzsiQmR3BBVOguTFQtGOcC0LConreodsV+lPjfoeP1iT
	 CSLH2lCVHvOx8yqdVWPGRfhUMRqIJfPUohbFz2+OE17vMnGzrerAMveCkutexD1VOI
	 8EEoed3dqS4YvnP4Z23YJAsH3a/bG+jGPApYr63I=
Date: Tue, 24 Nov 2026 09:34:52 +0100
From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To: David Carlier <devnexen@gmail.com>
Cc: linux-media@vger.kernel.org, 
	Daniel Scally <dan.scally@ideasonboard.com>, Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
	Nayden Kanchev <nayden.kanchev@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Hans Verkuil <hverkuil+cisco@kernel.org>, Linus Walleij <linusw@kernel.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] media: mali-c55: Serialise the ISP enable in the params
 and stats paths
Message-ID: <awVLwIfpxeOW_7Qx@zed>
References: <20261114164933.2657337-1-devnexen@gmail.com>
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
In-Reply-To: <20261114164933.2657337-1-devnexen@gmail.com>

Hi David

On Sat, Nov 14, 2026 at 04:49:33PM +0000, David Carlier wrote:
> Only the capture devices hold isp->capture_lock around the
> mali_c55_pipeline_ready() check and the ISP enable or disable. When the
> last two queues to start are on different video devices, both can see
> a ready pipeline and both enable the ISP. The second call fails with
> -EALREADY and its queue's start_streaming_called flag is cleared, so
> the ISP is never disabled again and every later start fails.
>
> Take capture_lock in the params and stats paths too.

Should we then:

        lockdep_assert_held(&mali_c55->isp.capture_lock);

in mali_c55_pipeline_ready() ?

>
> Fixes: d5f281f3dd29 ("media: mali-c55: Add Mali-C55 ISP driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  drivers/media/platform/arm/mali-c55/mali-c55-params.c | 4 ++++
>  drivers/media/platform/arm/mali-c55/mali-c55-stats.c  | 4 ++++
>  2 files changed, 8 insertions(+)
>
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
