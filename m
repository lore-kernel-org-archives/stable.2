Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892649;
	b=2m+PGQKFUeQDl0DQdWydn33OBA6QZdTZ8vE7HhV/k3Zrfm/p7a/XBTqJW1fFvK0rZQPC
	 uhe6bSlj6LADyLBbyhVQ0SdqgbF4tDe/JM3i5yNskpmZkZ53UDbShvrf/wtsHO07YSgCi
	 /U9jWnE5IMeMlhv6SOP6QfU+Ki0CWCwZq1P3HTcd/LytatjaQxCoV1JmzchOOWHwlkrlE
	 NOtiq+Cup+nm96iu7Q+hX0D7kBDMzuuJbLaD0AeK/xjT20hOyuzhBvT/Lw7Wa93Sy0W4D
	 YaH2KeRmF/dls6RAl22EofebgNzIOC+6Ooy4ZgRsH+RwrilurZhFYJyBzQezo4fMTmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892649;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Last-TLS-Session-Version;
	bh=f8xh5bzAH5XQe8z9ZVc8M1CWJpyKdDV4FlFi3SYW+4w=;
	b=FSiX7cTY8D0fHAkmX5Ei/iqESHYMT3k2MeyAyCACLxnskIW1ifR0olAOELb3+h+5By4I
	 oZZyUFwXDt9Inzpek3IMoURb5Sy8VFZHHJNPXRmv3gmU3jv97u0rN9EE77vRb/dbqHCwV
	 dZxZUMHOcB2y+wqODty2yxwoi+2C/U6yypDkhiVX9/Tv3ildv8XxRbdagGi/G6WZ8gj8R
	 H0aIswsz6f6KDqISdGOdTy4tCzd5//f9i4WbT8YRQWKJasCEgmWmN4mBFT9roQzAJGqpl
	 xvXoD3UXl8bEQIW5/pkAM67AYUWzxBnQZoKivyIGvDwO460ptr1vXdvQsd6YvH7rTOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nabladev.com;
	spf=pass smtp.mailfrom=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=RfZ5Wvdf;
	arc=none smtp.remote-ip=178.251.229.89
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA14606D813;
	Thu,  5 Nov 2026 15:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DA14606D813
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=RfZ5Wvdf
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5611C109A73;
	Thu, 05 Nov 2026 16:30:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1793892643;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=f8xh5bzAH5XQe8z9ZVc8M1CWJpyKdDV4FlFi3SYW+4w=;
	b=RfZ5WvdfgSXEeaS4JJxfdYOlTu0bETlMG+5AbMiQIPiFsZuMU9a0WU8oEmwLEJNwT4UFMD
	xiVT8eOcgZSXkiRMrGvEjoS5SmGoPVDJI0p2Iz17DPcejDKVV1kzqU8aJCdwOwI2EsObIG
	yP9zNE7qKOYYx5ISlI7iax8lJMQDGS0JlgUS/3mkGOsv3anS7BnEP5TYce6CeBrAw4Qi0T
	5s/0pn1K9tl6hkz3EaFe7xQ4uvXWRafmxR71Rkv7zOGnlwS0BfWD3Vt88HLt5ttHGPsTXG
	zPQ27baixfzCZ8PsV2e/0B1tkkX+6n1EnTv4V/ufoCn+niBah/9ddrgp1nWXZw==
Date: Thu, 5 Nov 2026 16:30:41 +0100
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
Subject: Re: [PATCH 7.3 000/547] 7.3.2-rc1 review
Message-ID: <auyhIbZA7ZzTeI3J@duo.ucw.cz>
References: <20261104211038.406938024@linuxfoundation.org>
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
	protocol="application/pgp-signature"; boundary="BVw6sPI2AcgAIiJV"
Content-Disposition: inline
In-Reply-To: <20261104211038.406938024@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--BVw6sPI2AcgAIiJV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 7.3.2 release.
> There are 547 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-7.3.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel

--BVw6sPI2AcgAIiJV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCauyhIQAKCRAw5/Bqldv6
8noqAJ9cm/wjagTcTmDTJbp8LIwX236JYACgiM9KuK5EeN5fYeHj4L27qdkc/C4=
=tqxo
-----END PGP SIGNATURE-----

--BVw6sPI2AcgAIiJV--
