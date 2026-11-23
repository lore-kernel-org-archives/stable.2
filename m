Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.217
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795405427;
	b=oivU5Gt4+w8sF3SCAhUuckywhJ1bx0S5IPKYZPISWgdnAcN4LWJF3OsTJWMED6CPlMq9
	 ICT6Rx7CUlbateVInlC1XcbbDBCQkGG0Vl4CQ7DTRfBCxbdxBaDQg9bE1+BmuoRmngI56
	 IDNRx4eBWrqWbAM6UURntKBoeRQQOJB1h4QchBCyj4SPwex+M1LRXNCTQjyiIGhggchIL
	 5WR2aFCPzClNOzsJbjPeFy28YMjyFS7wcVzhepni77BxhaWgD2HzZUUdHokmBIrSSVQsX
	 4yyeSGFi7fIJ2ki98FFbABIO0ia5wxOlzvMwcT6KvjsFqq7KOHFfMtuhMrN6bld3XEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795405427;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=u/dSSnvt29VXMuqEAAa81mXAdbrbhqEv++QT9+xRYhg=;
	b=X4RzNp/XJazuO2W3thcZwHuylYJi/G/crGoLlzblo16QhhTafugs14rVF8v6mL/6XkKQ
	 UuX3a/NnMq1XVtWij+NYVLd9eRBMncD+pEsv52sxxWf4I+mU9Nqz7vFVAIgml67qhx+zv
	 /Qx/6eYqAWBUB0P+H/CSZnMxYr2IlofxJspkhPWIHePQxrjAIHCk1d28OxllncvYVQM6D
	 HSyzv5/6DzJdHbBO2I22cOqv1nwTuINOfMHpmFihLaghN11O8HEf4seJZuLic/SPd3RGw
	 /SC6PY44Wa7/39HG3xx03FVntLnxdm+ZqRKe6j2kK/3uab8Cwiv385n8xTNoZJ0hWnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=oEIIGS9K;
	arc=none smtp.remote-ip=91.218.175.217
Received: from mta0.migadu.com (out-217.mta0.migadu.com [91.218.175.217])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A65606A6B7
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 03:43:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5A65606A6B7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=oEIIGS9K
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=u4K0EQqDi4+xhHfJPHjH7LQ7MYMicDcjgwVFleEBNuM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795405424; v=1; x=1796010224;
 b=oEIIGS9Ka5spYlhYLlfawa+ZXJ12Zna0ZEFeJEE7giXqmS3hI6VfU5abnWm9O5dKcBXdhDr3
 chFS9abhBmm/TkSVGVES9Fbe9qxxhndJ2h06+g34MMv9B9xjfE5uGLlQjOAPDphORiVdJwtVHXf
 T8NO827T1NAkp4Q7nbd81vvk=
X-Envelope-To: stable@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id cec765d6627a4390;
	Mon, 23 Nov 2026 03:43:44 +0000
X-Mizu-Trace-ID: cec765d6627a4390
X-Migadu-Flow: FLOW_OUT
From: "Xu Xin (vivo)" <xu.xin@linux.dev>
To: xu.xin@linux.dev
Cc: akpm@linux-foundation.org,
	chengming.zhou@linux.dev,
	david@kernel.org,
	donettom@linux.ibm.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org,
	Karl Mehltretter <kmehltretter@gmail.com>
Subject: [PATCH v3 1/3] mm/ksm: do not inherit ksm_zero_pages counter or PTE markers on fork
Date: Mon, 23 Nov 2026 11:43:31 +0800
Message-Id: <20261123034331.236509-1-xu.xin@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261123034136.209410-1-xu.xin@linux.dev>
References: <20261123034136.209410-1-xu.xin@linux.dev>
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

As documented in Documentation/admin-guide/mm/ksm.rst, ksm_zero_pages
accounts only for zero pages actually placed by KSM.  However, the
current implementation wrongly accounts for forked zero-page PTEs as
KSM's contribution, inflating both the child's per-mm counter and the
global ksm_zero_pages counter.

