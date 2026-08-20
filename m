Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E483647987B
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 15:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787240840; cv=none; b=i8uJPrVjgm0lYJEOE+0Y9EhzjIppabEVZQ670tNOt4At7T7PpQu5BTgyb3wIx2VGFx47BqgpuwnTSkBfgCb/Z+Nh55kgWOIznfboIRcC963mDU3QjM6QGFS1gYmcxF+5L+BRvJ+/GhfzDF/GDhigL9hCKsjSu31s0NbEX4t/K54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787240840; c=relaxed/simple;
	bh=i7llB6OCzgl8K4xcMP+HSalE94BC4IGWAu4nFa/K7+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSa5fmMAhEeUt8Hg1JSAhcdTT9tk9xsUTPruZR4LZgPqkJHnnhKfWHxrSKceOgtf7J/SlUxgh7lGdLiL5fsEV4FZoP6FHgcTglPsQVGRc/QK1a6fT80Ij3m7jxr4fl0LuxWTcGuqQmejGOhEyUYyFzVCM3Tp5cuposIhAkchUWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=EcA9QNoU; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="EcA9QNoU"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-527e352a167so14840361cf.1
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 08:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1787240829; x=1787845629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fFQAUnoaVoRfpKF2nIQ/H52WHDVeMuXfhRa4awyUg9o=;
        b=EcA9QNoUaM3WYBPYMgYsyBUukZsfAudvnEob89rN9Z8K/m2cJwC5hoaJRzGxjUDQVI
         WmVrAu3LDM7eMFUUHzHfrH++rdzSS/L1Zd1J2VS/aY6VcwT1CtwLtFbewf1++6hj2Mxx
         4kC3udF41OVVwg7oC/BPfbV85oiKgaLTYhe0OUGJIfe9AIhyiF2ncp773YIfRFzw00FC
         uYpBUJJM0u4DYQeaHbwNpLsMdl7j7wG9tY84T2edWc96gtp6Hsd8dVWaHAyW0C0cIn86
         wPF4jqjR3aaTr0Z813VHj8HOWs1n/QV2+NP1EoIUTnkGhBCkQ+9y6O8zBgcnwzaiTqWu
         VY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787240829; x=1787845629;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fFQAUnoaVoRfpKF2nIQ/H52WHDVeMuXfhRa4awyUg9o=;
        b=hYAPNbg2TmvaaLXuXuwxEY0icE4F14qZ40bsKeHfnVpyv6XZvc5MxMYmJghP0yNPOx
         slMXtHTmhw6ap6a/QKhBH4Cjpu38+yjp5+o81o50hb2mvXOqL04MToCvvNXG6VGD1P5/
         X/WDZkoVkgeoryxg5cciKUYuaFfSwdycOxwDDbSznltO9rTxanfEAuogTurzKx/RStnd
         KwDc/sxYgVEKP1lY2ZpdgBpy0Ihy6vIt/Fbw+E7td8T7Cpts/zqVWGA8njGbWDX/UkkP
         zK7f3E43O02z14fYGtlkZZBj7QjKBOSuQGVVNO9qsxOBzIj7SV+JTaKdDPHPH+rY43mp
         eqxA==
X-Forwarded-Encrypted: i=1; AHgh+RptCMgzIouFKcYJigWKyhL55j0ybVtrg2XN9iUzpFr8P6rnr9w2YYUBccoxEuU9eh7hdJ/jm4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9hJrMF9BkAH3BZF4fQPthZRq/iXr6R6xMQtoYyhiWP595US0f
	0cGz8uBlP9nN6sbOFGZEe9m8kNRlMNSAX1qyP9hGp9usaikbC3hj8mb/dEQU0ftoxA==
