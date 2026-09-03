Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5514B2713
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447919; cv=none; b=qh1XnlMKGWH8pxbnwp34YDjEpRKeHLiHzSyQ/KDPVe/Q1mjDpLTP0PPSDlbaud6xLVmIOzqms0YU0ReeS+mQxdYUy3zO20+stsTFOPtyAEdVj/udHd0N6Y6P91JXtgXhVVXJILPFTd621wprPGlQvT7q5OuIKcfOD7BvhVgBMuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447919; c=relaxed/simple;
	bh=Lezfc+Bl5DjTokTA7kmWcD1PB59Ip4vISEapFJPoc30=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ormMMTF3/newqxxFwcf3mAAEbUpov87dvzhR53F/n6u4L1JwaEb6Orqd45p3N0EQoE/1afm3kYhkkTjSM8rMhKfESILcJi/aHC/cJiYUGc6z9QZ9tsAJTf75Cdr1pw5zxqpIN7lO5p9i23zcgP6XyVH4HRAb/aE4452zpT5bDos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o75bxsF3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o75bxsF3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A603B1F000E9;
	Thu,  3 Sep 2026 15:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788447918;
	bh=vKhgfj/H8o/S0JW8Y5cebvxIajJHjJN14DqOn429DKU=;
	h=Subject:To:Cc:From:Date;
	b=o75bxsF3cU6c9jA015hVece9UN02F26wwmdEB+3xrlPF8fdLESZQv2DD6neSF5zMP
	 0kwvIhKgF7EgubmOivgGD8Qp62Fr2PCTQzUGvZRuQqsPkVWeCCR4IVjDm9y4qw6ElF
	 i62rkLbW/mWq4NvQE5Q1iFWn94f30CurdfBlAIio=
Subject: FAILED: patch "[PATCH] iommu/arm-smmu-v3: Add HAFT support for SVA" failed to apply to 6.18-stable tree
To: robin.murphy@arm.com,jgg@nvidia.com,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:45:08 +0200
Message-ID: <2026090308-zit-anaerobic-0133@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x f99d3b4bb095c4966cf58154077e8bb69ee4827f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090308-zit-anaerobic-0133@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f99d3b4bb095c4966cf58154077e8bb69ee4827f Mon Sep 17 00:00:00 2001
From: Robin Murphy <robin.murphy@arm.com>
Date: Mon, 27 Jul 2026 13:03:29 +0100
Subject: [PATCH] iommu/arm-smmu-v3: Add HAFT support for SVA

Since table access flags cannot be software-managed, if process
pagetables are using HAFT then SVA must require the SMMU to support and
enable it too, otherwise page aging is liable to get out of whack.

For unbinding, we can't disable HAFT atomically with HA as might be
desired, but luckily we can get away with just not disabling HA either.

Cc: stable@vger.kernel.org
Fixes: 62df5870ebf7 ("arm64: Enable ARCH_HAS_NONLEAF_PMD_YOUNG")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Will Deacon <will@kernel.org>

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 1ed8a6f29dc4..4cd60d3c450a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -92,16 +92,6 @@ void arm_smmu_make_sva_cd(struct arm_smmu_cd *target,
 
 		target->data[1] = cpu_to_le64(virt_to_phys(mm->pgd) &
 					      CTXDESC_CD_1_TTB0_MASK);
-
-		/*
-		 * Enable Hardware Access and Dirty updates (DBM) if supported.
-		 * This is safe to enable by default, as PTE_WRITE and PTE_DBM
-		 * share the same bit.
-		 */
-		if (master->smmu->features & ARM_SMMU_FEAT_HA)
-			target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_HA);
-		if (master->smmu->features & ARM_SMMU_FEAT_HD)
-			target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_HD);
 	} else {
 		target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_EPD0);
 
@@ -114,6 +104,17 @@ void arm_smmu_make_sva_cd(struct arm_smmu_cd *target,
 			target->data[0] &=
 				cpu_to_le64(~(CTXDESC_CD_0_S | CTXDESC_CD_0_R));
 	}
+	/*
+	 * Enable Hardware Access and Dirty updates (DBM) if supported. This is
+	 * safe to enable by default, as PTE_WRITE and PTE_DBM share the same bit,
+	 * while the EPD0 config can't get as far as fetching any PTEs anyway.
+	 */
+	if (master->smmu->features & ARM_SMMU_FEAT_HA)
+		target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_HA);
+	if (master->smmu->features & ARM_SMMU_FEAT_HD)
+		target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_HD);
+	if (master->smmu->features & ARM_SMMU_FEAT_HAFT && system_supports_haft())
+		target->data[1] |= cpu_to_le64(CTXDESC_CD_1_HAFT);
 
 	/*
 	 * MAIR value is pretty much constant and global, so we can just get it
@@ -211,6 +212,9 @@ bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
 	if (system_supports_bbml2_noabort())
 		feat_mask |= ARM_SMMU_FEAT_BBML2;
 
+	if (system_supports_haft())
+		feat_mask |= ARM_SMMU_FEAT_HAFT;
+
 	if ((smmu->features & feat_mask) != feat_mask)
 		return false;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 3a9cbd7d8a00..267dfc40919c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5015,10 +5015,14 @@ static void arm_smmu_device_iidr_probe(struct arm_smmu_device *smmu)
 
 static void arm_smmu_get_httu(struct arm_smmu_device *smmu, u32 reg)
 {
-	u32 fw_features = smmu->features & (ARM_SMMU_FEAT_HA | ARM_SMMU_FEAT_HD);
+	u32 fw_features = smmu->features & (ARM_SMMU_FEAT_HA | ARM_SMMU_FEAT_HD |
+					    ARM_SMMU_FEAT_HAFT);
 	u32 hw_features = 0;
 
 	switch (FIELD_GET(IDR0_HTTU, reg)) {
+	case IDR0_HTTU_ACCESS_DIRTY_HAFT:
+		hw_features |= ARM_SMMU_FEAT_HAFT;
+		fallthrough;
 	case IDR0_HTTU_ACCESS_DIRTY:
 		hw_features |= ARM_SMMU_FEAT_HD;
 		fallthrough;
@@ -5350,6 +5354,9 @@ static int arm_smmu_device_acpi_probe(struct platform_device *pdev,
 		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
 
 	switch (FIELD_GET(ACPI_IORT_SMMU_V3_HTTU_OVERRIDE, iort_smmu->flags)) {
+	case IDR0_HTTU_ACCESS_DIRTY_HAFT:
+		smmu->features |= ARM_SMMU_FEAT_HAFT;
+		fallthrough;
 	case IDR0_HTTU_ACCESS_DIRTY:
 		smmu->features |= ARM_SMMU_FEAT_HD;
 		fallthrough;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 43f4d24e7847..98191075242a 100644
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
@@ -922,6 +924,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_HD		(1 << 22)
 #define ARM_SMMU_FEAT_S2FWB		(1 << 23)
 #define ARM_SMMU_FEAT_BBML2		(1 << 24)
+#define ARM_SMMU_FEAT_HAFT		(1 << 25)
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)

