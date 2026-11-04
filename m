Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833988;
	b=FFFORNPBN4BSIWSHqFv8ZiA0bETtQth4/XmyqFq4x4/ZADY+3Ea1ugwlQEu5q/0vxmv5
	 ESlXfVVg7fin88XyIXcJ4MXFhBWHwXpUmOEjTyYNRV5X8DTb5DT6ftHuLX5LC6+v8OPtP
	 QjLayANh/WMYuAe6rXHIadh13+HyUnkAwUVKCVhhJ7qIBszHFSvu+umihZ7cGTpyo+MWs
	 vlPBzVqRpCNm2S5peauiFIogB4F+v7edCIyK9MTacMDb0nrKiDf2QcyFSCAbVDxfh4p5I
	 LsZ+TeNYE6PoQYtQtZdjbPsaagYHRe4znZ0CC5CqfpYU4R4yRSaETTlAeYnm7ao4l3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833988;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HAntF9u4ArumqUmCaCu5jJQRhMyuiZz0pLk76ZFB0pI=;
	b=U1nns4F1id4SgaqCyMcaMpqxAXlsw/zcVDIhZBuLb7mFfQpHtEB1wA5gbmm6c9rCMqWW
	 D7Ugqu1mwi3FSxL+nS2IZ4LqJtV+0P1tS0UBuS1KTnKtd8mjbEV2nrcGleDu1lNvXvRrD
	 XqxARuPy0n5tZpfN5mjbX7Dk368+el8ki/7btIGK3YdOVfCCxKU5h+rgXK6g4Zy1XN8Kh
	 kvXy9dRw13UnSNQI4cKpxQxBMBCQRJfb4xi8OYezpv21YxtJaCAW30HNosh2WaukKN+Br
	 NYa7jU25WIe/s7UQ/MFg8ignfGS/XKO/G36B2l06W1q51dZGDi0gOuDHnsr+iiVaLBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j5Ezn4tr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F43606A329
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 23:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j5Ezn4tr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B87B21F000C1;
	Wed,  4 Nov 2026 23:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793833988;
	bh=HAntF9u4ArumqUmCaCu5jJQRhMyuiZz0pLk76ZFB0pI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j5Ezn4trTN3+amrIGL56gS1zM8Kfx2eLiyxOYMGaPUk2VPgh13z+LDTynz/KvJ3Mi
	 wlbs1CeBYwgI6QeDbY7L0vNxBOECZwhxT3DassYBWCG7s0FYl9NODQ1W5+ZY7lTuYg
	 kqOH5/W+gcMOX73jBrVIIKeFeZH0aFSAse+tzl9AWp0ZTChM1Dm+UouMXMJRxCrFSL
	 FqW/oyN1zySMxdkOlt0PH/fHQfqHwL9/AUfS5nvaEVQaqJf9+TBAwUwlw53/d4tEWa
	 88L6AzpSr7BfkElBLink0cCzyiGPM8WdwyCDfuoBRH5yRFUbOOPm89f+rEqW/MPMwX
	 07YGFCL/HFrNg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/4] KVM: remove CONFIG_KVM_GENERIC_MMU_NOTIFIER
Date: Wed,  4 Nov 2026 18:13:03 -0500
Message-ID: <20261104231214.887398-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104231214.887398-1-sashal@kernel.org>
References: <2026110445-lividly-gratified-dd5f@gregkh>
 <20261104231214.887398-1-sashal@kernel.org>
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

From: Paolo Bonzini <pbonzini@redhat.com>

[ Upstream commit 407fd8b8d8cce03856aa67329715de48b254b529 ]

