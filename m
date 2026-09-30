Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C942D4DA9D2
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 13:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773992; cv=none; b=o99I5vhIyowE1RJtZfllLvRq0j01krDEknhRsVO6Aw143F1GE6wkqeop/R6P3f1/gySdasXOJpTykPDd0DEftmk//GM829aZKFt4ZU8V9/PfVgb1JC4ZIHoy+e0brih/cTW5tYpFS9BP4+B6l9RlqEu78X5gaDfmrOHlVE/YCdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773992; c=relaxed/simple;
	bh=G4d9zBopmqb3XCN0o6mWayxAYurtSJg/ua/mX6AMlxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHBZbAMIbeMOZ0G8j7K3SePN0j0P0zTY0Jn0Ka7TeJNvhMFBmq+rvxAG4jbuup0WfVuLeYgwwODWKSu/lzQ5mAt04O0znVz1c5VV7NGZsc1b5cwOCrtJ8NZuIlZ/Vi/FO2u0/Wpd4KTRpUV2CQefSLWGeIdXagi8tqSpk48t4Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NeVRel43; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NeVRel43"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648F21F00898;
	Wed, 30 Sep 2026 13:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790773979;
	bh=DEefKooOeJuj0IjIUuHobNgJvLNbx52ZxQtA7liCY8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NeVRel43JH+hyFzQ91M7gGgcBTIOyKPHQbtAt/Ypx2yJ0vjAo1HwmaqZwWNuzyF7q
	 ePBWU6cvW45Y3HWKpFA+s0mhXFoKcDURGhZG8wzHVS33Mge7JGwHE1Z0tKF6LYNqKK
	 TDlCZCr83RJVPnC6ObsXi4OVkT5lxm5V/SLmSTE2QtRSIu7WkJmul14KLaCYfZFaKW
	 bWv1/sq9GANfmP7f5ATYLrRfl4AzB/4t2fMcMCknKHBDsLqsG23KSLXTObilRg4l5n
	 AuMxYcSmoiULoMatn/G46g8FFjg/r+A9k/8VFNipSdU2ToAcpqy6PjDfrPI9zR8q2c
	 BoE+EogRVTbCw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 2/8] KVM: x86: Rework kvm_arch_interrupt_allowed() into kvm_is_interrupt_allowed()
Date: Wed, 30 Sep 2026 09:12:49 -0400
Message-ID: <20260930131256.1728861-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930131256.1728861-1-sashal@kernel.org>
References: <2026092945-unzip-pluck-7c40@gregkh>
 <20260930131256.1728861-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 5b9585bc5b883bb64f02bf171fd7c676caecd16f ]

Rename kvm_arch_interrupt_allowed() to kvm_is_interrupt_allowed() and
change its return type to a boolean, as the purpose of the helper is purely
to check if interrupts are architecturally allowed.  I.e. whether or not
interrupts are temporarily disallowed due a pending nested VM-Enter is
irrelevant (and callers are most definitely not supposed to care).

Opportunistically bury the helper in x86.c, as it hasn't been referenced by
arch-neutral code since commit a1b37100d9e2 ("KVM: Reduce runnability
interface with arch support code"), and has long since gained _very_
x86-specific semantics (see above).

Opportunistically add a comment to call out that treating -EBUSY as
"allowed" is intentional.

For all intents and purposes, no functional change intended (KVM treats
-EBUSY as "allowed" before and after).

Cc: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260613000329.732085-28-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: 10180a277549 ("KVM: x86: Re-pend GET_NESTED_STATE_PAGES if getting said pages fails")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/kvm_host.h |  1 -
 arch/x86/kvm/x86.c              | 23 +++++++++++++++--------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index cb07b2b8093db..a89beb6f8eade 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2462,7 +2462,6 @@ enum {
 # define kvm_memslots_for_spte_role(kvm, role) __kvm_memslots(kvm, 0)
 #endif
 
-int kvm_arch_interrupt_allowed(struct kvm_vcpu *vcpu);
 void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event);
 
 int kvm_pv_send_ipi(struct kvm *kvm, unsigned long ipi_bitmap_low,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 9822ff0450bb2..bd05ef7aa966f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4911,6 +4911,18 @@ static int kvm_vcpu_ioctl_set_lapic(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
+static bool kvm_is_interrupt_allowed(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * Note, .interrupt_allowed() returns -EBUSY if interrupts are allowed
+	 * based on CPU state, but can't be immediately delivered due to a
+	 * pending nested VM-Enter.  Treat that case as "allowed", because
+	 * the goal here is just to check if interrupts are architecturally
+	 * allowed, not to check if they can be injected.
+	 */
+	return kvm_x86_call(interrupt_allowed)(vcpu, false);
+}
+
 static int kvm_cpu_accept_dm_intr(struct kvm_vcpu *vcpu)
 {
 	/*
@@ -4936,7 +4948,7 @@ static int kvm_vcpu_ready_for_interrupt_injection(struct kvm_vcpu *vcpu)
 	 * or KVM_SET_SREGS.  For that to work, we must be at an
 	 * instruction boundary and with no events half-injected.
 	 */
-	return (kvm_arch_interrupt_allowed(vcpu) &&
+	return (kvm_is_interrupt_allowed(vcpu) &&
 		kvm_cpu_accept_dm_intr(vcpu) &&
 		!kvm_event_needs_reinjection(vcpu) &&
 		!kvm_is_exception_pending(vcpu));
@@ -11140,7 +11152,7 @@ bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu)
 	if (kvm_test_request(KVM_REQ_UPDATE_PROTECTED_GUEST_STATE, vcpu))
 		return true;
 
-	if (kvm_arch_interrupt_allowed(vcpu) && kvm_cpu_has_interrupt(vcpu))
+	if (kvm_is_interrupt_allowed(vcpu) && kvm_cpu_has_interrupt(vcpu))
 		return true;
 
 	if (kvm_hv_has_stimer_pending(vcpu))
@@ -13004,11 +13016,6 @@ int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
 	return kvm_vcpu_exiting_guest_mode(vcpu) == IN_GUEST_MODE;
 }
 
-int kvm_arch_interrupt_allowed(struct kvm_vcpu *vcpu)
-{
-	return kvm_x86_call(interrupt_allowed)(vcpu, false);
-}
-
 static inline u32 kvm_async_pf_hash_fn(gfn_t gfn)
 {
 	BUILD_BUG_ON(!is_power_of_2(ASYNC_PF_PER_VCPU));
@@ -13144,7 +13151,7 @@ bool kvm_can_do_async_pf(struct kvm_vcpu *vcpu)
 	 * If interrupts are off we cannot even use an artificial
 	 * halt state.
 	 */
-	return kvm_arch_interrupt_allowed(vcpu);
+	return kvm_is_interrupt_allowed(vcpu);
 }
 
 bool kvm_arch_async_page_not_present(struct kvm_vcpu *vcpu,
-- 
2.53.0

