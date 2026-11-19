Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.117.225.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795095890;
	b=EciAR7eSOS8lT6WHalsPJ+I7d9EpE12U1MsCeDoyZznfkGB0YNwQ6T18Dx6dymSLG3iG
	 deBaQ4QXZbWoghdN1r4i885mthbW8rV2ZHc2h6S/NzZXQNADwq9k2iuBl4mpNiH+yXeSl
	 PpcWMDUt6F3bmTvA40uKNTCauJA3Xvdfy4NmsTC5srzeu4OVXeA3BbKSxwzOZobGi7gpc
	 K20yWNBuABULGymKM1Yc9l8q3abOOhpLVdZ8eOucmWWsk7CCfUpmsyCGvHLR5dVLWTB+m
	 FmO5m0GKkka4FXVjLTXLo5O56Irrc4U02S6M0vPUoOjxoThWyqXkhX5lo2o5/t0dE9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095890;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=AxMySNVvPjLucVppfHytyY+kX3x4T6lEtLV81QZyco4=;
	b=nfi6lAt6eIl9hqFGiv8gooPCCYWbBdbTsrZK1FZQClsOYQyvFB/22xctKJ5AIvAaTXXD
	 tgOXASpMCGpqRUh0LeLdIrY4OiHlfIUgsFRwCFu8iCm5HJ7cQEQwATWxVZlpg0ZBLjRlw
	 UYWDDYPHpe/Ujbbr0Lzv5Sua9WiZXBSMvVqpVV0nkQ/TsanZBU/RzY85MwZah9JuhvEl6
	 bP7QaxjeTGCdfEesEHjhPjPQ6Gzgwzn3gpMc80OHo+6lTPNFVFp2nkOfHQJqGzoRYjMq7
	 U1bIPPSuRvjo0RN1JDSpC4vn+9fzW1Uj/vaGGE+hawT1bkRb/TB3PGP19+ldx77afbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=virtuozzo.com;
	spf=pass smtp.mailfrom=virtuozzo.com;
	dkim=pass header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=relay header.b=VOSH71Cw;
	arc=none smtp.remote-ip=130.117.225.111
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F25606A33A;
	Thu, 19 Nov 2026 13:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2F25606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=relay header.b=VOSH71Cw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=Message-Id:Content-Type:MIME-Version:Subject:Date
	:From; bh=AxMySNVvPjLucVppfHytyY+kX3x4T6lEtLV81QZyco4=; b=VOSH71CwjVoEFr6SOAO
	8v3CqiPqjopc3hX6iCTDL4NRauh3kG0xHnXkKCHlrjAA8HVhxDC1LBky4KT4m6XZdsBh8mfhM5BmO
	5cqz39X85md+IhaionpfkALD9n0Obupl5ILdCuxr3ySgwMYD0g2FZmQN0Pt1KmOSMisNJszpmLXjm
	tX59CZMiVBhp+EAhC6CF/RYD6qkCpY4AaCe6bV7P5Xp9s7w3jcDQibB4Ju3S9SmohtyG+Xf4t+1k1
	9mdiWogiz9RIL/VUlgBJAB0+n1du3N+n2U2IXs5f+vHmrJ1t+Fi3RP0a4/fZ9oSRxU7l+NZjb02BI
	AV/ll/TvEBPEgOw==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=f0.sw.ru)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <khorenko@virtuozzo.com>)
	id 1xU2R6-00FBqZ-1S;
	Thu, 19 Nov 2026 14:44:24 +0100
From: Konstantin Khorenko <khorenko@virtuozzo.com>
Date: Thu, 19 Nov 2026 14:44:03 +0100
Subject: [PATCH v6 2/4] mm/huge_memory: copy file THPs at fork like
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
Message-Id: <20261119-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v6-2-efa7817a2bb3@virtuozzo.com>
References: <20261119-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v6-0-efa7817a2bb3@virtuozzo.com>
In-Reply-To: <20261119-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v6-0-efa7817a2bb3@virtuozzo.com>
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
 Jason Gunthorpe <jgg@ziepe.ca>, stable@vger.kernel.org, 
 "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7540;
 i=khorenko@virtuozzo.com; h=from:subject:message-id;
 bh=IgE9uAEv/c+7yRxMtgqsFi6vMtEjdXegJpH8fpn8rS4=;
 b=owEBbQKS/ZANAwAKAVGWCkf5YVwqAcsmYgBq/v02ql8g3EcW9pPf4laG3jC53qlxFzRdsvB1A
 yrQpj8ZU62JAjMEAAEKAB0WIQRWD23IPcXT0GO9CCxRlgpH+WFcKgUCav79NgAKCRBRlgpH+WFc
 KuDLD/0WNK6BP+muT6uGJO6/TBtfM3lc/++r4ez/AxsXmcFbyaTeUKJYuV7iodMrqeSHzXKPFAu
 Peff7ZXoDLBCiK6OTguPLQq+FRh43y36PtNF04AkbpAkAqz81/Z9S7Z7sR6rAvi0erU27ugQaEU
 OQrwMzat5vHwy/Zce8pKvxNPhs5N8cWBAdXOOI7Q/mTg4YSfFnfuDIrFiYkZBBAbUI85xM3M13z
 54RxY4DQjjevy0tB9GeVyKtgDf5sZsp0Y63thT/a2yYZ+lSXC9hBVIPiGHmHnzI0nOXzKqh3bo6
 36iTYxBT5/aIoNuDTJ4Kbe2LPQKhOWHvHFqbzcFSDDxydQzPoNmuc2nBpsjJSSF5jg42tBVJaIR
 s+JZgQYe5OGxnP4fKlPitSR6uUk7X/g35C50vyX15buA1ToxmzU9WcWzg4b1j09v1HTC5G3qj2j
 ctWxJjqoSweDpbUtGENb34qfTXIH2wFGEl9pdJsX7o0IZpnVX7MUWTVb7jVOyjZtVN8pchrwdGy
 1+Qxwg8S9wzwqbbL5zW4DKibuQjYV5znPUgWTPb4MlobrR3g5lmyvBx+H3N4jY3Ehxv4CIzQFaQ
 sr/afIhFfjEjiDqgK1NW4OiCzitg535LxOPRw6djD5kgsMReBpj8EM8VQvZRJx1FqwM1SxxFL1K
 no6usWnboYgnAog==
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

