Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E9F42C4EA
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 13:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785417173; cv=none; b=ZcV5J5KI9SdTVll0m9zlCeN+BfuU0QKV3hyRLS/XxdwiAhvg7IzjwLIuHEyE/6laLpO0UVVTdusJFuu262Moemydn7VbH1jSHuR+cM2X4GB9Ci7XRDOrmFxSHrtnbyfGqZTJILObUbMV+FkkXUiom4RUfFk5UzrAUe2hElLnGTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785417173; c=relaxed/simple;
	bh=kdDZQ/l0G4Q4DriW8gHyhltjPqLubx8ag8K5Apdegv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J9lG95pntZrZc+OmGqH5E8POe36fXKiwEWzu7BlnZgYK9g9Cb6mQlADHtamdSHlD3tXdt13mF8LdggcnP6Onloc19z3hY6VICBdOk/cLzgxY5VadvHglwioOwAuh6fT1SmEN+Uwj4DHfVmeYVEFEnyTsrESjlpHic4RwALw1YEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAkK+tQi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAkK+tQi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC2B11F000E9;
	Thu, 30 Jul 2026 13:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785417170;
	bh=BWZVIfj/tC47G4K011AvZAC+cg45dp8x0pZLgLowTYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZAkK+tQi+VVjDFE8KE0Z2TOE5jtOqq7pYD7OfCQAGVmpqrdX1Wz3YZMuJ2/AHrMCt
	 fQUu8/FvojohqhLNtBvKfHNQN2/yElXyCWmsU7eL4T9uZ2pPwamKCaSpXu+ICc0FdC
	 /9dfNUIrFbXtFYoiTUQ0lIMOaEfvy3C4teCfrXZlnjXAmFcEKT7oc//aY77bvpNIqS
	 14T3Zhto/caCjhhZQ0Uqaz4TNNaBnTHq1n0nohWOGE7q2niDwcDOlIceFeElL8LaPT
	 I7jzIp+YEledCBIecPMNx2ASHxEGIkrtbOBuxBxhIefD61QvyqXIJKRRwirIaV04S+
	 SBFxG0CGwjDTw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Matlack <dmatlack@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] KVM: Introduce vcpu->wants_to_run
Date: Thu, 30 Jul 2026 09:12:46 -0400
Message-ID: <20260730131247.2343824-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072610-estimator-reclusive-2a87@gregkh>
References: <2026072610-estimator-reclusive-2a87@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Matlack <dmatlack@google.com>

[ Upstream commit a6816314af5749cd88944bfdceb270c627cdf348 ]

Introduce vcpu->wants_to_run to indicate when a vCPU is in its core run
loop, i.e. when the vCPU is running the KVM_RUN ioctl and immediate_exit
was not set.

Replace all references to vcpu->run->immediate_exit with
!vcpu->wants_to_run to avoid TOCTOU races with userspace. For example, a
malicious userspace could invoked KVM_RUN with immediate_exit=true and
then after KVM reads it to set wants_to_run=false, flip it to false.
This would result in the vCPU running in KVM_RUN with
wants_to_run=false. This wouldn't cause any real bugs today but is a
dangerous landmine.

Signed-off-by: David Matlack <dmatlack@google.com>
Link: https://lore.kernel.org/r/20240503181734.1467938-2-dmatlack@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Stable-dep-of: e800decd9c0a ("KVM: x86: Only reset TSC Deadline Timer in apic_timer_expired on KVM_RUN")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kvm/arm.c       | 2 +-
 arch/mips/kvm/mips.c       | 2 +-
 arch/powerpc/kvm/powerpc.c | 2 +-
 arch/riscv/kvm/vcpu.c      | 2 +-
 arch/s390/kvm/kvm-s390.c   | 2 +-
 arch/x86/kvm/x86.c         | 4 ++--
 include/linux/kvm_host.h   | 1 +
 virt/kvm/kvm_main.c        | 3 +++
 8 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index b0fe2bf7fa5ae1..672684d67e3994 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -891,7 +891,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 
 	vcpu_load(vcpu);
 
-	if (run->immediate_exit) {
+	if (!vcpu->wants_to_run) {
 		ret = -EINTR;
 		goto out;
 	}
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index a4f4407b0a332e..dfe2333c098ceb 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -446,7 +446,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 		vcpu->mmio_needed = 0;
 	}
 
-	if (vcpu->run->immediate_exit)
+	if (!vcpu->wants_to_run)
 		goto out;
 
 	lose_fpu(1);
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 98ac5d39ad9cf9..f05071bddce6cc 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -1866,7 +1866,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 
 	kvm_sigset_activate(vcpu);
 
-	if (run->immediate_exit)
+	if (!vcpu->wants_to_run)
 		r = -EINTR;
 	else
 		r = kvmppc_vcpu_run(vcpu);
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index 5174ef54ad1d9e..464eeabeaa2ee0 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -973,7 +973,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 		return ret;
 	}
 
-	if (run->immediate_exit) {
+	if (!vcpu->wants_to_run) {
 		kvm_vcpu_srcu_read_unlock(vcpu);
 		return -EINTR;
 	}
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index e6606ff91921ad..2a1a3117a5b231 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -4881,7 +4881,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 	if (vcpu->kvm->arch.pv.dumping)
 		return -EINVAL;
 
-	if (kvm_run->immediate_exit)
+	if (!vcpu->wants_to_run)
 		return -EINTR;
 
 	if (kvm_run->kvm_valid_regs & ~KVM_SYNC_S390_VALID_FIELDS ||
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 208a713d7ecd75..ffbf532baf7cd5 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11264,7 +11264,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 
 	kvm_vcpu_srcu_read_lock(vcpu);
 	if (unlikely(vcpu->arch.mp_state == KVM_MP_STATE_UNINITIALIZED)) {
-		if (kvm_run->immediate_exit) {
+		if (!vcpu->wants_to_run) {
 			r = -EINTR;
 			goto out;
 		}
@@ -11337,7 +11337,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 		WARN_ON_ONCE(vcpu->mmio_needed);
 	}
 
-	if (kvm_run->immediate_exit) {
+	if (!vcpu->wants_to_run) {
 		r = -EINTR;
 		goto out;
 	}
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 624380c4fef809..e1bea71ca92818 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -365,6 +365,7 @@ struct kvm_vcpu {
 		bool dy_eligible;
 	} spin_loop;
 #endif
+	bool wants_to_run;
 	bool preempted;
 	bool ready;
 	struct kvm_vcpu_arch arch;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index f060c914d68107..c4d17ded361965 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4119,7 +4119,10 @@ static long kvm_vcpu_ioctl(struct file *filp,
 				synchronize_rcu();
 			put_pid(oldpid);
 		}
+		vcpu->wants_to_run = !READ_ONCE(vcpu->run->immediate_exit);
 		r = kvm_arch_vcpu_ioctl_run(vcpu);
+		vcpu->wants_to_run = false;
+
 		trace_kvm_userspace_exit(vcpu->run->exit_reason, r);
 		break;
 	}
-- 
2.53.0

