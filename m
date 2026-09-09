Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B191E57C72F
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963044; cv=none; b=KKXLCHQIqyhZlqHLZnanbZS+MwXDbmrKfJGxsl9HiYh/XY5GTCcj+7OVoXzAx41st29yLgE9tB3AI5TkCJ3/thxVaIrE+XIdoiDHAh6z50ZT5yedVT5drchF0u2T/AZzY0StxxMEWEgQIx30ut8XQqhasIlLaQqaE33cALGa3/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963044; c=relaxed/simple;
	bh=wRH/8bzVaW3yzm0N7baxf+6SmPC9YlXAAX/7sbYRYpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o/R8zYyKwLgGlwajIp0oQo0fRhS3BA74rD7GpYN09fFoFrRL2uylgiocDQAO4gim/smoWMF3cNEfzdNC3WkhShWw4+XEWu5wNZ7lrBXCR0NTv1YpbwnNGNuXGSAQst0qNI0IEgWt34oivvGz38ja5ex3YMTYJ02VLeyvaOAptqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gA2B94gP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gA2B94gP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC271F00A3D;
	Wed,  9 Sep 2026 14:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788963039;
	bh=cUi7NbB/g0X/rJ2LFIE4PfCefHzGrWFVjptecVbL7Rk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gA2B94gP8jiveNUYdFZa2qUF3yc0MMw85PTSFLqCXOagOjPfO5MLMmU4zMltaPdpL
	 +/6uH+GAtBibd8t4Hr+QD44/ZW2FFYDGKyVPhHKA1KkO2W3bMohgVisosGntaUFk+c
	 cC0wRlsiSFdicnaE1kYlz958YsRVcp9S0wTCEwlQw1IQWSEjZBlxRD00YyZek8Voky
	 +F9WBLL5i4eBL+79YtCvuHRlvk3gB6oHPCT3m/I1aNHyz2YNbmJ8pX2bG2RuErL2Xs
	 uTqtTxxBtw+IhZdZnQLW4Yw4Vdlv/+MGng52uJCM8VX6vzXIw7gmb4E35s0qBfIXTt
	 hURn8qVkmHBSA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] x86: remove the IOMMU table infrastructure
Date: Wed,  9 Sep 2026 10:10:31 -0400
Message-ID: <20260909141035.2381120-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090351-clapper-monorail-cc3a@gregkh>
References: <2026090351-clapper-monorail-cc3a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 78013eaadf696d2105982abb4018fbae394ca08f ]

The IOMMU table tries to separate the different IOMMUs into different
backends, but actually requires various cross calls.

Rewrite the code to do the generic swiotlb/swiotlb-xen setup directly
in pci-dma.c and then just call into the IOMMU drivers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Tested-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

[5.15 dependency adaptation for 607432b2618b]

Limit the table removal to Intel VT-d detection. Call detect_intel_iommu()
directly after the remaining table entries, and return when a backend has
IOMMU_FINISH_IF_DETECTED so Xen, forced SWIOTLB and AMD retain their stop
semantics. Keep the existing SWIOTLB, GART and AMD implementations: this
branch uses sme_active() and already removed amd_iommu_init_dma_ops().
Guard the direct call with CONFIG_DMAR_TABLE instead of adding a stub.

Move the existing Intel IOMMU header to drivers/iommu/intel/iommu.h while
preserving the public include path through a forwarding include. Keep
the existing graphics declaration and align the enabled/disabled Intel
IOMMU declaration blocks with the target's context. All existing inline
function bodies are retained without additions or changes.

This retains the target's required void detect_intel_iommu() interface
and header layout without importing the full x86 IOMMU/SWIOTLB rewrite.

[ sashal: Reduced backport -- upstream 78013eaadf696 touches 21 file(s), this
  backport carries 6. Not backported here:
  arch/ia64/include/asm/iommu_table.h
  arch/x86/include/asm/dma-mapping.h
  arch/x86/include/asm/gart.h
  arch/x86/include/asm/iommu.h
  arch/x86/include/asm/iommu_table.h
  arch/x86/include/asm/swiotlb.h
  arch/x86/include/asm/xen/swiotlb-xen.h
  arch/x86/kernel/amd_gart_64.c
  ... and 10 more
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 607432b2618b ("iommu/vt-d: Force requesting ACS when tboot is enabled")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/pci-dma.c   |   6 +-
 drivers/iommu/intel/dmar.c  |   8 +-
 drivers/iommu/intel/iommu.c |   2 +-
 drivers/iommu/intel/iommu.h | 862 ++++++++++++++++++++++++++++++++++++
 include/linux/dmar.h        |   2 +-
 include/linux/intel-iommu.h | 861 +----------------------------------
 6 files changed, 873 insertions(+), 868 deletions(-)
 create mode 100644 drivers/iommu/intel/iommu.h

diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index de234e7a8962e..cecf6b6b8ab2f 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -49,9 +49,13 @@ void __init pci_iommu_alloc(void)
 			if (p->early_init)
 				p->early_init();
 			if (p->flags & IOMMU_FINISH_IF_DETECTED)
-				break;
+				return;
 		}
 	}
