Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AE749552D
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 09:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790589315; cv=none; b=o5xRsyU3WR+eRj0DcmbKGPv91q9MwNinol/Z9LJ9LsICYbRhgwJPmEv3NWDmHvWrhhiXzrjOqq0xst30XJUVzUWwCIJGEuqOs90CMZRVhk/MVsL2yhxU0kEO5fHc8S9sYcKBC87YA3bf0kSDtG588sapfY4TtWHh8QJivU7e48c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790589315; c=relaxed/simple;
	bh=tcJcJcQ6qPCVfTV/ZV4kLnVjnpFTdhAiLFxdblw46Bk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uOIcL2bNtGxsbIbnn5UaoB3GQG3Era2rzBqEotCCrmTX8yUzg890Fiui+u1c50CU13iJS3hHxlmzmjSnAhpaPiZAPW2BVggrp5/s5sF8LM8+p9S4OyMl5VkkXgzjQe3I337g1Jmfift6ByN7Qn743rKOHYh9ZR3HfoY2PF+o0WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bXnhS30n; arc=none smtp.client-ip=209.85.128.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bXnhS30n"
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49fcd86b8d3so22740405e9.3
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 02:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790589312; x=1791194112; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FUMLMkfrYG7ovAWGgH8OISX4nHJaEyCyIq32R+fyFGQ=;
        b=bXnhS30nJDKTdE6OXemy/HWWjgaFQqy1ftSY/oGhI2U4SmKi5PdHIaem4mFmYRDUCX
         At85z7QVXYpAyvGZ38GNCXrwehOQAt2df+Kyw1cqq+0p+PoRyNln8cZuBM7syhIavsZs
         hL/waoxL7AgAs09ppgc71U4zVHmmwwxcLFkSt3uFGaURIinL1F0qa1a9KF46CcqUe7RP
         ctfbEKXDQ/lFzW6tP1GijfAEYhDS6TAEDcrjn3EHjLSv6RhEbShUioONk5HT4C4Ekk5x
         V/zsfUVgbKBQz2MKVFa6X/YeeRC8ddNI3lWP7MJ+EBBu+UKKNGUGx48hnE2FbxL89k/5
         wqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790589312; x=1791194112;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FUMLMkfrYG7ovAWGgH8OISX4nHJaEyCyIq32R+fyFGQ=;
        b=NV5DaIqiqP/zvSajBZKth1+mCWvWcLx8A0dBIxCWLM9PQck1IOpgXtCwPf02k+lNo+
         1ZcTPWmNCIePCH+rBlo4/utbBc86+NebwPXT2AGYJ3dTK+zoP70yax/n8uqJbcCWf+A/
         qikxZ9JLakjEQfHeNDDLtZ6AvPwLTbBxofUuo49vqa1a3r4198M2AkdwN+wCBrlftWSq
         77LNt+9dzPubfaiPPsCnGbxP6H9k5kwgX1KmijECqtpTPA7IZT6HPxoEkwgi3/9W4gy9
         u1cNi1eqd47rinmh+Ui9u8KV84y5UBdKXbo7glPUxBsNED2yOPmMOluCrhx+9r/9tS8T
         u0QA==
X-Forwarded-Encrypted: i=1; AKwUvBwjhZebIp/SLS8nvnr519A3Mo2KnWOS3LtVaSirrgf/IranvJIPO7lhn+yKhHeD9l40EcwTmJo=@vger.kernel.org
X-Gm-Message-State: AFuF++mLu9gVRgzpHe/T33J4gVGCfOum+Rc+QHQzaWfIDnqs54ppfA1O
	W3RXhS5yAaVEBQRfZwMgE7KHt/V35rnOe/tVzmhf2c8uvFhYCmc/TNGqjVE7cYB9KYbKvEoLPJU
	52k8GV7lBuRdVk2kry5gARg==
X-Received: from wmdv19.prod.google.com ([2002:a05:600c:12d3:b0:49f:e401:6ca4])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:348e:b0:49e:8191:e5cb with SMTP id 5b1f17b1804b1-49ff06b2ef6mr163475965e9.5.1790589311187;
 Mon, 28 Sep 2026 02:55:11 -0700 (PDT)
Date: Mon, 28 Sep 2026 10:54:53 +0100
In-Reply-To: <20260928095454.3255918-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260928095454.3255918-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928095454.3255918-5-vdonnefort@google.com>
Subject: [PATCH v2 4/4] KVM: arm64: Use kvm_s2_fault_vma_info in pkvm_mem_abort()
From: Vincent Donnefort <vdonnefort@google.com>
To: maz@kernel.org, oupton@kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: joey.gouly@arm.com, seiden@linux.ibm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org, 
	kernel-team@android.com, fuad.tabba@linux.dev, qperret@google.com, 
	weilin.chang@arm.com, Vincent Donnefort <vdonnefort@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

