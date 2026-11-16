Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794821415;
	b=MxCVvCFS4eLmmTIlSa0ZNj8gw5oLU/QVpeMyqAYZMY1dRBdy6m2sdOjPXpMbclX1FY+1
	 wrUw+zRKqPtEGprMjq6q7H56/vrojDNUu1YDdBXgnNMkdfjpTWyaK0zX+w05meNHWnKzC
	 KsUA9zxsLWisM52HQhmiyI1G+WTFBOWAvr+fI3IS6mUxRbkcevoray/optah8rWEkZvFS
	 59uqlQmKKi4bO03kjKYmzDqA4TgN6mXuPN99/U0U+qE55gNQSUjMTQ1vx6sHyqMJ7tWbN
	 ez/811FL9hGlrkmF8SR7bDiwPNdwj03SaHTID05J93Ldbi4cUpVKfRFOkU7bzsqHaiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794821415;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Last-TLS-Session-Version;
	bh=xlljGRJsSC+5JkrL3aZZmjEC8607mng2pcknj/B50Xk=;
	b=wDMzUDzZIj4YC+1ETtMF0KA9ZR+QzWrmq4BRN9R1Eh1oP0oxjYV7yg+ID4vC6erL5b+s
	 nGwGzikJv2qIC1AHbEgwkjlhFpVhYQmFoMUq5kHd8JUrglTi/BZ5OLV91cBVxeS8W89Rf
	 4U+kKXC8vzAmoyKxVpiVh5dGo/BeV6C/j4BoQURXNyv8iAPCAvNVa8HN6p32xsIMQKd3H
	 OTUvHZY4bZY5FRcL+GxgM9cxsbVJuKBmQuRm1lMb19xAEbTO0VfJ5WbtOmwHQC7/swVv0
	 AZX9c6SlGPlUMUnutDCrRNEg+qxqVGKgn9gD3lw9UFGHoJ4v35uAsubVgVqIFXD9y7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nabladev.com;
	spf=pass smtp.mailfrom=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=E4wIoCqV;
	arc=none smtp.remote-ip=178.251.229.89
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F00D606A329;
	Mon, 16 Nov 2026 09:30:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F00D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=E4wIoCqV
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6167C10F00E;
	Mon, 16 Nov 2026 10:30:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1794821409;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=xlljGRJsSC+5JkrL3aZZmjEC8607mng2pcknj/B50Xk=;
	b=E4wIoCqVUzIHymoyFLnOmrk7CiA9+YDFuJnj0LJwZEfKF0aTnr1vZgaHyrIKV+dUMgq3lQ
	qUM9kKWSGt61gECAE33IOdbINGwmlkow0QJuPoNT1QJ3wwNOz/e4ydnElTLtWnzYJzXzjZ
	eJabVdMEcLdv28CRLAmzoCyaWpPTVW6PPNxXI4KbWU+LaLplMj+XlGq41BKX2pkBkkCZbk
	R61JVmktGe/qKvf3JzOWPmBgsaXQ+foexQkxTgbOVNZ3/tFrHW+kibyJtagotfe9YgQ02u
	H1JCqZIXrln1k8XLGPP8zKkY9Q8CGrjd8VAT8BAPDMivnIr3dT4YG0iszrTnLA==
Date: Mon, 16 Nov 2026 10:30:07 +0100
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
Subject: Re: [PATCH 6.18 000/686] 6.18.64-rc1 review
Message-ID: <avrNH09FzQfmPb2R@duo.ucw.cz>
References: <20261113153820.902362109@linuxfoundation.org>
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
	protocol="application/pgp-signature"; boundary="+vogw0/b0BeL8/+7"
Content-Disposition: inline
In-Reply-To: <20261113153820.902362109@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--+vogw0/b0BeL8/+7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 6.18.64 release.
> There are 686 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-6.18.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel

--+vogw0/b0BeL8/+7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iFwEABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCavrNHwAKCRAw5/Bqldv6
8qwwAJdaeQcd9mGrY6VeeHrxT5v+1+koAKCESukRNsZoqhbnORGYqsVIT/HzrQ==
=1szu
-----END PGP SIGNATURE-----

--+vogw0/b0BeL8/+7--
