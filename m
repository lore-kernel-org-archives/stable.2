Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793753267;
	b=3ZJX8tbZbOp4FV+5tFLTHzRLnFj7gpYXQDOKbBLCKVpQPBFMAzSL1W7zkpc4H+aG966w
	 qJf1zqDO8siek35mL2+jr5nxCCd6QvJ4UHdLNBOk1ObsiXcoI0dmFk+sWxfX+jQGdYB5u
	 0g86u7oYOUqD3w8q7DK+C4+l8gXB6Ll6QQwT4RpXk2X/LExxSQH8G2sS3XuylV64G4mUI
	 g6qoRSqEsWWYojnIBhL2y6MAdsAV4W8YDv8H6vFunck4otARs7PPv81EgAAWwRH/bm0SW
	 HfOgOlMNNnDL7BfSSIJMTp1I1IStuWs8Axjt7tQvx+rqhYwQQEEGNXuR5IcjghXoP2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793753267;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Ma0BJNPiyw5G435eYcqXLhH2XcRvaZWBudt7erlHK0w=;
	b=sqTIM0kVggzxT6lLmj2NZbu8EURLKPRramAgtSisvC0ZaECE0PiVgZNmfiy11o52DpwM
	 WZUUxJhCWKicyir5WEl8qkLZ2PMC0b4paq4o2zJyotYY9Io7BaECLXL5MWooCspUfcD8g
	 jog1X9w6aXw5aQIK7a5bUd271Bji5LH1OenHrRCcxYRyhDfcuOpMsIQOkU+OoJT8TvWR3
	 0eg9fueXjNofX5kJgaS4xopnaUnvb/zEmph9RZqUv6rxEMqRTQqr0iz2g3dZHnu0cfl55
	 tp+KoW+7fZGeH0SxmGFitkRvoNEecIBfV60q1ZthbIf8E1umFzvChhRv2z4Qdp6CnZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=edO4FVds;
	arc=none smtp.remote-ip=209.85.210.199
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B71606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 00:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71B71606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=edO4FVds
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-89e05d31e54so164562b3a.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 16:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793753266; x=1794358066; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ma0BJNPiyw5G435eYcqXLhH2XcRvaZWBudt7erlHK0w=;
        b=edO4FVdsKE+3sVvI0/R/flGkQfInhnICkLqzSL1RMpjIThGh+vA/Ub3j/KpnzLs20h
         uROAcj8j0vxd/MQQJVUdsIVzDn7C6Rx9yAtAtqtN7qo3PRlj9kXTvyNUMfsDmrFggbW6
         iyQH7kaueU7Vzf2DA+90gQoqYvDT/Xm+VASoc+04Mw9dBn38rg7t2bZibBrbDThrAgJZ
         tkyRsgV9naVd01RBfk8VUWa3J6hkiJCsbSa0aTyuv7H9UIDhwxgTv9c8fIITjItF7Vqt
         KmyTSbv4V2NkOEDNgCd6QGVPqKBk1wLeNfsRVtxlAzpHRt28OR7oB0skqgpAAGZx2D0j
         IjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793753266; x=1794358066;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ma0BJNPiyw5G435eYcqXLhH2XcRvaZWBudt7erlHK0w=;
        b=KXsBIFqUWMN+Il1zvfaKsepsMawWHtXay4oCJ1lLF08AydOQ+OR44Bs+dPldnNQs7U
         Jhp+zz5jXJiFCgysMypxr9zLdKU70leq7U6kK/xhlfyUF71i9TwTnJZqhzNnZO3reAcL
         53KBs3jGvmhESDI5a6uwjIxe/erEeSG/6nq1NbYzXxjf/6UftSFnTCTtVKiyFrakjVTX
         o59+sgtfUefE1WVDWeTGHjmZQwjNS7objAoi7JcmiclHKDGbwf4pkuTq+DzVG9J9I0Yy
         I1QXtU/pRbFFySnDXIjMgmMZ8GsvXIDTqUDTVW+WaR5G/gXzvTK0A4JT4U8P/qFfMmwd
         NnLQ==
