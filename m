Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794818868;
	b=p/WC8zPxHGjWcx6T/aetMy58mAAQQdOWa/1pdonJurbv3Rm9K/iQp2VzKzSuAk95P9/e
	 prZ7hlDEn3NvAGTwWvDpiFjnBZav00zuXEAa/H4b0CpRSnxWS3k4S7GPEEfQok7Kohrcn
	 lwEn6NX6rAvvjfv9EsZo1qpiMmVvL35/MRtfcMigtO+Mb96BSwob91Ziaftdov80Rjfm8
	 Hhktu3Pj5XIlq3TJarXtFgabVQENjg4y9wBpoVcav3/i8PHy7LSrjwUBvdltd7F02tLsZ
	 wosD9OSRfOlJlv/WMJ2Tf/e4NP8sdwCsdhzyEwTtdnZExI4lPE+qZmq0HdS2BJFb4rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794818868;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Last-TLS-Session-Version;
	bh=qs1+XyJIBcRXvNK4eAjtS4NGdjhzHm1jJtJ5wQ/HE4A=;
	b=Veo+XTwlZhEwjWzeVQOHz8eAKSTz6RLgJTXLzqUDk4wa148ZeJaf1x2BoR3/BcdazmFO
	 FzNAFhl3/3FDX+5yzfRzdgnIO34/Xn35oqFko9705DFNMVyuX0luf6mKctZeKBhMrGXOz
	 +zKDJTkJlYVCDrEIqbV+HtDrH00kqoyx3ASq53jYL+gji6+tmIWl5D3oBNxRKp4ZYWTIG
	 qE4SgHWNwBPzJpbvs3yWQvbP2XH8e+bujgNNfG580Rljo4XDrj6Bi3ZnIFyT8/8lN9jHI
	 q8yy5fSR+VgG5SvDoxGIEw/eywDWrEBWNFkW9xf3+bZ9W0U9q1jBrjpJtArUXz0me6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nabladev.com;
	spf=pass smtp.mailfrom=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=Dszj5M7U;
	arc=none smtp.remote-ip=178.251.229.89
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C88606A31C;
	Mon, 16 Nov 2026 08:47:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17C88606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=Dszj5M7U
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9661410EF78;
	Mon, 16 Nov 2026 09:47:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1794818861;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=qs1+XyJIBcRXvNK4eAjtS4NGdjhzHm1jJtJ5wQ/HE4A=;
	b=Dszj5M7U3OEX3vPhggvupYiDIDtgJ1CjrqH5Jt0f645TpAqgjRC9P+8/lrpkHKJ+4JoiTI
	L6UReXGEDu+KJYLwUgrhEDOaOLHm8TXhzjZsjwb1Cvq8TSacvTA4Zi7CQC+V2kbXr6z2Ec
	oJYa65T0uQ1X8vP0Ux1FzzD28Tw5cWSUL3S4IYBT8R50BW7hIMwlI/8f42jVXfRI2av8Qg
	Nr8K2WPco6yYOr8L9d1lNx14IvPMRsO1EjKVZuGoVCeILnDjUDnlM/+rpDR6UfPcoSs0l3
	x6LaUOrQKikwH0C250Caia2m9t8ssLX83VmU+40Km/H10RKzqjVPiq2+uJXVfA==
Date: Mon, 16 Nov 2026 09:47:36 +0100
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
Subject: Re: [PATCH 7.3 000/507] 7.3.5-rc1 review
Message-ID: <avrDKGcdTCqA4RFn@duo.ucw.cz>
References: <20261113153753.358973689@linuxfoundation.org>
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
	protocol="application/pgp-signature"; boundary="7nLTaoNpBa1RI6kS"
Content-Disposition: inline
In-Reply-To: <20261113153753.358973689@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--7nLTaoNpBa1RI6kS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 7.3.5 release.
> There are 507 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

We get build errors here:


236
19:06:22
  CC      arch/arm/kernel/asm-offsets.s
237
19:06:23
In file included from arch/arm/kernel/asm-offsets.c:12:
238
19:06:23
./include/linux/mmap_lock.h: In function 'vma_end_write_all':
239
19:06:23
./include/linux/mmap_lock.h:604:25: error: 'struct mm_struct' has no member named 'mm_lock_seq'
240
19:06:23
  604 |         if (unlikely(!mm->mm_lock_seq.sequence))
241
19:06:23
      |                         ^~
242
19:06:23
./include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
243
19:06:23
   77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
244
19:06:23
      |                                             ^
245
19:06:23
make[2]: *** [scripts/Makefile.build:185:
arch/arm/kernel/asm-offsets.s] Error 1

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/3065943408

Best regards,
								Pavel

--7nLTaoNpBa1RI6kS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCavrDKAAKCRAw5/Bqldv6
8ul/AJ9f+PnOukZPzcN2ZHZtw9cnclNmZACeMOiCeO2h+nlj4rHyzyH6uojigtI=
=Qmfa
-----END PGP SIGNATURE-----

--7nLTaoNpBa1RI6kS--
