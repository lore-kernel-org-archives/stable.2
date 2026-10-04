Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4DA41684B
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 10:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791109117; cv=none; b=H4yJiNHAxE+U3EjKRivfAIvOGMUF+MdN2aOEVPQQWYtCUp0xKNk/ibZFS0UPpu/p89cU81zxjdOUpmvww9ttsoKVgDMTQkkiuxIMPrCkyDzvvSc+FdvwojFxLSLVOHq1oDIknjnyE2unsh4APddZlcFqkUoPixXurJ4l+G+DemY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791109117; c=relaxed/simple;
	bh=eB1l8k4K7oPlY+yBACcpGlwrEX9I7MKEvcn10Xk1rU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BrRZYgLmSvOVbM7Lar7oVvCX1HlqRGPuq5ZnFlSL/HGk0iiqCAW+WQstKNjM8QLJIoMDNW7C1yF7rui3W+LHQ19Omr5U7g8R3FctbGJb659HMty02w2wqXTF/wZhzhBDPAn5HEQSgOGNbR14RZGvCIm2B4f0MQM9HYpPqutLfrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FuhLpAkU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FuhLpAkU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1EFE1F000FF;
	Sun,  4 Oct 2026 10:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791109115;
	bh=8a033Hhyly2M7EdWSwgL7OvDtcDS7yezygXHUsXu95Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FuhLpAkUHQdhKgvz/B+6bjBMCsOyBwZCyMt8dwXEXlUpbcV2zYLhUs7AKKe3KRQa2
	 4B/cvsktCLFUHlcLMg3sEPP4n0hiboV7sY2ppq7YmDbgqhQN0Gc0vrny/7RUq53JZA
	 /8r9mseetPre2eNELEwfcgIp+DQAc9100W3K7tEJFJM7j8flGlP2nM3nQs04gEphab
	 4eBJJcextUNOcaAm8B2IpqUb/mJ8ZRZmPLIv0z2LVjkayynuzKZV4SUujgzyxNFkLw
	 bSF5NaIcWNG4x8O1rNaauafXkxrai8dzEPzQ9j3L1KV1NfueLM6eFEadolqc+PcxzZ
	 BpeROaSQcvqIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baoquan He <bhe@redhat.com>,
	"Chatre, Reinette" <reinette.chatre@intel.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Christian Brauner <brauner@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Dave Martin <dave.martin@arm.com>,
	Dave Young <dyoung@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dmitriy Vyukov <dvyukov@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guo Ren <guoren@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Hugh Dickins <hughd@google.com>,
	James Morse <james.morse@arm.com>,
	Jan Kara <jack@suse.cz>,
	Jann Horn <jannh@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Kevin Tian <kevin.tian@intel.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Liam Howlett <liam.howlett@oracle.com>,
	"Luck, Tony" <tony.luck@intel.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Nicolas Pitre <nico@fluxnic.net>,
	Oscar Salvador <osalvador@suse.de>,
	Robin Murohy <robin.murphy@arm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/5] mm: add remap_pfn_range_prepare(), remap_pfn_range_complete()
Date: Sun,  4 Oct 2026 06:17:53 -0400
Message-ID: <20261004101719.1402752-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004101719.1402752-1-sashal@kernel.org>
References: <2026100329-jaws-trash-1c19@gregkh>
 <20261004101719.1402752-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

[ Upstream commit 51e38e7d40d617965504f4dcba569ecf9302f245 ]

We need the ability to split PFN remap between updating the VMA and
performing the actual remap, in order to do away with the legacy f_op->mmap
hook.

To do so, update the PFN remap code to provide shared logic, and also make
remap_pfn_range_notrack() static, as its one user, io_mapping_map_user()
was removed in commit 9a4f90e24661 ("mm: remove mm/io-mapping.c").

Then, introduce remap_pfn_range_prepare(), which accepts VMA descriptor
and PFN parameters, and remap_pfn_range_complete() which accepts the same
parameters as remap_pfn_rangte().

remap_pfn_range_prepare() will set the cow vma->vm_pgoff if necessary, so
it must be supplied with a correct PFN to do so.

While we're here, also clean up the duplicated #ifdef
__HAVE_PFNMAP_TRACKING check and put into a single #ifdef/#else block.

We keep these internal to mm as they should only be used by internal
helpers.

