Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA8F361961;
	Mon, 12 Oct 2026 09:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791796650; cv=none; b=qIFOgJi6rY8YfBl2n2oXzNevVGrXkCgZOfDV7aNaYdqVigriBdsYhLCjtjFmsPp+SRc/bwqh5BlDRkQBJmDzoBs04xeMngRBdrdylv2/cGX1RY6xJODVaid0LKSJm1Pzj0asfDj92VfLZLKXRXKEHW8QHALTchpJMW7WT8dafUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791796650; c=relaxed/simple;
	bh=JZfaV6Skd9noWQaft/SPWX8ibTsCB1DjJC1fy1PM21Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uC+TLKOoMxkPU9r+rN6gZXDgoW4LHRs1eCr27Kd0u4Rl2hb3+OwXF+mSg2HVCc8mO4nJbuYDAXnAsZ+PbPeli8r0XRiRA5CYdMKrv1hBsA2VQSSRylMZt7ZoadEwZx5XyqHsPVG7zJFtAiH+P6jpLTttIxUQ9beXn0eMieLclIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gafx0wjV; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gafx0wjV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791796649; x=1823332649;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JZfaV6Skd9noWQaft/SPWX8ibTsCB1DjJC1fy1PM21Q=;
  b=gafx0wjVYtH2ApV+lagHVZ/at5Cj5Y/6babxVjfR+Em9RNwsCjJpKunM
   0K80lTrG86q9+g+um0OGpEg+7k/dDSfG8lSMrNAy5006skn4a9P1c/4Tx
   Z2Ul2cU1jYqpz3Uyyq8MQnhmmR3TfwoRvBoLHRtzmcOd1+SWRFIX8+Vwt
   QlXUk+r08bmIzUmbICANcgx2Oy3Y6zg9SiTZNjLSu2246wol4Mjok0v6l
   LtnSxlI5Scg6vBnrMOkRF7TAEhz1v5ZjflT1KI+1tm6ynxefpk+pQPBW2
   8oDmsNpxmck+eebebK0DtVT2so82x7pHBu/O1EBtNmdrDFhaWCAKsl0aX
   A==;
X-CSE-ConnectionGUID: C35jKtq8Q4mTxzlnvWh2kw==
X-CSE-MsgGUID: sYb5/KxEQvuqSLJxJQCEqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="489526"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="489526"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 02:17:29 -0700
X-CSE-ConnectionGUID: TP8ESo+JSSySafOfxY2MVg==
X-CSE-MsgGUID: kVtISodZSnqz0LgNGf5J6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="2645055"
Received: from unknown (HELO WEBA2062.iind.intel.com) ([10.66.228.2])
  by fmviesa012.fm.intel.com with ESMTP; 12 Oct 2026 02:17:26 -0700
From: Ravindra <ravindra@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	stable@vger.kernel.org,
	chethan.tumkur.narayan@intel.com,
	Ravindra <ravindra@intel.com>
Subject: [PATCH v1] Bluetooth: btintel_pcie: Retry FLR on device lock contention
Date: Mon, 12 Oct 2026 14:50:17 +0530
Message-ID: <20261012092017.3275428-1-ravindra@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several paths request an FLR asynchronously, including S3/S4 resume,
resume recovery, HCI reset, and hardware-error recovery. When a request
comes from a PM callback, reset work may run before the PM core releases
the PCI device lock. pci_try_reset_function() then returns -EAGAIN
without attempting the FLR. Other FLR requests can encounter the same
error if another operation holds the device lock.

Retry the FLR on -EAGAIN. If all attempts fail, clear the recovery
in-progress flag so a later reset request can try again.

Fixes: 9c36951474d8 ("Bluetooth: btintel_pcie: Refactor FLR to use device_reprobe()")
Signed-off-by: Ravindra <ravindra@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 3a555aa50c87..251dd4e2ceb4 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -3743,7 +3743,7 @@ static void btintel_pcie_perform_pldr(struct btintel_pcie_data *data)
 static int btintel_pcie_perform_flr(struct btintel_pcie_data *data)
 {
 	struct pci_dev *pdev = data->pdev;
-	int err;
+	int err, retry;
 
 	/* pci_try_reset_function() avoids the device_lock ABBA against
 	 * btintel_pcie_remove(): .remove() runs with device_lock held and
@@ -3751,7 +3751,16 @@ static int btintel_pcie_perform_flr(struct btintel_pcie_data *data)
 	 * pci_reset_function() would deadlock by trying to re-acquire
 	 * device_lock here.
 	 */
-	err = pci_try_reset_function(pdev);
+	/* PM callbacks hold the device lock, so the queued resume reset may
+	 * run before the callback releases it. Retry after that lock is dropped.
+	 */
+	for (retry = 0; retry < 3; retry++) {
+		err = pci_try_reset_function(pdev);
+		if (err != -EAGAIN)
+			break;
+
+		usleep_range(1000, 2000);
+	}
 	if (err) {
 		BT_ERR("Failed resetting the pcie device (%d)", err);
 		return err;
@@ -3817,6 +3826,7 @@ static void btintel_pcie_reset_work(struct work_struct *wk)
 		enable_work(&data->hwexp_work);
 		enable_work(&data->fwtrigger_work);
 		enable_work(&data->mbox_work);
+		clear_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &data->flags);
 	}
 
 out:
@@ -3841,10 +3851,9 @@ static void btintel_pcie_reset_work(struct work_struct *wk)
  *     in-flight one (whose recovery will reinitialize the device
  *     regardless of the dropped trigger's variant).
  *
- * The bit is cleared only by .remove() / re-probe via fresh devm
- * allocation, which is the intended one-shot semantics: a reset
- * tears down and re-probes 'data', so there is no "in-flight"
- * reset to follow up after device_reprobe() succeeds.
+ * A successful reset clears the bit through .remove() / re-probe via
+ * fresh devm allocation. A failed FLR clears it in reset_work so a
+ * later request can retry; there is no in-flight reset after failure.
  */
 static void btintel_pcie_request_reset(struct btintel_pcie_data *data,
 				       enum btintel_pcie_reset_type type)
-- 
2.43.0

