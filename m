Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB123BB669
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 06:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785997444; cv=none; b=uk/gt+CBEtheHiLovttbhUrvPSNXhoqmmK1KH2P06OBj6wr6KUQNWRtyhiH4/WPIRWXWCqXL7eKR3etEdkQFOSGxJNtJCDYgCq6VYESoXWhzTW7GHWGxsduxUQSiPz+qvrqyUYJI62XPFtb5QCCzzTmb59iI7RKXJpMhbZk/tQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785997444; c=relaxed/simple;
	bh=aWQaR5O1Vanq6leGYgOFSLuLEeEuiZb92/xgrydC0ZU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uWCRp4vMocQeWJPdsQGV0MalKZKdqN6Wb2tCdMgqNs7R+8FGTEVlwfoXvT4u7WiIc0iGnu1gJZK+jQstAVPizZ0lU/Fu1kOdLh6gsNdySd5myr6DQ2DKV1O1VtRJBwqR/WK31GZbyZjDcMUiETfG/J9srvvooxXxidcLTK+0LW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iV/1w8OQ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iV/1w8OQ"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49558ce01afso12483335e9.1
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 23:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785997440; x=1786602240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sZtec6GChkFVt7/C1bKbl1bNbj1OFb+s6RfoXi8ur28=;
        b=iV/1w8OQoySr3U2j5zWG4QNI36Lxv09GthvokjfVZ80lQlUYVCMcNpmDcuD7oPThfp
         Lsqf8MqtWqDd4EWlPMLZkuuvOdhZkz/lQWYbous5lou0sT6gPK0zoGhfgSjEGWyGMRpe
         LYtbq2oKsrqAnwwgkbCNnvvxyyKGYNla2Qwp2YN+g8jMPbBlUpCizOmElhgIwlpi6Gtm
         Bq4Cq5vzG+iWYXpdLoU6AKpfXaWLBcbrqF8G3rkM6vQvDWgdIz3/SPxjWft6VHm1wuFy
         CL24Hya8RKanHGD11hXdmiL4J1GbCCzTrk0Z4Gxu3dfkNHdmgcfh3cWPmJUqCZLRwnVC
         /kxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785997440; x=1786602240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sZtec6GChkFVt7/C1bKbl1bNbj1OFb+s6RfoXi8ur28=;
        b=dYWgRlb71rPUEekQoLayDuCjqtxQwrQ28i4El/hfzVJyK46SCpJ07DoAlgW2oylaTR
         8MD7acWq3fPXwWnV4Ur4SrXaJoeHyv802LzwDQCbNG4EZr+92l4uqf5gWMz2DPS00sfk
         IliwWeccBga9F+Loi8IHcfpP4KzBfFfItZ9cP35iI35AKKu/NlHxm3EzhVgzeLmfyTd0
         OrKVsW/O5uoP+Hz2q/mxYIKg109rmfN5T6IL/oEjaokNLZ1lyVScyN9ComH8dhrHQ0rw
         mTSqtwYKOtGqEz33+PcCnpOYA4ptv4Fx5XFbVcGYJVanoYLyr03NuvuksXeXbVs4CtKx
         yslQ==
X-Forwarded-Encrypted: i=1; AHgh+RqzxtP5D+ONyvyq2SnNiCSuww6vwotF2yEhhjsIhGaXuRh8bu4arJufbJjCtKF5IKs18lSQrCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrtRELxcVw4IY7ZAfYrUfRyAbfQdRJBfx53QwNMspNPgq+OvxZ
	GxoNCzH5gpGwdOCpTJYmyEjzKSzyNo7Ce7oc0KjN9TJzu+d5x+ZzlRp2
