Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795689285;
	b=BE4AAyb8UogDA3T9zbqb4bULhK0LNJZB0JT9Oby/zkEAqsTd+p+tBamwEsT0gUT9iJnY
	 ovJ5VdrxTb3oqvPD9a7lRdANdPlGmoPjJxcVJVhQJ6aS/ORB6zvB2myuO2ITzWFnPxXZw
	 YINNSuPY2EEqDU75cPq7G2cpT46hp82OBwUY7NU1Xp1dvUHtkdSjjnXoKShIs+nB3AOFV
	 ysIEZQpP5SVpNWSTaoXsLoQQ+B0SUXSm42IX+Rhy3n/4ElmJ6ZmFPXx20+azy7TUu0kV5
	 ybbLfjQjKeMV6qv+QFTVoFkL2fMv/8JxxE1Y0GDaO6oHukuzKGffcLF1C4gacwlOEtg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795689285;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=8eZBaU6z95EeRYC0FmVtB0seoiQZSZeUPr/3m7VzgOU=;
	b=JnIlXkR2W5tCAsMFKNfy/TxJyIWIbeAQcZvmgh47I+YsGP+GmHyZtCPzU4NT5/fJWBH3
	 /iblWvyCYyNJAGKAzmQpUVG6nge3E30RhmyYoIWXiDQFUg08L5tzPm9OAyoKwZUUcyfSd
	 uJf34kOfwT/WEW2G32ymrsfTdg44aqjLtZybKJq1hmoTIGZE6r+QAGqHozb54g7i+vML5
	 1SOU8i59xn133rfdoVMqYc2z4C6btare2f44OAtAqcqrYyRdcbpEf0micFaCX12eD9STC
	 x3BCzagFhQgGWxBwXVg/dybL9KFX+3X0qccIenbuXYFoC8iurkozq33eAsy/lN4m1qQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R85x3qYL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5D0606A684;
	Thu, 26 Nov 2026 10:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R85x3qYL
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795689284;
	b=OV+xAIFrBLu8Pe+64Id2+BUY8rqZ5UmehkZ4OeWzQ4YNO3wYmKZER5Jx2Cy55YkI5OPV
	 p9h5OBbWP9d+cl9nLg/CTReI2hHnM5NLOKa4P2aAFGvtYxfu+o0hD6z8m9Ee1aJMYe0Lz
	 wPqNpAXHCG1yz7uB+Vtz3jfy5Au8SddjWII/TfyiLharTQBi+VFQES6pRbWuHRP0FTBhI
	 YiCdce0+aGe0wly5P75pcx9LkOwJ1Pm7dlLRXo2/ROLwuFigW6V9kYH5tpwjoHwwPjr/B
	 KVidLPbq28eFNDIEaCR+8gnTNFKdjiNiUPy0QIeLAVBvFRHlF31xgwfw9OtO6c8/dPg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795689284;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=8eZBaU6z95EeRYC0FmVtB0seoiQZSZeUPr/3m7VzgOU=;
	b=XUIndh4mRCRHC4m6bdyoimWwc2h8wwanl8pZVqPaDLV6ZvpGMvmzR1CEpVrBz0hpCKrh
	 kGfHitHakbdgv8TwCW0/wbcL8ERzlxG5ucSUmNA40n4BUsMJAgsuafipNlL7cS4kNLly0
	 hSZ0Wr2q4oYwVIvKXLnquw34u8vWr9eD3ffs92slUXy0+NfLF5hUAdc8jU06UW3T+BSAz
	 ulttcEgde55APRM9A4ZyK8R34gRiHAbIlYWlxYD7IJtDFFbSilnUU/hLQMw4QuYwQ7DQR
	 FrrbdOukBUUtVHWMwxWvJd+WFI7HS6m8uWdTzdHK7TvWkirztOR0h7Ks1DWnpilE4MA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7F4ED1F000EB;
	Thu, 26 Nov 2026 10:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795689284;
	bh=8eZBaU6z95EeRYC0FmVtB0seoiQZSZeUPr/3m7VzgOU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=R85x3qYLex516igtTOP18i4JXsRMI9bx3zeXEtrJwR156PTpjmfQWnTmpGeAKqVyL
	 yOjncV9AR+QjDwOKE5UJVxaLYFpwSNEDFUjkpcftjxoffM8CeGYXFZpOFu+Q/4llJJ
	 KqhCiy4i5Zox7J2F2GEIi11oTwTtchK7pW1Wjrbi2HS9nthl4OLurVTzJeWwplCnWJ
	 q+AeZibaCVaRlIQpDuQXGKM52XxmeGmblOF1jVJ33lbf5SaZkgQug4fntOTvM+b8T5
	 zUjJdb8cNOSn1V0IViT9BUk2Tm80+zQqHvqmtnQXV/ulFkYWO4gYwqHtnNJpywUamG
	 QyYctTxIGlEYw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1164C4D448;
	Thu, 26 Nov 2026 10:34:40 +0000 (UTC)
