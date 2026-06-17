Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06F83CF960
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 09:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781690109; cv=none; b=blSo5vp0b/Ov9vB4zkvY5YR2cpWjR4cVQsfm5AZ2G6ey+miNK7TBpupEcFeLweJPd8Gf/Hc3+cpJbtMKwraGgCvB60LSpyMUTfsem/8cNexuCXHklaQjXgv04xBBLosIS7+4+xaHdumxnJIT/zW66r3ezPOGYClA+zJxj+poioc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781690109; c=relaxed/simple;
	bh=SC4tsNutoMUwm1yl7w+6p6RvLCfnnsLfoLw00LCPf0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDE75eN6NkINKStMUQ4z5r56TNGghZI5w3co6qrCGVDbVOyEvmp8DPC/IIO0Mb/ORSeFoYmGFX+xr+TOlw7gfEJNXWEUxhYHueO7m+R5rz59FhSoj7xynkd8cE223cRfIiZdtzelhMM7sCDgCktY+4zeZuRTZsKz3bOGLPqhG0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=DMt4DMYo; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="DMt4DMYo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=mjyH
	St8LiNiWgI+8x8dI7OwW7pjC0pYK62XYoLKg6Mk=; b=DMt4DMYoY4uKMT3AdlLQ
	meeGaOmxcALKZ/3myKZvybxV1fYQCVy7urdtOT9EXyhw0HY7uFVnwF1xkNIkixOC
	pzw+jmyuqOYQs2gpOxWbph/hMZqoD1/vniz30M4kWIJLQ3WuoMKrYHJU6RlxeYi6
	2grra99lP3GHr3G9m9FdliMvR9xc+d7yLEJiJ3W17Qb0HuQEIxFWpiTKryT+i3pV
	qjDNjXrbykYTueIHXkZI+3cIYU5Bhh/SAPxBExU77g2txNMY0/JYk/4bYWaLnicI
	vfy2tM+Tl5atVig0NdoSpbdEWvLIwRHry/PbQUEVq4f5Q7YPwEGUiv7fSC66KX0t
	0w==
Received: (qmail 111291 invoked from network); 17 Jun 2026 11:55:05 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Jun 2026 11:55:05 +0200
X-UD-Smtp-Session: l3s3148p1@4r7XDXBUOt0ujnvI
Date: Wed, 17 Jun 2026 11:55:05 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-rtc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 02/12] rtc: rzn1: Handle EPROBE_DEFER for optional pps
 interrupt
Message-ID: <ajJu-f7VB7XSTPcu@shikoro>
References: <20260615154805.1619693-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260615154805.1619693-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cvd1DULyLHD8uUwc"
Content-Disposition: inline
In-Reply-To: <20260615154805.1619693-3-prabhakar.mahadev-lad.rj@bp.renesas.com>


--cvd1DULyLHD8uUwc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Sashiko found issues with your patch. I curated the list and agree. I
think, in probe(), 'rate' should be initialized to 32768 and 'sync_time'
should be calculated unconditionally.

