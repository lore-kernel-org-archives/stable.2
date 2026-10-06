Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E2541D626
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 13:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791293055; cv=none; b=iIyokGZeg5RvyImIMjL0pAZTJ8ExuM6vYzt6OxrYs8QEHX7GBAOsO8NNe12VRM/Yg7paM7Dapv6WspHotpxAlostZZhgrOqNWPCnJIZwAD0gqALqg7fLZmcBJ6A1PIE9syiNlKxBodC0phW3tIqjJlIdGksWn/BbeI3FRpl0Th8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791293055; c=relaxed/simple;
	bh=aEeIe6xwHZnJuP/k7ohX1qqWEYxgOPlybbfJLOcjLgU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mLNY170jy0SFALLXCjJkjRFi57NzRGx4RL6X8oT+YcWVT7IlQZJ7fKpwBKOrOEXpNy9o22DhztGXh3YFkDnUzp7zwXj+6sClCchUHFAQ5HXiop79WevvlRBzumDgUhsCsUbO+WmVc4DxHKIlHq+XXUFrWXHxJ0VN/s6F0x+mDyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bqt0LufN; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bqt0LufN"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a17741243eso7961325e9.0
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 06:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791293052; x=1791897852; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wez9zYzNuiA9QpGccXjAY60dpruYMZcIXFkwi+sXZRQ=;
        b=bqt0LufN5kVlq3Vu9fNEHcLKR6+ebmO752CrYiDkIS+nGbe1caIo9f/omCGqTc5kJO
         +atNe2D08RwNR3s6UHKjbNfyasIS5oVjZgaI7bz4cFJ4eurGABi42wOzZqW0eUpulw/R
         9FfaFs1VGYx5DBlRDbq/k5fa4xV3A8lngDbptBnWGUq1m6xq7NYVIWWkE/ClabiiexIL
         B7i0IWPRXtKiufKfXSogmzAOvjuG7uu6YxoqtntKkNVu83MRZlKtbXfipe4ubH9VYYQ5
         8UXWw5SEZIxBjv676qCfayBTqC7qGDeGEIzxsE9V6FUHPltwq+ZNmcQ06eHNC2dAnfJE
         dmdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791293052; x=1791897852;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wez9zYzNuiA9QpGccXjAY60dpruYMZcIXFkwi+sXZRQ=;
        b=Fh23ndy9DNyUUP25TDxWJramaSKgO22KfUBmC1oypB6mGhAkVgORbIo6p4hOzPpl+7
         A/lNYwVxh2Skbt+v0c155k/dNjruYdjN1ZyMLzJynREO1Pe+3JwHQ8L66cQ3vHmU72Bd
         XljQYizpE6bwKrQ758w37fUNClLmvfFe+ki0JjMsitRvLVjqW00KaNIrZNBtPoj+GxY+
         Ek5CDZ87MCbwSPYO5OQwnMfajphL1XCOgtyF+kE1BDy8OyQDpkV8lfTMO4T64Vhbf2hH
         sLow3oN+59dsjBy7No+r2ufZ/fy8npWZQPEZqkVAnGdOaF+IYbPYoqKBnNelBatXdhne
         JVBg==
X-Gm-Message-State: AFuF++kYTvjxI3LXs96mxqwkn5SOUiTQ+0dFMAZuQadcSd6AI1U9ORhE
	sRnW7qKDrIH7VsInc6puXuPKdA2571sDp87Z2eLSVLcu0LiTXRM6p1r8TsEulOzGqF5jOTV0PED
	rAFNHXEDBn8WTEOGf2A7IN5g7ZKkKsu/4ls7eqBETfFy6VNfFnAgdk/sH8H/kiRyq6VUSDIVqNF
	kaZgCzNmAD6v8cIe9hANyOVJ4MGLYYgeFs8d0eibcWeotKm5Y=
X-Received: from wmol7.prod.google.com ([2002:a05:600c:47c7:b0:4a0:12d8:d3ee])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c44c:10b0:49c:fc6e:a3d7 with SMTP id 5b1f17b1804b1-4a1680f7b15mr126834325e9.22.1791293052418;
 Tue, 06 Oct 2026 06:24:12 -0700 (PDT)
Date: Tue,  6 Oct 2026 13:23:58 +0000
In-Reply-To: <2026100531-budget-lyrics-f08e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026100531-budget-lyrics-f08e@gregkh>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261006132358.3040035-1-smostafa@google.com>
Subject: [PATCH] KVM: arm64: Don't use the VMA to size stage-2 block mappings
 for VM_PFNMAP
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
index 7d04f9670644..c5697cbbfabe 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -904,32 +904,11 @@ transparent_hugepage_adjust(struct kvm *kvm, struct kvm_memory_slot *memslot,
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
 
@@ -1038,7 +1017,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		force_pte = true;
 		vma_shift = PAGE_SHIFT;
 	} else {
-		vma_shift = get_vma_page_shift(vma, hva);
+		vma_shift = get_vma_page_shift(vma);
 	}
 
 	shared = (vma->vm_flags & VM_SHARED);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

