Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0369386557
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 17:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782927938; cv=none; b=HfNRepI3g2eQAxkgrEi1RHDYB5MODG6imQiSF3uGkn+XlSjcjrgJHwL0tb+w//uBFZiHFiESlpmzpBdAOwMkt7WkCv4DYQ3JL7bE1riVlJ58wQj3RDbY5XAe5ZllrrcOjVD6kOTJyHUObUSFbysCkd764vuOqeObnkCB5ICF4bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782927938; c=relaxed/simple;
	bh=JYlNs5cCz4iPuOZduJDZZgEyl0FofGYsMvYkgOEiosY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GX+eUpcBJHWpaFcQte5g6XyJnjTFajsNi3VBWxsfttwb6DZYbGZDDMfeVfI+S91lC3QWyIGH2hdY+o4Q0WxCruEbcR4VKVNmxvLZWe+REdYjoncR+coaFJA42gJMFj6Ic/BFOaSRMQC8KbvjB62t+cND5L/oEZa3GB8x53GGrmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=D8QgBOAW; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="D8QgBOAW"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6CFA2BF7;
	Wed,  1 Jul 2026 10:45:30 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B5C0E3F85F;
	Wed,  1 Jul 2026 10:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782927935; bh=JYlNs5cCz4iPuOZduJDZZgEyl0FofGYsMvYkgOEiosY=;
	h=From:To:Cc:Subject:Date:From;
	b=D8QgBOAWEV0NgOSJOt29mYQd7CeduBIC8fDG+HvGIgYU6EarArrsRwY5PWRQNX3XX
	 HwlhUhuxMY1m8wsHYQipFtTu2dRu3L+mN/dveZzBnT2E5OxjZrefhUPdDyc2p10i5x
	 mm8i/kdEytzA+nLMFa0Or60sjnCw6UZIsnqhNy4w=
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	joro@8bytes.org
Cc: jpb@kernel.org,
	catalin.marinas@arm.com,
	yangyicong@hisilicon.com,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH] iommu/arm-smmu-v3: Add HAFT support for SVA
Date: Wed,  1 Jul 2026 18:45:17 +0100
Message-ID: <878cd6bcbbe2d5677d2f63da13294c148268552c.1782927917.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.54.0.dirty
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since table access flags cannot be software-managed, if process
pagetables are using HAFT then SVA must require the SMMU to support and
enable it too, otherwise page aging is liable to get out of whack.

Cc: <stable@vger.kernel.org>
Fixes: 62df5870ebf7 ("arm64: Enable ARCH_HAS_NONLEAF_PMD_YOUNG")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 5 +++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 6 ++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     | 3 +++
 3 files changed, 14 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 1ed8a6f29dc4..ef11e9493f93 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -102,6 +102,8 @@ void arm_smmu_make_sva_cd(struct arm_smmu_cd *target,
 			target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_HA);
 		if (master->smmu->features & ARM_SMMU_FEAT_HD)
 			target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_HD);
+		if (master->smmu->features & ARM_SMMU_FEAT_HAFT && system_supports_haft())
+			target->data[1] |= cpu_to_le64(CTXDESC_CD_1_HAFT);
 	} else {
 		target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_EPD0);
 
@@ -211,6 +213,9 @@ bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
 	if (system_supports_bbml2_noabort())
 		feat_mask |= ARM_SMMU_FEAT_BBML2;
 
+	if (system_supports_haft())
+		feat_mask |= ARM_SMMU_FEAT_HAFT;
+
 	if ((smmu->features & feat_mask) != feat_mask)
 		return false;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a10affb483a4..7637e9128533 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4925,6 +4925,9 @@ static void arm_smmu_get_httu(struct arm_smmu_device *smmu, u32 reg)
 	u32 hw_features = 0;
 
 	switch (FIELD_GET(IDR0_HTTU, reg)) {
+	case IDR0_HTTU_ACCESS_DIRTY_HAFT:
+		hw_features |= ARM_SMMU_FEAT_HAFT;
+		fallthrough;
 	case IDR0_HTTU_ACCESS_DIRTY:
 		hw_features |= ARM_SMMU_FEAT_HD;
 		fallthrough;
@@ -5256,6 +5259,9 @@ static int arm_smmu_device_acpi_probe(struct platform_device *pdev,
 		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
 
 	switch (FIELD_GET(ACPI_IORT_SMMU_V3_HTTU_OVERRIDE, iort_smmu->flags)) {
+	case IDR0_HTTU_ACCESS_DIRTY_HAFT:
+		smmu->features |= ARM_SMMU_FEAT_HAFT;
+		fallthrough;
 	case IDR0_HTTU_ACCESS_DIRTY:
 		smmu->features |= ARM_SMMU_FEAT_HD;
 		fallthrough;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index c909c9a88538..61a7df5afb99 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -40,6 +40,7 @@ struct arm_vsmmu;
 #define IDR0_HTTU			GENMASK(7, 6)
 #define IDR0_HTTU_ACCESS		1
 #define IDR0_HTTU_ACCESS_DIRTY		2
+#define IDR0_HTTU_ACCESS_DIRTY_HAFT	3
 #define IDR0_COHACC			(1 << 4)
 #define IDR0_TTF			GENMASK(3, 2)
 #define IDR0_TTF_AARCH64		2
@@ -369,6 +370,7 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(unsigned int ssid)
 #define CTXDESC_CD_0_ASET		(1UL << 47)
 #define CTXDESC_CD_0_ASID		GENMASK_ULL(63, 48)
 
+#define CTXDESC_CD_1_HAFT		(1UL << 3)
 #define CTXDESC_CD_1_TTB0_MASK		GENMASK_ULL(51, 4)
 
 /*
@@ -921,6 +923,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_HD		(1 << 22)
 #define ARM_SMMU_FEAT_S2FWB		(1 << 23)
 #define ARM_SMMU_FEAT_BBML2		(1 << 24)
+#define ARM_SMMU_FEAT_HAFT		(1 << 25)
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
-- 
2.54.0.dirty

