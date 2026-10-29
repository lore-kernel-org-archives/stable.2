Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793268476;
	b=Uyia7ItVNZYQSzK/GY7qGckTDloHJsplyzD/Xib7oqnDViG1CRlLtDQ2UrZo+5T8ykT8
	 hL29QI/f3uqRS47hPbmSksvP1L1ye0KMD4fb5b5nxuhsyMPbbSIkaflFyAYItN0MGDZ7a
	 ncsUxurrPl+LYvfDXXwwiEtN+To2njHVEwxcV87xP1/3gSrkAIrw72CU9PFqk1S2AuhkJ
	 p033jiEHnR0SimWNMef5B3wWFL77o1dGu4Cv6bnn1oqIMrbxGg++tgiBocjn3YpYL5mC9
	 ABKFW+A3QP+rRglcs3vHYDY+Qy6ilmOMUCWt1m5UjFuZ6ShvvxRw9ukvE7HAfndUt2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268476;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Last-TLS-Session-Version;
	bh=TI6AalHVhi+Sio82id/sg3uxeFVtKbdYDGvmlopGcDQ=;
	b=yrCAOIwI9uNdY35ZqFVU76I6nbo5PFFpjmjkYZqsZ1peXalQbN++NANHLeYq6noM15Ux
	 1QFOQLVmVjoUWv6JQ1uWVThBEl8m0kNwzMQENMNkx6Vrem2waQQ54H5sPI+WjQSJItVu/
	 a3iSIPrO5yKYmGfy+3ExZ9ZwxiG/N3YjpVd5GCFdEwgwnoLWwT8bc3VzxQj4ET2mi6TL1
	 u4vlNPy63+gBzSbPfwN5987FpJgzlTLs2Xcyf5J9Vf28GL9RfmtAHBm96DQqGbDCd7FfC
	 i1gpt8WjU+8x+A6z5Zu1ZJIlZFlsfM2Mex48PCqY8HQR76etG1Lr9Tf3qL0ZVVj4dag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nabladev.com;
	spf=pass smtp.mailfrom=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=YeAqWATW;
	arc=none smtp.remote-ip=178.251.229.89
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965E0606A330;
	Thu, 29 Oct 2026 10:07:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 965E0606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=YeAqWATW
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4A41E10A856;
	Thu, 29 Oct 2026 11:07:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1793268469;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=TI6AalHVhi+Sio82id/sg3uxeFVtKbdYDGvmlopGcDQ=;
	b=YeAqWATW5x+ozeqPviFcbl6txm4WF3dK1vVehInyHY94wyELsCfFMdREi9sbayaaMGZ2ID
	SjRZvZZdXGa9TtbM4FV4oe5SohRA0ZtbJJ63gvJ54QRyFyzmtkGKp+iJtcV0DvkbMcV5lG
	3fz5OpLBGIBdzaVPV4rSv/znlQpRE7YBOFMZmbwkLs4s3/4SEIZUizaKa/D7s+7QvGV8KV
	1Vr9GMBcQpLZg+NRTt4QD7RGBrE+He7fC8FSk9PnXKGVpR8eXsWZmko0YpAu7MHzcSniAo
	bowa+t8oAC4poCaylzAyaclL6J1X2tuQaU6rWEO1uBr8CS0tMwXMU4y9q1Uaeg==
Date: Thu, 29 Oct 2026 11:07:48 +0100
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
Subject: Re: [PATCH 5.15 000/571] 5.15.224-rc1 review
Message-ID: <auMa9BlVHbrVCngs@duo.ucw.cz>
References: <20261028170008.009143722@linuxfoundation.org>
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
	protocol="application/pgp-signature"; boundary="O8eRNLd0ea63Myaw"
Content-Disposition: inline
In-Reply-To: <20261028170008.009143722@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--O8eRNLd0ea63Myaw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 5.15.224 release.
> There are 571 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-5.15.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel

--O8eRNLd0ea63Myaw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCauMa9AAKCRAw5/Bqldv6
8hQxAKCxcrv+Q4w8p6n/jDV/2gJCVM7IHQCfUahCvMGVdP8pMB4A+cLg0LLd1+I=
=gRZT
-----END PGP SIGNATURE-----

--O8eRNLd0ea63Myaw--
