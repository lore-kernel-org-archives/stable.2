Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CD74A64F0;
	Tue, 22 Sep 2026 07:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.101.248.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790060942; cv=none; b=dNKa2vqfqOU5bnvl7gVhevxcNOmml9qeJMKVu3557t0wOyp5bs9NUsBwBMltGMn2ORPNAFQGQmlRF01E2+D9g7qjHen0VcV1h2mi443YR7ip4g7/NS80tTFuQ8JajaegFoaP1NQr2jEEvwjW4vRfm0LAI7v6MjewwirGbM8UD5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790060942; c=relaxed/simple;
	bh=FnKuWwDVCLWMes3I4OYUEBgwHVY+65WSNJCp3RBnqVI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HPG2YjisHgg0L2R5EpU2qf5wdNBx0lqCtPWAyZeHCcibyhy3FH9mjOli8fw8IG/oVhUxW57TY93TaaNaUDMyrTYU6sPiFqZSgJ0l6t+9iG4rl8Rx0HvTG2HMwmoxm45r5aoke1KCBSVMjvP0N4rKeRmEEqYP24KvZeEQVKIvQaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=46.101.248.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wC3vzd4KbJqzlstAQ--.836S3;
	Tue, 22 Sep 2026 15:08:40 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app4 (Coremail) with SMTP id zi_KCgC36jFyKbJq83PLAw--.21269S2;
	Tue, 22 Sep 2026 15:08:37 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: netdev@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>,
	Song Li <songl@zju.edu.cn>
Subject: [PATCH net v4] net: mana: fix reset work race with device removal
Date: Tue, 22 Sep 2026 07:07:28 +0000
Message-Id: <20260922070728.309280-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgC36jFyKbJq83PLAw--.21269S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?lLUDIgXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnXz+g1OQfMo27QHy5TwQyZxk5o+qIL/vtwnKjAE9a4zD6j1wWld26+ljpZhSAxtE685B
	aL6DbbUz/pTPayEY+dep9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj9fXoWfXFyrXrW8Kr1fGry3GFWUZFc_yoW8Zw1rAo
	WfXrW3Xw48J345Ca97trykJFW3WrW0g34YgF409FsrAF18X3WYk34UCr13Z34rWF1Fkw12
	va43Xwn7uFZ3twnrl-sFpf9Il3svdjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUOU7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26F4UJVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU818BUUUUUU==

The reset service work is queued on the system workqueue and can
outlive mana_gd_remove(), which frees the GDMA context. It may then
dereference gc through the stale service work.

Embed the service work in gdma_context and guard its lifecycle with a
new serv_lock (hard IRQ safe, never held across a sleep) plus a
waitqueue. Removal, shutdown and the probe unwind close admission and
wait for an in-flight cycle to retire before clearing drvdata and
freeing gc. Service exits retire before taking the PCI rescan/remove
lock, avoiding a lock-cycle with remove.

Do not admit service work while probe is still constructing or
unwinding the device. Latch reset events seen during probe under the
same lock and let the probe rollback/recovery path handle them; an
event racing probe completion is admitted rather than lost. A service
exit that bails out of a rescan without removing the device (no parent
bus) retires without closing admission, so service is never
permanently disabled on a bound device.

The service work stays on the system workqueue because a reset cycle
destroys and re-creates gc->service_wq.

This issue was found by an in-house static analysis tool.

Fixes: fbe346ce9d62 ("net: mana: Handle Reset Request from MANA NIC")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 273 ++++++++++++++----
 drivers/net/ethernet/microsoft/mana/mana_en.c |  13 +-
 include/net/mana/gdma.h                       |  29 +-
 3 files changed, 238 insertions(+), 77 deletions(-)

