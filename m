Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D32EEC3
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 01:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785635360; cv=none; b=p7g/heXCg34CNmSSuqbYVYisMFN1SUQH+fryuyw2ebGLVD4q0lqlNTByngFt6muabeUo2+JfyL9yJ+niIcoOe7MMsNMfagD02IIBalPRB7bURojak6w5r9MHIZhX6DlDf5Bz9xWjseGy4QEpygqQvAWgXegbskp4hZpTiaHQevk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785635360; c=relaxed/simple;
	bh=PGvvp6oLlhaIcrpyOPBpP/A2zy2P9DIVrg5z8y/X+DY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ey9RjRVql4p9gYe6zG5OobBzHuPBhQXf681cUZEs3T73bACvdmwh+AGoypKfO3gA4r1Wd5cdL8D/BUV82MUhIy4ulAZX4G0/b3cl+Xet66fExHNF++doGtlrL2cCSZRLM2aaqGKdCbmshrVK2f5xqMEMpupwmG6tyhZN8/Aeux8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+WaCkq6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+WaCkq6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3EF31F00AC4;
	Sun,  2 Aug 2026 01:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785635359;
	bh=hoUfPtFq04YZDnP/1g16BzpMKo+GtDmw1gtnKJ3ZSNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a+WaCkq6e4Qe616v1GBNkRXQwl+daWt2T/cStmbSXGWBhNn2FhaPaDsw8X0B5b93+
	 7s+0iDM4iJ3RWxstVCGDfA6b5dnRLEC7zeMVLqfGmmCGPJenVvMMyC78bKNctlegP5
	 MGuWlcflEozDZZgETAoa/QyZCl6IeB1c/hubII2ZjyjAqWjM4JOM9jErZ1QgKx6TEP
	 kaw3w0+1m2EReJuTIWf6TdQJIEicZH8Vi4+37nHulKmwuaniQZg8RBxFcAVSL6f+tY
	 R25+6ZrEsQLanwpPUKT1blKgzMl7hahOtAyAlK2Y4GUSqyM8mT8ECvXW+Oo2/o4T8+
	 bGIpSIVpjDrJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/4] drm/xe: Use SVM range helpers in PT layer
Date: Sat,  1 Aug 2026 21:49:12 -0400
Message-ID: <20260802014916.504747-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072945-jaybird-vaguely-739f@gregkh>
References: <2026072945-jaybird-vaguely-739f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthew Brost <matthew.brost@intel.com>

[ Upstream commit 9ea9b45701ab50049a722450abc28346d1121e6e ]