X-Gm-Gg: AR+sD10d0jJooTL0JxkdsntSy3BJB2/pXPI9ZMGFqDxy2BXmxWk+22Zvg54HansvY3O
	urRZhzrDtDn5s4jS23OofPt+jl92/Yd42rLVzSLa1k+9+tCIP2IvdqR8D6g3fMKbt1nXZF5Tt2q
	Aax+6PZw4l2ZrEY26aLbJm7Ky+aN9Zo2410WbECk71E+NPs5txOEkvIisgSVet19zpE87fjBryz
	31KHSfteJzoKlQHk2jilCVjNB66odSDc5EdzbomkVIoo+rZr4mvXko/g1sIeCGGoqNARMmSzoBO
	JMfOYRBex6+0sIw4YCD96sZ4rIJoPI0dsL3x0OHQLgGee4cRb+An+dKtyzfkVoLaeHBZKPKls0M
	TngN3NdROvjj2hliieqza8ixPSPEz3A8gCMngj1p2Ki4SOIQyZ4IR3hxrhp0l/sBb+4tcOffINo
	vSHFjC3ICxav2TK0kaLZmq9TahiEvSn9Y9YUgJ3k3hqotwFs9YLzFqQiTHS35oxT4lMoXpcVjTL
	S1/GSEqnCLmbKhiMpCb5tMxUCtab5IcIXa2g9o+KKbKR90CfA4BPQ8zkCZxeabfdsyOGripXRk3
	nvkTn3JV3IGcdKGBhOpMnLPCAR1DR6m+A4YUoJ21Eq74TdBRuuaF7I4I4Jnv7IaoZmzfty/SLrC
	OmfI=
