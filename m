Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24970346FAE;
	Sun, 26 Jul 2026 11:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785066165; cv=none; b=Tog5s1qJfRxE140owHjK3KtAGxz+iZv/ngU6o5Uea/XKC9VqTSh/qzh6UklKXE3AF2J1Y9gBMDDzKs45PY15maH61bjw1m5c/jfvlUZHRUIN+s12qgC/zoMNzbTseGfcwnBarSxGU+1y4klqdbUWvaKW4NfBVeavcTUHKQ3I3aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785066165; c=relaxed/simple;
	bh=OUVzekdFxT1IPkH+ZcuTvGoIhDO2ZyvszxeAKYQuDuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+FhSG2Nz7tWAIiuGzO1l8kuAlCvhjnS5T0iE5e53j3BRNWDO39Rum4gi26cWRO6JAFbUCjLhesWEIGPWXPgl3B3HBDI9SDKCxgrz6KJ1BMdyhkl4UZvbEArjnEzMTAIdGUJQMbYO9wKKX2qb3xZ8zx3m0hh6oPzq9wOiNkZBZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zb9zkoNW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zb9zkoNW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38EF91F000E9;
	Sun, 26 Jul 2026 11:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785066163;
	bh=1eZCb+v1pTpRdVk5e/EARgPEZpyxXQSCuvqNGlYNTJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zb9zkoNWWXVyRaRgBcfrqOc/YrlqV/FusGQNb5a9qKxLgfc9bJjRUAXL7QAFTidmo
	 vdObG2z3GoHOF5Q0QavGPmgHNSUG2rDuklIoKHQHtFeAvLuVt6vDcJWZdZAcCz9vAd
	 Ge3Fg8Ij+D3NbxHQk5G9HhsneFOdvAKzWfx7l244=
Date: Sun, 26 Jul 2026 13:41:18 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: HE WEI =?utf-8?B?KOOCruOCq+OCryk=?= <skyexpoc@gmail.com>
Cc: Hans de Goede <hansg@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-usb@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] usb: misc: usbio: reject endpoints smaller than
 the packet header
Message-ID: <2026072625-mooing-stimulus-324b@gregkh>
References: <20260726113511.57596-1-skyexpoc@gmail.com>
 <20260726113511.57596-2-skyexpoc@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260726113511.57596-2-skyexpoc@gmail.com>

