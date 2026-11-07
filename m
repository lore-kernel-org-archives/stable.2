Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047732;
	b=DHkttkwEQR69EgMnSNu70Q/PpOv11dlPbA0L38aalfdabpmJY1biBauN1x7ffPuelLyL
	 DB+AKePiKy7bCBruEgnL7bqd2UUWhJTFu/DRTtnbdONWZrJZDQLiGT2lILet1aAr2h26O
	 gj1n8bZqBe+XmPnnRobHl1d0yW8s6QlbL6hbqLdorx9MB98ZWvrEYuucPrlOAVtLPB9n8
	 H2yxEiQVG1AyvoBBz+kR6CHygfT9IK2i65XiUEeOLouoLI8zbNK2pPBsTnLnk0S9+u6CO
	 Q2V03DSWKPp0ahrnxayA3zuQ53M8giO6fCb+kn6J4aPFSGOPEeYgeFX7qk7FE+ZrcVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047732;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=6hfnLx0Rdy3tAJY8X0x2mjwyMvjI5R/hAYUCtZYk5qU=;
	b=FaSZpLd7Y+j/W7ZbZ2ouZkVqVsIjlU/oCkjz00yFBxHX13zsD9qerFypdXWIbIDLxXZT
	 /8iBWfdAtSu+Yy9dFgaAxAalXaA3Yt8nbNy0MvVIS8DKALRFuMT4oLafpBBA5FyFyWZl9
	 6YnVBg4tXJFXuOo7CKbiLG9QCfqtdCigN3UixMUiciXaHVQeaarrhH+hrDckl2+tRghoc
	 Xg/msYQJlBtMAzGSdXkvujHmYeOIszgEf21kZZ/MU8RGbhxgJniCA0krQSB5yo4PhEwlc
	 FhwaE5EjT+BzWPpOovpU/udYKfnk7zaGU51hk2gAsU62eVjsaiU/Yf4vW6yKzOShSZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="j9KO3/P7";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8593606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j9KO3/P7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5298E1F0089F;
	Sat,  7 Nov 2026 10:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047731;
	bh=6hfnLx0Rdy3tAJY8X0x2mjwyMvjI5R/hAYUCtZYk5qU=;
	h=From:To:Cc:Subject:Date;
	b=j9KO3/P7Yw5pTGdvxV1lLfk4LQ+AH26geFw/4wDqaCTsbrxx/+u+89Q/Ermi7/jNU
	 wj5/dBKNrce0M8lORwA0DCw2g7EIt7BlMP1vXnX2NUbi7pAVe3Kwm1bJWr/I7wRtrI
	 RyXFaQt1O6KHdr3Yz1QHzJ+jgfLJMPMkg3FM1UnF9AUUAVdF9+g0JMq4TXAGIMA4RT
	 M9hoMmh+YvCgCCOhoyR5qfrP6LsVuuK62wYtvw+D/BUNLZx9q5RadiiMZ5nQnC4I1A
	 97T6CXon4yUJFPHu6Ytlp/+uolvvR5bzyoSlHun6cEIKG2S6QjRImRqyjZK2/a5T2m
	 RudBAD6xSJswA==
From: Sasha Levin <sashal@kernel.org>
To: maz@kernel.org,
	fuad.tabba@linux.dev
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: arm64: nv: Move L2->L1 switch on interrupt early" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:35:30 -0500
Message-ID: <20261107053530-failed-6.6-21d3b33234eb@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 21d3b33234ebbb675c2a2a0fa7b12d2d83953d7a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053530-failed-6.6-21d3b33234eb@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




