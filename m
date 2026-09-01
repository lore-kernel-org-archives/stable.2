Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B43F376A0C;
	Tue,  1 Sep 2026 08:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252260; cv=none; b=nI7LumIX4aOSDf9xCsew+jXWVFoXGFl6lVjvdTyxLSZy5Oe8WES/KvJhhve6jHausn45BWcDqq9rkmpMM91QBRet4KBuzIdHOZ71qP43GoPMNY4+FxGzsHWdrJ1LGvzgt9Y4CP45jVf0Ji28G+XmmW1n3tktgEH6n1ZMC8Qykkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252260; c=relaxed/simple;
	bh=UQL2AvVgTYIjOeMgq74rFfWzuqcozjMaGHHKlfugnZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nnFF+AjsQzaJiSWCPG2TUtbThpIAejWlgb580/8kdN5NvvpSgFJPg8H6QD4M0Xn6Qqf4oA9yT4LSpYaMA3NZMnXM1nvcpt/Sf99YYnGN7vjGYblluBljDM/gB4/nkSIC+ZY/R2+rt0l3wpOlOF5N4uGiiPyZbrS4CMGybMiRukY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=Wgn0Ruco; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="Wgn0Ruco"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F1DC511C6E2;
	Tue, 01 Sep 2026 10:44:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1788252250;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=iim8gbQmBzCCt56y67of+3f4sZwEwYxdqZFVhThR2Yg=;
	b=Wgn0RucocANZxsy8N1Kcp33xcj//Y3O+Zl26waB9p1rr+B9q5O3hgE19VgpSc1LA83Q+/w
	m0xtoRDuxS2zqPzozQqBIrik9tVQ0yK4C+nM5qBF5NUNymTpSNaQfnO3dKfyhvG4uaQm3G
	4QM1TkHGFHGohZP7KQfta8lmPVzhV6kNofddj4IQfP9SEM1ex8yOrXScnwFzQRUjSIKPtV
	3UStbiL8IZbq7CSrNV7J+Ph7O/tXuuFmBuEnnjTJbwtJ1ivqSuxmGZa05quci8H5+6NPBh
	dA5My0WcrRhJlrja2tMw2QJQyIM/B+TAKxTo1OC0meadLjiwsGm36I1lh87NtQ==
Date: Tue, 1 Sep 2026 10:44:08 +0200
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
Subject: Re: [PATCH 6.6 00/91] 6.6.156-rc1 review
Message-ID: <apaQWFJjN8s6QKDP@duo.ucw.cz>
References: <20260831133359.468089036@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z9FRtFhKS7hIk2Cw"
Content-Disposition: inline
In-Reply-To: <20260831133359.468089036@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--z9FRtFhKS7hIk2Cw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 6.6.156 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-6.6.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel

--z9FRtFhKS7hIk2Cw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCapaQWAAKCRAw5/Bqldv6
8qTaAJ9Ua7uH3fIg7aHLxEUJUCNZf6S4kwCdGwicf0BrtfB3j/nglW7JGweC3hQ=
=tebh
-----END PGP SIGNATURE-----

--z9FRtFhKS7hIk2Cw--
