Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794999128;
	b=tsSMtkN/NsmQio3TDKif4ObJWNzAY/6WKm0sZmbWf2+Wz5gWmF0ow8GCRrnOFjq/3Aqs
	 SDtm6psXp3M/Y0X1GIgsLKT0ES34ypmr+xcvo41sdrfcU3v0IpDW1bbIvUlYxB3meW+Ym
	 AWJ6u4yxfY40Zgd7sRTkavJKiMsB96B4nEwRGT8WbaD9IUZC2k1/KsusOxUVNMh2XwOvf
	 c0vtRDpV2l58z5t+jhLI/+u+A78cfhbowu9muzM4e8w8QDms/x7s2wbAzBSvz7XDhKREc
	 aW0jsTNhUJBqaWFS1pm+q4Nxhh/hHJgIw/PaLzrZ6RdPlsw0H/ZzycKfecOahSW52Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794999128;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YBu0cA8jS17Zmd35KzNwqLeEg0d5ykV16Mfd43dd0oo=;
	b=2Lx93dR051iEWsWU00Mzdrrsqy7vvfL4hBP0NkwxYTH8OuYXpbuoVnPASMXtNEAxQxp6
	 lTbooJBzIpWiHWqcwKVkQutZoqA5JqMq7QpYr/ZOerdAwNYtmKvt8j2hGh3U8BNT+tJrP
	 g4WJvmtYTyS7bcBfNeo5b0YXP0t26FzLdO8dU34wpI2cPjyIIxXCnmAYZxGn5UmPzsTJu
	 +mdOyBW4apKj/c4kH08KRUqCOKrMRqUQbtZ0tYrW68XBef0zQrtBE4dPp1hdddwkKMdE5
	 spafbtOcW250rbJvfKrjd8WF93H99I/diigeMU1XwNkfIH8dgVBG+dxXp+sNBJkF9TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UhIKHIri;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6635606A334
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 10:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UhIKHIri
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 207251F000C7;
	Wed, 18 Nov 2026 10:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794999128;
	bh=YBu0cA8jS17Zmd35KzNwqLeEg0d5ykV16Mfd43dd0oo=;
	h=From:To:Cc:Subject:Date;
	b=UhIKHIri/ZnPV+U6Dby2M5MBIrFTAUTsjQWi2ifwt737GHCSwx6FeY8ocqX/tGC+i
	 ID6gE0+Le3ERiuJihDwUuOY291B0R8SlfvxhUea65UCGxrQfssv9x1VSkSQnDGUJmW
	 6Gj+ZfN9egYGreAhdXfEWBm24RIyZcxuLcv/mONIkamVcuhcjDlZPlAugzDsO/veQC
	 Gc0lm5OY5MSpuuQJNAO7Tay1Lnj5St2XPTRmhNIOkEZfRoQat7/iaOaE2sCskSiYsV
	 CqaflI+rZBhtUlnuifMognnEOGGcuKEOPva7he6SKir6Y2lvCPb1Ys2ZW9RyVXXImW
	 ruNwWYGgMwZhw==
From: Claudiu Beznea <claudiu.beznea@kernel.org>
To: stable@vger.kernel.org
Cc: adrian.hunter@intel.com,
	Frank.Li@nxp.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@kernel.org
Subject: [PATCH 5.10.y-stable] i3c: master: Fix recursive locking during device registration
Date: Wed, 18 Nov 2026 12:52:05 +0200
Message-ID: <20261118105205.2780673-1-claudiu.beznea@kernel.org>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adrian Hunter <adrian.hunter@intel.com>

commit 456f832e5fc26fbfd3b8200fd4553eee520cc377 upstream.

i3c_master_register_new_i3c_devs() registers newly discovered devices
while holding i3c_bus_normaluse_lock(), a down_read().  device_register()
can immediately probe the device, and probe callbacks typically invoke
I3C helpers that take i3c_bus_normaluse_lock() again, leading to a
recursive acquisition of the same rwsem.  rwsems do not support recursive
read locking and can deadlock when a writer is waiting.  See the
"Recursive read locks" section of Documentation/locking/lockdep-design.rst.

For example, with Intel LPSS I3C, LOCKDEP generates a WARNING like:
  # echo intel-lpss-i3c.0 > /sys/bus/platform/drivers/mipi-i3c-hci/unbind
  # echo intel-lpss-i3c.0 > /sys/bus/platform/drivers/mipi-i3c-hci/bind
  WARNING: possible recursive locking detected
  kworker/5:1/94 is trying to acquire lock:
  ffff88811c810d78 (&i3cbus->lock){++++}-{4:4}, at: i3c_device_match_id+0x45/0x370
  but task is already holding lock:
  ffff88811c810d78 (&i3cbus->lock){++++}-{4:4}, at: i3c_master_reg_work_fn+0x21/0x5f0

