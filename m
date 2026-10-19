Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792429081;
	b=hRUag1c8jPFq27vbYSjfH5NOQZ9sTX+Zykd1+Ytdt4pkxfdVCuk6baxp8rWdhlJAvz/4
	 d8tKeA1/GDEaGTXtpwyIhV9ymWV2jQ24tsHRAi2UCLf7RAVOSc7SmDkbEG+Arjgl81A+9
	 nBnmxBR+9zitk6GDfj86WNnO+GhLqZhUMUtqiJhG6I1/Vndy22OX48QouUEpe0VodVa1O
	 5oKA5bwfwmLctHLXjDwK+YyzxNFySvJOM/hEBGFs8KDPewil15wWqJnYlc/IJvcBkyHZG
	 dQ6Ip+C2o48czrwkFIeLPi/fquTXqPK607ZKoM9A38B2kNAEuGl9eXZjcnHHUAkUI0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792429081;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Last-TLS-Session-Version;
	bh=iStW2gtmFZ94IqFADcqGvldlgQFT0UA+D8ygwsOiHws=;
	b=yWeL46ydFzul/qTL8xxHG6I/SV/k1jL5ysu3cN09NLFQbIdrJpMPH9P4r5bTl2XcgNJr
	 lQ3Htc1uCjgEfhvaG895mcEZaTaxsdNRSSQNNp2zvhbq5dNaFjQYM5QYHgLv8gX3kJcMj
	 AoSYZd468jRsehn57bGwI8FT4h28lK0bL3wYV27dBYokDCzU3TCUL7jNIxzpDAfhXwle7
	 gk0lyr+3exx20HX3E2IcOOwo5Ybnt+L+AYZb+uRGdbDjVKGVK/2qU+e55BsyYHBJtaGyE
	 xCiAbCcclO92PsIQT1FMmgK8Qj7cM4bdfefxFNbC+mII2CmK2gwf8YKKTICybWwueAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nabladev.com;
	spf=pass smtp.mailfrom=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=YZDvRKr6;
	arc=none smtp.remote-ip=178.251.229.89
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E188606A31A;
	Mon, 19 Oct 2026 16:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E188606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=YZDvRKr6
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D613A106C76;
	Mon, 19 Oct 2026 18:57:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1792429075;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=iStW2gtmFZ94IqFADcqGvldlgQFT0UA+D8ygwsOiHws=;
	b=YZDvRKr63J7qd3J75q3t2mTaeBa33Gf8LzM6KxogRKrLZf/X+r5jf8Yv/TZdFpKUoQlbAB
	7KOzuwgtACsHCsT+1bjX9WQi9SW1gvM1bCV97/T2W/WqGlOdoOjz0dzH+JPyXIMKwCeMh1
	dB5c3q/ZTv1d/WHfFFSAszIKkyuFeoQFxGWia/bnOftVOPZKG5zXc5kPTfk9x36py2FxLe
	ZzRuyFnVWTjrOdCmeDbw3Z+ABJpB0QP5Kw8rtA+C9t87hy3OFpLjKuxV31BJeKIiwr6oKO
	jimA1r4oaouBmK8NtV8ejflR21FvAe2x8VzVTQTqtSNxP97U672DCWBrjL5iiw==
Date: Mon, 19 Oct 2026 18:57:53 +0200
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
Subject: Re: [PATCH 6.12 000/869] 6.12.114-rc1 review
Message-ID: <atZMEXAy1y-2_irw@duo.ucw.cz>
References: <20261017160036.979869304@linuxfoundation.org>
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
	protocol="application/pgp-signature"; boundary="ZdM0yZJQjbv07ct6"
Content-Disposition: inline
In-Reply-To: <20261017160036.979869304@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--ZdM0yZJQjbv07ct6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 6.12.114 release.
> There are 869 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-6.12.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel

--ZdM0yZJQjbv07ct6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCatZMEQAKCRAw5/Bqldv6
8lQSAJ4uHtcHc8+sXe8KZxoIXXqHvN7tmgCgvZOv2/UbTnxWlXJgKCYQQgrvjuI=
=irlT
-----END PGP SIGNATURE-----

--ZdM0yZJQjbv07ct6--
