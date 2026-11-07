Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046303;
	b=mHwGwmamLwa7QNCkBHOGlH9u7vCBXNNeWDL95SMmkPK9uE+sDk6v951UA/DuO5aSh4E1
	 3ZhaQ3j0DrnuAfOJJARu3YaNFsHuIEay1mjFJpbxIzdhpOClFRJD6Ar99myuL2Fcruypb
	 E4QJYffnijE61gJbCeALzuUKsaob0OMzg2gBbnh8Z4NIj+W4l9Nol1JjVagX+/dMK1Qsf
	 lG7AwockgDxDkC95sCDj4bLAjUfe6i6Df+Aey49kKmu7Rw4X7gjsgsSEsiBJeGAWu5eHC
	 JULgAoS/qVkQuTAg9AW/Giam7K5QPVG/VUDwcYK/E951DwEFKcG90LRhYFNXOfG+rxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046303;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=gMwUsGvRiU2rxNT/DHvty97w/4NwuZb1lhCGh3+zRdQ=;
	b=J2F3mbNMr230tdYwZUZKlPS2q2EeY3MOnkSieHTYc1KCvdrA3zYvhfDIoA84Z39lhk/R
	 MW8yujuLTxMsBChhqNqrZDsr8Z7DMTXIZgID/GYfnch1TYJe9jvC9uOvyE3Znhstfw9xG
	 zKgquXItotL2EGGjvniEiW0T71d2BTUJ1Tmh/hhVSYbYGYCSiFPlnoYGjIYOTi2axkSL5
	 pPJgDDZ/7niOny583dhPL5yiUZtDxUzr0Psmm9yfQ9AVRwR6BIo8xhmHiNRK3FJN9Fr/z
	 wB7WjIcucl5gTyEA5T459EgQhe+oFEsiBNQjMmZOtFbrMbedQ+Skl0/U33UQeXPfOkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fxIGe+os;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD22B606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fxIGe+os
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099831F0089F;
	Sat,  7 Nov 2026 10:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046302;
	bh=gMwUsGvRiU2rxNT/DHvty97w/4NwuZb1lhCGh3+zRdQ=;
	h=From:To:Cc:Subject:Date;
	b=fxIGe+osUxnhjjRFCIZe87G5Pz5xm5XBz+wAr/4iPeBa5YpcNmIpOXUz6CYRq1bS0
	 MfQ/fBofkRcIs+5Ba7I3k4CJGc8vHDg4niQ43TrxJOMuAntR3nhl5QOjGbBruhlUTM
	 iWVJ6INZE8eTCLTyUFKsq409+x67rb1fX0AQqft9VSt41KSJm6sdM01A3wiW52EI3f
	 eFFyWeVHdaDl3hFKgb8BYvWdUa7AWd14fLDj5+tlX5ndi2DPClkiTNJUliuAUL5MwW
	 PB2pIUee14aAHQiJGTlgzB2ZBfMIyB6oTYJZ+0qee9wO7uDfBu6JssG/zvsisEgEhK
	 XGFlaaQspHLAQ==
From: Sasha Levin <sashal@kernel.org>
To: maz@kernel.org,
	fuad.tabba@linux.dev
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: arm64: nv: Move L2->L1 switch on interrupt early" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:11:41 -0500
Message-ID: <20261107051141-failed-6.18-21d3b33234eb@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 21d3b33234ebbb675c2a2a0fa7b12d2d83953d7a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051141-failed-6.18-21d3b33234eb@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 21d3b33234ebbb675c2a2a0fa7b12d2d83953d7a Mon Sep 17 00:00:00 2001
From: Marc Zyngier <maz@kernel.org>
Date: Thu, 15 Oct 2026 11:05:33 +0100
Subject: [PATCH] KVM: arm64: nv: Move L2->L1 switch on interrupt early

NV request generation to switch from L2 to L1 on interrupt is buried
into the vgic flush code, while we should be able to deliver requests
as early as possible.

Similarly, MI generation happens *after* the need for a request has been
evaluated, which means we potentially delay the maintenance interrupt by
a full exit/entry cycle.

Move these two things to happen much earlier in the entry code, and make
sure the MI generation and PMU interrupt serve as input to the request
switching back from L2 to L1.

Cc: stable@vger.kernel.org
Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
Tested-by: Fuad Tabba <fuad.tabba@linux.dev>
Link: https://patch.msgid.link/20261015100539.1011760-2-maz@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
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
2.53.0




