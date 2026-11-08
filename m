Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=92.243.27.206
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794146775;
	b=2R9YmaSXQO+yXaEjFL3K8mfL+OB/fpS+aaf5LTp6LkyB8cFT29tyjiL3+xtwA9kTHW73
	 pcEBtt1YEse2sO2T2PSnalrdgYF0FaGjvxhKa4JW8SEa8eP54455c+h9xL79Zx1KiRF8R
	 G62ZHgDKjUJtKsvj7gnfjNT7IlzQCz/fKrlC5tqCA9aLrL46qWwyec5J8WNpT3dDmEzY1
	 w5WHQIudyuLfJOBdf9WNNMYjAyHnOPkjSoL5P75TqPnKuPhwq79LwnowRhX4GVXTebpG4
	 wyk9vJE1hDnNSKr2TJm1LsLVVjK3zIlCsq2X6vaQC26JbyWao8ngsVaiex53k11xp1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794146775;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=SBPZ6aGtmIJIKTrRo/jMBFw23cG+nviQDpc9ZBgGBX8=;
	b=ROfCvXerbcDpfFBMaaRQHDHNVUdEBO/ZtcMjgdqR7ljs3ObLEFlvHPB0ma82EmbgC8Av
	 sjRbEPPOFr58yY8S0oBH/R+LbGUZt7PT6G2gKxqHhzbgrhJHkbL05UV4wHzITiINusS4M
	 8uOmsd45C5E33Qj/uVVtMYIwXvW57gi5zJlyanM4m7ef/l549bIiPyeN6TH4fxeVJTl8a
	 x4FgCRsDMR8CYjzx3YrhY3ouOvJeF9zH59WG4hsuc7g3k+jNytJEW91AVeH1ivZ3YX+AO
	 RJyit83Y3Sf/Oa7T8QqQF9RrYkuWHcPnM31kxbEHsi7SUBOBzrbhrbjPGMwn+4M1/VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mess.org;
	spf=pass smtp.mailfrom=mess.org;
	dkim=pass header.d=mess.org header.i=@mess.org header.a=rsa-sha256 header.s=2020 header.b=coGbXp1C;
	arc=none smtp.remote-ip=92.243.27.206
Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D70606A31C;
	Sun,  8 Nov 2026 14:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05D70606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mess.org header.i=@mess.org header.a=rsa-sha256 header.s=2020 header.b=coGbXp1C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1794146766; bh=+DA6+18hCu9Y6WONKKBnHDALWaDTMasqTq4m3FrGX9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=coGbXp1Cf22H2UiPq2O8JuMg1fn7ehfgM8ieIpE7Fut/mFmaN4ZQuPhpcBEBoFjEC
	 G3kybvRBBAByRrYWOZMFKsGOOZkxz+r7FZI8lee5I/ZGQGY7z3H8qB1ce2cJ59nI9R
	 6p0LjJ4EISG1KhY37naPtW0uIAI1stk9rZ4FpSfDW7MsxzOtT/PU12pjFGTmjYrQjn
	 XMxlIQ9ESrKFAQ4ctelZbkzBcSbCgTB+iNIl7CrfL2/l5XPLxjm5FRVL9iuArBbEyb
	 SXWzrhl5BtRJ0x6UD0Ex3DrUCKGMr0uDLWhB753lvtdGBgBfM/PRVymaxzb8AAkt2R
	 uCKRFF8li45lA==
Received: by extorris.mess.org (Postfix, from userid 1001)
	id DE204408CE; Sun, 08 Nov 2026 14:06:06 +0000 (GMT)
Date: Sun, 8 Nov 2026 14:06:06 +0000
From: Sean Young <sean@mess.org>
To: joasantonio108@gmail.com
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	syzbot+aec1962419768c5caf88@syzkaller.appspotmail.com
Subject: Re: [PATCH] media: rc: redrat3: fix use-after-free of input device
 name/phys strings
Message-ID: <avCBzjIenoErsXhh@extorris.mess.org>
References: <20261104-redrat3-input-uaf-v1-1-b882e43d9803@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104-redrat3-input-uaf-v1-1-b882e43d9803@gmail.com>

