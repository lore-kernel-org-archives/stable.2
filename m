Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794217799;
	b=ZQIZu/qqJfCvpuw04/uu3AnEPBN0dbXZ/XtOsA/lf4MmQbCaXwxraT67gxqgl1QodWbb
	 1gbCE+aCBLU9+KltQ0EZegpMpL0xTwQxELgZdN6lQX2R3bq1JXgHVHc7UlrmgjMOdZibA
	 4ZBC0/tLF5szYaEo4Q6kyYjAivAEsoRaDTOGux3rTQqyhedZ2BPVONfJMMALVNv0ausNn
	 eUSK2nhVsAwAuIxL6PIpfl75zb/qZ20yF7c3s/XwKFO/hamDjBUpeGYKfXPTM1db7NlVD
	 wJFnSmLNXtfjWkfFQl2/DVuMe6J8WVrfnPiC0V9AKfRHvmv0e3tfFu5DC8NQ2mr9CFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794217799;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Last-TLS-Session-Version;
	bh=c4GXWVSYSmYpFiUMU+gtc8FUYDxmXLWuMYocNxP345o=;
	b=x+wE6+M9B18yNrtvewPDB5t/ECTwFaq9eE8ma7xOP9BuNhcv+4E00W0hOLDQOASbU8Nf
	 YPYX/+SV1AtpjveCkkFxp8UT84kD60rqkx37E1SWuHgetsuJNhbS8CF/yHe6FlMohT+or
	 cu/YfYShi02bJtSt527JJCThS/m/+TiKfNVRTNKLbeP566qIYx8wCgzUgA18akSFNfvE/
	 V3szNmiuKE+4D7w8qCIDMmA0dmEEntB8ZmHYQE8CQlCQdYTFSWNVTCPxfT96djQO2gtt4
	 oMYlVnu65oIMZPFHcL6CaUjLnOa1nNygjWzblFAcAwuZybVwZbwPC6psBB9GmgMkZSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nabladev.com;
	spf=pass smtp.mailfrom=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=Z3LMltX7;
	arc=none smtp.remote-ip=178.251.229.89
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0880D606A33D;
	Mon,  9 Nov 2026 09:49:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0880D606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=Z3LMltX7
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7166510AD31;
	Mon, 09 Nov 2026 10:49:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1794217786;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=c4GXWVSYSmYpFiUMU+gtc8FUYDxmXLWuMYocNxP345o=;
	b=Z3LMltX7+m+BJtdwBhvfCmq8iM0r9z+pDfB7oDlVa5cWn1w7D+JYaDLepVso8VK2h5JXOE
	vYUx5F2EScxfpLSYE444owXgPmrCT1zcuseOWo8ziE/FYgA1px0MS+BUyP3IJ6JNOnqf1Q
	ikMT7eZrDm/P5+Zbl+S2HUfnDAObgbL8JWRWGUftULwtLGQVdRB66QAYxi9md9kHoyRbeM
	VfNVq0qRh5h5t4crOZ6P/sdEKpk0vH8gIrnraLz7P6XMuk0x1Ot1yQBtNsZg7Tz0NYrQRN
	kNuUI4oGsRMj8KmQoUFe5NtAUv6qGsSqatwv+FwZHTolN4yXp8T6s8xZbraKGw==
Date: Mon, 9 Nov 2026 10:49:42 +0100
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
Subject: Re: [PATCH 6.12 0000/1536] 6.12.117-rc1 review
Message-ID: <avGXNkyWQfNqN46v@duo.ucw.cz>
References: <20261107134957.653319350@linuxfoundation.org>
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
	protocol="application/pgp-signature"; boundary="Mubs9s+4go83l4pA"
Content-Disposition: inline
In-Reply-To: <20261107134957.653319350@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--Mubs9s+4go83l4pA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 6.12.117 release.
> There are 1536 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

I see build problems in -cip testing:

arch/arm/mach-imx/pm-imx6.c: In function 'imx6q_suspend_init':
618
16:02:42
arch/arm/mach-imx/pm-imx6.c:589:17: error: implicit declaration of function 'cfi_get_func_hash' [-Wimplicit-function-declaration]
619
16:02:42
  589 |                 cfi_get_func_hash((void *)((uintptr_t)&imx6_suspend & ~1UL));
620
16:02:42
      |                 ^~~~~~~~~~~~~~~~~
621

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/3040183502
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-6.12.y

Best regards,
									Pavel

--Mubs9s+4go83l4pA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCavGXNgAKCRAw5/Bqldv6
8rsqAJ45LzdoINNO5lyVKg2/Ub4hkp9kiACgtU/TOP3J4Mz66/+lyeobAmccWcY=
=Yr52
-----END PGP SIGNATURE-----

--Mubs9s+4go83l4pA--
