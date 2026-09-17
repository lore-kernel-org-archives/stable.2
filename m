Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500884B7A32
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 16:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661322; cv=none; b=hMv/5B8hEWYT4BN5bSNGzvUbdlmmCjrVLhskQ1TJwMx0PHMvcH9Jfzldk+kP9+fBIdHzFn6BKnQDJ4SeFTTvBNfzxk5MQi/TbIjbfXpoqfiP1AfacqQLLqPw5EikdU5R6wE41PTk57MVviMNHYNyvXhN8Y/nRWEZs/W6xxsJgZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661322; c=relaxed/simple;
	bh=xG+G9c6ELvTudVbdyLM8Ux10++5jdJaDb4W/3pJE9xQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KXjfQK4/nbBUCcrHVQaaRv2uSbVl3MU2uNxsd9dq4hI4PnIqT3mahKcd+ontwJ0tBlsdk75nef34KGkSVYOvMxh6Vqvzigv4maRriMnonT5uNUocz0byp9BgIE72zjxb+W4EmeLD6w4hT2GOalFHuTMzfxcHw1Bj6jrrK4W6ZFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dX/3Ogvn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dX/3Ogvn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869411F00899;
	Thu, 17 Sep 2026 16:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789661320;
	bh=jRMykOQIWeH4FIOr8LP8l9DywkdafsNkT5OTyx4fOW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dX/3Ogvn4MKyVnp26NM2yYf8mEst9tanrLT2V8j2qgy8svHAfHijchu5EePwJIeLA
	 OcV8gKeDZR9JcAG8ykrKBgV/S6zPEdLugkyIX5Tumi9bRvVyJM/RGSgKyfy9Yp0ZAj
	 3f5U+qU5kFAfGynEAdG0HGeOAtaIHZ0T8NslIkhdcupUEyRUZo9yWXf/2x6Injrz3h
	 0EokZlIPArxmrXbVbUjpwtvITJaCEhJNGKVk08EuquTEy5aUtrbMM/eaz1w0rg99i9
	 scE58bVc7Vyrex+i5gx3kryKNJKZqRLqhKn89ATvT83Nxwt7t2Jd2+LeDf6KuEKzgY
	 I0DSzg7aNRd5Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/5] KVM: SVM: Use guard(mutex) to simplify SNP vCPU state updates
Date: Thu, 17 Sep 2026 12:08:34 -0400
Message-ID: <20260917160835.967199-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917160835.967199-1-sashal@kernel.org>
References: <2026091709-diffusive-reforest-aa65@gregkh>
 <20260917160835.967199-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 5279d6f7e43d9c5863411482943200bf5ab8a261 ]

Use guard(mutex) in sev_snp_init_protected_guest_state() and pull in its
lock-protected inner helper.  Without an unlock trampoline (and even with
one), there is no real need for an inner helper.  Eliminating the helper
also avoids having to fixup the open coded "lockdep" WARN_ON().

Opportunistically drop the error message if KVM can't obtain the pfn for
the new target VMSA.  The error message provides zero information that
can't be gleaned from the fact that the vCPU is stuck.

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20250227012541.3234589-10-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

Backport notes:
Retain the 6.12 guest_memfd API: kvm_gmem_get_pfn() returns a PFN without
a struct page output, and release that reference with
kvm_release_pfn_clean().  Keep the scoped mutex and inline the existing
state-update helper into sev_snp_init_protected_guest_state().

Prepare the existing PSC code so ce6ea7b33e0075335b1eb3b227a21a98e3196e41
applies directly.  Fold in the PSC index-loop cleanup from 17d62e0b157f2
and the PSC metadata/local-variable refactor from 00b9744a36887.  Supply
the equivalent user_exit_on_hypercall() check as a local macro, since
this branch lacks that helper and no new functions are introduced.
These PSC changes preserve the existing behavior; the target still
provides the change to read and cache the request indices once.

Stable-dep-of: ce6ea7b33e00 ("KVM: SEV: Read start/end indices of PSC requests exactly once per #VMGEXIT")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/sev.c | 171 +++++++++++++++++++----------------------
 arch/x86/kvm/svm/svm.h |   8 +-
 2 files changed, 86 insertions(+), 93 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index ee7b46dbb5fa3..66aab76b8a9c1 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -41,6 +41,10 @@
 
 #define GHCB_HV_FT_SUPPORTED	(GHCB_HV_FT_SNP | GHCB_HV_FT_SNP_AP_CREATION)
 
+/* Check whether userspace handles the specified hypercall. */
+#define user_exit_on_hypercall(kvm, hc_nr) \
+	((kvm)->arch.hypercall_exit_enabled & BIT(hc_nr))
+
 /* enable/disable SEV support */
 static bool sev_enabled = true;
 module_param_named(sev, sev_enabled, bool, 0444);
