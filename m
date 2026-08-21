Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4BD3D6CD7;
	Fri, 21 Aug 2026 09:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306141; cv=none; b=S+LGPMP9gwJQNAKqc6IdYwqBUUcxomQUlUzvBxWcY+teQ/M0WHjxWJR3aGER0U9Ovph7u8Nxw4nwtFn80Pv+hq3im5yv/GupkBMocALc6J6HzIBhruYVf1ZhlnLLRVVsPdgh+r2vqe4rddlQstL0BPeE3IcJKVMX0cPuZcHkRPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306141; c=relaxed/simple;
	bh=24ElsADEh06edAjikGY7oCnUpIBZeIN0N6fSfPxfVsM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=POu2pxcNFjFpgwQgJF5IJ/weOs+u1SXm26kTAA0ORlrNnUVn7wrHcpkCSPFIGp6fb1xhPQ9hSGWcINAY/vbVoZIdaV+GoMey2EPVefgAn3LLdMBvDISYzS1KS2UfsMDjV9Y/pEGNqo7WnmSvsJAOLRCoL3LTwtydeMlND8Zdny8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=hNn41fI8; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="hNn41fI8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=fdbqfJ7QvYonUWlTYQvntCdh+ZP0kQrA2filCMbzWPo=; t=1787306137; x=1788515737; 
	b=hNn41fI8L0vLDokhh5dRhcRAbORMuTqtIG1RjIV2c45VQM/Lv96WEL1fheuQZmXFJkbrRY8MAGS
	P3jwtc9KyAwLc14mvKTQHFJpcwG63fswGBguSjBqxf/byVqIJHa8eDMBYjl5amur3fkAF9Tqr/HcI
	0jsPQLGx/Loi7EZ3aZecU0LLd1ZyU6koIYf3vZDcBxCUdwhGg+QfBdQ3QMRypBcxDS3umBNboRqkz
	6Gy6yJQ0B45VKTe/i1RvnoH1YT0PX4Xvn/yB2jUbTArkCX5U+/7ufJknzfuZymrQ+8KtuKnRlG5RS
	LIqMwQircRP2TQTfYPjDAsJ1TDbkF2rtBxjw==;
Date: Fri, 21 Aug 2026 11:55:05 +0200
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
Subject: Re: [PATCH 1/2] mfd: tps65217: Fix NULL pointer dereference on IRQ
 init failure
Message-ID: <20260821115505.6942aeae@kemnade.info>
In-Reply-To: <20260821075331.131315-2-r.zhambakiev@prosoftsystems.ru>
References: <20260821075331.131315-1-r.zhambakiev@prosoftsystems.ru>
	<20260821075331.131315-2-r.zhambakiev@prosoftsystems.ru>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Aug 2026 07:53:58 +0000
=D0=96=D0=B0=D0=BC=D0=B1=D0=B0=D0=BA=D0=B8=D0=B5=D0=B2 =D0=A0=D0=B0=D0=B4=
=D0=B8=D0=B9 =D0=A0=D0=B8=D0=BA=D0=B0=D1=80=D0=B4=D0=B8=D0=BD=D0=BE=D0=B2=
=D0=B8=D1=87 <r.zhambakiev@prosoftsystems.ru> wrote:

> tps65217_probe() ignores the return value of tps65217_irq_init(), so
> when the irq domain creation fails the probe still completes and the
> driver ends up bound with a NULL tps->irq_domain. Unloading the
> module then makes tps65217_remove() call irq_domain_remove() on the
> NULL pointer and oops the kernel. On top of that, irq_find_mapping()
> may fall back to the default irq domain and dispose of mappings that
> belong to other interrupt controllers.
>=20
> Check the return value and abort the probe on failure so the error
> is reported and no inconsistent state is left for removal.
>=20
> Fixes: 6556bdacf646fcaa ("mfd: tps65217: Add support for IRQs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Radiy Zhambakiev <r.zhambakiev@prosoftsystems.ru>

Reviewed-by: Andreas Kemnade <andreas@kemnade.info>

> ---
>  drivers/mfd/tps65217.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
> index c240fac0ede7..2d04d9e0ae29 100644
> --- a/drivers/mfd/tps65217.c
> +++ b/drivers/mfd/tps65217.c
> @@ -333,7 +333,9 @@ static int tps65217_probe(struct i2c_client *client)
>  	}
> =20
>  	if (client->irq) {
> -		tps65217_irq_init(tps, client->irq);
> +		ret =3D tps65217_irq_init(tps, client->irq);
> +		if (ret)
> +			return ret;
>  	} else {
>  		int i;
> =20

