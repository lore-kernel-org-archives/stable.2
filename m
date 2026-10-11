Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC3E279DB1;
	Sun, 11 Oct 2026 06:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791700176; cv=none; b=SEGeL+l2JfzBKrCTWik2x5M+daSEONwL5CwenihndzI/bsfC6Gcant0+Zp3URSZauUXYR7on6xMUmv39+2dodOmCkFPozBivIOYauN5rvX2iMSjk4n5mr3thXVqfO2oOAxzc/FO0wbnzEEaq5B05W/nXrTozCzNR9sHyO8hReyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791700176; c=relaxed/simple;
	bh=5vIidctZnEl3wtC1ByGQXHy1mdzwb3LTyG2mTj3tD9o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dSkjsiWsdpZRjmtVXbcMBqwQMJzCoFaEwZNx5DGhcLbl9wMRWIQCrJV+QPNBl4qA23yENhcbb5tOUxLoPd2UMmSHjhNX90RvVxsdZXwc5kD7ib65WPoT2QvIiRbIgVhDhxZAflbpv9/xXApgceDH2uXEgbidq0nAQYGgm5egvBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iEt2dtF/; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iEt2dtF/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791700174; x=1823236174;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=5vIidctZnEl3wtC1ByGQXHy1mdzwb3LTyG2mTj3tD9o=;
  b=iEt2dtF/pJI34Rt+pwme3mlZEe0RcagPleepsfGmBi5SWLDQHXTk23+G
   Ojgfyg6q+GcbT1mfxo/9Z4vqNuOognW9TqH1TMEwzfFhhqxUTXkCrtjcX
   VE3SF6PaEhZemmdOHB2io22NPnzMmSNoGfJt9GF3c2Zh7ArtwaOfIJ+m7
   JTHQmP3cvddppVdZpSoUIhmWiPVR6mhNQUAvgKbsUsnPNV4UQAWrP4VU8
   eudD06yq8C5V042IkPOZsy94j04SWLe6CyWYezUm1gU+vB8EbBfyXWe+G
   ic2jc/xPyZW3Cs70qdvmWGBZ3mijzNQ9Lf/S23VEv0VORIw6hG3WD2k8d
   g==;
X-CSE-ConnectionGUID: mLIV23CiTGOvZ6HIKIZcaQ==
X-CSE-MsgGUID: ALR71y1bQkC5/I2RHXu1KA==
X-IronPort-AV: E=McAfee;i="6800,10657,11931"; a="345102"
X-IronPort-AV: E=Sophos;i="6.27,151,1787036400"; 
   d="scan'208";a="345102"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2026 23:29:34 -0700
X-CSE-ConnectionGUID: NNOQdw+8RISKV3TLrOk61g==
X-CSE-MsgGUID: Qk7azwCBTgOg+xDwubfXWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,151,1787036400"; 
   d="scan'208";a="760412"
Received: from sannilnx-dsk.jer.intel.com (HELO [127.0.1.1]) ([10.12.231.107])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2026 23:29:32 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
Date: Sun, 11 Oct 2026 09:29:12 +0300
Subject: [PATCH char-misc] mei: me: Revert "mei: me: add adler lake point
 LP DID"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-remove_adl_lp-v1-1-177758bd617a@intel.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQqAIBBA4avErBPULKqrRITZVAP9MYIE0t2zl
 t/ivQgemdBDm0VgDOTpPBJUnoFb7bGgoCkZtNSVkkoJxv0MONhpG7ZLGFdLa2xTjKWG1FyMM93
 /r/sGLHbyDvrneQGd119wagAAAA==
X-Change-ID: 20261011-remove_adl_lp-4c80a4a93b52
To: Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Menachem Adin <menachem.adin@intel.com>, 
 stable@vger.kernel.org, Joe Finzel <joe@sudmix.de>, 
 Alexander Usyskin <alexander.usyskin@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791700171; l=1868;
 i=alexander.usyskin@intel.com; s=20260315; h=from:subject:message-id;
 bh=5vIidctZnEl3wtC1ByGQXHy1mdzwb3LTyG2mTj3tD9o=;
 b=Da4Hve3Q/B/MUDn+HuPCtCMYEY/0UudNoqPQ+zAox4gQGbg6sSuThkcRH9nE39al3iuJ563SD
 g2D14NghJ1pAPRy8TrUXV/RisDTAfk2vQeoXpEJgtNozPYHns1jlDHM
X-Developer-Key: i=alexander.usyskin@intel.com; a=ed25519;
 pk=X+qoF/nFCdDOV04IForWSxnkyoCAbUE10egZi6PSfcU=

This reverts commit 930c922a987a02936000f15ea62988b7a39c27f5.

This device ID is not belongs to HECI and added by mistake.

Cc: stable@vger.kernel.org
Fixes: 930c922a987a ("mei: me: add adler lake point LP DID")
Reported-by: Joe Finzel <joe@sudmix.de>
Link: https://lore.kernel.org/lkml/20261011-mei-xhci-v1-1-38c28b5f3f99@sudmix.de/
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/misc/mei/hw-me-regs.h | 1 -
 drivers/misc/mei/pci-me.c     | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/misc/mei/hw-me-regs.h b/drivers/misc/mei/hw-me-regs.h
index b9a67629496b..35af82ad1713 100644
--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
@@ -107,7 +107,6 @@
 #define PCI_DEVICE_ID_INTEL_MEI_EBG        0x1BE0  /* Emmitsburg WS */
 
 #define PCI_DEVICE_ID_INTEL_MEI_ADP_S      0x7AE8  /* Alder Lake Point S */
-#define PCI_DEVICE_ID_INTEL_MEI_ADP_LP     0x7A60  /* Alder Lake Point LP */
 #define PCI_DEVICE_ID_INTEL_MEI_ADP_P      0x51E0  /* Alder Lake Point P */
 #define PCI_DEVICE_ID_INTEL_MEI_ADP_N      0x54E0  /* Alder Lake Point N */
 
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index 790a4647811b..a25f2ed5db0c 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -113,7 +113,6 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
 	{ PCI_DEVICE_DATA(INTEL, MEI_EBG, MEI_ME_PCH15_SPS_CFG) },
 
 	{ PCI_DEVICE_DATA(INTEL, MEI_ADP_S, MEI_ME_PCH15_CFG) },
-	{ PCI_DEVICE_DATA(INTEL, MEI_ADP_LP, MEI_ME_PCH15_CFG) },
 	{ PCI_DEVICE_DATA(INTEL, MEI_ADP_P, MEI_ME_PCH15_CFG) },
 	{ PCI_DEVICE_DATA(INTEL, MEI_ADP_N, MEI_ME_PCH15_CFG) },
 

---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20261011-remove_adl_lp-4c80a4a93b52

Best regards,
-- 
Alexander Usyskin <alexander.usyskin@intel.com>

