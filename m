Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046740;
	b=JXSGqT4KyPMMuAU7o4T8vbrt5rQ6bkp2n9+8A/YpkC1/T97da1MJZ472ObWGZ6a2Qqdb
	 0k/rZfM9TDVFxl7j4wYpWzBpfyeDOJjr6dmXuEIMBj5ktmXPE3d1FZv+KU32qvz4KmCbB
	 99cs8B1N154Cm9l4rasOxL4zVKvBchgtmTpSG5k3a2+jQDOJRg4UeNsB3qJ0OH23HpADS
	 4Dloou2jPfDClf5zrgM8sjIr/IHYWhz0cKr24EpCarnNWKhKGsXsac0tSNufsQgE6qZQN
	 BWMl4i43BDwCG1kt1g/005dSGI7UwgVDrjebzvFIGJpNYiPDe94qMLVOAL3QJJ9BLNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046740;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=bxTI7F2tO3zqmV/iVO9SIkGtgWJTdmv8WtySdMX1RpM=;
	b=FRZcZiNQzgfSFiyDOhvex3j/b/LUyf+WqTDhqECDzKWQ82JSnZtbkTPgPNNo0ZLPDlyT
	 tYZDHHNxzwYIdOiex4d9ob+1SE0SvTnwejYz+ZNl8ckDochzvJjTh30A0l8JIA2H5lmwb
	 SI0KYEKksI9XgTdkd7XVIxFgbvZlnLXnr3xyMsuXccIv0lEMsjf3nQF4cdak6bX0vaq5Y
	 KunaMPJ3vnkhsMql7jtNuDZlMb3ZdtWIzPWC84dYgV3AreX0MP/CTG6bU+vJ7Q/M53n23
	 NeT1+85QoSdhdsVdxQRlcmCMKk9cHhJ2vBnfZUfqpY/348F2Mv9NHqee4/77gV9kQdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GRFVkl8q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D063B606A33B
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GRFVkl8q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA411F008A4;
	Sat,  7 Nov 2026 10:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046739;
	bh=bxTI7F2tO3zqmV/iVO9SIkGtgWJTdmv8WtySdMX1RpM=;
	h=From:To:Cc:Subject:Date;
	b=GRFVkl8qbS7rAuZvn/wZh+tKbAw9FMRSVEEP6IbLLWCaDOtjKvLCEkFArk6JmWjaE
	 IsCUQbZum4mCgDYJ3GUcwq0A5+Xq4t0ZO63NllZ1oVH02S5QbcTolvKiv6j55x6gIm
	 CRIzoOp9No1vVUaIYugKbpoU3RGGKBWu9WpTcEk6JU80NBpRqVwKggiXxnhJlhv+uh
	 Bb9uGlgIhdJY/mE1mGJBrxHWZ1f3v6eD7RRuAKL+0EBRLrGFOwxyJRgMRnG3zd721I
	 utkqaUOQJuGBPDqO5heqIVy3crgTsKeWL0RpFihCk+d4BO17HawQjisw1eX5ENkekw
	 8/4refSbUBSWQ==
From: Sasha Levin <sashal@kernel.org>
To: jgg@ziepe.ca,
	vijayanand.jitta@oss.qualcomm.com,
	smostafa@google.com,
	peaan@google.com,
	nicolinc@nvidia.com,
	praan@google.com,
	jgg@nvidia.com,
	will@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] iommu/arm-smmu-v3: Handle ARM erratum for CONT under invalidation with SVA" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:18:57 -0500
Message-ID: <20261107051857-failed-6.12-84c6089a365f@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 84c6089a365ff5547f9ea30cb407dc5fe3124fd3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051857-failed-6.12-84c6089a365f@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 84c6089a365ff5547f9ea30cb407dc5fe3124fd3 Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgg@nvidia.com>
Date: Fri, 2 Oct 2026 22:23:20 -0300
Subject: [PATCH] iommu/arm-smmu-v3: Handle ARM erratum for CONT under
 invalidation with SVA

