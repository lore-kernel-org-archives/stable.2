Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795631230;
	b=FqyZ63tuo7u3DRfXCy9iVK33GVsFXfLg7ENOGZJ3kk3ryPKMwrtXEiDrjgElveuMiKzn
	 q5lnpykDDgeeJKcoYzNd8JthngTsT0B/BfUC+KD3aMtq6vLnzPHAkU55mYj3wS/PfJ7c2
	 xIL7e0/KqFyApBwzAUrB0rC28ehK+KI6H4wcXTc/6rLHvAstGcNQbADdTgWVANA3PjuCI
	 QTJXtmbhQi6Af5PFTMA9RWv+cR0NDPQ0O+qOMJHzm4Z9MA4tlUOQPWC5+ZSonjF5iVUIL
	 jgmdJD+dyp5fhERtO1sqTDuz02oNMsK7bXrtyCrSTGq5v3jeBwRzLJH8TsiAFTL4uJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795631230;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MIZ5Or0eEeX1AB6lpchODeBO2XHWv6zyTHW0CDhWaRI=;
	b=LeaxQyMlDKnSF2m+E1gk86bUZ3DtpYVkoOIfz8k5RxoxMkgYwlulNB8wNG43M7xnMqmq
	 D1YTkzM+mE9iwEECJoEjlsrx927PTcVmJKY0Fy30pgKV/IMbG/vr2mdj8FctfKYOBgoKU
	 i81DF91J2KMUv/MO1RIyaXOG88p0PC08TSL4lp0dN97xiEHI2nJfjAzddKIr+RJKkf1N0
	 GJabIr/ko1lTqRuca6NCVCxBmjslecjphCQgP8tyWnztVuePolTOk9aaHSH9Hq9WDC2Lt
	 5kSjA/Mg9iHEJ+Ok7HznsqJcBux2ONnyZAAW3/GZDBwT3XBI3vq+HAQmes8IQls6+Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EzY+rXcA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2706D606A336;
	Wed, 25 Nov 2026 18:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EzY+rXcA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6331F000CF;
	Wed, 25 Nov 2026 18:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795631230;
	bh=MIZ5Or0eEeX1AB6lpchODeBO2XHWv6zyTHW0CDhWaRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EzY+rXcAaezjmu4azGW3xiPIhzlw3fYH8MC3KbdQ1bRgFn2g24idQd1QbQg8EU9zH
	 cAhuS+hEAR0vUB03UP4bO7mznqIBAK8G7bNt1/+D+lY5EMVgwibvZpQHKPdzIo5fNc
	 Q5EEx9Ouh6lyQtHaJohAAjVEg5xnjYMY7t7pqCkHSky1r24CRHAFQyGhOYa37BRJ6U
	 A1F5gYVjPZYMC7o7nQQ/CIh2Ec7wGd5+k0NX0h2dpglIsOMBiw5b27i73NO9ehjNMO
	 a8KDtMxGdHCzW7WRgAdrKBxuQxuf2K9eQ65sZ54TrBZT19+8A/SJJ8sKUUPIMzD+Qy
	 O5sr2Tx2Ce23A==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] KVM: x86/pmu: Always defer PMU reprogramming on SVM nested transitions
Date: Wed, 25 Nov 2026 18:27:02 +0000
Message-ID: <20261125182703.1694998-3-yosry@kernel.org>
X-Mailer: git-send-email 2.56.1.911.g883d8bcb20-goog
In-Reply-To: <20261125182703.1694998-1-yosry@kernel.org>
References: <20261125182703.1694998-1-yosry@kernel.org>
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

Always defer PMU counter reprogramming via KVM_REQ_PMU on SVM nested
transitions and EFER.SVME toggles instead of invoking
kvm_pmu_handle_event() synchronously. The motivation for synchronous
handling was to ensure to-be-emulated PMCs are updated before
instruction emulation completes, such that instructions count in the
mode they retire in (as per the hardware behavior).

However, since kvm_pmu_request_counters_reprogram() now recalculates
to-be-emulated PMCs synchronously, and kvm_pmu_recalc_pmc_emulation() ->
pmc_is_locally_enabled() already accounts for Host-Only and Guest-Only
bits on AMD, VMRUN or WRMSR(MSR_EFER) would correctly be counted in the
mode they retire in.

In addition to being a nice cleanup, this fixes an unprotected SRCU
access (and potential UAF) when userspace updates EFER.SVME via
KVM_SET_SREGS[2], as svm_set_efer() ends up calling
kvm_mediated_pmu_refresh_event_filter() -> pmc_is_event_allowed(), which
dereferences kvm->arch.pmu_event_filter via srcu_dereference(). This
results in the following splat (with CONFIG_PROVE_RCU):

  WARNING: suspicious RCU usage
  arch/x86/kvm/pmu.c:539 suspicious rcu_dereference_check() usage!
  ...
  pmc_is_event_allowed+0x27c/0x2b0 [kvm]
  kvm_pmu_handle_event+0x365/0x880 [kvm]
  svm_set_efer+0x16b/0x1a0 [kvm_amd]
  __set_sregs_common+0x2fd/0x6a0 [kvm]
  __set_sregs+0x37/0xd0 [kvm]
  kvm_arch_vcpu_ioctl_set_sregs+0x3e/0x50 [kvm]
  kvm_vcpu_ioctl+0x53a/0x6b0 [kvm]

