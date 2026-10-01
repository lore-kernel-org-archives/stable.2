Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079553B19C6;
	Thu,  1 Oct 2026 23:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790896741; cv=none; b=AJPN+p95+l81oqqosQRLJ+Fx+/b8hlfX0A/BjKBr8qmXCh/8DjTXP+l8ZeZYx/v6YFMVRSsEJjWQg2nU8p70r6Q3w3esnkBql7o3FvT2WMGh1+CTrVhRadW23r4m8+CNEZ0/3bMUhEoONp7/afKo9JLo1xf+K33G7VoPjy4ZyIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790896741; c=relaxed/simple;
	bh=9bxrtY3tr7ZzsH0K2o2kuH8XrbHlRax04WUJ0CoyNVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NuMWQPQydUQOjiXZQWkFjDCYY3ekqg4ehQuZvAofDKlUgjNbcBh5WJfVVCNc9iG1NNSkUBmOGRV3HCgzyfRs/a5M5DpWpmPfoSKlUlLva6pF4//ttFaLmHZaiu29GDoe1LnEFNc74s3EUqg1ZVqyc5tlmJVHyrLEtjceOd5cYyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Oy4mzuYI; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Oy4mzuYI"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8B7FCC23;
	Fri,  2 Oct 2026 01:17:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1790896624;
	bh=9bxrtY3tr7ZzsH0K2o2kuH8XrbHlRax04WUJ0CoyNVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oy4mzuYI6RFrAuQe1XYfN1o4ZZplirUHF8wDM+gQqINDr0qNzj8HPLq7hOG0+2Y6P
	 fY+fZ1WLbc9utx5kzFcwyFf72ecgYLzF3RtaSjqJohwzhzjaUv93fifZN+xODPJ86B
	 yNMA3PgY7nw+aIItWrRGVPJ26QznS3ygNcvamBoM=
Date: Fri, 2 Oct 2026 02:18:56 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: raoxu <raoxu@uniontech.com>
Cc: hansg@kernel.org, mchehab@kernel.org, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] media: uvcvideo: preserve status URB interval on resubmit
Message-ID: <20261001231856.GB9061@killaraus.ideasonboard.com>
References: <F0F008459FFA835D+20260813074632.2021311-1-raoxu@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <F0F008459FFA835D+20260813074632.2021311-1-raoxu@uniontech.com>

On Thu, Aug 13, 2026 at 03:46:32PM +0800, raoxu wrote:
> From: Xu Rao <raoxu@uniontech.com>
> 
> usb_fill_int_urb() takes an endpoint interval value and stores the
> period expected by usb_submit_urb() in urb->interval. For high-speed
> and SuperSpeed interrupt endpoints, it converts the logarithmic
> descriptor encoding to the corresponding microframe period.
> 
> The UVC status URB is initialized once in uvc_status_init(), including
> the UVC_QUIRK_STATUS_INTERVAL adjustment required by high-speed devices
> that report bInterval using the old full-speed convention. The first
> submission therefore carries the intended interval.
> 
> Both status resubmit paths, however, overwrite urb->interval with the
> raw endpoint bInterval before submitting the same URB again. On
> high-speed and SuperSpeed devices this mixes the descriptor encoding
> with the already converted URB interval representation. For devices
> using UVC_QUIRK_STATUS_INTERVAL it also deterministically discards the
> quirk adjustment after the first status completion, making the
> workaround effective only for the initial submission.
> 
> This has been easy to miss because the initial status submission is
> correct, full-speed interrupt endpoints do not have the same
> logarithmic encoding mismatch, and the status endpoint carries
> relatively infrequent control and streaming notifications rather than
> the video payload itself. The problem only appears after the status URB
> has completed and is resubmitted, and the externally visible effect
> also depends on how the host controller handles the resulting period.
> 
> Do not restore bInterval when resubmitting the status URB. Reuse the
> interval established by usb_fill_int_urb() and usb_submit_urb(), which
> also preserves the quirk-adjusted value. No additional state or
> interval conversion is needed because the same URB is being reused.
> 

This commit message is also very long and has a large amount of
irrelevant, when not borderline incorrect, information. Is this missing
an Assisted-by tag ?

> Fixes: c0efd232929c ("V4L/DVB (8145a): USB Video Class driver")
> Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xu Rao <raoxu@uniontech.com>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c   | 1 -
>  drivers/media/usb/uvc/uvc_status.c | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index 3ca108b83f1d..6552f541aa0d 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -2196,7 +2196,6 @@ static void uvc_ctrl_status_event_work(struct work_struct *work)
>  		return;
> 
>  	/* Resubmit the URB. */
> -	w->urb->interval = dev->int_ep->desc.bInterval;
>  	ret = usb_submit_urb(w->urb, GFP_KERNEL);
>  	if (ret < 0)
>  		dev_err(&dev->intf->dev,
> diff --git a/drivers/media/usb/uvc/uvc_status.c b/drivers/media/usb/uvc/uvc_status.c
> index b632cf5e3fe9..680c6c7f4ad7 100644
> --- a/drivers/media/usb/uvc/uvc_status.c
> +++ b/drivers/media/usb/uvc/uvc_status.c
> @@ -245,7 +245,6 @@ static void uvc_status_complete(struct urb *urb)
>  	}
> 
>  	/* Resubmit the URB. */
> -	urb->interval = dev->int_ep->desc.bInterval;
>  	ret = usb_submit_urb(urb, GFP_ATOMIC);
>  	if (ret < 0)
>  		dev_err(&dev->intf->dev,

-- 
Regards,

Laurent Pinchart
