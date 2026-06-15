Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A37406828
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781537953; cv=none; b=STwJk3LHBCw+2cbmwrMGnix/BocJtrh0pZc/bIcCVMGwPtxu9sAwXBMNZyCH5j63le6JmGAdA12tLg7FNDbC8WjG/r/a4vIZfaJ0AT/eGW0gwF9ONL0nmW6awn1/Pz5SEZRn2AQUtf0T+gWvlhVTC/ta+Du/eXucF8iq8CAdhf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781537953; c=relaxed/simple;
	bh=OqAXAaqMSooDLPE/j5yXhmbjRfYuWiLPpPLSNF3y/ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HMwzehpaVQIgeuXIeTDh12Xk7FC9xCgPZB3Gq/C/CReBIjaECQbG7O5d/Ctgt/qv/fvCAA+RRhhWHotCpVDXNzBtGpfrnhmEjXm6IUcDTMChyMJKw7Mt90IXEFIlRd6ZlT1k2+10zeLbW7mEQGD6PxdOk0ETQ1su4BdnC0CCmFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbVC5Pns; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbVC5Pns"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692A91F000E9;
	Mon, 15 Jun 2026 15:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781537951;
	bh=sH0DEYwc37de34hgf6n4ZSIzwLIIR7FmswdCPh4nCU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RbVC5PnsOMOwgrHAYQ+BpbnnjvW6bwyP+zdIG8Fe6uQYX7R3mNvw0VKWIjh1i1iBj
	 vr32rYibx7PyRlnY8lJQpvi3Tj+JUrkHUFuU213FRfjs2PmUqbsxdQRSgvAPl9pmAe
	 QEToFd6zW/AFGt35DXFn0vmXHk6WYQb4xfjrRDZKbfFuRrieduMad42LUSVDvuUb+/
	 ypTGOC2HTUfiPo00eLQ6O72gYnSmZcbpM6XpSbk9i1hxvE7CZd/LZVNbo6wmQBj/MO
	 kUqamKRsjW/DlF+cCI1UOmbnhrBSxFlnpJGDSM+57bGR3kvcVox6Zl3THY3g1hnYlv
	 51SOWOkRfIAXw==
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
Subject: [PATCH 6.6.y 5/5] mm/memory-failure: fix hugetlb_lock AA deadlock in get_huge_page_for_hwpoison
Date: Mon, 15 Jun 2026 11:39:03 -0400
Message-ID: <20260615153903.2214102-5-sashal@kernel.org>
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
 include/linux/hugetlb.h |  8 --------
 include/linux/mm.h      |  8 --------
 mm/hugetlb.c            | 11 -----------
 mm/memory-failure.c     | 19 ++++++++++---------
 4 files changed, 10 insertions(+), 36 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 0461616efdbf9b..6ecf2907172b79 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -164,8 +164,6 @@ long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
 						long freed);
 bool folio_isolate_hugetlb(struct folio *folio, struct list_head *list);
 int get_hwpoison_hugetlb_folio(struct folio *folio, bool *hugetlb, bool unpoison);
-int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
-				bool *migratable_cleared);
 void folio_putback_hugetlb(struct folio *folio);
 void move_hugetlb_state(struct folio *old_folio, struct folio *new_folio, int reason);
 void hugetlb_fix_reserve_counts(struct inode *inode);
@@ -456,12 +454,6 @@ static inline int get_hwpoison_hugetlb_folio(struct folio *folio, bool *hugetlb,
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
index dd763d3da86d14..09669ea23084a1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3924,8 +3924,6 @@ extern int soft_offline_page(unsigned long pfn, int flags);
  */
 extern const struct attribute_group memory_failure_attr_group;
 extern void memory_failure_queue(unsigned long pfn, int flags);
-extern int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
-					bool *migratable_cleared);
 void num_poisoned_pages_inc(unsigned long pfn);
 void num_poisoned_pages_sub(unsigned long pfn, long i);
 struct task_struct *task_early_kill(struct task_struct *tsk, int force_early);
@@ -3934,12 +3932,6 @@ static inline void memory_failure_queue(unsigned long pfn, int flags)
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
index 82e77880b0f3bc..ab33f409c7dc36 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7281,17 +7281,6 @@ int get_hwpoison_hugetlb_folio(struct folio *folio, bool *hugetlb, bool unpoison
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
index 9edd58cce31d50..86cdf36ee3bb93 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1994,20 +1994,19 @@ void folio_clear_hugetlb_hwpoison(struct folio *folio)
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
@@ -2023,13 +2022,13 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
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
@@ -2041,8 +2040,10 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
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
-- 
2.53.0

