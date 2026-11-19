Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795100116;
	b=cnThNKJk6P0us3VWSJJT/dwzFe4jUEMqDMBVyk458wr8QyC4TSPLhb7znsG5sGGV9J6E
	 /tUqu7pN1MGjkGmOYk2dFlL4lLaNnq2zDKo9dpe2guh85baTwZmOU2CzZyjY2B3vKIOTS
	 B6gVPDepj1YAeqG8+YwIfiZw9xAU6z9cc5nBEolE9mUEtYbM162ECVpMYvq36znWW1apV
	 rO0TjSbMyVafFyzwsXXrgScvAgV0zY4+bKpUxP9sdaqbTsABfMZLc358Z1PDHt8t/qKMt
	 EX6A/BoXxTyL/zFoCpMjWatxyRCdtaRELUEd0d/OLb7PXXkoS9Npsxc2z3iKIJha5UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795100116;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Subject:Cc:To:
	 From:X-Mailer:References:In-Reply-To:X-Last-TLS-Session-Version;
	bh=aKrzxSz3hLhQkNDEUiWgUXoAj4YRodSBySP8V/h8luw=;
	b=Mas8eMg7pkJ/d5T2Ek9z9N1W9Eao33lTAA8ClIEenPU7i5cGcBoUbuEzeVz3i4q5JzDq
	 SbkL8LzO+0pTQILmVmN074vCQ/DoG/PGcnkIFY3XtbMrmTs7omAccDJr+smDSSZ6L1y4K
	 yuSH+vqBjh5496u6eXlnP+xKd29v+apZctuuyq7vAIN1Gcs3W2tb+mONXdAr+NeYGtzun
	 jJYz1SdhKH91D5BOpboU3nsWQnT+obSvk/0b+GJPnlJTyTKfJuh6lzDfsis1QQBJWAikS
	 74MSSROVsxClov1/h4NPzi3/anMsye3aGFce0zKXWbuFuY3888SBAr+m8RGXHT/pplg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=HTrfOzxM;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC61606A320
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 14:55:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BC61606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=HTrfOzxM
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A5DD31A171B;
	Thu, 19 Nov 2026 14:55:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6FF2D60237;
	Thu, 19 Nov 2026 14:55:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6E98211BC0B70;
	Thu, 19 Nov 2026 15:55:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795100109; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=aKrzxSz3hLhQkNDEUiWgUXoAj4YRodSBySP8V/h8luw=;
	b=HTrfOzxM13WZ7n9aAmFcRFr5pAcxHA3ZqJL0kywhahRXAf//gq+yRoV22ahT0GZ4QXv3xj
	BLpPtTSNqmnKjV5bmUeNef4QhBKJigTonGXBxBIcK1WgU0enyEOnE6EnelZ1Fmm5IWwK/1
	SpfKUcqu7WpwkVJk/1T1UYw5FLOhcDLEc+3bS6Owx3vIcae0dPgxFt5z9Vi+kLiXvGbjUw
	7rD0CUDgx0PmaaQZpLPfXBXBv3K5yVeS20MNsRC5kNbvbcKqRkhSrCTrTMHTFtv6oyRun6
	YTvMF40qjQVWsvoIQUtXICu8ojYSQnzBNoDrXj197T8GqbUf16nvR4tScqBWSw==
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2026 15:55:04 +0100
Message-Id: <DMZ9VNGP6GSZ.15VHI64APKAQR@bootlin.com>
Subject: Re: [PATCH 06/10] spi: cadence-quadspi: Bound chip select against
 f_pdata array size
Cc: "Mark Brown" <broonie@kernel.org>, "Foon Tan" <lftan@altera.com>,
 "Graham Moore" <grmoore@opensource.altera.com>, "Murugan R"
 <vadivel.muruganx.ramuthevar@intel.com>, "Vignesh Raghavendra"
 <vigneshr@ti.com>, "Pratyush Yadav" <p.yadav@ti.com>, "Dhruva Gole"
 <d-gole@ti.com>, <linux-spi@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, =?utf-8?q?Miqu=C3=A8l_Raynal?=
 <miquel.raynal@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <stable@vger.kernel.org>
To: "Lee Jones" <lee@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261119091810.3440619-1-lee@kernel.org>
 <20261119091810.3440619-7-lee@kernel.org>
 <DMZ3XW6ZEFDF.2WJ1XU4UKTRAH@bootlin.com>
 <20261119143347.GS98456@joneslee-macbookpro.roam.internal>
In-Reply-To: <20261119143347.GS98456@joneslee-macbookpro.roam.internal>
X-Last-TLS-Session-Version: TLSv1.3

On Thu Nov 19, 2026 at 3:33 PM CET, Lee Jones wrote:
> On Thu, 19 Nov 2026, Th=C3=A9o Lebrun wrote:
>> On Thu Nov 19, 2026 at 10:17 AM CET, Lee Jones wrote:
>> > @@ -1761,8 +1762,9 @@ static int cqspi_setup_flash(struct cqspi_st *cq=
spi)
>> > -		if (cs >=3D cqspi->num_chipselect) {
>> > -			dev_err(dev, "Chip select %d out of range.\n", cs);
>> > +		if (cs >=3D cqspi->num_chipselect ||
>> > +		    cs >=3D CQSPI_MAX_CHIPSELECT) {
>> > +			dev_err(dev, "Chip select %u out of range.\n", cs);
>> >  			return -EINVAL;
>> >  		}
>>=20
>> OK this does fix the bug. Here is another proposal though:
>> ensure at probe that cqspi->num_chipselect <=3D CQSPI_MAX_CHIPSELECT.
>
> One slight hesitation with this.
>
> In cqspi_of_get_pdata(), CQSPI_MAX_CHIPSELECT used to be 16 prior to:
>
> 7cc3522aedb5 ("spi: cadence-qspi: set maximum chip-select to 4")
>
> ... and cqspi_setup_flash() overwrites cqspi->num_chipselect with max_cs
> + 1 at the end anyway.
>
> Thus if an older or out-of-tree DTB (e.g. with cdns,is-decoded-cs) still
> has `num-cs =3D <16>` while only populating flash@0, failing probe in
> cqspi_of_get_pdata() would break a working board, whereas clamping
> num_chipselect or checking cs against CQSPI_MAX_CHIPSELECT only rejects
> child nodes that would actually overflow f_pdata[].
>
> That said, no in-tree DTS hits this, so if you prefer rejecting
> (cqspi->num_chipselect > CQSPI_MAX_CHIPSELECT) or clamping it, let me
> know and I will happily make it so.

I still prefer the clamping or erroring from probe. A devicetree (ie
hardware description) which tells us this controller has 16 CS has, is
and will always be wrong. I don't see why we'd want to bother with this
edge-case.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

