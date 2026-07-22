Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6158E3AB466;
	Wed, 22 Jul 2026 18:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784744907; cv=none; b=qL/fzgUI5fLw4z8+qYkWgfIQuYu84InhD4OiBWIADpfdsK09k4zAiiGcvpFWzuGiaDfe2/ju7qZG9az/tYOXDnOkox9Kgly1ktFCrbG8ubz4lTudIRPH+/BtDCr+NKtqR8IokveEmo34LVyQKnwHwi6CQcCirT1hNeSpJvxeonw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784744907; c=relaxed/simple;
	bh=2UoPzJCEa1qoHRb+qw4KBoAloDqejD4u4xL3vHvoX4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DF6Kr0CUcMSvJkDB3d/r04XRovmvRZFW9fwcxhrL7ll+qrtH2zmZwdD5BIjP+egnRVi/uHdOHZ74W2a+upJr0BbX/qNjmJ99AcJ3UgUNaeWdvUtQ3sj9sPRhhIoH7fmi4Kt2X5K+SIHSap0O3TVwTGSoOhcmbc4EHEjpL4zU4js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=PZOx3bLj; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="PZOx3bLj"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 67FB811AEA5;
	Wed, 22 Jul 2026 20:28:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1784744904;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ObPQvHvrEKaOhDrMR6BWOxuiG0MshAQlz8PBtB2aw1I=;
	b=PZOx3bLj17qxeyMpsQkBF+W9OHZQ6fHza1vL6g3L8LyHTIzycs8f8KL9GTb8GJ3LoYJGtn
	yHJyMC2cYGnNXc3f4HFPDb0rgRtixdUMAUkbRn0vgsTIBYjSzLtib1H9SEnUFpnAwPaD1Z
	gWOjX7Dt+CS/TNe+GcbP7jun3nusjqNhfW4d1sB0Bxpj+HaEvj/+QlZUuuDARIlXOHgBZq
	9hMWYpy1KFO4Nrbmoq1aeGYlaqnBBmQal41/+otFLeCKSKBaDcAM2ZhnJXNfgShrYg7bJV
	nQXRO4t4X4WhWQhybMFq2EiVdlrbz2Ug5pRdtb60CjS38db/kEboxLhVX4FwLA==
Date: Wed, 22 Jul 2026 20:28:22 +0200
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
Subject: Re: [PATCH 7.1 0000/2079] 7.1.5-rc2 review
Message-ID: <amELxhVwBHtM4Y16@duo.ucw.cz>
References: <20260722142947.085426486@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QtGB91nx/Gs70UDU"
Content-Disposition: inline
In-Reply-To: <20260722142947.085426486@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--QtGB91nx/Gs70UDU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 7.1.5 release.
> There are 2079 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-7.1.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel

--QtGB91nx/Gs70UDU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCamELxgAKCRAw5/Bqldv6
8hMeAKC3Vh+b4BJJRGieN1ZL1tYhjLMouQCeLqqFRmT0GzBfub9YMAKgS5YHJb0=
=GzMb
-----END PGP SIGNATURE-----

--QtGB91nx/Gs70UDU--
