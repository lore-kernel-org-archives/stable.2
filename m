Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B670D2FE07D;
	Wed, 14 Oct 2026 21:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792014492; cv=none; b=QKFy2c3p7wTpMAtLFkW4ULdGXQ6+9Ha1YjrIgHrwFOP60VCFxkfZFidzzi97V54Wlo9vUsO7KaM2eo5lks1/3xFnEW8uE8VvhBxahR6U+up+zJMli6skY2izI9wFG6BCg/7uJ7Px/C3OcSLLcLno/heKXOGJ8RLRh2XfPbxAowY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792014492; c=relaxed/simple;
	bh=uDA4/61lKNsuBTTvzOupnnMTqjhKMI62DCWOIYtuftI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHaxyNsb0f1MAQbAl79dx9xwnlPgayVHG2F4pllXCnYDmbklDjQq/dhiythcgunQCmvDgP95cLHIRi4r6nHOVIH5bV6JoAV7DHy/Uh7GcT3j0HJZRpe/Y2pbvGA+bLpepfLrbaaRJzql8xBay4wBvgE97QIzm3Ey9R8XroM1knk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=cFobp1v9; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="cFobp1v9"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8E228106B7F;
	Wed, 14 Oct 2026 23:47:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1792014478;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=FX5mPvwB7tDy9/f6EGD7rUwrPbwrZzsd+j/t5C8iWsU=;
	b=cFobp1v977jFx3YguKe/zDO3jo7SkjWbpxoAY0Q7Zeb9ia1lWpg7Dy6LkDtzWRBrxJoKab
	OD1pAM7mm8+dm9jxuBIjfrwY5yIYJCjS+J2oL+ZLBCjvuIs5ga9jFyBmBA/kT1g8m02oqU
	97QtucsomEBz9wS3mYzkTNh0DgPgjMJSiHwcOo65eDvKN6SI/1uKcJVjNUoP+WUuwe1Ujx
	+WjtaTTKt+pnGsSznbak408eqW+OSfIIuYN7rAE9OTMdKJWVGwmVUcH6zVQIOC142dUZAN
	6gnxZ0NKZiQ9Aj9Ywn6MzCxPpE+lU3FqV8G2/5269oPOhKYXnFcCDwphep0t+w==
Date: Wed, 14 Oct 2026 23:47:53 +0200
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
Subject: Re: [PATCH 7.2 000/284] 7.2.11-rc2 review
Message-ID: <as_4iaBYeri2C9aW@duo.ucw.cz>
References: <20261014123758.782265692@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R91VgserZDQsxEqn"
Content-Disposition: inline
In-Reply-To: <20261014123758.782265692@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--R91VgserZDQsxEqn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 7.2.11 release.
> There are 284 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-7.2.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel

--R91VgserZDQsxEqn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCas/4iQAKCRAw5/Bqldv6
8rtFAKC3aNQQ5QLJVX5LH0ULMs+A6ojLogCfTa06dBzd1nC7TLBEU5u9HW0429s=
=0eJx
-----END PGP SIGNATURE-----

--R91VgserZDQsxEqn--
