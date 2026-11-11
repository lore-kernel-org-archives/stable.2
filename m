Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794393618;
	b=fYD3LN0eDaKq7BT3JlVL1wpTQgMdp305Z9a/yDPDN3Nx2LcLpVDjTKC/G3EItFG1l2XQ
	 dSPPTODmDHeMR/UGnuriKb8gtT3DcS8zBPUbhR/yMFQ54qrrASfUiW0kCexDdnYQFFKoH
	 J49ep2bihJkKvfmOfwmrKuL3p8/w6+GlH3hejfHb4QmxS/M+lyCfLwqAs4WELOdSchhZl
	 GCFSFaD35dysC2KmXLfBVh8Wg0t+XWE28KGfaTouddFgt9CJGqSeHw3GAd7KqzOr5Ozos
	 kk0rZySuPcAQSq0+QuE+rN9vlF9FnvBVk55OYXIpTtxvDO0XH9rfa+WpCJqzhADS2Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794393618;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=u6YIYVP4So+pNGPikhCPgMp1QCcA6/8B9yjFvBIXpR0=;
	b=qT9MDQgrfeJF1hIzjLRevnwRthe+I89QDLdknuxv4jDGv6skrKHAr98J5qt78YEueGWj
	 a405xuhu7zzWW4SGmLF5YD8ulE49oFAh4fBK+U79hxIPb6iverHOG+DgkyzaDR0q0Omh6
	 pWfU45RoKGqaCRLNJjWOZJapvx273SeGDQ7s1f/m3a9lwQBWbM/PcoSo6LKq3M3AXNiFC
	 Iyv0jkxtFg/Yru5JcVBhJS7RPsYt8jAtVxtkBsdUMxC3QnqpGu2bwwIqUfCTEnwzyqTRu
	 EFajMAxJmvoPjTiOuJdj6wnkfuhmAC5kr18q2AIrkZt8MxgGcM+TBvmxCAbnX8Y83MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=8bytes.org;
	spf=pass smtp.mailfrom=8bytes.org;
	arc=none smtp.remote-ip=85.214.250.239
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D45606A33F
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 10:40:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62D45606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from io.home.8bytes.org (p200300f6af404a0070a0fd992ce44cba.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:70a0:fd99:2ce4:4cba])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 641892440BE;
	Wed, 11 Nov 2026 11:40:10 +0100 (CET)
From: =?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>
To: stable@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Joerg Roedel <joerg.roedel@amd.com>
Subject: [PATCH 6.18.y] iommu/amd: Force device table to maximum size
Date: Wed, 11 Nov 2026 11:39:56 +0100
Message-ID: <20261111104001.216548-2-joro@8bytes.org>
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

kdump reuses the previous kernel's device table only when the size
encoded in the IOMMU device-table register matches
pci_seg->dev_table_size. A mixed rollout disagrees: the unpatched
kernel uses the IVRS-derived size and the patched kernel uses 2MB,
so __reuse_device_table() rejects the table. On SNP-capable IOMMUs
that rejection panics the kdump kernel. Kernels that both have this
patch agree on 2MB and reuse succeeds. Update the production kernel
and the crash kernel together.

Family 0x1a models 0xd8-0xef are Zen6. This kernel does not
mark that range as X86_FEATURE_ZEN6, so those processors would
still take the 2MB device table. Add the range to the existing
Zen6 detection and exclude them from the workaround.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 arch/x86/kernel/cpu/amd.c |  1 +
 drivers/iommu/amd/init.c  | 27 ++++++++++++++++++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index bd274c2b4c6a..ef55c76a3906 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -524,6 +524,7 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 		case 0x50 ... 0x5f:
 		case 0x80 ... 0xaf:
 		case 0xc0 ... 0xcf:
+		case 0xd8 ... 0xef:
 			setup_force_cpu_cap(X86_FEATURE_ZEN6);
 			break;
 		default:
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 16c26d75f46f..0631f26752e2 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1736,6 +1736,21 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 	return 0;
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
 /* Allocate PCI segment data structure */
 static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id,
 					  struct acpi_table_header *ivrs_base)
@@ -1758,9 +1773,15 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id,
 
 	pci_seg->last_bdf = last_bdf;
 	DUMP_printk("PCI segment : 0x%0x, last bdf : 0x%04x\n", id, last_bdf);
-	pci_seg->dev_table_size =
-		max(roundup_pow_of_two((last_bdf + 1) * DEV_TABLE_ENTRY_SIZE),
-		    SZ_4K);
+	if (amd_iommu_force_max_dev_table()) {
+		pr_info("Force device table to maximum size\n");
+		pci_seg->dev_table_size = SZ_2M;
+	} else {
+		pci_seg->dev_table_size =
+			max(roundup_pow_of_two((last_bdf + 1) *
+					       DEV_TABLE_ENTRY_SIZE),
+			    SZ_4K);
+	}
 
 	pci_seg->id = id;
 	init_llist_head(&pci_seg->dev_data_list);
-- 
2.53.0

