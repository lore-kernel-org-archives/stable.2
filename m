Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833988;
	b=SlSr6p1ztg+YJt1SUsJXAqwwWa7gPJSliq7pxBFkQNYB4LCbKuaIt7B20e6Dqll/vhve
	 4S7EdqqSto0o953QAXcMGM9yQPjwb5fyn8fmXZbeR1GuPm+KlpLyJJuXfqLfCrXP4w3K2
	 YCk9BRI4p5ge91WY2yBERDUTk10Hl2Vxetbvgz5aDx8NLtYkbs0lj8CY4L8mRdMvtN92I
	 inHL8aBRxMm6e3klTf2Tvah9ZqQXbeKO2AG16XHB89d9n9RDFbukvCostYFbyBV9c8bzV
	 CTvbEZke7/Bcwrt3mMmDz0E00XCfkvMHCgEnHYgwsns8xJmw+kITNsck0JCQMpj9tuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833988;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aqxDmOd1QM/Q86kuvBgtOg4sVmAthLLZBJJknYpMy+4=;
	b=agAURISiXJmiREaJa/VzrVvdrHP5lC2WX5vCQZquYPmiFsvAXsfbUqAGAIEvF/ONCc21
	 JBk2ymJSFuM+hFPi0dnw6rUK44lHn6aqGer9eo7beqRbXULNvEFrXq9gWhWVWVZ9+jWA8
	 6n/Cva2mrlqFFoYk/UjFFe99JwfcxPGBqdb5TIENoD7gkCt0+XPRrPdXLsU5uWFlvZ1ne
	 /3UZP3038azlHcjbzD+8o/9B/HYLAphE43Cp+AK4cx//X86Y+v0t+VP6AKc0UAuBI2MeA
	 P9xtdqoZuuTb9npEmen7oRuc+DRFpFsRpkECDsDYoR64K8Bnwws99W1KrT2J0d5CziA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=czvbGUdC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF335606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 23:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=czvbGUdC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA151F0093A;
	Wed,  4 Nov 2026 23:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793833987;
	bh=aqxDmOd1QM/Q86kuvBgtOg4sVmAthLLZBJJknYpMy+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=czvbGUdC5BZujos0Ujvm+GGfgGw6TzogiHpP9nuD65uMbf04RHtprtHTC/ZRdGnhJ
	 kNs8JUwNWmJB1D+lIu1qWwVqzkHw+m1C4or+393IQD7WN/gm3rNT/0DyuVSxlI4djH
	 gWU1DoHS+z2sR47nef2ejF9zOqZcMuI1mqbidscs/Zbzt0HVYi12eoEVoA3Az2bSwp
	 uxbZd56LC8L700bTBW46NTUCdLlZ7RXaWpfUi29gi7xjSNN/W9dfQpD0IAede707MZ
	 8+kcFXcK0Hdde/SsHmhVhSaRbO2xW4yzZRGg/CyJcK/Xbugv2Jj/fjENPCQ8vIJw9h
	 42B906lBlDszQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Christoph Schlameuss <schlameuss@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/4] KVM: s390: Enable KVM_GENERIC_MMU_NOTIFIER
Date: Wed,  4 Nov 2026 18:13:02 -0500
Message-ID: <20261104231214.887398-2-sashal@kernel.org>
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

From: Claudio Imbrenda <imbrenda@linux.ibm.com>

[ Upstream commit a2f2798fa6d18d91766b19a4896bd9fd0654d730 ]

Enable KVM_GENERIC_MMU_NOTIFIER, for now with empty placeholder callbacks.

Also enable KVM_MMU_LOCKLESS_AGING and define KVM_HAVE_MMU_RWLOCK.

Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Stable-dep-of: da260bcb56fe ("KVM: pfncache: use a dedicated invalidation sequence for cache refresh")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/include/asm/kvm_host.h |  1 +
 arch/s390/kvm/Kconfig            |  2 ++
 arch/s390/kvm/kvm-s390.c         | 45 +++++++++++++++++++++++++++++++-
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index c2ba3d4398c53..f5f87dae0dd9d 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -27,6 +27,7 @@
 #include <asm/isc.h>
 #include <asm/guarded_storage.h>
 
+#define KVM_HAVE_MMU_RWLOCK
 #define KVM_MAX_VCPUS 255
 
 #define KVM_INTERNAL_MEM_SLOTS 1
diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
index 0ca9d6587243c..0c93ed676508b 100644
--- a/arch/s390/kvm/Kconfig
+++ b/arch/s390/kvm/Kconfig
@@ -31,6 +31,8 @@ config KVM
 	select KVM_VFIO
 	select MMU_NOTIFIER
 	select VIRT_XFER_TO_GUEST_WORK
+	select KVM_GENERIC_MMU_NOTIFIER
+	select KVM_MMU_LOCKLESS_AGING
 	help
 	  Support hosting paravirtualized guest machines using the SIE
 	  virtualization capability on the mainframe. This should work
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index caf484b4df7ba..9d1150bb38b29 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -4919,7 +4919,7 @@ int __kvm_s390_handle_dat_fault(struct kvm_vcpu *vcpu, gfn_t gfn, gpa_t gaddr, u
 	rc = fixup_user_fault(vcpu->arch.gmap->mm, vmaddr, fault_flags, &unlocked);
 	if (!rc)
 		rc = __gmap_link(vcpu->arch.gmap, gaddr, vmaddr);
-	scoped_guard(spinlock, &vcpu->kvm->mmu_lock) {
+	scoped_guard(read_lock, &vcpu->kvm->mmu_lock) {
 		kvm_release_faultin_page(vcpu->kvm, page, false, writable);
 	}
 	mmap_read_unlock(vcpu->arch.gmap->mm);
@@ -6141,6 +6141,49 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 	return;
 }
 
+/**
+ * kvm_test_age_gfn() - test young
+ * @kvm: the kvm instance
+ * @range: the range of guest addresses whose young status needs to be cleared
+ *
+ * Context: called by KVM common code without holding the kvm mmu lock
+ * Return: true if any page in the given range is young, otherwise 0.
+ */
+bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
+{
+	return false;
+}
+
+/**
+ * kvm_age_gfn() - clear young
+ * @kvm: the kvm instance
+ * @range: the range of guest addresses whose young status needs to be cleared
+ *
+ * Context: called by KVM common code without holding the kvm mmu lock
+ * Return: true if any page in the given range was young, otherwise 0.
+ */
+bool kvm_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
+{
+	return false;
+}
+
+/**
+ * kvm_unmap_gfn_range() - Unmap a range of guest addresses
+ * @kvm: the kvm instance
+ * @range: the range of guest page frames to invalidate
+ *
+ * This function always returns false because every DAT table modification
+ * has to use the appropriate DAT table manipulation instructions, which will
+ * keep the TLB coherent, hence no additional TLB flush is ever required.
+ *
+ * Context: called by KVM common code with the kvm mmu write lock held
+ * Return: false
+ */
+bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
+{
+	return false;
+}
+
 static inline unsigned long nonhyp_mask(int i)
 {
 	unsigned int nonhyp_fai = (sclp.hmfai << i * 2) >> 30;
-- 
2.53.0

