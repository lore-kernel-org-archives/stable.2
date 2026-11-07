Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049617;
	b=HXhHNjJZ/GydPAFa4dLyKL3BFxMfRMNNsiAlLc1jPfWMkEn29eFXxUNnNhXcx9Lx4YtF
	 vuRy/giFT7uY7H83TxlOcqRk8cEcOcIpfYEGLlKtyQBjDnjL65cJPBkpDhGAQCEVwyNva
	 qT50tU7P2iZ0d7d/cJtRW1+ur0rBGzAMYcZ3AFjsqNBhdbhH1Xexxhm9pBpF42c+fyqCP
	 590GFFABvdfXhEoeA/2KILc3LzcVYQIK/H3Tgm8/gq1ObSVXKcEGFtaHG+mFBuoP6esy3
	 NQ5s0K4ypw6u+pmlbQpyLqbrRpaXkbiY2meB/GeA04NDEK6rk1ingdl50GRY0IY9Gaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049617;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qzEeHwglDanh91FEeD2QbdHOWsO0QrgQFIsL6iUxVMo=;
	b=UYK32jQEhU8nd/K/4qwirDEtg6PJnzA6+Dq6Kv9B+A90ta2g9/601WMsSfOLanegBrJJ
	 l8K0dNzLqtWTtpn2hYr7n5bVqZPRMqfkH/sS54D1llIVWqnx7b22WX+bKsVLn5MvncLZo
	 zu9v6uD3RYKG9pn+f2OwjsOrsDwhibtng5j7YbfvVp0kVUFAEdyPpC25WqGfnIbeGHzBf
	 LmNoSHqM5LTFZBE7iq324NTao2ao9jhK2hUxiFUEmiM6H5yWJrsj+pHfeFA6DqBj4MspP
	 jt+/GDqDxe8B4hqaBUAN5ihe0T/VtpSOR75Qmb1TMGts4YMquDGfXyPmdOlyvwbx0bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TCfow0n4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6804A606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TCfow0n4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D8C1F0089F;
	Sat,  7 Nov 2026 11:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049617;
	bh=qzEeHwglDanh91FEeD2QbdHOWsO0QrgQFIsL6iUxVMo=;
	h=From:To:Cc:Subject:Date;
	b=TCfow0n4wKwJXccyPlZ/zV8UFkwO1TAZMR+os5y9o1O9wlIKUX1bTBqjVUObBNsrs
	 tGwBX+9/xWXnHRMudEUnBunf1tx9e3H3bbeg9nu88QSFAnDoE3FI07SnDS3ekIuJOs
	 dN4A4RGZtGaLR/9Q8BTT7g2ISpEJOyA2kJ2vK0NK8bBUsEacWBRgKrzIszhMcHn56F
	 uj9X2GMrdtgqnnKZrSjbxYBg7OVRNiftRJJ30qG9FcCpIK3BPxcJc46TyOSgFc+v4Y
	 bRrnu8mr732Uerzh+Q3eVmEVgVu7qn+xsh/+JqbgteAyXxTR+Y8eIEbjLcDvAhhVJz
	 0gtGheDGxvh2Q==
