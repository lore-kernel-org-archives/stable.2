Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050635;
	b=0FOP7R4WPioQ2r5MJVzA8faTqWdZvTDhfTP/jsL9fQttsBl2e88A8OXOHtPC4JnVDOdf
	 4TGiq9Jx8AT02VSDTKLh2Ye8vLWRP7SCBSJ/mPTPzkYPRIL3AVjdI29LTazSA3jveroU2
	 K82z8+ZcjkryFL/L/U7wSmszAjt1Acevuh9cJK10s6CONZ5S9vvOmR92WO7ZsNGZWdCCs
	 M91sKECCO4Yy9A7bjDEqxvlYjjk+fNriB5uD5m2sSiBjrV7JJY2DMRQbq5IB7aghtVssD
	 Ar8rK3Zko+L0lxCUIwhb87AKK6jg07u2vXDOwybAQbO+6GVqvGDFVVml+Vh1EZsMzCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050635;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=q8LTY47VvNfe2YDljxue8O15BYEYJmIII3XQ/yG4rt0=;
	b=nN+GES2zz71WQ3mxjBWTeLlgYITowd9l7yn5oj8wtIcC7w8bBMJzfI89lu8JLzSoCtGt
	 C/2HWXq48Lthiw/BufUC6p7rmfIs7g5QMQpYc5Ah+iAEc6jaUZtlUdp58rGJXKs599/nl
	 jNg0AWJKztwMpxx89DWKFkpucLse91NNvwzwrFBoSSxJSiRChBkFzs0g+LCmRmYuy4v5t
	 AvCYzHSQu5mkmSkOUf8+RgB1vWnyZZ/xGeQRoTWvPH5j+G90pX8TlxARL8xL32XBuIZlx
	 Qjv4XvGbfOPIhzvAgjaLqS2FbOz0WopbU6JEWEX6LcqjEfI54nNhZBr4mbp+Ghp8jsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Smy675qN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EFE606A332
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Smy675qN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A481F0089F;
	Sat,  7 Nov 2026 11:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050635;
	bh=q8LTY47VvNfe2YDljxue8O15BYEYJmIII3XQ/yG4rt0=;
	h=From:To:Cc:Subject:Date;
	b=Smy675qN6PFOqGJw2PJi4lIIbxxXg6mB23KwEne/MlVVDJfxTJuYQlEEsURrr+tma
	 WiTF3AzCFrmtOFyRrUGP0VlAyLHLOCJ1jgo4Zk3zjVNHYwe5pVNfEza9uEJbhf7qpz
	 DsC8SghDqizHI42RGzgEJMyHjeqTLem3lDIENCLYDAKFrSqmTbyjzQ8ebJQxSPAfc7
	 cREkPWOniAJs6hF+6dscV3sW1Us9E0VVY6K1kND6wAnNvyEFD/lsSUzV9hMu1p9siC
	 tQZYyGu0JwtoFwTZIGzEcE8IXhVIyU7ocm1eIuvY/2f8l/SKxpOmKZGXCAjoxL2FuJ
	 OPhi+1BjsdUQg==
From: Sasha Levin <sashal@kernel.org>
To: maz@kernel.org,
	fuad.tabba@linux.dev
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: arm64: Turn vcpu->arch.pause into a counter" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:23:53 -0500
Message-ID: <20261107062353-failed-5.10-e64309198eda@kernel.org>
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
git cherry-pick -x e64309198eda29415a95113def92aa40196cd422
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062353-failed-5.10-e64309198eda@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




