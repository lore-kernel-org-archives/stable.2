Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795839720;
	b=pY9mXULIQNKBD8U9Hh67ytqvt/KiLCVD+AAqSdzFX5HZt/7cY1zWqYQSqRRvTW1AlfkY
	 OpYkHgMf90W/cSu4WE8eFXfAQwev1q14qNbikkC1RGsQzkQkSIZ5AKlJri44PCrzoRDYm
	 t9bViOH117CkIRV/YXtVlUeEKa1phJt/eRHof0WsVy33GseTLOhQnZHShbHqd3pqJX0Qi
	 PV6CWdopaMjkUrttWQ+ByYfLJBlZZjFUw1k9d4lIYse2BvfW7J3oaPTOzHxF0qZXbEjbY
	 9P42d+XpoWrQ6SXoTBxUkO2IA7RUBmoIITkB0Z2RFZ7rqagrKC5/O3s23RENoyerjzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795839720;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:In-Reply-To:References:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=QdlGEGgoxXmXj2z9+6gwgdcRdU3zBjkud66acvRGVx8=;
	b=jBiCQXGvx6Vvqwpo8muLf9pEjiPXFXQrjOrF4vtbScAtYdt1WD5D9DSoKZ4sdEwGMcj7
	 xMaUhtRInoTTBMfOoHuGDgMtV6Dh+2UFnOpBowRJLO4cKAC8YHXn7Z/QeqEeb1ttRprox
	 owu+5vNpO5sqX6A1V06oDTwWZowPa6+fOR4WSmV/07caNPhSMDdOZkt20g8hnNUahebc3
	 Hx1LcQ7hs1hmKfluzBPN/+VfkYxNVQg04nr6EQtnxMxz+v+KZZb4ohYdZqIOgSfwXI6wP
	 /djkvwLpqp0ldqESZQQOGtBeRgHY02ss6qwtVn4190eWd1ncszo21zltM8dhCzOTgkQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VWxtbeF6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9913606A31C;
	Sat, 28 Nov 2026 04:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VWxtbeF6
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795839720;
	b=mhhFm21goL3YrHOz6TwW8a+9JRNwVzBrgvr17PhHlwr+ZShBHFfCCjyobvFI7qbmKRa1
	 x3662xfkCbDhCKDtvR6IFgWsZ2cgn5x+iO0fE4XOCItl6vuR161QZKTbUOHYfHFC4ZugO
	 5QJMKZrZJ+1EpQIeLYXxZZL4bag8wKDXukXVpr7tmuR14DM0Hg5zBLM8P8vLlErTzzyA7
	 Cp1WD4Nfk+gyLwnBwTUW6PDos1y7ScHZylUZNFSw3fDbABJnkQvx6HsvcRL5q1aXWsoBa
	 2gUD2F1xtPZk8v+QEdPN15u2eKo5JWc2uQesPpcdquCNQ05TQoqjNYlH7WqTDBDYbyw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795839720;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:
	 In-Reply-To:References:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To;
	bh=QdlGEGgoxXmXj2z9+6gwgdcRdU3zBjkud66acvRGVx8=;
	b=cD/PjPoeJamdDURzKfbq2xUT5PcH/YV3CGFfYHTQqTASdF/kOZ0wPo/6n2yfzcRVlWK0
	 f60ShXUPi5gQIWQKrWe/ztLdAteKF/GnBRSjkllGDtKf+ybl5Nbr5okjmSnALULfs8CuU
	 NjKlsMsP0DSJzvWhlYpzcPScwV0A074yDI9Djq9m9TzsLScKT28ZEYk9EtOAehe+l4O+t
	 9rBZ/9PtVcSqqO/LqmjzsyFwdAyxjTNhwskjTHSaeRZP+skJ48IcZycWOrqrQsYXZ/RQR
	 mwUiI8I5+SU1pz395uz11fTbF5+EAJzGTfWJycdC/HoA3rGQer8fBmxIBwfL5DW5NKA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 11FA71F00893;
	Sat, 28 Nov 2026 04:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795839720;
	bh=QdlGEGgoxXmXj2z9+6gwgdcRdU3zBjkud66acvRGVx8=;
	h=From:Date:Subject:In-Reply-To:References:To:Cc:Reply-To;
	b=VWxtbeF6D/9pjdBCdMs5/6qxwlbuaZf0ZBEVuibSRxEsTuZgcvyw9tkRulLk9s3Vn
	 EG7kvomEzjSq26oq3oiLfyOb6E4xe5GWF0OfxcoUTCIex+/ZeHyRYBfeGX0+B3Mk3h
	 433j4ny5hnnMKcgNCQiqkFpTs4n9D90+g9hCJgMCbDDLb9J4V5BZSLoKz0WXyB/wFk
	 m0ZwK2tS4KVkY0TLNb6IIGZ8tiEL3y9raPhT4/+B+qsTPJab1Cd5hPXIFr0pIpPqsV
	 cEtrctQj+5woScGk5kSCax0GjoFmVotIPXotvO8xkWQFNS685eMB5o8AwTM1Uoyc9O
	 Eqwdb+YDOF81g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9A8184DF96;
	Sat, 28 Nov 2026 04:21:54 +0000 (UTC)
