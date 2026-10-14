Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CDF2D47F1;
	Wed, 14 Oct 2026 21:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792014540; cv=none; b=Dbinc5E9xrQA3BG1HElTwNANHEKG1wpA02v0HX0gSBYUqLlhIUToJgwi77vSKPKuJNHp5zf/eMApS92Ms4D+vgm3rW5fjcDfx06X7oMa1mnbaDXExsj1Vi+uWsfiz4kts2rgNcJadOVnJcdY3k1ZdbkJk/3fPD7CMgbpj7NPXzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792014540; c=relaxed/simple;
	bh=NhbsP932eQeAwXMbBcSyWgQH65bl2AGQLukgsBDV4QU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DnrF6/3EIm3atK0jtsnhAUzo6i1hgMXnGRN/UBkKVfzgtwxnDCCp1tlZDcnIB03dwYzJf9TmHYSYTXxW+czp8GXYZ/PJcG9jj8viMDr5QGzBVq8D8Dgt9R/0+Qbgd+Zi3S19lGuckrVU6pWEgLb20/7PD1hcushKr+rl4wl2kwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=DiaEW6t9; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="DiaEW6t9"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0E957106734;
	Wed, 14 Oct 2026 23:48:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1792014532;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=9VuIwqQpYDId6RnsV/1AwC/VgyZbs9ICEO7JoN6lLI8=;
	b=DiaEW6t9RnlRLOSNtvfJXhRwapV5475xNBbGVMlbcycjU3uGLAg+jp0dZO54h3+UoaaQK5
	0/lq2aiaS3NLZ+FKrXmKBIM4YytphJSn9YPeFPvE2meljUsZAdpWOVhlgU4XtYLRheTrfb
	Qb7f1TIoPlTDkCYf+7yClXPxfS8NascnYlEYx7zeNuOtA7pnr3bL8fH/vLvT4sLD1jf48z
	DjegVpoQAxouSFkFPkI4xk4n4DwCv8QQvolQNfBgpJB5ZNGHNUkhHIJaKT1kWrrK/JnvVz
	qObkVy17iSsOrxoN9muzW6os0OkDnobBgMhP7pBQl0fRrEpJGlzrAUocWpupJA==
Date: Wed, 14 Oct 2026 23:48:50 +0200
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
Subject: Re: [PATCH 6.12 000/505] 6.12.113-rc2 review
Message-ID: <as_4wi6AbUnCEGYN@duo.ucw.cz>
References: <20261014123803.944920639@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2YI51OE0uj6uF7TS"
Content-Disposition: inline
In-Reply-To: <20261014123803.944920639@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--2YI51OE0uj6uF7TS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 6.12.113 release.
> There are 505 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-6.12.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel

--2YI51OE0uj6uF7TS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCas/4wgAKCRAw5/Bqldv6
8ujnAKC/pj2LOqvod/Ydf1lsxsaGMvPqtQCfUgszSNf1qtsK1OKMjnOOBzHUEXU=
=zUUq
-----END PGP SIGNATURE-----

--2YI51OE0uj6uF7TS--
