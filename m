Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86019175A83;
	Fri,  2 Oct 2026 00:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790899686; cv=none; b=tCm0qWIScvRlaqgizYEuobYj2mOun91xABdSYr1y6BhgVmoTJl39Tsa34VEgzn84TijOMAJi2P0QPQeGDXwhpTwVv1dZlIisHP6CxbzMlkx/dho9bg+gpicQDQ0WWWYYCLGVXnA4V/RIkhlEUGIE0fWhxe+mkSWn7S7/o8dux80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790899686; c=relaxed/simple;
	bh=YMZdP7dghJMrLNJEzTCyTqwv/NuQuslcMFv6ITtjYe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8igT6gWU2HVvvWmZ6KCdSs/vzzP5ltPdtASh/z6H9vX3Ew2xs3TgZa8966BoDR2IEP2aouf8XcAXeMQbCLOMKXRIkgkPKYz2LO/k4StcV8AOLtqecqmwsGR+IvbYwgCaixsYn1N4RU92/epS3ZLdjgAf4wPOqoYgda5797sWgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Jx7/5K/3; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Jx7/5K/3"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id E1E20929;
	Fri,  2 Oct 2026 02:06:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1790899570;
	bh=YMZdP7dghJMrLNJEzTCyTqwv/NuQuslcMFv6ITtjYe4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jx7/5K/3SlRom+qybx7wms1uOB5RtlQ8vGr1fmcE4ccB33IWPYiI++DdmaH+a9FXU
	 gxqSrLcOqXHSSy+UJ6/Mmo4bc9TJnuDETvV3HPeuINbYUE5JxQhDnVyNMe9mVsggCw
	 1Wq2DQKMmV1hlO1s2T6vG+PGRUwk7+vCBbqJlBxw=
Date: Fri, 2 Oct 2026 03:08:01 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>,
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] media: uvcvideo: Do not read beyond the
 uvc_status_control memory
Message-ID: <20261002000801.GC9061@killaraus.ideasonboard.com>
References: <20260813-uvc-status-11-v1-1-2cf43e9590b0@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260813-uvc-status-11-v1-1-2cf43e9590b0@chromium.org>

Hi Ricardo,

Thank you for the patch.

On Thu, Aug 13, 2026 at 08:43:24PM +0000, Ricardo Ribalda wrote:
> When we receive an event from the camera we only receive 11 bytes. If a
> v4l2 control is mapped into a UVC control beyond those 11 bytes, right
> now the code is blindly reading those.
> 
> Add a check in the event handler to ignore controls that are not
> available in those 11 bytes.

I tried to see where the 11 bytes size came from, and couldn't find any
mention of it (direct or indirect) in the UVC spec.

Checking my UVC descriptors collection, here are the wMaxPacketSize I
see for the control interrupt endpoint (the first column is the number
of devices):

     11 wMaxPacketSize     0x0004  1x 4 bytes
     89 wMaxPacketSize     0x0008  1x 8 bytes
     37 wMaxPacketSize     0x000a  1x 10 bytes
      2 wMaxPacketSize     0x000c  1x 12 bytes
    238 wMaxPacketSize     0x0010  1x 16 bytes
      3 wMaxPacketSize     0x0017  1x 23 bytes
     12 wMaxPacketSize     0x0020  1x 32 bytes
     41 wMaxPacketSize     0x0040  1x 64 bytes
      1 wMaxPacketSize     0x4000  1x 0 bytes

16 bytes is by far the most common value, but smaller and larger sizes
are not uncommon. It seems we shouldn't harcode the size to 11, but
instead dynamically size the buffer based on the endpoint max packet
size, and, more importantly, validate the mapping offset and size
against the actual transfer length. The length is passed to
uvc_event_control() and is then lost when calling
uvc_ctrl_status_event_async(). It should be passed to the function
(subtracting the header size), stored in uvc_ctrl_work, and used in
uvc_ctrl_status_event_work() to pass it to uvc_ctrl_status_event().

One additional upside of that change is that we will be able to pass the
correct length to uvc_ctrl_status_event() in uvc_gpio_event().

What do you think ?

> Cc: stable@vger.kernel.org
> Closes: https://sashiko.dev/#/patchset/F0F008459FFA835D%2B20260813074632.2021311-1-raoxu%40uniontech.com
> Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 4 +++-
>  drivers/media/usb/uvc/uvcvideo.h | 3 ++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index 3ca108b83f1d..3061f388f57b 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -2158,7 +2158,9 @@ void uvc_ctrl_status_event(struct uvc_video_chain *chain,
>  	list_for_each_entry(mapping, &ctrl->info.mappings, list) {
>  		s32 value;
>  
> -		if (uvc_ctrl_mapping_is_compound(mapping))
> +		if (uvc_ctrl_mapping_is_compound(mapping) ||
> +		    DIV_ROUND_UP(mapping->offset + mapping->size, 8) >
> +		    UVC_STATUS_CONTROL_LEN)
>  			value = 0;
>  		else
>  			value = uvc_mapping_get_s32(mapping, UVC_GET_CUR, data);
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index b6bcee4a222f..ae5e6b6fdd98 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -559,10 +559,11 @@ struct uvc_status_streaming {
>  	u8	button;
>  } __packed;
>  
> +#define UVC_STATUS_CONTROL_LEN 11
>  struct uvc_status_control {
>  	u8	bSelector;
>  	u8	bAttribute;
> -	u8	bValue[11];
> +	u8	bValue[UVC_STATUS_CONTROL_LEN];
>  } __packed;
>  
>  struct uvc_status {
> 
> ---
> base-commit: 7b1734e1761258d78651263706182f1d772c0d3b
> change-id: 20260813-uvc-status-11-99b9e27a8ea9

-- 
Regards,

Laurent Pinchart
