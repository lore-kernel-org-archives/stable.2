Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D133FAE1A
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 08:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783497717; cv=none; b=ZkZAc3OMGKW5SKuLMkDcX4xWRgTFe4lHULYjNOFHvBSqkAe6bVbXnWFK1Bxa3pnuulNfEFrwhjHf42EQqil5pOlOI0YUsny1DwkcqHTmCqy+ZODobT+9tlDia4ElhF7VB1e8GrlXc+fwMd/hH+JHoUJ4eETjO4T4LmA7tvFzkVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783497717; c=relaxed/simple;
	bh=doJnDt3o58uL+BR3TBRqwuwi7Zn1tsai9cOZ4qWtNJM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kwO2E36TyxO0Bm2Iy+l2Y9iG5E+ee+ZppSdPcVRTFY4WAMmaVpDzYXsRUTaCdgulEUgNp7aegP4apGMtb2oP1pkv3jyEmMWYzvXzwHti7bvr5M1pu97TVC1Kst62T/cES8J12d4oWpcsjRBKJ891KwnkYlF82+Ot+iHoXR61i/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMcAr30T; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMcAr30T"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47362928f65so319983f8f.2
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 01:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783497712; x=1784102512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTtgga4TZLikFNZUSbCVcQ/U5UwEfA90+Dcxj1wQA0o=;
        b=OMcAr30TrnqlYZQcRi7VvxvGLri8OYvb+qOrNXi+nGbN1HSn77XFUAAIIkgAsq+IAT
         bsLeA4ySuG1luN74YSwXNhDt3pFtX9MG2CN9VxeuFc1ZraZaz+lzsnKiVok/pU4DvtHO
         w3oIu9/IXipDO/YimO39ONhw+H8GaytWv6krn1Ntl3uY/BNtCjYC4t7gMvKTgH124pAM
         4dZVcvyYstAO+5Oo6tEhXxhTzPJBPmPlt3/g0EZfGY43r1QVu74NMgqdNe4Np0KAq+0F
         MiI1iCaqzdygGUJS7o3/OrCsOy32CRKPuwi0YoBFnKvWILtqXhZ6/32BoDLS4PSdos9V
         9hgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783497712; x=1784102512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VTtgga4TZLikFNZUSbCVcQ/U5UwEfA90+Dcxj1wQA0o=;
        b=RZsXFoHy9l1wzxenktn9nJJSPOYEUX7h+bRGb9I6xVy3sHFra6NVgJZvjSYig2zVUz
         pZzdIavBKICQm0ROiVQ6rXzfRh4b0VP37lyVE0U9TPhxm5LQTtwuuemVcCtlhV5jP+S+
         LGJ2B0eogNy/f5c159DYrSy1/TFSnlO/o3x0szqTl9FS1NHQ78EqjQkGJfFx5WcOdHa/
         YHKzFP1ddyQ080WWXXXJOT3fEzsIshosQvvTd4747K18NysS51WyK3AzBpeX91jUccZ3
         r5Iuf5/DqPp7svExy04BH8PkUSXwntCkHt0ZMug3eB+F2qqfd6/zz4kQC4rGyiW9Jdsk
         JEvA==
X-Forwarded-Encrypted: i=1; AHgh+Rog255Ru9mLl+J2Wusp01NU6XVy8EuBulblpGs+DrzeAJWqoz53GGZlw+Z5kVJZ0ZzmCD9+Dkc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0W5xgH7Xg5ppmk4Qoe/156v0Olr/rtfLJcUFXN6tTK4KXyGWU
	M9ouBFTv4L/49okJ0vrxyxNK76PjvPNwL2zOvDdQsjXQOWuyXng8bv/2
