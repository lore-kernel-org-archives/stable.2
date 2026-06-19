Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C62632D42B
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 20:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781900580; cv=none; b=cMXig3qbv2amjCwhqk+RYX+HzesyT/78l7ahtSEbxCH/yBs64ABsxo2Rsl4JzGo1T7lJ5RP/kPdvCWdhWoU1Isip7V9ErZRqR+75PSJonxm6SqeKARLet8coursKhADRRO3BKFAqH3IdK/RSgYsP+FZithfnGWH0EuaYHRPv/2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781900580; c=relaxed/simple;
	bh=KEHvri2C+4rwq4Wz41q+2TtCvRVzvXyvnlqX/inZMjo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cGILCwHhQ+NGluoeXGyEib0KXE1Re8vEzAF97UDJcnad7d/3NduZCS104pGt6+ekZfTm08zdLggGXJJeBdr9MzQD/O6zYt0RJvgHkG9mY3qCtl3o514CvisizG+9A5BLLXL1iBE1u3B61mXV+44uqfmHzDaXg+X0tMSE5ftUpFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdIuRNGk; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdIuRNGk"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51a019e9ea9so4694511cf.2
        for <stable@vger.kernel.org>; Fri, 19 Jun 2026 13:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781900578; x=1782505378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vyiYsQofQELQbzMq1inRUoCbXJl9QmJD7EW7nh7MVlI=;
        b=PdIuRNGkcQCaSFwNvB/JW56XrqfArYQ7dOw3LyJmakiEDScwSf7OFKvKQSCLHhZAGC
         WF5JEWeY2jZop7gFk8+K1pbLpVFg27/dHhnQBw7XmM3ip5g40cBpzOa6hVOGfUsRvnH2
         TxXfUnu9QEknsiyYGlXm2IFsrkpA6KQeM3DvylRPuTSUP7EfGsk3GY+BMivTqppVb6ET
         nDQmDJ6/jt8YRg+eaKhyEKqV05HsiiSRmzVbC95udotZiKQlAJVQ0Q1ppdROTMo1uYKb
         2mBTS9Wg4pwMHQaWj6veLDcfEyqAAwrfN/+4c/RQDkBQymQ+JgzIctb0TFh4lNzHYr2m
         Nktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781900578; x=1782505378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vyiYsQofQELQbzMq1inRUoCbXJl9QmJD7EW7nh7MVlI=;
        b=B+3sAGiSoBEKN5m8yAlJUp6+leoAI+zH5x1TblrrIemf+FnISe5MLtn9O6cxSIKMat
         ErL0dOZIHFSkMIqguC7R0ggEJlBE146/bdcKK8nxUQIJPze1cdYAYaDmCjOZZjdjSgfN
         Q1kqQtThOpmaK0aqRHEGBo4T08lP3LPb6f652ANW0YEkKxkP9bSe47Cs+qsSogAyho6k
         SOinxiCbns65uwlmAilkiQ0rKUG6lcOCaE5EHQzjtX37I++L/1pFBabHSiCPe0KcW9gQ
         OjfbhSmveUjfYMAqRFRW0/1G5gTKRPU2A+6X4SnzFS5Exumr4dMc4QBvcmHCZHxoavbD
         JNGQ==
X-Gm-Message-State: AOJu0YyJSgyCmd40yS3mF2gNgF6QAnuUKRWTnZT4TrBzqM4HcWWYLWaP
	aojhBN4i6Ox88m6K+hF6spw2QbbuhZwbQuZZIDk45MgQXuTDuj3C8YTD
