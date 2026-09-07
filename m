Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61825237AF
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 20:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788811592; cv=none; b=OLyHRrFuUIy6/0+fae6F1gADJB8J0ISaxRDW0t2+l83HsraASNMMroPIIu45/TZI99Ft3OFFMcqLFFThvTa4r15iB+VZ0Bv4++0f5bxpGv2XOFxtsBQ89386FlAVHtuR5TINSS/vzVnJjkPLg2f1nPBWh7VMGLN/98Co2UlNCXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788811592; c=relaxed/simple;
	bh=dB9HSTudNyi41B8de/hQJEaJN8ZK42EF6QkYjn+jO1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ohu9RvBAz+6++zYIHwCKN67b0NV20d1FCXjqE2ARaF71mwqKhUxGIR2bhEkqciccO8I50Dy6aij33nPXkVRMap1Qcz95FD8VAjfMf0F1KSgiMTj0jD5ddJglRdoAB0c6mGOQnmID/5CyKR5IbcbznrUhzEUHw7qprslU5VaKwN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouyp+Vak; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouyp+Vak"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DFB61F00A3E;
	Mon,  7 Sep 2026 20:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788811587;
	bh=QVVf+hWjJbTNiX1rlAzMus7Pu0VYHL1GXm/Id8hCPcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ouyp+Vak6O0KulNOWxdjKuXs3ghzeAr5LcmP8K9CSOd2zjHaYZrMOTqt7jNwTuf0B
	 9oXZU0y9HE/b6ki2pzy5/KnlxjpzxYiRHc8vKUg6QJlCIr+upW1I7exuYAryGZHc+h
	 IdBQcyGh7Qyabk99i47nEOOcbNsMKj/dizeQssC5nW0WL7kUM/wY93IfJFbhjp6Wyv
	 b8oI1K8ZQvHPs0zmQitbmf9LTzBaQxlOXxKTcPda56lnH5/hBknvbR2EOs3Eq8I47o
	 tFJs1JL9GUdzaxY5zXJnhOs346cXRmkapciTLquRbwzduh+sPf/z/XbXliAYAZyUwR
	 dzNs42gCIDBWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rosalie Wanders <rosalie@mailbox.org>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] HID: sony: use guard() and scoped_guard()
Date: Mon,  7 Sep 2026 16:06:24 -0400
Message-ID: <20260907200625.359194-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090343-discharge-dallying-3c2b@gregkh>
References: <2026090343-discharge-dallying-3c2b@gregkh>
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
 drivers/hid/hid-sony.c | 53 ++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 31 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index d2486f3734f00..342e54fd03d4c 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -27,6 +27,7 @@
  * There will be no PIN request from the device.
  */
 
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/module.h>
@@ -520,14 +521,12 @@ static void sony_set_leds(struct sony_sc *sc);
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
@@ -796,7 +795,6 @@ static const u8 *sony_report_fixup(struct hid_device *hdev, u8 *rdesc,
 static void sixaxis_parse_report(struct sony_sc *sc, u8 *rd, int size)
 {
 	static const u8 sixaxis_battery_capacity[] = { 0, 1, 25, 50, 75, 100 };
-	unsigned long flags;
 	int offset;
 	u8 battery_capacity;
 	int battery_status;
@@ -818,10 +816,10 @@ static void sixaxis_parse_report(struct sony_sc *sc, u8 *rd, int size)
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
@@ -1624,15 +1622,14 @@ static int sony_battery_get_property(struct power_supply *psy,
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
@@ -1714,10 +1711,9 @@ static inline int sony_compare_connection_type(struct sony_sc *sc0,
 static int sony_check_add_dev_list(struct sony_sc *sc)
 {
 	struct sony_sc *entry;
-	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&sony_dev_list_lock, flags);
+	guard(spinlock_irqsave)(&sony_dev_list_lock);
 
 	list_for_each_entry(entry, &sony_device_list, list_node) {
 		ret = memcmp(sc->mac_address, entry->mac_address,
@@ -1731,26 +1727,23 @@ static int sony_check_add_dev_list(struct sony_sc *sc)
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
 
@@ -1878,12 +1871,10 @@ static inline void sony_init_output_report(struct sony_sc *sc,
 
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

