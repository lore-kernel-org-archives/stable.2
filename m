Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792537027;
	b=ccn0eERmS08sC+hLxxb59/cKrnbApNjYj3l3Ku3LbKvAdQCkfi5knlfEtCpizYynlDWm
	 WozyrGLhAu16bMCECFfeFWKDkJVdhX6BI04JAEtIbby0T2K9WrP9/8tpdzh4uHHHmEaZX
	 w2cR7TS6DojGVrYiqWG8rFGCrnAPzYpt42a5RyJbxScTEugPNdUe0h5wN/8pPqEciKECr
	 9+XicXC9F94r85sVB91cEhz0H0VrPqVTR2bgcXIWp1hanX9u7HpzoS1QBD2HFPA2XFQ03
	 w7iUjbxuXH1wSnhIeY9J2dq8dNCcqm8pNmxvqd33LNtF4+G+m6Fby7s0sJ4MdYu9Xyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792537027;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=bVH1fJHf5vkXaa9LWZIGqzT2wgp2XysB6VORD+LQhvw=;
	b=nZChpBEsU+d7wuW5tbeOD+nMQbnhUZvA0ueqeEvc+/4hP2FeBUMdePQPN3Ju0+mu0S+P
	 a7FS1tkDn5o4VeBLn9DLYAK3gbqY+vzpLG9PBX03zskcICjcKE7nHZJ7QK/JjEcUHPFi6
	 Uca3bs4jbwRwvStJ/PaKa65F7CvNWZ1bzDtv3u75L4ozvh+jNan3JzaQI2HHj69pMUsNC
	 5JnLRkvQY/9GOsS2w2l1Z3ACaFvNZhwPeOePEL3m7b/SZZLFRLiC1U5Y/qk0XWVQjcQsl
	 9GSj6s1kJDazbR0OrvclXxkmqgqOrQUrlIgdrCdy3xSVjuT/vWNXr3b+c5cwyV1p8zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DdozBHqU;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A2E606A31A
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 22:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5A2E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DdozBHqU
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48dc202a60eso44580f8f.3
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 15:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792537025; x=1793141825; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bVH1fJHf5vkXaa9LWZIGqzT2wgp2XysB6VORD+LQhvw=;
        b=DdozBHqUDBzjiHMLGZcAE0TBmdgteIvD+UXOVDOyF1dw4jIK/arG4W0oHYIMrMoJqA
         Gj4Utzf9gPeDDLGJAg3KQ0LWQMYSGGwLbYpxHB2k+Y7XWEI34dToIDek4EGPC4Vts2jV
         MPz+UPjpN/jMsa0RZXRSf5+7urqLXi4RSmKaTRJqH0ZzRfIakCdmeSfObivYbm9JjuSc
         yue4IBxEKidcnuMtUoTNa07vUHjQg78ALTk6P9+u3ZJ+z0zaeEK8UQ/K/7/5GpOcNbFi
         HGzCzZqejRAcSdiWmu61KG7ect6sezy6/7BGcRWWD88tlg6oSiAquiv+NMBB2q5sen42
         iD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792537025; x=1793141825;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bVH1fJHf5vkXaa9LWZIGqzT2wgp2XysB6VORD+LQhvw=;
        b=A6T0x3wHMNdFZCegb4ApxSPFgf2RdauCfqJ2yjjyEyeWi/eK4/cCEhKzk7yHc3K7MD
         nvhvCDw2qL/HsPjUYfnRvKVzipVW+9yHdTbXF1R+u5jK1HueKXTb3cQB5RThgy0xGOz3
         AAZy1HFWv7lEi0zs3i2F61e/3CRxQo+bdXSKAmwf0/N1iqxs6CRdZ9sJ4Z0sRtQWua89
         mugsuU9iWKX6ALslbvixHRwvR9IfBqaPmFl/P7R6fUYjPIi/DiH9FHkUFAnrHPvM1XHT
         uVYr7yQKoA83fXpiHujPg8IVghqQ89iPsxDII/xAaZhTc+6lA8vLIQnjXQcsjSozXVp1
         5j4A==
