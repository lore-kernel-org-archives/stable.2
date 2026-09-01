Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7312F7F19;
	Tue,  1 Sep 2026 08:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252300; cv=none; b=Mpf+9otwOsRqNKkgzQWuRnYpD4lVdMZROofK0z6dmoBWCVcSnTjsVOU0Zm02obGVwXl84DDp8g2JEmquE9Ues5dZNC81FJZ2PvXeqE2K1jBBeYCDUH4uMwEwHNoTzduN2aFHhoMJXoGZgB8YF6w7JrU5Kn4ceK0FL4wyuPTWel0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252300; c=relaxed/simple;
	bh=4A0WX0IxCN7pYtY96nliaRC0gN1NsFuNqNNc9dZIRDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0G33DHpKq1yMqNWcLBaH+tRPij2raXzejd1PmxBv4caApGLp/T0XpT/2gy1W4FHOnFClQYhSG+FXgElPluLXq90ii7jbyhdUXZezD5DD2LC3Ddn7UBRpT2SEmltM/UmvXRlEGhHlBBgR1qEX+oG37na3CxH8SrfW9SGFFSSRVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=O00ypweD; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="O00ypweD"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8500111D41B;
	Tue, 01 Sep 2026 10:44:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1788252287;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Fb/J43Nf2EOVn9n3jKlafKj6x+8AObw1zrA7mZl6O6M=;
	b=O00ypweDzgrGFe0FSwXmuvTqeQ7AJf6Tg2XeYeIbjEebFMCsVWfbyAgNvaYP8Yh01lQdxs
	F8rLprT0yxCdGYsyjj3/H+bJ4GMkcfcZcZl9StQ+5mjXQ0lIma8daIrUci74DPFfF2/Nd2
	pdNvSEcKV7UbisRJyKkWDBdhAu9pRU0o/8FHeXJnzURMGvjBohmCjJHqo52s1GlTRK1I6p
	t2yxSP6682QWkp6Gy6icidauiYv94jSCmCi4mygWrlm9kKwN4gMtp9RKZuR7xD0WcTtUJY
	RDY5WRsSQ4G1ozdNkJppilMM5QDnVq9aI2Y640qiuAhYgZifFAel4cT60/7+rA==
Date: Tue, 1 Sep 2026 10:44:45 +0200
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
Subject: Re: [PATCH 6.12 00/99] 6.12.108-rc1 review
Message-ID: <apaQfU4DhLbwXVUz@duo.ucw.cz>
References: <20260831133359.740409777@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cCxUqWqQK55neg6a"
Content-Disposition: inline
In-Reply-To: <20260831133359.740409777@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--cCxUqWqQK55neg6a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 6.12.108 release.
> There are 99 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-6.12.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel

--cCxUqWqQK55neg6a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCapaQfQAKCRAw5/Bqldv6
8kEfAJ92C8sEg2TtxYJIw3Ao2Tyv4mGSsgCfYjkzfjb+W9sdaB1GKmbnTEhVl48=
=WsYA
-----END PGP SIGNATURE-----

--cCxUqWqQK55neg6a--
