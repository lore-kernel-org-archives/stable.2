Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93405472777
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 18:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788201123; cv=none; b=O/zR5D7AYu53n5rWyuJ95Wxl9+JH0QQWi0LlLulbZVhJGPBJFutH/+wNA7uoD4QKk7RWZMgC5PNBZu0XzQo3Nr4pu/hwjQDhIBceCcjgVz8KMCnYM0jg8rHgtqulv00mma9Dgz/gdeNSW8fULTYPNlvdwZxBhIOnQQcPq8A3MAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788201123; c=relaxed/simple;
	bh=CwwCK4T138a4qMH2pGPLU0JspGic+KcJdOsnBThaRTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ts6RxcfpPgnyW36hD6rmOFve3OcgEv6LHcdRdnKxFhUEf51CWqARZ8f6XIj1Gj8fXRUj+ZfmUCu8T63nbJ7h1TYEEAg5hROUoRbW2MnCrDVOA+G6AsbzGc0dNzVIOQELgX4T8ZQkDWmvrimmtES/+bThwtokekHeNBcNcPtTlD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFqOe8vq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFqOe8vq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C1E1F00A3E;
	Mon, 31 Aug 2026 18:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788201121;
	bh=WCemP8l3BhKrXF5vZmPUFohWG3ZR6YedAT0x/yvcjgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jFqOe8vq6k9Cqmy2po3S1z5poFZ9xSVd6AKB9V4eb9ZFo03uLQh2PuNXM9UrviNsY
	 2CXbQg9bn0ctIEXFImQIBTGvM7zTYtyc1CizqVvT+NoDCYnqT5n1skIm1MtUZ73SV/
	 784W2tw+WTNY3ssXptSW3AAdfiQ8+ZSyBN7pFdsmx+nx0kFkSp2jkKtuW/YyCOC2IK
	 Do+uWvwVcrkMuSsyZJw47B1f85+TN04GLECDoEPt8Z4e2FsAD4Zwt+23bftXiUkcfG
	 TqIFrBT2dFcEHM87MtEy6zJARkyWuCl0qiTNq3tIdYTvxqMooEtcj0/XX0+jwPmJeG
	 SAK1PxIu/zqFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/6] KVM: SVM: Use guard(mutex) to simplify SNP vCPU state updates
Date: Mon, 31 Aug 2026 14:31:53 -0400
Message-ID: <20260831183157.1673215-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831183157.1673215-1-sashal@kernel.org>
References: <2026083106-utensil-mangy-28f5@gregkh>
 <20260831183157.1673215-1-sashal@kernel.org>
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

[ This tree lacks upstream commit 1fbee5b01a0fd ("KVM: guest_memfd:
  Provide "struct page" as output from kvm_gmem_get_pfn()"), so its
  kvm_gmem_get_pfn() still uses the older pfn-only signature (no
  struct page **).  Adapted the refactored
  sev_snp_init_protected_guest_state() to keep calling
  kvm_gmem_get_pfn() without a page argument and to use
  kvm_release_pfn_clean(pfn) instead of kvm_release_page_clean(page). ]

Stable-dep-of: 42a39ad5d592 ("KVM: SEV: Track the GPA of the guest-controlled VMSA used for SNP guests")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/sev.c | 114 ++++++++++++++++++-----------------------
 1 file changed, 49 insertions(+), 65 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 058d34622be35..be6150ec1b2f2 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3908,11 +3908,25 @@ static int snp_begin_psc(struct vcpu_svm *svm)
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
 
-	WARN_ON(!mutex_is_locked(&svm->sev_es.snp_vmsa_mutex));
+	if (!sev_snp_guest(vcpu->kvm))
+		return;
+
+	guard(mutex)(&svm->sev_es.snp_vmsa_mutex);
+
+	if (!svm->sev_es.snp_ap_waiting_for_reset)
+		return;
+
+	svm->sev_es.snp_ap_waiting_for_reset = false;
 
 	/* Mark the vCPU as offline and not runnable */
 	vcpu->arch.pv.pv_unhalted = false;
@@ -3927,78 +3941,48 @@ static int __sev_snp_update_protected_guest_state(struct kvm_vcpu *vcpu)
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
-
-		/*
-		 * gmem pages aren't currently migratable, but if this ever
-		 * changes then care should be taken to ensure
-		 * svm->sev_es.vmsa is pinned through some other means.
-		 */
-		kvm_release_pfn_clean(pfn);
-	}
+	if (!VALID_PAGE(svm->sev_es.snp_vmsa_gpa))
+		return;
 
-	return 0;
-}
+	gfn = gpa_to_gfn(svm->sev_es.snp_vmsa_gpa);
 
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
-- 
2.53.0

