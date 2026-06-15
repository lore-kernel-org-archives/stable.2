Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A23E40629D
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781537947; cv=none; b=dZYgXWY7yWD1xeNTd4NCMO4mBYt0+PT6UQC/W/UrTuzSflmBJN4wuuGydDOhH3g85TB9vm3FUhY11CDhlavH2ZMW6pbOVUpL3NA8Wo5nHTboXzlyfMfZhKwlWGF4oNeEpznPO8kUnEyQwszz12UILl+ue6UsSZCXtXe099aAsxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781537947; c=relaxed/simple;
	bh=G7MyCugrld8GreDRSnJYpQi7MMc8d99vDjseTGZ8q6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WgCCNAMbR6zCZis47sXDQZzAWWzjqSIUkXtmlw+w9CsXnu5XYYNzImXKOaxspZRhZRP55vKDi/LHLrxsOseAe06oVtzRnWhvOCPIpfc4C+piEIFb365bDPgQN5wpVTbpUby2NdGKsoVNsWUagdu1Q0DBB3QAr4lOQDCYGwTkxdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=og2jmn5k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="og2jmn5k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41AE11F000E9;
	Mon, 15 Jun 2026 15:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781537946;
	bh=jeqbV3uz1bzjoJMitbMX5AQfKM0I3X/aCyLsVHIp8SI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=og2jmn5kuAEUgpYGpg+swRN/00+UIl7/FbOSO89PBvUpf5oBup9dn0G2BlxtKEWQ7
	 E6OBwdUHSmjEuaj2GjgNm9JnZGo8Nzy7voGH6MtTzQV2lM6WLV85kKVOSFTxn+tw1j
	 hJXLsRTwa2MOQar0e++LKVATNSMNWq+uFe2BvAwaqYO3b12jv/KJ/1uJiM8ON0RNAU
	 w+O49/1D4eYmvBS9gmPqw528qQwzzRJ5JultSSdh6vVv8ajKu8o9stDcCTeko4Vk5h
	 OWWPlVdAYnFza7LZzBXyf3TgVvOMmWslkko95cy0OYQIa5r+bKak1ee/lMgw8GXul8
	 hcJxlNffxotug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Muchun Song <muchun.song@linux.dev>,
	Sidhartha Kumar <sidhartha.kumar@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/5] mm/hugetlb: rename isolate_hugetlb() to folio_isolate_hugetlb()
Date: Mon, 15 Jun 2026 11:38:59 -0400
Message-ID: <20260615153903.2214102-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061513-untracked-crane-019d@gregkh>
References: <2026061513-untracked-crane-019d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Hildenbrand <david@redhat.com>

[ Upstream commit 4c640f128074e0d4459ecf072595a44df5c2ae18 ]

Let's make the function name match "folio_isolate_lru()", and add some
kernel doc.

Link: https://lkml.kernel.org/r/20250113131611.2554758-3-david@redhat.com
Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 3c2d42b8ee34 ("mm/memory-failure: fix hugetlb_lock AA deadlock in get_huge_page_for_hwpoison")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/hugetlb.h |  4 ++--
 mm/gup.c                |  2 +-
 mm/hugetlb.c            | 25 +++++++++++++++++++------
 mm/memory-failure.c     |  2 +-
 mm/memory_hotplug.c     |  2 +-
 mm/mempolicy.c          |  2 +-
 mm/migrate.c            |  4 ++--
 7 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index d3aa91007c90a1..851502655e646d 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -162,7 +162,7 @@ bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
 						vm_flags_t vm_flags);
 long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
 						long freed);
-bool isolate_hugetlb(struct folio *folio, struct list_head *list);
+bool folio_isolate_hugetlb(struct folio *folio, struct list_head *list);
 int get_hwpoison_hugetlb_folio(struct folio *folio, bool *hugetlb, bool unpoison);
 int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 				bool *migratable_cleared);
@@ -446,7 +446,7 @@ static inline pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr,
 	return NULL;
 }
 
-static inline bool isolate_hugetlb(struct folio *folio, struct list_head *list)
+static inline bool folio_isolate_hugetlb(struct folio *folio, struct list_head *list)
 {
 	return false;
 }
