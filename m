Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9708F39478C;
	Tue,  1 Sep 2026 08:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252357; cv=none; b=mxAVF7OVT+QnzLB7akkcgbE4CGyEpS+xeViqcxuEAZN1U31CTH8Z2bm2Hf9nVHavvlS7tcNQryZjvdAF7AGpMv9uiJYlQInZHN0luRVlJ5cuYtbHMN1l9ctyMYowH8665d8dB+12iVArKkSmBb2MqfIEYlmACpEtosWRg+InEAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252357; c=relaxed/simple;
	bh=P/Wt6OresFFtzs3cX3tiIjdNBkeXgwYHcLowe1qXnEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTME9sXK+0Wn0WZCaHDJ3sNgce2R0D2DmA6+Ri00EgdNag974tr3kB3B5vRRLbsY6ej3gcmqBMrpAZDWcoNzJ0h+ArxtHkNM0JVlyUI8ZODrYytlco3QdSBEOEaoJO0KyiD/khGhFEl6ATq5tvc2CDWJZDXVjh7gYOL7a+ZhXuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=fHcMm4P4; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="fHcMm4P4"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7A26A11D41B;
	Tue, 01 Sep 2026 10:45:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1788252349;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=HH390RYj9E29P003J+jhRkRMBDXvEoH2rYCH+sN6G/0=;
	b=fHcMm4P40pV5JXgcZxOVwCBUcYwYbqI2EJzcEKkBz3yDIHYXwqPJCjgGe1Zbs09MTjKo/P
	hxWEfHZN+3NEMOIIwIMy2gVeyGSmWDgRssS8a+46XTtwLTasPyatKTGSQlGDCh5Q0I4yZO
	hH/2SONMvdGUEXocAgFk+1p+7WPi+WnQMYFlS+bWqS1Qnh45dMKX3Fm4FfoRJybBcv9dMU
	/kYzZ36tD9STl3pF6xksoGZmvVvyFsR7q54whOFwM02ykKbODYtaLybZfzgU8L2ccc0BwO
	iWeNRyatovCml32/LJZ6ZEYZRo6En00JB3hTzuK9xb0GMIhzPDBdDXOADsEktg==
Date: Tue, 1 Sep 2026 10:45:47 +0200
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
Subject: Re: [PATCH 5.10 00/43] 5.10.269-rc1 review
Message-ID: <apaQu-YBYBPnWys2@duo.ucw.cz>
References: <20260831133358.571886287@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TY4zyIrAs5xgFf3i"
Content-Disposition: inline
In-Reply-To: <20260831133358.571886287@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--TY4zyIrAs5xgFf3i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 5.10.269 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-5.10.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel

--TY4zyIrAs5xgFf3i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCapaQugAKCRAw5/Bqldv6
8h2AAJ9xGf/B0T/ArlUDhM3FzJlxCI/VQwCbBJjKCDqoNsMqZ/msd+3qPn3O6Lg=
=nOF4
-----END PGP SIGNATURE-----

--TY4zyIrAs5xgFf3i--
