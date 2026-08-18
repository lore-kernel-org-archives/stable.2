Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EF52FD69D;
	Tue, 18 Aug 2026 03:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787023544; cv=none; b=crzhKMA9QsWOB0DZbGCq5+3nd4hHMqQmGVeZlSJG8BNBK39L4occ6oC79itClRSczAarasF2BDAjo1+YEiQVD6L2dTmJ3sOjHu3VuWtcD0nNQBN1acYub3hOKt40ro4UVaJypPHKqs6ANXEy5jBUy/oikVurk9iTfi35Lh63WX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787023544; c=relaxed/simple;
	bh=CvTXD3FNVrHrMkHbiCTVM3r9c0YAm4H0KcVhh5bw9lY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jbHlWzWmI/UlLMvCYMoEPAKyh3uYmQQxizigd2TckZYgRs5boLYX0w9FMNQiwv2uKMnJRO6Idl532FzpGIVJRySvtaEtBJD6VTJ3rT75qSRRdhpgpY64ZgIChhlSng0yxcJXupcK1FytuBzNfdTjQm+OhPXRepIwe4n7kfCQVCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=YgiU/JEW; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="YgiU/JEW"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4a58b43ae;
	Tue, 18 Aug 2026 11:25:33 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alex Williamson <alex@shazbot.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH v2] PCI: defer bridge cfg lock in pci_try_reset_function()
Date: Tue, 18 Aug 2026 11:25:30 +0800
Message-Id: <20260818032530.1497538-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260817141553.1338157-1-runyu.xiao@seu.edu.cn>
References: <20260817141553.1338157-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa012e7246f03a1kunme9cff1f0fd332
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZTEgfVhlCGRhNQ0NLSR5PSlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=YgiU/JEW8v0AZHMsHxKuRIDc4ejq4mJhjo8Kd02VO9pITJSBH/XDOonRZn3jR2Rc7U7CPE1s9O2Oge/ZgDp/e4/OTbFua/HugkfECsayY7QtwR+A2NuwyAWshqwvKomoSmM51tD6IlE8VcJx9Ar9euaTENcG6WQWJlKECfZo+4I=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=2xi3CSBdjBEAsPBhcxt3uIP80Jrimw511V1067fIk3A=;
	h=date:mime-version:subject:message-id:from;

pci_try_reset_function() may need upstream bridge config serialization when
__pci_reset_function_locked() falls back to the "bus" or "cxl_bus" reset
methods.  Unlike pci_reset_function(), it currently only locks the target
device, so those fallback paths can still issue an unlocked secondary-bus
reset.

A naive fix is to trylock the shared upstream bridge before locking the
target device, mirroring pci_reset_function().  But
pci_try_reset_function() is used in vfio_pci_core_enable(), which treats
-EAGAIN as a fatal open failure.  Taking the bridge trylock up front
therefore broadens -EAGAIN to all try-reset callers, including sibling
devices that would otherwise reset independently via FLR.

Keep the existing device trylock semantics, but defer bridge serialization
until __pci_reset_function_locked() is actually about to run a bus-level
reset method.  For pci_try_reset_function(), trylock only the bridge config
access needed by the bus/cxl_bus paths and return -EAGAIN only if that
serialization is really required and contended.

This preserves bridge config serialization for the secondary-bus reset
fallback without introducing spurious -EAGAIN failures for concurrent
resets of sibling devices.

Link: https://lore.kernel.org/r/20260817141553.1338157-1-runyu.xiao@seu.edu.cn
Fixes: 61cf16d8bd38 ("PCI: Add pci_try_reset_function(), pci_try_reset_slot(), pci_try_reset_bus()")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
v2:
- Rework v1 to defer bridge cfg serialization until the `bus` or `cxl_bus`
  fallback is actually selected.
- Avoid broadening `-EAGAIN` to sibling devices that can reset
  independently via FLR or other function-level methods.
- Keep the upstream bridge serialization limited to the path that actually
  needs secondary-bus reset protection.

 drivers/pci/pci.c | 75 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 52 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e128696..0aa770c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5166,28 +5166,17 @@ const struct pci_reset_fn_method pci_reset_fn_methods[] = {
 	{ cxl_reset_bus_function, .name = "cxl_bus" },
 };
 
