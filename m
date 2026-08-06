Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D46F23E33D;
	Thu,  6 Aug 2026 06:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785997568; cv=none; b=KjEy46I055qzLndiw1fURR+rfSfML2aMu484ftcqiQ9yqP3GX7NCIbK2qO8dPxt/RiW6agnFed4O5e0d4ttgzwJrpkFXLNrbt3wx+sribuqsMNRpSub4vKYjJ9vIeQ8q21RG+Ux3RlCHaGrQX6Z4j9Y3kkYB3TSzlEx5bS/l3eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785997568; c=relaxed/simple;
	bh=FPvRGM2d0tn5ETUtjItZnpURgaYlLqteLmQ7bWT2KmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TV1UTmoqRD0yhF9ajCL1666G6g5SV4WHPTA6dBCA3Atq4lgcQGzZ0lAuYkH3SBK4/QHdBq5YRu1xfKjIvardoW+GRYhiUczHIXdBpaIBmW4Pfgmyccf9jvCIWtXYYiAjTiV8QDamDP1Z1UNVrB1vdCcqnaS6X0KmFSToXxciPuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6OaLtHI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6OaLtHI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D801F00A3A;
	Thu,  6 Aug 2026 06:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785997566;
	bh=jv/J3v5zsnx3lF5Lltm7UPUZd9XwJO/0Ke5FFbboxjc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=c6OaLtHI33jl483pwkOB+Kj+R1RDtBkZzKTjYSYzhvkTjuVI4IrHv66YaFlF1lI/Y
	 gGvc296k8a50Y8oVG/jtxtCOiOtTAJ9VCB9Zfx+p6l5PjVu5HUppKyzXE2G0ND/8ir
	 qZCnlGPr7T8An+QXSlNn4VZkSCXO4UEaDyHVWJlpsoqosb7grYUVN8jVCDmjQTrwGy
	 XjbuYFOFc0hqI35AKEjGe3zJqD2AkbiQo3jtFz/jJO2qaQeOZgUIsTrDIjvohKpMti
	 ucbPEcRYtl1evhIrQCSpYI6Wg+vvooysfrtoxVU5ArglNrJDVh91v0aVyBLorZosFp
	 kxl4+ZbhI30Eg==
Message-ID: <9ea7468e-73b4-4064-acae-8f9fcb0df447@kernel.org>
Date: Thu, 6 Aug 2026 09:26:02 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/10] media: microchip-isc: disable histogram and
 flush AWB work on teardown
To: Balakrishnan Sambath <balakrishnan.s@microchip.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260803-balki-isc-prefix-fixes-v1-v4-0-f625d6aa0ae1@microchip.com>
 <20260803-balki-isc-prefix-fixes-v1-v4-4-f625d6aa0ae1@microchip.com>
From: Eugen Hristev <ehristev@kernel.org>
Content-Language: en-US
In-Reply-To: <20260803-balki-isc-prefix-fixes-v1-v4-4-f625d6aa0ae1@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/3/26 13:20, Balakrishnan Sambath wrote:
> isc_stop_streaming() and the isc_start_streaming() error path dropped the
> runtime PM reference with the histogram still enabled. A HISDONE firing
> just before the stop, or a failed isc_update_profile() on the start path,
> can queue isc_awb_work(), which reads the histogram registers before
> taking its own PM reference and faults on the unclocked device.
> 
> Disable the histogram, synchronize the IRQ and flush the work before
> dropping the PM reference on both paths. synchronize_irq() must come
> before cancel_work_sync(), so an in-flight handler cannot re-queue
> awb_work after it is cancelled.
> 
> Fixes: 93d4a26c3dab ("[media] atmel-isc: add the isc pipeline function")
> Cc: stable@vger.kernel.org
> Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
> ---
>  drivers/media/platform/microchip/microchip-isc-base.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/media/platform/microchip/microchip-isc-base.c b/drivers/media/platform/microchip/microchip-isc-base.c
> index debbc38717de..54f3093e14fc 100644
> --- a/drivers/media/platform/microchip/microchip-isc-base.c
> +++ b/drivers/media/platform/microchip/microchip-isc-base.c
> @@ -382,6 +382,13 @@ static int isc_start_streaming(struct vb2_queue *vq, unsigned int count)
>  	return 0;
>  
>  err_configure:
> +	isc_set_histogram(isc, false);

I find it odd that an error path would clean up something that the
enable path did not do. So if the histogram is enabled by calling a
different function (isc_configure()) , then if isc_configure() failed,
isc_configure() should cleanup after itself, and you should not do the
cleanup here.

> +
> +	/* let a running IRQ handler finish before the clock is disabled */
> +	synchronize_irq(isc->irq);
> +
> +	cancel_work_sync(&isc->awb_work);
Same here, if something failed, there should not be any pending
workqueue left, it should be cleaned by the failing enabler.

Am I missing something ?

> +
>  	pm_runtime_put_sync(isc->dev);
>  err_pm_get:
>  	v4l2_subdev_call(isc->current_subdev->sd, video, s_stream, 0);
> @@ -425,9 +432,13 @@ static void isc_stop_streaming(struct vb2_queue *vq)
>  	/* Disable DMA interrupt */
>  	regmap_write(isc->regmap, ISC_INTDIS, ISC_INT_DDONE);
>  
> +	isc_set_histogram(isc, false);
> +
>  	/* let a running IRQ handler finish before the clock is disabled */
>  	synchronize_irq(isc->irq);
>  
> +	cancel_work_sync(&isc->awb_work);
> +
>  	pm_runtime_put_sync(isc->dev);
>  
>  	/* Disable stream on the sub device */
> 

