Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794700464;
	b=rWFbdlJO+A9bjMnZQsK9S3f19b/R1J7BXjcLSUMSPII452qs6tuxBLzE7eJYtb5b2uNG
	 /HQn4iLL5j0hkSypjTE1lftzggkkMvD1EMOUIfq5x9Gk7w+HFJcmIzV7LNPV5QvTvBDbj
	 iTQGJGmWJSbJu7z6V/1OnzBCKg4XH8BT8FQuEMmzGxEBh8oaq9wHzEiNcWft3bEjjNkED
	 ql5weNQoT8HbzypWnCXtpa3TCbXukqZ3zIbNt1WAxJi5Jn5wcLio+mXOEeEDe+I+ZWZ3g
	 KUCsdk5xvgL9sDjdhpUS6lmwtEjZ+APXFChUJKS+DV31HVbwUa7/s56qUgFcsABJIZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794700464;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=OmOWDTHs4v8eGfBw9Zf1YFY4jTOyvl+0L69mZ0TJgW0=;
	b=460N+d8+Er9b0guDK58oFwMshqOqjOlRn6KbMRqmO3ywwdkmGbE+6pzOOXDVQ7VnndkN
	 O09oimA8CAUdU3BKiaxNpsLTQDRlwj3G1lf8iUeUlFiBknWvC+oaUDSjkImghIRpq0oA5
	 DCYfpKlqEY60CF9lpAANnCgi6VKqgRkkTOu+1wui37nOwso2+qa8g2LtMLoYiLyYBaocF
	 vABiIc4bUm36BPo6I/ZrAPKRENsOiB1cPp0R1m6ffF0dzq8XuneDeqqpwYj/t/a201u8m
	 O8cQ41LyIFI0v3R85K5e1CmfF+wCFWIO1WaDBkVmNggLkraOBNIMPat/VfZeqRITCUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PM8Epa91;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1563606A880;
	Sat, 14 Nov 2026 23:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PM8Epa91
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA041F000C7;
	Sat, 14 Nov 2026 23:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794700464;
	bh=OmOWDTHs4v8eGfBw9Zf1YFY4jTOyvl+0L69mZ0TJgW0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PM8Epa911DWKIWkB/cSA9N1Q9ONn3UyiuR8llUtY0uvvw0Xpmr3Y8Fklcb6vWT6DD
	 Hbf51fXONGnNJM8yhsQXICXLDJXcDa45cCI2KpTOPyzXEYtjZ9QPXiTk8MBy2f6gCU
	 HSEPe9PkYh6EurOGqIoLyNztDsfeJ1v7MyCezA9/URsWFSIKdb+50B6kE9FqomRsvV
	 T+zLnuG8kv1uQWtQfmreblewXheWaomvXmemWI/EeYnkQqgNBS37Y1S31SjeHwuBe6
	 oD3zPrzs4QUC3evkEJhg+vy7AI+oaTSvfZXKWYFGTqBVfv3YOtwkfXQ4L6Vlsc+CWv
	 sfoVLNzHP2HnA==
Date: Sat, 14 Nov 2026 23:54:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, Per-Daniel Olsson
 <perdaniel.olsson@axis.com>, Kurt Borja <kuurtb@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: light: opt4060: fix inverted own trigger check
Message-ID: <20261114235416.5589888a@jic23-hlaptop>
In-Reply-To: <20261109085631.00007485@oss.qualcomm.com>
References: <20261109024746.1253593-1-jic23@kernel.org>
	<avHsKUE4xJ0vdu6P@nsa>
	<20261109085631.00007485@oss.qualcomm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 9 Nov 2026 08:56:31 -0800
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> wrote:

> On Mon, 9 Nov 2026 15:52:31 +0000
> Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>=20
> > On Mon, Nov 09, 2026 at 02:47:45AM +0000, Jonathan Cameron wrote: =20
> > > From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> > >=20
> > > opt4060_set_driver_state() is meant to keep sampling and the interrupt
> > > on every conversion enabled while the buffer is in use with the
> > > driver's own trigger, as that interrupt is what fires the trigger.
> > >=20
> > > When converted to use IIO_DEV_GUARD_CURRENT_MODE() the negation of
> > > iio_trigger_validate_own_device(), which returns 0 for the device's o=
wn
> > > trigger, was lost. As a result, with the driver's own trigger in use,
> > > enabling or disabling a threshold event switches the interrupt to
> > > thresholds only and buffered capture stops. With another trigger in
> > > use, the one shot conversions requested by opt4060_trigger_new_sample=
s()
> > > are instead forced to continuous mode.
> > >=20
> > > Restore the negation so the code matches the comment above it.
> > >=20
> > > Fixes: 8284a4985416 ("iio: light: opt4060: Use IIO cleanup helpers")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> > > ---
> > > This was found by an LLM whilst doing a refactor of related code.
> > > Indeed seems there was a change of behavior in the sited patch that
> > > wasn't as intended.
> > > ---   =20
> >=20
> > Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com> =20
>=20
> Fixed the linux-iio address.  I'll probably post a v2 so I can pick these=
 up
> as normal though.=20
>=20
> Thanks for the review Nuno,
Similar to previous, I decided to be a bit naughty and pick it up
on basis it was on LKML and this email with full content went to the
right list.

Applied to the testing branch of iio.git

thanks,

Jonathan

>=20
> J
>=20
> >  =20
> > >  drivers/iio/light/opt4060.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/iio/light/opt4060.c b/drivers/iio/light/opt4060.c
> > > index 8253a6a8bee4..1a7d429453be 100644
> > > --- a/drivers/iio/light/opt4060.c
> > > +++ b/drivers/iio/light/opt4060.c
> > > @@ -310,7 +310,7 @@ static int opt4060_set_driver_state(struct iio_de=
v *indio_dev,
> > >  	 * IRQ and sampling must go to or remain continuous.
> > >  	 */
> > >  	if (iio_buffer_enabled(indio_dev) &&
> > > -	    iio_trigger_validate_own_device(indio_dev->trig, indio_dev))
> > > +	    !iio_trigger_validate_own_device(indio_dev->trig, indio_dev))
> > >  		return opt4060_set_state_common(chip, true, true);
> > > =20
> > >  	/*
> > > --=20
> > > 2.56.0
> > >    =20
>=20

