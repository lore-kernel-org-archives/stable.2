Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793964972;
	b=t3dm2DUSV1xGHvrTuE1jlNF1+O5/5s1GmujwUQER4oAJSr935XkCUM10AIf2aqjGCGpq
	 UJWuNoKBaMUaxb+gXHYq9UGIqn+JoM7kOXzJL05xveiWXCNGAOFYeQcZgDiM+9HkHqU5a
	 D1hiZk+rKBpD9VoL8o6XfCeSHRzeu5F5pOLnysTsExnTBHwEvpr7hAksyO/amxjqyqdBr
	 cz6quG0GgePS+WU7QrIUmEhe0jg2slKnZUc5Ox29x6lSivGvqmiAbzkQVkGI87hiQdcwh
	 PHcZSB3OL+f+azSFiS/cfGXscdrSIKh+NTWFZCi/J1HTDCUJc+SDcik5rYLTfl7IgjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793964972;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=6ELh8iLQH33pk5/3omd9NoBeH6GNzJqOflJ+R3IwKLo=;
	b=nxFQXqzaRCkwIzuMwGr5cuQXYQNouer07g+lRJ6RwSy4ORIABwTCa2729wLVRL6m0HaP
	 wqXrenvgg77LiTXNpV7zpKVLPbJPiTFnZfE45h+KoQCTjLJHS8DWKogE2gYeBykYbUP/C
	 U3Pj5TNgr2r02fCzW/og5mcNjWg7qkpEU1lA4ScSKrpO6Kg6TH7lptXQlkDbpNvUCkUde
	 LJC3icyA+3BavFRSvg9w4pjKXyBr8CdjXyHukOp0IZf0WwTQWYnKRRciP/oIaE5jVdgta
	 ntANz/J+AM0CzCUh9QFb910eyS3HxE5mpVtoG/3hjlPhprnBudXk6uqCxVNLV1WAJFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GKebSQq2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDCB60A2629;
	Fri,  6 Nov 2026 11:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GKebSQq2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113C81F008A1;
	Fri,  6 Nov 2026 11:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793964971;
	bh=6ELh8iLQH33pk5/3omd9NoBeH6GNzJqOflJ+R3IwKLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GKebSQq2BVuNSVZhArvAoKElid1r+0NZIJbM/TrNg8V+C4/R6W13iyFRXdbmRytjd
	 CgTX3Y1rkvDmXFNGyaA61UNcD1/9TrW3N8fbfYdkfY8AtQiswkEIFNuTKASwDLkHin
	 Z9Sz8Iqa5iEiSWoeOSwlHeGYXLQD13Zy+a/CMX4nf3epyEE1JX6OEQ5verZ+SXOH2H
	 3a4t6QWDiyHL/7EAzNBSQ3JouMyd5sQHwwQ+hOY/9jhKwHjnLs93qr28qpUUQ45qTT
	 /UGgovlfHOxACHV7E2kZGcZC0dcCIIwLi1OIwINkeG5nGyz4q8FzPNT442Vnu2IkoC
	 FQUn9IG6GdXhA==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id 759CE27E8A5A; Fri, 06 Nov 2026 11:35:59 +0000 (GMT)
Date: Fri, 6 Nov 2026 11:35:59 +0000
From: Mark Brown <broonie@kernel.org>
To: hyunjungg <hj351016@gmail.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: codecs: wcd-mbhc-v2: cancel button long-press
 work on deinit
Message-ID: <11820b5b-43a8-4bfa-bde7-11e71f5ff72b@sirena.org.uk>
References: <20261106052242.2000264-1-hj351016@gmail.com>
 <20261106054447.2019214-1-hj351016@gmail.com>
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
	protocol="application/pgp-signature"; boundary="nxjRkP5C9ziDDxTd"
Content-Disposition: inline
In-Reply-To: <20261106054447.2019214-1-hj351016@gmail.com>
X-Cookie: Whoever dies with the most toys wins.


--nxjRkP5C9ziDDxTd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 06, 2026 at 02:44:47PM +0900, hyunjungg wrote:
> From: Hyunjung Ko <hj351016@gmail.com>
>=20
> wcd_mbhc_deinit() drains two of the three works embedded in struct
> wcd_mbhc before freeing it - correct_plug_swch (via
> wcd_cancel_hs_detect_plug()) and mbhc_plug_detect_work - but not the
> button long-press delayed work mbhc_btn_dwork:

Please don't send new patches in reply to old patches or serieses, this
makes it harder for both people and tools to understand what is going
on - it can bury things in mailboxes and make it difficult to keep track
of what current patches are, both for the new patches and the old ones.

--nxjRkP5C9ziDDxTd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQReagvpf3TrrA7BoYYv73Ows9A4iQUCau27nwAKCRAv73Ows9A4
iTi3AP9E/Q5jlbVckZnOHBP7zxvNogwVxoH9fdxMi/liHxBjbwEAxAfCmLJKVS+7
sRAZ4f9xZIktl+Sh0RcTY6I0km3XBQ0=
=3xzU
-----END PGP SIGNATURE-----

--nxjRkP5C9ziDDxTd--