All architectures now use MMU notifier for KVM page table management.
Remove the Kconfig symbol and the code that is used when it is
disabled.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: da260bcb56fe ("KVM: pfncache: use a dedicated invalidation sequence for cache refresh")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kvm/Kconfig     |  1 -
 arch/loongarch/kvm/Kconfig |  1 -
 arch/mips/kvm/Kconfig      |  1 -
 arch/powerpc/kvm/Kconfig   |  4 ----
 arch/powerpc/kvm/powerpc.c |  1 -
 arch/riscv/kvm/Kconfig     |  1 -
 arch/s390/kvm/Kconfig      |  2 --
 arch/x86/kvm/Kconfig       |  1 -
 include/linux/kvm_host.h   |  7 +------
 virt/kvm/Kconfig           |  9 +--------
 virt/kvm/kvm_main.c        | 16 ----------------
 11 files changed, 2 insertions(+), 42 deletions(-)

diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 4f803fd1c99af..7d1f22fd490b2 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -21,7 +21,6 @@ menuconfig KVM
 	bool "Kernel-based Virtual Machine (KVM) support"
 	select KVM_COMMON
 	select KVM_GENERIC_HARDWARE_ENABLING
-	select KVM_GENERIC_MMU_NOTIFIER
 	select HAVE_KVM_CPU_RELAX_INTERCEPT
 	select KVM_MMIO
 	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
diff --git a/arch/loongarch/kvm/Kconfig b/arch/loongarch/kvm/Kconfig
index ae64bbdf83a7a..f480728e7fb22 100644
--- a/arch/loongarch/kvm/Kconfig
+++ b/arch/loongarch/kvm/Kconfig
@@ -29,7 +29,6 @@ config KVM
 	select KVM_COMMON
 	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
 	select KVM_GENERIC_HARDWARE_ENABLING
-	select KVM_GENERIC_MMU_NOTIFIER
 	select KVM_MMIO
 	select VIRT_XFER_TO_GUEST_WORK
 	select SCHED_INFO
diff --git a/arch/mips/kvm/Kconfig b/arch/mips/kvm/Kconfig
index ab57221fa4dde..e37fbba8b95de 100644
--- a/arch/mips/kvm/Kconfig
+++ b/arch/mips/kvm/Kconfig
@@ -24,7 +24,6 @@ config KVM
 	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
 	select HAVE_KVM_VCPU_ASYNC_IOCTL
 	select KVM_MMIO
-	select KVM_GENERIC_MMU_NOTIFIER
 	select KVM_GENERIC_HARDWARE_ENABLING
 	select HAVE_KVM_READONLY_MEM
 	help
diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index 2f2702c867f76..c1be5f1f67b2e 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -39,7 +39,6 @@ config KVM_BOOK3S_64_HANDLER
 config KVM_BOOK3S_PR_POSSIBLE
 	bool
 	select KVM_MMIO
-	select KVM_GENERIC_MMU_NOTIFIER
 
 config KVM_BOOK3S_HV_POSSIBLE
 	bool
@@ -82,7 +81,6 @@ config KVM_BOOK3S_64_HV
 	tristate "KVM for POWER7 and later using hypervisor mode in host"
 	depends on KVM_BOOK3S_64 && PPC_POWERNV
 	select KVM_BOOK3S_HV_POSSIBLE
-	select KVM_GENERIC_MMU_NOTIFIER
 	select KVM_BOOK3S_HV_PMU
 	select CMA
 	help
@@ -204,7 +202,6 @@ config KVM_E500V2
 	depends on !CONTEXT_TRACKING_USER
 	select KVM
 	select KVM_MMIO
-	select KVM_GENERIC_MMU_NOTIFIER
 	help
 	  Support running unmodified E500 guest kernels in virtual machines on
 	  E500v2 host processors.
@@ -221,7 +218,6 @@ config KVM_E500MC
 	select KVM
 	select KVM_MMIO
 	select KVM_BOOKE_HV
-	select KVM_GENERIC_MMU_NOTIFIER
 	help
 	  Support running unmodified E500MC/E5500/E6500 guest kernels in
 	  virtual machines on E500MC/E5500/E6500 host processors.
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index cc22d41f8b2fe..721a4b1411eed 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -631,7 +631,6 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		break;
 #endif
 	case KVM_CAP_SYNC_MMU:
-		BUILD_BUG_ON(!IS_ENABLED(CONFIG_KVM_GENERIC_MMU_NOTIFIER));
 		r = 1;
 		break;
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
diff --git a/arch/riscv/kvm/Kconfig b/arch/riscv/kvm/Kconfig
index c50328212917e..b3de712c3a40b 100644
--- a/arch/riscv/kvm/Kconfig
+++ b/arch/riscv/kvm/Kconfig
@@ -31,7 +31,6 @@ config KVM
 	select KVM_GENERIC_HARDWARE_ENABLING
 	select KVM_MMIO
 	select VIRT_XFER_TO_GUEST_WORK
-	select KVM_GENERIC_MMU_NOTIFIER
 	select SCHED_INFO
 	select GUEST_PERF_EVENTS if PERF_EVENTS
 	help
diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
index 0c93ed676508b..2e3f28120b771 100644
--- a/arch/s390/kvm/Kconfig
+++ b/arch/s390/kvm/Kconfig
@@ -29,9 +29,7 @@ config KVM
 	select HAVE_KVM_INVALID_WAKEUPS
 	select HAVE_KVM_NO_POLL
 	select KVM_VFIO
-	select MMU_NOTIFIER
 	select VIRT_XFER_TO_GUEST_WORK
-	select KVM_GENERIC_MMU_NOTIFIER
 	select KVM_MMU_LOCKLESS_AGING
 	help
 	  Support hosting paravirtualized guest machines using the SIE
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 278f08194ec87..a795fdc677f34 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -20,7 +20,6 @@ if VIRTUALIZATION
 config KVM_X86
 	def_tristate KVM if (KVM_INTEL != n || KVM_AMD != n)
 	select KVM_COMMON
-	select KVM_GENERIC_MMU_NOTIFIER
 	select KVM_ELIDE_TLB_FLUSH_IF_YOUNG
 	select KVM_MMU_LOCKLESS_AGING
 	select HAVE_KVM_IRQCHIP
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 56033126bcde5..9faa434765546 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -253,7 +253,6 @@ bool kvm_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 int kvm_async_pf_wakeup_all(struct kvm_vcpu *vcpu);
 #endif
 
-#ifdef CONFIG_KVM_GENERIC_MMU_NOTIFIER
 union kvm_mmu_notifier_arg {
 	unsigned long attributes;
 };
@@ -275,7 +274,6 @@ struct kvm_gfn_range {
 bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range);
 bool kvm_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range);
 bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range);
