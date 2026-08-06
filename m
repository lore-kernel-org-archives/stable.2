Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EB141E6AD;
	Thu,  6 Aug 2026 08:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786005978; cv=none; b=INpC7v6ocFXht+sETbtk9Gg9bkamsJZNyTL0s5DLx7Gb+wAlg19BTy/RBIA5+/Rx2vaXIhxun8KHqmyrzTq37N6KUCJ4xHs9dzCcqQXB+BidHLSacSdnBgyEbrabgXDkU4UEAMCDxEyr/IclFBFuZKOWeVey2ZlyZG3cl/1LSBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786005978; c=relaxed/simple;
	bh=F6op/QJx9bTI1PI6Y9o9fXMP2jDyV11+mx/IsvqFbRw=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=sjMOtY7zjpSNJnyzbN23dA2yVtXPAQys5hUYaH2t/OiPigijQkS7UvB9XsWZ8KGHHr63B2xMhbPZv7xzHFc/v4fRjz6tpfR390M4Za+rCHJpTuYv66FMSlEoLSK0KM+sYhr5/Uv98iXXdH2uPp0rL8UZwlT5aOgS05ii363zbDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=aVUNKd7d; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="aVUNKd7d"
Received: from monstersaurus.ideasonboard.com (cpc89244-aztw30-2-0-cust6594.18-1.cable.virginm.net [86.31.185.195])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 552C11AAD;
	Thu,  6 Aug 2026 10:45:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1786005902;
	bh=F6op/QJx9bTI1PI6Y9o9fXMP2jDyV11+mx/IsvqFbRw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=aVUNKd7dLFPU0UEOL2UT+L9OHxtMNvNeRCoePwYUGs3ve+Pw3qOcp/10jaUPHX5Vb
	 54V9+ZFLmMxPVqH2AwU3VEQMD1Xb6jv1ZqjTHev82qx8tpuyRkPsGKaa6YDI/2LYTe
	 +K+Y2jSrKF9iJcOfszBVTxKxrNcoN/IVo4vbj/8s=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260806061804.1359700-1-serin.yeh@intel.com>
References: <20260806061804.1359700-1-serin.yeh@intel.com>
Subject: Re: [PATCH v4 1/2] media: i2c: ov8856 : remove ACPI node bypass mechanism
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: serin.yeh@intel.com, sakari.ailus@linux.intel.com, jimmy.su@intel.com, sarang.sapre@intel.com, bod@kernel.org, stable@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To: Serin Yeh <serin.yeh@intel.com>, linux-media@vger.kernel.org
Date: Thu, 06 Aug 2026 09:46:10 +0100
Message-ID: <178600597076.2317790.15882507123821898906@ping.linuxembedded.co.uk>
User-Agent: alot/0.9.1

Quoting Serin Yeh (2026-08-06 07:18:04)
> On Intel platforms the sensor is enumerated via ACPI, and an INT3472
> "discrete" companion device (the power-logic-control driver under
> drivers/platform/x86/intel/int3472) registers the sensor's
> reset/powerdown GPIOs and the regulator supply. These resources are
> therefore discoverable and usable through the standard gpiod/regulator
> lookups at probe time.
>=20
> However, the driver guarded both the GPIO/regulator acquisition in
> ov8856_get_hwcfg() and the whole power-on/off sequence with
> is_acpi_node() and skipped them on ACPI. As a result the sensor was
> never powered or reset by the driver, and probe failed when reading the
> chip ID in ov8856_identify_module().
>=20
> Remove the is_acpi_node() checks so the GPIO/regulator resources are
> acquired and the full power sequence runs regardless of the firmware
> interface. The driver now behaves consistently across DT and ACPI
> platforms and initialises the hardware correctly.

The calls to get GPIO resources is 'optional' but regulators aren't I
don't think. Is this still ok ?

I think it is - and we can't run a device without the regulators - but I
don't know how it works in ACPI land.


