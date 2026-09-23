Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E69282F09;
	Wed, 23 Sep 2026 03:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.101.248.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790134061; cv=none; b=IMAjJoWxCru0nWd6XeLXmZRZdyOf+8p78LPdo+WvgW91ldIhaboOAZDmFTgBIetowcDSW0Ysx+bUUHqG0ROyfAJBmOsmhst53ZnOq9/TKdX2Gm3SeodIyUDax1WS47M50g0bS2WoDtqBkIQPOJvWfAawlUiIrfPeiMoYZ99NASc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790134061; c=relaxed/simple;
	bh=Q0OJgEKLglJOc3TiSmI+X51rKO9cdO4eRuRAsGUSFGE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qIkNK8imRQj9NjHpHrS8WoeXxm840M47W503qqA62UGqjwA6kV7DsqvIKZ21zwP8Nexrh7ZOHJkJ1n+lhZBAJHCCDZA2umpqMHGemc3q3Bua2te7xNECJaO4s3YKa/SkajGsAV+pwdUo1iUFmLDVvRo5ljnHq+VZUmUB46z6bJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=46.101.248.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wA3EX4hR7NqqS0wAQ--.4488S3;
	Wed, 23 Sep 2026 11:27:30 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app4 (Coremail) with SMTP id zi_KCgBXOzQhR7NqwgvOAw--.50357S2;
	Wed, 23 Sep 2026 11:27:29 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: Roderick Colenbrander <roderick.colenbrander@sony.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>,
	Song Li <songl@zju.edu.cn>
Subject: [PATCH] HID: playstation: Fix DualShock4 dongle hotplug work use-after-free
Date: Wed, 23 Sep 2026 03:26:34 +0000
Message-Id: <20260923032634.417433-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgBXOzQhR7NqwgvOAw--.50357S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?XRzutQXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnXz+g1OQfMo27QHy5TwQyZzbrCNppSCAO8fXC4wAAxyLsocjHv9/8dsiiIVZ9jJt33FK
	A80kuYWeQhzwoy+xcQGp9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoW3GrWrJFykCr15KryftF4fZwc_yoW7ZF15pF
	Z5tasxX3yDCayFv3sYv3yrCF1Ykw1vq3y7AFWfGw12gwn5Ar1Yya4rAFn0va15XFZ5ZFs8
	Aa1qkrWYkrsrXrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Gb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU85l1PUUUUU==

dualshock4_remove() cancels ds4->dongle_hotplug_worker while input
reports can still arrive: hid_hw_close() and hid_hw_stop() only run
later in ps_remove(), so a dongle connect report in that window makes
dualshock4_dongle_parse_report() schedule the just-cancelled work
again. ds4 is devm-managed and freed once ps_remove() returns, so
dualshock4_dongle_calibration_work() then runs on freed memory.

The dualshock4_create() error path has the same exposure. Reports are
already flowing when it runs, because ps_probe() starts and opens the
device before creating it, so the connect branch of the dongle report
handler can also queue ds4->output_worker through its lightbar update.
Neither work is cancelled when creation fails, and ds4 is freed once
the failed probe unwinds its devm allocations.

Fix this by clearing a new dongle_hotplug_worker_initialized flag under
ps_dev->lock before cancelling the worker and checking it under the same
lock before scheduling, mirroring how this driver already guards
ds4->output_worker. Also drain both workers on every error path of
dualshock4_create(): cancel dongle_hotplug_worker on the early MAC-read
and device-list failures that currently return directly, and clear
output_worker_initialized and cancel ds4->output_worker as
dualshock4_remove() already does. The output-report buffer allocation
failure returns through the same cleanup.

The locked check closes the schedule-vs-clear race, and neither work
re-schedules itself, so the cancels leave nothing pending.

This issue was found by an in-house static analysis tool.

