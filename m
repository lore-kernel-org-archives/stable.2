Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E35358378;
	Sat,  5 Sep 2026 02:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788575932; cv=none; b=S9Ie//6aHlPkt7B77WoBCntrcsPybhHHKyCh3WQavaWlXkf/sUWMLGCvBa2SYZe4YgEJN0/YSwpiFn8WO2i/YTZxBHoxFckrz5f7eczQlX1C1VnR5dpxw5T7Y1KaS/vPNUCWIKrTK+q/FrSaJRtF149nFNCOHQIVFZVzb0WLK6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788575932; c=relaxed/simple;
	bh=dPiz1k8MShIscV7U7Ejf2SZEObGZkZZAB3U+4lvncgw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QQ47VrzdaFl9tX1im+be+1Hz6rjqCDTKPThLLEK1n2Ipk24h6dlQ3G9phgPZPGwfnaiqVtMh3Q7xFxMGvUojsD5HOPsJBCicv7CtMa1vXV324bn4JBHZq3ysVWjIAB5gSa6clb1bk8KpBNB6lqVYV36yvBk2QhKllVS71nV3Ydg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wA3FSikgJtqRt3wAA--.5526S3;
	Sat, 05 Sep 2026 10:38:30 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app3 (Coremail) with SMTP id zS_KCgCHcnehgJtq+C_xBA--.15226S2;
	Sat, 05 Sep 2026 10:38:25 +0800 (CST)
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
Subject: [PATCH net v2] net: mana: fix reset work race with device removal
Date: Sat,  5 Sep 2026 02:36:02 +0000
Message-Id: <20260905023602.425827-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgCHcnehgJtq+C_xBA--.15226S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?iYxUtQXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnZPoDCNGYdHSfuFmYJL54WNAQamieo0OhYHiuKjLXq8p5uZ2lCS+heQbNv0sWTfuRmsI
	EzhGf2FuLLnaNHu7kzVM4mgi+E1YyIsSrNptnRNP
X-Coremail-Antispam: 1Uk129KBj9fXoW3tF1xAr4kury5JF1fZF1fuFX_yoW8XF1DCo
	WfXrnxXw4rt3y5C3yktrykJFy3uFW093Z5XF48uFZrAw1UX3Wjk348Cr13Jwn8WF1rK342
	va4fXwn7uF90vwnrl-sFpf9Il3svdjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUOj7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjx
	CEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAF
	wI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0x
	vY0x0EwIxGrwACjcxG0xvY0x0EwIxGrVCF72vEw4AK0wACI402YVCY1x02628vn2kIc2xK
	xwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
	0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jbo7NUUUUU=

The reset service work is queued on the system workqueue and can
outlive mana_gd_remove(), which frees the GDMA context. It may
then dereference gc through the stale service work.

Embed the service work in gdma_context and make GC_IN_SERVICE describe
whether it may still access gc. Removal and probe unwind close new
admission with GC_REMOVING and wait for an admitted cycle to retire
before clearing drvdata and freeing gc. Service exits retire before
taking the PCI rescan/remove lock, avoiding a lock-cycle with remove.

Do not admit service work while probe is still constructing or
unwinding the device. Latch reset events seen during probe and let
the probe rollback/recovery path handle them; a boundary recheck
preserves events racing probe completion.

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

Changes since v1 (<20260805143812.220509-1-fanwu01@zju.edu.cn>,
https://lore.kernel.org/netdev/20260805143812.220509-1-fanwu01@zju.edu.cn):

- Dropped the device_lock() serialisation: holding the driver-core
  device lock across mana_gd_suspend() + msleep() + mana_gd_resume()
  blocks unbind, reboot, device PM and all PCI hotplug for up to a
  full reset cycle, and can deadlock against the
  flush_workqueue()/destroy_workqueue() of gc->service_wq.

- Replaced it with admission/drain gates: GC_REMOVING closes new
  admission and the freeing paths wait for an admitted cycle to
  retire (clear_bit_unlock/test_bit_acquire pairing) before clearing
  drvdata and calling vfree(); the failed-resume rescan no longer
  reopens admission, and mana_tx_timeout() also skips queue-reset
  work during removal.

- No longer admit service work before the probe completes (the
  reset-event handler no longer overloads GC_PROBE_SUCCEEDED with a
  mid-probe latch); the FPGA reconfig exit and the probe-failure
  recovery path are gated as well.

- Reference series for the HWC lifecycle model:
  https://lore.kernel.org/netdev/20260813174243.3044348-1-longli@microsoft.com
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 176 ++++++++++++++----
 drivers/net/ethernet/microsoft/mana/mana_en.c |  11 +-
 include/net/mana/gdma.h                       |  14 +-
 3 files changed, 150 insertions(+), 51 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index f92b2d0..eec8634 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -678,10 +678,38 @@ out:
 	pci_unlock_rescan_remove();
 }
 
