Received: from aposti.net (aposti.net [185.119.170.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F893A2576;
	Sun, 19 Jul 2026 15:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.119.170.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784473637; cv=none; b=muYJbc+I5dOWRwaZDZMWUYAG0k+NoVXP2VAhPhwMzwc56oJW4E3MsflFVuvp7uqtye0YdVQu+j7tgE8lmHowhHhS9AJyknEdc8mhprUo1hyTyeIx2pI8N7HQXVvhysKwWB/x7K7tTZCIKd7CYVFdQ8rugzCtWTMilxASp8uIQU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784473637; c=relaxed/simple;
	bh=QnNwdkTqOLiMGGNT01qFp2bvC6tjqhvmizSL0TXXDlE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SjOW8lpAqswFiuRo266faDqD2t9kreyMKO0TJo/GV3n/9l83gaiW2hf2CevouAk06Vp6gbgyzS9Hc1gOSBc4+ipNTKRoEYgT+LNHJunSo+loZS9w/DyyB9nlqC8mxTdshKH0ayizWjoxjzhq1CPcCnESdWSj+BdiApj3AfLmOLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=roIHmX4y; arc=none smtp.client-ip=185.119.170.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="roIHmX4y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crapouillou.net;
	s=mail; t=1784473633;
	bh=QnNwdkTqOLiMGGNT01qFp2bvC6tjqhvmizSL0TXXDlE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=roIHmX4yqyUUSV3TeF5wxejFbLbWqRbM7S4Zy5LJxECTksGlmSPqGaXjGC+wEpe/N
	 r9PkYLmdrDU7obM2+2FB9NeJDhdTCOpvE3iVtUfOPNu10qBrkjsShmQixzZP3IeqmX
	 PNHQQkb/Qs42zE0wUrM27iUrMOnOWLgpOZXpOIQs=
Message-ID: <a08203c004280827fda87fc4c83660aedb446440.camel@crapouillou.net>
Subject: Re: [PATCH] i2c: jz4780: Cache clock rate at probe to prevent CCF
 prepare_lock deadlock
From: Paul Cercueil <paul@crapouillou.net>
To: "H. Nikolaus Schaller" <hns@goldelico.com>, Andi Shyti
	 <andi.shyti@kernel.org>
Cc: linux-mips@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, 
	stable@vger.kernel.org
Date: Sun, 19 Jul 2026 17:07:09 +0200
In-Reply-To: <c69ca6511780aa4759a428cb7fb70de43ee5211b.1783666715.git.hns@goldelico.com>
References: 
	<c69ca6511780aa4759a428cb7fb70de43ee5211b.1783666715.git.hns@goldelico.com>
Autocrypt: addr=paul@crapouillou.net; prefer-encrypt=mutual;
 keydata=mQENBF0KhcEBCADkfmrzdTOp/gFOMQX0QwKE2WgeCJiHPWkpEuPH81/HB2dpjPZNW03ZM
 LQfECbbaEkdbN4YnPfXgcc1uBe5mwOAPV1MBlaZcEt4M67iYQwSNrP7maPS3IaQJ18ES8JJ5Uf5Uz
 FZaUawgH+oipYGW+v31cX6L3k+dGsPRM0Pyo0sQt52fsopNPZ9iag0iY7dGNuKenaEqkYNjwEgTtN
 z8dt6s3hMpHIKZFL3OhAGi88wF/21isv0zkF4J0wlf9gYUTEEY3Eulx80PTVqGIcHZzfavlWIdzhe
 +rxHTDGVwseR2Y1WjgFGQ2F+vXetAB8NEeygXee+i9nY5qt9c07m8mzjABEBAAG0JFBhdWwgQ2VyY
 3VlaWwgPHBhdWxAY3JhcG91aWxsb3UubmV0PokBTgQTAQoAOBYhBNdHYd8OeCBwpMuVxnPua9InSr
 1BBQJdCoXBAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHPua9InSr1BgvIH/0kLyrI3V0f
 33a6D3BJwc1grbygPVYGuC5l5eMnAI+rDmLR19E2yvibRpgUc87NmPEQPpbbtAZt8On/2WZoE5OIP
 dlId/AHNpdgAtGXo0ZX4LGeVPjxjdkbrKVHxbcdcnY+zzaFglpbVSvp76pxqgVg8PgxkAAeeJV+ET
 4t0823Gz2HzCL/6JZhvKAEtHVulOWoBh368SYdolp1TSfORWmHzvQiCCCA+j0cMkYVGzIQzEQhX7U
 rf9N/nhU5/SGLFEi9DcBfXoGzhyQyLXflhJtKm3XGB1K/pPulbKaPcKAl6rIDWPuFpHkSbmZ9r4KF
 lBwgAhlGy6nqP7O3u7q23hRU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Nikolaus,

Le vendredi 10 juillet 2026 =C3=A0 08:58 +0200, H. Nikolaus Schaller a
=C3=A9crit=C2=A0:
> Fix a severe AB/BA deadlock between the Common Clock Framework (CCF)
> and the I2C adapter lock, which triggers when an I2C-controlled clock
> generator (like the Si5351) is registered or modified under the CCF.
>=20
> During a clock frequency change, the CCF acquires its global
> 'prepare_lock'
> mutex and calls i2c_transfer() to update the chip registers, stalling
> for the adapter's I2C bus lock.
>=20
> Concurrently, a parallel transfer on the same bus (e.g., a GPIO
> expander
> handling LEDs) can hold the I2C adapter lock. Inside the transfer
> path,
> jz4780_i2c_set_speed() calls clk_get_rate() to dynamically calculate
> timings. This call attempts to acquire the blocked CCF
> 'prepare_lock',
> creating a circular dependency that freezes the system or at least
> the involved processes and workers.
>=20
> Eliminate the synchronous clk_get_rate() call from the active
> transfer
> path by caching the peripheral clock rate once - inside the private
> jz4780_i2c structure during jz4780_i2c_probe(). Update
> jz4780_i2c_set_speed() to use this cached value, decoupling active
> I2C
> transactions from the CCF internal locks.
>=20
> Assisted-by web based Google AI.
>=20
> Fixes: ba92222ed63a12 ("i2c: jz4780: Add i2c bus controller driver
> for Ingenic JZ4780")
> Cc: stable@vger.kernel.org
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
> =C2=A0drivers/i2c/busses/i2c-jz4780.c | 5 ++++-
> =C2=A01 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-jz4780.c
> b/drivers/i2c/busses/i2c-jz4780.c
> index 664a5471d9335..d729cec9cdf2c 100644
> --- a/drivers/i2c/busses/i2c-jz4780.c
> +++ b/drivers/i2c/busses/i2c-jz4780.c
> @@ -141,6 +141,7 @@ struct jz4780_i2c {
> =C2=A0	void __iomem		*iomem;
> =C2=A0	int			 irq;
> =C2=A0	struct clk		*clk;
> +	unsigned		long clk_rate;

That's a weird spacing. Should probably be "unsigned long" on the left
side.

> =C2=A0	struct i2c_adapter	 adap;
> =C2=A0	const struct ingenic_i2c_config *cdata;
> =C2=A0
> @@ -246,7 +247,7 @@ static int jz4780_i2c_set_target(struct
> jz4780_i2c *i2c, unsigned char address)
> =C2=A0
> =C2=A0static int jz4780_i2c_set_speed(struct jz4780_i2c *i2c)
> =C2=A0{
> -	int dev_clk_khz =3D clk_get_rate(i2c->clk) / 1000;
> +	int dev_clk_khz =3D i2c->clk_rate / 1000;

You cache `i2c->clk_rate` but only use it divided by 1000, so maybe
cache `clk_rate_khz` instead?

Cheers,
-Paul

> =C2=A0	int cnt_high =3D 0;	/* HIGH period count of the SCL
> clock */
> =C2=A0	int cnt_low =3D 0;	/* LOW period count of the SCL clock
> */
> =C2=A0	int cnt_period =3D 0;	/* period count of the SCL clock */
> @@ -796,6 +797,8 @@ static int jz4780_i2c_probe(struct
> platform_device *pdev)
> =C2=A0	if (IS_ERR(i2c->clk))
> =C2=A0		return PTR_ERR(i2c->clk);
> =C2=A0
> +	i2c->clk_rate =3D clk_get_rate(i2c->clk);
> +
> =C2=A0	ret =3D of_property_read_u32(pdev->dev.of_node, "clock-
> frequency",
> =C2=A0				=C2=A0=C2=A0 &clk_freq);
> =C2=A0	if (ret) {
