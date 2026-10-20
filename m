Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792521210;
	b=G2u16hdLgK0chWZM/P9L5iwKfr5qYrWGJA9kqqXFwGF6jOKm400NpxlGTnoiFJ923MZB
	 Rug8ehwXPuiv+5SauvOAgeZkdztAKCYc8e8fAlu99VS2p6Y99u900GCuR53FpEMGJFHQb
	 z7LE9LbR5icr5MaNSvvK8Tg4WKhG3CkX4xo4gThsKtrM6A0ElaCNLX+M32huO6xgnzFcD
	 EJpeBtaMJTZoYvgx1l9IH92+XNaDdKxF1gd+FuWOH0eNrPuuSMyJ5BcS0TqN0Y6wl2FaB
	 6rL4t719BZ9P8UuC5iaDOJIHSm7BM5qYsTR8uh/d2Z/I0PcMbegY31/ccGO1VTkckpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792521210;
	h=DMARC-Filter:Received:DKIM-Signature:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=0z9aJM5pcb7dWz5EgKYVG4y4LAG3PeNtEiLV7ggtYRc=;
	b=SACWsYsoXfUIKrgfj3qx418gkIJo1LfaLC/kPkWEqrUg1SM1IrUi21tADYUC1Ggn+DaQ
	 0Qkq6zybwXnXV+JihpFXikrC6CamaxAWuE+MQwk+YhEY5B8RIhuVCbNL/wa1DpQAVL1fG
	 erEon+Ud85zcAe/A66GXa2CbDt06jBt+H3CSWmsFPtUiUJyD2qODt0ZypMH3sQXnuAz64
	 XN8Oqd6JFk+rBk4XZs3OfHTRXHos4rvO0pKltwQ+3qR9fv0qpGwOkbeYlqAAPqH6FSM8z
	 ZYXSk7hzkZXMNZ2ew8ggC3eijia5a/746egK3UWJi5LZlX1qYRtMZy9DU8OPE7zyiaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=JTwO+OeJ;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF01606A31A;
	Tue, 20 Oct 2026 18:33:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFF01606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=JTwO+OeJ
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 43C89A156A;
	Tue, 20 Oct 2026 20:33:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792521198; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=0z9aJM5pcb7dWz5EgKYVG4y4LAG3PeNtEiLV7ggtYRc=;
	b=JTwO+OeJj20KZlr9tv+3kST6kEEl7JPmOCBFgFFVCNjecNVZP2qVu24zJxuFi2nmPEBTTe
	ew5RyL0/pBeakP84TlsPY7nBlEkQpoPoYHOuOmVUMDeTaL1yAhLh2MPUfdKifAVTr7LxP6
	fRRueY+w4hQ3NiTbFwhsHauHPjQeUDQUHzRLVzmcxvwKpIygsueKgny0vHxeWza/qTulaT
	y2euBenaXrc9Hh9eDiSnN0Eoy29Jp52CE4QG2Ld3b4NHPDSUvxrcp4cEj+tA75GbcS81u0
	n3CGRzhl/bb7bQHX91feDGk8ziJOAb/V/FF9YCejEtxR0YB8Jxrg4H8jo8A+tQ==
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 20 Oct 2026 20:33:17 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steve Bayless
 <steve_bayless@keysight.com>, Guido Kiener <guido@kiener-muenchen.de>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 0/4] usb: usbtmc: fix undersized high-speed bulk packets
 on xHCI
In-Reply-To: <20261020184244.69b78d5e.michal.pecio@gmail.com>
References: <20261020-fix-usbtmc-short-packets-v1-0-903f4d029193@tipi-net.de>
 <20261020184244.69b78d5e.michal.pecio@gmail.com>
Message-ID: <a642dbc2e4ba0efc381c69e26821762a@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Michal

On 20.10.2026 18:42, Michal Pecio wrote:
> [...]

> But SDM4065A is apparently pretty modern (2025) gear marketed for
> "automatic production lines", so it's odd that it has such issues.
> Has anyone looked if the same out-of-spec descriptor shows up on
> Windows or (don't laught at my optimism) consulted vendor support?

Not yet, but I'll check on Windows. The vendor(s) don't really seem to
care about the bug (surprise!). It is known for quite a while and even
not fixed with the latest 2026 firmware for the siglent. This makes me
assume that either most of the professional users a) use Windows or b)
use the lan interface (which we do for most of the stations).

> 
> Maybe Windows xHCI driver tries to enable out-of-spec maxpacket?
> We could do that too, though IIRC not all controllers are happy,
> so a SW workaround may be unavoidable.

Did some quick tests and it looks good so far. If the usb maintainers
can agree on making it less restrictive (/ compliant) it would save
lots of efforts and the quirk would be down to the ZLP patch. In my
tests all three devices worked with

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 8a8636279e844..c4306482874eb 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -1505,7 +1505,9 @@ int xhci_endpoint_init(struct xhci_hcd *xhci,
                 err_count = 3;
         /* HS bulk max packet should be 512, FS bulk supports 8, 16, 32 
or 64 */
         if (usb_endpoint_xfer_bulk(&ep->desc)) {
-               if (udev->speed == USB_SPEED_HIGH)
+               if (udev->speed == USB_SPEED_HIGH && max_packet != 512)
+                       xhci_warn(xhci, "EXPERIMENT: keeping HS bulk 
maxp %u\n", max_packet);
+               else if (udev->speed == USB_SPEED_HIGH)
                         max_packet = 512;
                 if (udev->speed == USB_SPEED_FULL) {
                         max_packet = rounddown_pow_of_two(max_packet);

So this looks like the better fix. How would we want it gated, a USB
core quirk flag per device, or per controller?

> [...]

>> The Rigols still have one issue I can't work around. They split
>> replies over 500 bytes into several transfers, and a follow-on
>> transfer that ends exactly on a packet boundary never arrives. Raw
>> libusb shows the same, so I guess it's another firmware bug. Should
>> be fine for most use cases though.
> 
> What exactly is the sequence of URBs you see vs would want to see?

The Rigols split anything over 500 bytes into two transfers:

   REQUEST_DEV_DEP_MSG_IN #1
   IN: 8 x 64 bytes (12 byte header + 500 data), then a ZLP
   REQUEST_DEV_DEP_MSG_IN #2
   IN: header + the rest

That works fine, unless the second transfer happens to end exactly on
a 64 byte boundary (e.g. 640 bytes). Then the device just never answers
request #2 and the first IN times out. I also tried leaving the ZLP
from #1 pending until after request #2. That fixes the boundary case,
but then the device randomly ignores request #2 instead (roughly 1 in
5). Raw libusb behaves the same, also with maxpacket 64 in xHCI, so I'm
pretty sure it's just another firmware bug. What I'd want to see is
simply the second transfer arriving :)

> [...]

Thanks,
Nicolai
