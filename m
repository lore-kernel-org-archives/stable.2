Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.119.170.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795080838;
	b=yTRtvRg7NOLShuAHGN7OHJa8eOTHdTK3557yu9+cpvtHNMxUvssK2zlfxx7fGZsoP52L
	 DkgUR7PQbMY4lf+ao7WSICGm+RKk0oT8s2vCWR3S+NGsDau/6QvFoifxrEi8Vfp36TB9T
	 fiobOeMHEV2L+ieMdDTP7qycnCI81h5QLlCOYevkUOmm+axunY4DzQ1KJn6FbpCKZox8j
	 f5CNagVH1IIQ7YyXi1Tc2g4n9K6fvFtzhkAh1r10mifgyrHDTl5nRwQ1jMbq2oO6cEbrD
	 XsoPp7Jj18fERjEoagvhR5MVowE1W0eSt+VgOlx+kmRYKqIymyQiQQqogDWxMwDLCRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795080838;
	h=DMARC-Filter:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=3FdYbGM4BmO4PXujten7LVhc0nlTJDBtBmP+989ACPo=;
	b=m1TKpOsibUie+Q9GtIyDUMTuRHxOzTI9qlLgSx1DuZhsZvRZXU+eKwWh0xFXD2oskXIj
	 TZKnew2zwas4Laol3pohHXvacq2lxYZtWeckAkZ2zhr/0Wee1SGKb70AS4L7pVIrFHMev
	 lAjUKJcJT5JoJEmp4XbQbDEIc/tFgOROLHupZ0XO0CKeBSzC8tFlWtd4i48WI+DAAFais
	 qibOXCgOMgAbOFO6fdCpd6nwGuFScDGV+BVcs+2qk65MwR0KGaP3Abxx9/qttxFko+kab
	 5/wmFDZ5z8KzsPAiiDmuo2n7aS8E1l/y1muWJ11ma223Ha5pU5/6MpShwPrmQOABv3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crapouillou.net;
	spf=pass smtp.mailfrom=crapouillou.net;
	arc=none smtp.remote-ip=185.119.170.32
