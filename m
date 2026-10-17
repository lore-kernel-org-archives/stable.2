Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B51343893;
	Sat, 17 Oct 2026 00:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792198290; cv=none; b=rXKMLw6e5ncDQusOEZxrco0CmxLqYy/DSSuCoh4OjTpEd+QRkQVNX0OpbjTULt9lrhw8DVF5wQff9eQBHFWFWSTqE3S1xg88YQe9fRwLLXbmHrpYfq35ZxBAjefxXwOtkyc/bRyAQPDsLBTlczvwf4r9xkxz8P5cuIL7CRJL7YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792198290; c=relaxed/simple;
	bh=sXrRlv31r9ke7rGPJzF8bPwwHXAo2YzF4etohBSxncE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P5e3/J97Gw4lmbJeC94Zm9NS5//CYF8wUiq628xnh0PkXcEyl9YMwlZMhuKrgENKgK12TL2qebdftX/vem7KdoBMAZ5gWRQ99tEwyJzf3AFRv4Jh7yYQyStoQedivz1AlmKPMoBgpw/DWLUajVkrCX3Z9PjIxpCLeBbGoVigr08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dd5Izn1f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dd5Izn1f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5741F000C4;
	Sat, 17 Oct 2026 00:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792198289;
	bh=i/9iEtzl646rTJPvpiVq/Z7W9CU4SexSw2RJncJ6CEI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dd5Izn1fK0rb3yfkaKOMTAV5IChrh/slFNiwGZWhRqwmW3QgYcLaym23Gimg1DfGl
	 UtVNCl1mVsrElxr/RcCX1G2wEaipeJDnSfUqIc8nBThmhQsSwErdH161q9dazUQ0H+
	 QI1dlqgX/vLpfuKeqcZY1iWPysvbk2NdfDMqXPgipSMMBLeyvCTdOtPxdHggRDyX4w
	 ffbfDFchrbay3PEVFEVeKszqlKhYpTGb4tpSifDmBmTOAN3bJ8eKTUEKaZguH5liqb
	 1Y0X4tnSzTsTmO9s/9rSiCNJsm9O/FokdnxMLItd13VbJLMwfq/LSWWRliPn4XZ+ob
	 4zHa/4ynUjjzw==
Date: Sat, 17 Oct 2026 01:51:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, Dingisoul
 <dingiso.kernel@gmail.com>, Linus Walleij <linusw@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: gyro: mpu3050: add missing trigger cleanup on
 remove
Message-ID: <20261017015122.7a902b28@jic23-hlaptop>
In-Reply-To: <atHinTYMtjsY45wY@nsa>
References: <20261015-mpu3050-fix-v2-1-53f73581e62c@gmail.com>
	<20261015221818.09527ff6@systembl0wer>
	<atHinTYMtjsY45wY@nsa>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 16 Oct 2026 09:39:51 +0100
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> On Thu, Oct 15, 2026 at 10:18:18PM +0200, Joshua Crofts wrote:
> > On Thu, 15 Oct 2026 21:58:35 +0200
> > Joshua Crofts <joshua.crofts1@gmail.com> wrote:
> >  =20
> > > The mpu3050_trigger_probe() function registers a trigger but
> > > mpu3050_common_remove() and error paths in mpu3050_common_probe() for=
get
> > > to clean it up, causing a use-after-free bug.
> > >=20
> > > Add the missing iio_trigger_unregister() function. Additionally, chan=
ge
> > > the mpu3050_trigger_probe() function to assign trig only after it is
> > > registered successfully to prevent a null pointer dereference using a
> > > local struct iio_trigger.
> > >=20
> > > Reported-by: Dingisoul <dingiso.kernel@gmail.com>
> > > Closes: https://lore.kernel.org/all/20261010203601.1686148-1-dingiso.=
kernel@gmail.com/
> > > Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscop=
e")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> > > --- =20
> >=20
> > Dingisoul, any chance you can test this?
> >=20
> > Q to others: better to leave the driver running in this weird
> > polling mode as it is now or return on trigger register failure
> > as Nuno suggests? =20
>=20
> Don't think it makes sense to continue if the idea is to have trigger
> but something failed when dealing with it. At the very least we should
> then drop the memory we allocated for it.

Fully agree. If there is an irq and trigger registration fails, fail
the probe.  Not doing that just leaves us with more corner cases
to bite us in future (such as tidying up the otherwise devm managed
trigger).  Note the mix of devm and non devm in here isn't something
we'd do today but may not be worth the effort of cleaning up.

Jonathan

>=20
> - Nuno S=C3=A1
> >=20
> > Thanks.
> >=20
> > --=20
> > Kind regards,
> > Joshua Crofts =20

