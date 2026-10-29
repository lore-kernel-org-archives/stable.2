Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793272215;
	b=PWVtxP/hZrIVqTSbc0ug+pG7dJRIa0A1ak08PirmxaY1Un9mbF2E0Xr2WpbENhpJCLIV
	 lvRKkG5woNYKiwM9aPnt2Tw9518b2l5e8OuYqhhPZ8ZSKJuq62iz46CYPYIMacW96Qm8h
	 8q+S7ZJG4TKj4+ZstRKY7CWKiyc1I8wv2jP8aX8cf9aOO7U/gE7Y7WOX7FWuyMTfynvp2
	 YAzQIiT+D7AXmZaojh2KbS58o6KiQma9x4azxvQnYfF0HlOAFxXehrU1BExHUvDOCnJx1
	 l09cxAUEVfVwXAJRv+OhGT7gX3mVkD9xa7nkZUu6ssEKBmcABwJo0rB7l6fNwt9n9EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793272215;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=DSxkRxPFsRck2A0J6inq6nAKEzhTB+HmFXLAFrUIAgg=;
	b=RRlyjq3IjzJzNzCDmq7nSIPG5QtZEV9eQmABSCYPDpZm7lEwPo5YMmVLVc5+OsAVcp3I
	 dsS5cKhS5XPd8SqzKyJ+oaQ2LOKp+/GmWUPiRS2kyy+zHDLxJo+S4PM3bOgpiFrla5xEn
	 mHtQIqBs8jF6/FpYHvRZPRG5vRk8nM0tRsuwoNPoVizUQdQ/LAlXGs+7hZcFOhmUUtTqe
	 y7p8q03FuVIGsuv60QYgci3L1H8xGJ64WqODuBYJXSvrD5dLaHn7GybahU+HjU7KuucMW
	 xALN2mwYhLjQBKpfxlOJphgowWXQe3651tZk3prqibGLHEZirh+Trr+bsCsqUQrUYPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MlQRtSUS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F121B606A321;
	Thu, 29 Oct 2026 11:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MlQRtSUS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9926C1F031E1;
	Thu, 29 Oct 2026 11:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793272214;
	bh=DSxkRxPFsRck2A0J6inq6nAKEzhTB+HmFXLAFrUIAgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MlQRtSUSoSiqLjihdmNQM49gHfTsSMr4L8C67SIk8pg5v2odSHKzWkqpdakTo8uUE
	 xpjNAg5Qq8haPtGfmcdN0/WMKACUMmUOhsA9T2S+53fDTP7wXvNV4QcN8JrChNhC0U
	 ic96xjslyH/kvFkFA0476aNioQ9Guj8jxR0ppGbm3ksUfYOVOqVDbOzHqDscerVIIY
	 pAmTWfPPBPlgBFfyskAOacWrYzkI8RfjdRvs49VSRQED8/wARpd2iROT1ZlMLWgmDH
	 9AyDnFm2J0HJhQxXKJolLp+xi9Nj0iEjl9ajHXJSqWRYiNw7kF9ZdFpv2e74axtxgU
	 YKflLo0uNKZzg==
Date: Thu, 29 Oct 2026 11:10:09 +0000
From: Mark Brown <broonie@kernel.org>
To: Tristan Madani <tristmd@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH v9] ASoC: wm8994: drain delayed works on remove and probe
 error
Message-ID: <a6254119-bdca-4ae7-910a-f50aaf07c472@sirena.org.uk>
References: <20261026112212.2519775-1-tristmd@gmail.com>
 <20261029102515.3417777-1-tristmd@gmail.com>
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
	protocol="application/pgp-signature"; boundary="BWQ7re8b1Km3keh9"
Content-Disposition: inline
In-Reply-To: <20261029102515.3417777-1-tristmd@gmail.com>
X-Cookie: I have a TINY BOWL in my HEAD


--BWQ7re8b1Km3keh9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 10:25:15AM +0000, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
>=20
> wm8994_component_probe() schedules several delayed works to handle jack
> detection and microphone status polling.  If the component is removed or
> probe fails after these works are scheduled, they can execute after
> resources are freed.

You've taken what was previously a series of 4 patches with only v1
posted, resent only two of the patches individually and for some reason
incremented the version to v9.  This all makes things really confusing
to track for both me and my tooling.  Please resend the full series as a
single series, with all of the patches.

--BWQ7re8b1Km3keh9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrjKZEACgkQJNaLcl1U
h9DO9gf+Nekk+pY1MkbO3rZ5b63q+jms2bcqkUuCRhJL5Wg/G+cF6acyWD2gCbrG
VrBqyaEscB+R9WMGwBuis7lA1Iwppas6SLZayXmjEinmUekFimHzEwEO9KdQaVfD
dH5veWPfo5To8z4FhrXUFcdPhpA9MhsLBLQ8T5+7H7ZLCNnOL6mx2CcXZCoKNeJ0
/2Rf5TLmQsh1wFMe/8XyATWsTDa5cSYMRtUGPLEm43lY5riXxRFaUq0X8GHRoRBz
jf0s80xeGv40c9QzC19pwHsafroM4XHIALbSdzhu0bUEd+JBXzhlnDhYubsNKOsc
2HUVKONujgKa+Xfb8eTtoeSZdk+swA==
=pHaf
-----END PGP SIGNATURE-----

--BWQ7re8b1Km3keh9--
