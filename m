Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794330039;
	b=cVqUkGUY/q//y6dM60kZmG5qRmDPf37ozMelvYjv2wKx4N+R6jUfyFpamzq+SfODtcN4
	 clYe5BKCmINIPF+2wf9G9LdAqjgEZCY3/LHW2FchTy9baKdenSzVnU9WdvslMtSlrx/Zo
	 ndYLw9pjNS1Z1wpP3KIaMddLxP+sTmQ0o6tECNWeyTqQaJnYFuTPo8I2rg/ZMAtPTtcpu
	 kA7bXroPpgrmEt+JCrtJYPeHKdlSp/J0urflF9TpKzv1bolcg1NsL4+HT89xdA9huZNjk
	 fiUhBpgjomjd+2JM5pNNUn2yR4MpoBP9eNe0YYLLVZjM61bf7jXw+tOnSmGSTkl4drg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794330039;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kH3UcFmrwxkDGAeD2iWgxponZM8SAKQZP8HB8fctwzg=;
	b=TsBUS1Z3SzSO/9Rm28+/0QL5613iEJABdtS85pUYp7/nfruqkavQCLuVTaVkvZ/YzmnD
	 6rH+2eo+oSNDP6bwGCD52+45/W9qTKmhhHlES9SyZZsy/qdKEREugLXZYPgmr1tyZAkI9
	 VSCdAW1xGhJ2wNvb6lqCkk3//LdfQp7m2cvYzoi5tz7WZH7De2N+jzODy785KSz/WEBE9
	 BawMChlG0La5xIyHVBoi+Mf7iG+436NQ8QHnq5dY4n5Hyr+Isz177Gv0mM8mZHw3egzMO
	 o8dFHlGSRI956zBCoJOYPty8CveH+c2AmSMbsF4gWdoNo59UsMDSqhxKTBWoAohDFDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="V/gCCZbd";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22472606A338
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V/gCCZbd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C0D1F0089F;
	Tue, 10 Nov 2026 17:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794330038;
	bh=kH3UcFmrwxkDGAeD2iWgxponZM8SAKQZP8HB8fctwzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V/gCCZbdAtGk0WSSNw3NEq6n/nClPKkhtInJJUe0/9h6ytwu+1q/uqFt377R7dwIb
	 EO10sgvQ//I5bIy3cI/vteg2C85yMJ23A/lQV+dDFj7kUzRvWX1E5xR8SHJbOrAejA
	 vCCNYpT6M7crXQv9UG+JesOu3Ui560BeZagu2XMSWZ33wIh7U6r0x3hCf5/+l74poR
	 mL3Q5F5xTEIBcGQtbvvthDfQOd++Zd1ckjxsh9CBbBZHk6eCcOW/g8YbXTceuBC32F
	 /v1ompe9ri4mj8GBWvHYdwuJt3kuBvbHE1jsfy2iD5/B0VHiopYjZW3BoRE62HIwsQ
	 lLE8uDf6feFRA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] KVM: arm64: Move IN_GUEST_MODE ahead of state being loaded
Date: Tue, 10 Nov 2026 12:00:37 -0500
Message-ID: <20261110170016.2611406-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060646-failed-5.15-22b6557ad05b@kernel.org>
References: <20261107060646-failed-5.15-22b6557ad05b@kernel.org>
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
[ sashal: Omitted relocation of kvm_pmu_update_vcpu_events() because the helper is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kvm/arm.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 6bff7fd323872..a621dd31d9213 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -836,28 +836,31 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 
 		local_irq_disable();
 
-		kvm_vgic_flush_hwstate(vcpu);
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
 			if (static_branch_unlikely(&userspace_irqchip_in_use))
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
 		kvm_arm_setup_debug(vcpu);
 
 		/**************************************************************
-- 
2.53.0

