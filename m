Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795686597;
	b=WW4m6PYGtn4v5oq0HkejSfEAitZnmC95dprhbbJEa7lenGnShpVVnLLSCyxE97MYYlEA
	 kzUbGoRGrbsFFJ4U4b4wRxQzLG2cL8o947tc7VKlGstU0HzoRnjSfP/9twd/RV7BU5yHA
	 F239c+PJoH9VySMgbcY4z+B7rNtVmMBddXrWHdopblekmiiz+fn3FL8k2BKNxAvUwYUtz
	 sX/398gndw0xSn2tzrTSRgK3C5t0UO6mmRmywKFLNVhSosfdoiwTtrD+96ije31htgQNl
	 JglwJQXw+PSQiX7D71vohcaaB+M4H46G27DHFjV685/90LpkkuqPnOYU8wOPsFfZL/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795686597;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Last-TLS-Session-Version;
	bh=ei+vRNvvaaEtyjfLzQncehkFlOKtAw1jiPfrrwX4ZWA=;
	b=vQwZomxvLtV0PihL0MdEUjoxnUuPIeu/gNRv2LSDcgqVnFr9hhrU5brmYBZsat6g9bmN
	 j3U3AX0shG4EtM/i10xsVq2fpJURQOwWdZ2VdLQwehnvBe6MACjYajxL/OdD5rIgTgrSh
	 2NisgWS1T60tucks09C+jXzrENSo2FtMDTxni8sLEHA2/9kkTpd0tAx0+UjjBvP+dVX/B
	 8T1LUEv6JvLfglZx4pe342T40cDLPIebR+aIl4xuhlHtFjL2TxKc97gC1clKpYgIgpYaK
	 qFxO/2m5e7Apbd4DAv7qu7bWndR5B4pjvYgyplcBieXwF0wkbYLPCFmbdISJU1BB+UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nabladev.com;
	spf=pass smtp.mailfrom=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=FvWIKJYg;
	arc=none smtp.remote-ip=178.251.229.89
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8189B606A323;
	Thu, 26 Nov 2026 09:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8189B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=FvWIKJYg
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4BB321094E6;
	Thu, 26 Nov 2026 10:49:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1795686590;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ei+vRNvvaaEtyjfLzQncehkFlOKtAw1jiPfrrwX4ZWA=;
	b=FvWIKJYgTV1vCjrMnY/0yZV33zLcgkAcuHMweH8xGqGQer8cCu6uSHkc1Vif92NCLI1Fyn
	FmWkzX9OrGJ+LIJfKEsme3gQGDUZdCYRG7BvA5g7tjIq0CYjuPYT2HQnkNUq+1klqJcvzH
	AE1vsflyaRAwnmNfSU00mjwu1ZGsrjuusbMUS3zEfJYpl1Q6nkkUzvWSBRMI1vfyvE9m9w
	trH9vvdVB7PYamegNIYWgyt+uBwgMoXmIUJy+jiXovZ0aCO1xO0/r5sNtTt7h21aFvTNsu
	IOIei/ihi/HC1pahtsygXq8YRhsNak2Jw5t87hINAegkvK+4ySgiW/LCgieQhg==
Date: Thu, 26 Nov 2026 10:49:45 +0100
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
Subject: Re: [PATCH 7.3 0000/1005] 7.3.7-rc1 review
Message-ID: <awgAuX3tvvXL73fK@duo.ucw.cz>
References: <20261125143821.729802100@linuxfoundation.org>
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
	protocol="application/pgp-signature"; boundary="dv1nl8+AO0Rn7JX9"
Content-Disposition: inline
In-Reply-To: <20261125143821.729802100@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--dv1nl8+AO0Rn7JX9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 7.3.7 release.
> There are 1005 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-7.3.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel

--dv1nl8+AO0Rn7JX9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCawgAuQAKCRAw5/Bqldv6
8o9sAKCg5hVOsenB/NvrxuLk1/9XOymh6wCgvvVhxvKimfUQInduSpyx95zhhmg=
=MqIO
-----END PGP SIGNATURE-----

--dv1nl8+AO0Rn7JX9--
