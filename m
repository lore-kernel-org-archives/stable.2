Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328564;
	b=kcMUJ/4lWFBO18bGmGG9VN98dGKE2WCXQsovqKoqCHPkqYexwacD7yFlul/sMyisCwEV
	 S762KGZPMNxtEFjVcLTo1vFSsJgSsLP1Cw1Hdhwn2UTT1m5gZ9sfeDC2rPjq0ECg4dqTu
	 u6hanETmghR/1fdFLNTfKGIWnokgfr6QVpJst7z4Tj+TKzkeZBuGdHxpFW9OTzqeV18eg
	 zZuLOl+vB0iO69jOPRAIOFxHn/kQDCPQdvswLGTk2+3TvE1ieyvNfD90niP7WphUg/Apn
	 vpnntrNdgwSyOgbzJPeXnpNlt1iUJiIofVNY1z5g3/8vrUsyagfI5AjLqKiNIta9r5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328564;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MK53w9PpDF12ayqCGC0aKiYDOLagydGxF8v5YqG4HzI=;
	b=csKV5DWTI2YW3vxFqCO7gRybhpVV6f7+2OqfX0Nk2mekMQ67Ivxn940cd1exmt2J5yag
	 g4bOZVp6clDzyv0lAN9MsBrq8aosdQ9lBPpSHz8LK74wAYS9IUjlB0yKE9ELAsliqkmK8
	 FkKPRlYt439uqEFofKqy12tfEy0Z5yhv2kuedJBkUir+LI+G1Spp9SESb+6/M81NwjkB/
	 Qr6lEkxpPrLT2DP7vu7T6UBTwrhhoWug1i3BC/88jDaldjeNDmpqF9hodH50+5SzLktt8
	 lPTX6JUGmhFYgT79HJdK1rg14Y2EmC/+nbegp0/9eWNnyk6dgT/vWsrPRVpo+HqbuAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PCDxJdtn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC69F606A211
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PCDxJdtn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241781F008BD;
	Tue, 10 Nov 2026 16:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794328563;
	bh=MK53w9PpDF12ayqCGC0aKiYDOLagydGxF8v5YqG4HzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PCDxJdtnVr+Oc02M9NYi7nNv+qgLU2MNm68oABewR/1pkdho3THEAO+QLSgH1tNOM
	 FAIG4xD7l3F+I/slQbah1lgO/7xBQk/0LSxQJLAC6bRvuULubGqW7HzQSbwRlkOn7E
	 YQkwuRQ2AkS7y64kU4dhqX5XJOtLtvi870irNX5itxABaNPm9eP7QfkYMcI+ZCC2mY
	 PM2W7Afg3VW4zzxnOyzLGwuYoxyWSUmLYnjdKMabIVQ2474WLCLvx2IvUWZbCqOIJP
	 dtKnThXHXDRBy+BocgCIkPF9yFITlWFJfYFee1lbEcieDdeMfZqShw78VrCJHOLyL9
	 dwLOvNm4LDvNQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] KVM: arm64: Move IN_GUEST_MODE ahead of state being loaded
Date: Tue, 10 Nov 2026 11:36:01 -0500
Message-ID: <20261110163541.2510284-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052258-failed-6.12-22b6557ad05b@kernel.org>
References: <20261107052258-failed-6.12-22b6557ad05b@kernel.org>
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

From: Marc Zyngier <maz@kernel.org>

[ Upstream commit 22b6557ad05bf05c73246f62c19af3e04017270e ]

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
[ sashal: Adapted PMU synchronization removal to an unconditional call while preserving kvm_arm_setup_debug() in the guest-entry loop. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kvm/arm.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 97d993f52b575..ec59faa70f97e 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1189,30 +1189,33 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 
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
-			kvm_pmu_sync_hwstate(vcpu);
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
 		kvm_arm_setup_debug(vcpu);
 		kvm_arch_vcpu_ctxflush_fp(vcpu);
 
-- 
2.53.0

