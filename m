Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC5940BCBB
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 22:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788820091; cv=none; b=fNGjISFnJOPOJtcYRiOffGWHbFaMsEDN93Ghvqq8UGDgekINcpVM8PBGd8iOGmHYvRgI6ztf11XA6hTjTtoDSbAP+oeqzZDB8fY4w+m4Fs4ECKN95yHbpOIHqa2RaLsL9f29bkyn0dEJxB+XSpji4v2dMPedUfodLtVgL5277PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788820091; c=relaxed/simple;
	bh=H4awYEYlQk5fFRTzn0l4pa2Pa0A5cbyvCz3owcB1e6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RECVWtyqd9610cw75Ob9I333NXIlLxMZW/gvHnZKLLRyoy9S1fROUERb73WoXCmPwnHFBn5oQRma6d5Nw2f/sxnm2tC/GrDy9eeDLQY/xIbuRn/2dfEThyuIQ9b9dVVIp2QVDOGwL7u5gVTxPIuuLklm5TWwaQsNVRlxzOlrnDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzoVbRH8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzoVbRH8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 408541F00ACA;
	Mon,  7 Sep 2026 22:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788820089;
	bh=iildF7pAaEVNjhgzku49rjgQmGj1gTBLr7Q2EFV7DXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FzoVbRH8j+G3vd/ow6d961LZF2SKfFYFQBXexvr5xWG3gq+QFFHi7BIPb4mlipAiH
	 PjZa7CMU+lYIPmzQ2oPzDwsSCaiN9Qs2ndYa7QzRhjGXbab280CUDg1Kx5Nr2c/dz3
	 PBSFedgKu8B+77ZjQU61nykyuUUDGQPSayo9e2fzSdKG+KBhr2PXcHgB12hTDtFrdP
	 3HQKPmgq9P0TE3qNKrSJ4N6JVyIp6JtX5AB2ht/ywXO0tQ0bWj4LGj7WSnvTQwtvgo
	 BOk7h+YOgixHm90cEybcCxoEUsCYnOHLlX37IAuTJrGHQ9+D75KNqt9H8BR270epwg
	 JT5pR09GGGmng==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rosalie Wanders <rosalie@mailbox.org>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/5] HID: sony: use guard() and scoped_guard()
Date: Mon,  7 Sep 2026 18:28:04 -0400
Message-ID: <20260907222805.669827-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907222805.669827-1-sashal@kernel.org>
References: <2026090345-compactor-scandal-09fb@gregkh>
 <20260907222805.669827-1-sashal@kernel.org>
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

For the 5.15 backport, omit the conversion of Rock Band handlers that were
removed earlier in this dependency chain. Compile hid-sony.o as GNU11 because
scoped_guard() requires declarations in for-loop initializers, while 5.15
otherwise uses GNU89. Also retain mutable fixed report descriptors because the
5.15 HID report_fixup callback is not const-qualified, and normalize the probe
allocation check so the dependent fix applies without conflict.

Stable-dep-of: 7c65699a3a31 ("HID: sony: clean up device list on probe failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/Makefile   |  1 +
 drivers/hid/hid-sony.c | 69 ++++++++++++++++++------------------------
 2 files changed, 30 insertions(+), 40 deletions(-)

diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 9fc46db0a3da6..ae8a58c5d2a95 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -108,6 +108,7 @@ obj-$(CONFIG_HID_SAITEK)	+= hid-saitek.o
 obj-$(CONFIG_HID_SAMSUNG)	+= hid-samsung.o
 obj-$(CONFIG_HID_SEMITEK)	+= hid-semitek.o
 obj-$(CONFIG_HID_SMARTJOYPLUS)	+= hid-sjoy.o
+CFLAGS_hid-sony.o		+= -std=gnu11
 obj-$(CONFIG_HID_SONY)		+= hid-sony.o
 obj-$(CONFIG_HID_SPEEDLINK)	+= hid-speedlink.o
 obj-$(CONFIG_HID_STEAM)		+= hid-steam.o
diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index d5b2850e467c0..e8b68dec14dc1 100644
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
+			unsigned int *rsize)
 {
 	*rsize = sizeof(motion_rdesc);
 	return motion_rdesc;
 }
 
-static const u8 *ps3remote_fixup(struct hid_device *hdev, u8 *rdesc,
-				 unsigned int *rsize)
+static u8 *ps3remote_fixup(struct hid_device *hdev, u8 *rdesc,
+			   unsigned int *rsize)
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
@@ -2067,10 +2058,8 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		quirks |= SHANWAN_GAMEPAD;
 
 	sc = devm_kzalloc(&hdev->dev, sizeof(*sc), GFP_KERNEL);
-	if (sc == NULL) {
-		hid_err(hdev, "can't alloc sony descriptor\n");
+	if (!sc)
 		return -ENOMEM;
-	}
 
 	spin_lock_init(&sc->lock);
 
-- 
2.53.0

