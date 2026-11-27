Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795779523;
	b=KtuJgB7169OLquBX9k6tWyi9gejwXdGNXf6ONXDPPjbgYJtB8O0djwJPVyNv3fUoDuAE
	 odKsVRdEC2+q1fkQwfavgPFOJbPSLbXbrjPthq37l/siwZS6eo15JUSOSru/yytWBDYrC
	 NE6ccqe9UWeF3KnGsLM8Tn+gnk+hVycj4gPXnps+02EMO/E80QUw/d5k/1zSbupaCWMFy
	 D/8k8inuMkbNQoxZBVixn5c4GNVXGgooV5Hv/IS3p8QaywOuxgJWiJAlQNTcyfFemEJzZ
	 1D1lygsLDMZ4mjNWKemSa09sa3sH18ZZdaoVTjCFEYN83lhyPYLVjjqjvfL/MPUPqGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779523;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Last-TLS-Session-Version;
	bh=mZfNTWYCycrADgGpy9HuwGJctAflXk9FoQ4TF35AKCI=;
	b=l5+p2nwKLtlpkLEIRkPLwWYRKic5j/0IVVrBAOfys86xU0H+UU0TRBDWbSAWLL1mDdFG
	 FtG9BO8LJPAZa0E0pS1gy3Wp/Dj8XDp1sycpqY+sgLpNoPzsovmqKpfktcRnmQPMyj6AH
	 tzRYHCald+YeJpKL58WFOTewMamg+NE6CPTCpzpn/rEfKToq4ZKgTB53gDiCasO46vtIE
	 l2BKC2qk3Yxl+6rtq/r69m3QKwY3wcQFS3yiyTru/ELxuLjOp0t6JDiIaRJwWcpsWacnn
	 27BRf7qSZt0NT/ObCo1KZjEIe/b+ukunY4CvMDDhZTJBuu5UBnFjejtttVCiofuQ3KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nabladev.com;
	spf=pass smtp.mailfrom=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=NiwvYkwp;
	arc=none smtp.remote-ip=178.251.229.89
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA88606A31E;
	Fri, 27 Nov 2026 11:38:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAA88606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=NiwvYkwp
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 844DD10AF96;
	Fri, 27 Nov 2026 12:38:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1795779516;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=mZfNTWYCycrADgGpy9HuwGJctAflXk9FoQ4TF35AKCI=;
	b=NiwvYkwpeodkk50rJ+BVyGeo5xDDXdTjo0H/lUu1mzZXOag6bZRalAJfrk6SzgnEcHN7nk
	7UQKcCexxhJx1q7kpE0ZMIcr190EUtR0sB9sABtSOYN/3ELFwinuTeXQ1TPdknuc6LrwM9
	Lo9YXhd5zsNEJw7GctaOrsZWBqzUBuq0jYWbZtquQvM5udTeZIx46YYbiVu/flnK4PUwMG
	5StqzJQuusjpRkZRMK/WFLEtZJCmDxSGGNNgxG4ZxCRLyzPMEAFWoWeVrSLDxdKwhE3gWC
	d7fBrk0omOBNN6eV68V8Jc+PCgtShVaNyAGJzUChd5wOmuTxMep7i6icu+lreA==
Date: Fri, 27 Nov 2026 12:38:34 +0100
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
Subject: Re: [PATCH 7.3 0000/1002] 7.3.7-rc2 review
Message-ID: <awlruog3l9codBvA@duo.ucw.cz>
References: <20261126105729.110697432@linuxfoundation.org>
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
	protocol="application/pgp-signature"; boundary="T6wGGn4Yvx6i7iqC"
Content-Disposition: inline
In-Reply-To: <20261126105729.110697432@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--T6wGGn4Yvx6i7iqC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 7.3.7 release.
> There are 1002 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-7.3.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel

--T6wGGn4Yvx6i7iqC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCawlrugAKCRAw5/Bqldv6
8ljlAJ9LfcT2768SVC58kVgBBWhyLSC4WACdFb2Q5FF0pOd3W6jXMYl2bUo2wjY=
=cIOz
-----END PGP SIGNATURE-----

--T6wGGn4Yvx6i7iqC--
