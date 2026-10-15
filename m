Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E813BBFC2
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 16:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792080242; cv=none; b=ej4F59CuMO51sIUaVBBHbRx6klfO0N0C/osVekrTVPkCHEn1nox6icaUSKPXEvMKMMMo7pGsAYXe6MNf4n3OfbxUzDVEYeaKgMMhj1kGWLNM3CAoxoIt1K69ElYjkRVmuNPYFoNRGpourvqEe2inY0FnR/Ak3X/vytaTZjbMDz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792080242; c=relaxed/simple;
	bh=+1w42RKlHjhoMTI6qrGMt7WUDJBfua6V5Wlx0xCt6P4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BBMv3bkQOkUVC2gv78/VdwGIP1+3EHgRMSIPtmaaBPntr/MbI23Ck/3WrsFb+sfGdlGRmtgjYtIS3ACNu1hi8O198NoP0yBIx4QXh3bf7YP82xPz4x7bOaEVmLgJvTw3r04xFtoK3mqYxk4odaI+aYSB/6wNpZyhzuVZUGLLz/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aaltinay.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bv0ddYeg; arc=none smtp.client-ip=74.125.82.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aaltinay.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bv0ddYeg"
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3548cdfd2fbso8146258eec.1
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 09:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792080230; x=1792685030; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tVk1h8kr+4w1E+iNU/gtIDx6drClIgFNmMMcd3gDZFc=;
        b=bv0ddYegfzu5RHHVHvWQmkEqpAXWit3XU3CSWAFLZb+iKvW6h2ZELLTgGTp3vgKoT/
         uV4kJCbE23+8SAPo4QnWRvRq3Q04X6pN3lhu5Wdemq++0LJIlVbzDZA9AEwOOeeu/wZ9
         zhXahQmY2Q8Ttt9HiBl0vkgumN/5Brftz87cICRnk4bl9I/BtGQZ2Yvs2AL/228f9mVr
         E9K/cEq/UMzsyEeT1+D8GkJDqKbb48MFQOJ4+O+8we1GQL/dcX90WZFAPBPYo1OnDYuE
         87dSbmY7zv6g7qy/pZgGwhBppsZmDqPegBRO/nmHkurD7SvXjx/MqdDDXzLXiwm+EpzC
         +D1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792080230; x=1792685030;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tVk1h8kr+4w1E+iNU/gtIDx6drClIgFNmMMcd3gDZFc=;
        b=Z+FuKSihHmNpRrZwn9UBh5paE+QCPCq9hvW9v9E+TZwdQctgrMMSYCjnNwUKOq6O+d
         lG05uZR+gg1uS7Cyj8DbwKiPPI4NBksAoqKe8mtljfupyLsUCSZrFXgVZbTMf5Ex9UaQ
         qq/FVWB1IPj+1mJHmPwveCC954UGv8YWRSXh1iHOi5HpL3lz9YhG0afIKad4kWLELjjq
         Lukd9pUvGpXNWrnMlOtyVXvsslkAGCUInHvJIWXqwVKzhydXIIpkleN4d0xYdY0ALpFy
         huH/S96iE3isHDAR5MZH/iylk1IPvcj8akJlqsElixSMg2RVtjgQTu4ZMudSxFP0/LV5
         fkGw==
X-Gm-Message-State: AFq9FYL2HDTotfuFv4EFTlvYD576AFfymyvMasocE26nT6M+yPGXhYVx
	ZtP2agypcDhb1wAsUCH/RcjRH1GAboTCFZpLkBKKunASMvW5ZBQK8XnBZrYLmgpXJ8nwSodFFXs
	aHvk7sF0RQ9i3hLi3GpqSHb8Yastg6ddC2sqOSS6z9GYqrOGTsgkykU5pW3sht7QaJJGDKxyUGQ
	S/N5o/ILEMSNIBrVZxTkuP195xSDJ9XBoydJxu11E64q43g0U=
