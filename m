Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89E236B90C
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789005564; cv=none; b=oEs0EFFweh5QJI2cynhWVYnXzqCQ2qFpwllhVwjLYBmSO5TjWNBxesDP04Xtk5DZ7s7Sn2bsA5+hxEAzfjlXvyFohn5vO2PiTfhUvhlqP5oB17v2Lcw0zQjTuUW4nBc09GjmrMmC/8Q1OXIglUTdwwisuv418otx2Agzih8rdU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789005564; c=relaxed/simple;
	bh=6GL5yu44V8hNGCq4rSt4fCFdg1T8sTndOFPxXg5mq6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GKHwVEUmcKcN31WmBY2yAx4mDc56TpMhALpDKwSaDWYHpnKzGa4JqcbHpk08VGPiu4RpoZTzDr2rJHC0w1oNL5YZJQTomKADC3k7rxJA9qLj3Fq1SgB88WFISjJBLWyb1uj1aGu4ZHPISCZ7EHAWXVGRDt+/XK+EbWCGBac575w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ave8y82x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ave8y82x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C25F1F00898;
	Thu, 10 Sep 2026 01:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789005562;
	bh=rWZl+hlBfSrNf3Z2HEyc7G9v6r6sG37EcFwPw6X+GtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ave8y82xnshwAfJ7dN29sKmFF8pcbftTnhlpHRm+1wEU2KCqHhFYensSwV8AhlHJ2
	 ISFR5/CIHaUQLI1gj+hsvXNELCfbm+YPgllrb7L5BPsLFVRWCr0GfP1dKcf1LLEMU8
	 EhywgPlD9XJBsotAxAGcBCl83bUgpHXzR84MAJwfdW6Q+dKakL5sQaQqUAm3rascKf
	 zo9VnBXvh1ax0fQ/MrrZv5ARXPQ3h+cBKqEZWMob7BinDnMumUPIvXWXYL3tqLV3Hl
	 D4AgIduUv8jyyTJxcp6BnqZfCOw1ySzPOoP4tnpjQdL4ntIOTZnTppxoDs2HEvqYDm
	 xPalmlgzkQY9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Frank Li <Frank.Li@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] i3c: master: Fix recursive locking during device registration
Date: Wed,  9 Sep 2026 21:59:18 -0400
Message-ID: <20260910015918.3949701-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910015918.3949701-1-sashal@kernel.org>
References: <2026090420-duplicate-unframed-a6f4@gregkh>
 <20260910015918.3949701-1-sashal@kernel.org>
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
index 66eb84878ff22..9732b3847117c 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1479,12 +1479,21 @@ static int i3c_master_early_i3c_dev_add(struct i3c_master_controller *master,
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
@@ -1505,25 +1514,37 @@ i3c_master_register_new_i3c_devs(struct i3c_master_controller *master)
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
 	}
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
+	}
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
index 6ff6669c4d2c2..ecffeb42e8245 100644
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
2.53.0

