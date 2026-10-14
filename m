Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEA63AC0DD;
	Wed, 14 Oct 2026 21:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792014515; cv=none; b=aS/BOoOqQXJmP8Kd/Moveq/4T+0mq2nTYayvVFao+fgVessXJJHYBA7JRnonOSKF4st+X+heP4JlKavog8RsPHCpntsFWZj8QAP+S6h6AdGplBgbrDlcGimceQmIt7LS5GPg+9+cCGtbKM8Xk0oLgfKi7GKf57LKcjsD+t9DD/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792014515; c=relaxed/simple;
	bh=zLs8lv72jdVdVpuSHmD0cCpsO+dAoJbFI/AwwdDEvog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7PXzqdNXSj+JPi+WESzuNtU38UlxAMDzmFF85ar5hIuWqMe0yg4GiTv9f3LrTe8QBc1fWVbuqj2hQLPg8FoQJTFWQD64UKo5EmOzHnKF7zgqO47AM08IhUT/iEJzCQNfaUxre80cjGpYEB7adghm1tCLOXIEK1ljJ66oMaupSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=aARjGemv; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="aARjGemv"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3AB37106734;
	Wed, 14 Oct 2026 23:48:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1792014507;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=n9JKL/canYMMKIWZgFSNwLGd9uX+pJwnF/IkieI2xxE=;
	b=aARjGemvzjCi+b0nk9Db16xyp9+vqBmtC5auGSQmMddje+882VvQaMNojPPpdesqbAAJAB
	4mrC7SldaeJp7vn1Y7eOpHHuLlT/v4giDKVOX2Ma+iTCXmp4cpmdcREEqmHri6woOAPJAh
	ataD4WhrDSUQU3kjQLtmVZTmg7jJjAU8eiL5v0erQ+YNKexaBLiiLeAAEACqqp+aPHuzjZ
	4ern+0Wf/N4v+Pg6ztVDcOxRMOIsOVYYAiDhPt+I5hnXiN74FV+eSPmw7bS/AQjCAzju5a
	J/Eyx7793J6EpuIA9NMQaDjVzu6V3bEnxf65GDM8YRRUlqPo2bpu5HCY4IRlNQ==
Date: Wed, 14 Oct 2026 23:48:25 +0200
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
Subject: Re: [PATCH 6.18 000/632] 6.18.57-rc2 review
Message-ID: <as_4qUPvybBE9TVU@duo.ucw.cz>
References: <20261014123820.008483134@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fafLaCgzFeHOfuHo"
Content-Disposition: inline
In-Reply-To: <20261014123820.008483134@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--fafLaCgzFeHOfuHo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 6.18.57 release.
> There are 632 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-6.18.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel

--fafLaCgzFeHOfuHo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCas/4qQAKCRAw5/Bqldv6
8sQ9AJwKPn5IZw4uptX2xgUKilKrMPlyugCgh0TLohrHqx/tCdcBjmrM1vcExx8=
=7yRa
-----END PGP SIGNATURE-----

--fafLaCgzFeHOfuHo--
