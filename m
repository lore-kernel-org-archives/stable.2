Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792780013;
	b=M/baihl78P2uv2DBeIo02f5pBU9Msk5/kEL9ioCN/Hl14eQqOJO4LFLHTNtnGUdqMjae
	 DrSVdTlqXTzdDyZJ8+nZg7/yKUpoVncak0iyw157W+yiBpu1E4MqGJcBqVgoebSH1U6gA
	 9XFF8IQ6yAFDdT6vvkBHiHu5JquKNturv+hmiCncnT9qKgsZsWvbqc3YkDUwz6B4qFpfV
	 YApFT9BmbVfyc/cZjGEZysp5oB/+LJSWryxv6X/gOOThnxlNN+gTV07BPEXO13uXoJvbX
	 d8VL1IYNKmOnWReaudDTJYCXIBjQbCUBXqi34lFnGVBkuopZGDtUFheejZYsKJp1uog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792780013;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=8oxptXPm0UTdO9zxzHdUJQ/03E+e6vl9OPFrHOgj4hU=;
	b=xr3nZWUv61nErB+8liQ5HxFpLxbH5UKHEMYBKedp0OoHb/bywh/0YnxyCqVUUm7vBmvy
	 dLkujAryPbnlDaiSvwYC3PdDd4HQYRLJbR0b8GfH02r2kpILFwsazP84GUohWUUmVXrPH
	 2a8T8bvFE7ODZlZSSc4I/xzmJX4sVi2Jdh9rdc9OzkqeX5M7bf9Pqo6vM8rtATOAl9CaY
	 P4y7of8vAh0HzJdR4ng3fm4qpTD1zEJba8SiujorOFkwcBZ4/90vnK1u/3YcJNqXnJ74q
	 DssRfl5sxZiHOsWQkVeZCdDHUOIyhzwBBO9Qd7gLiCjn8v5ALsIrjQaeDQ6zEumV0bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gG04FLN6;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED5F606A31A
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 18:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1ED5F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gG04FLN6
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e0d885929so741755f8f.3
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 11:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792780011; x=1793384811; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8oxptXPm0UTdO9zxzHdUJQ/03E+e6vl9OPFrHOgj4hU=;
        b=gG04FLN62SWZJQTWBnAsPFuc6TNGJVms+K0uDPT+IGHd/lC0w+Z+gOyI8iSwPYVYUT
         t23RxuVl4gpUg/wxIsHB1QtA8XLkkSnmQLDsCejf6bMm/w4K1aHPxE7WMbUA2TIE/671
         axqbO+N0BXg6wzRUISaiVONqh181VnHVLcJ6FOu/eVynt3JPiXfaV00Eu/9yENpUn+i0
         mr3sA1dNX/ouAahyt2pcb5O7MEOVJYzPbZHf0jC/XnBZLGB933IRgtj7ehaucC7N2mr+
         Fi74DwEzCtoO/bXcJeFO0yey+Gtevpev5UQ3Kd9Fdzpyy5LsbJFPM6uBRshZ6AAs9DWn
         TEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792780011; x=1793384811;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8oxptXPm0UTdO9zxzHdUJQ/03E+e6vl9OPFrHOgj4hU=;
        b=oHrhzGeCqbOmqaR3V2aZz9Tu3jShbeGMQb2mH2OKzJKJF8ONlNZCrvqvbbcWEKfYOQ
         o3WrdWE1lD8vyWq5MHok129Ftf/f0UcDqijxRawXd6H5BB5w/vjXFkBmMUZutla/uiGM
         HbX8Z67kN2oNVgvEv4Ci07vByMoNrA30g527vFed5s42Wbhq/W9CKDIte0ils/JVSKy/
         f7TsF9SxsSQwHjbgXSyFD+OSgO07/+7Qhd9ZyDnTd0txZS8/b08AmJ31Ml/KLaJlBfSm
         Aw2+o3nzvO2qIunJGbRd5+RQNB0Z1ZyqEKyb+6I2Tg3X8Kdnbzfp13WukA92UFqx4wqb
         tEvQ==
X-Forwarded-Encrypted: i=1; AKwUvBwpSm3zbvpEsFlmzaMaJR5D715JESFYlst9lmrFgPEDjEI9QTKrjKrxFu8MB5dyhuVKgaq59jA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJAg+8UEOQ4IiknbV4olfD2uUJ78GyLlQznl+JQanjUBjFu/MlE
	kyDEDFB7WNCpxkayAKyDG2xIBDd3NYFzD56NwFgJ/c/CgC9foNCW9lF7
