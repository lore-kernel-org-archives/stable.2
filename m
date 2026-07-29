Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCC538F253
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785330445; cv=none; b=KXQZv31hthnPLkuJyCx1jSd3MBWbAW//dFZmFAYg5ZGaRuAR9zf14nnDswwW2WPuZmr27G507iTYEybzwXiiRqJYEJ3z6PP2ehAFpTKaAAgqi3oAulSSpD6Dp3Mtm1Il//+6fi5fMj98qvD8XjRaffmJBZ4VGOMB/M7Kyhlcs1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785330445; c=relaxed/simple;
	bh=y425mL8nlEU4KOMY+rRTHj4jTD78ici+6IsXs3P3S5g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JJ6pOVeWMwk+h8X0Ywi6G9BVDC+xaEf03/nDauMkzuS70WZWXa7thaScswhb3w8MVdtMf+Go0lVPMY/iJlx3Eh4LPBJGjTdsh/zFMu6i2y9cmXVkwKpQj/jGMRIkFkj2s31U1OghRjr+NvW2IIBzNiadsFfPlRryudauVbDXqys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LIFNdUPs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LIFNdUPs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768AC1F000E9;
	Wed, 29 Jul 2026 13:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785330442;
	bh=RdPADLl3CudsmkmcQ6RByUBddc7VObYUsaOV0Ij3NMA=;
	h=Subject:To:Cc:From:Date;
	b=LIFNdUPs0JQPT66KFKTg1+C+4rUEjy9x3Dj5UkbeRI/2MMrfZ3IYXl21KRwWDx0Ip
	 YgPgrNrJ4ihwwbKPYJ0anmmrijRzWphpCEYxVzNcprSsVZ8UEZdGoSSgMTwRWYRDfG
	 OPMVResi0zCx3lDGeGU6T36u+26eOmK1rGNoZlW0=
Subject: FAILED: patch "[PATCH] wifi: brcmfmac: drain bus_reset work on device removal" failed to apply to 5.10-stable tree
To: fanwu01@zju.edu.cn,arend.vanspriel@broadcom.com,johannes.berg@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:06:55 +0200
Message-ID: <2026072955-groin-goldfish-e8e0@gregkh>
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
git cherry-pick -x 43b25879f004c98defa2776bedc6ca4763c51945
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072955-groin-goldfish-e8e0@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 43b25879f004c98defa2776bedc6ca4763c51945 Mon Sep 17 00:00:00 2001
From: Fan Wu <fanwu01@zju.edu.cn>
Date: Sat, 18 Jul 2026 02:43:53 +0000
Subject: [PATCH] wifi: brcmfmac: drain bus_reset work on device removal

brcmf_fw_crashed() and the debugfs "reset" entry both schedule
drvr->bus_reset, whose callback recovers drvr through container_of()
and dereferences it.  The removal path frees drvr (brcmf_free ->
wiphy_free) without draining the work, so a bus_reset callback pending
or running during removal can outlive drvr.

Cancellation cannot live in brcmf_detach() or brcmf_free(): the work
callback reaches teardown through the bus .reset op (PCIe
brcmf_pcie_reset -> brcmf_detach; SDIO brcmf_sdio_bus_reset ->
brcmf_sdiod_remove -> brcmf_free), so cancelling there would wait for
the running work and deadlock.

Add a per-bus mutex (bus_reset_lock) and route all arming through
brcmf_bus_schedule_reset(), which under the lock skips when the bus is
marked removing.  Each bus remove entry calls
brcmf_bus_cancel_reset_work(), which under the same lock sets removing
and cancels the work.  Holding the mutex across cancel_work_sync() makes
the set-removing + drain step atomic.  Every producer reaches the arming
path from process context -- the PCIe firmware-halt notification runs in
the threaded IRQ handler (brcmf_pcie_isr_thread) and the SDIO hostmail
path runs from the data workqueue -- so the mutex is taken only in
sleepable contexts.  Where applicable the remove entry first stops the
firmware-crash producer: on PCIe mask the mailbox and synchronize_irq;
on SDIO unregister the bus interrupt and cancel the data worker, which
also reports firmware halts through brcmf_fw_crashed().  The mutex is
initialized at bus allocation.  The SDIO suspend power-off path frees
drvr through the same brcmf_sdiod_remove() and takes the same lock;
resume re-allows the work only on a successful re-probe.

Also guard brcmf_fw_crashed() against a NULL bus_if/drvr: it can fire
before brcmf_attach() wires up drvr, and it dereferences drvr
(bphy_err/brcmf_dev_coredump) before reaching the arming gate.

The bus_reset work is shared across buses, so the drain is applied to
every remove path: PCIe (the .reset op introduced by the Fixes commit),
SDIO (arms the same work through brcmf_fw_crashed()), and USB (via the
debugfs "reset" entry).  cancel_work_sync() drains a running or pending
bus_reset work item before removal frees drvr, and patch 1/2 makes the
scratch-buffer release safe when reset teardown has already released
those DMA buffers.

