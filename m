Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E30C442B37
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 12:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787229324; cv=none; b=tYln+mEAnm6uF0o8SRyp2aRs8jQJYCJEoL80OR+lusvqjnT+aF4R1mLivdjxRjyEtY1a1xMoA2S12Qigb5TE3ruzX8OUVVme3GnhL8Us60rfohYRvsse7PtJmOyxVGtIOq7ls82kQjS0frt5h7RtlA6rhnywg0tP9vez7V3cJp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787229324; c=relaxed/simple;
	bh=UgvFOqMPXUtDaNlIKpnhLmXfV6CYs0hS4/yy/6cRQ6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hUq4oWbRF6GcXwV+O9H6W9fSXj++fpjWtE+pJAOAZ2Dzki61gEE1vyI2uyEs69X3cf0XR/5HC5lA35WNcq9HKW3TNI+ZgFjNFcir30BtdwZHxtiQWG4Ox0hDbuqC9CB4ipnj2urmG/gbBQacjzAAjsry3jsQm2LxyUW5Tkgjitk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2lDL+/O; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2lDL+/O"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cbb8b54fcf8so1750173a12.0
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 05:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787229321; x=1787834121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uQ1z2i7aFu3x1pkbW0xHXxf+v4OCvUsJU6MHdFftEMo=;
        b=I2lDL+/OqqRYJYVjYFlYkNx/agw0+o02O8GIZJdtH/Zk1YBya+m5oUI+kY6k0ty5r7
         2yijfCQVceUVLc9FcFssJ89GjD5xHzkS74j8uPY2ySKUuJZQY93Gl1d2Dm4L4fv5S/N5
         wG7RuSUUKrKzqJ3KEACPqT2YnuzQ2RaFyo4JvZIF2/WoaFCWHXmtrUlC0G7gop7lSJPU
         yXRN3LGOhkP3ax/aOZeV9Ip7Ew1pKJYPJF05Rc+aK6dtvk7lcQUnHbnfZOeEgVlCPzmA
         H1fmEUp0MV1hyyghlT6k6iPx9aRUhW6x0oWoV6xQQ7XQ0+OanuMakQQLRAqvir0S4PgV
         H6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787229321; x=1787834121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uQ1z2i7aFu3x1pkbW0xHXxf+v4OCvUsJU6MHdFftEMo=;
        b=POvo2zeMrC1AguLmZixdFPBpaAjGtrs6QmimeYxRjUgdhBxWmphSmVCpdrMvbv5yBz
         Knlrf9irsnlzS2haXckcFc+332jrYXCaTe1zBaMWu4gLvd3JFRt1hUnnwCPu7Uvhzf+C
         vpeaPK0169sKjIYqca7O9ijRD652Z9Zk9TCkSG61PavWEBP8Ac+BzzXYrZ/Z1vPXID0E
         YV+F+vBaYz4/F8pOzW0UATBeYHo1bvpEHf07XlqAi0RUXvRbqi2yvNU0VJunkukCnAd2
         GnqeWpm2/D1lxc4KcZUilDTupIpWp1+eUmOpin4Bf8cUlDvwlRsruxZZE/WpU/4vt+N3
         0/Gg==
X-Forwarded-Encrypted: i=1; AHgh+RobmOzuIBAv17ZX4/89Dj95OUYGRa9de68D0sHPMV611dDzIw+42D1pWwtlAJ+rsRBBgWuhUGA=@vger.kernel.org
X-Gm-Message-State: AFuF++nfEtnK1JgAsxfWrDysMU9tOoMn9mfl4T1dfkQsCCkhhg5ySg8m
	Ccjez3aAFkNQ4qfwbT+O0JPTTm5eOla7naR/28YJQsFiQotQ3a9MwewT
X-Gm-Gg: AR+sD12f80vfZnTYJ0tKNJsaln9U/Wv7TKft1tUdVB2RTk3WaO3EfjeT/Rbf192Vrc2
	uEZ/dGlXE0r9ps1NCqWEbpanD0oonEHusQnGrkxqlaHNhi1FsAmEFLjrKhLBgsraa1ecQq4Q/70
	XMJ7eVuKE8KzuPPvIwrIFO2qwb8OKwUfoeey6KZ9uGImoPOcC3sukRORS1qE+bUkaPYsE5B2Kp2
	dZPLhbG1J+tTQhH56AgF89Hv1gdUhWF9w4t+CY3nEO8Nhd3CttVVnH5oUDk7Y7gF4x2Om+yhMIJ
	GivibLvX/FxnW1ST/RR0WPr6SiAWNXvjojG/FuDa6jtO1XqZiudVWP5Sgd1PWnD5H9WcYM+JK/V
	0hGQmCnnOsVSouI+wRHe1Xhu4dS779qwHWmCLjZ25ZW7szSPC6Wp6KY1zm7Kx/zumKxZBOS8QG2
	wnkVSsoKyRh+J8GpTi9eddSvhsTMwx07UcHQs7FW/ygWRz6fG0BmPBdVNoGvEKUxmWbhGUUb5p0
	fjaqPRzER6xURLwZ2CeAQ==
X-Received: by 2002:a17:90b:5250:b0:38e:9eb2:9d43 with SMTP id 98e67ed59e1d1-395810f885amr24651907a91.16.1787229321327;
        Thu, 20 Aug 2026 05:35:21 -0700 (PDT)
Received: from localhost.localdomain ([103.167.26.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957faf6849sm6363161a91.10.2026.08.20.05.35.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 20 Aug 2026 05:35:20 -0700 (PDT)
From: Keqiang Duan <duankeqiangcym@gmail.com>
To: seanjc@google.com
Cc: pbonzini@redhat.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Qinguang Chen <chenqinguang@kuaishou.com>,
	Zhiping Du <duzhiping@kuaishou.com>
Subject: [PATCH v2] KVM: x86: Clear hardware HLT state when userspace makes a vCPU not-halted
Date: Thu, 20 Aug 2026 20:35:12 +0800
Message-Id: <20260820123512.87236-1-duankeqiangcym@gmail.com>
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


