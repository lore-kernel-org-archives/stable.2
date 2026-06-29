Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4745D3DD50F;
	Mon, 29 Jun 2026 07:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782719144; cv=none; b=ihLZQO181Yxbs3evK1yse5fCzOrDlJUuHZA8b5mWX2nEJYFfw5/oh+cadY3Qps3l3dfSZS7Cu5TXWM7ZunshLu12SoQ3CiNyZttU1NaaNYcGZtWw22mV4HRJQ2nsOGF1RQhFxkPePRa1sFG5+DEMSX5k1wnFSUD4t0qD3aHMnZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782719144; c=relaxed/simple;
	bh=GdOSW+9QpbI+GOCh/RF/AckWXho4xoQ8zdx+rrMu8RI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gguaqOJw9w5I4Or3WUgHHTsTM9/oZRP1GpAVPLrLfOa0XFNU/crE9K3GGd51/HS5c/0ceZaN0BwesJzMD04Vmc0QfNmHeFn6UJlyUyodLPIZYfCeY/VoVXqJVfk4QOSs4b4HnaXC1xg58B5C6BEdTJJhfUEMNwmAnxiraLkdEJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3/GFQ8Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3/GFQ8Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5D31F00A3A;
	Mon, 29 Jun 2026 07:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782719137;
	bh=X0uYIgycRQfmlWGtZQLMUu7Bf9aoXkgVqzrHIxUISYM=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=S3/GFQ8ZHJP33yNpAHgjlK04oWaIhQn9/JJ7ugdwUgAybIrffOlWXC8gbrimqKxGl
	 lH5wg/52z9ldIDSLDr5sPVjCD7AV1+F8c//nYYQfZmPSv6ds0vRyEdvvkMy7/eHhCx
	 D+BShmZcHknlfPmvdVPInaB9rNtxADquwvWimiexfd4hXBzd4p0Xx5UqVsBjj4/TzQ
	 isfN3oF1XnrNGhFYu2xGB5qabTM7DbJ5H4Ztyp1fAlriprvHMl5SDyT06r7vqtoe/B
	 xJbBkH9L2FHJpEkQqG3JsshZ4TzvQrtliCUX1e3x5WUmKnUW4Mp8MBP7jToam0Muoh
	 9m8PnjcrBi5FA==
Message-ID: <e0c25e65-8e07-41bc-a165-ae5e770a71a2@kernel.org>
Date: Mon, 29 Jun 2026 09:45:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH] media: em28xx: keep device state alive for registered
 video nodes
To: Yousef Alhouseen <alhouseenyousef@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Abhishek Kumar <abhishek_sts8@yahoo.com>, stable@vger.kernel.org,
 syzbot+39ff299961a7c07f00f0@syzkaller.appspotmail.com
References: <20260628003103.24832-1-alhouseenyousef@gmail.com>
Content-Language: en-US, nl
In-Reply-To: <20260628003103.24832-1-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/06/2026 02:31, Yousef Alhouseen wrote:
> The V4L2 core takes a video_device reference before invoking the
> driver open callback. That reference does not protect em28xx state
> because all three video_device objects are embedded in em28xx_v4l2 and
> use video_device_release_empty().
> 
> If initialization fails after registering a node, the error path can
> unregister it and drop the last em28xx_v4l2 reference while a concurrent
> open has passed the core registration check. The open callback then
> dereferences the freed video_device in video_drvdata(), as observed by
> KASAN. A disconnect has the same lifetime gap.
> 
> Give each successfully registered video node references to both the
> enclosing V4L2 state and the parent em28xx device. Release those
> references from the video_device release callback, after the core has
> drained pending opens and existing file references.

This patch series should fix this issue properly:

https://patchwork.linuxtv.org/project/linux-media/list/?series=26968

Rejecting this patch, manually manipulating refcounts is not the way to go.

Regards,

	Hans

