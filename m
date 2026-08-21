Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED733803E1;
	Fri, 21 Aug 2026 11:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787313051; cv=none; b=fkA8yRKKsPhAIcph3QO+X8sMkL7z0OpB0N0SyyRQZI7GMW0PJmESn6Tdebu+Vpa6agUgmfsJ6u85+//iKO6nU6mdqNUVoNeBsRma7KuKjtgeJb5P/XLSjMN29O1JDg+6YhZKcSu2aukZiusSxr8QA15e6/Ui8diIe6R+jLOgZyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787313051; c=relaxed/simple;
	bh=gGWt3N0H9V/r0Pd5vV/j3m0yDiezfwviuAyqs9hnxEI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hvVvDYyWIZQBKsqqsBXqPcGAoeczxM6QygixwGI0Lyv9csKvryKiz4Sc4RUQwVxpjDzjshjgtG1jop+8MIEnA8vHuAVslbF6QtRnquwDvOOGhQSgD7SOjccZKe2kaPAziKRTXz9URR6Zx16uuxs/dp9KJrAL9DEUJBtTR7D5uTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=kb2QotSG; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="kb2QotSG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=59zBv3Eri2T8plmV6KBEXNjHzEh3l9vZRamhccgqmnE=; t=1787313050; x=1788522650; 
	b=kb2QotSGGZfbCeHnZtJiG4dSwBvgQH85rwRTFVsTFAebndWEUfKjJvQi6/qy+6blTF4j3D/bOpC
	3DQ6svFZO4cWvXB+2bo3YfE5nEptap+9kJSj7sUfXPQj1qvjbADxsvP98lCMzbSH2kCTnKjlIY5d7
	0OqXrnHBj6wK6dd63tzXtwVaE1fM1vmH6YKHsyDRDPtaYkz4lDmC3W+uOq2CX7NS7vT5wgwSeNyYQ
	kufT7Sy2/6jtPYx36pv4nQV351cAb1cBF7SI+QnIYo1tWn2BoiKwsTN36O0p2VndDncK1kjvi976f
	QBhwDIRzQEc/s1EqWbXumyxyjI4uyZ+ioUsQ==;
Date: Fri, 21 Aug 2026 13:48:26 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: =?UTF-8?B?0JbQsNC80LHQsNC60LjQtdCyINCg0LDQtNC40Lkg0KDQuNC60LDRgNC00Lg=?=
 =?UTF-8?B?0L3QvtCy0LjRhw==?= <r.zhambakiev@prosoftsystems.ru>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman
 <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, "Tony Lindgren"
 <tony@atomide.com>, Lee Jones <lee@kernel.org>, Grygorii Strashko
 <grygorii.strashko@ti.com>, Marcin Niestroj <m.niestroj@grinn-global.com>,
 "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
 "mfd@lists.linux.dev" <mfd@lists.linux.dev>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
 <lvc-project@linuxtesting.org>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] mfd: tps65217: Check return value when masking
 interrupt sources
Message-ID: <20260821134826.7b545130@kemnade.info>
In-Reply-To: <20260821075331.131315-3-r.zhambakiev@prosoftsystems.ru>
References: <20260821075331.131315-1-r.zhambakiev@prosoftsystems.ru>
	<20260821075331.131315-3-r.zhambakiev@prosoftsystems.ru>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Aug 2026 07:54:02 +0000
=D0=96=D0=B0=D0=BC=D0=B1=D0=B0=D0=BA=D0=B8=D0=B5=D0=B2 =D0=A0=D0=B0=D0=B4=
=D0=B8=D0=B9 =D0=A0=D0=B8=D0=BA=D0=B0=D1=80=D0=B4=D0=B8=D0=BD=D0=BE=D0=B2=
=D0=B8=D1=87 <r.zhambakiev@prosoftsystems.ru> wrote:

> tps65217_irq_init() ignores the error returned by
> tps65217_set_bits() when masking all interrupt sources. A failed
> register write leaves the driver's software mask out of sync with the
> hardware and may result in spurious interrupts.
>=20
> Check the return value and propagate the error to the caller.
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>=20
> Fixes: 6556bdacf646fcaa ("mfd: tps65217: Add support for IRQs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Radiy Zhambakiev <r.zhambakiev@prosoftsystems.ru>

Reviewed-by: Andreas Kemnade <andreas@kemnade.info>

> ---
>  drivers/mfd/tps65217.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
> index 2d04d9e0ae29..9a1528456ffc 100644
> --- a/drivers/mfd/tps65217.c
> +++ b/drivers/mfd/tps65217.c
> @@ -155,8 +155,13 @@ static int tps65217_irq_init(struct tps65217 *tps, i=
nt irq)
> =20
>  	/* Mask all interrupt sources */
>  	tps->irq_mask =3D TPS65217_INT_MASK;
> -	tps65217_set_bits(tps, TPS65217_REG_INT, TPS65217_INT_MASK,
> -			  TPS65217_INT_MASK, TPS65217_PROTECT_NONE);
> +	ret =3D tps65217_set_bits(tps, TPS65217_REG_INT, TPS65217_INT_MASK,
> +				TPS65217_INT_MASK, TPS65217_PROTECT_NONE);
> +	if (ret) {
> +		dev_err(tps->dev, "Failed to mask interrupt sources: %d\n",
> +			ret);
> +		return ret;
> +	}
> =20
>  	tps->irq_domain =3D irq_domain_create_linear(dev_fwnode(tps->dev), TPS6=
5217_NUM_IRQ,
>  						   &tps65217_irq_domain_ops, tps);

