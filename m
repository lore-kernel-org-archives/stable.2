Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795022232;
	b=0/ius5zOCgi3imuDoH2Vgv8zpOt8U1727SturCJU2p+b7pH3Q2QNxyfRYCCPwIhS9Y5I
	 HnGvEa0Slfrk++kQe4hkZh3FMS7WCmR6ihJyts80N1kJsgg6FXrPQeBU/VCBKETpXnQ7q
	 Wef+3nu13XIJqxPG0cbKMmgIRqzi/ttPJACQo/jmqJKgLpcjwXYy6me9jacZv8rD+jbEf
	 IOt96O8d0bWDGk2Am+hGVzEflal14EUjAckvgjZeBx3dYHtZ9g/PRrv1bKHzAXXOrPKX+
	 IuAz6DrWJC+hlpD4u3yw5RR3LqEDzGNnAh0PvKeS/zT1TeS/jfPjUmE/aVOuUxHfetA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795022232;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Last-TLS-Session-Version;
	bh=JwzpYCQn/l6SzPxUmJU+YOvPOIewTFubouB7LMjAbDw=;
	b=F3d3f+5PkgybUGU/GEmVZN4iSogDAsk4mLQDkriPdnXGuUpgAa0+uKh0poUK6Ebir6GA
	 30LGVxhXSMrhW9mJ+SvJjOvwhtrypqknI2Ed9JE+l45LYZbJRIOM2ZE9efUvCAjn5d9mR
	 PyL8UuCvw5iNSdvyB0KOwXKvT/ObfnpNIfz3Gu5b9LnkOhEY6L8qDQjU34r+CBCbQU3E+
	 tVBBfrZ36j3KzINNCl81XIDok6bwLF7Krep5W8ROOWXhWvc1CMUOpTFYA3J5bDbA4Vdfj
	 hmC+qYuzdtN4rih8P7Nhj2rlKfQuH436aZvhdrVzuYhQPxrdth02kqYWFAlebE5gzqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nabladev.com;
	spf=pass smtp.mailfrom=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=Aqj4Nd3U;
	arc=none smtp.remote-ip=178.251.229.89
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40155606A325;
	Wed, 18 Nov 2026 17:17:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40155606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=Aqj4Nd3U
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9139410F9C1;
	Wed, 18 Nov 2026 18:17:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1795022226;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=JwzpYCQn/l6SzPxUmJU+YOvPOIewTFubouB7LMjAbDw=;
	b=Aqj4Nd3UXK6bUXOvekAurpfgjdH9vJkpCCH9Bi4tIJmpUPYZrCpfhCLd8XpNIqI/ggVwlK
	hXVg+6Fee6pK/KuQUUpLlW5+AMQPoft6PVMlzHj+RZZ386dkRxO09ExAgUjRDcKhtLgwXd
	LvmVfYZ5tXLERMBkiOFeO0T/KDzHIknZuTrRdVhDdGRgk66HlouamyWlU+otR0Tzozjas8
	OU+FZERbZ0O+DlLmxt2MAxD4oYrHep2W3DcGSPJBBlWXL5UXaSHUne8NhiEi3VhtCmciqJ
	y2lDlYyfVzUl0oTJUuis2dHJyqKOidmKq2Ux8oRCvELUAw4BZgYcp3phFUNqkQ==
Date: Wed, 18 Nov 2026 18:17:02 +0100
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
Subject: Re: [PATCH 7.3 0000/2651] 7.3.6-rc1 review
Message-ID: <av3djrju6lGWQD9K@duo.ucw.cz>
References: <20261118150247.972732815@linuxfoundation.org>
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
	protocol="application/pgp-signature"; boundary="H5QXGylTV+YzbXtC"
Content-Disposition: inline
In-Reply-To: <20261118150247.972732815@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--H5QXGylTV+YzbXtC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 7.3.6 release.
> There are 2651 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

We see a build failure here.

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/3084792704
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-7.3.y

Best regards,
									Pavel


In file included from ./include/linux/device.h:31,
1965
16:37:20
                 from ./include/linux/pci.h:38,
1966
16:37:20
                 from drivers/pci/controller/pcie-iproc-bcma.c:8:
1967
16:37:20
drivers/pci/controller/pcie-iproc-bcma.c: In function 'iproc_bcma_pcie_probe':
1968
16:37:20
drivers/pci/controller/pcie-iproc-bcma.c:72:45: error: 'devm_pci_alloc_host_bridge_release' undeclared (first use in this function); did you mean 'devm_pci_alloc_host_bridge'?
1969
16:37:20
   72 |         ret = devm_add_action_or_reset(dev, devm_pci_alloc_host_bridge_release,
1970
16:37:20
      |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1971
16:37:20
./include/linux/device/devres.h:181:41: note: in definition of macro 'devm_add_action_or_reset'
1972
16:37:20
  181 |         __devm_add_action_or_reset(dev, action, data, #action)
1973
16:37:20
      |                                         ^~~~~~
1974
16:37:20
drivers/pci/controller/pcie-iproc-bcma.c:72:45: note: each undeclared identifier is reported only once for each function it appears in
1975
16:37:20
   72 |         ret = devm_add_action_or_reset(dev, devm_pci_alloc_host_bridge_release,
1976
16:37:20
      |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1977
16:37:20
./include/linux/device/devres.h:181:41: note: in definition of macro 'devm_add_action_or_reset'
1978
16:37:20
  181 |         __devm_add_action_or_reset(dev, action, data, #action)
1979
16:37:20
      |                                         ^~~~~~
1980
16:37:20
make[5]: *** [scripts/Makefile.build:290: drivers/pci/controller/pcie-iproc-bcma.o] Error 1
1981
16:37:20
make[5]: *** Waiting for unfinished jobs....
1982
16:37:20
  CC      net/core/net-traces.o

Best regards,
							Pavel

--H5QXGylTV+YzbXtC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCav3djgAKCRAw5/Bqldv6
8t3IAJ4gVZa3TvIWdbjNlHQPDinSgvZDZQCdFLuooXCOwJRDwnLV9vG60+uD/qI=
=LORK
-----END PGP SIGNATURE-----

--H5QXGylTV+YzbXtC--