X-Forwarded-Encrypted: i=1; AKwUvBwaCK3Dmz3qn/hd5l+uW4IDsR4eGPGNXepEivw32/PeCVEzPrSYVbT+4kIdXox5YKUL1v7GZOQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/8aKs0OJlZvQicks6jI5/D27txcz5G+2KuSuq5jQefpEQVXnpl
	etFsW7rXXUn5nl0PsfjO6o75SNCoEaR3hI7DidOqaJ63Kt+x7f5P4r4X9g8KQyYUuPS4UH9k8Zl
	dhosGJw==
X-Received: from pgbdw7.prod.google.com ([2002:a05:6a02:4487:b0:cd6:261d:5bde])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3945:b0:3e2:9b5:b167
 with SMTP id adf61e73a8af0-3e928a51dc8mr11965695637.58.1793753265612; Tue, 03
 Nov 2026 16:47:45 -0800 (PST)
Date: Tue, 3 Nov 2026 16:47:44 -0800
In-Reply-To: <CABgObfbvv-fQnC35EU+TxEtNMyYA0wgJ-nA_2B1eqKrZ_2qqkQ@mail.gmail.com>
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
 <aunzE4yywHJOqsk4@google.com> <CABgObfbvv-fQnC35EU+TxEtNMyYA0wgJ-nA_2B1eqKrZ_2qqkQ@mail.gmail.com>
Message-ID: <auqAsEk9o6buPNiR@google.com>
Subject: Re: [PATCH 1/2] KVM: register asynchronous page fault waits with
 interrupts disabled
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>, 
	Hillf Danton <hdanton@sina.com>, Steven Rostedt <rostedt@goodmis.org>, Harry Yoo <harry@kernel.org>, 
	syzbot <syzbot+f11512d1e5878ba5e60e@syzkaller.appspotmail.com>, 
	stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Nov 03, 2026, Paolo Bonzini wrote:
> Il mar 3 nov 2026, 15:43 Sean Christopherson <seanjc@google.com> ha scritto:
> >
> > On Tue, Nov 03, 2026, Paolo Bonzini wrote:
> > > KVM cannot use a node on the stack like kvm_async_pf_task_wait_schedule() does
> >
> > Oh!  Yes, KVM can!  If we fully handle the PV async #PF in vcpu_enter_guest(),
> > then the node can be put on the stack, right?  Juggling preemption and guest
> > timing is heinous, but on the plus side it consolidates the PV async #PF code,
> > so I think it's a net positive?  Especially when factoring in the node stuff.
> >
> > Fully handle PV async #PFs (when running as a KVM guest) before enabling
> > IRQs so that it's impossible for the current task, i.e. the vCPU task, to
> > be preempted before invoking kvm_async_pf_task_wait_schedule().  This will
> > allow the guest-side async #PF code to eliminate its dummy allocation,
> > which is needed only to handle the case where the page ready notification
> > is delivered before handling the not-present #PF.
> >
> > Add dedicated handling for PV async #PFs instead of wrapping/piggybacking
> > kvm_x86_ops.handle_exit_irqoff(), as the act of handling an async #PF may
> > enable IRQs and schedule out the current task, i.e. needs to be done just
> > before KVM itself explicitly enables IRQs, and needs to enable preemption
> > before calling into the kernel's PV async #PF handler.
> >
> > Opportunistically wrap the code with CONFIG_KVM_GUEST to help document the
> > context, and drop the CONFIG_KVM_GUEST=n stubs.
> >
> > Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> More like Instigated-by. :)
> 
> The main advantage would be that it bypasses the missing lock issue
> that Sashiko reported, but I don't know... That;s surely nice, but at
> the same time it is not great having to add a new callback, 

Agreed, though IMO it's better than adding another vCPU field.  E.g. we could
just as easily add apf.host_cr2 instead of host_apf_node.

> duplicate the guest_time_exit/preempt_enable code into kvm_handle_pv_async_pf().

Yeah, I was all excited about the idea, and that excitement definitely fizzled
when I realized preemption needed to be enabled.

> Not that the extra field in vcpu->arch is beautiful, I admit that, but
> it seems extra unwarranted complexity.
> 
> Unless you insist I will send a v2 that takes the lock properly.

