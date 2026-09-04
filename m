Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DB23F4829
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 04:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788496679; cv=none; b=pITMRFRWvJ/aKITNWe8cnJdwPGaMa3ZxfDSVgERq/a0aGu3HyKgBW4xLaIzFTw400CJuv/SW1sUE7ShPiXi3FrNPVkrYWUiD7VjdN5EsQodkkLeDywWfCUW8AwoNIz3di7pprywqH7i/9EiTcwwhmh/sEt+Ac5S6fAAU1W8w43w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788496679; c=relaxed/simple;
	bh=JX4VGiYXUFnutHLfoP4HVl/Ry5ASD0qfhBkyfLJ6lgE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NAWnhBVgOsfGvbMg7fXKzEZaZSODoPxoTw51YCvwOHiKHfHp2nxnW7IdRoIywtP7MjRUDjL/EKVZNqLJohtToIoLHy5O7xxIxGA3A4f3tVNXlo+UVVgAaDFM2XnVAaHZY5soYhlj8qvhqrphnQ9/gVsoP8khKrZs77JpsKOjJHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VKhqBtqQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VKhqBtqQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50C91F00A3D;
	Fri,  4 Sep 2026 04:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788496677;
	bh=EcZ0FtW1VNUItxtLo9DjsO+cpzo+5OxY+6d/PNv9SZA=;
	h=Subject:To:Cc:From:Date;
	b=VKhqBtqQNGdp7OjJ9z2/r8FuHwynSEP07kBqaZRsA+bHrffA8OGToX3/QcatGP5pR
	 XgYJIrP1zs8hb2cPu7oo03V8CiV41ur/oGZfyzcIlMUva73WPqfjvYvyCgMnSuzcud
	 FrEb1gDMYvzg+4z8ztjt4N1F5Er1pCCJZBnLY9vw=
Subject: FAILED: patch "[PATCH] i3c: master: Fix recursive locking during device registration" failed to apply to 5.10-stable tree
To: adrian.hunter@intel.com,Frank.Li@nxp.com,alexandre.belloni@bootlin.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 04 Sep 2026 06:37:21 +0200
Message-ID: <2026090421-spilt-flock-92e8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 456f832e5fc26fbfd3b8200fd4553eee520cc377
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090421-spilt-flock-92e8@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 456f832e5fc26fbfd3b8200fd4553eee520cc377 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@intel.com>
Date: Fri, 7 Aug 2026 17:56:25 +0300
Subject: [PATCH] i3c: master: Fix recursive locking during device registration

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

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index f485b98805cf..d2fb1a110521 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2069,12 +2069,21 @@ static int i3c_master_early_i3c_dev_add(struct i3c_master_controller *master,
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
@@ -2104,25 +2113,37 @@ i3c_master_register_new_i3c_devs(struct i3c_master_controller *master)
 		if (desc->boardinfo)
 			device_set_node(&desc->dev->dev, desc->boardinfo->fwnode);
 
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
index 2dc139a217bf..26535beb1e77 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -238,6 +238,8 @@ struct i3c_dev_desc {
  *	  every time the I3C device is rediscovered with a different dynamic
  *	  address assigned
  * @bus: I3C bus this device is attached to
+ * @node: unregistered device list node, only for use by
+ *	  i3c_master_register_new_i3c_devs(), it is not protected by a lock
  *
  * I3C device object exposed to I3C device drivers. The takes care of linking
  * this object to the relevant &struct_i3c_dev_desc one.
@@ -248,6 +250,7 @@ struct i3c_device {
 	struct device dev;
 	struct i3c_dev_desc *desc;
 	struct i3c_bus *bus;
+	struct list_head node;
 };
 
 /*

