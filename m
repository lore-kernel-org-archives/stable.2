Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB5E4A2E3C;
	Fri, 11 Sep 2026 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789143745; cv=none; b=OEfJU3GfT7euD65W5V6PpKgymcF1seQc2FpXasXd++HgO7o6dJWcZXudWtiXqGtC1OOohsmwYwb8m/pyMc97DHuPM8iSs/DKuKsr/Wr3vciNgmHuX1twprXJtKQhIE1PAJdmYFLgpQXyrBg8ujQWUcIVnC5CKzqeAHnttzDWvs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789143745; c=relaxed/simple;
	bh=NjV7C4HVLJCHQlt9uGyytNKMuQXTFsWLdRecSphcvEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PqyAptihp78Ym9xcUOOyUbRwWWM4+YativQM3vdfk7HSTS3gTON740Ls5H5h9o0ZfDVbS2/X+q9WDVmaK34ftdpzTP8DTFqqd6NX3FeHAQ2NRaV0i1PCGEvb6vP/c24xI9F8Dh6zdlRvkIu8yYQHsnSxnbNGPZm88rsaJBWOiSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcce8d/h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcce8d/h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C13C1F00899;
	Fri, 11 Sep 2026 16:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789143744;
	bh=/K4/JsqJNTStRtnQH1QWXg5BJ0K8UF1m22SClbPFHr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bcce8d/hUmqdr2rbcSq6Pd8J3NhhX4JiokqM7sbd3F3oYtm/XcQ3dSmFJCToip8gh
	 mJMGkqYPqhZD0QtUDM+SlUaOIr02CDnBRpvvbQouirJ5OCaqzszrTXl6vc7FtHBUqu
	 Io5TlmZzbp0at1+w2ToZU0+o4ieBIi/bStKaoJSCetCTOQF/YTFmuFMJoAs++SMJi3
	 O488GX2wTV/XFtu7g5edeLzkS6xeQtXskFFBXiqQSdjahFfqyPye7vJaTQ9/lVYVNT
	 ntcUviYe4SG26XxJatH8QZ0vHvwG6Q0EB4u+NSDM2B59mkfMNSnC/YYA1qWtqK+cLu
	 3V0MqPM6Sq23g==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1x5418-00000007qRK-2Ep3;
	Fri, 11 Sep 2026 16:22:22 +0000
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Steffen Eiden <seiden@linux.ibm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Oliver Upton <oupton@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	ljs@kernel.org,
	Shen Yongchao <grayhat@foxmail.com>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	Wei-Lin Chang <weilin.chang@arm.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 2/2] KVM: arm64: nv: Delay freeing of shadow S2 structures until VM destruction
Date: Fri, 11 Sep 2026 17:22:03 +0100
Message-ID: <20260911162203.1919330-3-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260911162203.1919330-1-maz@kernel.org>
References: <20260911162203.1919330-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, seiden@linux.ibm.com, joey.gouly@arm.com, suzuki.poulose@arm.com, oupton@kernel.org, yuzenghui@huawei.com, fuad.tabba@linux.dev, ljs@kernel.org, grayhat@foxmail.com, kmehltretter@gmail.com, weilin.chang@arm.com, stable@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

We free the shadow S2 structures from kvm_arch_flush_shadow_all(), which
is a Bad Idea(tm). Freeing the page tables is fair game (this is what
this callback is for), but freeing the container that could still be
referenced by another part of the system is not great.

Instead, grow separate destructors that gets called when we tear the VM
down for good. From there, we can nuke both the individual MMUs as well
as the global array that points to them, safe in the knowledge that the
vcpus themselves have been destroyed already.

Fixes: 4f128f8e1aaac ("KVM: arm64: nv: Support multiple nested Stage-2 mmu structures")
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm64/include/asm/kvm_nested.h |  1 +
 arch/arm64/kvm/arm.c                |  4 ++--
 arch/arm64/kvm/nested.c             | 15 ++++++++++-----
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_nested.h b/arch/arm64/include/asm/kvm_nested.h
index 5b8edb2e8a87d..586026e859030 100644
--- a/arch/arm64/include/asm/kvm_nested.h
+++ b/arch/arm64/include/asm/kvm_nested.h
@@ -67,6 +67,7 @@ static inline u64 translate_ttbr0_el2_to_ttbr0_el1(u64 ttbr0)
 extern bool forward_smc_trap(struct kvm_vcpu *vcpu);
 extern bool forward_debug_exception(struct kvm_vcpu *vcpu);
 extern int kvm_init_nested(struct kvm *kvm);
+extern void kvm_destroy_nested(struct kvm *kvm);
 extern int kvm_vcpu_init_nested(struct kvm_vcpu *vcpu);
 extern void kvm_init_nested_s2_mmu(struct kvm_s2_mmu *mmu);
 extern struct kvm_s2_mmu *lookup_s2_mmu(struct kvm_vcpu *vcpu);
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index b53219e048bdf..eaf583b771931 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -282,7 +282,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 err_uninit_mmu:
 	kvm_uninit_stage2_mmu(kvm);
-	kvfree(kvm->arch.nested_mmus);
+	kvm_destroy_nested(kvm);
 err_free_cpumask:
 	free_cpumask_var(kvm->arch.supported_cpus);
 err_unshare_kvm:
@@ -340,7 +340,7 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 
 	kvm_unshare_hyp(kvm, kvm + 1);
 
-	kvfree(kvm->arch.nested_mmus);
+	kvm_destroy_nested(kvm);
 	kvm_arm_teardown_hypercalls(kvm);
 }
 
diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index 0a32d6bd3f6c6..d60f6f69e293d 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -56,6 +56,15 @@ int kvm_init_nested(struct kvm *kvm)
 	return kvm->arch.nested_mmus ? 0 : -ENOMEM;
 }
 
+void kvm_destroy_nested(struct kvm *kvm)
+{
+	for (int i = 0; i < kvm->arch.nested_mmus_size; i+= S2_MMU_PER_VCPU)
+		kvfree(kvm->arch.nested_mmus[i]);
+
+	kvm->arch.nested_mmus_size = 0;
+	kvfree(kvm->arch.nested_mmus);
+}
+
 static int init_nested_s2_mmu(struct kvm *kvm, struct kvm_s2_mmu *mmu)
 {
 	/*
@@ -1311,16 +1320,12 @@ void kvm_nested_s2_flush(struct kvm *kvm)
 
 void kvm_arch_flush_shadow_all(struct kvm *kvm)
 {
-	for (int i = kvm->arch.nested_mmus_size - 1; i >= 0; i--) {
+	for (int i = 0; i < kvm->arch.nested_mmus_size; i++) {
 		struct kvm_s2_mmu *mmu = kvm->arch.nested_mmus[i];
 
 		if (!WARN_ON(atomic_read(&mmu->refcnt)))
 			kvm_free_stage2_pgd(mmu);
-
-		if ((i % S2_MMU_PER_VCPU) == 0)
-			kvfree(mmu);
 	}
-	kvm->arch.nested_mmus_size = 0;
 	kvm_uninit_stage2_mmu(kvm);
 }
 
-- 
2.47.3