Changes since v3 (<20260909042529.652301-1-fanwu01@zju.edu.cn>,
https://lore.kernel.org/netdev/20260909042529.652301-1-fanwu01@zju.edu.cn):

- Replaced the flag protocol with a gc-embedded spinlock and waitqueue
  (Jakub Kicinski): admission, retirement and the probe boundary
  handshake now run under serv_lock instead of atomic bit pairings.

- A rescan exit that bails out without removing the device (no parent
  bus) now retires without closing admission, so service is not
  permanently disabled on a bound device.

- mana_gd_shutdown() also drains an in-flight cycle before tearing
  down the same hardware paths as remove().

Changes since v2 (<20260905023602.425827-1-fanwu01@zju.edu.cn>,
https://lore.kernel.org/netdev/20260905023602.425827-1-fanwu01@zju.edu.cn):

- Dropped the now-unused cleanup_mana_rdma and cleanup_mana labels in
  the probe error path (Simon Horman).

Changes since v1 (<20260805143812.220509-1-fanwu01@zju.edu.cn>,
https://lore.kernel.org/netdev/20260805143812.220509-1-fanwu01@zju.edu.cn):

- Dropped the device_lock() serialisation: holding the driver-core
  device lock across mana_gd_suspend() + msleep() + mana_gd_resume()
  blocks unbind, reboot, device PM and all PCI hotplug for up to a
  full reset cycle, and can deadlock against the
  flush_workqueue()/destroy_workqueue() of gc->service_wq.

- The freeing paths close admission and wait for an admitted cycle to
  retire before clearing drvdata and calling vfree(); the failed-resume
  rescan no longer reopens admission, and mana_tx_timeout() also skips
  queue-reset work during removal.

- No service work is admitted before the probe completes; the FPGA
  reconfig exit and the probe-failure recovery path are covered as
  well. The stats-work gate during probe is deliberate: a failing
  probe cannot drain a cycle, and the probe's own -ETIMEDOUT rollback
  plus the recovery rescan service the skipped event.

- Reference series for the HWC lifecycle model:
  https://lore.kernel.org/netdev/20260813174243.3044348-1-longli@microsoft.com

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 8e9bfc1..b91d254 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -659,63 +659,149 @@ EXPORT_SYMBOL_NS(mana_gd_ring_dim, "NET_MANA");
 
 #define MANA_SERVICE_PERIOD 10
 
-static void mana_serv_rescan(struct pci_dev *pdev)
+/* Retire one service cycle: serv_waitq is embedded in gc, so the wake
+ * must happen before the lock is dropped - a drainer that observes
+ * idle cannot free gc until the wake has stopped touching gc.
+ */
+static void mana_service_retire(struct gdma_context *gc)
 {
-	struct pci_bus *parent;
+	unsigned long flags;
 
-	pci_lock_rescan_remove();
+	spin_lock_irqsave(&gc->serv_lock, flags);
+	gc->serv_in_flight = false;
+	wake_up(&gc->serv_waitq);
+	spin_unlock_irqrestore(&gc->serv_lock, flags);
+}
+
+/* Close admission atomically with the retire itself. */
+static void mana_service_retire_removing(struct gdma_context *gc)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&gc->serv_lock, flags);
+	gc->serv_removing = true;
+	gc->serv_in_flight = false;
+	wake_up(&gc->serv_waitq);
+	spin_unlock_irqrestore(&gc->serv_lock, flags);
+}
+
+static bool mana_service_idle(struct gdma_context *gc)
+{
+	unsigned long flags;
+	bool idle;
+
+	spin_lock_irqsave(&gc->serv_lock, flags);
+	idle = !gc->serv_in_flight;
+	spin_unlock_irqrestore(&gc->serv_lock, flags);
+	return idle;
+}
+
+/* Close admission and wait until an in-flight cycle has stopped touching
+ * gc.  The cycle retires before taking the PCI rescan/remove lock, so
+ * this wait completes even when the caller holds that lock; serv_lock is
+ * never held across a sleep.
+ */
+static void mana_service_quiesce(struct gdma_context *gc)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&gc->serv_lock, flags);
+	gc->serv_removing = true;
+	spin_unlock_irqrestore(&gc->serv_lock, flags);
+
+	wait_event(gc->serv_waitq, mana_service_idle(gc));
+}
+
+/* May run in softirq context (tx timeout). */
+bool mana_service_active(struct gdma_context *gc)
+{
+	unsigned long flags;
+	bool active;
+
+	spin_lock_irqsave(&gc->serv_lock, flags);
+	active = gc->serv_in_flight || gc->serv_removing;
+	spin_unlock_irqrestore(&gc->serv_lock, flags);
+	return active;
+}
+
+bool mana_service_probe_done(struct gdma_context *gc)
+{
+	unsigned long flags;
+	bool done;
+
+	spin_lock_irqsave(&gc->serv_lock, flags);
+	done = gc->serv_probe_done;
+	spin_unlock_irqrestore(&gc->serv_lock, flags);
+	return done;
+}
+
+static void mana_serv_rescan(struct pci_dev *pdev, struct gdma_context *gc)
+{
+	struct pci_bus *parent;
 
 	parent = pdev->bus;
 	if (!parent) {
 		dev_err(&pdev->dev, "MANA service: no parent bus\n");
-		goto out;
+		/* Still bound: keep admission open for later events. */
+		if (gc)
+			mana_service_retire(gc);
+		return;
 	}
 
+	if (gc)
+		mana_service_retire_removing(gc);
+
+	pci_lock_rescan_remove();
+
 	pci_stop_and_remove_bus_device(pdev);
 	pci_rescan_bus(parent);
 
-out:
 	pci_unlock_rescan_remove();
 }
 