+
+#ifdef CONFIG_DMAR_TABLE
+	detect_intel_iommu();
+#endif
 }
 
 /*
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index f0d34ba78b4a9..adea04ac0bd47 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -19,7 +19,6 @@
 #include <linux/pci.h>
 #include <linux/dmar.h>
 #include <linux/iova.h>
-#include <linux/intel-iommu.h>
 #include <linux/timer.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
@@ -30,10 +29,10 @@
 #include <linux/numa.h>
 #include <linux/limits.h>
 #include <asm/irq_remapping.h>
-#include <asm/iommu_table.h>
 #include <trace/events/intel_iommu.h>
 
 #include "../irq_remapping.h"
+#include "iommu.h"
 #include "perf.h"
 
 typedef int (*dmar_res_handler_t)(struct acpi_dmar_header *, void *);
@@ -914,7 +913,7 @@ dmar_validate_one_drhd(struct acpi_dmar_header *entry, void *arg)
 	return 0;
 }
 
-int __init detect_intel_iommu(void)
+void __init detect_intel_iommu(void)
 {
 	int ret;
 	struct dmar_res_callback validate_drhd_cb = {
@@ -947,8 +946,6 @@ int __init detect_intel_iommu(void)
 		dmar_tbl = NULL;
 	}
 	up_write(&dmar_global_lock);
-
-	return ret ? ret : 1;
 }
 
 static void unmap_iommu(struct intel_iommu *iommu)
@@ -2184,7 +2181,6 @@ static int __init dmar_free_unused_resources(void)
 }
 
 late_initcall(dmar_free_unused_resources);
-IOMMU_INIT_POST(detect_intel_iommu);
 
 /*
  * DMAR Hotplug Support
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2680ba77e55de..86e23fe27c896 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -32,7 +32,6 @@
 #include <linux/iova.h>
 #include <linux/iommu.h>
 #include <linux/dma-iommu.h>
-#include <linux/intel-iommu.h>
 #include <linux/intel-svm.h>
 #include <linux/syscore_ops.h>
 #include <linux/tboot.h>
@@ -48,6 +47,7 @@
 
 #include "../irq_remapping.h"
 #include "../iommu-sva-lib.h"
+#include "iommu.h"
 #include "pasid.h"
 #include "cap_audit.h"
 
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
new file mode 100644
index 0000000000000..3c8bfc2cfccb8
--- /dev/null
+++ b/drivers/iommu/intel/iommu.h
@@ -0,0 +1,862 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright © 2006-2015, Intel Corporation.
+ *
+ * Authors: Ashok Raj <ashok.raj@intel.com>
+ *          Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
+ *          David Woodhouse <David.Woodhouse@intel.com>
+ */
+
+#ifndef _INTEL_IOMMU_H_
+#define _INTEL_IOMMU_H_
+
+#include <linux/types.h>
+#include <linux/iova.h>
+#include <linux/io.h>
+#include <linux/idr.h>
+#include <linux/mmu_notifier.h>
+#include <linux/list.h>
+#include <linux/iommu.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/dmar.h>
+#include <linux/ioasid.h>
+#include <linux/bitfield.h>
+
+#include <asm/cacheflush.h>
+#include <asm/iommu.h>
+
+/*
+ * VT-d hardware uses 4KiB page size regardless of host page size.
+ */
+#define VTD_PAGE_SHIFT		(12)
+#define VTD_PAGE_SIZE		(1UL << VTD_PAGE_SHIFT)
+#define VTD_PAGE_MASK		(((u64)-1) << VTD_PAGE_SHIFT)
+#define VTD_PAGE_ALIGN(addr)	(((addr) + VTD_PAGE_SIZE - 1) & VTD_PAGE_MASK)
+
+#define VTD_STRIDE_SHIFT        (9)
+#define VTD_STRIDE_MASK         (((u64)-1) << VTD_STRIDE_SHIFT)
+
+#define DMA_PTE_READ		BIT_ULL(0)
+#define DMA_PTE_WRITE		BIT_ULL(1)
+#define DMA_PTE_LARGE_PAGE	BIT_ULL(7)
+#define DMA_PTE_SNP		BIT_ULL(11)
+
+#define DMA_FL_PTE_PRESENT	BIT_ULL(0)
+#define DMA_FL_PTE_US		BIT_ULL(2)
+#define DMA_FL_PTE_ACCESS	BIT_ULL(5)
+#define DMA_FL_PTE_DIRTY	BIT_ULL(6)
+#define DMA_FL_PTE_XD		BIT_ULL(63)
+
+#define ADDR_WIDTH_5LEVEL	(57)
+#define ADDR_WIDTH_4LEVEL	(48)
+
+#define CONTEXT_TT_MULTI_LEVEL	0
+#define CONTEXT_TT_DEV_IOTLB	1
+#define CONTEXT_TT_PASS_THROUGH 2
+#define CONTEXT_PASIDE		BIT_ULL(3)
+
+/*
+ * Intel IOMMU register specification per version 1.0 public spec.
+ */
+#define	DMAR_VER_REG	0x0	/* Arch version supported by this IOMMU */
+#define	DMAR_CAP_REG	0x8	/* Hardware supported capabilities */
+#define	DMAR_ECAP_REG	0x10	/* Extended capabilities supported */
+#define	DMAR_GCMD_REG	0x18	/* Global command register */
+#define	DMAR_GSTS_REG	0x1c	/* Global status register */
+#define	DMAR_RTADDR_REG	0x20	/* Root entry table */
+#define	DMAR_CCMD_REG	0x28	/* Context command reg */
+#define	DMAR_FSTS_REG	0x34	/* Fault Status register */
+#define	DMAR_FECTL_REG	0x38	/* Fault control register */
+#define	DMAR_FEDATA_REG	0x3c	/* Fault event interrupt data register */
+#define	DMAR_FEADDR_REG	0x40	/* Fault event interrupt addr register */
+#define	DMAR_FEUADDR_REG 0x44	/* Upper address register */
+#define	DMAR_AFLOG_REG	0x58	/* Advanced Fault control */
+#define	DMAR_PMEN_REG	0x64	/* Enable Protected Memory Region */
+#define	DMAR_PLMBASE_REG 0x68	/* PMRR Low addr */
+#define	DMAR_PLMLIMIT_REG 0x6c	/* PMRR low limit */
+#define	DMAR_PHMBASE_REG 0x70	/* pmrr high base addr */
+#define	DMAR_PHMLIMIT_REG 0x78	/* pmrr high limit */
+#define DMAR_IQH_REG	0x80	/* Invalidation queue head register */
+#define DMAR_IQT_REG	0x88	/* Invalidation queue tail register */
+#define DMAR_IQ_SHIFT	4	/* Invalidation queue head/tail shift */
+#define DMAR_IQA_REG	0x90	/* Invalidation queue addr register */
+#define DMAR_ICS_REG	0x9c	/* Invalidation complete status register */
+#define DMAR_IQER_REG	0xb0	/* Invalidation queue error record register */
+#define DMAR_IRTA_REG	0xb8    /* Interrupt remapping table addr register */
+#define DMAR_PQH_REG	0xc0	/* Page request queue head register */
+#define DMAR_PQT_REG	0xc8	/* Page request queue tail register */
+#define DMAR_PQA_REG	0xd0	/* Page request queue address register */
+#define DMAR_PRS_REG	0xdc	/* Page request status register */
+#define DMAR_PECTL_REG	0xe0	/* Page request event control register */
+#define	DMAR_PEDATA_REG	0xe4	/* Page request event interrupt data register */
+#define	DMAR_PEADDR_REG	0xe8	/* Page request event interrupt addr register */
+#define	DMAR_PEUADDR_REG 0xec	/* Page request event Upper address register */
+#define DMAR_MTRRCAP_REG 0x100	/* MTRR capability register */
+#define DMAR_MTRRDEF_REG 0x108	/* MTRR default type register */
+#define DMAR_MTRR_FIX64K_00000_REG 0x120 /* MTRR Fixed range registers */
+#define DMAR_MTRR_FIX16K_80000_REG 0x128
+#define DMAR_MTRR_FIX16K_A0000_REG 0x130
+#define DMAR_MTRR_FIX4K_C0000_REG 0x138
+#define DMAR_MTRR_FIX4K_C8000_REG 0x140
+#define DMAR_MTRR_FIX4K_D0000_REG 0x148
+#define DMAR_MTRR_FIX4K_D8000_REG 0x150
+#define DMAR_MTRR_FIX4K_E0000_REG 0x158
+#define DMAR_MTRR_FIX4K_E8000_REG 0x160
+#define DMAR_MTRR_FIX4K_F0000_REG 0x168
+#define DMAR_MTRR_FIX4K_F8000_REG 0x170
+#define DMAR_MTRR_PHYSBASE0_REG 0x180 /* MTRR Variable range registers */
+#define DMAR_MTRR_PHYSMASK0_REG 0x188
+#define DMAR_MTRR_PHYSBASE1_REG 0x190
+#define DMAR_MTRR_PHYSMASK1_REG 0x198
+#define DMAR_MTRR_PHYSBASE2_REG 0x1a0
+#define DMAR_MTRR_PHYSMASK2_REG 0x1a8
+#define DMAR_MTRR_PHYSBASE3_REG 0x1b0
+#define DMAR_MTRR_PHYSMASK3_REG 0x1b8
+#define DMAR_MTRR_PHYSBASE4_REG 0x1c0
+#define DMAR_MTRR_PHYSMASK4_REG 0x1c8
+#define DMAR_MTRR_PHYSBASE5_REG 0x1d0
+#define DMAR_MTRR_PHYSMASK5_REG 0x1d8
+#define DMAR_MTRR_PHYSBASE6_REG 0x1e0
+#define DMAR_MTRR_PHYSMASK6_REG 0x1e8
+#define DMAR_MTRR_PHYSBASE7_REG 0x1f0
+#define DMAR_MTRR_PHYSMASK7_REG 0x1f8
+#define DMAR_MTRR_PHYSBASE8_REG 0x200
+#define DMAR_MTRR_PHYSMASK8_REG 0x208
+#define DMAR_MTRR_PHYSBASE9_REG 0x210
+#define DMAR_MTRR_PHYSMASK9_REG 0x218
+#define DMAR_VCCAP_REG		0xe30 /* Virtual command capability register */
+#define DMAR_VCMD_REG		0xe00 /* Virtual command register */
+#define DMAR_VCRSP_REG		0xe10 /* Virtual command response register */
+
+#define DMAR_IQER_REG_IQEI(reg)		FIELD_GET(GENMASK_ULL(3, 0), reg)
+#define DMAR_IQER_REG_ITESID(reg)	FIELD_GET(GENMASK_ULL(47, 32), reg)
+#define DMAR_IQER_REG_ICESID(reg)	FIELD_GET(GENMASK_ULL(63, 48), reg)
+
+#define OFFSET_STRIDE		(9)
+
+#define dmar_readq(a) readq(a)
+#define dmar_writeq(a,v) writeq(v,a)
+#define dmar_readl(a) readl(a)
+#define dmar_writel(a, v) writel(v, a)
+
+#define DMAR_VER_MAJOR(v)		(((v) & 0xf0) >> 4)
+#define DMAR_VER_MINOR(v)		((v) & 0x0f)
+
+/*
+ * Decoding Capability Register
+ */
+#define cap_5lp_support(c)	(((c) >> 60) & 1)
+#define cap_pi_support(c)	(((c) >> 59) & 1)
+#define cap_fl1gp_support(c)	(((c) >> 56) & 1)
+#define cap_read_drain(c)	(((c) >> 55) & 1)
+#define cap_write_drain(c)	(((c) >> 54) & 1)
+#define cap_max_amask_val(c)	(((c) >> 48) & 0x3f)
+#define cap_num_fault_regs(c)	((((c) >> 40) & 0xff) + 1)
+#define cap_pgsel_inv(c)	(((c) >> 39) & 1)
+
+#define cap_super_page_val(c)	(((c) >> 34) & 0xf)
+#define cap_super_offset(c)	(((find_first_bit(&cap_super_page_val(c), 4)) \
+					* OFFSET_STRIDE) + 21)
+
+#define cap_fault_reg_offset(c)	((((c) >> 24) & 0x3ff) * 16)
+#define cap_max_fault_reg_offset(c) \
+	(cap_fault_reg_offset(c) + cap_num_fault_regs(c) * 16)
+
+#define cap_zlr(c)		(((c) >> 22) & 1)
+#define cap_isoch(c)		(((c) >> 23) & 1)
+#define cap_mgaw(c)		((((c) >> 16) & 0x3f) + 1)
+#define cap_sagaw(c)		(((c) >> 8) & 0x1f)
+#define cap_caching_mode(c)	(((c) >> 7) & 1)
+#define cap_phmr(c)		(((c) >> 6) & 1)
+#define cap_plmr(c)		(((c) >> 5) & 1)
+#define cap_rwbf(c)		(((c) >> 4) & 1)
+#define cap_afl(c)		(((c) >> 3) & 1)
+#define cap_ndoms(c)		(((unsigned long)1) << (4 + 2 * ((c) & 0x7)))
+/*
+ * Extended Capability Register
+ */
+
+#define	ecap_rps(e)		(((e) >> 49) & 0x1)
+#define ecap_smpwc(e)		(((e) >> 48) & 0x1)
+#define ecap_flts(e)		(((e) >> 47) & 0x1)
+#define ecap_slts(e)		(((e) >> 46) & 0x1)
+#define ecap_slads(e)		(((e) >> 45) & 0x1)
+#define ecap_vcs(e)		(((e) >> 44) & 0x1)
+#define ecap_smts(e)		(((e) >> 43) & 0x1)
+#define ecap_dit(e)		(((e) >> 41) & 0x1)
+#define ecap_pds(e)		(((e) >> 42) & 0x1)
+#define ecap_pasid(e)		(((e) >> 40) & 0x1)
+#define ecap_pss(e)		(((e) >> 35) & 0x1f)
+#define ecap_eafs(e)		(((e) >> 34) & 0x1)
+#define ecap_nwfs(e)		(((e) >> 33) & 0x1)
+#define ecap_srs(e)		(((e) >> 31) & 0x1)
+#define ecap_ers(e)		(((e) >> 30) & 0x1)
+#define ecap_prs(e)		(((e) >> 29) & 0x1)
+#define ecap_broken_pasid(e)	(((e) >> 28) & 0x1)
+#define ecap_dis(e)		(((e) >> 27) & 0x1)
+#define ecap_nest(e)		(((e) >> 26) & 0x1)
+#define ecap_mts(e)		(((e) >> 25) & 0x1)
+#define ecap_iotlb_offset(e) 	((((e) >> 8) & 0x3ff) * 16)
+#define ecap_max_iotlb_offset(e) (ecap_iotlb_offset(e) + 16)
+#define ecap_coherent(e)	((e) & 0x1)
+#define ecap_qis(e)		((e) & 0x2)
+#define ecap_pass_through(e)	(((e) >> 6) & 0x1)
+#define ecap_eim_support(e)	(((e) >> 4) & 0x1)
+#define ecap_ir_support(e)	(((e) >> 3) & 0x1)
+#define ecap_dev_iotlb_support(e)	(((e) >> 2) & 0x1)
+#define ecap_max_handle_mask(e) (((e) >> 20) & 0xf)
+#define ecap_sc_support(e)	(((e) >> 7) & 0x1) /* Snooping Control */
+
+/* Virtual command interface capability */
+#define vccap_pasid(v)		(((v) & DMA_VCS_PAS)) /* PASID allocation */
+
+/* IOTLB_REG */
+#define DMA_TLB_FLUSH_GRANU_OFFSET  60
+#define DMA_TLB_GLOBAL_FLUSH (((u64)1) << 60)
+#define DMA_TLB_DSI_FLUSH (((u64)2) << 60)
+#define DMA_TLB_PSI_FLUSH (((u64)3) << 60)
+#define DMA_TLB_IIRG(type) ((type >> 60) & 3)
+#define DMA_TLB_IAIG(val) (((val) >> 57) & 3)
+#define DMA_TLB_READ_DRAIN (((u64)1) << 49)
+#define DMA_TLB_WRITE_DRAIN (((u64)1) << 48)
+#define DMA_TLB_DID(id)	(((u64)((id) & 0xffff)) << 32)
+#define DMA_TLB_IVT (((u64)1) << 63)
+#define DMA_TLB_IH_NONLEAF (((u64)1) << 6)
+#define DMA_TLB_MAX_SIZE (0x3f)
+
+/* INVALID_DESC */
+#define DMA_CCMD_INVL_GRANU_OFFSET  61
+#define DMA_ID_TLB_GLOBAL_FLUSH	(((u64)1) << 4)
+#define DMA_ID_TLB_DSI_FLUSH	(((u64)2) << 4)
+#define DMA_ID_TLB_PSI_FLUSH	(((u64)3) << 4)
+#define DMA_ID_TLB_READ_DRAIN	(((u64)1) << 7)
+#define DMA_ID_TLB_WRITE_DRAIN	(((u64)1) << 6)
+#define DMA_ID_TLB_DID(id)	(((u64)((id & 0xffff) << 16)))
+#define DMA_ID_TLB_IH_NONLEAF	(((u64)1) << 6)
+#define DMA_ID_TLB_ADDR(addr)	(addr)
+#define DMA_ID_TLB_ADDR_MASK(mask)	(mask)
+
+/* PMEN_REG */
+#define DMA_PMEN_EPM (((u32)1)<<31)
+#define DMA_PMEN_PRS (((u32)1)<<0)
+
+/* GCMD_REG */
+#define DMA_GCMD_TE (((u32)1) << 31)
+#define DMA_GCMD_SRTP (((u32)1) << 30)
+#define DMA_GCMD_SFL (((u32)1) << 29)
+#define DMA_GCMD_EAFL (((u32)1) << 28)
+#define DMA_GCMD_WBF (((u32)1) << 27)
+#define DMA_GCMD_QIE (((u32)1) << 26)
+#define DMA_GCMD_SIRTP (((u32)1) << 24)
+#define DMA_GCMD_IRE (((u32) 1) << 25)
+#define DMA_GCMD_CFI (((u32) 1) << 23)
+
+/* GSTS_REG */
+#define DMA_GSTS_TES (((u32)1) << 31)
+#define DMA_GSTS_RTPS (((u32)1) << 30)
+#define DMA_GSTS_FLS (((u32)1) << 29)
+#define DMA_GSTS_AFLS (((u32)1) << 28)
+#define DMA_GSTS_WBFS (((u32)1) << 27)
+#define DMA_GSTS_QIES (((u32)1) << 26)
+#define DMA_GSTS_IRTPS (((u32)1) << 24)
+#define DMA_GSTS_IRES (((u32)1) << 25)
+#define DMA_GSTS_CFIS (((u32)1) << 23)
+
+/* DMA_RTADDR_REG */
+#define DMA_RTADDR_SMT (((u64)1) << 10)
+
+/* CCMD_REG */
+#define DMA_CCMD_ICC (((u64)1) << 63)
+#define DMA_CCMD_GLOBAL_INVL (((u64)1) << 61)
+#define DMA_CCMD_DOMAIN_INVL (((u64)2) << 61)
+#define DMA_CCMD_DEVICE_INVL (((u64)3) << 61)
+#define DMA_CCMD_FM(m) (((u64)((m) & 0x3)) << 32)
+#define DMA_CCMD_MASK_NOBIT 0
+#define DMA_CCMD_MASK_1BIT 1
+#define DMA_CCMD_MASK_2BIT 2
+#define DMA_CCMD_MASK_3BIT 3
+#define DMA_CCMD_SID(s) (((u64)((s) & 0xffff)) << 16)
+#define DMA_CCMD_DID(d) ((u64)((d) & 0xffff))
+
+/* FECTL_REG */
+#define DMA_FECTL_IM (((u32)1) << 31)
+
+/* FSTS_REG */
+#define DMA_FSTS_PFO (1 << 0) /* Primary Fault Overflow */
+#define DMA_FSTS_PPF (1 << 1) /* Primary Pending Fault */
+#define DMA_FSTS_IQE (1 << 4) /* Invalidation Queue Error */
+#define DMA_FSTS_ICE (1 << 5) /* Invalidation Completion Error */
+#define DMA_FSTS_ITE (1 << 6) /* Invalidation Time-out Error */
+#define DMA_FSTS_PRO (1 << 7) /* Page Request Overflow */
+#define dma_fsts_fault_record_index(s) (((s) >> 8) & 0xff)
+
+/* FRCD_REG, 32 bits access */
+#define DMA_FRCD_F (((u32)1) << 31)
+#define dma_frcd_type(d) ((d >> 30) & 1)
+#define dma_frcd_fault_reason(c) (c & 0xff)
+#define dma_frcd_source_id(c) (c & 0xffff)
+#define dma_frcd_pasid_value(c) (((c) >> 8) & 0xfffff)
+#define dma_frcd_pasid_present(c) (((c) >> 31) & 1)
+/* low 64 bit */
+#define dma_frcd_page_addr(d) (d & (((u64)-1) << PAGE_SHIFT))
+
+/* PRS_REG */
+#define DMA_PRS_PPR	((u32)1)
+#define DMA_PRS_PRO	((u32)2)
+
+#define DMA_VCS_PAS	((u64)1)
+
+#define IOMMU_WAIT_OP(iommu, offset, op, cond, sts)			\
+do {									\
+	cycles_t start_time = get_cycles();				\
+	while (1) {							\
+		sts = op(iommu->reg + offset);				\
+		if (cond)						\
+			break;						\
+		if (DMAR_OPERATION_TIMEOUT < (get_cycles() - start_time))\
+			panic("DMAR hardware is malfunctioning\n");	\
+		cpu_relax();						\
+	}								\
+} while (0)
+
+#define QI_LENGTH	256	/* queue length */
+
+enum {
+	QI_FREE,
+	QI_IN_USE,
+	QI_DONE,
+	QI_ABORT
+};
+
+#define QI_CC_TYPE		0x1
+#define QI_IOTLB_TYPE		0x2
+#define QI_DIOTLB_TYPE		0x3
+#define QI_IEC_TYPE		0x4
+#define QI_IWD_TYPE		0x5
+#define QI_EIOTLB_TYPE		0x6
+#define QI_PC_TYPE		0x7
+#define QI_DEIOTLB_TYPE		0x8
+#define QI_PGRP_RESP_TYPE	0x9
+#define QI_PSTRM_RESP_TYPE	0xa
+
+#define QI_IEC_SELECTIVE	(((u64)1) << 4)
+#define QI_IEC_IIDEX(idx)	(((u64)(idx & 0xffff) << 32))
+#define QI_IEC_IM(m)		(((u64)(m & 0x1f) << 27))
+
+#define QI_IWD_STATUS_DATA(d)	(((u64)d) << 32)
+#define QI_IWD_STATUS_WRITE	(((u64)1) << 5)
+#define QI_IWD_FENCE		(((u64)1) << 6)
+#define QI_IWD_PRQ_DRAIN	(((u64)1) << 7)
+
+#define QI_IOTLB_DID(did) 	(((u64)did) << 16)
+#define QI_IOTLB_DR(dr) 	(((u64)dr) << 7)
+#define QI_IOTLB_DW(dw) 	(((u64)dw) << 6)
+#define QI_IOTLB_GRAN(gran) 	(((u64)gran) >> (DMA_TLB_FLUSH_GRANU_OFFSET-4))
+#define QI_IOTLB_ADDR(addr)	(((u64)addr) & VTD_PAGE_MASK)
+#define QI_IOTLB_IH(ih)		(((u64)ih) << 6)
+#define QI_IOTLB_AM(am)		(((u8)am) & 0x3f)
+
+#define QI_CC_FM(fm)		(((u64)fm) << 48)
+#define QI_CC_SID(sid)		(((u64)sid) << 32)
+#define QI_CC_DID(did)		(((u64)did) << 16)
+#define QI_CC_GRAN(gran)	(((u64)gran) >> (DMA_CCMD_INVL_GRANU_OFFSET-4))
+
+#define QI_DEV_IOTLB_SID(sid)	((u64)((sid) & 0xffff) << 32)
+#define QI_DEV_IOTLB_QDEP(qdep)	(((qdep) & 0x1f) << 16)
+#define QI_DEV_IOTLB_ADDR(addr)	((u64)(addr) & VTD_PAGE_MASK)
+#define QI_DEV_IOTLB_PFSID(pfsid) (((u64)(pfsid & 0xf) << 12) | \
+				   ((u64)((pfsid >> 4) & 0xfff) << 52))
+#define QI_DEV_IOTLB_SIZE	1
+#define QI_DEV_IOTLB_MAX_INVS	32
+
+#define QI_PC_PASID(pasid)	(((u64)pasid) << 32)
+#define QI_PC_DID(did)		(((u64)did) << 16)
+#define QI_PC_GRAN(gran)	(((u64)gran) << 4)
+
+/* PASID cache invalidation granu */
+#define QI_PC_ALL_PASIDS	0
+#define QI_PC_PASID_SEL		1
+#define QI_PC_GLOBAL		3
+
+#define QI_EIOTLB_ADDR(addr)	((u64)(addr) & VTD_PAGE_MASK)
+#define QI_EIOTLB_IH(ih)	(((u64)ih) << 6)
+#define QI_EIOTLB_AM(am)	(((u64)am) & 0x3f)
+#define QI_EIOTLB_PASID(pasid) 	(((u64)pasid) << 32)
+#define QI_EIOTLB_DID(did)	(((u64)did) << 16)
+#define QI_EIOTLB_GRAN(gran) 	(((u64)gran) << 4)
+
+/* QI Dev-IOTLB inv granu */
+#define QI_DEV_IOTLB_GRAN_ALL		1
+#define QI_DEV_IOTLB_GRAN_PASID_SEL	0
+
+#define QI_DEV_EIOTLB_ADDR(a)	((u64)(a) & VTD_PAGE_MASK)
+#define QI_DEV_EIOTLB_SIZE	(((u64)1) << 11)
+#define QI_DEV_EIOTLB_PASID(p)	((u64)((p) & 0xfffff) << 32)
+#define QI_DEV_EIOTLB_SID(sid)	((u64)((sid) & 0xffff) << 16)
+#define QI_DEV_EIOTLB_QDEP(qd)	((u64)((qd) & 0x1f) << 4)
+#define QI_DEV_EIOTLB_PFSID(pfsid) (((u64)(pfsid & 0xf) << 12) | \
+				    ((u64)((pfsid >> 4) & 0xfff) << 52))
+#define QI_DEV_EIOTLB_MAX_INVS	32
+
+/* Page group response descriptor QW0 */
+#define QI_PGRP_PASID_P(p)	(((u64)(p)) << 4)
+#define QI_PGRP_PDP(p)		(((u64)(p)) << 5)
+#define QI_PGRP_RESP_CODE(res)	(((u64)(res)) << 12)
+#define QI_PGRP_DID(rid)	(((u64)(rid)) << 16)
+#define QI_PGRP_PASID(pasid)	(((u64)(pasid)) << 32)
+
+/* Page group response descriptor QW1 */
+#define QI_PGRP_LPIG(x)		(((u64)(x)) << 2)
+#define QI_PGRP_IDX(idx)	(((u64)(idx)) << 3)
+
+
+#define QI_RESP_SUCCESS		0x0
+#define QI_RESP_INVALID		0x1
+#define QI_RESP_FAILURE		0xf
+
+#define QI_GRAN_NONG_PASID		2
+#define QI_GRAN_PSI_PASID		3
+
+#define qi_shift(iommu)		(DMAR_IQ_SHIFT + !!ecap_smts((iommu)->ecap))
+
+struct qi_desc {
+	u64 qw0;
+	u64 qw1;
+	u64 qw2;
+	u64 qw3;
+};
+
+struct q_inval {
+	raw_spinlock_t  q_lock;
+	void		*desc;          /* invalidation queue */
+	int             *desc_status;   /* desc status */
+	int             free_head;      /* first free entry */
+	int             free_tail;      /* last free entry */
+	int             free_cnt;
+};
+
+struct dmar_pci_notify_info;
+
+#ifdef CONFIG_IRQ_REMAP
+/* 1MB - maximum possible interrupt remapping table size */
+#define INTR_REMAP_PAGE_ORDER	8
+#define INTR_REMAP_TABLE_REG_SIZE	0xf
+#define INTR_REMAP_TABLE_REG_SIZE_MASK  0xf
+
+#define INTR_REMAP_TABLE_ENTRIES	65536
+
+struct irq_domain;
+
+struct ir_table {
+	struct irte *base;
+	unsigned long *bitmap;
+};
+
+void intel_irq_remap_add_device(struct dmar_pci_notify_info *info);
+#else
+static inline void
+intel_irq_remap_add_device(struct dmar_pci_notify_info *info) { }
+#endif
+
+struct iommu_flush {
+	void (*flush_context)(struct intel_iommu *iommu, u16 did, u16 sid,
+			      u8 fm, u64 type);
+	void (*flush_iotlb)(struct intel_iommu *iommu, u16 did, u64 addr,
+			    unsigned int size_order, u64 type);
+};
+
+enum {
+	SR_DMAR_FECTL_REG,
+	SR_DMAR_FEDATA_REG,
+	SR_DMAR_FEADDR_REG,
+	SR_DMAR_FEUADDR_REG,
+	MAX_SR_DMAR_REGS
+};
+
+#define VTD_FLAG_TRANS_PRE_ENABLED	(1 << 0)
+#define VTD_FLAG_IRQ_REMAP_PRE_ENABLED	(1 << 1)
+#define VTD_FLAG_SVM_CAPABLE		(1 << 2)
+
+extern spinlock_t device_domain_lock;
+
+#define sm_supported(iommu)	(intel_iommu_sm && ecap_smts((iommu)->ecap))
+#define pasid_supported(iommu)	(sm_supported(iommu) &&			\
+				 ecap_pasid((iommu)->ecap))
+
+struct pasid_entry;
+struct pasid_state_entry;
+struct page_req_dsc;
+
+/*
+ * 0: Present
+ * 1-11: Reserved
+ * 12-63: Context Ptr (12 - (haw-1))
+ * 64-127: Reserved
+ */
+struct root_entry {
+	u64     lo;
+	u64     hi;
+};
+
+/*
+ * low 64 bits:
+ * 0: present
+ * 1: fault processing disable
+ * 2-3: translation type
+ * 12-63: address space root
+ * high 64 bits:
+ * 0-2: address width
+ * 3-6: aval
+ * 8-23: domain id
+ */
+struct context_entry {
+	u64 lo;
+	u64 hi;
+};
+
+/*
+ * When VT-d works in the scalable mode, it allows DMA translation to
+ * happen through either first level or second level page table. This
+ * bit marks that the DMA translation for the domain goes through the
+ * first level page table, otherwise, it goes through the second level.
+ */
+#define DOMAIN_FLAG_USE_FIRST_LEVEL		BIT(1)
+
+/*
+ * Domain represents a virtual machine which demands iommu nested
+ * translation mode support.
+ */
+#define DOMAIN_FLAG_NESTING_MODE		BIT(2)
+
+struct dmar_domain {
+	int	nid;			/* node id */
+
+	unsigned int iommu_refcnt[DMAR_UNITS_SUPPORTED];
+					/* Refcount of devices per iommu */
+
+
+	u16		iommu_did[DMAR_UNITS_SUPPORTED];
+					/* Domain ids per IOMMU. Use u16 since
+					 * domain ids are 16 bit wide according
+					 * to VT-d spec, section 9.3 */
+
+	u8 has_iotlb_device: 1;
+	u8 iommu_coherency: 1;		/* indicate coherency of iommu access */
+	u8 iommu_snooping: 1;		/* indicate snooping control feature */
+
+	struct list_head devices;	/* all devices' list */
+	struct list_head subdevices;	/* all subdevices' list */
+	struct iova_domain iovad;	/* iova's that belong to this domain */
+
+	struct dma_pte	*pgd;		/* virtual address */
+	int		gaw;		/* max guest address width */
+
+	/* adjusted guest address width, 0 is level 2 30-bit */
+	int		agaw;
+
+	int		flags;		/* flags to find out type of domain */
+	int		iommu_superpage;/* Level of superpages supported:
+					   0 == 4KiB (no superpages), 1 == 2MiB,
+					   2 == 1GiB, 3 == 512GiB, 4 == 1TiB */
+	u64		max_addr;	/* maximum mapped address */
+
+	u32		default_pasid;	/*
+					 * The default pasid used for non-SVM
+					 * traffic on mediated devices.
+					 */
+
+	struct iommu_domain domain;	/* generic domain data structure for
+					   iommu core */
+};
+
+struct intel_iommu {
+	void __iomem	*reg; /* Pointer to hardware regs, virtual addr */
+	u64 		reg_phys; /* physical address of hw register set */
+	u64		reg_size; /* size of hw register set */
+	u64		cap;
+	u64		ecap;
+	u64		vccap;
+	u32		gcmd; /* Holds TE, EAFL. Don't need SRTP, SFL, WBF */
+	raw_spinlock_t	register_lock; /* protect register handling */
+	int		seq_id;	/* sequence id of the iommu */
+	int		agaw; /* agaw of this iommu */
+	int		msagaw; /* max sagaw of this iommu */
+	unsigned int 	irq, pr_irq;
+	u16		segment;     /* PCI segment# */
+	unsigned char 	name[13];    /* Device Name */
+
+#ifdef CONFIG_INTEL_IOMMU
+	unsigned long 	*domain_ids; /* bitmap of domains */
+	struct dmar_domain ***domains; /* ptr to domains */
+	unsigned long	*copied_tables; /* bitmap of copied tables */
+	spinlock_t	lock; /* protect context, domain ids */
+	struct root_entry *root_entry; /* virtual address */
+
+	struct iommu_flush flush;
+#endif
+#ifdef CONFIG_INTEL_IOMMU_SVM
+	struct page_req_dsc *prq;
+	unsigned char prq_name[16];    /* Name for PRQ interrupt */
+	struct completion prq_complete;
+	struct ioasid_allocator_ops pasid_allocator; /* Custom allocator for PASIDs */
+#endif
+	struct iopf_queue *iopf_queue;
+	unsigned char iopfq_name[16];
+	struct q_inval  *qi;            /* Queued invalidation info */
+	u32 iommu_state[MAX_SR_DMAR_REGS]; /* Store iommu states between suspend and resume.*/
+
+#ifdef CONFIG_IRQ_REMAP
+	struct ir_table *ir_table;	/* Interrupt remapping info */
+	struct irq_domain *ir_domain;
+	struct irq_domain *ir_msi_domain;
+#endif
+	struct iommu_device iommu;  /* IOMMU core code handle */
+	int		node;
+	u32		flags;      /* Software defined flags */
+
+	struct dmar_drhd_unit *drhd;
+	void *perf_statistic;
+};
+
+/* Per subdevice private data */
+struct subdev_domain_info {
+	struct list_head link_phys;	/* link to phys device siblings */
+	struct list_head link_domain;	/* link to domain siblings */
+	struct device *pdev;		/* physical device derived from */
+	struct dmar_domain *domain;	/* aux-domain */
+	int users;			/* user count */
+};
+
+/* PCI domain-device relationship */
+struct device_domain_info {
+	struct list_head link;	/* link to domain siblings */
+	struct list_head global; /* link to global list */
+	struct list_head table;	/* link to pasid table */
+	struct list_head subdevices; /* subdevices sibling */
+	u32 segment;		/* PCI segment number */
+	u8 bus;			/* PCI bus number */
+	u8 devfn;		/* PCI devfn number */
+	u16 pfsid;		/* SRIOV physical function source ID */
+	u8 pasid_supported:3;
+	u8 pasid_enabled:1;
+	u8 pri_supported:1;
+	u8 pri_enabled:1;
+	u8 ats_supported:1;
+	u8 ats_enabled:1;
+	u8 auxd_enabled:1;	/* Multiple domains per device */
+	u8 ats_qdep;
+	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
+	struct intel_iommu *iommu; /* IOMMU used by this device */
+	struct dmar_domain *domain; /* pointer to domain */
+	struct pasid_table *pasid_table; /* pasid table */
+};
+
+static inline void __iommu_flush_cache(
+	struct intel_iommu *iommu, void *addr, int size)
+{
+	if (!ecap_coherent(iommu->ecap))
+		clflush_cache_range(addr, size);
+}
+
+/* Convert generic struct iommu_domain to private struct dmar_domain */
+static inline struct dmar_domain *to_dmar_domain(struct iommu_domain *dom)
+{
+	return container_of(dom, struct dmar_domain, domain);
+}
+
+/*
+ * 0: readable
+ * 1: writable
+ * 2-6: reserved
+ * 7: super page
+ * 8-10: available
+ * 11: snoop behavior
+ * 12-63: Host physical address
+ */
+struct dma_pte {
+	u64 val;
+};
+
+static inline void dma_clear_pte(struct dma_pte *pte)
+{
+	pte->val = 0;
+}
+
+static inline u64 dma_pte_addr(struct dma_pte *pte)
+{
+#ifdef CONFIG_64BIT
+	return pte->val & VTD_PAGE_MASK & (~DMA_FL_PTE_XD);
+#else
+	/* Must have a full atomic 64-bit read */
+	return  __cmpxchg64(&pte->val, 0ULL, 0ULL) &
+			VTD_PAGE_MASK & (~DMA_FL_PTE_XD);
+#endif
+}
+
+static inline bool dma_pte_present(struct dma_pte *pte)
+{
+	return (pte->val & 3) != 0;
+}
+
+static inline bool dma_pte_superpage(struct dma_pte *pte)
+{
+	return (pte->val & DMA_PTE_LARGE_PAGE);
+}
+
+static inline int first_pte_in_page(struct dma_pte *pte)
+{
+	return !((unsigned long)pte & ~VTD_PAGE_MASK);
+}
+
+static inline bool context_present(struct context_entry *context)
+{
+	return (context->lo & 1);
+}
+
+extern struct dmar_drhd_unit * dmar_find_matched_drhd_unit(struct pci_dev *dev);
+extern int dmar_find_matched_atsr_unit(struct pci_dev *dev);
+
+extern int dmar_enable_qi(struct intel_iommu *iommu);
+extern void dmar_disable_qi(struct intel_iommu *iommu);
+extern int dmar_reenable_qi(struct intel_iommu *iommu);
+extern void qi_global_iec(struct intel_iommu *iommu);
+
+extern void qi_flush_context(struct intel_iommu *iommu, u16 did, u16 sid,
+			     u8 fm, u64 type);
+extern void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
+			  unsigned int size_order, u64 type);
+extern void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
+			u16 qdep, u64 addr, unsigned mask);
+
+void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64 addr,
+		     unsigned long npages, bool ih);
+
+void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
+			      u32 pasid, u16 qdep, u64 addr,
+			      unsigned int size_order);
+void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did, u64 granu,
+			  u32 pasid);
+
+int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
+		   unsigned int count, unsigned long options);
+/*
+ * Options used in qi_submit_sync:
+ * QI_OPT_WAIT_DRAIN - Wait for PRQ drain completion, spec 6.5.2.8.
+ */
+#define QI_OPT_WAIT_DRAIN		BIT(0)
+
+extern int dmar_ir_support(void);
+
+void *alloc_pgtable_page(int node);
+void free_pgtable_page(void *vaddr);
+struct intel_iommu *domain_get_iommu(struct dmar_domain *domain);
+int for_each_device_domain(int (*fn)(struct device_domain_info *info,
+				     void *data), void *data);
+void iommu_flush_write_buffer(struct intel_iommu *iommu);
+int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev);
+struct dmar_domain *find_domain(struct device *dev);
+struct device_domain_info *get_domain_info(struct device *dev);
+struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn);
+
+#ifdef CONFIG_INTEL_IOMMU_SVM
+extern void intel_svm_check(struct intel_iommu *iommu);
+extern int intel_svm_enable_prq(struct intel_iommu *iommu);
+extern int intel_svm_finish_prq(struct intel_iommu *iommu);
+int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
+			  struct iommu_gpasid_bind_data *data);
+int intel_svm_unbind_gpasid(struct device *dev, u32 pasid);
+struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *mm,
+				 void *drvdata);
+void intel_svm_unbind(struct iommu_sva *handle);
+u32 intel_svm_get_pasid(struct iommu_sva *handle);
+int intel_svm_page_response(struct device *dev, struct iommu_fault_event *evt,
+			    struct iommu_page_response *msg);
+
+struct intel_svm_dev {
+	struct list_head list;
+	struct rcu_head rcu;
+	struct device *dev;
+	struct intel_iommu *iommu;
+	struct iommu_sva sva;
+	unsigned long prq_seq_number;
+	u32 pasid;
+	int users;
+	u16 did;
+	u16 dev_iotlb:1;
+	u16 sid, qdep;
+};
+
+struct intel_svm {
+	struct mmu_notifier notifier;
+	struct mm_struct *mm;
+
+	unsigned int flags;
+	u32 pasid;
+	int gpasid; /* In case that guest PASID is different from host PASID */
+	struct list_head devs;
+};
+#else
+static inline void intel_svm_check(struct intel_iommu *iommu) {}
+#endif
+
+#ifdef CONFIG_INTEL_IOMMU_DEBUGFS
+void intel_iommu_debugfs_init(void);
+#else
+static inline void intel_iommu_debugfs_init(void) {}
+#endif /* CONFIG_INTEL_IOMMU_DEBUGFS */
+
+extern const struct attribute_group *intel_iommu_groups[];
+struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
+					 u8 devfn, int alloc);
+
+#ifdef CONFIG_INTEL_IOMMU
+extern int iommu_calculate_agaw(struct intel_iommu *iommu);
+extern int iommu_calculate_max_sagaw(struct intel_iommu *iommu);
+extern int intel_iommu_gfx_mapped;
+extern int intel_iommu_sm;
+
+extern int dmar_disabled;
+extern int intel_iommu_enabled;
+#else
+static inline int iommu_calculate_agaw(struct intel_iommu *iommu)
+{
+	return 0;
+}
+static inline int iommu_calculate_max_sagaw(struct intel_iommu *iommu)
+{
+	return 0;
+}
+#define dmar_disabled	(1)
+#define intel_iommu_enabled (0)
+#define intel_iommu_sm (0)
+#endif
+
+static inline const char *decode_prq_descriptor(char *str, size_t size,
+		u64 dw0, u64 dw1, u64 dw2, u64 dw3)
+{
+	char *buf = str;
+	int bytes;
+
+	bytes = snprintf(buf, size,
+			 "rid=0x%llx addr=0x%llx %c%c%c%c%c pasid=0x%llx index=0x%llx",
+			 FIELD_GET(GENMASK_ULL(31, 16), dw0),
+			 FIELD_GET(GENMASK_ULL(63, 12), dw1),
+			 dw1 & BIT_ULL(0) ? 'r' : '-',
+			 dw1 & BIT_ULL(1) ? 'w' : '-',
+			 dw0 & BIT_ULL(52) ? 'x' : '-',
+			 dw0 & BIT_ULL(53) ? 'p' : '-',
+			 dw1 & BIT_ULL(2) ? 'l' : '-',
+			 FIELD_GET(GENMASK_ULL(51, 32), dw0),
+			 FIELD_GET(GENMASK_ULL(11, 3), dw1));
+
+	/* Private Data */
+	if (dw0 & BIT_ULL(9)) {
+		size -= bytes;
+		buf += bytes;
+		snprintf(buf, size, " private=0x%llx/0x%llx\n", dw2, dw3);
+	}
+
+	return str;
+}
+
+#endif
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index e04436a7ff271..c4485252d0b81 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -121,7 +121,7 @@ extern int dmar_remove_dev_scope(struct dmar_pci_notify_info *info,
 				 u16 segment, struct dmar_dev_scope *devices,
 				 int count);
 /* Intel IOMMU detection */
