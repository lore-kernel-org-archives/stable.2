Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5133E1696;
	Wed, 23 Sep 2026 04:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790139496; cv=none; b=Y/cueHVkpUJ5XSG1Tds1R7NQOf2X+e+icEsAIxLvhq3I4jcmwkQSzY9xMoRmMeI9xFV0R//iIDRv9FtN8V15RS5zClf1L6lNwTSj1vdH9tvT5SB5l7viBvQA7vWLfjDlUMb7eVxNkt4vsU2IemyQqlUXzwS1cp20cBMPV9z9UDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790139496; c=relaxed/simple;
	bh=+xLjBZRqbhxJXVy1aoZOj+Hd6VxHwgD+0PmcD4Q6dHc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gN5RNY5UGZsFCVu+fl6DIHiFcJwBWwFNxUUPW/ivlN+bfK/cmJEcsw6fDvMy7wf+eFstUOsYJyPGkTK+1NYVMrBBbm9WNe8sq47K0vagDXcFlCHgLK/MbgNCWhdzjfZiXjwTBm9z4tB0NFH/nrV8M1MeXyIdcuNB8K2j1Xr5RDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Af2a0iLg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Af2a0iLg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3921F000FF;
	Wed, 23 Sep 2026 04:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790139481;
	bh=LgoJ5rliNTGR2MnIqbJdm3WRRpvsdhXpNYJ3jU1ZsRI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Af2a0iLgK8lejaIA5I1s0Px1nQ5kHtxCBopMl1KL2GDHqcnqm4WNqMcUyJlwRbdAA
	 qA/iPUHIZSkcXAsGagSxSgy+R/O77gXiKUpebn4e5cz9PUSIBIByCqDZBVA/nNuvwP
	 B3dk1IVUVY97GHD5dZZ8W388Ryr3XzJ7e2196NJjubrbnPMS9hqdGbSYOv01aUOaQK
	 hGKw3bLI7N9QFhrNcNpPoilY0JLOv7/aIoXKoQWEthjKLdY1N8XVMQMKOPAWWAIMbK
	 lqo36yWVCK6Ykxu1aNrgH26JonGGleu0xKepacBDK8NHGl9Zv2680hsJpZUnO1vc2j
	 Ilk56bgtz5I1A==
Subject: Re: [PATCH net v3] net: stmmac: request the MDIO reset GPIO only once
From: netdev-bot+sashiko@kernel.org
To: xiaolinkui@126.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 lorenzo.bianconi@oss.qualcomm.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 xiaolinkui@kylinos.cn, stable@vger.kernel.org
Date: Wed, 23 Sep 2026 04:57:59 +0000
Message-ID: <179013947978.2160803.13178881612960386709@kernel.org>
In-Reply-To: <20260921015727.2643540-1-xiaolinkui@126.com>
References: <20260921015727.2643540-1-xiaolinkui@126.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] New probe-failure path when the DT MDIO bus is disabled.
- [Low] Conditional-compilation mismatch between the new GPIO/delay
  acquisition and its only consumer.

--

net: stmmac: request the MDIO reset GPIO only once

The patch moves the "snps,reset" GPIO lookup and the "snps,reset-delays-us"
parsing out of stmmac_mdio_reset() and into stmmac_mdio_register(), caching
both in struct stmmac_priv. stmmac_mdio_reset() then only pulses the cached
descriptor, so the devm GPIO request happens once per device instead of once
per reset.

