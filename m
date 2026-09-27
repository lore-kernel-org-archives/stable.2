Received: from mta1.migadu.com (out-148.mta1.migadu.com [95.215.58.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AEB37C109
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 09:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790502495; cv=none; b=D2/7XJueyPn+YewytnZmQnjDLvqUdLjQW+wvcm7U9zEcdf68rvX7PPvRZklmbBPcv8D9GCsaWlFPlaHVwFh+fNnFveTxf/1v3Q55plqMc5kJKzwPKM1Yn0YNRW3rooDNViC0ud/SWuYuHc3Co8x8LTFJH3NawtYHeHRb7rlnjao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790502495; c=relaxed/simple;
	bh=5w+Y1CcKn/CttHaHw0/QkpxouoRBSJrbYaTBcdJOvHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D7BO1LpCbRP1FsgDlUQM0KoR5LX02T5LBWHdxqdFpPOtC3Ly/t2FrgEDjjFRpYEraz+uCeyMVsGXSiIChUGapZCq44iHjPZAKFneh/urZRWEHqbVespOXdE4lIRQp9tPRHZKB4lyQ3rJbzdYnwUEBE09sfxxHg5rqA+QagFHOW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s0qJvo0X; arc=none smtp.client-ip=95.215.58.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s0qJvo0X"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=5w+Y1CcKn/CttHaHw0/QkpxouoRBSJrbYaTBcdJOvHI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790502487; v=1; x=1791107287;
 b=s0qJvo0X8rx6wWtAh0YSIqtRqgO5nCOJ3tw3z4v0H4IrkzWJ3pbhT9W3yb4LKTIyh33xYTyC
 fRIHEkNPGGXJNwQnyuU1sGvjfVUihP9BFvJfhxNE/hucHeLZZJihe2ki9In/I0/xFih4+w9I8gM
 F4H9sqesJziEkb8IzGM2QPw4=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 75e904128475050b;
	Sun, 27 Sep 2026 09:48:07 +0000
X-Mizu-Trace-ID: 75e904128475050b
X-Migadu-Flow: FLOW_OUT
From: Hongfu Li <hongfu.li@linux.dev>
To: hughd@google.com,
	baolin.wang@linux.alibaba.com,
	akpm@linux-foundation.org,
	vivek.kasireddy@intel.com
Cc: muchun.song@linux.dev,
	osalvador@suse.de,
	david@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Hongfu Li <lihongfu@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v3] mm/memfd: fix hugetlb reservation accounting in error paths
Date: Sun, 27 Sep 2026 17:47:57 +0800
Message-ID: <20260927094757.31665-1-hongfu.li@linux.dev>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hongfu Li <lihongfu@kylinos.cn>

If hugetlb_add_to_page_cache() in memfd_alloc_folio() fails with -EEXIST,
a concurrent fault has already instantiated the folio in the page cache,
and the reservation now belongs to that folio. Calling
hugetlb_unreserve_pages() in that case incorrectly removes the region
backing the cached folio and releases one reservation more than it
should, leaving that folio in the page cache with no region recording it.

That leaves resv_huge_pages one page short until that folio is removed
from the page cache, so available_huge_pages() reports a page that is
not actually free and the pool can grant one reservation more than it
can back. Applications using hugetlb memfds can then fail to allocate
or fault in a page they already reserved. They see -ENOMEM or -ENOSPC
from the allocation or fault path even though the reservation and
HugePages_Free still look healthy.

So hold the hugetlb fault mutex from hugetlb_reserve_pages() until the
error-path unreserve completes to make the reserve, allocate and
instantiate steps atomic against concurrent faults. With the mutex held
from the start, a concurrent fault can no longer consume the reservation
between reserve and allocate/instantiate. If a fault completed before the
mutex was taken, it has already added the region for that index, so
hugetlb_reserve_pages() returns 0 and the error path leaves the region in
place.

Fixes: 717cf9357325 ("mm/memfd: reserve hugetlb folios before allocation")
Cc: stable@vger.kernel.org
Signed-off-by: Hongfu Li <lihongfu@kylinos.cn>
---
v3:
- Update commit message to describe the accounting damage and its
  user-visible effect; no code changes.
- Add Cc: stable@vger.kernel.org.
v2:
- Take the hugetlb fault mutex before hugetlb_reserve_pages() and hold
  it until the error-path unreserve completes.
- Update commit message
- Link to v1: https://lore.kernel.org/all/20260831090631.29227-1-hongfu.li@linux.dev/
---
 mm/memfd.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/mm/memfd.c b/mm/memfd.c
index c708d92533f4..0f6fff004f5e 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -82,22 +82,31 @@ struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx)
 		struct hstate *h = hstate_file(memfd);
 		int err = -ENOMEM;
 		long nr_resv;
+		u32 hash;
 
 		gfp_mask = htlb_alloc_mask(h);
 		gfp_mask &= ~(__GFP_HIGHMEM | __GFP_MOVABLE);
 		idx >>= huge_page_order(h);
 
+		/*
+		 * Serialize hugepage allocation and instantiation to prevent
+		 * races with concurrent allocations, as required by all other
+		 * callers of hugetlb_add_to_page_cache().
+		 */
+		hash = hugetlb_fault_mutex_hash(memfd->f_mapping, idx);
+		mutex_lock(&hugetlb_fault_mutex_table[hash]);
+
 		nr_resv = hugetlb_reserve_pages(inode, idx, idx + 1, NULL, EMPTY_VMA_FLAGS);
-		if (nr_resv < 0)
-			return ERR_PTR(nr_resv);
+		if (nr_resv < 0) {
+			err = nr_resv;
+			goto out_unlock;
+		}
 
 		folio = alloc_hugetlb_folio_reserve(h,
 						    numa_node_id(),
 						    NULL,
 						    gfp_mask);
 		if (folio) {
-			u32 hash;
-
 			/*
 			 * Zero the folio to prevent information leaks to userspace.
 			 * Use folio_zero_user() which is optimized for huge/gigantic
@@ -112,20 +121,9 @@ struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx)
 			 */
 			__folio_mark_uptodate(folio);
 
-			/*
-			 * Serialize hugepage allocation and instantiation to prevent
-			 * races with concurrent allocations, as required by all other
-			 * callers of hugetlb_add_to_page_cache().
-			 */
-			hash = hugetlb_fault_mutex_hash(memfd->f_mapping, idx);
-			mutex_lock(&hugetlb_fault_mutex_table[hash]);
-
 			err = hugetlb_add_to_page_cache(folio,
 							memfd->f_mapping,
 							idx);
-
-			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-
 			if (err) {
 				folio_put(folio);
 				goto err_unresv;
@@ -133,11 +131,14 @@ struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx)
 
 			hugetlb_set_folio_subpool(folio, subpool_inode(inode));
 			folio_unlock(folio);
+			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			return folio;
 		}
 err_unresv:
 		if (nr_resv > 0)
 			hugetlb_unreserve_pages(inode, idx, idx + 1, 0);
+out_unlock:
+		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 		return ERR_PTR(err);
 	}
 #endif
-- 
2.54.0

