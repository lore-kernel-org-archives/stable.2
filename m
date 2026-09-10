Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742692C0F7F
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789002140; cv=none; b=O9zMe/mRs9Ng0wa72DKFLUiQrISGsIYfwMQTYwtrdTc6vySRQMmacnPxe36z3DXEgPUm+fr90g84AKdZskBqCSn+ms75ZisbnTOCSMVxfcwc2HffKV6FnbReQ5W+bl+KLxm33fc8YJ3QoMgEOvmVaFETRpVk8JJkEdG5VipxZrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789002140; c=relaxed/simple;
	bh=m9K13ufwSHUxIva8zohEuAO/3tBRP2ZD6tbPZ7xJC1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uNs0gpuNX/rj0ei8kjtjL1lM8L1pEorgkhmAvFUNIWDuPXEYvsz+Mmv/zsXmdl2YFSmjsJxLM/3nqcqmHp+0K7m4FalpLTgMiB72zIbvI8sl1dQyoBpejRCYR4J5YUVKe55vSjMuI9nyzC2E1pDu2DZcvZp7QK3demTbfx2rpCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0RbzQXL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0RbzQXL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBB91F000FF;
	Thu, 10 Sep 2026 01:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789002139;
	bh=Qcn2dg75w+3U+dZ2a8cK301tl29K3A0SOiw1iy9taFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B0RbzQXLhJyzFs3fc3chnbGYlgzekG2LdjjV2oC5WFnnuMJf4yoq9D0FDN8Yi9aMY
	 c5SMWf6hgkWLNI43mUxV477yg/O+kEK12qM8VglxyyHoGXb5fMjsyH1gW01UHrQeln
	 mNth1rpy4exIxejinAuH6WPFDz6CRdxnjtFu64LVuFVU2iGYiFsApPFdN863fmOYP+
	 +W9/pTeTiXcyZGgFdK9CG1++wu+OcZTL27GP+524tFHwWxueDRaw3SGJoP4suD6W3o
	 Syamf5YOaVD8StGgoT8Fa4bvieIYY53icC03K3ZAJdmcJbuLS7Q87jxItc3P1fJJae
	 ekmPgWtWbZYaQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Frank Li <Frank.Li@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] i3c: master: Defer new-device registration out of DAA caller context
Date: Wed,  9 Sep 2026 21:02:14 -0400
Message-ID: <20260910010215.3799061-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910010215.3799061-1-sashal@kernel.org>
References: <2026090420-phobia-unluckily-1be7@gregkh>
 <20260910010215.3799061-1-sashal@kernel.org>
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

[Stable adaptation for 6.6:
Keep the registration worker introduced by this dependency, but queue it
from the existing i3c_master_do_daa() entry point. This tree does not have
the extended DAA/runtime-PM API, the core hot-join worker, or the master
shutdown callbacks, so do not import those unrelated interfaces.

Make the existing controller workqueue freezable. Add the shutting_down
gate required by the worker and the target fix, set it and cancel reg_work
in the existing i3c_master_unregister(), and queue successful DAA work
under the maintenance lock so teardown cannot race a late registration
queue. Preserve synchronous initial registration with flush_work().

Clear both device/descriptor links on registration failure, matching the
cleanup expected by target 456f832e5fc26fbfd3b8200fd4553eee520cc377.
Retain this tree's OF representation; the target applies with a clean
three-way merge. No helper functions beyond the registration worker
already added by the upstream dependency are introduced.]

Stable-dep-of: 456f832e5fc2 ("i3c: master: Fix recursive locking during device registration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i3c/master.c       | 50 +++++++++++++++++++++++++++-----------
 include/linux/i3c/master.h |  7 ++++++
 2 files changed, 43 insertions(+), 14 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index b805eb2204993..949de8c6b7cdf 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1643,11 +1643,23 @@ i3c_master_register_new_i3c_devs(struct i3c_master_controller *master)
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
@@ -1668,17 +1680,16 @@ int i3c_master_do_daa(struct i3c_master_controller *master)
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
 
@@ -2816,12 +2827,14 @@ int i3c_master_register(struct i3c_master_controller *master,
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
@@ -2840,12 +2853,15 @@ int i3c_master_register(struct i3c_master_controller *master,
 
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
 
@@ -2870,6 +2886,12 @@ EXPORT_SYMBOL_GPL(i3c_master_register);
  */
 void i3c_master_unregister(struct i3c_master_controller *master)
 {
+	i3c_bus_maintenance_lock(&master->bus);
+	master->shutting_down = true;
+	i3c_bus_maintenance_unlock(&master->bus);
+
+	cancel_work_sync(&master->reg_work);
+
 	i3c_master_i2c_adapter_cleanup(master);
 	i3c_master_unregister_i3c_devs(master);
 	i3c_master_bus_cleanup(master);
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 2f731c6c16ea8..1b172fa8d7396 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -490,6 +490,7 @@ struct i3c_master_controller_ops {
  * @secondary: true if the master is a secondary master
  * @init_done: true when the bus initialization is done
  * @hotjoin: true if the master support hotjoin
+ * @shutting_down: set to true when master begins unregister
  * @boardinfo.i3c: list of I3C  boardinfo objects
  * @boardinfo.i2c: list of I2C boardinfo objects
  * @boardinfo: board-level information attached to devices connected on the bus
@@ -499,6 +500,10 @@ struct i3c_master_controller_ops {
  *	in a thread context. Typical examples are Hot Join processing which
  *	requires taking the bus lock in maintenance, which in turn, can only
  *	be done from a sleep-able context
+ * @reg_work: work item used to register newly discovered I3C devices with
+ *            the driver model. Queued to @wq by i3c_master_do_daa() so
+ *            that device registration is deferred out of the DAA caller's
+ *            context, and is skipped if the controller is unregistering
  *
  * A &struct i3c_master_controller has to be registered to the I3C subsystem
  * through i3c_master_register(). None of &struct i3c_master_controller fields
@@ -513,12 +518,14 @@ struct i3c_master_controller {
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

