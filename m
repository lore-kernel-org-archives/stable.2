Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792504138;
	b=wWv2ioEYwX7bn13KwiLIRh0fyhfBmfqU6wxX+1Z4PG8X3nnQEEqYHgT1/t4DP0p9GIlV
	 K0LcO3BLxoAZgS6bnnfmPaJ54Z+4pHpGqnLVyoA3Qw4qvjJbcoXSJIL6GT840NFNjDucD
	 p5vMADwli3UpR2JnILPFFnCqw0ZCHJkAOesnZh38ZLy0/vZi4UXhYAvE3mK6FDN6OG6Kh
	 qx12Wglhyc1s4Wk2xAqalrPNtnvMBHpiA/wfQzgdoHXTLAh9nWGxb/iPSyE0RKD2174t+
	 6enlAX7BiGIkB1OAyC2OZyk1Ftkh4Hd8nzJMf9gBJ3qmMI3/p5KEHTmMNQoLVuWtlAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504138;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=zcrV5mG9wMNbuWGJGcpdlsFljn7zVfj+IAR+UtjH/uc=;
	b=zCbyjnIjc3LuL1BPc3ARbBwIz0xY9UH0EYEIqkOKLjA7S/OI/t9FL47UF7Yn39RhEV7r
	 xEtgF/pVz1HEdXOyPwBrxhiKrZP92DYrcdwdv2cYAQD3XstOoYCnudPX6I8B+GFqQWye8
	 e1LvC8YwOKTAKpZKyI9kWqzBI3X1lU6JRas47qnIQwiLD/BNXJoLPTsqNWon/ijRw0o2o
	 G1kqFSBoa4y1xNxBL8bXXLDAm8h3avYxl2ymXZiOucWXQeQGn+PH0GUM94AGBrM39g0BG
	 +H+JkspUbClhLRfZmnoNfa6bnqs7OrZE36y06MWgPMV89JPbTzwFv9wCV5lRqY0yWOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ddSpBepS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55075606AB01;
	Tue, 20 Oct 2026 13:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ddSpBepS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4AEB1F000C4;
	Tue, 20 Oct 2026 13:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792504137;
	bh=zcrV5mG9wMNbuWGJGcpdlsFljn7zVfj+IAR+UtjH/uc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ddSpBepStOwLMmX5+DRU/ATEWwOCt7lpjq3Z8DOEOkECcWP7Kqv0xqrgIjEJTVASl
	 AiYeX2+9vO7HC0zrpzY5+DtakbjlRZr0TEdzFUC5Rpb6/1WnXbIqEHBETS1Y12soAl
	 1gdDs+9TO95CyImxdC5h1A+eaH5YWvlKfGwQOFTEpjds1M4MLyaw02Demm9rINRTaH
	 8V2VnVmVPyUjnALyxqcdiPITxq84YmxqglVl2iMmj6/OmMIEafL4KjVSGKv0at+ZMo
	 gcCoOiUGWJJULiK/6zknsqDGswNPDG7guxmpGmUVdsyxiTsQpKjdt38l2kF5ABSvrG
	 HRuI4ddk05OuQ==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 875501AC5994; Tue, 20 Oct 2026 14:48:55 +0100 (BST)
Date: Tue, 20 Oct 2026 14:48:55 +0100
From: Mark Brown <broonie@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Val Packett <val@packett.cool>, linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
	Jaroslav Kysela <perex@perex.cz>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Srinivas Kandagatla <srini@kernel.org>,
	Takashi Iwai <tiwai@suse.com>, stable@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 4/4] ASoC: codecs: wcd939x: fix ref leak and NULL
 deref with USB-C audio
Message-ID: <atdxR_3csYBDOc2k@sirena.co.uk>
References: <20261020082631.1509275-5-val@packett.cool>
 <25bc6c8a-b47a-43bb-b035-5a755ac41531@web.de>
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
	protocol="application/pgp-signature"; boundary="G4TP9aRR0d3URbt3"
Content-Disposition: inline
In-Reply-To: <25bc6c8a-b47a-43bb-b035-5a755ac41531@web.de>
X-Cookie: You buttered your bread, now lie in it.


--G4TP9aRR0d3URbt3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 01:35:02PM +0200, Markus Elfring wrote:
> > Some code issues were found during review of a port of typec code from
> > wcd939x to wcd937x, pointed out by sashiko-bot:
> =E2=80=A6
>=20
> Would there be a need to offer corresponding adjustments as separate patc=
hes?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv7.3#n81

Feel free to ignore Markus, he has a long history of sending
unhelpful review comments and continues to ignore repeated requests
to stop.

--G4TP9aRR0d3URbt3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQReagvpf3TrrA7BoYYv73Ows9A4iQUCatdxRwAKCRAv73Ows9A4
ia8GAQDYFFbvBQ9+UGCIzLUaxMzznA8sOOzHrGDeBu+WDVeGiQEAuZ6N5YV89RLE
lHXRJB/Dpm5HVWr9M9I5zMLleM3gNQo=
=evPY
-----END PGP SIGNATURE-----

--G4TP9aRR0d3URbt3--
