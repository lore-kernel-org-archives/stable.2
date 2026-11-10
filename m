Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331281;
	b=KOml5WfbMnbs1zzmz8kSclEfBW0Kuon8RyQQ/KAJ6VR1J6bys/eiUqLIHEYY550oWN67
	 F78KGaqfVQoeDxFzN79dzxd2UFsltHkKe4oT2/qg1n21AD+2+SWPyYUTmRhmO8/3gej6h
	 Dwpe0P4R/KZoQxbwcaSnKwgQxHEFy/guyMhNkrk6wq9cRcxUPhFyZsDkfL7jjBf+syCCF
	 Ffz6I5QPO3Jvd0mrPq2KYSR9g2D1IXeTw0G/g5xIBKwIYS5Nxx4XSjyzjzi8rRoUGEjql
	 FUw9Bl6496YQGPOb6wqmG9emtPSKRXwY5LblSC4CXoMbHLix2tEPL9MnFlqtuu6WK0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331281;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=sA6MrSxFmlMk/pPBfg0d0BtSNXHcWS6SJYA9h+XFALs=;
	b=evHDd7WYfZAnBrsjf1vvbfvAQ5kwyZSDGmdeYbQmdR8G9B4CVXPEyCCmGGmf+hzuINaX
	 8Hyqkk2Wf6hkCewRrjT9H+34clXmww3OFZIYkf5kJQ8nL5myZZPQAKZv9JHXCpJRli1KC
	 wlX7VFGK3NtzBmLA5yu8wxT/9zorXsSKD+TLNiKfODN5TRKoEgpi1mIKsKvSBbicbiQos
	 UEiEb7SAFXwzBZxSOXzKHdrGjF/PYrU2EUYDSBnqchdqSnTDUnEhNVD7N+jYS0ZZcxp4L
	 JG221OroC4uMj9E5tDpw9WrAveI/m4Cq9Xy0xN/kCXUvHLiH8xRy8BrYElp5Eboymhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OWgn+Ixw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28BA606A323
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OWgn+Ixw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA301F0089F;
	Tue, 10 Nov 2026 17:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794331280;
	bh=sA6MrSxFmlMk/pPBfg0d0BtSNXHcWS6SJYA9h+XFALs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OWgn+IxwKLd1X1vORk548ADhTUCKhWX45Goh4ea4IxWl1F23DXCShnkHWB4bKIm2n
	 Dmlbs2CnKoHlyOlz/uxfSte5b5A48YMVW7+dlUm1sFXP82dMdXkHUH83J5VFrdYkVB
	 73eHmNRsDanorIT4++P0DsAAKsoRMEJKt5urLRynPDUUQDdGBjUbvOr/qx3y5oaj1T
	 HVpxsY1SQ1AFU1ImtekavVNZYdFNTyzwCdTbGbpf4hM3aVcszKp21oEHiQM1//ZEqd
	 33ZK9rpbC5SPThdUk9SmWH1TlflMJ7jrebdmoftaMb4fdAFyEMAnb4qdDAiscZ8CUl
	 Gk2NZ1ZuwWdfQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 5/7] power: supply: core: use power_supply_for_each_psy()
Date: Tue, 10 Nov 2026 12:21:11 -0500
Message-ID: <20261110172014.2622013-5-sashal@kernel.org>
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
index 260de00996bc1..2929e21b82032 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -63,10 +63,9 @@ static bool __power_supply_is_supplied_by(struct power_supply *supplier,
 	return false;
 }
 
-static int __power_supply_changed_work(struct device *dev, void *data)
+static int __power_supply_changed_work(struct power_supply *pst, void *data)
 {
 	struct power_supply *psy = data;
-	struct power_supply *pst = dev_get_drvdata(dev);
 
 	if (__power_supply_is_supplied_by(psy, pst)) {
 		if (pst->desc->external_power_changed)
@@ -95,7 +94,7 @@ static void power_supply_changed_work(struct work_struct *work)
 	if (likely(psy->changed)) {
 		psy->changed = false;
 		spin_unlock_irqrestore(&psy->changed_lock, flags);
-		power_supply_for_each_device(psy, __power_supply_changed_work);
+		power_supply_for_each_psy(psy, __power_supply_changed_work);
 		power_supply_update_leds(psy);
 		blocking_notifier_call_chain(&power_supply_notifier,
 				PSY_EVENT_PROP_CHANGED, psy);
@@ -187,11 +186,10 @@ static void power_supply_deferred_register_work(struct work_struct *work)
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
 
@@ -218,20 +216,19 @@ static int power_supply_populate_supplied_from(struct power_supply *psy)
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
 
@@ -243,16 +240,16 @@ static int power_supply_find_supply_from_node(struct device_node *supply_node)
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
@@ -332,10 +329,9 @@ struct psy_am_i_supplied_data {
 	unsigned int count;
 };
 
-static int __power_supply_am_i_supplied(struct device *dev, void *_data)
+static int __power_supply_am_i_supplied(struct power_supply *epsy, void *_data)
 {
 	union power_supply_propval ret = {0,};
-	struct power_supply *epsy = dev_get_drvdata(dev);
 	struct psy_am_i_supplied_data *data = _data;
 
 	if (__power_supply_is_supplied_by(epsy, data->psy)) {
@@ -353,7 +349,7 @@ int power_supply_am_i_supplied(struct power_supply *psy)
 	struct psy_am_i_supplied_data data = { psy, 0 };
 	int error;
 
-	error = power_supply_for_each_device(&data, __power_supply_am_i_supplied);
+	error = power_supply_for_each_psy(&data, __power_supply_am_i_supplied);
 
 	dev_dbg(&psy->dev, "%s count %u err %d\n", __func__, data.count, error);
 
@@ -364,10 +360,9 @@ int power_supply_am_i_supplied(struct power_supply *psy)
 }
 EXPORT_SYMBOL_GPL(power_supply_am_i_supplied);
 
-static int __power_supply_is_system_supplied(struct device *dev, void *data)
+static int __power_supply_is_system_supplied(struct power_supply *psy, void *data)
 {
 	union power_supply_propval ret = {0,};
-	struct power_supply *psy = dev_get_drvdata(dev);
 	unsigned int *count = data;
 
 	if (!psy->desc->get_property(psy, POWER_SUPPLY_PROP_SCOPE, &ret))
@@ -388,7 +383,7 @@ int power_supply_is_system_supplied(void)
 	int error;
 	unsigned int count = 0;
 
-	error = power_supply_for_each_device(&count, __power_supply_is_system_supplied);
+	error = power_supply_for_each_psy(&count, __power_supply_is_system_supplied);
 
 	/*
 	 * If no system scope power class device was found at all, most probably we
@@ -407,9 +402,8 @@ struct psy_get_supplier_prop_data {
 	union power_supply_propval *val;
 };
 
-static int __power_supply_get_supplier_property(struct device *dev, void *_data)
+static int __power_supply_get_supplier_property(struct power_supply *epsy, void *_data)
 {
-	struct power_supply *epsy = dev_get_drvdata(dev);
 	struct psy_get_supplier_prop_data *data = _data;
 
 	if (__power_supply_is_supplied_by(epsy, data->psy))
@@ -434,7 +428,7 @@ int power_supply_get_property_from_supplier(struct power_supply *psy,
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

