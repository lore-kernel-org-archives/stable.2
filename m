Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD72256B855
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790095343; cv=none; b=PXT+1PH9jiAXzcVCI7lKco/KR1quRhhwBL72f1BSlVjCub6Oe35/Pfb2Fx62c/Km3KVGybh32Ri1YON/ykX0pjqLttqeXGke3WD/410kAyfEf5SakSzXqcFfIYFvmxUNyXHDhu85KJyLEpYutfrJTOr8eV5A5+alJ05E8cIT4lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790095343; c=relaxed/simple;
	bh=C5UyZCRIOirhZrxo5A9GDkxh5QM0gMc3FH8Vfho3Z70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z5Q2gqJRMcklGCejzANaBZG9tt2HDvp/CHiX4ECYxLV+YJovJf5poyf27V3hLdFw+nwZOEBD5z2eGLIsHTLNdZMdNNJfSASfj5sBPJluLNdP3/AnUIn0zZ4fclCw92cjpliAN23fNuqr2a73bi32zPg0Ld9injFWTS+EJumDLHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/ZnVzPL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/ZnVzPL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726BD1F00893;
	Tue, 22 Sep 2026 16:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790095341;
	bh=dehDZ0X5VTPDT0cvVEwUy9UimSjJT189oYDDJNqff5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g/ZnVzPL4l5ncqBkUxdjh1zUjNfi9ISBu8PonletDJv96KLNGqjN0l/ansGGlG0Xi
	 Sp6XwyA8sUKvEGsBxiQoTI4g0h4GBYZTvQrwbJvrq2Xu3Rs7vqeq3XFR93vxolx/qR
	 S84swrqexgg/trNVVl9oMTfJ/WqJXJ8Fmtc6j76rXLApa5FBHE9dNXB9gNrpDxJ1Be
	 s2zID1vy/xJ2eQRG16eVN34Q82s1IEMa0fvxde/m3GQ1XJ5eBdzTlkNpZDYHnPqtOm
	 8n79SyeQQQnvWw7o3L+r+G4prcnfjIiI6kcwXY3yFi0uBj+e/wcyMoOi5IkW2TQXt9
	 v7ynvnRk59IHg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Jann Horn <jannh@google.com>,
	Liam Howlett <liam.howlett@oracle.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Hocko <mhocko@suse.com>,
	Muchun Song <muchun.song@linux.dev>,
	Nicholas Piggin <npiggin@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] mm: move vma_kernel_pagesize() from hugetlb to mm.h
Date: Tue, 22 Sep 2026 12:42:16 -0400
Message-ID: <20260922164218.3108158-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092210-parabola-undercut-a08b@gregkh>
References: <2026092210-parabola-undercut-a08b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "David Hildenbrand (Arm)" <david@kernel.org>

[ Upstream commit 341ffe82a7a3a1e0756b58999405b6df0c2b3e8d ]

Patch series "mm: move vma_(kernel|mmu)_pagesize() out of hugetlb.c", v2.

Looking into vma_(kernel|mmu)_pagesize(), I realized that there is one
scenario where DAX would not do the right thing when the kernel is not
compiled with hugetlb support.

Without hugetlb support, vma_(kernel|mmu)_pagesize() will always return
PAGE_SIZE instead of using the ->pagesize() result provided by dax-device
code.

Fix that by moving vma_kernel_pagesize() to core MM code, where it
belongs.  I don't think this is stable material, but am not 100% sure.

Also, move vma_mmu_pagesize() while at it.  Remove the unnecessary
hugetlb.h inclusion from KVM code.

This patch (of 4):

In the past, only hugetlb had special "vma_kernel_pagesize()"
requirements, so it provided its own implementation.

