Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375C34AD4AF
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211020; cv=none; b=I9EfUiU3e5CkEaKxJQgCoy+Xgb1yc3kyBCAp40sDOuNkK+urBvPpPs5junjpdLnKFZACoswp0GI+Prec616xTZlmqicD9aTqPS3lQv4XSQ9mmCgqVxijRcVs1iEEztQyTDbEJHGy8e/f8Ws1R/a6KqDS0iR7LSJNvuE6cqawb2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211020; c=relaxed/simple;
	bh=Ka7fgREzBdP804CQYjH1akqK5vRFq5r37rtTrXJAdbc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Gngw0ibOvmWfPMpUYyDAG7TGo+t7ahd3heF5BVorQMaYI4uF20DAPVu+Ydg3WfeaQ1fwbR+z0ysaYupUIhsDqGQsL07d5mJcTMKMNDrpBRParpnUrfMK/ct5p50jB/AKEFg+Dh0FPCUqqhq+VOl06MuHKbIu3VtF/WgRT+wNC5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0rJyUa63; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0rJyUa63"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F211F00893;
	Mon,  5 Oct 2026 14:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791211009;
	bh=M/40sKxmHPKqbh2rxQyDvXF4IZDpdYAEyxsnT1XguKw=;
	h=Subject:To:Cc:From:Date;
	b=0rJyUa63/VRhA6q9H82gZ0I4Fk0MEBqOVthyS2sjJWdj7ol2CRAsYEddF+GdFneOr
	 KVbMVe3/WTfKz1cQexMLygZ0G7K4+ruRMqUCBasc29PsOEVCrusMCiDgWfXvbiZk5u
	 8wL625BZ1i9+Iq4XHHwBGNvP+NMl2x8qn5rWJncE=
Subject: FAILED: patch "[PATCH] KVM: arm64: Use stage-1 leaf size for VM_PFNMAP" failed to apply to 6.1-stable tree
To: smostafa@google.com,maz@kernel.org,oupton@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 16:36:31 +0200
Message-ID: <2026100531-dragonfly-hypnotism-5010@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 71cc2c67fb8f8d5aa8154eb482e9846d2214f11b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100531-dragonfly-hypnotism-5010@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 71cc2c67fb8f8d5aa8154eb482e9846d2214f11b Mon Sep 17 00:00:00 2001
From: Mostafa Saleh <smostafa@google.com>
Date: Tue, 29 Sep 2026 20:02:09 +0000
Subject: [PATCH] KVM: arm64: Use stage-1 leaf size for VM_PFNMAP

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

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 2d44cd6a5aed..bf6d6526639f 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1468,32 +1468,11 @@ transparent_hugepage_adjust(struct kvm *kvm, struct kvm_memory_slot *memslot,
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
 
@@ -1794,7 +1773,7 @@ static short kvm_s2_resolve_vma_size(const struct kvm_s2_fault_desc *s2fd,
 		vma_shift = PAGE_SHIFT;
 	} else {
 		s2vi->max_map_size = PUD_SIZE;
-		vma_shift = get_vma_page_shift(vma, s2fd->hva);
+		vma_shift = get_vma_page_shift(vma);
 	}
 
 	switch (vma_shift) {
@@ -1952,16 +1931,6 @@ static int kvm_s2_fault_pin_pfn(const struct kvm_s2_fault_desc *s2fd,
 				return -EFAULT;
 			}
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
 			s2vi->map_non_cacheable = true;
 		}
 
@@ -2051,10 +2020,10 @@ static int kvm_s2_fault_map(const struct kvm_s2_fault_desc *s2fd,
 
 	/*
 	 * If we are not forced to use page mapping, check if we are
-	 * backed by a THP and thus use block mapping if possible.
+	 * backed by a huge stage-1 mapping and thus use block mapping if
+	 * possible.
 	 */
-	if (mapping_size == PAGE_SIZE &&
-	    !(s2vi->max_map_size == PAGE_SIZE || s2vi->map_non_cacheable)) {
+	if (mapping_size == PAGE_SIZE && s2vi->max_map_size != PAGE_SIZE) {
 		if (perm_fault_granule > PAGE_SIZE) {
 			mapping_size = perm_fault_granule;
 		} else {
@@ -2135,10 +2104,6 @@ static int user_mem_abort(const struct kvm_s2_fault_desc *s2fd)
 			return ret;
 	}
 
-	/*
-	 * Let's check if we will get back a huge page backed by hugetlbfs, or
-	 * get block mapping for device MMIO region.
-	 */
 	ret = kvm_s2_fault_pin_pfn(s2fd, &s2vi);
 	if (ret != 1)
 		return ret;

