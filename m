Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7680A29D29F
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 03:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781495548; cv=none; b=gcfmBH50ypD0bch97ZmNoACtMcznfzrsNjYzhi0+vVv+9fZJGJ2JLMegWg5F6mUFWeUL22eiXocaThWneuNaVRW8wVdZbYxesXYHN4FT8lWRt5YYxv5dFO6NviBybtvLlXuxqgjoayyCx3VJwBUy5qmYt8gyxN1aIX5AoZraI9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781495548; c=relaxed/simple;
	bh=GXhg27ovfaOnyOTBYmoIZeXVAcNRKIvcERaovMTOFkM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=H6ksgoHAdCZLeLFcyleVAm1QV1Drs6dbQGolM3m0wdFN5Mx9yrL2D390DCQ2qCvhSSk59GKdQN+z4cxoijLoFDmKcCsDoMLmLw01U24bbzUd9PW6WideTgpuggWeeideWCpxiSmHJJ0dVUTB2tBLjVnO51Tv8NfS4+Vjf2AHNzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N/8JXKhv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N/8JXKhv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB6F41F000E9;
	Mon, 15 Jun 2026 03:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781495547;
	bh=YFTcdOKgguR4Hckx0NMLa2htN+BQ2GJHP+scqRIha0U=;
	h=Subject:To:Cc:From:Date;
	b=N/8JXKhvjVE8cOrWHWbuH2IAmih/B0vrp6mzTr3Qe/Vy4NpMUdbDj6TAK0GmoLr5k
	 0853oLICxfHq407SQeFUyT9Qv0aMP+QwWC8hciBxVlmL6x7jjnj61Qk9eJDEofJ8VI
	 kLaF9E4kjdtoeAwUDAbTecZUtOFhZw8cYsQUAMss=
Subject: FAILED: patch "[PATCH] mm/memory-failure: fix hugetlb_lock AA deadlock in" failed to apply to 6.1-stable tree
To: mawupeng1@huawei.com,akpm@linux-foundation.org,david@kernel.org,liam.howlett@oracle.com,linmiaohe@huawei.com,ljs@kernel.org,mhocko@suse.com,muchun.song@linux.dev,nao.horiguchi@gmail.com,osalvador@kernel.org,rppt@kernel.org,stable@vger.kernel.org,surenb@google.com,vbabka@kernel.org,wangkefeng.wang@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 05:51:15 +0200
Message-ID: <2026061514-giblet-unsworn-8735@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 3c2d42b8ee345b17a4ba56b0f6492d1ff4c1178e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061514-giblet-unsworn-8735@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3c2d42b8ee345b17a4ba56b0f6492d1ff4c1178e Mon Sep 17 00:00:00 2001
From: Wupeng Ma <mawupeng1@huawei.com>
Date: Fri, 22 May 2026 09:03:05 +0800
Subject: [PATCH] mm/memory-failure: fix hugetlb_lock AA deadlock in
 get_huge_page_for_hwpoison

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

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 5957bc25efa8..2abaf99321e9 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -153,8 +153,6 @@ long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
 						long freed);
 bool folio_isolate_hugetlb(struct folio *folio, struct list_head *list);
 int get_hwpoison_hugetlb_folio(struct folio *folio, bool *hugetlb, bool unpoison);
-int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
-				bool *migratable_cleared);
 void folio_putback_hugetlb(struct folio *folio);
 void move_hugetlb_state(struct folio *old_folio, struct folio *new_folio, int reason);
 void hugetlb_fix_reserve_counts(struct inode *inode);
@@ -421,12 +419,6 @@ static inline int get_hwpoison_hugetlb_folio(struct folio *folio, bool *hugetlb,
 	return 0;
 }
 
-static inline int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
-					bool *migratable_cleared)
-{
-	return 0;
-}
-
 static inline void folio_putback_hugetlb(struct folio *folio)
 {
 }
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 06bbe9eba636..fc2acedf0b76 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4975,8 +4975,6 @@ extern int soft_offline_page(unsigned long pfn, int flags);
  */
 extern const struct attribute_group memory_failure_attr_group;
 extern void memory_failure_queue(unsigned long pfn, int flags);
-extern int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
-					bool *migratable_cleared);
 void num_poisoned_pages_inc(unsigned long pfn);
 void num_poisoned_pages_sub(unsigned long pfn, long i);
 #else
@@ -4984,12 +4982,6 @@ static inline void memory_failure_queue(unsigned long pfn, int flags)
 {
 }
 
-static inline int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
-					bool *migratable_cleared)
-{
-	return 0;
-}
-
 static inline void num_poisoned_pages_inc(unsigned long pfn)
 {
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1b1d4f87a3a4..c921287489de 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7161,17 +7161,6 @@ int get_hwpoison_hugetlb_folio(struct folio *folio, bool *hugetlb, bool unpoison
 	return ret;
 }
 
-int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
-				bool *migratable_cleared)
-{
-	int ret;
-
-	spin_lock_irq(&hugetlb_lock);
-	ret = __get_huge_page_for_hwpoison(pfn, flags, migratable_cleared);
-	spin_unlock_irq(&hugetlb_lock);
-	return ret;
-}
-
 /**
  * folio_putback_hugetlb - unisolate a hugetlb folio
  * @folio: the isolated hugetlb folio
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index ee42d4361309..d47aef256a32 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1966,20 +1966,19 @@ void folio_clear_hugetlb_hwpoison(struct folio *folio)
 	folio_free_raw_hwp(folio, true);
 }
 
-/*
- * Called from hugetlb code with hugetlb_lock held.
- */
-int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
+static int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 				 bool *migratable_cleared)
 {
 	struct page *page = pfn_to_page(pfn);
-	struct folio *folio = page_folio(page);
+	struct folio *folio;
 	bool count_increased = false;
 	int ret, rc;
 
+	spin_lock_irq(&hugetlb_lock);
+	folio = page_folio(page);
 	if (!folio_test_hugetlb(folio)) {
 		ret = MF_HUGETLB_NON_HUGEPAGE;
-		goto out;
+		goto out_unlock;
 	} else if (flags & MF_COUNT_INCREASED) {
 		ret = MF_HUGETLB_IN_USED;
 		count_increased = true;
@@ -1995,13 +1994,13 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 	} else {
 		ret = MF_HUGETLB_RETRY;
 		if (!(flags & MF_NO_RETRY))
-			goto out;
+			goto out_unlock;
 	}
 
 	rc = hugetlb_update_hwpoison(folio, page);
 	if (rc >= MF_HUGETLB_FOLIO_PRE_POISONED) {
 		ret = rc;
-		goto out;
+		goto out_unlock;
 	}
 
 	/*
@@ -2013,8 +2012,10 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 		*migratable_cleared = true;
 	}
 
+	spin_unlock_irq(&hugetlb_lock);
 	return ret;
-out:
+out_unlock:
+	spin_unlock_irq(&hugetlb_lock);
 	if (count_increased)
 		folio_put(folio);
 	return ret;

