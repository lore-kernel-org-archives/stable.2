Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FBF33FE15
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 22:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785797062; cv=none; b=WCoR/fGaltJ0tH2bfZgkmFiI+tRf5XnnG2/hDtcetRV7KeI48gzEyd3ej+O7a1QvmFvaRN4VKDenLWqBhY30oWLtCIsBFMGBqLzXwXZl1AHMWm3B7xNW/YbSrox2URKr/6jd1jxSc65k1zzYUrc8UTMT0vxqVPGck5irhsdGi8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785797062; c=relaxed/simple;
	bh=8tEf08+M05wAtfNLABdkntRWnfi1nh+gHafD8skemv0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P2V6dLJMvA/6QEFxDlQx1OUfWZMTqUUdvqCLxgohzG/72gY91tAn9Ba+j2OJOCipxvug5UTn3a+OLX0NK3LfEOEBBtVrIEorVxpK16ODn6qUSVY+cI9Zir3AyDiSJqtrSHLxTbuibugw8hUQPj72RRWGEmfJE2KyEzuQvku+2a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8NMy2lL; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8NMy2lL"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-495635a85d2so23981045e9.0
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 15:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785797059; x=1786401859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wXVKLiTea0/59JUrrH+7PA7Bo3NKwmFvSDJL86vx0Jw=;
        b=l8NMy2lL5hd6WpZnl+8onFmvrS1XhSDUDtAqbTXQKS6UaXw3BU9xZ2OkpeYI+e2X9v
         5rCxtJ0ihWg34HdjcUWwLfx7Ku3Osuhm1G7oGVgvF8TzGNpmfTU/IV4gHv16bFupsGMv
         czes9jXb3olV54ozqFtdCfZVW8HmjQHw4t1cxWH3FwS/k6wBrlFZB6rnPkShQzhqRKF1
         YjK6ijK4Pg3Qj0xIzm287HRp48lOlMeKeZLWivr5Py/6Jg0O2xQ8d8ZisPdoSgDccriQ
         tnEyrQcqAczg/4Unw3AcjAYYyLLwswoj0NHA5KbzQsc9CLQtMK4heQjAx+rdcjiliUOX
         RQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785797059; x=1786401859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wXVKLiTea0/59JUrrH+7PA7Bo3NKwmFvSDJL86vx0Jw=;
        b=kW2VU8pM+RcWIIpVjKRYwytFuPHSx2c5zNHWQPi3Q/VPqsXVr2HAgzV1xgtK6z6bXl
         tYIlsRnDL+eqQQ6yN1H1EDpOxIoYiu1FOSge4oBoD4YQXsIYfCBPa2+bf5phBnBP688G
         eSsWezLr6cOxEgg6RMF1/7e84orRflWaha0fcpQyC73OCgK0v3o5dhpfwzDHLO3aZkK8
         eoojz2DPV5FFNNhSv2vQdIXdfctrELx8ZAcpEUgahc9w0W69YyZY69doQC3+2TUzbrqI
         PZ65pJZ/reUNco9Ok1dBmx5gpFYXXNvZMmqmWDFqmiPMrEZRZpfuiScLC2CyvrKGckCu
         Ln3g==
X-Forwarded-Encrypted: i=1; AHgh+RokYXCZ4Y4qZm4sQ7IQFvCfqId4fqORm51MabJRFdtV1caVFJhGqI5G4GWwpxB4Ayu7nOXhE8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHW+dts5IBnQ4bbOTDJgCoNQUgn+JWE9sonFwmXIgNfuQmP3k9
	U3rGPLkNs5VhOVP91dowj7o7rRJjYLKrr1dZX1nuJlyzDhz182LkLq16
X-Gm-Gg: AR+sD11JK2+RFGcNS06AiAnVVpfB81yLSigeSun2pv7PVtZ8h/pCFiJCHowXiMJpJoc
	FPjsUskzbL5ohj0nOg5opY93bQ658LCZna9lTtrey8ap3irt/fo/mRedEeskPzMYVefgRSUI8W3
	4BpON1RpEgzbraz96wMTAV0TwADjiNBmDDIEuS545ZAEXnwJ8E/5/A8hHA0kSnv4vpqKpxLzeJU
	6COGktvF1ONdY0irNw2/RbJPdLdlMJ8ECyeuA13TDAvITMkfNMFPEJGhOYp+SQcFLpC/NfTc3Tr
	orxt1F49R9khnQNz/jYBRRebGE3KzpBjt4EDNax4TwSA+VRjIhUGEhjQFv2J0WfYCot2FSS/EFS
	6VAm/MDmXCgeF55UYVbeUmYg2G5FildIEKDlC/i26OXl/ETMLFV17QZIwkyAXp5DQsiF/+2FZqt
	JOd0VBkJnBrszmgljSSQAePFAfSePZhp58eLCSOhuyAjzM+FC6q/YRTSVmGCeaP/PT0Th5Bo1xH
	YECzvTJhcfDx9y7fBhgKD0yUjtwrQXAIvubtprkcdzEnDfDKlyt/IlndAJMZDiztiDeV3HvqOY2
	kY/WwfBfD2yOfIRPWcZC8xHwyf7sRh2YYEIZtKKG1yophkOAeWZiWjg/CyulQmd7PSW4
