Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF043905F9;
	Sun,  2 Aug 2026 08:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785660280; cv=none; b=T1YARg+yEeoHojo4crm5C4aGPCXq6ab0b/xlPvUmfyXn3B6rwgdtXfjzJg+tEtkRhK8wqHCkL+8p/J2mFigS53n4wKaSWyMBzAg5bJuy5d8bhWLgEDgmDIAqAsivJ5NGCQk6fnm1JfVbbtegSNC5X52EIC/H04Rw2F2d0+7Y9k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785660280; c=relaxed/simple;
	bh=7sfW5wlvZYnYnzcSvnYlUi9Nes8niWZernyfcxy7UWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpNaH6SPe74ELo7P3IYtakM4G83EmDBDDqVmrBzPIJ5yIUYOx+FgojY6DErK1oOF+n2iAgSrc1kdvDQnN9TnDNgy8AbMzn8A3bpZMNVTIiCC2el9kvyyK2yygweXgxgSTuLShr/6ITIWvOTTyq7rhSGTffhf41TKueLNrQDIqAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y299rIWR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y299rIWR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4111F00AC4;
	Sun,  2 Aug 2026 08:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785660278;
	bh=1Roupk5IXNgnb0jQ7zaI+Ly47KyHYdNPIJ5Qwm1Ktso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=y299rIWRBVsf7PVUy/+/ich9HT/PFAxKthYj2Z5VQ3cpSrywr+WAPamNXaOOFQzBX
	 ZUcJKSwmVDIJptvz53pC2Q9K2Z5XQAvIZ1nh82q64XomwCApyIFx2D0IS9sTCFjcyp
	 wMajmZxqV//VWOo6EwCr0xxbLU17/j7kodtOAVao=
Date: Sun, 2 Aug 2026 10:43:10 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: HE WEI =?utf-8?B?KOOCruOCq+OCryk=?= <skyexpoc@gmail.com>
Cc: Hans de Goede <hansg@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-usb@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] usb: misc: usbio: reject endpoints smaller than
 the packet header
Message-ID: <2026080209-satin-existing-5450@gregkh>
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

This is a very odd diff, what tool created it?  Did "Claude" manually
write a diff?  Please use the correct git diff output so that we can
correctly validate it is proper.

thanks,

greg k-h
