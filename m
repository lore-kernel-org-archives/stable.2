Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABA13546EC
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789005563; cv=none; b=BfmBGHnWfjuCRYOgsJGH4kjwOMWS5b+s3NofIYr7lV0ZL/s8uI8lJIGnwWXIqEZovd1He8va6OLB2zF9dKnoe+UizBjK9vUn0MYVakLf/eetOxRjYSEIUUkjE8myZ1NtU2mTn/nyQcPrYequteocHRtemJeCljR2K0QAC/VuSe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789005563; c=relaxed/simple;
	bh=ECR5BxGJxgygDSu9PSDW/KbCBmd0tZTDuD7eqwYF6t8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iXZYaWNJNSS8g4MaVKAtMhnKzQqa2IjzbhGFns4J/bIeD4WW5M/rVhV6B7Q/Q3RexLjyLpj8S1SqWczVF8XtqPA4VuKJjf2yqV/tsyHcj6438pP92ys2yDl+F9Q58Q0Fsowb/9VelOgzqSS2cCHa+JEE702NtQdTqzlzxaDD2g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfbuXpRP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfbuXpRP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361741F00893;
	Thu, 10 Sep 2026 01:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789005561;
	bh=CSuUa5SHGyY0jHMHFI0vxxiq8UMLYLTW1xJmLx3P/5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TfbuXpRPEUyVoNupwVPaMcFqQNzbw2xc9gjnWynnRMzVGzvUdSyD5Xc5LDaDh1DOJ
	 WnxKC5j6IBclZnX6vXzPS/L7kYm4FUexL6my7BXZ3UBMGqSI/CbodwoVELplz9fkWB
	 trSGekRd8eCvl03mk5dVG9lqYPluTIlvRYh4Hlu6VWAL7/+dMzwMZWH7DDc4lDOm+o
	 grSl+Uu3BMWVrs34JKv5tAxDKOb16223r5SHyEJL/qRz8w1UfMN5Epk8DHDB5YdI5h
	 0ZUIl5d+IZQ7TsndIfdjevDOV2F47/ZiHCVZN82lSXDWqRLPGuI4Y71GL7PKyzJ9pe
	 xu3dpCgMp3aIQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Frank Li <Frank.Li@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] i3c: master: Defer new-device registration out of DAA caller context
Date: Wed,  9 Sep 2026 21:59:17 -0400
Message-ID: <20260910015918.3949701-2-sashal@kernel.org>
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

[ Upstream commit 3f79dac3ea1c30516fcc791770af034387c7f917 ]

Master drivers may invoke i3c_master_do_daa_ext() during resume to
re-run Dynamic Address Assignment.  As well as assigning addresses to
any newly arrived devices, this restores the dynamic address of devices
that lost it across system suspend, so it has to run as part of the
controller's resume path.

A side effect of i3c_master_do_daa_ext() today is that it also
registers any newly discovered I3C devices with the driver model
inline, via i3c_master_register_new_i3c_devs().  Doing that from the
resume path is problematic: a hot-join-capable device may join the bus
during this same DAA, and registering it immediately would push driver
model work (probing, sysfs, etc.) into the controller's resume context,
where the rest of the system is not yet fully resumed and the
controller driver is still partway through its own resume sequence.

Decouple discovery from registration: add a reg_work work item to
struct i3c_master_controller and have i3c_master_do_daa_ext() queue it
on master->wq (the freezable workqueue) instead of calling
i3c_master_register_new_i3c_devs() directly.  The worker performs the
registration only when the controller is not shutting_down, and is
cancelled alongside hj_work in i3c_master_shutdown().  Because wq is
freezable, any newly observed devices end up being registered after
the system has finished resuming.

i3c_master_register() also routes its initial post-bus-init registration
through reg_work, using flush_work() to keep probe-time behavior
synchronous.  This keeps a single registration code path and ensures the
worker is the only writer of desc->dev.