From: Sasha Levin <sashal@kernel.org>
To: maz@kernel.org,
	fuad.tabba@linux.dev
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: arm64: Turn vcpu->arch.pause into a counter" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:06:55 -0500
Message-ID: <20261107060655-failed-5.15-e64309198eda@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x e64309198eda29415a95113def92aa40196cd422
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060655-failed-5.15-e64309198eda@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From e64309198eda29415a95113def92aa40196cd422 Mon Sep 17 00:00:00 2001
From: Marc Zyngier <maz@kernel.org>
Date: Thu, 15 Oct 2026 11:05:36 +0100
Subject: [PATCH] KVM: arm64: Turn vcpu->arch.pause into a counter

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
---
 arch/arm64/include/asm/kvm_host.h |  7 +++----
 arch/arm64/kvm/arm.c              | 21 ++++++++++++---------
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index cd9b9d2462f96..9c068f27f9b8a 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -889,11 +889,10 @@ struct kvm_vcpu_arch {
 	/*
 	 * Don't run the guest (internal implementation need).
 	 *
-	 * Contrary to the flags above, this is set/cleared outside of
-	 * a vcpu context, and thus cannot be mixed with the flags
-	 * themselves (or the flag accesses need to be made atomic).
+	 * Contrary to the flags above, this is updated outside of
+	 * a vcpu context, and thus cannot be mixed with the flags.
 	 */
-	bool pause;
+	atomic_t pause;
 
 	/*
 	 * We maintain more than a single set of debug registers to support
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index cadc82ba5a5a0..9b773ab0b51d5 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -565,6 +565,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	kvm_arm_pvtime_vcpu_init(&vcpu->arch);
 
 	vcpu->arch.hw_mmu = &vcpu->kvm->arch.mmu;
+	atomic_set(&vcpu->arch.pause, 0);
 
 	/*
 	 * This vCPU may have been created after mpidr_data was initialized.
@@ -839,6 +840,11 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 	return ret;
 }
 
+static bool vcpu_can_run(struct kvm_vcpu *vcpu)
+{
+	return !kvm_arm_vcpu_stopped(vcpu) && !atomic_read(&vcpu->arch.pause);
+}
+
 /**
  * kvm_arch_vcpu_runnable - determine if the vcpu can be scheduled
  * @v:		The VCPU pointer
@@ -854,8 +860,7 @@ int kvm_arch_vcpu_runnable(struct kvm_vcpu *v)
 		      (kvm_timer_should_notify_user(v) ||
 		       kvm_pmu_should_notify_user(v)));
 
-	return ((irq_lines || kvm_vgic_vcpu_pending_irq(v))
-		&& !kvm_arm_vcpu_stopped(v) && !v->arch.pause);
+	return ((irq_lines || kvm_vgic_vcpu_pending_irq(v)) && vcpu_can_run(v));
 }
 
 bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu)
@@ -1018,7 +1023,7 @@ void kvm_arm_halt_guest(struct kvm *kvm)
 	struct kvm_vcpu *vcpu;
 
 	kvm_for_each_vcpu(i, vcpu, kvm)
-		vcpu->arch.pause = true;
+		atomic_inc(&vcpu->arch.pause);
 	kvm_make_all_cpus_request(kvm, KVM_REQ_SLEEP);
 }
 
@@ -1028,8 +1033,8 @@ void kvm_arm_resume_guest(struct kvm *kvm)
 	struct kvm_vcpu *vcpu;
 
 	kvm_for_each_vcpu(i, vcpu, kvm) {
-		vcpu->arch.pause = false;
-		__kvm_vcpu_wake_up(vcpu);
+		if (atomic_dec_and_test(&vcpu->arch.pause))
+			__kvm_vcpu_wake_up(vcpu);
 	}
 }
 
@@ -1037,11 +1042,9 @@ static void kvm_vcpu_sleep(struct kvm_vcpu *vcpu)
 {
 	struct rcuwait *wait = kvm_arch_vcpu_get_wait(vcpu);
 
-	rcuwait_wait_event(wait,
-			   (!kvm_arm_vcpu_stopped(vcpu)) && (!vcpu->arch.pause),
-			   TASK_INTERRUPTIBLE);
+	rcuwait_wait_event(wait, vcpu_can_run(vcpu), TASK_INTERRUPTIBLE);
 
-	if (kvm_arm_vcpu_stopped(vcpu) || vcpu->arch.pause) {
+	if (!vcpu_can_run(vcpu)) {
 		/* Awaken to handle a signal, request we sleep again later. */
 		kvm_make_request(KVM_REQ_SLEEP, vcpu);
 	}
-- 
2.53.0




