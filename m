Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C53229B18;
	Wed, 29 Jul 2026 21:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785359798; cv=none; b=Yq9zouzHhrMihRasrtvJ/FdEZQITZ95bvBhzEahflK8v5I9k9+SEMZdLrLHU5/xHF4wvwOr71zF06l2x8576ScAd+gLDTymLKbxDLDpj148Vd2qW9qNlkumDQBKYdDiDu2LoZvIUS6kX/FVcCIFsa0YQN49O4ySGJdOammbYiTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785359798; c=relaxed/simple;
	bh=jhCXA+dWSWUpif09/n0d8Qt4sEbpdN8adehF2YoLyx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBF6HWB2yiLzqNyMmI1ecbGqUrLAdOXqdK1nAE9RavLFBlwb+2+2ugAkyMap07y65Km+q+djRQoZPU0gyx2ZfUu8VTysCqpQELdf4+pyTtnSOQsTDNm68GGrIClJiZum8NkzzcATafyFqtj1I3oQIM0A6QPaaLvVEE7QKqW1VsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ti3vd3LC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ti3vd3LC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4031F000E9;
	Wed, 29 Jul 2026 21:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785359797;
	bh=ICOOmH7oPMkeN55Q6RYj17FT0y6ZKJX2Y/p6cYzEeJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ti3vd3LCwYY+TxXB6RQSTLBlF7YvGZjEH2Xzx+vmu07cvKyKDHfS8I0iRe7vlx0f1
	 z9AEALmHpQkqDfmVmdXZ76ALyR9aIfj7lYO6k+DFYXMjckJjwtWsnJUQwxXR3Ki1br
	 ctP+yTmsSqM4fnqVcVF7FLIdGGwW8Z8FXhSPWlnpojJda1zojeaKctZxykav5bvDms
	 ctpKAAk8DpTV1wn/HTYcDqESLUNWo7eoHdQUPh8qMK4UcpBKX733YG8u82DTw6DVoT
	 8Co+ilgSUCRJ3ArIS3GEx6uNeoBGgSmNHAeizHYrh6hsK4b6XmL9GGZD8J5bALQban
	 nQVt9w9YG4RXQ==
Date: Wed, 29 Jul 2026 23:16:32 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: HE WEI =?utf-8?B?KOOCruOCq+OCryk=?= <skyexpoc@gmail.com>
Cc: Hans de Goede <hansg@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	linux-usb@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] usb: misc: usbio: reject endpoints smaller than
 the packet header
Message-ID: <ampsSryj3Vtjo37H@zenone.zhora.eu>
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

Hi He Wei,

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

... blah blah blah ...

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

... blah blah blah ...

> combined with "(udev->speed >= USB_SPEED_SUPER && i > 0)" below, so
> bMaxPacketSize0 of 0 or 1 gives a ctrlbuf of 1 or 2 bytes and the same
> wrap, during the five usbio_ctrl_msg() calls in usbio_probe().  Whether
> a given host controller will operate such an ep0 has not been

... blah blah blah ...

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

Please use Latin characters, with the first letter of each name
capitalized: "He Wei", not "HE WEI".

Also, your commit logs are far too long. If I had to spend this
much time reading AI generated commit logs, I'd end up spending
all my time chatting with AI instead of real people.

Please check what you are posting before sending it. Write the
commit logs yourself and use AI only to help with the grammar.

Thanks,
Andi
