Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050326;
	b=Y5zsgpZu+yHoOI9lWs0a9bpwclwX12ti9OFNCcB/zZ9sqsE6zfuuuIzl4PlIyKdQ9+fc
	 TAyUwK80zsjRRNKO38Gvw2688yB2sRbnkdjcWKEc2h4kKIJtIZl9gEbfq07Uir5bP/nTe
	 FMBlhybxzKlfU1x9/PMuIb/koy9Fyi3HwqSv+V5oIo4Brw+/sgBf9ySefllcszzD0w5nl
	 9ppCBrPbRZVOJ4JmQqQJ9YsdeurM1xU/6ijjp7/Gs2xL9nBqiL6EmrMzT9vliKd88ZaVq
	 +jXVP17H/eZg1/1lD5vCoWC34xe0XHAVGMqGx9iUwwkx0Y27mhWin5ZoEg2HfQtnfTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050326;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=4XGgsIyzY7v098XwUrp0HWoX+EcrrDc1LpwcNCggLZQ=;
	b=bodfHxZT/kj2QVCBP5E/x+sHdCekQd0Y6nkyYyzd/gHWPzYqvqTCnCiBsFEu6q5E4St4
	 YaZ0X8x73znwnj4MGvxUvdDnPPs9T7bzIpZDsNYVqkCcL5Wp8+OPZTq+P0n6eGpPdM0On
	 /rCsAz0V5+6utQ+5dRBqqLgsA0Dnp9BFcFBuXxNxLJDyFQQcI03TLw5dNfcXuzGB4hJ+S
	 swvWdXFy+ou6TFVxziN87895Vy+5CLrNsvSrSSYn07TBbb1LPgQE4SpAExlm957Zd/U95
	 suvHsg3reHRWmy88XkNDy5MY1iSlj2ns36szC0Y86WO7kE/mUAtlxaYHlsPMBDmQt2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n2ouYpHU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71CF606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n2ouYpHU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D661F0089F;
	Sat,  7 Nov 2026 11:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050325;
	bh=4XGgsIyzY7v098XwUrp0HWoX+EcrrDc1LpwcNCggLZQ=;
	h=From:To:Cc:Subject:Date;
	b=n2ouYpHUkSU1OslFDqA7m4gbgrncB5KwGq/uMsYlAVKzJnqA9QRQB4Okc1RUfmVml
	 mhJ/DnLqfT89oyWpe+mOmJLalolnZUfVGFso67hiHd4QwiEq+2zx0XSKYppOIUfsN5
	 5sl4/FjAdt40vH2sEnxHSh4e8hD7RNd5UjUHyiPNI6PG8LCOVkgTmAQ/OqsrRMaSgp
	 uASVFqqa8vynPKbnpGy/GZaanNdzFaGLKvitKjBaEg8ktXjfeEPDqqDrePsw5AMy/t
	 F3wHl6/4JzEOY+dAPiUy3qvy3XLRIB6yuJsFkLUczQ9RzInb4Eq9BGN8BIy03q739P
	 Lk8GB9Ah6oZSQ==
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
Subject: FAILED: patch "[PATCH] iommu/arm-smmu-v3: Handle ARM erratum for CONT under invalidation with SVA" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:18:43 -0500
Message-ID: <20261107061843-failed-5.10-84c6089a365f@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 84c6089a365ff5547f9ea30cb407dc5fe3124fd3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061843-failed-5.10-84c6089a365f@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




