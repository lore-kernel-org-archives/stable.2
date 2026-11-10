Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794352234;
	b=KK52+CAoA6RWmIszAACG9/JuD6wmcEaL7CRrpM8gSEnvMvfk4C3P7yagvUWkkAwkgSKn
	 qTV5lEPPFva4tEWM+WB2Er+DAQmvovvdUVh75MVapI0/mjfpp2avOJt7IcZ8YJGH3Ew3s
	 3sovpORLneBrJjWbrTkhj5KFEtDn+GDXVOO+P96L96Y06wjVeZj13PRPf21X2Oy2KoY0y
	 gUzVHPDEXAc4opusdQq2bahISwhrer+ZYSuqd+ZvDdH1ngdA1ZBOVCwcb6PGjHOPinMs+
	 YvSaw2/yTmumWDwMioU7toxozOXZ1xUHXWY1b3iS5sdqEb70Xt9FOhZQG+kSnxNvORA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794352234;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZaOnkSYwhFznLzva/UvQmS+VX72c3lupjyfR8fMVnKA=;
	b=W2BYCHtOrhpiFEneV25s8dj5/LQS1C7I5EGL2lhWh/Yk7cTWTG+RO7nuR35jw48TdV8J
	 jKdRdyqc6fIs8u4ZrkTNqxnbQ4LH+I/+RsaotNrDq+c4qO49PhvGf7aTXVtRiAQAEGG3y
	 JsE5758r7e1FS266VXzOK+JpjGUpK6idummTneiMDmDqfc+OYtAk3VGCyMI1+9wRA7RV/
	 kzMsUA36Itufq6vVtY9bdCLxsMEtsFF8reOH/CCehckAMhPpJHzixo3F2S5IT1IL6HQWZ
	 kvDBVUVZTpgXcXJ9b6xCXKxIKLt916uT2vxhb8inV8FOYKIe8aVWypZFfI5PYsy2RrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Unqq7UX3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40729606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Unqq7UX3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AAA11F00A03;
	Tue, 10 Nov 2026 23:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794352234;
	bh=ZaOnkSYwhFznLzva/UvQmS+VX72c3lupjyfR8fMVnKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Unqq7UX3uIa9Hlrjn97HMoJTDF0CBlleLM5rf/wVX+od4hdrep+WdPNhJV/V4ZScR
	 EVUMdK20DeXWT93DyRqhddhnu9eFVduCTVuDF9R8XuzEZKyYofVW0opQ4r29ApWj+l
	 HX9T1FAIJQQP2W1V7REmeknOxAy+ubh/PX636wGeLjGWJ3eyvXNweeaYrQNyqsQIP+
	 7pWSHj28fb4EooiyVonCtI1T6kXM/zMtNbvqcqENziUp89dYTo1d51/H82lmZG2Cl3
	 1tsQBDLu3UWbCCW10cfHS2eb9Y2m9FMzJwlV7jPfrmU1XDoeqNDMmZ9mGtJ5nKHPMu
	 HMiQSnDLlsByg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/7] power: supply: generic-adc-battery: use simple-battery API
Date: Tue, 10 Nov 2026 18:10:27 -0500
Message-ID: <20261110231006.55369-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110231006.55369-1-sashal@kernel.org>
References: <20261107060802-failed-5.15-8ae5a3f40045@kernel.org>
 <20261110231006.55369-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sebastian Reichel <sre@kernel.org>

[ Upstream commit 1b27bf793fd46219c882b8e545ec736cfadc0841 ]

Constant battery data is available through power-supply's simple-battery
API. This works automatically, so the manual handling can be removed
without loosing any feature :)

Note, that the POWER_SUPPLY_STATUS_FULL check for the level variable can
be dropped, since the variable is never written. It can be re-introduced
properly once the driver gets functionality to calculate the current
charge level. Apart from that the check must be done fuzzy anyways,
since charge estimation usually is not precise enough to always return
exactly the full charge capacity for a full battery.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
Stable-dep-of: 8ae5a3f40045 ("power: supply: generic-adc-battery: fix status with no supplier")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/generic-adc-battery.c | 60 ++--------------------
 include/linux/power/generic-adc-battery.h  | 18 -------
 2 files changed, 4 insertions(+), 74 deletions(-)
 delete mode 100644 include/linux/power/generic-adc-battery.h

diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index d07eeb7d46d34..d89247d647f8a 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -22,7 +22,6 @@
 #include <linux/slab.h>
 #include <linux/iio/consumer.h>
 #include <linux/iio/types.h>
-#include <linux/power/generic-adc-battery.h>
 #include <linux/devm-helpers.h>
 
 #define JITTER_DEFAULT 10 /* hope 10ms is enough */
