Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795186971;
	b=s6F5fckQlRFK8jqdyDJGEwt4rhGBBVTJxoQuNemDxtdT+b+fLhaWs/Gle8lIeJk2K7mm
	 jvRElTiuKhbiV5GUem5qTsXX/H5e10EaPTT8x8PDTVOcyTahtDgjWjg48EPYAIcY44TUR
	 //cGWn0L8V+ZMYxXHuFjT8S+fk75H3XaZB4rhQ1URZuEfcMfPtcak9GrGb7ZzjgePLF8r
	 ISQj8aV6GaWi21xcTklQs9E+unx/xYP67iBYxGvJQ7kkhZnohaam3VNOee6+wXpOUdu59
	 mBLCZfX+QquFsc6vAAYj4fdgN+f8oLcucYhT98PbZRc8nMfZeOJZzbJiRNj72CEPCsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795186971;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=RjjrO4x33/X7qoxGWKBXsMF2h2L17f9YWm2FAzoV/0w=;
	b=g9MjYQDCrcEMBOobj6zWzlovNbH+NDpDJFLTBKUp9spjLdeUd8W0TyE3pQLXKVbijl0Z
	 FE7UZSIA/uIMhc+1/rzFgUJRWn8A1AGnNKgZujXSqPDW8L8eQJ76UcJWACTqxYww/KLUs
	 yLYPfw2KMEWp/7BmB0sDO12tQ7uN0P28D3oxbk+Hv1mrmPZI/3P5qqScmMM/Boo+gQKAs
	 phbovNgBxZaHFP488Oozj7Z3pTiLpqppwfDWZFywtYIcm6JeatuhzVTeOB2b2o+W+WLcM
	 rZK08zugjvHbWKnD3N6ic1FotoCoRe4pdMQqflTXPw/opAw0QQnGE6VXn3bDuXQYyBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ssBNuUQb;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E68606BC88
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 15:02:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27E68606BC88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ssBNuUQb
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E07F11A174F;
	Fri, 20 Nov 2026 15:02:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B6057601B9;
	Fri, 20 Nov 2026 15:02:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2D5F711BC0284;
	Fri, 20 Nov 2026 16:02:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795186969; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=RjjrO4x33/X7qoxGWKBXsMF2h2L17f9YWm2FAzoV/0w=;
	b=ssBNuUQbwq+8FpwxhUsUTHSrrYka73VXPRpTygtfqS1ZSQzQtsQt62hmFZUL14zgBsO283
	lr5lgLztnkraf7fTmuJ3p/N6c6YYEsBvn2TGoH/imr2/EgqJnrmq2YGSvMpO9nVfCkCcIl
	IoeFMPcpKiC2mI1vy5nSW7jLE77LbyFSzxBbROEXbwbT+q3kLOg03K8JDkIyfIBPK90wnG
	v215Yx3iDwOlbc+7Be755B0ihfm675EuWfdEiS3udLQAPKH2qzSlpsjbETduT69oCjQ52E
	vkyCuSKcQwydIwfbZhgkg67OQ2NjOkqqQARbnnlUpQhuCXu/dk48+sgTxZ//TQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Boris Brezillon <bbrezillon@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261118-submit-mtd-empty-io-v1-v2-1-b980927931ef@gmail.com>
References: <20261118-submit-mtd-empty-io-v1-v2-1-b980927931ef@gmail.com>
Subject: Re: [PATCH v2] mtd: core: skip empty read and write requests
Message-Id: <179518696810.3401781.11014509839002382803.b4-ty@bootlin.com>
Date: Fri, 20 Nov 2026 16:02:48 +0100
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

On Wed, 18 Nov 2026 10:18:36 -0700, James Hilliard wrote:
> When mtd_read() and mtd_write() became wrappers around the OOB helpers,
> they lost their zero-length checks. An empty read at the end of a raw
> NAND device can then compute a die index one past the last die and hit
> the WARN_ON() in nand_select_target().
> 
> Return success from the common helpers without calling the driver when
> the request is valid but has neither data nor OOB bytes to transfer.
> 
> [...]

Applied to mtd/next, thanks!

[1/1] mtd: core: skip empty read and write requests
      commit: 3db54924e7fa664dd6303f3bd0cb1eeceb1f513e

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl

