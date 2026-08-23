Received: from www5210.sakura.ne.jp (www5210.sakura.ne.jp [133.167.8.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B9038A70A
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 13:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=133.167.8.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787490532; cv=none; b=NOXZIbU02z01U4Rmg7C8zcwzWPEDXC/XQSSbFLvZo51yrDh7jyIsYahykrxrfp68tkrjbEDq6aC1CvR8y25Z1q2NFQpp0uodjEGGLqwrw9Eb5RV/BMdm8E3xF5/9YYgwVhfeo0niHxxB9x2j0sYoK1Bkt5J0jmb5EFab3XDw+z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787490532; c=relaxed/simple;
	bh=kyTb9kOCxCCA9EVq8BUbUV9+zk5nX/O/ml3MmPPyF08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VbpxS0rzOI9tSNqjuClZIbfIwhT0CXrY9zxPUNxlzD0PtPvAuUoimYrh/2xeVjVdpdJDdarzUgYLv8KE9hrquFxtwPqxYVchqLMwcuF4q7Cvua3YLAF5AHAVIGcCTxZQn7QVZEq3vuGPJXJWHtcugnxwT6Tgn0bwQf9Ps2oxtSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me; spf=pass smtp.mailfrom=mgml.me; dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b=ObZ6ZAgr; arc=none smtp.client-ip=133.167.8.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mgml.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b="ObZ6ZAgr"
Received: from fedora (p4270056-ipxg00p01tokaisakaetozai.aichi.ocn.ne.jp [153.201.103.56])
	(authenticated bits=0)
	by www5210.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 67ND837v016116
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 23 Aug 2026 22:08:39 +0900 (JST)
	(envelope-from k@mgml.me)
DKIM-Signature: a=rsa-sha256; bh=3IzNVV9ORFQ9vrUYMH8SJB51eC3qaDcB0yq3Hk6qfXg=;
        c=relaxed/relaxed; d=mgml.me;
        h=From:Message-ID:To:Subject:Date;
        s=rs20250315; t=1787490520; v=1;
        b=ObZ6ZAgrIUHFQU5PmTkbp069UBLAr0YVt8YvUPysWP0t/Oxn5JaVvcFwht3i3542
         cVMxYYVBJR7Kk2RK1qEsnLmag1dT/Jy88x2gya6m5u7ezwGM+n1apgBBqlZL8rzH
         9C5R36ghqQRz1DrysRZ5EmYHvRpyWt3LHEzl50MlnjN6i+Dv7lknzt9unDbPxXOl
         M45pDDn8Rx9ZGJV0Pp6RmydTA85r+NYfSux3R/9CBBSNShNaV/5TSbdlBjB3LWdU
         FPSEMMZ5tCdCZWyqyZllpI9dz0Acdjs8D/3bzgjAK0UAvGKub89qskgsO8hSl9s7
         aj7mrOF9tzEq3oviwwmnCg==
From: Kenta Akagi <k@mgml.me>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>, Ben Gardon <bgardon@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Kenta Akagi <k@mgml.me>
Subject: [PATCH 5.15.y v2 1/8] KVM: x86/mmu: Retry page fault if root is invalidated by memslot update
Date: Sun, 23 Aug 2026 22:07:44 +0900
Message-ID: <20260823130751.2880-2-k@mgml.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260823130751.2880-1-k@mgml.me>
References: <2026072557-gem-defensive-a757@gregkh>
 <20260823130751.2880-1-k@mgml.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit a955cad84cdaffa282b3cf8f5ce69e9e5655e585 ]

Bail from the page fault handler if the root shadow page was obsoleted by
a memslot update.  Do the check _after_ acuiring mmu_lock, as the TDP MMU
doesn't rely on the memslot/MMU generation, and instead relies on the
root being explicit marked invalid by kvm_mmu_zap_all_fast(), which takes
mmu_lock for write.

For the TDP MMU, inserting a SPTE into an obsolete root can leak a SP if
kvm_tdp_mmu_zap_invalidated_roots() has already zapped the SP, i.e. has
moved past the gfn associated with the SP.

For other MMUs, the resulting behavior is far more convoluted, though
unlikely to be truly problematic.  Installing SPs/SPTEs into the obsolete
root isn't directly problematic, as the obsolete root will be unloaded
and dropped before the vCPU re-enters the guest.  But because the legacy
MMU tracks shadow pages by their role, any SP created by the fault can
can be reused in the new post-reload root.  Again, that _shouldn't_ be
problematic as any leaf child SPTEs will be created for the current/valid
memslot generation, and kvm_mmu_get_page() will not reuse child SPs from
the old generation as they will be flagged as obsolete.  But, given that
continuing with the fault is pointess (the root will be unloaded), apply
the check to all MMUs.

Fixes: b7cccd397f31 ("KVM: x86/mmu: Fast invalidation for TDP MMU")
Cc: stable@vger.kernel.org
Cc: Ben Gardon <bgardon@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20211120045046.3940942-5-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[backport note: is_page_fault_stale() adapted to take individual parameters
 instead of struct kvm_page_fault, since 4326e57ef40a ("KVM: MMU: change
 direct_page_fault() arguments to kvm_page_fault") is not in 5.15.y;
 required by the following backport of 2abd5287f083 and by 0cb2af2ea66a
 to be backported separately]
Assisted-by: Claude:claude-sonnet-4.6
Signed-off-by: Kenta Akagi <k@mgml.me>
---
 arch/x86/kvm/mmu/mmu.c         | 22 ++++++++++++++++++++--
 arch/x86/kvm/mmu/paging_tmpl.h |  3 ++-
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 84eeed9a9615..2fbe71dbab6f 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1942,7 +1942,11 @@ static void mmu_audit_disable(void) { }
 
 static bool is_obsolete_sp(struct kvm *kvm, struct kvm_mmu_page *sp)
 {
-	return sp->role.invalid ||
+	if (sp->role.invalid)
+		return true;
+
+	/* TDP MMU pages due not use the MMU generation. */
+	return !sp->tdp_mmu_page &&
 	       unlikely(sp->mmu_valid_gen != kvm->arch.mmu_valid_gen);
 }
 
@@ -3968,6 +3972,20 @@ static bool kvm_faultin_pfn(struct kvm_vcpu *vcpu, bool prefault, gfn_t gfn,
 	return true;
 }
 
+/*
+ * Returns true if the page fault is stale and needs to be retried, i.e. if the
+ * root was invalidated by a memslot update or a relevant mmu_notifier fired.
+ */
+static bool is_page_fault_stale(struct kvm_vcpu *vcpu,
+				kvm_pfn_t pfn, unsigned long mmu_seq, hva_t hva)
+{
+	if (is_obsolete_sp(vcpu->kvm, to_shadow_page(vcpu->arch.mmu->root_hpa)))
+		return true;
+
+	return !is_noslot_pfn(pfn) &&
+	       mmu_notifier_retry_hva(vcpu->kvm, mmu_seq, hva);
+}
+
 static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 			     bool prefault, int max_level, bool is_tdp)
 {
@@ -4009,7 +4027,7 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 	else
 		write_lock(&vcpu->kvm->mmu_lock);
 
-	if (!is_noslot_pfn(pfn) && mmu_notifier_retry_hva(vcpu->kvm, mmu_seq, hva))
+	if (is_page_fault_stale(vcpu, pfn, mmu_seq, hva))
 		goto out_unlock;
 
 	if (is_tdp_mmu_fault) {
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index a1811f51eda9..d1e7ac58b735 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -925,7 +925,8 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, gpa_t addr, u32 error_code,
 
 	r = RET_PF_RETRY;
 	write_lock(&vcpu->kvm->mmu_lock);
-	if (!is_noslot_pfn(pfn) && mmu_notifier_retry_hva(vcpu->kvm, mmu_seq, hva))
+
+	if (is_page_fault_stale(vcpu, pfn, mmu_seq, hva))
 		goto out_unlock;
 
 	kvm_mmu_audit(vcpu, AUDIT_PRE_PAGE_FAULT);
-- 
2.51.2