From: Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>
Date: Sat, 28 Nov 2026 04:13:05 +0000
Subject: [PATCH 6.6.y] KVM: x86: Unconditionally recompute CR8 intercept on
 PPR update
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261128-kvm-cr8-66b-v1-1-821d19f3001a@certik.com>
X-B4-Tracking: v=1; b=H4sIANBUCmsC/02NzQ6CMBCEX4Xs2UVbyIb4KsZDW7ZSfwrpItEQ3
 t1WLx7ny8w3KwinwALHaoXES5AwxhzUrgI3mHhhDH3OoA+alNId3pYHutQhkcWGbeO9Uq5tCfJ
 iSuzD62s7AdVUv+H8w/K0V3ZzMZWiNcJok4luKEg49vM43rHw/d8DbNsHiGYTnqIAAAA=
X-Change-ID: 20261128-kvm-cr8-66b-3eb3ff11c446
In-Reply-To: <2026071630-earmark-chop-3d7f@gregkh>
References: <2026071630-earmark-chop-3d7f@gregkh>
To: stable@vger.kernel.org
Cc: clopez@suse.de, Sean Christopherson <seanjc@google.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795839184; l=7616;
 i=dickson.wu@certik.com; s=dickson-b4; h=from:subject:message-id;
 bh=O1sRldbR0kLnbdVCe7s0tIwjDpjmQ/7AKyu5L/PXVHQ=;
 b=oWBJI6Z3fUAb7DjfFYDuYt7lsgMfAHGWDZDZoZzXgS7HTf71guuwkg61fXP9icM0dOQa92Knx
 zSngdtPb7kPCN0LDmGcTf52Ewl0C1S/lwoig7jENa/nWtlXhbJaV4Kz
X-Developer-Key: i=dickson.wu@certik.com; a=ed25519;
 pk=fxH7FS4FdojeJSGLJzgKdfO51Rvr4EW30yinj2mc1vg=
X-Endpoint-Received: by B4 Relay for dickson.wu@certik.com/dickson-b4 with
 auth_id=1647
X-Original-From: Dickson Wu <dickson.wu@certik.com>
Reply-To: dickson.wu@certik.com

From: Carlos López <clopez@suse.de>

commit bb365a506b1e6fb050c0fceaad354fe395385ef0 upstream.

The TPR_THRESHOLD field in the VMCS is used by VMX to induce VM exits
when the guest's virtual TPR falls under the specified threshold,
allowing KVM to inject previously masked interrupts.

KVM handles these VM exits in handle_tpr_below_threshold().
Commit eb90f3417a0c ("KVM: vmx: speed up TPR below threshold vmexits")
optimized this function by calling apic_update_ppr() instead of raising
KVM_REQ_EVENT. apic_update_ppr() then raises KVM_REQ_EVENT if there is
a pending, deliverable interrupt.

