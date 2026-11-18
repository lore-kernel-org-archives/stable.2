Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795021911;
	b=n1IFneC9OSPno9/wra5WNRiaErwRRZqU1gdAz/Q7RcsN6qggGSSMHIOndgFJtCi5fPGR
	 ELX4IVmhJst8ps0Az3InBTRq8em7OJcar2sR49RdzvCd9EqIGmnboS3f5kV2/G/eS6UxI
	 4RKp534yCrOkK6iCsNp660+2dlzi+ru9yyYBJfIrU7x0Kd4fQtiWngvDoIcQ32XU6ExOF
	 65zOiWq6VA/DaSQCxVPhUzg2mRBBZBNCBFH44fv2OQ/1cR1N+xgWrlaUPqqK2IuvFsOuk
	 AEhSZhSCYlt0S2BAXIXWprrnuAbiZw64TfyWtwthlAeDPkAfrS8aMBnOuo7zo5JhhdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795021911;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Last-TLS-Session-Version;
	bh=55hWbv3ahW17b2iOOwscIBO2RQ8epSsBo1FkfhM4zo0=;
	b=fiDrs2j4wkjTn1F5QA3cvMRCJXHhmZ/Rr7W9F1bXl8c8SaKYKFgFJUn6G+pF+LF1Je32
	 PNk5GR9tWQ+7n6AFsSyXzRDPtPVZdCcJMh+4fMWxCj9p+MgV726IsasfuqqgJ/bn+7lTc
	 TyKv9FXrS9tx6g/YOGqQW3S3ax4AJ7rgFuafYXEmsdfYOncpwIPhm4WzBqy61AQ5pwzxT
	 DnxoXn30BLDftaSq7BsAWLUmztKrhamLwxxB3Yt4CQ3fDJgf7HW5+IeAqfb0Cx1vY0IWI
	 ohc87pJnb1ROm2qzSSs/aQQfPwxddVTGX4gyWRz4rJtlOMmqVDclnms+yIDN/Ae/V5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nabladev.com;
	spf=pass smtp.mailfrom=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=McTjnncE;
	arc=none smtp.remote-ip=178.251.229.89
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E80606A31C;
	Wed, 18 Nov 2026 17:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65E80606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=McTjnncE
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AC10710BA16;
	Wed, 18 Nov 2026 18:11:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1795021904;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=55hWbv3ahW17b2iOOwscIBO2RQ8epSsBo1FkfhM4zo0=;
	b=McTjnncEDdCNvrpd87ixynpCyAndkyYKLVNAJ32je6Eb9VEdmhg+/qXfbJUr3ZrjBSHw1D
	JcmgWbcwt0sJ7LIO8gigByJSVzjiVu8AfDGeyAm0m9tUcepKNEhn0X4bSQ4P+CZL/QlYNm
	Ra10zu/nGp35YTMjgzUFUxwMEVVkDE5UCtIwO96476mmQb88J3Esj0dZQoscomafhDeDI4
	GTpDgT2cR++TRMIMWXpjmqKN7kitFBAv90uHTTZT7F62ROuPPsMxIZD9PvRC1zRdZmKAQK
	a0xdGQ5Bldmt7GFmkPhCNGYwghWiM2948M8GGIhza+fNsj3ujeNy5YMdDKHMDA==
Date: Wed, 18 Nov 2026 18:11:42 +0100
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
Subject: Re: [PATCH 6.6 0000/3318] 6.6.163-rc1 review
Message-ID: <av3cTuNbzz4trxoC@duo.ucw.cz>
References: <20261118150313.527275416@linuxfoundation.org>
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
	protocol="application/pgp-signature"; boundary="BfKMZaz260JFDJKq"
Content-Disposition: inline
In-Reply-To: <20261118150313.527275416@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--BfKMZaz260JFDJKq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 6.6.163 release.
> There are 3318 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

This failure looks similar to 6.12 failure.

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/18149509459
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/3084771510

Best regards,
								Pavel

--BfKMZaz260JFDJKq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCav3cTgAKCRAw5/Bqldv6
8vVwAKCiOHAF0itzIm9a92Rqx161/MIf1gCfVxJ7y7RqnougTDqOz0QZPVSmvjg=
=TeQW
-----END PGP SIGNATURE-----

--BfKMZaz260JFDJKq--
