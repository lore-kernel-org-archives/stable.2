Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794419042;
	b=R5Tr9xTUzYAb2KmqeiiyDDoIgz+nTcxCfA9ZFmi+R4lftZpWbQucLAQZgDVIL5Yx2kJF
	 oMF8ksjePUmsCmmSnBi28ajhAXPa5VvjMQP8S8vVQi0LvLzXQkiWt0N1Dpamb8k1UpgSJ
	 VubGT+G7BD+sCxXXr3eWh7XbEJeJRGUkAwCjEnxdRzo/q6EEZihlpJ+3i7k/qtTsfYmSV
	 HjwxetpGmx1425usqGw2USRIIzqQ/48Tyk8URODFHYTinmrbHzFinz24RbMzX6RmwX4KX
	 ZJhyhD7v7ooBUJVVif4FP6ElZwVYRNDysPr6BTayJ4lrme2qQidQmDQ/kMLZTW7TbtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419042;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ueFX5CI3G7Wd955i94T1keyzaDfcOPXFWwjMvFohilc=;
	b=FEEuZcbUyGjgJle90QxTG63bD4YqcX/NPxH5Pr5VolTa9wbOD4PzucsAW7mp//2Apfz/
	 VoocVfIhGyQMryl8hQRAcy+JOnq0vENkyBckZQ2aFHIegraEpEm+HCNTmrgfZD9OI/KX2
	 UUE5pNfWxE+3WCuyftsWEVwdLOvuIfRsPvxPpmIgrgskM62DvfMqcnfIBTkrTHGYkyCAs
	 tykJtxlVeyt1DYt2qfc/V2U+6vcQwmm22cTdLOltwfogv8YEZ5i/Xpl26NZitedM+RXy8
	 lkWN8AlKWccRaGbXwxwn4juKx/4wi/BicBRp0ErCpEiJFRbAfILHFy0HeJ4ye/lbISg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M1QYGIAl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8951F606A89B
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M1QYGIAl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7FF01F00A11;
	Wed, 11 Nov 2026 17:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794419042;
	bh=ueFX5CI3G7Wd955i94T1keyzaDfcOPXFWwjMvFohilc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M1QYGIAleDPvw5We0FpEO2teVVVtAxba8KPU3bLJlO9eI+ztB/m5YIZj6Q66SBHJp
	 zvDTjvi5LTkANdhu1ahGn+KOdoBKmoHWzbmKjAoPU2BTAjw/T3Seu3vPzHJZ/IJ8SB
	 TEoss1Syl2SRyI7rOdoOaXSvCwujoGrUAxKNMsFaZSy7v6p/xzrkSVHx/2MU8hRf+V
	 YJ5Vhxh6Emid+ZobRFHHgN7VjplYI1ZXNUkwWQ5c075yqmoVgZxWmhq603Rxjqvj2q
	 FIuai4D50lvgWuBrsEE5qhxD3iBXqJxVDl9lOUUk6mpVm8nj9TNeLnK8BUGgEZ7/NB
	 CfYyy4pcpF3xQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] KVM: arm64: Turn vcpu->arch.pause into a counter
Date: Wed, 11 Nov 2026 12:44:00 -0500
Message-ID: <20261111174337.3633257-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060655-failed-5.15-e64309198eda@kernel.org>
References: <20261107060655-failed-5.15-e64309198eda@kernel.org>
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
[ sashal: Inlined vcpu_can_run() checks using power_off while retaining vcpu_req_sleep() and rcuwait_wake_up(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h |  2 +-
 arch/arm64/kvm/arm.c              | 13 +++++++------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 6d7b6b5d076d4..660d8ef766796 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -368,7 +368,7 @@ struct kvm_vcpu_arch {
 	bool power_off;
 
 	/* Don't run the guest (internal implementation need) */
-	bool pause;
+	atomic_t pause;
 
 	/* Cache some mmu pages needed inside spinlock regions */
 	struct kvm_mmu_memory_cache mmu_page_cache;
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 6bff7fd323872..0ef2b4a2b5f1a 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -336,6 +336,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	kvm_arm_pvtime_vcpu_init(&vcpu->arch);
 
 	vcpu->arch.hw_mmu = &vcpu->kvm->arch.mmu;
+	atomic_set(&vcpu->arch.pause, 0);
 
 	err = kvm_vgic_vcpu_init(vcpu);
 	if (err)
@@ -496,7 +497,7 @@ int kvm_arch_vcpu_runnable(struct kvm_vcpu *v)
 {
 	bool irq_lines = *vcpu_hcr(v) & (HCR_VI | HCR_VF);
 	return ((irq_lines || kvm_vgic_vcpu_pending_irq(v))
-		&& !v->arch.power_off && !v->arch.pause);
+		&& !v->arch.power_off && !atomic_read(&v->arch.pause));
 }
 
 bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu)
@@ -636,7 +637,7 @@ void kvm_arm_halt_guest(struct kvm *kvm)
 	struct kvm_vcpu *vcpu;
 
 	kvm_for_each_vcpu(i, vcpu, kvm)
-		vcpu->arch.pause = true;
+		atomic_inc(&vcpu->arch.pause);
 	kvm_make_all_cpus_request(kvm, KVM_REQ_SLEEP);
 }
 
@@ -646,8 +647,8 @@ void kvm_arm_resume_guest(struct kvm *kvm)
 	struct kvm_vcpu *vcpu;
 
 	kvm_for_each_vcpu(i, vcpu, kvm) {
-		vcpu->arch.pause = false;
-		rcuwait_wake_up(kvm_arch_vcpu_get_wait(vcpu));
+		if (atomic_dec_and_test(&vcpu->arch.pause))
+			rcuwait_wake_up(kvm_arch_vcpu_get_wait(vcpu));
 	}
 }
 
@@ -656,10 +657,10 @@ static void vcpu_req_sleep(struct kvm_vcpu *vcpu)
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

