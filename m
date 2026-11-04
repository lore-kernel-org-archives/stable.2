Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804369;
	b=ZfaPchXWqwak6FAxFK0IRPoYkix1DcpznLu2grB1exIFOJMTpbZay0y1ARFNSz4mF+Qi
	 P1lRJMN3qlHQ0+zVeTkqlhPBBComQ+hVefcqk32gBxPkWiRnX6Alx7xdE41eFCwKTjLL6
	 9CB7KfGFy3kCzheF/mOwm7dimleBPK2WoFHQOzdmj5dTP/u91iRRKBRHa3ZvXUuz/MuhI
	 D0uuMUwhXY7V2SpLY9/d+aRjgSrPWgumzgnT7hs6CjPth+Zu+K6NiLGKKYwjlH3z/gIcn
	 eHoncwMnVmXBRaExAIrVbw6dREZsKNJRfyGwkMKnVnxxn2PLsNSUjvPkpkcHw+QF8xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804369;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=3/ZyrLpO2YrBePg65ZDHqsYDsU9Sy6HHpGp70pYUFOk=;
	b=SqcICt7AK9gMRdxtqJxBTjEEh/QhnSYeco63VC/8Eo2PIfufTLe4rDcVT6KXE3iAJhl0
	 0u205P+5SuVjTwbn2AT2K/hF58JPkFLryvl0Hd/zhVLq/IIUAaEc9cqv4quJ78z/y7Nvy
	 XJftoE69/6r3T8s8Tm53UVGFKfQwVpvkQTGmuGBYqeDbRvlP0UmjMP8gT1wmbYAcJjdrf
	 TDAvAYOOStGQnKKmSfKipBcUKVGd82bdYNXC2QrEvxOdz5WaGZzda6cT1T0L+CRl/0ymw
	 EfGoNCh+z8RwkpGtXXbXHZzsd44GaGDEaCeQBt/6OwzQe6ccoLCYbwPmBg/X5zxe8nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	dkim=pass header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=lEq8b60o;
	arc=none smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2780E606A330
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:59:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2780E606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=lEq8b60o
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-53397554beaso7006571cf.3
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 06:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1793804368; x=1794409168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3/ZyrLpO2YrBePg65ZDHqsYDsU9Sy6HHpGp70pYUFOk=;
        b=lEq8b60ocutpLxRGePnCFzYel0RtNnge+x8ga4YH7qzBAawsSbf88qMkorjv7NBzeW
         pEawZmqa/qmeDH7WxV2HXn0YhTnMFIY3eJm7S8V1UWvTa9oIa1c0ovKxQ7oeIFogcZj5
         rE7ALhD9m83r1G0NIoGoX0dUSQUNEVFIqovuKzcgH5cTOHKJF+pvd6yGC2vLCnsmdnLE
         QUp4ushRr4OWRo4VLYhOUqy3o/laCUqBlxavtqowtU6VJJnj5uK6QvWQD9DQHjRgPzXA
         dBzT3IB8Db55QZZ1nG1myJ8TaJps7VBk49kGMlUmtrLsWWTKM6sXllY4fDfu+vOcebG4
         jdSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793804368; x=1794409168;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3/ZyrLpO2YrBePg65ZDHqsYDsU9Sy6HHpGp70pYUFOk=;
        b=V/U4WMlyHywmay53m783ZXQ8oZ6LZpHMmjTnjnco/mntyN7zck7kKH7gFq6y3eLMti
         Ee3kNz2qHFPADiHwCh1EXkLe8IUY1ifScF8VZ8aOdC/fqg4Wt8UzpY5MQZhTSPogKqP7
         tEoJG6m8y2M74+4k7uSs3ACJatUH/rixdqSztDqjXzkHFiuY6LOpDfzio8qxIxG6EWqh
         xZJN9oDW52AYVuKzGN1e/jFnhkC3LMWIat8XoVeLCZLCn7xDtgDvTNRsbn6PJZSs1ElR
         2wa4ll1uMeF+bxoI/x45mS9ZvUpzM1Z+u5a27084hy+rPUtmDNJkxmKUbS5tsjYNhqgQ
         5vTA==
X-Forwarded-Encrypted: i=1; AKwUvBybmOAEuntXF9PoO3lEy7FKJiafne207T3exgLpRs0qbYgGlSked9Dn77h6O8ckY8LTzQW4s6Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z9bzyA08qxolbRxqgnDSaSpwn6F9F15RNhn9TNzD2O5gEUjPnEr
	CP8VIpFoTiXxWPJvf8BhdixSBabGtN/tmPfPtOnK6PbPyLvhGvruX0HzCrylVBUosg==
