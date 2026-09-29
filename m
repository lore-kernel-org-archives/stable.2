Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9437751FCB6;
	Tue, 29 Sep 2026 12:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790684169; cv=none; b=NLoKU2srS8GAvTHh1GZqALfwDJ2+MuXAEIJegpsk3ydGuQZzou+ZRSkVG1YmY6xoyTQXW8Xgf65MsfEAPT85Ra9ebLNtlUksv/M1RGzAB9+83pj5xShOvbnvdghmCGm/oWw+v0q4yl5bHz46bRPTBRwCItmCtNkfJe4jUstV5fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790684169; c=relaxed/simple;
	bh=CdBCQAS/5EIwUmaJe1PxISeDMXBdLqlwZr2xmkU6flk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLugpuURx582MApSFo18QqahxK6RxzChIr5rUnkBC7ciGjbl2Rb2ESTSAx3v7ClqV0VBIWYjd03wILm8ZJLKpD9lVPnwoAuwPAp8q2DyR20+MEGdwkTYekmHNFEJ/yOFsK1f4s/OZV0i3soN1w4Ot27+U4Ue4FWvDTMFiyIAcGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=E4J25Rgs; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="E4J25Rgs"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id E35E712B1;
	Tue, 29 Sep 2026 14:14:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1790684053;
	bh=CdBCQAS/5EIwUmaJe1PxISeDMXBdLqlwZr2xmkU6flk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E4J25Rgs4ODtpy/sR9cZ11y9VZu6ajB9+dz6U7o8+dFFz0VfMOMPOw/HwqEsUASq/
	 XbuFwSyWItsc/huqcnkClySILoizoQcHn4dCFmzhmC+gaWanC+sKbsdagKbgCZGPfL
	 f2TEi5sxLhmpvrfHyVdp+xgZAq9YE0urgtx8zEiI=
Date: Tue, 29 Sep 2026 15:16:02 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Jacopo Mondi <jacopo@jmondi.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>, linux-media@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] media: renesas: ceu: free device data if video device is
 unregistered
Message-ID: <20260929121602.GG171869@killaraus.ideasonboard.com>
References: <20260915135406.2423337-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260915135406.2423337-1-lgs201920130244@gmail.com>

On Tue, Sep 15, 2026 at 09:54:06PM +0800, Guangshuo Li wrote:
> ceu_probe() allocates ceudev, while ceu_remove() does not free it if the
> video device has not been registered.
> 
> The video device is registered from the async notifier complete
> callback, and its release callback is responsible for freeing ceudev.
> If the device is removed before the notifier completes, or before video
> device registration succeeds, video_unregister_device() does not invoke
> the release callback and the ceudev allocation is leaked.
> 
> Check whether the video device was registered during remove. Unregister
> it normally when registered so that its release callback handles the
> final free, otherwise free ceudev directly.
> 
> This issue was found by manual code inspection.

That's hard to believe.

How have you tested this patch ?

> Fixes: 32e5a70dc8f4 ("media: platform: Add Renesas CEU driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/media/platform/renesas/renesas-ceu.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/renesas/renesas-ceu.c b/drivers/media/platform/renesas/renesas-ceu.c
> index 65f7659a9e02..5015b7837381 100644
> --- a/drivers/media/platform/renesas/renesas-ceu.c
> +++ b/drivers/media/platform/renesas/renesas-ceu.c
> @@ -1705,7 +1705,10 @@ static void ceu_remove(struct platform_device *pdev)
>  
>  	v4l2_device_unregister(&ceudev->v4l2_dev);
>  
> -	video_unregister_device(&ceudev->vdev);
> +	if (video_is_registered(&ceudev->vdev))
> +		video_unregister_device(&ceudev->vdev);
> +	else
> +		kfree(ceudev);
>  }
>  
>  static const struct dev_pm_ops ceu_pm_ops = {

-- 
Regards,

Laurent Pinchart
