Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795592415;
	b=xznFAu4OzUh8DYfTLZm6uLYt4NsTiZbi4zrr2YpcerDPRUhN8UsQsk7NhYvKE8LkBYeQ
	 H9Sr8rGdoHUgYUk1fIWWkW2h1630X2h5oFB/9ZtobutUqvMNezwzFYSv6YaSjw7XDnpng
	 vSq6pRh+cw6bTr9Gf7XxRV0rWfb3HFlWYypmfX8g3jTMgrODSUfveFVu59QTSqhkhkGGh
	 +D9IiIt0enk+g+y6W2wZb86jFilIPrDySxfljvtJeHCgNAGimGOdDKCQIwRcG6YaXuZ3G
	 rQxsZ+G3vB50N5kpunW5FxL8g/KqQ3paxLDroKtA6h8sHIU7eQFdG/8618lY11cP2xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795592415;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:From:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=KAbequCzdOeu/XSdB92JF9NBPgxvhkaWdVmOOtV8r4U=;
	b=OppKYrhkgh6Pli03shoJ5RUJYBNkk+7ca8iSDGgZZkWwsyUFuyQhR4i4kgt5zZsRMyzo
	 4gehAAYB7dE6wjRBMZYv7Ju2L6aSlGblKWfs+zyj+vN0foSWO7+La6UwI+mmcN02tirCF
	 tmoWaAkv2VpZgMCoh/IPk6wYQYgzGhu62CkdmuBf0ks4kk+LfsKwNR+DhJ6G4nvs7AOem
	 IEjEy/U2knUpp0hw9gUfNzqJ7uPDF2VWZxBmoiUMKZTpYhBEXsNOe5AZUjFQMRDU2c3fJ
	 Fj6qyLW3ybE8rBhE6Sqpb58JPrpjx0qY4WRxKCXwjCJZbvSi8ipK9QmnRXKB522J70A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L8MkeZj7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C119B606A31E;
	Wed, 25 Nov 2026 07:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L8MkeZj7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6571F000C0;
	Wed, 25 Nov 2026 07:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795592415;
	bh=KAbequCzdOeu/XSdB92JF9NBPgxvhkaWdVmOOtV8r4U=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=L8MkeZj7tQsOMvritTHVEh+iIT3E575Y/1h8j9oOOfaD7SirLMvTfKcM8aYKRGgKy
	 owHB+SzaXykkek+bdJQ41PJsG7xT3hqBYrx8bnNwTExB1w6S8YOoBWTW7u0zP5PIXj
	 U+gTA1IGzREMYQyCO0BSEFOnxM9dR8pg3Nl9+fmMuy38NAOfsmtsOy3Y6zz71hqU44
	 9PiVdN2ra8rmnPug2Ug6pyb+X2u6FXiQdWs/BhuFZ0BRTIpo1DYWrpl/ytws3erLft
	 0vt/+c7tcTB09EDe9Xcfej7xVLjROpLrQPRqHXxMwmohnAtS741v8d5heipAHjZiei
	 a02rSkE/eOl3Q==
Message-ID: <4724fb41-06a0-457c-be3a-25ad9e49e25f@kernel.org>
Date: Wed, 25 Nov 2026 08:40:12 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH] media: em28xx: clear dev->v4l2 on init failure and fini
 to avoid double put
To: Arbab Haider <arbabhaider649@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+fb0d2df09b56117605fc@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20261122190008.21278-2-arbabhaider649@gmail.com>
Content-Language: en-US, nl
In-Reply-To: <20261122190008.21278-2-arbabhaider649@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/11/2026 20:00, Arbab Haider wrote:
> Commit 288254383674 ("media: em28xx: use v4l2_device release callback")
> switched em28xx_v4l2 teardown to v4l2_device reference counting, where
> dev->v4l2 is only cleared inside em28xx_free_v4l2() once the refcount
> reaches zero.
> 
> If em28xx_v4l2_init() fails after video_register_device() (for example,
> when v4l2_mc_create_media_graph() returns -EINVAL) while userspace has
> opened the video node, the unregister_dev error path calls
> v4l2_device_put(&v4l2->v4l2_dev) to drop the initial reference, but
> em28xx_free_v4l2() does not run yet because the open file handle still
> holds a reference, leaving dev->v4l2 non-NULL.
> 
> When the USB device is subsequently disconnected, em28xx_v4l2_fini()
> sees dev->v4l2 != NULL and calls v4l2_device_put(&v4l2->v4l2_dev) a
> second time for the initial reference, freeing struct em28xx_v4l2 while
> the video device node is still referenced and causing a
> slab-use-after-free in media_device_unregister() /
> __media_entity_remove_links().
> 
> Fix this by:
> - Calling v4l2_device_disconnect() and clearing dev->v4l2 = NULL under
>   dev->lock in em28xx_v4l2_init()'s unregister_dev path before dropping
>   the initial v4l2_device reference.
> - Checking and clearing dev->v4l2 under dev->lock in em28xx_v4l2_fini()
>   so the initial reference is dropped at most once.
> - Reading dev->v4l2 under dev->lock and checking for !v4l2 in
>   em28xx_v4l2_close() so a close racing with teardown cannot dereference
>   a NULL pointer.
> 
> Tested locally in QEMU (x86_64, KASAN+UBSAN) using dummy_hcd and
> raw-gadget emulating an EM2820 device with failed media graph creation
> and concurrent /dev/video0 open/disconnect.
> 
> Reported-by: syzbot+fb0d2df09b56117605fc@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=fb0d2df09b56117605fc
> Fixes: 288254383674 ("media: em28xx: use v4l2_device release callback")
> Cc: stable@vger.kernel.org
> Signed-off-by: Arbab Haider <arbabhaider649@gmail.com>

