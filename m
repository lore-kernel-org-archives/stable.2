Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B1B547073
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 13:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791293246; cv=none; b=APpiVIaNiHankgbl64yy7oG5gYmDoao2C0NxpNlA4IdtGehAQ6C+t1Hgl51qCZB3GBUCKo4pKEnov20hf7MT1fHW3dZRW7VRQdybKgsZ/rIbyUvO1esSfUK5g89ofrF14KBBKpCbr38ie9gCqdSmZG+K+WzH1SsHTxV5UV0afa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791293246; c=relaxed/simple;
	bh=15FLHXliOlxihS/gxX0kVI4hU3RB0dfUcmcFmLnB6Ms=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HS6dyEzgSPA/zJK69USW6tRPNZDOiJwxb6sz9DZtyzdHT7Bdjju2nhP6P5tKMDTHntWc5gGRsY87xbgXBqdNtR4+CsnFs1LN/6bAxyXBdf5C7NbjQoE/5+5IukaWMxW+DIu3Ot3sZ9WZvTuMNfhXZiG/NsmQbf9IRz8Vg5xzTc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dj0Fm4d7; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dj0Fm4d7"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a028616bebso24794485e9.1
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 06:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791293243; x=1791898043; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u5LlAn+OzJ4Pq8PYQrF+yZPQxxxGrWFRptAPUqDZMqs=;
        b=dj0Fm4d7S4LaBmNkljCzGy5TJTsnMibK3rUO+qt4bV7n72NzyzqVzUYCFdX2MV4n7s
         Yfi+eY6tA3JaTKND6z10LkLRfbWsg0mSzkooTqpCBG5lgqCYZnujwajRHj8xbQW1jpYs
         nwvOuLZcIpS/VYKT4gFoMYLb+vq4G36f7+CAW0uDdU4JzV+u+/4x17266z7WgASO+5Ho
         bRSZ/jILakQzhI/whIl+QX8Cg82dApNyY+onCTE6Z+zLYgPJ2CFBDmLyfYPy6+FCdTc4
         dJKZdRsv13dkTbktoPSy6G5WUFjtYRYCIXjSL7hAZA1xAQaQhTywa/g+0k/F97V7So/t
         eFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791293243; x=1791898043;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u5LlAn+OzJ4Pq8PYQrF+yZPQxxxGrWFRptAPUqDZMqs=;
        b=UXKSHA0nWyRHc+dVAMwHxwfp+OyAqzULrmeJ9DqLGClAww+ipzjt9+5fuwv4KsAud8
         p6YBhMJmuH8CZ3FT+E8Dpq6AtG80c7VkBRr0bZCknYvyXI5Jyhiu98Ad32pYWqFGvX8K
         eDqcRm/4ks+szBbdylFVJsVLBAAUiC2rju9O/6tmJgZrWM5s9qaKF/LAzGKjaZGsBDVE
         7ENmPl3vKVJYMiAd3DOPcvRBaK5bVGdtr7Jcm/D2mAa2a3glSZaOb9NRz1jhfM0kmbty
         vCcYKrm3NsohAXT3hcDp+lfk8535ZGIcL4Z3jcou3YSropo6nJX7ffScWK1PiMEyR8qP
         kXlg==
X-Gm-Message-State: AFuF++nUbmLCkDuWQDwTrnj6d5XOvqXlZ7bzPX6AD726Si16KbnvLH3K
	m6cEAZGkUKPeMYUMnGkGiyfKj/If0SqOZcBUu0uM7EXgvyQEr2W4tKiPepnyEAgCzHTOo3/pKoP
	zox8y1fAcyUahUwFxEP6wGvYEGL5B2JMnSsVpUipDFM+27wmGQK1gk3UqQ2G8Mcj1pXkwIFudNk
	9kEW1zDbK1hOeqJrhsYOkd3PqkuoLRRwHM1iqIYRk+UssW9jc=
X-Received: from wmv11.prod.google.com ([2002:a05:600c:26cb:b0:4a1:7b05:58e1])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:548f:b0:49e:6683:d23c with SMTP id 5b1f17b1804b1-4a17b4b6bfbmr25344015e9.0.1791293242321;
 Tue, 06 Oct 2026 06:27:22 -0700 (PDT)
Date: Tue,  6 Oct 2026 13:27:19 +0000
In-Reply-To: <2026100531-dragonfly-hypnotism-5010@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026100531-dragonfly-hypnotism-5010@gregkh>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261006132719.3043573-1-smostafa@google.com>
Subject: [PATCH 6.1.y] KVM: arm64: Don't use the VMA to size stage-2 block
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
index 54ccdcc2dbdf..2ccc62379642 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1077,32 +1077,11 @@ transparent_hugepage_adjust(struct kvm *kvm, struct kvm_memory_slot *memslot,
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
 
@@ -1214,7 +1193,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		use_read_lock = (fault_status == FSC_PERM && write_fault &&
 				 fault_granule == PAGE_SIZE);
 	} else {
-		vma_shift = get_vma_page_shift(vma, hva);
+		vma_shift = get_vma_page_shift(vma);
 	}
 
 	shared = (vma->vm_flags & VM_SHARED);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

