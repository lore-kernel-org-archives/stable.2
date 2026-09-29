Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197165111AB
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682007; cv=none; b=rc6OvJJ6IOWFIasL7k4XPxyu9OmvxF4pL/zNISusTAfjAIfhYvq/ZEkzdmV7KWJPLzfDbPfb0M6XD369IietC8Rhw8YOGz+y4lkqxwGKGHEoTS364LvDK/eXsTCPLFBQQo4tJ2X0jpTTyfP3qkmVekQdeLZ5DApypvPjAfsNR+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682007; c=relaxed/simple;
	bh=xza6RgOv08RMdVAc4zSfwVbGmVF2FNxBJTaqjLduwlE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tep92ff4ZPX74PCsQ7b5CownkIfgzfDN9aa+aKMK7/z/RSHhM7gxwcjYU7VWVMIj6flrVFHo8Qwn3H7h1yRwf6+KEMu3jXkJATLh2vB+70prmWvzKF+L91h7/zC0vub3b/g/yctsbhfAfBBPZAwZmoYh6eYXXyz3qlfJDf8nEaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SeDbUDj+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SeDbUDj+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527541F000FF;
	Tue, 29 Sep 2026 11:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790682005;
	bh=NhDGssebJzH4i2XO0U9keyfAVXAzSj/SwpxWLkUbjg8=;
	h=Subject:To:Cc:From:Date;
	b=SeDbUDj+H5RtO3qQC0TekLfs/prk5zjnZMEvwREToKIs6Y7gs1DpSmAGk1ZDiA70A
	 /oDsb2/ggup/M1jQMyhanpPtWC1UdhLP1sYq0cjgQd4l3MbAvPqt6sXiPpbYiE3C9Z
	 C8Qhuwn2P3E31ZdyKNV38Lkg0p/aIBOJqH7D/2xA=
Subject: FAILED: patch "[PATCH] KVM: arm64: nv: Fix life cycle of the nested_mmus array" failed to apply to 6.12-stable tree
To: maz@kernel.org,grayhat@foxmail.com,kmehltretter@gmail.com,ljs@kernel.org,oupton@kernel.org,weilin.chang@arm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 13:39:50 +0200
Message-ID: <2026092949-cider-outdated-8627@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 33346f8960c7bb6a3b4e273b5cfe25c5a8be349f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092949-cider-outdated-8627@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 33346f8960c7bb6a3b4e273b5cfe25c5a8be349f Mon Sep 17 00:00:00 2001
From: Marc Zyngier <maz@kernel.org>
Date: Fri, 11 Sep 2026 17:22:02 +0100
Subject: [PATCH] KVM: arm64: nv: Fix life cycle of the nested_mmus array

The nested_mmus array holds the shadow page tables that are used when
a guest is running a nested context. These structures are allocated on
VCPU_INIT for whole guest, which implies that they may have to be
relocated as the array grows.

Should a VCPU_INIT occur whilst a vcpu is actively running an L2 and
that the allocation requires relocation, that vcpu will still be
running with a pointer to the previous structure, which will have been
freed.

Fix this by turning the array of structures to an array of pointers,
which is now allocated at VM creation, sized to the absolute maximum
that KVM can handle.

In turn, each VCPU_INIT contributes S2_MMU_PER_VCPU to the pool. No
reallocation is ever performed, and the life cycle of each object is
much clearer:

- the nested_mmus array is allocated in kvm_init_nested(), and freed
  in kvm_arch_destroy_vm()

- s2_mmu structures are allocated in kvm_vcpu_init_nested(), and freed
  on kvm_arch_flush_shadow_all()

Finally, the freeing of vcpu->arch.vncr_array is made consistent
rather than being done on some failure paths, but not others.

