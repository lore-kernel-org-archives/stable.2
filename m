Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4FF4582F8;
	Thu, 30 Jul 2026 16:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428376; cv=none; b=Q9Zmu40EwMQ5RVOeKTbjUHWeDTjk9ViAQ1DFRH+r50G8a3X3yxY4N66tLys2ksN58/l4zcNAyRiBwXVhE3xpuW0sSfPhCUl0DvQKPLU8bqz8+j/HqE8eZX+JdqRbJkbIn5ph8POM7lKsso+U7+gKtw4doDvPnRhO0PLyiEgeg8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428376; c=relaxed/simple;
	bh=BlBE9+qC/Yc3JYSr4zpGEcDSMLhywmxbr+jkFyZPe1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLkomVNopIj1RM9jeuuzyHHjSBXEFUlXHt50q+Fg5N+S/V2WBhsZo2HKrPh3Ywsc5MSL3VUnSo0tItbMQFgh6plgALkQiwK0cupAtfih/FM62r/Fhxoy2bkKQmcSlMNUCT5WNyflWSQr6Lo833RNph0jFPC0+v02HF/oAEYUPuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TzFy5CWx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TzFy5CWx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0BA1F000E9;
	Thu, 30 Jul 2026 16:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785428374;
	bh=W6LzjI3KZgCsqhOgb1WdxUCZnol+9M4JR7uQfQP0oJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TzFy5CWx+ktgiy6js7e3ryUCn4EpvbGJNI7oZwLk4DMCrP+y9YQR7LzPWBhLlcIUs
	 ThUTaUmj5fbCPxcbp5135tA4w99pnD/fcL5fz5hUcC5GljVzrblZRcyxlIHHZVNXNd
	 kRQAFJGI6QUeEkWjO4N8MdkSofMfokGLLtOJ49tg=
Date: Thu, 30 Jul 2026 16:29:57 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 3/4] tty: don't oops in tty_unregister_device() when
 no cdev is registered
Message-ID: <2026073057-moustache-unfixable-5ab1@gregkh>
References: <20260719221014.44354-1-kmehltretter@gmail.com>
 <20260719221014.44354-4-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260719221014.44354-4-kmehltretter@gmail.com>

On Mon, Jul 20, 2026 at 12:10:13AM +0200, Karl Mehltretter wrote:
> serial_core_add_one_port() keeps a uart_port when tty device registration
> fails so setserial can still use it. It marks the port UPF_DEAD and
> returns success. Removing the port later reaches tty_unregister_device(),
> which unconditionally passes driver->cdevs[index] to cdev_del().
> 
> The slot does not always contain a live cdev. A serdev registration error
> other than -ENODEV returns before tty_register_device_attr(), leaving the
> slot NULL. If cdev_add() fails, tty_cdev_add() drops the cdev reference
> but leaves the slot pointing at freed memory. The later cdev_del() is
> therefore a NULL dereference or use-after-free.
> 
> The NULL path was reproduced with failslab during UART bind on qemu's
> mcimx6ul-evk and raspi1ap boards:
> 
>   Unhandled fault: page domain fault (0x01b) at 0x00000038
>   PC is at cdev_del+0x14/0x34
> 
> Clear the slot after cdev_add() fails and only call cdev_del() when it is
> non-NULL. This makes a non-NULL slot mean that a live cdev is registered.

Note, LLMs love to write a lot.  Please always rewrite the changelog
text to be sane and concise.

> 
> Fixes: c1a752ba2d6b ("tty: don't leak cdev in tty_cdev_add()")
> Fixes: 8cde11b2baa1 ("tty/serdev: add serdev registration interface")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  drivers/tty/tty_io.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index 6b283fd03ff8..4889076b975f 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -3167,8 +3167,10 @@ static int tty_cdev_add(struct tty_driver *driver, dev_t dev,
>  	driver->cdevs[index]->ops = &tty_fops;
>  	driver->cdevs[index]->owner = driver->owner;
>  	err = cdev_add(driver->cdevs[index], dev, count);
> -	if (err)
> +	if (err) {
>  		kobject_put(&driver->cdevs[index]->kobj);
> +		driver->cdevs[index] = NULL;
> +	}
>  	return err;
>  }
>  
> @@ -3305,7 +3307,7 @@ EXPORT_SYMBOL_GPL(tty_register_device_attr);
>  void tty_unregister_device(struct tty_driver *driver, unsigned index)
>  {
>  	device_destroy(&tty_class, MKDEV(driver->major, driver->minor_start) + index);
> -	if (!(driver->flags & TTY_DRIVER_DYNAMIC_ALLOC)) {
> +	if (!(driver->flags & TTY_DRIVER_DYNAMIC_ALLOC) && driver->cdevs[index]) {

This looks to be doing 2 different things in one patch, or am I
confused?

thanks,

greg k-h
