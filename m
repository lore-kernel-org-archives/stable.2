Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795779692;
	b=xn1BtiY84dP52twe6Jon7AQurKD97fGS2dRHhEg4cGyILZvjw4VcW+JA2XYSaShPh0zN
	 QSswK6jsGYiN/Ro7eQHACDFE9aK4tnr2RNrL7ccZm3xMvJwELj85Dp9pKW6DszpY3RPIO
	 VjC3inxp9Og+IFLOT3rJIQ5bt0di8OhciXKt8zPbKIl66G0mM8iOacxrgAbJKA3l/6BTq
	 MXVT5LKOogLF3Gof5mB0C7dL7WZkgW+yUH0zWzQXP8UIawEHcls3opcpK80X+GQKq2PRn
	 cTk+tuUOz10SDfPBz1Zn6fvaTW9jIFJmujiXq8eRotId/SBfenRs75PN5RZbyxJPmbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779692;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Last-TLS-Session-Version;
	bh=PEwKN57fXayam7QpW3+EgVkiTYhAsGK1PdQ9117BmoU=;
	b=T/r5RecDNrr/NK2TnPYIm4fSwAvO9nns3SyaNmaPGv8JorO3Qi/1z7vnVx3fvZckjz+t
	 WBTCvIAWRbklb3Y2jn5SCDkVfcoNKtP4/Xkb5YQwGRH2LI/Ti0jHpOpxsj7KJOEgTqTaJ
	 MzJNEyHjUCwtSq4yULQzHdode5K4KHNnqsWKCR87kfDsOOscgW0TSE/yjBMNkacV+bUbe
	 x1oZB1uB24hdvzvYg2RId2neWYalXmVxU75vrLk7p58f3+CWdgJ4DnS0WpmmdEPItqqih
	 eDIo2JK4+rVhbzCCQklR3KR53PdHBLykyiihYlUrq/FTMtcdNTbzb2y7MNIpLhDsBFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nabladev.com;
	spf=pass smtp.mailfrom=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=Tqfejkq1;
	arc=none smtp.remote-ip=178.251.229.89
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947E6606A32C;
	Fri, 27 Nov 2026 11:41:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 947E6606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=Tqfejkq1
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0632310A1AA;
	Fri, 27 Nov 2026 12:41:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1795779685;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=PEwKN57fXayam7QpW3+EgVkiTYhAsGK1PdQ9117BmoU=;
	b=Tqfejkq19wigcjRH6gjMuhO4L0VIBxD16LbNHeiTki+f82dupBnGP6aWuhI081emropPS9
	VOwdD/4tnWduEmwflZy3eAtrJT5W8ZyHdWI7mxQGf4IijyZ+X8ESPhZoicB86Ayccgnjze
	xksoXnz8Zliak8hqX1r7pmrrLUcyGdE1rX74mKIg4+w0OFbBQcOMygp7hayjipFZhp99Rd
	ctvculvpFu0q3QzKXTJ0TgZlJ2cz+DeAOoSqWo04wPVo9KnVVEnGV0ptiQ57I/+E0793f0
	GL3uabhwP9/TsmqwxquzrAC9PU4FBUH4aORB5Qknx+1XrJwA7MJoitad3/0XDg==
Date: Fri, 27 Nov 2026 12:41:22 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chris.Paterson2@renesas.com
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.18 000/990] 6.18.66-rc1 review
Message-ID: <awlsYiN0boZsl_Ag@duo.ucw.cz>
References: <20261125143822.072087159@linuxfoundation.org>
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
	protocol="application/pgp-signature"; boundary="A5yVwwMuwHiZwh2Z"
Content-Disposition: inline
In-Reply-To: <20261125143822.072087159@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--A5yVwwMuwHiZwh2Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 6.18.66 release.
> There are 990 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

I need help here.

I'm getting failure on qemu/arm here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/3118612432

It does not go away with retries. I got similar failure with other
trees, but there it went away with retries, so I assumed it was some
kind of testing problem.

Best regards,
								Pavel
--A5yVwwMuwHiZwh2Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCawlsYgAKCRAw5/Bqldv6
8hNDAKCxjTAij5oIiRAHPisDwnO1v3dX0gCgwEX4MCtxHDEJxoqQ2NSSjl9lWyo=
=QbE3
-----END PGP SIGNATURE-----

--A5yVwwMuwHiZwh2Z--
