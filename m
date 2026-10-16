Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F192DCF55;
	Fri, 16 Oct 2026 11:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792149864; cv=none; b=ss28CznL4buGLiSFq6c3AvkpQrNK8BkbvydzOqCTXi+S/HgUlCoLh7deRNvkigYpu8TpGtBI8EBrX9Qa0x7Q65vJK+MLqQrrdI8cGbQzLgRcZo6zhbof4ryfBnpjE1cUYuYQ9ttSbtGPrHD473MEU8M2Lt30M+ujrrFH0Ak5wBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792149864; c=relaxed/simple;
	bh=HXi3SpYWtqILFW/ZFgSoPPZgBqve/NXdRoxuq5AOVtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAxIhl9gDRrov7pf9Q4h1nMG8mq3jgo70pDllQg3jpBZEefIle5fx20cNicJU/eqQnDLq6CA9RH6+oCDyPlT2qubxqBMOh25GX6WiBqEq9DnVVCDpyOsdx+GIFRB4oun7pebbmO0d2ewGHqbr1rKCHWuPw/XjSH830bSr8O8hbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4Wweckm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4Wweckm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ABB51F000C4;
	Fri, 16 Oct 2026 11:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792149861;
	bh=HXi3SpYWtqILFW/ZFgSoPPZgBqve/NXdRoxuq5AOVtg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P4Wweckmz/VAclLhnQLjfYdPWIRp+Equ4qJzoLjDjYhy8J4ml/DsHEdaGpTe5/wiw
	 r6Gy4D1FiV73SMIphL4FZnqQrR9GJE5/zz8bjhLYqq6X8PXSV1z0YwViEXq4Rbmvqd
	 eOGBYb9yVs4ITzpGDLyk9ZL3t8tBT+3j5sZyBhxRN0rKpoT7ngvxDMDexLJjUbLzNj
	 9DDFnnNIBuVzWjGYSTaQKFj7CgTWrzl7ycyUA1BYWrUp8QksHAA2XES+dXvGI2Iiob
	 IzhRB83lumH3B02Q8OVgBXclABrd0NMBq7x4iVVpCNQ0vp8vBABmt9zWnyXjAmd4JO
	 lCegcUVlXXj4Q==
Date: Fri, 16 Oct 2026 12:24:15 +0100
From: Mark Brown <broonie@kernel.org>
To: Val Packett <val@packett.cool>
Cc: Srinivas Kandagatla <srini@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
	Bhushan Shah <bhushan.shah@machinesoul.in>,
	Luca Weiss <luca.weiss@fairphone.com>,
	Antoine Bernard <zalnir@proton.me>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH RESEND v2] ASoC: qcom: qdsp6: q6afe: fix clk vote
 response type mismatch
Message-ID: <cff5da88-30cb-42fd-b697-7cbe117f4376@sirena.org.uk>
References: <20261016063536.598610-1-val@packett.cool>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MICH3Cc02U1XLxW8"
Content-Disposition: inline
In-Reply-To: <20261016063536.598610-1-val@packett.cool>
X-Cookie: <<<<< EVACUATION ROUTE <<<<<


--MICH3Cc02U1XLxW8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 16, 2026 at 03:29:17AM -0300, Val Packett wrote:

> Previously part of a series:
> https://lore.kernel.org/all/20260506204142.659778-2-val@packett.cool/

> but it's actually independent and reviewed, let's try again with just this..

Don't mark things as resends if you're not actually resending the same
thing as before, it confuses both people and tooling.

--MICH3Cc02U1XLxW8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrSCV4ACgkQJNaLcl1U
h9Dv9wf/X0z0rQsoxDKFkD7Xa5E83nk6TpI2uXgyDJ1CUA1Md/Fy1hDr1viQ0EZ+
dHapZfbPDsT3gBrxCRd2RlwaNQstf4guXgBVYgPBxzUfBpF2o6z2vNDxPcOre7Te
ByBjeQJ9X2+MTFk3mjvR2+mLESMkPYLwlWZCMLNmx4aZaS743y86qjNVygu68GLW
caoDeBEKpHBHDLNfigppjQuN8SrM6KXZ8/tbi5fZ8VaQnpQFP8BtcFOsw7q63xdj
rOO7KhjodLga5DrJZrF9qwVTZ7YAJJKah9s1Qr919Ki0z9Rq2I+/Uh5wK8eINn1E
QiOxdmqS0+g72HoY4Mvt3e6tNzIAGg==
=Moro
-----END PGP SIGNATURE-----

--MICH3Cc02U1XLxW8--
