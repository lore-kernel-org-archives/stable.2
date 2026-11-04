Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801964;
	b=tix4+1CHVM4HFmGmIOLXQVJhtTf5OFNT4Noo99RVCXczMuu1XooBMCuTCXT469Jm23iU
	 3VM9AMRqnVW+Q+6bak0zJ2GMA/zyLl4S6OSd4VeczY5frLzAJqFfWr0NmqnayNfbPspbf
	 fiiVtQD5TwHRQXjoUdVa9BMn8MfAYvZ017kmwuhzA7Bo0QZqpBUswXQ3v10ha5eNfk3ej
	 /UfGLGz22aWiFoLFi8H7QCXrbraRqQUs6DJNOwzzODW5qIfoTtfni1DkzGhyhSTgpAvwX
	 qpeV4z+DpeqTrXkkPUDpMw2niWgNKmbEZnv7F0oiO3liYM8tFsMxY9vxZY2gWc454CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801964;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=8xcDca6mJItPuPDHgx1fF1/QUq5oHLjMGaqPwTDXb+I=;
	b=boOcgGJ0oaOyzcDWDfRk4SsbJ6ifXdpdiIBEcrxjYbDB0BBAj1dN0mFNiSEXfrKokRt0
	 dnCQ/dvi0xNyMm3Wll5Y9myfpolC/jBlahsObN5yX1Db7qo8cbDaa4Rpe3LDtE1EtXva6
	 qiP9p7FiqPLAOqf4K65QeM7cd8PUN104JqVfCbitOymLxYIhCXFSE//hT1C+b7lQgG5YA
	 2X/dN0GNvbzjfsqXeLGkGurwgwegTezqST3M8RcQv+C0VLIZq5447l+l+saB1Nsu0IlqX
	 aI6c3A3X7TSj51o/UHJ7fl0Gi3HcIohgx8bC6jH5GRAWV+wcAyyXmnmJoya9z/bHseA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=lYZKEDyc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F288C606A329
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=lYZKEDyc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 886EC1F00919;
	Wed,  4 Nov 2026 14:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793801963;
	bh=8xcDca6mJItPuPDHgx1fF1/QUq5oHLjMGaqPwTDXb+I=;
	h=Subject:To:Cc:From:Date;
	b=lYZKEDycWDhSnHf6tDxo3q7R/VM6aVkdez2sWxuUQwQjcsunzoWdD75kaWWYKnzfC
	 ffzd2dg5gFVBjmzaVCx3Q/OUc4K8FkTbi8FcJ/bAneT7FJ5T/2COl5XBcxJCSZruyw
	 lj/06DGradSqaTIs8BHrg11KRB7RWjoQ0pycB/tY=
Subject: FAILED: patch "[PATCH] mm: khugepaged: fix folio is used after pte_unmap_unlock()" failed to apply to 6.18-stable tree
To: yanglincheng@kylinos.cn,akpm@linux-foundation.org,baohua@kernel.org,david@kernel.org,dev.jain@arm.com,lance.yang@linux.dev,ljs@kernel.org,ryan.roberts@arm.com,stable@vger.kernel.org,zokeefe@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:19:21 +0100
Message-ID: <2026110421-scratch-semester-c068@gregkh>
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


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x ba2f1f92ddfabd340c9248fd2380104f717ee8b1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110421-scratch-semester-c068@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

