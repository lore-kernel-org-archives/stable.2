Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327395;
	b=0l7H4jY2ZSJKln2o3eF3yF+sVYn28i6cVmPmamho85pNUOTcbaMp/AIC55Z0KYTHRAs7
	 wpDp+ShfdoJz3pLxkZxTLwmHnEO3zLUjBM+X5jhj0Qey4efnKqF+AbmUloOWIwRros34Q
	 xcPvrbZvedOjYWv4GOu9Tpaq1DUzl83AJt2XGNOteND8SFKdAdjH+wntfs/fjHkz4p2Dl
	 s+NE8qiDD6TYUITX8MNX9hqRnO5am/6fpaYPqaCN58QacQvg04CNtLlTOlU+g5MDyQsIX
	 DKtgJqzdXeVQ2N8kHdSEW7E5WD8shItgPoLTP8jpvG9P67iKEnSLwlE7v6gPdNuM7JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327395;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=jBCDaiC9UOf2LzI06whE71LtAo8nO0Z3y669lZ3rsOI=;
	b=2GDCm3KkUWUzJ0Eq1ysXMrjxA3b75yhw1H2KyR902W5MUqrNn+5M7H5uA2AjZkzH/Ukk
	 stuSg/sNb05N6WYPBb0pbKYxG7EXU+fINAAc9ywwvKykTGehBbp90IvMiDmXqGKK0vfPS
	 3vMO1gCugdCoOGnmT/kLlrEosULYDoCNhUUUc/sPSIwrE0fHXHlxcPb8RvNJs1aRfuGpU
	 cqvEYQCfg1ulELRkdLI8FsR7d8l4zoBSoWEE0tPMOcakRl6RSLTZJGx/aOHHOLXiutgv9
	 YE2pgXZM8iEIoo5CMpkQ6Lc5GcvSxXiTIS+pQ33E2Qfl+oyk3L4TfCdXkGUYPKXi7kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="YAF/1YOd";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659A7606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YAF/1YOd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738011F0089F;
	Tue, 10 Nov 2026 16:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794327395;
	bh=jBCDaiC9UOf2LzI06whE71LtAo8nO0Z3y669lZ3rsOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YAF/1YOdFjBr/lMsaVTHYfsBz/UihX2/2zsl05bn5CsKlx1EOyV63m1EZ8tNfOu3o
	 mIs71dT6MhVv7QMF3qYyrQfuhvBwI6rhM/o9uD7yY4OuCub13ffSm07x+yRIJkXgDY
	 Ec2ujoOKV2+ZcBBzcRnhftNqJ5v9pRF2QAr/pkVX2a6LF7Exj0D0qxXKqiqh6W7/t3
	 cRs5SLEVX1fcg4bMMD8r/RyxKik8Gi5LCFjbcUhJ7yFfY6CIlLlm1esgtMr5qxNV/8
	 TGR+DD/ZRP6qUbuAaaQ4XM+UpfvkytCqgCF4gQhVV8NJBPCC1GnyAANCpPmnwZLBvk
	 SxtjFm0VeCiDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Lee Jones <lee.jones@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] mfd: twl: Remove platform data support
Date: Tue, 10 Nov 2026 11:16:31 -0500
Message-ID: <20261110161605.2449325-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061659-failed-5.10-3c5c55d979dd@kernel.org>
References: <20261107061659-failed-5.10-3c5c55d979dd@kernel.org>
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
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 4a346a03a63cb45f7766d9d6559cf3fee783e926 ]

There is no in-tree machine that provides a struct twl4030_platform_data
since commit e92fc4f04a34 ("ARM: OMAP2+: Drop legacy board file for
LDP"). So assume dev_get_platdata() returns NULL in twl_probe() and
simplify accordingly.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Link: https://lore.kernel.org/r/20220614152148.252820-1-u.kleine-koenig@pengutronix.de
Stable-dep-of: 3c5c55d979dd ("mfd: twl-core: Unregister the auxiliary platform device on unbind")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/twl-core.c  | 323 +---------------------------------------
 include/linux/mfd/twl.h |  55 -------
 2 files changed, 5 insertions(+), 373 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 20cf8cfe4f3b5..718ae54f4d6f6 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -656,309 +656,6 @@ static inline struct device *add_child(unsigned mod_no, const char *name,
 		can_wakeup, irq0, irq1);
 }
 
