Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793268400;
	b=apoMSCXTQpkNyACHE1d8838JxErYJGZ5Dxe3B4ktqd1TkqxaC+AKa179DyUcTWt3Cd1r
	 /rA149j8cnmH2ADTjqVCOrSMDdnQXHO7vcysdjZvxHbuUZ8C1Lsj9/us2IXQX24efZO4o
	 kErlLcMmALGt0ik9S6jhuUUUh+1GES+L+FhZSvEiMOMxoFGWOmgG5sIwaar/40wyL28Eg
	 RhAdGXeWVw/3Q7UeTuBDC5mLT3qY+HmQDdxRXVxM860Z9+zhbY0PutwJntw5ztKImUJ3U
	 ZLIn6DyuNVQA6kdB7Up4wtWJq/bzbfDBpmRley05h6F6bz31ngC+nS+IQ9OvaYG3b0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268400;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Last-TLS-Session-Version;
	bh=YcZX13asPHicwggbgU3iu1zB61slnlTiIzdyqnigXuE=;
	b=xSnS2pLPqoWcP3Kdk6hbXZO6CCQ128h22YVqtWgEbvCP83ysQwQ7yQhQGUrugp5tcdhL
	 x/Ir9WPlA6wMkcvEWNLc9a/AERqHt9belQLDc5X2VUJNYn5w8QgsZGd51jYfzRdiW/v3o
	 h6p47gGp7kFAoheOBhgcL5ZNSd3c6FYIrEEO3x/XMxi0JmfGUJAd4xC6EGcuDJXGnr9Up
	 Uw4+thk+z9vK0synzhpW3TABTb7R0nhA34iDRMiq6FCgnD3tYt6Z+jRcN5IYX4fLGJSN/
	 bGA207ksYuosTtL/R/7/wSv/Lyvw0D8AE+fJq9pa3BXUaKq7D3u4DveNOYXb0pPDKFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nabladev.com;
	spf=pass smtp.mailfrom=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b="Tg/9nf6+";
	arc=none smtp.remote-ip=178.251.229.89
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1213F606A31C;
	Thu, 29 Oct 2026 10:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1213F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=Tg/9nf6+
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 800B710A8E1;
	Thu, 29 Oct 2026 11:06:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1793268393;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=YcZX13asPHicwggbgU3iu1zB61slnlTiIzdyqnigXuE=;
	b=Tg/9nf6+ZED/l+he501JwsFVBSUCtWqvv5osLLzHGxLpOsuOG3Lm7CsSS4zAf5ff7KfGPf
	Ao/1zabCXhDSZAS3L0t02CmlVB//qOqJOF3QtDHXaxNZgAqTQjVpahBmhjP+G9tHdCebWk
	4XoVdV1iptTyf7Stzu3pEvrWk+QPwCRCxn7uWYwm8sKPe3A+1IK18yjyGsoUI1YePnbnMs
	83Z66nLAdgytwo3gKZVTl0/5BkUNDP++kwgqdDjRM+Z/Pf0xev2JScRQ8l+kqf/R/v3HIr
	0EBUQ0XQUqdophqPERxijil5UebsZ7e/vYDXTpS5rYKbF/sAvM80yvCL1ocbjA==
Date: Thu, 29 Oct 2026 11:06:31 +0100
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
Subject: Re: [PATCH 6.6 000/168] 6.6.161-rc1 review
Message-ID: <auMap06yesGohGRR@duo.ucw.cz>
References: <20261028165943.089486480@linuxfoundation.org>
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
	protocol="application/pgp-signature"; boundary="bqrpMzm0POkdKOCF"
Content-Disposition: inline
In-Reply-To: <20261028165943.089486480@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--bqrpMzm0POkdKOCF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 6.6.161 release.
> There are 168 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-6.6.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel

--bqrpMzm0POkdKOCF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCauMapwAKCRAw5/Bqldv6
8vWXAJ9gKIrH2NYE3YTaofHYZHe0CmInigCfVs6CQpVcQtmZU2jwLOw3+SNT1OQ=
=Gmp4
-----END PGP SIGNATURE-----

--bqrpMzm0POkdKOCF--
