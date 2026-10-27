Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793123759;
	b=iQ4lU61VicBpa92SB3PBNf9fcR4GiNwOxh0CX5IbE/vuvlHBfm/dk48ooZCq7hSDP9Ya
	 WPp8qqR6iX55cHj4OXjJeCw7mxRl2Icr5m08umAX/6OVHpJHVgh14iz0RaooikEq8n/Tm
	 6mpLX5VBcbfWfWcXpbyhlIWGUPVv93CpfaD+lvyLC7nW6caKCv9ZSxBekhj0dZRnY327k
	 kyb2N7qCgvQC+NmSAIb//hqn2lraYYMhUY/mmnTkJN6bgPc/cbxz5uc3auLixrBNnw1r5
	 tK2cIyYekPx6r3JWL6f/OTR0KIe1BtU9q/mSa3nj7D5Ipu280sLoA5qNPgYaIVBaa2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793123759;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Last-TLS-Session-Version;
	bh=v/Bv2s5RaJFiWDM0uX0J0oT4O4XbTScBaMgsYE1R3KM=;
	b=bl3d6Kb3j2dc1CXgh0j5s5uvQXxjfplIRjfUt3nbHpvoIW3gxKs8/GAwy5M9+FKuR3Cb
	 V3MnoE2xEFD3q15o3oWNT/g8ap+OLBkZzWcEMpqTSz/5e+5iPiY9p6bhA5DSDHGKJzkt9
	 WaIW8f/4NXNCCtzfFaMi4E/dS/ZN9zt//dK3ZJBPpSZPHMyeErkH3LDURCOrT32iuY4S+
	 LVSuJr+sjdeaJ0BZlGEfeW2cp1qutmOHbO8EWtuypoFG/OQOFPNF8t3zl0ACx+HHMv1Kf
	 5WJLtsd1KoD3hoCd7pszRl6FU8xn/B+73dNuiOhGQSLVaflv1lsNT3n4KlubNsx7gEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nabladev.com;
	spf=pass smtp.mailfrom=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=UolYGaDN;
	arc=none smtp.remote-ip=178.251.229.89
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0770606A31D;
	Tue, 27 Oct 2026 17:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0770606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=UolYGaDN
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 07C7E108D54;
	Tue, 27 Oct 2026 18:55:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1793123752;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=v/Bv2s5RaJFiWDM0uX0J0oT4O4XbTScBaMgsYE1R3KM=;
	b=UolYGaDNIWC9E50Y9cmM7BtASm3btxoQlN95xDsjkUA8jzFpyRGYQocPH0NjYZjqohfc/f
	f5ASPYfijTh3/Xo9XyWWJ/7X4Gq8aDmWTcMH1DAnf3MVXPxoHkdwwX1DvvBPqexIxCqbuq
	58jA7dLNIRBPrf7Zj4qqVoQAW5gJFUGq1nOjXvETEzi3+Nsi0nEocSDrxI6TkFxPFU4S3I
	fsY7SqeOgG6zde3ld88EvTdb1sQGBtju2xUYK2JalODVTlztvnu/ENXpThxjlihaI8hdwA
	7Dyk+/siPSnz6qaRd0BhWqT7ArF+AurveILMgaakINGTmG2dp9F4RPS7Etw9rw==
Date: Tue, 27 Oct 2026 18:55:47 +0100
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
Subject: Re: [PATCH 7.2 000/231] 7.2.13-rc3 review
Message-ID: <auDlo1LuocyDBmS6@duo.ucw.cz>
References: <20261025125805.309934791@linuxfoundation.org>
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
	protocol="application/pgp-signature"; boundary="LOree2NpcLncJNom"
Content-Disposition: inline
In-Reply-To: <20261025125805.309934791@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--LOree2NpcLncJNom
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 7.2.13 release.
> There are 231 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-7.2.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel

--LOree2NpcLncJNom
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCauDlowAKCRAw5/Bqldv6
8rc/AJ0ezYraoY7J5uD8d4MCo34euM+wvQCePmKxEqBtJsVwHTVQSyj3y8+08NE=
=9jR6
-----END PGP SIGNATURE-----

--LOree2NpcLncJNom--