X-Received: by 2002:a05:600c:a45:b0:495:6478:2dbc with SMTP id 5b1f17b1804b1-4994e73cc5cmr155960195e9.6.1785997439891;
        Wed, 05 Aug 2026 23:23:59 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-adf9-2301-8c14-6be6-a9e6-a2d4.310.pool.telefonica.de. [2a02:3100:adf9:2301:8c14:6be6:a9e6:a2d4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff79b4e5asm3356902f8f.15.2026.08.05.23.23.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 05 Aug 2026 23:23:59 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Fuad Tabba <tabba@google.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	grayhat@foxmail.com
Subject: [PATCH v2] KVM: arm64: nv: Keep the shadow S2 MMUs at fixed addresses
Date: Thu,  6 Aug 2026 08:23:52 +0200
Message-Id: <20260806062352.93489-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vcpu->arch.hw_mmu caches the S2 MMU the vCPU currently runs on; outside
of a hyp context, that is one of the shadow S2 MMUs.
kvm_vcpu_init_nested() can grow kvm->arch.nested_mmus while initialising
another vCPU: it copies the MMUs, publishes the new allocation, and frees
the old one.  It updates pgt->mmu back-pointers, but not hw_mmu, leaving
already-running vCPUs with pointers to freed memory.  hw_mmu cannot be
fixed up the same way: a running vCPU reads it without holding mmu_lock.

The reallocation similarly leaves the nested S2 ptdump file's debugfs
private data pointing into the freed array, and the copied refcounts stay
elevated forever as running vCPUs drop their references to the old entries.

KASAN reports the cached hw_mmu access as a slab-use-after-free in
kvm_handle_guest_abort().

Turn nested_mmus into a pointer table allocated once for the maximum
number of vCPUs during VM creation.  Allocate the MMUs separately as
vCPUs are initialised and append their pointers to that table.  The MMU
objects never move, so cached hw_mmu pointers, pgt->mmu back-pointers,
ptdump private data, and refcounts remain valid.

Operations that inspect nested_mmus on a live VM hold mmu_lock and
iterate only up to nested_mmus_size, so entries above it are invisible
and updating nested_mmus_size under the lock is the only publication
that needs ordering.

The old failure path passed uninitialised entries to kvm_free_stage2_pgd(),
which derives the kvm pointer from mmu->arch; free only the MMUs that were
fully initialised.

Fixes: 4f128f8e1aaa ("KVM: arm64: nv: Support multiple nested Stage-2 mmu structures")
Cc: stable@vger.kernel.org
Suggested-by: Marc Zyngier <maz@kernel.org>
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 arch/arm64/include/asm/kvm_host.h   |  6 +-
 arch/arm64/include/asm/kvm_nested.h |  2 +-
 arch/arm64/kvm/arm.c                |  7 ++-
 arch/arm64/kvm/nested.c             | 90 +++++++++++++++++------------
 4 files changed, 61 insertions(+), 44 deletions(-)

Changes in v2:
- Allocate the fixed pointer table during VM creation, as suggested by Marc.
- Allocate the MMUs individually and simplify the error and teardown paths.
- Drop the selftest patch that triggered KASAN.
  It is not a good fit for the existing suite.

v1: https://lore.kernel.org/r/20260803224405.41468-1-kmehltretter@gmail.com/

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index bae2c4f92ef5..59d1d77ee116 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -319,10 +319,10 @@ struct kvm_arch {
 	u64 fgu[__NR_FGT_GROUP_IDS__];
 
 	/*
-	 * Stage 2 paging state for VMs with nested S2 using a virtual
-	 * VMID.
+	 * Stage 2 paging state for VMs with nested S2 using a virtual VMID.
+	 * MMUs are allocated separately to keep their addresses stable.
 	 */
-	struct kvm_s2_mmu *nested_mmus;
+	struct kvm_s2_mmu **nested_mmus;
 	size_t nested_mmus_size;
 	int nested_mmus_next;
 
diff --git a/arch/arm64/include/asm/kvm_nested.h b/arch/arm64/include/asm/kvm_nested.h
index 012d711034d1..d21be647ac57 100644
--- a/arch/arm64/include/asm/kvm_nested.h
+++ b/arch/arm64/include/asm/kvm_nested.h
@@ -66,7 +66,7 @@ static inline u64 translate_ttbr0_el2_to_ttbr0_el1(u64 ttbr0)
 
 extern bool forward_smc_trap(struct kvm_vcpu *vcpu);
 extern bool forward_debug_exception(struct kvm_vcpu *vcpu);
-extern void kvm_init_nested(struct kvm *kvm);
+extern int kvm_init_nested(struct kvm *kvm);
 extern int kvm_vcpu_init_nested(struct kvm_vcpu *vcpu);
 extern void kvm_init_nested_s2_mmu(struct kvm_s2_mmu *mmu);
 extern struct kvm_s2_mmu *lookup_s2_mmu(struct kvm_vcpu *vcpu);
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 50adfff75be8..e883e45382fb 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -223,8 +223,6 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	mutex_unlock(&kvm->lock);
 #endif
 
-	kvm_init_nested(kvm);
-
 	ret = kvm_share_hyp(kvm, kvm + 1);
 	if (ret)
 		return ret;
@@ -239,6 +237,10 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	if (ret)
 		goto err_free_cpumask;
 
+	ret = kvm_init_nested(kvm);
+	if (ret)
+		goto err_uninit_mmu;
+
 	if (is_protected_kvm_enabled()) {
 		/*
 		 * If any failures occur after this is successful, make sure to
@@ -267,6 +269,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 err_uninit_mmu:
 	kvm_uninit_stage2_mmu(kvm);
+	kvfree(kvm->arch.nested_mmus);
 err_free_cpumask:
 	free_cpumask_var(kvm->arch.supported_cpus);
 err_unshare_kvm:
diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index dfb96edbdc43..90bb17a819a1 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -44,11 +44,19 @@ struct vncr_tlb {
  */
 #define S2_MMU_PER_VCPU		2
 
-void kvm_init_nested(struct kvm *kvm)
+int kvm_init_nested(struct kvm *kvm)
 {
-	kvm->arch.nested_mmus = NULL;
+	/* Allocate the fixed-size pointer table once per VM. */
+	kvm->arch.nested_mmus = kvcalloc(KVM_MAX_VCPUS * S2_MMU_PER_VCPU,
+					 sizeof(*kvm->arch.nested_mmus),
+					 GFP_KERNEL_ACCOUNT);
+	if (!kvm->arch.nested_mmus)
+		return -ENOMEM;
+
 	kvm->arch.nested_mmus_size = 0;
 	atomic_set(&kvm->arch.vncr_map_count, 0);
+
+	return 0;
 }
 
 static int init_nested_s2_mmu(struct kvm *kvm, struct kvm_s2_mmu *mmu)
@@ -66,11 +74,17 @@ static int init_nested_s2_mmu(struct kvm *kvm, struct kvm_s2_mmu *mmu)
 	return kvm_init_stage2_mmu(kvm, mmu, kvm_get_pa_bits(kvm));
 }
 
+static void free_nested_s2_mmu(struct kvm_s2_mmu *mmu)
+{
+	kvm_free_stage2_pgd(mmu);
+	kfree(mmu);
+}
+
 int kvm_vcpu_init_nested(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = vcpu->kvm;
-	struct kvm_s2_mmu *tmp;
-	int num_mmus, ret = 0;
+	struct kvm_s2_mmu *mmu;
+	int num_mmus, ret, i;
 
 	if (test_bit(KVM_ARM_VCPU_HAS_EL2_E2H0, kvm->arch.vcpu_features) &&
 	    !cpus_have_final_cap(ARM64_HAS_HCR_NV1))
@@ -91,44 +105,44 @@ int kvm_vcpu_init_nested(struct kvm_vcpu *vcpu)
 	 */
 	num_mmus = atomic_read(&kvm->online_vcpus) * S2_MMU_PER_VCPU;
 
-	if (num_mmus > kvm->arch.nested_mmus_size) {
-		tmp = kvcalloc(num_mmus, sizeof(*tmp), GFP_KERNEL_ACCOUNT);
-		if (!tmp)
-			return -ENOMEM;
-
-		write_lock(&kvm->mmu_lock);
+	if (num_mmus <= kvm->arch.nested_mmus_size)
+		return 0;
 
-		if (kvm->arch.nested_mmus_size) {
-			memcpy(tmp, kvm->arch.nested_mmus,
-			       size_mul(sizeof(*tmp), kvm->arch.nested_mmus_size));
+	lockdep_assert_held(&kvm->arch.config_lock);
 
-			for (int i = 0; i < kvm->arch.nested_mmus_size; i++)
-				tmp[i].pgt->mmu = &tmp[i];
+	for (i = 0; i < S2_MMU_PER_VCPU; i++) {
+		mmu = kzalloc_obj(*mmu, GFP_KERNEL_ACCOUNT);
+		if (!mmu) {
+			ret = -ENOMEM;
+			goto err_free_mmus;
 		}
 
-		swap(kvm->arch.nested_mmus, tmp);
-
-		write_unlock(&kvm->mmu_lock);
+		ret = init_nested_s2_mmu(kvm, mmu);
+		if (ret) {
+			kfree(mmu);
+			goto err_free_vncr;
+		}
 
-		kvfree(tmp);
+		kvm->arch.nested_mmus[kvm->arch.nested_mmus_size + i] = mmu;
 	}
 
-	for (int i = kvm->arch.nested_mmus_size; !ret && i < num_mmus; i++)
-		ret = init_nested_s2_mmu(kvm, &kvm->arch.nested_mmus[i]);
+	write_lock(&kvm->mmu_lock);
 
-	if (ret) {
-		for (int i = kvm->arch.nested_mmus_size; i < num_mmus; i++)
-			kvm_free_stage2_pgd(&kvm->arch.nested_mmus[i]);
+	kvm->arch.nested_mmus_size += S2_MMU_PER_VCPU;
 
-		free_page((unsigned long)vcpu->arch.ctxt.vncr_array);
-		vcpu->arch.ctxt.vncr_array = NULL;
+	write_unlock(&kvm->mmu_lock);
 
-		return ret;
-	}
+	return 0;
 
-	kvm->arch.nested_mmus_size = num_mmus;
+err_free_vncr:
+	free_page((unsigned long)vcpu->arch.ctxt.vncr_array);
+	vcpu->arch.ctxt.vncr_array = NULL;
 
-	return 0;
+err_free_mmus:
+	while (i--)
+		free_nested_s2_mmu(kvm->arch.nested_mmus[kvm->arch.nested_mmus_size + i]);
+
+	return ret;
 }
 
 struct s2_walk_info {
@@ -725,7 +739,7 @@ void kvm_s2_mmu_iterate_by_vmid(struct kvm *kvm, u16 vmid,
 	write_lock(&kvm->mmu_lock);
 
 	for (int i = 0; i < kvm->arch.nested_mmus_size; i++) {
-		struct kvm_s2_mmu *mmu = &kvm->arch.nested_mmus[i];
+		struct kvm_s2_mmu *mmu = kvm->arch.nested_mmus[i];
 
 		if (!kvm_s2_mmu_valid(mmu))
 			continue;
@@ -767,7 +781,7 @@ struct kvm_s2_mmu *lookup_s2_mmu(struct kvm_vcpu *vcpu)
 	 *   if S2 translation is disabled.
 	 */
 	for (int i = 0; i < kvm->arch.nested_mmus_size; i++) {
-		struct kvm_s2_mmu *mmu = &kvm->arch.nested_mmus[i];
+		struct kvm_s2_mmu *mmu = kvm->arch.nested_mmus[i];
 
 		if (!kvm_s2_mmu_valid(mmu))
 			continue;
@@ -806,7 +820,7 @@ static struct kvm_s2_mmu *get_s2_mmu_nested(struct kvm_vcpu *vcpu)
 	for (i = kvm->arch.nested_mmus_next;
 	     i < (kvm->arch.nested_mmus_size + kvm->arch.nested_mmus_next);
 	     i++) {
-		s2_mmu = &kvm->arch.nested_mmus[i % kvm->arch.nested_mmus_size];
+		s2_mmu = kvm->arch.nested_mmus[i % kvm->arch.nested_mmus_size];
 
 		if (atomic_read(&s2_mmu->refcnt) == 0)
 			break;
@@ -1223,7 +1237,7 @@ void kvm_nested_s2_wp(struct kvm *kvm)
 		return;
 
 	for (i = 0; i < kvm->arch.nested_mmus_size; i++) {
-		struct kvm_s2_mmu *mmu = &kvm->arch.nested_mmus[i];
+		struct kvm_s2_mmu *mmu = kvm->arch.nested_mmus[i];
 
 		if (kvm_s2_mmu_valid(mmu))
 			kvm_stage2_wp_range(mmu, 0, kvm_phys_size(mmu));
@@ -1242,7 +1256,7 @@ void kvm_nested_s2_unmap(struct kvm *kvm, bool may_block)
 		return;
 
 	for (i = 0; i < kvm->arch.nested_mmus_size; i++) {
-		struct kvm_s2_mmu *mmu = &kvm->arch.nested_mmus[i];
+		struct kvm_s2_mmu *mmu = kvm->arch.nested_mmus[i];
 
 		if (kvm_s2_mmu_valid(mmu))
 			kvm_stage2_unmap_range(mmu, 0, kvm_phys_size(mmu), may_block);
@@ -1261,7 +1275,7 @@ void kvm_nested_s2_flush(struct kvm *kvm)
 		return;
 
 	for (i = 0; i < kvm->arch.nested_mmus_size; i++) {
-		struct kvm_s2_mmu *mmu = &kvm->arch.nested_mmus[i];
+		struct kvm_s2_mmu *mmu = kvm->arch.nested_mmus[i];
 
 		if (kvm_s2_mmu_valid(mmu))
 			kvm_stage2_flush_range(mmu, 0, kvm_phys_size(mmu));
@@ -1273,10 +1287,10 @@ void kvm_arch_flush_shadow_all(struct kvm *kvm)
 	int i;
 
 	for (i = 0; i < kvm->arch.nested_mmus_size; i++) {
-		struct kvm_s2_mmu *mmu = &kvm->arch.nested_mmus[i];
+		struct kvm_s2_mmu *mmu = kvm->arch.nested_mmus[i];
 
 		if (!WARN_ON(atomic_read(&mmu->refcnt)))
-			kvm_free_stage2_pgd(mmu);
+			free_nested_s2_mmu(mmu);
 	}
 	kvfree(kvm->arch.nested_mmus);
 	kvm->arch.nested_mmus = NULL;
-- 
2.39.5 (Apple Git-154)

