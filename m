Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118393E40EF
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 16:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791302951; cv=none; b=d2DLI4lubw7evJD6noFzEBcpQfx+V91HWnOV7sBrq0XZ/6HATpwP49JWnFmIo29i8zXsA2FXR14hxlV+pzdwjgtA4DaPCjcHbjCOarAaUX8UIrpOJfL+0yUCmAEoruF+vQnrwH69eEFuoKl65WX4yFSHCe52++Syli2fa/4ydkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791302951; c=relaxed/simple;
	bh=436J2VeczdXRn6xBDJNx8Y0BX5xKwnwxhi3qG7gjOJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tIT2sFPP5VXoUMRmyrNe8/ghjfhNagGDc/0G2DGog4sksE1kZhzSo8Bf5hzGM7GfAkgr72+RujhbxKrQXqlQa247yND0iDpxV+O6lAR4a9FcqH0BnNvbbZMmKb4i/+fEbh545gVj5/IoKJdKdx5iMl1gzc1DtF3+qqqSMeYAOW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jy6Hza5+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jy6Hza5+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 563221F0089B;
	Tue,  6 Oct 2026 16:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791302949;
	bh=L/cOhERCRDCIQKGzfsZegmQ43nVHGg1nEZa28Kq2vAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jy6Hza5+nK/vtiodrgQUwcFD+U+/2vb5RCebSzekunY98gU3jGkGOfjNRMFO2d98S
	 gV4kNSL2qGIAfS3H487UNl/B0lbS5jWoq5LcITQN8xTq2QoGYweGpdimpi2NQncLuZ
	 6XNBWQic/1tBtrmPWuxKWn0WC4Z5ivIIAptTPwFLLaf0GfWWuLvUqBVWu2Tx83tXhy
	 EbmN4lxYpZEav7V21srzg7gS3FAD0CEJvVnUcUrJyODPUJ0jR+/TE6fgkTJCjJJl70
	 j7xF4Nz+MX1eOrXn1nPELnzHpIfBNIlhkZwE/nwtcadihYrfp8t4oRU2b8q1QtFbPz
	 k4649RWz0JuCA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mostafa Saleh <smostafa@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] KVM: arm64: Use stage-1 leaf size for VM_PFNMAP
Date: Tue,  6 Oct 2026 12:09:05 -0400
Message-ID: <20261006160846.858646-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100530-impulse-jiffy-87f1@gregkh>
References: <2026100530-impulse-jiffy-87f1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mostafa Saleh <smostafa@google.com>

[ Upstream commit 71cc2c67fb8f8d5aa8154eb482e9846d2214f11b ]

