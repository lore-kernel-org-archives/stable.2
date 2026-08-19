Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7771B208D0
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 03:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787111295; cv=none; b=ooDF/7DWmjMa7V3pEE6YHQ70ccD9crEVLzTwozC/XT1Nbv1hn4xqbQs+i9BSkmK8WO4aRchJ+dlJ1oudcEi6ULDMTqNL8PR0Bgi54DR6r7hEDm/t1Gsw1IK3uX2xcjMwOQvrLCqqLTOFWw8dWuh2JSghTtQVRaTvnO7kTwmyVYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787111295; c=relaxed/simple;
	bh=s0cOOj4h5pNjkKOsuDdDUCJxMXDpbWuREEibCHORmFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UhvyjN7ptlD2/GXZL6Uy30S9G4KaPDtkvPq+EgfvAV/IjTD+ECrAybME4f+nmjjvOu9RrPhgU+JTjrQXT/f5+s4bTHt7z0MYUXmFef5WuTT1GNfP/5EKBxRTtrP6Bn9vo0nlwPPCpT7xfekw3XFuSpdjwOCswEzVLLdn7YNrpYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBIlDPif; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBIlDPif"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cc891373e0so6643935ad.2
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 20:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787111294; x=1787716094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PU1yvxIOqoyoxZTo0QwlPy97Mpv8yx+t7SpyCWg2sl4=;
        b=cBIlDPifm5Knd8FbP3Qoa/hb5/1c0FaNZuJQPG6/OpCRsBGpEe7a9DQ/RzfItsDZZx
         AC40bRuP2cKqdkUdN6xfZevyyJhHvgw1+NWLkdXYNmEVhOzpWIPHjREV/5HAYATGYDFG
         BiLMcAX6dBqzJ8BlBevnA6toUsdfaDlQsD3FfYsobFEUZzKvx5ySzNFYlj0J7QcuKfcH
         I/ZKNDhCruQ10oAVO+D8vtepCMnUr+FewEvPh1mvoUNDy+bv30OdxEdlJscyYuSLBhJ4
         OCZncGkWPxBEfwYo/wSaBqU6NRiZrLJ5jVc/lLgZVHxQOq1kIdcedArAoQYdDG3em9MZ
         ejMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787111294; x=1787716094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PU1yvxIOqoyoxZTo0QwlPy97Mpv8yx+t7SpyCWg2sl4=;
        b=pQrcgUQUw5slInddJPyZriHrZ5kaLmzlrix1rGHi3bhzpuaeSpOlMJoXlWpXug6yLc
         qseRWJHWAYst8Ur4b6N9miaKtb99RvVy1XeVjhasKD3SYO4ClwWU9SFbbh8ZsBg2gJg/
         u0FXlD1vPc8V9B50OLL1mH6edJ9FBNUt/o+hpevDBAHGkeydi7bOBHML3Qvo6WjZxXaf
         u1M1o83b4apEq7RqKs+QziZ4kF6VHaMrQXrbmv6+3BzV6B2Z5t4hriujn0tK8LzIItx9
         EreDToeYYUjMgiiEIbQGSkWlK6D3DNGu3BATtNa3HzPBxUN5zTDGULwcxRLhrPmEZ0NT
         DgvA==
X-Forwarded-Encrypted: i=1; AHgh+RqfjnTHu4dnGesZUOlVlKEiDAh5FBpHrkaO4MxMQBONnlA9QKseUZNaCBonR7sio1qfC0xJt60=@vger.kernel.org
X-Gm-Message-State: AOJu0YwupBrXaKnGxCO4cBp20YfqZXDNAQdoLKiRhOuOagSDq0PYIqWa
	YlpXOo9dlq6TEGOchmYBj6bP74V18raIAteBf55j82iVmTjCrUkkUHikL1ETHhSA
X-Gm-Gg: AR+sD12F3LDKDl3JvOr+zw3sHwoxiyEJXG1h+FsRHQRTfLgKE65PbZO6IFySHsz6SaH
	gDGtqrTeT+7K0rQu2BndHbRtVLQW9H9j5mA8XlQVajFyZ5y9JTx0BJQ+JWwAbd94bq+0zHhIJ9e
	hA8u7p0xkr0oQi9B/lK+WZ+skxh5GgmFFZfaqKY+VcOnGIZe1XIskuW3izxCVcy63CzGxyTkhP7
	e9EuAdcR+b1bQUVJdXhq7MHkGpaUEq5u1qE+/FmyWcwiGcwgPd5r99UZJ4NyTQssBS0XHAGZlAK
	3Dw6MWHj27Owy5qIbkhnPLmuZF8KGc6XR8bgezDbE9X54GAscpYTNabayy+seFPp1sEUspEh3An
	wbZ4RB6W9ArEK/R2psfzKNNscWT0uQs0yavWKrdcyiuJUAlmG0s5lwvYmh6lJ30rgp7BghRl3rZ
	/SQ8VbWFpEOslAg9VBf0pXnTadyqjEuRB8RY8rASaA8Cy8YvL2GHfUsihIiQJi/7xbx3hAtXIN8
	xJl7qNGy1tOVFXx8Kiq2A==
