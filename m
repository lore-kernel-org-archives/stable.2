Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD3226D4CA
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 23:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780357300; cv=none; b=Cv80v/ZvaMK9pqbf8pS8LqJA+dVrDtbmaoTYiFAdOwmpEs54gzouxOChDG3icbG+TbEzspXWDIrWcm2vwCcY/LkT/BzYFTG7YrFuUcOI6L6HZtNuh94k9acfiL5Mc9xFmbjtTQ4A2JKM7rGgMbxV6OdZ9LAsR5/G5eGOjAj9AWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780357300; c=relaxed/simple;
	bh=BMgOF1hL7xNoFricd/B7Hlk7G5Rsm6O7+6W4w495Prc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G5NmXjwQ0Qb1CIkTcoOq3D+aVjoqCnckS7zuUL55AErX09s/9aFMtVYeXnnbpH00283SV8koomNmIw+aL2aL3OjpPmtHCZhZIeahdPHivWGsRC01jGUxHT+35rCf9N77td2RxQWHEJC8W4AGEMwCR0PF//vQUhpoBO/gcXRG/iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I2FACQa7; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I2FACQa7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780357298; x=1811893298;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BMgOF1hL7xNoFricd/B7Hlk7G5Rsm6O7+6W4w495Prc=;
  b=I2FACQa7C5R/3iKibnLrK9ci4+j6ZK5hWOLfT534zYqXyOyuvrvZKucb
   EM88s7ePvzCl/z/t8Gknt55hnm25bVx2NBpePe4Q2cunhMoUrtXZNBLw/
   zg1W2PVrdNe24Py4WGIYaKNurpF6GdG1KOKDPix8ffnmNyRmEfkmtXJCl
   my7onZL5gFS6NQ45a00M1UjDXA8LaAu6yywqDqM/shizkWXrRr4/iZzHz
   63dwZ/kMbzsEBX1m4721Y5HJQihRCWSH2VEvzU0RAYRVdl8Iwvs+H/dN0
   UXQOy7urzfwAEoyLaten9G+YhfWIuG0zC4l4nhXZhEhB6rvK3sxwNSKmW
   Q==;
X-CSE-ConnectionGUID: M3apbFp5SgaJ9rh+GRXeKw==
X-CSE-MsgGUID: ZdoazGXhQHuSj1QLqYXpYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="84981716"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="84981716"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 16:41:37 -0700
X-CSE-ConnectionGUID: F7CvCWj3R0SMxJb4Poo/Nw==
X-CSE-MsgGUID: 9A/F29d+SWCjlEDin9i+Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="273993363"
Received: from dut4463arlhx.fm.intel.com ([10.105.10.159])
  by orviesa002.jf.intel.com with ESMTP; 01 Jun 2026 16:41:36 -0700
From: Brian Nguyen <brian3.nguyen@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Brian Nguyen <brian3.nguyen@intel.com>,
	stable@vger.kernel.org,
	Matthew Auld <matthew.auld@intel.com>,
	Zongyao Bai <zongyao.bai@intel.com>
Subject: [PATCH v2] drm/xe: Add compact-PT and addr mask handling for page reclaim
Date: Mon,  1 Jun 2026 23:41:37 +0000
Message-ID: <20260601234136.1444344-2-brian3.nguyen@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current implementation of generate_reclaim_entry() overlooks some
differences between the different page implementations: address masking
and compact 64K page handling.

Address masking of each leaf varies depending on the leaf entry size.
generate_reclaim_entry() is using XE_PTE_ADDR_MASK [51:12] for all leaf
entries. For 2MB PTEs, bit 12 (PAT) is part of the flags so the old mask
corrupts the physical address extraction.

64K pages can be represented as PS64 and a compact PT, which the latter
was not handled. Compact pages aren't walked by the unbind walker, so we
separately walk through the compact PT to ensure none of the leaf 64K
PTEs are dropped. Previously, compact pt were causing an abort since it
was considered covered and not descended into.

v2:
 - Update 64K entry/unbind walker for 64K compact PT handling. (Matthew)
 - Rework calculations of reclamation and address mask size.
 - Add new func abstracting the error handling before generating the
   reclaim entry.

Fixes: b912138df299 ("drm/xe: Create page reclaim list on unbind")
Cc: stable@vger.kernel.org
Cc: Matthew Auld <matthew.auld@intel.com>
Suggested-by: Zongyao Bai <zongyao.bai@intel.com>
Signed-off-by: Brian Nguyen <brian3.nguyen@intel.com>
---
 drivers/gpu/drm/xe/regs/xe_gtt_defs.h |   2 +-
 drivers/gpu/drm/xe/xe_pt.c            | 129 +++++++++++++++-----------
 2 files changed, 77 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/xe/regs/xe_gtt_defs.h b/drivers/gpu/drm/xe/regs/xe_gtt_defs.h
index 4d83461e538b..5fa2d8ab7776 100644
--- a/drivers/gpu/drm/xe/regs/xe_gtt_defs.h
+++ b/drivers/gpu/drm/xe/regs/xe_gtt_defs.h
@@ -9,7 +9,7 @@
 #define XELPG_GGTT_PTE_PAT0	BIT_ULL(52)
 #define XELPG_GGTT_PTE_PAT1	BIT_ULL(53)
 
-#define XE_PTE_ADDR_MASK	GENMASK_ULL(51, 12)
+#define XE_PAGE_ADDR_MASK(shift)    GENMASK_ULL(51, (shift))
 #define GGTT_PTE_VFID		GENMASK_ULL(11, 2)
 
 #define GUC_GGTT_TOP		0xFEE00000
diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
index 2669ff5ee747..68a911ab9216 100644
--- a/drivers/gpu/drm/xe/xe_pt.c
+++ b/drivers/gpu/drm/xe/xe_pt.c
@@ -1602,23 +1602,21 @@ static bool xe_pt_check_kill(u64 addr, u64 next, unsigned int level,
 	return false;
 }
 