A couple of questions about the new probe-time acquisition below.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> index afe98ff5bdcb..cf768afd9237 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> @@ -384,33 +384,16 @@ int stmmac_mdio_reset(struct mii_bus *bus)
>  	struct stmmac_priv *priv = netdev_priv(bus->priv);
>  	unsigned int mii_address = priv->hw->mii.addr;
>  
> -#ifdef CONFIG_OF
> -	if (priv->device->of_node) {
> -		struct gpio_desc *reset_gpio;
> -		u32 delays[3] = { 0, 0, 0 };
> +	if (priv->mdio_reset_delays[0])
> +		msleep(DIV_ROUND_UP(priv->mdio_reset_delays[0], 1000));
>  
> -		reset_gpio = devm_gpiod_get_optional(priv->device,
> -						     "snps,reset",
> -						     GPIOD_OUT_LOW);
> -		if (IS_ERR(reset_gpio))
> -			return PTR_ERR(reset_gpio);
> +	gpiod_set_value_cansleep(priv->mdio_reset_gpio, 1);
> +	if (priv->mdio_reset_delays[1])
> +		msleep(DIV_ROUND_UP(priv->mdio_reset_delays[1], 1000));
>  
> -		device_property_read_u32_array(priv->device,
> -					       "snps,reset-delays-us",
> -					       delays, ARRAY_SIZE(delays));
> -
> -		if (delays[0])
> -			msleep(DIV_ROUND_UP(delays[0], 1000));
> -
> -		gpiod_set_value_cansleep(reset_gpio, 1);
> -		if (delays[1])
> -			msleep(DIV_ROUND_UP(delays[1], 1000));
> -
> -		gpiod_set_value_cansleep(reset_gpio, 0);
> -		if (delays[2])
> -			msleep(DIV_ROUND_UP(delays[2], 1000));
> -	}
> -#endif
> +	gpiod_set_value_cansleep(priv->mdio_reset_gpio, 0);
> +	if (priv->mdio_reset_delays[2])
> +		msleep(DIV_ROUND_UP(priv->mdio_reset_delays[2], 1000));
>  
>  	/* This is a workaround for problems with the STE101P PHY.
>  	 * It doesn't complete its reset until at least one clock cycle

[ ... ]

> @@ -608,6 +591,19 @@ int stmmac_mdio_register(struct net_device *ndev)
>  	if (!mdio_bus_data)
>  		return 0;
>  
> +	if (mdio_bus_data->needs_reset && dev_of_node(priv->device)) {
> +		priv->mdio_reset_gpio =
> +			devm_gpiod_get_optional(priv->device, "snps,reset",
> +						GPIOD_OUT_LOW);
> +		if (IS_ERR(priv->mdio_reset_gpio))
> +			return PTR_ERR(priv->mdio_reset_gpio);
> +
> +		device_property_read_u32_array(priv->device,
> +					       "snps,reset-delays-us",
> +					       priv->mdio_reset_delays,
> +					       ARRAY_SIZE(priv->mdio_reset_delays));
> +	}
> +

[Severity: Low]
Should this new block carry the same conditional compilation as its only
consumer?

The whole body of stmmac_mdio_reset(), including every use of
priv->mdio_reset_gpio and priv->mdio_reset_delays[], sits inside:

drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c:stmmac_mdio_reset() {
#if IS_ENABLED(CONFIG_STMMAC_PLATFORM)
	...
#endif
	return 0;
}

but the acquisition added here is not guarded that way. Before the patch the
devm_gpiod_get_optional() call lived inside that guard, so in a build with
CONFIG_STMMAC_PLATFORM=n no GPIO was requested at all.

stmmac_mdio.c is part of the core stmmac.o, and DWMAC_LOONGSON is declared
after "endif # STMMAC_PLATFORM" in drivers/net/ethernet/stmicro/stmmac/Kconfig
and only selects STMMAC_LIBPCI, so it can be built with STMMAC_PLATFORM=n.
loongson_dwmac_dt_config() sets needs_reset on a device that has an of_node:

drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c {
	plat->mdio_node = of_get_child_by_name(np, "mdio");
	if (plat->mdio_node) {
		dev_info(&pdev->dev, "Found MDIO subnode\n");
		plat->mdio_bus_data->needs_reset = true;
	}
}

In that configuration the line is claimed and driven low for the device
lifetime while the pulse code does not exist, and an acquisition error now
aborts stmmac_mdio_register() for a line that can never be used. Would it be
better for both sides to share one condition, either by guarding the
acquisition identically or by dropping the guard from the reset body?

[Severity: Medium]
Can this turn a disabled MDIO bus node into a MAC probe failure?

stmmac_mdio_setup() sets needs_reset from the mere presence of an MDIO child
node, and stmmac_of_get_mdio() uses for_each_child_of_node() /
of_get_child_by_name() without checking of_device_is_available(), so a node
with status = "disabled" still reaches this new block.

The acquisition and its "return PTR_ERR()" run before of_mdiobus_register()
gets a chance to report the disabled node, which stmmac_mdio_register()
currently treats as success:

drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c:stmmac_mdio_register() {
	err = of_mdiobus_register(new_bus, mdio_node);
	if (err == -ENODEV) {
		err = 0;
		dev_info(dev, "MDIO bus is disabled\n");
		goto bus_register_fail;
	}
}

and the -ENODEV comes from:

drivers/net/mdio/of_mdio.c:__of_mdiobus_register() {
	/* Do not continue if the node is disabled */
	if (!of_device_is_available(np))
		return -ENODEV;
}

Since bus->reset is only called from __mdiobus_register(), the pre-patch code
never requested the GPIO for a disabled MDIO node, so it could not fail there.
With this patch, a MAC node that still carries snps,reset-gpios whose
acquisition returns -EBUSY (another consumer owns the line) or a permanent
-EPROBE_DEFER aborts the MAC probe even though the reset can never run.

Would it make sense to acquire the descriptor only once the bus is known to be
enabled, still before its reset callback can run, or to let the disabled-bus
path tolerate the acquisition error the way it tolerates -ENODEV?

I could not find an in-tree device tree that combines a disabled mdio child
with a MAC-level snps,reset-gpios that fails to be acquired, so this one is
speculative, but nothing in the code appears to prevent the combination.

>  	stmmac_mdio_bus_config(priv);
>  
>  	new_bus = mdiobus_alloc();

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921015727.2643540-1-xiaolinkui%40126.com
