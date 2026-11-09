Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794217847;
	b=u3zeyMHsUVyzd82xUeobVYcsFohvxZUhsZ4MW1yQILdnx7vYrhBZ3LR4DwZncRg9CS+0
	 2wKR229o8F2CMIQS3Z20eSwAGKZ7lpQDAd/JEfxhDnG5rs2RReLOHrpaESX5e/lzYQbDV
	 Tm2/ickuKiOW1nO8ftNNAt853S/qQ7P6WaJm8ZEnppgG1aY5pYPkkzVMLS73kmjVnLYCa
	 99bxVjQzId7yQWpXmYk4+PE2tv7yb6II8msD7QJxSmASJ+qT/nzSHXIoFKukzfhplixoT
	 2n4lU292RKcmiZHMasYxRXIZ9QUopqUGj3bXioGaFguvkhwvx/oBwuY6GJm2v+qMUBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794217847;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Last-TLS-Session-Version;
	bh=Pyk3RMyOlvYCPKAmAwQ+s2rooO2rrKkWCnetcRD4/LM=;
	b=vntHZIIGlXdn/t/zgvovU77CSHUeThHbrnhOXA+TE5lflrD7t6FtJdZhmgKr1QvvV8R2
	 mGTVCBRzbldgsaYNh02DWMhH0eryyK1okffDXajs5uqGjmC57ILMZ6LFghUbsUyRxzJGn
	 /NW6wohvTWYgvmkaFBTvCPTp4MHGN11XBqTB9S64X+17lS+XiXgg3KNfOYH8D27y5nKaY
	 eGhxVbHVPHQE74wVo6D4VJzqCDaaRm/oeLjhj9KIzeJFBuivY/GuVuFLSq8fBRhHcMImd
	 rfy7qet3XOQR0NnR0UbEyuU7AguPis+ORsTVJ4O8Nix8UYmt0aIWdWZ2mNhg+usmF2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nabladev.com;
	spf=pass smtp.mailfrom=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=ikakdSxr;
	arc=none smtp.remote-ip=178.251.229.89
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9641B606A31C;
	Mon,  9 Nov 2026 09:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9641B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=ikakdSxr
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F1B2C10C073;
	Mon, 09 Nov 2026 10:50:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1794217840;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Pyk3RMyOlvYCPKAmAwQ+s2rooO2rrKkWCnetcRD4/LM=;
	b=ikakdSxre51pJn24szJMunDmNgVZfUsMTgSnL77T9je7QzUjM0/qtuEnGcktFKD/Ixx1lR
	US976aus4dySIkxeLSQKso1SuGZCwPG3X6NnjUphPKh73b3f33hvc3/bUee5bQIcjVrqJ5
	9yAGY4GpMohUvNFHfixdfPC0dGHL15oQ8sH+ODwqVCfojfolnIs6ce4WtbCAIbllrx+/e3
	VmIUqgRSIIXXxvY0jLUJG9u1za/682RVpdoEYjZxk1PnE6EIHvAh2xKk2fevj5ebgWg6rr
	azvJvsT5OqlbNhuL3Zo2IK/LRHHz5xgLofPDrge6ZubMOpEkECYNLHAdh34xNw==
Date: Mon, 9 Nov 2026 10:50:38 +0100
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
Subject: Re: [PATCH 6.18 000/869] 6.18.63-rc1 review
Message-ID: <avGXbnL-R--Nbb8t@duo.ucw.cz>
References: <20261107134852.069646174@linuxfoundation.org>
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
	protocol="application/pgp-signature"; boundary="QjWobvFqXxDI6HRX"
Content-Disposition: inline
In-Reply-To: <20261107134852.069646174@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--QjWobvFqXxDI6HRX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 6.18.63 release.
> There are 869 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-6.18.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel

--QjWobvFqXxDI6HRX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCavGXbgAKCRAw5/Bqldv6
8uocAJ48P5h+86BhBgsIWNmPw7KYO0vsAgCghWaiCR8FdFvrSUmbEtb8NFDSGZ4=
=J6Zl
-----END PGP SIGNATURE-----

--QjWobvFqXxDI6HRX--