-static void mana_serv_fpga(struct pci_dev *pdev)
+static void mana_serv_fpga(struct pci_dev *pdev, struct gdma_context *gc)
 {
 	struct pci_bus *bus, *parent;
 
-	pci_lock_rescan_remove();
-
 	bus = pdev->bus;
 	if (!bus) {
 		dev_err(&pdev->dev, "MANA service: no bus\n");
-		goto out;
+		if (gc)
+			mana_service_retire(gc);
+		return;
 	}
 
 	parent = bus->parent;
 	if (!parent) {
 		dev_err(&pdev->dev, "MANA service: no parent bus\n");
-		goto out;
+		if (gc)
+			mana_service_retire(gc);
+		return;
 	}
 
+	if (gc)
+		mana_service_retire_removing(gc);
+
+	pci_lock_rescan_remove();
+
 	pci_stop_and_remove_bus_device(bus->self);
 
 	msleep(MANA_SERVICE_PERIOD * 1000);
 
 	pci_rescan_bus(parent);
 
-out:
 	pci_unlock_rescan_remove();
 }
 
-static void mana_serv_reset(struct pci_dev *pdev)
+static void mana_serv_reset(struct pci_dev *pdev, struct gdma_context *gc)
 {
-	struct gdma_context *gc = pci_get_drvdata(pdev);
 	struct hw_channel_context *hwc;
 	int ret;
 
 	if (!gc) {
 		/* Perform PCI rescan on device if GC is not set up */
 		dev_err(&pdev->dev, "MANA service: GC not setup, rescanning\n");
-		mana_serv_rescan(pdev);
+		mana_serv_rescan(pdev, NULL);
 		return;
 	}
 
@@ -738,7 +824,7 @@ static void mana_serv_reset(struct pci_dev *pdev)
 	if (ret == -ETIMEDOUT || ret == -EPROTO) {
 		/* Perform PCI rescan on device if we failed on HWC */
 		dev_err(&pdev->dev, "MANA service: resume failed, rescanning\n");
-		mana_serv_rescan(pdev);
+		mana_serv_rescan(pdev, gc);
 		return;
 	}
 
@@ -748,22 +834,25 @@ static void mana_serv_reset(struct pci_dev *pdev)
 		dev_info(&pdev->dev, "MANA reset cycle completed\n");
 
 out:
-	clear_bit(GC_IN_SERVICE, &gc->flags);
+	mana_service_retire(gc);
 }
 
-static void mana_do_service(enum gdma_eqe_type type, struct pci_dev *pdev)
+static void mana_do_service(enum gdma_eqe_type type, struct pci_dev *pdev,
+			    struct gdma_context *gc)
 {
 	switch (type) {
 	case GDMA_EQE_HWC_FPGA_RECONFIG:
-		mana_serv_fpga(pdev);
+		mana_serv_fpga(pdev, gc);
 		break;
 
 	case GDMA_EQE_HWC_RESET_REQUEST:
-		mana_serv_reset(pdev);
+		mana_serv_reset(pdev, gc);
 		break;
 
 	default:
 		dev_err(&pdev->dev, "MANA service: unknown type %d\n", type);
+		if (gc)
+			mana_service_retire(gc);
 		break;
 	}
 }