The erratum (MMU-700: #3777127, S3: #3673557) deals with under
invalidation of a CONT PTE grouping in the SMMU. The recommended work
around is to use a range invalidation that spans the entire CONT. The only
user of CONT in the kernel right now is through SVA sharing a CPU page
table that contains a CONT created by the mm.

Previously it was thought that this errata was dealt with because the
driver always uses range invalidation. However, there is a subtle detail
in the errata that the invalidation range must fully enclose the entire
CONT for it to work.

It seems that two sequential range invalidations, with a split point
falling inside a CONT grouping, will not prevent the errata.

The SMMU's range invalidation generation algorithm does not produce a
single invalidation for a single SVA invalidation request, nor does the mm
carefully align the SVA invalidation ranges to accommodate the splitting
of the invalidation into several ranges.

Thus, when processing a SVA invalidation, the range invalidation splitting
routine can generate a range invalidation that is split in the middle of
the CONT and risk under invalidation from this errata. This condition
could be triggered by a malicious userspace manipulating the TLB gathers
via mmap/mprotect/munmap.

Update the errata list to the include the S3 variation, detect the IOMMUs
that have it, and then have SVA invalidations use a simplified version of
the over invalidation algorithm from the tlbi rework series. This ensures
that a single range invalidation is issued for a single MMU notifier
callback and now the range invalidation is guarenteed to cover any posible
CONT.

Future work to add CONT to iommu_domain page tables should either use this
one-invalidate/one-range invalidation algorithm or disable CONT support in
the iommu_domain.

Cc: stable@vger.kernel.org
Cc: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Fixes: 3f1ce8e85ee0 ("iommu/arm-smmu-v3: Share process page tables")
Reviewed-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Pranjal Shrivastava <peaan@google.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 Documentation/arch/arm64/silicon-errata.rst   |  3 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  7 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 89 +++++++++++++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  5 ++
 4 files changed, 87 insertions(+), 17 deletions(-)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index ac3248b9f2f3b..68018bf75b791 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -271,7 +271,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | MMU L1          | #3878312        | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
-| ARM            | MMU S3          | #3995052        | N/A                         |
+| ARM            | MMU S3          | #3995052,       | N/A                         |
+|                |                 | #3673557        |                             |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | GIC-700         | #2941627        | ARM64_ERRATUM_2941627       |
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 0a429c64fbf3e..3f50298a1c14c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -215,6 +215,13 @@ bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
 	if (system_supports_haft())
 		feat_mask |= ARM_SMMU_FEAT_HAFT;
 
+	/*
+	 * The workaround for ARM_SMMU_OPT_FULL_CONT_RANGE_INV requires range
+	 * invalidation support.
+	 */
+	if (smmu->options & ARM_SMMU_OPT_FULL_CONT_RANGE_INV)
+		feat_mask |= ARM_SMMU_FEAT_RANGE_INV;
+
 	if ((smmu->features & feat_mask) != feat_mask)
 		return false;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 658d2cdfa2863..502745984a536 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2560,6 +2560,37 @@ static void arm_smmu_cmdq_batch_add_range(struct arm_smmu_device *smmu,
 	}
 }
 
