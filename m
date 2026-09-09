Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF1A3CA481
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 20:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986771; cv=none; b=Mv2kHdEtlufcfB42ue7d+Vho1YITqZ5QcKoHLJTB2uaRSz+nccbB6ajDtFaX4LGbFCbssyou/6WCbQeEXggTuO1p2hJcn97NMxieqXfBANjMwDLH2jbwI6PpA3LF6wcLAaTK3968/oOpPbsvFcLRjaLJ0kxWzej5KsFuP0PVBG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986771; c=relaxed/simple;
	bh=b5HNe8EYc3DeTD6pgn190aBU3aYOF/mK191MjYbK9Ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q75ZzPydzo7F2hDcoK9v56nj1yDlq64O84jhAqfdUdMZcSd34GriOaQKhr1WYnPWdPw2YI3oPWm9Fi4c+npqA+gVNh+JI6xpQdhpxleAmYdMie0uVl2GtgvIhJbwVGRJ4i+6laG7h71EyH3adPII8bjrtS+UeOG4d/N7B56Os6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HeM1T5rk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HeM1T5rk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632621F0089B;
	Wed,  9 Sep 2026 20:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788986764;
	bh=kItjUbeD8CH5uLGFp/Q0nXTzwFgLrM3HSAJRmZQxQVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HeM1T5rk4p1ixe789Z5Dbf3ElZtESN0A9MWlUMDiCPUjAxgjBgJVP0rnP5na+uCzk
	 EWk9AC9M3JdM3LMtE1hqMrQEk1+QDy9Izum/gn2Zz7PhqsI78efPzqdBkcQq0SLqnY
	 hQoqiSQOebC4gHb1PIlv6xWGM3D8x2PU5sZ7/VlNzxHux6vP2rqZvV9lE3n1fzUQle
	 IWv3Qy5U9BhNLjgoaS57Fq8d2wiEKKGAnsCwStlU2kzz024D+J4gj9opsnM2a/6gpT
	 3jwsRGECSjxkkhgYDAPQIw7d9/F8Ij4NrcXIhQIk6c071E5k/tRh94phRLJMceeBr3
	 eot9B3SMca0IA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Frank Li <Frank.Li@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 2/2] i3c: master: Fix recursive locking during device registration
Date: Wed,  9 Sep 2026 16:46:01 -0400
Message-ID: <20260909204601.3679694-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909204601.3679694-1-sashal@kernel.org>
References: <2026090417-elevating-aging-a57d@gregkh>
 <20260909204601.3679694-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adrian Hunter <adrian.hunter@intel.com>

[ Upstream commit 456f832e5fc26fbfd3b8200fd4553eee520cc377 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i3c/master.c       | 45 ++++++++++++++++++++++++++++----------
 include/linux/i3c/master.h |  3 +++
 2 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 5485bebb54dc4..3a0092f439087 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1898,12 +1898,21 @@ static int i3c_master_early_i3c_dev_add(struct i3c_master_controller *master,
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
+	if (master->shutting_down) {
+		i3c_bus_maintenance_unlock(&master->bus);
+		return;
+	}
+
 	i3c_bus_for_each_i3cdev(&master->bus, desc) {
 		if (desc->dev || !desc->info.dyn_addr || desc == master->this)
 			continue;
@@ -1924,25 +1933,37 @@ i3c_master_register_new_i3c_devs(struct i3c_master_controller *master)
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
+	}
+
+	i3c_bus_maintenance_lock(&master->bus);
+
+	list_for_each_entry_safe(i3cdev, tmp, &i3c_unreg_devs, node) {
+		list_del(&i3cdev->node);
+		desc = i3cdev->desc;
+		i3cdev->desc = NULL;
+		put_device(&i3cdev->dev);
+		desc->dev = NULL;
 	}
+
+	i3c_bus_maintenance_unlock(&master->bus);
 }
 
 static void i3c_master_reg_work_fn(struct work_struct *work)
 {
 	struct i3c_master_controller *master = container_of(work, typeof(*master), reg_work);
 
-	i3c_bus_normaluse_lock(&master->bus);
-	if (!master->shutting_down)
-		i3c_master_register_new_i3c_devs(master);
-	i3c_bus_normaluse_unlock(&master->bus);
+	i3c_master_register_new_i3c_devs(master);
 }
 
 /**
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 4d2a687933240..2edf40b112ae0 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -228,6 +228,8 @@ struct i3c_dev_desc {
  *	  every time the I3C device is rediscovered with a different dynamic
  *	  address assigned
  * @bus: I3C bus this device is attached to
+ * @node: unregistered device list node, only for use by
+ *	  i3c_master_register_new_i3c_devs(), it is not protected by a lock
  *
  * I3C device object exposed to I3C device drivers. The takes care of linking
  * this object to the relevant &struct_i3c_dev_desc one.
@@ -238,6 +240,7 @@ struct i3c_device {
 	struct device dev;
 	struct i3c_dev_desc *desc;
 	struct i3c_bus *bus;
+	struct list_head node;
 };
 
 /*
-- 
2.53.0

