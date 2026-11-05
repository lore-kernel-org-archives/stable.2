Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793837326;
	b=ZCDWeFxnv9GBoYjzJ0kT8ux+WbEDybDT3V7pgweb7fcJO6daSR9pMJF1rJoy7JDwt6Ub
	 z2NoRI+gmSBh2+riL5xBp4haK+D6QHmRiDR1JNkgau6kTX3y77saRa/wDJehdC4iJli2y
	 yhr5w+p3qAG1+4z6b5k2kXa2IalGi9qiLd8vywaDJC5fS4A4E50EQuR37eptBsQOeEV/0
	 JrE7VHZs2rKY9frXpns3bHBz9auMSAsxWkpBTdZ/v2RjwSnU8deZxvnhmFcMvQi/oOGdu
	 Cajd7igFsE0r9Tj5X3hcYvNrf2iL4LSzgGshTHcha1DU+MqLdIj71OCPtPB1liNTflA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793837326;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=AoyI8+js6CBTlPGFphhIf16cjOV74ltgmCtIRebKI5E=;
	b=n9APBfLtAR0mNP5HAOOrE1SW2wrOwNR15MruqSlGz5zUV3mzJe/0IoftvsQKHfF58tuJ
	 TeGyQUAKCkHsIlFA35UaAHNQa+/QWtsT4/ZLgBcz7AHabSXvyyIi8rENQ+xdlJFyxbWBr
	 YPIClGca77L6lQQU1ewRyQOFKZehDHvWsajuOEQH3atdFR46NuU3w8S48DYpsKChBmfbS
	 QtjvbFkw9X+O6ICJ71Vu71R4QdYRrLbxMEAGZYZOidUO32u7DV5HJM09pt4EIPVc02XYp
	 UszvcR09D51/pAYrasoj7Wu2ZjcTA/a3jQ9/FBQi9iLWNdNEz5a6I1E2q7itUE5xnEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XzWPfN87;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92FE606A329
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 00:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XzWPfN87
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416981F000C1;
	Thu,  5 Nov 2026 00:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793837325;
	bh=AoyI8+js6CBTlPGFphhIf16cjOV74ltgmCtIRebKI5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XzWPfN87P1BOvgfZziYNKMrXR2hmzSY5/DJ3vJH9LivWaRPtH9yqbEeR4TOtgdyUb
	 4B/FcMcCWwi5zjRlx8ipjj83lNmQkW8mpaOvNwhHAdL1XB8qqN8DXtQ/hKYFKzLESy
	 fjG+i56tXN12VeV5rZ2mN3po47vy1X4C9c7eiNba/D4TimQAAoLGIR/f9E2dnCUQzM
	 muhHpiXgU6hW5pfrQIHdcaZ50nZ8ugRdGROtMlqc2Td2czmuiOuXWIJOtbwanzBcBO
	 MQl04+a28/ZMFTEBvujIE6tCL+o3PJKYEPU06t6udh1GU+YAtEr27RTW3UoC2vouNP
	 uwzxU001zrTAA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vernon Yang <yanglincheng@kylinos.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Barry Song <baohua@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Lance Yang <lance.yang@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Zach O'Keefe <zokeefe@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mm: khugepaged: fix swap entry value to folio_pfn()
Date: Wed,  4 Nov 2026 19:08:42 -0500
Message-ID: <20261105000826.927011-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110434-getup-ongoing-7464@gregkh>
References: <2026110434-getup-ongoing-7464@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vernon Yang <yanglincheng@kylinos.cn>

[ Upstream commit 942c8ec27aa4ffc587511650718349964e1696e6 ]

Patch series "mm: khugepaged: fix tracepoint UAF", v5.

The khugepaged tracepoints take a folio pointer and call folio_pfn(), but
by then the folio may no longer be valid: freed after folio_put(),
folio_unlock() or pte_unmap_unlock(), or not a folio at all but an
xarray-encoded swap entry.  On classic SPARSEMEM, dereferencing it oopses
khugepaged as soon as the trace event is enabled; on other memory models
it merely prints a bogus pfn.

Pass the pfn to the tracepoints directly, captured while the folio is
still pinned, closing the use-after-free windows in
mm_khugepaged_scan_file(), mm_khugepaged_scan_pmd() and
mm_khugepaged_collapse_file().

This patch (of 3):

