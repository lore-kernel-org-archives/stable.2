Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793313260;
	b=e4ut5+YHl0QLuS4A8TKEajO9mJVlZm6Mm3Z/OBWFsMtI+J1nlh0Cg6cQ9zFJavFkI6Ng
	 7p5Zm/aOULKEmQZZMChSL9eU5SIdLYX+lXM8MJHbTV46/6JCjbP83mSKo+0kAVsDHs/Tv
	 nQlvkhOAHe/QG3I0ntvFvyHTRD25tsKrnCxcWWU6ca5kqh1YUUcjRHp7Ci3agYIXn128n
	 d8WEH+gI0JK6JyaImN51yJ4sjXx/CkJx32j76cBBmcIh64wC3D8zgtEWQrpHX0gH64+/Y
	 XKxkSJpxWyWlPEEa90g/mvr/b2gHAnRrJVqGvycwplAz8wpGP0Ue2uzm71Yt1Q3b2dQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793313260;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=DbjQhRihY0/EvUWOyAElnilJ/pb6pFkDI5TA04aRSNw=;
	b=wnhDkdGpLaxno0E90EweehgGVhZcxxqPPeMq0gL5S2DJmFGcg7AVAEVZFiCBO32s1d8M
	 2kOhltNn50uO6e753xPekPrnHwbzdYhd5dYQrbQoViwjFyPmt78jCd0v4257x9wO1Gumq
	 P0hy93rZFpolsVJ5fgw1tOcGLH1JcMtvOGu+dMeKYGj8A8Y2N4tWme6+IzbOjNxgNihgB
	 449OzA9Jb79Ys5+pQ/OqX33uRUutCmOAf+xuitj8tU2Kam2T96/bkRBk0zNMFA7DEeyK+
	 j/XL9apC23H27MbOb3vRqSdCi9HJlEte3z8k16l0E048b5woIHOOH9TAjTxH7WtdOCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hSt6xROw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B914606A31A;
	Thu, 29 Oct 2026 22:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hSt6xROw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C9EE1F01816;
	Thu, 29 Oct 2026 22:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793313260;
	bh=DbjQhRihY0/EvUWOyAElnilJ/pb6pFkDI5TA04aRSNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hSt6xROwXhJ8UU85BerNgerdc82Ard7jEKvRQqugSSjlmOtbxLsFb918f/avPIg6g
	 OHmgldJYA6NDKrkPbZrUFFb8pGgauoQxTCiML7R5I6wzyJtG5LU23EmPjGxOadbXmu
	 qu3EDzkD8tQzyqzaGewrBUgqf+sCeounMj1RY9T9ZY9CcC7XkwRHL/r9RodsOeKj26
	 B7GeMViGD+mb2vEwvS4ok7E913/EH4Fmor8WE1lqBONQWljUuxxHaCK98LARyJVILF
	 wGSyWpjBdAcKOSS1EUVqkPS4Umgkv6di3RdKqKY8RW3n9UoLoR0GHLzPEXDU2Wpx4R
	 EXiAwpnYXZYdQ==
Date: Thu, 29 Oct 2026 22:34:15 +0000
From: Mark Brown <broonie@kernel.org>
To: Tristan Madani <tristmd@gmail.com>
Cc: Oder Chiou <oder_chiou@realtek.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Bard Liao <bardliao@realtek.com>,
	Misael Lopez Cruz <misael.lopez@ti.com>,
	patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 0/4] ASoC: cancel pending delayed works on codec
 removal
Message-ID: <6a9d3179-3706-438a-bd08-fad20cf047b8@sirena.org.uk>
References: <20261029212504.2997364-1-tristmd@gmail.com>
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
	protocol="application/pgp-signature"; boundary="IThJ0mShSvwYwnai"
Content-Disposition: inline
In-Reply-To: <20261029212504.2997364-1-tristmd@gmail.com>
X-Cookie: I have a TINY BOWL in my HEAD


--IThJ0mShSvwYwnai
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 29, 2026 at 09:25:00PM +0000, Tristan Madani wrote:

> Changes in v2:
> - Resend as unified series per Mark Brown request (previously sent as
>   individual patches with inflated version numbers)

I asked you to send a v10 (just prior to you sending v10 of one of the
patches) because my tools have seen that randomly higher version...
I'll fix things up, please don't resend for this.

--IThJ0mShSvwYwnai
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrjyeYACgkQJNaLcl1U
h9C8FQf+Oc/I7vohrB13bYcP9dodVO2a3syVAGp1kgI1Bk9JOdJKzKeg0NDb/3Bc
0uehOKbexQ3kP+2xkF8DBFHsC6c9Hx6+ed830MZfkHymm+A5NwUIegCoQbx9FjXE
pvLRpU1tUJOKYnGgxkOqaETo+9opWviYHJPEO5NTvEmYsnlX8hCgJ0dGe+XgO7Hh
r7aDsI6vrRR016A0uq2qTEd9i1n7bcrkT3DoGKJXz9cksPMeHS4kvg8WmiDiC05a
CQj0khl1EwyAZyGMhpjjHdKAxWtr/JF7mraUTf0dfHT0Q90o+DXLugqQACvfH+u8
Et6iGiBcw84zNUuFR/3Dl03pb+hSQQ==
=nfd8
-----END PGP SIGNATURE-----

--IThJ0mShSvwYwnai--
