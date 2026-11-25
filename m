Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795592448;
	b=LOvAQ2CqvyhUslS07sYB+ihQMzqzNk2lQZ1wNL0jn1RdEeMlQfDw2C7v1rjpdUIsDJ+y
	 4bfmxRcM/W6vdbHZgWV3XjFaGcnJ3ePORIkLqkuuxtbQxYE4vKcPFmmOnjiaNivmE215k
	 h1qagO7dA6ButQhiMAD1KhtCkKa35axOlHUJxrQSJaLNOhv1jZ09XueIScEJ8IPvWXDVc
	 lox+A9l0p75dYkBPQaAefshg7aPApIjvMOIcXT3oIEk4+XJW1wh2s/AX7n0r7DeEL8lnv
	 vVhu+UNHELkOo6kmmkxRcmhbtuIOhLwP+y8wxt4rB6ftEcFt3ZX9P0jrB3ikcWwLK/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795592448;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:From:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=LGaDNR7nBTs/UabrOSGv8Fp+nUmQmdrdd/i7qM58HNE=;
	b=ii9hqN2RzokJN8yAlhqM92r/LTFWWDgY1OqPx2yPAKZBpON3xdtit7h4d2EhlJO9cRQl
	 EGB8ajfSVY59haKB0puJSxnS4/tycTAxxUqB9iOqAB83mlH8wA9f8NRNwiFYwtJBkQEKe
	 Way0eG5StehyMaJJtcn8TZl9NrTSJhKGdsGz0nTMfLccIyN6O9HWQQWTmTywhzO5sL88L
	 jhDw0zguyC4je2Uw5wPPbxFHgwR7xL3zTMaJXjBrtLOQlCw0UlCc90queLN/Q3CiwFL2D
	 o/LIxdJF/ftfg0M7blT/sc7Ydc7i2OMXi9dTVU41MkV2oduo8nQpY21d9GXsLsQ86nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ji8pCcem;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DF1606A31E;
	Wed, 25 Nov 2026 07:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ji8pCcem
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561EF1F000C0;
	Wed, 25 Nov 2026 07:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795592448;
	bh=LGaDNR7nBTs/UabrOSGv8Fp+nUmQmdrdd/i7qM58HNE=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=ji8pCcem+8F1a8auh5fNMdBTUdxFonVVLGT2G8SR3j0V2r5+jV7JUXiOGo+C2h0nx
	 /QwGCogNjr20CTz2sVlrH2vcowx9T+fUzyyLhTAE/hPoDMNfqFYI0xXuq3eD9vaxvS
	 uwgJXYNwb/dufNZZbBtLpHZArKPPeBNZYjPsZtVYPdVm9fzA1lNYvK73xeuuTkQlVQ
	 BvCDmRs1+rvoTkrsY1q6auK+FvUu5MDQOnJirKU8MQ+Id8JNpKps+XPRoOJku8JWFT
	 ClOD7KLOE0pQ5AvScb0lw7Q1+IBhseD09PZShF6S/Ej+NHdNe7JnO76LBVLJAgZNL/
	 LYec9vz++ZZUg==
Message-ID: <403ad923-6430-42bc-9e16-f02033743a70@kernel.org>
Date: Wed, 25 Nov 2026 08:40:45 +0100
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
Subject: Re: [PATCH v2 1/2] media: em28xx: defer media_device cleanup and free
 to em28xx_free_device()
