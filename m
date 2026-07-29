Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E330C42B75C;
	Wed, 29 Jul 2026 08:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785312580; cv=none; b=oEofhq81HmgTj08idLhbluyvYkYAuVXX03o7wsD+jC+gzgg2mCuxigfTIhHf6Zl7wMmzr1sVZq9bYL998Np760DPyN7VutEsTYsvYAoJaeuMlYzpyBco5nQ28Old+bteh3kWyc/WEc2cOUYKMPLJNE6OZReo49G9zrdOAHoL7P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785312580; c=relaxed/simple;
	bh=FKRCzNl9iXi9B2N+9NYj5FAjRRrTLfK+wJOxreVTgFs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QMkLxpXk5FuscuSOvfNT1MOWBC3mKQlo0uv7jIBgrdmCXb9CJIFOb5pfpBJ4BdD+tG8h1p9JJ/tenHR2tP6Ouk2O2Rbi9kTO/+nnKzT0+Z6j1u0HMaWwhleCWVRcOct50MqDUQGwGzHs5rYBKkYzU9Ru38okqH1T5GmXt3vm/SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=WhwvIDxd; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="WhwvIDxd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1785312576;
	bh=EDLt92zXnWfQkNO/nMchV0mYN1bzrdRqmWVRBvOZuQ8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=WhwvIDxddwF8BefP8Ku3WrZ9cHlrrGRjUlcYodcN4r0I0OdASSpQgC033WV/tvz1e
	 uTlW62UoIqsdZfpb/wrwr9ez80VpUpXFbVV9UKBkB8H/D7tCACaE34x7oa7JC7L9/v
	 yWb+mHk6LhoYZa9BPjSsvyh3f2jHy+Rosad7Uj6Q=
