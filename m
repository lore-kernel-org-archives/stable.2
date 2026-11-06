Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793949430;
	b=uwP8Dhq0agI7nCPapKfx5CD5dqVIJuoSy+sP/eFXLfPIo6Zefox8UYcwVGDyQt/VPhzy
	 OjuCI8kY9Pj1JGaRZ2YG98iwNto8szflvSFCT4ay7mbYS5PfAieMXfy8+ZIOqRtX5SqIH
	 BhPfiXpAWDhJKxN6cCF4zrAWRfPfIXIJU4a7EcpmC/MlT8mTuumzvQ77NcbVdmdIn2AUe
	 I256mwo1qknrHRqQ/IjW3N3aiqFzmqpbw/pAd1YZeS96ErT4tuqjYIH0ocq9ZdpFz+O86
	 kluVwa1UXzaZI7hA0pN4q8ao5tMKQ9nWB7ddI59EU+DifxZSyNr3gbQSrm098jeRzPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793949430;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=phaG8fIAEdt42w1dFHlmJNP6UPxHP0iPRF5M4YLpvzA=;
	b=4OYgswbwFpj4rdKUyjsPnSt00khwDhKUSxx47/1wvfEINC0k/L7jacQavplVpTJHkve4
	 EbL4OQfsKz6+tmSawupP5m7LBqlv4JO9vzRaXXFhzpyKsJdDv/kmumCPI17FsFKFV7npo
	 ckhgB6THeLi4ByWvbxuNE0w6VmlkOBLZJ9RYTjJkUN9OEWq9xKiuDst5witB6ifmPvv4R
	 FlJTdZWy4rsPBEQu97mSvm0syGDJu2CIU5WvHZHwFmsDOSIRwz9Oml4VngQT3W/rLmaVo
	 X1iXMbM+3TW3j7xOiEkN3CG8uZepyguMirreMJCMAG0TwJIGbNi7pHyGvVRGwBWbr5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=miRj7K7Y;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60258606A32D
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 07:17:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60258606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=miRj7K7Y
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so2789975e9.2
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 23:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793949429; x=1794554229; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=phaG8fIAEdt42w1dFHlmJNP6UPxHP0iPRF5M4YLpvzA=;
        b=miRj7K7YHuY/8RFNhJ0nHR2yBAi2kd714Di5I0TQTBckobNwsqlzV/exwwTJcoimIN
         S3ZUr0O53UJuTaIe2J05KOusgkeScEKsdnliLj/GpXUjg/+W0mB26W3o6wPW7sco7SSi
         2Hpx3e6zgxqls9cXc0usSd8hd0bZ9Lyy2QHRmI9pb1guzNeUWiZ4YxfKP6hKxawGIIV/
         8RrZOY8CYfn5DBLkOk0pDLwaLCl8XAC3HzGK37hiu+TQb23t34VMVPB/jhjMP//1Pyoz
         GVfBoe+YkomZBFPsVwBBvoA3bnnDeuWJUMCAnz/lGdejclUfqgE22Hx/IF7spLGEhTFX
         tCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793949429; x=1794554229;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=phaG8fIAEdt42w1dFHlmJNP6UPxHP0iPRF5M4YLpvzA=;
        b=GlUMOyRYqMvGKXDrJ0evUlw1rrwiD10/v5OMxYiL6GFwWRtXoqFEelfimYLLlPxAP8
         lY+BNFF+OsZo905n7OGRiIpzUGecJ8RiG31xKUIYpKaBAijP2KDY3bd7Ub2nrNyXmrfZ
         oNG40VaHLjL14SSV5UthIS2wi/mkI+0qRGoKUUFdCiIYocJN4LAoTFTFX7fRfMZ6cI4c
         PnmFRwr6agcFCzAGAikYTd3Gqcrjnt/z8LQkM1sIvWpIXL4mErN5PXOF+BnSkF5/xnWP
         B8GMTU3wBDkKn+OezGfmc+kNUGMsZoWYHqcMcP0NOB4gG8Tj4uPICYwekrJZFODd18gp
         qjsg==
X-Forwarded-Encrypted: i=1; AKwUvByvr2izPhg2BFzCBZ+bczJaTYWSDUtSj79kO1rXoo/HyyS9QixgNf7oZHhAzpGH8uc3efabHf4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9XV/Mvx2HHnYr5KlKz/yjwc98rXBjWggLFJ+uF/iqGNYNYMAwC
	EHyH3+l/Oh5OvYf7w2PtdxJF2QyabstTeGKI+X82t3j/UcASKikRK8ms