diff --git a/mm/gup.c b/mm/gup.c
index 53154b63295ab6..60006de1219eec 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1971,7 +1971,7 @@ static unsigned long collect_longterm_unpinnable_pages(
 			continue;
 
 		if (folio_test_hugetlb(folio)) {
-			isolate_hugetlb(folio, movable_page_list);
+			folio_isolate_hugetlb(folio, movable_page_list);
 			continue;
 		}
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6a1e0eefd2540f..b0df6ebbf0820d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2966,7 +2966,7 @@ static int alloc_and_dissolve_hugetlb_folio(struct hstate *h,
 		 * Fail with -EBUSY if not possible.
 		 */
 		spin_unlock_irq(&hugetlb_lock);
-		isolated = isolate_hugetlb(old_folio, list);
+		isolated = folio_isolate_hugetlb(old_folio, list);
 		ret = isolated ? 0 : -EBUSY;
 		spin_lock_irq(&hugetlb_lock);
 		goto free_new;
@@ -3042,7 +3042,7 @@ int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list)
 	if (hstate_is_gigantic(h))
 		return -ENOMEM;
 
-	if (folio_ref_count(folio) && isolate_hugetlb(folio, list))
+	if (folio_ref_count(folio) && folio_isolate_hugetlb(folio, list))
 		ret = 0;
 	else if (!folio_ref_count(folio))
 		ret = alloc_and_dissolve_hugetlb_folio(h, folio, list);
@@ -7227,11 +7227,24 @@ __weak unsigned long hugetlb_mask_last_page(struct hstate *h)
 
 #endif /* CONFIG_ARCH_WANT_GENERAL_HUGETLB */
 
-/*
- * These functions are overwritable if your architecture needs its own
- * behavior.
+/**
+ * folio_isolate_hugetlb - try to isolate an allocated hugetlb folio
+ * @folio: the folio to isolate
+ * @list: the list to add the folio to on success
+ *
+ * Isolate an allocated (refcount > 0) hugetlb folio, marking it as
+ * isolated/non-migratable, and moving it from the active list to the
+ * given list.
+ *
+ * Isolation will fail if @folio is not an allocated hugetlb folio, or if
+ * it is already isolated/non-migratable.
+ *
+ * On success, an additional folio reference is taken that must be dropped
+ * using folio_putback_active_hugetlb() to undo the isolation.
+ *
+ * Return: True if isolation worked, otherwise False.
  */
-bool isolate_hugetlb(struct folio *folio, struct list_head *list)
+bool folio_isolate_hugetlb(struct folio *folio, struct list_head *list)
 {
 	bool ret = true;
 
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 8bedcd288a0cc9..004e73eda8228b 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2639,7 +2639,7 @@ static bool isolate_page(struct page *page, struct list_head *pagelist)
 	bool isolated = false;
 
 	if (PageHuge(page)) {
-		isolated = isolate_hugetlb(page_folio(page), pagelist);
+		isolated = folio_isolate_hugetlb(page_folio(page), pagelist);
 	} else {
 		bool lru = !__PageMovable(page);
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index aab16690545207..4498855daed8f5 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1720,7 +1720,7 @@ static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 
 		if (PageHuge(page)) {
 			pfn = page_to_pfn(head) + compound_nr(head) - 1;
-			isolate_hugetlb(folio, &source);
+			folio_isolate_hugetlb(folio, &source);
 			continue;
 		} else if (PageTransHuge(page))
 			pfn = page_to_pfn(head) + thp_nr_pages(page) - 1;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index d8007e1c269052..5bbeb6df9c0079 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -608,7 +608,7 @@ static int queue_folios_hugetlb(pte_t *pte, unsigned long hmask,
 	 */
 	if ((flags & MPOL_MF_MOVE_ALL) ||
 	    (folio_estimated_sharers(folio) == 1 && !hugetlb_pmd_shared(pte)))
-		if (!isolate_hugetlb(folio, qp->pagelist))
+		if (!folio_isolate_hugetlb(folio, qp->pagelist))
 			qp->nr_failed++;
 unlock:
 	spin_unlock(ptl);
diff --git a/mm/migrate.c b/mm/migrate.c
index 0e291c02214086..1d632aa4f526ae 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -142,7 +142,7 @@ static void putback_movable_folio(struct folio *folio)
  *
  * This function shall be used whenever the isolated pageset has been
  * built from lru, balloon, hugetlbfs page. See isolate_migratepages_range()
- * and isolate_hugetlb().
+ * and folio_isolate_hugetlb().
  */
 void putback_movable_pages(struct list_head *l)
 {
@@ -2113,7 +2113,7 @@ static int add_page_for_migration(struct mm_struct *mm, const void __user *p,
 
 	if (PageHuge(page)) {
 		if (PageHead(page)) {
-			isolated = isolate_hugetlb(page_folio(page), pagelist);
+			isolated = folio_isolate_hugetlb(page_folio(page), pagelist);
 			err = isolated ? 1 : -EBUSY;
 		}
 	} else {
-- 
2.53.0

