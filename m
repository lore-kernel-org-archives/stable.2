Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16879426689
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 12:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785413756; cv=none; b=lsQhA2UeLHD8+UsopgyrM84fbpZAa8fg3jXhXFF+HblSyDM975Ke2Vdf2iz70icyMpKRUc48gdj+iRZe+fNKTVC1Pp7uY8AManTGWmIi0KNa1hJeW+X4WbQn1uw1q6Z8ThyH898nv+pVl0NXYF1nDa+eKMkB8+DivAH40TNaYys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785413756; c=relaxed/simple;
	bh=tPukZg+77zRrSQajjVAesPNPCzsg05Mah5zclWga4g8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s4ZzZrrCUhjfY+LMb9C+GNOrE0Q5m/IOL0sNfYX9NSyimNLqRyqKWsE1WkdktzodXpR6cZWfxC2LEHqJaRqf0k5twP5A9Q0CbZGDvojt9RTqukWLfieNV5MJD+KOl1G6lgjO5zSdA0vSkqfjJV2qgj6EqoMb7om11kQoGsbd6Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4WBQuck; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4WBQuck"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A60D1F00A3A;
	Thu, 30 Jul 2026 12:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785413737;
	bh=/oWWySjx2BcHeoiWW0WdaivF4hrAov1HJhddvWk5lzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z4WBQuckA1mBkHdmaFdZ3ybrMNFWukcp/igQhMukHotuz+ElBKsukH3a7yMlj9e3A
	 PAfH5mHpQdYT0EOKm2DBNuT+xkxJ7niwDvS1AoYQLFCqiRHkU2+f8pHx/Zxj++Ld+D
	 ACtqJCdByHEqWgKqfl7Ts7IAY9Me1jLfa+uwhQTlpA+KTBQqGg54QFgCMF8xHsYSau
	 kKNSh4vS1fKmpbUsqUwnvUvCTwVHpVpDeCLjfwX7H8aYbkbe5Gj/3SsZXtQpaN8Xph
	 N73EJi71whchuqbejqCJU4Sb+kHcNn2SZqJNYTUwiRZo33JD3ahjf3+poLQGrNTBRq
	 Nrb11j1IR6+7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Matlack <dmatlack@google.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] KVM: x86/mmu: Rename __direct_map() to direct_map()
Date: Thu, 30 Jul 2026 08:15:34 -0400
Message-ID: <20260730121535.2208491-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072556-gem-immunize-5c2f@gregkh>
References: <2026072556-gem-immunize-5c2f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Matlack <dmatlack@google.com>

[ Upstream commit 6c882ef4fc7bd99b67ad152e75428b669281c521 ]

Rename __direct_map() to direct_map() since the leading underscores are
unnecessary. This also makes the page fault handler names more
consistent: kvm_tdp_mmu_page_fault() calls kvm_tdp_mmu_map() and
direct_page_fault() calls direct_map().

Opportunistically make some trivial cleanups to comments that had to be
modified anyway since they mentioned __direct_map(). Specifically, use
"()" when referring to functions, and include kvm_tdp_mmu_map() among
the various callers of disallowed_hugepage_adjust().

No functional change intended.

Signed-off-by: David Matlack <dmatlack@google.com>
Reviewed-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20220921173546.2674386-11-dmatlack@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: 2abd5287f083 ("KVM: x86: Check for invalid/obsolete root *after* making MMU pages available")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/mmu/mmu.c          | 61 ++++++++++++++++-----------------
 arch/x86/kvm/mmu/mmu_internal.h |  3 +-
 arch/x86/kvm/mmu/paging_tmpl.h  |  6 +---
 3 files changed, 33 insertions(+), 37 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 7785da8f0ad339..945cf6a7562b72 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3102,11 +3102,11 @@ void disallowed_hugepage_adjust(struct kvm_page_fault *fault, u64 spte, int cur_
 	    is_shadow_present_pte(spte) &&
 	    !is_large_pte(spte)) {
 		/*
-		 * A small SPTE exists for this pfn, but FNAME(fetch)
-		 * and __direct_map would like to create a large PTE
-		 * instead: just force them to go down another level,
-		 * patching back for them into pfn the next 9 bits of
-		 * the address.
+		 * A small SPTE exists for this pfn, but FNAME(fetch),
+		 * direct_map(), or kvm_tdp_mmu_map() would like to create a
+		 * large PTE instead: just force them to go down another level,
+		 * patching back for them into pfn the next 9 bits of the
+		 * address.
 		 */
 		u64 page_mask = KVM_PAGES_PER_HPAGE(cur_level) -
 				KVM_PAGES_PER_HPAGE(cur_level - 1);
@@ -3115,7 +3115,7 @@ void disallowed_hugepage_adjust(struct kvm_page_fault *fault, u64 spte, int cur_
 	}
 }
 
