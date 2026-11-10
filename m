Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329432;
	b=cXmnowb6EZOdtLoyUEq2kN0MNzvoLBYmHoJ/lKfboMVYS7NDREKD+jKyj7snVhDTx4LF
	 0AEsTeqYxd82D4MeLsbvfWb/VDZeAxxOlPRi7pcCh5g1b4x2SQadDSApp9X3gbJ/H//pF
	 sZkkzohjvspchGe2GqG+DEb2XceVS+IzGab6XJMbAlUrduP8MWkX+xP64ywoou++zG1JG
	 YHH3YidU795t1aChvZUQy+YndpFieI+EVMuiUrrUM7oGa4ZD4I3Cw+uSB3jUx6bmkKsU3
	 3riNqj3H+piNC1kR6pjpgJ1jg36afoQ3dXwTQP2ARjFqJPn9ejqVyvH/KN13PpsXxww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329432;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=/qFLc9uGRXm0xnwObudC03iZhzL1FbKIKKa8cm6fvz4=;
	b=xpmvzxtKVtnymdc/0bKvVq/kjhQUdlVJ0L+2j+r6p7LA+RbQhTuMRaNDgBJmO3W+ETDc
	 xQvFJkTUQsyXumgN53JjdAaU4A+82Z8PvXwog3wpNH94WFHxa1g6q/CHkR6batnTc7Tgi
	 ZpDnQFaCzQKmW70XwTm4U2JVj8iKj6JoHPmT3C/HQXZfn4rTvCS1UslZXd/8Ho58B7TCm
	 5V2kIh7LnP4BKuWMnnZAcr+awn9N/RsacZFrCC+p8/y2T4PfylcuPjNMeG2kzdS9TnEQU
	 U6KnN3zmy7jFcglfoKcm6jezpJJPtFcnpOCwn6cltnisi73vxGF1hVEJE+Z8Gpb34Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RD9R85vp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5996960A2600
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RD9R85vp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8420C1F008A3;
	Tue, 10 Nov 2026 16:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794329432;
	bh=/qFLc9uGRXm0xnwObudC03iZhzL1FbKIKKa8cm6fvz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RD9R85vpwTQRHh828TEpk3Owlogx00WUpA2ohu+Tzyvsaei4wjEVAHfAL55Y/mAw3
	 sFg9h3ZBX5YJNmzavqFoxEhg7PCFTJ7d9hMCO4w7B3uuVkxJOfFxsx2QWt28G0apcW
	 FeKNTFyhX5ObqAudurso5s+A7SBOqY8ya6yQD9PcVABuhs/fp91V9109cO0tBgcnQI
	 neC3NTHuOl2GAUlWn/YPsfAQvkCHIuuVFvFGwyMNyxa48P7t60bXB4n6NxO7hncvxJ
	 RKUPLWm2gsXb7/rrnmsihssRQrQNIDDpz+oY9Ue6awhWrf7BZfvwdX3o/IfSn3LDPc
	 5nrkA7/mkGUYA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] power: supply: core: use power_supply_for_each_psy()
Date: Tue, 10 Nov 2026 11:50:27 -0500
Message-ID: <20261110164953.2511682-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110164953.2511682-1-sashal@kernel.org>
References: <20261107051904-failed-6.12-6bd80f22c764@kernel.org>
 <20261110164953.2511682-1-sashal@kernel.org>
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

From: Thomas Weißschuh <linux@weissschuh.net>

[ Upstream commit 68abaf7323ae857db7ec56a174b7bbf5fc687d47 ]

Simplify the callbacks by removing the need to convert a 'struct device'
into a 'struct power_supply'.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Link: https://lore.kernel.org/r/20241210-power-supply-dev_to_psy-v2-3-9d8c9d24cfe4@weissschuh.net
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Stable-dep-of: 6bd80f22c764 ("power: supply: core: Honor supplied-from with CONFIG_OF=y")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/power_supply_core.c | 36 ++++++++++--------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 34aca2c76cc5d..252930b54138d 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -66,10 +66,9 @@ static bool __power_supply_is_supplied_by(struct power_supply *supplier,
 	return false;
 }
 
