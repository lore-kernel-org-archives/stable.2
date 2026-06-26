Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3FA3DBD55;
	Fri, 26 Jun 2026 11:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782474297; cv=none; b=J/hYSGLCISV0N03WbQJYey9aAp49Nn0i0sBK18hT1v5eGucso5VDHsmN+waW/SgZB+SLO9fb9UGQR7S8PONSxopJi3nYoe+ym0xbRHauPrXOLqqfid5XemC62J7mlpyunrrn2NTmI81uJlp0UVPj3eg+tkdb54z/pgqVCWPuF/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782474297; c=relaxed/simple;
	bh=TjOsQk8fELsZW2uj+46KbkV5sOFDaVPfr+7+FHCv6jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6a+NOY3AvD8pYkUuiNNJ3h3XmxPcTi9+IIv+EEXRhYwqyqN/E4jRxM65hYB6WjrbarYb7RKYoNZfIG0hG8CBzTUxD5590UuvxAlv0sJS++bZuvXaIR4iMpOnA9+txBVUkLNWyzeTvF4Xewq5O4dvVbhCimgNTunjYvtlAWL5hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=EcrkmsYH; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="EcrkmsYH"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B28FB117E1E;
	Fri, 26 Jun 2026 13:44:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1782474292;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Wt9pwN3xvqQpYzqex9ofgxGr+gijVC/fPTW/JNx/IHo=;
	b=EcrkmsYHddiAEU70gAqxc3MMKcQoC0/H7Y1HvM3E2QtzxJ7WjfM2EWeEd2wUTkbfE4HGaj
	WPU+/HaJxy9XL4LhI6PKYtFEBy71xBoq+uoFnp/GLqQwimADVNfz8V8FHG2cwvsJFinqZO
	VbTL6ikO5LN4M4/f1T19Ta0UKEageZh5WFCBksty8ZcbLMb8h9idbUGu2ODRWNZVd3ip87
	L7ro0+UKTbr0UVY/KXitP6r5rezsFpdm1VLEeJbqpOZ8ARsqIkHNDXwPUqv5ohDEjAhW6L
	D1eUFl17Bni2iqCpuZDxrzhtaO6sRRyMQotMks//pjeJdfXe0O7InYpgdnzlLw==
Date: Fri, 26 Jun 2026 13:44:48 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Pavel Machek <pavel@nabladev.com>, Chris.Paterson2@renesas.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
	achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 7.0 00/49] 7.0.14-rc1 review
Message-ID: <aj5mMP6X3NUx5XZM@duo.ucw.cz>
References: <20260625125637.527552689@linuxfoundation.org>
 <aj5ho8stx819px0w@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2JL0oPREIppCv6AO"
Content-Disposition: inline
In-Reply-To: <aj5ho8stx819px0w@duo.ucw.cz>
X-Last-TLS-Session-Version: TLSv1.3


--2JL0oPREIppCv6AO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2026-06-26 13:25:23, Pavel Machek wrote:
> Hi!
>=20
> > This is the start of the stable review cycle for the 7.0.14 release.
> > There are 49 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
>=20
> CIP testing did not find any problems here:
>=20
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linu=
x-7.0.y

Disregard this, too. For some reason, this release is not yet tested
on gitlab. I'm putting Chris on cc, perhaps he has an idea what is
wrong there.

Best regards,
								Pavel
--2JL0oPREIppCv6AO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaj5mMAAKCRAw5/Bqldv6
8mkQAJ92aRgjtp0fJ0vqrTaBBMsbZnesbQCfcDvRlNFKYVT7jllVgxTbH4XKXFQ=
=4fPg
-----END PGP SIGNATURE-----

--2JL0oPREIppCv6AO--
