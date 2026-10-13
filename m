Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4C63DEFF1;
	Tue, 13 Oct 2026 09:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882772; cv=none; b=a7cD+7HuCwSaGNUssHYRNOmt1iLwEespsFspsKFrN4CgEEnNbMOy5VfGAqQDk2j30EHxvI4ded067a5e+UZxLCM3NcQxdx0nCvhd2jLH012Tu/Ddizg9UDgJtZ0HRCt30KX9f340/QVr5G1x9o2rxdRcwBELeuX9IU248dHoZls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882772; c=relaxed/simple;
	bh=XGD5BqiS+rZqMsRlXWs30/doF4PIo9Dqs+10K3FGr3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gq3gHLccXViWJ1GjIG+rQtx9ZAM0N9f+ifXP2vC6Te+WuvUKmT6JkvlYBv4Rx0d24wOtZgSSCbz8hI+bEQ7rlcBmkx8GvdvT4uc/9TnEjiRVLfumulvYOOD5Cbtw7rE2v3LsbXGfH8Ie93XHNJt3WWenCdzO2sd6ySU1qbeGMsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pl9YSoVz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pl9YSoVz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F3E1F000FF;
	Tue, 13 Oct 2026 09:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791882769;
	bh=QQxSLazQcqBQLQ83XmnKghaKzhCGcMfYL+URp6agA5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pl9YSoVz/0s558Prl7hjM6ICb6wxhKl8POfOFFegQJq1MBQ2xtGrzDwCNI7KviN+t
	 SZH0pxp23MFFrMnpCCBHUwkE1Ip+PJgUyP2bbh8vBugnnaKrD+xgPRhDboZhCo4P3L
	 J1wKnIjSlsrtuwR9cxIpiU65md+aia7WIPdq5cpdllNo+aWjcRcbiV3F20zGhQnXtK
	 Cpo/wHbVOUQ60Fvpd6KoI70/m7daYcXhlh+94+teplayobmdpAwsmimjpH+pog8ZYr
	 hBmAAebeUWX8hnVI+PSmmJZ+W8qtu4Vv5iTUJ67FznuZ1Qthg6RVLw4c9dm9cn136D
	 dpOYTrmPq0MkQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Vicki Pfau <vi@endrift.com>,
	Jiri Kosina <jkosina@suse.com>
Subject: [STABLE v6.6 2/5] HID: steam: Fully unregister controller when hidraw is opened
Date: Tue, 13 Oct 2026 09:11:51 +0000
Message-ID: <20261013091156.528734-2-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261013091156.528734-1-lee@kernel.org>
References: <20261013091156.528734-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vicki Pfau <vi@endrift.com>

[ Upstream commit cd33a91d37eb4d7c6ce56aa7f4688066309808eb ]

To avoid conflicts between anything touching the hidraw and the driver we
had previously detached the evdev nodes when the hidraw is opened. However,
this isn't sufficient to avoid FEATURE reports from conflicting, so we
change to fully unregistering the controller internally, leaving only the
hidraw active until it's closed.

This also unifies the unregister and connect callbacks, as now the logic
between these two callbacks is identical.

