Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892618;
	b=Zfld6ZcigDOwfrQH6G9iyOPrnkkkztjBdD0sN7F6jAUoKpKckrRAOnT9tK7bVdm9n3X4
	 5TCwy1Kj9U2RVxmnj+qHsEcgUVJHv4Vjo7nLoE1WsqJwA1dz7frtH2YwO+CUEl8Ejfbts
	 GV8tkhweRKfaXZgovwKuL2Hvj3MD/PnskusnKaMgxc6cAGSuGnFwv7Dj6CoxqOS5VmuaT
	 1jImQP3eUAgOcJkdfsD86uxRHlQfoaiyRxcpoFYsCQpfhlZ2pZI/N4Irc2gGoa8HXJg4h
	 SvWcp3Za7y8YuzdgsVFwXkvvoaIi5UF83EwCE5UVERKphba+8m0q6pgjgu1x0Kr9fyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892618;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Last-TLS-Session-Version;
	bh=dR1D0mKpwqt5+k3otoLJdwlvTS9lJAMZTSK2BtdjMm4=;
	b=DG3s6+d7S/jEGVCeQqJS/3kS5THqYaquz9xSGI1H+CKRuyXHOAz2oAXi8CxStJ1FCfCe
	 cQ6kly/N0EGiBE1JokuYCQHM8rX6F8RDxcrPQ0o3FfhszmzqVxhNHs8uk5e+OAt7hk9Fn
	 JBDgoHSyRtUdVtKswey7l1r2Ls803eLhkb6sZZMKaQWxibv67UD4i6bnlbJWK/eXT2r6k
	 LMdFOnGNqFKU4UUGmtF1S7KNST0etISaWfFVs/dSbNemIsr72GpK66OKBtZ0kSBiczUkJ
	 DsnzbXqMcIbIloK5fotphHRmtnhVzB713vZRzaImc30+EoEgBpvVS3Gn1MrhZbM3quw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nabladev.com;
	spf=pass smtp.mailfrom=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=cfGwFD7I;
	arc=none smtp.remote-ip=178.251.229.89
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E54606D838;
	Thu,  5 Nov 2026 15:30:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4E54606D838
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=cfGwFD7I
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4E0E4109A73;
	Thu, 05 Nov 2026 16:30:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1793892608;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=dR1D0mKpwqt5+k3otoLJdwlvTS9lJAMZTSK2BtdjMm4=;
	b=cfGwFD7Ix+cjvM4j1YUkLdfsPy3zWwCqTJqtU0B1ohX1nIbyWbH8f+tjXJxC7tvHp3BMp6
	S4uTRIFptpyYKiHtSyyrxagK5Fe/JshqjTSM9ZZpj1c2MkAe9eWDXXTHVgueKccvmaUfYf
	yO97P206p9/qnvIwHLwxdf28qCNHTsOZ0hF+i/WA/MCsxrhQfKVYJI8ksNViEQU+3Mg04r
	nmpPMwL+nwUwB5pDwmLawkb8sZE9LPkW5CochnYTVAcnnuStcravjqBNm5OZkWurW7YAt7
	Fk5v5vxyYv1txsmnOAqnr12m86wOM68w9SJrS8Rrm+w2R4X9ggzEXcRjzS/Wtg==
Date: Thu, 5 Nov 2026 16:30:03 +0100
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
Subject: Re: [PATCH 6.18 0000/1005] 6.18.61-rc1 review
Message-ID: <auyg-91iUyD0I80a@duo.ucw.cz>
References: <20261104211043.516122098@linuxfoundation.org>
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
	protocol="application/pgp-signature"; boundary="EmtiC/zCCuB7zuHe"
Content-Disposition: inline
In-Reply-To: <20261104211043.516122098@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--EmtiC/zCCuB7zuHe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 6.18.61 release.
> There are 1005 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-6.18.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel

--EmtiC/zCCuB7zuHe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCauyg+wAKCRAw5/Bqldv6
8oT5AKCm8+UYNWW5XvRfdDYFfVR9nXl8HwCcD/DYhxSOVxxLYYvwrC/9y1DwFK0=
=Hplc
-----END PGP SIGNATURE-----

--EmtiC/zCCuB7zuHe--
