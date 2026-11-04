Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.117.225.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793824885;
	b=rQf0nLVs5DTz8zSlkpVi7bPtZi9bXpesPweeMZwQhN/3UiI9VdgNSs7D7CnlTUBAnKST
	 umrv/KSpIl3TBxnxxiQ3w58sdpp+d7JfTlZcH93i559Za+fL4iCjxsXWFtamkLzf5kz/9
	 8ff5+13LOsibKZc2eyyk9PB/5Eqs3bNb8bHk2D5TnBreJ2VulJ1nm1S+i4TWhF5qA1Daq
	 xHewmzq4ghxNpQEV2fj9IUb6u/qTYeLs45lG/BsVsTkaHAEOr1c/V5RJXZAt0uhj/s6Cg
	 myF0ENlKLffeIssBQD+602hzKX+gbUSz9r1z2IIyEc1ZFQq1+H6gD/fUWR0NG8qNUcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793824885;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=qXUxwrXDhs1PWm79i4GcxyZXvd/pHUbaJGpiHuI7wAo=;
	b=qpZ04s0NBYPxNwEsA75tRlB1ZtwxRNXrBX+Hh0EanhpLhiqRDJLmTAy1m1zjEWpCBiws
	 crSMbmjLKxaZgDLGzeZdiTd58l7AukQZ4M2ecolhzkwDurRbVGKUJUOHKVtf4RaueXUCm
	 WTsRG3wPm3zRhPkcT+b/ZcMoJKPbLVIoZYraR5EMgkzgNU+xlmYxgITjHGqxCscfkK1d3
	 vIYgd7fy+dvBuu2f2SaTJT2+yDD0MqBgWcStKghgIGc/AsJTzjKmsXWUsunI7AInW/18i
	 jtH/7Mdj4Sq8WpIjRE/YI6NbfCFxXqVEjRsfLjKZwiW1lVroD8lHZoRNXvBfyhZii6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=virtuozzo.com;
	spf=pass smtp.mailfrom=virtuozzo.com;
	dkim=pass header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=relay header.b=h4D1skB+;
	arc=none smtp.remote-ip=130.117.225.111
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BC8606AC03;
	Wed,  4 Nov 2026 20:41:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59BC8606AC03
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=relay header.b=h4D1skB+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=Message-Id:Content-Type:MIME-Version:Subject:Date
	:From; bh=qXUxwrXDhs1PWm79i4GcxyZXvd/pHUbaJGpiHuI7wAo=; b=h4D1skB+euETTCIeRLu
	bV0gdhvhkuKqbjoFm9Q/XNtzahcd/ZhrSGWr5fMlWUoKlySSJMdpS7Hpc5st6LFQQJLMOQtdRean+
	iwom2R3ds1othdg7yBjfj0zMqO8anQYnJF9kq+jgt7/ccZhnmBMsnGiJRt8Up2y2/dCnefNE/zjqR
	jjLHHCJ65IMwtjNReI9EjWvVlpy3WP2bMuBXYMgpt3bk7iYGtdwiowLQNcN+s1ZD8WcmTeDPQEKc1
	wVBTbMaaEPGpUrHMm7zBTkxRyDocN7v3hh1Sm8W6wYbjMsd5lrL2m/OEIJDMvS92qd2xyac0hdHz1
	A7x0PnQeT09gW2A==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=f0.sw.ru)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <khorenko@virtuozzo.com>)
	id 1xOhj9-0018X2-2u;
	Wed, 04 Nov 2026 21:41:04 +0100
