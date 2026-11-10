Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794343034;
	b=rDc4W/J9qFkP9/lCkkRKz1s/aiD3rTvepY4OCad+7c7CG9FoO1TlmUQDmDnMrMmnNk2/
	 iumfOG/DYcJEcXSg4vewT8Z7HMtK+5Ku4z+2RKMxKT6R/08VyNHndfV+FJDP2pIPPOxqQ
	 WY5i1Y7K5FnLM096E/ovlDfOQH1h7KUrKyou1ZCMQwkOStG4vOH1gFHdZHrRtT1NhtbWX
	 lS+3b++GW1VOAvSGgSaDlrKIZ8tLJpr9kekesaeiOx4RP0B0r6j1gHO6tDwl860YDscl7
	 M9XtjCcpME+Mvas0jO+AOYRAWX3xPAZad5fVoyJqmnQ7ngyCHWMls0hytCwTHTNjlCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343034;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=xNTZGr6LwJ9VWBask5R2cmG6ir5UL6XWI5ZbCADWAis=;
	b=aZIr/m6eP1bOIatBTy3027M+jxxiJ450WOR1zqXq29DjU8qott7l/aZ2DRoizuvZI3LZ
	 onwMeSx9fuCwrbJcU/33vMSeGTqAotKvTEK8hIZ18r+qc6/vkIo2fo3tqpW6Iu0iYq8rg
	 rY+8Hp94aBp1Eyd0D4ifBgk3tSUqCZsx15vHb00VFJpv7UmeN0umYSbXgX/uZFny5nVtg
	 qCLlvxu9O0DZTlyvXp39Eprt6jnpaK7iEfDVoNQ+n56tiaDjRjGN0tgBKS/E1XpFSoauX
	 oATSsMlvY3UcXDo6yKWsn/HlY9SdhcazWLUlmH+xkbCw92kVgi4IFlhm7uBpFuh53WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m5NV3Adl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74FA606A32D;
	Tue, 10 Nov 2026 20:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m5NV3Adl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85511F008A1;
	Tue, 10 Nov 2026 20:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794343033;
	bh=xNTZGr6LwJ9VWBask5R2cmG6ir5UL6XWI5ZbCADWAis=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=m5NV3Adl8ibePw1vBJrSDBrC0oMFNH/giLFB9LVRHMDw94FSo5Vac7V7nlpp+i/VV
	 jELuJ23kqJsTImYSy6xSCSjQF17fZGRnPthS8f0jkp636/AhdoHDjCB2K8S55BDeCL
	 G7juHyLQ44klelkfpEcL2khdpx8hvE7aitu7E7Vh09zI5axEbdlUI+zAR/T4XRXCi1
	 yVJqPNWruFzFU/vrtscyj+vVbFXCOR3hvs7146xiUXXHPJNocqzPHwCfmCNBenpI2Z
	 Q1Qi7YjKKEiWpSGSOLZh6GQ8GxjgvUQWCmVlrm/zY9fS4gQilUEsT7+ve10TpTbeaF
	 GV56VzFwFXbrQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 10 Nov 2026 21:35:41 +0100
Subject: [PATCH v3 1/9] mm: limit pagecache folio refcount when mapping
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
Message-Id: <20261110-refcount_overflow_stable-v3-1-318625d63a98@kernel.org>
References: <20261110-refcount_overflow_stable-v3-0-318625d63a98@kernel.org>
In-Reply-To: <20261110-refcount_overflow_stable-v3-0-318625d63a98@kernel.org>
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
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 fuse-devel@lists.linux.dev, linux-arch@vger.kernel.org, 
 iommu@lists.linux.dev, netdev@vger.kernel.org, 
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16149; i=david@kernel.org;
 h=from:subject:message-id; bh=4E1qNUHNUoCXmx1L2cz73tlemUJyAMlnGJzNIaiYGRM=;
 b=owGbwMvMwCF2QOXvyb15Z08znlZLYsj63BB+e9XrDT+WnFv+PGr5t4mOLSmL3tjfC/ngxuy4P
 /KEz/z7FR2lLAxiHAyyYoos19blpAavaXUsizJ0g5nDygQyhIGLUwAmkuHP8L8mSWP2v6l6At+Z
 Hy+OU+m7lnIm/GH/Pfc8v3C5lU23TvMx/GLKVDmXoB86Z5ajkVLcMQHtm97xYtllk3yPTekKebt
 HjBcA
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

Start reporting SIGBUS if we run into limits. When restoring mappings
from migration entries, instead zap the pte/pmd entry. We allow for
slightly exceeding the limit to keep things simpler.

During fork(), prefer not copying page table entries over failing fork.
Export __folio_ref_count_over_limit() right away as that will be needed
from fuse code next. Use has_capability_noaudit(current, CAP_SYS_RESOURCE),
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

Adjust the check folio_get() to just check for invalid refcounts and
drop folio_ref_zero_or_close_to_overflow(): we really don't want
negative refcounts or negative mapcounts. Convert to VM_WARN_ON_FOLIO as
we touch it.

Also, just document -EHWPOISON for copy_present_ptes() while at it.

Note: When zapping file migration entries, uffd-wp is preserved using PTE
markers, but uffd-rwp protection is lost because there is no corresponding
marker. try_to_unmap() already has the same problem when unmapping file
folios, so we'll happily ignore it.

Note2: For now we don't let migration or PTE table collapse exceed any
limits. Admins can always refault, and if we are already operating in
admin reserves, something is already off.

Reported-by: Chris Mason <mason@kernel.org>
Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
Cc: stable@vger.kernel.org
Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
Acked-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/mm.h | 35 +++++++++++++++++++++++++++++++----
 mm/filemap.c       |  6 ++++++
 mm/huge_memory.c   | 29 +++++++++++++++++++++++++++--
 mm/memory.c        | 33 +++++++++++++++++++++++++++++----
 mm/migrate.c       | 11 +++++++++++
 mm/userfaultfd.c   |  4 ++++
 mm/util.c          | 18 ++++++++++++++++++
 7 files changed, 126 insertions(+), 10 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e6da76fbe8e83..6c7c29a086bd1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2229,9 +2229,36 @@ vm_fault_t finish_fault(struct vm_fault *vmf);
  *   back into memory.
  */
 
-/* 127: arbitrary random number, small enough to assemble well */
-#define folio_ref_zero_or_close_to_overflow(folio) \
-	((unsigned int) folio_ref_count(folio) + 127u <= 127u)
+/* Leave separate reserves for administrators and concurrent reference gains. */
+#define FOLIO_REF_COUNT_LIMIT		(INT_MAX - (1U << 26))
+#define FOLIO_REF_COUNT_ADMIN_LIMIT	(INT_MAX - (1U << 25))
+
+bool __folio_ref_count_over_limit(unsigned int ref_count);
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
+	return __folio_ref_count_over_limit(ref_count);
+}
 
 /**
  * folio_get - Increment the reference count on a folio.
@@ -2243,7 +2270,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf);
  */
 static inline void folio_get(struct folio *folio)
 {
-	VM_BUG_ON_FOLIO(folio_ref_zero_or_close_to_overflow(folio), folio);
+	VM_WARN_ON_FOLIO(folio_ref_count(folio) <= 0, folio);
 	folio_ref_inc(folio);
 }
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 9871b4f32a916..0f6d57432a7e5 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3968,6 +3968,11 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		unsigned long end;
 		vm_fault_t map_ret;
 
+		if (unlikely(folio_ref_count_over_limit(folio))) {
+			folio_ref_dec(folio);
+			goto next;
+		}
+
 		addr += (xas.xa_index - last_pgoff) << PAGE_SHIFT;
 		vmf->pte += xas.xa_index - last_pgoff;
 		last_pgoff = xas.xa_index;
@@ -4009,6 +4014,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 					   mmap_miss - 1);
 		}
 
