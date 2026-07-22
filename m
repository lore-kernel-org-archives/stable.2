Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE6838F25F;
	Wed, 22 Jul 2026 15:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784734445; cv=none; b=atEptr17Y3vxfc/glbqVIKQOOkqhw1MBFZBiVi8njFMGKMHXUQBYxoXVnKsXDOKLY2Q2irtiGLsGht6FokGd5Pdfkw381X19hBxq5PwMq+D2qQkMf9xWbrE6pMJygWIuSC6AY5SJbkyyYni9+frlRbiUJm7s6wY5baBi4b/P4uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784734445; c=relaxed/simple;
	bh=Wj3iGHaFHk5cmK4MBcrZslWG7a1FtT47wL16Mc7fWzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eAQNIkOzQJAjHRfNPq+Qj8HnIqKszniZXYuSddt/ZjTkkycd/Bwa0j/BWxqMeXOHwPR3Jg0Fw3t4vJPea+KNRjsYhsj/kJEAYlcO9wweWlXNr/f+kc1k0Y6u12m21g9wgLfcgI+ObIt/pb0npRgVZnSVHGg6Nc21Z7kJfGoas50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6w3Kc/V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6w3Kc/V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225B51F000E9;
	Wed, 22 Jul 2026 15:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784734444;
	bh=Wj3iGHaFHk5cmK4MBcrZslWG7a1FtT47wL16Mc7fWzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U6w3Kc/V9lFKzM7M50hu3gsJsv9eztCwL+e8kF0iB8S8EAeV/x7mU0Zhr/uDV5mcC
	 ELIFTU80sM+NkKNmlcXWqx+QATpoHz9oqxOSfkKW4a+TVr5jx3HZ/xjGXbLMROIPkn
	 iAUTBsFWceWqsbXVc+WVipoS7+7uQdPHfZeYkaWaGFSEj8uCZlXZMDI/eMONUMW10Y
	 Qc/wi3D16ZDb6TXOk8TGOpFctCjVjtFYPSqkHc/7uwoc/TDguVKugQMAr2QeZdmIyo
	 2ZPWWNLhxNpLHRI1UnOrPu1eV2o/QgoL/vK3qk7TgrM1Myl9ZIEVZdiDyOBONRHRa0
	 eWkmyiT8/aEsw==
Received: by venus (Postfix, from userid 1000)
	id DD71218090F; Wed, 22 Jul 2026 17:34:01 +0200 (CEST)
Date: Wed, 22 Jul 2026 17:34:01 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, 
	jens.glathe@oldschoolsolutions.biz, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/5] usb: typec: ps883x: fixes for older Thunderbolt 4 /
 USB4 docks
Message-ID: <amDhpbdAElOpxW59@venus>
References: <20260718-ps883x-disable-usb4-v1-0-cec86d0b909e@oldschoolsolutions.biz>
 <al6-IyyWYRnEW4VC@venus>
 <al-dJjzorP-I4Yff@gallifrey>
 <al_0LjwmfW-cECnY@venus>
 <f54271f1-477e-433f-9839-e1111898088f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3cqpbpihkikroulm"
Content-Disposition: inline
In-Reply-To: <f54271f1-477e-433f-9839-e1111898088f@oss.qualcomm.com>


--3cqpbpihkikroulm
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/5] usb: typec: ps883x: fixes for older Thunderbolt 4 /
 USB4 docks
MIME-Version: 1.0

Hi,

On Wed, Jul 22, 2026 at 10:27:57AM +0200, Konrad Dybcio wrote:
> On 7/22/26 1:34 AM, Sebastian Reichel wrote:
> > On Tue, Jul 21, 2026 at 04:24:06PM +0000, Dr. David Alan Gilbert wrote:
> >> * Sebastian Reichel (sre@kernel.org) wrote:
> >>> On Sat, Jul 18, 2026 at 07:06:28PM +0200, Jens Glathe via B4 Relay wr=
ote:
> >>>> On Qualcomm X1E80100 platforms (e.g. Lenovo ThinkPad T14s Gen 6)
> >>>> using the Parade PS883x retimer, connecting USB4-capable docks such
> >>>> as the Lenovo 40B0 via a regular Type-C cable (which forces the dock
> >>>> into Type-C fallback mode) often results in working USB but no
> >>>> DisplayPort output.
>=20
> [...]
>=20
> > AFAIK only Qcom and Apple M series support it. A quick search
> > suggsts Apple used an Intel retimer in the past and a custom one
> > nowadays. From the looks of it the x86 world cannot use this driver
> > either and probably handles retimers transparently in ACPI, so it's
> > effectively Qcom specific until other vendors start adding USB4
> > support. The only thing announced potentially running into this
> > would be the Nvidia RTX Spark, which first needs to be released,
> > then find a bunch of people motivated to implement upstream support.
> > Nothing with USB4 capabilities has been announced from Mediatek or
> > Rockchip. So I wouldn't hold my breath for another user and still
> > suggested adding the machine check instead of simply disabling USB4
> > for everyone ;)
>=20
> The PS883x is used on x86 machines too.

In context of x86 I was more talking about the driver than the chip
itself. The driver can only be loaded via DT. Any quirks and hacks
in the driver are unrelevant if the driver is not used by a
platform.

> Apart from I2C, it also ""speaks thunderbolt"" - the bus has a way
> for retimers to enumerate and communicate with the routers
> (controllers) through a sideband UART-like interface. But for
> that, it still probably needs the platform firmware to program it
> into the right mode over I2C, which Linux is unaware of (as it
> effectively should be).
>
> FWIW, we do the same on X2. An MCU takes care of setting it up.

Thanks for the info.

Greetings,

-- Sebastian

--3cqpbpihkikroulm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmpg4uIACgkQ2O7X88g7
+pqwzA//fhMItCy0gKdoT+UnjnJFPyhQ7Qe4Dg9P0nmUtG+6mGJv+9aKsN1SFePx
tq+fqwvINni30JUwMfPPm8elmiUS4Y1zFyRD8FuqNxNZ4zypuQUr+wAAqNMgwhMU
wj7v6Uo6uHLoMD6iStedRHhu6YE3FBKqW2RJf83ng2tsTPX7BNPm7RLsTB4bvnUh
UO8VnpaHBFTQy2p7YknjRF/wQq2FafqONB6Q9x6H4AnGvA2CcTVguLU2rUuGr508
jHiLdoyPlBQm45aUAc5xRaDNunoqYvYvcrHbwthiMGvHvuG66POUWxzjmdE1Q71X
AvmPhezLYh5Z6I+ivrYGoB1CYWALZh7Ggs9r93bCroC4AJBIq/ZiohZ+aM+kzXJE
43SwtpKkMMK4TruD5A2W2+f6aL2edo+vOvyKCmHLvCykWvR2MUXaFvvGomEIRpzE
jgfELAWigx94VsJkK5TBTKQ9Gg2ShJexKE0fqj1JDpHVh/v30ATyUL53CZMvCL8b
Zhd8alUJQDvKb6rPm6t71VBJnLm8UKKiN8nDuRvHa5cWVrvA2mF0jN4kMMmhZfsf
2WzjXjDx2HpYcZBtDO9lEsdtaDT1S5oid7wh7LXnxeqdJSeUblVTNploMTACIA4K
kFclFiyAvHbEg5oVUPJgc8fP5Yl4YQx+3ul6IPuSEn7BGMSu+IE=
=ZoIQ
-----END PGP SIGNATURE-----

--3cqpbpihkikroulm--