To: Arbab Haider <arbabhaider649@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261122222325.41868-2-arbabhaider649@gmail.com>
Content-Language: en-US, nl
In-Reply-To: <20261122222325.41868-2-arbabhaider649@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/11/2026 23:23, Arbab Haider wrote:
> When a USB em28xx device is disconnected while a V4L2 device node
> (e.g. /dev/video0) is still open, em28xx_usb_disconnect() calls
> em28xx_release_resources() -> em28xx_unregister_media_device(), which
> calls media_device_cleanup() and kfree(dev->media_dev) immediately.
> 
> However, struct em28xx_v4l2 remains alive until the last open file
> handle is closed, and v4l2->v4l2_dev.mdev still points to the freed
> media_device.  When userspace subsequently closes /dev/video0,
> v4l2_release() calls v4l2_device_supports_requests(vdev->v4l2_dev),
> dereferencing vdev->v4l2_dev->mdev->ops and triggering a KASAN
> slab-use-after-free:
> 
>   BUG: KASAN: slab-use-after-free in v4l2_release+0x325/0x380
>   Read of size 8 at addr ffff88800787a260 by task test_em28xx_uaf/53
>   ...
>   Freed by task 30:
>    kfree+0x162/0x410
>    em28xx_unregister_media_device+0xa4/0xe0
>    em28xx_release_resources+0x70/0x170
>    em28xx_usb_disconnect.cold+0x107/0x2a3
> 
> Split em28xx_unregister_media_device() so it only calls
> media_device_unregister(dev->media_dev) on disconnect, and move
> media_device_cleanup() and kfree(dev->media_dev) into a new
> em28xx_cleanup_media_device() helper called from em28xx_free_device()
> (once the last dev->ref reference, including em28xx_free_v4l2(), has
> been dropped) and from em28xx_init_dev()'s error path.
> 
> Tested locally in QEMU (x86_64, KASAN+UBSAN) using dummy_hcd and
> raw-gadget emulating an EM2820 device across open->disconnect->close,
> repeated disconnect, dual-fd open->disconnect->close, and normal
> open->close->disconnect scenarios (8/8 passed, 0 KASAN reports).
> 
> Fixes: 37ecc7b1278f ("[media] em28xx: add media controller support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Arbab Haider <arbabhaider649@gmail.com>

This patch no longer applies, can you rebase it on top of
https://gitlab.freedesktop.org/linux-media/media-committers, next branch?

Thank you,

	Hans

> ---
> Changes in v2:
> - Add Fixes: tag as requested by Media CI.
> 
>  drivers/media/usb/em28xx/em28xx-cards.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/usb/em28xx/em28xx-cards.c b/drivers/media/usb/em28xx/em28xx-cards.c
> index 1d4f30cba..d8f2e40b7 100644
> --- a/drivers/media/usb/em28xx/em28xx-cards.c
> +++ b/drivers/media/usb/em28xx/em28xx-cards.c
> @@ -3773,8 +3773,15 @@ static int em28xx_media_device_init(struct em28xx *dev,
>  static void em28xx_unregister_media_device(struct em28xx *dev)
>  {
>  #ifdef CONFIG_MEDIA_CONTROLLER
> -	if (dev->media_dev) {
> +	if (dev->media_dev)
>  		media_device_unregister(dev->media_dev);
> +#endif
> +}
> +
> +static void em28xx_cleanup_media_device(struct em28xx *dev)
> +{
> +#ifdef CONFIG_MEDIA_CONTROLLER
> +	if (dev->media_dev) {
>  		media_device_cleanup(dev->media_dev);
>  		kfree(dev->media_dev);
>  		dev->media_dev = NULL;
> @@ -3826,6 +3833,8 @@ void em28xx_free_device(struct kref *ref)
>  	if (!dev->disconnected)
>  		em28xx_release_resources(dev);
>  
> +	em28xx_cleanup_media_device(dev);
> +
>  	if (dev->ts == PRIMARY_TS)
>  		kfree(dev->alt_max_pkt_size_isoc);
>  
> @@ -3997,6 +4006,7 @@ static int em28xx_init_dev(struct em28xx *dev, struct usb_device *udev,
>  	em28xx_i2c_unregister(dev, 0);
>  err_deinit_media:
>  	em28xx_unregister_media_device(dev);
> +	em28xx_cleanup_media_device(dev);
>  	return retval;
>  }
>  

