Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FB23A5435;
	Tue, 13 Oct 2026 23:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791933461; cv=none; b=PKZiwMsOxEPVSdLf2SQVDTSHp25KdY0cX1IUY2HdcqaMp+MfUBHXCnxJAJ4Cl1N3nglI3ebZAbaL6aB/PniX35z9UbtUK9pordH4B58s4qG1OqVkI915O/VXZG515xFFkLCM59e8EKjma24khRyZVp8h0Axip1oCNcXkA7nR8aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791933461; c=relaxed/simple;
	bh=cg+AVSbpa23OTJo/i7DbFiKB/9MVmmmaiuRAnCY4vP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EUB1yMAhWNqUCWc0E7llKLm//U5FJPJ4odW/KKAqfDsHJfu5kdD35UE2FyKSpMk1qt8HVMemhtBw6C9TeVbrbPRPc9isDj8xQ2clONHGDU68zOZ+uE8xegIpZccSUZxAiqTZlo0zain+GTeN2Q28xmqMeZwSD+K8HzEXhDStLs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MP5VB8qp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MP5VB8qp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD831F00893;
	Tue, 13 Oct 2026 23:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791933459;
	bh=Gx9aN5nwU70I/uG4l/rmyx+6VO9Z/JDI4+6yjYDx+Fs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MP5VB8qpr6jmeDhB98BYl6Ilrpon21T26zyRoCUzWdxuUeOL78zysq841hRS9U5T5
	 bR1uL9JGIxh8STPtaUBFOgwq5x/rI0VCLa+NnDAMcUlWeCpLDqsy+w1XoVImT6FkgP
	 R7Zy8Ljc8fIM1SGTNnJBDlxBkHlPXvfuIgjo0GWgPqxlL5YtWUX4qo/dpoxlVkKzya
	 8rabyCGOhRiTOZ4mp5hRH8h7WX149Yn2rFbjyQ6+B5XIIlb60y/AvS7XjTm2cRDEqP
	 FyBF5JUVmCR1l/4pFrJ8NHLu8Y6/07K7cPohInWCsDXeFcX5PzPgbW3RvMyhxPyoLn
	 sGOg+FvjdI63Q==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 3/4] KVM: x86/mmu: Don't sync cached roots created for a different MMU context
Date: Tue, 13 Oct 2026 23:17:27 +0000
Message-ID: <20261013231728.883001-4-yosry@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261013231728.883001-1-yosry@kernel.org>
References: <20261013231728.883001-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When invalidating an address (e.g. emulating INVLPG), KVM walks and
syncs the cached (previous) roots in addition to the current root.
The walk uses the current MMU's root level, and the sync uses the
current MMU's sync_spte() and page table walker, i.e. KVM assumes that
cached roots were created for the current MMU context.

This assumption does not hold for nested virtualization.  Nested
transitions re-initialize the MMU and load a new PGD without unloading
cached roots, so the cached roots may belong to a different MMU context
(e.g. a different paging mode).  Outside of nested transitions, this is
not possible, as changing CR0, CR4, or EFER in a way that affects the
MMU context resets the MMU, unloading all roots.

For example, with shadow paging, if a 64-bit L1 runs a 32-bit PAE L2,
L1's 4-level root is cached while L2 is running with a PAE root.  If L2
executes INVLPG and L1 doesn't intercept it, KVM walks L1's root using
L2's PAE root level, which hits the WARN (previously BUG) in
shadow_walk_init_using_root().  Similarly, with nested EPT,
nested_ept_invalidate_addr() can walk a cached root at the wrong level
if L1 uses the same EPT root with a different page-walk length.

Note, the WARN is only reachable if TDP is disabled, as KVM only syncs
the root_mmu's cached roots if TDP is disabled, and the only other flow
that syncs cached roots, nested_ept_invalidate_addr(), never uses a PAE
MMU.

Only walk cached roots if their role matches the current MMU's root role,
and sync the rest by freeing them if they have unsync children.  Check
the role in shadow_walk_init_using_root(), i.e. with mmu_lock held, as
zapping a root (e.g. due to a guest write to the page table it shadows)
marks it invalid, changing its role.

Note, comparing the full role, including guest_mode, doesn't affect
nested EPT fault injection (nested_ept_invalidate_addr()), as all of the
guest_mmu's roots, and its root role, have guest_mode set.  The only
casualty is nested virtualization with TDP disabled, where L1 and L2
share the root_mmu, i.e. their roots differ in guest_mode even if they're
otherwise compatible, e.g. INVLPG in L1 will now free L2's unsync roots
instead of syncing them.  But nested with TDP disabled isn't worth
optimizing.

Opportunistically WARN if the current root can't be invalidated, and
free it, even though that should be impossible.

