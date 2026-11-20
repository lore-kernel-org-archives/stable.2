Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795173617;
	b=np/0oZYuHXrfjD+JjhYOVhU7soytB7tEP2Lorz0zYiqTU1QLRW8/viY7PQ6T76NEsNQF
	 tSaBX/JEE8F8uDSZ7dlZJxPSzM7jKfbMjEuM7I9jH0YiLCQ078RgoFqx3QxQRBdhcnyOe
	 GbjsJVzTMJhPuprRy2KaVVHKscB+B2V/X03w7o5TCNPnkepQo8TDcGcz5PL0vr0RbGkhl
	 DuuRdCc8LDTy9+gTgAOSQsYdLGmkolD9I4fBJmezWwcxhidanXtnO/8eNkkYAgk0ShJ78
	 VIk5InBhh8x1gD3vxaASWnOGWO3sEYd5T5g9neUtMg3i/N+PuYTK6+qzb25SVwIiHAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795173617;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Last-TLS-Session-Version;
	bh=GhH/JI2wLbB44KLtAjRHwG83XhdtRChQMhDijc/6Qd8=;
	b=Hu9OWSJHsNFasyFJARTqPw7CFZqoQMSr1dfvkh3xXppg0gML/Dweth74ZfWvogi2alDR
	 cpgkN0+uimsCEwpjmSJlQ+mG/Si8+AFSA1vHu4UfJYvmqvXUh+5OTGR852fc2LERDhRg9
	 BhH+ST2f7Lomy2DN9xaJXoWKeAPQp/fGEeVA3g6KsXO1bxZsZn9s3IRxbQUTiz+1XSgq1
	 Kk9A5ACw2sgVKrArwqW17qiLpCgvCATLV6pE68Vkxxr0cT6q90oq/wrs9j2FGvE4lx2nF
	 qVxSC7sP4i2nDAoHzjYf3BFqmxLTbQSH75s4fhtnvm+4Gj0zRlrli06rv6Bqutz54Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nabladev.com;
	spf=pass smtp.mailfrom=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=kN12pxj7;
	arc=none smtp.remote-ip=178.251.229.89
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFF7606A325;
	Fri, 20 Nov 2026 11:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECFF7606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=kN12pxj7
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D3B5810CD95;
	Fri, 20 Nov 2026 12:20:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1795173611;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=GhH/JI2wLbB44KLtAjRHwG83XhdtRChQMhDijc/6Qd8=;
	b=kN12pxj77Ho2z/nGxjorMHGuTETB97HfQEthEU6pg6d2wHcCcF8CJCpI2Xwo5/hr6viuVp
	1ko27WvqlFwh/J8TXCPfj4K37mxWMRsU0gwb3kox5rTYD6rM3ZhGAkZZo6QvCJjrAazgH2
	O7ojcWVdZaa8UxJ3QUmxeX7nUkh8oLuca42Bwlu30D38nNXvFb6Oed5e00ZsgVEANSh6+c
	elgPfbyLl0siJIN6Z+USg+ueS4Xi8EO3NsC/C2K/PE6R6vjwviiv2p7CZNvy8KP2BHeoCI
	3a7mqLCI3j1+UZz6rvXRkJ77k2hzR1rFQxwvQ5/2uC1ZW9FwbRYruFse+WezvA==
Date: Fri, 20 Nov 2026 12:20:08 +0100
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
Subject: Re: [PATCH 6.12 0000/1736] 6.12.119-rc2 review
Message-ID: <awAs6Nnd4qjr5wRH@duo.ucw.cz>
References: <20261120054951.366579794@linuxfoundation.org>
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
	protocol="application/pgp-signature"; boundary="IrKPQrWCA5eTiyjD"
Content-Disposition: inline
In-Reply-To: <20261120054951.366579794@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--IrKPQrWCA5eTiyjD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 6.12.119 release.
> There are 1736 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-6.12.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel

--IrKPQrWCA5eTiyjD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCawAs6AAKCRAw5/Bqldv6
8s4aAKCO9Y7+nnbuYL9zksXZpFeIAdCb7ACfVKtsQqFcOqTij+IuZI1OWI+Lbjg=
=kOjN
-----END PGP SIGNATURE-----

--IrKPQrWCA5eTiyjD--
