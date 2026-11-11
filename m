Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794393619;
	b=dRAcPUoQ843dNxeyqc8m/w2tINF/7dhgHJpcy6ttLWJObsLMiuejlPUUJyz1e6WDWd23
	 IUG/FYw76n8sOBH5DbNhbgoQvH1kiUEo4N5HD/5kYXGP0wIEOV2jHmRpvKShYZIDCxxxg
	 C/g2HjMWEwNe9AMUaix3jn6G8umPlnfJdSBycka0T17lK1R4MyWtecSAKj71qToo/s6Bg
	 Z+DjWtMHgW2gbgQO/rmu3TLnmnLlnsCxaTle9OhU5wTS//P/AZV2BhKzthmirB4f1qVlk
	 Qwr+Wn+BcF27ZCl8hV9DIqpVG3MbHoQuW73xiRmkqMCfgKbmCCGEXsoA8+d4NxgSt9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794393619;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Jms381WghVbM5hv9Z+YanPHlJlY/IsbpmnGm3ABPT0o=;
	b=AblgAEge36J1yJKrnOqE6ssVXevW135HdxyzjNiyzqagBrFlT6Q9VNblEWAsrZj9Xot0
	 9D3OjGtB5EmeoyUDX5BLYxuH4aSIYF9AqKxcZP36pc7Oouj480nSjuImMXVTbwTHt4gXP
	 /zh/cxSDVMStbcXaCKMb3E4dn8KeTNpsqooW2KQt85BdoYCFydkd39HAL48pRg63AZwRS
	 utsLmiKo/fQ+wZldq/7lZPQQlH0Tm4ZP0n5rFWex5M6Rp5eShHrWcvvgwGGIS9qkW/djW
	 IhvIR5pHz55GkQDe8u0SC2Gu8E4uWQd6Jg9pDBxIpoh2eOpUVbxvct+oGR9wiqZKmQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=8bytes.org;
	spf=pass smtp.mailfrom=8bytes.org;
	arc=none smtp.remote-ip=85.214.250.239
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FD7606A89D
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 10:40:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4FD7606A89D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from io.home.8bytes.org (p200300f6af404a0070a0fd992ce44cba.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:70a0:fd99:2ce4:4cba])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id BA1CB244148;
	Wed, 11 Nov 2026 11:40:10 +0100 (CET)
From: =?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>
To: stable@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Joerg Roedel <joerg.roedel@amd.com>
Subject: [PATCH 5.10.y] iommu/amd: Force device table to maximum size
Date: Wed, 11 Nov 2026 11:40:01 +0100
Message-ID: <20261111104001.216548-7-joro@8bytes.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111104001.216548-1-joro@8bytes.org>
References: <20261111104001.216548-1-joro@8bytes.org>
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

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

commit 6e2213dae78b41976c60133eb10cf99e81916638 upstream.

IOMMU can perform out-of-bounds read of the device table entry (DTE)
that is adjacent to the last DTE and falls outside the device table.
For example, if the device table can hold 0 to N-1 entries, then the
IOMMU can be made to fetch the Nth entry, which falls outside the
device table.

The device table is owned by the hypervisor (HV) and is assigned in 4KB
pages that are contiguous in system physical address (SPA). If the
out-of-bound DTE falls on a guest-owned page, then the guest can exploit
this bug to setup malicious table walks to corrupt HV pages and/or bring
down the system. Note that this bug does not manifest when the device
table size is set to its maximum size of 2MB.

Therefore, force the device table size to the maximum 2MB on affected
processors. These are CPU family 0x17 (Zen1/Zen2) through family 0x1a
(Zen5/BRH).

This is a mitigation for CVE-2024-21963.

kdump copies the previous kernel's device table only when the size
encoded in the IOMMU device-table register matches dev_table_size.
A mixed rollout disagrees: the unpatched kernel uses the IVRS-derived
size and the patched kernel uses 2MB, so copy_device_table() rejects
the table and reinitializes translation. Kernels that both have this
patch agree on 2MB and the copy succeeds. Update the production
kernel and the crash kernel together.

This kernel has one global device table. Only that size is forced
to 2MB. Alias and rlookup sizes stay derived from the IVRS.

