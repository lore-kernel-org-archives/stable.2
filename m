Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493137;
	b=skL6JTAOuCLGSOTLh6Asarv4o9RvDa57diSA/KdQ+FQOO8sBVzqMeq6vJ/uYm5OCMbJo
	 /YsgaQVFK8JuYzss5mJM06eFT/38OzcRLWtH5TefQaWl8XSxK3DZBT01xPga6JBe9nEOG
	 S50BiBnSvNdoY9JqGn49UoUvAi4OFhyChY6vbZnXE45gIgXoodZ/j6WiJs6d2d5isHWeU
	 J8qR96suHN+GU+/Yvnw6hldWNKYwAU3DhP1DXASLXv0IEPf+p7fsfQ/AWeFHwSUVlMBb7
	 IIgJMZIZlfWIeAR2UPUI1ze73z27r0HYyyt2PF1xSqm1lzxXYaK+yP2GyrOTZNjGioA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493137;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Last-TLS-Session-Version;
	bh=TwezzM5TT3fSgFm5bORhn91SINIPUHV3PtxP9oYiBqk=;
	b=35ypO7ZVLHKFw1hKvS9jz2/N9mCi3V/iYo0/yzi1YJkJADsIshcPa0JgZWbsSR6fHfiS
	 HFa3zjfuM/JXM1ruOa0h7C6aGJ1GwSn/dn8CsHHhRrFS33X7vd+Lv0A0apzaUObmk4L5Z
	 UzaMleIdgoGU/8KuVc/QoL+a/hQ0+3RF1PBzyocYZuMSjgT65vrMULZIqbVWNfHvQNp2k
	 EIR53VvUeVUu191/42lR83dwm4odhjf5+sNFBK1p0jvE10R+2TNs0K5+RqO09fA9qjIP+
	 jTAq9Pss99tCPTj64nl3ZOu22jpXmuv3mYAWfn6U+XuW8rB1N0/4gYdLXnXTFMQOVOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nabladev.com;
	spf=pass smtp.mailfrom=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=XAzDGSpA;
	arc=none smtp.remote-ip=178.251.229.89
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE85C606A31C;
	Tue, 20 Oct 2026 10:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE85C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=XAzDGSpA
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F057B108C11;
	Tue, 20 Oct 2026 12:45:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1792493130;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=TwezzM5TT3fSgFm5bORhn91SINIPUHV3PtxP9oYiBqk=;
	b=XAzDGSpAhZqRCnfW3BNku+gQNeMAW9floxG++yIrxAI0a2tBTq96qUOr9YSvbMLvO0BzVS
	Zv7zVE41OJ6RMrVcV1SGD2TNZec0IndIZfM2JodE4xjlDq3BDPP1//udkO216FuxaX+cpL
	xFeeukPCaHXJh2a4SlFvygEFvpX/zB92upzny5tg6tPBI6S+fn3K6gJzK+GtVsv03ygYyc
	zKTgJDrapZIAfMeAx1jNOo6E5V1rnpkInaq8EMVVPg0AY2hy6I7A5NciC4hO497ZZq4JhK
	OZfF9B9agxLaqBi8qjrWGAVniuOZo/+zzbkGEli0L7KE3IkJEQ94CSKa3UMNug==
Date: Tue, 20 Oct 2026 12:45:28 +0200
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
Subject: Re: [PATCH 6.6 0000/1651] 6.6.160-rc2 review
Message-ID: <atdGSKrBOKxk2sWN@duo.ucw.cz>
References: <20261020075535.084584701@linuxfoundation.org>
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
	protocol="application/pgp-signature"; boundary="lNgc0qjUKjjepICP"
Content-Disposition: inline
In-Reply-To: <20261020075535.084584701@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--lNgc0qjUKjjepICP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 6.6.160 release.
> There are 1651 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-6.6.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel

--lNgc0qjUKjjepICP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCatdGSAAKCRAw5/Bqldv6
8gLSAJ9DTY/0SoylUpWrPbPoyvDT68pi6ACgtMgtbfVUdfO7nISVfFgVAesFEVY=
=jQDj
-----END PGP SIGNATURE-----

--lNgc0qjUKjjepICP--