-/* page_size = 2^(reclamation_size + XE_PTE_SHIFT) */
-#define COMPUTE_RECLAIM_ADDRESS_MASK(page_size)				\
-({									\
-	BUILD_BUG_ON(!__builtin_constant_p(page_size));			\
-	ilog2(page_size) - XE_PTE_SHIFT;				\
-})
-
 static int generate_reclaim_entry(struct xe_tile *tile,
 				  struct xe_page_reclaim_list *prl,
 				  u64 pte, struct xe_pt *xe_child)
 {
 	struct xe_gt *gt = tile->primary_gt;
 	struct xe_guc_page_reclaim_entry *reclaim_entries = prl->entries;
-	u64 phys_addr = pte & XE_PTE_ADDR_MASK;
+	bool is_2m = xe_child->level == 1 && (pte & XE_PDE_PS_2M);
+	bool is_64k = xe_child->level == 0 && ((pte & XE_PTE_PS64) || xe_child->is_compact);
+	u32 page_shift = is_2m ? ilog2(SZ_2M) : is_64k ? ilog2(SZ_64K) : ilog2(SZ_4K);
+	/* Physical address bits start at page shift: 2M->[51:21], 64K->[51:16], 4K->[51:12] */
+	u64 phys_addr = pte & XE_PAGE_ADDR_MASK(page_shift);
+	/* Page address is relative to 4K page regardless of entry level */
 	u64 phys_page = phys_addr >> XE_PTE_SHIFT;
 	int num_entries = prl->num_entries;
-	u32 reclamation_size;
+	u32 reclamation_size = page_shift - XE_PTE_SHIFT;
 
 	xe_tile_assert(tile, xe_child->level <= MAX_HUGEPTE_LEVEL);
 	xe_tile_assert(tile, reclaim_entries);
@@ -1633,18 +1631,15 @@ static int generate_reclaim_entry(struct xe_tile *tile,
 	 * Page size is computed as 2^(reclamation_size + XE_PTE_SHIFT) bytes.
 	 * Only 4K, 64K (level 0), and 2M pages are supported by hardware for page reclaim
 	 */
-	if (xe_child->level == 0 && !(pte & XE_PTE_PS64)) {
-		xe_gt_stats_incr(gt, XE_GT_STATS_ID_PRL_4K_ENTRY_COUNT, 1);
-		reclamation_size = COMPUTE_RECLAIM_ADDRESS_MASK(SZ_4K);  /* reclamation_size = 0 */
-		xe_tile_assert(tile, phys_addr % SZ_4K == 0);
-	} else if (xe_child->level == 0) {
-		xe_gt_stats_incr(gt, XE_GT_STATS_ID_PRL_64K_ENTRY_COUNT, 1);
-		reclamation_size = COMPUTE_RECLAIM_ADDRESS_MASK(SZ_64K); /* reclamation_size = 4 */
-		xe_tile_assert(tile, phys_addr % SZ_64K == 0);
-	} else if (xe_child->level == 1 && pte & XE_PDE_PS_2M) {
+	if (is_2m) {
 		xe_gt_stats_incr(gt, XE_GT_STATS_ID_PRL_2M_ENTRY_COUNT, 1);
-		reclamation_size = COMPUTE_RECLAIM_ADDRESS_MASK(SZ_2M);  /* reclamation_size = 9 */
 		xe_tile_assert(tile, phys_addr % SZ_2M == 0);
+	} else if (is_64k) {
+		xe_gt_stats_incr(gt, XE_GT_STATS_ID_PRL_64K_ENTRY_COUNT, 1);
+		xe_tile_assert(tile, phys_addr % SZ_64K == 0);
+	} else if (xe_child->level == 0) {
+		xe_gt_stats_incr(gt, XE_GT_STATS_ID_PRL_4K_ENTRY_COUNT, 1);
+		xe_tile_assert(tile, phys_addr % SZ_4K == 0);
 	} else {
 		xe_page_reclaim_list_abort(tile->primary_gt, prl,
 					   "unsupported PTE level=%u pte=%#llx",
@@ -1665,6 +1660,48 @@ static int generate_reclaim_entry(struct xe_tile *tile,
 	return 0;
 }
 
+static int add_pte_to_prl(struct xe_tile *tile, struct xe_page_reclaim_list *prl,
+			  struct xe_pt *xe_child, u64 pte, u64 addr)
+{
+	/*
+	 * In rare scenarios, pte may not be written yet due to racy conditions.
+	 * In such cases, invalidate the PRL and fallback to full PPC invalidation.
+	 */
+	if (!pte) {
+		xe_page_reclaim_list_abort(tile->primary_gt, prl,
+					   "found zero pte at addr=%#llx", addr);
+		return -EINVAL;
+	}
+
+	/* Ensure it is a defined page */
+	xe_tile_assert(tile, xe_child->level == 0 ||
+		       (pte & (XE_PDE_PS_2M | XE_PDPE_PS_1G)));
+
+	/* Account for NULL terminated entry on end (-1) */
+	if (prl->num_entries >= XE_PAGE_RECLAIM_MAX_ENTRIES - 1) {
+		xe_page_reclaim_list_abort(tile->primary_gt, prl,
+					   "overflow while adding pte=%#llx", pte);
+		return -ENOSPC;
+	}
+
+	return generate_reclaim_entry(tile, prl, pte, xe_child);
+}
+
+static bool add_compact_pt_prl(struct xe_tile *tile, struct xe_page_reclaim_list *prl,
+			       struct xe_device *xe, struct xe_pt *compact_pt, u64 addr)
+{
+	struct iosys_map *map = &compact_pt->bo->vmap;
+
+	for (pgoff_t i = 0; i < SZ_2M / SZ_64K && xe_page_reclaim_list_valid(prl); i++) {
+		u64 pte = xe_map_rd(xe, map, i * sizeof(u64), u64);
+
+		if (add_pte_to_prl(tile, prl, compact_pt, pte, addr))
+			break;
+	}
+
+	return xe_page_reclaim_list_valid(prl);
+}
+
 static int xe_pt_stage_unbind_entry(struct xe_ptw *parent, pgoff_t offset,
 				    unsigned int level, u64 addr, u64 next,
 				    struct xe_ptw **child,
@@ -1674,21 +1711,22 @@ static int xe_pt_stage_unbind_entry(struct xe_ptw *parent, pgoff_t offset,
 	struct xe_pt *xe_child = container_of(*child, typeof(*xe_child), base);
 	struct xe_pt_stage_unbind_walk *xe_walk =
 		container_of(walk, typeof(*xe_walk), base);
-	struct xe_device *xe = tile_to_xe(xe_walk->tile);
+	struct xe_page_reclaim_list *prl = xe_walk->prl;
+	struct xe_tile *tile = xe_walk->tile;
+	struct xe_device *xe = tile_to_xe(tile);
 	pgoff_t first = xe_pt_offset(addr, xe_child->level, walk);
 	bool killed;
 
 	XE_WARN_ON(!*child);
 	XE_WARN_ON(!level);
 	/* Check for leaf node */
-	if (xe_walk->prl && xe_page_reclaim_list_valid(xe_walk->prl) &&
+	if (prl && xe_page_reclaim_list_valid(prl) &&
 	    xe_child->level <= MAX_HUGEPTE_LEVEL) {
 		struct iosys_map *leaf_map = &xe_child->bo->vmap;
 		pgoff_t count = xe_pt_num_entries(addr, next, xe_child->level, walk);
 
 		for (pgoff_t i = 0; i < count; i++) {
 			u64 pte;
-			int ret;
 
 			/*
 			 * If not a leaf pt, skip unless non-leaf pt is interleaved between
@@ -1698,10 +1736,20 @@ static int xe_pt_stage_unbind_entry(struct xe_ptw *parent, pgoff_t offset,
 				u64 pt_size = 1ULL << walk->shifts[xe_child->level];
 				bool edge_pt = (i == 0 && !IS_ALIGNED(addr, pt_size)) ||
 					       (i == count - 1 && !IS_ALIGNED(next, pt_size));
+				struct xe_pt *child_pt =
+					container_of(xe_child->base.children[first + i],
+						     struct xe_pt, base);
 
-				if (!edge_pt) {
-					xe_page_reclaim_list_abort(xe_walk->tile->primary_gt,
-								   xe_walk->prl,
+				if (edge_pt)
+					continue;
+
+				/* Walker never descends into compact PTs, descend now */
+				if (child_pt->is_compact) {
+					if (!add_compact_pt_prl(tile, prl, xe, child_pt, addr))
+						break;
+				} else {
+					xe_page_reclaim_list_abort(tile->primary_gt,
+								   prl,
 								   "PT is skipped by walk at level=%u offset=%lu",
 								   xe_child->level, first + i);
 					break;
@@ -1711,37 +1759,12 @@ static int xe_pt_stage_unbind_entry(struct xe_ptw *parent, pgoff_t offset,
 
 			pte = xe_map_rd(xe, leaf_map, (first + i) * sizeof(u64), u64);
 
-			/*
-			 * In rare scenarios, pte may not be written yet due to racy conditions.
-			 * In such cases, invalidate the PRL and fallback to full PPC invalidation.
-			 */
-			if (!pte) {
-				xe_page_reclaim_list_abort(xe_walk->tile->primary_gt, xe_walk->prl,
-							   "found zero pte at addr=%#llx", addr);
+			if (add_pte_to_prl(tile, prl, xe_child, pte, addr))
 				break;
-			}
-
-			/* Ensure it is a defined page */
-			xe_tile_assert(xe_walk->tile, xe_child->level == 0 ||
-				       (pte & (XE_PDE_PS_2M | XE_PDPE_PS_1G)));
 
 			/* An entry should be added for 64KB but contigious 4K have XE_PTE_PS64 */
 			if (pte & XE_PTE_PS64)
 				i += 15; /* Skip other 15 consecutive 4K pages in the 64K page */
-
-			/* Account for NULL terminated entry on end (-1) */
-			if (xe_walk->prl->num_entries < XE_PAGE_RECLAIM_MAX_ENTRIES - 1) {
-				ret = generate_reclaim_entry(xe_walk->tile, xe_walk->prl,
-							     pte, xe_child);
-				if (ret)
-					break;
-			} else {
-				/* overflow, mark as invalid */
-				xe_page_reclaim_list_abort(xe_walk->tile->primary_gt, xe_walk->prl,
-							   "overflow while adding pte=%#llx",
-							   pte);
-				break;
-			}
 		}
 	}
 
@@ -1751,7 +1774,7 @@ static int xe_pt_stage_unbind_entry(struct xe_ptw *parent, pgoff_t offset,
 	 * Verify if any PTE are potentially dropped at non-leaf levels, either from being
 	 * killed or the page walk covers the region.
 	 */
-	if (xe_walk->prl && xe_page_reclaim_list_valid(xe_walk->prl) &&
+	if (prl && xe_page_reclaim_list_valid(prl) &&
 	    xe_child->level > MAX_HUGEPTE_LEVEL && xe_child->num_live) {
 		bool covered = xe_pt_covers(addr, next, xe_child->level, &xe_walk->base);
 
@@ -1760,7 +1783,7 @@ static int xe_pt_stage_unbind_entry(struct xe_ptw *parent, pgoff_t offset,
 		 * we need to invalidate the PRL.
 		 */
 		if (killed || covered)
-			xe_page_reclaim_list_abort(xe_walk->tile->primary_gt, xe_walk->prl,
+			xe_page_reclaim_list_abort(tile->primary_gt, prl,
 						   "kill at level=%u addr=%#llx next=%#llx num_live=%u",
 						   level, addr, next, xe_child->num_live);
 	}
-- 
2.43.0

