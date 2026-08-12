Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD623264E7
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 10:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786529146; cv=none; b=IoZHPHWuOvByPUKlzJw3N76oO0eO3pc6imMsBNQ+efcZEBRrdqpuU2ffbPHUTyLzXL9ReFswXXe4hVZGG8j6cBVVvwMBNy3OdbwX7iSG8drgd0y/VglZx6jwFeKgeyV83yvEBdyV7jZM+4+puG4kNXyZKyWL5+4JAjcjVEB0V4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786529146; c=relaxed/simple;
	bh=dRZPxqI25TZjHZ/6T+U90CPEsTAToTykZqHxtC4cUEA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kmhshzFr4ypUDd2bil1MSVRmGcZOYCHXX3ODFBfCnkp6IX1GjfI2CrOVExE0kiZ5R76R+RRPB/VG55bP0AGHrBvHB4FErjqlnmM+zt896lMHuKisg9nSx680cYyhfs0ZuTNtu7k8oN+Xj+UhWAWIxCyQA6gs3bqSW8QfeRjFjXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=c6peWfQL; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="c6peWfQL"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 2AAF81A15B7;
	Wed, 12 Aug 2026 10:05:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EB0376045E;
	Wed, 12 Aug 2026 10:05:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E0CA011C4CBCC;
	Wed, 12 Aug 2026 12:05:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786529142; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=dRZPxqI25TZjHZ/6T+U90CPEsTAToTykZqHxtC4cUEA=;
	b=c6peWfQLhcuGX9MbHL2ryhnJ03qbt8r7VtdTC7lv2jGxyp4/4FjitIiByE+9rrb8x61fKN
	k52O0qL9EGWvzOPTembinRYork0DXKOLsuIa9j8CC5cSEy2OxjxWfLARKb+KbK503jqYEz
	21/+FNgp29N6wf8yy7/2KA8MyyOPXGV0y9Rb7etcTtJr9lLreIdAuNdp5nLz6GLXnE2C8n
	DY8eZQSsuHWHidcymAC/fkb8xGsTA+hQckAOQTpSkn/qv2J3u+XDG+y68VkZrHtZ37thIa
	xFJMp41436aNf0QCjFeaLMOcxiAMlVJYXTjsN8/o+e7uCWA21nn20vlDgFDonQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Michael Walle" <mwalle@kernel.org>
Cc: "Pratyush Yadav" <pratyush@kernel.org>,  "Takahiro Kuwano"
 <takahiro.kuwano@infineon.com>,  "Richard Weinberger" <richard@nod.at>,
  "Vignesh Raghavendra" <vigneshr@ti.com>,  "Tudor Ambarus"
 <tudor.ambarus@linaro.org>,  "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>,  <linux-mtd@lists.infradead.org>,
  <linux-kernel@vger.kernel.org>,  <stable@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: Unprepare legacy controllers upon RWW
 wait interruption
In-Reply-To: <DKMVA2HIPB2Z.J0W6OM4H3ARL@kernel.org> (Michael Walle's message
	of "Wed, 12 Aug 2026 11:44:41 +0200")
References: <20260811-perso-rww-fixes-v1-1-5866a70e5d1c@bootlin.com>
	<DKMVA2HIPB2Z.J0W6OM4H3ARL@kernel.org>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 12 Aug 2026 12:05:39 +0200
Message-ID: <87ik5fmz64.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello,

> On Tue Aug 11, 2026 at 5:56 PM CEST, Miquel Raynal wrote:
>> All the parallel locking helpers (spi_nor_prep_and_lock(),
>> spi_nor_prep_and_lock_pe() and spi_nor_prep_and_lock_rd()) call
>> spi_nor_prep() then wait with a killable sleep. If the sleep gets
>> killed, we leave the controller in its prepared state.
>>
>
> Why does this only affect legacy controllers?

Aren't ->prepare()/->unprepare() callbacks only implemented by legacy
spi-nor controllers?

Thanks,
Miqu=C3=A8l
