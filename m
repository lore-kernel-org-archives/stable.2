Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795099488;
	b=W4Be7VPeXRawbF8Iv5tFTnSBd3+Tb4Tq7hM+OGwrL8Ntktl1DCAW8jSxjekTvW43g12E
	 dNhyA3NBM0wEr8Au+/Ao/OlDUls+YjU5jg8nn0G9QMVqXh11SjHr/aAc3P5dU2oCkMsPp
	 kIpm/ieeDAoOR5cPs5kpaI9u5g612jNmIYVSLsnL+jSLtBsPVag4+MgZtqYAGTlXWQm+b
	 NXjHHbywvnoMo3s/rRUuULJxSPwEf1CPz3wftU0rE3VfoMM93R5M0R/rBO1cjy4M825LI
	 LfGXFEkLII+zlXGiyn3gfSSvkOWLR8WIiXyEbLTn9RqyS8nTXUkmFmHFexvAayeR1zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795099488;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=VVAg1/ryLwUOAeW8qU0JirDb/BwEIE1Erv0JMtRCUic=;
	b=jVP5V3j3BKid6LQhwZZh4O8ky+cJFYHPHhIqc326HfOSvVYblKtFKbhTz5rHVZav28cb
	 00/7GLT8WJe8UgvC83yDc9vNKz+j/JGZwa1IlJWhGxAC0Y0B6NPjWiMeu2vVv1HCBbVBa
	 wO6SxupT/eO+yX0MLSsqphYI/R4rBOwzc1a7NnXy+dz0IODxOI64nhrNh818OjIOAs1v7
	 TdZYltZxgZfxbqB6GT36OzSxjBWeZyQLFceIpZyit4Nd7VV+aBrI/A8msJWW4pKWgf/r2
	 gSfZ3E29bhMqIwFnjK0UZQu90RErBHI9vmdFMbyXk/cbQg8J3sW+R9uDzfSKoWe8FaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ua7jgWcP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 550C9606A320;
	Thu, 19 Nov 2026 14:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ua7jgWcP
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 506861F000C5;
	Thu, 19 Nov 2026 14:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795099487;
	bh=VVAg1/ryLwUOAeW8qU0JirDb/BwEIE1Erv0JMtRCUic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ua7jgWcPeaH5QW53vFGC5KJ4GsrW4kqfB3Pp7S0Bq+Or4UlAva9aBUEZjLE9OzPn2
	 fLTZieGBTG75aQwfdu4bgWvYXSRQoNzjcU/cG9ob1v2TANsn2QgLVykWlDIc047xU3
	 76twZQISukR3Ycl/ijx6o2+EVAUFOtAtgRI/YRFbtQybY0bYt+1tLUDayqUS/NkeG7
	 qz3FSzkZb4grjbwixwAumaKWuXZwlur4+vP+HAc6LiEIYoVRZa8KZEGBwVJ0+LrBgy
	 jMSA2xcIwvv4jAlymKx7XMqr3JPCfOQC1PqnmE93hH0DfXvrjVVhoK3O43nxIgm+WQ
	 8MFQOaaZc31Ag==
Date: Thu, 19 Nov 2026 15:44:45 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Thierry Reding <thierry.reding@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Sandipan Patra <spatra@nvidia.com>, linux-pwm@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/8] pwm: tegra: Prevent 32-bit period truncation and
 division by zero
Message-ID: <av8LNHYxF1hIFb_y@monoceros>
References: <20261105143847.2559586-1-lee@kernel.org>
 <20261105143847.2559586-2-lee@kernel.org>
 <auykeNit2S4e7axg@monoceros>
 <20261118171636.GD98456@joneslee-macbookpro.roam.internal>
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
	protocol="application/pgp-signature"; boundary="nnwd6nhc567666kr"
Content-Disposition: inline
In-Reply-To: <20261118171636.GD98456@joneslee-macbookpro.roam.internal>


--nnwd6nhc567666kr
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/8] pwm: tegra: Prevent 32-bit period truncation and
 division by zero
MIME-Version: 1.0

Hello Lee,

On Wed, Nov 18, 2026 at 05:16:36PM +0000, Lee Jones wrote:
> On Thu, 05 Nov 2026, Uwe Kleine-K=F6nig wrote:
> > This is already addressed in
> > 9ad5602d4943 ("pwm: tegra: Fix value discarding for duty and period")
> > which is next-20261102 and later.
>=20
> Would you like me to resubmit the set without this or can you omit it?

It's fine, I'll pick your series partially when I came around to give it
a 2nd look

Best reagrds
Uwe

--nnwd6nhc567666kr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmr/C1sACgkQj4D7WH0S
/k6Dhwf/Ul4InGVjUZOz8ZdAW3ZpywQoMOwtH4g6O61+/L3otOv+1vE2koWgWHBR
pJWUwkaeHfe0Kwd2DN2davW41o3KObNxSAPYhFLUsoJb0ASvAQGj+dk3N9ss94RX
FCA8Zh3LKs6ToEBCSq8EBvVWeIHoT9+fUcTZ/LSMqjxxs1ANFIYxdn7mvPwVpIAv
S5Sg+zb6coQy5TpIJu02BoZVF75SM6nREbBNFhAnGjRDOqSf3GyRHWJl1J0g5WD3
hM6+7lQUDN9eHUDL0RybZJD+OAazsNZygOAspsMUb+EEVmVoUF4NwgypNfGWoOBJ
dAWv202+BwWFqlxujrshLHTCRP5j2Q==
=XZqW
-----END PGP SIGNATURE-----

--nnwd6nhc567666kr--
