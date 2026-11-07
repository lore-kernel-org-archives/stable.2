Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045841;
	b=uoqG/mos/Qcn8C2Z7KRNaEqRuzaPU3mky6k7siZF9Aqj5N9bLfFBy9HlkXOIgrJRtdHN
	 P2qx1fYi5GIaSuCkqZXvfc5uWdQY51AZ8CXTf/SJP09d2YcPjVqhJlU4zr+Is8M7mqR7V
	 AdDjiwFNFRnAjyGRKrknDkGUjlYkO0SYUFVzgKXXFGTTCqwLN4Ro4SenvQ309clAlu8Uy
	 B8hlzn2mEZ8Qh3GSDES80iKqkwnpov37jRO0CevoR6hmHlz5EurfjKJAplkuKhGABHxeU
	 l+9oC0Psq9vzpbLGBl0LTfD0+G0GVL1YVtu6Fxe+Q749EF4WxuRjztDrVJCdolTDEzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045841;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=sWUsH2W8H3NIFmjLC1vPfBDd5QdAXOSp1a1lMsH5nyg=;
	b=PJZAFssf0EywR0wekn2l5w0dFBMnwTpBrAkNanfkWHxGQ1OLa6NqFad3CNe2hZ5Y/Rdw
	 ha2iUw+ySxkZCECu5y3KII7YParE7oJJCcCBJz/aXVIETuP6kfe/k++hYE+UEyONgv2or
	 WEBzrSZviK8g4wTS7wSyyTBiweCqEWrtu0ySLh0COvvnt1izhhuXgWlVPIDRF+EU70jju
	 Sz4pR5rsAH1bG/bU7oKd+Q7uCk2jZl20G8BjUuuX9blUnqpBx+dJHZOmjQ0g/Ybw0B0Lf
	 OFdueRE1WjXiWmfem6dCn7VALVSIrHms+4i+lEysz+zHDQ9+mew1cK6CplAzOf1BhLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iej+K3YW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C07606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iej+K3YW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EAA51F0089F;
	Sat,  7 Nov 2026 10:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045841;
	bh=sWUsH2W8H3NIFmjLC1vPfBDd5QdAXOSp1a1lMsH5nyg=;
	h=From:To:Cc:Subject:Date;
	b=iej+K3YWZ/Q7Cv2L7UTPVdtflOHr90Boze6Gf7Voa6Y/fRILYpOZ0EPicX4R68RT7
	 7OI4h7116kN0aA1bomR3QhhS3vhPaDmfaqsGLcOyWAfOL2tc1AlwCy4ez1pPmqQd5l
	 a7dPJgLG7QPxYZPP0Z/ihamv3DYWTFd0JpQXc4lYkkbUjPuhbeJQJn2Yh5EXiwQ2QS
	 /wASfBsJQtLEYcx60xZ48HMdAMMFNY9NtzzvVa9plZ7ki7cAYLmMRMHDG86ahxACDk
	 KFiFWcja0PXj8/q3tBYYFFiWEelfHYuSSZsF5UHCEL59mMvxHzZNlnI7y99fNi91Rr
	 VedN4O0p0BaaQ==
From: Sasha Levin <sashal@kernel.org>
To: vdonnefort@google.com,
	fuad.tabba@linux.dev,
	maz@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: arm64: Use kvm_s2_fault_vma_info in pkvm_mem_abort()" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:03:59 -0500
Message-ID: <20261107050359-failed-7.3-0cdcc1039200@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 0cdcc1039200b3c4fbc2ae3f9b5c1be1bc9155e8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050359-failed-7.3-0cdcc1039200@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 0cdcc1039200b3c4fbc2ae3f9b5c1be1bc9155e8 Mon Sep 17 00:00:00 2001
From: Vincent Donnefort <vdonnefort@google.com>
Date: Mon, 28 Sep 2026 10:54:53 +0100
Subject: [PATCH] KVM: arm64: Use kvm_s2_fault_vma_info in pkvm_mem_abort()

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
Link: https://patch.msgid.link/20260928095454.3255918-5-vdonnefort@google.com
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/mmu.c  | 27 ++++++++++++++++++---------
 arch/arm64/kvm/pkvm.c |  3 +++
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 658ac6a09e7ba..9ee5a5c122cbf 100644
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
 
@@ -1621,6 +1623,9 @@ struct kvm_s2_fault_vma_info {
 	bool		map_non_cacheable;
 };
 
+static int kvm_s2_fault_get_vma_info(const struct kvm_s2_fault_desc *s2fd,
+				     struct kvm_s2_fault_vma_info *s2vi);
+
 static gfn_t get_canonical_gfn(const struct kvm_s2_fault_desc *s2fd,
 			       const struct kvm_s2_fault_vma_info *s2vi);
 
@@ -1710,12 +1715,12 @@ static int gmem_abort(const struct kvm_s2_fault_desc *s2fd)
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
@@ -1723,12 +1728,16 @@ static int pkvm_mem_abort(const struct kvm_s2_fault_desc *s2fd)
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
@@ -1738,7 +1747,7 @@ static int pkvm_mem_abort(const struct kvm_s2_fault_desc *s2fd)
 	} else if (ret != 1) {
 		ret = -EFAULT;
 		goto dec_account;
-	} else if (!folio_test_swapbacked(page_folio(page))) {
+	} else if (!folio_test_swapbacked(page_folio(s2vi.page))) {
 		/*
 		 * We really can't deal with page-cache pages returned by GUP
 		 * because (a) we may trigger writeback of a page for which we
@@ -1758,8 +1767,8 @@ static int pkvm_mem_abort(const struct kvm_s2_fault_desc *s2fd)
 	}
 
 	write_lock(&kvm->mmu_lock);
-	ret = pkvm_pgtable_stage2_map(pgt, s2fd->fault_ipa, PAGE_SIZE,
-				      page_to_phys(page), KVM_PGTABLE_PROT_RWX,
+	ret = pkvm_pgtable_stage2_map(pgt, gfn_to_gpa(s2vi.gfn), PAGE_SIZE,
+				      page_to_phys(s2vi.page), KVM_PGTABLE_PROT_RWX,
 				      hyp_memcache, 0);
 	write_unlock(&kvm->mmu_lock);
 	if (ret) {
@@ -1770,7 +1779,7 @@ static int pkvm_mem_abort(const struct kvm_s2_fault_desc *s2fd)
 
 	return 0;
 unpin:
-	unpin_user_pages(&page, 1);
+	unpin_user_page(s2vi.page);
 dec_account:
 	account_locked_vm(mm, 1, false);
 	return ret;
diff --git a/arch/arm64/kvm/pkvm.c b/arch/arm64/kvm/pkvm.c
index 8e4c6e4bec123..c298a5b9b12a6 100644
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
2.53.0




