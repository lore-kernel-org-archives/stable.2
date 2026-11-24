Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795532117;
	b=TUlt/CZIAiPtjHRbA2NOkbbfUa886qc9FYrjUugAoDXb0HxwwxoFtWCIvqQfjo9EGYZd
	 Ond8FJpGPRwreWfm/k8psGvifUe/ZXObQbyIS1oEYDteyfQyE3FTQjL48E/Wo5tWGtJTB
	 ABNKOnXpN06m+TcYQZD4QM0l2C0b32faKP7f1ach9qOU4R6sYCl85ZIYRWzfCjpSznmkq
	 YNmJLQ1Wq8/bTpPnN4W+TnNb+PEFM9lE9okmDjQHz7sI1fwVKUTdmiiX9Ipjh36fuVcEP
	 Tz8NzljB7CAvWJoZtM7/B4IhibhuXi3S1N8plWWyijaqbxuLeDAWm8om23lt4HrdxHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795532117;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=D+hSgyqO/o/m5Gc+8nN83BXmFEuYW3cQNIGgjao79ow=;
	b=4LEOmmLaVwcRarJjy4RDyZ0iekYB17IvPptMvj2O1bGEZcSfbimpAGPw9TNO+nXH9Q8u
	 bZbyB3I96otEpqaS9wZT2xtnzGiwbpmtI4TvHhfYnX0fySIy1m6hybkL3NFNg1fDXy4pm
	 Cp4jgqsqQOVTHs1JQXoaFcvmSQTVwJ29sooWtpJz1Z6IK31fZaY9LZQdi05QeP/xlPIvf
	 zavIvd3oYnLnU/vCIhI8drJ4thBLw0SAu2zs9bUqL28nM6E9IeYBzQATqir6Rbq3STQuG
	 MRe03a1KdTfj+GUi7sp9b1OhV3L4JyzSsztIlh+xYwkhqDyn6tH9ISNQw4qs/2CyCsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=apShX2Xm;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC2B606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 14:55:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AC2B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=apShX2Xm
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 095A4C2C64B;
	Tue, 24 Nov 2026 14:55:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 829BC601E1;
	Tue, 24 Nov 2026 14:55:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5324011E682C5;
	Tue, 24 Nov 2026 15:55:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795532113; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=D+hSgyqO/o/m5Gc+8nN83BXmFEuYW3cQNIGgjao79ow=;
	b=apShX2XmOcZ8Y9rsgu2DhgLWhow7BGxZ29+aVKYkUNeIHDKVD3XOlDxcg1Ith9pI39a2YS
	ZluQ9EZWe/AYKBOZXTH46yvBn6BTO4WLbUHY4t2xntNdo0bN+V49DQdBZ5AOGi0hvUedXp
	GW/jYLMdoUrpseuB1nh5lRlkzZNlhhqALhCLXMTxBWvTMIsFmrWPKDUyJY+zU9siZCNKuR
	cwrCbSZTgUtScu+8x/nQIpFqb70a5GSK5RhCkJrsL6WaLOStVZlhq3w3Lk1XMewW9QE3Ol
	nj9vYqgUR1oUvqzADk1CkRKtjhAZpAf+XdLzByQ7yADRokS+3cWRLVM4hL+56g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Arseniy Krasnov <AVKrasnov@sberdevices.ru>,  Boris
 Brezillon <bbrezillon@kernel.org>,  Kyle Roeschley
 <kyle.roeschley@ni.com>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mtd: rawnand: macronix: serialize OTP access
 with NAND operations
In-Reply-To: <20261122-submit-rawnand-operation-locking-v1-v2-1-030bc867f0c7@gmail.com>
	(James Hilliard's message of "Sun, 22 Nov 2026 02:25:20 -0700")
References: <20261122-submit-rawnand-operation-locking-v1-v2-0-030bc867f0c7@gmail.com>
	<20261122-submit-rawnand-operation-locking-v1-v2-1-030bc867f0c7@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 24 Nov 2026 15:55:09 +0100
Message-ID: <87a4mys2ia.fsf@bootlin.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3


> OTP I/O can also run while the chip is suspended.

Really? Where does that come from?

[...]

> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -207,7 +207,7 @@ EXPORT_SYMBOL_GPL(nand_deselect_target);
>   *
>   * Release chip lock and wake up anyone waiting on the device.
>   */
> -static void nand_release_device(struct nand_chip *chip)
> +void nand_release_device(struct nand_chip *chip)

You export a core helper...

>  {
>  	/* Release the controller and the chip */
>  	mutex_unlock(&chip->controller->lock);
> @@ -336,7 +336,7 @@ static int nand_isbad_bbm(struct nand_chip *chip, lof=
f_t ofs)
>   *
>   * Lock the device and its controller for exclusive access
>   */
> -static void nand_get_device(struct nand_chip *chip)
> +void nand_get_device(struct nand_chip *chip)
>  {
>  	/* Wait until the device is resumed. */
>  	while (1) {
> diff --git a/drivers/mtd/nand/raw/nand_macronix.c b/drivers/mtd/nand/raw/=
nand_macronix.c
> index 16847f28b19d..d7f5a9e7c240 100644
> --- a/drivers/mtd/nand/raw/nand_macronix.c
> +++ b/drivers/mtd/nand/raw/nand_macronix.c
> @@ -380,6 +380,7 @@ static int __macronix_30lfxg18ac_rw_otp(struct mtd_in=
fo *mtd,
>  	int ret, cleanup_ret;
>=20=20
>  	nand =3D mtd_to_nand(mtd);
> +	nand_get_device(nand);

...and you use it across the entire OTP operation...

>  	nand_select_target(nand, 0);
>=20=20
>  	ret =3D macronix_30lfxg18ac_otp_enable(nand);
> @@ -426,6 +427,7 @@ static int __macronix_30lfxg18ac_rw_otp(struct mtd_in=
fo *mtd,
>  			write ? "write" : "read");
>=20=20
>  	nand_deselect_target(nand);
> +	nand_release_device(nand);
>=20=20
>  	return ret ? ret : cleanup_ret;
>  }

...and in the commit log you mention:

> Make the existing NAND serialization helpers available within the raw
> NAND core and hold them across the entire OTP transaction

Why are you doing the serialization in one vendor driver then? Aren't
all the vendors affected by the exact same issue? Why isn't taking the
lock once for all in the core a better idea?

Miqu=C3=A8l