However, if there are no new interrupts pending, apic_update_ppr() does
not issue the request. Thus, kvm_lapic_update_cr8_intercept() and
vmx_update_cr8_intercept() are not called before VM entry, which results
in a high, stale TPR_THRESHOLD. This is problematic due to the following
sentence in 28.2.1.1 "VM-Execution Control Fields" in the SDM:

  The following check is performed if the “use TPR shadow” VM-execution
  control is 1 and the “virtualize APIC accesses” and “virtual-interrupt
  delivery” VM-execution controls are both 0: the value of bits 3:0 of
  the TPR threshold VM-execution control field should not be greater
  than the value of bits 7:4 of VTPR.

This error condition is typically not observed when KVM runs on a bare
metal system because modern processors support APICv, which enables
virtual-interrupt delivery, and which KVM uses when possible. This
causes the processor to no longer generate TPR-below-threshold exits
and to no longer check TPR_THRESHOLD on entry. However, when running
on older platforms, or under nested virtualization on a hypervisor that
does not support virtual-interrupt delivery and enforces this check
(like Hyper-V) this can cause a VM entry failure with hardware error
0x7, as seen in [1].

Call kvm_lapic_update_cr8_intercept() if apic_update_ppr() does not
find a deliverable interrupt (and thus does not raise KVM_REQ_EVENT).
Remove calls to kvm_lapic_update_cr8_intercept() on paths that end up in
apic_update_ppr(), as they now become redundant. This ensures that any
path that updates the guest's PPR also figures out if KVM needs to wait
for a TPR change (using TPR_THRESHOLD on VMX or CR8 intercepts on SVM).

Link: https://github.com/coconut-svsm/svsm/issues/1081 [1]
Tested-by: Stefano Garzarella <sgarzare@redhat.com>
Cc: stable@vger.kernel.org
Fixes: eb90f3417a0c ("KVM: vmx: speed up TPR below threshold vmexits")
Signed-off-by: Carlos López <clopez@suse.de>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260618174347.1981064-3-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[ adapted to 6.6.y: rename update_cr8_intercept(), declare it in lapic.h ]
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---
This failed to apply to 6.6.y. Upstream calls
kvm_lapic_update_cr8_intercept(), which only exists after
update_cr8_intercept() moved to lapic.c (c67494e7fae6). Here the x86.c
helper takes that name, becomes non-static and is declared in lapic.h
so apic_update_ppr() can call it. The rest matches upstream: the now
redundant calls after KVM_SET_LAPIC and in __set_sregs_common() go
away, and CR8 is set after the segments.

Tested on 6.6.163 in a QEMU guest with APICv disabled. A small KVM
test leaves vector 0x50 pending below an in-service 0x60, sets CR8
through KVM_SET_SREGS and through KVM_SYNC_X86_SREGS, then lowers it.
On the base kernel the vCPU keeps exiting through
handle_tpr_below_threshold() and both cases time out; with the patch
both complete. recalc_apic_map_test, vmx_apic_access_test,
xapic_ipi_test and xapic_state_test pass on both kernels, and a W=1
build of lapic.o and x86.o shows no new warnings. I didn't reproduce
the nested VM-entry failure under Hyper-V.

The backport and the test runs were prepared with AI coding tools
(OpenAI Codex agents, with review by Claude). I went over the result
before signing off.
---
 arch/x86/kvm/lapic.c |  2 ++
 arch/x86/kvm/lapic.h |  1 +
 arch/x86/kvm/x86.c   | 10 +++-------
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index a750ec8057cc..228d01964b5b 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -981,6 +981,8 @@ static void apic_update_ppr(struct kvm_lapic *apic)
 	if (__apic_update_ppr(apic, &ppr) &&
 	    apic_has_interrupt_for_ppr(apic, ppr) != -1)
 		kvm_make_request(KVM_REQ_EVENT, apic->vcpu);