X-Gm-Gg: AR+sD1124DnPOD+BiAV18uWIs2vsoBicVwvhvXwTb8UfYRc3/jk6jshgUx/CUQE/oQo
	Nvp5K1gAT9vgNHPuQKnRDHT7QxiRqh3TFCFxAwMsvy47IJKVSz5Pu+afPYjtl83XAMTWdL4aqJb
	ugz/QEIpIVfCMaF0+7WRSbe+0q8Vz6dWQbmfp5k4cguuFB1QbQ5rglYndeA3AZNEdTHAGc1LEoI
	jSL28Q0uDlxANfT6ckNg8Het7lh2r8jSLoZoYBSPPidosV52eNg5/U0+3mkQU1D+XT26wUltuoK
	VP7Zpf1r018UXDvZ3X5VKhQ3TvS3yKGlpNxyl0GRF6K3VsHrCzh4s3VimEUMYU1q/jYS1q+0Jgn
	DcPJul1lLOdv8YVjBqIW7MC7M57u63+H3eVY/a5QFIJj+GtIZowaNhR5sKkk5bEP1p39mqXOadt
	P2SVcsAzcVBWZCLVFLOcU40B/y292b5xqc+r1+SSU1NFR0tnB6YY4Q1V6yMSib1d30FpRKjSITc
	aeqg8nVURBBoz28tlKXtQnDOiitx9MJ
X-Received: by 2002:a05:622a:40c4:b0:52d:7c2f:7561 with SMTP id d75a77b69052e-52dd5cbe8ecmr135816691cf.41.1787240828678;
        Thu, 20 Aug 2026 08:47:08 -0700 (PDT)
Received: from rowland.harvard.edu ([2607:fb60:1011:2006:2008:aeb7:73d7:d8ff])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52dd8598adcsm33056221cf.9.2026.08.20.08.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 08:47:08 -0700 (PDT)
Date: Thu, 20 Aug 2026 11:47:05 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] USB: serial: fix driver deregistration order
Message-ID: <2b757e10-c39d-48e5-8240-5390053f6f99@rowland.harvard.edu>
References: <20260820145402.434447-1-johan@kernel.org>
 <20260820145402.434447-3-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820145402.434447-3-johan@kernel.org>

On Thu, Aug 20, 2026 at 04:54:02PM +0200, Johan Hovold wrote:
> USB serial driver modules register one driver for the USB bus and one or
> more drivers for the ports on the USB serial bus.
> 
> When unloading a driver module, the USB driver must be deregistered
> before the USB serial bus drivers so that I/O is stopped before
> unbinding the ports to avoid use-after-free in completion handlers
> accessing port data.
> 
> Note that the order does not matter currently in the registration error
> path as the USB driver is not bound until after the USB serial drivers
> have been registered.

But __usb_serial_register_drivers() does usb_register(udriver) _before_ 
calling usb_serial_register() for the serial_drivers.  Not _after_, as 
claimed here.

And if the order in the registration error path does not matter, why 
does the patch change it?

Or did you mean something else?

Also, what about the failure mode described in 765e0ba62613?  Not to 
mention that it seems odd to register a parent device driver after a 
child device driver, rather than before.  Or to unregister them in the 
reverse order.

If the point is to avoid I/O operations completing after the device 
structure has been deallocated, why not rely on the serial-bus drivers 
to stop all their I/O when they are unbound?

If these questions don't make sense, remember that I haven't done 
serious work on this subsystem for 15 years or so and blame it on that.  
:-)

Alan Stern

> Fixes: 765e0ba62613 ("usb-serial: new API for driver registration")
> Cc: stable@vger.kernel.org	# 3.4
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/usb/serial/usb-serial.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
> index a4fbc849c0fa..08a9b6f8cf7d 100644
> --- a/drivers/usb/serial/usb-serial.c
> +++ b/drivers/usb/serial/usb-serial.c
> @@ -1522,9 +1522,9 @@ int __usb_serial_register_drivers(struct usb_serial_driver *const serial_drivers
>  	return 0;
>  
>  err_deregister_drivers:
> +	usb_deregister(udriver);
>  	while (sd-- > serial_drivers)
>  		usb_serial_deregister(*sd);
> -	usb_deregister(udriver);
>  err_free_driver:
>  	kfree(udriver);
>  	return rc;
> @@ -1543,9 +1543,15 @@ void usb_serial_deregister_drivers(struct usb_serial_driver *const serial_driver
>  {
>  	struct usb_driver *udriver = (*serial_drivers)->usb_driver;
>  
> +	/*
> +	 * The USB driver must be deregistered before the USB serial drivers
> +	 * so that I/O is stopped before unbinding the ports.
> +	 */
> +	usb_deregister(udriver);
> +
>  	for (; *serial_drivers; ++serial_drivers)
>  		usb_serial_deregister(*serial_drivers);
> -	usb_deregister(udriver);
> +
>  	kfree(udriver);
>  }
>  EXPORT_SYMBOL_GPL(usb_serial_deregister_drivers);
> -- 
> 2.54.0
> 
