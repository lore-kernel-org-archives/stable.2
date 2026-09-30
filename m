Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F60F4F3ECC
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 13:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773989; cv=none; b=On81y8SOTQCMnlPbCrSzEHhVnkoq1/o/RC9L3GCAL35OTqWW6oBBhJJSZWEDIFhkZDcCGAeTqv9/OvHEZ2C9ekC0OONlKCWo1/olKnyfgpqvk9Nny+t7bigiAwcbmVQMz3XhhTQ6pvjgOGcCHB5TDrhYWNMOWbU87gzdh9eiIsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773989; c=relaxed/simple;
	bh=LNp5e60PEd8MWO8nLQWKW7KNgq0QB4BGpCMYExxPJWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ngSYm/vtIqaswcJDGWXzmxYlld/LwUMzuATGDaiqTr6Gj/0Bzim2MMBvRFpdxgSqi3ZvFziBcboS0/rLYD/JNh9lRIqK+S2CSR7m2h8OPTHW8KRKfh/o3Wd/b+5Bi0knoMAK1zSw7rr/IxFVf1JnhohGq0YKUnFxxY+tdScRk78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxBtillp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxBtillp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B4D1F00899;
	Wed, 30 Sep 2026 13:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790773981;
	bh=+KBgxevcBRGPvTVY+CojCt/EvZ63Oa4v0nbgbX87KMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MxBtillphxbK1CRXzyGdjgv7opM9qhZJohBSRLh1Kdfj99myNab4QQ3HXm7DJaRQ1
	 cKZRi9aHdzYR30a5uRWNTHZx2L8Azst8Bo37BLCN8tQ6efi5TbmmEep2y6ev4h1lrT
	 PB/KhONEALUNkMjvf48CWFdU3nQTK0/VcvxwROjFzc/4Tco1e2sEyeMLc5ZC2X7+l5
	 NKncpw4laRjSDktjns+SXJS7PVxmpH7Ke37VeA6yVHcRaGcw2MmKeScVBqhfXzSXbo
	 QA903DxVkjRKX6b6K+UGpwnSwCkR/kICRQ+Ra8i0rdXOo7SdgghoUh48rkNsy9MSAJ
	 NYyVXTfMe1e0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Kai Huang <kai.huang@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 4/8] KVM: x86/mmu: Move kvm_mmu_do_page_fault() from mmu_internal.h => mmu.c
Date: Wed, 30 Sep 2026 09:12:51 -0400
Message-ID: <20260930131256.1728861-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930131256.1728861-1-sashal@kernel.org>
References: <2026092945-unzip-pluck-7c40@gregkh>
 <20260930131256.1728861-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 20fe9252460524f9028b515f0f672442ffe6779b ]

Move kvm_mmu_do_page_fault() into mmu.c, as there are no users outside of
mmu.c, and the function typically isn't inlined by the compiler anyways.
This will allow moving the EMULTYPE_xxx definitions into x86.h without
having to include x86.h in mmu_internal.h, i.e. will help preserve the
goal of making x86.h KVM x86's "top-level" include.

No functional change intended.

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Message-ID: <20260613000329.732085-30-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: 10180a277549 ("KVM: x86: Re-pend GET_NESTED_STATE_PAGES if getting said pages fails")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/mmu/mmu.c          | 67 ++++++++++++++++++++++++++++++++-
 arch/x86/kvm/mmu/mmu_internal.h | 66 --------------------------------
 2 files changed, 66 insertions(+), 67 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index ab1cbc0ff0eb9..49a5fb103194a 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4957,7 +4957,7 @@ static int kvm_tdp_mmu_page_fault(struct kvm_vcpu *vcpu,
 }
 #endif
 
-int kvm_tdp_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
+static int kvm_tdp_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 {
 #ifdef CONFIG_X86_64
 	if (tdp_mmu_enabled)
@@ -4967,6 +4967,71 @@ int kvm_tdp_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 	return direct_page_fault(vcpu, fault);
 }
 