> 
> Fixes: ef74a0b9ff56 ("[media] em28xx: move video_device structs from struct em28xx to struct v4l2")
> Reported-by: syzbot+39ff299961a7c07f00f0@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=39ff299961a7c07f00f0
> Cc: stable@vger.kernel.org
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> ---
>  drivers/media/usb/em28xx/em28xx-video.c | 35 +++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/usb/em28xx/em28xx-video.c b/drivers/media/usb/em28xx/em28xx-video.c
> index da0422c65e5f..4274a9bcb432 100644
> --- a/drivers/media/usb/em28xx/em28xx-video.c
> +++ b/drivers/media/usb/em28xx/em28xx-video.c
> @@ -2289,6 +2289,31 @@ static void em28xx_free_v4l2(struct kref *ref)
>  	kfree(v4l2);
>  }
>  
> +static void em28xx_vdev_release(struct video_device *vdev)
> +{
> +	struct em28xx_v4l2 *v4l2;
> +	struct em28xx *dev;
> +
> +	switch (vdev->vfl_type) {
> +	case VFL_TYPE_VIDEO:
> +		v4l2 = container_of(vdev, struct em28xx_v4l2, vdev);
> +		break;
> +	case VFL_TYPE_VBI:
> +		v4l2 = container_of(vdev, struct em28xx_v4l2, vbi_dev);
> +		break;
> +	case VFL_TYPE_RADIO:
> +		v4l2 = container_of(vdev, struct em28xx_v4l2, radio_dev);
> +		break;
> +	default:
> +		WARN_ON_ONCE(1);
> +		return;
> +	}
> +
> +	dev = v4l2->dev;
> +	kref_put(&v4l2->ref, em28xx_free_v4l2);
> +	kref_put(&dev->ref, em28xx_free_device);
> +}
> +
>  /*
>   * em28xx_v4l2_open()
>   * inits the device and starts isoc transfer
> @@ -2554,7 +2579,7 @@ static const struct v4l2_ioctl_ops video_ioctl_ops = {
>  static const struct video_device em28xx_video_template = {
>  	.fops		= &em28xx_v4l_fops,
>  	.ioctl_ops	= &video_ioctl_ops,
> -	.release	= video_device_release_empty,
> +	.release	= em28xx_vdev_release,
>  	.tvnorms	= V4L2_STD_ALL,
>  };
>  
> @@ -2583,7 +2608,7 @@ static const struct v4l2_ioctl_ops radio_ioctl_ops = {
>  static struct video_device em28xx_radio_template = {
>  	.fops		= &radio_fops,
>  	.ioctl_ops	= &radio_ioctl_ops,
> -	.release	= video_device_release_empty,
> +	.release	= em28xx_vdev_release,
>  };
>  
>  /* I2C possible address to saa7115, tvp5150, msp3400, tvaudio */
> @@ -2965,6 +2990,8 @@ static int em28xx_v4l2_init(struct em28xx *dev)
>  			"unable to register video device (error=%i).\n", ret);
>  		goto unregister_dev;
>  	}
> +	kref_get(&v4l2->ref);
> +	kref_get(&dev->ref);
>  
>  	/* Allocate and fill vbi video_device struct */
>  	if (em28xx_vbi_supported(dev) == 1) {
> @@ -2999,6 +3026,8 @@ static int em28xx_v4l2_init(struct em28xx *dev)
>  				"unable to register vbi device\n");
>  			goto unregister_dev;
>  		}
> +		kref_get(&v4l2->ref);
> +		kref_get(&dev->ref);
>  	}
>  
>  	if (em28xx_boards[dev->model].radio.type == EM28XX_RADIO) {
> @@ -3012,6 +3041,8 @@ static int em28xx_v4l2_init(struct em28xx *dev)
>  				"can't register radio device\n");
>  			goto unregister_dev;
>  		}
> +		kref_get(&v4l2->ref);
> +		kref_get(&dev->ref);
>  		dev_info(&dev->intf->dev,
>  			 "Registered radio device as %s\n",
>  			 video_device_node_name(&v4l2->radio_dev));