In commit 05ea88608d4e ("mm, hugetlbfs: introduce ->pagesize() to
vm_operations_struct") we generalized that approach by providing a
vm_ops->pagesize() callback to be used by device-dax.

Once device-dax started using that callback in commit c1d53b92b95c
("device-dax: implement ->pagesize() for smaps to report MMUPageSize") it
was missed that CONFIG_DEV_DAX does not depend on hugetlb support.

So building a kernel with CONFIG_DEV_DAX but without CONFIG_HUGETLBFS
would not pick up that value.

Fix it by moving vma_kernel_pagesize() to mm.h, providing only a single
implementation.  While at it, improve the kerneldoc a bit.

Ideally, we'd move vma_mmu_pagesize() as well to the header.  However, its
__weak symbol might be overwritten by a PPC variant in hugetlb code.  So
let's leave it in there for now, as it really only matters for some
hugetlb oddities.

This was found by code inspection.

Link: https://lkml.kernel.org/r/20260309151901.123947-1-david@kernel.org
Link: https://lkml.kernel.org/r/20260309151901.123947-2-david@kernel.org
Fixes: c1d53b92b95c ("device-dax: implement ->pagesize() for smaps to report MMUPageSize")
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: e384abeb559d ("mm/huge_memory: bypass THP tuneables for huge pfnmap mappings")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/hugetlb.h |  7 -------
 include/linux/mm.h      | 20 ++++++++++++++++++++
 mm/hugetlb.c            | 17 -----------------
 3 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index ca6d6eb817118..228433226da5a 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -767,8 +767,6 @@ static inline unsigned long huge_page_size(const struct hstate *h)
 	return (unsigned long)PAGE_SIZE << h->order;
 }
 
-extern unsigned long vma_kernel_pagesize(struct vm_area_struct *vma);
-
 extern unsigned long vma_mmu_pagesize(struct vm_area_struct *vma);
 
 static inline unsigned long huge_page_mask(struct hstate *h)
@@ -1184,11 +1182,6 @@ static inline unsigned long huge_page_mask(struct hstate *h)
 	return PAGE_MASK;
 }
 
-static inline unsigned long vma_kernel_pagesize(struct vm_area_struct *vma)
-{
-	return PAGE_SIZE;
-}
-
 static inline unsigned long vma_mmu_pagesize(struct vm_area_struct *vma)
 {
 	return PAGE_SIZE;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 50710a5d4a05f..68db847e85bd3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1020,6 +1020,26 @@ static inline bool vma_is_shared_maywrite(const struct vm_area_struct *vma)
 	return is_shared_maywrite(vma->vm_flags);
 }
 
+/**
+ * vma_kernel_pagesize - Default page size granularity for this VMA.
+ * @vma: The user mapping.
+ *
+ * The kernel page size specifies in which granularity VMA modifications
+ * can be performed. Folios in this VMA will be aligned to, and at least
+ * the size of the number of bytes returned by this function.
+ *
+ * The default kernel page size is not affected by Transparent Huge Pages
+ * being in effect.
+ *
+ * Return: The default page size granularity for this VMA.
+ */
+static inline unsigned long vma_kernel_pagesize(struct vm_area_struct *vma)
+{
+	if (unlikely(vma->vm_ops && vma->vm_ops->pagesize))
+		return vma->vm_ops->pagesize(vma);
+	return PAGE_SIZE;
+}
+
 static inline
 struct vm_area_struct *vma_find(struct vma_iterator *vmi, unsigned long max)
 {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d969c9ed91b16..c67bfd13d9a8f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1027,23 +1027,6 @@ static pgoff_t vma_hugecache_offset(struct hstate *h,
 			(vma->vm_pgoff >> huge_page_order(h));
 }
 
-/**
- * vma_kernel_pagesize - Page size granularity for this VMA.
- * @vma: The user mapping.
- *
- * Folios in this VMA will be aligned to, and at least the size of the
- * number of bytes returned by this function.
- *
- * Return: The default size of the folios allocated when backing a VMA.
- */
-unsigned long vma_kernel_pagesize(struct vm_area_struct *vma)
-{
-	if (vma->vm_ops && vma->vm_ops->pagesize)
-		return vma->vm_ops->pagesize(vma);
-	return PAGE_SIZE;
-}
-EXPORT_SYMBOL_GPL(vma_kernel_pagesize);
-
 /*
  * Return the page size being used by the MMU to back a VMA. In the majority
  * of cases, the page size used by the kernel matches the MMU size. On
-- 
2.53.0