Fixes: a02a25a65246 ("KVM: x86/pmu: Reprogram Host/Guest-Only counters on nested transitions")
Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/pmu.c        |  1 -
 arch/x86/kvm/pmu.h        | 26 ++++++++------------------
 arch/x86/kvm/svm/nested.c | 10 +---------
 arch/x86/kvm/svm/svm.h    | 18 ++----------------
 4 files changed, 11 insertions(+), 44 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index eef2f792dc9e8..ae781bce7d322 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -698,7 +698,6 @@ void kvm_pmu_handle_event(struct kvm_vcpu *vcpu)
 	kvm_for_each_pmc(pmu, pmc, bit, bitmap)
 		kvm_pmu_recalc_pmc_emulation(pmu, pmc);
 }
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_pmu_handle_event);
 
 int kvm_pmu_check_rdpmc_early(struct kvm_vcpu *vcpu, unsigned int idx)
 {
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 8aa9db1569167..910a09ed9274e 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -216,11 +216,8 @@ extern struct x86_pmu_capability kvm_pmu_cap;
 void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu_ops);
 
 void kvm_pmu_recalc_pmc_emulation(struct kvm_pmu *pmu, struct kvm_pmc *pmc);
-void kvm_pmu_handle_event(struct kvm_vcpu *vcpu);
 
-static inline void __kvm_pmu_reprogram_counters(struct kvm_pmu *pmu,
-						u64 counters,
-						bool defer)
+static inline void kvm_pmu_request_counters_reprogram(struct kvm_pmu *pmu, u64 counters)
 {
 	DECLARE_BITMAP(bitmap, X86_PMC_IDX_MAX);
 	struct kvm_pmc *pmc;
@@ -229,22 +226,14 @@ static inline void __kvm_pmu_reprogram_counters(struct kvm_pmu *pmu,
 	if (!counters)
 		return;
 
+	BUILD_BUG_ON(sizeof(bitmap) != sizeof(counters));
 	atomic64_or(counters, &pmu->__reprogram_pmi);
-	if (defer) {
-		BUILD_BUG_ON(sizeof(bitmap) != sizeof(counters));
-		bitmap_from_u64(bitmap, counters);
-		kvm_for_each_pmc(pmu, pmc, bit, bitmap)
-			kvm_pmu_recalc_pmc_emulation(pmu, pmc);
-		kvm_make_request(KVM_REQ_PMU, pmu_to_vcpu(pmu));
-	} else {
-		kvm_pmu_handle_event(pmu_to_vcpu(pmu));
-	}
-}
+	bitmap_from_u64(bitmap, counters);
 
-static inline void kvm_pmu_request_counters_reprogram(struct kvm_pmu *pmu,
-						      u64 counters)
-{
-	__kvm_pmu_reprogram_counters(pmu, counters, true);
+	kvm_for_each_pmc(pmu, pmc, bit, bitmap)
+		kvm_pmu_recalc_pmc_emulation(pmu, pmc);
+
+	kvm_make_request(KVM_REQ_PMU, pmu_to_vcpu(pmu));
 }
 
 static inline void kvm_pmu_request_counter_reprogram(struct kvm_pmc *pmc)
@@ -278,6 +267,7 @@ static inline bool kvm_pmu_is_fastpath_emulation_allowed(struct kvm_vcpu *vcpu)
 }
 
 void kvm_pmu_deliver_pmi(struct kvm_vcpu *vcpu);
+void kvm_pmu_handle_event(struct kvm_vcpu *vcpu);
 int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned pmc, u64 *data);
 int kvm_pmu_check_rdpmc_early(struct kvm_vcpu *vcpu, unsigned int idx);
 bool kvm_pmu_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr);
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 1cecb82702e2c..122be289660c3 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1539,15 +1539,7 @@ void svm_leave_nested(struct kvm_vcpu *vcpu)
 		svm->nested.vmcb12_gpa = INVALID_GPA;
 
 		leave_guest_mode(vcpu);
-
-		/*
-		 * Force leaving nested is a non-architectural flow so precision
-		 * isn't a priority.  Defer updating the PMU until the next vCPU
-		 * run, potentially tolerating some imprecision to avoid poking
-		 * into PMU state from arbitrary contexts (e.g. to avoid using
-		 * stale state).
-		 */
-		__svm_pmu_handle_nested_transition(svm, true);
+		svm_pmu_handle_nested_transition(svm);
 
 		svm_switch_vmcb(svm, &svm->vmcb01);
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 011ab9cd40301..1c7727d47125c 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -914,26 +914,12 @@ bool nested_svm_check_vmcb01_save(struct kvm_vcpu *vcpu,
 				  struct vmcb_save_area *save);
 void svm_switch_vmcb(struct vcpu_svm *svm, struct kvm_vmcb_info *target_vmcb);
 
-
-static inline void __svm_pmu_handle_nested_transition(struct vcpu_svm *svm,
-						      bool defer)
+static inline void svm_pmu_handle_nested_transition(struct vcpu_svm *svm)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(&svm->vcpu);
 	u64 counters = *(u64 *)pmu->pmc_has_mode_specific_enables;
 
-	__kvm_pmu_reprogram_counters(pmu, counters, defer);
-}
-
-static inline void svm_pmu_handle_nested_transition(struct vcpu_svm *svm)
-{
-	/*
-	 * Do NOT defer reprogramming the counters by default.  Instructions
-	 * causing a state change are counted based on the _new_ CPU state
-	 * (e.g. a successful VMRUN is counted in guest mode). Hence, the
-	 * counters should be reprogrammed with the new state _before_ the
-	 * instruction is potentially counted upon emulation completion.
-	 */
-	__svm_pmu_handle_nested_transition(svm, false);
+	kvm_pmu_request_counters_reprogram(pmu, counters);
 }
 
 extern struct kvm_x86_nested_ops svm_nested_ops;
-- 
2.56.1.839.g22a8290db9-goog