@@ -779,12 +868,26 @@ static void mana_recovery_delayed_func(struct work_struct *w)
 	spin_lock_irqsave(&work->lock, flags);
 
 	while (!list_empty(&work->dev_list)) {
+		struct gdma_context *gc;
+
 		dev = list_first_entry(&work->dev_list,
 				       struct mana_dev_recovery, list);
 		list_del(&dev->list);
 		spin_unlock_irqrestore(&work->lock, flags);
 
-		mana_do_service(dev->type, dev->pdev);
+		/* Serialize the drvdata lookup and admission against
+		 * probe/remove.  Do not call sleeping functions while
+		 * holding the device lock.
+		 */
+		device_lock(&dev->pdev->dev);
+		gc = pci_get_drvdata(dev->pdev);
+		if (gc)
+			mana_schedule_serv_work(gc, dev->type);
+		device_unlock(&dev->pdev->dev);
+
+		if (!gc)
+			mana_do_service(dev->type, dev->pdev, NULL);
+
 		pci_dev_put(dev->pdev);
 		kfree(dev);
 
@@ -796,51 +899,94 @@ static void mana_recovery_delayed_func(struct work_struct *w)
 
 static void mana_serv_func(struct work_struct *w)
 {
-	struct mana_serv_work *mns_wk;
-	struct pci_dev *pdev;
-
-	mns_wk = container_of(w, struct mana_serv_work, serv_work);
-	pdev = mns_wk->pdev;
+	struct gdma_context *gc = container_of(w, struct gdma_context, serv_work);
+	struct pci_dev *pdev = to_pci_dev(gc->dev);
 
-	if (pdev)
-		mana_do_service(mns_wk->type, pdev);
+	mana_do_service(gc->serv_type, pdev, gc);
 
+	/* The rescan exits of mana_do_service() remove the device, which
+	 * frees gc before returning.  Only touch the pdev and the module
+	 * reference from here on; both are held until this point drops them.
+	 */
 	pci_dev_put(pdev);
-	kfree(mns_wk);
 	module_put(THIS_MODULE);
 }
 
+/* Serialize admission with retirement.  Called in hard IRQ context, so
+ * serv_lock is taken with interrupts disabled and nothing that may
+ * sleep runs under it.
+ */
 int mana_schedule_serv_work(struct gdma_context *gc, enum gdma_eqe_type type)
 {
-	struct mana_serv_work *mns_wk;
+	unsigned long flags;
+	bool busy;
+
+	spin_lock_irqsave(&gc->serv_lock, flags);
+	busy = gc->serv_removing || gc->serv_in_flight;
+	if (!busy)
+		gc->serv_in_flight = true;
+	spin_unlock_irqrestore(&gc->serv_lock, flags);
 
-	if (test_and_set_bit(GC_IN_SERVICE, &gc->flags)) {
+	if (busy) {
 		dev_info(gc->dev, "Already in service\n");
 		return -EBUSY;
 	}
 
 	if (!try_module_get(THIS_MODULE)) {
 		dev_info(gc->dev, "Module is unloading\n");
-		clear_bit(GC_IN_SERVICE, &gc->flags);
+		mana_service_retire(gc);
 		return -ENODEV;
 	}
 
-	mns_wk = kzalloc_obj(*mns_wk, GFP_ATOMIC);
-	if (!mns_wk) {
-		module_put(THIS_MODULE);
-		clear_bit(GC_IN_SERVICE, &gc->flags);
-		return -ENOMEM;
-	}
-
 	dev_info(gc->dev, "Start MANA service type:%d\n", type);
-	mns_wk->pdev = to_pci_dev(gc->dev);
-	mns_wk->type = type;
-	pci_dev_get(mns_wk->pdev);
-	INIT_WORK(&mns_wk->serv_work, mana_serv_func);
-	schedule_work(&mns_wk->serv_work);
+
+	gc->serv_type = type;
+	pci_dev_get(to_pci_dev(gc->dev));
+	queue_work(system_wq, &gc->serv_work);
 	return 0;
 }
 
+/* EQ-event side of the probe boundary: latch the event while the probe
+ * is still running and let the probe roll back (the recovery path will
+ * rescan), or admit the cycle once the probe has completed.  The probe
+ * tail stores probe_done and reads the latch under the same lock, so an
+ * event racing probe completion is admitted rather than lost.
+ */
+static void mana_service_event(struct gdma_context *gc,
+			       enum gdma_eqe_type type)
+{
+	unsigned long flags;
+	bool admit, first;
+
+	spin_lock_irqsave(&gc->serv_lock, flags);
+	admit = gc->serv_probe_done;
+	first = !gc->serv_during_probe;
+	if (!admit)
+		gc->serv_during_probe = true;
+	spin_unlock_irqrestore(&gc->serv_lock, flags);
+
+	if (admit)
+		mana_schedule_serv_work(gc, type);
+	else if (first)
+		dev_info(gc->dev, "Service is to be processed in probe\n");
+}
+
+/* Probe-tail side of the probe boundary: record probe completion and
+ * return whether an event was latched meanwhile; the same-lock pairing
+ * with mana_service_event() keeps a racing event from being lost.
+ */
+static bool mana_service_probe_complete(struct gdma_context *gc)
+{
+	unsigned long flags;
+	bool rollback;
+
+	spin_lock_irqsave(&gc->serv_lock, flags);
+	gc->serv_probe_done = true;
+	rollback = gc->serv_during_probe;
+	spin_unlock_irqrestore(&gc->serv_lock, flags);
+	return rollback;
+}
+
 /* Return the CPU address of byte @offset within a queue's ring buffer. */
 static void *mana_gd_ring_ptr(const struct gdma_queue *q, u32 offset)
 {
@@ -956,18 +1102,7 @@ static void mana_gd_process_eqe(struct gdma_queue *eq)
 	case GDMA_EQE_HWC_FPGA_RECONFIG:
 	case GDMA_EQE_HWC_RESET_REQUEST:
 		dev_info(gc->dev, "Recv MANA service type:%d\n", type);
-
-		if (!test_and_set_bit(GC_PROBE_SUCCEEDED, &gc->flags)) {
-			/*
-			 * Device is in probe and we received a hardware reset
-			 * event, the probe function will detect that the flag
-			 * has changed and perform service procedure.
-			 */
-			dev_info(gc->dev,
-				 "Service is to be processed in probe\n");
-			break;
-		}
-		mana_schedule_serv_work(gc, type);
+		mana_service_event(gc, type);
 		break;
 
 	default:
@@ -2502,6 +2637,7 @@ static int mana_gd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	void __iomem *bar0_va;
 	int bar = 0;
 	int err;
+	bool rollback;
 
 	/* Each port has 2 CQs, each CQ has at most 1 EQE at a time */
 	BUILD_BUG_ON(2 * MAX_PORTS_IN_MANA_DEV * GDMA_EQE_SIZE > EQ_SIZE);
@@ -2532,6 +2668,9 @@ static int mana_gd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	mutex_init(&gc->eq_test_event_mutex);
 	mutex_init(&gc->gic_mutex);
+	INIT_WORK(&gc->serv_work, mana_serv_func);
+	spin_lock_init(&gc->serv_lock);
+	init_waitqueue_head(&gc->serv_waitq);
 	pci_set_drvdata(pdev, gc);
 	gc->bar0_pa = pci_resource_start(pdev, 0);
 	gc->bar0_size = pci_resource_len(pdev, 0);
@@ -2558,22 +2697,26 @@ static int mana_gd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	err = mana_rdma_probe(&gc->mana_ib);
 	if (err)
-		goto cleanup_mana;
+		goto service_quiesce;
 
 	/*
 	 * If a hardware reset event has occurred over HWC during probe,
 	 * rollback and perform hardware reset procedure.
 	 */
-	if (test_and_set_bit(GC_PROBE_SUCCEEDED, &gc->flags)) {
+	rollback = mana_service_probe_complete(gc);
+	if (rollback) {
 		err = -EPROTO;
-		goto cleanup_mana_rdma;
+		goto service_quiesce;
 	}
 
 	return 0;
 
-cleanup_mana_rdma:
+service_quiesce:
+	/* The stats work can admit service once mana_probe() has run:
+	 * retire an in-flight cycle before any teardown.
+	 */
+	mana_service_quiesce(gc);
 	mana_rdma_remove(&gc->mana_ib);
-cleanup_mana:
 	mana_remove(&gc->mana, false);
 cleanup_gd:
 	mana_gd_cleanup_device(pdev);
@@ -2581,6 +2724,8 @@ unmap_bar:
 	xa_destroy(&gc->irq_contexts);
 	pci_iounmap(pdev, bar0_va);
 free_gc:
+	/* Backstop: drain before every vfree(). */
+	mana_service_quiesce(gc);
 	pci_set_drvdata(pdev, NULL);
 	vfree(gc);
 release_region:
@@ -2624,6 +2769,9 @@ static void mana_gd_remove(struct pci_dev *pdev)
 {
 	struct gdma_context *gc = pci_get_drvdata(pdev);
 
+	/* Drain the only gc user remove() does not synchronise with. */
+	mana_service_quiesce(gc);
+
 	pci_disable_sriov(pdev);
 
 	mana_rdma_remove(&gc->mana_ib);
@@ -2635,6 +2783,8 @@ static void mana_gd_remove(struct pci_dev *pdev)
 
 	pci_iounmap(pdev, gc->bar0_va);
 
+	/* Prevent late recovery work from using freed gc. */
+	pci_set_drvdata(pdev, NULL);
 	vfree(gc);
 
 	pci_release_regions(pdev);
@@ -2687,6 +2837,9 @@ static void mana_gd_shutdown(struct pci_dev *pdev)
 
 	dev_info(&pdev->dev, "Shutdown was called\n");
 
+	/* Shutdown tears down the same HW paths as remove(). */
+	mana_service_quiesce(gc);
+
 	mana_rdma_remove(&gc->mana_ib);
 	mana_remove(&gc->mana, true);
 
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 591fb41..0eb23ae 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -924,8 +924,8 @@ static void mana_tx_timeout(struct net_device *netdev, unsigned int txqueue)
 		return;
 	}
 
-	/* Already in service, hence tx queue reset is not required.*/
-	if (test_bit(GC_IN_SERVICE, &gc->flags))
+	/* Skip while a service cycle may still touch gc. */
+	if (mana_service_active(gc))
 		return;
 
 	/* Note: If there are pending queue reset work for this port(apc),
@@ -4060,10 +4060,13 @@ static void mana_gf_stats_work_handler(struct work_struct *work)
 		memset(&ac->hc_stats, 0, sizeof(ac->hc_stats));
 		dev_warn(gc->dev,
 			 "Gf stats wk handler: gf stats query timed out.\n");
-		/* As HWC timed out, indicating a faulty HW state and needs a
-		 * reset.
+		/* As HWC timed out, indicating a faulty HW state and
+		 * needs a reset.  Never admit service work before the probe
+		 * has completed: a probe that is failing unwinds netdevs and
+		 * the HWC channel itself and cannot drain a cycle.
 		 */
-		mana_schedule_serv_work(gc, GDMA_EQE_HWC_RESET_REQUEST);
+		if (mana_service_probe_done(gc))
+			mana_schedule_serv_work(gc, GDMA_EQE_HWC_RESET_REQUEST);
 		return;
 	}
 	schedule_delayed_work(&ac->gf_stats_work, MANA_GF_STATS_PERIOD);
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 308950f..850de01 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -228,12 +228,6 @@ enum gdma_page_type {
 
 #define GDMA_INVALID_DMA_REGION 0
 
-struct mana_serv_work {
-	struct work_struct serv_work;
-	struct pci_dev *pdev;
-	enum gdma_eqe_type type;
-};
-
 struct gdma_mem_info {
 	struct device *dev;
 
@@ -417,11 +411,6 @@ struct gdma_irq_context {
 	bool dyn_msix;
 };
 
-enum gdma_context_flags {
-	GC_PROBE_SUCCEEDED	= 0,
-	GC_IN_SERVICE		= 1,
-};
-
 struct gdma_context {
 	struct device		*dev;
 	struct dentry		*mana_pci_debugfs;
@@ -479,7 +468,21 @@ struct gdma_context {
 
 	struct workqueue_struct *service_wq;
 
-	unsigned long		flags;
+	/* The in-flight MANA service cycle, queued on the system workqueue:
+	 * a reset cycle destroys and re-creates @service_wq.
+	 */
+	struct work_struct	serv_work;
+	enum gdma_eqe_type	serv_type;
+
+	/* Service-cycle admission/retirement; taken irqsave (the EQ
+	 * event path is hard IRQ) and never held across a sleep.
+	 */
+	spinlock_t		serv_lock;
+	wait_queue_head_t	serv_waitq;
+	bool			serv_in_flight;
+	bool			serv_removing;
+	bool			serv_during_probe;
+	bool			serv_probe_done;
 
 	/* Protect access to GIC context */
 	struct mutex		gic_mutex;
@@ -528,6 +531,8 @@ ssize_t mana_gd_read_ring(struct gdma_queue *q, char __user *buf,
 			  size_t count, loff_t *pos);
 
 int mana_schedule_serv_work(struct gdma_context *gc, enum gdma_eqe_type type);
+bool mana_service_active(struct gdma_context *gc);
+bool mana_service_probe_done(struct gdma_context *gc);
 
 void mana_gd_ring_dim(struct gdma_queue *cq, u32 mod_usec, bool mod_usec_vld,
 		      u32 mod_comps, bool mod_comps_vld);

