Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011018.outbound.protection.outlook.com [40.107.208.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ABA257423;
	Tue, 30 Jun 2026 06:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782800177; cv=fail; b=Z2pxWIY2QjCdG3hac2DSF1ZAmm5LsuZivX/oOZ7aV2Zd4C9MyiMfJUVwN9eQgR2Rcz27//kMxJtFjZIdTMPRC7TfUXVs7ThMme41LaZwjKZ0xcsWBhCG951x7+kz+7LRV81FV8vu6nMf6q5uOLquiansrRICo62LPNsMag1krtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782800177; c=relaxed/simple;
	bh=4r+evyzIpgXux5o7303jDtRpwOCYa+VuYU6/sZXMzlU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EdIUPEpNQk14VGbSc4soqluDwemMzEj8bTBL+aHgXWrHyTOvFQX6v9WNKnGFPN/hpVHl2qUuqEjLJF3zO3uIRXxlC+eaRzPnGE7K6SljTXBE7WXVIPLBEWWzoMktQCh7j/eKP+vmR9RgIVuYb51F/3YBp7e1bbErlJ9QgFgZ4D8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B3hSrAY+; arc=fail smtp.client-ip=40.107.208.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B3hSrAY+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNuEYnAKR13vzGoFKyp7sI610jHXG4TAWPPB0oDElG1BEYlQ8gKi1yyn0KMSe0PPn3vEwRMcQg2Ik1Jh6gDgtGEPRZnH8SHZAg6S2Oe4fg1MkHxNaRqydsu8hSjOlDbOHhrLQNhLB39shstHE6XRl7n5K5nfDcfNP1l6aZvPjniUPUV4q4W0WaMt6FYfjQZzibmIU8pCp1DxQfp2AB0EjstuBND4hMRy3NqMR/4HKrBeRA+rn7lQ0nGJxixgd8pDfGLwJU62sXCOEQGDmC3qz/XiVMJS065gXMuVQrxZbRa2SD+PA04leQ6fGJqB986aBQDwPgcmg8ykpBNc1Gc5TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ot23SP76YmMZgYOqvSYavhc9KetDMyywWHgoUqsKkGI=;
 b=zNCb7jLZfEFM0fod8hbF+yKxzGFMAHWVk9sWOTGqw/A/47Xycdn79LQbsQss011yb+0II+X1fwmi0k4CPlPsb/YlzdnQto37oZB+KG1fLjFKD+6IgQNYsNYZTDCTqDtSuxmfqcEArHpDG6bdDU9IUJ5wwGrKaX4zerbg0ZL4nbm6RHbVHwYhcKQuPlYz4wJ2ALU5TDvd00PPnG64cJpRaZFsoC2BtNblLYLBVUlMePVAAy8yAqusCSTKtDwRL5m6VRUtgImiJGR28h8GLuQHME6uePdDsM6XiDWYkFPyqwB1zMJmotz7iuvLOAOTIOZr4T0NYbnmLaev6RcGyiP/iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ot23SP76YmMZgYOqvSYavhc9KetDMyywWHgoUqsKkGI=;
 b=B3hSrAY+2UAXezQWXZvPzV641jlBCyVbmItuuai+xp3XKmbWW38UgfpfkMXwfA2wh6wpYS3jbI/0Ei1D3OO/dKKzjuGSnNWqj7Z8RfHDAqmkjxALYwzYH9SU2LwVntHyWXv0tp8N/8mdhhOnJbAZGLp7Lh9t/9rpJA5FGyqiaAACwCaYqbloilCt+OYXBwMm+jJQexO8V97MffBsEE/2CBuqLMbQ5PDYJVypoYrOFIbrS8OYIU0G2KvUrQIqMUSsAasYocVjmkmZTrxtSuHUFYTlQ837pA7WyYP97LSKZLDA8CwUBrULi0TUH82jDKCxczZnKqXVWBF60paeoR3h4g==
Received: from CH0PR03CA0109.namprd03.prod.outlook.com (2603:10b6:610:cd::24)
 by PH0PR12MB8008.namprd12.prod.outlook.com (2603:10b6:510:26f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 06:16:09 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:cd:cafe::95) by CH0PR03CA0109.outlook.office365.com
 (2603:10b6:610:cd::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Tue,
 30 Jun 2026 06:16:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 06:16:09 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 23:15:55 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 23:15:54 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 29 Jun 2026 23:15:53 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kees@kernel.org>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<miko.lenczewski@arm.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH rc v7 1/7] iommu/arm-smmu-v3: Add arm_smmu_kdump_adopt_strtab() for kdump
Date: Mon, 29 Jun 2026 23:15:34 -0700
Message-ID: <7a8e829adda9a9d405b6f80bc32657b9b89ffe8c.1782799827.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1782799827.git.nicolinc@nvidia.com>
References: <cover.1782799827.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|PH0PR12MB8008:EE_
X-MS-Office365-Filtering-Correlation-Id: 3afd4959-34c7-424a-f801-08ded66f13ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|376014|7416014|1800799024|22082099003|18002099003|6133799003|11063799006|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	7sfzA8O9t5E11avyCiDUVSiSkHd/omyCylTDrKwpyNNMUCf8mrEvQQMTIImEFizJ/X9emekftZ6A+hh9hE4WJEHIbtsCp8hCG8jbqiY6ylsCtIEsanQ/DeFbdDbhDaNS28NkVh7RXSadT3xZpeJ8hNGcsqZxjmnYzkyfyx10eO5IXoB/kzZxrDRa0E60GGTqgQggU7Dh/+I+vVUg/jh7P+tc+SUHH0hCJOEi6AgpLW/Nd7ZONRT9lBdyVCd/4h+Wi7H37+tL+Zdp81PemoyB3F0JqBBQGI9hb7l7zVkhxWovu6522SXoIF31yVka3F2BhAlyFKSL4GTsWPLX8w3mT1soYgShZEYGohlF4O0nXpueM0sjBMupQ1WQ+MNgRYVX9wygEAA6N38WnFzwQ7K/BOo4TVLCCn78kYDg3an9PgClvTMMTZAaA6UMDUz0rq393SQpe9YqwXTDx0FvkHa1c3wP5I/R7NLEAgeiF8cWLHKl4IBZ2BcdGEIqpoo/awGMEnezSQ2B8ChURIfHLA8KqBxjnRgZDvu/8AhrfCEkGRbq4L4YI/C1Ma2DqK+Y2RmsqY6klnrj7iZdPKmUoJ/SMELi9ohPCEWfzTTFMI7B3rEZ+qIe8woaUtN04HqPtGGnHVKXcictttXDkgIPkhcqG//SEpZ3B3N4RXvLukqchqj2ZLcnWgdGrO61Yi55rRUaCdWx8nyn7uxK5w1g+ui5mw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2cTrBZvEHSu6XKH/ehiHTMryBisSQYCGFT4HgyeTrCzpbWVzBdjiyOk0mGnRvfSkBlkH3+Zd8mS0PxzAei2Z2mLe06fRu0O2/m3SqwoPPnqYia58VdeFcuL6FQKy2NXPnXK8qYp8sRpIES0YMGxbh7MLAmvsKqHSAvM5BF/mgdIimEARcIrw7LxDp3Zub91BREcPsms5IToGwTHeggb3PpbO3SO23wjoMeFXemjtdlMy6N3FKteQEE321mG/flZHy5DuNJXRAMuC0vb7n028VE5Zbn8XUGapLaLBBW5+VSP41t47yFng/KKwybbt1OWpRiOn/PakxW/fpSPrcmYYJ/xMFMuUtaeLOg9oAuiEI+ETc0l31HMHvkTUGYWgOCpHF0NDOOHp6GrfexeCrLwXpIwnQGXP5nPBIicDMOF0mSxDgewWuzeNRmnBT/ZqRzhF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 06:16:09.6697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3afd4959-34c7-424a-f801-08ded66f13ff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8008

When transitioning to a kdump kernel, the primary kernel might have crashed
while endpoint devices were actively bus-mastering DMA. Currently, the SMMU
driver aggressively resets the hardware during probe by clearing CR0_SMMUEN
and setting the Global Bypass Attribute (GBPA) to ABORT.

In a kdump scenario, this aggressive reset is highly destructive:
a) If GBPA is set to ABORT, in-flight DMA will be aborted, generating fatal
   PCIe AER or SErrors that may panic the kdump kernel
