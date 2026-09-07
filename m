Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86962525A8B
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 20:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788811239; cv=none; b=hn+c173x4Na2GjLyhqhgvevSmlMBnwoxr0s3EFp3sryM260svCeR4E2t0Fcj+6PhzDqPAWowyrhs5YfckWhEOlLruaU3n2nQ7d42q7sYYeDU3dz0MyynsQ/mqeZ6dGdQitk39Dzq4vuol4NHm3YQ/i0lS707g1JOpU7vqEksiek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788811239; c=relaxed/simple;
	bh=3+LPF30UP0DeBeBIXPVyDZn2VGOpFdc2mdckLtc6hVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G2QOlEv6Ss6qBgxGN3MWKGoPX9rcNFnry2rr29MYEvg6wUfDFkI0SqNL53kr0nipF14c4V8E6chWgurfAoWigE7VRh3G2oHmO+uYkIaW/zWcb3m4qetQVKK3lq/n1dYnyzPy8F/B084SxJ+t7W/mwLmAIuS5Z84aW+t0hy5oFMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwwd6N5C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwwd6N5C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E731F00A3A;
	Mon,  7 Sep 2026 20:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788811238;
	bh=qwMoPwK//+U4C4bDpwD7zGa0KFykHcJPdzBKJuvO1Rw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kwwd6N5C/8owrrRXwL3Yv25xnZp2yR+Y+lC+KQK/1Tpkh8QpX/+hJcWBWCVWc1axE
	 RKDGha5/xXPIvGrW6BW3w03aqZGRUNCxS2/U23VI7wOOZHHXrZFBKRzCrBmbGTp84E
	 tcwPJTv4Hrda9R2y5D8IPFmg99mBoG/AZ6eJ1FJysUG53h07lG4VCdIq1PP7VTKnuY
	 g7dJE/jFsCWp9NB+PHPX8oh4LOFQC2BFWK4vOzYKg6pdp7b5ywezrU69+Y+H9e/oc7
	 UjZlw4PyYLkisH5wrthgsjen2NjQ8MyA/u4UgVboncCXHqpXuuSL1RUrXou+YZWYe7
	 RBLfBhSqswIYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rosalie Wanders <rosalie@mailbox.org>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] HID: sony: use guard() and scoped_guard()
Date: Mon,  7 Sep 2026 16:00:35 -0400
Message-ID: <20260907200036.328038-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090343-eligible-knickers-2dfe@gregkh>
References: <2026090343-eligible-knickers-2dfe@gregkh>
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
index b966e4044238c..41d79b317735e 100644
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
@@ -1625,15 +1623,14 @@ static int sony_battery_get_property(struct power_supply *psy,
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
@@ -1715,10 +1712,9 @@ static inline int sony_compare_connection_type(struct sony_sc *sc0,
 static int sony_check_add_dev_list(struct sony_sc *sc)
 {
 	struct sony_sc *entry;
-	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&sony_dev_list_lock, flags);
+	guard(spinlock_irqsave)(&sony_dev_list_lock);
 
 	list_for_each_entry(entry, &sony_device_list, list_node) {
 		ret = memcmp(sc->mac_address, entry->mac_address,
@@ -1732,26 +1728,23 @@ static int sony_check_add_dev_list(struct sony_sc *sc)
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
 
@@ -1879,12 +1872,10 @@ static inline void sony_init_output_report(struct sony_sc *sc,
 
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

