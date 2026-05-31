Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EAE30C366;
	Sun, 31 May 2026 10:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780223439; cv=none; b=fcmety9asiZDsr/oSOLZDjIGdEMMdVnvYaKEcSkNGl+czVcmEdukgudyqAQPWn5V41FbQlFaSIbUl14W9Q/YkkTSigrt9X07uDFVl2fUpVHiX2XdfzTdIE+wZ+6aexoN27rSxIjYhmKzXy6Rq7irrpRcvCRuhZX/40jRBe+Gau4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780223439; c=relaxed/simple;
	bh=lakZVG7g5kCet7VQLT5a6WdgbIee6d7zDrhOBHgTWzc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gbBTbgoU2MjhqhzncuwjWC4hBjU27tifk/LP+SzXkmtW0EF48MH8OcTGNk25u8E+oSPPelV2PijnXW6yrbInI6kPnJW2PPpc5HNmCTfvC8HoCpZIVz+N87KgEkm8mGKFqn6/vguHE3cC21cs59g5eRd/gCdn0H8yX5yCStkzb9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DgT64fyr; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DgT64fyr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780223434; x=1811759434;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lakZVG7g5kCet7VQLT5a6WdgbIee6d7zDrhOBHgTWzc=;
  b=DgT64fyr4IVZrE00PPWo+4fhl5xN5LLt2m6VL69es3kp/Y4xcP194k3H
   Q/L2iTvzo0VgMuqLRJxCdowWDus1qzZ72uUyq2nn9fxyvb7uDd1wNqMKg
   UoS/dR/bljkKR6X/DCXmOk6M6iJH8U+oN8QB3CBf2rRQA6RvJyubwEsmf
   1kVbyiDXR5OIZ3Jxm090B4ItEhSWC2rL0zZV2I2ONUNx4RAImXdjStp/W
   MDkVbaxW0qWCHL7vvqbThdUYmiNPpL0ffRZWacJjhfB7gIs77ErExHeZR
   jZorIaXrMLJHpu7zOTf0vnwuzm8B7Zjk1plz0IUcEVTHKosD4Ts9NSd3c
   g==;
X-CSE-ConnectionGUID: lNag5tOwRh+oxOXZz6S+9Q==
X-CSE-MsgGUID: mod0W57aSr6g4TPKTmWvfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11802"; a="80148212"
X-IronPort-AV: E=Sophos;i="6.24,179,1774335600"; 
   d="scan'208";a="80148212"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 03:30:34 -0700
X-CSE-ConnectionGUID: 0F5G0Mw5RueR5pkgXtT4JQ==
X-CSE-MsgGUID: EecgkeFYRFmz2zGnrLp9aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,179,1774335600"; 
   d="scan'208";a="245118257"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 03:30:34 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH wireless-fixes] wifi: iwlwifi: pcie: simplify the resume flow if fast resume is not used
Date: Sun, 31 May 2026 13:30:19 +0300
Message-Id: <20260531133005.e2ed9e0cd44f.If283625983a843933e0c01561a421daff184e9e9@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

In most distributions, NetworkManager shuts the device down before
entering system suspend, so fast suspend is typically not used.

On older devices, resume currently tries to grab NIC access to infer
whether the device was powered off while suspended. That probe is only
meaningful for the fast-suspend path where the device is expected to
remain alive.

Unfortunately, for unclear reasons, grabbing NIC access was harmful as
reported in the bugzilla ticket below.

Workaround this issue by simply not grabbing NIC access if fast suspend
is not used.

Fixes: 6a0f81c549a0 ("wifi: iwlwifi: fix merge damage related to iwl_pci_resume")
Cc: stable@vger.kernel.org
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221501
Assisted-by: GitHub Copilot:gpt-5.3-codex
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 56 +++++++++++--------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index dc99e7ac4726..eb3c5a6dd088 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1225,33 +1225,41 @@ static int _iwl_pci_resume(struct device *device, bool restore)
 	if (!trans->op_mode)
 		return 0;
 
-	/*
-	 * Scratch value was altered, this means the device was powered off, we
-	 * need to reset it completely.
-	 * Note: MAC (bits 0:7) will be cleared upon suspend even with wowlan,
-	 * but not bits [15:8]. So if we have bits set in lower word, assume
-	 * the device is alive.
-	 * Alternatively, if the scratch value is 0xFFFFFFFF, then we no longer
-	 * have access to the device and consider it powered off.
-	 * For older devices, just try silently to grab the NIC.
-	 */
-	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
-		u32 scratch = iwl_read32(trans, CSR_FUNC_SCRATCH);
-
-		if (!(scratch & CSR_FUNC_SCRATCH_POWER_OFF_MASK) ||
-		    scratch == ~0U)
-			device_was_powered_off = true;
-	} else {
+	if (test_bit(STATUS_DEVICE_ENABLED, &trans->status)) {
 		/*
-		 * bh are re-enabled by iwl_trans_pcie_release_nic_access,
-		 * so re-enable them if _iwl_trans_pcie_grab_nic_access fails.
+		 * Scratch value was altered, this means the device was powered
+		 * off, we need to reset it completely.
+		 * Note: MAC (bits 0:7) will be cleared upon suspend even with
+		 * wowlan, but not bits [15:8]. So if we have bits set in lower
+		 * word, assume the device is alive.
+		 * Alternatively, if the scratch value is 0xFFFFFFFF, then we
+		 * no longer have access to the device and consider it powered
+		 * off.
+		 * For older devices, just try silently to grab the NIC.
 		 */
-		local_bh_disable();
-		if (_iwl_trans_pcie_grab_nic_access(trans, true)) {
-			iwl_trans_pcie_release_nic_access(trans);
+		if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
+			u32 scratch = iwl_read32(trans, CSR_FUNC_SCRATCH);
+
+			if (!(scratch & CSR_FUNC_SCRATCH_POWER_OFF_MASK) ||
+			    scratch == ~0U) {
+				IWL_DEBUG_WOWLAN(trans,
+						 "Scratch 0x%08x indicates device was powered off\n",
+						 scratch);
+				device_was_powered_off = true;
+			}
 		} else {
-			device_was_powered_off = true;
-			local_bh_enable();
+			/*
+			 * bh are re-enabled by iwl_trans_pcie_release_nic_access,
+			 * so re-enable them if _iwl_trans_pcie_grab_nic_access
+			 * fails.
+			 */
+			local_bh_disable();
+			if (_iwl_trans_pcie_grab_nic_access(trans, true)) {
+				iwl_trans_pcie_release_nic_access(trans);
+			} else {
+				device_was_powered_off = true;
+				local_bh_enable();
+			}
 		}
 	}
 
-- 
2.34.1