-static int __power_supply_changed_work(struct device *dev, void *data)
+static int __power_supply_changed_work(struct power_supply *pst, void *data)
 {
 	struct power_supply *psy = data;
-	struct power_supply *pst = dev_get_drvdata(dev);
 
 	if (__power_supply_is_supplied_by(psy, pst)) {
 		if (pst->desc->external_power_changed)
@@ -98,7 +97,7 @@ static void power_supply_changed_work(struct work_struct *work)
 	if (likely(psy->changed)) {
 		psy->changed = false;
 		spin_unlock_irqrestore(&psy->changed_lock, flags);
-		power_supply_for_each_device(psy, __power_supply_changed_work);
+		power_supply_for_each_psy(psy, __power_supply_changed_work);
 		power_supply_update_leds(psy);
 		blocking_notifier_call_chain(&power_supply_notifier,
 				PSY_EVENT_PROP_CHANGED, psy);
@@ -190,11 +189,10 @@ static void power_supply_deferred_register_work(struct work_struct *work)
 }
 
 #ifdef CONFIG_OF
-static int __power_supply_populate_supplied_from(struct device *dev,
+static int __power_supply_populate_supplied_from(struct power_supply *epsy,
 						 void *data)
 {
 	struct power_supply *psy = data;
-	struct power_supply *epsy = dev_get_drvdata(dev);
 	struct device_node *np;
 	int i = 0;
 
@@ -221,20 +219,19 @@ static int power_supply_populate_supplied_from(struct power_supply *psy)
 {
 	int error;
 
-	error = power_supply_for_each_device(psy, __power_supply_populate_supplied_from);
+	error = power_supply_for_each_psy(psy, __power_supply_populate_supplied_from);
 
 	dev_dbg(&psy->dev, "%s %d\n", __func__, error);
 
 	return error;
 }
 
-static int  __power_supply_find_supply_from_node(struct device *dev,
+static int  __power_supply_find_supply_from_node(struct power_supply *epsy,
 						 void *data)
 {
 	struct device_node *np = data;
-	struct power_supply *epsy = dev_get_drvdata(dev);
 
-	/* returning non-zero breaks out of power_supply_for_each_device loop */
+	/* returning non-zero breaks out of power_supply_for_each_psy loop */
 	if (epsy->of_node == np)
 		return 1;
 
@@ -246,16 +243,16 @@ static int power_supply_find_supply_from_node(struct device_node *supply_node)
 	int error;
 
 	/*
-	 * power_supply_for_each_device() either returns its own errors or values
+	 * power_supply_for_each_psy() either returns its own errors or values
 	 * returned by __power_supply_find_supply_from_node().
 	 *
 	 * __power_supply_find_supply_from_node() will return 0 (no match)
 	 * or 1 (match).
 	 *
-	 * We return 0 if power_supply_for_each_device() returned 1, -EPROBE_DEFER if
+	 * We return 0 if power_supply_for_each_psy() returned 1, -EPROBE_DEFER if
 	 * it returned 0, or error as returned by it.
 	 */
-	error = power_supply_for_each_device(supply_node, __power_supply_find_supply_from_node);
+	error = power_supply_for_each_psy(supply_node, __power_supply_find_supply_from_node);
 
 	return error ? (error == 1 ? 0 : error) : -EPROBE_DEFER;
 }
@@ -335,10 +332,9 @@ struct psy_am_i_supplied_data {
 	unsigned int count;
 };
 
-static int __power_supply_am_i_supplied(struct device *dev, void *_data)
+static int __power_supply_am_i_supplied(struct power_supply *epsy, void *_data)
 {
 	union power_supply_propval ret = {0,};
-	struct power_supply *epsy = dev_get_drvdata(dev);
 	struct psy_am_i_supplied_data *data = _data;
 
 	if (__power_supply_is_supplied_by(epsy, data->psy)) {
@@ -356,7 +352,7 @@ int power_supply_am_i_supplied(struct power_supply *psy)
 	struct psy_am_i_supplied_data data = { psy, 0 };
 	int error;
 
-	error = power_supply_for_each_device(&data, __power_supply_am_i_supplied);
+	error = power_supply_for_each_psy(&data, __power_supply_am_i_supplied);
 
 	dev_dbg(&psy->dev, "%s count %u err %d\n", __func__, data.count, error);
 
@@ -367,10 +363,9 @@ int power_supply_am_i_supplied(struct power_supply *psy)
 }
 EXPORT_SYMBOL_GPL(power_supply_am_i_supplied);
 
-static int __power_supply_is_system_supplied(struct device *dev, void *data)
+static int __power_supply_is_system_supplied(struct power_supply *psy, void *data)
 {
 	union power_supply_propval ret = {0,};
-	struct power_supply *psy = dev_get_drvdata(dev);
 	unsigned int *count = data;
 
 	if (!psy->desc->get_property(psy, POWER_SUPPLY_PROP_SCOPE, &ret))
@@ -391,7 +386,7 @@ int power_supply_is_system_supplied(void)
 	int error;
 	unsigned int count = 0;
 
-	error = power_supply_for_each_device(&count, __power_supply_is_system_supplied);
+	error = power_supply_for_each_psy(&count, __power_supply_is_system_supplied);
 
 	/*
 	 * If no system scope power class device was found at all, most probably we
@@ -410,9 +405,8 @@ struct psy_get_supplier_prop_data {
 	union power_supply_propval *val;
 };
 
-static int __power_supply_get_supplier_property(struct device *dev, void *_data)
+static int __power_supply_get_supplier_property(struct power_supply *epsy, void *_data)
 {
-	struct power_supply *epsy = dev_get_drvdata(dev);
 	struct psy_get_supplier_prop_data *data = _data;
 
 	if (__power_supply_is_supplied_by(epsy, data->psy))
@@ -437,7 +431,7 @@ int power_supply_get_property_from_supplier(struct power_supply *psy,
 	 * This function is not intended for use with a supply with multiple
 	 * suppliers, we simply pick the first supply to report the psp.
 	 */
-	ret = power_supply_for_each_device(&data, __power_supply_get_supplier_property);
+	ret = power_supply_for_each_psy(&data, __power_supply_get_supplier_property);
 	if (ret < 0)
 		return ret;
 	if (ret == 0)
-- 
2.53.0

