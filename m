Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.214
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795405401;
	b=anOt+R4hDlzdimV7p/7mtIx40EvH1hjBI9v7wUDtwgpiPL6v8TUiMoklRoHJ19E/Wid1
	 DeNwpniuWwB9rb2dsLw6j+dgu95D68cBcGjwOb5jrs2qDcIduDOsrYbugBg/q8Ip+xw+6
	 ULtXGk6ZPGny/Q3UW9KvGEDFXMncZ4DOUKTGSsyfkjNmhatkC8S4y7bv/uV3JDRtQC68h
	 0MIhDlMQk5JMxuskeDHjPuIZMvQBB8kQ7IaRnd8KfrYvCxU5/P/EHHMGpORZBhNhH5Hva
	 lUzOJYQ6eAzeDDMXpR3M8bDpQBr5mp7w/ZzTWt+3lPT4ZJ9ECp/oFt90DJ7AQZB2wsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795405401;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=u/dSSnvt29VXMuqEAAa81mXAdbrbhqEv++QT9+xRYhg=;
	b=dE++xw/9U3oaebO5YE45jsIPBAiAeXhDrRrMiJDYGf7LepYy7x40CL8IWdl8MdhGe6B5
	 gEr+lYcJlIg/60jqIxdepcm155BPgOqF6VUvI3YbBGK0i6x+YZ9sLh7E+0NIm34AUseKw
	 riq8fzBNYSHGlIGDp5e6zk+y4DVk6fVRZ0UwL90zkqOXiOZd1h+YSLqJh2jtRk12vLv7W
	 0UP7OLzouhxBOlu7iTiLXblCrOJ8dP5NJKEL/m8QmqmgBo5HMxEJ4qmOar8X7H9+Vw5/z
	 TXE2zu8Ef3ZCPaDnfXZAJj3BQIeHYGC0bNqqxu/vi//jWZnO021xKrNN9uMWwvzMN0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=sym98uDI;
	arc=none smtp.remote-ip=91.218.175.214
Received: from mta0.migadu.com (out-214.mta0.migadu.com [91.218.175.214])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48909606A31E
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 03:43:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48909606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=sym98uDI
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=u4K0EQqDi4+xhHfJPHjH7LQ7MYMicDcjgwVFleEBNuM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795405399; v=1; x=1796010199;
 b=sym98uDIogUQEVzQ57BtWFFt9Lo0yVdauWGeKKZLwDg6jJADX1S8k4zgKh5ONHgbDFhurkMK
 n23ugOKub2PpV5+WNX0IZz83zQ0Q6CLMi5FsPRTiOi4sV9uGT8ZKJz8Vq0vQeAAG9l+Mf8rx+DV
 ZHFqO7Q4VPkh4Ai1On/OOOAg=
X-Envelope-To: stable@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id b23e18659fa0a669;
	Mon, 23 Nov 2026 03:43:19 +0000
X-Mizu-Trace-ID: b23e18659fa0a669
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
Date: Mon, 23 Nov 2026 11:43:07 +0800
Message-Id: <20261123034307.236032-1-xu.xin@linux.dev>
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

