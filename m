Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AFD396B7F
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 19:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781552563; cv=none; b=FcwETQwKXPUsPLHtL22Pdzj8fQXX80lSIzB/sISiD0Rm2/jEUFZ4ifzd9F7DWREi2N8PXb1Z/A7M0xfFRhpgnWCTlGHDlbBQB3+970VqMdEm+f+1Xr0A7D8D/G2juBgrS9uWNmYaqgt9jdv2U3bpr2DgEuMoH+UpPRxy5fz0jRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781552563; c=relaxed/simple;
	bh=szSt05+JzU2Nkz/quY0J9cxT30TP1fIxMtmcdMnfz2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t+L5BB9o/vVLPNHRm7uY6SDxNKW0a3uDT7G4HL+9rPaYytheN8Yg6BJtvehgosZkDSfD31YfPvpi+eR8wymPLRX6NhmblSXOSpjJvA0YF9WT2wUiXEt5Yrw5b9bfHVSNTUS2zeywxqq8j9HEIolPTZCgKEi4/5/HuIinbWre3wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QMWFkkBw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMWFkkBw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F24931F00A3A;
	Mon, 15 Jun 2026 19:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781552561;
	bh=apV5n4aijoFmBKQlpckIts4+1lQu3JQXu5bYXA7v//M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QMWFkkBwDJj4Hu4XpVjUiqaI8vaX4sYU78s8nxNqOPdpdZIeOxIkgpuq9lZylQQHY
	 avo9N6ISANlQU9vbYAD/dMb2q172MCIk2APJSPTgRmdgu+72v0T2cfw3Eu+2oA+lHF
	 olB9G1O1ZR9c5JAH3XDwf+OoUEw2Pg7zk2VFtG6rUWDAuP2hqpWsVa/YR7le4y0uNs
	 Tmww5Bm9PzmTOJGro8sgnTVUadE3zpaejgJyC+iGjbFeKKgd9LVwT4KOP7UjXKifRR
	 GxBajcrG1820f+zXmdDoHOT+y46KbOKUVLyeV48r6rKFiBYfQSdRhsNSivwO0N/1Oo
	 dhrIoVE1qLiCg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Sidhartha Kumar <sidhartha.kumar@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/5] mm/hugetlb: rename folio_putback_active_hugetlb() to folio_putback_hugetlb()
Date: Mon, 15 Jun 2026 15:42:35 -0400
Message-ID: <20260615194237.2391157-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260615194237.2391157-1-sashal@kernel.org>
References: <2026061514-giblet-unsworn-8735@gregkh>
 <20260615194237.2391157-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Hildenbrand <david@redhat.com>

[ Upstream commit b235448e8cab7eea17d164efc7bf55505985ba65 ]

Now that folio_putback_hugetlb() is only called on folios that were
previously isolated through folio_isolate_hugetlb(), let's rename it to
match folio_putback_lru().

Add some kernel doc to clarify how this function is supposed to be used.

Link: https://lkml.kernel.org/r/20250113131611.2554758-5-david@redhat.com
Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 3c2d42b8ee34 ("mm/memory-failure: fix hugetlb_lock AA deadlock in get_huge_page_for_hwpoison")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/hugetlb.h |  4 ++--
 mm/hugetlb.c            | 15 +++++++++++++--
 mm/migrate.c            |  6 +++---
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 0fde057c81f6ce..9a0e8aa442b3e5 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -185,7 +185,7 @@ long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
 int folio_isolate_hugetlb(struct page *page, struct list_head *list);
 int get_hwpoison_huge_page(struct page *page, bool *hugetlb);
 int get_huge_page_for_hwpoison(unsigned long pfn, int flags);
-void putback_active_hugepage(struct page *page);
+void folio_putback_hugetlb(struct page *page);
 void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason);
 void free_huge_page(struct page *page);
 void hugetlb_fix_reserve_counts(struct inode *inode);
@@ -443,7 +443,7 @@ static inline int get_huge_page_for_hwpoison(unsigned long pfn, int flags)
 	return 0;
 }
 
-static inline void putback_active_hugepage(struct page *page)
+static inline void folio_putback_hugetlb(struct page *page)
 {
 }
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bac2a00f7dbf08..20095df62be4ba 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7440,7 +7440,7 @@ follow_huge_pgd(struct mm_struct *mm, unsigned long address, pgd_t *pgd, int fla
  * it is already isolated/non-migratable.
  *
  * On success, an additional page reference is taken that must be dropped
- * using putback_active_hugepage() to undo the isolation.
+ * using folio_putback_hugetlb() to undo the isolation.
  *
  * Return: 0 if isolation worked, otherwise -EBUSY.
  */
@@ -7491,7 +7491,18 @@ int get_huge_page_for_hwpoison(unsigned long pfn, int flags)
 	return ret;
 }
 
-void putback_active_hugepage(struct page *page)
+/**
+ * folio_putback_hugetlb - unisolate a hugetlb page
+ * @page: the isolated hugetlb page
+ *
+ * Putback/un-isolate the hugetlb page that was previous isolated using
+ * folio_isolate_hugetlb(): marking it non-isolated/migratable and putting it
+ * back onto the active list.
+ *
+ * Will drop the additional page reference obtained through
+ * folio_isolate_hugetlb().
+ */
+void folio_putback_hugetlb(struct page *page)
 {
 	spin_lock_irq(&hugetlb_lock);
 	SetHPageMigratable(page);
diff --git a/mm/migrate.c b/mm/migrate.c
index 328071b861c368..b5311dcb8dbbba 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -142,7 +142,7 @@ void putback_movable_pages(struct list_head *l)
 
 	list_for_each_entry_safe(page, page2, l, lru) {
 		if (unlikely(PageHuge(page))) {
-			putback_active_hugepage(page);
+			folio_putback_hugetlb(page);
 			continue;
 		}
 		list_del(&page->lru);
@@ -1371,7 +1371,7 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 
 	if (folio_ref_count(src) == 1) {
 		/* page was freed from under us. So we are done. */
-		putback_active_hugepage(hpage);
+		folio_putback_hugetlb(hpage);
 		return MIGRATEPAGE_SUCCESS;
 	}
 
@@ -1455,7 +1455,7 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 	folio_unlock(src);
 out:
 	if (rc == MIGRATEPAGE_SUCCESS)
-		putback_active_hugepage(hpage);
+		folio_putback_hugetlb(hpage);
 	else if (rc != -EAGAIN)
 		list_move_tail(&src->lru, ret);
 
-- 
2.53.0

