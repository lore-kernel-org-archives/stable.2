Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64762E542C
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 00:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788999481; cv=none; b=o/D4WlEbZ+1Zt20nGuajUKDiDv+kmLSvaqB9SlayLMrrl9oDbRvGX24wgK6GRINx6FYYsenDMhO/3+mzim1wG3QvvsEOvVNnHe0eY8iSK5KMFSRtmK58iClTQQ715KuXpUu1ebB77KAvv3NGA4f/Ms6nTD/UDNI/4XLEepMt1fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788999481; c=relaxed/simple;
	bh=Wzb4+bGMWGleCTRpnGn5Q6rH5OzWwyxjSTlMLSkiYw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QvuSH9johViZEF+rpsP9c7VwW34vwg8KENqM6rtnI52TTS6vddBQ/0vOdA9ke0qeU557AmcGYqvjVQZSiMDTLWyYZu5AK6oX5wXSTkgzmo3AYjixNuJA8wCfn5we5f2GaQg3vcdvZ53uSu3FOMEH3MgKEw5iyQ1zKwQgs0aqQyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqKXll1P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqKXll1P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B771F00898;
	Thu, 10 Sep 2026 00:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788999479;
	bh=ha/v6MewKjrJv7UmzfF2aRbhofxHT2O50lnijW+Kw1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BqKXll1PHzQiQ/ewCa33HxxHZcLQ7Y4BgD/dC4f/f4HET33twnezSxGMpRQszdijW
	 3feAJ3O8POJTSjXn2Hpbgpzj9gLcKFfHNIoNBpyepniS/YT/54GUGdRNOWbnHGbBGR
	 uN43YcWJy7BiAcdok22TouSJS1LYb07nFE6hCOvwD9KcRFFw6OpZfUlV54g8s7yUwg
	 8YsCeP/oSJtQPkqBwMatga261GSd+lU2iCbgOQt+PZi1njJ9zWfOdkAV6/ehmVGZek
	 ACDn7tJ3gXazUZnsXISl11UCDWyH0Igip5TCUT3RYHLJ92x6x3fspzgyAfUyZb5cat
	 sLXQ3q2qMkVtQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Frank Li <Frank.Li@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] i3c: master: Defer new-device registration out of DAA caller context
Date: Wed,  9 Sep 2026 20:17:55 -0400
Message-ID: <20260910001756.3748845-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910001756.3748845-1-sashal@kernel.org>
References: <2026090419-hunchback-antics-d9e3@gregkh>
 <20260910001756.3748845-1-sashal@kernel.org>
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

Stable adaptation for 6.12:

Use the existing i3c_master_do_daa() API because this branch lacks the
extended DAA API and the runtime-PM and core hot-join prerequisites.
Keep the registration worker introduced by this commit unchanged.
Initialize reg_work in i3c_master_register() and preserve the initial
registration flush.

Add the shutting_down gate and cancel reg_work directly in the existing
i3c_master_unregister() path, before device and bus cleanup. Queue DAA
registration while holding the maintenance lock so unregister cannot
cancel the work and then race with a late enqueue. No additional helper
functions or core hot-join/shutdown callbacks are introduced.

Include the two device_register() failure-path pointer clears from
74be657d98a8d ("i3c: master: Fix device_register() error path"), which are
required by the target's registration cleanup rewrite. Keep the existing
OF node handling; the target merges cleanly without the unified firmware
property conversion.

This prepares the tree for 456f832e5fc2 ("i3c: master: Fix recursive locking
during device registration").

Stable-dep-of: 456f832e5fc2 ("i3c: master: Fix recursive locking during device registration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i3c/master.c       | 48 +++++++++++++++++++++++++++-----------
 include/linux/i3c/master.h |  6 +++++
 2 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 067dd5946d512..9103dc77a4459 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1689,11 +1689,23 @@ i3c_master_register_new_i3c_devs(struct i3c_master_controller *master)
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
@@ -1714,17 +1726,17 @@ int i3c_master_do_daa(struct i3c_master_controller *master)
 	int ret;
 
 	i3c_bus_maintenance_lock(&master->bus);
-	ret = master->ops->do_daa(master);
-	i3c_bus_maintenance_unlock(&master->bus);
-
-	if (ret)
-		return ret;
+	if (master->shutting_down)
+		ret = -ENODEV;
+	else
+		ret = master->ops->do_daa(master);
 
-	i3c_bus_normaluse_lock(&master->bus);
-	i3c_master_register_new_i3c_devs(master);
-	i3c_bus_normaluse_unlock(&master->bus);
+	/* Serialize queuing with cancellation during unregister. */
+	if (!ret)
+		queue_work(master->wq, &master->reg_work);
+	i3c_bus_maintenance_unlock(&master->bus);
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(i3c_master_do_daa);
 
@@ -2817,6 +2829,7 @@ int i3c_master_register(struct i3c_master_controller *master,
 	master->dev.release = i3c_masterdev_release;
 	master->ops = ops;
 	master->secondary = secondary;
+	master->shutting_down = false;
 	INIT_LIST_HEAD(&master->boardinfo.i2c);
 	INIT_LIST_HEAD(&master->boardinfo.i3c);
 
@@ -2868,6 +2881,7 @@ int i3c_master_register(struct i3c_master_controller *master,
 		ret = -ENOMEM;
 		goto err_put_dev;
 	}
+	INIT_WORK(&master->reg_work, i3c_master_reg_work_fn);
 
 	ret = i3c_master_bus_init(master);
 	if (ret)
@@ -2893,12 +2907,15 @@ int i3c_master_register(struct i3c_master_controller *master,
 
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
 
@@ -2925,6 +2942,11 @@ void i3c_master_unregister(struct i3c_master_controller *master)
 {
 	i3c_bus_notify(&master->bus, I3C_NOTIFY_BUS_REMOVE);
 
+	i3c_bus_maintenance_lock(&master->bus);
+	master->shutting_down = true;
+	i3c_bus_maintenance_unlock(&master->bus);
+	cancel_work_sync(&master->reg_work);
+
 	i3c_master_i2c_adapter_cleanup(master);
 	i3c_master_unregister_i3c_devs(master);
 	i3c_master_bus_cleanup(master);
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 414a8acde0183..2addb43f85dac 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -499,6 +499,7 @@ struct i3c_master_controller_ops {
  * @secondary: true if the master is a secondary master
  * @init_done: true when the bus initialization is done
  * @hotjoin: true if the master support hotjoin
+ * @shutting_down: set to true when master is being unregistered
  * @boardinfo.i3c: list of I3C  boardinfo objects
  * @boardinfo.i2c: list of I2C boardinfo objects
  * @boardinfo: board-level information attached to devices connected on the bus
@@ -508,6 +509,9 @@ struct i3c_master_controller_ops {
  *	in a thread context. Typical examples are Hot Join processing which
  *	requires taking the bus lock in maintenance, which in turn, can only
  *	be done from a sleep-able context
+ * @reg_work: work item used to register newly discovered I3C devices with
+ *	    the driver model, queued to @wq by i3c_master_do_daa() and
+ *	    cancelled when the controller is unregistered
  *
  * A &struct i3c_master_controller has to be registered to the I3C subsystem
  * through i3c_master_register(). None of &struct i3c_master_controller fields
@@ -522,12 +526,14 @@ struct i3c_master_controller {
 	unsigned int secondary : 1;
 	unsigned int init_done : 1;
 	unsigned int hotjoin: 1;
+	bool shutting_down;
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

