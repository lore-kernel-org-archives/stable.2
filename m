Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331278;
	b=NJ0z0/sSW8dNuydiRCPy8BSMPW/v9XYu1IcQNRJvfRy5+J9ETyOu3pNfNsoT/VZqTVrw
	 jRKmix21fBqml+EQNZmjH2NaWGOkc+Iu3qFlxZcAvMZJI+IPobR90yaAxNrEyWyx8Q8b4
	 rFBJFgzLZSZrBQpAYaNVEC3nRVhB/JnBLUoRAMNm97VOA2jrzwKiYhoTioyFzTczGyLpi
	 v00iWhbNJyzdcKsQZpuZn/zT1Hq2T6iGoMxm/PjIcna+lQKBXyOrnQ/HUqinf0Dz498Yd
	 EciIlyFWCAO2WVKji5YLmxgHNe++Kw1BZvj3vuutyM2yruYHlEVk8eBZ0Y8v5KvPGOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331278;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vflkL1UZvEk1b9/EzLzdAW2R1K1XdbjQLWP0na9RzL4=;
	b=1PRv9nlc96HhHx3FyQK2TGl5CEmneg0rKSXryxDe1dSodtJjNVcO2DVI7YhwXA4JUjzp
	 qGSzqnDiR9a4uwuAZKNrrdjUixWD3RqDPdfjrUy+iintPVK1lnljbx4urbvOTqb9989lY
	 onorMlLT5kcHeaVQoQeeanLSiHzB66NFUVOEEOKMGzSQ5p0fBHax39vx6sCyRIL+b6UKi
	 YFkyPGMMPut61KcL8Ci/uZhV7rzwSTsgeQbzxvNuQS2awPwxdZPGnWFl+pXZxnpuzs02o
	 mkk75bzRWBzIjmtpCohFcCJIgAQmwSWt7WpLqyDlOIcQuIADik6ao3fWX4vM5OhLPCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=buGzpRDM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C20606A330
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=buGzpRDM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9F81F008A2;
	Tue, 10 Nov 2026 17:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794331278;
	bh=vflkL1UZvEk1b9/EzLzdAW2R1K1XdbjQLWP0na9RzL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=buGzpRDMtFNH/um0G/x6xf1VtAhbtN1isWqFMp5J8ky7FekATKBFuIsEZYH+2NFTh
	 NqQFLv6o29YNAirWejioYY5rjZBh/1+YKDuuPLZ/x0TwWzU8nD2BfqpgmN3/nEEs0X
	 ZBxL9v8wSEvHCjEZi3TCUzgiOleQDxK39lAS1oH0GmAS2aoZRUs7eDom6w67c+/IH2
	 EzRPM1dV1ewS7qiZr2/kudE+WIjnEkRgsyCAm4Wewsm3+UKa/wV4oa8hkanSi1fgcu
	 /gyrdA3lgx9Xv1MZmZ7ZhINPWCksdJBZTQ2g6jT9SVk/VqOyYpRzAx5IGr2eoDJZg6
	 QD44MAxpfQbBg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/7] power: supply: core: add power_supply_for_each_device()
Date: Tue, 10 Nov 2026 12:21:09 -0500
Message-ID: <20261110172014.2622013-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110172014.2622013-1-sashal@kernel.org>
References: <20261107053127-failed-6.6-6bd80f22c764@kernel.org>
 <20261110172014.2622013-1-sashal@kernel.org>
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

From: Sebastian Reichel <sebastian.reichel@collabora.com>

[ Upstream commit 68ade0976df7979eac5f1d46320ff798f5043af6 ]

Introduce power_supply_for_each_device(), which is a wrapper
for class_for_each_device() using the power_supply_class and
going through all devices.

This allows making the power_supply_class itself a local
variable, so that drivers cannot mess with it and simplifies
the code slightly.

Reviewed-by: Ricardo B. Marliere <ricardo@marliere.net>
Link: https://lore.kernel.org/r/20240301-psy-class-cleanup-v1-1-aebe8c4b6b08@collabora.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Stable-dep-of: 6bd80f22c764 ("power: supply: core: Honor supplied-from with CONFIG_OF=y")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/ab8500_btemp.c      |  3 +--
 drivers/power/supply/ab8500_chargalg.c   |  3 +--
 drivers/power/supply/ab8500_charger.c    |  3 +--
 drivers/power/supply/ab8500_fg.c         |  3 +--
 drivers/power/supply/apm_power.c         |  3 +--
 drivers/power/supply/power_supply_core.c | 34 +++++++++++-------------
 include/linux/power_supply.h             |  3 +--
 7 files changed, 22 insertions(+), 30 deletions(-)

diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
index 3ea01301da9ff..1c6aed46091e9 100644
--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -617,8 +617,7 @@ static int ab8500_btemp_get_ext_psy_data(struct device *dev, void *data)
  */
 static void ab8500_btemp_external_power_changed(struct power_supply *psy)
 {
-	class_for_each_device(&power_supply_class, NULL, psy,
-			      ab8500_btemp_get_ext_psy_data);
+	power_supply_for_each_device(psy, ab8500_btemp_get_ext_psy_data);
 }
 
 /* ab8500 btemp driver interrupts and their respective isr */
diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/supply/ab8500_chargalg.c
index faff6f7f38054..5a79772394f65 100644
--- a/drivers/power/supply/ab8500_chargalg.c
+++ b/drivers/power/supply/ab8500_chargalg.c
@@ -1231,8 +1231,7 @@ static void ab8500_chargalg_algorithm(struct ab8500_chargalg *di)
 	int ret;
 
 	/* Collect data from all power_supply class devices */
-	class_for_each_device(&power_supply_class, NULL,
-		di->chargalg_psy, ab8500_chargalg_get_ext_psy_data);
+	power_supply_for_each_device(di->chargalg_psy, ab8500_chargalg_get_ext_psy_data);
 
 	ab8500_chargalg_end_of_charge(di);
 	ab8500_chargalg_check_temp(di);
diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index 39eeeb10b5b04..788908ab0836c 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -1949,8 +1949,7 @@ static void ab8500_charger_check_vbat_work(struct work_struct *work)
 	struct ab8500_charger *di = container_of(work,
 		struct ab8500_charger, check_vbat_work.work);
 
-	class_for_each_device(&power_supply_class, NULL,
-			      &di->usb_chg, ab8500_charger_get_ext_psy_data);
+	power_supply_for_each_device(&di->usb_chg, ab8500_charger_get_ext_psy_data);
 
 	/* First run old_vbat is 0. */
 	if (di->old_vbat == 0)
diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 178394a7b289a..26246cc559d5a 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -2408,8 +2408,7 @@ static int ab8500_fg_init_hw_registers(struct ab8500_fg *di)
  */
 static void ab8500_fg_external_power_changed(struct power_supply *psy)
 {
-	class_for_each_device(&power_supply_class, NULL, psy,
-			      ab8500_fg_get_ext_psy_data);
+	power_supply_for_each_device(psy, ab8500_fg_get_ext_psy_data);
 }
 
 /**
diff --git a/drivers/power/supply/apm_power.c b/drivers/power/supply/apm_power.c
index 0bde81dd22e6c..2dbb474acea67 100644
--- a/drivers/power/supply/apm_power.c
+++ b/drivers/power/supply/apm_power.c
@@ -79,8 +79,7 @@ static void find_main_battery(void)
 	main_battery = NULL;
 	bp.main = main_battery;
 
-	error = class_for_each_device(&power_supply_class, NULL, &bp,
-				      __find_main_battery);
+	error = power_supply_for_each_device(&bp, __find_main_battery);
 	if (error) {
 		main_battery = bp.main;
 		return;
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 43f72ca0cbe4f..df5e21ec01638 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -25,12 +25,10 @@
 #include "power_supply.h"
 #include "samsung-sdi-battery.h"
 
-/* exported for the APM Power driver, APM emulation */
-const struct class power_supply_class = {
+static const struct class power_supply_class = {
 	.name = "power_supply",
 	.dev_uevent = power_supply_uevent,
 };
-EXPORT_SYMBOL_GPL(power_supply_class);
 
 BLOCKING_NOTIFIER_HEAD(power_supply_notifier);
 EXPORT_SYMBOL_GPL(power_supply_notifier);
@@ -97,8 +95,7 @@ static void power_supply_changed_work(struct work_struct *work)
 	if (likely(psy->changed)) {
 		psy->changed = false;
 		spin_unlock_irqrestore(&psy->changed_lock, flags);
-		class_for_each_device(&power_supply_class, NULL, psy,
-				      __power_supply_changed_work);
+		power_supply_for_each_device(psy, __power_supply_changed_work);
 		power_supply_update_leds(psy);
 		blocking_notifier_call_chain(&power_supply_notifier,
 				PSY_EVENT_PROP_CHANGED, psy);
@@ -116,6 +113,12 @@ static void power_supply_changed_work(struct work_struct *work)
 	spin_unlock_irqrestore(&psy->changed_lock, flags);
 }
 
+int power_supply_for_each_device(void *data, int (*fn)(struct device *dev, void *data))
+{
+	return class_for_each_device(&power_supply_class, NULL, data, fn);
+}
+EXPORT_SYMBOL_GPL(power_supply_for_each_device);
+
 void power_supply_changed(struct power_supply *psy)
 {
 	unsigned long flags;
@@ -191,8 +194,7 @@ static int power_supply_populate_supplied_from(struct power_supply *psy)
 {
 	int error;
 
-	error = class_for_each_device(&power_supply_class, NULL, psy,
-				      __power_supply_populate_supplied_from);
+	error = power_supply_for_each_device(psy, __power_supply_populate_supplied_from);
 
 	dev_dbg(&psy->dev, "%s %d\n", __func__, error);
 
@@ -205,7 +207,7 @@ static int  __power_supply_find_supply_from_node(struct device *dev,
 	struct device_node *np = data;
 	struct power_supply *epsy = dev_get_drvdata(dev);
 
-	/* returning non-zero breaks out of class_for_each_device loop */
+	/* returning non-zero breaks out of power_supply_for_each_device loop */
 	if (epsy->of_node == np)
 		return 1;
 
@@ -217,17 +219,16 @@ static int power_supply_find_supply_from_node(struct device_node *supply_node)
 	int error;
 
 	/*
-	 * class_for_each_device() either returns its own errors or values
+	 * power_supply_for_each_device() either returns its own errors or values
 	 * returned by __power_supply_find_supply_from_node().
 	 *
 	 * __power_supply_find_supply_from_node() will return 0 (no match)
 	 * or 1 (match).
 	 *
-	 * We return 0 if class_for_each_device() returned 1, -EPROBE_DEFER if
+	 * We return 0 if power_supply_for_each_device() returned 1, -EPROBE_DEFER if
 	 * it returned 0, or error as returned by it.
 	 */
-	error = class_for_each_device(&power_supply_class, NULL, supply_node,
-				      __power_supply_find_supply_from_node);
+	error = power_supply_for_each_device(supply_node, __power_supply_find_supply_from_node);
 
 	return error ? (error == 1 ? 0 : error) : -EPROBE_DEFER;
 }
@@ -328,8 +329,7 @@ int power_supply_am_i_supplied(struct power_supply *psy)
 	struct psy_am_i_supplied_data data = { psy, 0 };
 	int error;
 
-	error = class_for_each_device(&power_supply_class, NULL, &data,
-				      __power_supply_am_i_supplied);
+	error = power_supply_for_each_device(&data, __power_supply_am_i_supplied);
 
 	dev_dbg(&psy->dev, "%s count %u err %d\n", __func__, data.count, error);
 
@@ -364,8 +364,7 @@ int power_supply_is_system_supplied(void)
 	int error;
 	unsigned int count = 0;
 
-	error = class_for_each_device(&power_supply_class, NULL, &count,
-				      __power_supply_is_system_supplied);
+	error = power_supply_for_each_device(&count, __power_supply_is_system_supplied);
 
 	/*
 	 * If no system scope power class device was found at all, most probably we
@@ -411,8 +410,7 @@ int power_supply_get_property_from_supplier(struct power_supply *psy,
 	 * This function is not intended for use with a supply with multiple
 	 * suppliers, we simply pick the first supply to report the psp.
 	 */
-	ret = class_for_each_device(&power_supply_class, NULL, &data,
-				    __power_supply_get_supplier_property);
+	ret = power_supply_for_each_device(&data, __power_supply_get_supplier_property);
 	if (ret < 0)
 		return ret;
 	if (ret == 0)
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 87cd0fefc1dc2..b08e00368f9de 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -895,8 +895,7 @@ extern int power_supply_powers(struct power_supply *psy, struct device *dev);
 #define to_power_supply(device) container_of(device, struct power_supply, dev)
 
 extern void *power_supply_get_drvdata(struct power_supply *psy);
-/* For APM emulation, think legacy userspace. */
-extern const struct class power_supply_class;
+extern int power_supply_for_each_device(void *data, int (*fn)(struct device *dev, void *data));
 
 static inline bool power_supply_is_amp_property(enum power_supply_property psp)
 {
-- 
2.53.0

