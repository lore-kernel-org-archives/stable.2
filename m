Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792429032;
	b=1oAuiLjWz9xBJ7/wBbAtvAzJ9pvepOoUbOz2IWiMEeIgnkrONt5IMkEvYjxPKqrflzlm
	 VEF4pIWtkl9eDLCbgWTmi6RKRJNfMPmkjjHJB25d5UYqNc3SyVaWrERHOwLcd0OhNu52t
	 JO0UmG59PhDT9ZIJrnIkK9CrUL5comLd07I8WDB0q1hxIs6+DJ/67N5apCfk8Xa2bYo+K
	 WJ0Ga+XADdqBOB/TMQE7YYvhPdrg3Mc8bM20gj81kAf6vL+0HCdk5djm6RpU8OGja6Z9H
	 gVe1KhneroIClM8gvshXX4EsaANZW7Zn9A7m7Bf/ozRFF6hsNC6XO1hckvI1dObEcYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792429032;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Last-TLS-Session-Version;
	bh=UZITaddrP21giufc1kS4sSfUIiVpWl6pa7LTpWKgpJc=;
	b=FJcdB5bJPHrPwVh8MA1rz7eaLuSWxGJ/9/Fmk685jXeFPcHm8TWpW1uHkLHAMZUc2agO
	 8jDKXjwIK0iVMrxrjX0gN2q8pyyeR/OI7Uk5h2bYSr/kZL2dtlvwZt1xhMrRd+wiudk3o
	 ITAm/G5Dka33x1sJx2k/erxBXxRuFMsrABEMKkuciZ7SBmV9VdsdK4TWeGUwBMueBNlIJ
	 msVMSqh9d16T0q2Ch1gVUj2GqU4y8Z/u4ikqHIGYTVoAmyFq0KN7TZphxv34BwhgyUSpE
	 fNFUq+NZsLJBwXEL6Lx5XKp9gxKu+d/3mq4776bdtH2ufW0Pd3GUMYgTJXv8i4f3xWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nabladev.com;
	spf=pass smtp.mailfrom=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=bouxNA5B;
	arc=none smtp.remote-ip=178.251.229.89
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1001F606A31A;
	Mon, 19 Oct 2026 16:57:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1001F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=bouxNA5B
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0F8191074C6;
	Mon, 19 Oct 2026 18:57:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1792429026;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=UZITaddrP21giufc1kS4sSfUIiVpWl6pa7LTpWKgpJc=;
	b=bouxNA5Bx+tYJ/3H1Z5iY/9t902VWE+lz84R8i3GMopRow5nK8O8s2SMY9Ojquncd0WQ+X
	Ld3jMdKvcu/Mweqktef5ddRPz5EWsPPmRFzZHzUsH2rvtxNb/7BrHgq0FDn37fR6g79k4H
	v9wpmbK7Ao06tmBt3+aJl+h7uwHXm8z1dI2FS+iIAlKkYcewG1a2xMWDxTxGRAP/8LLkAE
	t/Km2PPJLbUUgosAnK31w1HIemwyhmua3TMIYqMKje8NAh/wUWul1ar5v+4fi33tOqTgpL
	4UyAaFnH4kn9BpmwOggkz/QlI43WpWRqPWsnZquYPxiSOA5VQPHInwofvyno2A==
Date: Mon, 19 Oct 2026 18:57:03 +0200
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
Subject: Re: [PATCH 7.2 00/10] 7.2.12-rc1 review
Message-ID: <atZL34R_sN6TMWgj@duo.ucw.cz>
References: <20261017155059.698368299@linuxfoundation.org>
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
	protocol="application/pgp-signature"; boundary="7NjjSEwWa6QMji15"
Content-Disposition: inline
In-Reply-To: <20261017155059.698368299@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--7NjjSEwWa6QMji15
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 7.2.12 release.
> There are 10 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-7.2.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel

--7NjjSEwWa6QMji15
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCatZL3wAKCRAw5/Bqldv6
8qZ/AKCWO9YiGQmEkuVz6C1QI4NuYPumxwCcDLwxZ7/nYQPXlyCateFhGs3VNEA=
=J7Le
-----END PGP SIGNATURE-----

--7NjjSEwWa6QMji15--
