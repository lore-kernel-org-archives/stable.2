Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795686952;
	b=Y2yUobS3E6vciGr5OV1UwcRSEv3SH8NPa2ln/I4bL/jlYNDvMePmmPza2XuR2Kv55AcH
	 fyU3LcJsa8+rHtOSWu5mMCpm6xUyLdC8PV4mUfc8r5nwzR9BZ7zXQqfyBrDkCcLlahx1q
	 gBZ9zeXtnLnyR2E+XjaWAz7nVUjIVbDLcwCtAkucB/AVYxqpiOspnLdYYngPJKZlRlSoq
	 5Ks4jr5bRJQk5jcdLAWdIUt+ccPrHWO2Vm5u7A+RkjoPQSBRSDDj5J3/T6S0nkSN9Yl3I
	 8oFnzrsy8ozA/jyTSCRQg7IdETDGhS83D0EX3gAxmndNDyvPLLaxLwqw83VhD1WqpkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795686952;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Last-TLS-Session-Version;
	bh=zw+R973gtwQwTUGP1+JczRwZxz4UW95QN1Ei33XKlY0=;
	b=x64/xWC+lohITJgJ28Qyd5yKgWiD1MGjgkIOPyV9iSERylg6e0z/f3260KamUkVFkUwP
	 DcDcjhIdlnqfuJLXUa02a3jJ6NEvlRctMSOJ+I3bcQacInde2EBkDYFaWF6GhIyMyZ/E0
	 K84RahXmoTw6P5zPFtQEW7CJT80pXM+MNt7qUlVDBbdu9oYcIMgcnsMXxrX0/fHdPsUNA
	 ZR6upUVTbF6hcTNl0yD782pRGun+ZxPJiXfSkFqNTXhHXA/SYwQ06N5NJco6YQ1c/Kc8j
	 k7DIw47NVhlkqjkofTHrn/gSAxU3N34Ha3nK1GVjvMQ6+nSU+t8ww6YGl5i/SB32C5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nabladev.com;
	spf=pass smtp.mailfrom=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=Fky2KCzM;
	arc=none smtp.remote-ip=178.251.229.89
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2EB606A31E;
	Thu, 26 Nov 2026 09:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B2EB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=Fky2KCzM
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DF28410907E;
	Thu, 26 Nov 2026 10:55:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1795686945;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=zw+R973gtwQwTUGP1+JczRwZxz4UW95QN1Ei33XKlY0=;
	b=Fky2KCzMEBINIc06BnuENEcRuoXO5cWxe0UQQrpSnF8u8+Qlcw1lFyB9FSuSLv7pNmA7O9
	yVqjESOHN6BwtBB12DaNbeB5d/5nYVUXnRqu09xmshcdODwppg0X5BX7s6qzHO5zdaS3T1
	m6/uBTuhr95JwPeSSZkytrjze14s9sXbmqicZvmGyJBmGreFbFH3iAmos+HpsEFSKpkYpm
	flIL30N6AMn/vdaO0umAhkcMEeEUJEWvAE4OmBqmmVwbTlW73NKVlZbbTOyLu5hKHuQwBk
	rP+uPV1bv0S5RiW+zT9f36PCtfnDdTyFDENC0iWyehkvCFzkdpS4jNQZxpB4IQ==
Date: Thu, 26 Nov 2026 10:55:42 +0100
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
Subject: Re: [PATCH 6.12 000/816] 6.12.120-rc1 review
Message-ID: <awgCHqMDTNJKs0n2@duo.ucw.cz>
References: <20261125143849.205329330@linuxfoundation.org>
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
	protocol="application/pgp-signature"; boundary="L4OTj72toGPYDGxF"
Content-Disposition: inline
In-Reply-To: <20261125143849.205329330@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--L4OTj72toGPYDGxF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 6.12.120 release.
> There are 816 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

We see build failures here.

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/3114400164
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/18365213109

fs/nfs/nfs4proc.c: In function 'nfs4_proc_unlck':
3301
15:36:38
fs/nfs/nfs4proc.c:7281:24: error: variable 'cbnl' has initializer but incomplete type
3302
15:36:38
 7281 |                 struct cb_notify_lock_args cbnl = { .cbnl_valid = false };
3303
15:36:38
      |                        ^~~~~~~~~~~~~~~~~~~
3304
15:36:38

Best regards,
									Pavel

--L4OTj72toGPYDGxF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCawgCHgAKCRAw5/Bqldv6
8gbiAJ9V5MJIg+z4W1WGXq0dSEnUDNr6SQCfYfqu+TDyRQfP9wbVF3N+L/hcr5Q=
=ZWsX
-----END PGP SIGNATURE-----

--L4OTj72toGPYDGxF--