-#endif
 
 enum {
 	OUTSIDE_GUEST_MODE,
@@ -848,13 +846,12 @@ struct kvm {
 	struct hlist_head irq_ack_notifier_list;
 #endif
 
-#ifdef CONFIG_KVM_GENERIC_MMU_NOTIFIER
 	struct mmu_notifier mmu_notifier;
 	unsigned long mmu_invalidate_seq;
 	long mmu_invalidate_in_progress;
 	gfn_t mmu_invalidate_range_start;
 	gfn_t mmu_invalidate_range_end;
-#endif
+
 	struct list_head devices;
 	u64 manual_dirty_log_protect;
 	struct dentry *debugfs_dentry;
@@ -2100,7 +2097,6 @@ extern const struct kvm_stats_desc kvm_vm_stats_desc[];
 extern const struct kvm_stats_header kvm_vcpu_stats_header;
 extern const struct kvm_stats_desc kvm_vcpu_stats_desc[];
 
-#ifdef CONFIG_KVM_GENERIC_MMU_NOTIFIER
 static inline int mmu_invalidate_retry(struct kvm *kvm, unsigned long mmu_seq)
 {
 	if (unlikely(kvm->mmu_invalidate_in_progress))
@@ -2178,7 +2174,6 @@ static inline bool mmu_invalidate_retry_gfn_unsafe(struct kvm *kvm,
 
 	return READ_ONCE(kvm->mmu_invalidate_seq) != mmu_seq;
 }
-#endif
 
 #ifdef CONFIG_HAVE_KVM_IRQ_ROUTING
 
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index 5f0015c5dd957..a3d24f5459fa5 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -5,6 +5,7 @@ config KVM_COMMON
        bool
        select EVENTFD
        select INTERVAL_TREE
+       select MMU_NOTIFIER
        select PREEMPT_NOTIFIERS
 
 config HAVE_KVM_PFNCACHE
@@ -96,24 +97,16 @@ config HAVE_KVM_PM_NOTIFIER
 config KVM_GENERIC_HARDWARE_ENABLING
        bool
 
-config KVM_GENERIC_MMU_NOTIFIER
-       select MMU_NOTIFIER
-       bool
-
 config KVM_ELIDE_TLB_FLUSH_IF_YOUNG
-       depends on KVM_GENERIC_MMU_NOTIFIER
        bool
 
 config KVM_MMU_LOCKLESS_AGING
-       depends on KVM_GENERIC_MMU_NOTIFIER
        bool
 
 config KVM_GENERIC_MEMORY_ATTRIBUTES
-       depends on KVM_GENERIC_MMU_NOTIFIER
        bool
 
 config KVM_GUEST_MEMFD
-       depends on KVM_GENERIC_MMU_NOTIFIER
        select XARRAY_MULTI
        bool
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 23e7d1bb80b04..8c14fa9b0d89d 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -501,7 +501,6 @@ void kvm_destroy_vcpus(struct kvm *kvm)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_destroy_vcpus);
 
-#ifdef CONFIG_KVM_GENERIC_MMU_NOTIFIER
 static inline struct kvm *mmu_notifier_to_kvm(struct mmu_notifier *mn)
 {
 	return container_of(mn, struct kvm, mmu_notifier);
@@ -900,15 +899,6 @@ static int kvm_init_mmu_notifier(struct kvm *kvm)
 	return mmu_notifier_register(&kvm->mmu_notifier, current->mm);
 }
 
-#else  /* !CONFIG_KVM_GENERIC_MMU_NOTIFIER */
-
-static int kvm_init_mmu_notifier(struct kvm *kvm)
-{
-	return 0;
-}
-
-#endif /* CONFIG_KVM_GENERIC_MMU_NOTIFIER */
-
 #ifdef CONFIG_HAVE_KVM_PM_NOTIFIER
 static int kvm_pm_notifier_call(struct notifier_block *bl,
 				unsigned long state,
@@ -1225,10 +1215,8 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
 out_err_no_debugfs:
 	kvm_coalesced_mmio_free(kvm);
 out_no_coalesced_mmio:
-#ifdef CONFIG_KVM_GENERIC_MMU_NOTIFIER
 	if (kvm->mmu_notifier.ops)
 		mmu_notifier_unregister(&kvm->mmu_notifier, current->mm);
-#endif
 out_err_no_mmu_notifier:
 	kvm_disable_virtualization();
 out_err_no_disable:
@@ -1291,7 +1279,6 @@ static void kvm_destroy_vm(struct kvm *kvm)
 		kvm->buses[i] = NULL;
 	}
 	kvm_coalesced_mmio_free(kvm);
-#ifdef CONFIG_KVM_GENERIC_MMU_NOTIFIER
 	mmu_notifier_unregister(&kvm->mmu_notifier, kvm->mm);
 	/*
 	 * At this point, pending calls to invalidate_range_start()
@@ -1310,9 +1297,6 @@ static void kvm_destroy_vm(struct kvm *kvm)
 		kvm->mn_active_invalidate_count = 0;
 	else
 		WARN_ON(kvm->mmu_invalidate_in_progress);
-#else
-	kvm_flush_shadow_all(kvm);
-#endif
 	kvm_arch_destroy_vm(kvm);
 	kvm_destroy_devices(kvm);
 	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
-- 
2.53.0

