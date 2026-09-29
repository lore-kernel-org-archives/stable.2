Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179D13C13E6;
	Tue, 29 Sep 2026 09:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674602; cv=none; b=hlZqN7S9HriYFSo6xdzqUIKLx0pTzrZiru8N6x5p5vv1ZHB5Og5LLo3Mn6M2f5x0fGu+iop9XnYphDuSL9SEzEZ60rzChTuezV9JQH3ckicjXN0aX6Nl4crTrCREvziyWjV+OdZzvK9lHWTO7uyuiYfnrXMyt6li6cSNRBX0804=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674602; c=relaxed/simple;
	bh=VZD8Yjru++WZZgwhQ0iPvVb5zdGKeoldZOymTVTN7Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZDP31DijX66HgP6Pn2oT3so1bKfUJL0vuzGfAY6roBR5dIclDFJTilzGk3v7zW2gb6peH6Y8CYOgzSEfyISx4sytnI3BrG95BeizrAcogvIZVZ1jZ2zJhOXSpTfeh9Xy1Tr5NFgPG+bymOBktj9ku/hk4aHXi1aiEMrFN+ykCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtnY2C39; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtnY2C39"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B60821F00899;
	Tue, 29 Sep 2026 09:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790674600;
	bh=9Eud5GNNPrAatHu+qEWY3UADBf1pHyyoCW3I8vnbr84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mtnY2C395UzD37gI5Ru1SgJroz8xkEZh1aCzNM+3r0wJIl1Xhjr/CKEMnA0CqH2Kl
	 lsrmE0vsWr9HCKYaatW/qqDbTV0drjW+EUk4Pce1F3h4jjMLni3+Qrt4kWO7ByhoKm
	 wvA2lF/pX3mbTmbhKp+VBrICKS6rjkofe5hRvODIxqAq8euIxELpBVhyYdjiss73ma
	 FLVSCfSpGeiEgZ+yVTtEG6MxdAMqbci2u+8HzPoIJ8CbOe8VFWLHv9RbWleswzS5dT
	 AYAY6IqVZ/nUwdM6+zW8c7sHDftSg/8DYysFIe+gRIOmq4rg7jqs1BD3m/RHLlYUk6
	 mBCMw8nehyucQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1xBUGM-0000000ElEa-3Ng9;
	Tue, 29 Sep 2026 09:36:38 +0000
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Steffen Eiden <seiden@linux.ibm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Oliver Upton <oupton@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Yuchao Zhang <ndaugoing@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/7] KVM: arm64: Turn vcpu->arch.pause into a counter
Date: Tue, 29 Sep 2026 10:35:43 +0100
Message-ID: <20260929093548.3598547-3-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260929093548.3598547-1-maz@kernel.org>
References: <20260929093548.3598547-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, seiden@linux.ibm.com, joey.gouly@arm.com, suzuki.poulose@arm.com, oupton@kernel.org, yuzenghui@huawei.com, fuad.tabba@linux.dev, ndaugoing@gmail.com, stable@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

We have situations where we can call kvm_arm_halt_guest() without
holding config_lock, which means that halt and resume can overlap in
funny ways when called from separate contexts, and result in situations
where a vcpu is resumed while other parts of KVM assume it is halted.
Consequences are left to the imagination of the reader.

Fix this sorry situation by turning kvm_vcpu_arch::pause into an
atomic counter, which makes the races described above harmless.

Fixes: 3b92830ad41b2 ("KVM: arm/arm64: implement kvm_arm_[halt,resume]_guest")
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm64/include/asm/kvm_host.h |  7 +++----
 arch/arm64/kvm/arm.c              | 21 ++++++++++++---------
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 27fe0cd5b2d7a..66ea2372f9870 100644
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
index 5f5dd8bead4b9..9a4871cd796bc 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -561,6 +561,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	kvm_arm_pvtime_vcpu_init(&vcpu->arch);
 
 	vcpu->arch.hw_mmu = &vcpu->kvm->arch.mmu;
+	atomic_set(&vcpu->arch.pause, 0);
 
 	/*
 	 * This vCPU may have been created after mpidr_data was initialized.
@@ -835,6 +836,11 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
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
@@ -850,8 +856,7 @@ int kvm_arch_vcpu_runnable(struct kvm_vcpu *v)
 		      (kvm_timer_should_notify_user(v) ||
 		       kvm_pmu_should_notify_user(v)));
 
-	return ((irq_lines || kvm_vgic_vcpu_pending_irq(v))
-		&& !kvm_arm_vcpu_stopped(v) && !v->arch.pause);
+	return ((irq_lines || kvm_vgic_vcpu_pending_irq(v)) && vcpu_can_run(v));
 }
 
 bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu)
@@ -1014,7 +1019,7 @@ void kvm_arm_halt_guest(struct kvm *kvm)
 	struct kvm_vcpu *vcpu;
 
 	kvm_for_each_vcpu(i, vcpu, kvm)
-		vcpu->arch.pause = true;
+		atomic_inc(&vcpu->arch.pause);
 	kvm_make_all_cpus_request(kvm, KVM_REQ_SLEEP);
 }
 
@@ -1024,8 +1029,8 @@ void kvm_arm_resume_guest(struct kvm *kvm)
 	struct kvm_vcpu *vcpu;
 
 	kvm_for_each_vcpu(i, vcpu, kvm) {
-		vcpu->arch.pause = false;
-		__kvm_vcpu_wake_up(vcpu);
+		if (atomic_dec_and_test(&vcpu->arch.pause))
+			__kvm_vcpu_wake_up(vcpu);
 	}
 }
 
@@ -1033,11 +1038,9 @@ static void kvm_vcpu_sleep(struct kvm_vcpu *vcpu)
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
2.47.3

