Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8434455628
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 13:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791293647; cv=none; b=QrQPQX6JiWY7iFWlyTCiGHrzeNGu4sBwOthGlSN8hQ5EMZ4DI7EZR2SR5xp5uiNTZxKrw8GvL2/IohdYdePHs7Gcr2XkSksfsRHjfzNjGAGcFhJ1UBTDapEA78IN57f2SI47Y12KznHPdiJoWPERxpJGP6JfUF5gAFlj5fUAOfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791293647; c=relaxed/simple;
	bh=akDDsrlz5LUiN+oGGtRhppEbN7v3PHSJ09mAkb8qS5M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M4E4WtP30hkucv7RslLJL+cJExGNfjQ5OsJSmlSB/5D9mqd2lP1I4eCO5OxHLlA9SAQI3r6lrdpTOdrsMAIvOyKm8bQSXzUt6ZKsxFtb0txnszvpTzUjgY07N48A4pB3OVoGlZIsJ7KtdhYusQBmtRGGMAn+VX9bJChow6N9AlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ePD+2pch; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ePD+2pch"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a022fee32fso24595625e9.0
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 06:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791293644; x=1791898444; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rFUs2O53h6lFQjQpssONV4CNZjAqmwmcBofDZBTNjWM=;
        b=ePD+2pchMMwE24VTslbY1D5FtRD5AG+ZuNzf5eCrCFEhy3ponZtySv76dOarZ2YP2/
         fEdyZV7dpl6Egx1BuPCAM6630szhRww7wH8ztklM61Ps98OeHgs/Zn8H9jSTyAa6UdAn
         +HIPY8Y7F5X+mydmAoE2aRzokzEVxnEo2hgcouG4ylZ1SRiWAEDZUmSAgobF0vZwC4fS
         PVoNQ5zrglcmjI79JegvXgOMy7g0lOSy7hUkpxM1iH8z51DIq9ndXJdBmfz6GKvZCJza
         82coeaK/rEBi7JX5JbafK2O0uflDQbTaB5AIPk2C4XbIoBpeGsWJ7/1PYGKdQ4icIFkP
         Q0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791293644; x=1791898444;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rFUs2O53h6lFQjQpssONV4CNZjAqmwmcBofDZBTNjWM=;
        b=wMIPz2VDB25SMAzr+q1r7kdl2i7A1yqH7eBZYtwtW2Lhj2YQ75i3P9TtZr4+Sgqx2H
         KdC+AbwMOX1CdgQ7Uio82DnsLS1HT/8Zo/a2jk2NHz6MWpPCVAFP7f+X+HwNyV1arAKn
         YhNzRakOKPsVkLKZQdkGWvcfBH6WtgX03kQisLqqu1DmL+2aYR2cNNX5p/5rwLaCbuc9
         rCP/6u09G/No6AbVNDTcpsSbmjNvcdsLCIbiRMe26ZrXHbvzq4HM44zLOtEbtpjnb4yh
         BfR0RhgR9kVNW4fT8o5z96cUNx1M9DIiN1mcDSwRmqUMESmxpdw7LItSa0PQCQMi56uX
         /gCQ==
X-Gm-Message-State: AFuF++kKYi24xlrz2cUXMXMBzMcL9mPWZAaRhKRbfBYYSsB+S8pCc/6O
	eiYevK6K2cjG0y8+G/ffZg0J5T2RyaA7wcUZBQgFQvt48DB44mprosiiBWQdW0Se0aQ6hwivbup
	uEIScj2vbtnm63wI1Ask+WigmErJa2L5FDnc3gu2jyzYZJtp2s2JyZa2ljw090b8rdoTASeBV/F
	yREX8hL7TnlMzGa8wqocq+7MPff/Irju1RJUJMLXcWxjMwNp8=
X-Received: from wmpj20.prod.google.com ([2002:a05:600c:4894:b0:4a1:76c7:7e63])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e45:b0:4a1:687b:8f3d with SMTP id 5b1f17b1804b1-4a17b55ad69mr21462695e9.31.1791293643560;
 Tue, 06 Oct 2026 06:34:03 -0700 (PDT)
Date: Tue,  6 Oct 2026 13:33:59 +0000
In-Reply-To: <2026100530-unscathed-basket-3d69@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026100530-unscathed-basket-3d69@gregkh>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261006133359.3163466-1-smostafa@google.com>
Subject: [PATCH 6.6.y] KVM: arm64: Don't use the VMA to size stage-2 block
 mappings for VM_PFNMAP
From: Mostafa Saleh <smostafa@google.com>
To: stable@vger.kernel.org
Cc: Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

[ Upstream commit 71cc2c67fb8f8d5aa8154eb482e9846d2214f11b ]

get_vma_page_shift() derives the stage-2 block size for VM_PFNMAP VMAs
from the VMA layout alone, which does not necessarily match what
stage-1 maps for that VMA.

Upstream commit 71cc2c67fb8f ("KVM: arm64: Use stage-1 leaf size for
VM_PFNMAP") drops that calculation and lets transparent_hugepage_adjust()
derive the mapping size from the stage-1 leaf instead. The second part
is not applicable here: in this kernel transparent_hugepage_adjust()
takes a reference on the backing struct page, which is not safe for
MMIO, and stage-1 has no huge PFNMAP before v6.12 anyway. Only drop the
VMA-based calculation, so VM_PFNMAP VMAs are mapped at PAGE_SIZE.

Fixes: 2aa53d68cee6 ("KVM: arm64: Try stage2 block mapping for host device MMIO")
Cc: stable@vger.kernel.org
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/kvm/mmu.c | 25 ++-----------------------
 1 file changed, 2 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 482280fe22d7..47f76a78ba1f 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1329,32 +1329,11 @@ transparent_hugepage_adjust(struct kvm *kvm, struct kvm_memory_slot *memslot,
 	return PAGE_SIZE;
 }
 
-static int get_vma_page_shift(struct vm_area_struct *vma, unsigned long hva)
+static int get_vma_page_shift(struct vm_area_struct *vma)
 {
-	unsigned long pa;
-
 	if (is_vm_hugetlb_page(vma) && !(vma->vm_flags & VM_PFNMAP))
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
 
@@ -1456,7 +1435,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		force_pte = true;
 		vma_shift = PAGE_SHIFT;
 	} else {
-		vma_shift = get_vma_page_shift(vma, hva);
+		vma_shift = get_vma_page_shift(vma);
 	}
 
 	switch (vma_shift) {
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