X-Gm-Gg: AfdE7clSNdMak0y/+5I7AXrQeVLu5QNHAPrUcSi+tCSjnJAW9RIm0UKYXOjzMV7+AOw
	en2CLzeaYBdql/u+Fth/HhOjWUN5qy7LRjvUPpkcS89fiIQYj9SfFGxGUdSResRtXtXYNF6BYcQ
	sDnug8r1IwlHrEdC5pHuGGAZkT/BevFnKsvn5tTJCNh+NbkbcuNXlYKmIliYH5hPIqymGtgv2fR
	Jtz1OQEWvD/bZ6NYq30MJCCukTEaCF6Kt/ggdjTHzaWsFR+vkTX6LnARXhm9g5fKeXthKZC99Qn
	C94PiH50lK/NE5ei8c+Bhl8KLknkUdnxFU+UwyJmDi4peAUnr4eOWAos86T76/avWYp/rXd6WEI
	glQBh8RaG6hgXXbougLFe0Vfvd5Q09oH1hvAVBgaMGOWxlaqKO/R5AKv81JiIWrWbVRbeOuiK5N
	+JiiQKf+wvVGR4DxY=
X-Received: by 2002:a05:622a:4d88:b0:51a:56d:1bec with SMTP id d75a77b69052e-51a06937de4mr19411811cf.32.1781900578158;
        Fri, 19 Jun 2026 13:22:58 -0700 (PDT)
Received: from TurinLinux.. ([37.19.212.13])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a0984da98sm3921561cf.15.2026.06.19.13.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 13:22:57 -0700 (PDT)
From: Nicholas Dudar <main.kalliope@gmail.com>
To: main.kalliope@gmail.com
Cc: stable@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6.1.y 3/3] KVM: nVMX: Fold requested virtual interrupt check into has_nested_events()
Date: Fri, 19 Jun 2026 16:22:25 -0400
Message-Id: <20260619202225.2749389-4-main.kalliope@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619202225.2749389-1-main.kalliope@gmail.com>
References: <20260619202225.2749389-1-main.kalliope@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

commit 321ef62b0c5f6f57bb8500a2ca5986052675abbf upstream.

Check for a Requested Virtual Interrupt, i.e. a virtual interrupt that is
pending delivery, in vmx_has_nested_events() and drop the one-off
kvm_x86_ops.guest_apic_has_interrupt() hook.

In addition to dropping a superfluous hook, this fixes a bug where KVM
would incorrectly treat virtual interrupts _for L2_ as always enabled due
to kvm_arch_interrupt_allowed(), by way of vmx_interrupt_blocked(),
treating IRQs as enabled if L2 is active and vmcs12 is configured to exit
on IRQs, i.e. KVM would treat a virtual interrupt for L2 as a valid wake
event based on L1's IRQ blocking status.

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240607172609.3205077-6-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
[ Nicholas Dudar: backport to 6.1.y. 6.1.y predates the vmx main.c /
  x86_ops.h split, so drop .guest_apic_has_interrupt from vmx_x86_ops in
  vmx.c rather than vt_x86_ops in main.c. The function is static in vmx.c, so
  upstream's x86_ops.h prototype removal does not apply. 6.1.y keeps the
  current hwapic_isr_update signature. ]
Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |  1 -
 arch/x86/include/asm/kvm_host.h    |  1 -
 arch/x86/kvm/vmx/nested.c          |  4 ++++
 arch/x86/kvm/vmx/vmx.c             | 21 ---------------------
 arch/x86/kvm/x86.c                 | 10 +---------
 5 files changed, 5 insertions(+), 32 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index c068565fe..1cfe83263 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -81,7 +81,6 @@ KVM_X86_OP(check_apicv_inhibit_reasons)
 KVM_X86_OP(refresh_apicv_exec_ctrl)
 KVM_X86_OP_OPTIONAL(hwapic_irr_update)
 KVM_X86_OP_OPTIONAL(hwapic_isr_update)
