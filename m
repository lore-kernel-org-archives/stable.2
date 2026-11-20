Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795186497;
	b=OqqpMeiIfS3WFphZHF5O8+VwTiEUKrOgXQeVRMSPG9f716D80tZjAvTCaTBfW6bgTjPY
	 KZN8VtwqmIMxuETxu+qxtOadcvUj18sYMcNi/jB1fbChSJhHYafDkKneb18O+myA2CZq6
	 beEdY+DadzjxitmpAurYywxToZkgruQjNHbz9Ur6vllufh5kfNfFXwAkoxzoXgbuwoZ0w
	 JHFRE+tCPqtvNnaD/BkhwxxZQR6wFnZvNMRpR94wR9pcv2y167JxZt85oPaLwm9u9uTWy
	 kQNdn7e5yzZ1yDtuQeUrdGSBZsj9ruyvS1W/PUWSAoCIqt+IxLFNgAc2h3crSGWpc9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795186497;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=rJXABJb2IswXHFHVUy9sFDPYDOPoMVxLMdVHHDodayk=;
	b=WvNTtSskFHOzhU8MRxylYp0Esvg+JsX+JyMPrUXNHTnSOAiQ80J5BmNWoTdODrs2aUPg
	 1YIjfPpshFEfMPJRxA7ObXFZb+LPxH8WnstOu7hdWSQBgNgqXYbXi8ftrFWq+aYMlQuJd
	 Gg5Idy8Lcu2Vc2fPswOg0Cmx1Cpo1lDIm6hto+wWND6M2nETi7AFwWdrmVp4EatXOK2Ad
	 iA6iW20ZfXAsPqzS62HZ5uygb1CDNdxb46PQ2Zk6daYo0nDcIfNFJevNBR9Blm9NRpiTW
	 ohmTHFJ8jOGNTDSlDuTWn/7Dquq/sNv6DPwt82wS9OyQhM6vmZakNSlsOUGiz0zrIVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=NSa6wdND;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1A8606A326;
	Fri, 20 Nov 2026 14:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E1A8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=NSa6wdND
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id BB1461A1735;
	Fri, 20 Nov 2026 14:54:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8E4CD601B9;
	Fri, 20 Nov 2026 14:54:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0474711BC027B;
	Fri, 20 Nov 2026 15:54:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795186483; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=rJXABJb2IswXHFHVUy9sFDPYDOPoMVxLMdVHHDodayk=;
	b=NSa6wdNDUXV1iBAQdr4Cq18Kf6waPEJ/Y7qwyECkK+15x2bH6Lvf2TuEaGypA2lB9oNG+r
	8uyiYz5UeB3lYM2E7hKXmfLogoUSdROg9Y02h/NEyX3z6FsL6JaVr2iC04Q1JeauoOD/GK
	rECxllg6qjXP6AsdaOjDkfN2MgTUtIfnjo7jLc6eUZ2Xa42bbGDwaBmSDWSqSu5ujQGX5d
	LwGpqyCx5S1dHlZSQFCQnAQ+3winGcc18c6AafMqbQ282ZqoHJMTTMHu+zk/4iXVwiONQm
	UorAtnyUnP/lFu6xcEOkjC1SNkTFiS2JwcYq+V8rulyoJPSUdVm096DL33+arQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH] mtd: take a reference when opening an unpartitioned master
In-Reply-To: <20261108-submit-mtd-master-open-reference-v1-v1-1-871aac8c6e05@gmail.com>
	(James Hilliard's message of "Sun, 08 Nov 2026 14:12:39 -0700")
References: <20261108-submit-mtd-master-open-reference-v1-v1-1-871aac8c6e05@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 20 Nov 2026 15:54:41 +0100
Message-ID: <87pkvza6z2.fsf@bootlin.com>
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

On 08/11/2026 at 14:12:39 -07, James Hilliard <james.hilliard1@gmail.com> w=
rote:

> CONFIG_MTD_PARTITIONED_MASTER controls whether a master is registered
> alongside its partitions. Without that option, an unpartitioned device
> is still registered as a master and can be opened directly.

"can be opened directly"

> __get_mtd_device() skips the master while walking the parent chain and
> only takes its reference when CONFIG_MTD_PARTITIONED_MASTER is enabled.
> A direct open therefore leaves the registration reference as the sole
> reference. Unregistering the device releases its device-model and
> NVMEM

"releases its device-model"

> state while the handle remains open.
>
> Take and release the master reference for direct opens as well. Retain
 > the existing behavior for partition handles whose master is not
> registered.

Is this really what you do? The code does not test whether the
master is registered. The condition is:

	mtd =3D=3D master || IS_ENABLED(CONFIG_MTD_PARTITIONED_MASTER)

As a result:

- A handle on the master takes a master reference.
- A handle on a partition takes a master reference only when
  CONFIG_MTD_PARTITIONED_MASTER is enabled.

No? I believe the code is correct, but that's again one of those very
imprecise commit logs where words taken independently are fine but put
alltogether don't build any meaningful message in my brain. Maybe:

  A handle on the master now takes a master reference. A handle on a
  partition takes a master reference only when CONFIG_MTD_PARTITIONED_MASTER
  is enabled.

In general I think this commit log must be reworded.

Thanks,
Miqu=C3=A8l
