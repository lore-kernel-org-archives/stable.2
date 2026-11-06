Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793976374;
	b=WJbP0IvCHFD+Fd7mttXKRjue4wHsbZoDLdBRT5O/dxliV4XuzSupEiHDpwtcCwoRQSde
	 cFwqkFPe19xJiX+VKPB2GzDaVkjIb/ARh4y33SfNCE+TeMTl6BJVLfUkb+PXDOk1Z+mtA
	 Ln+mC9k2FVo8ByUv/YwW2Sppe5vqXLy3Ai5JUGs40yYyWKpDuz/NUPkpoCXf60cUyDiGR
	 0JlqTH0JVuARTm0Obagiw7ijw4N0LApw1xPclXKnqUSM86vxohFNj/TVoeyU3zQfKJOsU
	 2S5PdFgN9128btmHsdg28cHXIu8b3VPeNPgJWWudZcuAWALLvOKqUOhe5H+LH5XbQyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976374;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=C23+x4dyjenyX4FwtuGZcgwB6QsFI2mzxLucYtaKZSo=;
	b=rWT4rpk0FLiOlRVE222VuNz4n3kMkO0OXo0bKN+6UrT83dE6FsmloB/a9Q0dFKinmcyo
	 ddGDiX9bIyMlMRd69rNN4jVRPB5wf6a5kIcZoUtzhdbB+eIRr9/dgHlBuJEGO2zPB3S3y
	 vlStwgOW2ejKWm0uljdtR7/ibGwVz4+0KKIetxq5Tc7KLZbtBYuEDs8cXnBaXj7EOjEDj
	 QWl5PiBAWdDNxDlXZnr8HehM7PdOxAdytVuU6ACNDjoByw7YvoYarrAVV7OKx12DoUNRu
	 i94zwcA3ARDXL3Hz2gkhDWUQX/88gS0qMYoGussU9c3yw8n+ts0eTwFskkcIzWUmmJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="dC8/CwyL";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DD4606A330
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 14:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dC8/CwyL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A101F008A1;
	Fri,  6 Nov 2026 14:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793976373;
	bh=C23+x4dyjenyX4FwtuGZcgwB6QsFI2mzxLucYtaKZSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dC8/CwyL0mnYXoFWvW3ii8SUMzVt4V7eNa2Zob9Xk51vMpNMANWefCQo6gCBnGtHp
	 pyknoYu53Cjdrm8iGzHYrOJuhunF7gL+NZ8+0joG77y9tzQF6qH8XBPuDwP59s21ZM
	 8uxv3xSVm7R4OEPaIsToQL1up/lzH91iJVU092Tk8jLXmYqPhNjlqGj0DTAagDRPuy
	 gIBKmlm3EfAp0y5F60IzmVDSgijGiTCHsLF6PIkiNoDECsIwdOeLpN6QRIjtpplh1B
	 O27YM4/Q4axvNSHfpytapzkw0Pwsgxyhj9SL6c5TvNmywPCvcq0THehwrGDhpNy3s/
	 SZcgVGdp+OHZA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Keqiang Duan <duankeqiangcym@gmail.com>,
	Qinguang Chen <chenqinguang@kuaishou.com>,
	Zhiping Du <duzhiping@kuaishou.com>,
	Chao Gao <chao.gao@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] KVM: x86: Clear hardware HLT state when userspace makes a vCPU not-halted
Date: Fri,  6 Nov 2026 09:46:11 -0500
Message-ID: <20261106144336.363080-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110435-dean-handwrite-b103@gregkh>
References: <2026110435-dean-handwrite-b103@gregkh>
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

From: Keqiang Duan <duankeqiangcym@gmail.com>

[ Upstream commit 883719f57f5d3898637b130d6db4742471cad618 ]

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

Hook KVM_SET_MP_STATE rather than the VM-Enter path so that the clearing
is driven by an explicit userspace declaration, and so that no work is
added to vmx_vcpu_run().  Gate the call on kvm_hlt_in_guest() even though
vmx_clear_hlt() checks it as well, as the check is cheap and makes it
obvious in common code when the hardware state can exist at all.