I don't insist, I agree the guest_time_exit() and preempt_enable() code is too
ugly.  And the part that I actually care about cleaning up is not having a bunch
of apf.host_apf_flags checks sprinkled all over, especially in the nested code.
Which definitely doesn't require fully handling async #PF with IRQs disabled, we
just need to handle them before calling into vendor code (I think).

E.g. something like this?  Though to land it on top of your patch to add
host_apf_node, we'd want to define pass a struct, but that should only make the
code prettier.

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 0378577d9d8b..09416d3588d0 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -959,7 +959,6 @@ struct kvm_vcpu_arch {
 		u64 msr_int_val; /* MSR_KVM_ASYNC_PF_INT */
 		u16 vec;
 		u32 id;
-		u32 host_apf_flags;
 		bool pageready_pending;
 	} apf;
 
@@ -1688,7 +1687,8 @@ struct kvm_x86_ops {
 			       struct x86_instruction_info *info,
 			       enum x86_intercept_stage stage,
 			       struct x86_exception *exception);
-	void (*handle_exit_irqoff)(struct kvm_vcpu *vcpu);
+	void (*handle_exit_irqoff)(struct kvm_vcpu *vcpu, u32 *async_pf_flags,
+				   unsigned long *async_pf_cr2);
 
 	void (*update_cpu_dirty_logging)(struct kvm_vcpu *vcpu, bool enable);
 
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
index 581bc3a23c95..5a92a22e8e6a 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3811,7 +3811,6 @@ static void svm_get_entry_info(struct kvm_vcpu *vcpu, u32 *intr_info,
 		*error_code = control->event_inj_err;
 	else
 		*error_code = 0;
-
 }
 
 static int svm_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
@@ -4758,11 +4757,6 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 			       vcpu_to_pmu(vcpu)->global_ctrl);
 	}
 
-	/* if exit due to PF check for async PF */
-	if (svm->vmcb->control.exit_code == SVM_EXIT_EXCP_BASE + PF_VECTOR)
-		vcpu->arch.apf.host_apf_flags =
-			kvm_read_and_reset_apf_flags();
-
 	kvm_clear_available_registers(vcpu, SVM_REGS_LAZY_LOAD_SET);
 
 	trace_kvm_exit(vcpu, KVM_ISA_SVM);
@@ -5088,9 +5082,15 @@ static int svm_check_intercept(struct kvm_vcpu *vcpu,
 	return ret;
 }
 