When the swap entries found exceed max_ptes_swap, the loop is left via
break with folio still holding the xarray value that encodes the swap
entry, not valid folio pointer.

That value is passed to trace_mm_khugepaged_scan_file(), which feeds it to
folio_pfn().  On FLATMEM and SPARSEMEM_VMEMMAP, the page_to_pfn() is plain
pointer arithmetic, so the trace event merely prints bogus scan_pfn.  On
classic SPARSEMEM, the page_to_pfn() reads page->flags, dereferencing the
tiny encoded integer and oopsing khugepaged whenever the trace event is
enabled.

So when folio is the swap entry value, simply set pfn to -1, just like
exhausted scan naturally.

And the folio_put() has maybe dropped the last reference of folio.  The
trace_mm_khugepaged_scan_file() is left with a dangling folio pointer.  so
using the folio_pfn() before dropping the reference, closing
use-after-free window.

Link: https://lore.kernel.org/20260909025804.3233645-1-vernon2gm@gmail.com
Link: https://lore.kernel.org/20260909025804.3233645-2-vernon2gm@gmail.com
Fixes: d41fd2016ed0 ("mm/khugepaged: add tracepoint to hpage_collapse_scan_file()")
Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Cc: Barry Song <baohua@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Zach O'Keefe <zokeefe@google.com>
Cc: <stable@vger.kernel.org>
[ sashal: adjusted PFN capture context for the existing scanner, which lacks temporary folio references and corresponding folio_put() calls ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/trace/events/huge_memory.h | 6 +++---
 mm/khugepaged.c                    | 7 ++++++-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
index 61967625c53d7..8f63af61c3ccb 100644
--- a/include/trace/events/huge_memory.h
+++ b/include/trace/events/huge_memory.h
@@ -174,10 +174,10 @@ TRACE_EVENT(mm_collapse_huge_page_swapin,
 
 TRACE_EVENT(mm_khugepaged_scan_file,
 
-	TP_PROTO(struct mm_struct *mm, struct folio *folio, struct file *file,
+	TP_PROTO(struct mm_struct *mm, unsigned long pfn, struct file *file,
 		 int present, int swap, int result),
 
-	TP_ARGS(mm, folio, file, present, swap, result),
+	TP_ARGS(mm, pfn, file, present, swap, result),
 
 	TP_STRUCT__entry(
 		__field(struct mm_struct *, mm)
@@ -190,7 +190,7 @@ TRACE_EVENT(mm_khugepaged_scan_file,
 
 	TP_fast_assign(
 		__entry->mm = mm;
-		__entry->pfn = folio ? folio_pfn(folio) : -1;
+		__entry->pfn = pfn;
 		__assign_str(filename);
 		__entry->present = present;
 		__entry->swap = swap;
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 0c111142e1e4d..7a54ce0f126bc 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2258,6 +2258,7 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
 	int present, swap;
 	int node = NUMA_NO_NODE;
 	int result = SCAN_SUCCEED;
+	unsigned long failed_pfn = -1;
 
 	present = 0;
 	swap = 0;
@@ -2283,6 +2284,7 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
 		    folio->index == start) {
 			/* Maybe PMD-mapped */
 			result = SCAN_PTE_MAPPED_HUGEPAGE;
+			failed_pfn = folio_pfn(folio);
 			/*
 			 * For SCAN_PTE_MAPPED_HUGEPAGE, further processing
 			 * by the caller won't touch the page cache, and so
@@ -2295,17 +2297,20 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
 		node = folio_nid(folio);
 		if (hpage_collapse_scan_abort(node, cc)) {
 			result = SCAN_SCAN_ABORT;
+			failed_pfn = folio_pfn(folio);
 			break;
 		}
 		cc->node_load[node]++;
 
 		if (!folio_test_lru(folio)) {
 			result = SCAN_PAGE_LRU;
+			failed_pfn = folio_pfn(folio);
 			break;
 		}
 
 		if (!is_refcount_suitable(folio)) {
 			result = SCAN_PAGE_COUNT;
+			failed_pfn = folio_pfn(folio);
 			break;
 		}
 
@@ -2335,7 +2340,7 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
 		}
 	}
 
-	trace_mm_khugepaged_scan_file(mm, folio, file, present, swap, result);
+	trace_mm_khugepaged_scan_file(mm, failed_pfn, file, present, swap, result);
 	return result;
 }
 #else
-- 
2.53.0