X-Received: by 2002:a05:6a21:7010:b0:3c4:2cf9:28ad with SMTP id adf61e73a8af0-3cd0193b2f8mr3599351637.12.1787111293574;
        Tue, 18 Aug 2026 20:48:13 -0700 (PDT)
Received: from localhost.localdomain ([103.167.26.54])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ad564bcsm2160318c88.5.2026.08.18.20.48.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Aug 2026 20:48:12 -0700 (PDT)
From: Keqiang Duan <duankeqiangcym@gmail.com>
To: kvm@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] KVM: VMX: Clear GUEST_ACTIVITY_STATE when userspace makes a vCPU RUNNABLE
Date: Wed, 19 Aug 2026 11:46:52 +0800
Message-Id: <20260819034652.98938-1-duankeqiangcym@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Force a vCPU out of its hardware-tracked halted state when userspace
explicitly declares the vCPU RUNNABLE via KVM_SET_MP_STATE, i.e. clear
VMCS.GUEST_ACTIVITY_STATE if it says the vCPU is halted.  Add an optional
kvm_x86_ops hook to do the clearing, as SVM has no equivalent VMCB field.

When HLT-exiting is disabled for a VM (KVM_CAP_X86_DISABLE_EXITS with
KVM_X86_DISABLE_EXITS_HLT, e.g. QEMU's "-overcommit cpu-pm=on"), a guest
HLT halts the physical CPU instead of exiting to KVM, and hardware saves
GUEST_ACTIVITY_STATE=HLT into the VMCS on the next VM-Exit.  That field is
sticky: it survives VM-Exit/VM-Enter and is only cleared by vmx_clear_hlt()
on event injection, or by vmx_vcpu_reset() on INIT / vCPU creation.

Nothing clears it on a userspace-driven state change.  KVM_SET_REGS only
writes the software register cache and KVM_SET_MP_STATE only writes
vcpu->arch.mp_state; kvm_vcpu_running() likewise consults software state
only.  A VMM that emulates a machine reset therefore ends up with a vCPU
that KVM happily VM-Enters while hardware refuses to fetch instructions.

Reproduce with a Linux guest by triggering a panic/kdump on a non-boot
vCPU: nmi_shootdown_cpus() parks the other vCPUs -- including vCPU0 -- in
crash_nmi_callback(), which does local_irq_disable() followed by a bare
HLT.  The capture kernel then resets the machine via port 0xCF9.  QEMU
rewrites RIP to 0xfff0 and sets mp_state to RUNNABLE, but vCPU0's
GUEST_ACTIVITY_STATE is still HLT, so the BSP never executes the reset
vector, never sends SIPIs, and the entire VM hangs at "reboot: machine
restart" forever.  Only destroying and recreating the VM recovers it.

Clearing the state is always safe: waking from HLT is architecturally
permitted to be spurious, and every HLT in the kernel is inside a loop.
Hook KVM_SET_MP_STATE rather than the VM-Enter path so that the clearing
is driven by an explicit userspace declaration, and so that no work is
added to vmx_vcpu_run().

Note, vmx_clear_hlt() loses its "static" qualifier as the kvm_x86_ops table
now lives in vmx/main.c.  TDX cannot disable HLT-exiting and KVM cannot
access a TD's VMCS, so vt_clear_hlt() short-circuits for TD vCPUs,
following the existing vt_*() wrapper pattern.

Fixes: caa057a2cad6 ("KVM: X86: Provide a capability to disable HLT intercepts")
Cc: stable@vger.kernel.org
Signed-off-by: Keqiang Duan <duankeqiangcym@gmail.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |  1 +
 arch/x86/include/asm/kvm_host.h    |  7 +++++++
 arch/x86/kvm/vmx/main.c            | 13 +++++++++++++
 arch/x86/kvm/vmx/vmx.c             |  2 +-
 arch/x86/kvm/vmx/x86_ops.h         |  1 +
 arch/x86/kvm/x86.c                 | 13 +++++++++++++
 6 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index e213c9ae3e30..dd9026c1071c 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -82,6 +82,7 @@ KVM_X86_OP(interrupt_allowed)
 KVM_X86_OP(nmi_allowed)
 KVM_X86_OP(get_nmi_mask)
 KVM_X86_OP(set_nmi_mask)
+KVM_X86_OP_OPTIONAL(clear_hlt)
 KVM_X86_OP(enable_nmi_window)
 KVM_X86_OP(enable_irq_window)
 KVM_X86_OP_OPTIONAL(update_cr8_intercept)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 283847619ff8..e5a0758536e1 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1607,6 +1607,13 @@ struct kvm_x86_ops {
 	int (*nmi_allowed)(struct kvm_vcpu *vcpu, bool for_injection);
 	bool (*get_nmi_mask)(struct kvm_vcpu *vcpu);
 	void (*set_nmi_mask)(struct kvm_vcpu *vcpu, bool masked);
+	/*
+	 * Force the vCPU out of any hardware-tracked halted/inactive state so
+	 * that it will fetch and execute instructions on the next VM-Enter.
+	 * Only needed by VMX, where VMCS.GUEST_ACTIVITY_STATE persists across
+	 * VM-Exit/VM-Enter; SVM has no equivalent VMCB field.
+	 */
+	void (*clear_hlt)(struct kvm_vcpu *vcpu);
 	/* Whether or not a virtual NMI is pending in hardware. */
 	bool (*is_vnmi_pending)(struct kvm_vcpu *vcpu);
 	/*
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index 0ff3230fd95e..74ce9dd70419 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -601,6 +601,18 @@ static void vt_set_nmi_mask(struct kvm_vcpu *vcpu, bool masked)
 	vmx_set_nmi_mask(vcpu, masked);
 }
 
+static void vt_clear_hlt(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * TDX doesn't support disabling HLT-exiting, and KVM can't access a
+	 * TD's VMCS, so there is never any hardware halted state to clear.
+	 */
+	if (is_td_vcpu(vcpu))
+		return;
+
+	vmx_clear_hlt(vcpu);
+}
+
 static void vt_enable_nmi_window(struct kvm_vcpu *vcpu)
 {
 	/* Refer to the comments in tdx_inject_nmi(). */
@@ -964,6 +976,7 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 	.nmi_allowed = vt_op(nmi_allowed),
 	.get_nmi_mask = vt_op(get_nmi_mask),
 	.set_nmi_mask = vt_op(set_nmi_mask),
+	.clear_hlt = vt_op(clear_hlt),
 	.enable_nmi_window = vt_op(enable_nmi_window),
 	.enable_irq_window = vt_op(enable_irq_window),
 	.update_cr8_intercept = vt_op(update_cr8_intercept),
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e3bfe6aca1a0..8ad79c60ecc6 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1909,7 +1909,7 @@ int vmx_skip_emulated_instruction(struct kvm_vcpu *vcpu)
 	return skip_emulated_instruction(vcpu);
 }
 
-static void vmx_clear_hlt(struct kvm_vcpu *vcpu)
+void vmx_clear_hlt(struct kvm_vcpu *vcpu)
 {
 	/*
 	 * Ensure that we clear the HLT state in the VMCS.  We don't need to
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index cdb38d940cfb..45e47f502a37 100644
--- a/arch/x86/kvm/vmx/x86_ops.h
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -95,6 +95,7 @@ int vmx_interrupt_allowed(struct kvm_vcpu *vcpu, bool for_injection);
 int vmx_nmi_allowed(struct kvm_vcpu *vcpu, bool for_injection);
 bool vmx_get_nmi_mask(struct kvm_vcpu *vcpu);
 void vmx_set_nmi_mask(struct kvm_vcpu *vcpu, bool masked);
+void vmx_clear_hlt(struct kvm_vcpu *vcpu);
 void vmx_enable_nmi_window(struct kvm_vcpu *vcpu);
 void vmx_enable_irq_window(struct kvm_vcpu *vcpu);
 void vmx_update_cr8_intercept(struct kvm_vcpu *vcpu, int tpr, int irr);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d94b59140c45..7777cf88a96b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9058,6 +9058,19 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 	}
 
 	kvm_set_mp_state(vcpu, mp_state->mp_state);
+
+	/*
+	 * Force the vCPU out of any hardware-tracked inactive state, e.g. VMX's
+	 * GUEST_ACTIVITY_STATE=HLT.  That state is sticky across VM-Exit and
+	 * VM-Enter and is not touched by any other ioctl, so a vCPU that halted
+	 * with HLT-exiting disabled (KVM_X86_DISABLE_EXITS_HLT) stays wedged
+	 * even after userspace declares it RUNNABLE and rewrites its registers,
+	 * e.g. when a VMM emulates a machine reset.  Waking from HLT is
+	 * architecturally allowed to be spurious, so clearing it is always safe.
+	 */
+	if (vcpu->arch.mp_state == KVM_MP_STATE_RUNNABLE)
+		kvm_x86_call(clear_hlt)(vcpu);
+
 	kvm_make_request(KVM_REQ_EVENT, vcpu);
 
 	ret = 0;

base-commit: 1b731e5ded480bd1e5546aed35584238661ce72e
-- 
2.24.3


