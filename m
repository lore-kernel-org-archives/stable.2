Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794157554;
	b=2qsE+U0bkd3un6TWG1xyam+v0PjZJ5goGqVstzZ7O0g4jOhAN9YIS6kt2YxhTZhKeQ2J
	 dE7kgJTsPC0QSy3i2+uu9GPhnzDyZRAgan8D6ukYTTU2UoQ+/jM0KT8omdFy9x3DB4HRd
	 btrl+9Q7Z4QTGGiHrJz5oQPXxuKkuz+HtcGkjSXi/0YQM9WVZaMa2sMLlbcyuNlZcVnCm
	 N1voQMzv7P9kMkPl4pzVkBS/bGuj/m9YoM234gNHCokE4ZeHTMP5PN+VF9yhKaKXEoPfZ
	 XPC1HdQe5qUsVkiwdIhjMizvWLnYBG9DlkcZ3nj6kQhy5GyK1ltAFPGBsPfdHVN+Ogw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794157554;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=OBtzH8SdKX6PFWDQWi8/2OLkMnONA7NSL81PIjNaI1Y=;
	b=AWa3Cx+sLryW0qp1rawA4em1qX0ICJa4EwNyO+54J1x0l/TESUQKtqJiCWx8JROy4JtE
	 pzFJRliL4nWhKvn0H1HtYjbEW7VUuHB7VvIwfoMh2DyqtmO15RZXXFSU8HExfkBXb0WEM
	 OaCnp6zdpCfxnuUYdXAwmdZOUOH6Qhy2+HFA30UQ/iIjWnfByqhhQMJFDAKkb8CLPZZjO
	 crbETC29G/8xRgLfAeAYVLlqv1PtKEaoSWcioSr3Uzk8gOau0X40UxsshdaCO4ICbo0yH
	 Bql5xSi0Zcuiy7qxVCXWuRyO1W+x1OGc8wBJfaP9s96Tph1FHUdWGIeWWyb5RHwWLIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O3jZ7sEZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCB0606A31C;
	Sun,  8 Nov 2026 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O3jZ7sEZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0F41F0089F;
	Sun,  8 Nov 2026 17:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794157553;
	bh=OBtzH8SdKX6PFWDQWi8/2OLkMnONA7NSL81PIjNaI1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O3jZ7sEZY8NENOgN+VZdm/lQ4jhwTTwtfjuuN5HxKPvwulp+skS5l6fD9lvL2B8LV
	 b1sfbfezrodHV0KljFrB8w2qNFFAbRl4ll6QDMZHpJ6sgOp5bNKiQpxzZ1PbmyQqLm
	 WAHTUc/KsjHTdEqzxiB/EYKrGJsFGO0249UhytJ/2eomMsS9dJ8w/Flqb3cvWFXig4
	 LwoSXfHD1GogM3gYQjc/LXjJkJ0YRhWPKd6atvUSpMgZfi3hAp4ELEoSbab3d/vB6l
	 mC1BlHNiBGnEWGexewRKqbOxTJmRSxr4BmjOF54cYzS0OhPZnwEJJU0i6y469NeWke
	 Gixdg56uMF9kA==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id 537062D0D762; Sun, 08 Nov 2026 17:05:51 +0000 (GMT)
Date: Sun, 8 Nov 2026 17:05:51 +0000
From: Mark Brown <broonie@kernel.org>
To: hyunjungg <hj351016@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: twl6040: cancel jack-detect work on component
 remove
Message-ID: <4d6c1da5-bb74-4fde-9cd5-9f361da26bda@sirena.org.uk>
References: <20261107142006.3711973-1-hj351016@gmail.com>
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
	protocol="application/pgp-signature"; boundary="cvlDbwXVb7DopO/R"
Content-Disposition: inline
In-Reply-To: <20261107142006.3711973-1-hj351016@gmail.com>
X-Cookie: Whoever dies with the most toys wins.


--cvlDbwXVb7DopO/R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 07, 2026 at 11:20:06PM +0900, hyunjungg wrote:
> From: Hyunjung Ko <hj351016@gmail.com>
>=20
> twl6040_remove() frees the plug IRQ but does not drain the delayed
> jack-detect work that the IRQ arms, so the work can run after the
> component and its devm-allocated private data have been freed.

This doesn't apply against current code, please check and resend.

--cvlDbwXVb7DopO/R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQReagvpf3TrrA7BoYYv73Ows9A4iQUCavCr6gAKCRAv73Ows9A4
ieajAP9y90FSW9womqL3t5vBzMwzESBB386z8EDUJEqr/uWZqAD/RZbBwKsuUiKH
1UqkeGeROrCAgK7yEPt6JOoDjb/64Qw=
=RQY6
-----END PGP SIGNATURE-----

--cvlDbwXVb7DopO/R--
