Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.187.6.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E032B542EF4;
	Tue, 29 Sep 2026 15:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.187.6.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790695216; cv=none; b=DFnmSv6sLB0M6gqb7Box0eOiClMqZq3YthYQtHCaqMxWKdcDbJevZXxlBsXa/QZdibfenfMgfiP9ydVroMk3NUoacqiIUIKJefluZSuTSPU3E6s+KUoDP16zqHrr5th4JhHeb75ZyJ9lvA9PU+Z57+q3fZ+rUsGa1vYDxPFAgP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790695216; c=relaxed/simple;
	bh=XjgSTZcB19h2+X9Ott84HHl97JmshSmY/cBH2BIlqy0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r3mS0tOrWFvobHxxH/MELPOZ7PWkyfSDru5ngqa2JmesTXr0g0ZIbW/p5i/yhEeCZ9slAW5PT9fPErDaCUOQvl5oMiQBIIQmvr80/wqr3G32FFn89gkKEPs/ZJnF/87+Pn62ONpCaHoBTF8qOfgNvnnG/wdUIwBMA9FcvY2ls/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.187.6.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wDHzy8O17tq2wJHAQ--.2427S3;
	Tue, 29 Sep 2026 23:19:42 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app3 (Coremail) with UTF8SMTPA id zS_KCgCXN6IO17tqQ88kAA--.13360S2;
	Tue, 29 Sep 2026 23:19:42 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: rafael@kernel.org
Cc: daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com,
	stable@vger.kernel.org,
	songl@zju.edu.cn,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH v2] thermal: intel: int340x: Fix potential use-after-free in proc_thermal_pci
Date: Tue, 29 Sep 2026 15:18:45 +0000
Message-Id: <20260929151845.23980-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgCXN6IO17tqQ88kAA--.13360S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?9O0/hAXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnbfYAegEspJ+qccDMUwRutsB0EcGSD8FLnu0ttyGdxLT+OZVqMkBXp0XbuT6aljoiZ/a
	gapOTp7f/pDFYyPhDoup9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoW3Jw4kXr13Jr1xGr4xGF47KFX_yoWftF1kpa
	y5WFyDCrWkGF43WwnrAr40vFs8tr40g3y3WrWfK34ftr45ArySqFyftFyUAFW8GFZ8AF1j
	yF15tr4DCF9rGFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Gb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8oCJPUUUUU==

proc_thermal_pci_remove() cancels pci_info->work before disabling the
interrupt sources that schedule it. A threshold IRQ which arrives after
the cancel but before the THRES_0 and INT_ENABLE_0 MMIO mask can
reschedule the work, which may then run after devm cleanup has freed
pci_info and dereference pci_info->tzone and proc_priv->mmio_base. The
shared IRQ is never freed in remove(), which widens the window, and the
probe error paths never cancel the work either.

Fix this by cutting off the producers before draining: mask the
threshold interrupt, remove the sysfs interfaces which can re-enable
the power floor and workload type hint notifications, disable the
secondary interrupt sources, including both workload type hint
prediction bits, free the IRQs, and only then cancel the delayed work
and unregister the thermal zone, with a final mask afterwards. The
probe error paths unwind in the same order, and partial MSI setup
failures go through the same teardown instead of freeing the requested
IRQs inside setup_msi().

The workload type hint helper removes its sysfs group before disabling
its interrupt sources and now clears both prediction bits. It is shared
with the legacy int340x driver, so the same gap is fixed there too.

This issue was found by an in-house static analysis tool.

Fixes: acd65d5d1cf4 ("thermal/drivers/int340x/processor_thermal: Add PCI MMIO based thermal driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 .../processor_thermal_device.c                | 13 +++++
 .../processor_thermal_device.h                |  1 +
 .../processor_thermal_device_pci.c            | 57 +++++++++++++++----
 .../processor_thermal_wt_hint.c               | 22 ++++---
 4 files changed, 74 insertions(+), 19 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index f80dbe2ca7e4..a8d355044972 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -335,6 +335,19 @@ void proc_thermal_remove(struct proc_thermal_device *proc_priv)
 }
 EXPORT_SYMBOL_GPL(proc_thermal_remove);
 
+/**
+ * proc_thermal_power_limits_attr_remove() - remove the "power_limits" group
+ * @dev:	Device passed to proc_thermal_add().
+ *
+ * Remove the group before the power floor interrupt source is disabled:
+ * a concurrent store to power_floor_enable could re-enable it.
+ */
+void proc_thermal_power_limits_attr_remove(struct device *dev)
+{
+	sysfs_remove_group(&dev->kobj, &power_limit_attribute_group);
+}
+EXPORT_SYMBOL_GPL(proc_thermal_power_limits_attr_remove);
+
 static int tcc_offset_save = -1;
 
 int proc_thermal_suspend(struct device *dev)
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
index b79937a386ec..918adc6d8712 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
@@ -116,6 +116,7 @@ int processor_thermal_mbox_interrupt_config(struct pci_dev *pdev, bool enable, i
 					    int time_window);
 int proc_thermal_add(struct device *dev, struct proc_thermal_device *priv);
 void proc_thermal_remove(struct proc_thermal_device *proc_priv);
