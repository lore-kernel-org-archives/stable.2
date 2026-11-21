Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=92.243.27.206
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795297933;
	b=Z/gcJRBGIb42rKmy6umZqS5506u+C7U8OJ/7ck+LRUrkrcnxRIpe5tJkqBmJUSl5MtJ2
	 DTa7YioO0nGB/fszy65laXtLVau4mDPWlRopPNuB5tblnZ5Wqa4YeuVPtNtynRIaA52A5
	 OyGAU0UgiSiKT8/MCKXOVqdPa8r7R/8a8uF/kLGRVhM+BuwgwOK4LTlBrn4/LZ5EVg6If
	 uYoDlni0pUL+bkMJnU6bvGrgGIoqYssCveIM9TX9z0vTP5fxxz0HIsnJ9b0xLZrwY3EEA
	 GUjkXbptsVCQQ2VCjoRYn6n5x29miy0toSSqkoi5SZLdaTgWbJ8Oi2ZudefyRgHBNqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795297933;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=mn4QwsYC9SpDkeEo6mtr8rieRmYKJG5dULJqiazNn4o=;
	b=b4YGQHEFaQmMD5QsBSd7lIqrXov2C/05gHy/vIxAgVGr+K4ZDLRtobQTYUyH2kcfIk2O
	 x2VmJIAK0gcm+6Zk1mLZ21W6IAPnmXr2C8Pw4RwD68e9QHoX9g8lpNYgTv123ZT4kgTlh
	 bPsGQuGdbaYNMwZ5vmNOao+9MoFTVxNxUQjUoxriIiCNRTmcXnT6nFVSAzo5piBL2Y9VP
	 AwuDAEtBL5FEh2ZAmlTj61aZNA8wA8cP78pktQzRvbQZ+E+BwuTGytR74iruwKEHXisSG
	 GVMQEUTgHbd9vyxPk2cWpzb353ULcIXQnQFzTVVOP8N6i0YJNC/t8ftaFaYLuZWFgxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mess.org;
	spf=pass smtp.mailfrom=mess.org;
	dkim=pass header.d=mess.org header.i=@mess.org header.a=rsa-sha256 header.s=2020 header.b=sIBTMnHR;
	arc=none smtp.remote-ip=92.243.27.206
Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091A2606A320;
	Sat, 21 Nov 2026 21:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 091A2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mess.org header.i=@mess.org header.a=rsa-sha256 header.s=2020 header.b=sIBTMnHR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1795297924; bh=20IZZvIZZkXQKwXY/nUAjz98irTKRrsCNSH/ecq7JHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sIBTMnHRKL1hyV2POJ7Squ2BF7XOOxZgEQTM90tk7X1Z9tHtd3A7xPF0dsCH8FniY
	 7GYFpMBoTddP45CtfqCgRQBTZ8Ddmu76un9bdBtFzWLVWB0k01dUBnwQvATKiOCtu8
	 eCqezIPrsupjKQRolr6ogqTXSg3rJv58WcqWcGOHU9htHBXF5UZn3reeA0x2fb0gRb
	 dgb6nV5gnmJSgvykPvxMk0bS8yW5Lbxf/Vc6MD3htmtFIRlqO3NYdkqxuPbazg9Wmg
	 2pe5KcSdf5KfiAue7oNEl340gLb5nkrzgRsrYc1VI28bZ62v/w3Ol4XA9wCF/JtTI9
	 i4OG3tw1/eKNw==
Received: by extorris.mess.org (Postfix, from userid 1001)
	id BA12241829; Sat, 21 Nov 2026 21:52:04 +0000 (GMT)
Date: Sat, 21 Nov 2026 21:52:04 +0000
From: Sean Young <sean@mess.org>
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	David =?utf-8?Q?H=EF=BF=BDrdeman?= <david@hardeman.nu>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: Re: [PATCH v2] media: rc: fix use-after-free of rc_map.name on
 register error path
Message-ID: <awIShD1k89rEsIc5@extorris.mess.org>
References: <20261027014144.9144-1-25031212351@stu.xidian.edu.cn>
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
In-Reply-To: <20261027014144.9144-1-25031212351@stu.xidian.edu.cn>

Hi,

Apologies for the delay in getting this reviewed. I've been very busy
lately, things should return to normal soon.

