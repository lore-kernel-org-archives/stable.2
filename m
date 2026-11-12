Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794524045;
	b=A2yFh7rSSJA8zVveF35jXKDOmd61S5pOr+LI2JFG/9nmNCzBRMGGQTIhu9vQsLW2N9CX
	 UMTQiJeZWxUVu+hTbnPE59y5IZ8t5gvYLz+0dJHXacU/wUv6Sd3GNguNej5Rvu4qZejmW
	 zWYjOJDUCibv6V8LPteSrBujmGU6xgrCK6dEjaBTjFuu8rS2HXKBe5tKqdt2ZoiC1GAWt
	 eiWOkpQr9NJ3t3FsIKN/XZOouD1skkxz0zt7tsbMiGNwdyeM0+I9JKoFLbphKhTPK+rX8
	 zXPZmAmmw8OIj+t8KT/RHdldTCAvPDSCtgwntPkvLT/LPSjDtuSHlRdu6GEBpLaoc4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794524045;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=XRWexksSGVBtQgh17cLt27gB89pNrvzfWCrkmq77oy8=;
	b=QfPyltaZWBM16lS/YI+mndFj2dlV9s763GOk5+LmhlOQXSiYidz5o7f7hyExguyCDrik
	 lZbYcE9+vkPs4ksYBn9oeiNrboP36lXRUrhRjkSkNYnVKz4M8+/c6IghXCCNdeu0MQPBh
	 PRe1b7OY5Bj6AhjTf40RYDtzVq8qW/XntDN88ab1QFQyG2HO/PCyzhzz7WwYhFLHr/tvu
	 apJAy1dAqn1eUADlofdbFKrWat0vjP2+8XZqDFGvXsnTxSJDDrtv1/sqt9EAhEmoFmiOt
	 0uqG3ym5MTSrlQ8nFWDNKsj5j2/E/KMESxFW+0mpRdxoaULCyc+ifYBU7Roj6+TTGTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XsoJi6Xc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E311B606A31C;
	Thu, 12 Nov 2026 22:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XsoJi6Xc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FCE11F000C4;
	Thu, 12 Nov 2026 22:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794524044;
	bh=XRWexksSGVBtQgh17cLt27gB89pNrvzfWCrkmq77oy8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XsoJi6Xc7nhe5oHz4REc5QujzxsiNQuyqwL7o1i6mn1TKTQqborbT4uwm9KfSWT7A
	 xJG6Oj0n9pQM3jJtnjAIaGCscpOTOtWxAMkjeAuSodFtcjXlGNGS1L12v/FzasTstI
	 gChWtbQGAjKOo9/4B1iW6ZPGEvrVSxLNx0WimFRK3vBKjCWkmIPCr00l8hotXSqOwF
	 5wSL85WW5Y2FBXm6Iv4l7NvYu+reTuiJNYCuHupfEXeGD/XVaiGjEin4qIn6E2LFya
	 QAxSLGb58ExtXtPPf/om9R1nBOUsqbPdjoTRFoZwN3REqMrz2aaV7HurPYljs1l/tL
	 D6rxJxjyLIZZw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 12 Nov 2026 23:53:20 +0100
Subject: [PATCH v4 1/9] mm: limit pagecache folio refcount when mapping
 pages
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
Message-Id: <20261112-refcount_overflow_stable-v4-1-ad3deef0bd23@kernel.org>
References: <20261112-refcount_overflow_stable-v4-0-ad3deef0bd23@kernel.org>
In-Reply-To: <20261112-refcount_overflow_stable-v4-0-ad3deef0bd23@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Song Liu <songliubraving@fb.com>, 
 Rik van Riel <riel@surriel.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Hugh Dickins <hughd@google.com>, 
 Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Kevin Tian <kevin.tian@intel.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Steve Sistare <steven.sistare@oracle.com>, 
 John Hubbard <jhubbard@nvidia.com>, 
 "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 fuse-devel@lists.linux.dev, linux-arch@vger.kernel.org, 
 iommu@lists.linux.dev, netdev@vger.kernel.org, 
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org, 
 Pedro Falcato <pfalcato@suse.de>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16439; i=david@kernel.org;
 h=from:subject:message-id; bh=9LU6mD9Hv245VOuCjcR6bLedSqjMVPGJJUdJmnIWLkQ=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLK+OWeeXej/J8bmPXf99zlxPJm9Zl/OZN06nMATv8D1v
 pjOZl/njlIWBjEOBlkxRZag4PsGL1+uq61242OGmcPKBDKEgYtTACayvJuRYVqFV/gmkRtqk1Z0
 nJfyulOdsv/wP65uJ3+5uVkZ2oGFaYwMB0Q23inf8Npprv2en2Xzb136q7H1we2uqzEhvj//PlC
 NZgIA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

With large file folios, overflowing the folio mapcount and refcount
became possible more easily. For anon folios it is currently not really
an issue: each large anon folio can only be mapped once into a process; on
4k kernels it would be more processes than usually allowed on a system,
and on 16k or 64k kernels the processes alone would consume hundreds of
GiB. Something to be sorted out at some point, but it's not as urgent.

Being able to overflow the refcount is not really big news, but it's about
time that we do something about it because some modern technology might
find ways to abuse it :)

One of the enablers for that was commit ddc58f27f9ee ("mm: drop tail page
refcounting"), however, file thp support was added later.

File folios can be mapped multiple times into the same process, allowing
for processes to hold many references to the same folio.

As a short-term solution, let's introduce two folio refcount limits:
one for ordinary consumers and one for admins. Leave some headroom
before the refcount goes negative, which we really don't want (having
the mapcount go negative is also not expected).

Start reporting SIGBUS and a ratelimited warning if we run into limits.
When restoring mappings from migration entries, instead zap the pte/pmd
entry. We allow for slightly exceeding the limit to keep things simpler.

During fork(), prefer not copying page table entries over failing fork.
For fault-around, check in next_uptodate_folio() before trying to lock
the folio.

Export folio_ref_count_over_limit_slowpath() using EXPORT_SYMBOL_GPL
right away so modules can use it through try_get_page(), where we will
use it next.

Use has_capability_noaudit(current, CAP_SYS_RESOURCE),
so filesystem credential overrides do not affect access to the admin
reserve, and to not generate auditing messages simply because we access
optional reserves.

Don't grant access to the admin reserve from kernel threads, from
interrupt context, where "current" is just the interrupted task, or with
IRQs disabled, as even unaudited capability checks can take locks.

This is far from ideal, but better than all easy alternatives we can
backport comfortably. For now it fixes the big problem: letting
the refcount (+mapcount) go negative and cause trouble.

This is only a temporary fix. Keep the mapping checks explicit and
separate from reference acquisition: most are expected to disappear when
we rework the underlying refcounting.

Check order 0 folios as well for consistency: each
folio_add_file_rmap*() and folio_dup_file_rmap*() needs a prior check.

Adjust the check in folio_get() to just check for invalid refcounts and
drop folio_ref_zero_or_close_to_overflow(): we really don't want
negative refcounts or negative mapcounts. Convert to VM_WARN_ON_FOLIO as
we touch it.

Also, just document -EHWPOISON for copy_present_ptes() while at it.

Note: When zapping file migration entries, uffd-wp is preserved using PTE
markers, but uffd-rwp protection is lost because there is no corresponding
marker. try_to_unmap() already has the same problem when unmapping file
folios, so we'll happily ignore it.

Reported-by: Chris Mason <mason@kernel.org>
Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
Cc: stable@vger.kernel.org
Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
Acked-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/mm.h | 36 ++++++++++++++++++++++++++++++++----
 mm/filemap.c       |  2 ++
 mm/huge_memory.c   | 32 ++++++++++++++++++++++++++++++--
 mm/memory.c        | 37 +++++++++++++++++++++++++++++++++----
 mm/migrate.c       | 11 +++++++++++
 mm/userfaultfd.c   |  4 ++++
 mm/util.c          | 26 ++++++++++++++++++++++++++
 7 files changed, 138 insertions(+), 10 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e6da76fbe8e83..9b247bebeda2c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2229,9 +2229,37 @@ vm_fault_t finish_fault(struct vm_fault *vmf);
  *   back into memory.
  */
 
