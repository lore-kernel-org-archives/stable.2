Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F6E4AB3CC;
	Thu, 15 Oct 2026 08:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792051301; cv=none; b=FK1yKFZ7IbuF2imBerdZ5W9EIwc6PVkl9aavwvahmMeVZSjfwPR4/GAvoX30RfJE0rLm2Bem13vb9PzY0bWdf4LcWyLmssXi+InSar6zPIl6/rd3iuzwO8kNKJNtqTB4hB0p3LAk9XQ4LAU1pxaWIJ8STJFOnb/l1A+LqXfwiF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792051301; c=relaxed/simple;
	bh=TMBAise+eet+ZBmb0cxVaSMYfYf4z593ofd0AGvPruk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZsXpXWRdS0J++ebTWNdQ3uGTA43jVr6ryNvW/EbVPvGBis0iF+lFZI/PvoMM9jaG1bgzXIrZ84zEAMfzso4QoP8KRF8g0zB8bWT2Lreja9QgYK3fKvCf1IKLwuLRnua7TNr6jzbXgzhQMaXJf6mXnmgW7ECQqWHHXH/JEGStUeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bYz4gy4y; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bYz4gy4y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792051300; x=1823587300;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TMBAise+eet+ZBmb0cxVaSMYfYf4z593ofd0AGvPruk=;
  b=bYz4gy4y7F4AWvYZANxsl+/9+y+YhUCJTVOkYEgnYZ36anNqD5tU1gbD
   n3ARJTcvZVrqaRNHpmVbLmWzmYBNcYxq75tP7UVyuBiQLIYvwnWelZgco
   Em/QyjM2+rO0YnG+4qZ7Ya4qHpfoyh19hECF+QZRmK9Njik7tAsQMDGtU
   JNPwdf5prv1n1rfXLVwJmTyDEQY+CmOT/gtJMLsOiWakjUi/5wga3+SkQ
   Y/W+CBFg/bTJjQI2whNKVTaFuaJJbKPr7QUmBLHa5P5tGVNFlwq7QLow2
   rV9B26YjUBvS4edWZIvPHRlUVNFak4PK9W3x9rFBbDi7QG2YPGuuHjh3y
   Q==;
X-CSE-ConnectionGUID: NfiTUb7zSpiUK+1+SqhvFA==
X-CSE-MsgGUID: Pwhx30+XRgilrpUkdcyBGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="916096"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="916096"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 01:01:39 -0700
X-CSE-ConnectionGUID: gCHsrrWORraAVLo4TzRKtA==
X-CSE-MsgGUID: H7au3/f+Sl65Wny6eb7b/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="3465336"
Received: from unknown (HELO WEBA2062.iind.intel.com) ([10.66.228.2])
  by fmviesa011.fm.intel.com with ESMTP; 15 Oct 2026 01:01:37 -0700
From: Ravindra <ravindra@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	stable@vger.kernel.org,
	chethan.tumkur.narayan@intel.com,
	Ravindra <ravindra@intel.com>
Subject: [PATCH v2] Bluetooth: btintel_pcie: Use blocking reset for FLR
Date: Thu, 15 Oct 2026 13:34:30 +0530
Message-ID: <20261015080430.3336201-1-ravindra@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several paths request an FLR asynchronously, including S3/S4 resume,
resume recovery, HCI reset, and hardware-error recovery. A queued reset
may run before the PM callback releases the PCI device lock, causing
pci_try_reset_function() to return -EAGAIN without attempting the FLR.

Use pci_reset_function() so reset work waits for the device lock and
performs the FLR once the PM callback releases it. If the reset fails,
clear the recovery in-progress flag so a later reset request can try
again.

Fixes: 9c36951474d8 ("Bluetooth: btintel_pcie: Refactor FLR to use device_reprobe()")
Signed-off-by: Ravindra <ravindra@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 3a555aa50c87..92b91f058fce 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -3745,13 +3745,10 @@ static int btintel_pcie_perform_flr(struct btintel_pcie_data *data)
 	struct pci_dev *pdev = data->pdev;
 	int err;
 
-	/* pci_try_reset_function() avoids the device_lock ABBA against
-	 * btintel_pcie_remove(): .remove() runs with device_lock held and
-	 * then waits for this work via disable_work_sync(); the blocking
-	 * pci_reset_function() would deadlock by trying to re-acquire
-	 * device_lock here.
+	/* Reset work runs asynchronously, so it can wait for the device lock
+	 * held by a PM callback to be released.
 	 */
-	err = pci_try_reset_function(pdev);
+	err = pci_reset_function(pdev);
 	if (err) {
 		BT_ERR("Failed resetting the pcie device (%d)", err);
 		return err;
@@ -3817,6 +3814,7 @@ static void btintel_pcie_reset_work(struct work_struct *wk)
 		enable_work(&data->hwexp_work);
 		enable_work(&data->fwtrigger_work);
 		enable_work(&data->mbox_work);
+		clear_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &data->flags);
 	}
 
 out:
@@ -3841,10 +3839,9 @@ static void btintel_pcie_reset_work(struct work_struct *wk)
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

