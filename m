Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D033CCFC2
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 08:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788941235; cv=none; b=mfUhoaunPXGEXdwJCHlEMvg+5BHYuRA/ap2VdEJpyBXrhOiHb828I7xEDkipolXvOW6YrXpcRxjKMJUrIXcGHRHEWM9zVxTAW5mFDwEIcuB2vbXyPgG2ooQnrJ4MB8LZUvu8DjjM5tB8Y/VVcrbuedQ/Dh/Ceoln0Pgjnd6o+B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788941235; c=relaxed/simple;
	bh=UgvFOqMPXUtDaNlIKpnhLmXfV6CYs0hS4/yy/6cRQ6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IoAgBgW0247vsv+MCJuGti+EwjNQrntoULOcXobGxXXdWcmMJ7544EUniu56F9/EBKzzCpaGpJKmj57gtSzHYOq8IriVSyweKSRdN7bnB/7W09QnRW4r4ud9pbUUoZa3aEVqrB2S862Ol2DwcyRrTiW0Vmn1/nO1fpZCgudrMxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clqrQKld; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clqrQKld"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb752so778876a91.0
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 01:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788941233; x=1789546033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uQ1z2i7aFu3x1pkbW0xHXxf+v4OCvUsJU6MHdFftEMo=;
        b=clqrQKldRMHmJZHmgVi33IF9LJcMPsmn1LdXCqpJLzwqlxWgtSeTPlcg4bVBnqgQRg
         BiMAa1C8uwL+hlNb2fMsAuQ39/lpdX1RAiXuX+ZseDH7CxoyFnJ9l4wEzklOt2Ib7vDg
         A6Lbzy1RO77PmfoAt4Fk7wF6xly+BZq8tc2wV+TQxzk6wh171yucEDOgkLzCO3qKG6pH
         C/g0uJuH3ZWSuqI7cQRHS4EydIwReIUjkP9qHXLJzc8Rg4xXImJSGVxpacmL5e6rr5V6
         eHIpGQG7HB22jx0OA88oJkd6CWqmaYnJ5uVspNL7rXrvSDiJhIMt3ujHfM9terFdUU8o
         quAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788941233; x=1789546033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uQ1z2i7aFu3x1pkbW0xHXxf+v4OCvUsJU6MHdFftEMo=;
        b=WmYkrrL5mrW0dqR8l54mHP7XcSxLoXI+09hodHI1QwtwePQJa3QcCnNx97epJUooZ+
         H5pjwCe4ZXB3E67AejX6RD/tRla4zEU4o9RUuRejqp0GnvF7hetn6WkomzUbpDBfS+h/
         6K0m6XP9vxVepXpCdoNpEIeoj1lPPDJru1xGuaMKjggz4JCDnFkOIwj0+jAxR/cWZpEK
         VyVAKZGnhAYE0NasBADn3NfIYhheA0NgWB68Kf1ssF6qyfqGCvUwnRm3znV8GyfbjMnY
         UShm3iyCXVNpAfTy/Y4tVSkSHs+wMjNd54QvRWxwmrKSVTlWKyJkouY7GLpn7qy7xBRP
         vxXw==
X-Gm-Message-State: AFuF++m6nV3OcMXAu+Hq/BtzpBukwXDHcRozzz4UWytUC48oWgtG/h7d
	wwWC7KzfRpS1jIK8dO9FwYBEZYmCtkneCB+ArdZsllIUjIp8SkZGcrrU
X-Gm-Gg: AYBFou28U2QqtBNo1CYTlu/np1ocKJYJNDKi16mgKMxiqADXOTk61G308oY3mtSTC80
	ybrF5f1f3nldipCt+grVKucO95aDf4Mxz4JGWc2oFE5WkBedMVL+MbRBvMIWlkSYbQlkK8z5ui3
	VHrx4XxhvstFeFBDRj+YUT5LAt0d/k2JNrpDAKAGLmPl6CACr2ohQs29CLU3cQegsak1WfV5IuT
	4zn4vvc3s2j3gXHehMq/3B0YuqRfukoZrDhBPzxkdR+nVDbfVdq2GC9KyRb++QnVBYsCBm/W26Z
	AWqRMkb3ZdvcuAy7fMmoqii5WHlhwdG6xvYyKvMsAak5MJM8u0+Y9EPPAIA+zIYGzWBB7jhBrrt
	fzSsmLh/kPUjMWpFQyLzMQAR+QJf3G2uAMwJ6PsMqmynCwuH7d2uSoKzTmgsZ9chFjJqAsKJxSu
	UWkvyt+AKAH81noaepy4y3j/wZFPnHEiTiYWoxWhjoVXNXlyAjrxH0VsjZglKbr/jCRX3bmqb0m
	CPqn8QIUDIuywI9rlTTJzec4tqPr8Kx