X-Gm-Gg: AYBFou0Mccj57fsS3xJzJMSiyS9hvtsNABm3zspuJxFyncDIGhyK7vQzSNbluD+VR+Y
	eBPrUBdIbpamQncUZ9wmBHyZgXwk8hVCr5MPeKcv0J6EhgF+B4FUnt6MZ/Lw5jqt+icPNqtjSIO
	Ub0hlea81QswjrxVRezAyP4gMmXPV6QYa5w6UjjmAz9uLWgUURyoH7Pg77tISLH286szsvkZmF5
	zBHjJfbG4kA7IK03+Q0mmfnsbTvgTfXOQITmdz+8LInxKBOUCplExLwQo7QcqceHZygXh9gcxI+
	FPRw+S9pQeP/oLH6lGRPC+mnmfIKDZTrYjH6Qu0A/FZIRsemvM5/7rWO44LnRY0O3xYYsXyvaQT
	Y2+hiJeHpIQOIezXEik8xEn0NvqAFUFnMrwzCrQ/iD/lVhHHF1apzeDqqzrViWBS+Fa8F77cOad
	tltUGe1l6W+jEnAo6I2p2hmLH46Hldm80sHP/FxnmCnAzNAFa7aJDZj4vkLepzFmNvBHK1CQqp/
	474H8EA0K3pYqDDTAlqI5CtGJWG4lYERo0fNQ+MHL04ZUXXvoUQ+X3vt7RldynWHByh+LWaRTqc
	f1Y2XKPHng==
X-Received: by 2002:a5d:5f4b:0:b0:48c:49bd:62df with SMTP id ffacd0b85a97d-48e3854ee8fmr5266476f8f.1.1792780011351;
        Fri, 23 Oct 2026 11:26:51 -0700 (PDT)
Received: from foxbook (bgu81.neoplus.adsl.tpnet.pl. [83.28.84.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d42f884sm1327266f8f.57.2026.10.23.11.26.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 23 Oct 2026 11:26:51 -0700 (PDT)
Date: Fri, 23 Oct 2026 20:26:45 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steve Bayless
 <steve_bayless@keysight.com>, Guido Kiener <guido@kiener-muenchen.de>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>
Subject: Re: [PATCH 0/4] usb: usbtmc: fix undersized high-speed bulk packets
 on xHCI
Message-ID: <20261023202645.7bf4827a.michal.pecio@gmail.com>
In-Reply-To: <cae2e837872be0560f7f46e13651059b@tipi-net.de>
References: <20261020-fix-usbtmc-short-packets-v1-0-903f4d029193@tipi-net.de>
	<20261020184244.69b78d5e.michal.pecio@gmail.com>
	<a642dbc2e4ba0efc381c69e26821762a@tipi-net.de>
	<20261021005654.23517441.michal.pecio@gmail.com>
	<cae2e837872be0560f7f46e13651059b@tipi-net.de>
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

On Wed, 21 Oct 2026 11:34:19 +0200, Nicolai Buchwitz wrote:
> I checked on Windows 11 (Intel xHCI, WinUSB + libusb): same
> descriptors as on Linux (HS, bulk wMaxPacketSize 64), and a single
> 4096 byte bulk IN read returns the complete 110 byte reply, so it
> seems, that Windows programs the 64 bytes into the endpoint instead
> of forcing 512.

Yes, that's what it seems to be doing. I passed a fake storage device
with weird endpoints to Windows 10 in QEMU and with some debug tracing
(slot/ep context hexdumps are my addition) I see this:

usb_xhci_fetch_trb addr 0x0000000139a3c450, CR_CONFIGURE_ENDPOINT, p 0x000000013a18d000, s 0x00000000, c 0x01003001
usb_xhci_slot_ctx addr 0x000000013a18d020, c 0x68000000 0x00000000 0x00000000 0x00000000
usb_xhci_ep_ctx addr 0x000000013a18d0a0, ep 4, c 0x00000000 0x00400016 0x39a3cc01 0x00000001 0x00000000
usb_xhci_ep_ctx addr 0x000000013a18d1c0, ep 13, c 0x00000000 0x00400036 0x375ff001 0x00000001 0x00000000

The 0x0040 in the second field is packet size, and it becomes 0x0400
when I change to 1024, or 0x0002 with 2050. Windows blindly copies
those eleven bits here and only gets upset if they are all zero, then
it resets and enumerates again a few times.

I don't have any out of spec device, so I tunned a Cypress FX2 into
one - it exactly replays every received packet back to the host. I
found that power of two sizes from 1 to 512 work, except on Etron HCs
which only take 512. Guess we could have an exception for those.

So this seems very viable. I will turn it into a proper patch and see
what the maintainers think. Seems better than patching class drivers.

Regards,
Michal