When commit 2aa53d68cee6 ("KVM: arm64: Try stage2 block mapping for
host device MMIO") added VM_PFNMAP support to get_vma_page_shift(),
stage-1 page tables did not support huge PFNMAP (as in VFIO-PCI
vfio_pci_mmap_huge_fault()) and transparent_hugepage_adjust() was
unsafe for MMIO as it dereferenced struct page.

Since commit 6011cf68c885 ("KVM: arm64: Walk userspace page tables to
compute the THP mapping size"), transparent_hugepage_adjust() instead
walks the host stage-1 page tables via get_user_mapping_size() without
touching struct page. Meanwhile, commit 3e509c9b03f9 ("mm/arm64:
support large pfn mappings") enabled stage-1 huge PFNMAP.

So. we can drop the VMA-based VM_PFNMAP size calculation in
get_vma_page_shift() and let transparent_hugepage_adjust() derive
the stage-2 mapping size directly from the populated stage-1 leaf
for non-cacheable mappings as well.

Assisted-by: LLM
Cc: stable@vger.kernel.org
Fixes: 2aa53d68cee6 ("KVM: arm64: Try stage2 block mapping for host device MMIO")
Reviewed-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Oliver Upton <oupton@kernel.org>
[ sashal: Adapted upstream helper changes to the monolithic user_mem_abort() implementation. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kvm/mmu.c | 46 ++++++--------------------------------------
 1 file changed, 6 insertions(+), 40 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 2dae3fcb7a7f7..af50fed5b5975 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1406,32 +1406,11 @@ transparent_hugepage_adjust(struct kvm *kvm, struct kvm_memory_slot *memslot,
 	return PAGE_SIZE;
 }
 
-static int get_vma_page_shift(struct vm_area_struct *vma, unsigned long hva)
+static int get_vma_page_shift(struct vm_area_struct *vma)
 {
-	unsigned long pa;
-
-	if (is_vm_hugetlb_page(vma) && !(vma->vm_flags & VM_PFNMAP))
+	if (is_vm_hugetlb_page(vma))
 		return huge_page_shift(hstate_vma(vma));
 
-	if (!(vma->vm_flags & VM_PFNMAP))
-		return PAGE_SHIFT;
-
-	VM_BUG_ON(is_vm_hugetlb_page(vma));
-
-	pa = (vma->vm_pgoff << PAGE_SHIFT) + (hva - vma->vm_start);
-
-#ifndef __PAGETABLE_PMD_FOLDED
-	if ((hva & (PUD_SIZE - 1)) == (pa & (PUD_SIZE - 1)) &&
-	    ALIGN_DOWN(hva, PUD_SIZE) >= vma->vm_start &&
-	    ALIGN(hva, PUD_SIZE) <= vma->vm_end)
-		return PUD_SHIFT;
-#endif
-
-	if ((hva & (PMD_SIZE - 1)) == (pa & (PMD_SIZE - 1)) &&
-	    ALIGN_DOWN(hva, PMD_SIZE) >= vma->vm_start &&
-	    ALIGN(hva, PMD_SIZE) <= vma->vm_end)
-		return PMD_SHIFT;
-
 	return PAGE_SHIFT;
 }
 
@@ -1655,10 +1634,6 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	if (ret)
 		return ret;
 
-	/*
-	 * Let's check if we will get back a huge page backed by hugetlbfs, or
-	 * get block mapping for device MMIO region.
-	 */
 	mmap_read_lock(current->mm);
 	vma = vma_lookup(current->mm, hva);
 	if (unlikely(!vma)) {
@@ -1670,7 +1645,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	if (force_pte)
 		vma_shift = PAGE_SHIFT;
 	else
-		vma_shift = get_vma_page_shift(vma, hva);
+		vma_shift = get_vma_page_shift(vma);
 
 	switch (vma_shift) {
 #ifndef __PAGETABLE_PMD_FOLDED
@@ -1786,16 +1761,6 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 			if (!kvm_supports_cacheable_pfnmap())
 				ret = -EFAULT;
 		} else {
-			/*
-			 * If the page was identified as device early by looking at
-			 * the VMA flags, vma_pagesize is already representing the
-			 * largest quantity we can map.  If instead it was mapped
-			 * via __kvm_faultin_pfn(), vma_pagesize is set to PAGE_SIZE
-			 * and must not be upgraded.
-			 *
-			 * In both cases, we don't let transparent_hugepage_adjust()
-			 * change things at the last minute.
-			 */
 			s2_force_noncacheable = true;
 		}
 	} else if (logging_active && !write_fault) {
@@ -1826,9 +1791,10 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 
 	/*
 	 * If we are not forced to use page mapping, check if we are
-	 * backed by a THP and thus use block mapping if possible.
+	 * backed by a huge stage-1 mapping and thus use block mapping if
+	 * possible.
 	 */
-	if (vma_pagesize == PAGE_SIZE && !(force_pte || s2_force_noncacheable)) {
+	if (vma_pagesize == PAGE_SIZE && !force_pte) {
 		if (fault_is_perm && fault_granule > PAGE_SIZE)
 			vma_pagesize = fault_granule;
 		else
-- 
2.53.0