+static int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
+				 u64 err, bool prefetch, int *emulation_type,
+				 u8 *level)
+{
+	struct kvm_page_fault fault = {
+		.addr = cr2_or_gpa,
+		.error_code = err,
+		.exec = err & PFERR_FETCH_MASK,
+		.write = err & PFERR_WRITE_MASK,
+		.present = err & PFERR_PRESENT_MASK,
+		.rsvd = err & PFERR_RSVD_MASK,
+		.user = err & PFERR_USER_MASK,
+		.prefetch = prefetch,
+		.is_tdp = likely(vcpu->arch.mmu->page_fault == kvm_tdp_page_fault),
+		.nx_huge_page_workaround_enabled =
+			is_nx_huge_page_enabled(vcpu->kvm),
+
+		.max_level = KVM_MAX_HUGEPAGE_LEVEL,
+		.req_level = PG_LEVEL_4K,
+		.goal_level = PG_LEVEL_4K,
+		.is_private = err & PFERR_PRIVATE_ACCESS,
+
+		.pfn = KVM_PFN_ERR_FAULT,
+	};
+	int r;
+
+	if (vcpu->arch.mmu->root_role.direct) {
+		/*
+		 * Things like memslots don't understand the concept of a shared
+		 * bit. Strip it so that the GFN can be used like normal, and the
+		 * fault.addr can be used when the shared bit is needed.
+		 */
+		fault.gfn = gpa_to_gfn(fault.addr) & ~kvm_gfn_direct_bits(vcpu->kvm);
+		fault.slot = kvm_vcpu_gfn_to_memslot(vcpu, fault.gfn);
+	}
+
+	/*
+	 * With retpoline being active an indirect call is rather expensive,
+	 * so do a direct call in the most common case.
+	 */
+	if (IS_ENABLED(CONFIG_MITIGATION_RETPOLINE) && fault.is_tdp)
+		r = kvm_tdp_page_fault(vcpu, &fault);
+	else
+		r = vcpu->arch.mmu->page_fault(vcpu, &fault);
+
+	/*
+	 * Not sure what's happening, but punt to userspace and hope that
+	 * they can fix it by changing memory to shared, or they can
+	 * provide a better error.
+	 */
+	if (r == RET_PF_EMULATE && fault.is_private) {
+		pr_warn_ratelimited("kvm: unexpected emulation request on private memory\n");
+		kvm_mmu_prepare_memory_fault_exit(vcpu, &fault);
+		return -EFAULT;
+	}
+
+	if (fault.write_fault_to_shadow_pgtable && emulation_type)
+		*emulation_type |= EMULTYPE_WRITE_PF_TO_SP;
+	if (level)
+		*level = fault.goal_level;
+
+	return r;
+}
+
+
 static int kvm_tdp_page_prefault(struct kvm_vcpu *vcpu, gpa_t gpa,
 				 u64 error_code, u8 *level)
 {
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index 73cdcbccc89e8..c29002c601265 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -290,8 +290,6 @@ struct kvm_page_fault {
 	bool write_fault_to_shadow_pgtable;
 };
 
-int kvm_tdp_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault);
-
 /*
  * Return values of handle_mmio_page_fault(), mmu.page_fault(), fast_page_fault(),
  * and of course kvm_mmu_do_page_fault().
@@ -337,70 +335,6 @@ static inline void kvm_mmu_prepare_memory_fault_exit(struct kvm_vcpu *vcpu,
 				      fault->is_private);
 }
 
-static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
-					u64 err, bool prefetch,
-					int *emulation_type, u8 *level)
-{
-	struct kvm_page_fault fault = {
-		.addr = cr2_or_gpa,
-		.error_code = err,
-		.exec = err & PFERR_FETCH_MASK,
-		.write = err & PFERR_WRITE_MASK,
-		.present = err & PFERR_PRESENT_MASK,
-		.rsvd = err & PFERR_RSVD_MASK,
-		.user = err & PFERR_USER_MASK,
-		.prefetch = prefetch,
-		.is_tdp = likely(vcpu->arch.mmu->page_fault == kvm_tdp_page_fault),
-		.nx_huge_page_workaround_enabled =
-			is_nx_huge_page_enabled(vcpu->kvm),
-
-		.max_level = KVM_MAX_HUGEPAGE_LEVEL,
-		.req_level = PG_LEVEL_4K,
-		.goal_level = PG_LEVEL_4K,
-		.is_private = err & PFERR_PRIVATE_ACCESS,
-
-		.pfn = KVM_PFN_ERR_FAULT,
-	};
-	int r;
-
-	if (vcpu->arch.mmu->root_role.direct) {
-		/*
-		 * Things like memslots don't understand the concept of a shared
-		 * bit. Strip it so that the GFN can be used like normal, and the
-		 * fault.addr can be used when the shared bit is needed.
-		 */
-		fault.gfn = gpa_to_gfn(fault.addr) & ~kvm_gfn_direct_bits(vcpu->kvm);
-		fault.slot = kvm_vcpu_gfn_to_memslot(vcpu, fault.gfn);
-	}
-
-	/*
-	 * With retpoline being active an indirect call is rather expensive,
-	 * so do a direct call in the most common case.
-	 */
-	if (IS_ENABLED(CONFIG_MITIGATION_RETPOLINE) && fault.is_tdp)
-		r = kvm_tdp_page_fault(vcpu, &fault);
-	else
-		r = vcpu->arch.mmu->page_fault(vcpu, &fault);
-
-	/*
-	 * Not sure what's happening, but punt to userspace and hope that
-	 * they can fix it by changing memory to shared, or they can
-	 * provide a better error.
-	 */
-	if (r == RET_PF_EMULATE && fault.is_private) {
-		pr_warn_ratelimited("kvm: unexpected emulation request on private memory\n");
-		kvm_mmu_prepare_memory_fault_exit(vcpu, &fault);
-		return -EFAULT;
-	}
-
-	if (fault.write_fault_to_shadow_pgtable && emulation_type)
-		*emulation_type |= EMULTYPE_WRITE_PF_TO_SP;
-	if (level)
-		*level = fault.goal_level;
-
-	return r;
-}
-
 int kvm_mmu_max_mapping_level(struct kvm *kvm, struct kvm_page_fault *fault,
 			      const struct kvm_memory_slot *slot, gfn_t gfn);
 void kvm_mmu_hugepage_adjust(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault);
-- 
2.53.0

