Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF7435201F;
	Tue,  1 Sep 2026 08:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252167; cv=none; b=I/SfEE3YqFV5tJ5U2MELnr/6F2WK2+BDGlrI39vl7+LjCPria+HsoGkcx1MDi+Wt70zoGRrHafS1KwO/ro1XEaR52y6QFOYmwzX5o6maep8yIAchHWB8TqpZE0Cogmy2yZRIfWI1dY85pkiTlXfm9EPaAm//IQZUzG9XNbd6Wno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252167; c=relaxed/simple;
	bh=TSsbaKqd4k1uhu4rFtQu/r41virVGxelZrsFbAwM7fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVJHT+xYyo9zeSMp7Bz4U+eW3FL5/lkTXv9fewouhy4gyZluSO5A4MiW/PJP4jA9zBZVHxiH6al+WF8pv1ek7MTcHZOw8stBO1n4/h1A5+67VjVlGtvUWwINkh3l0L7CgF2oIZBYhOXHc8zoeCfQ5SYWSHXPuG66PZC5F864Ub8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=MKIihRzB; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="MKIihRzB"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 085FE11D41B;
	Tue, 01 Sep 2026 10:42:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1788252153;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=+fmhrvVPIFFDsAKoKK0LwPt5+Dpq5tZ72FEeU9A1iV0=;
	b=MKIihRzBLGsoVxhkJ2XD6BzPz78hLi1xcRMEADHVnNQWRUyBArATiOvSu4GbbpWqWqKfPk
	ueWRsPtfyi8Xofb6CAFvakA5LIUDix9y0NHbu4MZibEmaTnUetEwdPWbGQUuqEUdG0cZHs
	1wITI/eKJ4PWc/gzfNUhY3KCIUeAK+WT8Z0sv6G6y7xNHb590XgLrRUwC1fguBNzOIAGV1
	AQpU3+TmTc+v2kXrrbjdU96nZnaC1FDDn61IWVPTiXIVjBsrA5/rhUd7ueczX7+CRB9eLR
	g+/xpBWPI/SizVowlhLeJpIduVt7HnH6UUNO0EB7sgfcYhdUlfXIg/OsxtCL2A==
Date: Tue, 1 Sep 2026 10:42:26 +0200
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
Subject: Re: [PATCH 7.1 00/76] 7.1.13-rc1 review
Message-ID: <apaP8sJVA54tpdPU@duo.ucw.cz>
References: <20260831133359.185608553@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s2j/ejBGG/F1nL5t"
Content-Disposition: inline
In-Reply-To: <20260831133359.185608553@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--s2j/ejBGG/F1nL5t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 7.1.13 release.
> There are 76 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-7.1.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel

--s2j/ejBGG/F1nL5t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCapaP8gAKCRAw5/Bqldv6
8oOsAJ9CXkywULfI7P4VHkXRHaj01Yw45gCfXRIl64HGCPTQgwiwfDZ2JS5BL6k=
=7azc
-----END PGP SIGNATURE-----

--s2j/ejBGG/F1nL5t--
