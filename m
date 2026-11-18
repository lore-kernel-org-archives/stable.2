Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795011802;
	b=WNk8OlpyH7eCB74/x2j6axXfO+DRdaWIP/K5EILi0RHCsE4gBvhYmcZ6Vkvy1cwD5TeR
	 rz3pv94761DLsyL9JoSeDnmwXWusdKZI2t0AVGbGPEamxVbDJKCV+JbpxQfz5x2/U3bvB
	 MViBStHWrZyMZhzJ0eOKYG9tvJg5wjTA3xO20PLLlzH6X8JyyaFTOwYq+NWayBg2vUvcJ
	 U6jBz7BrAdcGeJzjF9BvxA2Seqctpw+ZVb26/WN6OyZEtxg6z2s4kKfg80VuyXMS5PuOa
	 a91jQyQHiIpD7AOxejM0WpxJAUpR+HBG3a9AaouYV2jPqFY8GpWNnGxpaDKkrshQq2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795011802;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=zM15f4uyf0Cdm+4FPizmEwlym4Qzt4AjHjSfK0g234Q=;
	b=V37xpadSrLSxjNGYt+8JfRAFW7h98WdzSjSeijqAPw6Yz281MVwSGE565b6fGjBNsGFA
	 Os7mzIQumKFFT9fcu+a6S0CZvqJkZhq8oFjBwRgwAFWKNRksfAfnY7yraHtP56R6EDrLg
	 ZUBSoectFfKcQHCyePXPEkRNResGurpBEAwbGN6zTmLDqoH+4NEARcUbZXPGktqLOE84z
	 Sjp+QrI+F5fz7pkYSW8avBvOFfGmFXHUMZ55cULCUlxwRJWIiwkKCvwdkgnVDEV2Sbqck
	 7hHZqfOJMllFSrMA5nc0WxpEmy6Z1/OhfCWWgPCg0V1wh6ALIi/W5YCvGQRutCt5eSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=iyQlEKLk;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A93606A33A;
	Wed, 18 Nov 2026 14:23:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52A93606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=iyQlEKLk
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id F304C4E4162A;
	Wed, 18 Nov 2026 14:23:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BF0D25FE9B;
	Wed, 18 Nov 2026 14:23:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 095CB11BC2168;
	Wed, 18 Nov 2026 15:23:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795011792; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zM15f4uyf0Cdm+4FPizmEwlym4Qzt4AjHjSfK0g234Q=;
	b=iyQlEKLkTd8DttUlP7gz+c0smOLZPYcU3pJviyb/l17DIdDjSg+OmQwnTH9gEM3z1FGvmo
	J0gClc4UGIqxz1ylEnaKdXKKdF7zuaMVdETrUo3uSkE3O8NxyumntfDm5/HYKif+aBE5Rp
	RHvGDQ8dYyc8ixNe5qvimOtZ07WJOHw47URZ4sHbxbvfW/k7vkvtcqSiJKofFFYSVjijqc
	B8lPrxO4lAvUxhYUVJitf6a9rmLsa2xqJuU0CyZb/TTwYrk6yGw1fQ+y1Yd6x1gNkarfqR
	YhXZu/PImaI2zzM3xEob3nWoUyPwR2w9RlIXpAT05Y/VTBVNmwo06K9MAE5ewQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Michael Walle" <mwalle@kernel.org>
Cc: "Itai Handler" <itai.handler@gmail.com>,  <pratyush@kernel.org>,
  <richard@nod.at>,  <vigneshr@ti.com>,  <takahiro.kuwano@infineon.com>,
  <tudor.ambarus@linaro.org>,  <linux-mtd@lists.infradead.org>,
  <linux-kernel@vger.kernel.org>,  <stable@vger.kernel.org>
Subject: Re: [PATCH v5] mtd: spi-nor: take the flash lock around
 spi_nor_restore()
In-Reply-To: <DMYDITU0H48Z.2LA5KF2TFNUY2@kernel.org> (Michael Walle's message
	of "Wed, 18 Nov 2026 14:33:44 +0100")
References: <20261029210153.3986211-1-itai.handler@gmail.com>
	<DMYDITU0H48Z.2LA5KF2TFNUY2@kernel.org>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 18 Nov 2026 15:23:09 +0100
Message-ID: <87bj7mi5gy.fsf@bootlin.com>
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


>> +static void spi_nor_lock_and_restore(struct spi_nor *nor)
>> +{
>> +	int ret;
>> +
>> +	ret =3D spi_nor_prep_and_lock(nor);
>> +	if (ret =3D=3D -ESHUTDOWN)
>
> This is actually really hard to follow.

Yes, I tried to review this patch and eventually stopped. Please teach
your AI to not overengineer its solutions.

Thanks,
Miqu=C3=A8l