On Tue, Oct 27, 2026 at 09:41:44AM +0800, YuanZhe Liu wrote:
> If rc_register_device() fails after device_add() - for example when
> ir_raw_event_register() cannot create its kthread - the unwind path
> frees the keymap via rc_free_rx_device() while the device is still
> visible in sysfs, and never clears dev->registered.
> 
> A userspace reader of the uevent attribute then enters
> rc_dev_uevent(), passes the registered check under dev->lock and
> dereferences the already freed dev->rc_map.name:
> 
>   BUG: KASAN: slab-use-after-free in string+0x483/0x4c0
>   lib/vsprintf.c:737
>   Read of size 1 at addr ffff888007ca9d80
>    rc_dev_uevent+0xd7/0x1d0 drivers/media/rc/rc-main.c:1628
>    dev_uevent+0x28d/0x570 drivers/base/core.c:2709
>    uevent_show+0x1af/0x380 drivers/base/core.c:2756
> 
> Fix it the same way rc_unregister_device() does: take dev->lock,
> close the input device if it is still open and clear
> dev->registered before releasing any resources. rc_dev_uevent()
> then observes the cleared flag and returns -ENODEV instead of
> reading rc_map.name. The same sequence is also needed when
> rc_setup_rx_device() fails: lirc has been registered by then, so
> an open /dev/lircX file descriptor would otherwise keep calling
> driver callbacks that access the torn down device.
> 
> Fixes: f56928abaa6d ("[media] rc-core: cleanup rc_register_device")
> Cc: stable@vger.kernel.org
> Co-developed-by: Bin Yu <byu@xidian.edu.cn>
> Signed-off-by: Bin Yu <byu@xidian.edu.cn>
> Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
> 
> ---
> v2:
>  - Clear dev->registered on the rc_setup_rx_device() error path too;
>    lirc is already registered there and open file descriptors can
>    still reach driver callbacks.
>  - Factor the lock/close/clear sequence into rc_unregister_device_state()
>    and share it with rc_unregister_device().
> ---
>  drivers/media/rc/rc-main.c | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/rc/rc-main.c b/drivers/media/rc/rc-main.c
> index dda3479ea3ad..3ac5d532c6dc 100644
> --- a/drivers/media/rc/rc-main.c
> +++ b/drivers/media/rc/rc-main.c
> @@ -1888,6 +1888,24 @@ static void rc_free_rx_device(struct rc_dev *dev)
>  	ir_free_table(&dev->rc_map);
>  }
>  
> +/*
> + * Prevent userspace from accessing a device that is being taken down.
> + *
> + * The uevent attribute, the lirc character device and the input device
> + * all check dev->registered under dev->lock before using driver data.
> + * Clear it while still holding that lock, and call dev->close() for an
> + * input device that is still open, exactly as rc_unregister_device()
> + * does, before the resources they use are freed.
> + */

This comment is not really useful, might was as well delete it. It's just
part of the teardown.

> +static void rc_unregister_device_state(struct rc_dev *dev)

I am not sure rc_unregister_device_state() is a good name. How about
something like set_unregistered()? Since it's a static function it does
not need the rc_ prefix.

> +{
> +	mutex_lock(&dev->lock);
> +	if (dev->users && dev->close)
> +		dev->close(dev);
> +	dev->registered = false;
> +	mutex_unlock(&dev->lock);
> +}
> +
>  int rc_register_device(struct rc_dev *dev)
>  {
>  	const char *path;
> @@ -1954,8 +1972,10 @@ int rc_register_device(struct rc_dev *dev)
>  
>  	if (dev->driver_type != RC_DRIVER_IR_RAW_TX) {
>  		rc = rc_setup_rx_device(dev);
> -		if (rc)
> +		if (rc) {
> +			rc_unregister_device_state(dev);
>  			goto out_lirc;
> +		}
>  	}

Above this code there is a call to lirc_register() which also has a
goto out_lirc; error path. Unless I'm missing something, this should
also have a rc_unregister_device_state() in its error path.

>  
>  	if (dev->driver_type == RC_DRIVER_IR_RAW) {
> @@ -1970,6 +1990,7 @@ int rc_register_device(struct rc_dev *dev)
>  	return 0;
>  
>  out_rx:
> +	rc_unregister_device_state(dev);
>  	rc_free_rx_device(dev);
>  out_lirc:
>  	if (dev->allowed_protocols != RC_PROTO_BIT_CEC)
> @@ -2024,11 +2045,7 @@ void rc_unregister_device(struct rc_dev *dev)
>  	timer_delete_sync(&dev->timer_keyup);
>  	timer_delete_sync(&dev->timer_repeat);
>  
> -	mutex_lock(&dev->lock);
> -	if (dev->users && dev->close)
> -		dev->close(dev);
> -	dev->registered = false;
> -	mutex_unlock(&dev->lock);
> +	rc_unregister_device_state(dev);
>  
>  	rc_free_rx_device(dev);
>  
> -- 
> 2.34.1
> 

Thanks,

Sean
