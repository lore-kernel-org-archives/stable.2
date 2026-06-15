Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164063859F3
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 19:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781552561; cv=none; b=QHu1R6pTOF0inMQGBc/YRD+Yt4AyKAv/14wcTaDXEC/kdwIZSqrji0C327oVYy7oXzdnj/t1c1Wcs+FbSeys39XmWnC8gd/HF5ea7uIwmpp0gya2XaitdqWOSwTaO8QNmpQ2SqRNHzfivtO1g+bKDFtiDeZF2N2Ik0JYdT8sF+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781552561; c=relaxed/simple;
	bh=Syx+21mWy2/QVqmGRSzo4PVNU+xJC7lWd8t6+ROJRV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqkMEEGeeFdNvZyV8ekO+CblKA6rJqqEyOySFc45AgDKz/U36qFd9hBbp3ppSLNTuC4UkhYznNG6oR4MorqlL2srCAjd8XkchEAzeWyZNRd3nuRcWvsnE/JG7r71ulKQ3bMQnS8VrzZGn7QIzPNqceSEOgF9ISQilTtmz6wYvjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRU0tmA2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRU0tmA2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D245A1F000E9;
	Mon, 15 Jun 2026 19:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781552559;
	bh=toGdbJU7JEWUT/uS+S/63XdMkW8y9hOVAoq8cfRb4fM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IRU0tmA2fT5myRW8XNqtN3ubMHodrAuFoEiaXnquIAcTvyinnnj65D/PzhayatgGH
	 upbAQJxzd2rXAuiAZPxWVk3u81FuFNPSUXKOiBhv131WT90kgOtlypyhnSheCGvZm1
	 Qc4acetS+oLc1irZ+5P4QWCQ8JTvWdCGyM/1/zE1fF+dQA9bx5qdDqj2HTzG5sQHg9
	 ZhLg2jdQjEWZUO/Lkqfn6mBT6Hlg43gPHMXRmZ8PE3mzjqdIryK96eK44+HQ/HPMme
	 k23LbQ1+dAWBDJZeArBBubV/TG4rwHZ1rU0pMNsvUdHmZTDBBL0Q9a3mt8nwTrZSz3
	 hSB2XO3l50J4Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Muchun Song <muchun.song@linux.dev>,
	Sidhartha Kumar <sidhartha.kumar@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/5] mm/hugetlb: rename isolate_hugetlb() to folio_isolate_hugetlb()
Date: Mon, 15 Jun 2026 15:42:33 -0400
Message-ID: <20260615194237.2391157-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061514-giblet-unsworn-8735@gregkh>
References: <2026061514-giblet-unsworn-8735@gregkh>
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
 mm/hugetlb.c            | 23 ++++++++++++++++++++---
 mm/memory-failure.c     |  2 +-
 mm/memory_hotplug.c     |  2 +-
 mm/mempolicy.c          |  2 +-
 mm/migrate.c            |  4 ++--
 7 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index e9549a3b9073d0..0fde057c81f6ce 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -182,7 +182,7 @@ bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
 						vm_flags_t vm_flags);
 long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
 						long freed);
-int isolate_hugetlb(struct page *page, struct list_head *list);
+int folio_isolate_hugetlb(struct page *page, struct list_head *list);
 int get_hwpoison_huge_page(struct page *page, bool *hugetlb);
 int get_huge_page_for_hwpoison(unsigned long pfn, int flags);
 void putback_active_hugepage(struct page *page);
@@ -428,7 +428,7 @@ static inline pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr,
 	return NULL;
 }
 
-static inline int isolate_hugetlb(struct page *page, struct list_head *list)
+static inline int folio_isolate_hugetlb(struct page *page, struct list_head *list)
 {
 	return -EBUSY;
 }
diff --git a/mm/gup.c b/mm/gup.c
index b02993c9a8cdf9..72e01b8311d7cf 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1986,7 +1986,7 @@ static unsigned long collect_longterm_unpinnable_pages(
 			continue;
 
 		if (folio_test_hugetlb(folio)) {
-			isolate_hugetlb(&folio->page, movable_page_list);
+			folio_isolate_hugetlb(&folio->page, movable_page_list);
 			continue;
 		}
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 161f95473c2ac2..bde99cd3525784 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2991,7 +2991,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 		 * Fail with -EBUSY if not possible.
 		 */
 		spin_unlock_irq(&hugetlb_lock);
-		ret = isolate_hugetlb(old_page, list);
+		ret = folio_isolate_hugetlb(old_page, list);
 		spin_lock_irq(&hugetlb_lock);
 		goto free_new;
 	} else if (!HPageFreed(old_page)) {
@@ -3067,7 +3067,7 @@ int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list)
 	if (hstate_is_gigantic(h))
 		return -ENOMEM;
 
