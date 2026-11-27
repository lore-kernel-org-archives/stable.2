Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795779441;
	b=ufilrrUV+6KG7sEMXOU3UHtbKXdVR1/Ou/kJC1Ecq5+GT3NjbcyIqcj43mKfHd1S7QEN
	 XXjaC0LaZ5MYCNIQ6Mxy63DHT+E70y4JJXssphhkdTlS13pDYF2glg8SkWiBTnAo3CGrx
	 T1RVBzalUGbbBKlwEbQrOhE17foBMAa7riD8CdLchRo5CAlr7026plhfEFqGwLgbroA5p
	 ny/9uY7z7/VAUUkdYg6xkoHSU5eFRfxjMfCmD4m1MjWCfuvf3fL75VQJ57YjEmbZDnPii
	 hkFWKTtpl3yBZ6dz80xAer8N9zTtxGiAEg9gQ2+zploUi8Q+/LJBpuQVuEHjtwfkvpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779441;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Last-TLS-Session-Version;
	bh=3q5ApM8WktUE9IkZYWmOP2hMeTSODz8wONx8qHbI4pg=;
	b=Ujq/BAK7xld5YZ9EL2Lw9Xme5De8IJgVmaRIboQ1xxojjCGd4UC7d9hd73L4RqWx0NiA
	 NDZUSIW/3zwPF/wehbaIC+VZimWvrUtOp2diiGNG/7PTtDbkI/Y7IMyiCfn/1PEk7+obi
	 i9tHLs1NX/Kst9IdQqcbopmG9kdOZTm0WzTXEUMZh4H1n/EYek/DsI1pejFkOwn93rRyo
	 7oM2Ow4tiG8IwhVM3VgM2MNV1Tj6N1p7boPwPsKoeFz1r4vcrV6XkKa8RmXSMIcrG+rif
	 lBIXJP5Mb6nUM3FSE34y2/uIt6sVwZe/Dm65tf8cyLmCvLhHnyhLvCiDJuc2kuPnlqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nabladev.com;
	spf=pass smtp.mailfrom=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=J6vksQMv;
	arc=none smtp.remote-ip=178.251.229.89
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44AB606A31C;
	Fri, 27 Nov 2026 11:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E44AB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=J6vksQMv
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 54F4610AB1B;
	Fri, 27 Nov 2026 12:37:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1795779434;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=3q5ApM8WktUE9IkZYWmOP2hMeTSODz8wONx8qHbI4pg=;
	b=J6vksQMvV33ikptLVFeCswmmc+y5SgXiAIDuwB48p13O9dA9OCIiqc6fOhkrFYbBJslUyp
	ZOeLyblsraDUSZ6LmJU7yHHL1OknAqshGZQP8x0BVSWXLQzrKU50UdXB3mjD4D2r9ZDcen
	jLBMh65/YRceqh6hxDdV7M5qHD/cERR/1kJtOkzmppeHMowXdT5DP0XCoQwM3N+ESK2ena
	md5ljxu64FKATTGTzSYNQfI58mOqaVJToid1Z/4QY/9mHvXNDUusALHAwKAZOfmzyqeGxq
	lr6oHUpmHJenifGKwLRFEfObW8tZg8LuDWd/ctyE5IbIDfGn/YkW93jv3waXWQ==
Date: Fri, 27 Nov 2026 12:37:12 +0100
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
Subject: Re: [PATCH 5.15 000/318] 5.15.227-rc2 review
Message-ID: <awlraBknK5kgEyHs@duo.ucw.cz>
References: <20261127052515.841545444@linuxfoundation.org>
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
	protocol="application/pgp-signature"; boundary="Tb6Ne9dYHzdTQEK0"
Content-Disposition: inline
In-Reply-To: <20261127052515.841545444@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--Tb6Ne9dYHzdTQEK0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 5.15.227 release.
> There are 318 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-5.15.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel

--Tb6Ne9dYHzdTQEK0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCawlraAAKCRAw5/Bqldv6
8sCMAJ4qfXaaA6hyepE1tk27JBVs3wDLxwCfdAO/St4Gn5h2J3EneJW6sxiPmt0=
=wVrc
-----END PGP SIGNATURE-----

--Tb6Ne9dYHzdTQEK0--
