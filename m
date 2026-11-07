Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050626;
	b=3jvzw7fZvzWoqwO5rMM5HuyyyGukRS18NIw+WRCieHbZYTG7ng2Xb7Go7SS9DFuCkT5J
	 vJoBQectzDbF2NVWN4mZyz6GnPSkWiN07o5irKzyu2Sd6+/eaTsl92NYFmdOIMr/8Ty9V
	 Wm/SGGscku0iWADVCyeHepbYALHLqkKLvTdJrigvnThR2RcjNON9DsVM3H5UaRNP915t3
	 DD6k0tB76WCw7ojNb1n8Rruz6q/7BYnMNsAuABD8wZ7PoeICDxP0Dx1iY6kqc6XxZPpuM
	 4u8rLauA+me5Wnj8/0MI4qUK/zf5d0Vth5uONcg9hxJbvUdV0Snl5N7NWDFcbB7Dsww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050626;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=zNHRFK0pXDSCzUVrFZ5fICwae79Yru4uGe+Bm8Ldx30=;
	b=oAqwBMa/zLU4TbPxKSuEoYzfp16p2L+KLzjVWwllbZViFVMwPSzdpRMZk+kACPJ7m5FD
	 qMQqn9SimiWalsA9H6Dw+bMYIor0aYShvQYpRBkuEKje/AQw+ZeKt6KqFFLK7IvKhV3Pt
	 Cco8WQbMKhogoexVzgo8c8UG9AyXkm9i6tmrxdQNUDhDi6cyDD9qeEavWUbPVqjAZ50M+
	 88LCn8pcWEk2C7ynLZjnnCsv0I3WJonXEIqGYGhWu9fgN0D/AmG2jJvNfhScaRa63Tt9x
	 7c20jUIT7n/RHeH0oedcl88xHPZ89keg4xvRhwNbEpTouXj34RFfRYUevzn0FRpdrog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EBh3VHvT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67776606A336
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EBh3VHvT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99071F008A6;
	Sat,  7 Nov 2026 11:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050626;
	bh=zNHRFK0pXDSCzUVrFZ5fICwae79Yru4uGe+Bm8Ldx30=;
	h=From:To:Cc:Subject:Date;
	b=EBh3VHvTkSDcELva6xwyUxBewwtui1yj9LnCHCegAODONxGfXnBbpF1spN9/At6Ti
	 pZQp/UYDzaiCEfSvUh1wu4NToBY1NFryQ4GOFXXtDJkIqqD1M9MOuhtcHppUEXFTp+
	 h96MFTTCmoePf6h6HceMBJ14/tPl1YEDaAOD5WxBzYSOJcXBkKuveadBzp6jQ1EZUm
	 469lWYHDL9huHiJVIc7vERJJm/90DePghl/qRUIFs981Nl513P9G5C3l9rDxPD9EPn
	 95IROcgg57LYJ5fNGnwDMmqg6C2k9ZywKuRfF52XRmxlbcbIM6jHW6ix4G+ndgEuw7
	 sK3Hmozkv4RWg==
From: Sasha Levin <sashal@kernel.org>
To: maz@kernel.org,
	fuad.tabba@linux.dev
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: arm64: Move IN_GUEST_MODE ahead of state being loaded" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:23:44 -0500
Message-ID: <20261107062344-failed-5.10-22b6557ad05b@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 22b6557ad05bf05c73246f62c19af3e04017270e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062344-failed-5.10-22b6557ad05b@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