We have helpers SVM range start, end, and size. Use them in the PT
layer rather than directly looking at the struct.

Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Link: https://lore.kernel.org/r/20251022230122.922382-1-matthew.brost@intel.com
Stable-dep-of: 6384271ac1ac ("drm/xe/pt: Reset current_op in xe_pt_update_ops_init()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_pt.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
index 1f0262adc3ae..a32752c57ea4 100644
--- a/drivers/gpu/drm/xe/xe_pt.c
+++ b/drivers/gpu/drm/xe/xe_pt.c
@@ -715,7 +715,7 @@ xe_pt_stage_bind(struct xe_tile *tile, struct xe_vma *vma,
 		.vm = vm,
 		.tile = tile,
 		.curs = &curs,
-		.va_curs_start = range ? range->base.itree.start :
+		.va_curs_start = range ? xe_svm_range_start(range) :
 			xe_vma_start(vma),
 		.vma = vma,
 		.wupd.entries = entries,
@@ -734,7 +734,7 @@ xe_pt_stage_bind(struct xe_tile *tile, struct xe_vma *vma,
 		}
 		if (xe_svm_range_has_dma_mapping(range)) {
 			xe_res_first_dma(range->base.pages.dma_addr, 0,
-					 range->base.itree.last + 1 - range->base.itree.start,
+					 xe_svm_range_size(range),
 					 &curs);
 			xe_svm_range_debug(range, "BIND PREPARE - MIXED");
 		} else {
@@ -778,8 +778,8 @@ xe_pt_stage_bind(struct xe_tile *tile, struct xe_vma *vma,
 
 walk_pt:
 	ret = xe_pt_walk_range(&pt->base, pt->level,
-			       range ? range->base.itree.start : xe_vma_start(vma),
-			       range ? range->base.itree.last + 1 : xe_vma_end(vma),
+			       range ? xe_svm_range_start(range) : xe_vma_start(vma),
+			       range ? xe_svm_range_end(range) : xe_vma_end(vma),
 			       &xe_walk.base);
 
 	*num_entries = xe_walk.wupd.num_used_entries;
@@ -983,8 +983,8 @@ bool xe_pt_zap_ptes_range(struct xe_tile *tile, struct xe_vm *vm,
 	if (!(pt_mask & BIT(tile->id)))
 		return false;
 
-	(void)xe_pt_walk_shared(&pt->base, pt->level, range->base.itree.start,
-				range->base.itree.last + 1, &xe_walk.base);
+	(void)xe_pt_walk_shared(&pt->base, pt->level, xe_svm_range_start(range),
+				xe_svm_range_end(range), &xe_walk.base);
 
 	return xe_walk.needs_invalidate;
 }
@@ -1701,8 +1701,8 @@ static unsigned int xe_pt_stage_unbind(struct xe_tile *tile,
 				       struct xe_svm_range *range,
 				       struct xe_vm_pgtable_update *entries)
 {
-	u64 start = range ? range->base.itree.start : xe_vma_start(vma);
-	u64 end = range ? range->base.itree.last + 1 : xe_vma_end(vma);
+	u64 start = range ? xe_svm_range_start(range) : xe_vma_start(vma);
+	u64 end = range ? xe_svm_range_end(range) : xe_vma_end(vma);
 	struct xe_pt_stage_unbind_walk xe_walk = {
 		.base = {
 			.ops = &xe_pt_stage_unbind_ops,
@@ -1912,7 +1912,7 @@ static int bind_range_prepare(struct xe_vm *vm, struct xe_tile *tile,
 
 	vm_dbg(&xe_vma_vm(vma)->xe->drm,
 	       "Preparing bind, with range [%lx...%lx)\n",
-	       range->base.itree.start, range->base.itree.last);
+	       xe_svm_range_start(range), xe_svm_range_end(range) - 1);
 
 	pt_op->vma = NULL;
 	pt_op->bind = true;
@@ -1927,8 +1927,8 @@ static int bind_range_prepare(struct xe_vm *vm, struct xe_tile *tile,
 					pt_op->num_entries, true);
 
 		xe_pt_update_ops_rfence_interval(pt_update_ops,
-						 range->base.itree.start,
-						 range->base.itree.last + 1);
+						 xe_svm_range_start(range),
+						 xe_svm_range_end(range));
 		++pt_update_ops->current_op;
 		pt_update_ops->needs_svm_lock = true;
 
@@ -2023,7 +2023,7 @@ static int unbind_range_prepare(struct xe_vm *vm,
 
 	vm_dbg(&vm->xe->drm,
 	       "Preparing unbind, with range [%lx...%lx)\n",
-	       range->base.itree.start, range->base.itree.last);
+	       xe_svm_range_start(range), xe_svm_range_end(range) - 1);
 
 	pt_op->vma = XE_INVALID_VMA;
 	pt_op->bind = false;
@@ -2034,8 +2034,8 @@ static int unbind_range_prepare(struct xe_vm *vm,
 
 	xe_vm_dbg_print_entries(tile_to_xe(tile), pt_op->entries,
 				pt_op->num_entries, false);
-	xe_pt_update_ops_rfence_interval(pt_update_ops, range->base.itree.start,
-					 range->base.itree.last + 1);
+	xe_pt_update_ops_rfence_interval(pt_update_ops, xe_svm_range_start(range),
+					 xe_svm_range_end(range));
 	++pt_update_ops->current_op;
 	pt_update_ops->needs_svm_lock = true;
 	pt_update_ops->needs_invalidation |= xe_vm_has_scratch(vm) ||
-- 
2.53.0