@@ -48,9 +47,7 @@ struct gab {
 	struct power_supply		*psy;
 	struct power_supply_desc	psy_desc;
 	struct iio_channel	*channel[GAB_MAX_CHAN_TYPE];
-	struct gab_platform_data	*pdata;
 	struct delayed_work bat_work;
-	int	level;
 	int	status;
 	bool cable_plugged;
 	struct gpio_desc *charge_finished;
@@ -70,14 +67,6 @@ static void gab_ext_power_changed(struct power_supply *psy)
 
 static const enum power_supply_property gab_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
-	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
-	POWER_SUPPLY_PROP_CHARGE_EMPTY_DESIGN,
-	POWER_SUPPLY_PROP_VOLTAGE_NOW,
-	POWER_SUPPLY_PROP_CURRENT_NOW,
-	POWER_SUPPLY_PROP_TECHNOLOGY,
-	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
-	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
-	POWER_SUPPLY_PROP_MODEL_NAME,
 };
 
 /*
@@ -97,17 +86,6 @@ static bool gab_charge_finished(struct gab *adc_bat)
 	return gpiod_get_value(adc_bat->charge_finished);
 }
 
-static int gab_get_status(struct gab *adc_bat)
-{
-	struct gab_platform_data *pdata = adc_bat->pdata;
-	struct power_supply_info *bat_info;
-
-	bat_info = &pdata->battery_info;
-	if (adc_bat->level == bat_info->charge_full_design)
-		return POWER_SUPPLY_STATUS_FULL;
-	return adc_bat->status;
-}
-
 static enum gab_chan_type gab_prop_to_chan(enum power_supply_property psp)
 {
 	switch (psp) {
@@ -144,27 +122,14 @@ static int read_channel(struct gab *adc_bat, enum power_supply_property psp,
 static int gab_get_property(struct power_supply *psy,
 		enum power_supply_property psp, union power_supply_propval *val)
 {
-	struct gab *adc_bat;
-	struct gab_platform_data *pdata;
-	struct power_supply_info *bat_info;
+	struct gab *adc_bat = to_generic_bat(psy);
 	int result = 0;
 	int ret = 0;
 
-	adc_bat = to_generic_bat(psy);
-	if (!adc_bat) {
-		dev_err(&psy->dev, "no battery infos ?!\n");
-		return -EINVAL;
-	}
-	pdata = adc_bat->pdata;
-	bat_info = &pdata->battery_info;
-
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
-		val->intval = gab_get_status(adc_bat);
-		break;
-	case POWER_SUPPLY_PROP_CHARGE_EMPTY_DESIGN:
-		val->intval = 0;
-		break;
+		val->intval = adc_bat->status;
+		return 0;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 	case POWER_SUPPLY_PROP_POWER_NOW:
@@ -173,21 +138,6 @@ static int gab_get_property(struct power_supply *psy,
 			goto err;
 		val->intval = result;
 		break;
-	case POWER_SUPPLY_PROP_TECHNOLOGY:
-		val->intval = bat_info->technology;
-		break;
-	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
-		val->intval = bat_info->voltage_min_design;
-		break;
-	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
-		val->intval = bat_info->voltage_max_design;
-		break;
-	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
-		val->intval = bat_info->charge_full_design;
-		break;
-	case POWER_SUPPLY_PROP_MODEL_NAME:
-		val->strval = bat_info->name;
-		break;
 	default:
 		return -EINVAL;
 	}
@@ -235,7 +185,6 @@ static int gab_probe(struct platform_device *pdev)
 	struct gab *adc_bat;
 	struct power_supply_desc *psy_desc;
 	struct power_supply_config psy_cfg = {};
-	struct gab_platform_data *pdata = pdev->dev.platform_data;
 	enum power_supply_property *properties;
 	int ret = 0;
 	int chan;
@@ -250,7 +199,7 @@ static int gab_probe(struct platform_device *pdev)
 
 	psy_cfg.drv_data = adc_bat;
 	psy_desc = &adc_bat->psy_desc;
-	psy_desc->name = pdata->battery_info.name;
+	psy_desc->name = dev_name(&pdev->dev);
 
 	/* bootup default values for the battery */
 	adc_bat->cable_plugged = false;
@@ -258,7 +207,6 @@ static int gab_probe(struct platform_device *pdev)
 	psy_desc->type = POWER_SUPPLY_TYPE_BATTERY;
 	psy_desc->get_property = gab_get_property;
 	psy_desc->external_power_changed = gab_ext_power_changed;
-	adc_bat->pdata = pdata;
 
 	/*
 	 * copying the static properties and allocating extra memory for holding
diff --git a/include/linux/power/generic-adc-battery.h b/include/linux/power/generic-adc-battery.h
deleted file mode 100644
index 54434e4304d35..0000000000000
--- a/include/linux/power/generic-adc-battery.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2012, Anish Kumar <anish198519851985@gmail.com>
- */
-
-#ifndef GENERIC_ADC_BATTERY_H
-#define GENERIC_ADC_BATTERY_H
-
-/**
- * struct gab_platform_data - platform_data for generic adc iio battery driver.
- * @battery_info:         recommended structure to specify static power supply
- *			   parameters
- */
-struct gab_platform_data {
-	struct power_supply_info battery_info;
-};
-
-#endif /* GENERIC_ADC_BATTERY_H */
-- 
2.53.0

