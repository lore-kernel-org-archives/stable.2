Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168C5423E9E
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 13:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790343194; cv=none; b=BLdWIL36oCA0/50SJISjZaL7hXb83EMhqYGsi6ds8yTBaGZLaaojaEDMoFzE0ZL1zXm8KMDoVRtxUXAQ5Y4J72d26Psrq8xXbmKKm1y3aWbkVB+UsELZy0VajYIqXJDnaMds3djAsndQ60H06FBsmGJlF0zj5l73Ar9gqZANxdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790343194; c=relaxed/simple;
	bh=PjaiRlRH2Y8JceVC6/lC0OMOb3aYV85nZn1Sazlgkr4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sXB9iC8kvHSlGMrPfJC5do3NZfwiNa5uuzBwP1NCRku0xuj5x+umptWdxDkWIL1rewhWvHtz0ElIL0AhA2wqZWVA0CPvwXbpLFrbmuJ0RSLmyj1cJvelGckkpmJK/8tud5kp8j4LdYaUh1zQoVV4e/rDRv6Zmr2tvoN6qzVfH6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=k7XLJijc; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="k7XLJijc"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 82C974E4106C;
	Fri, 25 Sep 2026 13:33:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4DE676073B;
	Fri, 25 Sep 2026 13:33:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F2B4710328CD2;
	Fri, 25 Sep 2026 15:33:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790343186; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=PjaiRlRH2Y8JceVC6/lC0OMOb3aYV85nZn1Sazlgkr4=;
	b=k7XLJijcDLcyf8iPSjDSE9Nl+hRkjAjW2cYnzlOLOe3dt3jd6pWxPhUBVjdBxX88tG88hB
	LFWHTah3TtleKhGCnr8fTAhuxhEcdH2As+QmVNZ6mW8FFIQsPDHqGqtwQnNv3PDmcJGRI6
	7ZsI9qpukupNrIMCasNUsyJLm8P/8kMvr0kUUaxyTstzH6RASMIA5bNO10EPg2rM5WlP3Q
	Q1F7WxqRx4MNWN+4MHfjSbPSWrED6qkvRH1f6kmSIH/Im3/ax5kx/viCh6U75FwfLP3GxE
	WLq+Rq0lNN/xAT3tAySBTqxtP1vhx7voFW4s8S6wgTo8T9l1E+Vg4bHP6V7o9A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Rosen Penev <rosenp@gmail.com>,  Thomas Gleixner
 <tglx@kernel.org>,  Sean MacLennan <smaclennan@pikatech.com>,  David
 Woodhouse <David.Woodhouse@intel.com>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: ndfc: fix I/O mapping leak on remove
In-Reply-To: <20260915164204.2492099-1-lgs201920130244@gmail.com> (Guangshuo
	Li's message of "Wed, 16 Sep 2026 00:42:04 +0800")
References: <20260915164204.2492099-1-lgs201920130244@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 25 Sep 2026 15:33:02 +0200
Message-ID: <87qzih4fsh.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 16/09/2026 at 00:42:04 +08, Guangshuo Li <lgs201920130244@gmail.com> wro=
te:

> ndfc_probe() maps the controller registers with of_iomap(), but the
> remove path does not call the matching iounmap() before the driver is
> removed.
>
> If ndfc_chip_init() fails, the probe error path correctly unmaps
> ndfc->ndfcbase. However, after a successful probe, the mapping remains
> active for the lifetime of the device and ndfc_remove() never releases
> it, leaking the I/O mapping on driver unbind.
>
> Call iounmap() in ndfc_remove() after the NAND device cleanup to release
> the controller register mapping.
>
> This issue was found by manual code inspection.
>
> Fixes: a808ad3b0d28 ("[MTD] [NAND] ndfc driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

No longer applies after Rosen Penev's patch, can you please rebase on top?

Thanks,
Miqu=C3=A8l