-static void svm_handle_exit_irqoff(struct kvm_vcpu *vcpu)
+static void svm_handle_exit_irqoff(struct kvm_vcpu *vcpu, u32 *async_pf_flags,
+				   unsigned long *async_pf_cr2)
 {
 	switch (to_svm(vcpu)->vmcb->control.exit_code) {
+	case SVM_EXIT_EXCP_BASE + PF_VECTOR:
+		*async_pf_flags = kvm_read_and_reset_apf_flags();
+		if (*async_pf_flags)
+			*async_pf_cr2 = to_svm(vcpu)->vmcb->control.exit_info_2;
+		break;
 	case SVM_EXIT_EXCP_BASE + MC_VECTOR:
 		svm_handle_mce(vcpu);
 		break;
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index d75170a6199e..05e1d600dbd8 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -912,17 +912,21 @@ static void handle_nm_fault_irqoff(struct kvm_vcpu *vcpu)
 		rdmsrq(MSR_IA32_XFD_ERR, vcpu->arch.guest_fpu.xfd_err);
 }
 
-static void handle_exception_irqoff(struct kvm_vcpu *vcpu, u32 intr_info)
+static void handle_exception_irqoff(struct kvm_vcpu *vcpu, u32 intr_info,
+				    u32 *async_pf_flags,
+				    unsigned long *async_pf_cr2)
 {
-	/* if exit due to PF check for async PF */
-	if (is_page_fault(intr_info))
-		vcpu->arch.apf.host_apf_flags = kvm_read_and_reset_apf_flags();
 	/* if exit due to NM, handle before interrupts are enabled */
-	else if (is_nm_fault(intr_info))
+	if (is_page_fault(intr_info)) {
+		*async_pf_flags = kvm_read_and_reset_apf_flags();
+		if (*async_pf_flags)
+			*async_pf_cr2 = vt_get_exit_qual(vcpu);
+	} else if (is_nm_fault(intr_info)) {
 		handle_nm_fault_irqoff(vcpu);
 	/* Handle machine checks before interrupts are enabled */
-	else if (is_machine_check(intr_info))
+	} else if (is_machine_check(intr_info)) {
 		kvm_machine_check();
+	}
 }
 
 static void handle_external_interrupt_irqoff(struct kvm_vcpu *vcpu,
@@ -941,7 +945,8 @@ static void handle_external_interrupt_irqoff(struct kvm_vcpu *vcpu,
 	vcpu->arch.at_instruction_boundary = true;
 }
 
-static void vt_handle_exit_irqoff(struct kvm_vcpu *vcpu)
+static void vt_handle_exit_irqoff(struct kvm_vcpu *vcpu, u32 *async_pf_flags,
+				  unsigned long *async_pf_cr2)
 {
 	if (to_vt(vcpu)->emulation_required)
 		return;
@@ -951,7 +956,8 @@ static void vt_handle_exit_irqoff(struct kvm_vcpu *vcpu)
 		handle_external_interrupt_irqoff(vcpu, vt_get_intr_info(vcpu));
 		break;
 	case EXIT_REASON_EXCEPTION_NMI:
-		handle_exception_irqoff(vcpu, vt_get_intr_info(vcpu));
+		handle_exception_irqoff(vcpu, vt_get_intr_info(vcpu),
+					async_pf_flags, async_pf_cr2);
 		break;
 	case EXIT_REASON_MCE_DURING_VMENTRY:
 		kvm_machine_check();
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
index b341af4c6057..15f54474382b 100644
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
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 26e7beaff8a0..57aff240cdb6 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8118,6 +8118,19 @@ static void kvm_update_cpu_dirty_logging(struct kvm_vcpu *vcpu)
 	kvm_x86_call(update_cpu_dirty_logging)(vcpu, enable);
 }
 
+static void kvm_handle_pv_async_pf(u32 flags, unsigned long cr2)
+{
+	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_KVM_GUEST)))
+		return;
+
+	if (WARN_ON_ONCE(!(flags & KVM_PV_REASON_PAGE_NOT_PRESENT)))
+		return;
+
+	local_irq_disable();
+	kvm_async_pf_task_wait_schedule(cr2);
+	local_irq_enable();
+}
+
 /*
  * Called within kvm->srcu read side.
  * Returns 1 to let vcpu_run() continue the guest execution loop without
@@ -8130,9 +8143,10 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	bool req_int_win =
 		dm_request_for_irq_injection(vcpu) &&
 		kvm_cpu_accept_dm_intr(vcpu);
+	unsigned long async_pf_cr2;
 	fastpath_t exit_fastpath;
 	u64 run_flags, debug_ctl;
-
+	u32 async_pf_flags = 0;
 	bool req_immediate_exit = false;
 
 	if (kvm_request_pending(vcpu)) {
@@ -8506,7 +8520,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	if (vcpu->arch.xfd_no_write_intercept)
 		fpu_sync_guest_vmexit_xfd_state();
 
-	kvm_x86_call(handle_exit_irqoff)(vcpu);
+	kvm_x86_call(handle_exit_irqoff)(vcpu, &async_pf_flags, &async_pf_cr2);
 
 	if (vcpu->arch.guest_fpu.xfd_err)
 		wrmsrq(MSR_IA32_XFD_ERR, 0);
@@ -8568,6 +8582,11 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	if (vcpu->arch.apic_attention)
 		kvm_lapic_sync_from_vapic(vcpu);
 
+	if (async_pf_flags && !WARN_ON_ONCE(exit_fastpath != EXIT_FASTPATH_NONE)) {
+		kvm_handle_pv_async_pf(async_pf_flags, async_pf_cr2);
+		exit_fastpath = EXIT_FASTPATH_EXIT_HANDLED;
+	}
+
 	r = kvm_x86_call(handle_exit)(vcpu, exit_fastpath);
 	return r;