-/**
- * __pci_reset_function_locked - reset a PCI device function while holding
- * the @dev mutex lock.
- * @dev: PCI device to reset
- *
- * Some devices allow an individual function to be reset without affecting
- * other functions in the same device.  The PCI device must be responsive
- * to PCI config space in order to use this function.
- *
- * The device function is presumed to be unused and the caller is holding
- * the device mutex lock when this function is called.
- *
- * Resetting the device will make the contents of PCI configuration space
- * random, so any caller of this must be prepared to reinitialise the
- * device including MSI, bus mastering, BARs, decoding IO and memory spaces,
- * etc.
- *
- * Returns 0 if the device function was successfully reset or negative if the
- * device doesn't support resetting a single function.
- */
-int __pci_reset_function_locked(struct pci_dev *dev)
+static bool
+pci_reset_fn_needs_bridge_cfg_access(const struct pci_reset_fn_method *method)
 {
+	return method->reset_fn == pci_reset_bus_function ||
+	       method->reset_fn == cxl_reset_bus_function;
+}
+
+static int pci_reset_function_locked_internal(struct pci_dev *dev,
+					      bool trylock_bridge_cfg)
+{
+	struct pci_dev *bridge;
 	int i, m, rc;
 	const struct pci_reset_fn_method *method;
 
@@ -5208,7 +5197,21 @@ int __pci_reset_function_locked(struct pci_dev *dev)
 
 		method = &pci_reset_fn_methods[m];
 		pci_dbg(dev, "reset via %s\n", method->name);
+
+		bridge = NULL;
+		if (trylock_bridge_cfg &&
+		    pci_reset_fn_needs_bridge_cfg_access(method)) {
+			bridge = pci_upstream_bridge(dev);
+			if (bridge && !pci_cfg_access_trylock(bridge)) {
+				rc = -EAGAIN;
+				goto done;
+			}
+		}
+
 		rc = method->reset_fn(dev, PCI_RESET_DO_RESET);
+		if (bridge)
+			pci_cfg_access_unlock(bridge);
+done:
 		if (!rc)
 			return 0;
 
@@ -5219,6 +5222,31 @@ int __pci_reset_function_locked(struct pci_dev *dev)
 
 	return -ENOTTY;
 }
+
+/**
+ * __pci_reset_function_locked - reset a PCI device function while holding
+ * the @dev mutex lock.
+ * @dev: PCI device to reset
+ *
+ * Some devices allow an individual function to be reset without affecting
+ * other functions in the same device.  The PCI device must be responsive
+ * to PCI config space in order to use this function.
+ *
+ * The device function is presumed to be unused and the caller is holding
+ * the device mutex lock when this function is called.
+ *
+ * Resetting the device will make the contents of PCI configuration space
+ * random, so any caller of this must be prepared to reinitialise the
+ * device including MSI, bus mastering, BARs, decoding IO and memory spaces,
+ * etc.
+ *
+ * Returns 0 if the device function was successfully reset or negative if the
+ * device doesn't support resetting a single function.
+ */
+int __pci_reset_function_locked(struct pci_dev *dev)
+{
+	return pci_reset_function_locked_internal(dev, false);
+}
 EXPORT_SYMBOL_GPL(__pci_reset_function_locked);
 
 /**
@@ -5338,7 +5366,8 @@ EXPORT_SYMBOL_GPL(pci_reset_function_locked);
  * pci_try_reset_function - quiesce and reset a PCI device function
  * @dev: PCI device to reset
  *
- * Same as above, except return -EAGAIN if unable to lock device.
+ * Same as above, except return -EAGAIN if unable to lock device or the
+ * upstream bridge config access needed for a bus-level reset fallback.
  */
 int pci_try_reset_function(struct pci_dev *dev)
 {
@@ -5351,7 +5380,7 @@ int pci_try_reset_function(struct pci_dev *dev)
 		return -EAGAIN;
 
 	pci_dev_save_and_disable(dev);
-	rc = __pci_reset_function_locked(dev);
+	rc = pci_reset_function_locked_internal(dev, true);
 	pci_dev_restore(dev);
 	pci_dev_unlock(dev);
 
-- 
2.34.1
