Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B38B3AA9F8
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 13:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082515; cv=none; b=HD/xUE/ktVAabroO4H+LTmvH1iaGmNSDVCYkdPq0bkUNL+AavCvP3PfGEWA3/jc/pglsQLK9e3DdxAjfmGaUnHVNaejsZ6SYAflbs+2mzadfqqLbfNtm032T5C7PlomMjY6RUy3Ob8GI/lm1alln9rSmzkXe6t7lvKy1qL+GzJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082515; c=relaxed/simple;
	bh=ofQ1oPhtNYdQIg2drBmsKL5iLxiuc2AiZdhA9y3Ej3k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kOsLpZVDDCZFXOWgtohWiypSgfdBqcsvUvsKDrqMzF2QUiXciJ/IlPkJSUV7cNIj4y7JCv4A0BYLD4Fpj/BraTWlJQauCeml03LRnmqRhCs196bmyd23e11oo4yjMdQAkKBw6P1gHFYoCQvAmzJ5CRMMudm3gdb4s2UYNLiz3e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bBuTzaKq; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bBuTzaKq"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490a767b782so32697745e9.2
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 06:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790082512; x=1790687312; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hRT4LKrWmlIEgB+8kAa2SxHNKz3rcwa3j5wHsFjjrzo=;
        b=bBuTzaKqTylPVQf2yVbQgb0sMlSuXZ0JZGWldE7rGEtZwMM8nrYtBQqc6yOgVAZWpL
         9H8585YuQF33Wjdryk/bfjbNuAjAkq9PryObkIIWeHwZGsHt4nFrSpTKDpAcsoVKcj0b
         FY2UI1v0uH7WPHuXSoZW/+SqPtnls1apxfGEDy77Z/dUnutrKFBuf0sxBrrP5RoGk7xX
         ZGQm5N6EcyACF8DjkaiP07i9utDxQGojk0+92YKhGd2ZQcDgMadSFtYgkHUySgKJh7vL
         NWi62GHPkWJb1QfMO8El+A+jiQqtFxwWytUtJuQMlbQQ/L+uuLjerzBXu9PifS9NNBy7
         dUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790082512; x=1790687312;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hRT4LKrWmlIEgB+8kAa2SxHNKz3rcwa3j5wHsFjjrzo=;
        b=xZsxwi59bafp4cWguatIzyQZbez1TgA9TSMenzWObf3hpaWHzVuZN4qLPyQNxFxJKJ
         wUuPI81tF+yP4T63ryBBe5wRabseZmCC2hD6O0gDIGORzkn7EtBuz88UOjrfy6Z1xcSF
         G6+NmJEZdLnnxE9izKkugqaudhWpMf+n+WiPLqTt2hYq0TOHrZ3jwJIetn/UEPDFQ8Rs
         KvqkWGPqZmuVY4KyFinRkOg+x14t5x1BcypE0IpwWk4683HyGCkhhw7z0Kyx0zGYJcto
         kh5Zo9nUk7vCW3lvFmZFGIApWfsJkfu9bOI8KIg/mQxDj5orDTBh+5CFq8UBd4MeyamE
         WP/g==
X-Forwarded-Encrypted: i=1; AKwUvBzEMBPxuxeSLEGJMhFX8uvpimm25QcxHdKHTKJOJ+kVdzxtT6OWN30A+MLAA2c6u1QeGEpx+Rc=@vger.kernel.org
X-Gm-Message-State: AFuF++nDIFj07JE28dsFZJoI/aYPVFaEKOg0UB5tOhDoQ5xrvf316UBv
	a96lfw+NxE1RTSr1moHJItxVK65xSNF/leoarhmX4c2HKUdtjUE0L0y8yyTea8lk2iChtelerzg
	1rCx9q59KSeL5+jGhKrdnSA==
X-Received: from wmbgv5.prod.google.com ([2002:a05:600c:80c5:b0:49e:6a1d:16af])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1e24:b0:49c:fc6e:a3d2 with SMTP id 5b1f17b1804b1-49fc574f74bmr191646085e9.17.1790082511588;
 Tue, 22 Sep 2026 06:08:31 -0700 (PDT)
Date: Tue, 22 Sep 2026 14:08:20 +0100
In-Reply-To: <20260922130821.1666713-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260922130821.1666713-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922130821.1666713-6-vdonnefort@google.com>
Subject: [PATCH v1 5/6] KVM: arm64: Use kvm_s2_fault_vma_info in gmem_abort()
From: Vincent Donnefort <vdonnefort@google.com>
To: maz@kernel.org, oupton@kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: joey.gouly@arm.com, seiden@linux.ibm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org, 
	kernel-team@android.com, fuad.tabba@linux.dev, qperret@google.com, 
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Fuad Tabba <fuad.tabba@linux.dev>

gmem_abort() maps at s2fd->fault_ipa, which HPFAR_EL2 holds at 4K
granularity whatever the page size. The generic page-table code aligns
it, but pkvm_pgtable_stage2_map() looks up existing mappings over
[addr, addr + size), so on a pKVM host with pages larger than 4K a
guest_memfd-backed guest that faults past the first 4K of a page can
find its neighbour's mapping, get -EAGAIN and take the same fault
forever.