From: Konstantin Khorenko <khorenko@virtuozzo.com>
Date: Wed, 04 Nov 2026 21:40:56 +0100
Subject: [PATCH v5 2/4] mm/huge_memory: copy file THPs at fork like
 copy_present_ptes() does
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-2-c56d0d26f970@virtuozzo.com>
References: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-0-c56d0d26f970@virtuozzo.com>
In-Reply-To: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-0-c56d0d26f970@virtuozzo.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org, 
 =?utf-8?q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Konstantin Khorenko <khorenko@virtuozzo.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6832;
 i=khorenko@virtuozzo.com; h=from:subject:message-id;
 bh=qbeE72EcKt+nHvslYKs4rrLI6uA1PAwtfZQutpxdsEs=;
 b=owEBbQKS/ZANAwAKAVGWCkf5YVwqAcsmYgBq65hd0gTi0o46y84KkC0gNr7/WUAZtvCZ2TTzE
 fp/UcJTw02JAjMEAAEKAB0WIQRWD23IPcXT0GO9CCxRlgpH+WFcKgUCauuYXQAKCRBRlgpH+WFc
 KhHuD/4l+IpPwzsQO46HGwIUZiqhz9ws7K2EnvQ9qeNADrnW7gO2bLSMm6eh7rH1lH72DxrYZbW
 Qjm+11Kb1PZEWl67YBRPdSteWZbt/eSquhnFVtC0eT+7QGzcghOUsd1BPjuTV+y1v+TR6YztiPW
 /krS2nnsvrkBICfOMU7MDULARirANoLT1VhFHCZjO9tp8UQxVNWerVl3ihwx8vMHFpfp3dHximT
 oI8YSQzUzQ6r8QnTC43ktRqcBPSnavnKPJwHrydhRy8PLjEfcyxQJcbAu8wLMN9hPfYM8fv1PNJ
 LG50fVq0VJim1CbpFNsxWzfiC9bYJb8rDUUs4EpQSovdsN2k0tl5oB2qG3jti7fBkvQtyRU4HU9
 G+w3CADbOtNPgv6/mjLEhq0PGEYBZX598ftLnraCKDBCoC5SWTPzDArMUygoJCbLw9Z4sQULpGZ
 IsK1Ck2dxPDdQrGoLttE1HOM9cobWSIAV/eBAIBbduxhhc8IdvThgCOy4pQ15V/Wza4xGpDUoi6
 hp9IvgDN5DgGKv7xxf1d9Ykf/vo+KvWm9YzRTVkN17QV28qOMRNsE6vcbFkDMQwEPYLFBkzEIXf
 xRT4eURWmXSDYZbHDAOn9anK1cnwpVgyEQ1tI1f/eImzHd9+cvB4A8MocCxTtsOwv6MvJsiroix
 qH4FW3GL+6qqXzA==
X-Developer-Key: i=khorenko@virtuozzo.com; a=openpgp;
 fpr=560F6DC83DC5D3D063BD082C51960A47F9615C2A

This fixes no bug: it makes fork copy a PMD the way copy_present_ptes()
copies a PTE. Until now copy_huge_pmd() skipped every folio PMD of a
non-anonymous VMA and left the child to fault them in again, while the
PTEs of the same VMA are copied.

Treat file folios as the PTE path does: take a reference, duplicate the
rmap and account them. fork then pays a reference and an rmap update
per PMD, and saves the child a fault per PMD it touches. The next patch
sends PFN mappings through the same tail.

That covers the VMAs vma_needs_copy() sends here:

- private file mappings with an anon_vma;
- VM_COPY_ON_FORK ones: uffd-wp and uffd-rwp, VM_MIXEDMAP, and
  VM_MAYBE_GUARD, which shared shmem, file and DAX mappings get from a
  guard region.

The DAX huge zero PMD is copied too, with a reference taken by
mm_get_huge_zero_folio() as for anonymous VMAs. A migration entry of a
file folio is copied and accounted like copy_nonpresent_pte() does, and
made read-only in both processes only in a CoW mapping. A device
private entry gets the same CoW check, as in copy_nonpresent_pte().

The copy then gets the same tail as __copy_present_ptes(): write
protect both sides in a CoW mapping, mark the child's copy clean in a
shared one, and drop the uffd-wp bit where the child is not armed. An
anonymous THP is now write protected only when its PMD is writable, as
a PTE is.

A page table is deposited under the copy where the fault paths deposit
one: in anonymous VMAs, and wherever the architecture needs one.

