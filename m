Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047736;
	b=HlMKKhGzAqVHWGMtPNJbPBiCFTSjwQKGboHFOAze3qcEiFXOkWEb+3w7V33XzyWK07fK
	 vihHkIdc9Zo71d/CRVd5xZDxxdWnmimiU2DP0BZQHFCufXwubfQhgqojARZpkjy/ou2Vf
	 699PmgIW5JkE/D+cmHUup+Mh/B7nPUU6NmB6nXa4U4I2ZfsyNkPlIsMWqy1YiyUxzDnQu
	 80UfsZPFT9/KfsR/ckjCOLhr5LwGVfyGefkXIfMRstOOkoo8jp0AKb1ywzFJZmpxfPwyn
	 uE5y/F6SYWJX72lVz9/adC3nu9hUF8lj+73s3lJppz/Hij2dwWvf6J4tgfaw5K44CjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047736;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=iao7xs7HFuiXIPcRFEo+g5tBLwQg1VYoJ6hpzJjiihA=;
	b=vns2w8o+CCuJEU7KxL198MlxcT38avl+52Lqm8t3As3xZJ2l9V+xtMaYWNJrvCKjo61R
	 Q6blXVRggj+ZRqO9ZiQiBbw/8GxdAf7qCJmPUWkuwqPh74A9TN4jmNBytumAYSYRP+S05
	 SaV8ASXBkPM4whdoGztBTIZ3MKkySBJWdlxKXeM665sUiGdhViowBv7EEw19ShvAEQCaV
	 AeB+CiYU7u190zPvjQnCU/5hEb4XZCMMQiCE8vYUvEoMci2GZsInn97Al1vT6Xxa6AfMJ
	 IzLVzGkgs8Bgr9UgU/DnRHZfdtdgJeLp9yaq7PfQEmiVTcqoibIMwC4R9d2klXxodJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LrjXfXp1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CD6606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LrjXfXp1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DBC31F0089F;
	Sat,  7 Nov 2026 10:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047736;
	bh=iao7xs7HFuiXIPcRFEo+g5tBLwQg1VYoJ6hpzJjiihA=;
	h=From:To:Cc:Subject:Date;
	b=LrjXfXp1YO7wWq1Zb1IgWAxxKTAfpTKfpPkNWR9kZwsooUwhppT3vdeU2/DsuWrtI
	 9m3Q+uJrqo3NIlSnD/4FA8jly5pEIpVX4Mr3bsz5YFA2tArRZo7ozDYJJXWYkrlc6y
	 LnTup1exmK5nWzdBWZDlNYpgNcuuuBhIboXaEtimB6rCQaqfmpJEntC9nQGND0Z4M5
	 tFHCrF1Y3OsC6uqavFxLlNsvpJWIxOaA+6xf5wYCAiFPtwnmEc0k65upybBaS+WOEn
	 B5m15+17tg8PVARvqQTQpU8HfOYtblZ1xg3nps3RVX1zT4tMX4z48+U9W0IEWvs9E+
	 bTwFpt0pXZRxQ==
From: Sasha Levin <sashal@kernel.org>
To: maz@kernel.org,
	fuad.tabba@linux.dev
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: arm64: Move IN_GUEST_MODE ahead of state being loaded" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:35:34 -0500
Message-ID: <20261107053534-failed-6.6-22b6557ad05b@kernel.org>
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
git cherry-pick -x 22b6557ad05bf05c73246f62c19af3e04017270e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053534-failed-6.6-22b6557ad05b@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