-static int __direct_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
+static int direct_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 {
 	struct kvm_shadow_walk_iterator it;
 	struct kvm_mmu_page *sp;
@@ -4157,6 +4157,9 @@ static int kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 	struct kvm_memory_slot *slot = fault->slot;
 	bool async;
 
+	fault->mmu_seq = vcpu->kvm->mmu_invalidate_seq;
+	smp_rmb();
+
 	/*
 	 * Retry the page fault if the gfn hit a memslot that is being deleted
 	 * or moved.  This ensures any existing SPTEs for the old memslot will
@@ -4213,8 +4216,7 @@ static int kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
  * root was invalidated by a memslot update or a relevant mmu_notifier fired.
  */
 static bool is_page_fault_stale(struct kvm_vcpu *vcpu,
-				struct kvm_page_fault *fault,
-				unsigned long mmu_seq)
+				struct kvm_page_fault *fault)
 {
 	struct kvm_mmu_page *sp = to_shadow_page(vcpu->arch.mmu->root.hpa);
 
@@ -4234,14 +4236,13 @@ static bool is_page_fault_stale(struct kvm_vcpu *vcpu,
 		return true;
 
 	return fault->slot &&
-	       mmu_invalidate_retry_hva(vcpu->kvm, mmu_seq, fault->hva);
+	       mmu_invalidate_retry_hva(vcpu->kvm, fault->mmu_seq, fault->hva);
 }
 
 static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 {
 	bool is_tdp_mmu_fault = is_tdp_mmu(vcpu->arch.mmu);
 
-	unsigned long mmu_seq;
 	kvm_pfn_t orig_pfn;
 	int r;
 
@@ -4259,43 +4260,41 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	if (r)
 		return r;
 
-	mmu_seq = vcpu->kvm->mmu_invalidate_seq;
-	smp_rmb();
-
 	r = kvm_faultin_pfn(vcpu, fault);
 	if (r != RET_PF_CONTINUE)
 		return r;
-
 	r = handle_abnormal_pfn(vcpu, fault, ACC_ALL);
 	if (r != RET_PF_CONTINUE)
 		return r;
 
 	orig_pfn = fault->pfn;
 
+	if (is_tdp_mmu_fault) {
+		r = RET_PF_RETRY;
+		read_lock(&vcpu->kvm->mmu_lock);
+
+		if (!is_page_fault_stale(vcpu, fault))
+			r = kvm_tdp_mmu_map(vcpu, fault);
+
+		read_unlock(&vcpu->kvm->mmu_lock);
+		kvm_release_pfn_clean(orig_pfn);
+		return r;
+	}
+
 	r = RET_PF_RETRY;
+	write_lock(&vcpu->kvm->mmu_lock);
 
-	if (is_tdp_mmu_fault)
-		read_lock(&vcpu->kvm->mmu_lock);
-	else
-		write_lock(&vcpu->kvm->mmu_lock);
+	if (is_page_fault_stale(vcpu, fault))
+		goto out_unlock;
 
-	if (is_page_fault_stale(vcpu, fault, mmu_seq))
+	r = make_mmu_pages_available(vcpu);
+	if (r)
 		goto out_unlock;
 
-	if (is_tdp_mmu_fault) {
-		r = kvm_tdp_mmu_map(vcpu, fault);
-	} else {
-		r = make_mmu_pages_available(vcpu);
-		if (r)
-			goto out_unlock;
-		r = __direct_map(vcpu, fault);
-	}
+	r = direct_map(vcpu, fault);
 
 out_unlock:
-	if (is_tdp_mmu_fault)
-		read_unlock(&vcpu->kvm->mmu_lock);
-	else
-		write_unlock(&vcpu->kvm->mmu_lock);
+	write_unlock(&vcpu->kvm->mmu_lock);
 	kvm_release_pfn_clean(orig_pfn);
 	return r;
 }
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index 5e4be3bb3624ce..009024d421831a 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -197,7 +197,7 @@ struct kvm_page_fault {
 
 	/*
 	 * Maximum page size that can be created for this fault; input to
-	 * FNAME(fetch), __direct_map and kvm_tdp_mmu_map.
+	 * FNAME(fetch), direct_map() and kvm_tdp_mmu_map().
 	 */
 	u8 max_level;
 
@@ -220,6 +220,7 @@ struct kvm_page_fault {
 	struct kvm_memory_slot *slot;
 
 	/* Outputs of kvm_faultin_pfn.  */
+	unsigned long mmu_seq;
 	kvm_pfn_t pfn;
 	hva_t hva;
 	bool map_writable;
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 1c7d73b8081c60..8d1ab32ee5f9e0 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -792,7 +792,6 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	struct guest_walker walker;
 	kvm_pfn_t orig_pfn;
 	int r;
-	unsigned long mmu_seq;
 	bool is_self_change_mapping;
 
 	pgprintk("%s: addr %lx err %x\n", __func__, fault->addr, fault->error_code);
@@ -837,9 +836,6 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	else
 		fault->max_level = walker.level;
 
-	mmu_seq = vcpu->kvm->mmu_invalidate_seq;
-	smp_rmb();
-
 	r = kvm_faultin_pfn(vcpu, fault);
 	if (r != RET_PF_CONTINUE)
 		return r;
@@ -872,7 +868,7 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	r = RET_PF_RETRY;
 	write_lock(&vcpu->kvm->mmu_lock);
 
-	if (is_page_fault_stale(vcpu, fault, mmu_seq))
+	if (is_page_fault_stale(vcpu, fault))
 		goto out_unlock;
 
 	r = make_mmu_pages_available(vcpu);
-- 
2.53.0

