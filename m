Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDF021ABB1;
	Tue, 28 Jul 2026 12:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785241988; cv=none; b=G+oINw5WASW//Tm92VMGYzP802LPeunq4tl7R18XDqJNvE5PmciV/TO/n+lRfTah43qWa51uqhe7EQ6ES9VQ8YlWttImdvwmjENgf3YM8Z6FfWwq9OA8CRRwO3aBmVWfbHeEZfWz4cHQL2iz3jM+jDlymc7ySwhY2Eg5X/XgfbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785241988; c=relaxed/simple;
	bh=R1x0gbHSEF649dDBsLTEEovn86RgGiNcWj6ZQqmH5lk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bFl0EqPQGVCbvFO50e+jRcFQCBScc4CTUEG73Fr92DXzvNx7h6Vol9kYbp69jtAi6jIzVQz1LqrR+Z9z+AEV/5ksvgv6zdLG0qTCe/FTKMa0w7as6yoFtzrcEnZ38KcMkrwOVUuIrYfvJuVWaVl4QvI1TjcTda4Y1LMpGdDnRRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBj0Jzo9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBj0Jzo9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160C71F00A3A;
	Tue, 28 Jul 2026 12:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785241987;
	bh=utV4vKMlqT8Z9yiEQPdu4Tu2oACykHmjT/Dng8uAAZI=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=EBj0Jzo9sRM+7F9WAamOmzMyYlUjghd2VbHD/w2WM4nlVznU1WEzkP9guj7Gk6nXF
	 97iiYvQhzIFKb8vFtgILccMRg3J+aCS+edK6I6wEeeOrpi5onSJpvn8W4OzHJKx5Ld
	 FKMrj70J8J+o6vme3OhrsAuCz/MT7J0oX/J1jB55JdoGZMFx+6fkgd/0NkN24nfHz8
	 ELEeZ16J0rpj7Z/e4xhwZG7rj6240QO/sYwKtxhZCmU0+3q7ogCGguh5cZObvnpIiP
	 ykDp1cDZcp14gvCeg/AlNx8ahhY690/RTIklf/RvuNNBsrl5hFxMcP06wmuSCxejs6
	 PjQPpJdEy5KAw==
Message-ID: <15b0899f-ce90-4f60-80bd-a0f8432ce811@kernel.org>
Date: Tue, 28 Jul 2026 14:33:04 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH] media: gspca: hold a usb_device reference while
 registered
To: Shuangpeng Bai <shuangpeng.kernel@gmail.com>, hverkuil@kernel.org,
 mchehab@kernel.org
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260718025434.2259756-1-shuangpeng.kernel@gmail.com>
Content-Language: en-US, nl
In-Reply-To: <20260718025434.2259756-1-shuangpeng.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/07/2026 04:54, Shuangpeng Bai wrote:
> gspca keeps a pointer to the probed struct usb_device in
> gspca_dev->dev, but it does not hold a reference to it. The
> V4L2/video-device reference can keep the outer gspca_dev alive after USB
> disconnect, and the streaming queue can then be canceled from the last
> file release path.
> 
> That late release path still calls into gspca_stream_off(), which may
> call sub-driver stop callbacks or usb_set_interface() and dereference
> gspca_dev->dev after the USB core has freed the device.
> 
> Take a reference to the usb_device when storing it in gspca_dev and drop
> it from the final gspca_release() path. Balance the reference in the
> probe error path as well.
> 
> Fixes: 63eb9546dcb5 ("V4L/DVB (8152): Initial release of gspca with only one driver.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
> ---
>  drivers/media/usb/gspca/gspca.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/usb/gspca/gspca.c b/drivers/media/usb/gspca/gspca.c
> index 594d73e50b9f..59eb4cec1aed 100644
> --- a/drivers/media/usb/gspca/gspca.c
> +++ b/drivers/media/usb/gspca/gspca.c
> @@ -1178,6 +1178,7 @@ static void gspca_release(struct v4l2_device *v4l2_device)
>  	v4l2_ctrl_handler_free(gspca_dev->vdev.ctrl_handler);
>  	v4l2_device_unregister(&gspca_dev->v4l2_dev);
>  	kfree(gspca_dev->usb_buf);
> +	usb_put_dev(gspca_dev->dev);
>  	kfree(gspca_dev);
>  }
>  
> @@ -1462,7 +1463,7 @@ int gspca_dev_probe2(struct usb_interface *intf,
>  		ret = -ENOMEM;
>  		goto out;
>  	}
> -	gspca_dev->dev = dev;
> +	gspca_dev->dev = usb_get_dev(dev);
>  	gspca_dev->iface = intf->cur_altsetting->desc.bInterfaceNumber;
>  	gspca_dev->xfer_ep = -1;
>  
> @@ -1574,6 +1575,7 @@ int gspca_dev_probe2(struct usb_interface *intf,
>  	if (sd_desc->probe_error)
>  		sd_desc->probe_error(gspca_dev);
>  	kfree(gspca_dev->usb_buf);
> +	usb_put_dev(gspca_dev->dev);
>  	kfree(gspca_dev);
>  	return ret;
>  }

Actually, the better solution is to replace v4l2_device_unregister()
by vb2_v4l2_device_unregister() in gspca_disconnect. That ensures that the
queue is canceled at disconnect time.

Regards,

	Hans