Link: https://lkml.kernel.org/r/75b55de63249b3aa0fd5b3b08ed1d3ff19255d0d.1760959442.git.lorenzo.stoakes@oracle.com
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Pedro Falcato <pfalcato@suse.de>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Chatre, Reinette <reinette.chatre@intel.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Dave Martin <dave.martin@arm.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Dmitriy Vyukov <dvyukov@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guo Ren <guoren@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: James Morse <james.morse@arm.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Jann Horn <jannh@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: "Luck, Tony" <tony.luck@intel.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Robin Murohy <robin.murphy@arm.com>
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 976d5e0ddac8 ("mm/vma: predicate setting mmap_prepare VMA fields on new vma alloc")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/mm.h |  22 ++++++--
 mm/internal.h      |   4 ++
 mm/memory.c        | 132 ++++++++++++++++++++++++++++++---------------
 3 files changed, 110 insertions(+), 48 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2c0503bbcc190..4d0770d4ae0f8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -492,6 +492,21 @@ extern unsigned int kobjsize(const void *objp);
  */
 #define VM_SPECIAL (VM_IO | VM_DONTEXPAND | VM_PFNMAP | VM_MIXEDMAP)
 
+/*
+ * Physically remapped pages are special. Tell the
+ * rest of the world about it:
+ *   VM_IO tells people not to look at these pages
+ *	(accesses can have side effects).
+ *   VM_PFNMAP tells the core MM that the base pages are just
+ *	raw PFN mappings, and do not have a "struct page" associated
+ *	with them.
+ *   VM_DONTEXPAND
+ *      Disable vma merging and expanding with mremap().
+ *   VM_DONTDUMP
+ *      Omit vma from core dump, even when VM_IO turned off.
+ */
+#define VM_REMAP_FLAGS (VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP)
+
 /* This mask prevents VMA from being scanned with khugepaged */
 #define VM_NO_KHUGEPAGED (VM_SPECIAL | VM_HUGETLB)
 
@@ -3782,10 +3797,9 @@ unsigned long change_prot_numa(struct vm_area_struct *vma,
 
 struct vm_area_struct *find_extend_vma_locked(struct mm_struct *,
 		unsigned long addr);
-int remap_pfn_range(struct vm_area_struct *, unsigned long addr,
-			unsigned long pfn, unsigned long size, pgprot_t);
-int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long addr,
-		unsigned long pfn, unsigned long size, pgprot_t prot);
+int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
+		    unsigned long pfn, unsigned long size, pgprot_t pgprot);
+
 int vm_insert_page(struct vm_area_struct *, unsigned long addr, struct page *);
 int vm_insert_pages(struct vm_area_struct *vma, unsigned long addr,
 			struct page **pages, unsigned long *num);
diff --git a/mm/internal.h b/mm/internal.h
index ef42eee87c7be..2f2466390d1a9 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1666,4 +1666,8 @@ static inline bool reclaim_pt_is_enabled(unsigned long start, unsigned long end,
 void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm);
 int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm);
 
+void remap_pfn_range_prepare(struct vm_area_desc *desc, unsigned long pfn);
+int remap_pfn_range_complete(struct vm_area_struct *vma, unsigned long addr,
+		unsigned long pfn, unsigned long size, pgprot_t pgprot);
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/memory.c b/mm/memory.c
index 72793ec631072..64abfa4df3072 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2914,6 +2914,25 @@ static inline int remap_p4d_range(struct mm_struct *mm, pgd_t *pgd,
 	return 0;
 }
 
