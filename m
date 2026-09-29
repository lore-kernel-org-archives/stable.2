Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC8C5012AF;
	Tue, 29 Sep 2026 11:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790680362; cv=none; b=Cyv2PkflnQwMDT1o6m2nD3aONgUt40dTvsosynsCt0/Y5jKDvYKD7Rj2ljHUpf6tJWn93HNZ2dRfiaAKxG7VI3ps3zEVehb0F5ssfQsIc6vLBT+Z85s3bb52bmm2CoeNpXq4KpbOqi+PC1Mh7kZh8Zkyk0y2ay1cyTPGvpb+QE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790680362; c=relaxed/simple;
	bh=N7+Ub7LLba7osU7/14FGS0o+dQjIAOpH41y1Dos8Kbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhFdqP0RJg+WAnUaOuvxDFx/CM6DRXN21Gtyv1x95sTiwaKWhoKTEYBQMKH9PdLm5AQ+QO29msuSYJfcSLk+ajQGWcVvBwVca2BAjYPZRq69879VVRaWSg4gY0N0GTKzaldyiBF3iTUa2JY4SQkDgtuCw9MIXjvafmxH9C84wx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnQlMeXO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnQlMeXO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30BD51F000FF;
	Tue, 29 Sep 2026 11:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790680360;
	bh=hgn6UzFftlde0zw9KskCSs3TqU9tvzi1Um2CAQfs5xg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TnQlMeXObjC7uDN8kaYH8gJSP+ISnVp7PDWpg8yfOIQ2eOWJRT/0+VwxLoKLPn6ym
	 bts1t3r5NLCPcwKDBXDTAHdm8Cg6p3exNCVOSU/HAApjhwBpqGXZiSPXda0BWh5XB2
	 /XCKdnpvWbdtsBRHaMIBg1H0IxOi/lUNZtzJZuqkyNcvG7ZrgAuxUiyQiRAiCnCpWj
	 mhxI7MJaGV5PC1D6cJugn9il0ceYRDvyCpi8GnliVYIOOMukIA55pONC3HKuu7U6+L
	 N2AtdPOWpYO2+ZQCdF4Ub7OBRyKKIIghxwh+JuziPQpfbe4vayjRnzOhnRbSEP1kyc
	 PPaAmNZloT0bQ==
Date: Tue, 29 Sep 2026 13:12:38 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: webgeek1234@gmail.com
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Thierry Reding <treding@nvidia.com>, linux-sound@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/tegra: Re-enable SDO workaround for Tegra194
Message-ID: <aruc3qx7izFQYOhC@orome>
References: <20260926-tegra194-hda-sdo-v1-1-f7a636a07a58@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fexg7o6bv4dlhh6q"
Content-Disposition: inline
In-Reply-To: <20260926-tegra194-hda-sdo-v1-1-f7a636a07a58@gmail.com>


--fexg7o6bv4dlhh6q
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] ALSA: hda/tegra: Re-enable SDO workaround for Tegra194
MIME-Version: 1.0

On Sat, Sep 26, 2026 at 02:24:19AM -0500, Aaron Kling via B4 Relay wrote:
> From: Aaron Kling <webgeek1234@gmail.com>
>=20
> This workaround was originally added for Tegra194, but no longer gets
> applied for it. Commit 615d43540043 ("ALSA: hda/tegra: fix tegra-hda on
> tegra30 soc") changed the guard to tegra30-hda, which worked because all
> affected archs had the fallback compatible. However, commit 7f0ea5acfc19
> ("arm64: tegra: Use correct compatible string for Tegra194 HDA") removed
> the fallback compatible for Tegra194, causing this to break.
>=20
> Fixes: 7f0ea5acfc19 ("arm64: tegra: Use correct compatible string for Teg=
ra194 HDA")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
> ALSA: hda/tegra: Re-enable SDO workaround for Tegra194
> ---
>  sound/hda/controllers/tegra.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Maybe we should move this out of of_device_is_compatible() conditionals
and into hda_tegra_soc instead. That would make the checks for this a
lot more consistent and robust.

Thierry

--fexg7o6bv4dlhh6q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmq7nSYACgkQ3SOs138+
s6G8VQ//fPtsBNsS67sosQKCGJZwlhKMBm2S9NajDOR3TS1fkg06JoYRnXv1rPFM
kijuiif4bGqCfmLoIR4avtDbTSY9MKcKqHNwWSD/7RBpPDpSWfz4HiBhmUGO0tZh
74NHII6eOg4qh3wZ+as0lefha/zltEO+mhJcKGr+9kRo3evxtAFuLATeEh3IlNvR
p44wWSUUcpsx3kUV2I5S414Zd565xpPdfPj/AwF/uZqu1a67s9SdOcUQooRa9tE8
9OOwWRojGQ01XNSqgR4NwBI7tDKP8jfyBNj1msJUVmiESRi7IzNt466b1QmgrIgY
RIcFD2qinjItw2RoihZztJ5i+Hc7C8ZxUxgznyHky+ZpQDiXSPRgnti1XIdSl1F7
p2EF32w7vX0g3dUTn51xOU0J6ZxQrSSnE7Cl2l+Anlgb4SITujrQbGaj7U7nleRp
ZJ8pj73Tegxt6rZcegkmBBnwlphDjezvgZzoA8+ZhaA8K5CGZJu8vuLYlNPR2JCD
tdQ+5cOUGQDQznDu4hGC2A3TElpxoZmgEZHJT0z8Zq4badm8fmIlGY/Q7g1qD2iR
Z1tNNHpMB1nJS4ohWEwIqnqK1ku1tWOgfkT/nVC62uhnlA5Uwkq/rqSercIeWhyz
N5jHQNNHJ9jaJaZyaDfJd7Fvp8punOcfmN5qmnRQcaD7JSd6NNk=
=W9+E
-----END PGP SIGNATURE-----

--fexg7o6bv4dlhh6q--
