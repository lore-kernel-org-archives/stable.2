Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC74546C4A9
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 19:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785439787; cv=none; b=BcXT8O2vCdU0Tmf7CWfDAY2n6CKlUfGZdLnIdHzjEyJcdJIl5gtyarSdfY94tTEORiE+JCWAfjXKIpnX1CTJLTaqM2NfiiwZTbQT8J8uvae78waJdTSdmvnbozfBrzDQaz/gSlD44rxN7WikqCOWEMIaEyDNcRiAvYI3l/kEVLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785439787; c=relaxed/simple;
	bh=DHRg4JsWgUIHRfJnNPWrtbl5u9ceLOmC66VsQDobwm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tNZ68F969pAHLP8CVWx/xkjWILSd9sQP/0BtLlZmeHwZ0Ev+YWUeUm2xEDU4RS+7+apcyCRMsoaWfGVhCHujOBcb7/03My8jiJCFyCeqDQ2/fetSq93PviAwArfyAmgWHs6GnIASF/pgbqCoNUK3JVcXZfjp8nnr9hCrPKJ3faI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ay906Jvd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ay906Jvd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF451F00A3D;
	Thu, 30 Jul 2026 19:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785439781;
	bh=75F9u0zfMYwSUYAo1G52mh1wA8H9DvXqA+6FIlNmffU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ay906JvdtSG2pY24r5NQj4vbM40uMtxKep7N7jpmDQj5tShtURlR9suO9VRYID7ns
	 UiQA8rRROr8MJOUondu0OlcIiItZoIbQAqVNZ2LgEMDIELUmDu55LlvU2mbcc2DzvB
	 i89jrfMaq1aDbXLTzot6icMbj3yyjhtHiq5PnkdnQ40xNezA55U0dYjKdxeCvMKJQg
	 4JMQgVcSX8qLJNaA/NlIx7AkJ4nyZoRZAbtFXCE+jbIiPbU1fzCKjO4rbQS2WRr3Om
	 6Lawm7dDB0oOW/8tyVkpKB+F7BL5s0Jq5if1wvM0mjAsK67z9vT6dNY41RLbcCe9Kx
	 tLOj5BkBvxDVw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Matlack <dmatlack@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/5] KVM: Introduce vcpu->wants_to_run
Date: Thu, 30 Jul 2026 15:29:36 -0400
Message-ID: <20260730192937.3123765-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730192937.3123765-1-sashal@kernel.org>
References: <2026072512-swept-john-385a@gregkh>
 <20260730192937.3123765-1-sashal@kernel.org>
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
 arch/s390/kvm/kvm-s390.c   | 2 +-
 arch/x86/kvm/x86.c         | 4 ++--
 include/linux/kvm_host.h   | 1 +
 virt/kvm/kvm_main.c        | 3 +++
 7 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index afe8be2fef88..309a925c2e7a 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -686,7 +686,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 			return ret;
 	}
 
-	if (run->immediate_exit)
+	if (!vcpu->wants_to_run)
 		return -EINTR;
 
 	vcpu_load(vcpu);
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 3d6a7f5827b1..e70b8a5793e0 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -464,7 +464,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 		vcpu->mmio_needed = 0;
 	}
 
-	if (vcpu->run->immediate_exit)
+	if (!vcpu->wants_to_run)
 		goto out;
 
 	lose_fpu(1);
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 0f5ebec660a7..103d389b59b5 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -1832,7 +1832,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 
 	kvm_sigset_activate(vcpu);
 
-	if (run->immediate_exit)
+	if (!vcpu->wants_to_run)
 		r = -EINTR;
 	else
 		r = kvmppc_vcpu_run(vcpu);
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index f6c27b44766f..15cd2c22ed00 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -4373,7 +4373,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 	struct kvm_run *kvm_run = vcpu->run;
 	int rc;
 
-	if (kvm_run->immediate_exit)
+	if (!vcpu->wants_to_run)
 		return -EINTR;
 
 	if (kvm_run->kvm_valid_regs & ~KVM_SYNC_S390_VALID_FIELDS ||
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f9cfba9ec644..1b8860a1c7c2 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9648,7 +9648,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 	kvm_load_guest_fpu(vcpu);
 
 	if (unlikely(vcpu->arch.mp_state == KVM_MP_STATE_UNINITIALIZED)) {
-		if (kvm_run->immediate_exit) {
+		if (!vcpu->wants_to_run) {
 			r = -EINTR;
 			goto out;
 		}
@@ -9692,7 +9692,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 	} else
 		WARN_ON(vcpu->arch.pio.count || vcpu->mmio_needed);
 
-	if (kvm_run->immediate_exit)
+	if (!vcpu->wants_to_run)
 		r = -EINTR;
 	else
 		r = vcpu_run(vcpu);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 1e6a377af368..5b9c303876a5 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -318,6 +318,7 @@ struct kvm_vcpu {
 		bool dy_eligible;
 	} spin_loop;
 #endif
+	bool wants_to_run;
 	bool preempted;
 	bool ready;
 	struct kvm_vcpu_arch arch;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index b340be2d81a3..ae961d487f94 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3366,7 +3366,10 @@ static long kvm_vcpu_ioctl(struct file *filp,
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

