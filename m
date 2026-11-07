Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048580;
	b=kc2DxwCkUdJTZETGrgej6OMHMsxVQ63okuG0klStKgkmoOirkNyDeqPpbH9yoo9XcBAu
	 Oe1HK5TO5cFi10hKhxpVy72zwI47CFb6JQuQcB1z7ucvElMRu8dV6Ol0gOT12mSzBDwxI
	 O9FVZJ/Qao7OEzwbCQcEyUGCBH2j2NLer+0Xuax1hr5cDggZi+XGmc2skNzkTwTmxOr/r
	 uA3jcT0qjIPYD0rG3emo+OQVh/wnZ/aOl1lWgLUTCn3vhVXQZWSYUZ1rZVkFjIxkHlZQb
	 rn7Edon+WZ5kW/OHzQC18ui2jSxbiXC7sXPhZEedRDUj2gyapiE+9uh/EfYwbaUpzYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048580;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=b1hG5FXdfZy3JGujnCRymb8tWr756ZpynCLBMkSZGA8=;
	b=kF4ltjVrkwGki60l/FX2FNJdXRdgfwX0YUPOKLQDygI+kdL3k5xFPjgr1ahOu4FRucyB
	 +WB07hXwisL7n3PFDkt1bSmsC5rIivEm2BOI7J1ZZdzHksr48uaRq53UAuc8ecdmEY+dM
	 Jq2HlA3wRlYMyHXvBpucawjIg87MnOHvVQR6DQGHxLKy1YG8q+4zHqDczp042pbsVoR7a
	 uG2jLHtoVy7bMe+hzRwNoYAudzLcFi5G3cJ6cHc9iE/3KeKY8Lvw5f6LeNbg2lOwxBwKT
	 pR9nMSYzqzdoFexau1qfykUdG6DnwOtBkFbdASbo6PO+zCrmanPktMMv3wqQ5ubLrDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U0FDt01p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB766606EEBD
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U0FDt01p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5760B1F008A1;
	Sat,  7 Nov 2026 10:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048579;
	bh=b1hG5FXdfZy3JGujnCRymb8tWr756ZpynCLBMkSZGA8=;
	h=From:To:Cc:Subject:Date;
	b=U0FDt01p9PvMO6U18Phuirlut8F3r8oc+g3IflvRaMYdEKhb2RVnWFm2TxpF355al
	 BaOEN8FOjwJbCaanu0dD90vpRsGbKsx8VIqJ3QG7ijqqPcMMWiu/jjdYduJ5166eBQ
	 x2+pTwKG5nLTWip9UjP2tdQ1+vX96JTpk8DH2MnallX/25SLJkkIvi1JNxWZZxxhSq
	 FSheuUKwLJmhukHHDg0JXcRdwPyTCKbrRVVFGQZfikw0Czz1/xfrIYHmdiInZQ2se9
	 g9K1rW6xm+gXEo96dKbcnYvAdBk0fHS00gLDxPn7S1Gx2g8FCpwEfBBPUq0GcSdFu9
	 72gOBvpY1vqeg==
From: Sasha Levin <sashal@kernel.org>
To: maz@kernel.org,
	fuad.tabba@linux.dev
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: arm64: Move IN_GUEST_MODE ahead of state being loaded" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:49:38 -0500
Message-ID: <20261107054938-failed-6.1-22b6557ad05b@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 22b6557ad05bf05c73246f62c19af3e04017270e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054938-failed-6.1-22b6557ad05b@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 22b6557ad05bf05c73246f62c19af3e04017270e Mon Sep 17 00:00:00 2001
From: Marc Zyngier <maz@kernel.org>
Date: Thu, 15 Oct 2026 11:05:35 +0100
Subject: [PATCH] KVM: arm64: Move IN_GUEST_MODE ahead of state being loaded

IN_GUEST_MODE is advertised too late, when state has already been moved
onto CPU registers and cannot be observed by another CPU anymore.

Move the IN_GUEST_MODE publication ahead of the state being loaded, and
immediately check for pending request. This ensures that there is no
window of opportunity for another CPU to observe OUTSIDE_GUEST_MODE and
yet for state to be loaded.

This also simplifies the "state rollback", which solely amounts to
synchronising the timer when no irqchip is present.

Cc: stable@vger.kernel.org
Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
Tested-by: Fuad Tabba <fuad.tabba@linux.dev>
Link: https://patch.msgid.link/20261015100539.1011760-4-maz@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/arm.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 7ce9f3bfa7fff..cadc82ba5a5a0 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1321,31 +1321,33 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 
 		local_irq_disable();
 
-		kvm_vgic_flush_hwstate(vcpu);
-
-		kvm_pmu_update_vcpu_events(vcpu);
-
 		/*
 		 * Ensure we set mode to IN_GUEST_MODE after we disable
 		 * interrupts and before the final VCPU requests check.
 		 * See the comment in kvm_vcpu_exiting_guest_mode() and
 		 * Documentation/virt/kvm/vcpu-requests.rst
+		 *
+		 * Requests to self must be posted before this point, or
+		 * won't be taken into account until the next exit. No state
+		 * loading other than what happens at vcpu_load() time can
+		 * be done before we have checked for pending requests.
 		 */
 		smp_store_mb(vcpu->mode, IN_GUEST_MODE);
 
 		if (ret <= 0 || kvm_vcpu_exit_request(vcpu, &ret)) {
-			isb(); /* Ensure work in x_flush_hwstate is committed */
-			if (kvm_vcpu_has_pmu(vcpu))
-				kvm_pmu_sync_hwstate(vcpu);
 			if (unlikely(!irqchip_in_kernel(vcpu->kvm)))
 				kvm_timer_sync_user(vcpu);
-			kvm_vgic_sync_hwstate(vcpu);
 			smp_store_release(&vcpu->mode, OUTSIDE_GUEST_MODE);
 			local_irq_enable();
 			preempt_enable();
 			continue;
 		}
 
+		/* From here onwards, we are commited to entering the guest */
+		kvm_vgic_flush_hwstate(vcpu);
+
+		kvm_pmu_update_vcpu_events(vcpu);
+
 		kvm_arch_vcpu_ctxflush_fp(vcpu);
 
 		/**************************************************************
-- 
2.53.0




