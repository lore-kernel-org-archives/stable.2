Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152D8348445;
	Mon, 31 Aug 2026 01:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788139117; cv=none; b=bLezbjdKExgUyY+8U6LoIjyuUKDC5XHDPBSD/FlEL+AxzKERT/M3rg/4rHMPL8096yJ2IwDVgo1CiQK2bHzJ6PX2VAg+U1F9bJn4BwqRuuoWRVcZFnQlynl5LfP2wGWWF0xmffg8bYk615rFu5VeIWedjWijKoxPLIrciPurFzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788139117; c=relaxed/simple;
	bh=R62aGQzTkbrTMbK+YcFb8dFuc0V81YdQHYu0jteuwFE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aFHJQPf/ynSYCogg51uPsk5dMyoF3JLMupeWLIdHDu95lhJbZCvyzt9YgFhXYEQn993/jeuC7ftawc3HjrBro8PFF7fQHSAXxFq0h6jGxeOXmGeWn6pEvH5eZ/o9OI/HLLz35XQXCSf0tH8xesFMI/6JMGpRq+co7ifKNSLpc2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LT5V5Y8l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LT5V5Y8l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C23231F000E9;
	Mon, 31 Aug 2026 01:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788139115;
	bh=3ErGGCNtqbH/4uyNbF/FHiXjcbOI5guPjt9Iu9717vY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LT5V5Y8lMaYuF8qUe3ksESx6pHvo6tS8TF8wZL14TQMa12XE6+66g8YLpDkrwhQfU
	 FmJPokOE/Kd/fQUXO6vbjQk4Bkvi4CEmPDFtaDfKfYelW4ShKdrMLWjje9ie80xBBI
	 Zxmmtt56l9BnZuRNntE1rUWlhQH/p009A8dhbad+35sp8wiYzuymXRaKFJ4aqqtacv
	 ylkFEUWlczOt4UfozvBUtqfRcx5xTlAV6ojCUAvUbWd9mbudPW5/uYitGw8XXcJlkx
	 toRUHVQ0jjAk7tN3ToElF+uIghLfJrWcma/5pXsXD4IC6uC4xIOisYVuwQZtRH0TGG
	 3RHxofQj0lZYw==
Date: Mon, 31 Aug 2026 02:18:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Jonathan Cameron
 <jonathan.cameron@oss.qualcomm.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>
Subject: Re: [PATCH] iio: inv_sensors: fix estimated value larger than
 interrupt timestamp
Message-ID: <20260831021829.5240cba4@jic23-huawei>
In-Reply-To: <BE1P281MB142668824B5EB8067F8E1034CEAF2@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
References: <20260824-iio-common-inv-sensors-fix-estimated-use-v1-1-6e93506e7e93@tdk.com>
	<aoxkI3SV4IGumncy@ashevche-desk.local>
	<BE1P281MB142668824B5EB8067F8E1034CEAF2@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Aug 2026 13:31:38 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> >
> >
> >________________________________________
> >From: Andy Shevchenko <andriy.shevchenko@intel.com>
> >Sent: Monday, August 24, 2026 17:32
> >To: Jean-Baptiste Maneyrol
> >Cc: Jonathan Cameron; David Lechner; Nuno S=C3=A1; Andy Shevchenko; Jona=
than Cameron; linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org; stab=
le@vger.kernel.org
> >Subject: Re: [PATCH] iio: inv_sensors: fix estimated value larger than i=
nterrupt timestamp
> >
> >On Mon, Aug 24, 2026 at 05:=E2=80=8A16:=E2=80=8A58PM +0200, Jean-Baptist=
e Maneyrol via B4 Relay wrote: > When interrupt timestamp interval is not v=
alid, we use an estimated value > that can in rare case be bigger than the =
interrupt timestamp. This is >
> >ZjQcmQRYFpfptBannerStart
> >This Message Is From an External Sender
> >This message came from outside your organization.
> >
> >ZjQcmQRYFpfptBannerEnd
> >
> >On Mon, Aug 24, 2026 at 05:16:58PM +0200, Jean-Baptiste Maneyrol via B4 =
Relay wrote:
> > =20
> >> When interrupt timestamp interval is not valid, we use an estimated va=
lue
> >> that can in rare case be bigger than the interrupt timestamp. This is
> >> obviously wrong, so better use interrupt timestamp in this case. =20
> >
> >...
> > =20
> >> -             ts->period =3D ts->mult * ts->chip_period.val;
> >> +             ts->period =3D min(ts->mult * ts->chip_period.val, perio=
d); =20
> >
> >It's u32 * u32, how is this guaranteed to be always under the u32 result=
? =20
>=20
> Hello Andy,
>=20
> (ts->mult * ts->chip_period.val) is an estimation of the sampling period =
of
> the chip in ns. It is limited by maximum setting 8kHz (125000) and minimum
> setting 1.5625Hz (640000000), with a 2% margin. Meaning maximum value is
> 652800000, which is below the 32 bits limit.
>=20
> ts->chip_period.val is an estimation of the internal frequency which is 8=
kHz.
> It's value will always be around 125000, with a 2% margin. Maximum value
> being 127500.
>=20
> ts->mult will change from 8kHz setting (1) to 1.5625Hz setting (5120).
>=20
> Thanks,
> JB
Seems fine to me so applied to the fixes-togreg branch of iio.git

Thanks

Jonathan

>=20
> >
> >--
> >With Best Regards,
> >Andy Shevchenko
> >
> >
> >
>  =20