Fixes: 7eb77e9f5fcf ("kvm: x86: Add a root_hpa parameter to kvm_mmu->invlpg()")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/mmu/mmu.c | 56 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 2fc23a36433c5..0b78c56f771b7 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2547,7 +2547,8 @@ static void shadow_walk_init_using_root(struct kvm_shadow_walk_iterator *iterato
 					struct kvm_vcpu *vcpu, hpa_t root,
 					u64 addr)
 {
-	struct kvm_pagewalk *w = vcpu->arch.mmu->w;
+	struct kvm_mmu *mmu = vcpu->arch.mmu;
+	struct kvm_pagewalk *w = mmu->w;
 
 	iterator->addr = addr;
 	iterator->shadow_addr = root;
@@ -2555,6 +2556,18 @@ static void shadow_walk_init_using_root(struct kvm_shadow_walk_iterator *iterato
 	if (WARN_ON_ONCE(!VALID_PAGE(root)) || kvm_mmu_is_dummy_root(root))
 		goto error;
 
+	/*
+	 * Cached roots are walked using the current MMU context, and so can
+	 * only be walked if they were created for the same context, which
+	 * isn't guaranteed as nested transitions don't unload cached roots.
+	 */
+	if (root != mmu->root.hpa) {
+		struct kvm_mmu_page *sp = root_to_sp(root);
+
+		if (WARN_ON_ONCE(!sp) || sp->role.word != mmu->root_role.word)
+			goto error;
+	}
+
 	iterator->level = vcpu->arch.mmu->root_role.level;
 
 	if (iterator->level >= PT64_ROOT_4LEVEL &&
@@ -6729,7 +6742,11 @@ void kvm_mmu_print_sptes(struct kvm_vcpu *vcpu, gpa_t gpa, const char *msg)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_mmu_print_sptes);
 
-static void __kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
+/*
+ * Returns false if the address cannot be invalidated, and the caller needs to
+ * free the entire root instead.
+ */
+static bool __kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 				      u64 addr, hpa_t root_hpa)
 {
 	struct kvm_shadow_walk_iterator iterator;
@@ -6742,13 +6759,23 @@ static void __kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu
 	 * this is ever used to sync the guest_mmu, e.g. to emulate INVEPT.
 	 */
 	if (WARN_ON_ONCE(mmu != vcpu->arch.mmu))
-		return;
+		return false;
 
 	if (!VALID_PAGE(root_hpa))
-		return;
+		return true;
 
-	write_lock(&vcpu->kvm->mmu_lock);
+	guard(write_lock)(&vcpu->kvm->mmu_lock);
 	shadow_walk_init_using_root(&iterator, vcpu, root_hpa, addr);
+
+	/*
+	 * Sync cached roots that can't be walked by freeing them if they have
+	 * unsync children.  Roots that aren't backed by shadow pages (PAE and
+	 * dummy roots) are never cached, and failing to walk them means that
+	 * nothing is mapped at @addr, e.g. the relevant PDPTE isn't present.
+	 */
+	if (!shadow_walk_okay(&iterator))
+		return !root_to_sp(root_hpa) || !is_unsync_root(root_hpa);
+
 	for ( ; shadow_walk_okay(&iterator); shadow_walk_next(&iterator)) {
 		struct kvm_mmu_page *sp = sptep_to_sp(iterator.sptep);
 
@@ -6764,12 +6791,13 @@ static void __kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu
 		if (!sp->unsync_children)
 			break;
 	}
-	write_unlock(&vcpu->kvm->mmu_lock);
+	return true;
 }
 
 void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 			     u64 addr, unsigned long roots)
 {
+	unsigned long roots_to_free = 0;
 	struct kvm_mmu *mmu;
 	int i;
 
@@ -6795,13 +6823,21 @@ void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 	if (!mmu->sync_spte)
 		return;
 
-	if (roots & KVM_MMU_ROOT_CURRENT)
-		__kvm_mmu_invalidate_addr(vcpu, mmu, addr, mmu->root.hpa);
+	if (roots & KVM_MMU_ROOT_CURRENT) {
+		if (WARN_ON_ONCE(!__kvm_mmu_invalidate_addr(vcpu, mmu, addr, mmu->root.hpa)))
+			roots_to_free |= KVM_MMU_ROOT_CURRENT;
+	}
 
 	for (i = 0; i < KVM_MMU_NUM_PREV_ROOTS; i++) {
-		if (roots & KVM_MMU_ROOT_PREVIOUS(i))
-			__kvm_mmu_invalidate_addr(vcpu, mmu, addr, mmu->prev_roots[i].hpa);
+		if (!(roots & KVM_MMU_ROOT_PREVIOUS(i)))
+			continue;
+
+		if (!__kvm_mmu_invalidate_addr(vcpu, mmu, addr, mmu->prev_roots[i].hpa))
+			roots_to_free |= KVM_MMU_ROOT_PREVIOUS(i);
 	}
+
+	if (roots_to_free)
+		kvm_mmu_free_roots(vcpu->kvm, mmu, roots_to_free);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_mmu_invalidate_addr);
 
-- 
2.56.0.385.gd3acb90ef8-goog