X-Gm-Gg: AfdE7cmbFEaxoGg6Iz+GO/LoB3KFYQOLtvSNs4kX8Ng+SJGbPU0/ZU16G4omuy7F22U
	/GCsnsSeaz4h8Q8+8AutFz2OLGyhzFXMAOkVN5EgkdEKzyB6+TBVJJg0m3ivy25jkDYC8HF6MG/
	vpluTXw87K1sBBAxXWR+eGh1p/+7Jrtqenn1QLv3jCAH76yGDgoEeHYoqBKIXAzhkPaXSOVO4yQ
	tRrOmng/nC01oV+Xcl+SCA3VZqr1ngP2bkyc+iCG8bBINkputxWh4+ITJ+nCJjZ2zeo3VlMgO9V
	FdW56DpKHDD7CqDcKFaVceRxV1KV4jnARFuyu9fY9OAtOtnKcY3T8+dUcbW6kSIcQrcwxkwnAsT
	c525TTsVyhV60dt86VuW42isRtRFTBlnohoOL2hAqsetUxub9JfR2HHCblAJLOhvZC5auR6uver
	ai5w4IIBMdaftI1wnwEjQM0hx/3b9Ah8V4zXRphX9atQaqCSrZKk24OZFO6eQdv1ObyHIeIzyYf
	J50LKtxl/xUMcwHe9+JL8z31UmfIE6NFjyxdK4jcHVeRrv450pTVik53pAKXKiKyNaXAHGhlX+6
	eC90Es0Gxhhdl6Sm+X7gwfD3ZOjERnZyLJX2zPSstvrJVtqx7Uv/QZH1m4OQYQ8QHjZ7pz5zY59
	aeI+fI35UG6x/xiOAhLvG71k=
X-Received: by 2002:a05:6000:2381:b0:475:d10d:b582 with SMTP id ffacd0b85a97d-47df07a5375mr1374409f8f.39.1783497711696;
        Wed, 08 Jul 2026 01:01:51 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039ae44sm39114212f8f.23.2026.07.08.01.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 01:01:51 -0700 (PDT)
Date: Wed, 8 Jul 2026 10:01:50 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Stefan Popa <stefan.popa@analog.com>,
 Julien Stephan <jstephan@baylibre.com>, Ivan Mikhaylov
 <fr0st61te@gmail.com>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Marilene Andrade Garcia <marilene.agarcia@gmail.com>, Kim Seer Paller
 <kimseer.paller@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/3] iio: adc: add missing 'select REGMAP' to Kconfig
Message-ID: <20260708100150.00002436@gmail.com>
In-Reply-To: <ak4ApBBYdyVNd1Al@ashevche-desk.local>
References: <20260708-add-missing-regmap-v1-0-6d424322e3d4@gmail.com>
	<ak4ApBBYdyVNd1Al@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 8 Jul 2026 10:47:48 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Jul 08, 2026 at 07:34:11AM +0200, Joshua Crofts wrote:
> > This series adds missing `select REGMAP` and `select REGMAP_I2C` to the
> > AD7380/MAX34408/MAX14001 Kconfig entries. Without these, some builds
> > may result in a failure. =20
>=20
> > Steps to reproduce build failure:
> > 1. Run `make allnoconfig`.
> > 2. Run `make menuconfig` and select I2C/SPI, IIO and any of said driver=
s.
> > 3. Run `make .` and make will end with regmap-related errors. =20
>=20
> Repeating same mistake from the previous similar contribution. Where is t=
he
> actual excerpt of the failure? Please, provide one.
>=20

Here is one of the several errors when compiling.

drivers/iio/adc/max14001.c: In function =E2=80=98max14001_probe=E2=80=99:
drivers/iio/adc/max14001.c:315:22: error: implicit declaration of function =
=E2=80=98devm_regmap_init=E2=80=99 [-Wimplicit-function-declaration]
  315 |         st->regmap =3D devm_regmap_init(dev, NULL, st, &max14001_re=
gmap_config);
      |                      ^~~~~~~~~~~~~~~~
drivers/iio/adc/max14001.c:315:20: error: assignment to =E2=80=98struct reg=
map *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from integer withou=
t a cast [-Wint-conversion]
  315 |         st->regmap =3D devm_regmap_init(dev, NULL, st, &max14001_re=
gmap_config);
      |                    ^

Funny how I essentially copied the cover letter from the series where I add=
ed
missing IIO_TRIGGER_BUFFER entries to Kconfig - to which you didn't require
an example build error :-)

Shall I do a v2 or is this reply enough?

Thanks

--=20
Kind regards

CJD
