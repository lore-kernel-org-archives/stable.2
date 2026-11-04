Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801973;
	b=R0nEtKKTUDQBK771WBpWxvSYbjr4DSIMkzR9DR7Wmo7E3885+i4QGRUPX5GsdTcEA6UQ
	 qiw/ntpEkpGvYJPio480RAaLjwyHrvY6G7MaqbBxqjOFzqszQ3Rg6q7luo7NLoBOD+zGF
	 jXdRNcUDmnJmNXQ7mDN1XSmOTPa49Ce+Q39IqAF5JUyuNzuhakCWlIxKx6k2qA04bLYct
	 PNHvAK7UyLUoaHPaqT0jLdUj6nuYiVSnFf0NzNGqAOmBWXYXNeW0xmlu48OtqU52nvFhA
	 AlTRItp60t8y90lRUcCAHWePHP2Lx8ptqb2x/dSUJ6HIVMmRYWxBMWRuvFrjbP3zrXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801973;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Ik51YJzCVZsbraIomk946kuzYGgVNT24ndsmN5VtTQE=;
	b=UwzWVUFMLSp9iT5ByEoaZ/hS6EoJgenBDkM/IhMy1ZH49ufkp907ASRXFx3ujo5IbDM+
	 vB6EtmCUxx951fV9MjlAE876X6CsKqEgsofjqxeVpIN9vqkWSie/sa+8iMDcg6KFzIN7d
	 L22xqnviE9hLmw2Q46nYByjRwtqm2RkeQOMvFZ/lCc7izeVYBkkdOYiB+y2FqGdcBfF9G
	 iemUmkkKYuH/Mvsm0tQT2tr9oi0hHuT3mc4AfBNs1xpW8scccomi8MQvrkpjhGz9A6uA/
	 4bjzD5mz86haWSPaI6EZGgaRLtcID0yFadbX+ldMmUWJFSfUKV7kMEmCoJelHXMmZ3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=XXQbeH1O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFD5606A326
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=XXQbeH1O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 036021F000C1;
	Wed,  4 Nov 2026 14:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793801973;
	bh=Ik51YJzCVZsbraIomk946kuzYGgVNT24ndsmN5VtTQE=;
	h=Subject:To:Cc:From:Date;
	b=XXQbeH1O+leQLLHAC3qr3PuqlAID+aFAUGOL9bOJIMWsu7Ul4KRYpz68vHhfW0jLh
	 CtjEBjGSueRLV1KdcBqCpX8TWD3v7HvtW0pX1e/XD5IpBqMtMoSXQ6CWrUKVx5YpYe
	 Kp6jYcs6PigYypdZXdGTcnU82juNrgdk/XJTJa+Y=
Subject: FAILED: patch "[PATCH] mm: khugepaged: fix folio is used after pte_unmap_unlock()" failed to apply to 6.1-stable tree
To: yanglincheng@kylinos.cn,akpm@linux-foundation.org,baohua@kernel.org,david@kernel.org,dev.jain@arm.com,lance.yang@linux.dev,ljs@kernel.org,ryan.roberts@arm.com,stable@vger.kernel.org,zokeefe@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:19:23 +0100
Message-ID: <2026110423-angelic-valley-4eb9@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x ba2f1f92ddfabd340c9248fd2380104f717ee8b1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110423-angelic-valley-4eb9@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

