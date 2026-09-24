Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5013B4749D4;
	Thu, 24 Sep 2026 11:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790249231; cv=none; b=oSwfrH5m9Mkx3gs9MM9ViB7+WTS91F6o3HY9HmBEDA7r7yUXdkMyL8J+1ZzjXDsp4yk2Ks5DbAJ/aSCPEAcAbslrQ9iqP+Z2hd3/93dACD3lEvJcGa/LgqPCJLYFICzinomDzPX3mqhZ3elJerovgAz9XvArlKgcL7vS8SICXkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790249231; c=relaxed/simple;
	bh=Ds0VP6NgpHgGjrktIUEiwwpNPT0ElcBSW3E0Wmcvg2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AW6HITB/mizhEI1v+I1yOgl0IhMJOFknX5UkwsPbf9wImstRW5bu6Z/z8dRbCJ+SbbjeLMlBYKM/LS8o3gVpAv9yc9ZcOvHB/VNHeeo+sRsJI98zUdQwtWBsmucUQe1vYJasBhMB05+LVyDBI2QiaElVta8DiOoPZUEKNb80rVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=GTcq46Rq; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="GTcq46Rq"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5A6E3105BB9;
	Thu, 24 Sep 2026 13:26:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1790249223;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=5xwCXfeCM8EghcCMeFwzYoiWEPOW1omxmLCe7yuZSXw=;
	b=GTcq46RqlTxZZaDm4SxorwJpOYWiWvV/ZTETSBW/t2txdOyWbNnHjAg1VGHLNbpmZ/L2IM
	6Vmw7cBg7nizrkQWi8WXkMifp9+dIdD+oQI4KvnezW9/kbNIEYG1cHSkJ5lrF1ra9HFqoo
	a/4H3sGtwq9MOQDLNn3By16kQDPIsf0fNbzNNHPUr5+rmBfl0bVdGBWNRSZhagyTpH85fk
	gLrU7hJuTMQFnsNg18S83GsBS4iAk2d8ruVpRRluqF6+50fvxlM1E62nv96IqC3ccKhWBe
	W/h956UOCpqKM0cdOqyQhgpKiZYc2VJxYoqb9UpzmXP+KctC1JfNfhzhS+zqrA==
Date: Thu, 24 Sep 2026 13:26:58 +0200
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
Subject: Re: [PATCH 7.2 000/438] 7.2.8-rc1 review
Message-ID: <arUJAsTgllLGVIt-@duo.ucw.cz>
References: <20260923140644.756254324@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jXz/Wp/mcl7nof3B"
Content-Disposition: inline
In-Reply-To: <20260923140644.756254324@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--jXz/Wp/mcl7nof3B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 7.2.8 release.
> There are 438 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-7.2.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel

--jXz/Wp/mcl7nof3B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCarUJAgAKCRAw5/Bqldv6
8oJeAJ0e4ifV49htfKhfbmPNxPd8ZOSYVwCgs+wD7UBcbdrmBN4Mf0o2Mt0KMow=
=jLVM
-----END PGP SIGNATURE-----

--jXz/Wp/mcl7nof3B--
