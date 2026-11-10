Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329017;
	b=X9fpEffsQ/B6YkUO5bANtQb/lBODx6vr82YKEGI6WFLsf2JHElYN0S6oAy2AgGsKOSOW
	 gmjrQlnAxt2cSgivFJD6pQxZcmDzJI6AzRsHN1Ptq20C/B8c/dBB59T2Y/BxCUT4CKWvA
	 m7livkavZI4Ih6uaAi09bFvxwO5ffB60VmXv7LsccSS3grrLGFwfeYGntZOLO4aogd7fJ
	 giSas/PIww9UB++FOyR1UjayNMRKgb/lYx3akpWLN/dQp7dRUDW14z74wKITffuoq5rlB
	 VYC5LtyTbCm7HbaewMHbd5AtiHsws0r8RPfpppa4dyXfl/PdXS2x5GRUP3OCKG5R0zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329017;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Uhz4k9MadkybbPi374wW2VEWRpp86Ne1tbqn9UaXAAQ=;
	b=fi9wveK1WMDo6iY8yd9W7+fUDBnCT9wELTErSpJg78gHI2+DiiZ7dZNyqMbqmO2luHBC
	 jTaN9LjOArPOD3MMgrCiN+xlC7C4LWpRuQqtcIZtLOByCnAcYaRAHD5Aq/+/l5LoqguWm
	 7bCPkxSpxtj5lOfMjPpyn9HBsA7dLZCeI5JawnZzATfKi7xJxRy6/A8Z4yuaxOT1HyRAd
	 t8yw0d+IV9QusutiQLKwjYu82L1xc8QimJb4TxFzNTsycGmFZDPdjMvgRm6O9cq27fHF2
	 tNbVGOf3Z3LdcjTceBqmRRpHngYo2Lj3sUCPCjrJfbZu9VPRKRO0HbCgttpGnaZtBrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="FI85/zQb";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ADA606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FI85/zQb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 057841F0089F;
	Tue, 10 Nov 2026 16:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794329016;
	bh=Uhz4k9MadkybbPi374wW2VEWRpp86Ne1tbqn9UaXAAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FI85/zQb+s1rdkXJPCH99ePEmbfIoDUHd0FHYv6QBR2Yax/AC89ZqgBYlFD077GVc
	 m4SWDjyl9TvT4jOvdvuuM6++z9xAhnDT3ZCvb7Q+lsejA+j0vuiZldavFomSYzrW6n
	 nYLhI6EO6H3RpiRqCrvJelDMZD02awSdLRUNwaNdDdYFUcmEOZlOUURLsfo0OQ3BJj
	 diJ8vruo8OHmtl/3cY7DXzzHuagXmlek492E8B09lr+ACJyv4Jd8FwrI+4l81D2nMr
	 60oDjDSZAT6lVWQR2ae9YHJcuVWPyKE+h1iaFRG2TLCE9wV+V+R28EWdsIHtLfBGIG
	 SwhAYEFeWlUtg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] KVM: arm64: Move IN_GUEST_MODE ahead of state being loaded
Date: Tue, 10 Nov 2026 11:43:34 -0500
Message-ID: <20261110164314.2560466-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053534-failed-6.6-22b6557ad05b@kernel.org>
References: <20261107053534-failed-6.6-22b6557ad05b@kernel.org>
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
[ sashal: adapted removal of kvm_pmu_sync_hwstate() to the existing unconditional call ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kvm/arm.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 7b7afea4c5363..9ff2984d203fe 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -959,30 +959,33 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 
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

