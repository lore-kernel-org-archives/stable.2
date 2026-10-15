Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EE2499F23;
	Thu, 15 Oct 2026 10:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792058746; cv=none; b=lHRoLBVdYOz0GSDacf6Bfdy19+da2oQgl8D+64zORKWnb95eegG5/Erj57PMghMjaLCel62KbsE2R3VGJgAgPp+6gwgjrVMkkk97Erq2splM9gzmYGWBIXxowLLDUr0+LJzIwjlt3nz3FCHZg6vQuhrVR3Oi4M4XdMDRtGRtABA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792058746; c=relaxed/simple;
	bh=Fa/Fl7yQLCFi0wirZWAPPOUcD+ltOoLN/YZXIz5l8Es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hqZ+XlpT5N+PD53ZAiBywKL7r1wJMyciTBErC3VdyPQNF+cugQGf8pL5fdGAimuCIhzKP0sFmNl/40Vkplwr+PsIpUOYZhBSdwLWYTQ3DpeCNcCCYK3rco6wuRx66JE1dth1tiTd2ViebGZpKDdgb/5WzxZqbMY6D3luvVVN9y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UL7vGU2d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UL7vGU2d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E49D71F000C6;
	Thu, 15 Oct 2026 10:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792058744;
	bh=03zjQQJrzlvixqCO6kY17ZcnCnLvJX2CD7hsp0wle7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UL7vGU2drMo+oSMQdgnJfWE2uV4Dgyap+0yHgXcZUchbWQ7W8gu09KlUAjx9rVX5/
	 azErWThURCKNtLo4EqMHBwaCTNlP3Bmf86w74F5En7dL1OLoBZ9Bg1Qs4rgcEdbkHk
	 P1HlDdx+Z+rzLj5jEVWtULONxM9Ydl1CFqijcleaAIxbyMYpMUrq0LEGmAHIseJ/zH
	 U7LjW5J40DAyk0djp0nIsn2+S9a1lPtY9H+YMBWTm+nu4/B23bGWzSuoo5cUkzNzr9
	 /5mHHBqsU6Ga8A1455Gco0TgscTtOvYGKLSJBJPBXRZ9ufWxVB3e/sDuB22CmU3BN6
	 4ZoRFRf2LQWWg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1xHILG-00000003EfK-34mT;
	Thu, 15 Oct 2026 10:05:42 +0000
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	kvm@vger.kernel.org
Cc: Steffen Eiden <seiden@linux.ibm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Oliver Upton <oupton@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH 1/7] KVM: arm64: nv: Move L2->L1 switch on interrupt early
Date: Thu, 15 Oct 2026 11:05:33 +0100
Message-ID: <20261015100539.1011760-2-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261015100539.1011760-1-maz@kernel.org>
References: <20261015100539.1011760-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, seiden@linux.ibm.com, joey.gouly@arm.com, suzuki.poulose@arm.com, oupton@kernel.org, yuzenghui@huawei.com, fuad.tabba@linux.dev, stable@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

NV request generation to switch from L2 to L1 on interrupt is buried
into the vgic flush code, while we should be able to deliver requests
as early as possible.

Similarly, MI generation happens *after* the need for a request has been
evaluated, which means we potentially delay the maintenance interrupt by
a full exit/entry cycle.

Move these two things to happen much earlier in the entry code, and make
sure the MI generation and PMU interrupt serve as input to the request
switching back from L2 to L1.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm64/kvm/arm.c       | 4 ++--
 arch/arm64/kvm/nested.c    | 8 ++++++++
 arch/arm64/kvm/vgic/vgic.c | 8 +-------
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 0576c2022ef57..73706464d2653 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1314,11 +1314,11 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 		 */
 		preempt_disable();
 
-		kvm_nested_flush_hwstate(vcpu);
-
 		if (kvm_vcpu_has_pmu(vcpu))
 			kvm_pmu_flush_hwstate(vcpu);
 
+		kvm_nested_flush_hwstate(vcpu);
+
 		local_irq_disable();
 
 		kvm_vgic_flush_hwstate(vcpu);
diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index b191365d97cc2..2fac0f2678122 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -2046,6 +2046,9 @@ void check_nested_vcpu_requests(struct kvm_vcpu *vcpu)
  *
  * What follows is some slop to (1) react to exception routing / masking and (2)
  * preserve the pending SError state across translation regimes.
+ *
+ * Also generate the maintenance interrupt state, and finally check that if
+ * we need to take an interrupt targetting the guest hypervisor.
  */
 void kvm_nested_flush_hwstate(struct kvm_vcpu *vcpu)
 {
@@ -2054,6 +2057,11 @@ void kvm_nested_flush_hwstate(struct kvm_vcpu *vcpu)
 
 	if (unlikely(vcpu_test_and_clear_flag(vcpu, NESTED_SERROR_PENDING)))
 		kvm_inject_serror_esr(vcpu, vcpu_get_vsesr(vcpu));
+
+	vgic_v3_nested_update_mi(vcpu);
+
+	if (vgic_state_is_nested(vcpu) && kvm_vgic_vcpu_pending_irq(vcpu))
+		kvm_make_request(KVM_REQ_GUEST_HYP_IRQ_PENDING, vcpu);
 }
 
 void kvm_nested_sync_hwstate(struct kvm_vcpu *vcpu)
diff --git a/arch/arm64/kvm/vgic/vgic.c b/arch/arm64/kvm/vgic/vgic.c
index 5cf5a1ef86cdd..7061b4ab206c9 100644
--- a/arch/arm64/kvm/vgic/vgic.c
+++ b/arch/arm64/kvm/vgic/vgic.c
@@ -1152,7 +1152,7 @@ void kvm_vgic_flush_hwstate(struct kvm_vcpu *vcpu)
 	 *
 	 *   We do that by placing a request to ourselves which will
 	 *   abort the entry procedure and inject the exception at the
-	 *   beginning of the run loop.
+	 *   beginning of the run loop (see kvm_nested_flush_hwstate()).
 	 *
 	 * - Otherwise, do exactly *NOTHING* apart from enabling the virtual
 	 *   CPU interface. The guest state is already loaded, and we can
@@ -1162,16 +1162,10 @@ void kvm_vgic_flush_hwstate(struct kvm_vcpu *vcpu)
 	 * maintenance interrupt state, as it may fire.
 	 */
 	if (vgic_state_is_nested(vcpu)) {
-		if (kvm_vgic_vcpu_pending_irq(vcpu))
-			kvm_make_request(KVM_REQ_GUEST_HYP_IRQ_PENDING, vcpu);
-
 		vgic_v3_flush_nested(vcpu);
 		return;
 	}
 
-	if (vcpu_has_nv(vcpu))
-		vgic_v3_nested_update_mi(vcpu);
-
 	DEBUG_SPINLOCK_BUG_ON(!irqs_disabled());
 
 	vgic_flush_state(vcpu);
-- 
2.47.3