-/* 127: arbitrary random number, small enough to assemble well */
-#define folio_ref_zero_or_close_to_overflow(folio) \
-	((unsigned int) folio_ref_count(folio) + 127u <= 127u)
+/* Leave separate reserves for administrators and concurrent reference gains. */
+#define FOLIO_REF_COUNT_LIMIT		(INT_MAX - (1U << 26))
+#define FOLIO_REF_COUNT_ADMIN_LIMIT	(INT_MAX - (1U << 25))
+
+bool folio_ref_count_over_limit_slowpath(const struct folio *folio,
+		unsigned int ref_count);
+
+/**
+ * folio_ref_count_over_limit - Check whether to refuse more folio references.
+ * @folio: The folio.
+ *
+ * Check before adding page table mappings or other significant refcount users
+ * to pagecache folios (!hugetlb), either before acquiring references or
+ * afterwards with rollback if the operation is refused.
+ *
+ * Checking other folios does no harm.
+ *
+ * This check is an approximation; we leave some headroom such that concurrent
+ * increments, batches, temporary references, or other bounded refcount
+ * consumers are not a problem.
+ *
+ * Return: True if the caller should refuse the operation, false otherwise.
+ */
+static inline bool folio_ref_count_over_limit(const struct folio *folio)
+{
+	const unsigned int ref_count = folio_ref_count(folio);
+
+	if (likely(ref_count < FOLIO_REF_COUNT_LIMIT))
+		return false;
+	return folio_ref_count_over_limit_slowpath(folio, ref_count);
+}
 
 /**
  * folio_get - Increment the reference count on a folio.
@@ -2243,7 +2271,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf);
  */
 static inline void folio_get(struct folio *folio)
 {
-	VM_BUG_ON_FOLIO(folio_ref_zero_or_close_to_overflow(folio), folio);
+	VM_WARN_ON_FOLIO(folio_ref_count(folio) <= 0, folio);
 	folio_ref_inc(folio);
 }
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 9871b4f32a916..78f86f1daefe4 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3774,6 +3774,8 @@ static struct folio *next_uptodate_folio(struct xa_state *xas,
 			continue;
 		if (!folio_try_get(folio))
 			continue;
+		if (unlikely(folio_ref_count_over_limit(folio)))
+			goto skip;
 		if (folio_test_locked(folio))
 			goto skip;
 		/* Has the page moved or been split? */
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 4608540e40d46..e4a7b4e0b6225 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1626,6 +1626,7 @@ static vm_fault_t insert_pmd(struct vm_area_struct *vma, unsigned long addr,
 {
 	struct mm_struct *mm = vma->vm_mm;
 	pgtable_t pgtable = NULL;
+	vm_fault_t ret = VM_FAULT_NOPAGE;
 	spinlock_t *ptl;
 	pmd_t entry;
 
@@ -1662,6 +1663,10 @@ static vm_fault_t insert_pmd(struct vm_area_struct *vma, unsigned long addr,
 		if (is_huge_zero_folio(fop.folio)) {
 			entry = pmd_mkspecial(entry);
 		} else {
+			if (unlikely(folio_ref_count_over_limit(fop.folio))) {
+				ret = VM_FAULT_SIGBUS;
+				goto out_unlock;
+			}
 			folio_get(fop.folio);
 			folio_add_file_rmap_pmd(fop.folio, &fop.folio->page, vma);
 			add_mm_counter(mm, mm_counter_file(fop.folio), HPAGE_PMD_NR);
@@ -1688,7 +1693,7 @@ static vm_fault_t insert_pmd(struct vm_area_struct *vma, unsigned long addr,
 	spin_unlock(ptl);
 	if (pgtable)
 		pte_free(mm, pgtable);
-	return VM_FAULT_NOPAGE;
+	return ret;
 }
 
 /**
@@ -1758,6 +1763,7 @@ static vm_fault_t insert_pud(struct vm_area_struct *vma, unsigned long addr,
 		pud_t *pud, struct folio_or_pfn fop, pgprot_t prot, bool write)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	vm_fault_t ret = VM_FAULT_NOPAGE;
 	spinlock_t *ptl;
 	pud_t entry;
 
@@ -1783,6 +1789,10 @@ static vm_fault_t insert_pud(struct vm_area_struct *vma, unsigned long addr,
 	if (fop.is_folio) {
 		entry = folio_mk_pud(fop.folio, vma->vm_page_prot);
 
+		if (unlikely(folio_ref_count_over_limit(fop.folio))) {
+			ret = VM_FAULT_SIGBUS;
+			goto out_unlock;
+		}
 		folio_get(fop.folio);
 		folio_add_file_rmap_pud(fop.folio, &fop.folio->page, vma);
 		add_mm_counter(mm, mm_counter_file(fop.folio), HPAGE_PUD_NR);
@@ -1798,7 +1808,7 @@ static vm_fault_t insert_pud(struct vm_area_struct *vma, unsigned long addr,
 	update_mmu_cache_pud(vma, addr, pud);
 out_unlock:
 	spin_unlock(ptl);
-	return VM_FAULT_NOPAGE;
+	return ret;
 }
 
 /**
@@ -2093,6 +2103,14 @@ int copy_huge_pud(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 	if (page) {
 		struct folio *folio = page_folio(page);
 
+		if (unlikely(folio_ref_count_over_limit(folio))) {
+			/*
+			 * VM_MIXEDMAP may contain driver-inserted pages with no
+			 * fault handler to reconstruct the mapping.
+			 */
+			ret = (dst_vma->vm_flags & VM_MIXEDMAP) ? -ENOMEM : 0;
+			goto out_unlock;
+		}
 		folio_get(folio);
 		/*
 		 * TODO: once we support anonymous pages, use
@@ -5223,6 +5241,16 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct folio *folio
 	if (!(pvmw->pmd && !pvmw->pte))
 		return;
 
+	if (!folio_test_anon(folio) && unlikely(folio_ref_count_over_limit(folio))) {
+		/* Leave the file mapping absent so it can be faulted in. */
+		pmd_clear(pvmw->pmd);
+		if (arch_needs_pgtable_deposit())
+			zap_deposited_table(mm, pvmw->pmd);
+		update_hiwater_rss(mm);
+		add_mm_counter(mm, mm_counter_file(folio), -HPAGE_PMD_NR);
+		return;
+	}
+
 	entry = softleaf_from_pmd(*pvmw->pmd);
 	folio_get(folio);
 	pmde = folio_mk_pmd(folio, READ_ONCE(vma->vm_page_prot));
diff --git a/mm/memory.c b/mm/memory.c
index c9d64170e47ab..f473df474f1b8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1168,7 +1168,10 @@ static __always_inline void __copy_present_ptes(struct vm_area_struct *dst_vma,
  * consecutive pages of the same folio by copying them as well.
  *
  * Returns -EAGAIN if one preallocated page is required to copy the next PTE.
- * Otherwise, returns the number of copied PTEs (at least 1).
+ * Returns -ENOMEM if the file folio refcount is too high and the PTE must
+ * be copied.
+ * Returns -EHWPOISON if copying a page fails.
+ * Otherwise, returns the number of processed PTEs (at least 1).
  */
 static inline int
 copy_present_ptes(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
@@ -1186,6 +1189,20 @@ copy_present_ptes(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 
 	folio = page_folio(page);
 
+	if (!folio_test_anon(folio) && unlikely(folio_ref_count_over_limit(folio))) {
+		/*
+		 * VM_MIXEDMAP may contain pages inserted by a driver at mmap
+		 * time, with no fault handler to restore a missing PTE.
+		 */
+		if (dst_vma->vm_flags & VM_MIXEDMAP)
+			return -ENOMEM;
+		if (userfaultfd_pte_rwp(dst_vma, pte))
+			return -ENOMEM;
+		/* Preserve uffd-wp protection when faulting the page back in. */
+		cond_install_uffd_wp_ptes(dst_vma, addr, dst_pte, pte, 1);
+		return 1;
+	}
+
 	/*
 	 * If we likely have to copy, just don't bother with batching. Make
 	 * sure that the common "small folio" case is as fast as possible
@@ -1367,9 +1384,9 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		/*
 		 * If we need a pre-allocated page for this pte, drop the
 		 * locks, allocate, and try again.
-		 * If copy failed due to hwpoison in source page, break out.
+		 * Other errors abort the copy after releasing the page table locks.
 		 */
-		if (unlikely(ret == -EAGAIN || ret == -EHWPOISON))
+		if (unlikely(ret < 0))
 			break;
 		if (unlikely(prealloc)) {
 			/*
@@ -1399,7 +1416,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 			goto out;
 		}
 		entry.val = 0;
-	} else if (ret == -EBUSY || unlikely(ret == -EHWPOISON)) {
+	} else if (ret == -EBUSY || ret == -ENOMEM || unlikely(ret == -EHWPOISON)) {
 		goto out;
 	} else if (ret ==  -EAGAIN) {
 		prealloc = folio_prealloc(src_mm, src_vma, addr, false);
@@ -2474,6 +2491,8 @@ static int insert_page_into_pte_locked(struct vm_area_struct *vma, pte_t *pte,
 	if (unlikely(is_zero_folio(folio))) {
 		pteval = pte_mkspecial(pteval);
 	} else {
+		if (unlikely(folio_ref_count_over_limit(folio)))
+			return -EOVERFLOW;
 		folio_get(folio);
 		pteval = mk_pte(page, prot);
 		if (mkwrite) {
@@ -5754,6 +5773,9 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *pa
 	if (unlikely(folio_test_has_hwpoisoned(folio)))
 		return ret;
 
+	if (unlikely(folio_ref_count_over_limit(folio)))
+		return VM_FAULT_SIGBUS;
+
 	/*
 	 * Archs like ppc64 need additional space to store information
 	 * related to pte entry. Use the preallocated table for that.
@@ -5816,6 +5838,9 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *pa
  * @page: The first page to create a PTE for.
  * @nr: The number of PTEs to create.
  * @addr: The first address to create a PTE for.
+ *
+ * For file mappings, the caller must check folio_ref_count_over_limit()
+ * before installing PTEs.
  */
 void set_pte_range(struct vm_fault *vmf, struct folio *folio,
 		struct page *page, unsigned int nr, unsigned long addr)
@@ -5982,6 +6007,10 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 		goto fallback;
 	}
 
+	if (!is_cow && unlikely(folio_ref_count_over_limit(folio))) {
+		ret = VM_FAULT_SIGBUS;
+		goto unlock;
+	}
 	folio_ref_add(folio, nr_pages - 1);
 	set_pte_range(vmf, folio, page, nr_pages, addr);
 	type = is_cow ? MM_ANONPAGES : mm_counter_file(folio);
diff --git a/mm/migrate.c b/mm/migrate.c
index a5ac7192f0578..e241a594c3eed 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -385,6 +385,17 @@ static bool remove_migration_pte(struct folio *folio,
 		    try_to_map_unused_to_zeropage(&pvmw, folio, old_pte, idx))
 			continue;
 
+		if (!folio_test_anon(folio) && !folio_test_hugetlb(folio) &&
+		    unlikely(folio_ref_count_over_limit(folio))) {
+			/* File contents remain available for a later fault. */
+			pte_clear(vma->vm_mm, pvmw.address, pvmw.pte);
+			cond_install_uffd_wp_ptes(vma, pvmw.address,
+						  pvmw.pte, old_pte, 1);
+			update_hiwater_rss(vma->vm_mm);
+			dec_mm_counter(vma->vm_mm, mm_counter_file(folio));
+			continue;
+		}
+
 		folio_get(folio);
 		new = folio_page(folio, idx);
 		pte = mk_pte(new, READ_ONCE(vma->vm_page_prot));
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 169f681f9849b..89853c157fa91 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -373,6 +373,10 @@ static int mfill_atomic_install_pte(pmd_t *dst_pmd,
 		goto out_unlock;
 
 	if (page_in_cache) {
+		if (unlikely(folio_ref_count_over_limit(folio))) {
+			ret = -ENOMEM;
+			goto out_unlock;
+		}
 		folio_add_file_rmap_pte(folio, page, dst_vma);
 	} else {
 		folio_add_new_anon_rmap(folio, dst_vma, dst_addr, RMAP_EXCLUSIVE);
diff --git a/mm/util.c b/mm/util.c
index 80f6c714844f2..c9c3dc4b490fa 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -791,6 +791,32 @@ int folio_mc_copy(struct folio *dst, struct folio *src)
 }
 EXPORT_SYMBOL(folio_mc_copy);
 
+bool folio_ref_count_over_limit_slowpath(const struct folio *folio,
+		unsigned int ref_count)
+{
+	if (ref_count >= FOLIO_REF_COUNT_ADMIN_LIMIT)
+		goto over_limit;
+	/* Background threads must not consume admin reserves. */
+	if (current->flags & PF_KTHREAD)
+		goto over_limit;
+	/* Neither must interrupt contexts on behalf of the interrupted task. */
+	if (!in_task())
+		goto over_limit;
+	/* Capability checks are not safe with IRQs disabled. */
+	if (irqs_disabled())
+		goto over_limit;
+	/* Use the task's credentials, which filesystem overrides cannot change. */
+	if (has_capability_noaudit(current, CAP_SYS_RESOURCE))
+		return false;
+
+over_limit:
+	pr_warn_ratelimited("folio:%p refcount:%d mapcount:%d mapping:%p reached refcount limit\n",
+			    folio, (int)ref_count, folio_mapcount(folio),
+			    folio_mapping(folio));
+	return true;
+}
+EXPORT_SYMBOL_GPL(folio_ref_count_over_limit_slowpath);
+
 int sysctl_overcommit_memory __read_mostly = OVERCOMMIT_GUESS;
 static int sysctl_overcommit_ratio __read_mostly = 50;
 static unsigned long sysctl_overcommit_kbytes __read_mostly;

-- 
2.56.0

