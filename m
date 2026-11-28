Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795875606;
	b=HfQvVs2IyodUt1Ulpf6beJiZq0xRUXPGHscQh3MJVkYTk00oaiz9ATfCujpdEJ5nUmxS
	 3aQlsMJF9+ZEcj8oSVaLBbqrPrUWC63JorP9ilyM9OWLNbp7t2xq5fV6TNDnkjDNX/Z1C
	 AgXFPva8WH8JzZl1wgxZG9n6Fbwxy6e/Ep/9GLpgJgeBU0XICuDTPVHNpnk4HpgnqhxLI
	 BCfha1nBgNylhfqxNzQxyvbC6zyWEhoOMx0l6EgLfTU9aPbFvyQadxYASxn2cz1nl6zNU
	 S3RKkc4R0giZJSd5oKz4f/LSgRJX+kLn1l4CELhK+MESFgaiP9hoUbU40ZALRrTHT7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795875606;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=p6RETe2n9nSFkgmwbwxPDMILbC3h00DQnWP3gt1J/Cc=;
	b=Pw+sdfBGYcIOQtKSU+8ybsNOag//rRujtekeMvhL6uU1LmQ2JgyeM/I7uKHiSd8AhNnN
	 BwibWeU9ceXU348dQ4GaGVUqmc5aZQxNjeDk4eP14/snaFU8rfC5eCEs83FG22xjhSFoN
	 SLIadwNZeaB1CSFtHejGSQC1cam7T3GWjwrN1ChBUCHN4pFzsmrXDdki3R0ZxO9YtYk1l
	 wS/NaVd8aKzJ/fHhDdAWX1jpG2MFMQkhjEtXBsbL/l5IWHVDicsKO31vYFFXUHDq41E46
	 Q8bHT3ipc2ez4NJk1ww4ZVbW87GUgFI+yZ6+6jISAHYJnnlrDflMBLKZS/PWGkKTo9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R1lZZ1+5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EB0606A31F;
	Sat, 28 Nov 2026 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R1lZZ1+5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3311F000C1;
	Sat, 28 Nov 2026 14:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795875605;
	bh=p6RETe2n9nSFkgmwbwxPDMILbC3h00DQnWP3gt1J/Cc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R1lZZ1+5qbv/4e6EYQ1EuQ88gqj55hacUhJhSUdHikUvDIGnQ9reUDAB5COBBreMV
	 HiUbgm01XKP8cTP37qjSoCQBYfezxXwFuIJ4cQ3jGSOVShcjKtAvcpoWLNZCh7eS9y
	 DYfD49PJt7XKe70Kc8znYEt9exh4qHmXBnaafS4OxAjlqFiYLKe0NzPBP0TX151imb
	 wtGXGprxf088A7aAclFYzvwqXs0ujaZM8mYe6XFgWN9wwFk+Jm/RsKe5lX4v9cdDQd
	 s4j/dHWbNG3Rash9P8vauADDjt7C7L8CtsLrAwq8mpbqKhhrHyygNrW5VBzheNGPz8
	 w/2PMvr1tPSsw==
Date: Sat, 28 Nov 2026 14:19:59 +0000
From: Mark Brown <broonie@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	bui duc phuc <phucduc.bui@gmail.com>,
	Kees Cook <kees+treewide@kernel.org>,
	Ryan Walklin <ryan@testtoast.com>,
	Andre Przywara <andre.przywara@arm.com>, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-sound@vger.kernel.org, stable@vger.kernel.org,
	Marcus Cooper <codekipper@gmail.com>,
	Philippe Simons <simons.philippe@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 0/1] clk/ASoC: sunxi: fix H616 audio PLL and codec clock
 rates
Message-ID: <7350b432-a04c-451f-8a1a-045d3f3a597b@sirena.org.uk>
References: <cover.1795815223.git.daniel@makrotopia.org>
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
	protocol="application/pgp-signature"; boundary="layEJsjDVDBOgV60"
Content-Disposition: inline
In-Reply-To: <cover.1795815223.git.daniel@makrotopia.org>
X-Cookie: I'm a Lisp variable -- bind me!


--layEJsjDVDBOgV60
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 27, 2026 at 09:42:18PM +0000, Daniel Golle wrote:
> The H616 CCU reports the audio PLL at half its real frequency since its
> sigma-delta table was added, and the H616 codec support was tuned on
> top of that, so the two errors cancel for the analogue codec. Other
> users of the audio PLL run at the wrong rate: sun4i-spdif plays at
> twice the requested rate once the codec has moved the PLL to its
> sigma-delta setting, and an I2S driver for the Audio Hub that asks for
> 24.576 MHz gets 49.152 MHz.

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--layEJsjDVDBOgV60
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmsK4w4ACgkQJNaLcl1U
h9AeuAf9G0qsxK6Y/sQ0f+9QCEUTP96FGYku7DdOZg2H7llUzXOXE2TqwowcOvsO
LKpNWIHw9Z+rdh1kuqlVsyaJaUJcvK2zDol+/cKYXWnFixHCpMO5yyly45V9wXhX
5woquNvg3DCV6XvGw5D0iAte6fD4/HuNh9yRTfzyMGA6UUoxFRRNUxN1N+FxY0mf
/l81igCXEqTgZonnGRnQm/1WV31x7oNt1AiADDJj/aCtL/YOf5vcB9/JkwFhIZUb
XmUSp/vfJ4lNdXnONWyVY9kz6AxHdAuQTOJNIseWnGOur9LqBopMLs8TD5soeslT
4KLUrtT76f+UUGbzGExMdDpzaG96Sg==
=O75m
-----END PGP SIGNATURE-----

--layEJsjDVDBOgV60--