Fix this by separating device creation from device registration.
Populate desc->dev under the maintenance lock, collect the devices that
still need registration into a local list, then release the lock before
calling device_register().  Finally retake the lock and clean up any
devices that failed to register.

Use the maintenance lock rather than the normal-use lock while adding
device objects.  A write-side maintenance lock prevents readers from
observing a partially initialized desc->dev during initial device
population, or desc->dev disappearing if registration fails.

The local list requires a list node, so add a list node member to struct
i3c_device.

Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260807145638.168865-2-adrian.hunter@intel.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
[claudiu.beznea:
 - drop the i3c_bus_normaluse_{lock,unlock}() around
   i3c_master_register_new_i3c_devs() calls from i3c_master_do_daa() and
   i3c_master_register()
 - drop master->shutting_down specific code since this is not available
   in v5.10]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i3c/master.c       | 39 ++++++++++++++++++++++++++------------
 include/linux/i3c/master.h |  3 +++
 2 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 457e112dbc0f..5595d980a2c8 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1520,12 +1520,16 @@ static int i3c_master_early_i3c_dev_add(struct i3c_master_controller *master,
 static void
 i3c_master_register_new_i3c_devs(struct i3c_master_controller *master)
 {
+	struct i3c_device *i3cdev, *tmp;
 	struct i3c_dev_desc *desc;
+	LIST_HEAD(i3c_unreg_devs);
 	int ret;
 
 	if (!master->init_done)
 		return;
 
+	i3c_bus_maintenance_lock(&master->bus);
+
 	i3c_bus_for_each_i3cdev(&master->bus, desc) {
 		if (desc->dev || !desc->info.dyn_addr || desc == master->this)
 			continue;
@@ -1546,15 +1550,30 @@ i3c_master_register_new_i3c_devs(struct i3c_master_controller *master)
 		if (desc->boardinfo)
 			desc->dev->dev.of_node = desc->boardinfo->of_node;
 
-		ret = device_register(&desc->dev->dev);
-		if (ret) {
-			dev_err(&master->dev,
-				"Failed to add I3C device (err = %d)\n", ret);
-			desc->dev->desc = NULL;
-			put_device(&desc->dev->dev);
-			desc->dev = NULL;
-		}
+		list_add_tail(&desc->dev->node, &i3c_unreg_devs);
+	}
+
+	i3c_bus_maintenance_unlock(&master->bus);
+
+	list_for_each_entry_safe(i3cdev, tmp, &i3c_unreg_devs, node) {
+		ret = device_register(&i3cdev->dev);
+		if (ret)
+			dev_err(&master->dev, "Failed to add I3C device (err = %d)\n", ret);
+		else
+			list_del_init(&i3cdev->node);
 	}
+
+	i3c_bus_maintenance_lock(&master->bus);
+
+	list_for_each_entry_safe(i3cdev, tmp, &i3c_unreg_devs, node) {
+		list_del(&i3cdev->node);
+		desc = i3cdev->desc;
+		i3cdev->desc = NULL;
+		put_device(&i3cdev->dev);
+		desc->dev = NULL;
+	}
+
+	i3c_bus_maintenance_unlock(&master->bus);
 }
 
 /**
@@ -1583,9 +1602,7 @@ int i3c_master_do_daa(struct i3c_master_controller *master)
 	if (ret)
 		return ret;
 
-	i3c_bus_normaluse_lock(&master->bus);
 	i3c_master_register_new_i3c_devs(master);
-	i3c_bus_normaluse_unlock(&master->bus);
 
 	return 0;
 }
@@ -2627,9 +2644,7 @@ int i3c_master_register(struct i3c_master_controller *master,
 	 * register I3C devices discovered during the initial DAA.
 	 */
 	master->init_done = true;
-	i3c_bus_normaluse_lock(&master->bus);
 	i3c_master_register_new_i3c_devs(master);
-	i3c_bus_normaluse_unlock(&master->bus);
 
 	return 0;
 
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index b31170e37655..1b646b2067db 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -219,6 +219,8 @@ struct i3c_dev_desc {
  *	  every time the I3C device is rediscovered with a different dynamic
  *	  address assigned
  * @bus: I3C bus this device is attached to
+ * @node: unregistered device list node, only for use by
+ *	  i3c_master_register_new_i3c_devs(), it is not protected by a lock
  *
  * I3C device object exposed to I3C device drivers. The takes care of linking
  * this object to the relevant &struct_i3c_dev_desc one.
@@ -229,6 +231,7 @@ struct i3c_device {
 	struct device dev;
 	struct i3c_dev_desc *desc;
 	struct i3c_bus *bus;
+	struct list_head node;
 };
 
 /*
-- 
2.43.0

