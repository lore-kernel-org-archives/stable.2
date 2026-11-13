Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794584458;
	b=4m8Lok2679k6BN7FIyrSjD+oE+7rze8vdyICXx8o2BcOMyNbZDeqE5V6qdwQfH6ZgRCv
	 Y5hn7kQcx1pMGe+hyV30Upw81jvSZ90gsKR7DwXWkxSV74fzRiItt++SKs8ovVD33iXZJ
	 NbLd1tEvzf4Rf3/3/91Ler6vWlMsqRZzB0QSojXYTnXKxpFC8xAPdBMVPP1wI/DG8Wr0m
	 hXOnUwi1I51GDb/OVy0e8KpVEIP1kg+xY9C28M6YqwbC92YeDS1vqTUREBRvKIOv+83aM
	 XFTs8b0xkZDtGiUt4GVuSV6j5nqYSIt5BrFXDx7ZuJqVcB3ftBWfd+oxNseUg/T6WDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584458;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=4GT8+Mmr8OYn6xUMx+uYQ3KeEz5BsFTJd3z2yKiJr1Y=;
	b=pPssrBn+Mzoxum5K4khgGO3MKPsmFaSgcRXcLDkusUfoMu1i/6eo2azygzVqODHwhYtC
	 +6MXdNUyWf1onzreWi3YaR+xbts4zdufA0yqbiiWWx3QoafJhJfJ/MZUKscW5jOqdCrd5
	 OGUbGtei5NdgMwHBOx8EZkPgLSwKggTnex1hGCRul3e2b/I8+mGE+xfE6px3TjYcJt7FN
	 hP22rVOawOryD97WguLTwoEF0U2Fd70W4rclzpACTjZWe9IdNAUpvhJaPw7x4ZNg9E9hb
	 7lf+Iz37cJc5+Qu3bE+YpSUUlgNb3a4KwLZFOomG8Y2DmPKMVFQwJYsBQsVGQKZOaZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AD3FUUY4;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DD0606A881;
	Fri, 13 Nov 2026 15:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0DD0606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AD3FUUY4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794584458; x=1826120458;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XW9+ctSAsRi1UZ6OAm7aUEQJe5hNybzu4A7OLgjs9Wk=;
  b=AD3FUUY4ynSEK0N9SnpAahM+Ge8S7QEoGS6gCusRWlmdJFpO9p9YVm6/
   SOzIvfs1NoSE/AZJxkOSR8By/Qqcgc+hCv1CiwLUxtghnXS0tveZLzKQn
   u3imIwgfca+Y/vuIOac3RziSPG2LmKNee1KoDlTdvOiHBHNxR/dQwBFGF
   6eoSl7nCTb+ceAJkImYSYqYlavkrMpAUP4pkokl720fGH4hiRgoZg/3DV
   B21IDZtnFPyCx4iWtl+CmxZ9mXDPQG7jqlTUhD9YmjRrOLmfPVN3Hvywf
   bbvp0VjUOF2rTLwmZDL8WAHAgQLUym4y0Ky2vLzaY9B99mc10HQZNM68A
   w==;
X-CSE-ConnectionGUID: AQwh4vz8RtKlCE1O9aezmQ==
X-CSE-MsgGUID: djy0H95WRA2iGMl5qqL+3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3278976"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3278976"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 07:40:57 -0800
X-CSE-ConnectionGUID: X7oXsXksRnOn5cEv9RlEUw==
X-CSE-MsgGUID: hHon+IRjTZukSp35DTGh4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="10851533"
Received: from vyassate-mobl1.gar.corp.intel.com (HELO soc-5CG42912VT.clients.intel.com) ([10.247.253.251])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 07:40:55 -0800
From: Sankara Tankala <sankara.narayana@intel.com>
To: rafael@kernel.org,
	daniel.lezcano@kernel.org
Cc: rui.zhang@intel.com,
	lukasz.luba@arm.com,
	srinivas.pandruvada@linux.intel.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sankara Tankala <sankara.narayana@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] thermal: int340x: processor_thermal: Fix Nova Lake-S PCI device ID
Date: Fri, 13 Nov 2026 21:10:01 +0530
Message-ID: <20261113154001.2081-1-sankara.narayana@intel.com>
X-Mailer: git-send-email 2.53.0.windows.2
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nova Lake-S uses the same processor thermal PCI device ID as Nova
Lake-H, 0xD703. The 0xAD03 ID added for Nova Lake-S is the Arrow
Lake-S ID (PCI_DEVICE_ID_INTEL_ARL_S_THERMAL).