b) If GBPA is set to BYPASS, in-flight DMA targeting some IOVAs will bypass
   the SMMU and corrupt the physical memory at those 1:1 mapped IOVAs.

To safely absorb in-flight DMAs, a kdump kernel will have to leave SMMUEN=1
intact and avoid modifying STRTAB_BASE, allowing HW to continue translating
in-flight DMAs reusing the crashed kernel's page tables until the endpoint
device drivers probe and quiesce their respective hardware.

However, the ARM SMMUv3 architecture specification states that updating the
SMMU_STRTAB_BASE register while SMMUEN == 1 is UNPREDICTABLE or ignored.

This leaves a kdump kernel no choice but to adopt the stream table from the
crashed kernel.

Introduce ARM_SMMU_OPT_KDUMP_ADOPT and adopt functions memremapping all the
stream tables extracted from STRTAB_BASE and STRTAB_BASE_CFG.

Note that the adoption of the crashed kernel's stream table follows certain
strict rules, since the old stream table might be compromised. Thus, apply
some basic validations against the values read from the registers. If tests
fail, it means the stream table cannot be trusted, so toss it entirely. To
avoid OOM due to a potentially corrupted stream table, the memremap for l2
tables is done on the kdump kernel's demand.

The new option will be set in a following change.

Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel")
Cc: stable@vger.kernel.org # v6.12+
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 244 +++++++++++++++++++-
 2 files changed, 242 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index c909c9a88538b..9d86dc89d8e2e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -928,6 +928,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_OPT_MSIPOLL		(1 << 2)
 #define ARM_SMMU_OPT_CMDQ_FORCE_SYNC	(1 << 3)
 #define ARM_SMMU_OPT_TEGRA241_CMDQV	(1 << 4)