Fixes: c64ed0cd9324 ("HID: playstation: add DualShock4 dongle support.")
Cc: stable@vger.kernel.org
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/hid/hid-playstation.c | 36 ++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.c
index f9dc937..1b7a18f 100644
--- a/drivers/hid/hid-playstation.c
+++ b/drivers/hid/hid-playstation.c
@@ -421,6 +421,7 @@ struct dualshock4 {
 	enum dualshock4_dongle_state dongle_state;
 	/* Used during calibration. */
 	struct work_struct dongle_hotplug_worker;
+	bool dongle_hotplug_worker_initialized;
 
 	/* Timestamp for sensor data */
 	bool sensor_timestamp_initialized;
@@ -2618,10 +2619,12 @@ static int dualshock4_dongle_parse_report(struct ps_device *ps_dev, struct hid_r
 
 			dualshock4_set_default_lightbar_colors(ds4);
 
-			scoped_guard(spinlock_irqsave, &ps_dev->lock)
+			scoped_guard(spinlock_irqsave, &ps_dev->lock) {
 				ds4->dongle_state = DONGLE_CALIBRATING;
 
-			schedule_work(&ds4->dongle_hotplug_worker);
+				if (ds4->dongle_hotplug_worker_initialized)
+					schedule_work(&ds4->dongle_hotplug_worker);
+			}
 
 			/* Don't process the report since we don't have
 			 * calibration data, but let hidraw have it anyway.
@@ -2677,8 +2680,12 @@ static void dualshock4_remove(struct ps_device *ps_dev)
 
 	cancel_work_sync(&ds4->output_worker);
 
-	if (ps_dev->hdev->product == USB_DEVICE_ID_SONY_PS4_CONTROLLER_DONGLE)
+	if (ps_dev->hdev->product == USB_DEVICE_ID_SONY_PS4_CONTROLLER_DONGLE) {
+		scoped_guard(spinlock_irqsave, &ds4->base.lock)
+			ds4->dongle_hotplug_worker_initialized = false;
+
 		cancel_work_sync(&ds4->dongle_hotplug_worker);
+	}
 }
 
 static inline void dualshock4_schedule_work(struct dualshock4 *ds4)
@@ -2770,12 +2777,15 @@ static struct ps_device *dualshock4_create(struct hid_device *hdev)
 
 	max_output_report_size = sizeof(struct dualshock4_output_report_bt);
 	ds4->output_report_dmabuf = devm_kzalloc(&hdev->dev, max_output_report_size, GFP_KERNEL);
-	if (!ds4->output_report_dmabuf)
-		return ERR_PTR(-ENOMEM);
+	if (!ds4->output_report_dmabuf) {
+		ret = -ENOMEM;
+		goto err_cancel;
+	}
 
 	if (hdev->product == USB_DEVICE_ID_SONY_PS4_CONTROLLER_DONGLE) {
 		ds4->dongle_state = DONGLE_DISCONNECTED;
 		INIT_WORK(&ds4->dongle_hotplug_worker, dualshock4_dongle_calibration_work);
+		ds4->dongle_hotplug_worker_initialized = true;
 
 		/* Override parse report for dongle specific hotplug handling. */
 		ps_dev->parse_report = dualshock4_dongle_parse_report;
@@ -2784,7 +2794,7 @@ static struct ps_device *dualshock4_create(struct hid_device *hdev)
 	ret = dualshock4_get_mac_address(ds4);
 	if (ret) {
 		hid_err(hdev, "Failed to get MAC address from DualShock4\n");
-		return ERR_PTR(ret);
+		goto err_cancel;
 	}
 	snprintf(hdev->uniq, sizeof(hdev->uniq), "%pMR", ds4->base.mac_address);
 
@@ -2796,7 +2806,7 @@ static struct ps_device *dualshock4_create(struct hid_device *hdev)
 
 	ret = ps_devices_list_add(ps_dev);
 	if (ret)
-		return ERR_PTR(ret);
+		goto err_cancel;
 
 	ret = dualshock4_get_calibration_data(ds4);
 	if (ret) {
@@ -2858,6 +2868,18 @@ static struct ps_device *dualshock4_create(struct hid_device *hdev)
 
 err:
 	ps_devices_list_remove(ps_dev);
+err_cancel:
+	scoped_guard(spinlock_irqsave, &ps_dev->lock)
+		ds4->output_worker_initialized = false;
+
+	cancel_work_sync(&ds4->output_worker);
+
+	if (ds4->dongle_hotplug_worker_initialized) {
+		scoped_guard(spinlock_irqsave, &ps_dev->lock)
+			ds4->dongle_hotplug_worker_initialized = false;
+
+		cancel_work_sync(&ds4->dongle_hotplug_worker);
+	}
 	return ERR_PTR(ret);
 }
 

