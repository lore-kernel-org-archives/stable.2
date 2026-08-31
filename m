Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE9439A4A0
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 21:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788210616; cv=none; b=b17ukwZcMgZAb7ePF04y25fe0Awm0XjnhNEX9fT/oFXUfz4QIyIbU4qdqp12bex3/rfFS9SRV0kIqOqRZdIjImClw7kdsAA1z3447fOHGci2IYxVAjs3Wmd2RXppGtGRtQoqbsQI+1AWq5jNevrNXYd3fE+RaDqeISLPfBbv3t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788210616; c=relaxed/simple;
	bh=JlNKtPbD5aainNjWUC65CXaTbowGNwoQZVUF+A7TCtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tdSN91u6Imav47Y7OzJT/mcFXgBNgz3uebP27dZo+6Tfdm6a2H1YEiclKgBtL6b1iOY+mYJ90tyyCZ6UXpct6cUy2THurf6kwCuONHAge+KLFi1BoLIOPolkZA2VUIVYjuIbdQaFSvVQv2l9PBDa0FSkDznHfVts/2RzYnEDFKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEr8M6B7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEr8M6B7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E7E1F00ADB;
	Mon, 31 Aug 2026 21:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788210613;
	bh=EsIfO/hyo8TObnsxDQvWTxLZ8CXzcy3NphEF6JMwVM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WEr8M6B7WldqPSq7V8p/pS9/BNBUjEH7GcarQIu6SJFZk3wwbtjfe+gtWRj+c6g7Z
	 4qLrNcznUxa43BTMlRkj5xHA/gKbZjmp0pOcJaawoP4h/nvHAN9KDtBy1jdB1gc2So
	 bktFuYGgIvjvJxi/t7lz90QC2jALT2+rZMjf0IjEMmOWvKU1UhmgA7Zbdv+xjQp+fN
	 4ENavKkDR3nCBB/59yncxcn+KdTmANO8O0pLBxJeoBAvmGYE5QbiqhDP1UBSmS+qwK
	 2IU9+UhgLr90VZJpRUz6xtXRo6qV5t0wVW7IOntJV/jWViP/I5ulWsrtqKVWgJCjYp
	 HEipUtbzBaNUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] KVM: SEV: Add an anonymous "psc" struct to track current PSC metadata
Date: Mon, 31 Aug 2026 17:10:09 -0400
Message-ID: <20260831211010.1798943-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831211010.1798943-1-sashal@kernel.org>
References: <2026083135-thud-surplus-53de@gregkh>
 <20260831211010.1798943-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 00b9744a3688758c5c492756d08a1cd599a76965 ]

Add a "psc" struct to vcpu_sev_es_state to avoid having to prefix all of
the fields with "psc_".

Take advantage of the code churn to opportunistically rename local
variables to "guest_psc" to make it more obvious that the buffer is guest
data, and more importantly, guest accessible!

Opportunistically rename inflight => batch_size as well, because there can
really only be one operation in-flight (per-vCPU), i.e. "inflight" _looks_
like a boolean, but in actuality is an integer tracking how many pages are
being handled by the current operation.

No functional change intended.

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-13-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20260529183549.1104619-13-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

For the 6.12 backport, retain the existing GHCB response write because the
newer VMGEXIT response helper is not available.  Also fold in the VMSA GPA
tracking and helper refactoring needed by the dependent AP_CREATE fix,
adapting them to the 6.12 gmem and MP-state APIs and existing reset hook
without adding a new function.

