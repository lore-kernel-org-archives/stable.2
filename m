Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DF530D411
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 21:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788817003; cv=none; b=KI0rlbKY8pqqe9KUzg/tPm1iSA0DdIwA7NWNTRBNUAHazH9nCVbsxItPaCYIz2w9IC4mLhL5TQbTZ/UOq+/k+07pQuxWzG9pQd+GH634B8TguD6kSWNcgw8HMq5LzuQ2tf6TThytneG0GK3VQqZ2vx4cczajCt4M+F4Ris2AS+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788817003; c=relaxed/simple;
	bh=QL2FtY9M02VMBNQOC63szbvasSjsay5JH+JVk6PRCmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FLsC5iNdfsCtHj7baKftDAowkTujIDa40QScytxJsXinm//OldYLyiu08MBxkS2STUkboNBg8yP/aqrR6Xc9n5Ro7dpav6LQ5GTXZhtKV7//CF/tXqnKGRY7vjAexTre+mxAlt0L2t4pEO9NrKrUVBjgLDC48yq+o01/7umGMC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDvxwKUK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDvxwKUK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 751511F00ACF;
	Mon,  7 Sep 2026 21:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788817001;
	bh=jsYmcz39PG2IQLT1WzzvmIjUQio2JFH5Y7nColzUrXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MDvxwKUKRl4fCT5xKAzafThzUOWdmWP2WEQtoZ2koAkkXQV3mbeNCzIFk3Kn5mdxG
	 Ir8A6S0m+C2FZbPIROsGBkG2DllbkRsMXwk4xh1BfknLoY9kt17gCWHQ5r+WeVdzHR
	 Wu4SC7K343fIHtIJpPxovBnuaoCsnWMfysKvy5CSdkdlWfaGt+S7NqMP1SwWAs84Gk
	 LNNi4FaMY6BCXZcD+XwjKw9KJbFcJjJQhmEmtan6gDJUbX1O3eTJx1gWdXFdn/jpk1
	 aIv0Xf59Wn+PEZJbZwBkQrVeQL2PhRmjMi5gTjR7sFmXgLPRr/cqqcXC3WO0tM5UTT
	 ykKKkPP0t6OTQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rosalie Wanders <rosalie@mailbox.org>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/5] HID: sony: use guard() and scoped_guard()
Date: Mon,  7 Sep 2026 17:36:36 -0400
Message-ID: <20260907213637.574137-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907213637.574137-1-sashal@kernel.org>
References: <2026090344-dislocate-egging-04af@gregkh>
 <20260907213637.574137-1-sashal@kernel.org>
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

[ Stable backport: omit the Rock Band 4 PS5 hunk because that handler is
absent here. Restore mutable fixed report descriptors because this branch
lacks the HID core const report_fixup API required by the earlier
dependency. ]

Stable-dep-of: 7c65699a3a31 ("HID: sony: clean up device list on probe failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-sony.c | 65 ++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 37 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 8486228a49a75..7a961a2b14432 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -27,6 +27,7 @@
  * There will be no PIN request from the device.
  */
 
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/module.h>
@@ -99,7 +100,7 @@ static const char ghl_ps4_magic_data[] = {
 };
 
 /* PS/3 Motion controller */
-static const u8 motion_rdesc[] = {
+static u8 motion_rdesc[] = {
 	0x05, 0x01,         /*  Usage Page (Desktop),               */
 	0x09, 0x04,         /*  Usage (Joystick),                   */
 	0xA1, 0x01,         /*  Collection (Application),           */
@@ -195,7 +196,7 @@ static const u8 motion_rdesc[] = {
 	0xC0                /*  End Collection                      */
 };
 
-static const u8 ps3remote_rdesc[] = {
+static u8 ps3remote_rdesc[] = {
 	0x05, 0x01,          /* GUsagePage Generic Desktop */
 	0x09, 0x05,          /* LUsage 0x05 [Game Pad] */
 	0xA1, 0x01,          /* MCollection Application (mouse, keyboard) */
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
@@ -599,15 +598,15 @@ static int guitar_mapping(struct hid_device *hdev, struct hid_input *hi,
 	return 0;
 }
 
-static const u8 *motion_fixup(struct hid_device *hdev, u8 *rdesc,
-			      unsigned int *rsize)
+static u8 *motion_fixup(struct hid_device *hdev, u8 *rdesc,
+			     unsigned int *rsize)
 {
 	*rsize = sizeof(motion_rdesc);
 	return motion_rdesc;
 }
 
-static const u8 *ps3remote_fixup(struct hid_device *hdev, u8 *rdesc,
-				 unsigned int *rsize)
+static u8 *ps3remote_fixup(struct hid_device *hdev, u8 *rdesc,
+			    unsigned int *rsize)
 {
 	*rsize = sizeof(ps3remote_rdesc);
 	return ps3remote_rdesc;
@@ -796,7 +795,6 @@ static u8 *sony_report_fixup(struct hid_device *hdev, u8 *rdesc,
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
@@ -1622,15 +1620,14 @@ static int sony_battery_get_property(struct power_supply *psy,
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
@@ -1712,10 +1709,9 @@ static inline int sony_compare_connection_type(struct sony_sc *sc0,
 static int sony_check_add_dev_list(struct sony_sc *sc)
 {
 	struct sony_sc *entry;
-	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&sony_dev_list_lock, flags);
+	guard(spinlock_irqsave)(&sony_dev_list_lock);
 
 	list_for_each_entry(entry, &sony_device_list, list_node) {
 		ret = memcmp(sc->mac_address, entry->mac_address,
@@ -1729,26 +1725,23 @@ static int sony_check_add_dev_list(struct sony_sc *sc)
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
 
@@ -1877,12 +1870,10 @@ static inline void sony_init_output_report(struct sony_sc *sc,
 
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

