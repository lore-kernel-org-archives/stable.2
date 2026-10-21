Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792568768;
	b=iCvWEHiR3gSSQ29OShMHLAgyx36/gk1nD+aG5i7dz0NCwZP0WPHAe/4si5z3mc+kzA7w
	 wYn+N7rEXvO9q2DAdH5Q7YcyFbHhc0QtG/d+LYWh/kr5UkGxklJKbFfoXxj0wAwbZIh54
	 mVhYDcrAF9oiPkCeNrAn783sYOc4ip83GMvSjFeRHecj5UcYHFpwJfRUWrCRxi51L+vZj
	 3TuMBbzxKIDOYE9VlhYNhh44ZmaMsLBTzdxB8Hx7rarlZv1DbZAXiUEkrUIjuQHDX+I++
	 Tmlejr0QVuq6QRhS1cdvdkn35hfk99hvjTtxwGscSM4MuUtSXKJD7cNVjN44Zc36YJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792568768;
	h=DMARC-Filter:Received:DKIM-Signature:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=ET5rhTxwtX7fX9v6ABZB7zLXXFj1JkJDQQtcNe2GYf8=;
	b=NrjPdlVrP3ZzmR2WNpxqmnpZL/iedvNEY0D0dtdavqhstlDiiHgXJEDantja4qNKZ5K3
	 BByLuTB7AF5sAUNwtbqoVMfmwvm5umbtYeoTyEcMUfk5UQZUuDDX3jhvPNGrsuWPVwfCO
	 Td5yT6Nsp2xHtTm1hF4wboQ5w9DaN3uDNgvQ8QSxBDKx38r8PRRMcqQVlmGoxo/lWfWVh
	 8OMhSlXJ0uM4SWoycodlOpYr2U+H+XGkk9sHTYQZkILqmSk8J/FVffS0naJibziVnKiEU
	 SqmDvVplY1JTGZ0bHDRdZ1dDVZjpFLqt+LMEID3TTcB4ULDS8UM7euMlMrddM2RSIQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b="Ha9qLd/U";
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98BB606A322;
	Wed, 21 Oct 2026 07:46:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C98BB606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=Ha9qLd/U
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DD6D3A012B;
	Wed, 21 Oct 2026 09:46:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792568764; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ET5rhTxwtX7fX9v6ABZB7zLXXFj1JkJDQQtcNe2GYf8=;
	b=Ha9qLd/UsUBPMr6m+DXtbe7FdLef7AaGcFSe33AscKw98A4YdoRMRgGtDFxUDLZV2dPNeO
	VxGLUktjHmlt4sp2xN/2vsTPBuNX8AZTiUCKtcmgffy5DDS60cvYqa+oheM0U5lVcRfa4v
	K1sdhC8rZWvGY0Da77VYiFCtmMKSYQ69vDIR7LG6bc1l6oI7Rbz4haFraNqafzF9CBaYOQ
	K1TVBp7UyNwhvE4tpvzrk18QH8EarudJYjExYqz6Af1MsIG4YwDeY3UDFOumJVPdFzcpSw
	2VhlS6NGheoUy6/dBUOgV3dmn1ZuPRy5J7rGpXzLBvwF/LG85ybu0FmlPSsPPQ==
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 21 Oct 2026 09:46:03 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: guido@kiener-muenchen.de
Cc: Michal Pecio <michal.pecio@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Steve Bayless <steve_bayless@keysight.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 0/4] usb: usbtmc: fix undersized high-speed bulk packets
 on xHCI
In-Reply-To: <d702d2b3b66d6229855515c2eed09636@kiener-muenchen.de>
References: <20261020-fix-usbtmc-short-packets-v1-0-903f4d029193@tipi-net.de>
 <20261020184244.69b78d5e.michal.pecio@gmail.com>
 <a642dbc2e4ba0efc381c69e26821762a@tipi-net.de>
 <d702d2b3b66d6229855515c2eed09636@kiener-muenchen.de>
Message-ID: <bcb7b29468175cd13f08bdd363b8c733@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Guido,

On 20.10.2026 23:12, guido@kiener-muenchen.de wrote:
> [...] Therefore every manufacturer of USBTMC devices should
> comply with the specification and cannot expect bugs in device firmware
> to be fixed by patches to the USBTMC driver on Windows, Linux, or 
> macOS.
> [...] Otherwise I cannot support adding device‑specific patches to a
> class driver.

I agree, it would be a better world if every vendor stuck to the specs.
Unfortunately reality is often different, and we are the ones stuck
with the devices on the production line.

Anyway, I get your point about keeping quirks out of the driver. It
looks like the maxpacket part can be fixed in xHCI instead, since ehci
and dwc2 already accept HS bulk endpoints below 512 bytes (see the
discussion with Michal). The ZLP issue of the Rigols can be worked
around in the application. So I'll drop this series.

Thanks,
Nicolai
