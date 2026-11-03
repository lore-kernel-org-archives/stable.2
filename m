Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717016;
	b=2DvP3bYBChTZBVG7A01gZSxdaAsKp3JPlevY3SCOOMc+1b8jCfLeYC3j5LuCptPh3XKu
	 n4AvYRbJVR0R/2tyzuuoKDB0CJo2ZWblKLfnFsuL0j9O4xrOZcDiJNbr9vRk1z+a84VSO
	 x0HSf/6j8NRWozwiVmM09DwqqLAaskCE2LUQTM+UdklvZEUO8YhR7oWAyXccf1IwcBacO
	 yRimAIWqPKOQIg/SWnbr9pV/HXIyaARIM870XV9yk/h69oyOKZG4v9kNR+BIV5rUScMsH
	 Qb1KYUEJOZGO+L4P/+0y/CdmC7/I3/HJ3lV0xDy+/4vshBuXY8cr4MuQZd5r+liftyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717016;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=fIZca3ZFOx2OiQ+HEKSHJ37h67yqYNFOEiVyX8sAl4o=;
	b=iPFm/xtQWE0NH8WSYfZUlsyvu/jlFymhKoBZvTqPB569HNUE2wnpZG0FeriKxL3FDo0n
	 BcSxLCSPttzcC5hSgxr+eZPWVIXP87LcpxnMxc8/xEu9Jvs7Zpsl1akadJmYDa4XGRjMa
	 0XP5pRw3D0wTNhjg9OmChtQm1xmGxRs1RhpRTfnNGZh08zPvh2ZnvEnoWO3yfBPFRF5eZ
	 g5Nhl/+RK2jT+brR8sWeRj3voDtAOpju944obnQDo2uIBAhNP6alokwkJfVh2tMX2JKM5
	 I89yHOUgF3V0ab7BeHeSCAeHSeZTWvN81bcP0m4MZVxIHCJt+dwH4AItdhhsAytV8VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KD6j66jC;
	arc=none smtp.remote-ip=209.85.210.198
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99249606A324
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 14:43:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99249606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KD6j66jC
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8a01e2962a1so3378280b3a.2
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 06:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793717015; x=1794321815; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fIZca3ZFOx2OiQ+HEKSHJ37h67yqYNFOEiVyX8sAl4o=;
        b=KD6j66jCTDywsxdj2YGhnM/0bmYJldPxS2cnfWIVvIyyG5e2ybLGSXisbk/DWMOAHM
         WvzF7Cc6V4dMPiwHVWUkSC89W82ijDHwLsbG2BSwWNmJ3qDflMJ2n1n44YcVOliEfz+E
         TkVFLNdhQAp1JSh6QVcXsGEtycS1V1Ku8O4/c6BChb+H1v9ksWO36vUXOkdHEonRq6Tm
         hek0BiUViBMzHe3L34VNF8oVM1Fpj9iYaLyRMAlDe4A8RxrSCWHglHLrTl6boTTksHzo
         tgAd1gonL7U9FLmbLLIwAnxAOdeXrHG/q2RHrT44aZ3A5rVtBhm9I9xqA/Kt+MZ/mg8f
         BaqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793717015; x=1794321815;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fIZca3ZFOx2OiQ+HEKSHJ37h67yqYNFOEiVyX8sAl4o=;
        b=bZx5JLP1+5PJM0c90W1Epb042EMX/cgtv6D2UDEBBq++VwGnPqxudVzmXRt16HpM5I
         cd03+HHKtvMOj5KmdLKW5ThrNDEst2LCmhf1F6PEhJRzM/ZXheguDpiBRyjE8DJSd/u+
         uxFvF+m7AVRFgKTOh0ZppoCCX1X85iE2OYKwFK7Qhm7bpBET6XLVMRTsIoSlonkQpC8N
         S29OBvcvmE+yq8zdUnBRbl5NRfkHFtJQhhiJpMHyTjl+62GYDP8jsKlKtL3p+qsIzW20
         344HRaaIaCIHj335nVeS42u1obu4YiWXLulh1eAO6hUC0yJwxv7V6+EoJX8Ur7CT9iBJ
         SwDA==
X-Forwarded-Encrypted: i=1; AKwUvBzIUqaoV+eWwNfow5nUKu7n5Yao0xsIEazlCjZimiOkaSErCTZ8cGrxkf0K3GiDBw+R550Werw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/9BdX9iOlTN+QsJEnbTbTlnA3uu5lHS004T5eU9eatDX1FEKiV
	Iw5UZir5e4MVxGd/Sq3vbXyQH13vFqINW5+10LIpbH0+K6bAxNGbz99/L3miDEWi8ObD1WHoorN
	fD9EEvg==