+	else
+		kvm_lapic_update_cr8_intercept(apic->vcpu);
 }
 
 void kvm_apic_update_ppr(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index 0dd069b8d6d1..20e60f7ee2f2 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -108,6 +108,7 @@ void kvm_apic_clear_irr(struct kvm_vcpu *vcpu, int vec);
 bool __kvm_apic_update_irr(u32 *pir, void *regs, int *max_irr);
 bool kvm_apic_update_irr(struct kvm_vcpu *vcpu, u32 *pir, int *max_irr);
 void kvm_apic_update_ppr(struct kvm_vcpu *vcpu);
+void kvm_lapic_update_cr8_intercept(struct kvm_vcpu *vcpu);
 int kvm_apic_set_irq(struct kvm_vcpu *vcpu, struct kvm_lapic_irq *irq,
 		     struct dest_map *dest_map);
 int kvm_apic_local_deliver(struct kvm_lapic *apic, int lvt_type);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index cc50327a0f13..af5c43c0d6d0 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -113,7 +113,6 @@ static u64 __read_mostly cr4_reserved_bits = CR4_RESERVED_BITS;
 #define KVM_X2APIC_API_VALID_FLAGS (KVM_X2APIC_API_USE_32BIT_IDS | \
                                     KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK)
 
-static void update_cr8_intercept(struct kvm_vcpu *vcpu);
 static void process_nmi(struct kvm_vcpu *vcpu);
 static void __kvm_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags);
 static void store_regs(struct kvm_vcpu *vcpu);
@@ -4977,7 +4976,6 @@ static int kvm_vcpu_ioctl_set_lapic(struct kvm_vcpu *vcpu,
 	r = kvm_apic_set_state(vcpu, s);
 	if (r)
 		return r;
-	update_cr8_intercept(vcpu);
 
 	return 0;
 }
@@ -10094,7 +10092,7 @@ static void post_kvm_run_save(struct kvm_vcpu *vcpu)
 		kvm_run->flags |= KVM_RUN_X86_SMM;
 }
 
-static void update_cr8_intercept(struct kvm_vcpu *vcpu)
+void kvm_lapic_update_cr8_intercept(struct kvm_vcpu *vcpu)
 {
 	int max_irr, tpr;
 
@@ -10816,7 +10814,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 			static_call(kvm_x86_enable_irq_window)(vcpu);
 
 		if (kvm_lapic_enabled(vcpu)) {
-			update_cr8_intercept(vcpu);
+			kvm_lapic_update_cr8_intercept(vcpu);
 			kvm_lapic_sync_to_vapic(vcpu);
 		}
 	}
@@ -11718,8 +11716,6 @@ static int __set_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs,
 	kvm_register_mark_dirty(vcpu, VCPU_EXREG_CR3);
 	static_call_cond(kvm_x86_post_set_cr3)(vcpu, sregs->cr3);
 
-	kvm_set_cr8(vcpu, sregs->cr8);
-
 	*mmu_reset_needed |= vcpu->arch.efer != sregs->efer;
 	static_call(kvm_x86_set_efer)(vcpu, sregs->efer);
 
@@ -11749,7 +11745,7 @@ static int __set_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs,
 	kvm_set_segment(vcpu, &sregs->tr, VCPU_SREG_TR);
 	kvm_set_segment(vcpu, &sregs->ldt, VCPU_SREG_LDTR);
 
-	update_cr8_intercept(vcpu);
+	kvm_set_cr8(vcpu, sregs->cr8);
 
 	/* Older userspace won't unhalt the vcpu on reset. */
 	if (kvm_vcpu_is_bsp(vcpu) && kvm_rip_read(vcpu) == 0xfff0 &&

---
base-commit: e2bb30811e063ce0db964484357973b855b06572
change-id: 20261128-kvm-cr8-66b-3eb3ff11c446

Best regards,
--  
Dickson Wu <dickson.wu@certik.com>