On Sun, Jul 26, 2026 at 08:35:07PM +0900, HE WEI (ギカク) wrote:
> usbio_ctrl_msg() and usbio_bulk_msg() bound the caller's transfer sizes
> against the endpoint packet size minus the fixed protocol header:
> 
> 	if ((obuf_len > (usbio->txbuf_len - sizeof(*bpkt))) ||
> 	    (ibuf_len > (usbio->txbuf_len - sizeof(*bpkt))))
> 		return -EMSGSIZE;
> 
> usbio->txbuf_len is a u16 and sizeof(*bpkt) is a size_t, so the
> subtraction is done in size_t.  struct usbio_bulk_packet is 5 bytes and
> struct usbio_ctrl_packet is 4 bytes, so any endpoint smaller than that
> makes the expression wrap to a value close to ULONG_MAX, both
> comparisons become false and the check is disabled.
> 
> txbuf_len and rxbuf_len come from the bulk endpoint wMaxPacketSize.
> usb_parse_endpoint() only clamps wMaxPacketSize downwards, it never
> enforces a lower bound:
> 
> 	if (maxp > j) {
> 		dev_notice(ddev, "... has invalid maxpacket %d, setting to %d\n",
> 		    ..., maxp, j);
> 		maxp = j;
> 		endpoint->desc.wMaxPacketSize = cpu_to_le16(i | maxp);
> 	}
> 
> A wMaxPacketSize of 0 is merely logged with dev_notice(), and a bulk
> endpoint declaring 1 is accepted verbatim.  usb_submit_urb() rejects
> maxpacket 0, but nothing rejects 1.
> 
> A device claiming one of the ids in usbio_table[] and advertising a bulk
> out endpoint with wMaxPacketSize 1 therefore ends up with a one byte
> usbio->txbuf, and the very first I2C transfer reaches usbio_bulk_msg()
> via usbio_i2c_init() with obuf_len = 7.  The wrapped check passes and the
> packet header stores overflow the slab object before memcpy() is even
> reached:
> 
> 	bpkt = usbio->txbuf;
> 	bpkt->header.type = type;	/* txbuf[0] */
> 	bpkt->header.cmd = cmd;		/* txbuf[1], out of bounds */
> 	bpkt->header.flags = ...;	/* txbuf[2], out of bounds */
> 	bpkt->len = cpu_to_le16(obuf_len);	/* txbuf[3..4] */
> 	memcpy(bpkt->data, obuf, obuf_len);	/* txbuf[5..] */
> 
> Note that this is all complete before usb_bulk_msg() is called, so it
> does not depend on the host controller being willing to run a transfer
> on such an endpoint.  With KASAN it is a slab-out-of-bounds write.
> Through usbio_i2c_write() obuf_len becomes sizeof(struct usbio_i2c_rw) +
> msg->len, so the length and the contents of the overflow are controlled
> by whoever can issue I2C transfers, up to the 4096 byte adapter limit.
> 
> wMaxPacketSize 0 is worse in a different way: devm_kzalloc(dev, 0)
> returns ZERO_SIZE_PTR rather than NULL, so the existing
> 
> 	if (!usbio->txbuf)
> 		return -ENOMEM;
> 
> does not catch it and the same header stores dereference ZERO_SIZE_PTR.
> usbio_bulk_recv() has the same problem on the receive side: it reads
> bpkt->header.flags at offset 2 of usbio->rxbuf before any length
> validation.
> 
> The control side is different.  For low, full and high speed hub.c
> forces ep0 wMaxPacketSize to 8, 16, 32 or 64, all larger than the
> control header, so usbio_ctrl_msg()'s check cannot wrap there.  For
> SuperSpeed it accepts any bMaxPacketSize0 that encodes a non-zero value:
> 
> 	i = maxp0;
> 	if (udev->speed >= USB_SPEED_SUPER) {
> 		if (maxp0 <= 16)
> 			i = 1 << maxp0;
> 		else
> 			i = 0;		/* Invalid */
> 	}
> 
> combined with "(udev->speed >= USB_SPEED_SUPER && i > 0)" below, so
> bMaxPacketSize0 of 0 or 1 gives a ctrlbuf of 1 or 2 bytes and the same
> wrap, during the five usbio_ctrl_msg() calls in usbio_probe().  Whether
> a given host controller will operate such an ep0 has not been
> established; the control length is checked here regardless so that the
> invariant is stated once for all three buffers.
> 
> Validate the three lengths in usbio_probe(), which is the only place
> that assigns them, instead of hardening each arithmetic site.  A bridge
> whose endpoints cannot even carry the protocol header is unusable, so
> refusing to probe is the correct outcome.  Rejecting the equal case as
> well is deliberate: it does not wrap, but it leaves no room for a
> payload, and excluding it makes every "<buf>_len - sizeof(*pkt)" in the
> driver a valid size of at least one.
> 
> No supported bridge is affected.  The low, full and high speed devices
> this driver binds to have an ep0 packet size of at least 8, and they use
> bulk endpoints of 64, or 63 via USBIO_QUIRK_BULK_MAXP_63.
> 
> Found by code review, doing variant analysis on the code around
> 8c6314489550.  The overflow was reproduced under AddressSanitizer with a
> userspace model of usbio_probe() and usbio_bulk_msg() that uses this
> driver's struct definitions, checks and stores verbatim; it has not been
> exercised on hardware or on dummy_hcd.
> 
> Fixes: 121a0f839dbb ("usb: misc: Add Intel USBIO bridge driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5 asan
> Signed-off-by: HE WEI (ギカク) <skyexpoc@gmail.com>
> ---
> --- a/drivers/usb/misc/usbio.c
> +++ b/drivers/usb/misc/usbio.c
> @@ -577,6 +577,24 @@
>  
>  	usbio->ctrl_pipe = usb_endpoint_num(&udev->ep0.desc);
>  	usbio->ctrlbuf_len = usb_maxpacket(udev, usbio->ctrl_pipe);
> +
> +	/*
> +	 * Every transfer starts with a fixed size packet header and the length
> +	 * checks in usbio_ctrl_msg() and usbio_bulk_msg() are computed as
> +	 * "<buf>_len - sizeof(*pkt)".  Those lengths are u16 while sizeof() is
> +	 * size_t, so an endpoint smaller than its header makes the subtraction
> +	 * wrap to a huge value, disabling the checks and overflowing the
> +	 * buffers.  An endpoint exactly the size of the header does not wrap
> +	 * but leaves no room for a payload, so reject that too and every
> +	 * "<buf>_len - sizeof(*pkt)" below is a valid size of at least one.
> +	 * usbio_probe() is the only place assigning these lengths, so
> +	 * validating them once here covers every user.
> +	 */
> +	if (usbio->ctrlbuf_len <= sizeof(struct usbio_ctrl_packet))
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Control endpoint maxpacket too small: %u\n",
> +				     usbio->ctrlbuf_len);

LLMs are so chatty it's not even funny.

Just check the value and return an error, it's obvious what you are
doing, no need to write a 10 line comment about the thing, or hundred+
lines of changelog text, right?

Please look at how we normally write kernel changelog texts, the
documentation for how to do so should be very complete and the way your
LLM generated this is obviously not in line with that.


> +
>  	usbio->ctrlbuf = devm_kzalloc(dev, usbio->ctrlbuf_len, GFP_KERNEL);
>  	if (!usbio->ctrlbuf)
>  		return -ENOMEM;
> @@ -596,6 +614,11 @@

How did git generate this diff, no function name?


>  	else
>  		usbio->txbuf_len = usb_endpoint_maxp(ep_out);
>  
> +	if (usbio->txbuf_len <= sizeof(struct usbio_bulk_packet))

Why not use the proper function to verify endpoint sizes instead of
manually checking them like this?


> +		return dev_err_probe(dev, -EINVAL,
> +				     "Bulk out endpoint maxpacket too small: %u\n",
> +				     usbio->txbuf_len);
> +
>  	usbio->txbuf = devm_kzalloc(dev, usbio->txbuf_len, GFP_KERNEL);
>  	if (!usbio->txbuf)
>  		return -ENOMEM;
> @@ -607,6 +630,11 @@
>  	else
>  		usbio->rxbuf_len = usb_endpoint_maxp(ep_in);
>  
> +	if (usbio->rxbuf_len <= sizeof(struct usbio_bulk_packet))

and this, they both can be checked at the same time, with the same
function call.

thanks,

greg k-h
