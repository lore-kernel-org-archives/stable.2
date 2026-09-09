Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C093D54A7FD
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953507; cv=none; b=QJg64ylUs8ZGwf23Y3V/WiOa4fHo6O5iCW/Mv8A3zaMqzXgr9ncnQFnV7xETNb7Qd1R9QR8XOPU39/0TK2jCXUkIJGmstm2COxHgDq4QZ1mahEpIMmsP5qwBvk/sdZg7vLyedWeNN/Lnbncpcor5SnSSUOgUTZt/IV1uUmm4haE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953507; c=relaxed/simple;
	bh=O0UsgYXzvFML8jffIZP15V3Z8VumDVCiZ3v82Mv99bM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=li+f9FL7HViQ1AA/YOfw6fSSmWat4vWuRGNik5hnR6weL3n7LXW4nXCZRjg/m6AwZ5e7vJXpwOekMlfLT19SFf1/IN0YVre7cNyqtpfE9GYSMAAS9K0uTNqAh6xAyq1X18Surhugr0nbGgH08KXyIretoS4ykkgQDErPXSEizgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQEVyFzW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQEVyFzW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4491F00A3A;
	Wed,  9 Sep 2026 11:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788953505;
	bh=1AXGHq0rEZM+YoJ2qlq316RAZyYzUQjeRA9ZperhHyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bQEVyFzWu98pdki8SVHbLivzluPqYDENIDr5Guxb6gNcVKdJGz9aklIVfWgnSmcr5
	 D71PAiz1b8bDKEtWcf/T/5hBTCiI10J0GYMz+lMtvy6S0KMVoiElUkw331V+2qqh/f
	 LwsMP3i5KP6huPyXlJA1hgGQBawDAYDzwvAGosrCtcGTP9qTmybkZRLqvniHcXxXVW
	 /edsdsJyLgCv1IrFHbGel6JaOH+NsltrXgvpQ2tpTAoYaoK3CvPApo0W9Oa1lK7HZz
	 2rqJYUI+cG9D2IWFtTR9hZJrz38QZk28vh2cT4xQf/D1lwiIipXejSb6ImT5rvaX5Z
	 NDSjRe3YrcE4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jianing Li <m13940358460@163.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] power: supply: max17040: propagate register read errors
Date: Wed,  9 Sep 2026 07:31:42 -0400
Message-ID: <20260909113142.1868881-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909113142.1868881-1-sashal@kernel.org>
References: <2026090314-unplowed-trance-1ff3@gregkh>
 <20260909113142.1868881-1-sashal@kernel.org>
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
index 13e82a1ab2aee..f82c26ebb33aa 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -190,8 +190,11 @@ static int max17040_raw_vcell_to_uvolts(struct max17040_chip *chip, u16 vcell)
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
@@ -199,8 +202,11 @@ static int max17040_get_vcell(struct max17040_chip *chip)
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
@@ -259,7 +265,11 @@ static int max17040_get_of_data(struct max17040_chip *chip)
 
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
@@ -393,10 +403,16 @@ static int max17040_get_property(struct power_supply *psy,
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

