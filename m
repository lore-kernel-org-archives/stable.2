Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE433C2B8F
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 20:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781901124; cv=none; b=CTRkQF4u9Z1XsGqn6paJaIq8Diw5NQGECUAVDxDrDapG6GlBB8LYp495pt1nncAF4PvJnqW/9AamJ6uq311q5xnL1F8rvAYf2ZHh/3H7wWIAOjkw+buYoc2eydyA6EEzrtZUZNiVud+qgTZP1pbSZfy9Bir9+5FDzxmATa4HgrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781901124; c=relaxed/simple;
	bh=KEHvri2C+4rwq4Wz41q+2TtCvRVzvXyvnlqX/inZMjo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N2E1xXPR0KvKiJ/kBlKTEXc399ZjOQKEUgorSIH5kuG+A1WTMSVLZVAQtzdUjzecuPGp+2Tb35hZyeyFItUPnamJbSKiLzleQSJc/0B1lIiNilOYTzEILnnQ+5XGzhfiwWeQacr9dP+Ohcjp0OmjoYYlu8PQclgXkBquWiBTAF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dM+3r2rK; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dM+3r2rK"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7e1916922b9so29057437b3.1
        for <stable@vger.kernel.org>; Fri, 19 Jun 2026 13:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781901119; x=1782505919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vyiYsQofQELQbzMq1inRUoCbXJl9QmJD7EW7nh7MVlI=;
        b=dM+3r2rKuRCj0AnZ9/5CQhVuFolFYblR7SpHBPcUtb13HrEvFqStkAfm5RFq9bNSWo
         w2hoNu6kx5hcLSLqyKaFUb8WSKB7WuBH211yA9YoTqvlZ9m6Sak+Jb/dyJH3Kw24RL+v
         EgndwFVFsQpKkdXNbOrU27zx9ATF2QhRmV1aVzYDBlJvbfpZu/XobsP2YffdYivwJfc4
         N63tHNbzhkjz4OT7z0tDEOkleCd35ZOV0/9mlKWL5Q9wfcOcUbuantLJrM0tRCjM4wPl
         QHPErmRW3XDOgdeAxm2hRAfELi/r4uVsx4ycPJLhTUUJivTQZS1jiqMdtuk3eXRSydbj
         1vHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781901119; x=1782505919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vyiYsQofQELQbzMq1inRUoCbXJl9QmJD7EW7nh7MVlI=;
        b=PmB6pagGYwlJOXG0/qHBl2EY1SOueDS+r/2GXuBSKp499C6D28MtV6gNgZZ4ydT53n
         34OX100EG672Zzn7Z3nPLXNhM/MFRE23TvwgYn9KnheF7C1BsFylI+sY3J5bmpZG09ZU
         UFeLZGR10+2KrrTb4xeydLzUYwbYxsCF3X0yLjMXVwmVSdpbeiYuNssfainjuGkVkZJl
         L4A8qjnzuCWp1rwxnus4BRiB1rCu9TFDBnYh01CJDAg+IJn8GPszbbCKs916AzXprprZ
         N65xwdOcSIvTN7m6bb2BnVf7HD5adhAYul0Ff80uvKFugBuOPYbMs06uxQJA+UxUqIU+
         9KFQ==
X-Gm-Message-State: AOJu0YxVR97ps4ARFV0Izw+vakJGpFOShFsJJ7AjKCzcZ9RHs5uGmFZM
	MBUbkIY40Ml0HtL6CgXla9rkqhYBlBbai+2Qc0gLypjlqNPB6ncJO6gH2srem6dzJ2I=
X-Gm-Gg: AfdE7cmd2p79Uffp0Ldm5Cw3zso9nkR8lz1/1G3guiEx0Lyp1oOE2tQsDQlr7LRWOpL
	VVbVtTsR7TZ00mvhyli+I3ErtgGwOe0N2qZDLs5UsDZ0lsUCbZVxyrR4rx5VE4oM96qZBdTdSY2
	FBwyipzhsvSqIucdGQ+IfDKYbrS5m5RMcGg6A0FhsxC6aoa0ncG8Yw7k+rE1KQl33rUSd8aI7YT
	n2XYlTJt+qgmSN7CYA8Ln35k6uDeEVvrWHuK7i8Tx8v/zHi8YblRam9GJTZfOQUL7VzHIiy9z5A
	1wgLJtGNuFq+abN8TsE8WNu1vj73d8LIKku/qSaWz7v/u3CX/vmG+WQgTx5KSDV4pCsW2CBPqiT
	2pcvvFLY6q7p+douF19dfTPlrq3j2iOTMIFzLnGbomv+yhjL/sbv0zo/+HlCHpKfWi7RZQXtGlB
	79/wZ/Z4jC+BCmQtM=
X-Received: by 2002:a05:690c:6c8e:b0:7fe:1333:c745 with SMTP id 00721157ae682-80134c78770mr57757507b3.27.1781901119103;
        Fri, 19 Jun 2026 13:31:59 -0700 (PDT)
Received: from TurinLinux.. ([37.19.212.13])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f015805sm11106986d6.1.2026.06.19.13.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 13:31:58 -0700 (PDT)
From: Nicholas Dudar <main.kalliope@gmail.com>
To: stable@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	gregkh@linuxfoundation.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	0wn@theori.io,
	mlevitsk@redhat.com,
	jmattson@google.com,
	Nicholas Dudar <main.kalliope@gmail.com>
Subject: [PATCH v2 6.1.y 3/3] KVM: nVMX: Fold requested virtual interrupt check into has_nested_events()
Date: Fri, 19 Jun 2026 16:31:07 -0400
Message-Id: <20260619203107.2752678-4-main.kalliope@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619203107.2752678-1-main.kalliope@gmail.com>
References: <20260619203107.2752678-1-main.kalliope@gmail.com>
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