Sakari, could this cause any regression ? I think it's ok - I just have
a niggle of worry here in case there's something I'm not seeing.


> Tested on Intel platforms with kernel 6.17 and 7.0.
>=20
> Fixes: d2fa1134a48b ("media: i2c: ov8856: Use V4L2 legacy sensor clock he=
lper")

Is this accurate though? I don't think that commit caused or added the
ACPI checks. Was this just the first line that matched a git blame ?

I suspect the blame might lie further back.

devm_gpiod_get_optional was still guarded by
 "if (!is_acpi_node(fwnode))"

before d2fa1134a48b, it was just a bit higher before
devm_v4l2_sensor_clk_get().


--
Kieran


> Cc: stable@vger.kernel.org
> Signed-off-by: Serin Yeh <serin.yeh@intel.com>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  drivers/media/i2c/ov8856.c | 29 ++++++++++-------------------
>  1 file changed, 10 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/media/i2c/ov8856.c b/drivers/media/i2c/ov8856.c
> index 8bedb47cd7cf..9d2b0469a576 100644
> --- a/drivers/media/i2c/ov8856.c
> +++ b/drivers/media/i2c/ov8856.c
> @@ -2082,9 +2082,6 @@ static int ov8856_power_on(struct device *dev)
>         struct ov8856 *ov8856 =3D to_ov8856(sd);
>         int ret;
> =20
> -       if (is_acpi_node(dev_fwnode(dev)))
> -               return 0;
> -
>         ret =3D clk_prepare_enable(ov8856->xvclk);
>         if (ret < 0) {
>                 dev_err(dev, "failed to enable xvclk\n");
> @@ -2120,9 +2117,6 @@ static int ov8856_power_off(struct device *dev)
>         struct v4l2_subdev *sd =3D dev_get_drvdata(dev);
>         struct ov8856 *ov8856 =3D to_ov8856(sd);
> =20
> -       if (is_acpi_node(dev_fwnode(dev)))
> -               return 0;
> -
>         gpiod_set_value_cansleep(ov8856->reset_gpio, 1);
>         regulator_bulk_disable(ARRAY_SIZE(ov8856_supply_names),
>                                ov8856->supplies);
> @@ -2293,21 +2287,18 @@ static int ov8856_get_hwcfg(struct ov8856 *ov8856)
>                 dev_warn(dev, "external clock rate %u is unsupported",
>                          xvclk_rate);
> =20
> -       if (!is_acpi_node(fwnode)) {
> -               ov8856->reset_gpio =3D devm_gpiod_get_optional(dev, "rese=
t",
> -                                                            GPIOD_OUT_LO=
W);
> -               if (IS_ERR(ov8856->reset_gpio))
> -                       return PTR_ERR(ov8856->reset_gpio);
> +       ov8856->reset_gpio =3D devm_gpiod_get_optional(dev, "reset",
> +                                                    GPIOD_OUT_LOW);
> +       if (IS_ERR(ov8856->reset_gpio))
> +               return PTR_ERR(ov8856->reset_gpio);
> =20
> -               for (i =3D 0; i < ARRAY_SIZE(ov8856_supply_names); i++)
> -                       ov8856->supplies[i].supply =3D ov8856_supply_name=
s[i];
> +       for (i =3D 0; i < ARRAY_SIZE(ov8856_supply_names); i++)
> +               ov8856->supplies[i].supply =3D ov8856_supply_names[i];
> =20
> -               ret =3D devm_regulator_bulk_get(dev,
> -                                             ARRAY_SIZE(ov8856_supply_na=
mes),
> -                                             ov8856->supplies);
> -               if (ret)
> -                       return ret;
> -       }
> +       ret =3D devm_regulator_bulk_get(dev, ARRAY_SIZE(ov8856_supply_nam=
es),
> +                                     ov8856->supplies);
> +       if (ret)
> +               return ret;
> =20
>         ep =3D fwnode_graph_get_next_endpoint(fwnode, NULL);
>         if (!ep)
> --=20
> 2.25.1
>
