Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794330901;
	b=vpnRGcO7iVD+dIDRIpcned3Vcb2xCK5T+EyuB2d5GpO440n8Q4L4PrXj0Yp2kSwvfFxs
	 9hUiJWKWLQVenJ6gJ7ULKP3qfAEHNbnucWe769gELabHOODdZRDhbcWHKwtCMjg/oLKCD
	 600CthMUp9oi7//hfIF8GonguCdCSFQWHCjNwF/ZcaIi15Qx+TPe1StIaapbntyEMTnKL
	 g/7fflAH6/97it65smesNwpaWkCmRNrXsjpA49x6nKnaqu0azb46qnFyo2PbX7ojbirvC
	 POLDJ5HxnYI4E1zxaMUHxeymQKEXfapRvQ57pQ50Hwb40Y8ddXPkqQqUH07BoGmJHaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794330901;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=EFfRqSHE31Zeqw/gRV+ghlc1mWVDiA4w5gqX0LAKKWg=;
	b=qgMODWbuZEYiQ/yQzdUbVe8K9RcFdE5b21Te+M+3iakpReFUA9hK/rn77tZG4M0KggFJ
	 wnnpmIC71zOy0XY6y39ZHZ5frWz30ZrYJNJM6t/670+1+qwsRM4wEwHeEesmJj6FEJ4/e
	 YrNKgpjPKYZhsy13aw+6d3E8542ApJMfFlfHtu6PPyebrI7l2qGWWtaOlFAPo7C7SnYA6
	 eq85NprAkw57LcKmoABbHRGWnhmYAb3mTEusZ3b14pdYa2W8cMKewbfuDEaahqLxRGQSB
	 vwAZRHFGmcf5U5sf29siVye03ZbYj9EOFTrfiV1rAScioUdFVzegaDgbPOcrBmiXn6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j71NyCX4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693B2606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j71NyCX4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68921F0089F;
	Tue, 10 Nov 2026 17:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794330901;
	bh=EFfRqSHE31Zeqw/gRV+ghlc1mWVDiA4w5gqX0LAKKWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j71NyCX4tj4QHMhoN+16w37w+RB2Zu7fqAN2r/EbcDWyhMZGqPBkHfFY+M8JgBUbt
	 rJjj1okA6SyjwGRNVdQEKxRk3i/69pWtvQBbtDO6iX+k2IXXDrFjnshsT09ye03t+M
	 9KtYHAR1YxW/24gatNfkXsyTzVhNmblwziqezY85BUtxQwuBfcsET48b20Bx3Iqduv
	 m9VczZpvAcSd2gTKZch/32cJ2iPgp6FCJ6fEdWrDeej7bXOV+AK/+FBLn2Vb/8OLIi
	 TCL0/OCld7HHK01yfDWQOVmNAWROypQV6QR+RamL2+4fmMdKF7Huc4pBz9/wx3jolU
	 90RbBChAqpf0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] KVM: arm64: Move IN_GUEST_MODE ahead of state being loaded
Date: Tue, 10 Nov 2026 12:14:58 -0500
Message-ID: <20261110171430.2677289-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062344-failed-5.10-22b6557ad05b@kernel.org>
References: <20261107062344-failed-5.10-22b6557ad05b@kernel.org>
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
[ sashal: adapted guest-entry changes to existing inline exit checks instead of kvm_vcpu_exit_request() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kvm/arm.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 528229636c635..ccf31a749c827 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -716,8 +716,6 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 
 		local_irq_disable();
 
-		kvm_vgic_flush_hwstate(vcpu);
-
 		/*
 		 * Exit if we have a signal pending so that we can deliver the
 		 * signal to user space.
@@ -747,22 +745,27 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
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
 
 		if (ret <= 0 || need_new_vmid_gen(&vcpu->arch.hw_mmu->vmid) ||
 		    kvm_request_pending(vcpu)) {
 			vcpu->mode = OUTSIDE_GUEST_MODE;
-			isb(); /* Ensure work in x_flush_hwstate is committed */
-			kvm_pmu_sync_hwstate(vcpu);
 			if (static_branch_unlikely(&userspace_irqchip_in_use))
 				kvm_timer_sync_user(vcpu);
-			kvm_vgic_sync_hwstate(vcpu);
 			local_irq_enable();
 			preempt_enable();
 			continue;
 		}
 
+		/* From here onwards, we are commited to entering the guest */
+		kvm_vgic_flush_hwstate(vcpu);
+
 		kvm_arm_setup_debug(vcpu);
 
 		/**************************************************************
-- 
2.53.0