-static struct device *
-add_regulator_linked(int num, struct regulator_init_data *pdata,
-		struct regulator_consumer_supply *consumers,
-		unsigned num_consumers, unsigned long features)
-{
-	struct twl_regulator_driver_data drv_data;
-
-	/* regulator framework demands init_data ... */
-	if (!pdata)
-		return NULL;
-
-	if (consumers) {
-		pdata->consumer_supplies = consumers;
-		pdata->num_consumer_supplies = num_consumers;
-	}
-
-	if (pdata->driver_data) {
-		/* If we have existing drv_data, just add the flags */
-		struct twl_regulator_driver_data *tmp;
-		tmp = pdata->driver_data;
-		tmp->features |= features;
-	} else {
-		/* add new driver data struct, used only during init */
-		drv_data.features = features;
-		drv_data.set_voltage = NULL;
-		drv_data.get_voltage = NULL;
-		drv_data.data = NULL;
-		pdata->driver_data = &drv_data;
-	}
-
-	/* NOTE:  we currently ignore regulator IRQs, e.g. for short circuits */
-	return add_numbered_child(TWL_MODULE_PM_MASTER, "twl_reg", num,
-		pdata, sizeof(*pdata), false, 0, 0);
-}
-
-static struct device *
-add_regulator(int num, struct regulator_init_data *pdata,
-		unsigned long features)
-{
-	return add_regulator_linked(num, pdata, NULL, 0, features);
-}
-
-/*
- * NOTE:  We know the first 8 IRQs after pdata->base_irq are
- * for the PIH, and the next are for the PWR_INT SIH, since
- * that's how twl_init_irq() sets things up.
- */
-
-static int
-add_children(struct twl4030_platform_data *pdata, unsigned irq_base,
-		unsigned long features)
-{
-	struct device	*child;
-
-	if (IS_ENABLED(CONFIG_GPIO_TWL4030) && pdata->gpio) {
-		child = add_child(TWL4030_MODULE_GPIO, "twl4030_gpio",
-				pdata->gpio, sizeof(*pdata->gpio),
-				false, irq_base + GPIO_INTR_OFFSET, 0);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-	}
-
-	if (IS_ENABLED(CONFIG_KEYBOARD_TWL4030) && pdata->keypad) {
-		child = add_child(TWL4030_MODULE_KEYPAD, "twl4030_keypad",
-				pdata->keypad, sizeof(*pdata->keypad),
-				true, irq_base + KEYPAD_INTR_OFFSET, 0);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-	}
-
-	if (IS_ENABLED(CONFIG_TWL4030_MADC) && pdata->madc &&
-	    twl_class_is_4030()) {
-		child = add_child(TWL4030_MODULE_MADC, "twl4030_madc",
-				pdata->madc, sizeof(*pdata->madc),
-				true, irq_base + MADC_INTR_OFFSET, 0);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-	}
-
-	if (IS_ENABLED(CONFIG_RTC_DRV_TWL4030)) {
-		/*
-		 * REVISIT platform_data here currently might expose the
-		 * "msecure" line ... but for now we just expect board
-		 * setup to tell the chip "it's always ok to SET_TIME".
-		 * Eventually, Linux might become more aware of such
-		 * HW security concerns, and "least privilege".
-		 */
-		child = add_child(TWL_MODULE_RTC, "twl_rtc", NULL, 0,
-				true, irq_base + RTC_INTR_OFFSET, 0);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-	}
-
-	if (IS_ENABLED(CONFIG_PWM_TWL)) {
-		child = add_child(TWL_MODULE_PWM, "twl-pwm", NULL, 0,
-				  false, 0, 0);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-	}
-
-	if (IS_ENABLED(CONFIG_PWM_TWL_LED)) {
-		child = add_child(TWL_MODULE_LED, "twl-pwmled", NULL, 0,
-				  false, 0, 0);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-	}
-
-	if (IS_ENABLED(CONFIG_TWL4030_USB) && pdata->usb &&
-	    twl_class_is_4030()) {
-
-		static struct regulator_consumer_supply usb1v5 = {
-			.supply =	"usb1v5",
-		};
-		static struct regulator_consumer_supply usb1v8 = {
-			.supply =	"usb1v8",
-		};
-		static struct regulator_consumer_supply usb3v1 = {
-			.supply =	"usb3v1",
-		};
-
-	/* First add the regulators so that they can be used by transceiver */
-		if (IS_ENABLED(CONFIG_REGULATOR_TWL4030)) {
-			/* this is a template that gets copied */
-			struct regulator_init_data usb_fixed = {
-				.constraints.valid_modes_mask =
-					REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-				.constraints.valid_ops_mask =
-					REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-			};
-
-			child = add_regulator_linked(TWL4030_REG_VUSB1V5,
-						      &usb_fixed, &usb1v5, 1,
-						      features);
-			if (IS_ERR(child))
-				return PTR_ERR(child);
-
-			child = add_regulator_linked(TWL4030_REG_VUSB1V8,
-						      &usb_fixed, &usb1v8, 1,
-						      features);
-			if (IS_ERR(child))
-				return PTR_ERR(child);
-
-			child = add_regulator_linked(TWL4030_REG_VUSB3V1,
-						      &usb_fixed, &usb3v1, 1,
-						      features);
-			if (IS_ERR(child))
-				return PTR_ERR(child);
-
-		}
-
-		child = add_child(TWL_MODULE_USB, "twl4030_usb",
-				pdata->usb, sizeof(*pdata->usb), true,
-				/* irq0 = USB_PRES, irq1 = USB */
-				irq_base + USB_PRES_INTR_OFFSET,
-				irq_base + USB_INTR_OFFSET);
-
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-
-		/* we need to connect regulators to this transceiver */
-		if (IS_ENABLED(CONFIG_REGULATOR_TWL4030) && child) {
-			usb1v5.dev_name = dev_name(child);
-			usb1v8.dev_name = dev_name(child);
-			usb3v1.dev_name = dev_name(child);
-		}
-	}
-
-	if (IS_ENABLED(CONFIG_TWL4030_WATCHDOG) && twl_class_is_4030()) {
-		child = add_child(TWL_MODULE_PM_RECEIVER, "twl4030_wdt", NULL,
-				  0, false, 0, 0);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-	}
-
-	if (IS_ENABLED(CONFIG_INPUT_TWL4030_PWRBUTTON) && twl_class_is_4030()) {
-		child = add_child(TWL_MODULE_PM_MASTER, "twl4030_pwrbutton",
-				  NULL, 0, true, irq_base + 8 + 0, 0);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-	}
-
-	if (IS_ENABLED(CONFIG_MFD_TWL4030_AUDIO) && pdata->audio &&
-	    twl_class_is_4030()) {
-		child = add_child(TWL4030_MODULE_AUDIO_VOICE, "twl4030-audio",
-				pdata->audio, sizeof(*pdata->audio),
-				false, 0, 0);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-	}
-
-	/* twl4030 regulators */
-	if (IS_ENABLED(CONFIG_REGULATOR_TWL4030) && twl_class_is_4030()) {
-		child = add_regulator(TWL4030_REG_VPLL1, pdata->vpll1,
-					features);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-
-		child = add_regulator(TWL4030_REG_VIO, pdata->vio,
-					features);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-
-		child = add_regulator(TWL4030_REG_VDD1, pdata->vdd1,
-					features);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-
-		child = add_regulator(TWL4030_REG_VDD2, pdata->vdd2,
-					features);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-
-		child = add_regulator(TWL4030_REG_VMMC1, pdata->vmmc1,
-					features);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-
-		child = add_regulator(TWL4030_REG_VDAC, pdata->vdac,
-					features);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-
-		child = add_regulator((features & TWL4030_VAUX2)
-					? TWL4030_REG_VAUX2_4030
-					: TWL4030_REG_VAUX2,
-				pdata->vaux2, features);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-
-		child = add_regulator(TWL4030_REG_VINTANA1, pdata->vintana1,
-					features);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-
-		child = add_regulator(TWL4030_REG_VINTANA2, pdata->vintana2,
-					features);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-
-		child = add_regulator(TWL4030_REG_VINTDIG, pdata->vintdig,
-					features);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-	}
-
-	/* maybe add LDOs that are omitted on cost-reduced parts */
-	if (IS_ENABLED(CONFIG_REGULATOR_TWL4030) && !(features & TPS_SUBSET)
-	  && twl_class_is_4030()) {
-		child = add_regulator(TWL4030_REG_VPLL2, pdata->vpll2,
-					features);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-
-		child = add_regulator(TWL4030_REG_VMMC2, pdata->vmmc2,
-					features);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-
-		child = add_regulator(TWL4030_REG_VSIM, pdata->vsim,
-					features);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-
-		child = add_regulator(TWL4030_REG_VAUX1, pdata->vaux1,
-					features);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-
-		child = add_regulator(TWL4030_REG_VAUX3, pdata->vaux3,
-					features);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-
-		child = add_regulator(TWL4030_REG_VAUX4, pdata->vaux4,
-					features);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-	}
-
-	if (IS_ENABLED(CONFIG_CHARGER_TWL4030) && pdata->bci &&
-			!(features & (TPS_SUBSET | TWL5031))) {
-		child = add_child(TWL_MODULE_MAIN_CHARGE, "twl4030_bci",
-				pdata->bci, sizeof(*pdata->bci), false,
-				/* irq0 = CHG_PRES, irq1 = BCI */
-				irq_base + BCI_PRES_INTR_OFFSET,
-				irq_base + BCI_INTR_OFFSET);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-	}
-
-	if (IS_ENABLED(CONFIG_TWL4030_POWER) && pdata->power) {
-		child = add_child(TWL_MODULE_PM_MASTER, "twl4030_power",
-				  pdata->power, sizeof(*pdata->power), false,
-				  0, 0);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-	}
-
-	return 0;
-}
-
 /*----------------------------------------------------------------------*/
 
 /*
@@ -987,8 +684,7 @@ static inline int unprotect_pm_master(void)
 	return e;
 }
 
-static void clocks_init(struct device *dev,
-			struct twl4030_clock_init_data *clock)
+static void clocks_init(struct device *dev)
 {
 	int e = 0;
 	struct clk *osc;
@@ -1018,8 +714,6 @@ static void clocks_init(struct device *dev,
 	}
 
 	ctrl |= HIGH_PERF_SQ;
-	if (clock && clock->ck32k_lowpwr_enable)
-		ctrl |= CK32K_LOWPWR_EN;
 
 	e |= unprotect_pm_master();
 	/* effect->MADC+USB ck en */
