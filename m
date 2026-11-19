Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795091844;
	b=UThbhd8mLHnYWx/1/09wGc5gnezNEa5q2Pwf17UwqryDBb9F7hrd7KcYpMMg6Aw65zXx
	 ShNrLZ6ko3pGwRwhmszUsytCkfvoN7E7pkV6WyAmFYNeA2N/IY9fBPofEIYCFp6eR4qeY
	 6lrwAj2CKuHiLWOqiHb//jr6eg8V5jr/Mim77ISt60DhBEFjKr8OMs1KsiejOGguOIolq
	 gNzvy3rC8Vy2MWo17N/6CLrg+80MQCiCSV5Mde7TD616hm+A5eQyBMCoMmjzbPIdBiwr6
	 O8MOphzBPARn+jAJqJdmUC9vQ/Kakaygrg3PnOZqn0iEUPoO7drV3VVXXm2OBZmnYIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795091844;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=dEW7y7XAqeBD7xaDjDBvP0fFGQoFweZsJxNTbP4g5PA=;
	b=QB4vDC86DuU8ODci2d1aSribBbIVaRjmi3TFJIoch6brOVr/YwKYx3Ql3wC/CTpNVZWe
	 PDCR9LGSaIrbIcqLp9S6ddkZaStIUOp3dYNN1JuJyUaUTjfrQNO/VXJkTW2Rb4JtAgZ5n
	 4qf+64AZXUgTPAQIBwvKWg4MnJF9LSPYK9YX7tmcaC7WgCRH+/Wyzsmt//DjBRegn1YjK
	 gWWrD/2DRPVXzEtsGBt0vEftAcFdhjAdOL/t90BxjZeQ0PqSX7hdUcNgY9muDqmW2Z7Is
	 FQQ3uxnwSwSKQUIWsh08HXe5pYCHGQqwMo3bTKjwz69427N+URrgDEpbdtaVzMkbEzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=DzS57S0w;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99067606A330;
	Thu, 19 Nov 2026 12:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99067606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=DzS57S0w
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3B35E1A1710;
	Thu, 19 Nov 2026 12:37:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0F18960237;
	Thu, 19 Nov 2026 12:37:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9686B11BC0662;
	Thu, 19 Nov 2026 13:37:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795091841; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=dEW7y7XAqeBD7xaDjDBvP0fFGQoFweZsJxNTbP4g5PA=;
	b=DzS57S0w4Q/Wfag9dbeGY7Y5VyDZmMUYpkFzrU0CsSrhkx7hz+bnMFqLzPgiweIGoOrB4t
	C/WxQ3kGbJkV00+wLUs3cuX1YBrMP6+dx86wCOM5+OSgsidlvaTqi44vGTA8wdspAzRVAd
	l/lSw5Cm/QG7KQ6bhJW19zAbRvUiw2m+gtNmmwhEVJSOt44nKdP9qToYZDpOSXWNKQ5fOT
	MWKYAZbS8bgM1AI4f3H9w92KwD5zOuY3nOJrRSUhrAoze1VUrRU15v0VEOPwq/qeI9N9ki
	qp87fFyejJn09aCxciRELib+cB7TB7krFWLdx3xrQMIfpZ98Nj2zcaUQQLNtJA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: paul@crapouillou.net, harveyhuntnexus@gmail.com, 
 Guanglei Zhu <zhugl3@xiaopeng.com>
Cc: richard@nod.at, vigneshr@ti.com, linux-mips@vger.kernel.org, 
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 liuwb@xiaopeng.com, stable@vger.kernel.org
In-Reply-To: <20261118020751.1833498-1-zhugl3@xiaopeng.com>
References: <80f1ef9dd605d16df2add0a9dbdcdd5f9f508174.camel@crapouillou.net>
 <20261118020751.1833498-1-zhugl3@xiaopeng.com>
Subject: Re: [PATCH v3 1/2] mtd: rawnand: ingenic: validate BCH error index
 in jz4725b_correct()
Message-Id: <179509183841.2889394.14531200887089182050.b4-ty@bootlin.com>
Date: Thu, 19 Nov 2026 13:37:18 +0100
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

On Wed, 18 Nov 2026 10:07:50 +0800, Guanglei Zhu wrote:
> The JZ4725B BCH controller reports each corrected bit error as an
> index into the codeword it was asked to decode, in the INDEX0/INDEX1
> fields of the BCH_BHERR registers. These fields are 13 bits wide, but
> nothing in jz4725b_correct() checks the reported index against the
> size of the data buffer being corrected:
> 
>     buf[(bit >> 3)] ^= BIT(bit & 0x7);
> 
> [...]

Applied to nand/next, thanks!

[1/2] mtd: rawnand: ingenic: validate BCH error index in jz4725b_correct()
      commit: 5c621482debe642623ff974dc6beff7015371fc7
[2/2] mtd: rawnand: ingenic: validate BCH error index in jz4780_correct()
      commit: 21cb873a01c5706b443b6d8328c57de8ce07cffc

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl

