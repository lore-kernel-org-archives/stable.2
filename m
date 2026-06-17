Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3095E2882CD;
	Wed, 17 Jun 2026 02:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781662741; cv=none; b=JrdUm73uEIeQQ+QQR640dvryoV4vm9CPcWyV6yWKHeNC6toqk60TrG8Lh555qrbCC6P4tJ0QkVLMGcDF9npMgmXWjBzWMFY2r01C8UuT8U+ibIzS8UK/WgFazDuJukuLWp7qT6+JGYTG/TUf/iFqSSNkljrv8RjzDIR0PLy2CqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781662741; c=relaxed/simple;
	bh=XNiwWu2+gV/RfMyk6G+AAEYdNKnICJ3JSNxX5v3BoVA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=kmpxhLwjWvJ4Ju6IXVAnO5vVs8yWrAJ7yNc/omo3QGkhePAy0PqPXqzLSikPmSxY92ghv1JU5GhD6z1fea1JMTBjbB0eml9LzdxFiTaWTYbtzBcPjfpDWr0A/uqtnbYdYl3CzchBDsotDTW3tWEkRPbKS4P4mWcHNqLUZDgMTk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cz1YN3nl; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cz1YN3nl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781662739; x=1813198739;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XNiwWu2+gV/RfMyk6G+AAEYdNKnICJ3JSNxX5v3BoVA=;
  b=cz1YN3nlmeiXy7hoQwxhcO0V9ekf/2JJ5Ig7bW44+eduhTY2NrhDXR8L
   4PqjRRfG813vhkP5xrG7hyXQVeMoM/xui61vpDtqvcldEBnYNexfKVqLP
   Ql1McJ5kQznyDZnyOUf6m4oKee8XGEngFLiNhHu/C96K+iAYQaFrYl+G1
   KsFsvE/yFEo8JOr1SMCFFPtxnwmpSZVSWRGm6jq0+wXsesFniyupF7D+A
   ZAsIpRUAiFdkR8pqzba0BOM+Znl7r7utQtcysn1KdbcdLjwziZsoaV2S1
   jvPGdtHgciMlZ4QocC3R7qFoJT+zlvA4Ly+eRqRnQ2gc5nvqS249lOFwr
   g==;
X-CSE-ConnectionGUID: N07649SdTOeJShqCq2tBRA==
X-CSE-MsgGUID: PWrRE5L/QmqipGyuSCpmCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="82458349"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="82458349"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 19:18:58 -0700
X-CSE-ConnectionGUID: Wv0ILDRxTwaYgzdUFIWj0A==
X-CSE-MsgGUID: w2GsxsQ5QJK6/6sVVSbKJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="252895970"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 19:18:58 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH v6] drm/ttm/pool: back up at native page order
Date: Tue, 16 Jun 2026 19:18:51 -0700
Message-Id: <20260617021851.1164946-1-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ttm_pool_split_for_swap() splits high-order pool pages into order-0
pages during backup so each 4K page can be released to the system as
soon as it has been written to shmem. While this minimizes the
allocator's working set during reclaim, it actively fragments memory:
every TTM-backed compound page that the shrinker touches is shattered
into order-0 pages, even when the rest of the system would prefer that
the high-order block stay intact. Under sustained kswapd pressure this
is enough to drive other parts of MM into recovery loops from which
they cannot easily escape, because the memory TTM just freed is no
longer contiguous.

Stop unconditionally splitting on the backup path and back up each
compound at its native order in ttm_pool_backup():

  - For each non-handle slot, read the order from the head page and
    hand the full compound to ttm_backup_backup_folio(), which
    backs up subpages to a contiguous range of shmem indices and
    returns the base handle plus the number of subpages actually
    backed up (@nr_backed).
  - Populate tt->pages[i..i+nr_backed) from the contiguous handle
    range and bump shrunken by nr_backed.
  - On full success (nr_backed == 1 << order) free the compound once
    at its native order. No split_page(), no per-4K refcount juggling,
    no fragmentation introduced from this path.
  - Slots that already hold a backup handle from a previous partial
    attempt are skipped (in both the dma/purge pre-pass and the main
    loop). A compound that would extend past a fault-injection-
    truncated num_pages is skipped rather than split.

A per-folio backup cannot be made fully atomic under memory pressure:
ttm_backup_backup_folio() must allocate shmem folios before the source
subpages can be released, so under true OOM any subpage of the
compound (not necessarily the first) may fail to be backed up while
the rest of the source compound is still live and contiguous. Two
mechanisms keep this from regressing reclaim behaviour:

  - Proactive split via ttm_pool_split_for_nearly_oom(): before
    handing a compound to the backup helper, check the free-page
    watermark of the relevant zones on the pool's NUMA node (ZONE_DMA32
    on configs that have it, falling through to ZONE_NORMAL).  If free
    pages have dropped below low_wmark/2 on any of those zones, split
    the source compound up front so backup proceeds at order 0 and the
    just-allocated shmem folios can be balanced 1:1 by immediate
    per-subpage frees. The head order and npages are re-read after the
    split. On nodes without valid NUMA topology, or for order-0 pages,
    this is a no-op.

  - Reactive split on a short return: even after the watermark check,
    ttm_backup_backup_folio() may still return a short @nr_backed
    (0 <= nr_backed < 1 << order) with a valid base handle covering
    just the successfully backed-up prefix. In that case split the
    source compound with ttm_pool_split_for_swap() so the prefix can
    be freed as individual order-0 pages, free those pages now (their
    contents already live in shmem and their handles are recorded in
    tt->pages), and advance the outer loop by nr_backed rather than
    the full compound so the next iteration retries the first
    un-backed subpage at order 0. A subsequent order-0 failure simply
    terminates the loop with partial progress; the remaining order-0
    subpages stay in tt->pages as plain page pointers and are cleaned
    up by the normal ttm_pool_drop_backed_up() /
    ttm_pool_free_range() paths.

Together these preserve the original split-on-OOM fallback behaviour
while keeping the common, non-OOM case fragmentation-free, and
preserve the "partial backup is allowed" contract: shrunken is
incremented per backed-up subpage so the caller still sees forward
progress when a compound only partially succeeds.

The restore-side leftover-page branch in ttm_pool_restore_commit() is
left as-is for now: that path can still split a previously-retained
compound, but in practice it is unreachable under realistic workloads
(per profiling we have not been able to trigger it), so it is not
worth complicating the restore state machine to avoid the split there.
If it ever becomes a problem in practice it can be addressed
independently.

ttm_pool_split_for_swap() itself is retained for the proactive and
reactive split paths above and for the restore path's remaining
caller. The DMA-mapped pre-backup unmap loop, the purge path,
ttm_pool_free_*, and ttm_pool_unmap_and_free() already operate at
native order and are unchanged.

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Fixes: b63d715b8090 ("drm/ttm/pool, drm/ttm/tt: Provide a helper to shrink pages")
Suggested-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Matthew Brost <matthew.brost@intel.com>

---

Continuation of [1].

[1] https://patchwork.freedesktop.org/series/166020/
---
 drivers/gpu/drm/ttm/ttm_backup.c | 119 ++++++++++++++++++-------------
 drivers/gpu/drm/ttm/ttm_pool.c   | 104 ++++++++++++++++++++++-----
 include/drm/ttm/ttm_backup.h     |  12 ++--
 3 files changed, 163 insertions(+), 72 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_backup.c b/drivers/gpu/drm/ttm/ttm_backup.c
index 81df4cb5606b..e67921393f56 100644
--- a/drivers/gpu/drm/ttm/ttm_backup.c
+++ b/drivers/gpu/drm/ttm/ttm_backup.c
@@ -6,23 +6,23 @@
 #include <drm/ttm/ttm_backup.h>
 
 #include <linux/export.h>
-#include <linux/page-flags.h>
 #include <linux/swap.h>
 
 /*
  * Need to map shmem indices to handle since a handle value
  * of 0 means error, following the swp_entry_t convention.
  */
-static unsigned long ttm_backup_shmem_idx_to_handle(pgoff_t idx)
-{
-	return (unsigned long)idx + 1;
-}
 
 static pgoff_t ttm_backup_handle_to_shmem_idx(pgoff_t handle)
 {
 	return handle - 1;
 }
 
+static unsigned long ttm_backup_shmem_idx_to_handle(pgoff_t idx)
+{
+	return (unsigned long)idx + 1;
+}
+
 /**
  * ttm_backup_drop() - release memory associated with a handle
  * @backup: The struct backup pointer used to obtain the handle
@@ -68,17 +68,23 @@ int ttm_backup_copy_page(struct file *backup, struct page *dst,
 }
 
 /**
- * ttm_backup_backup_page() - Backup a page
+ * ttm_backup_backup_folio() - Backup a folio
  * @backup: The struct backup pointer to use.
- * @page: The page to back up.
- * @writeback: Whether to perform immediate writeback of the page.
+ * @folio: The folio to back up.
+ * @order: The allocation order of @folio.  Since TTM allocates higher-order
+ *         pages without __GFP_COMP, folio_nr_pages(@folio) would always
+ *         return 1; the caller must pass the true order explicitly.
+ * @writeback: Whether to perform immediate writeback of the folio's pages.
  * This may have performance implications.
- * @idx: A unique integer for each page and each struct backup.
+ * @idx: A unique integer for the first page of the folio and each struct backup.
  * This allows the backup implementation to avoid managing
  * its address space separately.
- * @page_gfp: The gfp value used when the page was allocated.
- * This is used for accounting purposes.
+ * @folio_gfp: The gfp value used when the folio was allocated.
+ * Currently unused.
  * @alloc_gfp: The gfp to be used when allocating memory.
+ * @nr_pages_backed: Output. On a successful return, set to the number of
+ * pages actually backed up, which may be less than (1 << @order)
+ * if an -ENOMEM was encountered mid-folio.
  *
  * Context: If called from reclaim context, the caller needs to
  * assert that the shrinker gfp has __GFP_FS set, to avoid
@@ -87,53 +93,66 @@ int ttm_backup_copy_page(struct file *backup, struct page *dst,
  * that the shrinker gfp has __GFP_IO set, since without it,
  * we're not allowed to start backup IO.
  *
- * Return: A handle on success. Negative error code on failure.
- *
- * Note: This function could be extended to back up a folio and
- * implementations would then split the folio internally if needed.
- * Drawback is that the caller would then have to keep track of
- * the folio size- and usage.
+ * Return: A handle for the first backed-up page on success (handles for
+ * subsequent pages follow sequentially). -ENOMEM if no pages could be backed
+ * up. Any other negative error code if a non-ENOMEM failure occurred; in that
+ * case any pages backed up so far are truncated before returning.
  */
 s64
-ttm_backup_backup_page(struct file *backup, struct page *page,
-		       bool writeback, pgoff_t idx, gfp_t page_gfp,
-		       gfp_t alloc_gfp)
+ttm_backup_backup_folio(struct file *backup, struct folio *folio,
+			unsigned int order, bool writeback, pgoff_t idx,
+			gfp_t folio_gfp, gfp_t alloc_gfp,
+			pgoff_t *nr_pages_backed)
 {
 	struct address_space *mapping = backup->f_mapping;
-	unsigned long handle = 0;
+	int nr_pages = 1 << order;
 	struct folio *to_folio;
-	int ret;
-
-	to_folio = shmem_read_folio_gfp(mapping, idx, alloc_gfp);
-	if (IS_ERR(to_folio))
-		return PTR_ERR(to_folio);
-
-	folio_mark_accessed(to_folio);
-	folio_lock(to_folio);
-	folio_mark_dirty(to_folio);
-	copy_highpage(folio_file_page(to_folio, idx), page);
-	handle = ttm_backup_shmem_idx_to_handle(idx);
-
-	if (writeback && !folio_mapped(to_folio) &&
-	    folio_clear_dirty_for_io(to_folio)) {
-		folio_set_reclaim(to_folio);
-		ret = shmem_writeout(to_folio, NULL, NULL);
-		if (!folio_test_writeback(to_folio))
-			folio_clear_reclaim(to_folio);
-		/*
-		 * If writeout succeeds, it unlocks the folio.	errors
-		 * are otherwise dropped, since writeout is only best
-		 * effort here.
-		 */
-		if (ret)
+	int ret, i;
+
+	*nr_pages_backed = 0;
+
+	for (i = 0; i < nr_pages; ) {
+		int to_nr, j;
+
+		to_folio = shmem_read_folio_gfp(mapping, idx + i, alloc_gfp);
+		if (IS_ERR(to_folio)) {
+			int err = PTR_ERR(to_folio);
+
+			if (err == -ENOMEM && *nr_pages_backed)
+				return ttm_backup_shmem_idx_to_handle(idx);
+
+			if (*nr_pages_backed)
+				shmem_truncate_range(file_inode(backup),
+						     (loff_t)idx << PAGE_SHIFT,
+						     ((loff_t)(idx + i) << PAGE_SHIFT) - 1);
+			return err;
+		}
+
+		to_nr = min_t(int, nr_pages - i,
+			      folio_next_index(to_folio) - (idx + i));
+
+		folio_mark_accessed(to_folio);
+		folio_lock(to_folio);
+		folio_mark_dirty(to_folio);
+
+		for (j = 0; j < to_nr; j++)
+			copy_highpage(folio_file_page(to_folio, idx + i + j),
+				      folio_page(folio, i + j));
+
+		if (writeback && !folio_mapped(to_folio)) {
+			ret = shmem_writeout(to_folio, NULL, NULL);
+			if (ret == AOP_WRITEPAGE_ACTIVATE)
+				folio_unlock(to_folio);
+		} else {
 			folio_unlock(to_folio);
-	} else {
-		folio_unlock(to_folio);
-	}
+		}
 
-	folio_put(to_folio);
+		folio_put(to_folio);
+		i += to_nr;
+		*nr_pages_backed = i;
+	}
 
-	return handle;
+	return ttm_backup_shmem_idx_to_handle(idx);
 }
 
 /**
diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 682ae4f40424..3350a65745ec 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -492,7 +492,7 @@ static void ttm_pool_split_for_swap(struct ttm_pool *pool, struct page *p)
 /**
  * DOC: Partial backup and restoration of a struct ttm_tt.
  *
- * Swapout using ttm_backup_backup_page() and swapin using
+ * Swapout using ttm_backup_backup_folio() and swapin using
  * ttm_backup_copy_page() may fail.
  * The former most likely due to lack of swap-space or memory, the latter due
  * to lack of memory or because of signal interruption during waits.
@@ -1024,6 +1024,38 @@ void ttm_pool_drop_backed_up(struct ttm_tt *tt)
 	ttm_pool_free_range(NULL, tt, ttm_cached, start_page, tt->num_pages);
 }
 
+static bool ttm_pool_split_for_nearly_oom(struct ttm_pool *pool,
+					  struct page *page)
+{
+	unsigned int order = ttm_pool_page_order(pool, page);
+	int nid = pool->nid;
+	enum zone_type zone_type;
+
+	if (!order)
+		return false;
+
+	if (!numa_valid_node(nid))
+		return false;
+
+#if IS_ENABLED(CONFIG_ZONE_DMA32)
+	zone_type = ZONE_DMA32;
+#else
+	zone_type = ZONE_NORMAL;
+#endif
+
+	for (; zone_type <= ZONE_NORMAL; ++zone_type) {
+		struct zone *zone = &NODE_DATA(nid)->node_zones[zone_type];
+
+		if (zone_page_state(zone, NR_FREE_PAGES) <
+		    low_wmark_pages(zone) / 2) {
+			ttm_pool_split_for_swap(pool, page);
+			return true;
+		}
+	}
+
+	return false;
+}
+
 /**
  * ttm_pool_backup() - Back up or purge a struct ttm_tt
  * @pool: The pool used when allocating the struct ttm_tt.
@@ -1050,12 +1082,12 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *tt,
 {
 	struct file *backup = tt->backup;
 	struct page *page;
-	unsigned long handle;
 	gfp_t alloc_gfp;
 	gfp_t gfp;
 	int ret = 0;
 	pgoff_t shrunken = 0;
-	pgoff_t i, num_pages;
+	pgoff_t i, j, num_pages, npages;
+	pgoff_t nr_backed;
 
 	if (WARN_ON(ttm_tt_is_backed_up(tt)))
 		return -EINVAL;
@@ -1075,7 +1107,8 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *tt,
 			unsigned int order;
 
 			page = tt->pages[i];
-			if (unlikely(!page)) {
+			if (unlikely(!page ||
+				     ttm_backup_page_ptr_is_handle(page))) {
 				num_pages = 1;
 				continue;
 			}
@@ -1111,26 +1144,65 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *tt,
 	if (IS_ENABLED(CONFIG_FAULT_INJECTION) && should_fail(&backup_fault_inject, 1))
 		num_pages = DIV_ROUND_UP(num_pages, 2);
 
-	for (i = 0; i < num_pages; ++i) {
-		s64 shandle;
+	for (i = 0; i < num_pages; i += npages) {
+		unsigned int order;
+		s64 handle;
 
+		npages = 1;
 		page = tt->pages[i];
 		if (unlikely(!page))
 			continue;
 
-		ttm_pool_split_for_swap(pool, page);
+		/* Already-handled entry from a previous attempt. */
+		if (unlikely(ttm_backup_page_ptr_is_handle(page)))
+			continue;
 
