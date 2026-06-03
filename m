Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0143F411B
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 09:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780479130; cv=none; b=C1/SbgHlImarfBvrZiFBBwo9te2WCw4yAj18PQlgFrbeppntR3wc9HS8j8jTQ5HpqLcLLRGifDmO7FQsWQ9Z3nWOSyt1BPNcZxwA7l+WAUuRbw+1gVBD8PRzKRwCsstOC05j+URi+rvfSdHcqV4xJGwT6ByVnDRiHW2LHLVEcS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780479130; c=relaxed/simple;
	bh=Ob8wxHCO6PRz1nBSHnxcaRaWXqCaoG4xtQffslKTzrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9B0ZFbln8tVAkCfmAVNDB5SuN8Kab//XEJMV/R4CuQn44ZuQB5IN752FeeX2SLqh/5uCxOOfKIH6VPsf+jv+wykTITGN/2NgiEwjJ/eGR3TulF+Df3B7gQrHWl9N0MBlQKwKZYu2P6hLG0v2EkgYSREOpV9n2oh3Qfx5s6tqo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=jrj/wLJG; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="jrj/wLJG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=8gLX
	THVGs634p2369jecAE6hm7OpEG0A266Yw88MJL4=; b=jrj/wLJG2SHQ+Aak+anq
	rqqEDuJGqCPbOPzteqqoy6lp+MeWurkfDI9dGJwtk6OaFEhqDgmPmF2xOSycJXxN
	uYqABzMHnCATbu19fTIVfuCPfkc7WKx9JRP20ckzZl0c87LvgngmsROw8UW32Jt6
	aj0ZzO+qsCffKynsE8+wRrPabA5P01V2Ci57JturwQJlOs3p4tKm0x8qUyIWJhhm
	lKRI3t6bnzw7Y1qNieKPWXEYbPCLHa5HjWJU8lfZgeHxOi/U4zf4rn8zYRw1Zn+e
	D9bK/WglrL8t9pbBNlUj8NvGQa5crf6VDw9GbR6zCUEyKWMZ8V+RF7k7br3VMTMy
	Rg==
Received: (qmail 3218725 invoked from network); 3 Jun 2026 11:32:06 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Jun 2026 11:32:06 +0200
X-UD-Smtp-Session: l3s3148p1@fhrWGVZTzpkujnsK
Date: Wed, 3 Jun 2026 11:32:05 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Johan Hovold <johan@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: Re: [PATCH v3 04/10] i2c: core: fix adapter probe deferral loop
Message-ID: <ah_0lRElrB_2BK2W@ninjato>
References: <20260511143715.729714-1-johan@kernel.org>
 <20260511143715.729714-5-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sUV7M72RRK93NobD"
Content-Disposition: inline
In-Reply-To: <20260511143715.729714-5-johan@kernel.org>


--sUV7M72RRK93NobD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 04:37:09PM +0200, Johan Hovold wrote:
> Drivers must not probe defer after having registered devices as that
> will trigger a probe loop if the devices bind to a driver (cf. commit
> fbc35b45f9f6 ("Add documentation on meaning of -EPROBE_DEFER")).
>=20
> Move the recovery initialisation, where the GPIO lookup may fail, before
> registering the adapter to prevent this.
>=20
> Fixes: 75820314de26 ("i2c: core: add generic I2C GPIO recovery")
> Cc: stable@vger.kernel.org	# 5.9
> Cc: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--sUV7M72RRK93NobD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmof9JUACgkQFA3kzBSg
KbYXPQ/+LzAHG2FLqx1IFf/xIdZzdxtvvs117Em857A5G+dtKE1bF774dVO2U2Gh
wyjQdSi9Vdp0jBsMgVSUHvxC7YKcxH4ZVx+7TVAVeghDRndwEjqOvrVdw9xhXmgc
vjJv2cO1Y4FGG7eEwqwEhATLuPTBQ57VWXV58xQFFvsWJn9ao8Z7SFb8yJ5PKww4
bvnWWHLiP1g8WyOl+gmpqI4txW3FSl7dchJYYSbfwNHvLjk/xS33iKrWnsMwfhu4
CMz16TwjANU8eO4NSko+nH7fnHUPtzssNRzHXowtV3oReVb+NAz2JrilV6IHpyah
KoiLOGtQ8S35hB7IoKqFXbwPmwbJ4IdtLTvzr45iFEonhkav0H0dHmVyUMZ0ipjr
NdxjyrJzdKsRbIbWnAXBl6OQP+2Ns0K9lJjJPVC1tCgOQwRyKEFtbxFhFwrlygK+
YH6s3Gl85xQykpQpTpqYsXM4MGYG81pevhV5Yjh3xlr0yQbcBzLVOw6BNeXxIqzl
a4WG2UrrLWUzwfRJjwk7gLbPhzxNxknC4z/RAWvJNwUlZTC9ECYNrneAMhnTHG5s
aob0Uoo4rRh8cDKpo4CrVaogmLpswP8F7XbQqtGZAvlVvasVesByRMXvvXd30vjJ
A+TDMHuBTDKmSr9kQznnWERScmq6wLLx5555R0H8rDdF1u8Wchc=
=26hV
-----END PGP SIGNATURE-----

--sUV7M72RRK93NobD--
