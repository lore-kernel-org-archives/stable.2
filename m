Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793368084;
	b=Asas+fCUFu335NvZXBj0fjuhrY/QVlJJhfDY3gkJDboBeZ2cSuMUMX1iULt5NKR9gGtH
	 YlKyrWrl6HIQQvTWqcXYq9tqh7Gy7HXrm37maougCfxYAPbexEaVad3O3xmIl3jAynd0r
	 KmGVjglZMICFzCyBd4++/6bUl+SQ0NxQcguSrjmMstO3t56ZvfX4aKxLc0ZYwBjpF1FIQ
	 CIYIeBvvYuTG0nzHE4c5+QjRbCDzKjEsGRpDVeq7T+GfqrhuPessiWmthmnVDAGcQI2HI
	 HCWx6RoSKZl7jqBTWFn7WkuUz0r843XlRd2q9fFoDmris6BbHrimMA3DtR829THaS6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793368084;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Last-TLS-Session-Version;
	bh=OQUCECKRV95fBLQhxHRghGxv+UF7o/D+Uq4NFTgG2P0=;
	b=hPjFGPZ+biB1r+PAJsnupthCim5POsoKZqrmVlYjxqxMtn4Nig5UZfaGhdzp291Ec3e/
	 KUVs41HUaZzFjBJrefc745/XRlWyQ7HLThK7wfsizbDV+NHNT+L5D9W8lHow0WNfWvu3W
	 ZkygsWerkmqBABDuw4Lj99LGEoCOGxhnTenwD1G7+aBqoNQvK/odwuwDlJnjopVbfxryb
	 CJyYUdI1lBqGfnGR2L9CkThqSBDKys1sfGkKklwGV7nEipstGZbNRU7clADlOaySKiord
	 iapzVJYzqOKtyVBL1JvLqarytYj5u/ScqfWrtGlO2Itafx0h+lx2imo1mKRlPaNNmPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nabladev.com;
	spf=pass smtp.mailfrom=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=LTnFvruM;
	arc=none smtp.remote-ip=178.251.229.89
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622F6606A31C;
	Fri, 30 Oct 2026 13:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 622F6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=LTnFvruM
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0BC3310AD2C;
	Fri, 30 Oct 2026 14:47:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1793368076;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=OQUCECKRV95fBLQhxHRghGxv+UF7o/D+Uq4NFTgG2P0=;
	b=LTnFvruM0hUeFYJZl3b4NgxkgAiOFAK8a+REGCaKfU3QpVxrcB97k3KtW2wm2fTH99AFI9
	O1qzDm5EePyytMdd4AuHC1q1Mk3FSlMr9x+qVsZVHdQcXk5nLHskHjW4aqKpJSB9mkwHxb
	wneu4Ijrifm/ZfwNl+y00vzjBHDTD57rfbk/kr7omgzfIf/VxJJf0huqIVYWXVHqmDSp7L
	dIUPEZAmhhWjCpVK+VdWOW0lG+kMYfBCOmFs9Ju3Uz52sRZFVed5+EQaK5sm4hgna/Fio8
	LYkatR0hwfBHRFoaR1DGbThMIpM3poHjlZlAFrJk59m3DCXJLt+J6F4nHnxOrQ==
Date: Fri, 30 Oct 2026 14:47:52 +0100
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
Subject: Re: [PATCH 7.2 00/10] 7.2.15-rc1 review
Message-ID: <auSgCKf_0YrXeE5K@duo.ucw.cz>
References: <20261030121255.257615100@linuxfoundation.org>
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
	protocol="application/pgp-signature"; boundary="juEBLUEEKpz1sXSm"
Content-Disposition: inline
In-Reply-To: <20261030121255.257615100@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--juEBLUEEKpz1sXSm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 7.2.15 release.
> There are 10 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-7.2.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel

--juEBLUEEKpz1sXSm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCauSgCAAKCRAw5/Bqldv6
8sRKAKCNipeITUD08o8VzSvjjrWGXsmuPwCcCntA31QaYp69oVw2l+XtVfeQins=
=GUil
-----END PGP SIGNATURE-----

--juEBLUEEKpz1sXSm--