Stable-dep-of: 98ade8c48c28 ("KVM: SEV: Mark vCPU RUNNABLE after AP_CREATE, even if VMSA is unusable")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/sev.c | 162 ++++++++++++++++++++---------------------
 arch/x86/kvm/svm/svm.c |   2 +
 arch/x86/kvm/svm/svm.h |  11 ++-
 3 files changed, 87 insertions(+), 88 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index e5587675cf9ec..7be27b481ca22 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3726,17 +3726,14 @@ static int snp_begin_psc(struct vcpu_svm *svm);
 
 static void snp_complete_psc(struct vcpu_svm *svm, u64 psc_ret)
 {
-	svm->sev_es.psc_inflight = 0;
-	svm->sev_es.psc_idx = 0;
-	svm->sev_es.psc_2m = false;
+	memset(&svm->sev_es.psc, 0, sizeof(svm->sev_es.psc));
 	ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, psc_ret);
 }
 
 static void __snp_complete_one_psc(struct vcpu_svm *svm)
 {
-	struct psc_buffer *psc = svm->sev_es.ghcb_sa;
-	struct psc_entry *entries = psc->entries;
-	struct psc_hdr *hdr = &psc->hdr;
+	struct vcpu_sev_es_state *sev_es = &svm->sev_es;
+	struct psc_buffer *guest_psc = sev_es->ghcb_sa;
 	__u16 idx;
 
 	/*
@@ -3744,14 +3741,14 @@ static void __snp_complete_one_psc(struct vcpu_svm *svm)
 	 * corresponding entries in the guest's PSC buffer and zero out the
 	 * count of in-flight PSC entries.
 	 */
-	for (idx = svm->sev_es.psc_idx; svm->sev_es.psc_inflight;
-	     svm->sev_es.psc_inflight--, idx++) {
-		struct psc_entry entry = READ_ONCE(entries[idx]);
+	for (idx = sev_es->psc.cur_idx; sev_es->psc.batch_size;
+	     sev_es->psc.batch_size--, idx++) {
+		struct psc_entry entry = READ_ONCE(guest_psc->entries[idx]);
 
-		entries[idx].cur_page = entry.pagesize ? 512 : 1;
+		guest_psc->entries[idx].cur_page = entry.pagesize ? 512 : 1;
 	}
 
-	hdr->cur_entry = idx;
+	guest_psc->hdr.cur_entry = idx;
 }
 
 static int snp_complete_one_psc(struct kvm_vcpu *vcpu)
@@ -3772,10 +3769,8 @@ static int snp_complete_one_psc(struct kvm_vcpu *vcpu)
 static int snp_begin_psc(struct vcpu_svm *svm)
 {
 	struct vcpu_sev_es_state *sev_es = &svm->sev_es;
-	struct psc_buffer *psc = sev_es->ghcb_sa;
-	struct psc_entry *entries = psc->entries;
+	struct psc_buffer *guest_psc = sev_es->ghcb_sa;
 	struct kvm_vcpu *vcpu = &svm->vcpu;
-	struct psc_hdr *hdr = &psc->hdr;
 	struct psc_entry entry_start;
 	u16 idx, idx_start, idx_end, max_nr_entries;
 	int npages;
@@ -3802,7 +3797,7 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 
 next_range:
 	/* There should be no other PSCs in-flight at this point. */
-	if (WARN_ON_ONCE(svm->sev_es.psc_inflight)) {
+	if (WARN_ON_ONCE(svm->sev_es.psc.batch_size)) {
 		snp_complete_psc(svm, VMGEXIT_PSC_ERROR_GENERIC);
 		return 1;
 	}
@@ -3812,8 +3807,8 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 	 * validation, so take care to only use validated copies of values used
 	 * for things like array indexing.
 	 */
-	idx_start = READ_ONCE(hdr->cur_entry);
-	idx_end = READ_ONCE(hdr->end_entry);
+	idx_start = READ_ONCE(guest_psc->hdr.cur_entry);
+	idx_end = READ_ONCE(guest_psc->hdr.end_entry);
 
 	if (idx_end >= max_nr_entries) {
 		snp_complete_psc(svm, VMGEXIT_PSC_ERROR_INVALID_HDR);
@@ -3822,7 +3817,7 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 
 	/* Find the start of the next range which needs processing. */
 	for (idx = idx_start; idx <= idx_end; idx++) {
-		entry_start = READ_ONCE(entries[idx]);
+		entry_start = READ_ONCE(guest_psc->entries[idx]);
 
 		gfn = entry_start.gfn;
 		huge = entry_start.pagesize;
@@ -3855,7 +3850,7 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 		 * for READ_ONCE() as KVM doesn't consume the field, i.e. a
 		 * misbehaving guest can only break itself.
 		 */
-		hdr->cur_entry++;
+		guest_psc->hdr.cur_entry++;
 	}
 
 	if (idx > idx_end) {
@@ -3864,9 +3859,9 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 		return 1;
 	}
 
-	svm->sev_es.psc_2m = huge;
-	svm->sev_es.psc_idx = idx;
-	svm->sev_es.psc_inflight = 1;
+	sev_es->psc.is_2m = huge;
+	sev_es->psc.cur_idx = idx;
+	sev_es->psc.batch_size = 1;
 
 	/*
 	 * Find all subsequent PSC entries that contain adjacent GPA
@@ -3874,14 +3869,14 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 	 * KVM_HC_MAP_GPA_RANGE exit.
 	 */
 	while (++idx <= idx_end) {
-		struct psc_entry entry = READ_ONCE(entries[idx]);
+		struct psc_entry entry = READ_ONCE(guest_psc->entries[idx]);
 
 		if (entry.operation != entry_start.operation ||
 		    entry.gfn != entry_start.gfn + npages ||
 		    entry.cur_page || !!entry.pagesize != huge)
 			break;
 
-		svm->sev_es.psc_inflight++;
+		sev_es->psc.batch_size++;
 		npages += huge ? 512 : 1;
 	}
 
@@ -3916,71 +3911,66 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 	BUG();
 }
 
-static int __sev_snp_update_protected_guest_state(struct kvm_vcpu *vcpu)
+/* kvm_set_mp_state() was introduced after 6.12. */
+#define kvm_set_mp_state(vcpu, state) ((vcpu)->arch.mp_state = (state))
+
+static void sev_snp_reload_vmsa(struct kvm_vcpu *vcpu, gpa_t gpa)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
+	struct kvm_memory_slot *slot;
+	gfn_t gfn = gpa_to_gfn(gpa);
+	kvm_pfn_t pfn;
 
-	WARN_ON(!mutex_is_locked(&svm->sev_es.snp_vmsa_mutex));
+	lockdep_assert_held(&svm->sev_es.snp_vmsa_mutex);
 
-	/* Mark the vCPU as offline and not runnable */
-	vcpu->arch.pv.pv_unhalted = false;
-	vcpu->arch.mp_state = KVM_MP_STATE_HALTED;
-
-	/* Clear use of the VMSA */
+	/* Clear use of the VMSA. */
 	svm->vmcb->control.vmsa_pa = INVALID_PAGE;
+	svm->sev_es.snp_guest_vmsa_gpa = INVALID_PAGE;
 
-	if (VALID_PAGE(svm->sev_es.snp_vmsa_gpa)) {
-		gfn_t gfn = gpa_to_gfn(svm->sev_es.snp_vmsa_gpa);
-		struct kvm_memory_slot *slot;
-		kvm_pfn_t pfn;
-
-		slot = gfn_to_memslot(vcpu->kvm, gfn);
-		if (!slot)
-			return -EINVAL;
+	/*
+	 * When replacing the VMSA during SEV-SNP AP creation,
+	 * mark the VMCB dirty so that full state is always reloaded.
+	 */
+	vmcb_mark_all_dirty(svm->vmcb);
 
-		/*
-		 * The new VMSA will be private memory guest memory, so
-		 * retrieve the PFN from the gmem backend.
-		 */
-		if (kvm_gmem_get_pfn(vcpu->kvm, slot, gfn, &pfn, NULL))
-			return -EINVAL;
+	if (!VALID_PAGE(gpa))
+		return;
 
-		/*
-		 * From this point forward, the VMSA will always be a
-		 * guest-mapped page rather than the initial one allocated
-		 * by KVM in svm->sev_es.vmsa. In theory, svm->sev_es.vmsa
-		 * could be free'd and cleaned up here, but that involves
-		 * cleanups like wbinvd_on_all_cpus() which would ideally
-		 * be handled during teardown rather than guest boot.
-		 * Deferring that also allows the existing logic for SEV-ES
-		 * VMSAs to be re-used with minimal SNP-specific changes.
-		 */
-		svm->sev_es.snp_has_guest_vmsa = true;
+	slot = gfn_to_memslot(vcpu->kvm, gfn);
+	if (!slot)
+		return;
 
-		/* Use the new VMSA */
-		svm->vmcb->control.vmsa_pa = pfn_to_hpa(pfn);
+	/*
+	 * The new VMSA will be private memory guest memory, so retrieve the
+	 * PFN from the gmem backend.
+	 */
+	if (kvm_gmem_get_pfn(vcpu->kvm, slot, gfn, &pfn, NULL))
+		return;
 
-		/* Mark the vCPU as runnable */
-		vcpu->arch.pv.pv_unhalted = false;
-		vcpu->arch.mp_state = KVM_MP_STATE_RUNNABLE;
+	/*
+	 * From this point forward, the VMSA will always be a guest-mapped page
+	 * rather than the initial one allocated by KVM in svm->sev_es.vmsa. In
+	 * theory, svm->sev_es.vmsa could be free'd and cleaned up here, but
+	 * that involves cleanups like flushing caches, which would ideally be
+	 * handled during teardown rather than guest boot.  Deferring that also
+	 * allows the existing logic for SEV-ES VMSAs to be re-used with minimal
+	 * SNP-specific changes.
+	 */
+	svm->sev_es.snp_has_guest_vmsa = true;
 
-		svm->sev_es.snp_vmsa_gpa = INVALID_PAGE;
+	/* Use the new VMSA */
+	svm->sev_es.snp_guest_vmsa_gpa = gpa;
+	svm->vmcb->control.vmsa_pa = pfn_to_hpa(pfn);
 
-		/*
-		 * gmem pages aren't currently migratable, but if this ever
-		 * changes then care should be taken to ensure
-		 * svm->sev_es.vmsa is pinned through some other means.
-		 */
-		kvm_release_pfn_clean(pfn);
-	}
+	/* Mark the vCPU as runnable */
+	kvm_set_mp_state(vcpu, KVM_MP_STATE_RUNNABLE);
 
 	/*
-	 * When replacing the VMSA during SEV-SNP AP creation,
-	 * mark the VMCB dirty so that full state is always reloaded.
+	 * gmem pages aren't currently migratable, but if this ever changes
+	 * then care should be taken to ensure svm->sev_es.vmsa is pinned
+	 * through some other means.
 	 */
-	vmcb_mark_all_dirty(svm->vmcb);
-
-	return 0;
+	kvm_release_pfn_clean(pfn);
 }
 
 /*
@@ -3989,26 +3979,30 @@ static int __sev_snp_update_protected_guest_state(struct kvm_vcpu *vcpu)
 void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
-	int ret;
+	gpa_t gpa;
 
 	if (!sev_snp_guest(vcpu->kvm))
 		return;
 
-	mutex_lock(&svm->sev_es.snp_vmsa_mutex);
+	guard(mutex)(&svm->sev_es.snp_vmsa_mutex);
 
 	if (!svm->sev_es.snp_ap_waiting_for_reset)
-		goto unlock;
+		return;
 
 	svm->sev_es.snp_ap_waiting_for_reset = false;
 
-	ret = __sev_snp_update_protected_guest_state(vcpu);
-	if (ret)
-		vcpu_unimpl(vcpu, "snp: AP state update on init failed\n");
+	/* Mark the vCPU as offline and not runnable */
+	vcpu->arch.pv.pv_unhalted = false;
+	kvm_set_mp_state(vcpu, KVM_MP_STATE_HALTED);
 
-unlock:
-	mutex_unlock(&svm->sev_es.snp_vmsa_mutex);
+	gpa = svm->sev_es.snp_pending_vmsa_gpa;
+	svm->sev_es.snp_pending_vmsa_gpa = INVALID_PAGE;
+
+	sev_snp_reload_vmsa(vcpu, gpa);
 }
 
+#undef kvm_set_mp_state
+
 static int sev_snp_ap_creation(struct vcpu_svm *svm)
 {
 	struct kvm_sev_info *sev = &to_kvm_svm(svm->vcpu.kvm)->sev_info;
@@ -4085,10 +4079,10 @@ static int sev_snp_ap_creation(struct vcpu_svm *svm)
 			goto out;
 		}
 
-		target_svm->sev_es.snp_vmsa_gpa = svm->vmcb->control.exit_info_2;
+		target_svm->sev_es.snp_pending_vmsa_gpa = svm->vmcb->control.exit_info_2;
 		break;
 	case SVM_VMGEXIT_AP_DESTROY:
-		target_svm->sev_es.snp_vmsa_gpa = INVALID_PAGE;
+		target_svm->sev_es.snp_pending_vmsa_gpa = INVALID_PAGE;
 		break;
 	default:
 		vcpu_unimpl(vcpu, "vmgexit: invalid AP creation request [%#x] from guest\n",
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 44819d9470dcf..48a2d5c42f233 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1473,6 +1473,8 @@ static int svm_vcpu_create(struct kvm_vcpu *vcpu)
 
 	if (vmsa_page)
 		svm->sev_es.vmsa = page_address(vmsa_page);
+	svm->sev_es.snp_pending_vmsa_gpa = INVALID_PAGE;
+	svm->sev_es.snp_guest_vmsa_gpa = INVALID_PAGE;
 
 	svm->guest_state_loaded = false;
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index c34cd7f1408fc..725d5cf237c4f 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -231,14 +231,17 @@ struct vcpu_sev_es_state {
 	bool ghcb_sa_free;
 
 	/* SNP Page-State-Change buffer entries currently being processed */
-	u16 psc_idx;
-	u16 psc_inflight;
-	bool psc_2m;
+	struct {
+		u16 cur_idx;
+		u16 batch_size;
+		bool is_2m;
+	} psc;
 
 	u64 ghcb_registered_gpa;
 
 	struct mutex snp_vmsa_mutex; /* Used to handle concurrent updates of VMSA. */
-	gpa_t snp_vmsa_gpa;
+	gpa_t snp_pending_vmsa_gpa;
+	gpa_t snp_guest_vmsa_gpa;
 	bool snp_ap_waiting_for_reset;
 	bool snp_has_guest_vmsa;
 };
-- 
2.53.0

