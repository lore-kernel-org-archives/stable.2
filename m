Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C731A9B24;
	Mon, 29 Jun 2026 13:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782739991; cv=none; b=OX17S4ktp/2pjdWOe+dV+mLfhqxSEpsHQXrTBfFhSZamS0Y/L9DYMIVYI16/nOjIYTf+OFdE+GyEcJGRfUKOle3FipQlG3/xRrU67TsnzqVJ+Vkkkpc6eiLo8k47SyDOExNpfpNUWoGSAv6o/2IPxTqPpzqTa64Sr5Y6sPxfD/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782739991; c=relaxed/simple;
	bh=QCFBw/xJRQ/J1HKN/dIIyJ1SeNj2agIKOaeZDEM0KSM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ujVMGjXF9b67CpaUnIzCzTchopR0keyR7BnkQdV6EsjbWQxOIJLAeyE+Eke1NNL1KJq397XY3NmKCfF8/poeBrDnXhu/Lul1/lHWqm10N3qiOnYlMIFUJ4uZBBEFNDFQV2Dw1SrgOMJ/6aW6iASfPfrcb1arWt6hCTlv3vlVVpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVp7bkZD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVp7bkZD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E8A71F000E9;
	Mon, 29 Jun 2026 13:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782739989;
	bh=aVfOEMQ8FHgyc6cNNe2Ze8iDiCaW4tFzEyy8N2ynY0Q=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=jVp7bkZDWMWWYny/2Cd3m/wnt0A9I0f9IoBhXrpNxcBylYE+T7f3bYwe35LVBSvaF
	 uUsuz7vJ/sABsA9WRyowtd2l4q3mqP8GfflXSj0SDBeq3DY0e3XzR8yNRVL86PEY6D
	 5SXyC9QKPFSgmqPW3D5f2ZEYlAzg8fQ24hgYx5Fw4GEG0zZBgCJJDUqfeXWSLNhwDl
	 zLTGAO6kg8+ysJ6NsodOegQfXsLBFPhbIjddd0qotTFuRx13uznHYH5pbhKvXlgIPO
	 xb9ipYhfxK3qbewuWWHnXRMchLQ7njWNr3lisl7qNW5bOfI4VcT6hB8t/KnJTMrESS
	 IqMcRK52uKcnw==
Message-ID: <525600ac-f304-4a5c-b50c-b0051756c1a6@kernel.org>
Date: Mon, 29 Jun 2026 15:33:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH 4/4] Input: sur40 - fix V4L2 video device lifetime
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Hans Verkuil <hverkuil@kernel.org>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, sashiko-bot@kernel.org,
 stable@vger.kernel.org
References: <20260616051235.1549517-1-dmitry.torokhov@gmail.com>
 <20260616051235.1549517-4-dmitry.torokhov@gmail.com>
Content-Language: en-US, nl
In-Reply-To: <20260616051235.1549517-4-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/06/2026 07:12, Dmitry Torokhov wrote:
> sur40_disconnect() synchronously frees the sur40_state structure (kfree(sur40))
> while userspace might still hold an open file descriptor to the V4L2 video
> device node. When userspace later accesses or closes the lingering file
> descriptor, the V4L2 core invokes file operations (such as vb2_fop_release)
> that dereference the already freed sur40 memory, resulting in a use-after-free
> vulnerability.
> 
> Fix this by implementing a V4L2 release callback (sur40_video_release) in
> sur40_video_device to clean up V4L2 components and free the sur40 structure
> only when the last video file descriptor is closed.
> 
> Additionally, update the sur40_probe() error path to call video_unregister_device()
> and return inline if input initialization fails after video device registration
> succeeded, allowing the V4L2 release callback to manage cleanup.
> 
> Also, call v4l2_device_disconnect() in sur40_disconnect() to safely dissociate
> the V4L2 device from the parent USB device during unplug.
> 
> Reported-by: sashiko-bot@kernel.org
> Cc: stable@vger.kernel.org
> Assisted-by: Antigravity:gemini-3.5-flash
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/touchscreen/sur40.c | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
> index 1ad68131e3a6..2f0efee23d1e 100644
> --- a/drivers/input/touchscreen/sur40.c
> +++ b/drivers/input/touchscreen/sur40.c
> @@ -806,8 +806,10 @@ static int sur40_probe(struct usb_interface *interface,
>  	}
>  
>  	error = sur40_init_input(sur40);
> -	if (error)
> -		goto err_unreg_video;
> +	if (error) {
> +		video_unregister_device(&sur40->vdev);
> +		return error;
> +	}
>  
>  	/* we can register the device now, as it is ready */
>  	usb_set_intfdata(interface, sur40);
> @@ -815,8 +817,6 @@ static int sur40_probe(struct usb_interface *interface,
>  
>  	return 0;
>  
> -err_unreg_video:
> -	video_unregister_device(&sur40->vdev);
>  err_free_ctrl:
>  	v4l2_ctrl_handler_free(&sur40->hdl);
>  err_unreg_v4l2:
> @@ -835,13 +835,8 @@ static void sur40_disconnect(struct usb_interface *interface)
>  	struct sur40_state *sur40 = usb_get_intfdata(interface);
>  
>  	input_unregister_device(sur40->input);
> -
> -	v4l2_ctrl_handler_free(&sur40->hdl);
>  	video_unregister_device(&sur40->vdev);

This call can free sur40,

> -	v4l2_device_unregister(&sur40->v4l2);
> -
> -	kfree(sur40->bulk_in_buffer);
> -	kfree(sur40);
> +	v4l2_device_disconnect(&sur40->v4l2);

but this call still uses it.

The easiest fix is just to swap the two lines.

Regards,

	Hans

>  
>  	usb_set_intfdata(interface, NULL);
>  	dev_dbg(&interface->dev, "%s is now disconnected\n", DRIVER_DESC);
> @@ -1176,11 +1171,21 @@ static const struct v4l2_ioctl_ops sur40_video_ioctl_ops = {
>  	.vidioc_streamoff	= vb2_ioctl_streamoff,
>  };
>  
> +static void sur40_video_release(struct video_device *vdev)
> +{
> +	struct sur40_state *sur40 = video_get_drvdata(vdev);
> +
> +	v4l2_device_unregister(&sur40->v4l2);
> +	v4l2_ctrl_handler_free(&sur40->hdl);
> +	kfree(sur40->bulk_in_buffer);
> +	kfree(sur40);
> +}
> +
>  static const struct video_device sur40_video_device = {
>  	.name = DRIVER_LONG,
>  	.fops = &sur40_video_fops,
>  	.ioctl_ops = &sur40_video_ioctl_ops,
> -	.release = video_device_release_empty,
> +	.release = sur40_video_release,
>  	.device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_TOUCH |
>  		       V4L2_CAP_READWRITE | V4L2_CAP_STREAMING,
>  };

