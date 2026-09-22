Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB615542EE6
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 13:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082516; cv=none; b=ly6R3whGY0nVxOGVdYFSZ/SLnGY5TOYsjq1vBFH+xAdij/xD37n3ioETsH5HCSTmr4NJySkH9crBxCRUrgA/llWw0U/VtSiaeA514g0kY6Ljc5I71ArKqlUzh4wNN8tIA1wuXJ5MyUOCX3Ew6R4uw6kjIlAx9lRg0nWhafmNIP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082516; c=relaxed/simple;
	bh=sWQysiUuLDCO1gA7DRjNHp2nzV403FdQ/lwZst3OfLM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Obg4waSDXFuUIR5jsrEHJCT88P+Y92x55bEmhTgNN26x0VwiVpyhKx8AwaRIY4zNHa8hssNZuoUh6AbmCz/vb16ejBSXtgpgVGdGjIDgFz2K31d/E0KXSoGpAbPSavV2DNLGVzaQuCAhc5+g9rFTiN1c4muPqx9zPuvkL1b/jWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ioh1fgs1; arc=none smtp.client-ip=209.85.218.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ioh1fgs1"
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c2939e341f7so467662166b.2
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 06:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790082513; x=1790687313; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6psWOVVyFeQFOY75EO2JMzQlsdjSGaYJxWUCFV1ZrrE=;
        b=ioh1fgs1lXKkcDhiyxq5pevUuBpxtdW6m7ZaV3WTrcKVB/51aPVvBPRND//X9gHZfR
         +G4yRaseH4O2qpHlb6UcVORmweJPpafzRa8Bn9Ex6BOMrgHCxpivywZuV7JQS/+MMVyw
         zSawOY96G6BTzk7+IhNbBgZ3+awLbKgi+NqwcDX7Z77fdh89ojCj/3AB5ZpRfpVN8J3j
         fWTswOMDrLB5vhw3Dq4X06VwFo8pMDWEiZ6lVqm0eCyVS8yyhMLsDiRByfzvJMcZCCBl
         Zuwbc31U+ZOrw44IbcV5g5LkgSY4kabPC8PBLaQpj9Xh9COmYy1Mg+tCXbD2TIot4h3p
         BBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790082513; x=1790687313;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6psWOVVyFeQFOY75EO2JMzQlsdjSGaYJxWUCFV1ZrrE=;
        b=mab9ZYZGAi2ftrFMgn/0YGjBnKVJ4b4t1cDcl7AXmUiaWVVvGy5WImoT7fWYCHpcrq
         6jQkI1bTMEYzMEXiNWtPvJlGIY8auuWCrHgXgl5gnHum9Dz9FnV62YLqpWjjN0jI8F5j
         +MXanqB+6pegd7ZDmv47SaZhbYZCy0T/LTOrIjH42tMncLV9i7GQ+KPl8vS+6JG/CByX
         yGU27xTeMF5XuTToin/4hY6W0d5S03+WKUdSHl737XC1Ua8J6NUKehuOfsq4JNI5KR/8
         EUSqL7Qdgq67VhcU0D63Zisiv2/7hqrWYQrWW/mgGWvGXHCP27RjmB5pOzCDsv+jlJdj
         81hQ==
X-Forwarded-Encrypted: i=1; AKwUvBxDiOgvL05maW+dz7V9YjmmqGD6g7VWG/9esF+zW1pSA2TOdy/zBHx4J8Qlxfvhp7Av7ILgOXA=@vger.kernel.org
X-Gm-Message-State: AFuF++neQt4g1q4E4cjB48aAdbhvN2nJFxV8dTLE5DMkYIKuxbrGGkgW
	bHJyVe3uMwAf5953Bw8wCx0eq+JQ19H5ALqhHdmj/upSCyS+H7brQimwROmbhizADFPn/sCGTwc
	7KUrFktgaOIKDRfrgdeRxAg==
X-Received: from ejsr12.prod.google.com ([2002:a17:906:7fcc:b0:c1c:2696:91f1])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:c10b:b0:c26:19de:9139 with SMTP id a640c23a62f3a-c2a15cf8ea1mr1328780266b.44.1790082512677;
 Tue, 22 Sep 2026 06:08:32 -0700 (PDT)
Date: Tue, 22 Sep 2026 14:08:21 +0100
In-Reply-To: <20260922130821.1666713-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260922130821.1666713-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922130821.1666713-7-vdonnefort@google.com>
Subject: [PATCH v1 6/6] KVM: arm64: Use kvm_s2_fault_vma_info in pkvm_mem_abort()
From: Vincent Donnefort <vdonnefort@google.com>
To: maz@kernel.org, oupton@kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: joey.gouly@arm.com, seiden@linux.ibm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org, 
	kernel-team@android.com, fuad.tabba@linux.dev, qperret@google.com, 
	Vincent Donnefort <vdonnefort@google.com>, stable@vger.kernel.org
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
---
 arch/arm64/kvm/mmu.c  | 24 +++++++++++++++---------
 arch/arm64/kvm/pkvm.c |  3 +++
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index ee0fcca838c1..167b769107ee 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1374,9 +1374,11 @@ static bool fault_supports_stage2_huge_mapping(const struct kvm_s2_fault_desc *s
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
 
@@ -2167,12 +2169,12 @@ int kvm_handle_guest_sea(struct kvm_vcpu *vcpu)
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
@@ -2180,12 +2182,16 @@ static int pkvm_mem_abort(const struct kvm_s2_fault_desc *s2fd)
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
@@ -2195,7 +2201,7 @@ static int pkvm_mem_abort(const struct kvm_s2_fault_desc *s2fd)
 	} else if (ret != 1) {
 		ret = -EFAULT;
 		goto dec_account;
-	} else if (!folio_test_swapbacked(page_folio(page))) {
+	} else if (!folio_test_swapbacked(page_folio(s2vi.page))) {
 		/*
 		 * We really can't deal with page-cache pages returned by GUP
 		 * because (a) we may trigger writeback of a page for which we
@@ -2215,8 +2221,8 @@ static int pkvm_mem_abort(const struct kvm_s2_fault_desc *s2fd)
 	}
 
 	write_lock(&kvm->mmu_lock);
-	ret = pkvm_pgtable_stage2_map(pgt, s2fd->fault_ipa, PAGE_SIZE,
-				      page_to_phys(page), KVM_PGTABLE_PROT_RWX,
+	ret = pkvm_pgtable_stage2_map(pgt, gfn_to_gpa(s2vi.gfn), PAGE_SIZE,
+				      page_to_phys(s2vi.page), KVM_PGTABLE_PROT_RWX,
 				      hyp_memcache, 0);
 	write_unlock(&kvm->mmu_lock);
 	if (ret) {
@@ -2227,7 +2233,7 @@ static int pkvm_mem_abort(const struct kvm_s2_fault_desc *s2fd)
 
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
2.55.0.1082.g2b9226bbc0-goog