Cc: stable@vger.kernel.org # needed by the next patch
Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
---
 mm/huge_memory.c | 63 +++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 39 insertions(+), 24 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index bd44d58e86845..e00632edb3856 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1897,12 +1897,13 @@ static void copy_huge_non_present_pmd(
 		pmd_t pmd, pgtable_t pgtable)
 {
 	softleaf_t entry = softleaf_from_pmd(pmd);
-	struct folio *src_folio;
+	struct folio *src_folio = softleaf_to_folio(entry);
 
 	VM_WARN_ON_ONCE(!pmd_is_valid_softleaf(pmd));
 
-	if (softleaf_is_migration_write(entry) ||
-	    softleaf_is_migration_read_exclusive(entry)) {
+	if ((softleaf_is_migration_write(entry) ||
+	     softleaf_is_migration_read_exclusive(entry)) &&
+	    vma_is_cow_mapping(src_vma)) {
 		entry = make_readable_migration_entry(swp_offset(entry));
 		pmd = softleaf_to_pmd(entry);
 		if (pmd_swp_soft_dirty(*src_pmd))
@@ -1915,7 +1916,8 @@ static void copy_huge_non_present_pmd(
 		 * For device private entries, since there are no
 		 * read exclusive entries, writable = !readable
 		 */
-		if (softleaf_is_device_private_write(entry)) {
+		if (softleaf_is_device_private_write(entry) &&
+		    vma_is_cow_mapping(src_vma)) {
 			entry = make_readable_device_private_entry(swp_offset(entry));
 			pmd = softleaf_to_pmd(entry);
 
@@ -1926,7 +1928,6 @@ static void copy_huge_non_present_pmd(
 			set_pmd_at(src_mm, addr, src_pmd, pmd);
 		}
 
-		src_folio = softleaf_to_folio(entry);
 		VM_WARN_ON(!folio_test_large(src_folio));
 
 		folio_get(src_folio);
@@ -1938,9 +1939,11 @@ static void copy_huge_non_present_pmd(
 					    dst_vma, src_vma);
 	}
 
-	add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
-	mm_inc_nr_ptes(dst_mm);
-	pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
+	add_mm_counter(dst_mm, mm_counter(src_folio), HPAGE_PMD_NR);
+	if (pgtable) {
+		mm_inc_nr_ptes(dst_mm);
+		pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
+	}
 	if (!userfaultfd_protected(dst_vma))
 		pmd = pmd_swp_clear_uffd(pmd);
 	set_pmd_at(dst_mm, addr, dst_pmd, pmd);
@@ -1956,6 +1959,7 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	pmd_t pmd;
 	pgtable_t pgtable = NULL;
 	int ret = -ENOMEM;
+	bool writable;
 
 	pmd = pmdp_get_lockless(src_pmd);
 	if (unlikely(pmd_present(pmd) && pmd_special(pmd) &&
@@ -1976,13 +1980,11 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		goto set_pmd;
 	}
 
-	/* Skip if can be re-fill on fault */
-	if (!vma_is_anonymous(dst_vma))
-		return 0;
-
-	pgtable = pte_alloc_one(dst_mm);
-	if (unlikely(!pgtable))
-		goto out;
+	if (vma_is_anonymous(dst_vma) || arch_needs_pgtable_deposit()) {
+		pgtable = pte_alloc_one(dst_mm);
+		if (unlikely(!pgtable))
+			goto out;
+	}
 
 	dst_ptl = pmd_lock(dst_mm, dst_pmd);
 	src_ptl = pmd_lockptr(src_mm, src_pmd);
@@ -2000,7 +2002,8 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	}
 
 	if (unlikely(!pmd_trans_huge(pmd))) {
-		pte_free(dst_mm, pgtable);
+		if (pgtable)
+			pte_free(dst_mm, pgtable);
 		goto out_unlock;
 	}
 	/*
@@ -2015,7 +2018,7 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		 * copy. It just takes a reference.
 		 */
 		mm_get_huge_zero_folio(dst_mm);
-		goto out_zero_page;
+		goto copy_pmd;
 	}
 
 	src_page = pmd_page(pmd);
@@ -2023,6 +2026,12 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	src_folio = page_folio(src_page);
 
 	folio_get(src_folio);
+	if (!folio_test_anon(src_folio)) {
+		folio_dup_file_rmap_pmd(src_folio, src_page, dst_vma);
+		add_mm_counter(dst_mm, mm_counter_file(src_folio),
+			       HPAGE_PMD_NR);
+		goto copy_pmd;
+	}
 	if (unlikely(folio_try_dup_anon_rmap_pmd(src_folio, src_page, dst_vma, src_vma))) {
 		/* Page maybe pinned: split and retry the fault on PTEs. */
 		folio_put(src_folio);
@@ -2033,19 +2042,25 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		return -EAGAIN;
 	}
 	add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
-out_zero_page:
-	mm_inc_nr_ptes(dst_mm);
-	pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
+copy_pmd:
+	if (pgtable) {
+		mm_inc_nr_ptes(dst_mm);
+		pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
+	}
 
-	/* See __copy_present_ptes(): restore accessible protection. */
+	/* See __copy_present_ptes(). */
+	writable = pmd_write(pmd);
 	if (!userfaultfd_protected(dst_vma)) {
 		if (userfaultfd_rwp(src_vma) && pmd_uffd(pmd))
 			pmd = pmd_modify(pmd, dst_vma->vm_page_prot);
 		pmd = pmd_clear_uffd(pmd);
 	}
-
-	pmdp_set_wrprotect(src_mm, addr, src_pmd);
-	pmd = pmd_wrprotect(pmd);
+	if (vma_is_cow_mapping(src_vma) && writable) {
+		pmdp_set_wrprotect(src_mm, addr, src_pmd);
+		pmd = pmd_wrprotect(pmd);
+	}
+	if (src_vma->vm_flags & VM_SHARED)
+		pmd = pmd_mkclean(pmd);
 set_pmd:
 	pmd = pmd_mkold(pmd);
 	set_pmd_at(dst_mm, addr, dst_pmd, pmd);

-- 
2.43.0