X-Forwarded-Encrypted: i=1; AKwUvBwoFrPc2Vx/dz9m5wRvHFUTpmyMTnWLrllV9O8pxdVi3+kRWfbspobBYLJy0ncDlPZ82tGKUfE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLMLODw5+KcoJ2/ZNfke6oIs8tiWx4rffShvqeZkgv04RQnut4d
	aAqwy7fV+T0OvcgY6Bj/nhQYRy9DcR5QBh0BIWlKdWtJt/Wp3jmY9FQy
X-Gm-Gg: AYBFou1GFScXeE/Ufmmjdg4i7+27l5orey5YOyEjTjVnscCZ5pB/DLHI0pThRfvNSWg
	WIpJ9U4SqSbQd9Er0S55IOouVXgB1K/urt/nI1kWlC+W1bbkOBPvc01o9RvsAl2cN/G9XpxCjEN
	rtt+TWNLQu4I35284ueoN+Om6maCDl+4DKwcWX6pN2WgvYwz1K7wvpMUO54fqLrko/jB0/CoXTT
	NjqJxI5YP1fN8suyw5YDZslLMy5hmRcmK/+eiNEBCZDk0eP4sTloOnXVSM7ow9teNfcUV/Xet7Q
	1oFdXI0H5CDMc8O+OG9V0r9aWA3c9EokRJNxJ17wF2K4MtIbLsPkFBL0kWh33z4xx6hHbVX0Yxn
	yl8U9eRMtBVV595Fz65uKDmFRhLBAg4n1FGvUfIBIa4L1myOMq+kYIYsOZXJJvtG6bR65szPC9M
	VJDVFoKPZ2DjebH9qKAb9GGl0TZ+IkD5fFTcbMmC33FxWuzK1n+i3ktO32Og7Vs3D+ILQDJfbqx
	OlDJyHowQ==
X-Received: by 2002:a05:6000:992:b0:48c:4a62:9af7 with SMTP id ffacd0b85a97d-48e264c01e8mr221660f8f.28.1792537024962;
        Tue, 20 Oct 2026 15:57:04 -0700 (PDT)