On Wed, Nov 04, 2026 at 09:03:01PM +0000, Joas Antonio dos Santos via B4 Relay wrote:
> From: Joas Antonio dos Santos <joasantonio108@gmail.com>
> 
> redrat3_init_rc_dev() sets rc->device_name and rc->input_phys to point
> at the name[] and phys[] arrays embedded in struct redrat3_dev.
> rc_prepare_rx_device() then copies these pointers into input_dev->name
> and input_dev->phys without duplicating the strings.
> 
> When redrat3_dev_disconnect() runs, it calls redrat3_delete() which
> kfrees the redrat3_dev struct, freeing the embedded name and phys
> arrays.  If an evdev client still holds the input device open, a
> subsequent EVIOCGNAME or EVIOCGPHYS ioctl calls str_to_user() which
> reads the freed string via strlen(), triggering a KASAN
> slab-use-after-free on the freed kmalloc-2k object.

This is nonsense. rc_unregister_device() calls input_unregister_device()
so EVIOCGNAME will not work any more.

My guess this syzbot issue is resolved by commit
af452b9e01331b5338a1e5141624f17607239207 and this is the error path in probe,
not disconnect..


Sean

> 
> Fix by allocating the name and phys strings with devm_kasprintf() and
> devm_kzalloc() respectively, tied to the USB interface device lifetime.
> This ensures the strings outlive the input device, since the USB
> interface device (and its devres) is not released until all references
> to it are dropped.
> 
> Found by LLM-assisted code review of syzbot-reported crash patterns.
> 
> Reported-by: syzbot+aec1962419768c5caf88@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=aec1962419768c5caf88
> Fixes: 2154be651bfd ("[media] redrat3: new driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
> ---
> redrat3_init_rc_dev() stores pointers to the name[] and phys[] arrays
> embedded in struct redrat3_dev into rc->device_name and rc->input_phys.
> These are copied into input_dev->name/phys without duplication.
> 
> When the device disconnects, kfree(rr3) frees the strings while evdev
> may still hold the input device open.  A subsequent EVIOCGNAME ioctl
> dereferences the freed string via str_to_user() -> strlen(), triggering
> a KASAN slab-use-after-free.
> 
> syzbot link: https://syzkaller.appspot.com/bug?extid=aec1962419768c5caf88
> ---
>  drivers/media/rc/redrat3.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/rc/redrat3.c b/drivers/media/rc/redrat3.c
> index 3e82b5e66..d9e37ede2 100644
> --- a/drivers/media/rc/redrat3.c
> +++ b/drivers/media/rc/redrat3.c
> @@ -229,8 +229,8 @@ struct redrat3_dev {
>  
>  	u32 carrier;
>  
> -	char name[64];
> -	char phys[64];
> +	char *name;
> +	char *phys;
>  };
>  
>  static void redrat3_dump_fw_error(struct redrat3_dev *rr3, int code)
> @@ -943,11 +943,16 @@ static struct rc_dev *redrat3_init_rc_dev(struct redrat3_dev *rr3)
>  	if (!rc)
>  		return NULL;
>  
> -	snprintf(rr3->name, sizeof(rr3->name),
> -		 "RedRat3%s Infrared Remote Transceiver",
> -		 prod == USB_RR3IIUSB_PRODUCT_ID ? "-II" : "");
> +	rr3->name = devm_kasprintf(rr3->dev, GFP_KERNEL,
> +				   "RedRat3%s Infrared Remote Transceiver",
> +				   prod == USB_RR3IIUSB_PRODUCT_ID ? "-II" : "");
> +	if (!rr3->name)
> +		goto out;
>  
> -	usb_make_path(rr3->udev, rr3->phys, sizeof(rr3->phys));
> +	rr3->phys = devm_kzalloc(rr3->dev, 64, GFP_KERNEL);
> +	if (!rr3->phys)
> +		goto out;
> +	usb_make_path(rr3->udev, rr3->phys, 64);
>  
>  	rc->device_name = rr3->name;
>  	rc->input_phys = rr3->phys;
> 
> ---
> base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
> change-id: 20261104-redrat3-input-uaf-b6d3789e63c9
> 
> Best regards,
> -- 
> Joas Antonio dos Santos <joasantonio108@gmail.com>
> 
> 
