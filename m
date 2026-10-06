Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD9545D92F
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 13:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791293128; cv=none; b=Kh3MhBego/axGwnvWyMqEYGwZSwpn0G+IG8wM+5t3QN9/ENPaKTuDc6qMdrQltRK3u8W67flDxuwGizDJaEFb93t3F5Fyj0a9GRjjvjetx59yUxZwrrnfxiC1Pei+Bd8bWh4JHD/RLUPw2Ey3nwGl1UVPb/i986/+K9/FmGY8c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791293128; c=relaxed/simple;
	bh=aEeIe6xwHZnJuP/k7ohX1qqWEYxgOPlybbfJLOcjLgU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TH3LwSaPi8eLdc3AeVRtQLk/zGqRH5I9BjSnYy8lET3fMlh/3Zdliq0rS6UZNbLMPCalnj//qWhY+1oDY9J5SNOvkQRAvfW6aQzzhTLLAP05v8r3/57l6oXFO9qBVcOkdRWTUO7YnPlfwEMk0HCtRNBqhEIJ0vhXkayX75tu2vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bb8OXumP; arc=none smtp.client-ip=209.85.128.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bb8OXumP"
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a16faefac0so15649425e9.0
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 06:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791293122; x=1791897922; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wez9zYzNuiA9QpGccXjAY60dpruYMZcIXFkwi+sXZRQ=;
        b=Bb8OXumPgZ+ubHlu1mtKsv+5dDwcY/8lyjn/6ODwPADGfJQTA3mTwjWKMGxfB72GJo
         AWuEqZ+i4Q1hHBEEMGe4w/GO7i2lz94l/uRJPKPYbv0szr/VV16yBDeEmjOZy1cNiiFJ
         mDLNwSGOYNzwEaxMkyCsswlr7l2jfTaQuVaWzIabSQAvIYOh6vCUVTSj+9IK4k/TLkDq
         Ghp+O8BY3+7Q9vNwBPBt/4WUzW2jNoODQwLGMDb1YUVS1hz/yTXk8upjog+egCSbQIll
         odwR+zKgHXGGMSlhzww3U6sYmmy2GMW0kidq5+piipNvYBsEUyKvgU+8MCrYI1THrWDU
         pZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791293122; x=1791897922;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wez9zYzNuiA9QpGccXjAY60dpruYMZcIXFkwi+sXZRQ=;
        b=QlVLJW4siF64xybnhmzkZChE97l7LFvwLYUIkp8QxGTBO4Pq5O6U9yCUiVm1+F57md
         peKgPD8T6ifioS868GtZt9K8ZPzrZhkf8vyKxZjFsGi0FwAkrgg9lSrK+VCCza/ttd1g
         GevGupZJutuXAQVnSalbH9qFlZdVtH02h2Uxm1BTcL8mdm0ATJR+cHAb96eFNioz0tJP
         nWTs6nB2Iua8h3S640b9Zk2OuDqJuysOZIdcEKhzLx18ouoasAoo0m/iIGPkD1QHNdcH
         zJuDadQ/9ECyO30C3DoEl7AHftdbNTxk0056AwtnJCWANYAUIVlNxl6GooK5H5Qae2Nm
         4ffA==
X-Gm-Message-State: AFuF++lnErf+NGkweNEroYPRtXAuTVEjoJh1tYYJir3C7jRckP8wZhIt
	DteFCp3NO0WCUjY0zPvAy7rTVaiDVDQzEiM24RWpd1M3hvpHV8xJz4+bitnjwSzX4UhRa5sZMYg
	G7zLUyAdHto8/25Li8MvxET310oRN021sT9uFJEOY5yrHwAB6yudmXIfSFVXgPjc3/MBp/njSse
	yjf4krI6O8aT1j41HFE713va+zGl6r20mKbIKmXUGPMYGkRbM=
X-Received: from wmoo9.prod.google.com ([2002:a05:600d:109:b0:4a1:7bd7:d511])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:644f:20b0:4a1:7c56:d4e2 with SMTP id 5b1f17b1804b1-4a17c56d510mr14255395e9.16.1791293121907;
 Tue, 06 Oct 2026 06:25:21 -0700 (PDT)
Date: Tue,  6 Oct 2026 13:25:13 +0000
In-Reply-To: <2026100531-budget-lyrics-f08e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026100531-budget-lyrics-f08e@gregkh>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261006132513.3041062-1-smostafa@google.com>
Subject: [PATCH 5.15.y] KVM: arm64: Don't use the VMA to size stage-2 block
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

