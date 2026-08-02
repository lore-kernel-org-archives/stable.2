Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15A43947B5;
	Sun,  2 Aug 2026 08:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785660384; cv=none; b=Dj0X5wXQmrhaEa1sHQIzQsX7MH3YngyFVQbmad3MrqNFuv701U4HRskyp7OW7b2cDEG/4xqvbUhcuhXHEU+YLTNY/pQrxLIIbjR/ywKCK/QaA9PXtk9CT9yqTbc0MR6H+3TBJLTgKU0Y6RYdqFRS/gs6/Gwixy35TGmNS3EfqyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785660384; c=relaxed/simple;
	bh=3ZcwpEa2NfHQVR5Nd5SyiUeFflcH5yvoc99YgRW0cmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZlvUl2fjFLJ7nX+TXqDCiG+4Y88S9GEiZPKgqDkTcOHxQoa+O0NqYQmJy2CeUpb9LhJc2oUn+qFpkILV+XlGE+KeDksktFfe6dWYJvaNZUhPI99/uoWSUKN1JyyVkV970eVDTROJN2FFwpnZP4ZvSOjX2/WgItatO/P85EZmoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bCVJxIR4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bCVJxIR4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F0D21F00AC4;
	Sun,  2 Aug 2026 08:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785660381;
	bh=uuqVVnThs34ehZg3XRXY2PllsT/tzs+Y4xani+c6xrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bCVJxIR4nRBkhHTBBKTsnmXPynPSPzZkUXTDwGwd2P7+WdenZpg0EmgnVYKqmfqAT
	 obMzscQAlQgpDkeFUdn7K9E6MzZt2sBSS0dyrpvkDZlyo7051eQ+tkv5m1m7ZepP7M
	 ev26qbsOgTb5nPyuW5TIoUww/o0MEEwbrg6fwAIw=
Date: Sun, 2 Aug 2026 10:44:52 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: HE WEI =?utf-8?B?KOOCruOCq+OCryk=?= <skyexpoc@gmail.com>
Cc: Hans de Goede <hansg@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-usb@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 3/3] usb: misc: usbio: bound the debug hex dumps by
 the received length
Message-ID: <2026080222-capped-registrar-be10@gregkh>
References: <20260726113511.57596-1-skyexpoc@gmail.com>
 <20260726113511.57596-4-skyexpoc@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260726113511.57596-4-skyexpoc@gmail.com>

On Sun, Jul 26, 2026 at 08:35:09PM +0900, HE WEI (ギカク) wrote:
> usbio_ctrl_msg() and usbio_bulk_msg() hex dump the reply with "%*phN",
> using a length the device supplied and that has not been validated yet:
> 
> 	ret = usb_control_msg(usbio->udev, pipe, 0, request | USB_DIR_IN, 0, 0,
> 			      cpkt, cpkt_len, USBIO_CTRLXFER_TIMEOUT);
> 	dev_dbg(usbio->dev, "control in %d hdr %*phN data %*phN\n", ret,
> 		(int)sizeof(*cpkt), cpkt, (int)cpkt->len, cpkt->data);
> 
> cpkt->len is a u8 read back out of usbio->ctrlbuf after the IN transfer,
> and bpkt_len in usbio_bulk_msg() is le16_to_cpu(bpkt->len) read out of
> usbio->rxbuf.  Both are handed to "%*phN" as the field width.
> hex_string() in lib/vsprintf.c caps that at 64, and dereferences every
> byte up to that cap regardless of how much room the output buffer has:
> 
> 	if (spec.field_width > 0)
> 		len = min(spec.field_width, 64);
> 
> 	for (i = 0; i < len; ++i) {
> 		if (buf < end)
> 			*buf = hex_asc_hi(addr[i]);
> 
> So the dump reads up to byte 67 of ctrlbuf and byte 68 of rxbuf.  Both
> buffers are sized from the endpoint packet sizes, so this is out of
> bounds whenever ep0 wMaxPacketSize is below 68 and whenever the bulk in
> endpoint is below 69.  That covers every low, full and high speed ep0
> (8, 16, 32 or 64) and the bulk sizes the supported bridges actually use
> (64, or 63 for the Synaptics Sabre via USBIO_QUIRK_BULK_MAXP_63).
> 
> A device answering one of the five usbio_ctrl_msg() calls in
> usbio_probe() with cpkt->len = 255 therefore leaks up to 60 bytes of
> adjacent slab memory into the kernel log during enumeration, before any
> user space is involved.  On the bulk path a reply claiming
> bpkt->len = 0xffff reads 5 bytes past a 64 byte rxbuf.
> 
> Unlike the endpoint size issues this needs no malformed descriptor at
> all; it only needs the dev_dbg() calls to be enabled.  When they are, it
> is a slab-out-of-bounds read under KASAN and the bytes reach dmesg.
> 
> Bound both dumps by the number of bytes actually received.  That is in
> bounds by construction and also stops the dump printing stale bytes left
> over from an earlier transfer.  The matching dumps on the two OUT paths
> are left alone: they use lengths the driver itself just wrote, which the
> size checks above them already bound.
> 
> Found by code review.  The out-of-bounds read was reproduced under
> AddressSanitizer with a userspace model of the two dev_dbg() call sites
> and of hex_string()'s field-width handling; it has not been exercised on
> hardware or on dummy_hcd.
> 
> Fixes: 121a0f839dbb ("usb: misc: Add Intel USBIO bridge driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5 asan
> Signed-off-by: HE WEI (ギカク) <skyexpoc@gmail.com>
> ---
> --- a/drivers/usb/misc/usbio.c
> +++ b/drivers/usb/misc/usbio.c
> @@ -14,6 +14,7 @@
>  #include <linux/dev_printk.h>
>  #include <linux/device.h>
>  #include <linux/lockdep.h>
> +#include <linux/minmax.h>
>  #include <linux/mutex.h>
>  #include <linux/string.h>
>  #include <linux/types.h>
> @@ -141,7 +142,7 @@
>  	struct usbio_ctrl_packet *cpkt;
>  	unsigned int pipe;
>  	u16 cpkt_len;
> -	int ret;
> +	int dbg_len, ret;
>  
>  	lockdep_assert_held(&usbio->ctrl_mutex);
>  
> @@ -181,8 +182,15 @@
>  	cpkt_len = sizeof(*cpkt) + ibuf_len;
>  	ret = usb_control_msg(usbio->udev, pipe, 0, request | USB_DIR_IN, 0, 0,
>  			      cpkt, cpkt_len, USBIO_CTRLXFER_TIMEOUT);
> +	/*
> +	 * cpkt->len has just been written by the device and is not validated
> +	 * until below, while %*phN dereferences up to 64 bytes of whatever
> +	 * field width it is handed.  Bound the dump by what was received.
> +	 */
> +	dbg_len = (ret > (int)sizeof(*cpkt)) ?
> +		  min_t(int, cpkt->len, ret - (int)sizeof(*cpkt)) : 0;

LLMs love to write comments, please think about what it is attempting to
do here and if a comment is even needed.

And that line is crazy, please write code for people first, compilers
second.  Make that readable, because as-is, it's not.

And finally, it's obviously LLM generated as they do not know how to
properly deal with min_t() lines due to it being trained on "old" kernel
code.  That's wrong, please do it properly, you should almost never be
using min_t() anymore.

thanks,

greg k-h
