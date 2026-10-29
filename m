Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793282054;
	b=GdcHtR4LwdGwu5dJxq69rn/d2qLeC2LCYmWHv/Mrwg1bfwdyiDfIi0OSutkwCZ1fn0PE
	 x/9jdJs8XEmkFflL/wOPrejQlNkR1evfEYHaJUyDRcxf4CGwGXaohKnW+c74/zAJa+yvB
	 HpIdTOsqu4cwdelkeW1VcXq7jIzBwBZUgSRtSk3GfqtR8Z4Rsrl1Qhybh3UPLsIeQ8rAm
	 jsjZu7uN36LHUadDI4M/IjbE92MBzzGdXavU5rK/RkQhUk5IyDgRTlVyvgHVNjhr0ZSY4
	 0vJX7PmnSfhZnv19/uSFZmkVpnXXDWmsrf7J8SGj8Wk4Jz3TIq5MtPgwDgMzJzcZTsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793282054;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3HESh4P6MjW7IDJILbZ6M6f0+i4dLZtBcfUg1p2bZ98=;
	b=oQaX1NhrHAJSBilIuSFupKNBErbw5+DGfTDyIBhdTpZNpyBMctKcEG1cmTqCcCrAkW4k
	 c6hfsEUZWxSko+wt8fFr+v5vTmyTss1FZqRMms6OXa2m1R4ZGxUVANndL6hR/ohKt/iqN
	 af0c5cdmXNt/53b0kck5JXJFEjZqWoijehNTb4amAyUWrhnCExKtYdwwBtcfOelBxpKyT
	 HuCj5msfYPafZHUIyATSNtTHVTRCcm1Gdn4kcRvAYWr+yxf20gZ+o9mI7n8AZNMLw8COF
	 FL4opuihNylgBFYM59tr91XqhyPBlItJzeZkL56wGHGeQxMfW2UpXWRNb/OhrHccLdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=bDmE6BFe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F999606A31E;
	Thu, 29 Oct 2026 13:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=bDmE6BFe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6213E1F01825;
	Thu, 29 Oct 2026 13:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793282053;
	bh=3HESh4P6MjW7IDJILbZ6M6f0+i4dLZtBcfUg1p2bZ98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bDmE6BFeFvGESFh+ESxTElzSne3tHHWFFnT9epormD37DaLNS23+2fapmIckEXWbc
	 H+xcehwuyesrq8sSSgIJUP6yeMrhXKb7k/kO8YkczW4IFbYHmLA58R8+3pS5tTtbdE
	 ESvjHXm8yM7xoHS6WvL67h2pvzKgc4HrZsV84Zq8=
Date: Thu, 29 Oct 2026 14:54:11 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] USB: serial: garmin_gps: fix deadlock on reset request
Message-ID: <2026102958-figurine-unthawed-e1c2@gregkh>
References: <20261029101828.865915-1-johan@kernel.org>
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
In-Reply-To: <20261029101828.865915-1-johan@kernel.org>

On Thu, Oct 29, 2026 at 11:18:28AM +0100, Johan Hovold wrote:
> The garmin_gps driver has a reset feature that is supposed to reset the
> device when writing a private reset request packet. The reset is however
> done synchronously from the write() callback (and without holding the
> required device lock) which leads to a deadlock in the line discipline
> when hanging up the port as part of disconnect.
> 
> Switch to using the asynchronous reset interface while dropping the
> redundant and synchronous stopping of the interrupt urb (write()
> callbacks are supposed to be atomic and USB core, USB serial core and
> the driver itself will unlink and kill all URBs during disconnect).
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Link: https://lore.kernel.org/2026102733-prayer-drainer-56f3@gregkh
> Cc: stable@vger.kernel.org
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/usb/serial/garmin_gps.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/serial/garmin_gps.c b/drivers/usb/serial/garmin_gps.c
> index abfc03e44ca9..f1e69eca2601 100644
> --- a/drivers/usb/serial/garmin_gps.c
> +++ b/drivers/usb/serial/garmin_gps.c
> @@ -823,10 +823,9 @@ static void priv_status_resp(struct usb_serial_port *port)
>   * Garmin specific driver functions
>   ******************************************************************************/
>  
> -static int process_resetdev_request(struct usb_serial_port *port)
> +static void process_resetdev_request(struct usb_serial_port *port)
>  {
>  	unsigned long flags;
> -	int status;
>  	struct garmin_data *garmin_data_p = usb_get_serial_port_data(port);
>  
>  	spin_lock_irqsave(&garmin_data_p->lock, flags);
> @@ -835,13 +834,8 @@ static int process_resetdev_request(struct usb_serial_port *port)
>  	garmin_data_p->serial_num = 0;
>  	spin_unlock_irqrestore(&garmin_data_p->lock, flags);
>  
> -	usb_kill_urb(port->interrupt_in_urb);
> -	dev_dbg(&port->dev, "%s - usb_reset_device\n", __func__);
> -	status = usb_reset_device(port->serial->dev);
> -	if (status)
> -		dev_dbg(&port->dev, "%s - usb_reset_device failed: %d\n",
> -			__func__, status);
> -	return status;
> +	dev_dbg(&port->dev, "%s - usb_queue_reset_device\n", __func__);
> +	usb_queue_reset_device(port->serial->interface);
>  }
>  
>  
> -- 
> 2.55.0
>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