A folio over the page cache refcount limit is not copied, as in
copy_present_ptes(): the child faults it in, and fork() fails with
-ENOMEM only in a VM_MIXEDMAP VMA, which may have no fault handler.
Unlike a skipped PTE, the PMD needs no uffd marker: a file PMD never
carries the uffd bit, as protecting it splits it.

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
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
---
 mm/huge_memory.c | 74 ++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 50 insertions(+), 24 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 641e5a3822e3a..277d27a8a4364 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1913,12 +1913,13 @@ static void copy_huge_non_present_pmd(
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
@@ -1931,7 +1932,8 @@ static void copy_huge_non_present_pmd(
 		 * For device private entries, since there are no
 		 * read exclusive entries, writable = !readable
 		 */
-		if (softleaf_is_device_private_write(entry)) {
+		if (softleaf_is_device_private_write(entry) &&
+		    vma_is_cow_mapping(src_vma)) {
 			entry = make_readable_device_private_entry(swp_offset(entry));
 			pmd = softleaf_to_pmd(entry);
 
@@ -1942,7 +1944,6 @@ static void copy_huge_non_present_pmd(
 			set_pmd_at(src_mm, addr, src_pmd, pmd);
 		}
 
-		src_folio = softleaf_to_folio(entry);
 		VM_WARN_ON(!folio_test_large(src_folio));
 
 		folio_get(src_folio);
@@ -1954,9 +1955,11 @@ static void copy_huge_non_present_pmd(
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
@@ -1972,6 +1975,7 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	pmd_t pmd;
 	pgtable_t pgtable = NULL;
 	int ret = -ENOMEM;
+	bool writable;
 
 	pmd = pmdp_get_lockless(src_pmd);
 	if (unlikely(pmd_present(pmd) && pmd_special(pmd) &&
@@ -1992,13 +1996,11 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
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
@@ -2016,7 +2018,8 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	}
 
 	if (unlikely(!pmd_trans_huge(pmd))) {
-		pte_free(dst_mm, pgtable);
+		if (pgtable)
+			pte_free(dst_mm, pgtable);
 		goto out_unlock;
 	}
 	/*
@@ -2031,13 +2034,30 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		 * copy. It just takes a reference.
 		 */
 		mm_get_huge_zero_folio(dst_mm);
-		goto out_zero_page;
+		goto copy_pmd;
 	}
 
 	src_page = pmd_page(pmd);
 	VM_BUG_ON_PAGE(!PageHead(src_page), src_page);
 	src_folio = page_folio(src_page);
 
+	if (!folio_test_anon(src_folio)) {
+		if (unlikely(folio_ref_count_over_limit(src_folio))) {
+			/*
+			 * VM_MIXEDMAP may contain driver-inserted pages with no
+			 * fault handler to reconstruct the mapping.
+			 */
+			ret = (dst_vma->vm_flags & VM_MIXEDMAP) ? -ENOMEM : 0;
+			if (pgtable)
+				pte_free(dst_mm, pgtable);
+			goto out_unlock;
+		}
+		folio_get(src_folio);
+		folio_dup_file_rmap_pmd(src_folio, src_page, dst_vma);
+		add_mm_counter(dst_mm, mm_counter_file(src_folio),
+			       HPAGE_PMD_NR);
+		goto copy_pmd;
+	}
 	folio_get(src_folio);
 	if (unlikely(folio_try_dup_anon_rmap_pmd(src_folio, src_page, dst_vma, src_vma))) {
 		/* Page maybe pinned: split and retry the fault on PTEs. */
@@ -2049,19 +2069,25 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
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