-	if (page_count(head) && !isolate_hugetlb(head, list))
+	if (page_count(head) && !folio_isolate_hugetlb(head, list))
 		ret = 0;
 	else if (!page_count(head))
 		ret = alloc_and_dissolve_huge_page(h, head, list);
@@ -7427,7 +7427,24 @@ follow_huge_pgd(struct mm_struct *mm, unsigned long address, pgd_t *pgd, int fla
 	return pte_page(*(pte_t *)pgd) + ((address & ~PGDIR_MASK) >> PAGE_SHIFT);
 }
 
-int isolate_hugetlb(struct page *page, struct list_head *list)
+/**
+ * folio_isolate_hugetlb - try to isolate an allocated hugetlb page
+ * @page: the page to isolate
+ * @list: the list to add the page to on success
+ *
+ * Isolate an allocated (refcount > 0) hugetlb page, marking it as
+ * isolated/non-migratable, and moving it from the active list to the
+ * given list.
+ *
+ * Isolation will fail if @page is not an allocated hugetlb page, or if
+ * it is already isolated/non-migratable.
+ *
+ * On success, an additional page reference is taken that must be dropped
+ * using putback_active_hugepage() to undo the isolation.
+ *
+ * Return: 0 if isolation worked, otherwise -EBUSY.
+ */
+int folio_isolate_hugetlb(struct page *page, struct list_head *list)
 {
 	int ret = 0;
 
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 482c2b6039f0df..109703dc39080c 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2444,7 +2444,7 @@ static bool isolate_page(struct page *page, struct list_head *pagelist)
 	bool isolated = false;
 
 	if (PageHuge(page)) {
-		isolated = !isolate_hugetlb(page, pagelist);
+		isolated = !folio_isolate_hugetlb(page, pagelist);
 	} else {
 		bool lru = !__PageMovable(page);
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index c8cc2f63c3eac7..33b21fc6d90d98 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1641,7 +1641,7 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 
 		if (PageHuge(page)) {
 			pfn = page_to_pfn(head) + compound_nr(head) - 1;
-			isolate_hugetlb(head, &source);
+			folio_isolate_hugetlb(head, &source);
 			continue;
 		} else if (PageTransHuge(page))
 			pfn = page_to_pfn(head) + thp_nr_pages(page) - 1;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 97106305ce21ee..518adfe4ad85bf 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -598,7 +598,7 @@ static int queue_pages_hugetlb(pte_t *pte, unsigned long hmask,
 	if (flags & (MPOL_MF_MOVE_ALL) ||
 	    (flags & MPOL_MF_MOVE && page_mapcount(page) == 1 &&
 	     !hugetlb_pmd_shared(pte))) {
-		if (isolate_hugetlb(page, qp->pagelist) &&
+		if (folio_isolate_hugetlb(page, qp->pagelist) &&
 			(flags & MPOL_MF_STRICT))
 			/*
 			 * Failed to isolate page but allow migrating pages
diff --git a/mm/migrate.c b/mm/migrate.c
index c58fc73e85fd4e..9271f9dbd352a1 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -133,7 +133,7 @@ static void putback_movable_page(struct page *page)
  *
  * This function shall be used whenever the isolated pageset has been
  * built from lru, balloon, hugetlbfs page. See isolate_migratepages_range()
- * and isolate_hugetlb().
+ * and folio_isolate_hugetlb().
  */
 void putback_movable_pages(struct list_head *l)
 {
@@ -1995,7 +1995,7 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
 
 	if (PageHuge(page)) {
 		if (PageHead(page)) {
-			err = isolate_hugetlb(page, pagelist);
+			err = folio_isolate_hugetlb(page, pagelist);
 			if (!err)
 				err = 1;
 		}
-- 
2.53.0