-extern int detect_intel_iommu(void);
+void detect_intel_iommu(void);
 extern int enable_drhd_fault_handling(void);
 extern int dmar_device_add(acpi_handle handle);
 extern int dmar_device_remove(acpi_handle handle);
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index e00857c4efc28..66034335284be 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -1,860 +1,3 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright © 2006-2015, Intel Corporation.
- *
- * Authors: Ashok Raj <ashok.raj@intel.com>
- *          Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
- *          David Woodhouse <David.Woodhouse@intel.com>
- */
-
-#ifndef _INTEL_IOMMU_H_
-#define _INTEL_IOMMU_H_
-
-#include <linux/types.h>
-#include <linux/iova.h>
-#include <linux/io.h>
-#include <linux/idr.h>
-#include <linux/mmu_notifier.h>
-#include <linux/list.h>
-#include <linux/iommu.h>
-#include <linux/io-64-nonatomic-lo-hi.h>
-#include <linux/dmar.h>
-#include <linux/ioasid.h>
-#include <linux/bitfield.h>
-
-#include <asm/cacheflush.h>
-#include <asm/iommu.h>
-
-/*
- * VT-d hardware uses 4KiB page size regardless of host page size.
- */
-#define VTD_PAGE_SHIFT		(12)
-#define VTD_PAGE_SIZE		(1UL << VTD_PAGE_SHIFT)
-#define VTD_PAGE_MASK		(((u64)-1) << VTD_PAGE_SHIFT)
-#define VTD_PAGE_ALIGN(addr)	(((addr) + VTD_PAGE_SIZE - 1) & VTD_PAGE_MASK)
-
-#define VTD_STRIDE_SHIFT        (9)
-#define VTD_STRIDE_MASK         (((u64)-1) << VTD_STRIDE_SHIFT)
-
-#define DMA_PTE_READ		BIT_ULL(0)
-#define DMA_PTE_WRITE		BIT_ULL(1)
-#define DMA_PTE_LARGE_PAGE	BIT_ULL(7)
-#define DMA_PTE_SNP		BIT_ULL(11)
-
-#define DMA_FL_PTE_PRESENT	BIT_ULL(0)
-#define DMA_FL_PTE_US		BIT_ULL(2)
-#define DMA_FL_PTE_ACCESS	BIT_ULL(5)
-#define DMA_FL_PTE_DIRTY	BIT_ULL(6)
-#define DMA_FL_PTE_XD		BIT_ULL(63)
-
-#define ADDR_WIDTH_5LEVEL	(57)
-#define ADDR_WIDTH_4LEVEL	(48)
-
-#define CONTEXT_TT_MULTI_LEVEL	0
-#define CONTEXT_TT_DEV_IOTLB	1
-#define CONTEXT_TT_PASS_THROUGH 2
-#define CONTEXT_PASIDE		BIT_ULL(3)
-
-/*
- * Intel IOMMU register specification per version 1.0 public spec.
- */
-#define	DMAR_VER_REG	0x0	/* Arch version supported by this IOMMU */
-#define	DMAR_CAP_REG	0x8	/* Hardware supported capabilities */
-#define	DMAR_ECAP_REG	0x10	/* Extended capabilities supported */
-#define	DMAR_GCMD_REG	0x18	/* Global command register */
-#define	DMAR_GSTS_REG	0x1c	/* Global status register */
-#define	DMAR_RTADDR_REG	0x20	/* Root entry table */
-#define	DMAR_CCMD_REG	0x28	/* Context command reg */
-#define	DMAR_FSTS_REG	0x34	/* Fault Status register */
-#define	DMAR_FECTL_REG	0x38	/* Fault control register */
-#define	DMAR_FEDATA_REG	0x3c	/* Fault event interrupt data register */
-#define	DMAR_FEADDR_REG	0x40	/* Fault event interrupt addr register */
-#define	DMAR_FEUADDR_REG 0x44	/* Upper address register */
-#define	DMAR_AFLOG_REG	0x58	/* Advanced Fault control */
-#define	DMAR_PMEN_REG	0x64	/* Enable Protected Memory Region */
-#define	DMAR_PLMBASE_REG 0x68	/* PMRR Low addr */
-#define	DMAR_PLMLIMIT_REG 0x6c	/* PMRR low limit */
-#define	DMAR_PHMBASE_REG 0x70	/* pmrr high base addr */
-#define	DMAR_PHMLIMIT_REG 0x78	/* pmrr high limit */
-#define DMAR_IQH_REG	0x80	/* Invalidation queue head register */
-#define DMAR_IQT_REG	0x88	/* Invalidation queue tail register */
-#define DMAR_IQ_SHIFT	4	/* Invalidation queue head/tail shift */
-#define DMAR_IQA_REG	0x90	/* Invalidation queue addr register */
-#define DMAR_ICS_REG	0x9c	/* Invalidation complete status register */
-#define DMAR_IQER_REG	0xb0	/* Invalidation queue error record register */
-#define DMAR_IRTA_REG	0xb8    /* Interrupt remapping table addr register */
-#define DMAR_PQH_REG	0xc0	/* Page request queue head register */
-#define DMAR_PQT_REG	0xc8	/* Page request queue tail register */
-#define DMAR_PQA_REG	0xd0	/* Page request queue address register */
-#define DMAR_PRS_REG	0xdc	/* Page request status register */
-#define DMAR_PECTL_REG	0xe0	/* Page request event control register */
-#define	DMAR_PEDATA_REG	0xe4	/* Page request event interrupt data register */
-#define	DMAR_PEADDR_REG	0xe8	/* Page request event interrupt addr register */
-#define	DMAR_PEUADDR_REG 0xec	/* Page request event Upper address register */
-#define DMAR_MTRRCAP_REG 0x100	/* MTRR capability register */
-#define DMAR_MTRRDEF_REG 0x108	/* MTRR default type register */
-#define DMAR_MTRR_FIX64K_00000_REG 0x120 /* MTRR Fixed range registers */
-#define DMAR_MTRR_FIX16K_80000_REG 0x128
-#define DMAR_MTRR_FIX16K_A0000_REG 0x130
-#define DMAR_MTRR_FIX4K_C0000_REG 0x138
-#define DMAR_MTRR_FIX4K_C8000_REG 0x140
-#define DMAR_MTRR_FIX4K_D0000_REG 0x148
-#define DMAR_MTRR_FIX4K_D8000_REG 0x150
-#define DMAR_MTRR_FIX4K_E0000_REG 0x158
-#define DMAR_MTRR_FIX4K_E8000_REG 0x160
-#define DMAR_MTRR_FIX4K_F0000_REG 0x168
-#define DMAR_MTRR_FIX4K_F8000_REG 0x170
-#define DMAR_MTRR_PHYSBASE0_REG 0x180 /* MTRR Variable range registers */
-#define DMAR_MTRR_PHYSMASK0_REG 0x188
-#define DMAR_MTRR_PHYSBASE1_REG 0x190
-#define DMAR_MTRR_PHYSMASK1_REG 0x198
-#define DMAR_MTRR_PHYSBASE2_REG 0x1a0
-#define DMAR_MTRR_PHYSMASK2_REG 0x1a8
-#define DMAR_MTRR_PHYSBASE3_REG 0x1b0
-#define DMAR_MTRR_PHYSMASK3_REG 0x1b8
-#define DMAR_MTRR_PHYSBASE4_REG 0x1c0
-#define DMAR_MTRR_PHYSMASK4_REG 0x1c8
-#define DMAR_MTRR_PHYSBASE5_REG 0x1d0
-#define DMAR_MTRR_PHYSMASK5_REG 0x1d8
-#define DMAR_MTRR_PHYSBASE6_REG 0x1e0
-#define DMAR_MTRR_PHYSMASK6_REG 0x1e8
-#define DMAR_MTRR_PHYSBASE7_REG 0x1f0
-#define DMAR_MTRR_PHYSMASK7_REG 0x1f8
-#define DMAR_MTRR_PHYSBASE8_REG 0x200
-#define DMAR_MTRR_PHYSMASK8_REG 0x208
-#define DMAR_MTRR_PHYSBASE9_REG 0x210
-#define DMAR_MTRR_PHYSMASK9_REG 0x218
-#define DMAR_VCCAP_REG		0xe30 /* Virtual command capability register */
-#define DMAR_VCMD_REG		0xe00 /* Virtual command register */
-#define DMAR_VCRSP_REG		0xe10 /* Virtual command response register */
-
-#define DMAR_IQER_REG_IQEI(reg)		FIELD_GET(GENMASK_ULL(3, 0), reg)
-#define DMAR_IQER_REG_ITESID(reg)	FIELD_GET(GENMASK_ULL(47, 32), reg)
-#define DMAR_IQER_REG_ICESID(reg)	FIELD_GET(GENMASK_ULL(63, 48), reg)
-
-#define OFFSET_STRIDE		(9)
-
-#define dmar_readq(a) readq(a)
-#define dmar_writeq(a,v) writeq(v,a)
-#define dmar_readl(a) readl(a)
-#define dmar_writel(a, v) writel(v, a)
-
-#define DMAR_VER_MAJOR(v)		(((v) & 0xf0) >> 4)
-#define DMAR_VER_MINOR(v)		((v) & 0x0f)
-
-/*
- * Decoding Capability Register
- */
-#define cap_5lp_support(c)	(((c) >> 60) & 1)
-#define cap_pi_support(c)	(((c) >> 59) & 1)
-#define cap_fl1gp_support(c)	(((c) >> 56) & 1)
-#define cap_read_drain(c)	(((c) >> 55) & 1)
-#define cap_write_drain(c)	(((c) >> 54) & 1)
-#define cap_max_amask_val(c)	(((c) >> 48) & 0x3f)
-#define cap_num_fault_regs(c)	((((c) >> 40) & 0xff) + 1)
-#define cap_pgsel_inv(c)	(((c) >> 39) & 1)
-
-#define cap_super_page_val(c)	(((c) >> 34) & 0xf)
-#define cap_super_offset(c)	(((find_first_bit(&cap_super_page_val(c), 4)) \
-					* OFFSET_STRIDE) + 21)
-
-#define cap_fault_reg_offset(c)	((((c) >> 24) & 0x3ff) * 16)
-#define cap_max_fault_reg_offset(c) \
-	(cap_fault_reg_offset(c) + cap_num_fault_regs(c) * 16)
-
-#define cap_zlr(c)		(((c) >> 22) & 1)
-#define cap_isoch(c)		(((c) >> 23) & 1)
-#define cap_mgaw(c)		((((c) >> 16) & 0x3f) + 1)
-#define cap_sagaw(c)		(((c) >> 8) & 0x1f)
-#define cap_caching_mode(c)	(((c) >> 7) & 1)
-#define cap_phmr(c)		(((c) >> 6) & 1)
-#define cap_plmr(c)		(((c) >> 5) & 1)
-#define cap_rwbf(c)		(((c) >> 4) & 1)
-#define cap_afl(c)		(((c) >> 3) & 1)
-#define cap_ndoms(c)		(((unsigned long)1) << (4 + 2 * ((c) & 0x7)))
-/*
- * Extended Capability Register
- */
-
-#define	ecap_rps(e)		(((e) >> 49) & 0x1)
-#define ecap_smpwc(e)		(((e) >> 48) & 0x1)
-#define ecap_flts(e)		(((e) >> 47) & 0x1)
-#define ecap_slts(e)		(((e) >> 46) & 0x1)
-#define ecap_slads(e)		(((e) >> 45) & 0x1)
-#define ecap_vcs(e)		(((e) >> 44) & 0x1)
-#define ecap_smts(e)		(((e) >> 43) & 0x1)
-#define ecap_dit(e)		(((e) >> 41) & 0x1)
-#define ecap_pds(e)		(((e) >> 42) & 0x1)
-#define ecap_pasid(e)		(((e) >> 40) & 0x1)
-#define ecap_pss(e)		(((e) >> 35) & 0x1f)
-#define ecap_eafs(e)		(((e) >> 34) & 0x1)
-#define ecap_nwfs(e)		(((e) >> 33) & 0x1)
-#define ecap_srs(e)		(((e) >> 31) & 0x1)
-#define ecap_ers(e)		(((e) >> 30) & 0x1)
-#define ecap_prs(e)		(((e) >> 29) & 0x1)
-#define ecap_broken_pasid(e)	(((e) >> 28) & 0x1)
-#define ecap_dis(e)		(((e) >> 27) & 0x1)
-#define ecap_nest(e)		(((e) >> 26) & 0x1)
-#define ecap_mts(e)		(((e) >> 25) & 0x1)
-#define ecap_iotlb_offset(e) 	((((e) >> 8) & 0x3ff) * 16)
-#define ecap_max_iotlb_offset(e) (ecap_iotlb_offset(e) + 16)
-#define ecap_coherent(e)	((e) & 0x1)
-#define ecap_qis(e)		((e) & 0x2)
-#define ecap_pass_through(e)	(((e) >> 6) & 0x1)
-#define ecap_eim_support(e)	(((e) >> 4) & 0x1)
-#define ecap_ir_support(e)	(((e) >> 3) & 0x1)
-#define ecap_dev_iotlb_support(e)	(((e) >> 2) & 0x1)
-#define ecap_max_handle_mask(e) (((e) >> 20) & 0xf)
-#define ecap_sc_support(e)	(((e) >> 7) & 0x1) /* Snooping Control */
-
-/* Virtual command interface capability */
-#define vccap_pasid(v)		(((v) & DMA_VCS_PAS)) /* PASID allocation */
-
-/* IOTLB_REG */
-#define DMA_TLB_FLUSH_GRANU_OFFSET  60
-#define DMA_TLB_GLOBAL_FLUSH (((u64)1) << 60)
-#define DMA_TLB_DSI_FLUSH (((u64)2) << 60)
-#define DMA_TLB_PSI_FLUSH (((u64)3) << 60)
-#define DMA_TLB_IIRG(type) ((type >> 60) & 3)
-#define DMA_TLB_IAIG(val) (((val) >> 57) & 3)
-#define DMA_TLB_READ_DRAIN (((u64)1) << 49)
-#define DMA_TLB_WRITE_DRAIN (((u64)1) << 48)
-#define DMA_TLB_DID(id)	(((u64)((id) & 0xffff)) << 32)
-#define DMA_TLB_IVT (((u64)1) << 63)
-#define DMA_TLB_IH_NONLEAF (((u64)1) << 6)
-#define DMA_TLB_MAX_SIZE (0x3f)
-
-/* INVALID_DESC */
-#define DMA_CCMD_INVL_GRANU_OFFSET  61
-#define DMA_ID_TLB_GLOBAL_FLUSH	(((u64)1) << 4)
-#define DMA_ID_TLB_DSI_FLUSH	(((u64)2) << 4)
-#define DMA_ID_TLB_PSI_FLUSH	(((u64)3) << 4)
-#define DMA_ID_TLB_READ_DRAIN	(((u64)1) << 7)
-#define DMA_ID_TLB_WRITE_DRAIN	(((u64)1) << 6)
-#define DMA_ID_TLB_DID(id)	(((u64)((id & 0xffff) << 16)))
-#define DMA_ID_TLB_IH_NONLEAF	(((u64)1) << 6)
-#define DMA_ID_TLB_ADDR(addr)	(addr)
-#define DMA_ID_TLB_ADDR_MASK(mask)	(mask)
-
-/* PMEN_REG */
-#define DMA_PMEN_EPM (((u32)1)<<31)
-#define DMA_PMEN_PRS (((u32)1)<<0)
-
-/* GCMD_REG */
-#define DMA_GCMD_TE (((u32)1) << 31)
-#define DMA_GCMD_SRTP (((u32)1) << 30)
-#define DMA_GCMD_SFL (((u32)1) << 29)
-#define DMA_GCMD_EAFL (((u32)1) << 28)
-#define DMA_GCMD_WBF (((u32)1) << 27)
-#define DMA_GCMD_QIE (((u32)1) << 26)
-#define DMA_GCMD_SIRTP (((u32)1) << 24)
-#define DMA_GCMD_IRE (((u32) 1) << 25)
-#define DMA_GCMD_CFI (((u32) 1) << 23)
-
-/* GSTS_REG */
-#define DMA_GSTS_TES (((u32)1) << 31)
-#define DMA_GSTS_RTPS (((u32)1) << 30)
-#define DMA_GSTS_FLS (((u32)1) << 29)
-#define DMA_GSTS_AFLS (((u32)1) << 28)
-#define DMA_GSTS_WBFS (((u32)1) << 27)
-#define DMA_GSTS_QIES (((u32)1) << 26)
-#define DMA_GSTS_IRTPS (((u32)1) << 24)
-#define DMA_GSTS_IRES (((u32)1) << 25)
-#define DMA_GSTS_CFIS (((u32)1) << 23)
-
-/* DMA_RTADDR_REG */
-#define DMA_RTADDR_SMT (((u64)1) << 10)
-
-/* CCMD_REG */
-#define DMA_CCMD_ICC (((u64)1) << 63)
-#define DMA_CCMD_GLOBAL_INVL (((u64)1) << 61)
-#define DMA_CCMD_DOMAIN_INVL (((u64)2) << 61)
-#define DMA_CCMD_DEVICE_INVL (((u64)3) << 61)
-#define DMA_CCMD_FM(m) (((u64)((m) & 0x3)) << 32)
-#define DMA_CCMD_MASK_NOBIT 0
-#define DMA_CCMD_MASK_1BIT 1
-#define DMA_CCMD_MASK_2BIT 2
-#define DMA_CCMD_MASK_3BIT 3
-#define DMA_CCMD_SID(s) (((u64)((s) & 0xffff)) << 16)
-#define DMA_CCMD_DID(d) ((u64)((d) & 0xffff))
-
-/* FECTL_REG */
-#define DMA_FECTL_IM (((u32)1) << 31)
-
-/* FSTS_REG */
-#define DMA_FSTS_PFO (1 << 0) /* Primary Fault Overflow */
-#define DMA_FSTS_PPF (1 << 1) /* Primary Pending Fault */
-#define DMA_FSTS_IQE (1 << 4) /* Invalidation Queue Error */
-#define DMA_FSTS_ICE (1 << 5) /* Invalidation Completion Error */
-#define DMA_FSTS_ITE (1 << 6) /* Invalidation Time-out Error */
-#define DMA_FSTS_PRO (1 << 7) /* Page Request Overflow */
-#define dma_fsts_fault_record_index(s) (((s) >> 8) & 0xff)
-
-/* FRCD_REG, 32 bits access */
-#define DMA_FRCD_F (((u32)1) << 31)
-#define dma_frcd_type(d) ((d >> 30) & 1)
-#define dma_frcd_fault_reason(c) (c & 0xff)
-#define dma_frcd_source_id(c) (c & 0xffff)
-#define dma_frcd_pasid_value(c) (((c) >> 8) & 0xfffff)
-#define dma_frcd_pasid_present(c) (((c) >> 31) & 1)
-/* low 64 bit */
-#define dma_frcd_page_addr(d) (d & (((u64)-1) << PAGE_SHIFT))
-
-/* PRS_REG */
-#define DMA_PRS_PPR	((u32)1)
-#define DMA_PRS_PRO	((u32)2)
-
-#define DMA_VCS_PAS	((u64)1)
-
-#define IOMMU_WAIT_OP(iommu, offset, op, cond, sts)			\
-do {									\
-	cycles_t start_time = get_cycles();				\
-	while (1) {							\
-		sts = op(iommu->reg + offset);				\
-		if (cond)						\
-			break;						\
-		if (DMAR_OPERATION_TIMEOUT < (get_cycles() - start_time))\
-			panic("DMAR hardware is malfunctioning\n");	\
-		cpu_relax();						\
-	}								\
-} while (0)
-
-#define QI_LENGTH	256	/* queue length */
-
-enum {
-	QI_FREE,
-	QI_IN_USE,
-	QI_DONE,
-	QI_ABORT
-};
-
-#define QI_CC_TYPE		0x1
-#define QI_IOTLB_TYPE		0x2
-#define QI_DIOTLB_TYPE		0x3
-#define QI_IEC_TYPE		0x4
-#define QI_IWD_TYPE		0x5
-#define QI_EIOTLB_TYPE		0x6
-#define QI_PC_TYPE		0x7
-#define QI_DEIOTLB_TYPE		0x8
-#define QI_PGRP_RESP_TYPE	0x9
-#define QI_PSTRM_RESP_TYPE	0xa
-
-#define QI_IEC_SELECTIVE	(((u64)1) << 4)
-#define QI_IEC_IIDEX(idx)	(((u64)(idx & 0xffff) << 32))
-#define QI_IEC_IM(m)		(((u64)(m & 0x1f) << 27))
-
-#define QI_IWD_STATUS_DATA(d)	(((u64)d) << 32)
-#define QI_IWD_STATUS_WRITE	(((u64)1) << 5)
-#define QI_IWD_FENCE		(((u64)1) << 6)
-#define QI_IWD_PRQ_DRAIN	(((u64)1) << 7)
-
-#define QI_IOTLB_DID(did) 	(((u64)did) << 16)
-#define QI_IOTLB_DR(dr) 	(((u64)dr) << 7)
-#define QI_IOTLB_DW(dw) 	(((u64)dw) << 6)
-#define QI_IOTLB_GRAN(gran) 	(((u64)gran) >> (DMA_TLB_FLUSH_GRANU_OFFSET-4))
-#define QI_IOTLB_ADDR(addr)	(((u64)addr) & VTD_PAGE_MASK)
-#define QI_IOTLB_IH(ih)		(((u64)ih) << 6)
-#define QI_IOTLB_AM(am)		(((u8)am) & 0x3f)
-
-#define QI_CC_FM(fm)		(((u64)fm) << 48)
-#define QI_CC_SID(sid)		(((u64)sid) << 32)
-#define QI_CC_DID(did)		(((u64)did) << 16)
-#define QI_CC_GRAN(gran)	(((u64)gran) >> (DMA_CCMD_INVL_GRANU_OFFSET-4))
-
-#define QI_DEV_IOTLB_SID(sid)	((u64)((sid) & 0xffff) << 32)
-#define QI_DEV_IOTLB_QDEP(qdep)	(((qdep) & 0x1f) << 16)
-#define QI_DEV_IOTLB_ADDR(addr)	((u64)(addr) & VTD_PAGE_MASK)
-#define QI_DEV_IOTLB_PFSID(pfsid) (((u64)(pfsid & 0xf) << 12) | \
-				   ((u64)((pfsid >> 4) & 0xfff) << 52))
-#define QI_DEV_IOTLB_SIZE	1
-#define QI_DEV_IOTLB_MAX_INVS	32
-
-#define QI_PC_PASID(pasid)	(((u64)pasid) << 32)
-#define QI_PC_DID(did)		(((u64)did) << 16)
-#define QI_PC_GRAN(gran)	(((u64)gran) << 4)
-
-/* PASID cache invalidation granu */
-#define QI_PC_ALL_PASIDS	0
-#define QI_PC_PASID_SEL		1
-#define QI_PC_GLOBAL		3
-
-#define QI_EIOTLB_ADDR(addr)	((u64)(addr) & VTD_PAGE_MASK)
-#define QI_EIOTLB_IH(ih)	(((u64)ih) << 6)
-#define QI_EIOTLB_AM(am)	(((u64)am) & 0x3f)
-#define QI_EIOTLB_PASID(pasid) 	(((u64)pasid) << 32)
-#define QI_EIOTLB_DID(did)	(((u64)did) << 16)
-#define QI_EIOTLB_GRAN(gran) 	(((u64)gran) << 4)
-
-/* QI Dev-IOTLB inv granu */
-#define QI_DEV_IOTLB_GRAN_ALL		1
-#define QI_DEV_IOTLB_GRAN_PASID_SEL	0
-
-#define QI_DEV_EIOTLB_ADDR(a)	((u64)(a) & VTD_PAGE_MASK)
-#define QI_DEV_EIOTLB_SIZE	(((u64)1) << 11)
-#define QI_DEV_EIOTLB_PASID(p)	((u64)((p) & 0xfffff) << 32)
-#define QI_DEV_EIOTLB_SID(sid)	((u64)((sid) & 0xffff) << 16)
-#define QI_DEV_EIOTLB_QDEP(qd)	((u64)((qd) & 0x1f) << 4)
-#define QI_DEV_EIOTLB_PFSID(pfsid) (((u64)(pfsid & 0xf) << 12) | \
-				    ((u64)((pfsid >> 4) & 0xfff) << 52))
-#define QI_DEV_EIOTLB_MAX_INVS	32
-
-/* Page group response descriptor QW0 */
-#define QI_PGRP_PASID_P(p)	(((u64)(p)) << 4)
-#define QI_PGRP_PDP(p)		(((u64)(p)) << 5)
-#define QI_PGRP_RESP_CODE(res)	(((u64)(res)) << 12)
-#define QI_PGRP_DID(rid)	(((u64)(rid)) << 16)
-#define QI_PGRP_PASID(pasid)	(((u64)(pasid)) << 32)
-
-/* Page group response descriptor QW1 */
-#define QI_PGRP_LPIG(x)		(((u64)(x)) << 2)
-#define QI_PGRP_IDX(idx)	(((u64)(idx)) << 3)
-
-
-#define QI_RESP_SUCCESS		0x0
-#define QI_RESP_INVALID		0x1
-#define QI_RESP_FAILURE		0xf
-
-#define QI_GRAN_NONG_PASID		2
-#define QI_GRAN_PSI_PASID		3
-
-#define qi_shift(iommu)		(DMAR_IQ_SHIFT + !!ecap_smts((iommu)->ecap))
-
-struct qi_desc {
-	u64 qw0;
-	u64 qw1;
-	u64 qw2;
-	u64 qw3;
-};
-
-struct q_inval {
-	raw_spinlock_t  q_lock;
-	void		*desc;          /* invalidation queue */
-	int             *desc_status;   /* desc status */
-	int             free_head;      /* first free entry */
-	int             free_tail;      /* last free entry */
-	int             free_cnt;
-};
-
-struct dmar_pci_notify_info;
-
-#ifdef CONFIG_IRQ_REMAP
-/* 1MB - maximum possible interrupt remapping table size */
-#define INTR_REMAP_PAGE_ORDER	8
-#define INTR_REMAP_TABLE_REG_SIZE	0xf
-#define INTR_REMAP_TABLE_REG_SIZE_MASK  0xf
-
-#define INTR_REMAP_TABLE_ENTRIES	65536
-
-struct irq_domain;
-
-struct ir_table {
-	struct irte *base;
-	unsigned long *bitmap;
-};
-
-void intel_irq_remap_add_device(struct dmar_pci_notify_info *info);
-#else
-static inline void
-intel_irq_remap_add_device(struct dmar_pci_notify_info *info) { }
-#endif
-
-struct iommu_flush {
-	void (*flush_context)(struct intel_iommu *iommu, u16 did, u16 sid,
-			      u8 fm, u64 type);
-	void (*flush_iotlb)(struct intel_iommu *iommu, u16 did, u64 addr,
-			    unsigned int size_order, u64 type);
-};
-
-enum {
-	SR_DMAR_FECTL_REG,
-	SR_DMAR_FEDATA_REG,
-	SR_DMAR_FEADDR_REG,
-	SR_DMAR_FEUADDR_REG,
-	MAX_SR_DMAR_REGS
-};
-
-#define VTD_FLAG_TRANS_PRE_ENABLED	(1 << 0)
-#define VTD_FLAG_IRQ_REMAP_PRE_ENABLED	(1 << 1)
-#define VTD_FLAG_SVM_CAPABLE		(1 << 2)
-
-extern int intel_iommu_sm;
-extern spinlock_t device_domain_lock;
-
-#define sm_supported(iommu)	(intel_iommu_sm && ecap_smts((iommu)->ecap))
-#define pasid_supported(iommu)	(sm_supported(iommu) &&			\
-				 ecap_pasid((iommu)->ecap))
-
-struct pasid_entry;
-struct pasid_state_entry;
-struct page_req_dsc;
-
-/*
- * 0: Present
- * 1-11: Reserved
- * 12-63: Context Ptr (12 - (haw-1))
- * 64-127: Reserved
- */
-struct root_entry {
-	u64     lo;
-	u64     hi;
-};
-
-/*
- * low 64 bits:
- * 0: present
- * 1: fault processing disable
- * 2-3: translation type
- * 12-63: address space root
- * high 64 bits:
- * 0-2: address width
- * 3-6: aval
- * 8-23: domain id
- */
-struct context_entry {
-	u64 lo;
-	u64 hi;
-};
-
-/*
- * When VT-d works in the scalable mode, it allows DMA translation to
- * happen through either first level or second level page table. This
- * bit marks that the DMA translation for the domain goes through the
- * first level page table, otherwise, it goes through the second level.
- */
-#define DOMAIN_FLAG_USE_FIRST_LEVEL		BIT(1)
-
-/*
- * Domain represents a virtual machine which demands iommu nested
- * translation mode support.
- */
-#define DOMAIN_FLAG_NESTING_MODE		BIT(2)
-
-struct dmar_domain {
-	int	nid;			/* node id */
-
-	unsigned int iommu_refcnt[DMAR_UNITS_SUPPORTED];
-					/* Refcount of devices per iommu */
-
-
-	u16		iommu_did[DMAR_UNITS_SUPPORTED];
-					/* Domain ids per IOMMU. Use u16 since
-					 * domain ids are 16 bit wide according
-					 * to VT-d spec, section 9.3 */
-
-	u8 has_iotlb_device: 1;
-	u8 iommu_coherency: 1;		/* indicate coherency of iommu access */
-	u8 iommu_snooping: 1;		/* indicate snooping control feature */
-
-	struct list_head devices;	/* all devices' list */
-	struct list_head subdevices;	/* all subdevices' list */
-	struct iova_domain iovad;	/* iova's that belong to this domain */
-
-	struct dma_pte	*pgd;		/* virtual address */
-	int		gaw;		/* max guest address width */
-
-	/* adjusted guest address width, 0 is level 2 30-bit */
-	int		agaw;
-
-	int		flags;		/* flags to find out type of domain */
-	int		iommu_superpage;/* Level of superpages supported:
-					   0 == 4KiB (no superpages), 1 == 2MiB,
-					   2 == 1GiB, 3 == 512GiB, 4 == 1TiB */
-	u64		max_addr;	/* maximum mapped address */
-
-	u32		default_pasid;	/*
-					 * The default pasid used for non-SVM
-					 * traffic on mediated devices.
-					 */
-
-	struct iommu_domain domain;	/* generic domain data structure for
-					   iommu core */
-};
-
-struct intel_iommu {
-	void __iomem	*reg; /* Pointer to hardware regs, virtual addr */
-	u64 		reg_phys; /* physical address of hw register set */
-	u64		reg_size; /* size of hw register set */
-	u64		cap;
-	u64		ecap;
-	u64		vccap;
-	u32		gcmd; /* Holds TE, EAFL. Don't need SRTP, SFL, WBF */
-	raw_spinlock_t	register_lock; /* protect register handling */
-	int		seq_id;	/* sequence id of the iommu */
-	int		agaw; /* agaw of this iommu */
-	int		msagaw; /* max sagaw of this iommu */
-	unsigned int 	irq, pr_irq;
-	u16		segment;     /* PCI segment# */
-	unsigned char 	name[13];    /* Device Name */
-
-#ifdef CONFIG_INTEL_IOMMU
-	unsigned long 	*domain_ids; /* bitmap of domains */
-	struct dmar_domain ***domains; /* ptr to domains */
-	unsigned long	*copied_tables; /* bitmap of copied tables */
-	spinlock_t	lock; /* protect context, domain ids */
-	struct root_entry *root_entry; /* virtual address */
-
-	struct iommu_flush flush;
-#endif
-#ifdef CONFIG_INTEL_IOMMU_SVM
-	struct page_req_dsc *prq;
-	unsigned char prq_name[16];    /* Name for PRQ interrupt */
-	struct completion prq_complete;
-	struct ioasid_allocator_ops pasid_allocator; /* Custom allocator for PASIDs */
-#endif
-	struct iopf_queue *iopf_queue;
-	unsigned char iopfq_name[16];
-	struct q_inval  *qi;            /* Queued invalidation info */
-	u32 iommu_state[MAX_SR_DMAR_REGS]; /* Store iommu states between suspend and resume.*/
-
-#ifdef CONFIG_IRQ_REMAP
-	struct ir_table *ir_table;	/* Interrupt remapping info */
-	struct irq_domain *ir_domain;
-	struct irq_domain *ir_msi_domain;
-#endif
-	struct iommu_device iommu;  /* IOMMU core code handle */
-	int		node;
-	u32		flags;      /* Software defined flags */
-
-	struct dmar_drhd_unit *drhd;
-	void *perf_statistic;
-};
-
-/* Per subdevice private data */
-struct subdev_domain_info {
-	struct list_head link_phys;	/* link to phys device siblings */
-	struct list_head link_domain;	/* link to domain siblings */
-	struct device *pdev;		/* physical device derived from */
-	struct dmar_domain *domain;	/* aux-domain */
-	int users;			/* user count */
-};
-
-/* PCI domain-device relationship */
-struct device_domain_info {
-	struct list_head link;	/* link to domain siblings */
-	struct list_head global; /* link to global list */
-	struct list_head table;	/* link to pasid table */
-	struct list_head subdevices; /* subdevices sibling */
-	u32 segment;		/* PCI segment number */
-	u8 bus;			/* PCI bus number */
-	u8 devfn;		/* PCI devfn number */
-	u16 pfsid;		/* SRIOV physical function source ID */
-	u8 pasid_supported:3;
-	u8 pasid_enabled:1;
-	u8 pri_supported:1;
-	u8 pri_enabled:1;
-	u8 ats_supported:1;
-	u8 ats_enabled:1;
-	u8 auxd_enabled:1;	/* Multiple domains per device */
-	u8 ats_qdep;
-	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
-	struct intel_iommu *iommu; /* IOMMU used by this device */
-	struct dmar_domain *domain; /* pointer to domain */
-	struct pasid_table *pasid_table; /* pasid table */
-};
-
-static inline void __iommu_flush_cache(
-	struct intel_iommu *iommu, void *addr, int size)
-{
-	if (!ecap_coherent(iommu->ecap))
-		clflush_cache_range(addr, size);
-}
-
-/* Convert generic struct iommu_domain to private struct dmar_domain */
-static inline struct dmar_domain *to_dmar_domain(struct iommu_domain *dom)
-{
-	return container_of(dom, struct dmar_domain, domain);
-}
-
-/*
- * 0: readable
- * 1: writable
- * 2-6: reserved
- * 7: super page
- * 8-10: available
- * 11: snoop behavior
- * 12-63: Host physical address
- */
-struct dma_pte {
-	u64 val;
-};
-
-static inline void dma_clear_pte(struct dma_pte *pte)
-{
-	pte->val = 0;
-}
-
-static inline u64 dma_pte_addr(struct dma_pte *pte)
-{
-#ifdef CONFIG_64BIT
-	return pte->val & VTD_PAGE_MASK & (~DMA_FL_PTE_XD);
-#else
-	/* Must have a full atomic 64-bit read */
-	return  __cmpxchg64(&pte->val, 0ULL, 0ULL) &
-			VTD_PAGE_MASK & (~DMA_FL_PTE_XD);
-#endif
-}
-
-static inline bool dma_pte_present(struct dma_pte *pte)
-{
-	return (pte->val & 3) != 0;
-}
-
-static inline bool dma_pte_superpage(struct dma_pte *pte)
-{
-	return (pte->val & DMA_PTE_LARGE_PAGE);
-}
-
-static inline int first_pte_in_page(struct dma_pte *pte)
-{
-	return !((unsigned long)pte & ~VTD_PAGE_MASK);
-}
-
-static inline bool context_present(struct context_entry *context)
-{
-	return (context->lo & 1);
-}
-
-extern struct dmar_drhd_unit * dmar_find_matched_drhd_unit(struct pci_dev *dev);
-extern int dmar_find_matched_atsr_unit(struct pci_dev *dev);
-
-extern int dmar_enable_qi(struct intel_iommu *iommu);
-extern void dmar_disable_qi(struct intel_iommu *iommu);
-extern int dmar_reenable_qi(struct intel_iommu *iommu);
-extern void qi_global_iec(struct intel_iommu *iommu);
-
-extern void qi_flush_context(struct intel_iommu *iommu, u16 did, u16 sid,
-			     u8 fm, u64 type);
-extern void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
-			  unsigned int size_order, u64 type);
-extern void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
-			u16 qdep, u64 addr, unsigned mask);
-
-void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64 addr,
-		     unsigned long npages, bool ih);
-
-void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
-			      u32 pasid, u16 qdep, u64 addr,
-			      unsigned int size_order);
-void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did, u64 granu,
-			  u32 pasid);
-
-int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
-		   unsigned int count, unsigned long options);
-/*
- * Options used in qi_submit_sync:
- * QI_OPT_WAIT_DRAIN - Wait for PRQ drain completion, spec 6.5.2.8.
- */
-#define QI_OPT_WAIT_DRAIN		BIT(0)
-
-extern int dmar_ir_support(void);
-
-void *alloc_pgtable_page(int node);
-void free_pgtable_page(void *vaddr);
-struct intel_iommu *domain_get_iommu(struct dmar_domain *domain);
-int for_each_device_domain(int (*fn)(struct device_domain_info *info,
-				     void *data), void *data);
-void iommu_flush_write_buffer(struct intel_iommu *iommu);
-int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev);
-struct dmar_domain *find_domain(struct device *dev);
-struct device_domain_info *get_domain_info(struct device *dev);
-struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn);
-
-#ifdef CONFIG_INTEL_IOMMU_SVM
-extern void intel_svm_check(struct intel_iommu *iommu);
-extern int intel_svm_enable_prq(struct intel_iommu *iommu);
-extern int intel_svm_finish_prq(struct intel_iommu *iommu);
-int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
-			  struct iommu_gpasid_bind_data *data);
-int intel_svm_unbind_gpasid(struct device *dev, u32 pasid);
-struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *mm,
-				 void *drvdata);
-void intel_svm_unbind(struct iommu_sva *handle);
-u32 intel_svm_get_pasid(struct iommu_sva *handle);
-int intel_svm_page_response(struct device *dev, struct iommu_fault_event *evt,
-			    struct iommu_page_response *msg);
-
-struct intel_svm_dev {
-	struct list_head list;
-	struct rcu_head rcu;
-	struct device *dev;
-	struct intel_iommu *iommu;
-	struct iommu_sva sva;
-	unsigned long prq_seq_number;
-	u32 pasid;
-	int users;
-	u16 did;
-	u16 dev_iotlb:1;
-	u16 sid, qdep;
-};
-
-struct intel_svm {
-	struct mmu_notifier notifier;
-	struct mm_struct *mm;
-
-	unsigned int flags;
-	u32 pasid;
-	int gpasid; /* In case that guest PASID is different from host PASID */
-	struct list_head devs;
-};
-#else
-static inline void intel_svm_check(struct intel_iommu *iommu) {}
-#endif
-
-#ifdef CONFIG_INTEL_IOMMU_DEBUGFS
-void intel_iommu_debugfs_init(void);
-#else
-static inline void intel_iommu_debugfs_init(void) {}
-#endif /* CONFIG_INTEL_IOMMU_DEBUGFS */
-
-extern const struct attribute_group *intel_iommu_groups[];
-struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
-					 u8 devfn, int alloc);
-
-#ifdef CONFIG_INTEL_IOMMU
-extern int iommu_calculate_agaw(struct intel_iommu *iommu);
-extern int iommu_calculate_max_sagaw(struct intel_iommu *iommu);
-extern int dmar_disabled;
-extern int intel_iommu_enabled;
-extern int intel_iommu_gfx_mapped;
-#else
-static inline int iommu_calculate_agaw(struct intel_iommu *iommu)
-{
-	return 0;
-}
-static inline int iommu_calculate_max_sagaw(struct intel_iommu *iommu)
-{
-	return 0;
-}
-#define dmar_disabled	(1)
-#define intel_iommu_enabled (0)
-#endif
-
-static inline const char *decode_prq_descriptor(char *str, size_t size,
-		u64 dw0, u64 dw1, u64 dw2, u64 dw3)
-{
-	char *buf = str;
-	int bytes;
-
-	bytes = snprintf(buf, size,
-			 "rid=0x%llx addr=0x%llx %c%c%c%c%c pasid=0x%llx index=0x%llx",
-			 FIELD_GET(GENMASK_ULL(31, 16), dw0),
-			 FIELD_GET(GENMASK_ULL(63, 12), dw1),
-			 dw1 & BIT_ULL(0) ? 'r' : '-',
-			 dw1 & BIT_ULL(1) ? 'w' : '-',
-			 dw0 & BIT_ULL(52) ? 'x' : '-',
-			 dw0 & BIT_ULL(53) ? 'p' : '-',
-			 dw1 & BIT_ULL(2) ? 'l' : '-',
-			 FIELD_GET(GENMASK_ULL(51, 32), dw0),
-			 FIELD_GET(GENMASK_ULL(11, 3), dw1));
-
-	/* Private Data */
-	if (dw0 & BIT_ULL(9)) {
-		size -= bytes;
-		buf += bytes;
-		snprintf(buf, size, " private=0x%llx/0x%llx\n", dw2, dw3);
-	}
-
-	return str;
-}
-
-#endif
+/* Keep the public include path for existing users. */
+#include "../../drivers/iommu/intel/iommu.h"
-- 
2.53.0