+next:
 		folio_unlock(folio);
 	} while ((folio = next_uptodate_folio(&xas, mapping, end_pgoff)) != NULL);
 	add_mm_counter(vma->vm_mm, folio_type, rss);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 4608540e40d46..439cfe446cea4 100644
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
@@ -2093,6 +2103,11 @@ int copy_huge_pud(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 	if (page) {
 		struct folio *folio = page_folio(page);
 
+		if (unlikely(folio_ref_count_over_limit(folio))) {
+			/* Skip this PUD; it can be faulted in later. */
+			ret = (dst_vma->vm_flags & VM_MIXEDMAP) ? -ENOMEM : 0;
+			goto out_unlock;
+		}
 		folio_get(folio);
 		/*
 		 * TODO: once we support anonymous pages, use
@@ -5223,6 +5238,16 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct folio *folio
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
index c9d64170e47ab..977e037388963 100644
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
@@ -1186,6 +1189,16 @@ copy_present_ptes(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 
 	folio = page_folio(page);
 
+	if (!folio_test_anon(folio) && unlikely(folio_ref_count_over_limit(folio))) {
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
@@ -1367,9 +1380,9 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
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
@@ -1399,7 +1412,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 			goto out;
 		}
 		entry.val = 0;
-	} else if (ret == -EBUSY || unlikely(ret == -EHWPOISON)) {
+	} else if (ret == -EBUSY || ret == -ENOMEM || unlikely(ret == -EHWPOISON)) {
 		goto out;
 	} else if (ret ==  -EAGAIN) {
 		prealloc = folio_prealloc(src_mm, src_vma, addr, false);
@@ -2474,6 +2487,8 @@ static int insert_page_into_pte_locked(struct vm_area_struct *vma, pte_t *pte,
 	if (unlikely(is_zero_folio(folio))) {
 		pteval = pte_mkspecial(pteval);
 	} else {
+		if (unlikely(folio_ref_count_over_limit(folio)))
+			return -EOVERFLOW;
 		folio_get(folio);
 		pteval = mk_pte(page, prot);
 		if (mkwrite) {
@@ -5754,6 +5769,9 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *pa
 	if (unlikely(folio_test_has_hwpoisoned(folio)))
 		return ret;
 
+	if (unlikely(folio_ref_count_over_limit(folio)))
+		return VM_FAULT_SIGBUS;
+
 	/*
 	 * Archs like ppc64 need additional space to store information
 	 * related to pte entry. Use the preallocated table for that.
@@ -5816,6 +5834,9 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *pa
  * @page: The first page to create a PTE for.
  * @nr: The number of PTEs to create.
  * @addr: The first address to create a PTE for.
+ *
+ * For file mappings, the caller must check folio_ref_count_over_limit()
+ * before installing PTEs.
  */
 void set_pte_range(struct vm_fault *vmf, struct folio *folio,
 		struct page *page, unsigned int nr, unsigned long addr)
@@ -5982,6 +6003,10 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
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
index 80f6c714844f2..a5140b3b70f33 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -791,6 +791,24 @@ int folio_mc_copy(struct folio *dst, struct folio *src)
 }
 EXPORT_SYMBOL(folio_mc_copy);
 
+bool __folio_ref_count_over_limit(unsigned int ref_count)
+{
+	if (ref_count >= FOLIO_REF_COUNT_ADMIN_LIMIT)
+		return true;
+	/* Background threads must not consume admin reserves. */
+	if (current->flags & PF_KTHREAD)
+		return true;
+	/* Neither must interrupt contexts on behalf of the interrupted task. */
+	if (!in_task())
+		return true;
+	/* Capability checks are not safe with IRQs disabled. */
+	if (irqs_disabled())
+		return true;
+	/* Use the task's credentials, which filesystem overrides cannot change. */
+	return !has_capability_noaudit(current, CAP_SYS_RESOURCE);
+}
+EXPORT_SYMBOL_GPL(__folio_ref_count_over_limit);
+
 int sysctl_overcommit_memory __read_mostly = OVERCOMMIT_GUESS;
 static int sysctl_overcommit_ratio __read_mostly = 50;
 static unsigned long sysctl_overcommit_kbytes __read_mostly;

-- 
2.56.0