Received: from aposti.net (aposti.net [185.119.170.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8C5606A324;
	Thu, 19 Nov 2026 09:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D8C5606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
Message-ID: <1aea100330532a23abb11dd55235970da48107e5.camel@crapouillou.net>
Subject: Re: [PATCH v4 2/7] pinctrl: ingenic: Fix hardware dual-edge
 interrupts on X1600
From: Paul Cercueil <paul@crapouillou.net>
To: "H. Nikolaus Schaller" <hns@goldelico.com>, Linus Walleij	
 <linusw@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski	
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Bartosz
 Golaszewski	 <brgl@kernel.org>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
	letux-kernel@openphoenux.org, stable@vger.kernel.org
Date: Thu, 19 Nov 2026 10:33:53 +0100
In-Reply-To: <12e66f571e8765b1eefeab5939c2c874b71b28af.1795022736.git.hns@goldelico.com>
References: <cover.1795022736.git.hns@goldelico.com>
	 <12e66f571e8765b1eefeab5939c2c874b71b28af.1795022736.git.hns@goldelico.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Nikolaus,

Le mercredi 18 novembre 2026 =C3=A0 18:25 +0100, H. Nikolaus Schaller a =C3=
=A9crit=C2=A0:
> Use the hardware dual-edge detector on X1600 and X2000.
>=20
> Set PAT1 when configuring both edges and program EDG on X1600.
> Keep software edge switching for older SoCs without EDG.
>=20
> Tested on X1600 and X2000 using GPIO buttons and register readback.
>=20
> Fixes: 4da56f9c6f14 ("pinctrl: ingenic: add x1600 support")
> Cc: stable@vger.kernel.org
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>=20
> Notes:
> =C2=A0=C2=A0=C2=A0 Changes V4:
> =C2=A0=C2=A0=C2=A0 - Fix Fixes: and stable Cc trailers.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (suggested by Paul Cercueil and Sashiko-Bo=
t)
> =C2=A0=C2=A0=C2=A0 - Merge the common shadow-register paths and simplify =
EDG handling.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (suggested by Paul Cercueil)
> =C2=A0=C2=A0=C2=A0 - Retested hardware dual-edge interrupts on X1600/X200=
0 after the
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shadow-register refactoring. Verified both=
 button transitions
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with evtest and confirmed via devmem2 that=
 PAT1, PAT0 and EDG
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 remain unchanged across GPIO input transit=
ions.
>=20
> =C2=A0drivers/pinctrl/pinctrl-ingenic.c | 17 ++++++++---------
> =C2=A01 file changed, 8 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-
> ingenic.c
> index 88c5edeaaddcc..7f65f3abf05f5 100644
> --- a/drivers/pinctrl/pinctrl-ingenic.c
> +++ b/drivers/pinctrl/pinctrl-ingenic.c
> @@ -3601,7 +3601,8 @@ static void irq_set_type(struct ingenic_gpio_chip *=
jzgc,
> =C2=A0
> =C2=A0	switch (type) {
> =C2=A0	case IRQ_TYPE_EDGE_BOTH:
> -		val1 =3D val2 =3D false;
> +		val1 =3D false;
> +		val2 =3D is_soc_or_above(jzgc->jzpc, ID_X1600);
> =C2=A0		val3 =3D true;
> =C2=A0		break;
> =C2=A0	case IRQ_TYPE_EDGE_RISING:
> @@ -3635,15 +3636,13 @@ static void irq_set_type(struct ingenic_gpio_chip
> *jzgc,
> =C2=A0		return;
> =C2=A0	}
> =C2=A0
> -	if (is_soc_or_above(jzgc->jzpc, ID_X2000)) {
> -		ingenic_gpio_shadow_set_bit(jzgc, reg2, offset, val1);
> -		ingenic_gpio_shadow_set_bit(jzgc, reg1, offset, val2);
> -		ingenic_gpio_shadow_set_bit_load(jzgc);
> -		ingenic_gpio_set_bit(jzgc, X2000_GPIO_EDG, offset, val3);
> -	} else if (is_soc_or_above(jzgc->jzpc, ID_X1000)) {
> +	if (is_soc_or_above(jzgc->jzpc, ID_X1000)) {
> =C2=A0		ingenic_gpio_shadow_set_bit(jzgc, reg2, offset, val1);
> =C2=A0		ingenic_gpio_shadow_set_bit(jzgc, reg1, offset, val2);
> =C2=A0		ingenic_gpio_shadow_set_bit_load(jzgc);
> +
> +		if (is_soc_or_above(jzgc->jzpc, ID_X1600))
> +			ingenic_gpio_set_bit(jzgc, X2000_GPIO_EDG, offset,
> val3);
> =C2=A0	} else {
> =C2=A0		ingenic_gpio_set_bit(jzgc, reg2, offset, val1);
> =C2=A0		ingenic_gpio_set_bit(jzgc, reg1, offset, val2);
> @@ -3718,7 +3717,7 @@ static void ingenic_gpio_irq_ack(struct irq_data *i=
rqd)
> =C2=A0	bool high;
> =C2=A0
> =C2=A0	if ((irqd_get_trigger_type(irqd) =3D=3D IRQ_TYPE_EDGE_BOTH) &&
> -	=C2=A0=C2=A0=C2=A0 !is_soc_or_above(jzgc->jzpc, ID_X2000)) {
> +	=C2=A0=C2=A0=C2=A0 !is_soc_or_above(jzgc->jzpc, ID_X1600)) {
> =C2=A0		/*
> =C2=A0		 * Switch to an interrupt for the opposite edge to the one
> that
> =C2=A0		 * triggered the interrupt being ACKed.
> @@ -3758,7 +3757,7 @@ static int ingenic_gpio_irq_set_type(struct irq_dat=
a
> *irqd, unsigned int type)
> =C2=A0		irq_set_handler_locked(irqd, handle_bad_irq);
> =C2=A0	}
> =C2=A0
> -	if ((type =3D=3D IRQ_TYPE_EDGE_BOTH) && !is_soc_or_above(jzgc->jzpc,
> ID_X2000)) {
> +	if (type =3D=3D IRQ_TYPE_EDGE_BOTH && !is_soc_or_above(jzgc->jzpc,
> ID_X1600)) {
> =C2=A0		/*
> =C2=A0		 * The hardware does not support interrupts on both edges.
> The
> =C2=A0		 * best we can do is to set up a single-edge interrupt and
> then