X-Received: from dlbvv4.prod.google.com ([2002:a05:7022:5f04:b0:15f:5ef4:b896])
 (user=aaltinay job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:f50a:b0:17c:393d:a0c8 with SMTP id a92af1059eb24-17c393da495mr8478366c88.5.1792080229565;
 Thu, 15 Oct 2026 09:03:49 -0700 (PDT)
Date: Thu, 15 Oct 2026 16:03:42 +0000
In-Reply-To: <20261015160346.181835-1-aaltinay@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261015160346.181835-1-aaltinay@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261015160346.181835-3-aaltinay@google.com>
Subject: [PATCH 6.18.y v2 2/6] KVM: x86: Consolidate CPUID fault handling for
 emulator and interception logic
From: Anil Altinay <aaltinay@google.com>
To: stable@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Anil Altinay <aaltinay@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Sean Christopherson <seanjc@google.com>

commit cf7d65d1d6f50daadfe7c475f0c2b1bfdc288b56 upstream.

Extract the logic for emulating CPUID faulting (where CPUID #GPs at CPL>0
outside of SMM) into a dedicated helper and use the helper for both the
full emulator and the intercepted-CPUID paths.

Opportunistically drop kvm_require_cpl(), as kvm_emulate_cpuid() was the
one and only user.

No functional change intended.

[jim: Add EXPORT_STATIC_CALL_GPL(kvm_x86_get_cpl) so that KVM vendor
modules can call kvm_is_cpuid_allowed(). Fix typo in commit message.]

Signed-off-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Link: https://patch.msgid.link/20260527174347.2356165-2-jmattson@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
[ Resolve minor context conflict in arch/x86/include/asm/kvm_host.h ]
Signed-off-by: Anil Altinay <aaltinay@google.com>
---
 arch/x86/include/asm/kvm_host.h |  1 -
 arch/x86/kvm/cpuid.c            |  5 +++--
 arch/x86/kvm/cpuid.h            |  8 ++++++++
 arch/x86/kvm/emulate.c          |  6 +-----
 arch/x86/kvm/kvm_emulate.h      |  1 +
 arch/x86/kvm/x86.c              | 19 +++++++------------
 6 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index b2cf3431e259..0458f51a571e 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2255,7 +2255,6 @@ void kvm_requeue_exception(struct kvm_vcpu *vcpu, unsigned int nr,
 void kvm_inject_page_fault(struct kvm_vcpu *vcpu, struct x86_exception *fault);
 void kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
 				    struct x86_exception *fault);
-bool kvm_require_cpl(struct kvm_vcpu *vcpu, int required_cpl);
 bool kvm_require_dr(struct kvm_vcpu *vcpu, int dr);
 
 static inline int __kvm_irq_line_state(unsigned long *irq_state,
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index bfa89fbe826b..3f2689fdc304 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -2098,9 +2098,10 @@ int kvm_emulate_cpuid(struct kvm_vcpu *vcpu)
 {
 	u32 eax, ebx, ecx, edx;
 
-	if (!is_smm(vcpu) && cpuid_fault_enabled(vcpu) &&
-	    !kvm_require_cpl(vcpu, 0))
+	if (!kvm_is_cpuid_allowed(vcpu)) {
+		kvm_queue_exception_e(vcpu, GP_VECTOR, 0);
 		return 1;
+	}
 
 	eax = kvm_rax_read(vcpu);
 	ecx = kvm_rcx_read(vcpu);
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index d3f5ae15a7ca..c5399ab7e5ae 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -7,6 +7,8 @@
 #include <asm/processor.h>
 #include <uapi/asm/kvm_para.h>
 
+#include "smm.h"
+
 extern u32 kvm_cpu_caps[NR_KVM_CPU_CAPS] __read_mostly;
 void kvm_set_cpu_caps(void);
 
@@ -184,6 +186,12 @@ static inline bool cpuid_fault_enabled(struct kvm_vcpu *vcpu)
 		  MSR_MISC_FEATURES_ENABLES_CPUID_FAULT;
 }
 
+static inline bool kvm_is_cpuid_allowed(struct kvm_vcpu *vcpu)
+{
+	return !cpuid_fault_enabled(vcpu) || is_smm(vcpu) ||
+	       !kvm_x86_call(get_cpl)(vcpu);
+}
+
 static __always_inline void kvm_cpu_cap_clear(unsigned int x86_feature)
 {
 	unsigned int x86_leaf = __feature_leaf(x86_feature);
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 8aa10d0e9894..54a1528003fa 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -3557,12 +3557,8 @@ static int em_sti(struct x86_emulate_ctxt *ctxt)
 static int em_cpuid(struct x86_emulate_ctxt *ctxt)
 {
 	u32 eax, ebx, ecx, edx;
-	u64 msr = 0;
 
-	ctxt->ops->get_msr(ctxt, MSR_MISC_FEATURES_ENABLES, &msr);
-	if (!ctxt->ops->is_smm(ctxt) &&
-	    (msr & MSR_MISC_FEATURES_ENABLES_CPUID_FAULT) &&
-	    ctxt->ops->cpl(ctxt))
+	if (!ctxt->ops->is_cpuid_allowed(ctxt))
 		return emulate_gp(ctxt, 0);
 
 	eax = reg_read(ctxt, VCPU_REGS_RAX);
diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index 7b5ddb787a25..c0dcfebcec07 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -225,6 +225,7 @@ struct x86_emulate_ops {
 			 struct x86_instruction_info *info,
 			 enum x86_intercept_stage stage);
 
+	bool (*is_cpuid_allowed)(struct x86_emulate_ctxt *ctxt);
 	bool (*get_cpuid)(struct x86_emulate_ctxt *ctxt, u32 *eax, u32 *ebx,
 			  u32 *ecx, u32 *edx, bool exact_only);
 	bool (*guest_has_movbe)(struct x86_emulate_ctxt *ctxt);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ae33393c9b47..6f76290e79c9 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -138,6 +138,7 @@ struct kvm_x86_ops kvm_x86_ops __read_mostly;
 #include <asm/kvm-x86-ops.h>
 EXPORT_STATIC_CALL_GPL(kvm_x86_get_cs_db_l_bits);
 EXPORT_STATIC_CALL_GPL(kvm_x86_cache_reg);
+EXPORT_STATIC_CALL_GPL(kvm_x86_get_cpl);
 
 #define KVM_X86_NESTED_OP(func)							\
 	DEFINE_STATIC_CALL_NULL(kvm_x86_nested_##func,				\
@@ -1011,18 +1012,6 @@ void kvm_queue_exception_e(struct kvm_vcpu *vcpu, unsigned nr, u32 error_code)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_queue_exception_e);
 
-/*
- * Checks if cpl <= required_cpl; if true, return true.  Otherwise queue
- * a #GP and return false.
- */
-bool kvm_require_cpl(struct kvm_vcpu *vcpu, int required_cpl)
-{
-	if (kvm_x86_call(get_cpl)(vcpu) <= required_cpl)
-		return true;
-	kvm_queue_exception_e(vcpu, GP_VECTOR, 0);
-	return false;
-}
-
 bool kvm_require_dr(struct kvm_vcpu *vcpu, int dr)
 {
 	if ((dr != 4 && dr != 5) || !kvm_is_cr4_bit_set(vcpu, X86_CR4_DE))
@@ -8422,6 +8411,11 @@ static int emulator_intercept(struct x86_emulate_ctxt *ctxt,
 					     &ctxt->exception);
 }
 
+static bool emulator_is_cpuid_allowed(struct x86_emulate_ctxt *ctxt)
+{
+	return kvm_is_cpuid_allowed(emul_to_vcpu(ctxt));
+}
+
 static bool emulator_get_cpuid(struct x86_emulate_ctxt *ctxt,
 			      u32 *eax, u32 *ebx, u32 *ecx, u32 *edx,
 			      bool exact_only)
@@ -8545,6 +8539,7 @@ static const struct x86_emulate_ops emulate_ops = {
 	.wbinvd              = emulator_wbinvd,
 	.fix_hypercall       = emulator_fix_hypercall,
 	.intercept           = emulator_intercept,
+	.is_cpuid_allowed    = emulator_is_cpuid_allowed,
 	.get_cpuid           = emulator_get_cpuid,
 	.guest_has_movbe     = emulator_guest_has_movbe,
 	.guest_has_fxsr      = emulator_guest_has_fxsr,
-- 
2.56.0.385.gd3acb90ef8-goog