From: Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>
Date: Thu, 26 Nov 2026 10:31:57 +0000
Subject: [PATCH 5.10.y v2 1/2] KVM: x86: pull kvm->srcu read-side to
 kvm_arch_vcpu_ioctl_run
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-kvm-510d-v2-1-bcba96aa2088@certik.com>
References: <20261126-kvm-510d-v2-0-bcba96aa2088@certik.com>
In-Reply-To: <20261126-kvm-510d-v2-0-bcba96aa2088@certik.com>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795689116; l=5395;
 i=dickson.wu@certik.com; s=dickson-b4; h=from:subject:message-id;
 bh=aWlRKTULD3CULaHPvBETo5OWJQzrTM787U9y9afMXqY=;
 b=/Zc0OGramgsMxtQpZ9yJX9U88b3svJgKHqE3rON3D809yG9SntKymh1C5aJrFPIaa6AvADnb4
 HR23ixzMHWbAVlEZhGr74cbBn9vN8CqB173FIxmrhWohp/DkNkiDnni
X-Developer-Key: i=dickson.wu@certik.com; a=ed25519;
 pk=fxH7FS4FdojeJSGLJzgKdfO51Rvr4EW30yinj2mc1vg=
X-Endpoint-Received: by B4 Relay for dickson.wu@certik.com/dickson-b4 with
 auth_id=1647
X-Original-From: Dickson Wu <dickson.wu@certik.com>
Reply-To: dickson.wu@certik.com

From: Paolo Bonzini <pbonzini@redhat.com>

commit 8d25b7beca7ed6ca34f53f0f8abd009e2be15d94 upstream.

kvm_arch_vcpu_ioctl_run is already doing srcu_read_lock/unlock in two
places, namely vcpu_run and post_kvm_run_save, and a third is actually
needed around the call to vcpu->arch.complete_userspace_io to avoid
the following splat:

  WARNING: suspicious RCU usage
  arch/x86/kvm/pmu.c:190 suspicious rcu_dereference_check() usage!
  other info that might help us debug this:
  rcu_scheduler_active = 2, debug_locks = 1
  1 lock held by CPU 28/KVM/370841:
  #0: ff11004089f280b8 (&vcpu->mutex){+.+.}-{3:3}, at: kvm_vcpu_ioctl+0x87/0x730 [kvm]
  Call Trace:
   <TASK>
   dump_stack_lvl+0x59/0x73
   reprogram_fixed_counter+0x15d/0x1a0 [kvm]
   kvm_pmu_trigger_event+0x1a3/0x260 [kvm]
   ? free_moved_vector+0x1b4/0x1e0
   complete_fast_pio_in+0x8a/0xd0 [kvm]

This splat is not at all unexpected, since complete_userspace_io callbacks
can execute similar code to vmexits.  For example, SVM with nrips=false
will call into the emulator from svm_skip_emulated_instruction().

While it's tempting to never acquire kvm->srcu for an uninitialized vCPU,
practically speaking there's no penalty to acquiring kvm->srcu "early"
as the KVM_MP_STATE_UNINITIALIZED path is a one-time thing per vCPU.  On
the other hand, seemingly innocuous helpers like kvm_apic_accept_events()
and sync_regs() can theoretically reach code that might access
SRCU-protected data structures, e.g. sync_regs() can trigger forced
existing of nested mode via kvm_vcpu_ioctl_x86_set_vcpu_events().

