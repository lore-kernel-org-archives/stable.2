Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792876695;
	b=Ca1zzmoCFWzPQGuZ59BVQv1YU8iIZTSS56fIT2e2zKLaYAfgQNG9gd9eQu+/eXiQTV36
	 aKbOK6hCsC2+WuR/pq41p7pACdG7IhJEMp6BWeF8oN4QP3IDBeAxrWM5m3MvHyIDDdxv0
	 g7QQXnaTRMr5pyZoKSyFuJ6azhQYAdUqEHq+kNEG5suyBODvmoC0zCkX/VGIsmo+1I4o4
	 n7HNxmuvSLnu61XNKOH/1nKGk2IaYUBKROcW4fO70qIZLSVLf+nG4NeBR+Xdg6GuncoMR
	 lbx5FVInOLiVJsk/hc12UJ3XECWQ2rH7h1jcZMU4FuqHz5J0ynYsxRfLkuAj2glQayg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792876695;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Last-TLS-Session-Version;
	bh=cOf8mESgib9f7hKUDZCeOJ5JbQGYBRALkXWDWw5jEGI=;
	b=kEESloA5EHDMSVuEvwN+aLbDkcsyqExBjEpd8Tnsm3ldGhUOZ0g6ebZ3fJZh99OKNiSq
	 v5+JDXn0wmwjezpOqSyF/r8eED4VH5mzjcvXvF/P6ChN5a5wcRS5Uz94CATvSUI2ClDLF
	 9Cw+76VRL/KSAc3umGVcONFclE4X386I7HgGvdwyoraAPhgKZIkvuKef6yqRJOFi+apSv
	 8SCjVQor8MuItEnksIGMgXjQ24z424/6nhcETYIXld4sQ30KAN+Dqe7gu8V9ArX6oTwpA
	 0ScAQpBK6Nzdr/2ebp1DWpa5tKw8EeGbWiYHbli3KQcO/KQWuRm1Yw0NeWTBKQ3dA1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nabladev.com;
	spf=pass smtp.mailfrom=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=ehWmSUtC;
	arc=none smtp.remote-ip=178.251.229.89
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659B3606A31B;
	Sat, 24 Oct 2026 21:18:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 659B3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=ehWmSUtC
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AA9BB10B1D0;
	Sat, 24 Oct 2026 23:17:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1792876681;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=cOf8mESgib9f7hKUDZCeOJ5JbQGYBRALkXWDWw5jEGI=;
	b=ehWmSUtC/KEwXoHrB9tUY6//BARDJeI7E2u0GFWvURDGEOoYH/j6azhj30uaM0jHQ+VbT6
	8Z9RLzE9AZfzOSqcChRULLsDWORKWx91aBkW4GMl+afHzAVDU47NoCboCyGbcoSxD0IN3k
	UzEk36Q2RCYmNlm7feFsqFp3JlRCOBBCW3TgSAJu4GDoa4LLyMkAk0Q5fFcs16aGJAwSkC
	w60/ZW/O76nVD7qQ6JLeYbxLvae45F4RlPvP3CAR6XVUVJQme/06Fu+Ty1FVMr+WfvjpWn
	rDim8J3fR00WgEfCq9OAmgS5iXv3pGQJRFLraLzzkCAGozeWA7rtc8fjYyMZRw==
Date: Sat, 24 Oct 2026 23:17:53 +0200
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
Subject: Re: [PATCH 7.2 000/243] 7.2.13-rc2 review
Message-ID: <at0ggXGMXopcKNy0@duo.ucw.cz>
References: <20261024064731.125251200@linuxfoundation.org>
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
	protocol="application/pgp-signature"; boundary="wTbJHr3RXeTqtFkv"
Content-Disposition: inline
In-Reply-To: <20261024064731.125251200@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--wTbJHr3RXeTqtFkv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 7.2.13 release.
> There are 243 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-7.2.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel

--wTbJHr3RXeTqtFkv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCat0ggQAKCRAw5/Bqldv6
8s2OAJ9E5C17dnUuf8ESF5U5NmJLCMkwUgCffmCnjDuAPUB2klgWwzB0HAoT/qo=
=7j9W
-----END PGP SIGNATURE-----

--wTbJHr3RXeTqtFkv--