Fixes: 4f128f8e1aaa ("KVM: arm64: nv: Support multiple nested Stage-2 mmu structures")
Reported-by: Shen Yongchao <grayhat@foxmail.com>
Reported-by: Karl Mehltretter <kmehltretter@gmail.com>
Suggested-by: Karl Mehltretter <kmehltretter@gmail.com>
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Link: https://lore.kernel.org/r/20260803224405.41468-1-kmehltretter@gmail.com
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
Reviewed-by: Wei-Lin Chang <weilin.chang@arm.com>
Link: https://patch.msgid.link/20260911162203.1919330-2-maz@kernel.org
Signed-off-by: Oliver Upton <oupton@kernel.org>

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 27fe0cd5b2d7..cd9b9d2462f9 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -322,7 +322,7 @@ struct kvm_arch {
 	 * Stage 2 paging state for VMs with nested S2 using a virtual
 	 * VMID.
 	 */
-	struct kvm_s2_mmu *nested_mmus;
+	struct kvm_s2_mmu **nested_mmus;
 	size_t nested_mmus_size;
 	int nested_mmus_next;
 
diff --git a/arch/arm64/include/asm/kvm_nested.h b/arch/arm64/include/asm/kvm_nested.h
index 1ed708335809..5b8edb2e8a87 100644
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
index 8b080804bc90..b53219e048bd 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -236,8 +236,6 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	mutex_unlock(&kvm->lock);
 #endif
 
-	kvm_init_nested(kvm);
-
 	ret = kvm_share_hyp(kvm, kvm + 1);
 	if (ret)
 		return ret;
@@ -252,6 +250,10 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	if (ret)
 		goto err_free_cpumask;
 
+	ret = kvm_init_nested(kvm);
+	if (ret)
+		goto err_uninit_mmu;
+
 	if (is_protected_kvm_enabled()) {
 		/*
 		 * If any failures occur after this is successful, make sure to
@@ -280,6 +282,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 err_uninit_mmu:
 	kvm_uninit_stage2_mmu(kvm);
+	kvfree(kvm->arch.nested_mmus);
 err_free_cpumask:
 	free_cpumask_var(kvm->arch.supported_cpus);
 err_unshare_kvm:
@@ -337,6 +340,7 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 
 	kvm_unshare_hyp(kvm, kvm + 1);
 
+	kvfree(kvm->arch.nested_mmus);
 	kvm_arm_teardown_hypercalls(kvm);
 }
 
diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index a0808391a456..2571f177e654 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -45,11 +45,15 @@ struct vncr_tlb {
  */
 #define S2_MMU_PER_VCPU		2
 
-void kvm_init_nested(struct kvm *kvm)
+int kvm_init_nested(struct kvm *kvm)
 {
-	kvm->arch.nested_mmus = NULL;
+	kvm->arch.nested_mmus = kvmalloc_objs(struct kvm_s2_mmu *,
+					      KVM_MAX_VCPUS * S2_MMU_PER_VCPU,
+					      GFP_KERNEL_ACCOUNT);
 	kvm->arch.nested_mmus_size = 0;
 	atomic_set(&kvm->arch.vncr_tlb_count, 0);
+
+	return kvm->arch.nested_mmus ? 0 : -ENOMEM;
 }
 
 static int init_nested_s2_mmu(struct kvm *kvm, struct kvm_s2_mmu *mmu)
@@ -70,8 +74,9 @@ static int init_nested_s2_mmu(struct kvm *kvm, struct kvm_s2_mmu *mmu)
 int kvm_vcpu_init_nested(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = vcpu->kvm;
-	struct kvm_s2_mmu *tmp;
-	int num_mmus, ret = 0;
+	int num_mmus;
+
+	lockdep_assert_held(&kvm->arch.config_lock);
 
 	if (test_bit(KVM_ARM_VCPU_HAS_EL2_E2H0, kvm->arch.vcpu_features) &&
 	    !cpus_have_final_cap(ARM64_HAS_HCR_NV1))
@@ -84,51 +89,40 @@ int kvm_vcpu_init_nested(struct kvm_vcpu *vcpu)
 	if (!vcpu->arch.ctxt.vncr_array)
 		return -ENOMEM;
 
-	/*
-	 * Let's treat memory allocation failures as benign: If we fail to
-	 * allocate anything, return an error and keep the allocated array
-	 * alive. Userspace may try to recover by initializing the vcpu
-	 * again, and there is no reason to affect the whole VM for this.
-	 */
 	num_mmus = atomic_read(&kvm->online_vcpus) * S2_MMU_PER_VCPU;
 
 	if (num_mmus > kvm->arch.nested_mmus_size) {
-		tmp = kvzalloc_objs(*tmp, num_mmus, GFP_KERNEL_ACCOUNT);
+		struct kvm_s2_mmu *tmp;
+		int i, ret = 0;
+
+		tmp = kvzalloc_objs(*tmp, S2_MMU_PER_VCPU, GFP_KERNEL_ACCOUNT);
 		if (!tmp)
-			return -ENOMEM;
+			ret = -ENOMEM;
 
-		write_lock(&kvm->mmu_lock);
-
-		if (kvm->arch.nested_mmus_size) {
-			memcpy(tmp, kvm->arch.nested_mmus,
-			       size_mul(sizeof(*tmp), kvm->arch.nested_mmus_size));
-
-			for (int i = 0; i < kvm->arch.nested_mmus_size; i++)
-				tmp[i].pgt->mmu = &tmp[i];
+		for (i = 0; !ret && i < S2_MMU_PER_VCPU; i++) {
+			ret = init_nested_s2_mmu(kvm, &tmp[i]);
+			if (ret)
+				break;
 		}
 
-		swap(kvm->arch.nested_mmus, tmp);
+		if (ret) {
+			while (--i >= 0)
+				kvm_free_stage2_pgd(&tmp[i]);
 
-		write_unlock(&kvm->mmu_lock);
+			kvfree(tmp);
+			free_page((unsigned long)vcpu->arch.ctxt.vncr_array);
+			vcpu->arch.ctxt.vncr_array = NULL;
+			return ret;
+		}
 
-		kvfree(tmp);
+		guard(write_lock)(&kvm->mmu_lock);
+
+		for (i = 0; i < S2_MMU_PER_VCPU; i++)
+			kvm->arch.nested_mmus[i + kvm->arch.nested_mmus_size] = &tmp[i];
+
+		kvm->arch.nested_mmus_size += S2_MMU_PER_VCPU;
 	}
 
-	for (int i = kvm->arch.nested_mmus_size; !ret && i < num_mmus; i++)
-		ret = init_nested_s2_mmu(kvm, &kvm->arch.nested_mmus[i]);
-
-	if (ret) {
-		for (int i = kvm->arch.nested_mmus_size; i < num_mmus; i++)
-			kvm_free_stage2_pgd(&kvm->arch.nested_mmus[i]);
-
-		free_page((unsigned long)vcpu->arch.ctxt.vncr_array);
-		vcpu->arch.ctxt.vncr_array = NULL;
-
-		return ret;
-	}
-
-	kvm->arch.nested_mmus_size = num_mmus;
-
 	return 0;
 }
 
@@ -742,7 +736,7 @@ void kvm_s2_mmu_iterate_by_vmid(struct kvm *kvm, u16 vmid,
 	write_lock(&kvm->mmu_lock);
 
 	for (int i = 0; i < kvm->arch.nested_mmus_size; i++) {
-		struct kvm_s2_mmu *mmu = &kvm->arch.nested_mmus[i];
+		struct kvm_s2_mmu *mmu = kvm->arch.nested_mmus[i];
 
 		if (!kvm_s2_mmu_valid(mmu))
 			continue;
@@ -784,7 +778,7 @@ struct kvm_s2_mmu *lookup_s2_mmu(struct kvm_vcpu *vcpu)
 	 *   if S2 translation is disabled.
 	 */
 	for (int i = 0; i < kvm->arch.nested_mmus_size; i++) {
-		struct kvm_s2_mmu *mmu = &kvm->arch.nested_mmus[i];
+		struct kvm_s2_mmu *mmu = kvm->arch.nested_mmus[i];
 
 		if (!kvm_s2_mmu_valid(mmu))
 			continue;
@@ -823,7 +817,7 @@ static struct kvm_s2_mmu *get_s2_mmu_nested(struct kvm_vcpu *vcpu)
 	for (i = kvm->arch.nested_mmus_next;
 	     i < (kvm->arch.nested_mmus_size + kvm->arch.nested_mmus_next);
 	     i++) {
-		s2_mmu = &kvm->arch.nested_mmus[i % kvm->arch.nested_mmus_size];
+		s2_mmu = kvm->arch.nested_mmus[i % kvm->arch.nested_mmus_size];
 
 		if (atomic_read(&s2_mmu->refcnt) == 0)
 			break;
@@ -1281,7 +1275,7 @@ void kvm_nested_s2_wp(struct kvm *kvm)
 		return;
 
 	for (i = 0; i < kvm->arch.nested_mmus_size; i++) {
-		struct kvm_s2_mmu *mmu = &kvm->arch.nested_mmus[i];
+		struct kvm_s2_mmu *mmu = kvm->arch.nested_mmus[i];
 
 		if (kvm_s2_mmu_valid(mmu))
 			kvm_stage2_wp_range(mmu, 0, kvm_phys_size(mmu));
@@ -1300,7 +1294,7 @@ void kvm_nested_s2_unmap(struct kvm *kvm, bool may_block)
 		return;
 
 	for (i = 0; i < kvm->arch.nested_mmus_size; i++) {
-		struct kvm_s2_mmu *mmu = &kvm->arch.nested_mmus[i];
+		struct kvm_s2_mmu *mmu = kvm->arch.nested_mmus[i];
 
 		if (kvm_s2_mmu_valid(mmu))
 			kvm_stage2_unmap_range(mmu, 0, kvm_phys_size(mmu), may_block);
@@ -1319,7 +1313,7 @@ void kvm_nested_s2_flush(struct kvm *kvm)
 		return;
 
 	for (i = 0; i < kvm->arch.nested_mmus_size; i++) {
-		struct kvm_s2_mmu *mmu = &kvm->arch.nested_mmus[i];
+		struct kvm_s2_mmu *mmu = kvm->arch.nested_mmus[i];
 
 		if (kvm_s2_mmu_valid(mmu))
 			kvm_stage2_flush_range(mmu, 0, kvm_phys_size(mmu));
@@ -1328,16 +1322,15 @@ void kvm_nested_s2_flush(struct kvm *kvm)
 
 void kvm_arch_flush_shadow_all(struct kvm *kvm)
 {
-	int i;
-
-	for (i = 0; i < kvm->arch.nested_mmus_size; i++) {
-		struct kvm_s2_mmu *mmu = &kvm->arch.nested_mmus[i];
+	for (int i = kvm->arch.nested_mmus_size - 1; i >= 0; i--) {
+		struct kvm_s2_mmu *mmu = kvm->arch.nested_mmus[i];
 
 		if (!WARN_ON(atomic_read(&mmu->refcnt)))
 			kvm_free_stage2_pgd(mmu);
+
+		if ((i % S2_MMU_PER_VCPU) == 0)
+			kvfree(mmu);
 	}
-	kvfree(kvm->arch.nested_mmus);
-	kvm->arch.nested_mmus = NULL;
 	kvm->arch.nested_mmus_size = 0;
 	kvm_uninit_stage2_mmu(kvm);
 }