@@ -1067,7 +761,6 @@ static struct of_dev_auxdata twl_auxdata_lookup[] = {
 static int
 twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
-	struct twl4030_platform_data	*pdata = dev_get_platdata(&client->dev);
 	struct device_node		*node = client->dev.of_node;
 	struct platform_device		*pdev;
 	const struct regmap_config	*twl_regmap_config;
@@ -1075,7 +768,7 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	int				status;
 	unsigned			i, num_slaves;
 
-	if (!node && !pdata) {
+	if (!node) {
 		dev_err(&client->dev, "no platform data\n");
 		return -EINVAL;
 	}
@@ -1165,7 +858,7 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	twl_priv->ready = true;
 
 	/* setup clock framework */
-	clocks_init(&client->dev, pdata ? pdata->clock : NULL);
+	clocks_init(&client->dev);
 
 	/* read TWL IDCODE Register */
 	if (twl_class_is_4030()) {
@@ -1213,14 +906,8 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 				 TWL4030_DCDC_GLOBAL_CFG);
 	}
 
-	if (node) {
-		if (pdata)
-			twl_auxdata_lookup[0].platform_data = pdata->gpio;
-		status = of_platform_populate(node, NULL, twl_auxdata_lookup,
-					      &client->dev);
-	} else {
-		status = add_children(pdata, irq_base, id->driver_data);
-	}
+	status = of_platform_populate(node, NULL, twl_auxdata_lookup,
+				      &client->dev);
 
 fail:
 	if (status < 0)
diff --git a/include/linux/mfd/twl.h b/include/linux/mfd/twl.h
index 089e8942223aa..3b91dc858a465 100644
--- a/include/linux/mfd/twl.h
+++ b/include/linux/mfd/twl.h
@@ -694,61 +694,6 @@ struct twl4030_audio_data {
 	unsigned int irq_base;
 };
 
-struct twl4030_platform_data {
-	struct twl4030_clock_init_data		*clock;
-	struct twl4030_bci_platform_data	*bci;
-	struct twl4030_gpio_platform_data	*gpio;
-	struct twl4030_madc_platform_data	*madc;
-	struct twl4030_keypad_data		*keypad;
-	struct twl4030_usb_data			*usb;
-	struct twl4030_power_data		*power;
-	struct twl4030_audio_data		*audio;
-
-	/* Common LDO regulators for TWL4030/TWL6030 */
-	struct regulator_init_data		*vdac;
-	struct regulator_init_data		*vaux1;
-	struct regulator_init_data		*vaux2;
-	struct regulator_init_data		*vaux3;
-	struct regulator_init_data		*vdd1;
-	struct regulator_init_data		*vdd2;
-	struct regulator_init_data		*vdd3;
-	/* TWL4030 LDO regulators */
-	struct regulator_init_data		*vpll1;
-	struct regulator_init_data		*vpll2;
-	struct regulator_init_data		*vmmc1;
-	struct regulator_init_data		*vmmc2;
-	struct regulator_init_data		*vsim;
-	struct regulator_init_data		*vaux4;
-	struct regulator_init_data		*vio;
-	struct regulator_init_data		*vintana1;
-	struct regulator_init_data		*vintana2;
-	struct regulator_init_data		*vintdig;
-	/* TWL6030 LDO regulators */
-	struct regulator_init_data              *vmmc;
-	struct regulator_init_data              *vpp;
-	struct regulator_init_data              *vusim;
-	struct regulator_init_data              *vana;
-	struct regulator_init_data              *vcxio;
-	struct regulator_init_data              *vusb;
-	struct regulator_init_data		*clk32kg;
-	struct regulator_init_data              *v1v8;
-	struct regulator_init_data              *v2v1;
-	/* TWL6032 LDO regulators */
-	struct regulator_init_data		*ldo1;
-	struct regulator_init_data		*ldo2;
-	struct regulator_init_data		*ldo3;
-	struct regulator_init_data		*ldo4;
-	struct regulator_init_data		*ldo5;
-	struct regulator_init_data		*ldo6;
-	struct regulator_init_data		*ldo7;
-	struct regulator_init_data		*ldoln;
-	struct regulator_init_data		*ldousb;
-	/* TWL6032 DCDC regulators */
-	struct regulator_init_data		*smps3;
-	struct regulator_init_data		*smps4;
-	struct regulator_init_data		*vio6025;
-};
-
 struct twl_regulator_driver_data {
 	int		(*set_voltage)(void *data, int target_uV);
 	int		(*get_voltage)(void *data);
-- 
2.53.0

