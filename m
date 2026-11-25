Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795600138;
	b=0Vr8DRHKel2qWTBVo/9yDFWU6qTh3xYC9PGSi1Cudu8CW2Sf4gVaSUjaXslQTmGXtWB2
	 VYqH3razgBq6/qqMPDGMUjOB6Tzy5r1SAmSixwfgdp1/iXWvYYNaZOK3QameLN/wSpvBy
	 SxjSkzAMHFppeo5LGIe/UYAqGOj/DaJVLuVPLcQtEHE3ory9ku3O17iYoDRkju//OL6pk
	 /tMVfb+eNsztjsVOMXy35dATBXB9FY4r6RvRzR2fPlqhg39PqdeyBk7WI++UaR5nF4YGy
	 lRphTW8XQlQKOZXbi6x8cUjS8HKibx+lRQCuVyTYrpHFbPIJ7GpJXl/iva0/RD+jJbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795600138;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:X-Last-TLS-Session-Version;
	bh=hSrZ7TU1SA/f7pgNCA+lRSXARyll9PDrfkSwUDqb5bQ=;
	b=ZSCX83zXnjytR2OueVwWrqse/b3HRiir+FXK2prea9l04SYjRuwNMFv/1/z0noEHSKOO
	 6mnVXk8aJGZh13GboidxR1b9asDXjgABizCeoO2bSEBBuBYwHL9ZPSpUTdnby9oIXRw/9
	 6j2fcfZyoEwEWIiHrlXrcx/F9GG903nyaEHwmAkJBAX89Ctv9LGatX3Tdz0s3SEohh0rJ
	 I4kDP1O2KKmsRf3iIDwbed+Rpbn66p6jFAAXbgPAx7HurcV/ausvBjrkxfvUXeCkpIbQP
	 L3dNQ32RvuUurq8w4Ao66OT4e75R7otMciwHYtRhIASUg+6Yzpz6HLFlSSTxZ2C+3yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=TOy6dma9;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A4D606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:48:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59A4D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=TOy6dma9
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0477F4E41778;
	Wed, 25 Nov 2026 09:48:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CDBA860480;
	Wed, 25 Nov 2026 09:48:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0511711E68BFA;
	Wed, 25 Nov 2026 10:48:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795600128; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=hSrZ7TU1SA/f7pgNCA+lRSXARyll9PDrfkSwUDqb5bQ=;
	b=TOy6dma9VN72lEIA2mOsMYgGMAErfdIoRSZWSmuR3sNQ/r++AKHH05xX7wZHyXoTzYrP0d
	MJgyYXafYAVyeXfaszWG3DVaRCGADyJJ+4TLGN6ruQ85uytHsqBsKcwLYeTxGBG3VAOsZL
	LS6Xi9SMbtpuqisidOW7XHsETfWUbdIhgHf4bS9/y5e1+DgUY9TYE5o21jFdhrSfDT7M13
	Wvbupi7nG4/gHDEBgd8w1CIMPdIi/DNe1K8Wl6JVfEDweAcvti+VkCjnPPcOZm0b86y8WY
	mELRLcph9h+AgI5+T0RBPy5C2rL4s4x0GkJaRRRzNsMzevrdT+evzz8ty6xB3w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Ping Li <leeonion.muyu@gmail.com>
Cc: richard@nod.at,  vigneshr@ti.com,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH v3 3/3] mtd: rawnand: r852: declare NAND_USES_DMA
In-Reply-To: <20261125092538.1938516-4-leeonion.muyu@gmail.com> (Ping Li's
	message of "Wed, 25 Nov 2026 17:25:38 +0800")
References: <20261123070440.3060882-1-leeonion.muyu@gmail.com>
	<20261125092538.1938516-1-leeonion.muyu@gmail.com>
	<20261125092538.1938516-4-leeonion.muyu@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 25 Nov 2026 10:48:45 +0100
Message-ID: <87o6bdz1fm.fsf@bootlin.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3


> +	/*
> +	 * r852_do_dma() feeds the buffers provided by the NAND core
> +	 * straight to dma_map_single(), so ask nand_base to bounce
> +	 * non-linear-map buffers.  The local bounce in r852_do_dma()
> +	 * is still needed for the hardware's 512-byte alignment
> +	 * requirement, which the core condition (chip->buf_align,
> +	 * default 1) does not cover.

Can't we change the default for this chip then?

Please drop this comment after fixing that, it is not useful, this is
information that should belong in the commit log.

> +	 */
> +	dev->chip->options |= NAND_USES_DMA;
> +
>  	r852_engine_enable(dev);
>  
>  	if (sm_register_device(mtd, dev->sm))
