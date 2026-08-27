Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D425450F2;
	Thu, 27 Aug 2026 05:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787807543; cv=none; b=ufgu49u+qwDH3adUXh2QZ6/jUPSUVPuuMOV+DALfyjQjlYU4Y72hGDBtvQrYmCzpPzfXAI2rZO48QgVMaiui/oGSFxbQw5ftJ2vB3oQKwwCQxPz49PBSXYxSCvvkVhrxpbgNDCU9+N1R/V7eg7phyCMHbXukVPfmY4Kdv+at59A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787807543; c=relaxed/simple;
	bh=jplI6Oc3+3ZSXLSuE+Ach9nhgnX57Rptzw/LsuGgC1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qsWKxl0LdeqWFrSKmMWksb5nNqcyETicOgMpwdlX2dFhiBu95xF0TI/rkK1Jkoe+pgIluXuv9I+nLA0MHM1MMjshPLGL+5FqRGe563ydSGG6ak9sje07XBxN2jAzJ4gfdeUvhf7CF0yhX7gUJ4cRytwpnUfsTEelzKVEsDm2fDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=corzzDPd; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="corzzDPd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787807540; x=1819343540;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=jplI6Oc3+3ZSXLSuE+Ach9nhgnX57Rptzw/LsuGgC1g=;
  b=corzzDPdmDv2ptTfvm9Lec4fz47fPBg9JbkjWka6DXDe7j1E5Sc5w9mk
   JddnGMztueciBrQBlAgh97ZyCPPJLu1m8tD07jm9Mx7nSCI5tE3bjoV68
   Ct0EgIGqfjcr2a+rLqE+Cz1Olqkg5fbBuF0Ko+rgpyaOTitHYcO+9Wd+5
   Yk94ib4MjbCm4qkMpasvy8OfoKevm6CiXM+2iuwnZhx3zhlmPOSTQuuTp
   1AthY3cPY8THJdu+mpSb9cc7ptf6MxmQVkf66kcpyMdtImwdSKn3p7aQS
   FyJ0Id4UFj/7CCyXq/iPU9vYoXQ3mUK6H+IMGvEhL0gHCxgUOjkA18HSQ
   w==;
X-CSE-ConnectionGUID: /aP5u6BNST2uNnk3CUTy0A==
X-CSE-MsgGUID: mBam4IEjQm672oLcJNByow==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="88159967"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="88159967"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 22:12:19 -0700
X-CSE-ConnectionGUID: K1BmynRxRiqXZKLk7KJeng==
X-CSE-MsgGUID: 3f+bCbmmQxa+S5aPjgo3eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="271979932"
Received: from sannilnx-dsk.jer.intel.com (HELO [127.0.1.1]) ([10.12.231.107])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 22:12:17 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
Date: Thu, 27 Aug 2026 08:11:56 +0300
Subject: [PATCH v2] mtd: mtd_intel_dg: reset poll counter for each erase
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-mtd_eraze_to_fix-v2-1-1395ae4fb795@intel.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6DIBREr2L+ujSAqUJXvUdjCOq3/qSKAULaG
 u5e6gE6uzfJvNkhoCcMcK128JgokFsLyFMFw2zXBzIaC4PksuFKNmyJo0FvP2iiMxO9WN1yhXz
 SuhcWymzzWOpDee8KzxSi8+/jIYlf+0eWBBOsV1bpuoS3lxutEZ/nwS3Q5Zy/ww6QcbAAAAA=
X-Change-ID: 20260826-mtd_eraze_to_fix-3708e0f99b1a
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Menachem Adin <menachem.adin@intel.com>, stable@vger.kernel.org, 
 Alexander Usyskin <alexander.usyskin@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787807537; l=1851;
 i=alexander.usyskin@intel.com; s=20260315; h=from:subject:message-id;
 bh=vXZtjOotZCVR+xsRZA0rIviHyugLPf2qFp/jodZPmYw=;
 b=SYT4x5TEJSV6W7tgkrgpQLF0ikG4f8qzCFOJoR2z39DBB/6wsTT8T1Dn0HXd1IZ8/fFnEeiVO
 oNbiqwvN28uDGyWKghXGft1r5donYh+ihopCaM5fzS51hEWOuE04Vr+
X-Developer-Key: i=alexander.usyskin@intel.com; a=ed25519;
 pk=X+qoF/nFCdDOV04IForWSxnkyoCAbUE10egZi6PSfcU=

From: Menachem Adin <menachem.adin@intel.com>

The non-posted erase polling counter is initialized only once per MTD
erase request. Large requests therefore share the polling budget across
all 4K erase commands and can fail with -ETIME even though no individual
command timed out.

Reset the counter for each 4K erase command so every operation gets the
intended completion timeout.

Cc: stable@vger.kernel.org
Fixes: a1c940cbf505 ("drm/xe/nvm: add support for non-posted erase")
Signed-off-by: Menachem Adin <menachem.adin@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
Changes in v2:
- Add Fixes tag and stable cc
- Link to v1: https://lore.kernel.org/r/20260826-mtd_eraze_to_fix-v1-1-b8a893333075@intel.com
---
 drivers/mtd/devices/mtd_intel_dg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/mtd_intel_dg.c b/drivers/mtd/devices/mtd_intel_dg.c
index f2fa8f68d190..6e226c0c7f17 100644
--- a/drivers/mtd/devices/mtd_intel_dg.c
+++ b/drivers/mtd/devices/mtd_intel_dg.c
@@ -387,7 +387,7 @@ idg_erase(struct intel_dg_nvm *nvm, u8 region, loff_t from, u64 len, u64 *fail_a
 	void __iomem *base2 = nvm->base2;
 	void __iomem *base = nvm->base;
 	const u32 block = 0x10;
-	u32 iter = 0;
+	u32 iter;
 	u32 reg;
 	u64 i;
 
@@ -396,6 +396,7 @@ idg_erase(struct intel_dg_nvm *nvm, u8 region, loff_t from, u64 len, u64 *fail_a
 		iowrite32(region << 24 | block, base + NVM_ERASE_REG);
 		if (nvm->non_posted_erase) {
 			/* Wait for Erase Done */
+			iter = 0;
 			reg = ioread32(base2 + NVM_DEBUG_REG);
 			while (!(reg & NVM_NON_POSTED_ERASE_DONE) &&
 			       ++iter < NVM_NON_POSTED_ERASE_DONE_ITER) {

---
base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
change-id: 20260826-mtd_eraze_to_fix-3708e0f99b1a

Best regards,
-- 
Alexander Usyskin <alexander.usyskin@intel.com>

