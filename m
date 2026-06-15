Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB75396B7F
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 19:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781552567; cv=none; b=bTh/izFSutbFL23ovcHrdRNrjau5N32W0m0hp5mLGv6q/6nki8j05kekjWHbfbEickoWBO9kfdM36XfAAa1ESxsAWHdICkrf57eB9gMYJ8w0Vn0iaL5+808udug7q9Wme1cALTm+zGQgtZQtX6Hg9qProuvINypprg+F87/XGXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781552567; c=relaxed/simple;
	bh=4kUR5csRb6vXqBV0gNRUctv42djXbsCSROH5V2lTNys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vj+rE2YYxlYhZTbGKoVOX5Qszi6vIUXpHzKYdm8iOH/Q/vZiuyCIQKv25y7EXiBxe7FE0M7A96Tt5WuMUUxgDqo3YAtPu7bM9z1MSTi8C6EGxWaFEK5QyKqkU1zxjV7jjcgP0anoN6ZWRJwJtHFSK9Da74SzMQwPiK2MMJ7Xmis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTaYAMFO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTaYAMFO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C481F00A3A;
	Mon, 15 Jun 2026 19:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781552565;
	bh=0G1+fTAMztvpKDSXRTS9b0XYK7OON/eceF4Tpp354kQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QTaYAMFO/ukc2BB6soV0Fvb7z+z/tg8ieaKeIys8i1obvj8jsRg7d8JwSoyFK0jAb
	 agCg+loAfRWRL4ZSIdhsoi5vahTWhqQthNQ97ffiU5lAA4bNNVxffN8cfPJp54bQ4v
	 WTvUDtesgKU1WXQ8EUnUX5C7lc2c0tkuZHTIQuVm9P5noo+gbyX8Z85p6av9/7StwZ
	 8xJTUkDl3mVC64+uWhBajmQrf1FZwWFKJH1enTjFHyagJ2w3rMEIC/Tz65vyI5Fz97
	 yWM1B8A3gYStrTUQu2B0GDfW6dG62y3GxtM9K3i/fnSgFUsZiE4DSweEdpkemurnu+
	 KHmQwfNswy86A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wupeng Ma <mawupeng1@huawei.com>,
	"Oscar Salvador (SUSE)" <osalvador@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	David Hildenbrand <david@kernel.org>,
	Liam Howlett <liam.howlett@oracle.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 5/5] mm/memory-failure: fix hugetlb_lock AA deadlock in get_huge_page_for_hwpoison
Date: Mon, 15 Jun 2026 15:42:37 -0400
Message-ID: <20260615194237.2391157-5-sashal@kernel.org>
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

From: Wupeng Ma <mawupeng1@huawei.com>

[ Upstream commit 3c2d42b8ee345b17a4ba56b0f6492d1ff4c1178e ]

Two concurrent madvise(MADV_HWPOISON) calls on the same hugetlb page can
trigger a recursive spinlock self-deadlock (AA deadlock) on hugetlb_lock
when racing with a concurrent unmap:

  thread#0                              thread#1
  --------                              --------
  madvise(folio, MADV_HWPOISON)
    -> poisons the folio successfully
  madvise(folio, MADV_HWPOISON)         unmap(folio)
    try_memory_failure_hugetlb
      get_huge_page_for_hwpoison
        spin_lock_irq(&hugetlb_lock)    <- held
        __get_huge_page_for_hwpoison
          hugetlb_update_hwpoison()
            -> MF_HUGETLB_FOLIO_PRE_POISONED
          goto out:
            folio_put()
              refcount: 1 -> 0
              free_huge_folio()
                spin_lock_irqsave(&hugetlb_lock)
                  -> AA DEADLOCK!

The out: path in __get_huge_page_for_hwpoison() calls folio_put() to drop
the GUP reference while the hugetlb_lock is still held by the hugetlb.c
wrapper get_huge_page_for_hwpoison().  If concurrent unmap has released
the page table mapping reference, folio_put() drops the folio refcount to
zero, triggering free_huge_folio() which attempts to re-acquire the
non-recursive hugetlb_lock.

Fix this by moving hugetlb_lock acquisition from the hugetlb.c wrapper
into get_huge_page_for_hwpoison().  Place spin_unlock_irq() before the
folio_put() at the out: label so the folio is always released outside the
lock.

[akpm@linux-foundation.org: fix race, rename label per Miaohe]
  Link: https://sashiko.dev/#/patchset/20260522010305.4099834-1-mawupeng1@huawei.com
  Link: https://lore.kernel.org/f39f405e-4b4b-8f79-70fe-a2b5b62114eb@huawei.com