The ARL-S entry comes first in the PCI ID table, so the NVL-S entry
never matched. However, proc_thermal_rfim_add() matches on the device
ID alone, so Arrow Lake-S, which has DLVR, wrongly gets the Nova Lake
DLVR register map.

Replace the separate NVL_H and NVL_S IDs with a single NVL ID, 0xD703,
and drop the 0xAD03 entries.

Fixes: af1b80b94126 ("thermal: int340x: processor_thermal: Add Nova Lake processor thermal device")
Fixes: dbd911a07f14 ("thermal: intel: int340x: Add DLVR support for Nova Lake")
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sankara Tankala <sankara.narayana@intel.com>
---
 .../intel/int340x_thermal/processor_thermal_device.h       | 3 +--
 .../intel/int340x_thermal/processor_thermal_device_pci.c   | 7 +------
 .../thermal/intel/int340x_thermal/processor_thermal_rfim.c | 3 +--
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
index b79937a386ec..87d8ff9c7173 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
@@ -27,8 +27,7 @@
 #define PCI_DEVICE_ID_INTEL_JSL_THERMAL	0x4E03
 #define PCI_DEVICE_ID_INTEL_LNLM_THERMAL	0x641D
 #define PCI_DEVICE_ID_INTEL_MTLP_THERMAL	0x7D03
-#define PCI_DEVICE_ID_INTEL_NVL_H_THERMAL	0xD703
-#define PCI_DEVICE_ID_INTEL_NVL_S_THERMAL	0xAD03
+#define PCI_DEVICE_ID_INTEL_NVL_THERMAL	0xD703
 #define PCI_DEVICE_ID_INTEL_RPL_THERMAL	0xA71D
 #define PCI_DEVICE_ID_INTEL_SKL_THERMAL	0x1903
 #define PCI_DEVICE_ID_INTEL_TGL_THERMAL	0x9A03
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index 7d6fee59ade2..f218ee247ab4 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -501,12 +501,7 @@ static const struct pci_device_id proc_thermal_pci_ids[] = {
 	  PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_WT_HINT |
 	  PROC_THERMAL_FEATURE_POWER_FLOOR | PROC_THERMAL_FEATURE_PTC |
 	  PROC_THERMAL_FEATURE_SOC_POWER_SLIDER) },
-	{ PCI_DEVICE_DATA(INTEL, NVL_H_THERMAL, PROC_THERMAL_FEATURE_RAPL |
-	  PROC_THERMAL_FEATURE_DLVR | PROC_THERMAL_FEATURE_DVFS |
-	  PROC_THERMAL_FEATURE_MSI_SUPPORT | PROC_THERMAL_FEATURE_WT_HINT |
-	  PROC_THERMAL_FEATURE_POWER_FLOOR | PROC_THERMAL_FEATURE_PTC |
-	  PROC_THERMAL_FEATURE_SOC_POWER_SLIDER) },
-	{ PCI_DEVICE_DATA(INTEL, NVL_S_THERMAL, PROC_THERMAL_FEATURE_RAPL |
+	{ PCI_DEVICE_DATA(INTEL, NVL_THERMAL, PROC_THERMAL_FEATURE_RAPL |
 	  PROC_THERMAL_FEATURE_DLVR | PROC_THERMAL_FEATURE_DVFS |
 	  PROC_THERMAL_FEATURE_MSI_SUPPORT | PROC_THERMAL_FEATURE_WT_HINT |
 	  PROC_THERMAL_FEATURE_POWER_FLOOR | PROC_THERMAL_FEATURE_PTC |
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
index 96279756177f..1832f13634d8 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
@@ -472,8 +472,7 @@ int proc_thermal_rfim_add(struct pci_dev *pdev, struct proc_thermal_device *proc
 			dlvr_mmio_regs_table = lnl_dlvr_mmio_regs;
 			dlvr_mapping = lnl_dlvr_mapping;
 			break;
-		case PCI_DEVICE_ID_INTEL_NVL_H_THERMAL:
-		case PCI_DEVICE_ID_INTEL_NVL_S_THERMAL:
+		case PCI_DEVICE_ID_INTEL_NVL_THERMAL:
 			dlvr_mmio_regs_table = nvl_dlvr_mmio_regs;
 			ddr_data_rate_reg = &nvl_ddr_data_rate_reg;
 			break;
-- 
2.43.0