+/*
+ * Generate a range invalidation for ARM_SMMU_OPT_FULL_CONT_RANGE_INV by
+ * ensuring the entire SVA requested range is covered with a single range
+ * invalidation command. The scale is adjusted so that the range invalidation
+ * may extend past the end of the requested range. This ensures that any CONT
+ * the MM is invalidating is covered by a single range invalidation. TTL and
+ * LEAF are always 0 because this is only used by SVA.
+ */
+static bool arm_smmu_cmdq_batch_add_range_inv(struct arm_smmu_device *smmu,
+					      struct arm_smmu_cmdq_batch *cmds,
+					      struct arm_smmu_cmd *cmd,
+					      unsigned long iova, size_t size,
+					      u8 tgsz_lg2)
+{
+	u64 cur_tg = iova >> tgsz_lg2;
+	u64 num_tg = ((iova + size - 1) >> tgsz_lg2) - cur_tg + 1;
+	unsigned int scale = fls64((num_tg - 1) / 32);
+
+	if (scale > 31)
+		return false;
+
+	cmd->data[0] |=
+		FIELD_PREP(CMDQ_TLBI_0_NUM,
+			   DIV_ROUND_UP_ULL(num_tg, 1ULL << scale) - 1) |
+		FIELD_PREP(CMDQ_TLBI_0_SCALE, scale);
+	cmd->data[1] = FIELD_PREP(CMDQ_TLBI_1_TG, (tgsz_lg2 - 10) / 2) |
+		       (cur_tg << tgsz_lg2);
+	arm_smmu_cmdq_batch_add_cmd_p(smmu, cmds, cmd);
+	return true;
+}
+
 static bool arm_smmu_inv_size_too_big(struct arm_smmu_device *smmu, size_t size,
 				      size_t granule)
 {
@@ -2587,21 +2618,30 @@ static bool arm_smmu_inv_size_too_big(struct arm_smmu_device *smmu, size_t size,
 static void arm_smmu_inv_to_cmdq_batch(struct arm_smmu_inv *inv,
 				       struct arm_smmu_cmdq_batch *cmds,
 				       struct arm_smmu_cmd *cmd,
-				       bool leaf,
+				       bool single_range_inv, bool leaf,
 				       unsigned long iova, size_t size,
 				       unsigned int granule)
 {
-	if (arm_smmu_inv_size_too_big(inv->smmu, size, granule)) {
-		struct arm_smmu_cmd nsize_cmd = *cmd;
+	struct arm_smmu_cmd nsize_cmd;
+
+	if (arm_smmu_inv_size_too_big(inv->smmu, size, granule))
+		goto full_inv;
 
-		u64p_replace_bits(&nsize_cmd.data[0], inv->nsize_opcode,
-				  CMDQ_0_OP);
-		arm_smmu_cmdq_batch_add_cmd_p(inv->smmu, cmds, &nsize_cmd);
+	if (single_range_inv && size > granule) {
+		if (!arm_smmu_cmdq_batch_add_range_inv(inv->smmu, cmds, cmd,
+						       iova, size, inv->pgsize))
+			goto full_inv;
 		return;
 	}
 
-	arm_smmu_cmdq_batch_add_range(inv->smmu, cmds, cmd, leaf,
-				      iova, size, granule, inv->pgsize);
+	arm_smmu_cmdq_batch_add_range(inv->smmu, cmds, cmd, leaf, iova, size,
+				      granule, inv->pgsize);
+	return;
+
+full_inv:
+	nsize_cmd = *cmd;
+	u64p_replace_bits(&nsize_cmd.data[0], inv->nsize_opcode, CMDQ_0_OP);
+	arm_smmu_cmdq_batch_add_cmd_p(inv->smmu, cmds, &nsize_cmd);
 }
 
 static inline bool arm_smmu_invs_end_batch(struct arm_smmu_inv *cur,
@@ -2622,7 +2662,8 @@ static inline bool arm_smmu_invs_end_batch(struct arm_smmu_inv *cur,
 
 static void __arm_smmu_domain_inv_range(struct arm_smmu_invs *invs,
 					unsigned long iova, size_t size,
-					unsigned int granule, bool leaf)
+					unsigned int granule,
+					bool single_range_inv, bool leaf)
 {
 	struct arm_smmu_cmdq_batch cmds = {};
 	struct arm_smmu_inv *cur;
@@ -2652,14 +2693,16 @@ static void __arm_smmu_domain_inv_range(struct arm_smmu_invs *invs,
 		case INV_TYPE_S1_ASID:
 			cmd = arm_smmu_make_cmd_tlbi(cur->size_opcode,
 						     cur->id, 0);
-			arm_smmu_inv_to_cmdq_batch(cur, &cmds, &cmd, leaf,
-						   iova, size, granule);
+			arm_smmu_inv_to_cmdq_batch(cur, &cmds, &cmd,
+						   single_range_inv, leaf, iova,
+						   size, granule);
 			break;
 		case INV_TYPE_S2_VMID:
 			cmd = arm_smmu_make_cmd_tlbi(cur->size_opcode,
 						     0, cur->id);
-			arm_smmu_inv_to_cmdq_batch(cur, &cmds, &cmd, leaf,
-						   iova, size, granule);
+			arm_smmu_inv_to_cmdq_batch(cur, &cmds, &cmd,
+						   single_range_inv, leaf, iova,
+						   size, granule);
 			break;
 		case INV_TYPE_S2_VMID_S1_CLEAR:
 			/* CMDQ_OP_TLBI_S12_VMALL already flushed S1 entries */
@@ -2706,6 +2749,9 @@ void arm_smmu_domain_inv_range(struct arm_smmu_domain *smmu_domain,
 			       unsigned int granule, bool leaf)
 {
 	struct arm_smmu_invs *invs;
+	bool single_range_inv =
+		smmu_domain->stage == ARM_SMMU_DOMAIN_SVA &&
+		(smmu_domain->smmu->options & ARM_SMMU_OPT_FULL_CONT_RANGE_INV);
 
 	/*
 	 * An invalidation request must follow some IOPTE change and then load
@@ -2745,10 +2791,12 @@ void arm_smmu_domain_inv_range(struct arm_smmu_domain *smmu_domain,
 		unsigned long flags;
 
 		read_lock_irqsave(&invs->rwlock, flags);
-		__arm_smmu_domain_inv_range(invs, iova, size, granule, leaf);
+		__arm_smmu_domain_inv_range(invs, iova, size, granule,
+					    single_range_inv, leaf);
 		read_unlock_irqrestore(&invs->rwlock, flags);
 	} else {
-		__arm_smmu_domain_inv_range(invs, iova, size, granule, leaf);
+		__arm_smmu_domain_inv_range(invs, iova, size, granule,
+					    single_range_inv, leaf);
 	}
 
 	rcu_read_unlock();
@@ -5081,11 +5129,20 @@ static void arm_smmu_device_iidr_probe(struct arm_smmu_device *smmu)
 				/* Arm errata 2268618, 2812531 */
 				smmu->features &= ~ARM_SMMU_FEAT_NESTING;
 			}
+			/* Arm errata 3777127 */
+			smmu->options |= ARM_SMMU_OPT_FULL_CONT_RANGE_INV;
 			break;
 		case IIDR_PRODUCTID_ARM_MMU_L1:
+			/* Arm errata 3878312 */
+			smmu->features &= ~ARM_SMMU_FEAT_BTM;
+			break;
 		case IIDR_PRODUCTID_ARM_MMU_S3:
-			/* Arm errata 3878312/3995052 */
+			/* Arm errata 3995052 */
 			smmu->features &= ~ARM_SMMU_FEAT_BTM;
+			/* Arm errata 3673557 */
+			if (variant < 1 || (variant == 1 && revision < 1))
+				smmu->options |=
+					ARM_SMMU_OPT_FULL_CONT_RANGE_INV;
 			break;
 		}
 		break;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index cbfb3e9f50958..0a1bb75467dbd 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -940,6 +940,11 @@ struct arm_smmu_device {
 #define ARM_SMMU_OPT_CMDQ_FORCE_SYNC	(1 << 3)
 #define ARM_SMMU_OPT_TEGRA241_CMDQV	(1 << 4)
 #define ARM_SMMU_OPT_OVR_INSTCFG_DATA	(1 << 5)
+/*
+ * Range invalidation is mandatory and one range invalidation must fully span an
+ * invalidated CONT
+ */
+#define ARM_SMMU_OPT_FULL_CONT_RANGE_INV (1 << 6)
 	u32				options;
 
 	struct arm_smmu_cmdq		cmdq;
-- 
2.53.0