Fixes: 3a379bbcea0af ("i3c: Add core I3C infrastructure")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260608054312.10604-7-adrian.hunter@intel.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

[5.15 backport: Retain the upstream registration worker, but queue it
from i3c_master_do_daa(), since this tree has no extended DAA API or
runtime-PM wrappers. Mark the existing workqueue freezable and flush the
initial registration work to retain synchronous master registration.

This tree also lacks the core hot-join work and shutdown helpers. Add the
shutting_down state needed by the worker and the dependent locking fix,
and cancel registration work in the existing unregister and registration
failure paths. Queue work while holding the maintenance lock, so setting
shutting_down and cancelling work cannot race with a new DAA enqueue.
Initialize both lifecycle flags when registering the controller.

Include the two pointer clears from 74be657d98a8d ("i3c: master: Fix
device_register() error path") so failed registration cannot leave a
stale descriptor/device link, and target 456f832e5fc2 applies cleanly.
Keep the 5.15 OF-node handling; the target's three-way merge preserves it.
No additional helper functions are introduced beyond the worker already
present in this dependency.]

Stable-dep-of: 456f832e5fc2 ("i3c: master: Fix recursive locking during device registration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i3c/master.c       | 56 ++++++++++++++++++++++++++++----------
 include/linux/i3c/master.h |  9 +++++-
 2 files changed, 50 insertions(+), 15 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index b4426fa660898..66eb84878ff22 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1509,11 +1509,23 @@ i3c_master_register_new_i3c_devs(struct i3c_master_controller *master)
 		if (ret) {
 			dev_err(&master->dev,
 				"Failed to add I3C device (err = %d)\n", ret);
+			desc->dev->desc = NULL;
 			put_device(&desc->dev->dev);
+			desc->dev = NULL;
 		}
 	}
 }
 
+static void i3c_master_reg_work_fn(struct work_struct *work)
+{
+	struct i3c_master_controller *master = container_of(work, typeof(*master), reg_work);
+
+	i3c_bus_normaluse_lock(&master->bus);
+	if (!master->shutting_down)
+		i3c_master_register_new_i3c_devs(master);
+	i3c_bus_normaluse_unlock(&master->bus);
+}
+
 /**
  * i3c_master_do_daa() - do a DAA (Dynamic Address Assignment)
  * @master: master doing the DAA
@@ -1534,17 +1546,16 @@ int i3c_master_do_daa(struct i3c_master_controller *master)
 	int ret;
 
 	i3c_bus_maintenance_lock(&master->bus);
-	ret = master->ops->do_daa(master);
+	if (master->shutting_down) {
+		ret = -ENODEV;
+	} else {
+		ret = master->ops->do_daa(master);
+		if (!ret)
+			queue_work(master->wq, &master->reg_work);
+	}
 	i3c_bus_maintenance_unlock(&master->bus);
 
-	if (ret)
-		return ret;
-
-	i3c_bus_normaluse_lock(&master->bus);
-	i3c_master_register_new_i3c_devs(master);
-	i3c_bus_normaluse_unlock(&master->bus);
-
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(i3c_master_do_daa);
 
@@ -2507,6 +2518,8 @@ int i3c_master_register(struct i3c_master_controller *master,
 	master->dev.release = i3c_masterdev_release;
 	master->ops = ops;
 	master->secondary = secondary;
+	master->init_done = false;
+	master->shutting_down = false;
 	INIT_LIST_HEAD(&master->boardinfo.i2c);
 	INIT_LIST_HEAD(&master->boardinfo.i3c);
 
@@ -2549,12 +2562,14 @@ int i3c_master_register(struct i3c_master_controller *master,
 	if (ret)
 		goto err_put_dev;
 
-	master->wq = alloc_workqueue("%s", 0, 0, dev_name(parent));
+	master->wq = alloc_workqueue("%s", WQ_FREEZABLE, 0, dev_name(parent));
 	if (!master->wq) {
 		ret = -ENOMEM;
 		goto err_put_dev;
 	}
 
+	INIT_WORK(&master->reg_work, i3c_master_reg_work_fn);
+
 	ret = i3c_master_bus_init(master);
 	if (ret)
 		goto err_put_dev;
@@ -2573,12 +2588,15 @@ int i3c_master_register(struct i3c_master_controller *master,
 
 	/*
 	 * We're done initializing the bus and the controller, we can now
-	 * register I3C devices discovered during the initial DAA.
+	 * register I3C devices discovered during the initial DAA. Device
+	 * registration is done via reg_work because that keeps a single
+	 * registration code path and ensures the worker is the only writer
+	 * of desc->dev. Flush the work to preserve synchronous probe-time
+	 * behavior.
 	 */
 	master->init_done = true;