-static void mana_serv_fpga(struct pci_dev *pdev)
+/* Retire one service cycle: GC_IN_SERVICE is the last state published
+ * by the work, so remove() and the probe unwind may free gc once it
+ * is clear.  Must run before the exit paths take pci_lock_rescan_remove():
+ * removal can be waiting on the bit while holding that lock.
+ */
+static void mana_service_done(struct gdma_context *gc)
+{
+	/* Pairs with test_bit_acquire() on the wait side. */
+	clear_bit_unlock(GC_IN_SERVICE, &gc->flags);
+	/* wake_up_var() requires a full barrier between the update of the
+	 * waited-on variable and the wake.
+	 */
+	smp_mb__after_atomic();
+	wake_up_var(&gc->flags);
+}
+
+/* Retire a cycle whose exit removes the device: close admission
+ * first so no new cycle can be admitted in the retire window.
+ */
+static void mana_service_done_removing(struct gdma_context *gc)
+{
+	set_bit(GC_REMOVING, &gc->flags);
+	mana_service_done(gc);
+}
+
+static void mana_serv_fpga(struct pci_dev *pdev, struct gdma_context *gc)
 {
 	struct pci_bus *bus, *parent;
 
+	if (gc)
+		mana_service_done_removing(gc);
+
 	pci_lock_rescan_remove();
 
 	bus = pdev->bus;
@@ -706,9 +734,8 @@ out:
 	pci_unlock_rescan_remove();
 }
 
-static void mana_serv_reset(struct pci_dev *pdev)
+static void mana_serv_reset(struct pci_dev *pdev, struct gdma_context *gc)
 {
-	struct gdma_context *gc = pci_get_drvdata(pdev);
 	struct hw_channel_context *hwc;
 	int ret;
 
@@ -738,6 +765,7 @@ static void mana_serv_reset(struct pci_dev *pdev)
 	if (ret == -ETIMEDOUT || ret == -EPROTO) {
 		/* Perform PCI rescan on device if we failed on HWC */
 		dev_err(&pdev->dev, "MANA service: resume failed, rescanning\n");
+		mana_service_done_removing(gc);
 		mana_serv_rescan(pdev);
 		return;
 	}
@@ -748,22 +776,25 @@ static void mana_serv_reset(struct pci_dev *pdev)
 		dev_info(&pdev->dev, "MANA reset cycle completed\n");
 
 out:
-	clear_bit(GC_IN_SERVICE, &gc->flags);
+	mana_service_done(gc);
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
+			mana_service_done(gc);
 		break;
 	}
 }
@@ -779,12 +810,26 @@ static void mana_recovery_delayed_func(struct work_struct *w)
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
 
