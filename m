Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794611310;
	b=oENTscpmy1UmVIT77MThrbXGfhvvqYmpi9wymz8/YGP8DoMsaurpB/1JPOIY39e6nO8d
	 PiM+COMJcIQl23v8TBVxwMMMAP/NEbOKNXRb1jrTsdTN6TIEXBSBt64XngVfbSqAnDDTC
	 F9l5hepEjXHReETq5HRZUDiQsia1PMnskhgWJ12DUTGxicKur+lPUByH9Ha1QwSvbyaJX
	 YmgghBi3URb50HGWUt4GRGGXtGlkigQcHk9hNxGgkWgcqPPDiROB5gu2PCpz3AsUM1XDR
	 q/YWOBGTwxAlr9BI3fSOuDGYbMyfod884t47uRUyhUUMSRK4LzFCjwzb6Enh91NAqfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794611310;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=3b7zwExtQ0SyEtoROKgKdBFl0prgGBD+99Xf4KbA/Cg=;
	b=eqv0o7eqDSGIF3Z2FdWF5UCIDrSbijexqRCqxQOfeMN6740eJUWUcF4i2P2g8S871MLT
	 6zqrimN6lM+hpJ3iZd+e/J4MFVZ5x70yhGvHJVgUNpFn/f2X7EsUV1wKjeACEFcmiKIri
	 yO2WF3HkV9EAPFIV+riW1o6ClPme3EiAeEjU38M1Yt86m0MweqaLz+NzXQAsq3G1GRLE+
	 DlFqCAEgY8RiPoZ2f3RLMDseCjrATIQx0fRoO3CmXPc46TpaZSHg6yOzMlPx9hw0/NUZh
	 bc6NWSRQ3TgKm4sMUm8hkjUfax0kqxNfHpeMQrF+96Jy0pXw756osYGSnIMUGqy0W5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XMrIERFQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4DB606A323;
	Fri, 13 Nov 2026 23:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XMrIERFQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 671C21F000C4;
	Fri, 13 Nov 2026 23:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794611309;
	bh=3b7zwExtQ0SyEtoROKgKdBFl0prgGBD+99Xf4KbA/Cg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XMrIERFQ4LYqRD0M7ITDhWoh8pBH5iXi9VXsNrEQy+aL+guRPf41t8HGcqduPFRYF
	 ZlotY3uuFo+i5rnYuIdXfVEPb2Y8esqsRfKPbbQcmBx4N8M9YpdZpC9XIhTQjwtZxi
	 NtHj7kw+Z4vc4b7G+4MUHQ47J3ZAOiP0Bm6JPnWj70BTQLtipW7PZVqutN+QmfBExF
	 ZE6BfzaXVjPioKtlYmwd05X2lvJrN0FM6ZrwGLEYlc66k4G63uwadJ44d94W6/xP2V
	 HdYw6LtLoTMTrc9YVndtWqKMwXpcOXJfPZC0+kZLZGDlS4FW1Euxfc6O6KjFo2zPuV
	 /dpDoa4XQjbDA==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id 27FFA328BDAC; Fri, 13 Nov 2026 23:08:25 +0000 (GMT)
Date: Fri, 13 Nov 2026 23:08:25 +0000
From: Mark Brown <broonie@kernel.org>
To: Angelo Compagnucci <angelo.compagnucci@gmail.com>
Cc: linux-spi@vger.kernel.org, Ryan Wanner <ryan.wanner@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Radu Pirea <radu.pirea@microchip.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] spi: atmel: keep DMA chunks to whole 16 bit words
Message-ID: <80efd284-f13c-4efc-8384-5d46d7d5c65a@sirena.org.uk>
References: <20261113230016.4144717-1-angelo.compagnucci@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LjV2J+a7LTFyhXlG"
Content-Disposition: inline
In-Reply-To: <20261113230016.4144717-1-angelo.compagnucci@gmail.com>
X-Cookie: Earth is a beta site.


--LjV2J+a7LTFyhXlG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 14, 2026 at 12:00:14AM +0100, Angelo Compagnucci wrote:
> The PDC path cuts a long transfer into chunks of max_dma_len bytes, that
> is SPI_MAX_DMA_XFER: 65535, an odd size. With more than 8 bits per word,
> a chunk takes 65535 bytes off the remaining length, but programs the PDC
> counters with 65535 / 2 = 32767 words, that is 65534 bytes. One byte is
> lost at each chunk, and the next chunk starts in the middle of a word.

Please supply cover letters for multi-patch serieses, it makes it much
easier to keep track of what's going on for both people and tooling.

--LjV2J+a7LTFyhXlG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQReagvpf3TrrA7BoYYv73Ows9A4iQUCaveYaAAKCRAv73Ows9A4
ieTjAQDWqkdu7y4MSusxv8kW+zdN69QxsZH6WvPtJgN1/xwu6wD5AWEQ1gXERgTY
6Nz7jN+wfuAUz7YLlSAIrhlr0H06Mwg=
=s//O
-----END PGP SIGNATURE-----

--LjV2J+a7LTFyhXlG--