+#define ARM_SMMU_OPT_KDUMP_ADOPT	(1 << 5)
 	u32				options;
 
 	struct arm_smmu_cmdq		cmdq;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a10affb483a4f..af97a22c11696 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1933,16 +1933,67 @@ static void arm_smmu_init_initial_stes(struct arm_smmu_ste *strtab,
 	}
 }
 
+static int arm_smmu_kdump_adopt_l2_strtab(struct arm_smmu_device *smmu, u32 sid,
+					  phys_addr_t base, u32 span,
+					  struct arm_smmu_strtab_l2 **l2table)
+{
+	struct arm_smmu_strtab_l2 *table;
+	size_t size;
+
+	/*
+	 * Retest the span in case the L1 descriptor has been overwritten since
+	 * the adopt. Reject this master's insert; panic or SMMU-disable would
+	 * either lose the vmcore or cascade aborts. Do not try to fix it, as it
+	 * would break all other SIDs in the same bus (PCI case). The corruption
+	 * blast radius is already bounded to that bus range.
+	 */
+	if (span != STRTAB_SPLIT + 1) {
+		dev_err(smmu->dev,
+			"kdump: L1[%u] span %u changed since adopt (was %u)\n",
+			arm_smmu_strtab_l1_idx(sid), span, STRTAB_SPLIT + 1);
+		return -EINVAL;
+	}
+
+	size = (1UL << (span - 1)) * sizeof(struct arm_smmu_ste);
+
+	/*
+	 * This L2 table is mapped lazily per master; devres frees it at unbind,
+	 * as with the dmam_alloc_coherent() used for a fresh L2.
+	 */
+	table = devm_memremap(smmu->dev, base, size, MEMREMAP_WB);
+	if (IS_ERR(table)) {
+		dev_err(smmu->dev,
+			"kdump: failed to adopt l2 stream table for SID %u\n",
+			sid);
+		return PTR_ERR(table);
+	}
+
+	*l2table = table;
+	return 0;
+}
+
 static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
 {
 	dma_addr_t l2ptr_dma;
 	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
 	struct arm_smmu_strtab_l2 **l2table;
+	u32 l1_idx = arm_smmu_strtab_l1_idx(sid);
 
-	l2table = &cfg->l2.l2ptrs[arm_smmu_strtab_l1_idx(sid)];
+	l2table = &cfg->l2.l2ptrs[l1_idx];
 	if (*l2table)
 		return 0;
 
+	/* Deferred adoption of the crashed kernel's L2 table */
+	if (smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT) {
+		u64 l2ptr = le64_to_cpu(cfg->l2.l1tab[l1_idx].l2ptr);
+		phys_addr_t base = l2ptr & STRTAB_L1_DESC_L2PTR_MASK;
+		u32 span = FIELD_GET(STRTAB_L1_DESC_SPAN, l2ptr);
+
+		if (span && base)
+			return arm_smmu_kdump_adopt_l2_strtab(smmu, sid, base,
+							      span, l2table);
+	}
+
 	*l2table = dmam_alloc_coherent(smmu->dev, sizeof(**l2table),
 				       &l2ptr_dma, GFP_KERNEL);
 	if (!*l2table) {
@@ -1954,8 +2005,7 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
 
 	arm_smmu_init_initial_stes((*l2table)->stes,
 				   ARRAY_SIZE((*l2table)->stes));
-	arm_smmu_write_strtab_l1_desc(&cfg->l2.l1tab[arm_smmu_strtab_l1_idx(sid)],
-				      l2ptr_dma);
+	arm_smmu_write_strtab_l1_desc(&cfg->l2.l1tab[l1_idx], l2ptr_dma);
 	return 0;
 }
 
@@ -4490,10 +4540,197 @@ static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
 	return 0;
 }
 