@@ -796,48 +841,49 @@ static void mana_recovery_delayed_func(struct work_struct *w)
 
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
 
 int mana_schedule_serv_work(struct gdma_context *gc, enum gdma_eqe_type type)
 {
-	struct mana_serv_work *mns_wk;
-
 	if (test_and_set_bit(GC_IN_SERVICE, &gc->flags)) {
 		dev_info(gc->dev, "Already in service\n");
 		return -EBUSY;
 	}
 
+	/* Pairs with set_bit(GC_REMOVING) + smp_mb__after_atomic() in
+	 * mana_gd_remove(): the test_and_set_bit() above is fully ordered,
+	 * so either this read sees GC_REMOVING and the cycle aborts, or
+	 * remove() observes GC_IN_SERVICE and waits for the cycle to retire
+	 * before it frees gc.
+	 */
+	if (test_bit(GC_REMOVING, &gc->flags)) {
+		dev_info(gc->dev, "Device is being removed\n");
+		mana_service_done(gc);
+		return -EBUSY;
+	}
+
 	if (!try_module_get(THIS_MODULE)) {
 		dev_info(gc->dev, "Module is unloading\n");
-		clear_bit(GC_IN_SERVICE, &gc->flags);
+		mana_service_done(gc);
 		return -ENODEV;
 	}
 
-	mns_wk = kzalloc(sizeof(*mns_wk), GFP_ATOMIC);
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
 
@@ -957,14 +1003,20 @@ static void mana_gd_process_eqe(struct gdma_queue *eq)
 	case GDMA_EQE_HWC_RESET_REQUEST:
 		dev_info(gc->dev, "Recv MANA service type:%d\n", type);
 
-		if (!test_and_set_bit(GC_PROBE_SUCCEEDED, &gc->flags)) {
+		if (!test_bit(GC_PROBE_SUCCEEDED, &gc->flags)) {
 			/*
-			 * Device is in probe and we received a hardware reset
-			 * event, the probe function will detect that the flag
-			 * has changed and perform service procedure.
+			 * Probe not completed: latch the event and let the
+			 * probe roll back, the recovery path will rescan.
+			 * Never admit service work before probe success;
+			 * the success re-check below preserves an event
+			 * racing probe completion.
 			 */
-			dev_info(gc->dev,
-				 "Service is to be processed in probe\n");
+			if (!test_and_set_bit(GC_SERVICE_DURING_PROBE,
+					      &gc->flags))
+				dev_info(gc->dev,
+					 "Service is to be processed in probe\n");
+			else if (test_bit(GC_PROBE_SUCCEEDED, &gc->flags))
+				mana_schedule_serv_work(gc, type);
 			break;
 		}
 		mana_schedule_serv_work(gc, type);
@@ -2546,6 +2598,7 @@ static int mana_gd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	gc->bar0_va = bar0_va;
 	gc->dev = &pdev->dev;
+	INIT_WORK(&gc->serv_work, mana_serv_func);
 	xa_init(&gc->irq_contexts);
 
 	err = mana_gd_setup(pdev);
@@ -2558,19 +2611,36 @@ static int mana_gd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	err = mana_rdma_probe(&gc->mana_ib);
 	if (err)
-		goto cleanup_mana;
+		goto service_quiesce;
 
 	/*
 	 * If a hardware reset event has occurred over HWC during probe,
-	 * rollback and perform hardware reset procedure.
+	 * rollback and perform hardware reset procedure.  Storing the
+	 * success bit before the latch check pairs with the handler's
+	 * latch-then-recheck, so an event racing probe completion is
+	 * admitted rather than lost.
 	 */
-	if (test_and_set_bit(GC_PROBE_SUCCEEDED, &gc->flags)) {
+	set_bit(GC_PROBE_SUCCEEDED, &gc->flags);
+	if (test_and_set_bit(GC_SERVICE_DURING_PROBE, &gc->flags)) {
 		err = -EPROTO;
-		goto cleanup_mana_rdma;
+		goto service_quiesce;
 	}
 
 	return 0;
 
+service_quiesce:
+	/* The stats work can admit a service cycle once mana_probe()
+	 * has run: close admission and retire an in-flight cycle
+	 * before any teardown, like mana_gd_remove() does.  Earlier
+	 * failure points cannot have admitted service work.
+	 */
+	set_bit(GC_REMOVING, &gc->flags);
+	/* Pairs with the ordered test_and_set_bit(GC_IN_SERVICE) in
+	 * mana_schedule_serv_work().
+	 */
+	smp_mb__after_atomic();
+	wait_var_event(&gc->flags,
+		       !test_bit_acquire(GC_IN_SERVICE, &gc->flags));
 cleanup_mana_rdma:
 	mana_rdma_remove(&gc->mana_ib);
 cleanup_mana:
@@ -2581,6 +2651,14 @@ unmap_bar:
 	xa_destroy(&gc->irq_contexts);
 	pci_iounmap(pdev, bar0_va);
 free_gc:
+	/* Backstop: drain before every vfree(). */
+	set_bit(GC_REMOVING, &gc->flags);
+	/* Pairs with the ordered test_and_set_bit(GC_IN_SERVICE) in
+	 * mana_schedule_serv_work().
+	 */
+	smp_mb__after_atomic();
+	wait_var_event(&gc->flags,
+		       !test_bit_acquire(GC_IN_SERVICE, &gc->flags));
 	pci_set_drvdata(pdev, NULL);
 	vfree(gc);
 release_region:
@@ -2624,6 +2702,20 @@ static void mana_gd_remove(struct pci_dev *pdev)
 {
 	struct gdma_context *gc = pci_get_drvdata(pdev);
 
+	/* Close admission and retire an in-flight cycle before any
+	 * teardown: the service work is the only user of gc that
+	 * remove() does not otherwise synchronise with.  The service
+	 * exits retire before taking the PCI rescan/remove lock, so
+	 * this wait cannot deadlock against them.
+	 */
+	set_bit(GC_REMOVING, &gc->flags);
+	/* Pairs with the ordered test_and_set_bit(GC_IN_SERVICE) in
+	 * mana_schedule_serv_work().
+	 */
+	smp_mb__after_atomic();
+	wait_var_event(&gc->flags,
+		       !test_bit_acquire(GC_IN_SERVICE, &gc->flags));
+
 	pci_disable_sriov(pdev);
 
 	mana_rdma_remove(&gc->mana_ib);
@@ -2635,6 +2727,8 @@ static void mana_gd_remove(struct pci_dev *pdev)
 
 	pci_iounmap(pdev, gc->bar0_va);
 
+	/* Prevent late recovery work from using freed gc. */
+	pci_set_drvdata(pdev, NULL);
 	vfree(gc);
 
 	pci_release_regions(pdev);
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 7a1ac85..67c7e7e 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -924,8 +924,8 @@ static void mana_tx_timeout(struct net_device *netdev, unsigned int txqueue)
 		return;
 	}
 
-	/* Already in service, hence tx queue reset is not required.*/
-	if (test_bit(GC_IN_SERVICE, &gc->flags))
+	if (test_bit(GC_IN_SERVICE, &gc->flags) ||
+	    test_bit(GC_REMOVING, &gc->flags))
 		return;
 
 	/* Note: If there are pending queue reset work for this port(apc),
@@ -4056,9 +4056,12 @@ static void mana_gf_stats_work_handler(struct work_struct *work)
 		dev_warn(gc->dev,
 			 "Gf stats wk handler: gf stats query timed out.\n");
 		/* As HWC timed out, indicating a faulty HW state and needs a
-		 * reset.
+		 * reset.  Never admit service work before the probe has
+		 * completed: a probe that is failing unwinds netdevs and the
+		 * HWC channel itself and cannot drain a cycle.
 		 */
-		mana_schedule_serv_work(gc, GDMA_EQE_HWC_RESET_REQUEST);
+		if (test_bit(GC_PROBE_SUCCEEDED, &gc->flags))
+			mana_schedule_serv_work(gc, GDMA_EQE_HWC_RESET_REQUEST);
 		return;
 	}
 	schedule_delayed_work(&ac->gf_stats_work, MANA_GF_STATS_PERIOD);
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 308950f..fd4b967 100644
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
 
@@ -420,6 +414,8 @@ struct gdma_irq_context {
 enum gdma_context_flags {
 	GC_PROBE_SUCCEEDED	= 0,
 	GC_IN_SERVICE		= 1,
+	GC_REMOVING		= 2,
+	GC_SERVICE_DURING_PROBE	= 3,
 };
 
 struct gdma_context {
@@ -479,6 +475,12 @@ struct gdma_context {
 
 	struct workqueue_struct *service_wq;
 
+	/* The in-flight MANA service cycle, queued on the system workqueue:
+	 * a reset cycle destroys and re-creates @service_wq.
+	 */
+	struct work_struct	serv_work;
+	enum gdma_eqe_type	serv_type;
+
 	unsigned long		flags;
 
 	/* Protect access to GIC context */