-KVM_X86_OP_OPTIONAL_RET0(guest_apic_has_interrupt)
 KVM_X86_OP_OPTIONAL(load_eoi_exitmap)
 KVM_X86_OP_OPTIONAL(set_virtual_apic_mode)
 KVM_X86_OP_OPTIONAL(set_apic_access_page_addr)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index fe5c0f86a..31395c434 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1549,7 +1549,6 @@ struct kvm_x86_ops {
 	void (*refresh_apicv_exec_ctrl)(struct kvm_vcpu *vcpu);
 	void (*hwapic_irr_update)(struct kvm_vcpu *vcpu, int max_irr);
 	void (*hwapic_isr_update)(struct kvm_vcpu *vcpu, int isr);
-	bool (*guest_apic_has_interrupt)(struct kvm_vcpu *vcpu);
 	void (*load_eoi_exitmap)(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap);
 	void (*set_virtual_apic_mode)(struct kvm_vcpu *vcpu);
 	void (*set_apic_access_page_addr)(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index ad07e83d2..f7a790a28 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3979,6 +3979,10 @@ static bool vmx_has_nested_events(struct kvm_vcpu *vcpu, bool for_injection)
 
 	vppr = *((u32 *)(vapic + APIC_PROCPRI));
 
+	max_irr = vmx_get_rvi();
+	if ((max_irr & 0xf0) > (vppr & 0xf0))
+		return true;
+
 	if (vmx->nested.pi_pending && vmx->nested.pi_desc &&
 	    pi_test_on(vmx->nested.pi_desc)) {
 		max_irr = pi_find_highest_vector(vmx->nested.pi_desc);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e5d162e97..2e6454e4c 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4063,26 +4063,6 @@ void pt_update_intercept_for_msr(struct kvm_vcpu *vcpu)
 	}
 }
 
-static bool vmx_guest_apic_has_interrupt(struct kvm_vcpu *vcpu)
-{
-	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	void *vapic_page;
-	u32 vppr;
-	int rvi;
-
-	if (WARN_ON_ONCE(!is_guest_mode(vcpu)) ||
-		!nested_cpu_has_vid(get_vmcs12(vcpu)) ||
-		WARN_ON_ONCE(!vmx->nested.virtual_apic_map.gfn))
-		return false;
-
-	rvi = vmx_get_rvi();
-
-	vapic_page = vmx->nested.virtual_apic_map.hva;
-	vppr = *((u32 *)(vapic_page + APIC_PROCPRI));
-
-	return ((rvi & 0xf0) > (vppr & 0xf0));
-}
-
 static void vmx_msr_filter_changed(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -8266,7 +8246,6 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
 	.check_apicv_inhibit_reasons = vmx_check_apicv_inhibit_reasons,
 	.hwapic_irr_update = vmx_hwapic_irr_update,
 	.hwapic_isr_update = vmx_hwapic_isr_update,
-	.guest_apic_has_interrupt = vmx_guest_apic_has_interrupt,
 	.sync_pir_to_irr = vmx_sync_pir_to_irr,
 	.deliver_interrupt = vmx_deliver_interrupt,
 	.dy_apicv_has_pending_interrupt = pi_has_pending_interrupt,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 10ef8a435..208a713d7 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13046,12 +13046,6 @@ void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
 	kvm_page_track_flush_slot(kvm, slot);
 }
 
-static inline bool kvm_guest_apic_has_interrupt(struct kvm_vcpu *vcpu)
-{
-	return (is_guest_mode(vcpu) &&
-		static_call(kvm_x86_guest_apic_has_interrupt)(vcpu));
-}
-
 static inline bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu)
 {
 	if (!list_empty_careful(&vcpu->async_pf.done))
@@ -13077,9 +13071,7 @@ static inline bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu)
 	     static_call(kvm_x86_smi_allowed)(vcpu, false)))
 		return true;
 
-	if (kvm_arch_interrupt_allowed(vcpu) &&
-	    (kvm_cpu_has_interrupt(vcpu) ||
-	    kvm_guest_apic_has_interrupt(vcpu)))
+	if (kvm_arch_interrupt_allowed(vcpu) && kvm_cpu_has_interrupt(vcpu))
 		return true;
 
 	if (kvm_hv_has_stimer_pending(vcpu))
-- 
2.34.1

