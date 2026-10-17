Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A188D3AF666;
	Sat, 17 Oct 2026 18:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792260912; cv=none; b=ZFTpHb5q78oo8sIwzPF0MbvlXkMqWojvPNnVWbstZfcxVlw740nbXIyLYi8E68CFojMMuvuD64op/dX8uBWiuOle9xbOpYFMJNr+LTJR5uYen746EQqpkFiilp+wQPmx9BmCT23LXg6JB1XrOQMpGdk3A6g4bloxFEmqbROD5Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792260912; c=relaxed/simple;
	bh=w5l7AZoel6Uf3sXVPO0QyL8QcG7bxfsLhXR0D1M2iIY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IbYXrwCcStMoK9bcudNI6Fto1t8die9OeIL4MAmXyv0ZoMKVj4LeukaV7/zjAiUnzpZhvqMfP6v1McVegEcWZJ6dNm7wa5o1annfN/3FvTYqaX6iCGUZYoNDBMrNgPe7fLxSBVUPVt01gudqSNZNoVlDU1NaNtGOj1Rmvi0BvYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BM3YyAIw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BM3YyAIw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22BA1F000C4;
	Sat, 17 Oct 2026 18:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792260911;
	bh=4znjinCLcqPzFE0R8FB/ik0uww9KW27iFqq3XzpkYl0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BM3YyAIw1goCY7dMBhIt1OVCTawJ09Qakto1ZAD+9EYSmdA81ggm2OioShJDrrBWO
	 ElrVX9gMaAJgPXYZCm3FIYuUiSWJxZ2LEuKG/BLqhlM5L0yBC+2JWa7fG/bi/EtI/r
	 4cLrL1TYfqMjeCBBSxklP6v8/9q72bIVHpcBh6hT4aTkxwuH/U1EtYMop7wzL5/6Sr
	 1kbuYm8+zGIbMElvcAK01+j3V03QPkjySHwHibyzY4wZyWNG9H3PSnEzbzsleEj/5E
	 zkRq5ojBASRqPl01bmCY32+gIRmApsq8Q5Hu9kP7gM2c2IWqUuLt4B/MO1tHttvCD9
	 kX0fRKjhHKC1g==
Date: Sat, 17 Oct 2026 19:15:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc: BouziguesAlexis@johndeere.com, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lothar Rubusch <l.rubusch@gmail.com>,
 linux@analog.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: accel: adxl345: select IIO_BUFFER and
 IIO_KFIFO_BUF
Message-ID: <20261017191505.3668b209@jic23-hlaptop>
In-Reply-To: <as3zHnUUTcpJl9Zi@nsa>
References: <20261007-fix-adxl345-buffer-deps-review-v1-1-0c94c8d0443a@JohnDeere.com>
	<as3zHnUUTcpJl9Zi@nsa>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Oct 2026 10:00:35 +0100
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> On Wed, Oct 07, 2026 at 09:34:16AM -0500, Alexis Bouzigues via B4 Relay w=
rote:
> > From: Alexis Bouzigues <BouziguesAlexis@JohnDeere.com>
> >=20
> > Since the addition of FIFO watermark support, adxl345_core.c calls
> > devm_iio_kfifo_buffer_setup() and iio_push_to_buffers(), but the
> > ADXL345 Kconfig entry does not select IIO_BUFFER and IIO_KFIFO_BUF.
> > Building with CONFIG_ADXL345_I2C=3Dy and CONFIG_IIO_BUFFER=3Dn fails to
> > link:
> >=20
> >   ld: drivers/iio/accel/adxl345_core.o: in function `adxl345_irq_handle=
r':
> >   adxl345_core.c:(.text+0x145c): undefined reference to `iio_push_to_bu=
ffers'
> >   ld: drivers/iio/accel/adxl345_core.o: in function `adxl345_core_probe=
':
> >   adxl345_core.c:(.text+0x1db6): undefined reference to `devm_iio_kfifo=
_buffer_setup_ext'
> >=20
> > Add the missing selects on the hidden ADXL345 core symbol, as done for
> > ADXL367, ADXL372 and ADXL380, so both the I2C and SPI front-ends are
> > covered.
> >=20
> > Fixes: cf04212d1fe7 ("iio: accel: adxl345: add FIFO with watermark even=
ts")
> > Assisted-by: LLM
> > Signed-off-by: Alexis Bouzigues <BouziguesAlexis@JohnDeere.com>
> > ---
> > Add the buffer selections required by the ADXL345 FIFO support.
> > The shared core symbol covers both I2C and SPI frontends.
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied to the fixes-togreg branch of iio.git.

Note I'll rebase that on rc1 (once available) before doing a pull
request.

Thanks,

Jonathan
>=20
> >  drivers/iio/accel/Kconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> > index 4094299e2ed8..fc130854af71 100644
> > --- a/drivers/iio/accel/Kconfig
> > +++ b/drivers/iio/accel/Kconfig
> > @@ -61,6 +61,8 @@ config ADXL313_SPI
> > =20
> >  config ADXL345
> >  	tristate
> > +	select IIO_BUFFER
> > +	select IIO_KFIFO_BUF
> > =20
> >  config ADXL345_I2C
> >  	tristate "Analog Devices ADXL345 3-Axis Digital Accelerometer I2C Dri=
ver"
> >=20
> > ---
> > base-commit: 7b63ef2d55f24519e7e9e5f4d15dbea03f126e40
> > change-id: 20261007-fix-adxl345-buffer-deps-review-69a214e05dca
> >=20
> > Best regards,
> > --=20
> > Alexis Bouzigues <BouziguesAlexis@JohnDeere.com>
> >=20
> >  =20