Take the addresses from kvm_s2_fault_vma_info instead, as
user_mem_abort() does, and report the gfn kvm_gmem_get_pfn() failed on
in the memory fault exit. kvm_s2_fault_get_vma_info() itself isn't
called: a guest_memfd memslot's userspace_addr doesn't need to be
backed by a VMA.

Fixes: a7b57e0995927 ("KVM: arm64: Handle guest_memfd-backed guest page faults")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/20260913175105.A57AC1F000FF@smtp.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 arch/arm64/kvm/mmu.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 5aac624b0442..ee0fcca838c1 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1953,11 +1953,9 @@ static int gmem_abort(const struct kvm_s2_fault_desc *s2fd)
 	enum kvm_pgtable_walk_flags flags = KVM_PGTABLE_WALK_SHARED;
 	enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_R;
 	struct kvm_pgtable *pgt = s2fd->vcpu->arch.hw_mmu->pgt;
-	unsigned long mmu_seq;
-	struct page *page;
+	struct kvm_s2_fault_vma_info s2vi = {};
 	struct kvm *kvm = s2fd->vcpu->kvm;
 	void *memcache = NULL;
-	kvm_pfn_t pfn;
 	gfn_t gfn;
 	int ret;
 
@@ -1968,23 +1966,22 @@ static int gmem_abort(const struct kvm_s2_fault_desc *s2fd)
 			return ret;
 	}
 
-	if (s2fd->nested)
-		gfn = kvm_s2_trans_output(s2fd->nested) >> PAGE_SHIFT;
-	else
-		gfn = s2fd->fault_ipa >> PAGE_SHIFT;
+	s2vi.vma_pagesize = PAGE_SIZE;
+	s2vi.gfn = ALIGN_DOWN(s2fd->fault_ipa, s2vi.vma_pagesize) >> PAGE_SHIFT;
+	gfn = get_canonical_gfn(s2fd, &s2vi);
 
 	write_fault = kvm_is_write_fault(s2fd->vcpu);
 	exec_fault = kvm_vcpu_trap_is_exec_fault(s2fd->vcpu);
 
 	VM_WARN_ON_ONCE(write_fault && exec_fault);
 
-	mmu_seq = kvm->mmu_invalidate_seq;
+	s2vi.mmu_seq = kvm->mmu_invalidate_seq;
 	/* Pairs with the smp_wmb() in kvm_mmu_invalidate_end(). */
 	smp_rmb();
 
-	ret = kvm_gmem_get_pfn(kvm, s2fd->memslot, gfn, &pfn, &page, NULL);
+	ret = kvm_gmem_get_pfn(kvm, s2fd->memslot, gfn, &s2vi.pfn, &s2vi.page, NULL);
 	if (ret) {
-		kvm_prepare_memory_fault_exit(s2fd->vcpu, s2fd->fault_ipa, PAGE_SIZE,
+		kvm_prepare_memory_fault_exit(s2fd->vcpu, gfn_to_gpa(gfn), s2vi.vma_pagesize,
 					      write_fault, exec_fault, false);
 		return ret;
 	}
@@ -2002,7 +1999,7 @@ static int gmem_abort(const struct kvm_s2_fault_desc *s2fd)
 		prot = adjust_nested_exec_perms(kvm, s2fd->nested, prot);
 
 	kvm_fault_lock(kvm);
-	if (mmu_invalidate_retry(kvm, mmu_seq)) {
+	if (mmu_invalidate_retry(kvm, s2vi.mmu_seq)) {
 		ret = -EAGAIN;
 		goto out_unlock;
 	}
@@ -2013,16 +2010,17 @@ static int gmem_abort(const struct kvm_s2_fault_desc *s2fd)
 		 * PTE, which will be preserved.
 		 */
 		prot &= ~KVM_NV_GUEST_MAP_SZ;
-		ret = KVM_PGT_FN(kvm_pgtable_stage2_relax_perms)(pgt, s2fd->fault_ipa,
+		ret = KVM_PGT_FN(kvm_pgtable_stage2_relax_perms)(pgt, gfn_to_gpa(s2vi.gfn),
 								 prot, flags);
 	} else {
-		ret = KVM_PGT_FN(kvm_pgtable_stage2_map)(pgt, s2fd->fault_ipa, PAGE_SIZE,
-							 __pfn_to_phys(pfn), prot,
+		ret = KVM_PGT_FN(kvm_pgtable_stage2_map)(pgt, gfn_to_gpa(s2vi.gfn),
+							 s2vi.vma_pagesize,
+							 __pfn_to_phys(s2vi.pfn), prot,
 							 memcache, flags);
 	}
 
 out_unlock:
-	kvm_release_faultin_page(kvm, page, !!ret, prot & KVM_PGTABLE_PROT_W);
+	kvm_release_faultin_page(kvm, s2vi.page, !!ret, prot & KVM_PGTABLE_PROT_W);
 	kvm_fault_unlock(kvm);
 
 	if ((prot & KVM_PGTABLE_PROT_W) && !ret)
-- 
2.55.0.1082.g2b9226bbc0-goog

