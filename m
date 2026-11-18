Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794999177;
	b=1Y8RrcnI7nqraLdPEZSuHOWrROUe+KBphQEG1XTe8R4FYJygSjT+kwPSRgtFhjspbH7y
	 z+TuzoYpAs+132lVjoy7p5ilPIIN59I++ut9X4N5HfSOx2DMqdblIl3ITLbTrMnk8IbSj
	 z4jM7gVOGpK8S4SSVR7H2LcjLLSrlJ+gtv15IOZmgErtvHjJn6X0yACln45pxYb8DpR1m
	 X0vNMCB+umO1fuaIRvMeQzpNiHO75NZEUtmYwUMfGmTsksHRvssU+40CUEvH+w4K1NfxT
	 FRHfnJ0W1TcJIkJAlZNmQpbLMudeAhHY1XqjIW5Ru9qTSCkYGs2TCROCTJmjuQrXyew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794999177;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=i6hgnfRszYDjFrX7jRG/fj8WPQ69Z1ONdqlGSYpx9KU=;
	b=OH/h5HT8P6vlMuNp1AJE3k29K62R4P6V4Fbjs16444sJFNShENyjy9icj7NjJiQ0DTZZ
	 szJs5QDrj0LktyZfbXZrER8Y5JZxWd7kK/s85MysgEzegN+bYG9eZKXvBiBi8erAzG+pz
	 JF2wzD6kH+q9CW+lWuOipXH9uWYBh5NC8cylaezkkxRwkjDs1W/QgYv2vYcm9oXHIq5L2
	 d+n8xt8K5mVk2b6zkjhomzJBnyCzIUb2Tn4FghmDoCZlLFLD9qHWekM9cRlCIS9Woc0bW
	 IYusOSqnxkiPWCxK5ikab8WCC+3wlu62Ff3d6z1dz3bIqLeUBdldv7UsHcG7GS40y+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZNmvL82y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1665606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 10:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZNmvL82y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 636DC1F000C4;
	Wed, 18 Nov 2026 10:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794999177;
	bh=i6hgnfRszYDjFrX7jRG/fj8WPQ69Z1ONdqlGSYpx9KU=;
	h=From:To:Cc:Subject:Date;
	b=ZNmvL82yhQWbSS+IxKWssrQgnWVxaokdBpFfWwuvkC9TmBqWIqGVWIbPbVlNcWUQo
	 S7BNesKvaahp7p7kpATkZGueh1Of1J4jjpOay4dpqrbmNZp7EmUlx7ysmASWQXwOMi
	 p2G1ZoPvhD/qFYLkpJ0MtXJP0G+62hVGYhXq7j0lU34KIFOhkKOAeOXgqXMQGiqtTM
	 DHQ1MNU5rFuk5rZcCTiDkEZtHIEw+JQTJDH5JKi49tWod0jvFtQj2ej6m3HQMGZbIF
	 d8iI47/aWMmoeHqasVNdKqC5pf38fRLmWmqENvZdd9oWcXUIwiupOBmFJ+pkIgDih9
	 5PIOX0a59GBFQ==
From: Claudiu Beznea <claudiu.beznea@kernel.org>
To: stable@vger.kernel.org
Cc: adrian.hunter@intel.com,
	Frank.Li@nxp.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@kernel.org
Subject: [PATCH 5.15.y-stable] i3c: master: Fix recursive locking during device registration
Date: Wed, 18 Nov 2026 12:52:54 +0200
Message-ID: <20261118105254.2780893-1-claudiu.beznea@kernel.org>
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
   in v5.15]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i3c/master.c       | 39 ++++++++++++++++++++++++++------------
 include/linux/i3c/master.h |  3 +++
 2 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 6e02c91060ab..40aca5006b87 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1481,12 +1481,16 @@ static int i3c_master_early_i3c_dev_add(struct i3c_master_controller *master,
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
@@ -1507,15 +1511,30 @@ i3c_master_register_new_i3c_devs(struct i3c_master_controller *master)
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
@@ -1544,9 +1563,7 @@ int i3c_master_do_daa(struct i3c_master_controller *master)
 	if (ret)
 		return ret;
 
-	i3c_bus_normaluse_lock(&master->bus);
 	i3c_master_register_new_i3c_devs(master);
-	i3c_bus_normaluse_unlock(&master->bus);
 
 	return 0;
 }
@@ -2585,9 +2602,7 @@ int i3c_master_register(struct i3c_master_controller *master,
 	 * register I3C devices discovered during the initial DAA.
 	 */
 	master->init_done = true;
-	i3c_bus_normaluse_lock(&master->bus);
 	i3c_master_register_new_i3c_devs(master);
-	i3c_bus_normaluse_unlock(&master->bus);
 
 	return 0;
 
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 604a126b78c8..d73770f5f69e 100644
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