Originally, commit e2942062e01d ("ksm: count all zero pages placed by
KSM") marked KSM-placed zero-page PTEs with the dirty bit for unmap
accounting, but forgot to clear this marker during fork().  Later, to
prevent ksm_might_unmap_zero_page() from underflowing the counters on
child exit[1], commit 4d6fc29f3634 ("mm/ksm: fix incorrect KSM counter
handling in mm_struct during fork") kept the child's inherited per-mm
counter and added it to the global counter.

Instead of inflating the counters, fix the root cause by resetting the
child's mm->ksm_zero_pages to 0 in ksm_fork() and clearing the KSM
zero-page marker via ksm_fork_pte() when copying present PTEs in
copy_present_ptes().  With the marker cleared,
ksm_might_unmap_zero_page() will not decrement the counters on child
exit, MADV_UNMERGEABLE in the child will not unnecessarily unshare
inherited zero pages, and the global counter remains untouched.

[1] https://lore.kernel.org/all/53a7bf3d-843d-4e19-b0a3-cc6852fe72c1@redhat.com/

Fixes: 4d6fc29f3634 ("mm/ksm: fix incorrect KSM counter handling in mm_struct during fork")
Cc: stable@vger.kernel.org
Tested-by: Karl Mehltretter <kmehltretter@gmail.com>
Signed-off-by: Xu Xin (vivo) <xu.xin@linux.dev>
---
Changes in v3:
- Rename might_clear_ksm_zero_pte() to ksm_fork_pte() and move the
  is_ksm_zero_pte() check into copy_present_ptes() under the !page
  branch, as suggested by David Hildenbrand.
- Expand the comment above ksm_fork_pte() to explain why the marker is
  cleared on fork.
- Add Tested-by tag from Karl Mehltretter.

 Documentation/admin-guide/mm/ksm.rst |  7 ++++++-
 include/linux/ksm.h                  | 22 +++++++++++++++++++---
 mm/memory.c                          |  5 ++++-
 3 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-guide/mm/ksm.rst
index c329ca747b8c..8968ae3f55c0 100644
--- a/Documentation/admin-guide/mm/ksm.rst
+++ b/Documentation/admin-guide/mm/ksm.rst
@@ -214,7 +214,12 @@ stable_node_dups
         number of duplicated KSM pages
 ksm_zero_pages
         how many zero pages that are still mapped into processes were mapped by
-        KSM when deduplicating.
+        KSM when deduplicating. Note: on fork(), the child process does not
+        inherit the ``ksm_zero_pages`` counter, and any inherited KSM-placed
+        zero-page mappings are converted into ordinary shared zero-page
+        mappings. Consequently, these mappings are neither accounted for in
+        the child's counter nor unshared when ``MADV_UNMERGEABLE`` is called
+        in the child.
 
 When ``use_zero_pages`` is/was enabled, the sum of ``pages_sharing`` +
 ``ksm_zero_pages`` represents the actual number of pages saved by KSM.
diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index 596c04ca7326..f29aec4496d0 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -32,6 +32,17 @@ void __ksm_exit(struct mm_struct *mm);
  */
 #define is_ksm_zero_pte(pte)	(is_zero_pfn(pte_pfn(pte)) && pte_dirty(pte))
 
+/*
+ * Since the inherited mappings on fork are not expected to be accounted for
+ * in the child's ksm_zero_pages counter (reset in ksm_fork()), we must
+ * clear KSM's dirty-bit marker on KSM-placed zero-page PTEs to avoid
+ * underflowing the counters on child exit.
+ */
+static inline pte_t ksm_fork_pte(pte_t pte)
+{
+	return pte_mkclean(pte);
+}
+
 extern atomic_long_t ksm_zero_pages;
 
 static inline void ksm_map_zero_page(struct mm_struct *mm)
@@ -57,11 +68,9 @@ static inline void ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
 {
 	/* Adding mm to ksm is best effort on fork. */
 	if (mm_flags_test(MMF_VM_MERGEABLE, oldmm)) {
-		long nr_ksm_zero_pages = atomic_long_read(&mm->ksm_zero_pages);
-
 		mm->ksm_merging_pages = 0;
 		mm->ksm_rmap_items = 0;
-		atomic_long_add(nr_ksm_zero_pages, &ksm_zero_pages);
+		atomic_long_set(&mm->ksm_zero_pages, 0);
 		__ksm_enter(mm);
 	}
 }
@@ -95,6 +104,8 @@ bool ksm_process_mergeable(struct mm_struct *mm);
 
 #else  /* !CONFIG_KSM */
 
+#define is_ksm_zero_pte(pte)	false
+
 static inline vma_flags_t ksm_vma_flags(struct mm_struct *mm,
 		const struct file *file, vma_flags_t vma_flags)
 {
@@ -114,6 +125,11 @@ static inline void ksm_exit(struct mm_struct *mm)
 {
 }
 
+static inline pte_t ksm_fork_pte(pte_t pte)
+{
+	return pte;
+}
+
 static inline void ksm_might_unmap_zero_page(struct mm_struct *mm, pte_t pte)
 {
 }
diff --git a/mm/memory.c b/mm/memory.c
index 6a23198c1c67..f0b5df879e6f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1184,8 +1184,11 @@ copy_present_ptes(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 	int err, nr;
 
 	page = vm_normal_page(src_vma, addr, pte);
-	if (unlikely(!page))
+	if (unlikely(!page)) {
+		if (unlikely(is_ksm_zero_pte(pte)))
+			pte = ksm_fork_pte(pte);
 		goto copy_pte;
+	}
 
 	folio = page_folio(page);
 
-- 
2.34.1