This patch fixes the lifetime of the bus_reset work item itself.  It does
not attempt to address the separate, pre-existing lifetime of the
asynchronous firmware completion started by the PCIe reset path.  That
callback needs its own lifetime/ownership protocol and is being tracked
separately.

This issue was found by an in-house static analysis tool.

Fixes: 4684997d9eea ("brcmfmac: reset PCIe bus on a firmware crash")
Cc: stable@vger.kernel.org
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Assisted-by: Codex:gpt-5.6
Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Link: https://patch.msgid.link/20260718024353.3147201-3-fanwu01@zju.edu.cn
Signed-off-by: Johannes Berg <johannes.berg@intel.com>

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index d24b80e492e0..ec487c6f2e38 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -1069,6 +1069,7 @@ static int brcmf_ops_sdio_probe(struct sdio_func *func,
 	bus_if = kzalloc_obj(*bus_if);
 	if (!bus_if)
 		return -ENOMEM;
+	mutex_init(&bus_if->bus_reset_lock);
 	sdiodev = kzalloc_obj(*sdiodev);
 	if (!sdiodev) {
 		kfree(bus_if);
@@ -1130,6 +1131,14 @@ static void brcmf_ops_sdio_remove(struct sdio_func *func)
 		if (func->num != 1)
 			return;
 
+		/* Drain bus_reset before the shared brcmf_sdiod_remove()
+		 * teardown, which the SDIO reset callback also reaches.  The
+		 * data worker can arm bus_reset via brcmf_fw_crashed(); cancel
+		 * it first.
+		 */
+		brcmf_sdio_cancel_datawork(sdiodev->bus);
+		brcmf_bus_cancel_reset_work(bus_if);
+
 		/* only proceed with rest of cleanup if func 1 */
 		brcmf_sdiod_remove(sdiodev);
 
@@ -1204,6 +1213,8 @@ static int brcmf_ops_sdio_suspend(struct device *dev)
 	} else {
 		/* power will be cut so remove device, probe again in resume */
 		brcmf_sdiod_intr_unregister(sdiodev);
+		brcmf_sdio_cancel_datawork(sdiodev->bus);
+		brcmf_bus_cancel_reset_work(bus_if);
 		ret = brcmf_sdiod_remove(sdiodev);
 		if (ret)
 			brcmf_err("Failed to remove device on suspend\n");
@@ -1229,6 +1240,8 @@ static int brcmf_ops_sdio_resume(struct device *dev)
 		ret = brcmf_sdiod_probe(sdiodev);
 		if (ret)
 			brcmf_err("Failed to probe device on resume\n");
+		else
+			brcmf_bus_allow_reset_work(bus_if);
 	} else {
 		if (sdiodev->wowl_enabled && sdiodev->settings->bus.sdio.oob_irq_supported)
 			disable_irq_wake(sdiodev->settings->bus.sdio.oob_irq_nr);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
index fe31051a9e11..9371c1489948 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/firmware.h>
 #include <linux/device.h>
+#include <linux/mutex.h>
 #include "debug.h"
 
 /* IDs of the 6 default common rings of msgbuf protocol */
@@ -179,6 +180,8 @@ struct brcmf_bus {
 	enum brcmf_fwvendor fwvid;
 	bool always_use_fws_queue;
 	bool wowl_supported;
+	bool removing;		/* device removal in progress; quiesce async work */
+	struct mutex bus_reset_lock;
 
 	const struct brcmf_bus_ops *ops;
 	struct brcmf_bus_msgbuf *msgbuf;
@@ -186,6 +189,9 @@ struct brcmf_bus {
 	struct list_head list;
 };
 
+void brcmf_bus_cancel_reset_work(struct brcmf_bus *bus_if);
+void brcmf_bus_allow_reset_work(struct brcmf_bus *bus_if);
+
 /*
  * callback wrappers
  */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index ec170647800d..dad6f4563d14 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -1167,6 +1167,35 @@ static int brcmf_revinfo_read(struct seq_file *s, void *data)
 	return 0;
 }
 
+/*
+ * Serialize arming from debugfs reset and brcmf_fw_crashed() against
+ * teardown.  The remove path sets ->removing and drains the work while
+ * holding bus_reset_lock, so a racing armer is either drained or skips it.
+ */
+static void brcmf_bus_schedule_reset(struct brcmf_bus *bus_if)
+{
+	mutex_lock(&bus_if->bus_reset_lock);
+	if (bus_if->drvr && bus_if->drvr->bus_reset.func && !bus_if->removing)
+		schedule_work(&bus_if->drvr->bus_reset);
+	mutex_unlock(&bus_if->bus_reset_lock);
+}
+
+void brcmf_bus_cancel_reset_work(struct brcmf_bus *bus_if)
+{
+	mutex_lock(&bus_if->bus_reset_lock);
+	bus_if->removing = true;
+	if (bus_if->drvr)
+		cancel_work_sync(&bus_if->drvr->bus_reset);
+	mutex_unlock(&bus_if->bus_reset_lock);
+}
+
+void brcmf_bus_allow_reset_work(struct brcmf_bus *bus_if)
+{
+	mutex_lock(&bus_if->bus_reset_lock);
+	bus_if->removing = false;
+	mutex_unlock(&bus_if->bus_reset_lock);
+}
+
 static void brcmf_core_bus_reset(struct work_struct *work)
 {
 	struct brcmf_pub *drvr = container_of(work, struct brcmf_pub,
@@ -1187,7 +1216,7 @@ static ssize_t bus_reset_write(struct file *file, const char __user *user_buf,
 	if (value != 1)
 		return -EINVAL;
 
-	schedule_work(&drvr->bus_reset);
+	brcmf_bus_schedule_reset(drvr->bus_if);
 
 	return count;
 }
@@ -1417,14 +1446,23 @@ void brcmf_dev_coredump(struct device *dev)
 void brcmf_fw_crashed(struct device *dev)
 {
 	struct brcmf_bus *bus_if = dev_get_drvdata(dev);
-	struct brcmf_pub *drvr = bus_if->drvr;
+	struct brcmf_pub *drvr;
+
+	/* May fire before brcmf_attach() wires up drvr, or after removal
+	 * has cleared it; guard the derefs below (and the arming gate in
+	 * brcmf_bus_schedule_reset() already checks drvr/->removing).
+	 */
+	if (!bus_if)
+		return;
+	drvr = bus_if->drvr;
+	if (!drvr)
+		return;
 
 	bphy_err(drvr, "Firmware has halted or crashed\n");
 
 	brcmf_dev_coredump(dev);
 
-	if (drvr->bus_reset.func)
-		schedule_work(&drvr->bus_reset);
+	brcmf_bus_schedule_reset(bus_if);
 }
 
 void brcmf_detach(struct device *dev)
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index 9f10b3fff9ff..55f4d7b970f2 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -2503,6 +2503,7 @@ brcmf_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		ret = -ENOMEM;
 		goto fail;
 	}
+	mutex_init(&bus->bus_reset_lock);
 	bus->msgbuf = kzalloc_obj(*bus->msgbuf);
 	if (!bus->msgbuf) {
 		ret = -ENOMEM;
@@ -2598,6 +2599,11 @@ brcmf_pcie_remove(struct pci_dev *pdev)
 	if (devinfo->ci)
 		brcmf_pcie_intr_disable(devinfo);
 
+	if (devinfo->irq_allocated)
+		synchronize_irq(pdev->irq);
+
+	brcmf_bus_cancel_reset_work(bus);
+
 	brcmf_detach(&pdev->dev);
 	brcmf_free(&pdev->dev);
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index b725c64e5b5c..9f7ed1d293a0 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -4560,6 +4560,12 @@ int brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 	return ret;
 }
 
+void brcmf_sdio_cancel_datawork(struct brcmf_sdio *bus)
+{
+	if (bus)
+		cancel_work_sync(&bus->datawork);
+}
+
 /* Detach and free everything */
 void brcmf_sdio_remove(struct brcmf_sdio *bus)
 {
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h
index 80180d5c6c87..b93d153a8963 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h
@@ -361,6 +361,7 @@ int brcmf_sdiod_remove(struct brcmf_sdio_dev *sdiodev);
 int brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev);
 void brcmf_sdio_remove(struct brcmf_sdio *bus);
 void brcmf_sdio_isr(struct brcmf_sdio *bus, bool in_isr);
+void brcmf_sdio_cancel_datawork(struct brcmf_sdio *bus);
 
 void brcmf_sdio_wd_timer(struct brcmf_sdio *bus, bool active);
 void brcmf_sdio_wowl_config(struct device *dev, bool enabled);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
index 0b52f968b907..b41949a9bdc8 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
@@ -1260,6 +1260,7 @@ static int brcmf_usb_probe_cb(struct brcmf_usbdev_info *devinfo,
 		ret = -ENOMEM;
 		goto fail;
 	}
+	mutex_init(&bus->bus_reset_lock);
 
 	bus->dev = dev;
 	bus_pub->bus = bus;
@@ -1329,6 +1330,8 @@ brcmf_usb_disconnect_cb(struct brcmf_usbdev_info *devinfo)
 		return;
 	brcmf_dbg(USB, "Enter, bus_pub %p\n", devinfo);
 
+	brcmf_bus_cancel_reset_work(devinfo->bus_pub.bus);
+
 	brcmf_detach(devinfo->dev);
 	brcmf_free(devinfo->dev);
 	kfree(devinfo->bus_pub.bus);