X-Received: by 2002:a17:90b:5705:b0:398:9be8:ea66 with SMTP id 98e67ed59e1d1-39bac3f1dc2mr6449349a91.19.1788941233102;
        Wed, 09 Sep 2026 01:07:13 -0700 (PDT)
Received: from localhost.localdomain ([103.167.26.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b26155324sm30016503a91.17.2026.09.09.01.07.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Sep 2026 01:07:12 -0700 (PDT)
From: Keqiang Duan <duankeqiangcym@gmail.com>
To: duankeqiangcym@gmail.com
Cc: stable@vger.kernel.org,
	Qinguang Chen <chenqinguang@kuaishou.com>,
	Zhiping Du <duzhiping@kuaishou.com>
Subject: [PATCH v2] KVM: x86: Clear hardware HLT state when userspace makes a vCPU not-halted
Date: Wed,  9 Sep 2026 16:07:05 +0800
Message-Id: <20260909080705.61942-1-duankeqiangcym@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Force a vCPU out of its hardware-tracked halted state when userspace puts
the vCPU into any state other than HALTED via KVM_SET_MP_STATE, i.e. clear
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

Key off "not HALTED" rather than "is RUNNABLE" as HALTED is the only target
state for which retaining the hardware halted state is meaningful; every
other transition either can't be reached on VMX, e.g. AP_RESET_HOLD, or
goes through vmx_vcpu_reset(), which stuffs GUEST_ACTIVITY_ACTIVE anyways.
This also captures the intent more directly: KVM only ever drops the
hardware halted state, it never installs it.

Clearing the state is always safe: waking from HLT is architecturally
permitted to be spurious, and every HLT in the kernel is inside a loop.
Hook KVM_SET_MP_STATE rather than the VM-Enter path so that the clearing
is driven by an explicit userspace declaration, and so that no work is
added to vmx_vcpu_run().  Gate the call on kvm_hlt_in_guest() even though
vmx_clear_hlt() checks it as well, as the check is cheap and makes it
obvious in common code when the hardware state can exist at all.

Note, vmx_clear_hlt() loses its "static" qualifier as the kvm_x86_ops table
now lives in vmx/main.c.  TDX cannot disable HLT-exiting and KVM cannot
access a TD's VMCS, so vt_clear_hlt() short-circuits for TD vCPUs,
following the existing vt_*() wrapper pattern.

Fixes: caa057a2cad6 ("KVM: X86: Provide a capability to disable HLT intercepts")
Cc: stable@vger.kernel.org
Tested-by: Qinguang Chen <chenqinguang@kuaishou.com>
Signed-off-by: Zhiping Du <duzhiping@kuaishou.com>
Signed-off-by: Keqiang Duan <duankeqiangcym@gmail.com>
---
v2:
 - Gate the call into vendor code on kvm_hlt_in_guest(). (Sean)
 - Key off "mp_state->mp_state != KVM_MP_STATE_HALTED" instead of
   "vcpu->arch.mp_state == KVM_MP_STATE_RUNNABLE". (Sean)
 - Retitle from "KVM: VMX:" to "KVM: x86:" as the change also touches
   common x86 code.
 - Collect Tested-by and Signed-off-by tags.

v1: https://lore.kernel.org/kvm/20260819034652.98938-1-duankeqiangcym@gmail.com/

 arch/x86/include/asm/kvm-x86-ops.h |  1 +
 arch/x86/include/asm/kvm_host.h    |  7 +++++++
 arch/x86/kvm/vmx/main.c            | 13 +++++++++++++
 arch/x86/kvm/vmx/vmx.c             |  2 +-
 arch/x86/kvm/vmx/x86_ops.h         |  1 +
 arch/x86/kvm/x86.c                 | 15 +++++++++++++++
 6 files changed, 38 insertions(+), 1 deletion(-)

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
index d94b59140c45..3b224c3bbe42 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9058,6 +9058,21 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 	}
 
 	kvm_set_mp_state(vcpu, mp_state->mp_state);
+
+	/*
+	 * Force the vCPU out of any hardware-tracked halted state, e.g. VMX's
+	 * GUEST_ACTIVITY_STATE=HLT, when userspace puts the vCPU into a state
+	 * other than HALTED.  The hardware state is sticky across VM-Exit and
+	 * VM-Enter and is not touched by any other ioctl, so a vCPU that halted
+	 * with HLT-exiting disabled stays wedged even after userspace rewrites
+	 * its registers, e.g. when a VMM emulates a machine reset.  Waking from
+	 * HLT is architecturally allowed to be spurious, so clearing it is
+	 * always safe.
+	 */
+	if (kvm_hlt_in_guest(vcpu->kvm) &&
+	    mp_state->mp_state != KVM_MP_STATE_HALTED)
+		kvm_x86_call(clear_hlt)(vcpu);
+
 	kvm_make_request(KVM_REQ_EVENT, vcpu);
 
 	ret = 0;

base-commit: 1b731e5ded480bd1e5546aed35584238661ce72e
-- 
2.24.3