X-Received: from pfbhu13.prod.google.com ([2002:a05:6a00:698d:b0:89e:78fd:6ab9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:12c2:b0:8a9:95d6:31f4
 with SMTP id d2e1a72fcca58-8a9beb69affmr11186999b3a.32.1793717012595; Tue, 03
 Nov 2026 06:43:32 -0800 (PST)
Date: Tue, 3 Nov 2026 06:43:31 -0800
In-Reply-To: <20261103124930.2278671-2-pbonzini@redhat.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261103124930.2278671-1-pbonzini@redhat.com> <20261103124930.2278671-2-pbonzini@redhat.com>
Message-ID: <aunzE4yywHJOqsk4@google.com>
Subject: Re: [PATCH 1/2] KVM: register asynchronous page fault waits with
 interrupts disabled
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Hillf Danton <hdanton@sina.com>, Steven Rostedt <rostedt@goodmis.org>, Harry Yoo <harry@kernel.org>, 
	syzbot+f11512d1e5878ba5e60e@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Nov 03, 2026, Paolo Bonzini wrote:
> KVM cannot use a node on the stack like kvm_async_pf_task_wait_schedule() does

Oh!  Yes, KVM can!  If we fully handle the PV async #PF in vcpu_enter_guest(),
then the node can be put on the stack, right?  Juggling preemption and guest
timing is heinous, but on the plus side it consolidates the PV async #PF code,
so I think it's a net positive?  Especially when factoring in the node stuff.

Not properly nested (we really need PV async #PF test coverage).

From: Sean Christopherson <seanjc@google.com>
Date: Tue, 3 Nov 2026 06:08:54 -0800
Subject: [PATCH] KVM: x86: Handle KVM-as-a-guest paravirt async #PFs before
 enabling IRQs

Fully handle PV async #PFs (when running as a KVM guest) before enabling
IRQs so that it's impossible for the current task, i.e. the vCPU task, to
be preempted before invoking kvm_async_pf_task_wait_schedule().  This will
allow the guest-side async #PF code to eliminate its dummy allocation,
which is needed only to handle the case where the page ready notification
is delivered before handling the not-present #PF.

Add dedicated handling for PV async #PFs instead of wrapping/piggybacking
kvm_x86_ops.handle_exit_irqoff(), as the act of handling an async #PF may
enable IRQs and schedule out the current task, i.e. needs to be done just
before KVM itself explicitly enables IRQs, and needs to enable preemption
before calling into the kernel's PV async #PF handler.

Opportunistically wrap the code with CONFIG_KVM_GUEST to help document the
context, and drop the CONFIG_KVM_GUEST=n stubs.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |  1 +
 arch/x86/include/asm/kvm_host.h    |  2 +-
 arch/x86/include/asm/kvm_para.h    |  7 ---
 arch/x86/kvm/mmu/mmu.c             | 19 +-------
 arch/x86/kvm/svm/nested.c          |  4 --
 arch/x86/kvm/svm/svm.c             | 16 +++++--
 arch/x86/kvm/vmx/main.c            | 14 ++++--
 arch/x86/kvm/vmx/nested.c          |  3 +-
 arch/x86/kvm/vmx/vmx.c             | 13 +++--
 arch/x86/kvm/vmx/x86_ops.h         |  1 +
 arch/x86/kvm/x86.c                 | 76 ++++++++++++++++++++++--------
 11 files changed, 92 insertions(+), 64 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 48fa973b98d5..119fb588fc30 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -107,6 +107,7 @@ KVM_X86_OP(write_tsc_offset)
 KVM_X86_OP(write_tsc_multiplier)
 KVM_X86_OP(get_exit_info)
 KVM_X86_OP(get_entry_info)
+KVM_X86_OP(get_pf_exit_info)
 KVM_X86_OP(check_intercept)
 KVM_X86_OP(handle_exit_irqoff)
 KVM_X86_OP_OPTIONAL(update_cpu_dirty_logging)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 0378577d9d8b..63cc2026dfce 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -959,7 +959,6 @@ struct kvm_vcpu_arch {
 		u64 msr_int_val; /* MSR_KVM_ASYNC_PF_INT */
 		u16 vec;
 		u32 id;
-		u32 host_apf_flags;
 		bool pageready_pending;
 	} apf;
 
@@ -1683,6 +1682,7 @@ struct kvm_x86_ops {
 
 	void (*get_entry_info)(struct kvm_vcpu *vcpu,
 			       u32 *intr_info, u32 *error_code);
+	bool (*get_pf_exit_info)(struct kvm_vcpu *vcpu, u64 *fault_address);
 
 	int (*check_intercept)(struct kvm_vcpu *vcpu,
 			       struct x86_instruction_info *info,
diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
index 4a47c16e2df8..857d4ac7dc42 100644
--- a/arch/x86/include/asm/kvm_para.h
+++ b/arch/x86/include/asm/kvm_para.h
@@ -146,8 +146,6 @@ static inline void kvm_spinlock_init(void)
 #endif /* CONFIG_PARAVIRT_SPINLOCKS */
 
 #else /* CONFIG_KVM_GUEST */
-#define kvm_async_pf_task_wait_schedule(T) do {} while(0)
-
 static inline bool kvm_para_available(void)
 {
 	return false;
@@ -163,11 +161,6 @@ static inline unsigned int kvm_arch_para_hints(void)
 	return 0;
 }
 
-static inline u32 kvm_read_and_reset_apf_flags(void)
-{
-	return 0;
-}
-
 static __always_inline bool kvm_handle_async_pf(struct pt_regs *regs, u32 token)
 {
 	return false;
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index f4b12d6aef55..3cc4bf506cb1 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4954,9 +4954,6 @@ static int nonpaging_page_fault(struct kvm_vcpu *vcpu,
 int kvm_handle_page_fault(struct kvm_vcpu *vcpu, u64 error_code,
 				u64 fault_address, char *insn, int insn_len)
 {
-	int r = 1;
-	u32 flags = vcpu->arch.apf.host_apf_flags;
-
 #ifndef CONFIG_X86_64
 	/* A 64-bit CR2 should be impossible on 32-bit KVM. */
 	if (KVM_BUG_ON(fault_address >> 32, vcpu->kvm))
@@ -4977,21 +4974,9 @@ int kvm_handle_page_fault(struct kvm_vcpu *vcpu, u64 error_code,
 	BUILD_BUG_ON(lower_32_bits(PFERR_SYNTHETIC_MASK));
 
 	kvm_request_l1tf_flush_l1d();
-	if (!flags) {
-		trace_kvm_page_fault(vcpu, fault_address, error_code);
+	trace_kvm_page_fault(vcpu, fault_address, error_code);
 
-		r = kvm_mmu_page_fault(vcpu, fault_address, error_code, insn,
-				insn_len);
-	} else if (flags & KVM_PV_REASON_PAGE_NOT_PRESENT) {
-		vcpu->arch.apf.host_apf_flags = 0;
-		local_irq_disable();
-		kvm_async_pf_task_wait_schedule(fault_address);
-		local_irq_enable();
-	} else {
-		WARN_ONCE(1, "Unexpected host async PF flags: %x\n", flags);
-	}
-
-	return r;
+	return kvm_mmu_page_fault(vcpu, fault_address, error_code, insn, insn_len);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_handle_page_fault);
 
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 07554089ec05..d4951dc8b1f7 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1818,10 +1818,6 @@ int nested_svm_exit_special(struct vcpu_svm *svm)
 		if (svm->vmcb01.ptr->control.intercepts[INTERCEPT_EXCEPTION] &
 		    excp_bits)
 			return NESTED_EXIT_HOST;
-		else if (exit_code == SVM_EXIT_EXCP_BASE + PF_VECTOR &&
-			 svm->vcpu.arch.apf.host_apf_flags)
-			/* Trap async PF even if not shadowing */
-			return NESTED_EXIT_HOST;
 		break;
 	}
 	case SVM_EXIT_VMMCALL:
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 581bc3a23c95..32e1f6d0fc38 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3811,7 +3811,17 @@ static void svm_get_entry_info(struct kvm_vcpu *vcpu, u32 *intr_info,
 		*error_code = control->event_inj_err;
 	else
 		*error_code = 0;
+}
 
+static bool svm_get_pf_exit_info(struct kvm_vcpu *vcpu, u64 *fault_address)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	if (svm->vmcb->control.exit_code != SVM_EXIT_EXCP_BASE + PF_VECTOR)
+		return false;
+
+	*fault_address = svm->vmcb->control.exit_info_2;
+	return true;
 }
 
 static int svm_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
@@ -4758,11 +4768,6 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 			       vcpu_to_pmu(vcpu)->global_ctrl);
 	}
 
-	/* if exit due to PF check for async PF */
-	if (svm->vmcb->control.exit_code == SVM_EXIT_EXCP_BASE + PF_VECTOR)
-		vcpu->arch.apf.host_apf_flags =
-			kvm_read_and_reset_apf_flags();
-
 	kvm_clear_available_registers(vcpu, SVM_REGS_LAZY_LOAD_SET);
 
 	trace_kvm_exit(vcpu, KVM_ISA_SVM);
@@ -5544,6 +5549,7 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 
 	.get_exit_info = svm_get_exit_info,
 	.get_entry_info = svm_get_entry_info,
+	.get_pf_exit_info = svm_get_pf_exit_info,
 
 	.vcpu_after_set_cpuid = svm_vcpu_after_set_cpuid,
 
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index d75170a6199e..370f649595f9 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -721,6 +721,14 @@ static void vt_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
 	vmx_get_exit_info(vcpu, reason, info1, info2, intr_info, error_code);
 }
 
+static bool vt_get_pf_exit_info(struct kvm_vcpu *vcpu, u64 *fault_address)
+{
+	if (is_td_vcpu(vcpu))
+		return false;
+
+	return vmx_get_pf_exit_info(vcpu, fault_address);
+}
+
 static void vt_update_cr8_intercept(struct kvm_vcpu *vcpu, int tpr, int irr)
 {
 	if (is_td_vcpu(vcpu))
@@ -914,11 +922,8 @@ static void handle_nm_fault_irqoff(struct kvm_vcpu *vcpu)
 
 static void handle_exception_irqoff(struct kvm_vcpu *vcpu, u32 intr_info)
 {
-	/* if exit due to PF check for async PF */
-	if (is_page_fault(intr_info))
-		vcpu->arch.apf.host_apf_flags = kvm_read_and_reset_apf_flags();
 	/* if exit due to NM, handle before interrupts are enabled */
-	else if (is_nm_fault(intr_info))
+	if (is_nm_fault(intr_info))
 		handle_nm_fault_irqoff(vcpu);
 	/* Handle machine checks before interrupts are enabled */
 	else if (is_machine_check(intr_info))
@@ -1100,6 +1105,7 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 
 	.get_exit_info = vt_op(get_exit_info),
 	.get_entry_info = vt_op(get_entry_info),
+	.get_pf_exit_info = vt_op(get_pf_exit_info),
 
 	.vcpu_after_set_cpuid = vt_op(vcpu_after_set_cpuid),
 
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index f0d75f5a968c..087c12e11d74 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -6500,8 +6500,7 @@ static bool nested_vmx_l0_wants_exit(struct kvm_vcpu *vcpu,
 		if (is_nmi(intr_info))
 			return true;
 		else if (is_page_fault(intr_info))
-			return vcpu->arch.apf.host_apf_flags ||
-			       vmx_need_pf_intercept(vcpu);
+			return vmx_need_pf_intercept(vcpu);
 		else if (is_debug(intr_info) &&
 			 vcpu->guest_debug &
 			 (KVM_GUESTDBG_SINGLESTEP | KVM_GUESTDBG_USE_HW_BP))
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b341af4c6057..464d6ed862d5 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5396,9 +5396,6 @@ static int vmx_handle_page_fault(struct kvm_vcpu *vcpu, u32 error_code)
 {
 	unsigned long cr2 = vt_get_exit_qual(vcpu);
 
-	if (vcpu->arch.apf.host_apf_flags)
-		goto handle_pf;
-
 	/* When using EPT, KVM intercepts #PF only to detect illegal GPAs. */
 	WARN_ON_ONCE(enable_ept && !allow_smaller_maxphyaddr);
 
@@ -5429,7 +5426,6 @@ static int vmx_handle_page_fault(struct kvm_vcpu *vcpu, u32 error_code)
 		return 1;
 	}
 
-handle_pf:
 	return kvm_handle_page_fault(vcpu, error_code, cr2, NULL, 0);
 }
 
@@ -6402,6 +6398,15 @@ void vmx_get_entry_info(struct kvm_vcpu *vcpu, u32 *intr_info, u32 *error_code)
 		*error_code = 0;
 }
 
+bool vmx_get_pf_exit_info(struct kvm_vcpu *vcpu, u64 *fault_address)
+{
+	if (!is_page_fault(vt_get_intr_info(vcpu)))
+		return false;
+
+	*fault_address = vt_get_exit_qual(vcpu);
+	return true;
+}
+
 static void vmx_destroy_pml_buffer(struct kvm_vcpu *vcpu)
 {
 	if (vcpu->arch.pml_page) {
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index cd72684d075d..30a712266c4e 100644
--- a/arch/x86/kvm/vmx/x86_ops.h
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -113,6 +113,7 @@ static inline bool vmx_tdp_has_smep(struct kvm *kvm)
 void vmx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
 		       u64 *info1, u64 *info2, u32 *intr_info, u32 *error_code);
 void vmx_get_entry_info(struct kvm_vcpu *vcpu, u32 *intr_info, u32 *error_code);
+bool vmx_get_pf_exit_info(struct kvm_vcpu *vcpu, u64 *fault_address);
 
 u64 vmx_get_l2_tsc_offset(struct kvm_vcpu *vcpu);
 u64 vmx_get_l2_tsc_multiplier(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 26e7beaff8a0..0956bf8fbe65 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8118,6 +8118,31 @@ static void kvm_update_cpu_dirty_logging(struct kvm_vcpu *vcpu)
 	kvm_x86_call(update_cpu_dirty_logging)(vcpu, enable);
 }
 
+static bool kvm_handle_pv_async_pf(struct kvm_vcpu *vcpu)
+{
+#ifdef CONFIG_KVM_GUEST
+	u32 host_apf_flags;
+	u64 fault_address;
+
+	if (!kvm_x86_call(get_pf_exit_info)(vcpu, &fault_address))
+		return false;
+
+	host_apf_flags = kvm_read_and_reset_apf_flags();
+	if (!host_apf_flags ||
+	    WARN_ON_ONCE(!(host_apf_flags & KVM_PV_REASON_PAGE_NOT_PRESENT)))
+		return false;
+
+	guest_timing_exit_irqoff();
+
+	preempt_enable();
+	kvm_async_pf_task_wait_schedule(fault_address);
+	local_irq_enable();
+	return true;
+#else
+	return false;
+#endif
+}
+
 /*
  * Called within kvm->srcu read side.
  * Returns 1 to let vcpu_run() continue the guest execution loop without
@@ -8521,29 +8546,40 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		this_cpu_write(x86_ibpb_exit_to_user, true);
 
 	/*
-	 * Consume any pending interrupts, including the possible source of
-	 * VM-Exit on SVM and any ticks that occur between VM-Exit and now.
-	 * An instruction is required after local_irq_enable() to fully unblock
-	 * interrupts on processors that implement an interrupt shadow, the
-	 * stat.exits increment will do nicely.
+	 * Handle PV async #PFs, before enabling IRQs, to ensure the page ready
+	 * notification arrives after the async #PF is queued.  Note, the async
+	 * #PF handler is responsible for enabling preemption and IRQs, and for
+	 * exiting guest timing if the #PF is an async #PF (because handling PV
+	 * async #PFs enables IRQs and may schedule out this task).
 	 */
-	kvm_before_interrupt(vcpu, KVM_HANDLING_IRQ);
-	local_irq_enable();
-	++vcpu->stat.exits;
-	local_irq_disable();
-	kvm_after_interrupt(vcpu);
+	if (exit_fastpath == EXIT_FASTPATH_NONE && kvm_handle_pv_async_pf(vcpu)) {
+		exit_fastpath = EXIT_FASTPATH_EXIT_HANDLED;
+	} else {
+		/*
+		* Consume any pending interrupts, including the possible source
+		* of VM-Exit on SVM, and any ticks that occur between VM-Exit
+		* and now.  An instruction is required after local_irq_enable()
+		* to fully unblock interrupts on processors that implement an
+		* interrupt shadow, the stat.exits increment will do nicely.
+		*/
+		kvm_before_interrupt(vcpu, KVM_HANDLING_IRQ);
+		local_irq_enable();
+		++vcpu->stat.exits;
+		local_irq_disable();
+		kvm_after_interrupt(vcpu);
 
-	/*
-	 * Wait until after servicing IRQs to account guest time so that any
-	 * ticks that occurred while running the guest are properly accounted
-	 * to the guest.  Waiting until IRQs are enabled degrades the accuracy
-	 * of accounting via context tracking, but the loss of accuracy is
-	 * acceptable for all known use cases.
-	 */
-	guest_timing_exit_irqoff();
+		/*
+		 * Wait until after servicing IRQs to account guest time so that
+		 * any ticks that occurred while running the guest are properly
+		 * accounted to the guest.  Waiting until IRQs are enabled
+		 * degrades the accuracy of accounting via context tracking, but
+		 * the loss of accuracy is acceptable for all known use cases.
+		 */
+		guest_timing_exit_irqoff();
 
-	local_irq_enable();
-	preempt_enable();
+		local_irq_enable();
+		preempt_enable();
+	}
 
 	kvm_vcpu_srcu_read_lock(vcpu);
 

base-commit: d21eef2084a9af87ac2a783bc7c2b175ba114e4e
--