To paraphrase Marc in commit 08f97454b7fa ("KVM: arm64: Fix protected
mode handling of pages larger than 4kB"), pkvm_pgtable_stage2_map()
assumes the address passed as a parameter is aligned to the size of the
intended mapping, while HPFAR_EL2 gives the IPA minus the bottom 12
bits, regardless of the system page size configuration.

To fix this alignment, bring support for kvm_s2_fault_vma_info in
pkvm_mem_abort() and use its members where possible. They do contain the
page-alignment we need to fix the fault on system with pages larger than
4K.

Also, add a check at the start of pkvm_pgtable_stage2_map(), it does not
support !PAGE_ALIGNED arguments.

Fixes: ea03466e806f ("KVM: arm64: Handle aborts from protected VMs")
Cc: stable@vger.kernel.org
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
Tested-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 arch/arm64/kvm/mmu.c  | 27 ++++++++++++++++++---------
 arch/arm64/kvm/pkvm.c |  3 +++
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 5c89b6684b02..d48e4beab483 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1383,9 +1383,11 @@ static bool fault_supports_stage2_huge_mapping(const struct kvm_s2_fault_desc *s
 	if (map_size == PAGE_SIZE)
 		return true;
 
-	/* pKVM only supports PMD_SIZE huge-mappings */
-	if (is_protected_kvm_enabled() && map_size != PMD_SIZE)
-		return false;
+	/* pKVM only supports PMD_SIZE huge-mappings for non-protected VMs */
+	if (is_protected_kvm_enabled()) {
+		if (vcpu_is_protected(s2fd->vcpu) || map_size != PMD_SIZE)
+			return false;
+	}
 
 	size = memslot->npages * PAGE_SIZE;
 
@@ -1630,6 +1632,9 @@ struct kvm_s2_fault_vma_info {
 	bool		map_non_cacheable;
 };
 
+static int kvm_s2_fault_get_vma_info(const struct kvm_s2_fault_desc *s2fd,
+				     struct kvm_s2_fault_vma_info *s2vi);
+
 static gfn_t get_canonical_gfn(const struct kvm_s2_fault_desc *s2fd,
 			       const struct kvm_s2_fault_vma_info *s2vi);
 
@@ -1719,12 +1724,12 @@ static int gmem_abort(const struct kvm_s2_fault_desc *s2fd)
 static int pkvm_mem_abort(const struct kvm_s2_fault_desc *s2fd)
 {
 	unsigned int flags = FOLL_HWPOISON | FOLL_LONGTERM | FOLL_WRITE;
+	struct kvm_s2_fault_vma_info s2vi = {};
 	struct kvm_vcpu *vcpu = s2fd->vcpu;
 	struct kvm_pgtable *pgt = vcpu->arch.hw_mmu->pgt;
 	struct mm_struct *mm = current->mm;
 	struct kvm *kvm = vcpu->kvm;
 	void *hyp_memcache;
-	struct page *page;
 	int ret;
 
 	hyp_memcache = get_mmu_memcache(vcpu);
@@ -1732,12 +1737,16 @@ static int pkvm_mem_abort(const struct kvm_s2_fault_desc *s2fd)
 	if (ret)
 		return -ENOMEM;
 
+	ret = kvm_s2_fault_get_vma_info(s2fd, &s2vi);
+	if (ret)
+		return ret;
+
 	ret = account_locked_vm(mm, 1, true);
 	if (ret)
 		return ret;
 
 	mmap_read_lock(mm);
-	ret = pin_user_pages(s2fd->hva, 1, flags, &page);
+	ret = pin_user_pages(s2fd->hva, 1, flags, &s2vi.page);
 	mmap_read_unlock(mm);
 
 	if (ret == -EHWPOISON) {
@@ -1747,7 +1756,7 @@ static int pkvm_mem_abort(const struct kvm_s2_fault_desc *s2fd)
 	} else if (ret != 1) {
 		ret = -EFAULT;
 		goto dec_account;
-	} else if (!folio_test_swapbacked(page_folio(page))) {
+	} else if (!folio_test_swapbacked(page_folio(s2vi.page))) {
 		/*
 		 * We really can't deal with page-cache pages returned by GUP
 		 * because (a) we may trigger writeback of a page for which we
@@ -1767,8 +1776,8 @@ static int pkvm_mem_abort(const struct kvm_s2_fault_desc *s2fd)
 	}
 
 	write_lock(&kvm->mmu_lock);
-	ret = pkvm_pgtable_stage2_map(pgt, s2fd->fault_ipa, PAGE_SIZE,
-				      page_to_phys(page), KVM_PGTABLE_PROT_RWX,
+	ret = pkvm_pgtable_stage2_map(pgt, gfn_to_gpa(s2vi.gfn), PAGE_SIZE,
+				      page_to_phys(s2vi.page), KVM_PGTABLE_PROT_RWX,
 				      hyp_memcache, 0);
 	write_unlock(&kvm->mmu_lock);
 	if (ret) {
@@ -1779,7 +1788,7 @@ static int pkvm_mem_abort(const struct kvm_s2_fault_desc *s2fd)
 
 	return 0;
 unpin:
-	unpin_user_pages(&page, 1);
+	unpin_user_page(s2vi.page);
 dec_account:
 	account_locked_vm(mm, 1, false);
 	return ret;
diff --git a/arch/arm64/kvm/pkvm.c b/arch/arm64/kvm/pkvm.c
index 8e4c6e4bec12..c298a5b9b12a 100644
--- a/arch/arm64/kvm/pkvm.c
+++ b/arch/arm64/kvm/pkvm.c
@@ -414,6 +414,9 @@ int pkvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
 	u64 end = addr + size;
 	int ret;
 
+	if (WARN_ON_ONCE(!PAGE_ALIGNED(addr | size)))
+		return -EINVAL;
+
 	lockdep_assert_held_write(&kvm->mmu_lock);
 	mapping = pkvm_mapping_iter_first(&pgt->pkvm_mappings, addr, end - 1);
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