X-Gm-Gg: AYBFou3tkH9QFrZy43mG5Z/omvoJx2iwItM83J5fHyWb8m6JGrpGS2KDZ0Bs3F5ICIG
	RtSNl1pGFuVy9WPjn17Mcxj9m0w+xD4MSsHAsgJXi/M5BGE02RjQx+ILng5Po4x9+Ek/ENyKpkw
	RABG7Dp8ozmmt44vYBOM4Zom492o0sBlh0KcJ6hcOLVNC5jVDCOXkSX/6GqO5p5kkuwDauqhdip
	g0b4lKHDcchCpLOlzJdH7jbX74IOJ/krYCU18TXF1NCWelfowrqQBFgBCOMy3C8f803bZG82Sxo
	zmR67Jfz8i3KMM4ndvxepgpDtSKap6K1/WFLwLXoQSrs8E2DGKZQLcBv/5stU3B50Gb1TdU3eaE
	8XnLzd/rOqIvQSUszLhHyhPPGKZdA+w6LZQj/MSPK7IPNKCZyiqmml9Wis5Ne4rWMEjGTorIpIg
	vLX6msMX79oSzyI8sKsbdDvqqlOPSkUZ8nnkqjuunGsLZhYXt10bDhv2BtZf0e9V6+1NmrGf/FA
	KDHtjGkRbdjprGPxFl2Wv7wO9tnuEC8JNza5JA4rTIdcXtZoffmjxvnBCigPqToLv6wr9xd+Ot9
	ah7Jdvt6mfxWflo6Mg0XvnFfeABCgVnw07Kur6w=
X-Received: by 2002:a05:600c:314f:b0:4b0:bc65:b9b5 with SMTP id 5b1f17b1804b1-4b6e063f9a9mr22671795e9.35.1793949428444;
        Thu, 05 Nov 2026 23:17:08 -0800 (PST)
