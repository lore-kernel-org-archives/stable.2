Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3E7446BE0;
	Wed, 30 Sep 2026 08:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790755541; cv=none; b=NGlRiH7OcpfitkO3Y7U+6fxdUdEVol8tWmw6D7N/rVtWYEL2M6KxSfU7YOev+ne9yikp4+bSl4aRQVJ3qIJvMaWfyCnJwyoj+W3PPjGJthXP1CzwuIBJNShkb/gK3/9LVZlgILq3FQHzMQTBWULWUlOvkYuTa3ITa6FJcgdEP3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790755541; c=relaxed/simple;
	bh=bA5RGmVi8QPO47pRoIpnyvShczznrPxAsOYKaVmvejE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BU/jaglc+AYmWPWYAdDcy8fvZT9hTW3sL4hUawWCbnxjOI+PE37f5tAI8EYLcvO1ENK7PKF89AcEhf09YfQ3jgr86kE5zckM1B9H+6yODaZ9FhzywiE//p8xiWj/ROAF5Cz2VM2IWz26bWkTod3a4irNCW9NksF25RaoHVnQge0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3vod8ec; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3vod8ec"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FBA01F00898;
	Wed, 30 Sep 2026 08:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790755540;
	bh=oHu8TD0gBwvICgVAe5FHk53wpXDvt9OKTi0hPQxVrpo=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=e3vod8ecaON3MlO8JKRjVWhHj1yMfcW4yx5O+pJ2Qae8Wy+hSVsrwCyLtSBV3RFYm
	 wmXodDi4gBJIGdMiJI+kRZyP5duK2oe1mw3e7nCXKZCT9iBSqy9fR2BUJvisEABpzo
	 V8YDI81f7GYT7EQNF4qc3OwyMqwxbNjMhdzikyqCyxByk5mDb1PpUHpqLSzJZxhH+v
	 jd9nc0DqJCQXH2oqq/wWOYOZTWMOAQ7fSciZ7gIbScr/Fn5e4TlrcQqX0B5ULvnCfQ
	 2hN/27hdioI0MC2cYekVnfsP2zUx7CGXlxTZOKlI/uQHkiRLUrtlqayogBWrprR/Ti
	 mzNKqmaoj6jyQ==
Message-ID: <48b7f6ef-e5f9-445e-820d-fdfd1458452b@kernel.org>
Date: Wed, 30 Sep 2026 10:05:37 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH v1 2/2] Input: sur40 - keep device state alive until the
 video node is released
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
 dmitry.torokhov@gmail.com
Cc: floe@butterbrot.org, linux-input@vger.kernel.org,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+eb4706daf505f9c4b547@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20260920113949.12726-1-ngocthang2710.1999@gmail.com>
 <20260920113949.12726-3-ngocthang2710.1999@gmail.com>
Content-Language: en-US, nl
In-Reply-To: <20260920113949.12726-3-ngocthang2710.1999@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/09/2026 13:39, Nguyen Ngoc Thang wrote:
> sur40_disconnect() frees the sur40_state, which embeds the video_device,
> the v4l2_device and the vb2_queue, while a video node may still be open.
> Closing that file afterwards touches freed memory:
> 
>   BUG: KASAN: slab-use-after-free in vb2_core_queue_release+0x12d/0x150
>   Read of size 4 at addr ffff888066fa8aa8 by task v4l_id/28733
>    vb2_core_queue_release+0x12d/0x150
>    vb2_fop_release+0x16e/0x200
>    v4l2_release+0x22c/0x350
>    __fput+0x418/0xa50
>   Freed by task 16811:
>    kfree+0x1c5/0x650
>    sur40_disconnect+0xaf/0x140
> 
> Give the v4l2_device a release callback that frees the bulk buffer and
> the state, and drop the disconnect path's own reference with
> v4l2_device_put(). The last closer of the node then does the freeing.
> The probe error paths never open the node and keep freeing directly.
> 
> Reported-by: syzbot+eb4706daf505f9c4b547@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=eb4706daf505f9c4b547
> Fixes: e831cd251fb9 ("[media] add raw video stream support for Samsung SUR40")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>

Reviewed-by: Hans Verkuil <hverkuil+cisco@kernel.org>

Regards,

	Hans

> ---
>  drivers/input/touchscreen/sur40.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
> index 7020bcf9b81a..efd4fe557cef 100644
> --- a/drivers/input/touchscreen/sur40.c
> +++ b/drivers/input/touchscreen/sur40.c
> @@ -648,6 +648,15 @@ static int sur40_input_setup_events(struct input_dev *input_dev)
>  }
>  
>  /* Check candidate USB interface. */
> +/* Runs once the last video node reference is gone. */
> +static void sur40_release(struct v4l2_device *v4l2)
> +{
> +	struct sur40_state *sur40 = container_of(v4l2, struct sur40_state, v4l2);
> +
> +	kfree(sur40->bulk_in_buffer);
> +	kfree(sur40);
> +}
> +
>  static int sur40_probe(struct usb_interface *interface,
>  		       const struct usb_device_id *id)
>  {
> @@ -733,6 +742,7 @@ static int sur40_probe(struct usb_interface *interface,
>  			"Unable to register video master device.");
>  		goto err_free_buffer;
>  	}
> +	sur40->v4l2.release = sur40_release;
>  
>  	/* initialize the lock and subdevice */
>  	sur40->queue = sur40_queue;
> @@ -831,11 +841,10 @@ static void sur40_disconnect(struct usb_interface *interface)
>  	video_unregister_device(&sur40->vdev);
>  	v4l2_device_unregister(&sur40->v4l2);
>  
> -	kfree(sur40->bulk_in_buffer);
> -	kfree(sur40);
> -
>  	usb_set_intfdata(interface, NULL);
>  	dev_dbg(&interface->dev, "%s is now disconnected\n", DRIVER_DESC);
> +
> +	v4l2_device_put(&sur40->v4l2);
>  }
>  
>  /*

