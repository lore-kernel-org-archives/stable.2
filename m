Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A453A3807
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781537949; cv=none; b=eSHn3bunKw3LACzkb9hnhDeTCV8qj6DPftVxbG0KIHG52x+YqOM9x6UaQ1EGjTfMPvRX7rsrBQaWnDXzLD5ON1CMCCybYAiiaN01oSIrGzqPrfJ6iHKght95gwJKWhCKKiJjHnnMOmwX++C7qADHz36LGlj+rxP1quQaDNwKC/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781537949; c=relaxed/simple;
	bh=KRBSnS0cvHYJOJARW3A6m0guKoVn796DTNZRFiHXKT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CrOFdZP0shOAuQKI/cANFH/B1CFCByeNqGqd7Kgw/OfzRC7FA5+nUXqZCVR+poRnW+w2ce7zyepCmvHMcDqVp6bAbMB8+CXhWAflyB5YMZ01Kju1+Hi+di5YW8DG6XwRO7q2zcUl/2EwUgsFKook6Qe1Of4KhseCX+LsafrYLpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5TXJiEn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5TXJiEn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1301F00A3F;
	Mon, 15 Jun 2026 15:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781537948;
	bh=LkaQfOfa2tz5EHTQ4qxcr0+aF6ISfU7Lfb9Sqj0B4oY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g5TXJiEnmusg2xIgdVBXjJkxoKirMDUvHUyLY4AaqJwahv/Eo10DDuS3P+vUv92Nh
	 Por/XchcDBVpWZg/Nbh2uVrFCLu/cgLGLbRs7sQcyID/QWIQ34ur+7Ki4DPKwqGQ1g
	 j6QbpdmTdwa2xWeQF36bQ2Mchnj6ab2itI0FIasA6G4iG/cbhD83V3BBZFetCYj9ep
	 VuRGTzvyFnucFGKXp6Sn3S8iA4S/KF/dV5AYPrZUUGcFZAYf2mjoBzYiICUYsW86/j
	 MKUOKpdGZ+a5RZN92WiNs+ZbdvbJPXKHWwZEeBLINHSAFHZfQgZEZ7sYCW5Tiwxciw
	 JaJyS5CJIxqVw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Sidhartha Kumar <sidhartha.kumar@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/5] mm/hugetlb: rename folio_putback_active_hugetlb() to folio_putback_hugetlb()
Date: Mon, 15 Jun 2026 11:39:01 -0400
Message-ID: <20260615153903.2214102-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260615153903.2214102-1-sashal@kernel.org>
References: <2026061513-untracked-crane-019d@gregkh>
 <20260615153903.2214102-1-sashal@kernel.org>
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
index 851502655e646d..0461616efdbf9b 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -166,7 +166,7 @@ bool folio_isolate_hugetlb(struct folio *folio, struct list_head *list);
 int get_hwpoison_hugetlb_folio(struct folio *folio, bool *hugetlb, bool unpoison);
 int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 				bool *migratable_cleared);
-void folio_putback_active_hugetlb(struct folio *folio);
+void folio_putback_hugetlb(struct folio *folio);
 void move_hugetlb_state(struct folio *old_folio, struct folio *new_folio, int reason);
 void hugetlb_fix_reserve_counts(struct inode *inode);
 extern struct mutex *hugetlb_fault_mutex_table;
@@ -462,7 +462,7 @@ static inline int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 	return 0;
 }
 
-static inline void folio_putback_active_hugetlb(struct folio *folio)
+static inline void folio_putback_hugetlb(struct folio *folio)
 {
 }
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0c6b34dbe9e133..82e77880b0f3bc 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7240,7 +7240,7 @@ __weak unsigned long hugetlb_mask_last_page(struct hstate *h)
  * it is already isolated/non-migratable.
  *
  * On success, an additional folio reference is taken that must be dropped
- * using folio_putback_active_hugetlb() to undo the isolation.
+ * using folio_putback_hugetlb() to undo the isolation.
  *
  * Return: True if isolation worked, otherwise False.
  */
@@ -7292,7 +7292,18 @@ int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 	return ret;
 }
 
-void folio_putback_active_hugetlb(struct folio *folio)
+/**
+ * folio_putback_hugetlb - unisolate a hugetlb folio
+ * @folio: the isolated hugetlb folio
+ *
+ * Putback/un-isolate the hugetlb folio that was previous isolated using
+ * folio_isolate_hugetlb(): marking it non-isolated/migratable and putting it
+ * back onto the active list.
+ *
+ * Will drop the additional folio reference obtained through
+ * folio_isolate_hugetlb().
+ */
+void folio_putback_hugetlb(struct folio *folio)
 {
 	spin_lock_irq(&hugetlb_lock);
 	folio_set_hugetlb_migratable(folio);
diff --git a/mm/migrate.c b/mm/migrate.c
index bd3ab46c989c79..620871d193c7ca 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -151,7 +151,7 @@ void putback_movable_pages(struct list_head *l)
 
 	list_for_each_entry_safe(folio, folio2, l, lru) {
 		if (unlikely(folio_test_hugetlb(folio))) {
-			folio_putback_active_hugetlb(folio);
+			folio_putback_hugetlb(folio);
 			continue;
 		}
 		list_del(&folio->lru);
@@ -1373,7 +1373,7 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
 
 	if (folio_ref_count(src) == 1) {
 		/* page was freed from under us. So we are done. */
-		folio_putback_active_hugetlb(src);
+		folio_putback_hugetlb(src);
 		return MIGRATEPAGE_SUCCESS;
 	}
 
@@ -1456,7 +1456,7 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
 	folio_unlock(src);
 out:
 	if (rc == MIGRATEPAGE_SUCCESS)
-		folio_putback_active_hugetlb(src);
+		folio_putback_hugetlb(src);
 	else if (rc != -EAGAIN)
 		list_move_tail(&src->lru, ret);
 
-- 
2.53.0

