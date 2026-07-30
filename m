Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFF1404BE8;
	Thu, 30 Jul 2026 11:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785412569; cv=none; b=J9yvAVSwjz5GI5HijrtSPQhpDlrNXkIgMKD+xwv5AGYjBMY/jqjfyipmPqIiYh20lWH2LJZCOQxxAZKIC3B+1WHx0EmevVEFjc+NWsoVINsoYWEYUM6xYTGbk4hHiZYEwTtSPDlTeni9seoNgNl2Q9Jk7rqOJwXPHLj//54qFF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785412569; c=relaxed/simple;
	bh=pWWaV4L2WQLV8lswXNeL6Djig5CWGG9Ths2HqYhhniU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEvCflZCEm7FCUUrLOlt0FimDr96cYAUMn44wzMKQ9AQg5XUraEiYiWP3OqSE+ArGhAlcHFUSObiwEk/B8xQVOLL0g1V/cm4zdwTGk3G6fukZe6qaP1dYlt8NwACRP/nyMNPYRmdEaqGN/w9zsRmTTI+RE2X8NKFVF3ZUtFj6/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2p6XA/2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2p6XA/2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E2B1F00A3A;
	Thu, 30 Jul 2026 11:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785412568;
	bh=DVZNDGpx2fF7ZIE+o5dbaYPa66WPrFHS8f0qW3kHd9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l2p6XA/25synrlFjSzD316VNKsb7kaJO8SkX3Y5cHDAbrHDvXEm5UGtWEs9erhrXh
	 OoCC7USjpo358Ejh65YBkmOjCsqB0bIinSYykaj9E1s1VtFl75uuMq77cCKuUzgDoi
	 ABWqj5IGeSLd4Itm3/Qovrh/YJLLd609s7futEo2CdZXLbkuzO/Tt125uljqJFuuFC
	 ajTRIa1Ep+h2KSG72pqOWALd1WAvqfCowrW5OKGbLYdhpjHQHEAhw/lwP4bvt7P9Nm
	 UAzepT3aTY95lAkROXDbIRi56AJLVA/gAiKQdJ+S53bSltI0QBklQzKBz+16PFXFbf
	 A/SPPIPlSkIMw==
Date: Thu, 30 Jul 2026 12:56:03 +0100
From: Mark Brown <broonie@kernel.org>
To: me@dawidwrobel.com
Cc: Srinivas Kandagatla <srini@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ASoC: codecs: lpass-tx-macro: Fix enum kcontrol
 accesses
Message-ID: <e9b81e2d-a140-452c-950e-2cf299d7aef7@sirena.org.uk>
References: <20260730-worktree-lpass-tx-macro-enum-fix-v2-0-6d091c736116@dawidwrobel.com>
 <20260730-worktree-lpass-tx-macro-enum-fix-v2-1-6d091c736116@dawidwrobel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8KUNt4IWGcLLWBMz"
Content-Disposition: inline
In-Reply-To: <20260730-worktree-lpass-tx-macro-enum-fix-v2-1-6d091c736116@dawidwrobel.com>
X-Cookie: In specially marked packages only.


--8KUNt4IWGcLLWBMz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 12:58:12PM +0200, Dawid Wro=CC=81bel via B4 Relay w=
rote:
>   snd-sm8250 sound: control 2:0:0:DEC0 MODE:0: access overflow
>=20
> Fixes: c39667ddcfc5 ("ASoC: codecs: lpass-tx-macro: add support for lpass=
 tx macro")
> Assisted-by: Claude:claude-fable-5
> Cc: stable@vger.kernel.org
> Signed-off-by: Dawid Wro=CC=81bel <me@dawidwrobel.com>
> ---

You had tags for this and patch 2 on v1, what happened with them?

--8KUNt4IWGcLLWBMz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmprO9IACgkQJNaLcl1U
h9CXlAf/SohBD6rv7Le3Eto/QfkfWNKUh8iS88MvStNPKfiNUy3+iUFUro9AAyGx
jGQSJoGPwPAlpGBm0C7RUyZjTlYPJ2LggXnTUC+Vile1oYzfwTvOa3X/FsKsRIJh
FdNp0z5ZQVFZxnA2GS+qVa6CmHdY8dVCYoPPvAPjlAyGqafPokg9uIb3RWQszG7j
k3oTm2j7eY23Q9bmuD0RgEeHXfnDMTAnVW8LTBPK08sNhW6+woNsWWFaYA2m43X/
e90G29wPEq8QnmbtqmampNUVoeMyo8hJ2mT8JuZHAJtstrIZ32Q2lKA+6ycetmsW
+ZAqRr1fa2wt1kmWke4sdjy8/jiTDQ==
=BFhX
-----END PGP SIGNATURE-----

--8KUNt4IWGcLLWBMz--
