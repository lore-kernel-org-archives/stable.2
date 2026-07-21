Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD6436213D;
	Tue, 21 Jul 2026 13:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784640425; cv=none; b=CcQd6LxnKLgA+f5z1NAwUcpIZ2t8XZrdaUUPxG6bRVDNii/cRJu0yBhhQSepY8PAs/bT0HKI2g5e1tjcloKjisbHfn9CQU6Y7duN0b9Mp7qqU3RMg/k154mNae4SuyOsxFDuAvu+9YM0TIzHMluynWep3nhq/2V8CL1MEU4MgPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784640425; c=relaxed/simple;
	bh=KEmr7XCPhQJPsCBErama538ysVxQKV9oKaMULmHQEmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I7mDKGKbFreEbdicYlSCjmLu46u58F30+bCFeiohJGgeMbn/mbFN1xu0i09ZpnznQGPwC+y8yt4IrDuqjEZK8i1D0ttlgwGL9PtgZPie9dfqSvgXqdcESNvF7qDZUxKh0ltSffxdjIBZ4lxNSl8ERwh4GiHKvZZRjKhE64WblL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TntPXKLo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TntPXKLo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6480A1F00A3A;
	Tue, 21 Jul 2026 13:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784640423;
	bh=GVLhNSiA5sK4zlggq3n3wsWEvUQ5cAF5wO5yeR1DrDY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TntPXKLoJApf7ouvoJCzLlrKnXgtXi24CE53d7+kUUCXzc2yDmGFlSYQCzO+pStEl
	 xx73VPkjFQEmr45X6EF7JfRMFnd+3rZaJRkDltElx/9yjBs9HoS6CVc+WSFRp3SnHg
	 2niKzWTZDwlrxrr45/hYLTGNL12KCOmPdJR4oLe8NtdPeLABsIM+Q9fZAw/H/roGQD
	 oW/19k62yU+3e0tYpVP3qSZMtxnjBPnAw//I3/wJm5EvpKHojWQkMYXqKiCpk8IAvV
	 z7UQ9vKWPFYo8fE55OSt00oosU+WrQKk6XtAqC/EjUu7IshgjaO5gVVJrMyFdRG++R
	 iveyCrSV5ZrvA==
Message-ID: <d98128fe-079c-4145-9e4f-68cbdc9702dd@kernel.org>
Date: Tue, 21 Jul 2026 16:27:00 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] media: microchip-isc: fix awb_mutex and lock
 lifecycle
To: Balakrishnan Sambath <balakrishnan.s@microchip.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260721-balki-isc-prefix-fixes-v1-v3-0-ffe10640a2d9@microchip.com>
 <20260721-balki-isc-prefix-fixes-v1-v3-1-ffe10640a2d9@microchip.com>
Content-Language: en-US
From: Eugen Hristev <ehristev@kernel.org>
In-Reply-To: <20260721-balki-isc-prefix-fixes-v1-v3-1-ffe10640a2d9@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/21/26 13:28, Balakrishnan Sambath wrote:
> isc_async_complete() initialised awb_mutex and isc->lock only after an
> early error return, and the teardown was inconsistent:
> 
>  - isc_async_unbind() destroyed awb_mutex before cancelling awb_work,
>    which takes it;
>  - a failed .complete() destroyed both locks, then the v4l2-async core
>    unbinds the subdev and isc_async_unbind() destroyed awb_mutex again;
>  - isc->lock was destroyed only on the .complete() error path, so the
>    normal unbind path leaked it.
> 
> Initialise both locks before the first error return, make unbind the
> single teardown site (cancel the work, then destroy both locks) and
> drop the destroys from the .complete() error path.
> 
> Fixes: 314c96e5203d ("media: atmel: atmel-isc-base: use mutex to lock awb workq from streaming")
> Cc: stable@vger.kernel.org
> Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
> ---
>  drivers/media/platform/microchip/microchip-isc-base.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/media/platform/microchip/microchip-isc-base.c b/drivers/media/platform/microchip/microchip-isc-base.c
> index a7cdc743fda7..45a7af779323 100644
> --- a/drivers/media/platform/microchip/microchip-isc-base.c
> +++ b/drivers/media/platform/microchip/microchip-isc-base.c
> @@ -1703,10 +1703,11 @@ static void isc_async_unbind(struct v4l2_async_notifier *notifier,
>  {
>  	struct isc_device *isc = container_of(notifier->v4l2_dev,
>  					      struct isc_device, v4l2_dev);
> -	mutex_destroy(&isc->awb_mutex);
>  	cancel_work_sync(&isc->awb_work);
> +	mutex_destroy(&isc->awb_mutex);
>  	video_unregister_device(&isc->video_dev);
>  	v4l2_ctrl_handler_free(&isc->ctrls.handler);
> +	mutex_destroy(&isc->lock);
>  }
>  
>  struct isc_format *isc_find_format_by_code(struct isc_device *isc,
> @@ -1758,6 +1759,8 @@ static int isc_async_complete(struct v4l2_async_notifier *notifier)
>  	int ret = 0;
>  
>  	INIT_WORK(&isc->awb_work, isc_awb_work);
> +	mutex_init(&isc->lock);
> +	mutex_init(&isc->awb_mutex);

Does it make sense to reinit these mutexes again every time complete()
is called , and not get destroyed here in case of an err ?

The way I understand it, is isc_async_complete() will init them, then
some other function would destroy them, but that destroy is called in
every single case ?
It is odd that a failing function in this case would leave mutexes
initialized and not destroyed, when the function itself would initialize
them. It would not leave the device in the same state , after failing .
Which is quite odd.
I am thinking whether it's better to allocate these mutexes at probe and
have them all the time, and teardown on remove(). Is that making more
sense ?

>  
>  	ret = v4l2_device_register_subdev_nodes(&isc->v4l2_dev);
>  	if (ret < 0) {
> @@ -1767,8 +1770,6 @@ static int isc_async_complete(struct v4l2_async_notifier *notifier)
>  
>  	isc->current_subdev = container_of(notifier,
>  					   struct isc_subdev_entity, notifier);
> -	mutex_init(&isc->lock);
> -	mutex_init(&isc->awb_mutex);
>  
>  	init_completion(&isc->comp);
>  
> @@ -1841,8 +1842,6 @@ static int isc_async_complete(struct v4l2_async_notifier *notifier)
>  	video_unregister_device(vdev);
>  
>  isc_async_complete_err:
> -	mutex_destroy(&isc->awb_mutex);
> -	mutex_destroy(&isc->lock);
>  	return ret;

If now isc_async_complete_err just returns ret, does it still make sense
to have this label ? Or just return ret instead of goto [...] ?

>  }
>  
> 