@@ -3724,9 +3728,7 @@ static int snp_begin_psc(struct vcpu_svm *svm);
 
 static void snp_complete_psc(struct vcpu_svm *svm, u64 psc_ret)
 {
-	svm->sev_es.psc_inflight = 0;
-	svm->sev_es.psc_idx = 0;
-	svm->sev_es.psc_2m = false;
+	memset(&svm->sev_es.psc, 0, sizeof(svm->sev_es.psc));
 
 	/*
 	 * PSC requests always get a "no action" response in SW_EXITINFO1, with
@@ -3739,9 +3741,8 @@ static void snp_complete_psc(struct vcpu_svm *svm, u64 psc_ret)
 
 static void __snp_complete_one_psc(struct vcpu_svm *svm)
 {
-	struct psc_buffer *psc = svm->sev_es.ghcb_sa;
-	struct psc_entry *entries = psc->entries;
-	struct psc_hdr *hdr = &psc->hdr;
+	struct vcpu_sev_es_state *sev_es = &svm->sev_es;
+	struct psc_buffer *guest_psc = sev_es->ghcb_sa;
 	__u16 idx;
 
 	/*
@@ -3749,14 +3750,14 @@ static void __snp_complete_one_psc(struct vcpu_svm *svm)
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
@@ -3777,17 +3778,15 @@ static int snp_complete_one_psc(struct kvm_vcpu *vcpu)
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
 	bool huge;
 	u64 gfn;
 
-	if (!(vcpu->kvm->arch.hypercall_exit_enabled & (1 << KVM_HC_MAP_GPA_RANGE))) {
+	if (!user_exit_on_hypercall(vcpu->kvm, KVM_HC_MAP_GPA_RANGE)) {
 		snp_complete_psc(svm, VMGEXIT_PSC_ERROR_GENERIC);
 		return 1;
 	}
@@ -3807,7 +3806,7 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 
 next_range:
 	/* There should be no other PSCs in-flight at this point. */
-	if (WARN_ON_ONCE(svm->sev_es.psc_inflight)) {
+	if (WARN_ON_ONCE(svm->sev_es.psc.batch_size)) {
 		snp_complete_psc(svm, VMGEXIT_PSC_ERROR_GENERIC);
 		return 1;
 	}
@@ -3817,8 +3816,8 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 	 * validation, so take care to only use validated copies of values used
 	 * for things like array indexing.
 	 */
-	idx_start = READ_ONCE(hdr->cur_entry);
-	idx_end = READ_ONCE(hdr->end_entry);
+	idx_start = READ_ONCE(guest_psc->hdr.cur_entry);
+	idx_end = READ_ONCE(guest_psc->hdr.end_entry);
 
 	if (idx_end >= max_nr_entries) {
 		snp_complete_psc(svm, VMGEXIT_PSC_ERROR_INVALID_HDR);
@@ -3826,8 +3825,8 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 	}
 
 	/* Find the start of the next range which needs processing. */
-	for (idx = idx_start; idx <= idx_end; idx++, hdr->cur_entry++) {
-		entry_start = READ_ONCE(entries[idx]);
+	for (idx = idx_start; idx <= idx_end; idx++) {
+		entry_start = READ_ONCE(guest_psc->entries[idx]);
 
 		gfn = entry_start.gfn;
 		huge = entry_start.pagesize;
@@ -3853,6 +3852,14 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 
 		if (npages)
 			break;
+
+		/*
+		 * Increment the guest-visible index to communicate the current
+		 * entry back to the guest, e.g. in case of failure.  No need
+		 * for READ_ONCE() as KVM doesn't consume the field, i.e. a
+		 * misbehaving guest can only break itself.
+		 */
+		guest_psc->hdr.cur_entry++;
 	}
 
 	if (idx > idx_end) {
@@ -3861,9 +3868,9 @@ static int snp_begin_psc(struct vcpu_svm *svm)
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
@@ -3871,14 +3878,14 @@ static int snp_begin_psc(struct vcpu_svm *svm)
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
 
@@ -3913,11 +3920,25 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 	BUG();
 }
 
-static int __sev_snp_update_protected_guest_state(struct kvm_vcpu *vcpu)
+/*
+ * Invoked as part of svm_vcpu_reset() processing of an init event.
+ */
+void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
+	struct kvm_memory_slot *slot;
+	kvm_pfn_t pfn;
+	gfn_t gfn;
+
+	if (!sev_snp_guest(vcpu->kvm))
+		return;
+
+	guard(mutex)(&svm->sev_es.snp_vmsa_mutex);
+
+	if (!svm->sev_es.snp_ap_waiting_for_reset)
+		return;
 
-	WARN_ON(!mutex_is_locked(&svm->sev_es.snp_vmsa_mutex));
+	svm->sev_es.snp_ap_waiting_for_reset = false;
 
 	/* Mark the vCPU as offline and not runnable */
 	vcpu->arch.pv.pv_unhalted = false;
@@ -3932,78 +3953,48 @@ static int __sev_snp_update_protected_guest_state(struct kvm_vcpu *vcpu)
 	 */
 	vmcb_mark_all_dirty(svm->vmcb);
 
-	if (VALID_PAGE(svm->sev_es.snp_vmsa_gpa)) {
-		gfn_t gfn = gpa_to_gfn(svm->sev_es.snp_vmsa_gpa);
-		struct kvm_memory_slot *slot;
-		kvm_pfn_t pfn;
-
-		slot = gfn_to_memslot(vcpu->kvm, gfn);
-		if (!slot)
-			return -EINVAL;
-
-		/*
-		 * The new VMSA will be private memory guest memory, so
-		 * retrieve the PFN from the gmem backend.
-		 */
-		if (kvm_gmem_get_pfn(vcpu->kvm, slot, gfn, &pfn, NULL))
-			return -EINVAL;
-
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
-
-		/* Use the new VMSA */
-		svm->vmcb->control.vmsa_pa = pfn_to_hpa(pfn);
-
-		/* Mark the vCPU as runnable */
-		vcpu->arch.pv.pv_unhalted = false;
-		vcpu->arch.mp_state = KVM_MP_STATE_RUNNABLE;
-
-		svm->sev_es.snp_vmsa_gpa = INVALID_PAGE;
+	if (!VALID_PAGE(svm->sev_es.snp_vmsa_gpa))
+		return;
 
-		/*
-		 * gmem pages aren't currently migratable, but if this ever
-		 * changes then care should be taken to ensure
-		 * svm->sev_es.vmsa is pinned through some other means.
-		 */
-		kvm_release_pfn_clean(pfn);
-	}
+	gfn = gpa_to_gfn(svm->sev_es.snp_vmsa_gpa);
 
-	return 0;
-}
-
-/*
- * Invoked as part of svm_vcpu_reset() processing of an init event.
- */
-void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
-{
-	struct vcpu_svm *svm = to_svm(vcpu);
-	int ret;
+	slot = gfn_to_memslot(vcpu->kvm, gfn);
+	if (!slot)
+		return;
 
-	if (!sev_snp_guest(vcpu->kvm))
+	/*
+	 * The new VMSA will be private memory guest memory, so retrieve the
+	 * PFN from the gmem backend.
+	 */
+	if (kvm_gmem_get_pfn(vcpu->kvm, slot, gfn, &pfn, NULL))
 		return;
 
-	mutex_lock(&svm->sev_es.snp_vmsa_mutex);
+	/*
+	 * From this point forward, the VMSA will always be a guest-mapped page
+	 * rather than the initial one allocated by KVM in svm->sev_es.vmsa. In
+	 * theory, svm->sev_es.vmsa could be free'd and cleaned up here, but
+	 * that involves cleanups like wbinvd_on_all_cpus() which would ideally
+	 * be handled during teardown rather than guest boot.  Deferring that
+	 * also allows the existing logic for SEV-ES VMSAs to be re-used with
+	 * minimal SNP-specific changes.
+	 */
+	svm->sev_es.snp_has_guest_vmsa = true;
 
-	if (!svm->sev_es.snp_ap_waiting_for_reset)
-		goto unlock;
+	/* Use the new VMSA */
+	svm->vmcb->control.vmsa_pa = pfn_to_hpa(pfn);
 
-	svm->sev_es.snp_ap_waiting_for_reset = false;
+	/* Mark the vCPU as runnable */
+	vcpu->arch.pv.pv_unhalted = false;
+	vcpu->arch.mp_state = KVM_MP_STATE_RUNNABLE;
 
-	ret = __sev_snp_update_protected_guest_state(vcpu);
-	if (ret)
-		vcpu_unimpl(vcpu, "snp: AP state update on init failed\n");
+	svm->sev_es.snp_vmsa_gpa = INVALID_PAGE;
 
-unlock:
-	mutex_unlock(&svm->sev_es.snp_vmsa_mutex);
+	/*
+	 * gmem pages aren't currently migratable, but if this ever changes
+	 * then care should be taken to ensure svm->sev_es.vmsa is pinned
+	 * through some other means.
+	 */
+	kvm_release_pfn_clean(pfn);
 }
 
 static int sev_snp_ap_creation(struct vcpu_svm *svm)
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 12b559e84d531..912262c7dc8a2 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -231,9 +231,11 @@ struct vcpu_sev_es_state {
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
 
-- 
2.53.0

