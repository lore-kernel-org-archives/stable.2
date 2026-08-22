Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE2A2AD16;
	Sat, 22 Aug 2026 23:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787442031; cv=none; b=R3GCEMpYWk6YBYcqV8nEGdqajgZD9YiVamtb/GF3j2WEb50yhPqfuvhp+/gV+80GMkFuaTWFXA9WXgHesk7yBJGYMr+Gr0PnWmkyrb0CxSKJOwZJos0JNO25/SzSZhaKb+ep07rcTBRXlfu/0rc0gNnA3DTm+aWnxFG1hpCjOWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787442031; c=relaxed/simple;
	bh=tF8pbehjvMr0dbmBxgUWBZ9fGWUHNSadv/jjbzYHTCA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PV8NFNsThEhJCXoxi5BNe7wcbkoVYxtlidlN2zN8gkK/K5+BUkxS5RSxSZXfjya2DrQyq7rDFjqbLZtjs95eZxLpOz035zoQASMMmnjRRqmhYtJYyp9Bhf12kxOjlMNosev+Hh7dRvVbfMydJdlhYvU2wcW8j+omaCYcgUW6Dcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJBAfv5d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJBAfv5d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216941F000E9;
	Sat, 22 Aug 2026 23:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787442030;
	bh=HROfVkva7hHBdqL3WqOpsBymtuCEZV9xgp7Kerg19h0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CJBAfv5dV+ntxDmL8j+YnvPltI722v47VzipMerU4gw6r2YwQbCBTplsw+HXeuzKF
	 /kWUx48HWjhP+ZovEJSN0qimFjB/3uWvODCTsqPOFwRjlMDaPVGxI41pD6TptVO5ew
	 GtCT1eaJZfloc5s/FsdJbMUWH2rYY3sRTWV7snhY883MFqpKk2yCB1s1kJBkTsX7Dp
	 dSWJ5SCPaxEWL0oX4cqH1RJXj/RhWhBbxhKDa4m5ss2GnEtGw/bAWggLmBosEwI3D1
	 H8nBj1ncKtMADL8u2NeYSPQ6w/5zg41K3jrhQz/9XOgrwPcSb4f5bwNtsN+BF+5lCz
	 tDAWKxN8geZUA==
Date: Sun, 23 Aug 2026 00:40:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Esben Haabendal <esben@geanix.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nikita Travkin <nikita@trvn.ru>, Maslov Dmitry
 <maslovdmitry@seeed.cc>, Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>, Thomas Gleixner
 <tglx@kernel.org>, Pan Chuang <panchuang@vivo.com>, Yangtao Li
 <frank.li@vivo.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski
 <krzysztof.kozlowski@oss.qualcomm.com>, stable@vger.kernel.org, Andy
 Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v5 0/8] iio: light: ltr501: Add ltr329 support
Message-ID: <20260823004024.015d66bf@jic23-huawei>
In-Reply-To: <20260817-liteon-ltr329-v5-0-6f71ab2b0588@geanix.com>
References: <20260817-liteon-ltr329-v5-0-6f71ab2b0588@geanix.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Aug 2026 19:08:49 +0200
Esben Haabendal <esben@geanix.com> wrote:

> The LiteON LTR-329ALS-01 chip is similar to the LTR-303ALS-01, except for
> interrupt support and related registers, which LTR-329ALS-01 does not hav=
e.
>=20
> Signed-off-by: Esben Haabendal <esben@geanix.com>
With tweaks to patch 4 and dropping 5, applied to the testing branch of iio=
.git

thanks,

Jonathan

> ---
> Changes in v5:
> - Changed error handling of interrupt being configured for ltr329 device =
to
>   just print a warning message and get on with life.
> - Mark interrupt properties as invalid for liteon,ltr329 bindings.
> - Changed patch 5 to not claim to be a fix.
> - Link to v4: https://patch.msgid.link/20260810-liteon-ltr329-v4-0-8bd3df=
d15280@geanix.com
>=20
> Changes in v4:
> - Split the duplicate error message removal into separate patch.
> - Removed uneeded enum =3D0 assignment.
> - Use dev_err_probe() instead of plain dev_err().
> - Link to v3: https://patch.msgid.link/20260804-liteon-ltr329-v3-0-c6b768=
c7c745@geanix.com
>=20
> Changes in v3:
> - Removed duplicated error message on devm_request_threaded_irq() failure.
> - Added Fixes: and Cc: stable tags to fix for error handling of
>   devm_request_threaded_irq() failure.
> - Added no_irq_support boolean to simplify checking for chip irq support.
> - Moved check for no_irq_support from ltr501_read_intr_prst() and
>   ltr501_write_intr_prst() to callers. Note: event functions are not
>   registered for no_irq_support devices.
> - Moved #include <linux/array_size.h> into its place according to
>   alphabetical sorting order (although the rest is not really wel sorted).
> - Restored alphanumerical ordering of compatible list in bindings
>   documentation.
> - Ordered device arrays and enum values according to alphanumerical sorti=
ng
>   order.
> - Link to v2: https://patch.msgid.link/20260715-liteon-ltr329-v2-0-d18af5=
5edab5@geanix.com
>=20
> Changes in v2:
> - Fixed error handling when irq is defined for a chip that does not suppo=
rt
>   irq, powering the chip down again.
> - Added simlar fix to error handling of devm_request_threaded_irq() error
>   handling, powering the chip down again on failure.
> - Added explicit #include <linux/array_size.h>.
> - Link to v1: https://patch.msgid.link/20260715-liteon-ltr329-v1-0-31f027=
051594@geanix.com
>=20
> To: Jonathan Cameron <jic23@kernel.org>
> To: David Lechner <dlechner@baylibre.com>
> To: Nuno S=C3=A1 <nuno.sa@analog.com>
> To: Andy Shevchenko <andy@kernel.org>
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> To: Conor Dooley <conor+dt@kernel.org>
> To: Nikita Travkin <nikita@trvn.ru>
> To: Maslov Dmitry <maslovdmitry@seeed.cc>
> To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.co=
m>
> To: Thomas Gleixner <tglx@kernel.org>
> To: Pan Chuang <panchuang@vivo.com>
> To: Yangtao Li <frank.li@vivo.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: linux-iio@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
>=20
> ---
> Esben Haabendal (8):
>       dt-bindings: iio: light: ltr501: Sort compatible enum array
>       dt-bindings: iio: light: ltr501: Add missing ltr303 compatible
>       dt-bindings: iio: light: ltr501: Add ltr329 compatible
>       iio: light: ltr501: Power down chip if request irq fails
>       iio: light: ltr501: Drop duplicated error message
>       iio: light: ltr501: Add ltr329 driver support
>       iio: light: ltr501: Fix sorting order of device arrays
>       dt-bindings: iio: light: ltr501: Make proximity-near-level conditio=
nal
>=20
>  .../bindings/iio/light/liteon,ltr501.yaml          |  32 +++++-
>  drivers/iio/light/ltr501.c                         | 114 +++++++++++++--=
------
>  2 files changed, 101 insertions(+), 45 deletions(-)
> ---
> base-commit: 075b74841bd0065a3bda3440873c747938e69b68
> change-id: 20260711-liteon-ltr329-a3eb12414866
>=20
> Best regards,
> -- =20
> Esben Haabendal <esben@geanix.com>
>=20

