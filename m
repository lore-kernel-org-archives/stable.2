Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793268291;
	b=yILYtWNtAeX5bCgnH/4yArld4gQOP2RMFOjig8qTSoW5Ea82BCUXI9k4dyBYhyVCnMRi
	 WljMKqT3jBNgtMnCBFVngDMH7lepv1zy1R2/47U6si11OY4DuCI4h0HuuyS9pQN5L812u
	 f3up9HdB1+2Vs6F0ti2yT7jdTEFMYPE3StjiEF0SfWv5HIX1WPIRfJ365AXoGuV82dSy+
	 CcyDkyuJnCyNfqcCKiqQZU+LvRCrXhfYB4IWHGT+u7OeEHqLZYbfYUXgVMgjAiLpQYj2V
	 OjU8uOscQfZe+xijXiSsrJ6mVeZXqxNMBNGax9TRsSJW5gac0PAETacY6DlYUWvQ5pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268291;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Last-TLS-Session-Version;
	bh=UcZhnuPJtXeYwgg3fwGjrJNdb2UtBfX0hISrVvvqQs4=;
	b=xpqrvkWegJRLt1jHzvisgI7KbFGKykMi/Jc4+jiyWZuVVJLjABWFaYjCyxn+yVz6H3ZZ
	 dvYi7U5Vymu4GoomZg8sIpBsrWfo1cMmPPo13+sPw27Uf8//tn3GiMGeH3b9YTcWw6kcu
	 2wGrPrh7W+KlSqW9/I7H38SiNPDNjOlWJadeDBRqKcrpqhpqhzFO0bFHwW7pR0i9DwNkm
	 AWCkA+HM3Z5LKI78IrCquftTUHwZjL6zzflXRwZLjesdJmtW/8hWGZrVqq84Pu3L1H8oL
	 xaTnsxxPAaAbIfKrIvEVQt/EwI1XAHCSza6RpUuTg1V1RVGGXVWa6ma2Qi9qaxHoeQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nabladev.com;
	spf=pass smtp.mailfrom=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=A8EEHosi;
	arc=none smtp.remote-ip=178.251.229.89
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF82606A31C;
	Thu, 29 Oct 2026 10:04:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FF82606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=A8EEHosi
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0765210A8C7;
	Thu, 29 Oct 2026 11:04:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1793268284;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=UcZhnuPJtXeYwgg3fwGjrJNdb2UtBfX0hISrVvvqQs4=;
	b=A8EEHosiNKzMrhpvO6G5nhbMxnLPsahuNA++Zwe2PUrGOSQYXkyJgnldjwWs8Gkk5fimVb
	AXpAKRgZb1HN/3gN00B+sK8lMbWpmK4RIq04I0GC+x7EM++AKEyDdDSsm1DNq+9qu51rHK
	fwrUrcfN/R9cZOTp4ilp0Ay0tSCLCzEjY0XgbbqFzUepAmUnXHeQ1VxJwTHyBA6EgxB2oV
	PVi0b/+r684GOAarI8r1YPtKrhiHr+lXpcCmzeIrYnDPeJdqxzyolCRxXaZkC/KATjxUzp
	8Kx6ZUwNHdk2POkJoGy8cO4+MOkQW7brVuJfwbD50JdJ1YgObwr4H/FIppfzCw==
Date: Thu, 29 Oct 2026 11:04:40 +0100
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
Subject: Re: [PATCH 5.10 000/516] 5.10.273-rc1 review
Message-ID: <auMaOEApb5g7PKgR@duo.ucw.cz>
References: <20261028170003.522232767@linuxfoundation.org>
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
	protocol="application/pgp-signature"; boundary="l4SxPlqw4x0U+X/O"
Content-Disposition: inline
In-Reply-To: <20261028170003.522232767@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--l4SxPlqw4x0U+X/O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 5.10.273 release.
> There are 516 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-5.10.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel

--l4SxPlqw4x0U+X/O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCauMaNwAKCRAw5/Bqldv6
8pPFAJ0UG2+W92i2HA9cs0SOgACv8jTdAACfaWuFZ8QsRDoZo5uqpovnaKKe2V4=
=IciF
-----END PGP SIGNATURE-----

--l4SxPlqw4x0U+X/O--
