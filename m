Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311201;
	b=X8WvBNGJKb2PenRdnIo28IvqRE1d7eHFxiYUZGMviIZYzOkg1CZ1ifdBplpmKzh+tfPa
	 FaZ2b8V2Tvbg9Zp9NIu9ncbz5BwrdR8rrm157M3f3NKnbrK7tvVrfMBVNqZ5cAiBDSzJ+
	 QI5YlzlD/STR4XCGeNDCTKlyRqq/bIvmmcqSyyHi9d8P6MTCNffxYIO3matso4o0zS4mj
	 kT3mGpvVv93Nn4Cej6YJ7zyuNaAfsXI/Pzt/pdlBw1KBOGIJQjyzPNqqJK6jP5WZc+Jjz
	 qUrspTjOwIGWRr2kA4XE+orutlFqB6b7Zvv1EQhlx/BVanW3cIPKaoQWs+8KdLsnGMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311201;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Z0RbsDiQgZF7rK2SoloJ6T60ditn+MWkzuqDZufg570=;
	b=uElAChwM+8RJTaqzLxfIXlVQEKL9MhoB6tNLp/zVafLLiQFTQgFNPSHDecMVSqE3qLg+
	 +RDWWFtx3YhFq5qOLIiPMfCOtbA5irKoi8yn+S6D4RXytSeDDPnJ1+5yTwiWZ2xKPuGhS
	 Em0sgbUdu8r3HLwJzrpaWqZIkQJpdHn3x3AgY9MqAs20JiGVewiHqkTLdajTzDUKMV19w
	 PWbFUAp712lr9GP6f/QHLuuEv/zQIglq7A9EWD16dHygJM1ERuxuIOyKyiBtdRLgff5iM
	 qrvaXfeUw7PQ3hrBUeaVuR8iW9U9gRYOnXpKVy7TbEowS4R8WYi9L1XRFAEPOnCvrhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=om5hDtwX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F523606A330
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 11:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=om5hDtwX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD181F008A2;
	Tue, 10 Nov 2026 11:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794311201;
	bh=Z0RbsDiQgZF7rK2SoloJ6T60ditn+MWkzuqDZufg570=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=om5hDtwXwsQqsKOXfMPLf+Jn2f4X/lirNhSdtMSWrBUiA35ZKBAneaaNCQv5RLozy
	 rz+Sj8a+pvSwnR6/ZP1TbPQSmI+d4XEjdKoLZxOnLKsw9oGPnGgfg/fGRZJnl+ISs6
	 YpApyQsycjdtouUlag0zQvmj+1+xqH7nJLFqEV0EeNS8ftCh8aGLrc634bjkOQ9XVA
	 nKK8DWKXl6rO6NGFtFYFLvqykhfLLLZifllwJOq1gnZWbuYF6m7cpvhB2856cede7+
	 AG+RFvL8h/M+/qOTlUVurpRIHKbii9hhfbtiYENCdhe2MolZ6vrDdcZwzebJWlfds8
	 288b+JdI9VVAA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fuad Tabba <fuad.tabba@linux.dev>,
	Sashiko <sashiko-bot@kernel.org>,
	Vincent Donnefort <vdonnefort@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 2/2] KVM: arm64: Use kvm_s2_fault_vma_info in gmem_abort()
Date: Tue, 10 Nov 2026 06:46:37 -0500
Message-ID: <20261110114632.607777-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110114632.607777-1-sashal@kernel.org>
References: <20261107050354-failed-7.3-80b0b86dc5e4@kernel.org>
 <20261110114632.607777-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fuad Tabba <fuad.tabba@linux.dev>

[ Upstream commit 80b0b86dc5e4344e62a2fd3ee43d0ef816fe9122 ]

gmem_abort() maps at s2fd->fault_ipa, which HPFAR_EL2 holds at 4K
granularity whatever the page size. The generic page-table code aligns
it, but pkvm_pgtable_stage2_map() looks up existing mappings over
[addr, addr + size), so on a pKVM host with pages larger than 4K a
guest_memfd-backed guest that faults past the first 4K of a page can
find its neighbour's mapping, get -EAGAIN and take the same fault
forever.

The memory fault exit reports s2fd->fault_ipa too, which for a nested
guest's fault is the nested IPA rather than the canonical one
kvm_gmem_get_pfn() failed on.

Take the addresses from kvm_s2_fault_vma_info instead, as
user_mem_abort() does, and report the canonical gfn in the memory fault
exit. kvm_s2_fault_get_vma_info() itself isn't called: a guest_memfd
memslot's userspace_addr doesn't need to be backed by a VMA.

Fixes: a7b57e0995927 ("KVM: arm64: Handle guest_memfd-backed guest page faults")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/20260913175105.A57AC1F000FF@smtp.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Link: https://patch.msgid.link/20260928095454.3255918-4-vdonnefort@google.com
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kvm/mmu.c | 67 ++++++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 33 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 291696dda0741..9ebc17d3e0c00 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1594,6 +1594,24 @@ static enum kvm_pgtable_prot adjust_nested_exec_perms(struct kvm *kvm,
 	return prot;
 }
 
