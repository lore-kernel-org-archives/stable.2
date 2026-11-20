Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160657;
	b=mzIxmZsfmQVoi5qUFKzknYi0qqlEsxYfVzRCHK48xtOErUrei8MNLoJn97WydOlAE98f
	 MrD4oUr2v7E4WvFw6I/u0L8SUYj0RalOtl2hvsI3pLtFE3M5MaJQ9XPYy3HaQF0DXZntx
	 ba1tP9XG2k+JTJN59IjIFz8agTUl2wVb4cfEpiQEhoRP+nGmTrDSPWaBW3mmRF3gkuiwU
	 NGpNihN/jGP3WngM0XyjYLXqnyVyfJJW+T4ehIDYmarg8H35LEe5SbVxb7Got+DkJxMV7
	 IHHE6o93kvwTZYMv2xIa3Tg6iCtu2eh3T2wjh7nVcTE1SuCKPjsJ8S18PphrIp6+Omg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160657;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wS8YTXUEYmlpow8QFrpCI11WZWGA6i9kEdPiCMgtarw=;
	b=QRRkrTflrLp48+l7j7IhXYo4yt4LHswalDd+y97StzbOa++KRyZjpef/hCPnaMFUTrIQ
	 9OR9Lu/81ols0TJVkFrn5SwGNcbp6wH5edOuMdetcP0mgIHKnbeMBL7sYjsxHSm80HxdW
	 XfYZ6+ZYHKXUt1PhCoqhc9zzX7Ybl/I1OOq8PdJ4p9Aiu0LcKMl6XinpSTU0fyAE+QlCx
	 79ZHn42uQz0ZouI2Ptp34C3mSkzNLp2zeMFNp9xo2mAETJBqeGcJ0xcjuQZPqDgsBMqdY
	 Ypq0Sk1ulBWCdXKIdIbLZhxJS5t6LP5agc27XyvIPL1Qt/a60WXh7uDF1kUrH7zRErw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XimPrw1i;
	arc=none smtp.remote-ip=91.218.175.220
Received: from mta0.migadu.com (out-220.mta0.migadu.com [91.218.175.220])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07CB606A320
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 07:44:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E07CB606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XimPrw1i
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=l4lLHnbLURw2R0LQLtIWt2VlgrpY8/rwx1HMfQXWaYo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795160654; v=1; x=1795765454;
 b=XimPrw1izPqOXLRwj5kSrM6oXjcvnKTSQ+yZ0EO4uAbJm/qjOWED6fwZehQBFTx20/PQycmk
 5tILXP6BnV1Fis3mcokiwhIF4aWVRx8NjPN52gaDDfKZ6exH3tqn/YW+XnUqOhmnxK2SClX1tFM
 a6sytOEoGgkxB7G5FQBwnHMI=
X-Envelope-To: stable@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 6334611df7694553;
	Fri, 20 Nov 2026 07:44:14 +0000
X-Mizu-Trace-ID: 6334611df7694553
X-Migadu-Flow: FLOW_OUT
From: "Xu Xin (vivo)" <xu.xin@linux.dev>
To: xu.xin@linux.dev
Cc: akpm@linux-foundation.org,
	chengming.zhou@linux.dev,
	david@kernel.org,
	donettom@linux.ibm.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] mm/ksm: do not inherit ksm_zero_pages counter or PTE markers on fork
Date: Fri, 20 Nov 2026 15:43:59 +0800
Message-Id: <20261120074359.41019-1-xu.xin@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261120074230.40269-1-xu.xin@linux.dev>
References: <20261120074230.40269-1-xu.xin@linux.dev>
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
zero-page marker via might_clear_ksm_zero_pte() when copying present
PTEs in __copy_present_ptes(). With the marker cleared,
ksm_might_unmap_zero_page() will not decrement the counters on child
exit, MADV_UNMERGEABLE in the child will not unnecessarily unshare
inherited zero pages, and the global counter remains untouched.

[1] https://lore.kernel.org/all/53a7bf3d-843d-4e19-b0a3-cc6852fe72c1@redhat.com/

Fixes: 4d6fc29f3634 ("mm/ksm: fix incorrect KSM counter handling in mm_struct during fork")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Xin (vivo) <xu.xin@linux.dev>
---
 Documentation/admin-guide/mm/ksm.rst |  7 ++++++-
 include/linux/ksm.h                  | 18 +++++++++++++++---
 mm/memory.c                          |  2 ++
 3 files changed, 23 insertions(+), 4 deletions(-)

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
index 596c04ca7326..62fa8ca803ed 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -32,6 +32,15 @@ void __ksm_exit(struct mm_struct *mm);
  */
 #define is_ksm_zero_pte(pte)	(is_zero_pfn(pte_pfn(pte)) && pte_dirty(pte))
 
+/* Clear KSM's marker on zero-page PTEs (e.g., on fork). */
+static inline pte_t might_clear_ksm_zero_pte(pte_t pte)
+{
+	if (is_ksm_zero_pte(pte))
+		return pte_mkclean(pte);
+
+	return pte;
+}
+
 extern atomic_long_t ksm_zero_pages;
 
 static inline void ksm_map_zero_page(struct mm_struct *mm)
@@ -57,11 +66,9 @@ static inline void ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
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
@@ -114,6 +121,11 @@ static inline void ksm_exit(struct mm_struct *mm)
 {
 }
 
+static inline pte_t might_clear_ksm_zero_pte(pte_t pte)
+{
+	return pte;
+}
+
 static inline void ksm_might_unmap_zero_page(struct mm_struct *mm, pte_t pte)
 {
 }
diff --git a/mm/memory.c b/mm/memory.c
index d2f48d78b0d7..79ebaa1e3368 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1160,6 +1160,8 @@ static __always_inline void __copy_present_ptes(struct vm_area_struct *dst_vma,
 		pte = pte_mkclean(pte);
 	pte = pte_mkold(pte);
 
+	pte = might_clear_ksm_zero_pte(pte);
+
 	set_ptes(dst_vma->vm_mm, addr, dst_pte, pte, nr);
 }
 
-- 
2.34.1

