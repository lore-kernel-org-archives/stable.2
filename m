Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793844075;
	b=bwmCcj4F50H81uzyMyWFkZdPJ0jastR/RZ4bjTORLhCPG91aH2DsORX9C2RmkbjDh2vv
	 4BiKi20cy6pu3M23EK6PxKFAf0fyWZIIL2gfxFWWPwF0uvVZ2FUr4iEOCU3xCQq4nhGuj
	 aZvrpXsPmyJXHlcmjdAJnraXqfoianpy5u8nYbCRI+gS0CCq6XZvRFkpwauh+jsJwK79h
	 rOFyIM4NnX1rEQcld3z8kD8MxRM0S0+8Is9zhCaESte3aW/rL8ym7bXw83ArJLGPTUe/2
	 RTHsHz8mHHGk6mfyAb6c+6FIj7ztVc6uZr+6mV4eajXzjH3WIc7cpwQiw1fOMFXrooQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793844075;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=AhYjv8NuLbTIEkejiyuBrqV9b1AYMUH06dMl+QsydXM=;
	b=EY0AdkEP2OsaZHNU3g6v4DGVN86c7hRnxh2Pz4T5Rh5r1IidWdeqjX0PShjnwSm1Updj
	 N0uyiEXQjF7oZZmSumnRTNyJYmMBKEtndL6zexVHvLpxCS3VUxrSWYFrgQXdPt3dOxOuG
	 RlBZsk+JUzYTjIawbQ/1xkWql/OJYzmjgd6lCf+QCcY/Rq3umIYYn6std4F8uLG3ulC/A
	 1loMI7V/SCJWZrRy9n2/Z9bsyhQ6CBfgtCrYyUy9w1HDPTFS1L4prkNY5hpZaie0Zwruk
	 rAaEzpX9AwtNjKWGAJfnJ889tdLEhLKJiOQleNKzm5wAP21idlHw2zZU4jkUBmOXKuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QOclsVrR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C114606EE97
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 02:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QOclsVrR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE55B1F00A29;
	Thu,  5 Nov 2026 02:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793844074;
	bh=AhYjv8NuLbTIEkejiyuBrqV9b1AYMUH06dMl+QsydXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QOclsVrRHmPIaF19i8FMypyA61tBwJE02VxasqukBygZdqBBaWVlmJqMjwhVDJyjb
	 ofCBgm2xUVjtvAb1bfFO93eEgtsPPim5PzcoeVr0pjnq+K5kbMXu84fU10FyJ4nG/c
	 nsHdBF/dRZvqYoGiedV9yNQ/YQHDiWV2fF1lzjitdUAd0K5GO5GrL1iHW4ipGQtgVM
	 BSRup3GQ1ON5vIxxzt34BORRKPcmCuEggj/KxXkhqWcuEdH5YBb3mQWepXP76nFjMT
	 2Hi94Ap66fJR5V4E4TkIObwxfW/z4vZxfKWjDxNi4G7lg7NwVEfcLfDUuc77+x3c/g
	 4sjYh1Ldq2U4g==
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
Subject: [PATCH 6.6.y] mm: khugepaged: fix swap entry value to folio_pfn()
Date: Wed,  4 Nov 2026 21:01:12 -0500
Message-ID: <20261105020044.1021834-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110434-manhole-ferry-83f7@gregkh>
References: <2026110434-manhole-ferry-83f7@gregkh>
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
[ sashal: adapted folio APIs to the page-based scanner while preserving two-argument __assign_str() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/trace/events/huge_memory.h | 6 +++---
 mm/khugepaged.c                    | 7 ++++++-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
index 37f2443b3cdb0..0c57ef317e311 100644
--- a/include/trace/events/huge_memory.h
+++ b/include/trace/events/huge_memory.h
@@ -174,10 +174,10 @@ TRACE_EVENT(mm_collapse_huge_page_swapin,
 
 TRACE_EVENT(mm_khugepaged_scan_file,
 
-	TP_PROTO(struct mm_struct *mm, struct page *page, struct file *file,
+	TP_PROTO(struct mm_struct *mm, unsigned long pfn, struct file *file,
 		 int present, int swap, int result),
 
-	TP_ARGS(mm, page, file, present, swap, result),
+	TP_ARGS(mm, pfn, file, present, swap, result),
 
 	TP_STRUCT__entry(
 		__field(struct mm_struct *, mm)
@@ -190,7 +190,7 @@ TRACE_EVENT(mm_khugepaged_scan_file,
 
 	TP_fast_assign(
 		__entry->mm = mm;
-		__entry->pfn = page ? page_to_pfn(page) : -1;
+		__entry->pfn = pfn;
 		__assign_str(filename, file->f_path.dentry->d_iname);
 		__entry->present = present;
 		__entry->swap = swap;
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 42330aeb76386..84a64e2033d22 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2221,6 +2221,7 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
 	int present, swap;
 	int node = NUMA_NO_NODE;
 	int result = SCAN_SUCCEED;
+	unsigned long failed_pfn = -1;
 
 	present = 0;
 	swap = 0;
@@ -2254,6 +2255,7 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
 					/* Maybe PMD-mapped */
 					? SCAN_PTE_MAPPED_HUGEPAGE
 					: SCAN_PAGE_COMPOUND;
+			failed_pfn = page_to_pfn(page);
 			/*
 			 * For SCAN_PTE_MAPPED_HUGEPAGE, further processing
 			 * by the caller won't touch the page cache, and so
@@ -2266,18 +2268,21 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
 		node = page_to_nid(page);
 		if (hpage_collapse_scan_abort(node, cc)) {
 			result = SCAN_SCAN_ABORT;
+			failed_pfn = page_to_pfn(page);
 			break;
 		}
 		cc->node_load[node]++;
 
 		if (!PageLRU(page)) {
 			result = SCAN_PAGE_LRU;
+			failed_pfn = page_to_pfn(page);
 			break;
 		}
 
 		if (page_count(page) !=
 		    1 + page_mapcount(page) + page_has_private(page)) {
 			result = SCAN_PAGE_COUNT;
+			failed_pfn = page_to_pfn(page);
 			break;
 		}
 
@@ -2306,7 +2311,7 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
 		}
 	}
 
-	trace_mm_khugepaged_scan_file(mm, page, file, present, swap, result);
+	trace_mm_khugepaged_scan_file(mm, failed_pfn, file, present, swap, result);
 	return result;
 }
 #else
-- 
2.53.0

