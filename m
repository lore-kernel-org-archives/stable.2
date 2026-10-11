Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5B723EAAF;
	Sun, 11 Oct 2026 09:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791711782; cv=none; b=tMxd2s/JkO+VTthx+QdlgzKLiyiOYV83PuWdTk6YshekWC2l5BDnoDdlH6wykDdubQcLzJCAPoYJgPK9EEHmAG1/dYa8gbzeq/D6aPdXd9BNWg8dY/0HhjjQZJbOFNJG8TiF30JRYXMkyHPWmLLo8LKyxFXOz2G6PM3tQNtj4YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791711782; c=relaxed/simple;
	bh=cWdqPRQBdkfG4TSFZFmnSdgEmJk0Ks+sECMOuffNi6U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uKvinblpfmXyUHb0HqPEah6KOzH5JPzooQgecXVOFb6cpd1jOB2IkHYmXfH7L645uHwPrPCVPCzLVJaGYobe0gTJvq9nW+l7068rWWMEu97+/QwoE5EGzhUe9f7N20vDaiURYxPkSbx3N7UJjXjDnVvFl0btpafWcXZ+sQH+okM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OQMAbsFU; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OQMAbsFU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791711781; x=1823247781;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=cWdqPRQBdkfG4TSFZFmnSdgEmJk0Ks+sECMOuffNi6U=;
  b=OQMAbsFUJLRzEtexsuQ+yymeEw+I2AvrwNeEgkfrWnXS5BB8WmwrcSL9
   LQ3VcUoMa6tguAhsgJLfAgXO3dYuem3CnQ40hkbqC4G76Xo+kFkelHbTV
   SztMDgHtxCZpdITlbfCMyP1Og0e64N/WzjTWBrYXj1hLt81peKOVGuDT9
   EreINgi9PiHh0JazfYIngjtCZOM2bGn+Mgwt3MbCyw/3+k7wRfPdxEI6Z
   LlymEpqZOOOGANpOEUTofBqMCC9uO6/08KP3eI5pTGHj8+FSDh70p/j4J
   D3s5aQYUwrwWgzzDyQnjTzuxgV7gUCGiElo8QW8vlAlB92KlSEXdrzrtK
   A==;
X-CSE-ConnectionGUID: 8tWzvfH2Q4+iRjiLQt8dsg==
X-CSE-MsgGUID: LJ4twEfAQnaE3VdKULjFFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11931"; a="451397"
X-IronPort-AV: E=Sophos;i="6.27,151,1787036400"; 
   d="scan'208";a="451397"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2026 02:43:00 -0700
X-CSE-ConnectionGUID: xpStNBBbThODO0FBaSHIbA==
X-CSE-MsgGUID: fc4HvxIyQ+CzRSpgMZ/QWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,151,1787036400"; 
   d="scan'208";a="1116670"
Received: from sannilnx-dsk.jer.intel.com (HELO [127.0.1.1]) ([10.12.231.107])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2026 02:42:58 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
Date: Sun, 11 Oct 2026 12:42:46 +0300
Subject: [PATCH char-misc v2] mei: me: Revert "mei: me: add adler lake
 point LP DID"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-remove_adl_lp-v2-1-3da6f6f671e6@intel.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNwQqDMBBEf0X23BQ3VWN76n8UkRi3dUETSSS0S
 P69qfcyp2Fm3uwQyDMFuBU7eIoc2Nls5KkAM2n7IsFj9iBL2WCJKDwtLlKvx7mfV1GZttSVvl6
 GWkLerJ6e/D54jx/Ai4WDgS5HE4fN+c/xFPEo/IFGFFlKqbodxgaVvrPdaD4bt0CXUvoCe1OaJ
 LUAAAA=
X-Change-ID: 20261011-remove_adl_lp-4c80a4a93b52
To: Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Menachem Adin <menachem.adin@intel.com>, 
 stable@vger.kernel.org, Joe Finzel <joe@sudmix.de>, 
 Alexander Usyskin <alexander.usyskin@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791711778; l=2018;
 i=alexander.usyskin@intel.com; s=20260315; h=from:subject:message-id;
 bh=cWdqPRQBdkfG4TSFZFmnSdgEmJk0Ks+sECMOuffNi6U=;
 b=LzQcEUyceEksqX7wC7PoMj4vYAKLDtM+KxoI4QT+JprRMEZGvZdqR4MgzOdb3TYBxeFxphr62
 +3VaIV0Khu+CKB4dUKzpB6czYc9KajNk7UlePynjTGkZ/SqluRwBlqP
X-Developer-Key: i=alexander.usyskin@intel.com; a=ed25519;
 pk=X+qoF/nFCdDOV04IForWSxnkyoCAbUE10egZi6PSfcU=

This reverts commit 930c922a987a02936000f15ea62988b7a39c27f5.

This device ID does not belong to HECI and was added by mistake.

Cc: stable@vger.kernel.org
Fixes: 930c922a987a ("mei: me: add adler lake point LP DID")
Reported-by: Joe Finzel <joe@sudmix.de>
Link: https://lore.kernel.org/lkml/20261011-mei-xhci-v1-1-38c28b5f3f99@sudmix.de/
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
Changes in v2:
- fix commit wording (Greg KH)
- Link to v1: https://lore.kernel.org/r/20261011-remove_adl_lp-v1-1-177758bd617a@intel.com
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