This patch no longer applies, can you rebase it on top of
https://gitlab.freedesktop.org/linux-media/media-committers, next branch?

This patch might not be needed anymore, it's unclear.

Regards,

	Hans

> ---
>  drivers/media/usb/em28xx/em28xx-video.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/media/usb/em28xx/em28xx-video.c b/drivers/media/usb/em28xx/em28xx-video.c
> index 84424284d..50998aa1c 100644
> --- a/drivers/media/usb/em28xx/em28xx-video.c
> +++ b/drivers/media/usb/em28xx/em28xx-video.c
> @@ -2333,7 +2333,6 @@ static void em28xx_free_v4l2(struct v4l2_device *v4l2_dev)
>  
>  	v4l2_ctrl_handler_free(&v4l2->ctrl_handler);
>  	v4l2_device_unregister(v4l2_dev);
> -	dev->v4l2 = NULL;
>  	kfree(v4l2);
>  	kref_put(&dev->ref, em28xx_free_device);
>  }
> @@ -2414,7 +2413,7 @@ static int em28xx_v4l2_open(struct file *filp)
>   */
>  static int em28xx_v4l2_fini(struct em28xx *dev)
>  {
> -	struct em28xx_v4l2 *v4l2 = dev->v4l2;
> +	struct em28xx_v4l2 *v4l2;
>  
>  	if (dev->is_audio_only) {
>  		/* Shouldn't initialize IR for this interface */
> @@ -2426,13 +2425,16 @@ static int em28xx_v4l2_fini(struct em28xx *dev)
>  		return 0;
>  	}
>  
> -	if (!v4l2)
> +	mutex_lock(&dev->lock);
> +
> +	v4l2 = dev->v4l2;
> +	if (!v4l2) {
> +		mutex_unlock(&dev->lock);
>  		return 0;
> +	}
>  
>  	dev_info(&dev->intf->dev, "Closing video extension\n");
>  
> -	mutex_lock(&dev->lock);
> -
>  	v4l2_device_disconnect(&v4l2->v4l2_dev);
>  
>  	em28xx_uninit_usb_xfer(dev, EM28XX_ANALOG_MODE);
> @@ -2455,6 +2457,8 @@ static int em28xx_v4l2_fini(struct em28xx *dev)
>  		vb2_video_unregister_device(&v4l2->vdev);
>  	}
>  
> +	dev->v4l2 = NULL;
> +
>  	mutex_unlock(&dev->lock);
>  
>  	/*
> @@ -2502,18 +2506,19 @@ static int em28xx_v4l2_close(struct file *filp)
>  {
>  	struct video_device   *vdev = video_devdata(filp);
>  	struct em28xx         *dev  = video_drvdata(filp);
> -	struct em28xx_v4l2    *v4l2 = dev->v4l2;
> +	struct em28xx_v4l2    *v4l2;
>  	struct usb_device *udev = interface_to_usbdev(dev->intf);
>  	int              err;
>  	bool last_user;
>  
>  	mutex_lock(&dev->lock);
> +	v4l2 = dev->v4l2;
>  	last_user = v4l2_fh_is_singular_file(filp);
>  	_vb2_fop_release(filp, vdev->queue->lock);
>  
>  	if (last_user) {
>  		/* No sense to try to write to the device */
> -		if (dev->disconnected)
> +		if (dev->disconnected || !v4l2)
>  			goto exit;
>  
>  		/* Save some power by putting tuner to sleep */
> @@ -3110,6 +3115,8 @@ static int em28xx_v4l2_init(struct em28xx *dev)
>  	return 0;
>  
>  unregister_dev:
> +	v4l2_device_disconnect(&v4l2->v4l2_dev);
> +
>  	if (video_is_registered(&v4l2->radio_dev)) {
>  		dev_info(&dev->intf->dev,
>  			 "V4L2 device %s deregistered\n",
> @@ -3129,6 +3136,8 @@ static int em28xx_v4l2_init(struct em28xx *dev)
>  		vb2_video_unregister_device(&v4l2->vdev);
>  	}
>  
> +	dev->v4l2 = NULL;
> +
>  	mutex_unlock(&dev->lock);
>  
>  	/*

