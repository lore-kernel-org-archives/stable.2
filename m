Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FAC1DF748;
	Tue, 29 Sep 2026 14:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790693326; cv=none; b=Eu+AFeJihGB36jvE6bnk0boOPmB56YqfCXYAXE0hKvzoERaoAjno2QWE0+KL3JiO4is4A2hlqpQg61SGGFID2KX4ZtAxy+VNs1uEvfxHvKrEbwd5Ut6Q2zyZifb+nvcG0q6aOH8HNtpVCoANEXs8fVgmYShq2CO/DA5+lOQM3fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790693326; c=relaxed/simple;
	bh=L9t2Par57RVjHecI7nYs/b1rSeqUDJVuRULt6+FZQsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HKPUFCoyXoZx/BUazDr2zDS2NWE05iteDOmV0b03cMsTHCr+6d+l2Fi5uwDjcBfFNqPkUiHLzGCWYrVcKamqYM7FKNoqxmutObl3Ew5CLUrLLc7powSgxC9g7x583gchKlJ6kSvm6kjJrQueIKntFi8GX8jpvUSNRlsekVeb7rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVJAU006; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVJAU006"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070621F000FF;
	Tue, 29 Sep 2026 14:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790693324;
	bh=I9X4U7BvKdhfzPkylrAkQ7XYLNAWNJVOd5c9E00Jn3I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FVJAU006/P9MSKnk0RmiD4AM7X4oMnhDDkFLkSzEEcTDgEgyTNBh3JDwLsu40j+N/
	 BsGdCkdenWxx8MYtMcdrwsnUlzFFzmrjKudeGbStmxoNw6vSHW4X/qMTVuNoGta1Na
	 klpbXM7CTIVUZVCSTv1CKNulvzLHWwF/Izn9P18p/wVCvPirMuM50dj7KEpEpwUymV
	 WW/HEre4oeQoixxWAzbRr0dod1gXUnsnmzMboSbkDwYD3Gp+stJdXLGIGep1cpVJfO
	 ROuccSH56lVZFy3oOWYZRRxX8xHhYvLdsZyDmC/NZLDmk8ohK1qbC5i9j4wAOcjHQp
	 RwDu8s28YznRA==
Message-ID: <2724369e-1e16-44dc-8c93-835aec73b415@kernel.org>
Date: Tue, 29 Sep 2026 16:48:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: uvcvideo: preserve status URB interval on resubmit
To: raoxu <raoxu@uniontech.com>, laurent.pinchart@ideasonboard.com
Cc: mchehab@kernel.org, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <F0F008459FFA835D+20260813074632.2021311-1-raoxu@uniontech.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <F0F008459FFA835D+20260813074632.2021311-1-raoxu@uniontech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 13-Aug-26 09:46, raoxu wrote:
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
> Fixes: c0efd232929c ("V4L/DVB (8145a): USB Video Class driver")
> Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xu Rao <raoxu@uniontech.com>

Thank you for your patch.

I have merged this into:

https://gitlab.freedesktop.org/linux-media/users/uvc/-/commits/for-next/

Regards,

Hans


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
> --
> 2.50.1