+void proc_thermal_power_limits_attr_remove(struct device *dev);
 
 int proc_thermal_wt_hint_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv);
 void proc_thermal_wt_hint_remove(struct pci_dev *pdev);
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index c5131423ec9b..28c5cf53a6f5 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -302,6 +302,12 @@ static int proc_thermal_setup_msi(struct pci_dev *pdev, struct proc_thermal_pci
 	dev_info(&pdev->dev, "msi enabled:%d msix enabled:%d\n", pdev->msi_enabled,
 		 pdev->msix_enabled);
 
+	/*
+	 * Set MSI mode once the vectors are allocated, so a failure below
+	 * unwinds through the caller's masked teardown path.
+	 */
+	msi_irq = true;
+
 	for (i = 0; i < count; i++) {
 		irq =  pci_irq_vector(pdev, i);
 
@@ -309,19 +315,12 @@ static int proc_thermal_setup_msi(struct pci_dev *pdev, struct proc_thermal_pci
 						proc_thermal_irq_thread_handler,
 						0, KBUILD_MODNAME, pci_info);
 		if (ret)
-			goto err_free_msi_vectors;
+			return ret;
 
 		proc_thermal_msi_map[i] = irq;
 	}
 
-	msi_irq = true;
-
 	return 0;
-
-err_free_msi_vectors:
-	proc_thermal_free_msi(pdev, pci_info);
-
-	return ret;
 }
 
 static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
@@ -383,8 +382,12 @@ static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device_
 
 	if (use_msi) {
 		ret = proc_thermal_setup_msi(pdev, pci_info);
-		if (ret)
+		if (ret) {
+			/* Full teardown: at least one IRQ was requested. */
+			if (msi_irq)
+				goto err_free_vectors;
 			goto err_ret_tzone;
+		}
 	} else {
 		irq_flag = IRQF_SHARED;
 		irq = pdev->irq;
@@ -403,8 +406,24 @@ static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device_
 	return 0;
 
 err_free_vectors:
+	proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_THRES_0, 0);
+	proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_INT_ENABLE_0, 0);
+	if (!pci_info->no_legacy)
+		proc_thermal_power_limits_attr_remove(&pdev->dev);
+	proc_thermal_mmio_remove(pdev, proc_priv);
 	if (msi_irq)
 		proc_thermal_free_msi(pdev, pci_info);
+	else
+		devm_free_irq(&pdev->dev, pdev->irq, pci_info);
+	/* Cancel after the IRQs are freed, or the handler may reschedule it. */
+	cancel_delayed_work_sync(&pci_info->work);
+	thermal_zone_device_unregister(pci_info->tzone);
+	proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_THRES_0, 0);
+	proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_INT_ENABLE_0, 0);
+	if (!pci_info->no_legacy)
+		proc_thermal_remove(proc_priv);
+
+	return ret;
 err_ret_tzone:
 	thermal_zone_device_unregister(pci_info->tzone);
 err_del_legacy:
@@ -420,16 +439,30 @@ static void proc_thermal_pci_remove(struct pci_dev *pdev)
 	struct proc_thermal_device *proc_priv = pci_get_drvdata(pdev);
 	struct proc_thermal_pci *pci_info = proc_priv->priv_data;
 
-	cancel_delayed_work_sync(&pci_info->work);
-
 	proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_THRES_0, 0);
 	proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_INT_ENABLE_0, 0);
 
+	/* The group must go first: a store could re-enable the source. */
+	if (!pci_info->no_legacy)
+		proc_thermal_power_limits_attr_remove(&pdev->dev);
+
+	/* Secondary sources must be off before the IRQs are freed. */
+	proc_thermal_mmio_remove(pdev, pci_info->proc_priv);
+
 	if (msi_irq)
 		proc_thermal_free_msi(pdev, pci_info);
+	else
+		devm_free_irq(&pdev->dev, pdev->irq, pci_info);
+
+	/* Cancel after the IRQs are freed, or the handler may reschedule it. */
+	cancel_delayed_work_sync(&pci_info->work);
 
 	thermal_zone_device_unregister(pci_info->tzone);
-	proc_thermal_mmio_remove(pdev, pci_info->proc_priv);
+
+	/* The work function and trip updates can re-enable the interrupt. */
+	proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_THRES_0, 0);
+	proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_INT_ENABLE_0, 0);
+
 	if (!pci_info->no_legacy)
 		proc_thermal_remove(proc_priv);
 }
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_wt_hint.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_wt_hint.c
index f8c33e8e5b7a..3e70f66dae8c 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_wt_hint.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_wt_hint.c
@@ -278,17 +278,25 @@ EXPORT_SYMBOL_NS_GPL(proc_thermal_wt_hint_add, "INT340X_THERMAL");
 
 void proc_thermal_wt_hint_remove(struct pci_dev *pdev)
 {
-	mutex_lock(&wt_lock);
-	if (wt_enable)
-		processor_thermal_mbox_interrupt_config(pdev, false,
-							SOC_WT_PREDICTION_INT_ENABLE_BIT,
-							0);
-	mutex_unlock(&wt_lock);
-
+	/* Group removal waits for active stores, so remove it first. */
 	if (workload_hint_created)
 		sysfs_remove_group(&pdev->dev.kobj, &workload_hint_attribute_group);
 
 	workload_hint_created = false;
+
+	mutex_lock(&wt_lock);
+
+	/* Disable both bits: the slow prediction bit was never cleared before. */
+	processor_thermal_mbox_interrupt_config(pdev, false,
+						SOC_WT_PREDICTION_INT_ENABLE_BIT,
+						0);
+	processor_thermal_mbox_interrupt_config(pdev, false,
+						SOC_WT_SLOW_PREDICTION_INT_ENABLE_BIT,
+						0);
+	wt_enable = false;
+	wt_slow_enable = false;
+
+	mutex_unlock(&wt_lock);
 }
 EXPORT_SYMBOL_NS_GPL(proc_thermal_wt_hint_remove, "INT340X_THERMAL");
 

