Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795779486;
	b=zuxVatPQZVqN7gL2DCu7a6H4xuHi/qBQNwKmHqTbgU/hVTXA4jst6UKAPmNGTo620ew8
	 b4DXHgCk5htO/2bBEkhEW99QqWWkE8Cr5oV+A8NLec2SWb8ypPVd/WZ+VFPUY66nnFQe1
	 Z7Wr3oz+itQUupqBKS0W9+vaBrS8dW6q2kUZSN1Hu/6YihhFNFmXbYPPXaJbL2BD2uJEp
	 7ea3W9BY+OWZQuOavwqvZ0h6rptHrpnxa58Dwhb0ssXg/IMKeNWccQuRJvsmf0kCxNCaY
	 U02Xy4daolu+CHI9zNUivFy6f3eQIkk3/7CH+/VVy12IlinLO4/4wahdPbdA941IhRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779486;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Last-TLS-Session-Version;
	bh=Tq4F0Eq2vjlkwyqOn3adEAVZInM3B87MkHau2yGN/+s=;
	b=fi1H8TsCJmdFvP3KcDL68ZYFC7U9GSFtGCo0QtPqjx84ME9NGdWIuvOkJ7nr2d3WqwCB
	 k57NLH9+Z3SHQtOhi/rHyViCPJfakFej9BKmILWXtcuq+S4bLL+l5Mec70z2KQ0W2Dj71
	 5HEI6AxxUshijdLtmCGApsvAnlj2+/jgj1HYlzNza3YDMFC/kxFFHtMR2cWmL+sV/AMPR
	 VDbJ+DZYvLhsSGzh+BLwNvbHG2Y0njDlJ9sxAWoPCGBvgbB7fHcdy7sffBCAuhkV3nM58
	 xTvFcu9o3dHjtXTOYjymt5i+dd0LM9qr/k0kcvX9CxXcU9nd5PujbxVYWF6elFI+nEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nabladev.com;
	spf=pass smtp.mailfrom=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=VMOVOokW;
	arc=none smtp.remote-ip=178.251.229.89
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE7A606A326;
	Fri, 27 Nov 2026 11:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CE7A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=VMOVOokW
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5A47710AB1B;
	Fri, 27 Nov 2026 12:37:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1795779478;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Tq4F0Eq2vjlkwyqOn3adEAVZInM3B87MkHau2yGN/+s=;
	b=VMOVOokW/GOaK6BD59DNVzcnSiEli9UqfauMiIfsA9azAWjv83LBJKnb0+qpJ3iTHQU9g4
	6OzNBpz8eI/b+TY+6G/BrmyMadbOXQ5Y1rCFcyJFZbFM5olxmqAZj29PSJwHddKNWMnrxH
	Ei36yqtnPxy87GFR5YiQdZgv7zgV1+ivxeyKc0AkXEgXQzNGuKfTyJGawyT0hJh8XPKnQf
	h0kF/92A5L3rnju7Bq/AT35juz+SFtYt0GhVmN+8DxAWkhHs7sGRs4yuo4yKIofAhXSU69
	So1NDuWNneG6qWwXEQY3YUXAGWpv9nSbrQzXh9YgoP/aa2q5dVxDF/NnIUuBog==
Date: Fri, 27 Nov 2026 12:37:55 +0100
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
Subject: Re: [PATCH 6.12 000/815] 6.12.120-rc2 review
Message-ID: <awlrk-W9w4vQ1aQU@duo.ucw.cz>
References: <20261126105709.009001842@linuxfoundation.org>
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
	protocol="application/pgp-signature"; boundary="JvoJi2FzZ8mnpaNP"
Content-Disposition: inline
In-Reply-To: <20261126105709.009001842@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--JvoJi2FzZ8mnpaNP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 6.12.120 release.
> There are 815 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-6.12.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel

--JvoJi2FzZ8mnpaNP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCawlrkwAKCRAw5/Bqldv6
8kHWAJoD/ySmUF+M1R55RPGSfemykUDuTgCdEQJZpLlAIU5q6KBmA4c9lG4Istc=
=5C5f
-----END PGP SIGNATURE-----

--JvoJi2FzZ8mnpaNP--