Link: https://lore.kernel.org/20260522010305.4099834-1-mawupeng1@huawei.com
Fixes: 405ce051236c ("mm/hwpoison: fix race between hugetlb free/demotion and memory_failure_hugetlb()")
Signed-off-by: Wupeng Ma <mawupeng1@huawei.com>
Acked-by: Oscar Salvador (SUSE) <osalvador@kernel.org>
Acked-by: Muchun Song <muchun.song@linux.dev>
Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Acked-by: Miaohe Lin <linmiaohe@huawei.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/hugetlb.h |  6 ------
 include/linux/mm.h      |  5 -----
 mm/hugetlb.c            | 10 ----------
 mm/memory-failure.c     | 19 ++++++++++---------
 4 files changed, 10 insertions(+), 30 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 9a0e8aa442b3e5..6b78a0f457d953 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -184,7 +184,6 @@ long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
 						long freed);
 int folio_isolate_hugetlb(struct page *page, struct list_head *list);
 int get_hwpoison_huge_page(struct page *page, bool *hugetlb);
-int get_huge_page_for_hwpoison(unsigned long pfn, int flags);
 void folio_putback_hugetlb(struct page *page);
 void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason);
 void free_huge_page(struct page *page);
@@ -438,11 +437,6 @@ static inline int get_hwpoison_huge_page(struct page *page, bool *hugetlb)
 	return 0;
 }
 
-static inline int get_huge_page_for_hwpoison(unsigned long pfn, int flags)
-{
-	return 0;
-}
-
 static inline void folio_putback_hugetlb(struct page *page)
 {
 }
diff --git a/include/linux/mm.h b/include/linux/mm.h
index cf0cc4a64887c9..ac0638a8c38dba 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3429,15 +3429,10 @@ extern atomic_long_t num_poisoned_pages __read_mostly;
 extern int soft_offline_page(unsigned long pfn, int flags);
 #ifdef CONFIG_MEMORY_FAILURE
 extern void memory_failure_queue(unsigned long pfn, int flags);
-extern int __get_huge_page_for_hwpoison(unsigned long pfn, int flags);
 #else
 static inline void memory_failure_queue(unsigned long pfn, int flags)
 {
 }
-static inline int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
-{
-	return 0;
-}
 #endif
 
 #ifndef arch_memory_failure
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 20095df62be4ba..ee753b2ff09f82 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7481,16 +7481,6 @@ int get_hwpoison_huge_page(struct page *page, bool *hugetlb)
 	return ret;
 }
 
-int get_huge_page_for_hwpoison(unsigned long pfn, int flags)
-{
-	int ret;
-
-	spin_lock_irq(&hugetlb_lock);
-	ret = __get_huge_page_for_hwpoison(pfn, flags);
-	spin_unlock_irq(&hugetlb_lock);
-	return ret;
-}
-
 /**
  * folio_putback_hugetlb - unisolate a hugetlb page
  * @page: the isolated hugetlb page
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 1d39bdb434e734..776a37ae4eb695 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1812,19 +1812,18 @@ void hugetlb_clear_page_hwpoison(struct page *hpage)
 	free_raw_hwp_pages(hpage, true);
 }
 
-/*
- * Called from hugetlb code with hugetlb_lock held.
- */
-int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
+static int get_huge_page_for_hwpoison(unsigned long pfn, int flags)
 {
 	struct page *page = pfn_to_page(pfn);
-	struct page *head = compound_head(page);
+	struct page *head;
 	bool count_increased = false;
 	int ret, rc;
 
+	spin_lock_irq(&hugetlb_lock);
+	head = compound_head(page);
 	if (!PageHeadHuge(head)) {
 		ret = MF_HUGETLB_NON_HUGEPAGE;
-		goto out;
+		goto out_unlock;
 	} else if (flags & MF_COUNT_INCREASED) {
 		ret = MF_HUGETLB_IN_USED;
 		count_increased = true;
@@ -1840,17 +1839,19 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
 	} else {
 		ret = MF_HUGETLB_RETRY;
 		if (!(flags & MF_NO_RETRY))
-			goto out;
+			goto out_unlock;
 	}
 
 	rc = hugetlb_update_hwpoison(head, page);
 	if (rc >= MF_HUGETLB_FOLIO_PRE_POISONED) {
 		ret = rc;
-		goto out;
+		goto out_unlock;
 	}
 
+	spin_unlock_irq(&hugetlb_lock);
 	return ret;
-out:
+out_unlock:
+	spin_unlock_irq(&hugetlb_lock);
 	if (count_increased)
 		put_page(head);
 	return ret;
-- 
2.53.0

