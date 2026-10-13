Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CFF3F58C4;
	Tue, 13 Oct 2026 09:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882778; cv=none; b=K6gXfXN4T8K/Ax3lIYdhakgV/ZYXxwlW3UiiRYTPFj12uN+aclx//NE1OX2+dw974NPLS6Yd8jNBnWo+jSzPO4rTSnf/owqWAQBTKdmWgLUjOrpwIHW7sNBUDXw712C0qtuOCkKyADQNWvMX4uDAUoygaN+QHmoDGs4caZV6o5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882778; c=relaxed/simple;
	bh=Pq61G5Nj4VQvOOxtDA62mPNBc1l1574GDyvUb8ph6Gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D88JSy9PykCj4MeCc58pB7AqHwzo20Roi/MlOfjFV7a14ENXIPu/MnEaosE5lT/E5xedqsKF8/NDGJrdivpBu6Gweh2LuGnPxNT/WydMzVjnMCkIzm41Br49l7qHb6pLquzqZgHlYKN+f7asyEOPTKoA4rH7Xhj8nTklbP4vAgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQ2xdceL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQ2xdceL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F0A1F00898;
	Tue, 13 Oct 2026 09:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791882776;
	bh=rZ95AXDyiWsMbK1j9MOyfW00A7u0Hbb8ha/lntod1Ow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QQ2xdceLMukqlqFdZjupTapl5bZub0KpdPogn/9T3JwDVnMSSp0WXrA0oB404E27B
	 wTOqZON/aQksW1OYAG+xgaCv2Z6EskqlMDmGxq27MrDmhitYxyaHynLKc7WYfHmv+w
	 DJ4Xw9UnsTN9eKCQHM0P/vLRl2WD1NmFRr+ywwSFmWaMq3rU201MCXt41XmJpn8vkr
	 HFsAdJPuZ5deRgeqJ5IHL6Xw8eRG4vzT795QbG0bhwCpPxUdfHzdCxe1RfY6ut3Jrs
	 t6jg5byVoOD+ytZ3QTdx5+8hyZ68QuNhkhgnI9AbUBmZ25qDf8oEEl/6BY186frVEH
	 KtS5rEXdu6rag==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Vicki Pfau <vi@endrift.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Jiri Kosina <jkosina@suse.com>
Subject: [STABLE v5.15-v5.10 3/6] HID: steam: Fully unregister controller when hidraw is opened
Date: Tue, 13 Oct 2026 09:12:10 +0000
Message-ID: <20261013091215.529531-3-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261013091215.529531-1-lee@kernel.org>
References: <20261013091215.529531-1-lee@kernel.org>
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
[Lee: Convert steam_client_ll_open() and steam_client_ll_close() to
      schedule work_connect directly and omit sensors, rumble_work,
      mode_switch and unregister_work changes as e133dc99fc07,
      e1147961b214 and 1d4549fd1115 are not present]
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/hid/hid-steam.c | 78 ++++++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 36 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 159b55dff799..a856276b6c2c 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -380,6 +380,7 @@ static int steam_battery_register(struct steam_device *steam)
 			&steam->battery_desc, &battery_cfg);
 	if (IS_ERR(battery)) {
 		ret = PTR_ERR(battery);
+		devm_kfree(&steam->hdev->dev, steam->battery_desc.name);
 		hid_err(steam->hdev,
 				"%s:power_supply_register failed with error %d\n",
 				__func__, ret);
@@ -504,12 +505,15 @@ static void steam_battery_unregister(struct steam_device *steam)
 	RCU_INIT_POINTER(steam->battery, NULL);
 	synchronize_rcu();
 	power_supply_unregister(battery);
+	devm_kfree(&steam->hdev->dev, steam->battery_desc.name);
 }
 
 static int steam_register(struct steam_device *steam)
 {
 	int ret;
 	unsigned long client_opened;
+	unsigned long flags;
+	bool do_add;
 
 	/*
 	 * This function can be called several times in a row with the
@@ -535,38 +539,47 @@ static int steam_register(struct steam_device *steam)
 		if (steam->quirks & STEAM_QUIRK_WIRELESS)
 			steam_battery_register(steam);
 
-		mutex_lock(&steam_devices_lock);
-		if (list_empty(&steam->list))
-			list_add(&steam->list, &steam_devices);
-		mutex_unlock(&steam_devices_lock);
+		do_add = true;
 	}
 
-	mutex_lock(&steam->mutex);
+	spin_lock_irqsave(&steam->lock, flags);
 	client_opened = steam->client_opened;
-	if (!client_opened)
-		steam_set_lizard_mode(steam, lizard_mode);
-	mutex_unlock(&steam->mutex);
+	spin_unlock_irqrestore(&steam->lock, flags);
 
-	if (!client_opened)
+	if (!client_opened) {
+		mutex_lock(&steam->mutex);
+		steam_set_lizard_mode(steam, lizard_mode);
+		mutex_unlock(&steam->mutex);
 		ret = steam_input_register(steam);
-	else
-		ret = 0;
+		if (ret != 0)
+			goto steam_register_input_fail;
+	}
 
+	if (do_add) {
+		mutex_lock(&steam_devices_lock);
+		if (list_empty(&steam->list))
+			list_add(&steam->list, &steam_devices);
+		mutex_unlock(&steam_devices_lock);
+	}
+	return 0;
+
+steam_register_input_fail:
 	return ret;
 }
 
 static void steam_unregister(struct steam_device *steam)
 {
+	if (!steam->serial_no[0])
+		return;
+
+	hid_info(steam->hdev, "Steam Controller '%s' disconnected",
+			steam->serial_no);
 	steam_battery_unregister(steam);
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
@@ -575,19 +588,20 @@ static void steam_work_connect_cb(struct work_struct *work)
 							work_connect);
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
@@ -632,12 +646,13 @@ static void steam_client_ll_stop(struct hid_device *hdev)
 static int steam_client_ll_open(struct hid_device *hdev)
 {
 	struct steam_device *steam = hdev->driver_data;
+	unsigned long flags;
 
-	mutex_lock(&steam->mutex);
+	spin_lock_irqsave(&steam->lock, flags);
 	steam->client_opened++;
-	mutex_unlock(&steam->mutex);
+	spin_unlock_irqrestore(&steam->lock, flags);
 
-	steam_input_unregister(steam);
+	schedule_work(&steam->work_connect);
 
 	return 0;
 }
@@ -645,22 +660,13 @@ static int steam_client_ll_open(struct hid_device *hdev)
 static void steam_client_ll_close(struct hid_device *hdev)
 {
 	struct steam_device *steam = hdev->driver_data;
-
 	unsigned long flags;
-	bool connected;
 
 	spin_lock_irqsave(&steam->lock, flags);
-	connected = steam->connected;
-	spin_unlock_irqrestore(&steam->lock, flags);
-
-	mutex_lock(&steam->mutex);
 	steam->client_opened--;
-	if (connected && !steam->client_opened)
-		steam_set_lizard_mode(steam, lizard_mode);
-	mutex_unlock(&steam->mutex);
+	spin_unlock_irqrestore(&steam->lock, flags);
 
-	if (connected && !steam->client_opened)
-		steam_input_register(steam);
+	schedule_work(&steam->work_connect);
 }
 
 static int steam_client_ll_raw_request(struct hid_device *hdev,
-- 
2.56.0.385.gd3acb90ef8-goog

