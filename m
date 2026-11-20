Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795173648;
	b=Hb05STluvjFaMxuPtXvncbeIzywdpUvkZM5fSlVWu4J3BJTdrOeSLKUMIAm06kGIe9s3
	 yLH+FjE+TfWkiIfB1E4iVNJ6uFkYCqZ1G/DMcsyKAbwwrCdVqsGwU40Y6JifRDNCvbYaZ
	 k5PAe5W2tBnCuCi/oXGgBl7xdnrg6xnxFTEF7kAE3xVmjXuhKZzVQzpjOF6Ct5RH3Xi1Y
	 D8AYXf3f+vmxfULFOaE50P3A4DUZSdpA6dtMq6XXlbDfT/+XL4J8xZcUEszxy8WLcdy5n
	 trp+n8+ZSBG49ljf1e3n00SIOUGVXTDXSHPUdtJYoDu9cutDdGf4EnCTw6cgEhkWKfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795173648;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Last-TLS-Session-Version;
	bh=UfHyPr4hxKrAaOseESZGBqjkM2SVW8KuOr2ITZ8z8CE=;
	b=T5rdkKCa9Tz1kypLyUJARl06U44xGQQ1ljWojWpp7pxMtm4Armloj3eO1vTWI5xduykb
	 0D8/Lyqs/sQ7i89zpIiAgxvPEZTdufoet6bELBpTpijiVPXmvIZfxm18AsokARcUyUCFi
	 dOYvpYvE0xhfkqpgjAL2zaw5GsL/BfYexcfsgLUgih40kZm0TyDSYb+/Q3zHyVSnjY/Nz
	 3iryDLkHt/Qes469qxFTA1dWesYKGtYigGg9BlLX5Wf2AQfNkrNk20pHqhR3fAxkSuzH/
	 h38udkXsmx+IOh4wnsK57RgmFTTFxnpyGGqVf4HTZ8YOhR6NgLRRRgwI82zIrkn/aMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nabladev.com;
	spf=pass smtp.mailfrom=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=AxkJptZm;
	arc=none smtp.remote-ip=178.251.229.89
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61903606A325;
	Fri, 20 Nov 2026 11:20:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61903606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=AxkJptZm
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EE2CA1088D5;
	Fri, 20 Nov 2026 12:20:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1795173642;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=UfHyPr4hxKrAaOseESZGBqjkM2SVW8KuOr2ITZ8z8CE=;
	b=AxkJptZmAF2fZlI0iPaqUOfTDBxRyKbNyYZr0G6l0+Hs7oVt8O687MW8zJ5kPrprQf4xOl
	ZQsxDEA5Hkum0M+akfuIZIVFzV7SB2IJ+OTcO58rVjFTgGG+zWna0SiKAKOtiOh+T2RrB4
	5xhq9gOP+0I01ofWPgAPS/JLuQ0ykYCETxoFC3xsYssOdkWrnhMA9xS0B9p6QrI5toGyA7
	VnayQ9eYYowuhWoDN6WkFivcxFRmxf5HTPxO6zig4FknMuGIgWJnxWkXW3AEk1TzyBpEKa
	uSl90CQdRZ+j+5i+z/KY8K0+aA6SFdn9mF423p8/Po7AWTFILafoxA+JmCjwfQ==
Date: Fri, 20 Nov 2026 12:20:40 +0100
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
Subject: Re: [PATCH 6.6 0000/3308] 6.6.163-rc2 review
Message-ID: <awAtCMJf3MdDpIeD@duo.ucw.cz>
References: <20261120055324.975889935@linuxfoundation.org>
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
	protocol="application/pgp-signature"; boundary="o24NkTiqvgyX5+O7"
Content-Disposition: inline
In-Reply-To: <20261120055324.975889935@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--o24NkTiqvgyX5+O7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 6.6.163 release.
> There are 3308 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-6.6.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel

--o24NkTiqvgyX5+O7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCawAtCAAKCRAw5/Bqldv6
8hvfAJ91FutdF39F5Lnr7jrokPbJb3ezAgCgkfHVdP4XlD5mJCw21YMw+/N6G34=
=Tf9B
-----END PGP SIGNATURE-----

--o24NkTiqvgyX5+O7--
