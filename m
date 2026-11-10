Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794352233;
	b=hNrOPyKAv3xocvcg7+siqeIeF6NWfOw4AZSv3eWrOdzGTVzNf3wYCM9krZ1wFLNcEZ+z
	 0FY3KtUeuKfIHGvt1JkI0ZYj//7k7nrWh+fDbl0+mairaFKtO7ToiLrGuPPDxlBZ9UQru
	 CjiQyRFrVRl721/c7bdkHx4rVZZ92P3d6HBdgWNR+2U5NWOmeIGMRMi88bKx6dENVlV0Z
	 KxCkWjptdtBmZeV6+/lSt1h/dLFfEb2qiW3+BUKgJ2Gs2IQ37aylopo4Bxiz3dc+02qky
	 iwvQXZPa7l+u7FbXoA58CTuM+6mtIKGDpxnJaNPaOmfclyjVZm8i5pe6N4oeUf3oGXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794352233;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8zBAiSes49lYwxr1rzNiKX88xIXObDRLeo0/v06lRqA=;
	b=MVKNmT5hRqC34K6a5gCFwKY0krlxZtaPO/6cKsiEcxkP8/NFCVOWGAGMB+dWaWcuNPme
	 2fMvC1rhp4SyuACLDOUGrZag70W+j6s7LUjSvHzTUP3Wl8mKE+y5/zP+uGmuQPFqTwp8W
	 woqsoesfxECLxCvkxf2hG7vpJpgo9Yt3I7n54GvGV74TG70nSHLrXGZ5ed3OhzQYzSUk5
	 1sGniNHIg189dndquW8rnFyakzW5eYsIEQM/SZqS6wh3PGPPVmN+65R0NtxVWQj5Dk0LO
	 bStAOD8yv792BXIS+WSHcnhC6FybPAj1ucXrdbW6t4UM7pCptfQjiE4mtlkeuQ3zTqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=igaPQnir;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F192606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=igaPQnir
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38B01F0093D;
	Tue, 10 Nov 2026 23:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794352233;
	bh=8zBAiSes49lYwxr1rzNiKX88xIXObDRLeo0/v06lRqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=igaPQnirP00mGzR8aZMDcncv4MW+TIwX4nqE4yi1r7DFO9Rcq5i7pXJ4d34xWQL1a
	 91zW9K5c7fAHGSSak6vBHastOeUn9vySJgmRUjBsoDmOEhAyAF688S2qScPDJv3hMP
	 c0mEnAMI/7Ximr35f43IaV26rRPf967VLWJZr9nBtMeslp864NBL6kE6G1xU33DCvb
	 bBwjSQbbJ4u4sYRKYTT73xROwxO+ePNrH1td20YCJzWMTGYgliG8fNbkcCjibgdJb4
	 HF6BoPxDnnrutg7MVj48e1767+TvIIa1TeZC+GdPZX9YvWEh8qLkSI6F7l6JNVJfsK
	 qM4QoCo5jL3jg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/7] power: supply: generic-adc-battery: drop charge now support
Date: Tue, 10 Nov 2026 18:10:26 -0500
Message-ID: <20261110231006.55369-3-sashal@kernel.org>
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