X-Received: by 2002:a05:600c:1908:b0:495:7838:7e25 with SMTP id 5b1f17b1804b1-4980ee9f00fmr252333455e9.15.1785797058758;
        Mon, 03 Aug 2026 15:44:18 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b3d4-c101-2c67-9805-4069-c4eb.310.pool.telefonica.de. [2a02:3100:b3d4:c101:2c67:9805:4069:c4eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd456a6cbsm32690944f8f.23.2026.08.03.15.44.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 03 Aug 2026 15:44:18 -0700 (PDT)
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
	stable@vger.kernel.org
Subject: [PATCH 1/2] KVM: arm64: nv: Allocate the shadow S2 MMUs individually
Date: Tue,  4 Aug 2026 00:44:04 +0200
Message-Id: <20260803224405.41468-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A vCPU in L2 caches its shadow S2 MMU in vcpu->arch.hw_mmu.
kvm_vcpu_init_nested() can grow kvm->arch.nested_mmus while initialising
another vCPU: it copies the MMUs, publishes the new allocation, and frees
the old one.  It updates pgt->mmu back-pointers, but not hw_mmu, leaving
the first vCPU with a pointer to freed memory.  hw_mmu cannot be fixed up
the same way: a running vCPU reads it without holding mmu_lock.  Copying
also duplicates the MMU's refcount, leaving the live copy permanently
elevated.

KASAN reports this as a slab-use-after-free in kvm_handle_guest_abort().

Make nested_mmus a pointer table and allocate each MMU separately.
Growing the table now moves only pointer entries, preserving cached
hw_mmu pointers, pgt->mmu back-pointers, and each MMU's refcount.  Fully
initialise new MMUs before publishing the table and its size under
mmu_lock.

The old failure path passed uninitialised entries to
kvm_free_stage2_pgd(), which needs mmu->arch.  Use an allocation helper
that returns only fully initialised MMUs, so error cleanup frees only
completed objects; kvm_init_stage2_mmu() unwinds a failed initialisation.

Fixes: 4f128f8e1aaa ("KVM: arm64: nv: Support multiple nested Stage-2 mmu structures")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---

Tested on an arm64 KASAN kernel under QEMU TCG with EL2 emulation
(-machine virt,virtualization=on -cpu max, kvm-arm.mode=nested): the
selftest in patch 2 reports the slab-use-after-free without this patch
and passes with it.

 arch/arm64/include/asm/kvm_host.h |  6 +-
 arch/arm64/kvm/nested.c           | 92 +++++++++++++++++++++----------
 2 files changed, 67 insertions(+), 31 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index bae2c4f92ef5..f587b01039f9 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -319,10 +319,10 @@ struct kvm_arch {
 	u64 fgu[__NR_FGT_GROUP_IDS__];
 
 	/*
-	 * Stage 2 paging state for VMs with nested S2 using a virtual
-	 * VMID.
+	 * Stage 2 paging state for VMs with nested S2 using a virtual VMID.
+	 * MMUs are individually allocated to keep their addresses stable.
 	 */
-	struct kvm_s2_mmu *nested_mmus;
+	struct kvm_s2_mmu **nested_mmus;
 	size_t nested_mmus_size;
 	int nested_mmus_next;
 
diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index dfb96edbdc43..af804a5ddca7 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/err.h>
 #include <linux/kvm.h>
 #include <linux/kvm_host.h>
 
@@ -66,11 +67,36 @@ static int init_nested_s2_mmu(struct kvm *kvm, struct kvm_s2_mmu *mmu)
 	return kvm_init_stage2_mmu(kvm, mmu, kvm_get_pa_bits(kvm));
 }
 
+static struct kvm_s2_mmu *alloc_nested_s2_mmu(struct kvm *kvm)
+{
+	struct kvm_s2_mmu *mmu;
+	int ret;
+
+	mmu = kzalloc_obj(*mmu, GFP_KERNEL_ACCOUNT);
+	if (!mmu)
+		return ERR_PTR(-ENOMEM);
+
+	ret = init_nested_s2_mmu(kvm, mmu);
+	if (ret) {
+		/* kvm_init_stage2_mmu() frees its internal allocations on error */
+		kfree(mmu);
+		return ERR_PTR(ret);
+	}
+
+	return mmu;
+}
+
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
+	struct kvm_s2_mmu **tmp;
+	int i, num_mmus, ret = 0;
 
 	if (test_bit(KVM_ARM_VCPU_HAS_EL2_E2H0, kvm->arch.vcpu_features) &&
 	    !cpus_have_final_cap(ARM64_HAS_HCR_NV1))
@@ -96,38 +122,48 @@ int kvm_vcpu_init_nested(struct kvm_vcpu *vcpu)
 		if (!tmp)
 			return -ENOMEM;
 
+		/*
+		 * Populate new slots before publishing: table walkers hold
+		 * mmu_lock and iterate up to nested_mmus_size.
+		 */
+		for (i = kvm->arch.nested_mmus_size; i < num_mmus; i++) {
+			struct kvm_s2_mmu *mmu = alloc_nested_s2_mmu(kvm);
+
+			if (IS_ERR(mmu)) {
+				ret = PTR_ERR(mmu);
+				break;
+			}
+
+			tmp[i] = mmu;
+		}
+
+		if (ret) {
+			while (i-- > kvm->arch.nested_mmus_size)
+				free_nested_s2_mmu(tmp[i]);
+
+			kvfree(tmp);
+
+			free_page((unsigned long)vcpu->arch.ctxt.vncr_array);
+			vcpu->arch.ctxt.vncr_array = NULL;
+
+			return ret;
+		}
+
 		write_lock(&kvm->mmu_lock);
 
 		if (kvm->arch.nested_mmus_size) {
 			memcpy(tmp, kvm->arch.nested_mmus,
 			       size_mul(sizeof(*tmp), kvm->arch.nested_mmus_size));
-
-			for (int i = 0; i < kvm->arch.nested_mmus_size; i++)
-				tmp[i].pgt->mmu = &tmp[i];
 		}
 
 		swap(kvm->arch.nested_mmus, tmp);
+		kvm->arch.nested_mmus_size = num_mmus;
 
 		write_unlock(&kvm->mmu_lock);
 
 		kvfree(tmp);
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
 
@@ -725,7 +761,7 @@ void kvm_s2_mmu_iterate_by_vmid(struct kvm *kvm, u16 vmid,
 	write_lock(&kvm->mmu_lock);
 
 	for (int i = 0; i < kvm->arch.nested_mmus_size; i++) {
-		struct kvm_s2_mmu *mmu = &kvm->arch.nested_mmus[i];
+		struct kvm_s2_mmu *mmu = kvm->arch.nested_mmus[i];
 
 		if (!kvm_s2_mmu_valid(mmu))
 			continue;
@@ -767,7 +803,7 @@ struct kvm_s2_mmu *lookup_s2_mmu(struct kvm_vcpu *vcpu)
 	 *   if S2 translation is disabled.
 	 */
 	for (int i = 0; i < kvm->arch.nested_mmus_size; i++) {
-		struct kvm_s2_mmu *mmu = &kvm->arch.nested_mmus[i];
+		struct kvm_s2_mmu *mmu = kvm->arch.nested_mmus[i];
 
 		if (!kvm_s2_mmu_valid(mmu))
 			continue;
@@ -806,7 +842,7 @@ static struct kvm_s2_mmu *get_s2_mmu_nested(struct kvm_vcpu *vcpu)
 	for (i = kvm->arch.nested_mmus_next;
 	     i < (kvm->arch.nested_mmus_size + kvm->arch.nested_mmus_next);
 	     i++) {
-		s2_mmu = &kvm->arch.nested_mmus[i % kvm->arch.nested_mmus_size];
+		s2_mmu = kvm->arch.nested_mmus[i % kvm->arch.nested_mmus_size];
 
 		if (atomic_read(&s2_mmu->refcnt) == 0)
 			break;
@@ -1223,7 +1259,7 @@ void kvm_nested_s2_wp(struct kvm *kvm)
 		return;
 
 	for (i = 0; i < kvm->arch.nested_mmus_size; i++) {
-		struct kvm_s2_mmu *mmu = &kvm->arch.nested_mmus[i];
+		struct kvm_s2_mmu *mmu = kvm->arch.nested_mmus[i];
 
 		if (kvm_s2_mmu_valid(mmu))
 			kvm_stage2_wp_range(mmu, 0, kvm_phys_size(mmu));
@@ -1242,7 +1278,7 @@ void kvm_nested_s2_unmap(struct kvm *kvm, bool may_block)
 		return;
 
 	for (i = 0; i < kvm->arch.nested_mmus_size; i++) {
-		struct kvm_s2_mmu *mmu = &kvm->arch.nested_mmus[i];
+		struct kvm_s2_mmu *mmu = kvm->arch.nested_mmus[i];
 
 		if (kvm_s2_mmu_valid(mmu))
 			kvm_stage2_unmap_range(mmu, 0, kvm_phys_size(mmu), may_block);
@@ -1261,7 +1297,7 @@ void kvm_nested_s2_flush(struct kvm *kvm)
 		return;
 
 	for (i = 0; i < kvm->arch.nested_mmus_size; i++) {
-		struct kvm_s2_mmu *mmu = &kvm->arch.nested_mmus[i];
+		struct kvm_s2_mmu *mmu = kvm->arch.nested_mmus[i];
 
 		if (kvm_s2_mmu_valid(mmu))
 			kvm_stage2_flush_range(mmu, 0, kvm_phys_size(mmu));
@@ -1273,10 +1309,10 @@ void kvm_arch_flush_shadow_all(struct kvm *kvm)
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

base-commit: 38436106b2f5ceb55950a7098c1a5804de2bde62
-- 
2.39.5 (Apple Git-154)
