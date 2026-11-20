Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795172963;
	b=v76+hdnU1RFktpzu8pN1hxySXMHWXd0BH1KKe/7YWe4YkMP3U+olYWfpVzndgHzLcR5B
	 llmkaG4fRSF+pPH5Wl1u5M/MY03aZ+V53pz7lY0n4CZUXR1oDH/d4vPXkX9JPZw1EkHma
	 Gx8tW8O508LsUwd1KKIy84znvp8/UzjHTxscl/g7F1arYWuRD/MntZCyfRC+AnHgmmEuE
	 0yIJHKFOJcJ7xLgegi4tA6VvzbilB41amIRDBDtVdU1lde+ym4S7Oi0X4WrUqQ80CyFmI
	 MtTul1G2BRT7F3Uql8vOdHYMZ4Rz87rsdh0NnizIpujZ0FTrIVt2LLBFUPYbWUAFrBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172963;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Last-TLS-Session-Version;
	bh=WC5BXVHskQrd/cZEjgDgnsY3tu9geBYXj3pSkofB/nc=;
	b=zhUrmQ+hJfKSk2lagfGtNDzxX4wBYgp2ZUELR2xj6I7uiLLsjkSGxzRoEkONHVqxkRvs
	 bcdeq8ieTxU4CWjiLv1bBXXHF5k6Zm3KA1pwRykvoan+gFucK7FBYZBPTrcyv/gzzLtaR
	 F01mxF+0jqwQLcIu0GpWOV3MjFH7ZmBV/guoXP4jhN8ZEnfKb2iiHJj8x6GyGES93/a7G
	 Pimrt0tVweWGAJsqRBp4f2DHFuG4Kb4j0P31TTz2oODfj5H/mYJeJ4zjJrMRbgAGCVXCO
	 KvZnoqljFYH9wOtW6nv0BuyeeIt7Q6LenAkueSzASNTGxi2Za5bcU9v2jJuo9ajFNOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nabladev.com;
	spf=pass smtp.mailfrom=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=jckqfYdV;
	arc=none smtp.remote-ip=178.251.229.89
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7B1606AA38;
	Fri, 20 Nov 2026 11:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B7B1606AA38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=jckqfYdV
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 759AF10E482;
	Fri, 20 Nov 2026 12:09:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1795172950;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=WC5BXVHskQrd/cZEjgDgnsY3tu9geBYXj3pSkofB/nc=;
	b=jckqfYdVw0szIG41xYqB4Ro1aJyZEOLhR07JfNfhBpN5SOC/78yvQ7gbSVLQBqcSQCABUu
	eC36abgQo/9KfhT/A/ogsNYGfZUBViao88K6sS1aCinOrM9WOFKxy6Py4aMu2qy/vqOQEM
	4N7e1TEyMKx1Wh5Mxh6SinU7K3kX5BkCZqi2DmkcNSY9+imSpDAESmRjw8GEWLNEstKD8b
	/3OSUebqJ+RXpp9+vxKinbvPhGzmXw+ypo6/qlFesVzHml2Ul0vEfhptcEy0W7YcVxIHkK
	xou4YXFBzUt+ZBd1/Bq18MJbZWP8QoYenUahTHMhLeE2nxiYByAQmykwExsHEw==
Date: Fri, 20 Nov 2026 12:09:05 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Sasha Levin <sashal@kernel.org>
Cc: Pavel Machek <pavel@nabladev.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 5.10 0000/1848] 5.10.275-rc1 review
Message-ID: <awAqUdjqspPSlb9g@duo.ucw.cz>
References: <20261118145911.150052362@linuxfoundation.org>
 <av3a38u7mlLN6yJL@duo.ucw.cz>
 <20261120020908.2320910-3-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UQupFZjTLHTtcclT"
Content-Disposition: inline
In-Reply-To: <20261120020908.2320910-3-sashal@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3


--UQupFZjTLHTtcclT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > We get build failures here:
>=20
> Dropped the whole queued ste_dma40 series from the 5.10, 5.15 and 6.1
> queues.
>=20
> 6.6 and newer keep the series.

Thank you, I see -rc2's are out, and I no longer see build failures.

Best regards,
								Pavel

--UQupFZjTLHTtcclT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCawAqUQAKCRAw5/Bqldv6
8tXuAJkB+vaoBfSY7WtrhOzLIABOJJr8PwCfeb8r85ZbQyW+Gqs46myalO70okw=
=bhun
-----END PGP SIGNATURE-----

--UQupFZjTLHTtcclT--