+static int get_remap_pgoff(vm_flags_t vm_flags, unsigned long addr,
+		unsigned long end, unsigned long vm_start, unsigned long vm_end,
+		unsigned long pfn, pgoff_t *vm_pgoff_p)
+{
+	/*
+	 * There's a horrible special case to handle copy-on-write
+	 * behaviour that some programs depend on. We mark the "original"
+	 * un-COW'ed pages by matching them up with "vma->vm_pgoff".
+	 * See vm_normal_page() for details.
+	 */
+	if (is_cow_mapping(vm_flags)) {
+		if (addr != vm_start || end != vm_end)
+			return -EINVAL;
+		*vm_pgoff_p = pfn;
+	}
+
+	return 0;
+}
+
 static int remap_pfn_range_internal(struct vm_area_struct *vma, unsigned long addr,
 		unsigned long pfn, unsigned long size, pgprot_t prot)
 {
@@ -2926,31 +2945,7 @@ static int remap_pfn_range_internal(struct vm_area_struct *vma, unsigned long ad
 	if (WARN_ON_ONCE(!PAGE_ALIGNED(addr)))
 		return -EINVAL;
 
-	/*
-	 * Physically remapped pages are special. Tell the
-	 * rest of the world about it:
-	 *   VM_IO tells people not to look at these pages
-	 *	(accesses can have side effects).
-	 *   VM_PFNMAP tells the core MM that the base pages are just
-	 *	raw PFN mappings, and do not have a "struct page" associated
-	 *	with them.
-	 *   VM_DONTEXPAND
-	 *      Disable vma merging and expanding with mremap().
-	 *   VM_DONTDUMP
-	 *      Omit vma from core dump, even when VM_IO turned off.
-	 *
-	 * There's a horrible special case to handle copy-on-write
-	 * behaviour that some programs depend on. We mark the "original"
-	 * un-COW'ed pages by matching them up with "vma->vm_pgoff".
-	 * See vm_normal_page() for details.
-	 */
-	if (is_cow_mapping(vma->vm_flags)) {
-		if (addr != vma->vm_start || end != vma->vm_end)
-			return -EINVAL;
-		vma->vm_pgoff = pfn;
-	}
-
-	vm_flags_set(vma, VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
+	VM_WARN_ON_ONCE((vma->vm_flags & VM_REMAP_FLAGS) != VM_REMAP_FLAGS);
 
 	BUG_ON(addr >= end);
 	pfn -= addr >> PAGE_SHIFT;
@@ -2971,7 +2966,7 @@ static int remap_pfn_range_internal(struct vm_area_struct *vma, unsigned long ad
  * Variant of remap_pfn_range that does not call track_pfn_remap.  The caller
  * must have pre-validated the caching bits of the pgprot_t.
  */
-int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long addr,
+static int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long addr,
 		unsigned long pfn, unsigned long size, pgprot_t prot)
 {
 	int error = remap_pfn_range_internal(vma, addr, pfn, size, prot);
@@ -3016,23 +3011,9 @@ void pfnmap_track_ctx_release(struct kref *ref)
 	pfnmap_untrack(ctx->pfn, ctx->size);
 	kfree(ctx);
 }
-#endif /* __HAVE_PFNMAP_TRACKING */
 
-/**
- * remap_pfn_range - remap kernel memory to userspace
- * @vma: user vma to map to
- * @addr: target page aligned user address to start at
- * @pfn: page frame number of kernel physical memory address
- * @size: size of mapping area
- * @prot: page protection flags for this mapping
- *
- * Note: this is only safe if the mm semaphore is held when called.
- *
- * Return: %0 on success, negative error code otherwise.
- */
-#ifdef __HAVE_PFNMAP_TRACKING
-int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
-		    unsigned long pfn, unsigned long size, pgprot_t prot)
+static int remap_pfn_range_track(struct vm_area_struct *vma, unsigned long addr,
+		unsigned long pfn, unsigned long size, pgprot_t prot)
 {
 	struct pfnmap_track_ctx *ctx = NULL;
 	int err;
@@ -3068,15 +3049,78 @@ int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
 	return err;
 }
 
+static int do_remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
+		unsigned long pfn, unsigned long size, pgprot_t prot)
+{
+	return remap_pfn_range_track(vma, addr, pfn, size, prot);
+}
 #else
-int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
-		    unsigned long pfn, unsigned long size, pgprot_t prot)
+static int do_remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
+		unsigned long pfn, unsigned long size, pgprot_t prot)
 {
 	return remap_pfn_range_notrack(vma, addr, pfn, size, prot);
 }
 #endif
+
+void remap_pfn_range_prepare(struct vm_area_desc *desc, unsigned long pfn)
+{
+	/*
+	 * We set addr=VMA start, end=VMA end here, so this won't fail, but we
+	 * check it again on complete and will fail there if specified addr is
+	 * invalid.
+	 */
+	get_remap_pgoff(desc->vm_flags, desc->start, desc->end,
+			desc->start, desc->end, pfn, &desc->pgoff);
+	desc->vm_flags |= VM_REMAP_FLAGS;
+}
+
+static int remap_pfn_range_prepare_vma(struct vm_area_struct *vma, unsigned long addr,
+		unsigned long pfn, unsigned long size)
+{
+	unsigned long end = addr + PAGE_ALIGN(size);
+	int err;
+
+	err = get_remap_pgoff(vma->vm_flags, addr, end,
+			      vma->vm_start, vma->vm_end,
+			      pfn, &vma->vm_pgoff);
+	if (err)
+		return err;
+
+	vm_flags_set(vma, VM_REMAP_FLAGS);
+	return 0;
+}
+
+/**
+ * remap_pfn_range - remap kernel memory to userspace
+ * @vma: user vma to map to
+ * @addr: target page aligned user address to start at
+ * @pfn: page frame number of kernel physical memory address
+ * @size: size of mapping area
+ * @prot: page protection flags for this mapping
+ *
+ * Note: this is only safe if the mm semaphore is held when called.
+ *
+ * Return: %0 on success, negative error code otherwise.
+ */
+int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
+		    unsigned long pfn, unsigned long size, pgprot_t prot)
+{
+	int err;
+
+	err = remap_pfn_range_prepare_vma(vma, addr, pfn, size);
+	if (err)
+		return err;
+
+	return do_remap_pfn_range(vma, addr, pfn, size, prot);
+}
 EXPORT_SYMBOL(remap_pfn_range);
 
+int remap_pfn_range_complete(struct vm_area_struct *vma, unsigned long addr,
+		unsigned long pfn, unsigned long size, pgprot_t prot)
+{
+	return do_remap_pfn_range(vma, addr, pfn, size, prot);
+}
+
 /**
  * vm_iomap_memory - remap memory to userspace
  * @vma: user vma to map to
-- 
2.53.0

