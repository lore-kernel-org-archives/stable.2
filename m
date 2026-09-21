Received: from algol.kleine-koenig.org (algol.kleine-koenig.org [162.55.41.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841B24973AE;
	Mon, 21 Sep 2026 13:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.55.41.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789996218; cv=none; b=LZq2IJVjb73vGYH6VnYanMulovbQWr30gtP8i9SQSRVjmdLL7e+u8DPDjMBqQDmy9uBcr6inuyQAciroHcSOaOIIP7yElXlhsR+7YrpIqR0oGWpZt8cuO8tnnoiHM9RHILmwE8m3chnLkfvLbyMN0R95eTtJ7fOw0OULStJgRPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789996218; c=relaxed/simple;
	bh=JdC1SHfsUKy7BMrU/HzmZDlznS1XKmehOsPz9P4irUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pf0hzY6n+QNmqH2gEZ+F9tjl8Dc+uIi+quizFIySmIkMCI0VTwecE6u/ydqDNmAat0B8BvtFDK10ymGTwysmT6eqlnaTbnjHDu09Md/pPCI0PHxousdKV++rsXbvQQbi5g61/+EScVpJGBmQJSuHjYDUBYxodXHQiVUpwxRqLg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=kleine-koenig.org; arc=none smtp.client-ip=162.55.41.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kleine-koenig.org
Received: by algol.kleine-koenig.org (Postfix, from userid 1000)
	id 2DFA9132F528; Mon, 21 Sep 2026 15:02:01 +0200 (CEST)
Date: Mon, 21 Sep 2026 15:02:01 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Guangshuo Li <lgs201920130244@gmail.com>, kernel@pengutronix.de, 
	Thorsten Scherer <t.scherer@eckelmann.de>, stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] siox: fix master memory leak on registration failure
Message-ID: <arEpuhA24xUlA-vw@monoceros>
References: <20260919181051.3751829-1-lgs201920130244@gmail.com>
 <2784d61d-99d7-41f0-8c51-7736b788dc6c@web.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="izhixbwlshqkotqn"
Content-Disposition: inline
In-Reply-To: <2784d61d-99d7-41f0-8c51-7736b788dc6c@web.de>


--izhixbwlshqkotqn
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] siox: fix master memory leak on registration failure
MIME-Version: 1.0

On Mon, Sep 21, 2026 at 12:51:00PM +0200, Markus Elfring wrote:
> =E2=80=A6
> > +++ b/drivers/siox/siox-core.c
> > @@ -753,14 +753,21 @@ int siox_master_register(struct siox_master *smas=
ter)
> >  	smaster->poll_thread =3D kthread_run(siox_poll_thread, smaster,
> >  					   "siox-%d", smaster->busno);
> >  	if (IS_ERR(smaster->poll_thread)) {
> > +		ret =3D PTR_ERR(smaster->poll_thread);
>=20
> Would it be nicer to use this variable assignment directly before
> the goto statement?

No, please don't, IMHO it's fine to have IS_ERR and PTR_ERR together.

But I wonder if it's sensible to create a function to all the usual init
stuff such that the error handling in siox_master_register() can become
just:

	get_device(&smaster->dev);

	ret =3D siox_master_init(...);
	if (ret)
		put_device();

	return ret;

Having said that, I wonder about the smaster->active =3D 0 assignment.
It's quite some time ago that I wrote that code, but either it's
useless (that's where my bet is on), or this assignment is missing in
the error path of device_add()? Thorsten?

Best regards
Uwe

--izhixbwlshqkotqn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqxKsYACgkQj4D7WH0S
/k5KIwgArWd7VR7jrF2DdZF41bo+PLqWjYaiYwuGi+qh+xQIr5OxD+XEzPZYka2y
Jfdw0Op5EczyDXTiYg6EPCERwTQBQof72MpDpK4m0yGOBb+6AC90zNWNZFGEbyT7
/BjW5EBsaYOPvSPy/MxdzwG+Kx5UvRl7CgOlCdtri7RwdfuZiA7+LlcvrAeuNSTS
dzt/Pj04fbFc06lh8iHPZBpDH85Pv84an3LvLXrlKYB7JoVdIio3hZz5WrgI0rPd
QwxdZR//ClGjDETl5xfo0TRmSBK1Cqwea+LO2gNUxiq86ZkkL4LoBx1/yR9A9vUN
6gpHa/OJ4LuLho1JkoyW3TIbdXHN1g==
=jbTq
-----END PGP SIGNATURE-----

--izhixbwlshqkotqn--
