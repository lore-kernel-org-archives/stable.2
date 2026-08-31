Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5153B995D
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 22:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788214814; cv=none; b=PTHKnwDQ9IOUSqZD7+fZTp7MSzeZX88pwNj2hmRmMFOuoFVzN689VOAs/49B6p4OV+PD1L5x/Md3AciOkREe680VE81Gdl80BeJ6eaKH57sYYXrhMc6x2kNizSUrV/99iLivSfeBYBt4VuylgpMIgJNoBt9cIUGttruVpausBQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788214814; c=relaxed/simple;
	bh=IezHKTUGpxN2Ajqa+hVJ3DhQcJWMBc3jv8oL0+LTeTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M3hyi1hs81mz8LMwXJ+ZKBfGUQuxvW4KfjSEjpy7MVLH/166SqGa1T+bF//MvtsGfT6yR+QIQ/ZLa4T+zCT3O7UbnKKpbydLEX8kkfv82pynI6l3qvkbWgmkpmhjBSjhxPU45P24tVMVUcEAAfmJx/CAaH7ckwQylC37SxzkRk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EiuPGdNS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EiuPGdNS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9F21F00A3D;
	Mon, 31 Aug 2026 22:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788214813;
	bh=NVeumg42wU9728dy+Rm08K0+mOlxWNU5F0OuQ1W/RAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EiuPGdNSpiAapS43QSWJkXQdG/WellcEpz2vyX9FmlJuk11FgS+GkbRIFO1jubsqL
	 DPUYBPoA5V/KH/XAHjQ4WtwnSBsAJb6QTKSX18AyqhJnjy3rxj65DgtnXiYU7zoHzT
	 TYgeWkbhFmixeFW0G3NDJJplgXHQqNHA3CvLAYEias8AAReQTOcBVNOJcASEsaky5Y
	 4SKPhWr9STrnnYyspyjtcpJdIs4xT7BOjQBzpf7eB4Q5+nC+KKfM3BELRA/B5JK0ei
	 X6DEi2A4UQJlg3yywxZuwf03PI4d1XfFVUlFuf9otm8gq9ybqalsbzKPS1Ot4PYDke
	 pDOSzalNcZIow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Michael Roth <michael.roth@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 2/8] KVM: SEV: Extract loading of guest-provided VMSA to a separate helper
Date: Mon, 31 Aug 2026 18:20:04 -0400
Message-ID: <20260831222010.1859431-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831222010.1859431-1-sashal@kernel.org>
References: <2026083158-cornmeal-overhang-51bb@gregkh>
 <20260831222010.1859431-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 0060569e4f18a7dee2dd8728595e909f19a23c24 ]

Extract the loading/retrieval of a guest-provided VMSA to a separate helper
so that KVM can reuse the core logic when refreshing the VMSA after an MMU
invalidation from guest_memfd.

No functional change intended.

Cc: stable@vger.kernel.org # 6.12.x
Reviewed-by: Michael Roth <michael.roth@amd.com>
Link: https://patch.msgid.link/20260709204948.1988414-3-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Stable-dep-of: d1a3c2162334 ("KVM: SEV: Forcefully invalidate SNP VMSA if its backing gmem page is zapped")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/sev.c | 52 +++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 5924d739c7adb..25e5948ccc19f 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3998,29 +3998,17 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 	return snp_do_psc(svm);
 }
 
-/*
- * Invoked as part of svm_vcpu_reset() processing of an init event.
- */
-static void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
+static void sev_snp_reload_vmsa(struct kvm_vcpu *vcpu, gpa_t gpa)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct kvm_memory_slot *slot;
+	gfn_t gfn = gpa_to_gfn(gpa);
 	struct page *page;
 	kvm_pfn_t pfn;
-	gfn_t gfn;
-
-	guard(mutex)(&svm->sev_es.snp_vmsa_mutex);
-
-	if (!svm->sev_es.snp_ap_waiting_for_reset)
-		return;
 
-	svm->sev_es.snp_ap_waiting_for_reset = false;
-
-	/* Mark the vCPU as offline and not runnable */
-	vcpu->arch.pv.pv_unhalted = false;
-	kvm_set_mp_state(vcpu, KVM_MP_STATE_HALTED);
+	lockdep_assert_held(&svm->sev_es.snp_vmsa_mutex);
 
-	/* Clear use of the VMSA */
+	/* Clear use of the VMSA. */
 	svm->vmcb->control.vmsa_pa = INVALID_PAGE;
 	svm->sev_es.snp_guest_vmsa_gpa = INVALID_PAGE;
 
@@ -4030,12 +4018,9 @@ static void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
 	 */
 	vmcb_mark_all_dirty(svm->vmcb);
 
-	if (!VALID_PAGE(svm->sev_es.snp_pending_vmsa_gpa))
+	if (!VALID_PAGE(gpa))
 		return;
 
-	gfn = gpa_to_gfn(svm->sev_es.snp_pending_vmsa_gpa);
-	svm->sev_es.snp_pending_vmsa_gpa = INVALID_PAGE;
-
 	slot = gfn_to_memslot(vcpu->kvm, gfn);
 	if (!slot)
 		return;
@@ -4059,7 +4044,7 @@ static void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
 	svm->sev_es.snp_has_guest_vmsa = true;
 
 	/* Use the new VMSA */
-	svm->sev_es.snp_guest_vmsa_gpa = gfn_to_gpa(gfn);
+	svm->sev_es.snp_guest_vmsa_gpa = gpa;
 	svm->vmcb->control.vmsa_pa = pfn_to_hpa(pfn);
 
 	/* Mark the vCPU as runnable */
@@ -4073,6 +4058,31 @@ static void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
 	kvm_release_page_clean(page);
 }
 
+/*
+ * Invoked as part of svm_vcpu_reset() processing of an init event.
+ */
+static void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+	gpa_t gpa;
+
+	guard(mutex)(&svm->sev_es.snp_vmsa_mutex);
+
+	if (!svm->sev_es.snp_ap_waiting_for_reset)
+		return;
+
+	svm->sev_es.snp_ap_waiting_for_reset = false;
+
+	/* Mark the vCPU as offline and not runnable */
+	vcpu->arch.pv.pv_unhalted = false;
+	kvm_set_mp_state(vcpu, KVM_MP_STATE_HALTED);
+
+	gpa = svm->sev_es.snp_pending_vmsa_gpa;
+	svm->sev_es.snp_pending_vmsa_gpa = INVALID_PAGE;
+
+	sev_snp_reload_vmsa(vcpu, gpa);
+}
+
 static int sev_snp_ap_creation(struct vcpu_svm *svm)
 {
 	struct kvm_sev_info *sev = to_kvm_sev_info(svm->vcpu.kvm);
-- 
2.53.0