X-Gm-Gg: AYBFou2SFa1k+IU6mSCvSmjI5w1IHIDdfK2NzL2m4+kmhJitjSvCo4VXV4HoYtmGIVf
	5gNOLvz2EhupBW2WetEhCcLsw7+DQeuNfFtitcsPM0yV/mBs4RKJiJAjOZxBhZFJpc7bgShp4Ra
	XKDeXyzrKwF/S/kQ7XYWQJafN4gC8UtIxPUYPh2PxGw8gzd13VZvTa2+oxLZ319ZzEuPV06Y10i
	igsLNPrI5DDR5GmdrGYRTri05+qD2tHDZ4rxM7VcCsyg+LwF93f9HWQhqAY0HcXTHdSmHue1x3A
	HNgI1kGJOG9EyoLISRz0s+fTTnnbtExp/qaymbFy3bfbw1q2EFZ9f1hZFQpSCJOSitiImAUZM9X
	Smf0y3EoIY2wkgVjGnaDqy5T6bVaEYVsYMy0gh5X5sY7Zd58/DfKrlMfEjF/w/WFjToH/+H7TNk
	k4pIddExfvvLfjlhVRMZC8FiyYz9+MgiS+tg+MAyjMicF4O0/rAqk/PDMwDO7gAXryNem/Bj56h
	P2YNBpM9gtCrfShMvhJ3dhWaccPdHaZaC71LwWW+PUtrmMSlvV7yN4rq6JfxfWBBjPllfRmzRDY
	QmO55EiHEfg9Ood3nT1CfvrtIguvmA==
X-Received: by 2002:a05:622a:54f:b0:536:35e1:b5 with SMTP id d75a77b69052e-542b405b141mr275442201cf.1.1793804367929;
        Wed, 04 Nov 2026 06:59:27 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::66b0])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10c48591sm25768241cf.18.2026.11.04.06.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:59:27 -0800 (PST)
Date: Wed, 4 Nov 2026 09:59:24 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Pengfei Lv <lvpengfei20@huawei.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	xuhaiyang5@hisilicon.com, xuetao09@huawei.com, caiyadong@huawei.com,
	suzhuangluan@hisilicon.com
Subject: Re: [PATCH] usb: core: hub: Re-guess ep0 maxpacket size on reset
Message-ID: <b9ac3c8f-7ce5-43d1-bcf1-d2ce9877d914@rowland.harvard.edu>
References: <20261104124402.1269650-1-lvpengfei20@huawei.com>
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
In-Reply-To: <20261104124402.1269650-1-lvpengfei20@huawei.com>

On Wed, Nov 04, 2026 at 08:44:02PM +0800, Pengfei Lv wrote:
> Per USB 2.0 spec section 5.5.3, the ep0 maxpacket size is fixed for
> all device speeds except full-speed devices, where it can be 8, 16,
> 32, or 64 bytes and can only be determined by reading the device
> descriptor.  During the initial enumeration of a full-speed device,
> the USB core guesses 64 bytes (hub_port_init() with initial=true);
> after reading the descriptor, the real value (e.g. 8) is stored in
> udev->ep0.desc.wMaxPacketSize and propagated to the xHCI ep0 context
> via an Evaluate Context command (xhci_check_maxpacket()).
> 
> After a port reset (usb_reset_and_verify_device() -> hub_port_init()
> with initial=false), the "if (initial)" guard added by commit
> ff33299ec8bb ("USB: core: Fix race by not overwriting udev->descriptor in hub_port_init()") skips the ep0 maxpacket
> guess block, so udev->ep0.desc.wMaxPacketSize retains the real value
> (e.g. 8).  The xHCI Reset Device command preserves the ep0 context
> as well, so the xHC ep0 max_packet also stays at 8.
> 
> When the subsequent re-enumeration then uses the "new scheme" and
> issues a 64-byte GET_DESCRIPTOR (get_bMaxPacketSize0 with size=64),
> xhci_check_maxpacket() sees hw==sw==8 and does not issue an Evaluate
> Context command.  The xHC queues a Data TRB of length 64 but applies
> ep0 max_packet=8 for short-packet detection.

That's exactly what we want it to do.

>  If the device's first
> data packet is exactly 8 bytes and it sends no ZLP, the xHC does not
> recognise a short packet, keeps issuing IN tokens for the remaining
> 56 bytes, and the control transfer hangs in the Data stage until URB
> timeout.

That is the correct behavior.  Indeed, the same issue applies to _any_ 
64-byte transfer (not just control and not just Get-Descriptor) when the 
maxpacket value is 8.  If the device sends an 8-byte reply with no ZLP 
following, the transfer will hang in the data stage.  That's _supposed_ 
to happen.

>  (A standard 18-byte descriptor returned as 8+8+2 is not
> affected because the final 2-byte packet is a short packet.)

Quite right.  Why wouldn't the device reply with a standard 18-byte 
descriptor in this situation?

Have you observed this problem in actual testing or is it purely 
theoretical?

> Fix this by removing the "if (initial)" guard so that the ep0
> maxpacket size is re-guessed from udev->speed on every reset.  For
> full-speed devices this re-establishes the 64-byte guess, which makes
> xhci_check_maxpacket() issue an Evaluate Context command that brings
> the xHC ep0 context back to max_packet=64 before the GET_DESCRIPTOR
> data stage; the data stage then terminates correctly via short-packet
> detection, and the ep0 maxpacket is subsequently corrected to the
> real value as usual.
> 
> For high-speed, low-speed, and SuperSpeed-or-faster devices the
> re-guess is a no-op (guessed value equals the fixed real value).
> The descriptor-immutability checks (!initial && maxp0 !=
> udev->descriptor.bMaxPacketSize0) remain unchanged.

As far as I can see, there is no need to do this.

Alan Stern