-	i3c_bus_normaluse_lock(&master->bus);
-	i3c_master_register_new_i3c_devs(master);
-	i3c_bus_normaluse_unlock(&master->bus);
+	queue_work(master->wq, &master->reg_work);
+	flush_work(&master->reg_work);
 
 	return 0;
 
@@ -2586,6 +2604,11 @@ int i3c_master_register(struct i3c_master_controller *master,
 	device_del(&master->dev);
 
 err_cleanup_bus:
+	i3c_bus_maintenance_lock(&master->bus);
+	master->shutting_down = true;
+	i3c_bus_maintenance_unlock(&master->bus);
+	cancel_work_sync(&master->reg_work);
+
 	i3c_master_bus_cleanup(master);
 
 err_put_dev:
@@ -2605,6 +2628,11 @@ EXPORT_SYMBOL_GPL(i3c_master_register);
  */
 int i3c_master_unregister(struct i3c_master_controller *master)
 {
+	i3c_bus_maintenance_lock(&master->bus);
+	master->shutting_down = true;
+	i3c_bus_maintenance_unlock(&master->bus);
+	cancel_work_sync(&master->reg_work);
+
 	i3c_master_i2c_adapter_cleanup(master);
 	i3c_master_unregister_i3c_devs(master);
 	i3c_master_bus_cleanup(master);
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 604a126b78c83..6ff6669c4d2c2 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -464,15 +464,20 @@ struct i3c_master_controller_ops {
  * @ops: master operations. See &struct i3c_master_controller_ops
  * @secondary: true if the master is a secondary master
  * @init_done: true when the bus initialization is done
+ * @shutting_down: true when the controller is being unregistered
  * @boardinfo.i3c: list of I3C  boardinfo objects
  * @boardinfo.i2c: list of I2C boardinfo objects
  * @boardinfo: board-level information attached to devices connected on the bus
  * @bus: I3C bus exposed by this master
- * @wq: workqueue used to execute IBI handlers. Can also be used by master
+ * @wq: freezable workqueue used to execute IBI handlers. Can also be used by master
  *	drivers if they need to postpone operations that need to take place
  *	in a thread context. Typical examples are Hot Join processing which
  *	requires taking the bus lock in maintenance, which in turn, can only
  *	be done from a sleep-able context
+ * @reg_work: work item used to register newly discovered I3C devices with
+ *            the driver model. Queued by i3c_master_do_daa() to defer
+ *            registration out of the DAA caller's context, and cancelled
+ *            before tearing down the controller
  *
  * A &struct i3c_master_controller has to be registered to the I3C subsystem
  * through i3c_master_register(). None of &struct i3c_master_controller fields
@@ -486,12 +491,14 @@ struct i3c_master_controller {
 	const struct i3c_master_controller_ops *ops;
 	unsigned int secondary : 1;
 	unsigned int init_done : 1;
+	unsigned int shutting_down : 1;
 	struct {
 		struct list_head i3c;
 		struct list_head i2c;
 	} boardinfo;
 	struct i3c_bus bus;
 	struct workqueue_struct *wq;
+	struct work_struct reg_work;
 };
 
 /**
-- 
2.53.0

