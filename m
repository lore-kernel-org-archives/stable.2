Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801968;
	b=St6k9vZEmHDUaTyeaNsjccDFex5nqaM8H6yXSHE7Q5QBWWrGeZJ8LT3PB7fn2YYo3MAs
	 iRVKQVMbl7RD6Dhl8a0F9mbBkOETZCuue9IZxoMd2TTM1gMuuxwLfoNfm5KXGqIysXRIR
	 RqdSrxIxyx/1stH3BZop3dZ4EZbvgeLlom2g/awqPNk873CAos6SM2uJSygmVYa4jeT2e
	 3SUcItHarzH4xNfRc7FjyKS4B72y2RzKOMsCEo0GgdGEx7ITJ1JNyhIPreXbAFmWT3taQ
	 zgBWqktEtO32WJ7WWbj6b+LpQgqbAn+JUUwpCt5lTRPdSJ1jAVPm3BwFjaONRSdNJ+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801968;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=t9CUZeXoUIWrr+xot5a8xNbqv3Dp4v4ad1/w3PR+UEU=;
	b=Q4Rmj4CoDv54twCa7r99815aqGAG/kwA0hoJYVkvfsrpSe9Bj5mTamZS2PQbn7C+uIeF
	 NEsZnkHouQepvKHHxsa19gscyWS09jLY2exeyOOtWlchPqrzqLIloAlEAVdloflgOt1fx
	 lSA/1NB0muFLgZxfL7H6RcOhJvwi82bL/uXOdtZ0gjhRQDX31bCvo/6sVPUwXfQzDEmDv
	 bCx9XV7M2BtV/LDQJvUCQSQIgXZ0Y7ZS+OnSe+81FGqKlres6N4wF9c8FAt4f4K7dlXPl
	 CRiO2rQl0n5JsDjAme8ySjWVDQDhP0jzSqtDeaKVJMwNxSirBqyWKoF2LAr8tvsYkiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="1FU7/oeB";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23223606A330
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=1FU7/oeB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26991F000C1;
	Wed,  4 Nov 2026 14:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793801968;
	bh=t9CUZeXoUIWrr+xot5a8xNbqv3Dp4v4ad1/w3PR+UEU=;
	h=Subject:To:Cc:From:Date;
	b=1FU7/oeBu5mK24H0zqa3xs1lPRm4r4I5XMx/Yec/zSF8yyuIIYdu3uHIFYNOUzZX7
	 YCNH5fi1y5gGAHi+H5JqKjg8mI4k18/Xl1+VxNhsPR119wqyzfU3dv9AT6qbeiwG6q
	 tp3Kx0BOpn6x79PfOKqWSSXDqvBykjRHBVZ26uRc=
Subject: FAILED: patch "[PATCH] mm: khugepaged: fix folio is used after pte_unmap_unlock()" failed to apply to 6.6-stable tree
To: yanglincheng@kylinos.cn,akpm@linux-foundation.org,baohua@kernel.org,david@kernel.org,dev.jain@arm.com,lance.yang@linux.dev,ljs@kernel.org,ryan.roberts@arm.com,stable@vger.kernel.org,zokeefe@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:19:22 +0100
Message-ID: <2026110422-silt-crazily-9039@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x ba2f1f92ddfabd340c9248fd2380104f717ee8b1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110422-silt-crazily-9039@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ba2f1f92ddfabd340c9248fd2380104f717ee8b1 Mon Sep 17 00:00:00 2001
From: Vernon Yang <yanglincheng@kylinos.cn>
Date: Wed, 9 Sep 2026 10:58:02 +0800
Subject: [PATCH] mm: khugepaged: fix folio is used after pte_unmap_unlock()

After the page table lock has dropped, the folio can be freed
concurrently.  The trace_mm_khugepaged_scan_pmd() is left with a dangling
folio pointer.

So using the folio_pfn() before dropping the page table lock, closing
use-after-free window.

And other pre-existing bug, When the `for (i = 0; i < HPAGE_PMD_NR; i++)`
iteration to terminate and the folio operation preceding is normal, but
pfn will be incorrect.  so we really only trace the PFN if it really was
problematic.