Received: from foxbook (bfd231.neoplus.adsl.tpnet.pl. [83.28.41.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2583ffa8sm1292244f8f.51.2026.10.20.15.57.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 20 Oct 2026 15:57:04 -0700 (PDT)
Date: Wed, 21 Oct 2026 00:56:54 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steve Bayless
 <steve_bayless@keysight.com>, Guido Kiener <guido@kiener-muenchen.de>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>
Subject: Re: [PATCH 0/4] usb: usbtmc: fix undersized high-speed bulk packets
 on xHCI
Message-ID: <20261021005654.23517441.michal.pecio@gmail.com>
In-Reply-To: <a642dbc2e4ba0efc381c69e26821762a@tipi-net.de>
References: <20261020-fix-usbtmc-short-packets-v1-0-903f4d029193@tipi-net.de>
	<20261020184244.69b78d5e.michal.pecio@gmail.com>
	<a642dbc2e4ba0efc381c69e26821762a@tipi-net.de>
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

On Tue, 20 Oct 2026 20:33:17 +0200, Nicolai Buchwitz wrote:
> On 20.10.2026 18:42, Michal Pecio wrote:
> > But SDM4065A is apparently pretty modern (2025) gear marketed for
> > "automatic production lines", so it's odd that it has such issues.
> > Has anyone looked if the same out-of-spec descriptor shows up on
> > Windows or (don't laught at my optimism) consulted vendor support?  
> 
> Not yet, but I'll check on Windows. The vendor(s) don't really seem to
> care about the bug (surprise!). It is known for quite a while and even
> not fixed with the latest 2026 firmware for the siglent. This makes me
> assume that either most of the professional users a) use Windows or b)
> use the lan interface (which we do for most of the stations).

It's worth trying, because sporadically we see devices which enumerate
differently on Windows and on Linux for some stupid reason. Although I
have a feeling that this won't be one of those times.

> > Maybe Windows xHCI driver tries to enable out-of-spec maxpacket?
> > We could do that too, though IIRC not all controllers are happy,
> > so a SW workaround may be unavoidable.  
> 
> Did some quick tests and it looks good so far. If the usb maintainers
> can agree on making it less restrictive (/ compliant) it would save
> lots of efforts and the quirk would be down to the ZLP patch. In my
> tests all three devices worked with
> 
> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
> index 8a8636279e844..c4306482874eb 100644
> --- a/drivers/usb/host/xhci-mem.c
> +++ b/drivers/usb/host/xhci-mem.c
> @@ -1505,7 +1505,9 @@ int xhci_endpoint_init(struct xhci_hcd *xhci,
>                  err_count = 3;
>          /* HS bulk max packet should be 512, FS bulk supports 8, 16, 32 or 64 */
>          if (usb_endpoint_xfer_bulk(&ep->desc)) {
> -               if (udev->speed == USB_SPEED_HIGH)
> +               if (udev->speed == USB_SPEED_HIGH && max_packet != 512)
> +                       xhci_warn(xhci, "EXPERIMENT: keeping HS bulk maxp %u\n", max_packet);
> +               else if (udev->speed == USB_SPEED_HIGH)
>                          max_packet = 512;
>                  if (udev->speed == USB_SPEED_FULL) {
>                          max_packet = rounddown_pow_of_two(max_packet);
> 
> So this looks like the better fix. How would we want it gated, a USB
> core quirk flag per device, or per controller?

[Cc Mathias]

Good question. Do you need this fixed in stable?

Depending on regression risk maybe we could get away with no quirk
flag at all. That's what ehci and dwc2 seem to do, which means that
hopefully no device specifies illegal packet size while using 512.

Other possible risk is some device doesn't truly care (no transfer
is ever large enough to matter) and works with 512, but setting its
requested packet size (needlessly) breaks some xHCI controller.

Such devices seem not very likely to exist, though more likely than
the former kind, so I will try to test whether such xHCI breakage is
possible. Preliminary results are encouraging: although several of
my HCs reject packet size of 1024 or corrupt data, 64 is accepted by
all but one. I haven't checked for corruption yet.

I will also see if I can figure out what Windows does in such case,
because doing the same thing as Windows may be the safest bet.

> >> The Rigols still have one issue I can't work around. They split
> >> replies over 500 bytes into several transfers, and a follow-on
> >> transfer that ends exactly on a packet boundary never arrives. Raw
> >> libusb shows the same, so I guess it's another firmware bug. Should
> >> be fine for most use cases though.  
> > 
> > What exactly is the sequence of URBs you see vs would want to see?  
> 
> The Rigols split anything over 500 bytes into two transfers:
> 
>    REQUEST_DEV_DEP_MSG_IN #1
>    IN: 8 x 64 bytes (12 byte header + 500 data), then a ZLP
>    REQUEST_DEV_DEP_MSG_IN #2
>    IN: header + the rest
> 
> That works fine, unless the second transfer happens to end exactly on
> a 64 byte boundary (e.g. 640 bytes). Then the device just never
> answers request #2 and the first IN times out. I also tried leaving
> the ZLP from #1 pending until after request #2. That fixes the
> boundary case, but then the device randomly ignores request #2
> instead (roughly 1 in 5). Raw libusb behaves the same, also with
> maxpacket 64 in xHCI, so I'm pretty sure it's just another firmware
> bug. What I'd want to see is simply the second transfer arriving :)

Doesn't look like any obvious xHCI problem to me. Did it also happen
with those USB2 controllers that you used previously?

Regards,
Michal