Received: from foxbook (bfg124.neoplus.adsl.tpnet.pl. [83.28.44.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49354fc5ab4sm178934f8f.30.2026.11.05.23.17.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 05 Nov 2026 23:17:08 -0800 (PST)
Date: Fri, 6 Nov 2026 08:17:03 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Pengfei Lv <lvpengfei20@huawei.com>
Cc: <gregkh@linuxfoundation.org>, <stern@rowland.harvard.edu>,
 <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>, <xuhaiyang5@hisilicon.com>,
 <xuetao09@huawei.com>, <caiyadong@huawei.com>, <suzhuangluan@hisilicon.com>
Subject: Re: [PATCH v2] usb: core: hub: Re-guess ep0 maxpacket size on reset
Message-ID: <20261106081703.295cc0a2.michal.pecio@gmail.com>
In-Reply-To: <20261106031625.1824732-1-lvpengfei20@huawei.com>
References: <20261104124402.1269650-1-lvpengfei20@huawei.com>
	<20261106031625.1824732-1-lvpengfei20@huawei.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Nov 2026 11:16:25 +0800, Pengfei Lv wrote:
> Per USB 2.0 spec section 5.5.3, the ep0 maxpacket size is fixed for
> all device speeds except full-speed devices, where it can be 8, 16,
> 32, or 64 bytes and can only be determined by reading the device
> descriptor.  During the initial enumeration of a full-speed device,
> the USB core guesses 64 bytes (hub_port_init() with initial=true);
> after reading the descriptor, the real value (e.g. 8) is stored in
> udev->ep0.desc.wMaxPacketSize and propagated to the xHCI ep0 context
> via an Evaluate Context command.

  ... and applied to hardware by the usb_ep0_reinit() call.

Is there anything xHCI-specific about this issue?
Any properly working HCD should behave equivalently.

> 
> After a port reset (usb_reset_and_verify_device() -> hub_port_init()
> with initial=false), the "if (initial)" guard added by commit
> ff33299ec8bb ("USB: core: Fix race by not overwriting udev->descriptor in hub_port_init()")
>
> skips the ep0 maxpacket guess block, so
> udev->ep0.desc.wMaxPacketSize retains the real value (e.g. 8).  The
> xHCI Reset Device command preserves the ep0 context as well, so the
> xHC ep0 max_packet also stays at 8.

So it's another unimportant xHCI implementation detail.

Doesn't need to be mentioned at all; it's obvious that if we don't
change ep0.desc then there is no reason to update the HW either.
 
> When the subsequent re-enumeration then uses the "new scheme" and
> issues a 64-byte GET_DESCRIPTOR (get_bMaxPacketSize0 with size=64),
> the xHC queues a Data TRB

xHC is the HW, it doesn't queue any TRBs.

Why not just omit all those irrelevant details of how xHCI implements
policies decided by this code?

> of length 64 but applies ep0 max_packet=8
> for short-packet detection.  If the device's first data packet is
> exactly 8 bytes and it sends no ZLP,

It certainly shouldn't be sending any ZLP if descriptor size is not
a multiple of packet size. This whole paragraph boils down to:

  If a buggy device responds with one 8 byte packet and NAKs all
  further polling, the HC doesn't recognize a short transfer but
  keeps polling for the rest of the descriptor till unlink.

> the xHC does not recognise a
> short packet, keeps issuing IN tokens for the remaining 56 bytes, and
> the control transfer hangs in the Data stage until URB timeout.
> 
> This is not merely theoretical.  It was observed in production on a

s/is not merely theoretical. It// would still be fine.

> 6.6 LTS kernel with a Full-Speed USB banking token (bMaxPacketSize0
> = 8) in a virtual-machine USB passthrough scenario; the reset
> re-enumeration hangs 100% of the time after the VM issues
> USBDEVFS_RESET.  Bus captures with an Ellisys analyzer confirm that
> the device sends exactly one 8-byte packet for the 64-byte request
> and then stops responding to IN tokens, relying on the host's
> short-packet detection with max_packet=64 to terminate the transfer.
> For the subsequent 18-byte GET_DESCRIPTOR (usb_get_device_descriptor,
> wLength=18) the same device sends the full 18 bytes as 8 + 8 + 2;
> the final 2-byte packet is always a short packet regardless of
> max_packet, so that transfer succeeds on both kernels.  This is why
> the device completes initial enumeration yet hangs on reset
> re-enumeration.
> 
> The device is not strictly compliant (it should continue answering
> IN tokens for the 64-byte request), but this class of USB banking
> token is widely deployed in enterprise environments, and the
> regression introduced by commit ff33299ec8bb ("USB: core: Fix race by not overwriting udev->descriptor in hub_port_init()") breaks a configuration that
> previously worked.
> 
> Fix this by removing the "if (initial)" guard so that the ep0 maxpacket
> size is re-guessed from udev->speed on every reset, and by calling
> usb_ep0_reinit() afterwards when !initial so that the new software
> value is propagated to the xHCI ep0 context via an Evaluate Context
> command before the GET_DESCRIPTOR data stage.

More unnecessary xHCI details.

> The usb_ep0_reinit() call is necessary because commit e34900f46cd6
> ("xhci: Reconfigure endpoint 0 max packet size only during endpoint reset")
> moved the ep0 maxpacket sync point from xhci_urb_enqueue()
> (xhci_check_maxpacket, lazy per-URB) to xhci_endpoint_reset()
> (xhci_check_ep0_maxpacket, eager), reachable only via
> usb_ep0_reinit() -> usb_enable_endpoint(reset_ep=true) ->
> usb_hcd_reset_endpoint() -> xhci_endpoint_reset().  Without the
> explicit usb_ep0_reinit() after the re-guess, no Evaluate Context
> command is issued on the reset path: the pre-existing
> usb_ep0_reinit() in usb_reset_and_verify_device() runs before
> hub_port_init() and thus syncs the stale value, and the subsequent
> hub_enable_device() -> xhci_setup_device(SETUP_CONTEXT_ONLY) returns
> early when the slot is already in SLOT_STATE_DEFAULT.

Does this need to be explained?

usb_ep0_reinit() is quite self-explanatory, or its effects could be
explained with one HCD-agnostic sentence if you must.

> The !initial guard on the new usb_ep0_reinit() call ensures that
> initial enumeration is unaffected: on first enumeration the ep0
> context is initialised by the Address Device command, so no extra
> Evaluate Context is needed.

This, of course, makes assumption that xhci-hcd has guessed the same
initial values as USB core. (Which it currently does).

Not sure if this optimization is worth bothering with. For xhci-hcd
at least, usb_ep0_reniti() exits quickly if no change occurred. And
you say it's a no-op for others? Great, who cares if we call it.

>  For high-speed, low-speed, and
> SuperSpeed-or-faster devices, xhci_endpoint_reset() returns early
> (speed != USB_SPEED_FULL), so the call is a no-op on xHCI, and on
> non-xHCI host controllers endpoint_reset for control endpoints is
> likewise a no-op (e.g. ehci_endpoint_reset only handles bulk and
> interrupt endpoints).  The descriptor-immutability checks (!initial
> && maxp0 != udev->descriptor.bMaxPacketSize0) remain unchanged;
> udev->ep0.desc is not part of udev->descriptor and is not the field
> involved in the read_descriptors() race that commit ff33299ec8bb ("USB: core: Fix race by not overwriting udev->descriptor in hub_port_init()") fixed, so
> restoring the wMaxPacketSize re-guess does not reopen that race.
> 
> Fixes: ff33299ec8bb ("USB: core: Fix race by not overwriting udev->descriptor in hub_port_init()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Pengfei Lv <lvpengfei20@huawei.com>
> ---
> 
> Changes in v2:
> - Add usb_ep0_reinit(udev) after the ep0 maxpacket re-guess block,
>   guarded by !initial, to propagate the new wMaxPacketSize to the
>   xHCI ep0 context.  v1 only removed the if(initial) guard, which
>   is insufficient after commit e34900f46cd6 ("xhci: Reconfigure endpoint 0 max packet size only during endpoint reset")
>   moved the xHCI ep0
>   maxpacket sync point from xhci_urb_enqueue() (xhci_check_maxpacket,
>   lazy per-URB) to xhci_endpoint_reset() (xhci_check_ep0_maxpacket,
>   eager), reachable only via usb_ep0_reinit().  The !initial guard
>   avoids a redundant Evaluate Context on first enumeration, where the
>   Address Device command already initialises the ep0 context to 64.
>   (Sashiko AI review)
> - Expand commit message with observed-in-production evidence and the
>   wLength=64 vs wLength=18 device behavior distinction, per Alan
>   Stern's review.
> - Note: on kernels before e34900f46cd6 (e.g. 6.6 LTS), the xHCI ep0
>   maxpacket sync happens lazily in xhci_urb_enqueue() via
>   xhci_check_maxpacket(), so removing the if(initial) guard alone is
>   sufficient and the extra usb_ep0_reinit() call is a no-op for ep0
>   maxpacket sync (xhci_endpoint_reset returns early for control
>   endpoints on those kernels).  This patch targets current mainline
>   where e34900f46cd6 is already present.  Would the maintainers
>   prefer a separate, simpler patch (without the usb_ep0_reinit()
>   addition) for stable branches predating e34900f46cd6, or is this
>   single patch acceptable for backport given that the
>   usb_ep0_reinit() call is harmless on those kernels?
> ---
>  drivers/usb/core/hub.c | 49 +++++++++++++++++++++---------------------
>  1 file changed, 25 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 199d3f535a89..a6c260d39094 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -4969,33 +4969,34 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
>  	}
>  	oldspeed = udev->speed;
>  
> -	if (initial) {
> -		/* USB 2.0 section 5.5.3 talks about ep0 maxpacket ...
> -		 * it's fixed size except for full speed devices.
> +	/* USB 2.0 section 5.5.3 talks about ep0 maxpacket ...
> +	 * it's fixed size except for full speed devices.
> +	 */
> +	switch (udev->speed) {
> +	case USB_SPEED_SUPER_PLUS:
> +	case USB_SPEED_SUPER:
> +		udev->ep0.desc.wMaxPacketSize = cpu_to_le16(512);
> +		break;
> +	case USB_SPEED_HIGH:		/* fixed at 64 */
> +		udev->ep0.desc.wMaxPacketSize = cpu_to_le16(64);
> +		break;
> +	case USB_SPEED_FULL:		/* 8, 16, 32, or 64 */
> +		/* to determine the ep0 maxpacket size, try to read
> +		 * the device descriptor to get bMaxPacketSize0 and
> +		 * then correct our initial guess.
>  		 */
> -		switch (udev->speed) {
> -		case USB_SPEED_SUPER_PLUS:
> -		case USB_SPEED_SUPER:
> -			udev->ep0.desc.wMaxPacketSize = cpu_to_le16(512);
> -			break;
> -		case USB_SPEED_HIGH:		/* fixed at 64 */
> -			udev->ep0.desc.wMaxPacketSize = cpu_to_le16(64);
> -			break;
> -		case USB_SPEED_FULL:		/* 8, 16, 32, or 64 */
> -			/* to determine the ep0 maxpacket size, try to read
> -			 * the device descriptor to get bMaxPacketSize0 and
> -			 * then correct our initial guess.
> -			 */
> -			udev->ep0.desc.wMaxPacketSize = cpu_to_le16(64);
> -			break;
> -		case USB_SPEED_LOW:		/* fixed at 8 */
> -			udev->ep0.desc.wMaxPacketSize = cpu_to_le16(8);
> -			break;
> -		default:
> -			goto fail;
> -		}
> +		udev->ep0.desc.wMaxPacketSize = cpu_to_le16(64);
> +		break;
> +	case USB_SPEED_LOW:		/* fixed at 8 */
> +		udev->ep0.desc.wMaxPacketSize = cpu_to_le16(8);
> +		break;
> +	default:
> +		goto fail;
>  	}
>  
> +	if (!initial)
> +		usb_ep0_reinit(udev);
> +
>  	speed = usb_speed_string(udev->speed);
>  
>  	/*
> -- 
> 2.34.1
> 
