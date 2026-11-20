Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795173545;
	b=s6ESVmq+j2TEQ5lgmeOnF15K7HRPER35IiuVjf1718UuAlnY+tiBEBPsMIoq1f4SBAGx
	 56NSKo+VYy7MylCNKdHqw2lWkZ7f/pQ3zHJZP87UfG/ysyU4kt9E3MJ6OgJY72oUAgr7h
	 xqqw1RBTBk7wS0EAhZWy2rh9urtUozh9oCy35swYj3tywAfye6cx/ReR1zMMIRhMfKciI
	 mkLPjjXzKlWcLYk63nXJHNJxrCKIS35WdF0/GQQktk4eO/Anb8Ttkz6UdC/1U9KYZJRyi
	 qw3clyyXgEc1ToLBpsRQE/Wgx3Hy1hl8TQ7MWQX4gzHrq83AlTSBI8BeLn6iodNMNKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795173545;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Last-TLS-Session-Version;
	bh=wIqBZXdyYIAF5S33ldVhQ9hrfIE5TTxvNvkzp0PWMt0=;
	b=vymyhXyH72v9HzsmXupifyzvsSma2imklgdV1qtOkAHFgD5dHuso1/eGYxjuWbAkzlP8
	 JxU9xcRhcXzfKazFR9s9eWV6vyPvtqhLkO5Bl1xQXpSR+IupMW/yDLjEKiTDY8MzBVcVW
	 qesqmvUxsBbzHpWSvdDCQ8Ssknb/pDPsQnlF5wrCZimpSsnMKJdBtdPQTNpZlAH+kbyQW
	 WLxaZTUHLKcIVbdO5y18s0CKg8/jOszUOEC38QA5VFrPaBRo0ytGR403wie1TOSmUypIs
	 wMWce35rIPGNEB3KfCLV7BdYUyxFnkyZiaji99jJn5SoyG/yAkkeYy3XO+gFWi8hRAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nabladev.com;
	spf=pass smtp.mailfrom=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=bXiPPZqr;
	arc=none smtp.remote-ip=178.251.229.89
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAC8606A320;
	Fri, 20 Nov 2026 11:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BAC8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=bXiPPZqr
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3CE6E10CE9A;
	Fri, 20 Nov 2026 12:18:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1795173538;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=wIqBZXdyYIAF5S33ldVhQ9hrfIE5TTxvNvkzp0PWMt0=;
	b=bXiPPZqr7xAGPWlp3lSww1d3jU8YYq/L9GKf3wN+wC95Efg9ijRr2dvYc6pJO/mgAEnNa7
	xjTNhdfYelyaN8oKOsqH2z1pwCCpHkSaCASJET+VoUbLa+AJbljJlPF40FAygDsivne5uw
	fciRkpc0j5C2TDOQpBFpui8Q82v8YTmcLVmZrsLhEhrF5vbCYgF13TV9oS3kDMUWeG0hNR
	D6+YC771JzhVsjVSU1KkwTmHcTkNmwYKdqcfw6boNedZ3NVgXf80BXJLeOsJd75QPRRuKW
	R/ASTCZ5ABtjKK9PCOPb+aFY070W5ldpM6PZJxGlONEsHTYI5O9qbW2PrnMXbA==
Date: Fri, 20 Nov 2026 12:18:54 +0100
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
Subject: Re: [PATCH 5.10 0000/1811] 5.10.275-rc2 review
Message-ID: <awAsnjf5hlR7dVN7@duo.ucw.cz>
References: <20261120054906.397973290@linuxfoundation.org>
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
	protocol="application/pgp-signature"; boundary="mkqudG5LwmabYYvS"
Content-Disposition: inline
In-Reply-To: <20261120054906.397973290@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--mkqudG5LwmabYYvS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 5.10.275 release.
> There are 1811 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-5.10.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel


--mkqudG5LwmabYYvS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCawAsngAKCRAw5/Bqldv6
8t4kAJ41Qpg2RSHhD2A5mE+bYeWIlcdScACgiUHl59RyUTGN1wlA7JBz+BmOQUs=
=H/EC
-----END PGP SIGNATURE-----

--mkqudG5LwmabYYvS--
