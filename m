Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794419388;
	b=jipiOI62eWx57EliSA7uAwzjD5uTrJ9361GlzTPl5yDpYrHvd19r0+O6QhCiNG/XRndZ
	 hkSnkQrhnY/wWsnvgcQJaVLCpDZdNOoYr8nMMI+1F7woy8wgY0q9KMpU/htbeUUx10a4p
	 t+cAHHVoUAJt/67rgnq6b6far2dylDatJOIMYyBpbQdDmG2vPHdtOpsFVnK37lCGBmmqq
	 RTlCq8HzZgkHqa4X3dDhiqG20cewid+iyRopY+oLYF59hqqGoEmy20n/LYEbSg7hCuZtE
	 u0k/6JvzwMjtGbj9c0hvWrtV1Noh7PIF8wEh21lcKAmq+TEDvJiNHZPlv/gQ8cswcKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419388;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=urTcQ13koFRYQxvx3+1awm06YxW2thycTA5i5g41OAM=;
	b=h1NEyJFjtThZ2GBKhgADVbUdGI4ISMlVhVIi3cY9As6O6j3xdSzV0T5qZvlX19AE73DI
	 2jx7QerAnNm+m4IXkkKdja/w3QXoN4FZlGnAFarJJsP+MbwTqg4fAPrEUpzBZ8CbiMXHM
	 8+UyHDiXVlaLny5t5cZ32AUqdvFVBCTKmq/+4E/OSAhzkNgN9hOZQ/WNFJorky1nlaCDL
	 hv0/5jgdHtouaxgZ97MH+MV61FLsKyWljieB48CHgOFsgT1lq4j8tufvf5H5xCXGXOj0X
	 4vAFM+asdWvzkx2iZ2UHa2JMtfeGUSn8kQakLgkcTzBm8UfxZ1uvcq3coqdweXRjVTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AvykjvDP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB10A606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AvykjvDP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03261F00A05;
	Wed, 11 Nov 2026 17:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794419388;
	bh=urTcQ13koFRYQxvx3+1awm06YxW2thycTA5i5g41OAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AvykjvDP7khYfxNnSgRD2M62/HYDnU4Hi4ZTzETG7W1HzkmssxSEzHVB4OxAsTrKH
	 1TACf7S0jX7Za2Gh/NBmv8APIbwzhUBmr4SfFRodqZAtAseVVWDSEM5csEZcdP9U47
	 /KQJes7otJtOuAi8ZW4fmf00QvruPyZkFarGawSA4HwN0rLUsevn8unZEjWuhwlGxR
	 2cAHI4JsDsMdLBUEhQ3cj6EQ/FEvG2Vs6D7tym85gNY0vM09/R79knjXgUci2XUiWF
	 fOeEP5XAiew3v6+nzArPNhdewz7OcNlrlQn//xaOSvXAS6DkjGSTkNLfeN9Xpaigf8
	 WbJfLhQGseLXQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] KVM: arm64: Turn vcpu->arch.pause into a counter
Date: Wed, 11 Nov 2026 12:49:46 -0500
Message-ID: <20261111174927.3663842-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062353-failed-5.10-e64309198eda@kernel.org>
References: <20261107062353-failed-5.10-e64309198eda@kernel.org>
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

[ Upstream commit e64309198eda29415a95113def92aa40196cd422 ]

We have situations where we can call kvm_arm_halt_guest() without
holding config_lock, which means that halt and resume can overlap in
funny ways when called from separate contexts, and result in situations
where a vcpu is resumed while other parts of KVM assume it is halted.
Consequences are left to the imagination of the reader.

Fix this sorry situation by turning kvm_vcpu_arch::pause into an
atomic counter, which makes the races described above harmless.

Fixes: 3b92830ad41b2 ("KVM: arm/arm64: implement kvm_arm_[halt,resume]_guest")
Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
Tested-by: Fuad Tabba <fuad.tabba@linux.dev>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261015100539.1011760-5-maz@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
[ sashal: adapted pause handling to existing power_off checks and vcpu_req_sleep(), retaining direct rcuwait_wake_up() calls ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h |  2 +-
 arch/arm64/kvm/arm.c              | 13 +++++++------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 48ee1fe3aca40..16062b15131cf 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -354,7 +354,7 @@ struct kvm_vcpu_arch {
 	bool power_off;
 
 	/* Don't run the guest (internal implementation need) */
-	bool pause;
+	atomic_t pause;
 
 	/* Cache some mmu pages needed inside spinlock regions */
 	struct kvm_mmu_memory_cache mmu_page_cache;
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 528229636c635..198141e2ecfc8 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -289,6 +289,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	kvm_arm_pvtime_vcpu_init(&vcpu->arch);
 
 	vcpu->arch.hw_mmu = &vcpu->kvm->arch.mmu;
+	atomic_set(&vcpu->arch.pause, 0);
 
 	err = kvm_vgic_vcpu_init(vcpu);
 	if (err)
@@ -447,7 +448,7 @@ int kvm_arch_vcpu_runnable(struct kvm_vcpu *v)
 {
 	bool irq_lines = *vcpu_hcr(v) & (HCR_VI | HCR_VF);
 	return ((irq_lines || kvm_vgic_vcpu_pending_irq(v))
-		&& !v->arch.power_off && !v->arch.pause);
+		&& !v->arch.power_off && !atomic_read(&v->arch.pause));
 }
 
 bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu)
@@ -589,7 +590,7 @@ void kvm_arm_halt_guest(struct kvm *kvm)
 	struct kvm_vcpu *vcpu;
 
 	kvm_for_each_vcpu(i, vcpu, kvm)
-		vcpu->arch.pause = true;
+		atomic_inc(&vcpu->arch.pause);
 	kvm_make_all_cpus_request(kvm, KVM_REQ_SLEEP);
 }
 
@@ -599,8 +600,8 @@ void kvm_arm_resume_guest(struct kvm *kvm)
 	struct kvm_vcpu *vcpu;
 
 	kvm_for_each_vcpu(i, vcpu, kvm) {
-		vcpu->arch.pause = false;
-		rcuwait_wake_up(kvm_arch_vcpu_get_wait(vcpu));
+		if (atomic_dec_and_test(&vcpu->arch.pause))
+			rcuwait_wake_up(kvm_arch_vcpu_get_wait(vcpu));
 	}
 }
 
@@ -609,10 +610,10 @@ static void vcpu_req_sleep(struct kvm_vcpu *vcpu)
 	struct rcuwait *wait = kvm_arch_vcpu_get_wait(vcpu);
 
 	rcuwait_wait_event(wait,
-			   (!vcpu->arch.power_off) &&(!vcpu->arch.pause),
+			   !vcpu->arch.power_off && !atomic_read(&vcpu->arch.pause),
 			   TASK_INTERRUPTIBLE);
 
-	if (vcpu->arch.power_off || vcpu->arch.pause) {
+	if (vcpu->arch.power_off || atomic_read(&vcpu->arch.pause)) {
 		/* Awaken to handle a signal, request we sleep again later. */
 		kvm_make_request(KVM_REQ_SLEEP, vcpu);
 	}
-- 
2.53.0

