Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833952;
	b=DgN/+raUoYirAFxzoAq2qnBLLEA0GF1ldbXGadhJPo70R3wmbraZd1czZRljbmHDC75I
	 CG+wNhdeXOTof7urSg9k+XUx7Yhb6wgHfjxoHDKm6Cv2azyM+sZXnNm5i5/7LVlcRQeC8
	 W+pjZ4jr9owHsg/Jho31al0fLHAy9n4H5oaFqFmGwYosw54RkZw4zBGj2xv/DJcYaruRV
	 z4/Pjs0PMrRkmN6F/EjsBkxM952mX6CKKAcligXmhlNZPWmerAzhIfi56h0E0Xnjoz5lF
	 CnsiFdJW47NOOI4O/nQMWmEE6+tZpbL7lG0u4SWy399VlX1XcPhj+RiDUBxGEp8VhKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833952;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Kc5FNT8++8zqjv9Uv42gVmOP5Qoeo3jVa983URMnBnA=;
	b=QRjGvRmSwJf2Xy+DUMVwgNqbiFJH43s/g6aU//ZMegY5CFow1uGGpar5FsoaR9O/y+XE
	 Mm4DO3VKJ9kHcOh5SmpGQsdwHe+YKvUo+kxK5scF1fXJ2Dd1f9r4J61TRZJxXQ43KGve+
	 C5qrmycKFLaXqrfpi0CQO2/ZoZD5UD1prLNCBWXXabJXFbdI9EFoGDfyK4dpNiU88mHV7
	 PD/zXanKInd2NYNi8TcRTdvHJDnB7DdzonKsTpIcumi/pfnVsWP1TqxXeIMRSA6LkPjB4
	 Jwg1uJEon4IQg0kYAQgJupqC9yLTh6hhPNt0LubmcPBtSDr7mOXogNHxcAV1ivX9gQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jGfDXfBJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D76606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 23:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jGfDXfBJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B0A1F000C1;
	Wed,  4 Nov 2026 23:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793833952;
	bh=Kc5FNT8++8zqjv9Uv42gVmOP5Qoeo3jVa983URMnBnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jGfDXfBJdLex5ZXTfDhQ2WQEvMj8ZdXUTSjodnVt6rT22nqOo6peRLK+eQ6/QzJ0Q
	 3dnXBD1jfGEas4BVIQpxTMIxBrcytPeANF/awmbNRndXrCxE9OY5MQQV8bx6VQo2j6
	 SwgdnZa2RDYvj8QFndfxa6wCycx7YJrDwISM1VsW9PLdtvwjLqQuz0SVnEYZmNAVH0
	 Uk+8ZRH0AY+L/3a2a2HJuiHfWCrhcWpEFHbAlaIlhbH/jKufs0mpmydfkN3AyaLbE7
	 KCAWqJDNObe8s6Y/YKxR4U8CSCx4ihGNwPYEJTUC7kIgGGYCchDVtcuhjt6yzgQD6Q
	 Mkqf2O+ZcDQcQ==
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
Subject: [PATCH 6.18.y] mm: khugepaged: fix swap entry value to folio_pfn()
Date: Wed,  4 Nov 2026 18:12:29 -0500
Message-ID: <20261104231213.892598-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110433-example-husband-50dd@gregkh>
References: <2026110433-example-husband-50dd@gregkh>
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
[ sashal: Retained int result instead of enum scan_result in hpage_collapse_scan_file(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/trace/events/huge_memory.h | 6 +++---
 mm/khugepaged.c                    | 7 ++++++-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
index 2276614691dfd..1464d45c90abf 100644
--- a/include/trace/events/huge_memory.h
+++ b/include/trace/events/huge_memory.h
@@ -167,10 +167,10 @@ TRACE_EVENT(mm_collapse_huge_page_swapin,
 
 TRACE_EVENT(mm_khugepaged_scan_file,
 
-	TP_PROTO(struct mm_struct *mm, struct folio *folio, struct file *file,
+	TP_PROTO(struct mm_struct *mm, unsigned long pfn, struct file *file,
 		 int present, int swap, int result),
 
-	TP_ARGS(mm, folio, file, present, swap, result),
+	TP_ARGS(mm, pfn, file, present, swap, result),
 
 	TP_STRUCT__entry(
 		__field(struct mm_struct *, mm)
@@ -183,7 +183,7 @@ TRACE_EVENT(mm_khugepaged_scan_file,
 
 	TP_fast_assign(
 		__entry->mm = mm;
-		__entry->pfn = folio ? folio_pfn(folio) : -1;
+		__entry->pfn = pfn;
 		__assign_str(filename);
 		__entry->present = present;
 		__entry->swap = swap;
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index e2ac26c05064f..cc3a09a0c2596 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2308,6 +2308,7 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
 	int present, swap;
 	int node = NUMA_NO_NODE;
 	int result = SCAN_SUCCEED;
+	unsigned long failed_pfn = -1;
 
 	present = 0;
 	swap = 0;
@@ -2344,6 +2345,7 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
 		    folio->index == start) {
 			/* Maybe PMD-mapped */
 			result = SCAN_PTE_MAPPED_HUGEPAGE;
+			failed_pfn = folio_pfn(folio);
 			/*
 			 * For SCAN_PTE_MAPPED_HUGEPAGE, further processing
 			 * by the caller won't touch the page cache, and so
@@ -2357,6 +2359,7 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
 		node = folio_nid(folio);
 		if (hpage_collapse_scan_abort(node, cc)) {
 			result = SCAN_SCAN_ABORT;
+			failed_pfn = folio_pfn(folio);
 			folio_put(folio);
 			break;
 		}
@@ -2364,12 +2367,14 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
 
 		if (!folio_test_lru(folio)) {
 			result = SCAN_PAGE_LRU;
+			failed_pfn = folio_pfn(folio);
 			folio_put(folio);
 			break;
 		}
 
 		if (folio_expected_ref_count(folio) + 1 != folio_ref_count(folio)) {
 			result = SCAN_PAGE_COUNT;
+			failed_pfn = folio_pfn(folio);
 			folio_put(folio);
 			break;
 		}
@@ -2401,7 +2406,7 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
 		}
 	}
 
-	trace_mm_khugepaged_scan_file(mm, folio, file, present, swap, result);
+	trace_mm_khugepaged_scan_file(mm, failed_pfn, file, present, swap, result);
 	return result;
 }
 
-- 
2.53.0

