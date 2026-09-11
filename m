Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDEE41D4D4;
	Fri, 11 Sep 2026 08:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789114173; cv=none; b=WLwv8KTKJ/IAn3LPSz1v1KGUR2B1dvO9a9k8zxCTgaHfarW2e8zE7aaMjQOyJV2jids+5Tnv85FOguvJSm4YzEKBLoiTNqM79N7eNXinHmqq19pbpiVtes/2b59mRbc8wwJADtx3FJ1jRh6r+eOfFPuw4ERFKSnhTtQTvWZGp/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789114173; c=relaxed/simple;
	bh=OZi94MFbn80qGqeWjmm68L+x49CK/AaA4m52GJkAl0U=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:Cc:
	 References:In-Reply-To; b=eCFAfvZwjXj4n/x6BlMTWUBmPzFgIG2gC3Pb5IhaX4mAV4FdR4BMDci7eDoQY9AhWPO1BQ7g6JowiSZ1UTC9afNkh6h1cNW94BDp0t30H+zyPFLUMotvcwZE8RoW3lkb+Byvm4QuXx2QjI5xv2BLB5iAWcOMAhFqliNm7nmNkco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABkeFsR8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABkeFsR8"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 891FE1F000FF;
	Fri, 11 Sep 2026 08:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789114171;
	bh=C/bSmY3dussktX4XXEfGa3xLo4YHGuzrmx2ufGQXu50=;
	h=Date:From:To:Subject:Cc:References:In-Reply-To;
	b=ABkeFsR8RRtD+1Vun7xe2fHSqIREw+siG1VKDK5hpnMUXpt1K7U6LtxHk5CemAhUL
	 LdL0DB/Pr1jruWSxvsbxvmZWj5AmCUKL02hbBfNzBeh+e1rQV+HbJptlmWsEleWIuK
	 v0imTqdKQOPCLlEzh9ydJEuhI+n3MUvuddeDz4oRoC4Op3yn9mYITdPiwnIXOXkMbD
	 7fsL5gnZsdWi+lAPXOz/okxISoYki7JaaiqvToDp+A59tKocMGyJOIi5dbZ92Oc2Rk
	 wlKDjLC+fqA/35sVoiXCVSqgGp+Il4WMNupgM6z3l6hqW/Y++9U/ol/lYM1dvm9Bie
	 rskzWyquJKolA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=450039049a878f99262beedcb50f43df13d2c89635805f68d2b59f1390f8;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Fri, 11 Sep 2026 10:09:27 +0200
Message-Id: <DLCC1HX0HX8Z.1X4CEDDDVRQ58@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Sanjaikumar V S" <sanjaikumarvs@gmail.com>, <pratyush@kernel.org>
Subject: Re: [PATCH v5] mtd: spi-nor: Fix SST AAI write mode opcode handling
Cc: <hd@os-cillation.de>, <linux-kernel@vger.kernel.org>,
 <linux-mtd@lists.infradead.org>, <miquel.raynal@bootlin.com>,
 <richard@nod.at>, <sanjaikumar.vs@dicortech.com>, <stable@vger.kernel.org>,
 <tudor.ambarus@linaro.org>, <vigneshr@ti.com>
X-Mailer: aerc 0.20.0
References: <20260331095026.38-1-sanjaikumarvs@gmail.com>
In-Reply-To: <20260331095026.38-1-sanjaikumarvs@gmail.com>

--450039049a878f99262beedcb50f43df13d2c89635805f68d2b59f1390f8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Mar 31, 2026 at 11:50 AM CEST, Sanjaikumar V S wrote:
> From: Sanjaikumar V S <sanjaikumar.vs@dicortech.com>
>
> When the SPI controller lacks direct mapping support, the fallback path
> in spi_nor_spimem_write_data() uses nor->write_proto based operation
> template. However, this template uses the standard page program opcode
> set during probe, not the AAI opcode required for SST flash.

So it looks like that mtd->_write override in sst.c is rather
hacky..

> Additionally, controllers that do support direct mapping will also use
> the wrong opcode since the dirmap template is created at probe time
> with the standard page program opcode.
>
> Fix this by:
> 1. Checking the nodirmap flag in spi_nor_spimem_write_data() to ensure
>    the code falls through to spi_nor_spimem_exec_op() path which builds
>    the operation at runtime with the correct program_opcode.
> 2. Setting nodirmap=3Dtrue for SST AAI devices in sst_nor_late_init() to
>    disable dirmap and force the runtime opcode path.

I'd be fine with disabling dirmap support as a workaround. But I'm
not sure if we are supposed to change the nodirmap property as that
is a property owned/set by the controller.

Could we just compare the mtd->_write =3D=3D spi_nor_write and then skip
the dirmap support? With a big here be dragons warning.

-michael

--450039049a878f99262beedcb50f43df13d2c89635805f68d2b59f1390f8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaqO3NxIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/gjMwGA5E7TquopeYXl0SpjG/PWzgt0kUtU/ZoQ
uzs6pbnl1rGqJR84IXbMXDJGThX4Udh8AYDu9tBGaN9gWgZdAdaYkjYte1mBv8w4
uvUdV+6z5WEYqoZDxG/J67/LhpXNUcHEdi8=
=4Zdr
-----END PGP SIGNATURE-----

--450039049a878f99262beedcb50f43df13d2c89635805f68d2b59f1390f8--