Link: https://lore.kernel.org/20260909025804.3233645-3-vernon2gm@gmail.com
Fixes: 7d2eba0557c1 ("mm: add tracepoint for scanning pages")
Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Cc: Barry Song <baohua@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Zach O'Keefe <zokeefe@google.com>
Cc: <stable@vger.kernel.org>

diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
index 7b526528f85b..fa828967e1fb 100644
--- a/include/trace/events/huge_memory.h
+++ b/include/trace/events/huge_memory.h
@@ -55,10 +55,10 @@ SCAN_STATUS
 
 TRACE_EVENT(mm_khugepaged_scan_pmd,
 
-	TP_PROTO(struct mm_struct *mm, struct folio *folio,
+	TP_PROTO(struct mm_struct *mm, unsigned long pfn,
 		 int referenced, int none_or_zero, int status, int unmapped),
 
-	TP_ARGS(mm, folio, referenced, none_or_zero, status, unmapped),
+	TP_ARGS(mm, pfn, referenced, none_or_zero, status, unmapped),
 
 	TP_STRUCT__entry(
 		__field(struct mm_struct *, mm)
@@ -71,7 +71,7 @@ TRACE_EVENT(mm_khugepaged_scan_pmd,
 
 	TP_fast_assign(
 		__entry->mm = mm;
-		__entry->pfn = folio ? folio_pfn(folio) : -1;
+		__entry->pfn = pfn;
 		__entry->referenced = referenced;
 		__entry->none_or_zero = none_or_zero;
 		__entry->status = status;
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 6380a12b8eee..730829947b4c 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1612,6 +1612,7 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
 	enum scan_result result = SCAN_FAIL;
 	struct page *page = NULL;
 	struct folio *folio = NULL;
+	unsigned long failed_pfn = -1;
 	unsigned long addr;
 	unsigned long enabled_orders;
 	spinlock_t *ptl;
@@ -1706,11 +1707,13 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
 		if (cc->is_khugepaged && !(vma->vm_flags & VM_DROPPABLE) &&
 		    folio_test_lazyfree(folio) && !pte_dirty(pteval)) {
 			result = SCAN_PAGE_LAZYFREE;
+			failed_pfn = folio_pfn(folio);
 			goto out_unmap;
 		}
 
 		if (!folio_test_anon(folio)) {
 			result = SCAN_PAGE_ANON;
+			failed_pfn = folio_pfn(folio);
 			goto out_unmap;
 		}
 
@@ -1721,6 +1724,7 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
 		if (folio_maybe_mapped_shared(folio)) {
 			if (++shared > max_ptes_shared) {
 				result = SCAN_EXCEED_SHARED_PTE;
+				failed_pfn = folio_pfn(folio);
 				count_collapse_event(HPAGE_PMD_ORDER, THP_SCAN_EXCEED_SHARED_PTE,
 						     MTHP_STAT_COLLAPSE_EXCEED_SHARED);
 				goto out_unmap;
@@ -1738,15 +1742,18 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
 		node = folio_nid(folio);
 		if (collapse_scan_abort(node, cc)) {
 			result = SCAN_SCAN_ABORT;
+			failed_pfn = folio_pfn(folio);
 			goto out_unmap;
 		}
 		cc->node_load[node]++;
 		if (!folio_test_lru(folio)) {
 			result = SCAN_PAGE_LRU;
+			failed_pfn = folio_pfn(folio);
 			goto out_unmap;
 		}
 		if (folio_test_locked(folio)) {
 			result = SCAN_PAGE_LOCK;
+			failed_pfn = folio_pfn(folio);
 			goto out_unmap;
 		}
 
@@ -1759,6 +1766,7 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
 		 */
 		if (folio_expected_ref_count(folio) != folio_ref_count(folio)) {
 			result = SCAN_PAGE_COUNT;
+			failed_pfn = folio_pfn(folio);
 			goto out_unmap;
 		}
 
@@ -1784,7 +1792,7 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
 		*lock_dropped = true;
 	}
 out:
-	trace_mm_khugepaged_scan_pmd(mm, folio, referenced,
+	trace_mm_khugepaged_scan_pmd(mm, failed_pfn, referenced,
 				     none_or_zero, result, unmapped);
 	return result;
 }