Signed-off-by: Vicki Pfau <vi@endrift.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
[Lee: Omit coalesce_rumble_work cancellation as 1d4549fd1115 ("HID:
      steam: Coalesce rumble packets") is not present]
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/hid/hid-steam.c | 73 +++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 46 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index d390ac5aee0d..59e39bdf34ed 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -312,7 +312,6 @@ struct steam_device {
 	u16 rumble_left;
 	u16 rumble_right;
 	unsigned int sensor_timestamp_us;
-	struct work_struct unregister_work;
 };
 
 static int steam_recv_report(struct steam_device *steam,
@@ -694,6 +693,7 @@ static int steam_battery_register(struct steam_device *steam)
 			&steam->battery_desc, &battery_cfg);
 	if (IS_ERR(battery)) {
 		ret = PTR_ERR(battery);
+		devm_kfree(&steam->hdev->dev, steam->battery_desc.name);
 		hid_err(steam->hdev,
 				"%s:power_supply_register failed with error %d\n",
 				__func__, ret);
@@ -947,6 +947,7 @@ static void steam_battery_unregister(struct steam_device *steam)
 	RCU_INIT_POINTER(steam->battery, NULL);
 	synchronize_rcu();
 	power_supply_unregister(battery);
+	devm_kfree(&steam->hdev->dev, steam->battery_desc.name);
 }
 
 static int steam_register(struct steam_device *steam)
@@ -954,6 +955,7 @@ static int steam_register(struct steam_device *steam)
 	int ret;
 	unsigned long client_opened;
 	unsigned long flags;
+	bool do_add;
 
 	/*
 	 * This function can be called several times in a row with the
@@ -977,10 +979,7 @@ static int steam_register(struct steam_device *steam)
 		if (steam->quirks & STEAM_QUIRK_WIRELESS)
 			steam_battery_register(steam);
 
-		mutex_lock(&steam_devices_lock);
-		if (list_empty(&steam->list))
-			list_add(&steam->list, &steam_devices);
-		mutex_unlock(&steam_devices_lock);
+		do_add = true;
 	}
 
 	spin_lock_irqsave(&steam->lock, flags);
@@ -996,6 +995,13 @@ static int steam_register(struct steam_device *steam)
 		if (ret != 0)
 			goto steam_register_sensors_fail;
 	}
+
+	if (do_add) {
+		mutex_lock(&steam_devices_lock);
+		if (list_empty(&steam->list))
+			list_add(&steam->list, &steam_devices);
+		mutex_unlock(&steam_devices_lock);
+	}
 	return 0;
 
 steam_register_sensors_fail:
@@ -1006,38 +1012,41 @@ static int steam_register(struct steam_device *steam)
 
 static void steam_unregister(struct steam_device *steam)
 {
+	if (!steam->serial_no[0])
+		return;
+
+	hid_info(steam->hdev, "Steam Controller '%s' disconnected",
+			steam->serial_no);
 	steam_battery_unregister(steam);
 	steam_sensors_unregister(steam);
 	steam_input_unregister(steam);
-	if (steam->serial_no[0]) {
-		hid_info(steam->hdev, "Steam Controller '%s' disconnected",
-				steam->serial_no);
-		mutex_lock(&steam_devices_lock);
-		list_del_init(&steam->list);
-		mutex_unlock(&steam_devices_lock);
-		steam->serial_no[0] = 0;
-	}
+	mutex_lock(&steam_devices_lock);
+	list_del_init(&steam->list);
+	mutex_unlock(&steam_devices_lock);
+	steam->serial_no[0] = 0;
 }
 
 static void steam_work_connect_cb(struct work_struct *work)
 {
 	struct steam_device *steam = container_of(work, struct steam_device,
 							work_connect);
+
 	unsigned long flags;
 	bool connected;
+	bool opened;
 	int ret;
 
 	spin_lock_irqsave(&steam->lock, flags);
+	opened = steam->client_opened;
 	connected = steam->connected;
 	spin_unlock_irqrestore(&steam->lock, flags);
 
-	if (connected) {
+	if (connected && !opened) {
 		ret = steam_register(steam);
-		if (ret) {
+		if (ret)
 			hid_err(steam->hdev,
 				"%s:steam_register failed with error %d\n",
 				__func__, ret);
-		}
 	} else {
 		steam_unregister(steam);
 	}
@@ -1071,31 +1080,6 @@ static void steam_mode_switch_cb(struct work_struct *work)
 	}
 }
 
-static void steam_work_unregister_cb(struct work_struct *work)
-{
-	struct steam_device *steam = container_of(work, struct steam_device,
-							unregister_work);
-	unsigned long flags;
-	bool connected;
-	bool opened;
-
-	spin_lock_irqsave(&steam->lock, flags);
-	opened = steam->client_opened;
-	connected = steam->connected;
-	spin_unlock_irqrestore(&steam->lock, flags);
-
-	if (connected) {
-		if (opened) {
-			steam_sensors_unregister(steam);
-			steam_input_unregister(steam);
-		} else {
-			steam_set_lizard_mode(steam, lizard_mode);
-			steam_input_register(steam);
-			steam_sensors_register(steam);
-		}
-	}
-}
-
 static bool steam_is_valve_interface(struct hid_device *hdev)
 {
 	struct hid_report_enum *rep_enum;
@@ -1141,7 +1125,7 @@ static int steam_client_ll_open(struct hid_device *hdev)
 	steam->client_opened++;
 	spin_unlock_irqrestore(&steam->lock, flags);
 
-	schedule_work(&steam->unregister_work);
+	schedule_work(&steam->work_connect);
 
 	return 0;
 }
@@ -1158,7 +1142,7 @@ static void steam_client_ll_close(struct hid_device *hdev)
 	connected = steam->connected && !steam->client_opened;
 	spin_unlock_irqrestore(&steam->lock, flags);
 
-	schedule_work(&steam->unregister_work);
+	schedule_work(&steam->work_connect);
 }
 
 static int steam_client_ll_raw_request(struct hid_device *hdev,
@@ -1250,7 +1234,6 @@ static int steam_probe(struct hid_device *hdev,
 	INIT_LIST_HEAD(&steam->list);
 	INIT_WORK(&steam->rumble_work, steam_haptic_rumble_cb);
 	steam->sensor_timestamp_us = 0;
-	INIT_WORK(&steam->unregister_work, steam_work_unregister_cb);
 
 	/*
 	 * With the real steam controller interface, do not connect hidraw.
@@ -1311,7 +1294,6 @@ static int steam_probe(struct hid_device *hdev,
 	cancel_work_sync(&steam->work_connect);
 	cancel_delayed_work_sync(&steam->mode_switch);
 	cancel_work_sync(&steam->rumble_work);
-	cancel_work_sync(&steam->unregister_work);
 
 	return ret;
 }
@@ -1329,7 +1311,6 @@ static void steam_remove(struct hid_device *hdev)
 	cancel_delayed_work_sync(&steam->mode_switch);
 	cancel_work_sync(&steam->work_connect);
 	cancel_work_sync(&steam->rumble_work);
-	cancel_work_sync(&steam->unregister_work);
 	steam->client_hdev = NULL;
 	steam->client_opened = 0;
 	if (steam->quirks & STEAM_QUIRK_WIRELESS) {
-- 
2.56.0.385.gd3acb90ef8-goog

