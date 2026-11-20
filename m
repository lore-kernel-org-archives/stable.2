Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795173590;
	b=QZhsWS/y4ovg2+rhRgLpB4AysnrtLYgW54QPDSlRPOPq1oGaod0U+mHBri8LzMhZKna6
	 VcN82Xi1PlA5aVOpQW55v1oCeIuxrW/EkafiI4Biao12l8G/RQkI/OpcmOC2ywdYvrUFh
	 BGxQxUzlpCw8QLB1ODbJ/i1DOa1I4i02U3P2pvIyVO8IGzZoHZQVqXEH4OV012Oq1diFj
	 MQ5wNj2F+nA15BaoGR5nbkwCeXlfbs3XTKZus75O5i9IEGbxN839IOQ4HjTsotiGKsMDL
	 Kimj6VVVKfonXR6xkF/fdnb4Lb2mOIpGXF3sOGYxrDAiwlU+8li1APOhXxiDJvOXn6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795173590;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Last-TLS-Session-Version;
	bh=tkzVaWdVselP8sA6vNBgY6M0lpdoHJoWb1IVeZ4lsis=;
	b=HoRBJP2bTnA1F77t6fhIxhzxWyXtDglJuw+MC1uTDqRTJ8ThanXOHOJK+bxJZCuSe2bm
	 qguSxBeVdf1zyy1rBhU+DfOos5NwGjKWPcJLZkbKbZnbw5JYIMpWvDTq2SpOBauZckYKa
	 D/N9GCh5zjPvF+HtUoMbJiY138qXGPjdSk8XXGFtqD693Ek+ceRmDc2392yb6PHqf90Ja
	 czxYq+1o2e29fhYmTLJFW0lORTcaGOdBqjB9SFYgYq/k9MDaJ5T5B+SMYfE6XVZzfIDvp
	 YsDF/ONKfjiywXfcZi3WwqLDVD8r7P3PyWzlDyLyNNuCL3oPyd/Nx3qO0A/yD046eQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nabladev.com;
	spf=pass smtp.mailfrom=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=Qh9vRaD3;
	arc=none smtp.remote-ip=178.251.229.89
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2213B606A330;
	Fri, 20 Nov 2026 11:19:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2213B606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=Qh9vRaD3
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8DE1F10D007;
	Fri, 20 Nov 2026 12:19:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1795173583;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=tkzVaWdVselP8sA6vNBgY6M0lpdoHJoWb1IVeZ4lsis=;
	b=Qh9vRaD38A8U6IGasIRDKMI9mC7KsGWP34kGvhAj5sJ3Q0bpz76RxcWl0Bqq2sEiT5KhSh
	BKVasi5WRlH8wgl1ih9GDmvv1AUQ3uTunctx9fO8/5/FuntZ7YN1FKA5TyACpfQNkysMO1
	mBrGwwn8FKt1bFa46duLVPHZY76o7qpxmfyosHsv6HjA2HUCSoHVx1SLpjLHE75yv+I/o2
	bX93b8y6qCKvBcfsnG8WXvTiaKQcDVQPWh9BqQDwVxVCWyts99QULy7GCa55a4O+uLy0yH
	zg/hx8B9ZH9JzX6a13TF2LOB8BpohkqnJucGVeuJdBQFtKyO5jYt14gfJsApSA==
Date: Fri, 20 Nov 2026 12:19:41 +0100
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
Subject: Re: [PATCH 6.1 0000/2812] 6.1.193-rc2 review
Message-ID: <awAszTDD6D4BZ2Uu@duo.ucw.cz>
References: <20261120055200.707545519@linuxfoundation.org>
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
	protocol="application/pgp-signature"; boundary="Goz9+AH6EcVdSf3l"
Content-Disposition: inline
In-Reply-To: <20261120055200.707545519@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--Goz9+AH6EcVdSf3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 6.1.193 release.
> There are 2812 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-6.1.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel


--Goz9+AH6EcVdSf3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCawAszQAKCRAw5/Bqldv6
8pecAKCc292IUR2FYR4VXvbobFYZ0QEvjACgw3iNpP3MG6gf0Uo1Y9KS56ti0u4=
=73q5
-----END PGP SIGNATURE-----

--Goz9+AH6EcVdSf3l--
