Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54B85111B8
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 16:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788797081; cv=none; b=UXmNqC6oabMsL2FlvY02AmLF9VK0XHyKAW6+iXQfCucAkzIJwvB170ZCjKWM6PEPHIUznTJCb82CdweQfcpnwHoza6TQ27wQCXZSLpDmY2m71h1TGFgd/QmZD87Ui16eFqHW+XvhQGFGOyIe9Kr7Maaiobrx6vsLPGfnl3xVJj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788797081; c=relaxed/simple;
	bh=CrjaX9TNx1HBuxQfCh2zZbn5WBNTh+XAC8acM3SwMTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JAmlolnNw8jGSZfTnyR/DwwBRphK9kN5URa1yYH6Tt70OlJlCv210n2Wj/O70uxAAnUf2W3IZ97xJPyiR2BfccOTd5F8s1hR/EE9gYm1LjyEAP5+r81iONMlqaYX8fIk/IcuCRn8V6YEnne9snMUAj2uBm/6giLes6KYDmtUuOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRZBDsG+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRZBDsG+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4D31F00A3A;
	Mon,  7 Sep 2026 16:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788797078;
	bh=ZSkzMBnGD33+8pHvHh5ikQ+sciRhql/e2/9VU+jdX3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DRZBDsG+h+jwnrsSG0wyu1pqnqFqP6kY/0nOMgb5a2mPAmw2sh0//NdthuS2nGq53
	 W6vcYTOzknxKXJrarK8YDocogVNUbYtLz6wjc9gdd2MrrKlid2UUWxIsh0q7sYQe6D
	 Ymlr7GnIZnNc+JR+vcBsgOWrrTlNJhyB2yu1zED+t1bdTTLYfAMrdXYVpbDr+BePgQ
	 QnxYaATSASmEeUAYYQfFR0AGqRNRJEw0WEnIORr8uOepGPIP9HjfXAoL24hZKGiFfW
	 UpdEcifZs4aNRMk21WAzkwIQpRBoyCvt0cl9rDNlo0JUWR2SxF6MJFtw6psatTsPBV
	 JVhFZNnSA7y3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rosalie Wanders <rosalie@mailbox.org>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 1/2] HID: sony: use guard() and scoped_guard()
Date: Mon,  7 Sep 2026 12:04:35 -0400
Message-ID: <20260907160436.4159774-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090342-yelling-voucher-a519@gregkh>
References: <2026090342-yelling-voucher-a519@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rosalie Wanders <rosalie@mailbox.org>

[ Upstream commit da4f817ad273bca9aefd8636d347a8c101069111 ]

This replaces the spin_lock_irqsave() and spin_unlock_irqrestore() calls
with the RAII guard() and scoped_guard().