This backport adds X86_FEATURE_ZEN6. Bit 3*32+6 is still
X86_FEATURE_P3 here, so the new flag uses free bit 21*32+7.
Family 0x1a models 0x50-0x5f, 0x80-0xaf, 0xc0-0xcf, and
0xd8-0xef are Zen6 and are excluded from the workaround.
This kernel has no X86_FEATURE_ZEN5. Other family 0x1a models
stay unmarked and still take the 2MB device table.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 arch/x86/include/asm/cpufeatures.h |  6 ++++++
 arch/x86/kernel/cpu/amd.c          | 18 ++++++++++++++++++
 drivers/iommu/amd/init.c           | 23 ++++++++++++++++++++++-
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 19a18df50a2e..12928845f136 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -416,6 +416,12 @@
 #define X86_FEATURE_IBPB_BRTYPE		(20*32+28) /* "" MSR_PRED_CMD[IBPB] flushes all branch type predictions */
 #define X86_FEATURE_SRSO_NO		(20*32+29) /* "" CPU is not affected by SRSO */
 
+/*
+ * Upstream defines X86_FEATURE_ZEN6 as (3*32+6). That bit is still
+ * X86_FEATURE_P3 in this kernel, so use a free bit in this word.
+ */
+#define X86_FEATURE_ZEN6		(21*32+7) /* "" CPU based on Zen6 microarchitecture */
+
 #define X86_FEATURE_TSA_SQ_NO          (22*32+11) /* "" AMD CPU not vulnerable to TSA-SQ */
 #define X86_FEATURE_TSA_L1_NO          (22*32+12) /* "" AMD CPU not vulnerable to TSA-L1 */
 #define X86_FEATURE_CLEAR_CPU_BUF_VM   (22*32+13) /* "" Clear CPU buffers using VERW before VMRUN */
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 0ded215bcaf6..2abed4f24dbc 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -769,6 +769,24 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 		}
 		break;
 	}
+	case 0x1a: {
+		switch (c->x86_model) {
+		case 0x50 ... 0x5f:
+		case 0x80 ... 0xaf:
+		case 0xc0 ... 0xcf:
+		case 0xd8 ... 0xef:
+			setup_force_cpu_cap(X86_FEATURE_ZEN6);
+			break;
+		default:
+			/*
+			 * Zen5 models in family 0x1a have no feature bit
+			 * in this kernel. Leave them unmarked so the
+			 * device-table workaround still applies.
+			 */
+			break;
+		}
+		break;
+	}
 	default:
 		break;
 	}
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index cccbe59c2604..c643ea095c97 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -21,6 +21,7 @@
 #include <linux/kmemleak.h>
 #include <linux/mem_encrypt.h>
 #include <linux/iopoll.h>
+#include <linux/sizes.h>
 #include <asm/pci-direct.h>
 #include <asm/iommu.h>
 #include <asm/apic.h>
@@ -2664,6 +2665,21 @@ static void __init ivinfo_init(void *ivrs)
 	amd_iommu_ivinfo = *((u32 *)(ivrs + IOMMU_IVINFO_OFFSET));
 }
 
+/*
+ * Apply workaround for Zen1 to Zen5(BRH) generation of processors.
+ * References: CVE-2024-21963
+ */
+static bool __init amd_iommu_force_max_dev_table(void)
+{
+	if (boot_cpu_data.x86 >= 0x17 && boot_cpu_data.x86 <= 0x1a) {
+		if (cpu_feature_enabled(X86_FEATURE_ZEN6))
+			return false;
+		else
+			return true;
+	}
+	return false;
+}
+
 /*
  * This is the hardware init function for AMD IOMMU in the system.
  * This function is called either from amd_iommu_init or from the interrupt
@@ -2732,7 +2748,12 @@ static int __init early_amd_iommu_init(void)
 	if (ret)
 		goto out;
 
-	dev_table_size     = tbl_size(DEV_TABLE_ENTRY_SIZE);
+	if (amd_iommu_force_max_dev_table()) {
+		pr_info("Force device table to maximum size\n");
+		dev_table_size = SZ_2M;
+	} else {
+		dev_table_size = tbl_size(DEV_TABLE_ENTRY_SIZE);
+	}
 	alias_table_size   = tbl_size(ALIAS_TABLE_ENTRY_SIZE);
 	rlookup_table_size = tbl_size(RLOOKUP_TABLE_ENTRY_SIZE);
 
-- 
2.53.0

