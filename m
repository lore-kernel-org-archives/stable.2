Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794925402;
	b=GaDaFV7M1gX32iso83bbMHcTBgSVZwGxaMTV39M7RKzAEHskDOzwyjc0oj4w4mBnsQ11
	 uix1y+cdU15+04nxB3ESfCZPdX0sqQnrRKKWuZHpMQWPugdXixomEyq3uhggKZmC3Nvhs
	 yR0Mo3gNszUiYiCMLkO6P/57Ngt77RWmxMAeBMX2TMEv8fZkrUX7HwEvlD6V/oWr3oj9r
	 RnnYdXDUDV/XNXdHNFXRHqp7cyhAbFY0aMR+m9AL4TuvQtlCIZ+cv5YlZy/RRSGifd1Vr
	 +4rFmCurXkXibrkE8BwAk2go92f//NbZoCggoHnj745Dj1D7FptMXbRh2up/7NIcHFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794925402;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=LmdnAdyFc/KExKjlXTQQG9vPex2c1X+M3F6FG9ILMsw=;
	b=xDwSXXhLCxhAuqYJG6elwimAL6/n4FyvM96HrLqjCd7CCRsSlrBslK5Ml2KyAtt4iZRa
	 LeAchA7HEO1Hmy46mYqVffJcid/bvJbkISdzVp0xhu5KRFW+ZXhXP0fYgy3HAkjxcd0JP
	 /v20bH+eOYB9hnVoLtKtJD+oxceDuWjSNK6C8NBoqiesQSM5LmVWlbobnuNNPkHifBErx
	 9lhN08ZJeGhXNmq2X3xM1/LvPscLT8IHdrFYKEGlJrSrEYPPGkpK0dpcoqG+9Y99AKXP/
	 KUo4upxXNlGvTWmd+wUo73Fc11EOEqsJBM5SyXLEHF4kN3eg385CtFOw99PvZzmqORA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=J7U40aS7;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837F3606A335;
	Tue, 17 Nov 2026 14:23:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 837F3606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=J7U40aS7
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E1C861A1691;
	Tue, 17 Nov 2026 14:23:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B745E5FD6A;
	Tue, 17 Nov 2026 14:23:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F2B7E11BC0039;
	Tue, 17 Nov 2026 15:23:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794925398; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=LmdnAdyFc/KExKjlXTQQG9vPex2c1X+M3F6FG9ILMsw=;
	b=J7U40aS7WBu6kKVkRezLn47fJrpUXyPOBQu4dgs67vHMxgOWv2kMJQsSg+jyzCbDYCIF7G
	vSr0R7ZvDK3Xs7tChTwjYj9wcRCe06qR2GNDb9pOQCafzX5NWZaQjFlYKYyxaNFvcejqkP
	GjYjm7sR2sYhwHCnGH1kCUvyNfNzVENHYVB1qlucYC+IkOjmal+TP8UI/jCK+adO0wCEc5
	seOiDX0jrFv5H6kBd0fw6VXx8FEl8RxqDIwFuELjywmMcKAC+VxcnsEC6MDT5cVFp7QIWF
	6tYMD+CaLBBlJelZfI8Hi29pDa5dx2cI9EiJqPyVRcu7pMlvIVqx2PaHp5nJSw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261103100602.1310416-1-vulab@iscas.ac.cn>
References: <20261103100602.1310416-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] mtd: rawnand: atmel: Release the HSMC clock on legacy
 init failure
Message-Id: <179492539687.2259780.15450665265756565603.b4-ty@bootlin.com>
Date: Tue, 17 Nov 2026 15:23:16 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

On Tue, 03 Nov 2026 10:06:02 +0000, Wentao Liang wrote:
> When atmel_hsmc_nand_controller_legacy_init() fails after acquiring the
> NFC clock with of_clk_get(), the error paths return without dropping the
> clock reference.  For failures after clk_prepare_enable(), the clock is
> also left enabled.  The caller returns the error without running the
> controller removal path, so the reference and the enable count are both
> leaked.
> 
> [...]

Applied to nand/next, thanks!

[1/1] mtd: rawnand: atmel: Release the HSMC clock on legacy init failure
      commit: 85dc1b1e3bf5d299fc3531dfa9ee8473bcfc075e

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl

