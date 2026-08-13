Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAB54854F1
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 15:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786633444; cv=none; b=R6COmqhgnTj92j6PzezXoAcRK+JJd7SKiaoea3kl+QoAViTtbRmg54t2MIv4U4G2NhiGk6cRhZ/NGiO7pR8h7wLpeSQWEK/mqjKeai0U+Z43VQl1CL0xknHqRdrpOyJs6O+uuE1E8cL1t8VWA8ptFj0VXw4Axp8MPEyrf1sf2sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786633444; c=relaxed/simple;
	bh=L0POC1dxHiRCxuwK9nJWFxZm24tqjT2/4K6LlboI2aM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V3Up0xRQlS6RfvujB8SHItBm/9Lw0ZLph+7GirNnvwoBacMmg7KOuNZ4bO4X9544gK+ZYI3VYHsji670cgqIfcMCIK2lzGZNEAL6pw6UZzLVp5F2j5o1SCJzK+k5RK53aukCcU/y/m5OeH3SjpdD04fYhnTxsWoz7HMTpoZGQLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=R5QtYXBS; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="R5QtYXBS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=yl
	uVcWye/s/7XdOwmqnjfFXhTdJaDPji+Tuj86y5Lk8=; b=R5QtYXBSF32IgsnuOg
	6PZ43Fi8F/jaVCwdxzeDppe40g7UVr2SF4Jn/abGEbhpWYzf+8NXCXFLcXuFbwe9
	4rEKbaPh3do/AKMCODKOh3t2MeZScsSS+K1K9oimbBW/6J7d/Lv3r9YrRieCs0jw
	adSjiXzmXEJONMQH6UzqgvXBU=
Received: from XLL-9950X.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDnN2y33H1qz03vOg--.16715S2;
	Thu, 13 Aug 2026 23:03:20 +0800 (CST)
From: Longlong Xia <xialonglong2025@163.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	linux-mm@kvack.org,
	Longlong Xia <xialonglong@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] mm/swap: publish cluster tables after full initialization
Date: Thu, 13 Aug 2026 23:03:16 +0800
Message-ID: <20260813150316.2793642-1-xialonglong2025@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnN2y33H1qz03vOg--.16715S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3GFWfCF18KryftrWxZrW5ZFb_yoW3CF43pF
	4fK3s8Kr4fXrnxWrsxAw4ktFyrCw40gryDGFyxGw1a93ZxXr48Wa97AFyavF97CF1kJwnx
	Kr15Kw17uF48AwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnhL8UUUUU=
X-CM-SenderInfo: x0ldz0pqjo00rjsqjki6rwjhhfrp/xtbC9xhfWGp93LgaqQAA3o

From: Longlong Xia <xialonglong@kylinos.cn>

swap_cluster_populate() drops the local, global, and cluster locks
before its sleeping allocation.  The allocation helper publishes ci->table
before allocating the memcg table and, on some 32-bit configurations, the
zero bitmap.

A stale per-CPU or global cluster cursor can reach the isolated cluster in
that window.  Since CLUSTER_FLAG_NONE and a non-NULL table make the cluster
appear usable, it can allocate a slot without the auxiliary state.  An
auxiliary allocation failure can then tear down a table which is already in
use.

Allocate the complete set of tables into a private carrier.  Install the
auxiliary pointers and publish the main table only while holding ci->lock;
the slow path does this after reacquiring all allocator locks.  Allocation
failures now free only unpublished resources.

Fixes: b197d41462c2 ("mm/memcg, swap: store cgroup id in cluster table directly")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
---
 mm/swapfile.c | 167 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 117 insertions(+), 50 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 78b49b0658ad..2ca947c540e9 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -410,6 +410,99 @@ static inline unsigned int cluster_offset(struct swap_info_struct *si,
 	return cluster_index(si, ci) * SWAPFILE_CLUSTER;
 }
 
+struct swap_cluster_tables {
+	struct swap_table *table;
+#ifdef CONFIG_MEMCG
+	struct swap_memcg_table *memcg_table;
+#endif
+#if !SWAP_TABLE_HAS_ZEROFLAG
+	unsigned long *zero_bitmap;
+#endif
+};
+
+static void swap_cluster_tables_free(struct swap_cluster_tables *tables)
+{
+#ifdef CONFIG_MEMCG
+	kfree(tables->memcg_table);
+	tables->memcg_table = NULL;
+#endif
+
+#if !SWAP_TABLE_HAS_ZEROFLAG
+	kfree(tables->zero_bitmap);
+	tables->zero_bitmap = NULL;
+#endif
+
+	if (!tables->table)
+		return;
+
+	if (SWP_TABLE_USE_PAGE)
+		folio_put(virt_to_folio(tables->table));
+	else
+		kmem_cache_free(swap_table_cachep, tables->table);
+	tables->table = NULL;
+}
+
+static int swap_cluster_tables_alloc(struct swap_cluster_tables *tables,
+				     gfp_t gfp)
+{
+	struct folio *folio;
+
+	if (SWP_TABLE_USE_PAGE) {
+		folio = folio_alloc(gfp | __GFP_ZERO, 0);
+		if (folio)
+			tables->table = folio_address(folio);
+	} else {
+		tables->table = kmem_cache_zalloc(swap_table_cachep, gfp);
+	}
+	if (!tables->table)
+		return -ENOMEM;
+
+#ifdef CONFIG_MEMCG
+	if (!mem_cgroup_disabled()) {
+		tables->memcg_table = kzalloc_obj(*tables->memcg_table, gfp);
+		if (!tables->memcg_table)
+			goto free_tables;
+	}
+#endif
+
+#if !SWAP_TABLE_HAS_ZEROFLAG
+	tables->zero_bitmap = bitmap_zalloc(SWAPFILE_CLUSTER, gfp);
+	if (!tables->zero_bitmap)
+		goto free_tables;
+#endif
+
+	return 0;
+
+#if defined(CONFIG_MEMCG) || !SWAP_TABLE_HAS_ZEROFLAG
+free_tables:
+	swap_cluster_tables_free(tables);
+	return -ENOMEM;
+#endif
+}
+
+static void swap_cluster_tables_install(struct swap_cluster_info *ci,
+					struct swap_cluster_tables *tables)
+{
+	lockdep_assert_held(&ci->lock);
+	VM_WARN_ON_ONCE(ci->flags || !cluster_is_empty(ci));
+	VM_WARN_ON_ONCE(rcu_access_pointer(ci->table));
+
+#ifdef CONFIG_MEMCG
+	VM_WARN_ON_ONCE(ci->memcg_table);
+	ci->memcg_table = tables->memcg_table;
+	tables->memcg_table = NULL;
+#endif
+
+#if !SWAP_TABLE_HAS_ZEROFLAG
+	VM_WARN_ON_ONCE(ci->zero_bitmap);
+	ci->zero_bitmap = tables->zero_bitmap;
+	tables->zero_bitmap = NULL;
+#endif
+
+	rcu_assign_pointer(ci->table, tables->table);
+	tables->table = NULL;
+}
+
 static void swap_cluster_free_table_folio_rcu_cb(struct rcu_head *head)
 {
 	struct folio *folio;
@@ -446,50 +539,6 @@ static void swap_cluster_free_table(struct swap_cluster_info *ci)
 		 swap_cluster_free_table_folio_rcu_cb);
 }
 
-static int swap_cluster_alloc_table(struct swap_cluster_info *ci, gfp_t gfp)
-{
-	struct swap_table *table = NULL;
-	struct folio *folio;
-
-	/* The cluster must be empty and not on any list during allocation. */
-	VM_WARN_ON_ONCE(ci->flags || !cluster_is_empty(ci));
-	if (rcu_access_pointer(ci->table))
-		return 0;
-
-	if (SWP_TABLE_USE_PAGE) {
-		folio = folio_alloc(gfp | __GFP_ZERO, 0);
-		if (folio)
-			table = folio_address(folio);
-	} else {
-		table = kmem_cache_zalloc(swap_table_cachep, gfp);
-	}
-	if (!table)
-		return -ENOMEM;
-
-	rcu_assign_pointer(ci->table, table);
-
-#ifdef CONFIG_MEMCG
-	if (!mem_cgroup_disabled()) {
-		VM_WARN_ON_ONCE(ci->memcg_table);
-		ci->memcg_table = kzalloc_obj(*ci->memcg_table, gfp);
-		if (!ci->memcg_table) {
-			swap_cluster_free_table(ci);
-			return -ENOMEM;
-		}
-	}
-#endif
-
-#if !SWAP_TABLE_HAS_ZEROFLAG
-	VM_WARN_ON_ONCE(ci->zero_bitmap);
-	ci->zero_bitmap = bitmap_zalloc(SWAPFILE_CLUSTER, gfp);
-	if (!ci->zero_bitmap) {
-		swap_cluster_free_table(ci);
-		return -ENOMEM;
-	}
-#endif
-	return 0;
-}
-
 /*
  * Sanity check to ensure nothing leaked, and the specified range is empty.
  * One special case is that bad slots can't be freed, so check the number of
@@ -527,6 +576,7 @@ static struct swap_cluster_info *
 swap_cluster_populate(struct swap_info_struct *si,
 			 struct swap_cluster_info *ci)
 {
+	struct swap_cluster_tables tables = {};
 	int ret;
 
 	/*
@@ -538,9 +588,12 @@ swap_cluster_populate(struct swap_info_struct *si,
 		lockdep_assert_held(&si->global_cluster_lock);
 	lockdep_assert_held(&ci->lock);
 
-	if (!swap_cluster_alloc_table(ci, __GFP_HIGH | __GFP_NOMEMALLOC |
-					  __GFP_NOWARN))
+	ret = swap_cluster_tables_alloc(&tables, __GFP_HIGH | __GFP_NOMEMALLOC |
+					       __GFP_NOWARN);
+	if (!ret) {
+		swap_cluster_tables_install(ci, &tables);
 		return ci;
+	}
 
 	/*
 	 * Try a sleep allocation. Each isolated free cluster may cause
@@ -552,8 +605,8 @@ swap_cluster_populate(struct swap_info_struct *si,
 		spin_unlock(&si->global_cluster_lock);
 	local_unlock(&percpu_swap_cluster.lock);
 
-	ret = swap_cluster_alloc_table(ci, __GFP_HIGH | __GFP_NOMEMALLOC |
-					   GFP_KERNEL);
+	ret = swap_cluster_tables_alloc(&tables, __GFP_HIGH | __GFP_NOMEMALLOC |
+						GFP_KERNEL);
 
 	/*
 	 * Back to atomic context. We might have migrated to a new CPU with a
@@ -568,11 +621,19 @@ swap_cluster_populate(struct swap_info_struct *si,
 		spin_lock(&si->global_cluster_lock);
 	spin_lock(&ci->lock);
 
+	/* Nothing except this helper should populate an isolated cluster. */
+	if (WARN_ON_ONCE(cluster_table_is_alloced(ci))) {
+		swap_cluster_tables_free(&tables);
+		return ci;
+	}
+
 	if (ret) {
 		move_cluster(si, ci, &si->free_clusters, CLUSTER_FLAG_FREE);
 		spin_unlock(&ci->lock);
 		return NULL;
 	}
+
+	swap_cluster_tables_install(ci, &tables);
 	return ci;
 }
 
@@ -788,6 +849,7 @@ static int swap_cluster_setup_bad_slot(struct swap_info_struct *si,
 				       struct swap_cluster_info *cluster_info,
 				       unsigned int offset, bool mask)
 {
+	struct swap_cluster_tables tables = {};
 	unsigned int ci_off = offset % SWAPFILE_CLUSTER;
 	unsigned long idx = offset / SWAPFILE_CLUSTER;
 	struct swap_cluster_info *ci;
@@ -812,9 +874,14 @@ static int swap_cluster_setup_bad_slot(struct swap_info_struct *si,
 
 	ci = cluster_info + idx;
 	/* Need to allocate swap table first for initial bad slot marking. */
-	if (!ci->count && swap_cluster_alloc_table(ci, GFP_KERNEL))
-		return -ENOMEM;
+	if (!ci->count) {
+		ret = swap_cluster_tables_alloc(&tables, GFP_KERNEL);
+		if (ret)
+			return ret;
+	}
 	spin_lock(&ci->lock);
+	if (tables.table)
+		swap_cluster_tables_install(ci, &tables);
 	/* Check for duplicated bad swap slots. */
 	if (__swap_table_xchg(ci, ci_off, SWP_TB_BAD) != SWP_TB_NULL) {
 		pr_warn("Duplicated bad slot offset %d\n", offset);
-- 
2.43.0

