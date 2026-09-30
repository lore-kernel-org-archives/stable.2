Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E69A4E2F3D
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 14:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777151; cv=none; b=BsJncJVf+aTpVA7zRXJRqLAtMO0qOXl0ktOSCkanjyjbR/w4WS891BiFZYLgGAcREMrNhpfNE9O/TkDgtEAb6qK6uP09XlVgbiOfBBlm+za1z9wVdLiC4XfJIxZ46U+G8VyjnVfM8pP/4a3wdDSwKW1He7RJyRR/5PmqVab4Wm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777151; c=relaxed/simple;
	bh=AkgR6yT/KmcB0yhzLobZ4lqIjW+gPRQcFZquaw0Mp6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DrxDdSEsZjmbnOjCMru1AHwx2bI1q0azrwsEhg+1B+xhWZWD3vHNaqqfvuSn47Gso+KdP3JKlEqiYiljKFI+20IDdMzX4EwGmqg3KUUymB8+v/z6CwKw5gIQa0L0VD8cKNKwlm8xrXjvNk1CUCLt9fBivBz8nGtmxAvXOqmhlCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJbGixcR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJbGixcR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E992F1F0089E;
	Wed, 30 Sep 2026 14:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790777140;
	bh=CEn/dfQdHbZBWyq9gSycx18IwUSA0WebqYhb/TeB3sw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GJbGixcRBeiJx2KFWLERfwXghwzNPHVs9dC1YUZCfeKLtM1eXy7ikrYA81UWXWNIk
	 aA6DeEmXrsdYpLIOHvzSIfcvY7sBreW2snxzwC5taRpIR6WCcaTZlzq2BPEXbN8w2c
	 5S8P2M8KgW3g98i84ivEpufhJ8cXKwA/zudGVmoDEocA4Z/znWVBOB7dVMiyE/N52t
	 2sbJ/hki4220cQ+Eq3L7efVrMMabeLFvqYhDlMDwX/ePvE+AIYO7PK4qzL/bm3FWXC
	 uoWihKOgker3xi21SJVae0CHX+cFR0iuO833kz3kO78VUTXVQvscPB/sQoEPgdBIWM
	 ps8A6TDY8j7Jw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Wei-Lin Chang <weilin.chang@arm.com>,
	Oliver Upton <oupton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] KVM: arm64: nv: Delay freeing of shadow S2 structures until VM destruction
Date: Wed, 30 Sep 2026 10:05:37 -0400
Message-ID: <20260930140537.1824583-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930140537.1824583-1-sashal@kernel.org>
References: <2026092944-deviation-elude-f3dc@gregkh>
 <20260930140537.1824583-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marc Zyngier <maz@kernel.org>

[ Upstream commit e5843f4effaa2ffac3e789ecd4456403564961d4 ]

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
Reviewed-by: Wei-Lin Chang <weilin.chang@arm.com>
Link: https://patch.msgid.link/20260911162203.1919330-3-maz@kernel.org
Signed-off-by: Oliver Upton <oupton@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/kvm_nested.h |  1 +
 arch/arm64/kvm/arm.c                |  4 ++--
 arch/arm64/kvm/nested.c             | 15 ++++++++++-----
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_nested.h b/arch/arm64/include/asm/kvm_nested.h
index 30d4c8ae28d3e..dda7fffe0bd92 100644
--- a/arch/arm64/include/asm/kvm_nested.h
+++ b/arch/arm64/include/asm/kvm_nested.h
@@ -66,6 +66,7 @@ static inline u64 translate_ttbr0_el2_to_ttbr0_el1(u64 ttbr0)
 extern bool forward_smc_trap(struct kvm_vcpu *vcpu);
 extern bool forward_debug_exception(struct kvm_vcpu *vcpu);
 extern int kvm_init_nested(struct kvm *kvm);
+extern void kvm_destroy_nested(struct kvm *kvm);
 extern int kvm_vcpu_init_nested(struct kvm_vcpu *vcpu);
 extern void kvm_init_nested_s2_mmu(struct kvm_s2_mmu *mmu);
 extern struct kvm_s2_mmu *lookup_s2_mmu(struct kvm_vcpu *vcpu);
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 6a26367943320..cec58e6328323 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -219,7 +219,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 err_uninit_mmu:
 	kvm_uninit_stage2_mmu(kvm);
-	kvfree(kvm->arch.nested_mmus);
+	kvm_destroy_nested(kvm);
 err_free_cpumask:
 	free_cpumask_var(kvm->arch.supported_cpus);
 err_unshare_kvm:
@@ -276,7 +276,7 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 
 	kvm_unshare_hyp(kvm, kvm + 1);
 
-	kvfree(kvm->arch.nested_mmus);
+	kvm_destroy_nested(kvm);
 	kvm_arm_teardown_hypercalls(kvm);
 }
 
diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index 144b72743a5c6..3440b7709f39f 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -54,6 +54,15 @@ int kvm_init_nested(struct kvm *kvm)
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
@@ -1171,16 +1180,12 @@ void kvm_nested_s2_flush(struct kvm *kvm)
 
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
2.53.0

