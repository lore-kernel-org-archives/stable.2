Received: from 0001.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F8640F8E3;
	Wed, 12 Aug 2026 10:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786530823; cv=none; b=lq0JsV08UsAmbS/aS/IpSd0ItMh5ngIJEhHqezfpiUAM6RrX3noHKW4iLL5CdgbrJT0dRUF36NWx7ZqyYB7i9SrRiuFLlLwKarbMzJjRS3Hekw7IXqRv+BBM5VUXs5doqAUsasngMJdf5eaWq98pl3w5gvRQn1D2nl+htBXSzqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786530823; c=relaxed/simple;
	bh=LRljl16grhtf0djGBTDLkC1Gq9fhyrTmbQwMN2Auh2A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=iZry5eYXtbnN4CDWcxx1dYAgQWIvp1VvIG50uKleU8Il4kzNk5sXgAUeg5w+nWweVN4RuvolEnSuxDj/Pti7zhe3ZJCZPatBV7JSdwfsTndIW1PrMadkG1j7xi7BFDueY2kkMHe5MCrQESC7Gda5kGAZHh9pRvONObo2jvLsYHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4320:1000:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 626A9141;
	Wed, 12 Aug 2026 12:33:39 +0200 (CEST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Aug 2026 12:33:39 +0200
Message-Id: <DKMWBK3M5W6V.1V1JTUV6Q8IDT@kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: Unprepare legacy controllers upon RWW
 wait interruption
Cc: "Pratyush Yadav" <pratyush@kernel.org>, "Takahiro Kuwano"
 <takahiro.kuwano@infineon.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>, "Tudor Ambarus"
 <tudor.ambarus@linaro.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <linux-mtd@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Miquel Raynal" <miquel.raynal@bootlin.com>
X-Mailer: aerc 0.20.0
References: <20260811-perso-rww-fixes-v1-1-5866a70e5d1c@bootlin.com>
 <DKMVA2HIPB2Z.J0W6OM4H3ARL@kernel.org> <87ik5fmz64.fsf@bootlin.com>
In-Reply-To: <87ik5fmz64.fsf@bootlin.com>

On Wed Aug 12, 2026 at 12:05 PM CEST, Miquel Raynal wrote:
> Hello,
>
>> On Tue Aug 11, 2026 at 5:56 PM CEST, Miquel Raynal wrote:
>>> All the parallel locking helpers (spi_nor_prep_and_lock(),
>>> spi_nor_prep_and_lock_pe() and spi_nor_prep_and_lock_rd()) call
>>> spi_nor_prep() then wait with a killable sleep. If the sleep gets
>>> killed, we leave the controller in its prepared state.
>>>
>>
>> Why does this only affect legacy controllers?
>
> Aren't ->prepare()/->unprepare() callbacks only implemented by legacy
> spi-nor controllers?

ah ok :)

-michael