-		shandle = ttm_backup_backup_page(backup, page, flags->writeback, i,
-						 gfp, alloc_gfp);
-		if (shandle < 0) {
-			/* We allow partially shrunken tts */
-			ret = shandle;
+		order = ttm_pool_page_order(pool, page);
+		npages = 1UL << order;
+
+		/*
+		 * Back up the compound atomically at its native order. If
+		 * fault injection truncated num_pages mid-compound, skip
+		 * the partial tail rather than splitting.
+		 */
+		if (unlikely(i + npages > num_pages))
+			break;
+
+		if (ttm_pool_split_for_nearly_oom(pool, page)) {
+			order = ttm_pool_page_order(pool, page);
+			npages = 1UL << order;
+		}
+
+		handle = ttm_backup_backup_folio(backup, page_folio(page),
+						 order, flags->writeback, i,
+						 gfp, alloc_gfp,
+						 &nr_backed);
+		if (unlikely(handle < 0)) {
+			ret = handle;
 			break;
 		}
-		handle = shandle;
-		tt->pages[i] = ttm_backup_handle_to_page_ptr(handle);
-		__free_pages_gpu_account(page, 0, false);
-		shrunken++;
+
+		for (j = 0; j < nr_backed; j++)
+			tt->pages[i + j] = ttm_backup_handle_to_page_ptr(handle + j);
+
+		shrunken += nr_backed;
+
+		if (unlikely(nr_backed < npages)) {
+			/*
+			 * Partial OOM backup: split the compound and free the
+			 * subpages whose content is now in shmem. Continue the
+			 * loop from the first un-backed order-0 page.
+			 */
+			ttm_pool_split_for_swap(pool, page);
+			for (j = 0; j < nr_backed; j++)
+				__free_pages_gpu_account(page + j, 0, false);
+			npages = nr_backed;
+			continue;
+		}
+
+		/* Fully backed up: free at native order. */
+		page->private = 0;
+		__free_pages_gpu_account(page, order, false);
 	}
 
 	return shrunken ? shrunken : ret;
diff --git a/include/drm/ttm/ttm_backup.h b/include/drm/ttm/ttm_backup.h
index 29b9c855af77..49efa713e87c 100644
--- a/include/drm/ttm/ttm_backup.h
+++ b/include/drm/ttm/ttm_backup.h
@@ -13,9 +13,8 @@
  * ttm_backup_handle_to_page_ptr() - Convert handle to struct page pointer
  * @handle: The handle to convert.
  *
- * Converts an opaque handle received from the
- * ttm_backup_backup_page() function to an (invalid)
- * struct page pointer suitable for a struct page array.
+ * Converts an opaque handle received from a ttm_backup_backup_*()
+ * function to an (invalid) struct page pointer suitable for a struct page array.
  *
  * Return: An (invalid) struct page pointer.
  */
@@ -59,9 +58,10 @@ int ttm_backup_copy_page(struct file *backup, struct page *dst,
 			 pgoff_t handle, bool intr, gfp_t additional_gfp);
 
 s64
-ttm_backup_backup_page(struct file *backup, struct page *page,
-		       bool writeback, pgoff_t idx, gfp_t page_gfp,
-		       gfp_t alloc_gfp);
+ttm_backup_backup_folio(struct file *backup, struct folio *folio,
+			unsigned int order, bool writeback, pgoff_t idx,
+			gfp_t folio_gfp, gfp_t alloc_gfp,
+			pgoff_t *nr_pages_backed);
 
 void ttm_backup_fini(struct file *backup);
 
-- 
2.34.1