Do nothing for TDX vCPUs as TDX doesn't support disabling HLT-exiting and
KVM cannot access a TD's VMCS, i.e. the VMCS used to run the vCPU can't
in HALTED state, and even if it were, KVM can't change it.

Fixes: caa057a2cad6 ("KVM: X86: Provide a capability to disable HLT intercepts")
Cc: stable@vger.kernel.org
Tested-by: Qinguang Chen <chenqinguang@kuaishou.com>
Signed-off-by: Zhiping Du <duzhiping@kuaishou.com>
Signed-off-by: Keqiang Duan <duankeqiangcym@gmail.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
Link: https://patch.msgid.link/20260820123512.87236-1-duankeqiangcym@gmail.com
[sean: drop claim that spurious wakeups are ok, massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
[ sashal: Replaced kvm_x86_call(clear_hlt) with static_call_cond(kvm_x86_clear_hlt) to match the existing optional callback API. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/kvm-x86-ops.h |  1 +
 arch/x86/include/asm/kvm_host.h    |  7 +++++++
 arch/x86/kvm/vmx/vmx.c             |  1 +
 arch/x86/kvm/x86.c                 | 13 +++++++++++++
 4 files changed, 22 insertions(+)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 1cfe83263b213..91fa3d44457e4 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -74,6 +74,7 @@ KVM_X86_OP(interrupt_allowed)
 KVM_X86_OP(nmi_allowed)
 KVM_X86_OP(get_nmi_mask)
 KVM_X86_OP(set_nmi_mask)
+KVM_X86_OP_OPTIONAL(clear_hlt)
 KVM_X86_OP(enable_nmi_window)
 KVM_X86_OP(enable_irq_window)
 KVM_X86_OP_OPTIONAL(update_cr8_intercept)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 31395c43416dd..6c1e9c6dc42ff 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1540,6 +1540,13 @@ struct kvm_x86_ops {
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
 	void (*enable_nmi_window)(struct kvm_vcpu *vcpu);
 	void (*enable_irq_window)(struct kvm_vcpu *vcpu);
 	void (*update_cr8_intercept)(struct kvm_vcpu *vcpu, int tpr, int irr);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 16b95732ba9e6..9fa2eb33d54d1 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8234,6 +8234,7 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
 	.nmi_allowed = vmx_nmi_allowed,
 	.get_nmi_mask = vmx_get_nmi_mask,
 	.set_nmi_mask = vmx_set_nmi_mask,
+	.clear_hlt = vmx_clear_hlt,
 	.enable_nmi_window = vmx_enable_nmi_window,
 	.enable_irq_window = vmx_enable_irq_window,
 	.update_cr8_intercept = vmx_update_cr8_intercept,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c9e76ef43389f..0fcac00259cba 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11604,6 +11604,19 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 		set_bit(KVM_APIC_SIPI, &vcpu->arch.apic->pending_events);
 	} else
 		vcpu->arch.mp_state = mp_state->mp_state;
+
+	/*
+	 * Force the vCPU out of any hardware-tracked halted state, e.g. VMX's
+	 * GUEST_ACTIVITY_STATE=HLT, when userspace puts the vCPU into a state
+	 * other than HALTED.  The hardware state is sticky across VM-Exit and
+	 * VM-Enter and is not touched by any other ioctl, so a vCPU that halted
+	 * with HLT-exiting disabled stays wedged even after userspace rewrites
+	 * its registers, e.g. when a VMM emulates a machine reset.
+	 */
+	if (kvm_hlt_in_guest(vcpu->kvm) &&
+	    mp_state->mp_state != KVM_MP_STATE_HALTED)
+		static_call_cond(kvm_x86_clear_hlt)(vcpu);
+
 	kvm_make_request(KVM_REQ_EVENT, vcpu);
 
 	ret = 0;
-- 
2.53.0