Reported-by: Like Xu <likexu@tencent.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[ adapted to 5.10.y: keep wants_to_run, no Xen reader; folds in 2d08935682ac ]
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---
The backport and the test runs were prepared with AI coding tools
(OpenAI Codex agents, with review by Claude). I went over the result
before signing off.

 arch/x86/kvm/x86.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 58660d5de141..69ab4e317422 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8486,6 +8486,7 @@ static int dm_request_for_irq_injection(struct kvm_vcpu *vcpu)
 		likely(!pic_in_kernel(vcpu->kvm));
 }
 
+/* Called within kvm->srcu read side.  */
 static void post_kvm_run_save(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *kvm_run = vcpu->run;
@@ -9098,6 +9099,7 @@ void __kvm_request_immediate_exit(struct kvm_vcpu *vcpu)
 EXPORT_SYMBOL_GPL(__kvm_request_immediate_exit);
 
 /*
+ * Called within kvm->srcu read side.
  * Returns 1 to let vcpu_run() continue the guest execution loop without
  * exiting to the userspace.  Otherwise, the value will be returned to the
  * userspace.
@@ -9421,6 +9423,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	return r;
 }
 
+/* Called within kvm->srcu read side.  */
 static inline int vcpu_block(struct kvm *kvm, struct kvm_vcpu *vcpu)
 {
 	if (!kvm_arch_vcpu_runnable(vcpu) &&
@@ -9463,12 +9466,12 @@ static inline bool kvm_vcpu_running(struct kvm_vcpu *vcpu)
 		!vcpu->arch.apf.halted);
 }
 
+/* Called within kvm->srcu read side.  */
 static int vcpu_run(struct kvm_vcpu *vcpu)
 {
 	int r;
 	struct kvm *kvm = vcpu->kvm;
 
-	vcpu->srcu_idx = srcu_read_lock(&kvm->srcu);
 	vcpu->arch.l1tf_flush_l1d = true;
 
 	for (;;) {
@@ -9503,25 +9506,18 @@ static int vcpu_run(struct kvm_vcpu *vcpu)
 		if (__xfer_to_guest_mode_work_pending()) {
 			srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
 			r = xfer_to_guest_mode_handle_work(vcpu);
+			vcpu->srcu_idx = srcu_read_lock(&kvm->srcu);
 			if (r)
 				return r;
-			vcpu->srcu_idx = srcu_read_lock(&kvm->srcu);
 		}
 	}
 
-	srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
-
 	return r;
 }
 
 static inline int complete_emulated_io(struct kvm_vcpu *vcpu)
 {
-	int r;
-
-	vcpu->srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
-	r = kvm_emulate_instruction(vcpu, EMULTYPE_NO_DECODE);
-	srcu_read_unlock(&vcpu->kvm->srcu, vcpu->srcu_idx);
-	return r;
+	return kvm_emulate_instruction(vcpu, EMULTYPE_NO_DECODE);
 }
 
 static int complete_emulated_pio(struct kvm_vcpu *vcpu)
@@ -9646,18 +9642,23 @@ static void kvm_put_guest_fpu(struct kvm_vcpu *vcpu)
 int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *kvm_run = vcpu->run;
+	struct kvm *kvm = vcpu->kvm;
 	int r;
 
 	vcpu_load(vcpu);
 	kvm_sigset_activate(vcpu);
 	kvm_load_guest_fpu(vcpu);
 
+	vcpu->srcu_idx = srcu_read_lock(&kvm->srcu);
 	if (unlikely(vcpu->arch.mp_state == KVM_MP_STATE_UNINITIALIZED)) {
 		if (!vcpu->wants_to_run) {
 			r = -EINTR;
 			goto out;
 		}
+		srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
 		kvm_vcpu_block(vcpu);
+		vcpu->srcu_idx = srcu_read_lock(&kvm->srcu);
+
 		kvm_apic_accept_events(vcpu);
 		kvm_clear_request(KVM_REQ_UNHALT, vcpu);
 		r = -EAGAIN;
@@ -9707,8 +9708,9 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 	if (kvm_run->kvm_valid_regs)
 		store_regs(vcpu);
 	post_kvm_run_save(vcpu);
-	kvm_sigset_deactivate(vcpu);
+	srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
 
+	kvm_sigset_deactivate(vcpu);
 	vcpu_put(vcpu);
 	return r;
 }

-- 
2.43.0