Received: from [127.0.0.1] (2607-8700-5500-e873-0000-0000-0000-1001.16clouds.com [IPv6:2607:8700:5500:e873::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 8C52765AAE;
	Wed, 29 Jul 2026 04:09:33 -0400 (EDT)
Message-ID: <affa49c80b0762b5b9e6ae4f4fa4ae787afecbd8.camel@xry111.site>
Subject: Re: [PATCH v8 2/2] i2c: ls2x: Add clocks property parsing and
 adjust bus speed
From: Xi Ruoyao <xry111@xry111.site>
To: Hongliang Wang <wanghongliang@loongson.cn>, Binbin Zhou
	 <zhoubinbin@loongson.cn>, Andi Shyti <andi.shyti@kernel.org>, Rob Herring
	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	 <conor+dt@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	loongarch@lists.linux.dev, Huacai Chen <chenhuacai@loongson.cn>, 
	stable@vger.kernel.org
Date: Wed, 29 Jul 2026 16:09:31 +0800
In-Reply-To: <20260721122604.12717-3-wanghongliang@loongson.cn>
References: <20260721122604.12717-1-wanghongliang@loongson.cn>
	 <20260721122604.12717-3-wanghongliang@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-07-21 at 20:26 +0800, Hongliang Wang wrote:
> The i2c-ls2x driver supports dts and acpi parameter passing.
>=20
> In dts, uses clock framework, by parsing clocks property to
> get i2c bus reference clock, and define the div of reference
> clock by device data.
>=20
> In acpi, by passing clocks property to describe i2c bus reference
> clock and clock-div property to describe the div of reference clock.
>=20
> Based on i2c bus reference clock(clock_a), i2c bus speed(clock_s)
> and div, calculate the prcescale of i2c divider register. The
> calculation formula is
>=20
> prcescale =3D (clock_a*10)/(div*clock_s)-1
>=20
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongliang Wang <wanghongliang@loongson.cn>

This resolves the jittery touchpad input on the EAECIS NL60R laptop.

Tested-by: Xi Ruoyao <xry111@xry111.site>

> ---
> =C2=A0drivers/i2c/busses/i2c-ls2x.c | 40 ++++++++++++++++++++++++++++++++=
---
> =C2=A01 file changed, 37 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-ls2x.c b/drivers/i2c/busses/i2c-ls2x.=
c
> index b475dd27b7af..25f8301ae14f 100644
> --- a/drivers/i2c/busses/i2c-ls2x.c
> +++ b/drivers/i2c/busses/i2c-ls2x.c
> @@ -12,6 +12,7 @@
> =C2=A0
> =C2=A0#include <linux/bitfield.h>
> =C2=A0#include <linux/bits.h>
> +#include <linux/clk.h>
> =C2=A0#include <linux/completion.h>
> =C2=A0#include <linux/device.h>
> =C2=A0#include <linux/iopoll.h>
> @@ -63,11 +64,19 @@
> =C2=A0/* The default bus frequency, which is an empirical value */
> =C2=A0#define LS2X_I2C_FREQ_STD	(33 * HZ_PER_KHZ)
> =C2=A0
> +/* The div of i2c reference clock on LS2K0500/2K1000/2K2000 */
> +#define LS2X_I2C_2K_CLOCK_DIV	40
> +
> +/* The div of i2c reference clock on LS7A1000/7A2000 */
> +#define LS2X_I2C_7A_CLOCK_DIV	50
> +
> =C2=A0struct ls2x_i2c_priv {
> =C2=A0	struct i2c_adapter	adapter;
> =C2=A0	void __iomem		*base;
> =C2=A0	struct i2c_timings	i2c_t;
> =C2=A0	struct completion	cmd_complete;
> +	unsigned int		div;
> +	unsigned int		pclk;
> =C2=A0};
> =C2=A0
> =C2=A0/*
> @@ -107,12 +116,13 @@ static void ls2x_i2c_adjust_bus_speed(struct ls2x_i=
2c_priv *priv)
> =C2=A0	else
> =C2=A0		t->bus_freq_hz =3D LS2X_I2C_FREQ_STD;
> =C2=A0
> +	val =3D (priv->pclk * 10) / (priv->div * t->bus_freq_hz) - 1;
> +
> =C2=A0	/*
> =C2=A0	 * According to the chip manual, we can only access the registers =
as bytes,
> =C2=A0	 * otherwise the high bits will be truncated.
> =C2=A0	 * So set the I2C frequency with a sequential writeb() instead of =
writew().
> =C2=A0	 */
> -	val =3D LS2X_I2C_PCLK_FREQ / (5 * t->bus_freq_hz) - 1;
> =C2=A0	writeb(FIELD_GET(GENMASK(7, 0), val), priv->base + I2C_LS2X_PRER_L=
O);
> =C2=A0	writeb(FIELD_GET(GENMASK(15, 8), val), priv->base + I2C_LS2X_PRER_=
HI);
> =C2=A0}
> @@ -287,6 +297,7 @@ static const struct i2c_algorithm ls2x_i2c_algo =3D {
> =C2=A0static int ls2x_i2c_probe(struct platform_device *pdev)
> =C2=A0{
> =C2=A0	int ret, irq;
> +	struct clk *clk;
> =C2=A0	struct i2c_adapter *adap;
> =C2=A0	struct ls2x_i2c_priv *priv;
> =C2=A0	struct device *dev =3D &pdev->dev;
> @@ -304,6 +315,29 @@ static int ls2x_i2c_probe(struct platform_device *pd=
ev)
> =C2=A0	if (irq < 0)
> =C2=A0		return irq;
> =C2=A0
> +	if (dev_of_node(dev)) {
> +		clk =3D devm_clk_get_optional_enabled(dev, NULL);
> +		if (IS_ERR(clk))
> +			return PTR_ERR(clk);
> +		if (clk)
> +			priv->pclk =3D clk_get_rate(clk);
> +		else
> +			priv->pclk =3D LS2X_I2C_PCLK_FREQ;
> +
> +		priv->div =3D (unsigned long)device_get_match_data(dev);
> +		if (!priv->div)
> +			priv->div =3D LS2X_I2C_2K_CLOCK_DIV;
> +	} else {
> +		/* clocks and clock-div are only ACPI properties. */
> +		ret =3D device_property_read_u32(dev, "clocks", &priv->pclk);
> +		if (ret)
> +			priv->pclk =3D LS2X_I2C_PCLK_FREQ;
> +
> +		ret =3D device_property_read_u32(dev, "clock-div", &priv->div);
> +		if (ret || !priv->div)
> +			priv->div =3D LS2X_I2C_7A_CLOCK_DIV;
> +	}
> +
> =C2=A0	/* Add the i2c adapter */
> =C2=A0	adap =3D &priv->adapter;
> =C2=A0	adap->retries =3D 5;
> @@ -349,8 +383,8 @@ static DEFINE_RUNTIME_DEV_PM_OPS(ls2x_i2c_pm_ops,
> =C2=A0				 ls2x_i2c_suspend, ls2x_i2c_resume, NULL);
> =C2=A0
> =C2=A0static const struct of_device_id ls2x_i2c_id_table[] =3D {
> -	{ .compatible =3D "loongson,ls2k-i2c" },
> -	{ .compatible =3D "loongson,ls7a-i2c" },
> +	{ .compatible =3D "loongson,ls2k-i2c", .data =3D (void *)LS2X_I2C_2K_CL=
OCK_DIV, },
> +	{ .compatible =3D "loongson,ls7a-i2c", .data =3D (void *)LS2X_I2C_7A_CL=
OCK_DIV, },
> =C2=A0	{ /* sentinel */ }
> =C2=A0};
> =C2=A0MODULE_DEVICE_TABLE(of, ls2x_i2c_id_table);

--=20
Xi Ruoyao <xry111@xry111.site>