Thank you and happy hacking,

   Wolfram

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] If the optional 'xtal' clock is not present, `rtc->sync_time` re=
mains 0, causing `readl_poll_timeout` to use a 0 timeout (infinite wait) an=
d `usleep_range` to use a 0 delay.
> --
>=20
> commit 5d75a1049c228d2049afaf29833f1b2f212837d4
> Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: rtc: rzn1: Handle EPROBE_DEFER for optional pps interrupt
>=20
> This commit checks for -EPROBE_DEFER from platform_get_irq_byname_optiona=
l()
> and handles the deferred probe request properly. It intercepts this speci=
fic
> error condition, assigns it to the return value, and jumps to the
> dis_runtime_pm label to avoid ignoring a valid probe deferral.
>=20
> Fixes: eea7791e00f33 ("rtc: rzn1: implement one-second accuracy for alarm=
s")
> Cc: stable@vger.kernel.org
>=20
> > diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
> > index c4ed437354574..f81d691c8b9a2 100644
> > --- a/drivers/rtc/rtc-rzn1.c
> > +++ b/drivers/rtc/rtc-rzn1.c
> > @@ -465,6 +465,10 @@ static int rzn1_rtc_probe(struct platform_device *=
pdev)
> >  	}
> > =20
> >  	irq =3D platform_get_irq_byname_optional(pdev, "pps");
> > +	if (irq =3D=3D -EPROBE_DEFER) {
> > +		ret =3D irq;
> > +		goto dis_runtime_pm;
> > +	}
> >  	if (irq >=3D 0)
> >  		ret =3D devm_request_irq(&pdev->dev, irq, rzn1_rtc_1s_irq, 0, "RZN1 =
RTC 1s", rtc);
>=20
> [Severity: High]
> If the optional xtal clock is not present, does rtc->sync_time remain 0,
> causing readl_poll_timeout() to use a 0 timeout (infinite wait) and
> usleep_range() to use a 0 delay?
>=20
> devm_clk_get_optional() returns NULL if the clock is absent in the device
> tree, skipping the calculation:
>=20
> drivers/rtc/rtc-rzn1.c:rzn1_rtc_probe() {
>     ...
>     xtal =3D devm_clk_get_optional(dev, "xtal");
>     if (IS_ERR(xtal)) {
>         ...
>     } else if (xtal) {
>         rate =3D clk_get_rate(xtal);
>         ...
>         rtc->sync_time =3D DIV_ROUND_UP(2 * NSEC_PER_MSEC, rate);
>     }
>     ...
>     ret =3D readl_poll_timeout(rtc->base + RZN1_RTC_CTL0, val,
>                              !(val & RZN1_RTC_CTL0_CEST), rtc->sync_time,
>                              rtc->sync_time * 2);
>     ...
> }
>=20
> In include/linux/iopoll.h, a timeout_us of 0 skips the timeout check
> entirely, which could lead to a tight infinite loop and a kernel hard loc=
kup
> if the hardware fails to clear the CEST bit.
>=20
> Additionally, rtc->sync_time being 0 causes usleep_range(0, 100) in
> rzn1_rtc_set_time(), which may return almost immediately and violate the
> hardware's explicit 2-clock-cycle delay requirement (previously hardcoded=
 to
> 61us).
>=20
> This regression was introduced by the commit 'rtc: rzn1: Dynamically
> calculate synchronization delay based on clock rate' later in this series.
>=20
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615154805.16=
19693-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D2

--cvd1DULyLHD8uUwc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoybvUACgkQFA3kzBSg
KbbVeA/9GmiKuqd4qxBXuPO3UIOWcONUqvvsN27JpOh82PNaun4p6M3attm45Vx4
oCaUZXQFSPebOgG98Wxp7ZpYjxEzyVvhegq9r3/SMotwxx12df7MI+bgKjkra6Cr
iUT44q5CJCIo36tJaVnL0B//7jlNq5MVuL5PySMEXlZ7Sg5J1njQx0ELXyyigweT
sIx06ah6kCunuCuHxqn/fZ+/z8l5qaJx0sZWpzsFmCPszfyL+pWYEZmwNoEANvkH
QKFvBGCYTBrq1aJZ8jUEuRk+qekZa7Slv0aEiu7qZa5GuwcQmeZWV2nIxaP5/Ryo
52P627C/r7IAsTMMjcRpwERN/HgwtTSv17dHCZa7Srzpl8xpogXJJ40YEdgJ1eBd
NNRvUxq/88Hj5e0zeDrthETJty1qwJjtGG5KGwf9KGxsPJxDWnToCxmI6c5q0lFp
rQ5za6b6oVdGZl6b4HfSg9cwrlfJTlCyPHeRVRI1uu0wXXODWbaDPlVMKsmO5JJ0
kkdIbYm5HZ7ZXlpIqoI4pL4U1M1IKvdX10hRF6THKwkaz3bgek8Ou/7R7uTCUtHv
zLzE120CHjnLG0VkjPNc0017TceMvH593BHKxT3gGXH0avA5FuYTFYYoeoyrtcr8
5vr5vlFsfMNZlzOZBfXD19UsfkIN1vYtSnv0+bEXckz8QLguq6w=
=JJIr
-----END PGP SIGNATURE-----

--cvd1DULyLHD8uUwc--