+struct kvm_s2_fault_vma_info {
+	unsigned long	mmu_seq;
+	long		vma_pagesize;
+	vm_flags_t	vm_flags;
+	unsigned long	max_map_size;
+	struct page	*page;
+	kvm_pfn_t	pfn;
+	gfn_t		gfn;
+	bool		device;
+	bool		mte_allowed;
+	bool		is_vma_cacheable;
+	bool		map_writable;
+	bool		map_non_cacheable;
+};
+
+static gfn_t get_canonical_gfn(const struct kvm_s2_fault_desc *s2fd,
+			       const struct kvm_s2_fault_vma_info *s2vi);
+
 static int gmem_abort(const struct kvm_s2_fault_desc *s2fd)
 {
 	bool write_fault, exec_fault;
@@ -1601,12 +1619,10 @@ static int gmem_abort(const struct kvm_s2_fault_desc *s2fd)
 	enum kvm_pgtable_walk_flags flags = KVM_PGTABLE_WALK_SHARED;
 	enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_R;
 	struct kvm_pgtable *pgt = s2fd->vcpu->arch.hw_mmu->pgt;
-	unsigned long mmu_seq;
-	struct page *page;
+	struct kvm_s2_fault_vma_info s2vi = {};
 	struct kvm *kvm = s2fd->vcpu->kvm;
 	void *memcache = NULL;
-	kvm_pfn_t pfn;
-	gfn_t gfn;
+	gfn_t canonical_gfn;
 	int ret;
 
 	if (!perm_fault) {
@@ -1616,24 +1632,23 @@ static int gmem_abort(const struct kvm_s2_fault_desc *s2fd)
 			return ret;
 	}
 
-	if (s2fd->nested)
-		gfn = kvm_s2_trans_output(s2fd->nested) >> PAGE_SHIFT;
-	else
-		gfn = s2fd->fault_ipa >> PAGE_SHIFT;
+	s2vi.vma_pagesize = PAGE_SIZE;
+	s2vi.gfn = ALIGN_DOWN(s2fd->fault_ipa, s2vi.vma_pagesize) >> PAGE_SHIFT;
+	canonical_gfn = get_canonical_gfn(s2fd, &s2vi);
 
 	write_fault = kvm_is_write_fault(s2fd->vcpu);
 	exec_fault = kvm_vcpu_trap_is_exec_fault(s2fd->vcpu);
 
 	VM_WARN_ON_ONCE(write_fault && exec_fault);
 
-	mmu_seq = kvm->mmu_invalidate_seq;
+	s2vi.mmu_seq = kvm->mmu_invalidate_seq;
 	/* Pairs with the smp_wmb() in kvm_mmu_invalidate_end(). */
 	smp_rmb();
 
-	ret = kvm_gmem_get_pfn(kvm, s2fd->memslot, gfn, &pfn, &page, NULL);
+	ret = kvm_gmem_get_pfn(kvm, s2fd->memslot, canonical_gfn, &s2vi.pfn, &s2vi.page, NULL);
 	if (ret) {
-		kvm_prepare_memory_fault_exit(s2fd->vcpu, s2fd->fault_ipa, PAGE_SIZE,
-					      write_fault, exec_fault, false);
+		kvm_prepare_memory_fault_exit(s2fd->vcpu, gfn_to_gpa(canonical_gfn),
+					      s2vi.vma_pagesize, write_fault, exec_fault, false);
 		return ret;
 	}
 
@@ -1650,7 +1665,7 @@ static int gmem_abort(const struct kvm_s2_fault_desc *s2fd)
 		prot = adjust_nested_exec_perms(kvm, s2fd->nested, prot);
 
 	kvm_fault_lock(kvm);
-	if (mmu_invalidate_retry(kvm, mmu_seq)) {
+	if (mmu_invalidate_retry(kvm, s2vi.mmu_seq)) {
 		ret = -EAGAIN;
 		goto out_unlock;
 	}
@@ -1661,39 +1676,25 @@ static int gmem_abort(const struct kvm_s2_fault_desc *s2fd)
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
-		mark_page_dirty_in_slot(kvm, s2fd->memslot, gfn);
+		mark_page_dirty_in_slot(kvm, s2fd->memslot, canonical_gfn);
 
 	return ret != -EAGAIN ? ret : 0;
 }
 
-struct kvm_s2_fault_vma_info {
-	unsigned long	mmu_seq;
-	long		vma_pagesize;
-	vm_flags_t	vm_flags;
-	unsigned long	max_map_size;
-	struct page	*page;
-	kvm_pfn_t	pfn;
-	gfn_t		gfn;
-	bool		device;
-	bool		mte_allowed;
-	bool		is_vma_cacheable;
-	bool		map_writable;
-	bool		map_non_cacheable;
-};
-
 static int pkvm_mem_abort(const struct kvm_s2_fault_desc *s2fd)
 {
 	unsigned int flags = FOLL_HWPOISON | FOLL_LONGTERM | FOLL_WRITE;
-- 
2.53.0