+static int arm_smmu_kdump_adopt_strtab_2lvl(struct arm_smmu_device *smmu,
+					    u32 cfg_reg, phys_addr_t base)
+{
+	u32 log2size = FIELD_GET(STRTAB_BASE_CFG_LOG2SIZE, cfg_reg);
+	u32 split = FIELD_GET(STRTAB_BASE_CFG_SPLIT, cfg_reg);
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+	u32 num_l1_ents;
+	size_t size;
+	int i;
+
+	if (log2size < split || log2size > smmu->sid_bits) {
+		dev_err(smmu->dev, "kdump: log2size %u out of range [%u, %u]\n",
+			log2size, split, smmu->sid_bits);
+		return -EINVAL;
+	}
+	if (split != STRTAB_SPLIT) {
+		dev_err(smmu->dev,
+			"kdump: unsupported STRTAB_SPLIT %u (expected %u)\n",
+			split, STRTAB_SPLIT);
+		return -EINVAL;
+	}
+
+	num_l1_ents = 1U << (log2size - split);
+	if (num_l1_ents > STRTAB_MAX_L1_ENTRIES) {
+		dev_err(smmu->dev, "kdump: l1 entries %u exceeds max %u\n",
+			num_l1_ents, STRTAB_MAX_L1_ENTRIES);
+		return -EINVAL;
+	}
+
+	cfg->l2.num_l1_ents = num_l1_ents;
+
+	size = num_l1_ents * sizeof(struct arm_smmu_strtab_l1);
+	cfg->l2.l1tab = memremap(base, size, MEMREMAP_WB);
+	if (!cfg->l2.l1tab)
+		return -ENOMEM;
+
+	cfg->l2.l2ptrs =
+		kcalloc(num_l1_ents, sizeof(*cfg->l2.l2ptrs), GFP_KERNEL);
+	if (!cfg->l2.l2ptrs)
+		return -ENOMEM;
+
+	for (i = 0; i < num_l1_ents; i++) {
+		u64 l2ptr = le64_to_cpu(cfg->l2.l1tab[i].l2ptr);
+		phys_addr_t l2_base = l2ptr & STRTAB_L1_DESC_L2PTR_MASK;
+		u32 span = FIELD_GET(STRTAB_L1_DESC_SPAN, l2ptr);
+
+		if (!span || !l2_base)
+			continue;
+
+		if (span != STRTAB_SPLIT + 1) {
+			dev_err(smmu->dev,
+				"kdump: L1[%u] unsupported span %u (vs %u)\n",
+				i, span, STRTAB_SPLIT + 1);
+			return -EINVAL;
+		}
+
+		/*
+		 * If the crashed kernel's l1 descriptors are deeply corrupted,
+		 * blindly memremapping every l2 table here could lead to OOM.
+		 *
+		 * Defer the l2 memremap to arm_smmu_init_l2_strtab(), so peak
+		 * memory is bounded by the kdump kernel's actual demand.
+		 */
+	}
+
+	return 0;
+}
+
+static int arm_smmu_kdump_adopt_strtab_linear(struct arm_smmu_device *smmu,
+					      u32 cfg_reg, phys_addr_t base)
+{
+	u32 log2size = FIELD_GET(STRTAB_BASE_CFG_LOG2SIZE, cfg_reg);
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+	unsigned int max_log2size;
+	size_t size;
+
+	/* Cap the size at what the kdump kernel itself would have allocated */
+	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)
+		max_log2size =
+			ilog2(STRTAB_MAX_L1_ENTRIES * STRTAB_NUM_L2_STES);
+	else
+		max_log2size = smmu->sid_bits;
+
+	/* cfg->linear.num_ents is unsigned int, so cap log2size at 31 */
+	max_log2size = min(max_log2size, 31U);
+	if (log2size > max_log2size) {
+		dev_err(smmu->dev, "kdump: unsupported log2size %u (> %u)\n",
+			log2size, max_log2size);
+		return -EINVAL;
+	}
+
+	/*
+	 * We might end up with a num_ents != sid_bits, which is fine. In the
+	 * ARM_SMMU_OPT_KDUMP_ADOPT case, arm_smmu_write_strtab() is bypassed.
+	 */
+	cfg->linear.num_ents = 1U << log2size;
+
+	size = cfg->linear.num_ents * sizeof(struct arm_smmu_ste);
+	cfg->linear.table = memremap(base, size, MEMREMAP_WB);
+	if (!cfg->linear.table)
+		return -ENOMEM;
+	return 0;
+}
+
+static void arm_smmu_kdump_adopt_cleanup(void *data)
+{
+	struct arm_smmu_device *smmu = data;
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+
+	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
+		kfree(cfg->l2.l2ptrs);
+		if (cfg->l2.l1tab)
+			memunmap(cfg->l2.l1tab);
+	} else {
+		if (cfg->linear.table)
+			memunmap(cfg->linear.table);
+	}
+}
+
+static int arm_smmu_kdump_adopt_strtab(struct arm_smmu_device *smmu)
+{
+	u32 cfg_reg = readl_relaxed(smmu->base + ARM_SMMU_STRTAB_BASE_CFG);
+	u64 base_reg = readq_relaxed(smmu->base + ARM_SMMU_STRTAB_BASE);
+	bool was_2lvl = smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB;
+	phys_addr_t base = base_reg & STRTAB_BASE_ADDR_MASK;
+	u32 fmt = FIELD_GET(STRTAB_BASE_CFG_FMT, cfg_reg);
+	int ret;
+
+	dev_dbg(smmu->dev, "kdump: adopting crashed kernel's stream table\n");
+
+	if (fmt == STRTAB_BASE_CFG_FMT_2LVL) {
+		/*
+		 * Both kernels run on the same hardware, so it's impossible for
+		 * kdump kernel to see the support for linear stream table only.
+		 */
+		if (WARN_ON(!(smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)))
+			ret = -EINVAL;
+		else
+			ret = arm_smmu_kdump_adopt_strtab_2lvl(smmu, cfg_reg,
+							       base);
+	} else if (fmt == STRTAB_BASE_CFG_FMT_LINEAR) {
+		/*
+		 * The kdump kernel need not match the crashed kernel. An older
+		 * crashed kernel that predates two-level stream table support
+		 * may have used a linear table on 2-level-capable hardware, so
+		 * enforce the same format here to match the adopted table.
+		 */
+		ret = arm_smmu_kdump_adopt_strtab_linear(smmu, cfg_reg, base);
+		if (!ret)
+			smmu->features &= ~ARM_SMMU_FEAT_2_LVL_STRTAB;
+	} else {
+		dev_err(smmu->dev, "kdump: invalid STRTAB format %u\n", fmt);
+		ret = -EINVAL;
+	}
+
+	if (ret) {
+		arm_smmu_kdump_adopt_cleanup(smmu);
+		goto err;
+	}
+
+	ret = devm_add_action_or_reset(smmu->dev, arm_smmu_kdump_adopt_cleanup,
+				       smmu);
+	/* devm_add_action_or_reset ran the cleanup upon failure */
+	if (ret) {
+		dev_warn(smmu->dev, "kdump: failed to set up cleanup action\n");
+		/*
+		 * Undo the linear adoption's clearing of FEAT_2_LVL_STRTAB so
+		 * the full-reset fallback uses the hardware-supported format.
+		 */
+		if (was_2lvl)
+			smmu->features |= ARM_SMMU_FEAT_2_LVL_STRTAB;
+		goto err;
+	}
+
+	return 0;
+
+err:
+	dev_warn(smmu->dev, "kdump: falling back to full reset\n");
+	memset(&smmu->strtab_cfg, 0, sizeof(smmu->strtab_cfg));
+	smmu->options &= ~ARM_SMMU_OPT_KDUMP_ADOPT;
+	return ret;
+}
+
 static int arm_smmu_init_strtab(struct arm_smmu_device *smmu)
 {
 	int ret;
 
+	if ((smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT) &&
+	    !arm_smmu_kdump_adopt_strtab(smmu))
+		goto out;
+
 	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)
 		ret = arm_smmu_init_strtab_2lvl(smmu);
 	else
@@ -4501,6 +4738,7 @@ static int arm_smmu_init_strtab(struct arm_smmu_device *smmu)
 	if (ret)
 		return ret;
 
+out:
 	ida_init(&smmu->vmid_map);
 
 	return 0;
-- 
2.43.0

