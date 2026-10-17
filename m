Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A03D24BBEE;
	Sat, 17 Oct 2026 23:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792279707; cv=none; b=aW/nVItT1S5C01YPDAe7fJrck3WgqLWKYLtmgn+/wILkakUOVVKgzNA1PYQeSDbJUeh2VH/2ETfNV4s7nqxzzyGxmYxAtQnHDLvK0RmMw3De5exdSI57HSBCxN33D58z+L7oejE0WU0Dycj+3PrCn2ExB6PCTGMkGcwQugp1vm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792279707; c=relaxed/simple;
	bh=k5zWeJXJEurOnDhHsF93exBiSxJgAlW9SNVyvu9qQqU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V+57vz9rYLhs3PTjbcVlc2CM3EGmKaYJtK3R+fLfO0b7/jFuo+ERr7jQeMWwIk2oHrsApYNry0+yDCieid/pwkVerLii1LBiyVHOWCdzJAi8Nl7V/NOk33oIn4GC5Ajrf4ozbOoCEXP1m2faitw7dRKaeHAzmSOMGoqbVEcyVho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/DF35Yw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/DF35Yw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4021F000C4;
	Sat, 17 Oct 2026 23:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792279705;
	bh=qRc6XunMlGQk8dxay7+/4etC+5Ns2lA5EHpNlyAI7pk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=C/DF35YwBaO+K0nsPc934z0kRUdiEuFW3LRHOKyrW/esIxV5j19FNloYHGt3JBWBw
	 sMr65974v6zEOL6ZeShmB+y5m9u275s9Nt8rBEeS1RJqAQeIzvxRcRDUQpXlYgLG1Q
	 FtpreyIzpYCIkBUeVHC14rdw8DqposRf2HV9CCTnj34nkC0RuY8HU7rg5lknVeL/d8
	 XAsyeS5sO0qrvBok2SGjljb3Kwg2yYP5FyTUSMGJR34rHFI9sKxIQtAW+6A/iIIRmH
	 7fuSpMEIbPTN7ooarkfxnWaHwNNk71rpyKNb0AcQlF4ZgOkeg2rHkGABEsxLv+yIAo
	 TBuVuiJXOyFDA==
Date: Sun, 18 Oct 2026 00:28:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc: Alexander Sarmanow <as@discnull.de>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Parthiban
 Nallathambi <pn@denx.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: light: vcnl4035: Fix reversed ALS mode bit
Message-ID: <20261018002822.5a5f2102@jic23-hlaptop>
In-Reply-To: <as0B1EnPqfwRO1D-@nsa>
References: <20261012144315.1678195-1-as@discnull.de>
	<as0B1EnPqfwRO1D-@nsa>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 12 Oct 2026 16:51:05 +0100
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> On Mon, Oct 12, 2026 at 04:43:15PM +0200, Alexander Sarmanow wrote:
> > According to the datasheet (table 2) the ALS_SD bit behaves the opposite
> > way the current ALS mode defines are set, writing 0 powers the sensor
> > and writing 1 shuts it down.
> >=20
> > The current driver thinks the ALS is up while it's actually shut down
> > and it's down when the systems powers it up.
> >=20
> > Fixes: 55707294c4eb ("iio: light: Add support for vishay vcnl4035")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Alexander Sarmanow <as@discnull.de>
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Mystifying how this worked for original contributor.  Maybe it's one of
those last minute edits that went wrong.

Anyhow, applied and marked for stable as what you have matches the datasheet
and you've tested it so it's not an issue with a wrong datasheet.

Thanks,
Jonathan

>=20
> > Tested on a Raspberry Pi 3B+ with a VCNL4035 on I2C, running Raspberry
> > Pi OS downstream kernel 6.18.50. Checked with i2cget that bit 0 of the
> > config register 0x00 is 0 while PM runtime resume and 1 once it's
> > runtime suspended. Also builds cleanly against iio/testing.
> >=20
> >  drivers/iio/light/vcnl4035.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
> > index ce1bd42b0c7c..f1cc75245001 100644
> > --- a/drivers/iio/light/vcnl4035.c
> > +++ b/drivers/iio/light/vcnl4035.c
> > @@ -44,8 +44,8 @@
> >  #define VCNL4035_DEV_ID_MASK		GENMASK(7, 0)
> > =20
> >  /* Default values */
> > -#define VCNL4035_MODE_ALS_ENABLE	BIT(0)
> > -#define VCNL4035_MODE_ALS_DISABLE	0x00
> > +#define VCNL4035_MODE_ALS_ENABLE	0x00
> > +#define VCNL4035_MODE_ALS_DISABLE	BIT(0)
> >  #define VCNL4035_MODE_ALS_INT_ENABLE	BIT(1)
> >  #define VCNL4035_MODE_ALS_INT_DISABLE	0
> >  #define VCNL4035_DEV_ID_VAL		0x80
> >=20
> > base-commit: a22dc7ebb21a6bd4c8b63bc2c1dd46a24945aae7
> >=20
> > Best regards,
> > Alexander
> > --=20
> > 2.47.3
> >  =20

