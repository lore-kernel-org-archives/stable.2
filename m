Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590CD54EED9
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955099; cv=none; b=XTYI7sN2Eg8eX0v+bok1yUitJQJhuD30IdpvzA6K0hV1CBUf0ktCbKiCLz8p+DvS4Us37UoEUaOLc5h79mvFdc1C9Ac9L9yxNLdCmUxp5eWHgBip3NaYZ28/Y+wUEL3fEUsnq/9PBcZFz4Ri/DQ2nGViXgQzGjRx1eu6YvaFcPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955099; c=relaxed/simple;
	bh=6yOjapjZwaembAbnRxNqx7QU2LnZuKwdpeS/s+2Kz1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TXNvoYTI9SWB2Ff+kwsMdauU7rnGzj0vgfG+H2EEXHWQFpi2jJI2mgbI5LmVacp1rTd7B0GYbH5Mn5Mk/eRsSXuo4E6SyumlfSiuCYr3IjohTbT0agzORLbbCCJc7bL1K0Qql+QyCAgRflqibPMfHUo4UzAjOsm4ZXTv2YB73rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMbZdKP7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMbZdKP7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB59F1F00A3A;
	Wed,  9 Sep 2026 11:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788955098;
	bh=DW3fPKS6jWhQqvy4hEVlFVS9mblwHtBnFuMUgLn3xM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mMbZdKP79oqd0PAcjb0xnawwaHttgp+utD5VEWhaPiQqDikgxOLpeligbcPfZACkp
	 zq5ZwmKy6McAEQ+QTjvbbYHUKUKz9xRQ8L+3pWFDEnRhAFRJ3smF71bF+muL2wk819
	 fKuiMW87Gd61jyFmvJJheXBr4ZiFguDCgJOBdYXMxNt+KrKEEoqZ5pzHoTWGNx63QY
	 Da8kA3RQKI3yq0UEj7oC5LfUOOEZjh0jXcsk2AwkpTfJcKY14LGA1Dn/EmzqCQAp4m
	 kvrkcOz18EG1uuPAxNzapcWriMRmL/4ZhP1b11IIXF6AIwqOx7GJ0ZwiO5hVM32Q9/
	 tsfJ8eCAPEDqQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jianing Li <m13940358460@163.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/4] power: supply: max17040: propagate register read errors
Date: Wed,  9 Sep 2026 07:58:13 -0400
Message-ID: <20260909115813.2181976-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909115813.2181976-1-sashal@kernel.org>
References: <2026090352-handyman-delegate-c138@gregkh>
 <20260909115813.2181976-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianing Li <m13940358460@163.com>

[ Upstream commit 659cc3d8d5ef246263873fce72c8cadeeed073cc ]

max17040_get_vcell() and max17040_get_soc() ignore errors returned by
regmap_read().  When an I2C transfer fails, the uninitialized register
value is converted and reported to userspace as a valid voltage or state
of charge.  The polling worker can also replace the cached state of charge
with the bogus value and emit a spurious change event.

Propagate read errors through the power supply get_property callback and
keep the last valid cached state of charge when polling fails.

Fixes: c6f4a42de60b ("Add MAX17040 Fuel Gauge driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jianing Li <m13940358460@163.com>
Link: https://patch.msgid.link/20260727064825.948-1-m13940358460@163.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/max17040_battery.c | 26 ++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index fad244a73c8ea..5f266c0244d8d 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -192,8 +192,11 @@ static int max17040_raw_vcell_to_uvolts(struct max17040_chip *chip, u16 vcell)
 static int max17040_get_vcell(struct max17040_chip *chip)
 {
 	u32 vcell;
+	int ret;
 
-	regmap_read(chip->regmap, MAX17040_VCELL, &vcell);
+	ret = regmap_read(chip->regmap, MAX17040_VCELL, &vcell);
+	if (ret)
+		return ret;
 
 	return max17040_raw_vcell_to_uvolts(chip, vcell);
 }
@@ -201,8 +204,11 @@ static int max17040_get_vcell(struct max17040_chip *chip)
 static int max17040_get_soc(struct max17040_chip *chip)
 {
 	u32 soc;
+	int ret;
 
-	regmap_read(chip->regmap, MAX17040_SOC, &soc);
+	ret = regmap_read(chip->regmap, MAX17040_SOC, &soc);
+	if (ret)
+		return ret;
 
 	return soc >> (chip->quirk_double_soc ? 9 : 8);
 }
@@ -263,7 +269,11 @@ static int max17040_get_of_data(struct max17040_chip *chip)
 
 static void max17040_check_changes(struct max17040_chip *chip)
 {
-	chip->soc = max17040_get_soc(chip);
+	int soc;
+
+	soc = max17040_get_soc(chip);
+	if (soc >= 0)
+		chip->soc = soc;
 }
 
 static void max17040_queue_work(struct max17040_chip *chip)
@@ -399,10 +409,16 @@ static int max17040_get_property(struct power_supply *psy,
 		val->intval = max17040_get_online(chip);
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
-		val->intval = max17040_get_vcell(chip);
+		ret = max17040_get_vcell(chip);
+		if (ret < 0)
+			return ret;
+		val->intval = ret;
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY:
-		val->intval = max17040_get_soc(chip);
+		ret = max17040_get_soc(chip);
+		if (ret < 0)
+			return ret;
+		val->intval = ret;
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN:
 		val->intval = chip->low_soc_alert;
-- 
2.53.0

