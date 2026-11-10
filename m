Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794351477;
	b=bqb3VyshtXeBpqG50cQ/JQbkag+eTTHFgMr+PiQ5qRO4ekgYztn/mBu7HU2l+jotP3oO
	 4Fbcv5iEBfAQXmnBbs+Wdch4k4Hj9/+cx5GWLJRTR8tPc8usqVQgcQwrvE46zOa5jANh3
	 e9fJ8CSew+guS98B04AFP227JHUlPeBlXwOpRtcDBh7yx/qiG8+vGLNgystqf9iLSUZ2s
	 RNk0ru6+yRr7sq+usblFAGgDbp7x6IJvr9nPJnkNhJVSOZC5ASyswFUL7IaXMtvWPLJYh
	 8txfvsoQlfLR/oqVGFwgvl8a5BwTxDjltNpGRUEE+WilEwmbR9Qe6SAXm9Om4cdzYUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794351477;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8zBAiSes49lYwxr1rzNiKX88xIXObDRLeo0/v06lRqA=;
	b=UuVSCdnBUcRKBgtwapxfcCQpI++zM1+5CvVRmBwB07HfVZcsB/CdEqRYwwF9U+lovenV
	 ZlhGovuT8x5j5oGg0Ew9u99X1Zet4PEtVWp3KQTTCmrix4mOOXz9HbiI05EHcaB1WuMlb
	 drL7BvhTEBTLM8+XlMLNLFx009cVfOPdcFtuNAXxJ1ugnxSfu8VVTyuBFQo9WWkg2OhxA
	 mmLDIN284UNR9pWp67mWoBPLLQltVtXo6pisGUcoWmtURu0OPCcZa6ZDq6BXUISlQ+voI
	 kz0pkTIRNDtGZwzQiGoGn6P0GzYqcYP6pK29632yG1gZVcY/uPPASs1+p93+8Uxf1aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MQtSdWVk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8931F606A327
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MQtSdWVk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0BA1F0093E;
	Tue, 10 Nov 2026 22:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794351477;
	bh=8zBAiSes49lYwxr1rzNiKX88xIXObDRLeo0/v06lRqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MQtSdWVkWXzLfl8jYwmwb6A1a93mqOqTZXhxygWWaRnp6qBB+0NbLnK7Yf53ad2h9
	 KGV/goVALXOUMnI/2C8lNm6yJdCIl0eWUj5uI7bdvvioh+wl2tLg/1dwlUrG0vh05D
	 wbvqImZYGFKZb3j1kJys7kgiCizjMAOhblTUSgE6do9hakbikNEu7xd/GVgdPSJLqb
	 XSiEcI7asWbRgmwD2CsKm1Sy3+zz6zHC63Wy2GaVFiYd+VtfvxlK04Cuwdf46PL32E
	 84QlTgh+M9OiSKmIkeO6Z/cppnJpnVpQfRz9lujvvf/A/qSCPo5K/D5Ce7zhPzFJlD
	 ZhWFFpFrbprKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/7] power: supply: generic-adc-battery: drop charge now support
Date: Tue, 10 Nov 2026 17:57:49 -0500
Message-ID: <20261110225738.4066560-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110225738.4066560-1-sashal@kernel.org>
References: <20261107055053-failed-6.1-8ae5a3f40045@kernel.org>
 <20261110225738.4066560-1-sashal@kernel.org>
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

[ Upstream commit 3b6fd262bfcd696aa98af99d71dcf952f289cbee ]

Drop CHARGE_NOW support, which requires a platform specific
calculation method.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
Stable-dep-of: 8ae5a3f40045 ("power: supply: generic-adc-battery: fix status with no supplier")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/generic-adc-battery.c | 4 ----
 include/linux/power/generic-adc-battery.h  | 2 --
 2 files changed, 6 deletions(-)

diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index e20894460d7fb..d07eeb7d46d34 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -72,7 +72,6 @@ static const enum power_supply_property gab_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
 	POWER_SUPPLY_PROP_CHARGE_EMPTY_DESIGN,
-	POWER_SUPPLY_PROP_CHARGE_NOW,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
 	POWER_SUPPLY_PROP_TECHNOLOGY,
@@ -166,9 +165,6 @@ static int gab_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CHARGE_EMPTY_DESIGN:
 		val->intval = 0;
 		break;
-	case POWER_SUPPLY_PROP_CHARGE_NOW:
-		val->intval = pdata->cal_charge(result);
-		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 	case POWER_SUPPLY_PROP_POWER_NOW:
diff --git a/include/linux/power/generic-adc-battery.h b/include/linux/power/generic-adc-battery.h
index 50eb4bf28286b..54434e4304d35 100644
--- a/include/linux/power/generic-adc-battery.h
+++ b/include/linux/power/generic-adc-battery.h
@@ -10,11 +10,9 @@
  * struct gab_platform_data - platform_data for generic adc iio battery driver.
  * @battery_info:         recommended structure to specify static power supply
  *			   parameters
- * @cal_charge:           calculate charge level.
  */
 struct gab_platform_data {
 	struct power_supply_info battery_info;
-	int	(*cal_charge)(long value);
 };
 
 #endif /* GENERIC_ADC_BATTERY_H */
-- 
2.53.0

