Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794217888;
	b=i07nuv/Aot8I8m2NAj9fgtiHtO5imNs9INKCTqv+fDVK3uS5baZjuYFwE+d6hX8CiKho
	 QGcLF4PAI8T+ub/x6ysMd1OzYCerSWUDmFosFDgU0MPVKVZy3rUoPJTmwrQIqQ6PtK3k2
	 TwM0+bpBIcWeRF5vwP5ogbpgAZkiEK8HX704DIMGO+j7aFLkU5NuvFwUDVUdSPlWOISZR
	 EL3dPPBuivZOVBZC1yEOxNPY8CdGLRsdWbLgi2zf72RTnaJrmmUZG7i4agaS9a3KVVGvG
	 aPdrQyr/yL+Ojtlojibhh6OykOV/3o5YZajw2PVDLyARenTdHPxs2mFcp+D/NLHm91w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794217888;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Last-TLS-Session-Version;
	bh=ezNOCMrbd9p4oAuHMi4rq419vdcjfc42j5tDoLcIzx0=;
	b=0bFaMSN5eMesolpx6kpkS8M4qChveZA0Oj7Gto4iwiPIMaJfIuJwkiz3grq4FDp6PO2Z
	 4HJt7lDrF9ryYUCR3vEUaqrRF0LFlZHy7Jm8fXaZDXuzTcuEbN50aXSmzyp8jOVL6qSwV
	 3TpV3V7gfYqKTWSqC8kUe7h87c4SjykmL8px6+fSzNv2qc5CQL9Kf0+Xsa/3Mr+ZQzHZO
	 8CwBO7JoDqWwGQ04Gs1pwBsWVeggwiBGEN9HVe5Tc1aesnS2ZTOlbp4oNXut7q3ZDrmVl
	 ePqI9SqdmsNFR0fwj7qIBBjs+nafr+F5S/MXvthVyxJbdgL4pSjktbAq7zaxtnV8Lfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nabladev.com;
	spf=pass smtp.mailfrom=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=gN76syU0;
	arc=none smtp.remote-ip=178.251.229.89
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0D5606A323;
	Mon,  9 Nov 2026 09:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C0D5606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=gN76syU0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 69BED10C082;
	Mon, 09 Nov 2026 10:51:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1794217881;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ezNOCMrbd9p4oAuHMi4rq419vdcjfc42j5tDoLcIzx0=;
	b=gN76syU0YfAf3f/w5NXJuxEyDjFVJqGz7hNh57wHqHYRaQhJToc8oGBXlQs51gkFi0BkXk
	Cw6E3HtIbFJqZt2UY0oyV6HQB8oWhP6caXyYn7l/0ucZyxPX8r32dw0Py7C4xsbmdpMzjd
	+t91IbyG9R2FOw45pIYP0UuICiFdNjpc8wZojDDMoYH+k+pnpQyusbDs0KSmikdsXL8aqA
	nQvzuwXYN+jhgjb6qo8152h+9KPDlfGUs2abxwScAL5gp81fNglevrK+mtY8+OVGoLC9wS
	AXiqWK4wgQw02yeBQTjZERlnBV+jJwALAtR74HYpn9D/HZN2hIjKKJx0qWUPCw==
Date: Mon, 9 Nov 2026 10:51:19 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 7.3 0000/1257] 7.3.4-rc1 review
Message-ID: <avGXl7Uy2PkEjPhH@duo.ucw.cz>
References: <20261107134939.434104957@linuxfoundation.org>
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
	protocol="application/pgp-signature"; boundary="fMg5DBF/WS7L0yPR"
Content-Disposition: inline
In-Reply-To: <20261107134939.434104957@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--fMg5DBF/WS7L0yPR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 7.3.4 release.
> There are 1257 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-7.3.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel

--fMg5DBF/WS7L0yPR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCavGXlwAKCRAw5/Bqldv6
8va6AKCebkyoVCc+WnL20xljuFGKvNL+0wCfdEXXnne74yZJryfDUneVvvzL+o8=
=s0/j
-----END PGP SIGNATURE-----

--fMg5DBF/WS7L0yPR--