Signed-off-by: Rosalie Wanders <rosalie@mailbox.org>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Stable-dep-of: 7c65699a3a31 ("HID: sony: clean up device list on probe failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-sony.c | 62 ++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 36 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index e75246d29e16d..cae5bd7e77dfb 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -29,6 +29,7 @@
  * There will be no PIN request from the device.
  */
 
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/module.h>
@@ -569,14 +570,12 @@ static void sony_set_leds(struct sony_sc *sc);
 static inline void sony_schedule_work(struct sony_sc *sc,
 				      enum sony_worker which)
 {
-	unsigned long flags;
-
 	switch (which) {
 	case SONY_WORKER_STATE:
-		spin_lock_irqsave(&sc->lock, flags);
-		if (!sc->defer_initialization && sc->state_worker_initialized)
-			schedule_work(&sc->state_worker);
-		spin_unlock_irqrestore(&sc->lock, flags);
+		scoped_guard(spinlock_irqsave, &sc->lock) {
+			if (!sc->defer_initialization && sc->state_worker_initialized)
+				schedule_work(&sc->state_worker);
+		}
 		break;
 	}
 }
@@ -949,7 +948,6 @@ static const u8 *sony_report_fixup(struct hid_device *hdev, u8 *rdesc,
 static void sixaxis_parse_report(struct sony_sc *sc, u8 *rd, int size)
 {
 	static const u8 sixaxis_battery_capacity[] = { 0, 1, 25, 50, 75, 100 };
-	unsigned long flags;
 	int offset;
 	u8 index;
 	u8 battery_capacity;
@@ -972,10 +970,10 @@ static void sixaxis_parse_report(struct sony_sc *sc, u8 *rd, int size)
 		battery_status = POWER_SUPPLY_STATUS_DISCHARGING;
 	}
 
-	spin_lock_irqsave(&sc->lock, flags);
-	sc->battery_capacity = battery_capacity;
-	sc->battery_status = battery_status;
-	spin_unlock_irqrestore(&sc->lock, flags);
+	scoped_guard(spinlock_irqsave, &sc->lock) {
+		sc->battery_capacity = battery_capacity;
+		sc->battery_status = battery_status;
+	}
 
 	if (sc->quirks & SIXAXIS_CONTROLLER) {
 		int val;
@@ -1092,7 +1090,6 @@ static void rb4_ps5_guitar_parse_report(struct sony_sc *sc, u8 *rd, int size)
 	u8 battery_data;
 	u8 battery_capacity;
 	u8 battery_status;
-	unsigned long flags;
 
 	/*
 	 * Rock Band 4 PS5 guitars have whammy and
@@ -1132,10 +1129,10 @@ static void rb4_ps5_guitar_parse_report(struct sony_sc *sc, u8 *rd, int size)
 		break;
 	}
 
-	spin_lock_irqsave(&sc->lock, flags);
-	sc->battery_capacity = battery_capacity;
-	sc->battery_status = battery_status;
-	spin_unlock_irqrestore(&sc->lock, flags);
+	scoped_guard(spinlock_irqsave, &sc->lock) {
+		sc->battery_capacity = battery_capacity;
+		sc->battery_status = battery_status;
+	}
 
 	input_sync(sc->input_dev);
 }
@@ -1869,15 +1866,14 @@ static int sony_battery_get_property(struct power_supply *psy,
 				     union power_supply_propval *val)
 {
 	struct sony_sc *sc = power_supply_get_drvdata(psy);
-	unsigned long flags;
 	int ret = 0;
 	u8 battery_capacity;
 	int battery_status;
 
-	spin_lock_irqsave(&sc->lock, flags);
-	battery_capacity = sc->battery_capacity;
-	battery_status = sc->battery_status;
-	spin_unlock_irqrestore(&sc->lock, flags);
+	scoped_guard(spinlock_irqsave, &sc->lock) {
+		battery_capacity = sc->battery_capacity;
+		battery_status = sc->battery_status;
+	}
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_PRESENT:
@@ -1959,10 +1955,9 @@ static inline int sony_compare_connection_type(struct sony_sc *sc0,
 static int sony_check_add_dev_list(struct sony_sc *sc)
 {
 	struct sony_sc *entry;
-	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&sony_dev_list_lock, flags);
+	guard(spinlock_irqsave)(&sony_dev_list_lock);
 
 	list_for_each_entry(entry, &sony_device_list, list_node) {
 		ret = memcmp(sc->mac_address, entry->mac_address,
@@ -1976,26 +1971,23 @@ static int sony_check_add_dev_list(struct sony_sc *sc)
 				"controller with MAC address %pMR already connected\n",
 				sc->mac_address);
 			}
-			goto unlock;
+			goto out;
 		}
 	}
 
 	ret = 0;
 	list_add(&(sc->list_node), &sony_device_list);
 
-unlock:
-	spin_unlock_irqrestore(&sony_dev_list_lock, flags);
+out:
 	return ret;
 }
 
 static void sony_remove_dev_list(struct sony_sc *sc)
 {
-	unsigned long flags;
-
 	if (sc->list_node.next) {
-		spin_lock_irqsave(&sony_dev_list_lock, flags);
-		list_del(&(sc->list_node));
-		spin_unlock_irqrestore(&sony_dev_list_lock, flags);
+		scoped_guard(spinlock_irqsave, &sony_dev_list_lock) {
+			list_del(&(sc->list_node));
+		}
 	}
 }
 
@@ -2123,12 +2115,10 @@ static inline void sony_init_output_report(struct sony_sc *sc,
 
 static inline void sony_cancel_work_sync(struct sony_sc *sc)
 {
-	unsigned long flags;
-
 	if (sc->state_worker_initialized) {
-		spin_lock_irqsave(&sc->lock, flags);
-		sc->state_worker_initialized = 0;
-		spin_unlock_irqrestore(&sc->lock, flags);
+		scoped_guard(spinlock_irqsave, &sc->lock) {
+			sc->state_worker_initialized = 0;
+		}
 		cancel_work_sync(&sc->state_worker);
 	}
 }
-- 
2.53.0

