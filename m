Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62073BED27
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 02:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789093864; cv=none; b=AUk6xZBw+UtTY35RsVIFU8oFRPn3n8GsROAeHD+CvzyT/bAMBqNQLIEB6G2XjpAH5w12pNcGsM2HfH26sxNSqqoRhCiKU5gNs9VUEAWVtmQKFD96MCDQVREbGOvxU9ViNC8Zg/bG8kePvn5ndaeXNSIjSDbqUM+KJeWVi3MGzG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789093864; c=relaxed/simple;
	bh=n3YwM/bGUrhjFZA5dZXIIRVeMWv+0eOEwnNY0i5K2Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WC+jA8JUwe+3gdXl8mOE06TGTAFPsyNtYz/i/ir0h5fRuAzrwLm+vZNzwVdCUweurZcBf11ZolMTjugZVwiFhZjesWj9DQphQjQhQaipoBQNNHSrpjq+ArjCFJuUwTfGg0cqO+RYWcRGZ0pjlCmwO3C3I2iSmMnx/Q5WcwtSYUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwGd/Wwj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwGd/Wwj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14FD21F00898;
	Fri, 11 Sep 2026 02:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789093863;
	bh=s4lqgK1vjyuZ9K2kaTaoJgJ7dcZII81jrau0cJyqlWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gwGd/WwjGY2uo9+HwQp6oIGxgxZaQGVlvClomTHWRruXnM3G99nQb3TBpT7lgKQwP
	 v2Y14H+pLfLVCto8EbbwEUX4Is/cRIgbNll4xFLX2OXsgNlaGZ8bRV1HVHskExCX7w
	 JC1zCrhOHrYB1A2HExF072cNlgs8OWEFj2l3ONLEN8FVRD/OHFGQ6MbR4X0P/xDMBX
	 lpHqofiOu7Oh3/lcJlTmdt5VzGxqj7/YGe2mcWkXbxcKprjFgh3eDAc/HISbzcs/1p
	 fAr9ACVyp51TCojk3Mn1fbMhLTy2kvU26dLLDxp1QY7uB7J8Y4DNhU7OGtHKwJCg4i
	 sna3v4RxuPbdg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Michael Roth <michael.roth@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] KVM: x86/mmu: Split kvm_mmu_zap_all_fast() into "front" and "back" halves
Date: Thu, 10 Sep 2026 22:31:00 -0400
Message-ID: <20260911023100.75724-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911023100.75724-1-sashal@kernel.org>
References: <2026090911-eats-threefold-66cf@gregkh>
 <20260911023100.75724-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit b27622c4eeb125814081baaefe9175191be5b94d ]

Split kvm_mmu_zap_all_fast() into a "front half" and a "back half", where
the front half is everything that runs with mmu_lock held for write, and
the back half is the code that runs outside of mmu_lock.  This will allow
putting more code inside kvm_arch_flush_shadow_memslot()'s critical section
without having to take mmu_lock twice in quick succession.

No functional change intended.

Cc: stable@vger.kernel.org # 6.12.x
Reviewed-by: Michael Roth <michael.roth@amd.com>
Link: https://patch.msgid.link/20260709204948.1988414-9-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/mmu/mmu.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 8d46a307a2a3b..1c9d6132e24ad 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6489,20 +6489,11 @@ static void kvm_zap_obsolete_pages(struct kvm *kvm)
 	kvm_mmu_commit_zap_page(kvm, &kvm->arch.zapped_obsolete_pages);
 }
 
-/*
- * Fast invalidate all shadow pages and use lock-break technique
- * to zap obsolete pages.
- *
- * It's required when memslot is being deleted or VM is being
- * destroyed, in these cases, we should ensure that KVM MMU does
- * not use any resource of the being-deleted slot or all slots
- * after calling the function.
- */
-static void kvm_mmu_zap_all_fast(struct kvm *kvm)
+static void __kvm_mmu_zap_all_fast_front_half(struct kvm *kvm)
 {
 	lockdep_assert_held(&kvm->slots_lock);
+	lockdep_assert_held_write(&kvm->mmu_lock);
 
-	write_lock(&kvm->mmu_lock);
 	trace_kvm_mmu_zap_all_fast(kvm);
 
 	/*
@@ -6534,8 +6525,12 @@ static void kvm_mmu_zap_all_fast(struct kvm *kvm)
 	kvm_make_all_cpus_request(kvm, KVM_REQ_MMU_FREE_OBSOLETE_ROOTS);
 
 	kvm_zap_obsolete_pages(kvm);
+}
 
-	write_unlock(&kvm->mmu_lock);
+static void __kvm_mmu_zap_all_fast_back_half(struct kvm *kvm)
+{
+	lockdep_assert_held(&kvm->slots_lock);
+	lockdep_assert_not_held(&kvm->mmu_lock);
 
 	/*
 	 * Zap the invalidated TDP MMU roots, all SPTEs must be dropped before
@@ -6554,6 +6549,24 @@ static bool kvm_has_zapped_obsolete_pages(struct kvm *kvm)
 	return unlikely(!list_empty_careful(&kvm->arch.zapped_obsolete_pages));
 }
 
+/*
+ * Fast invalidate all shadow pages and use lock-break technique
+ * to zap obsolete pages.
+ *
+ * It's required when memslot is being deleted or VM is being
+ * destroyed, in these cases, we should ensure that KVM MMU does
+ * not use any resource of the being-deleted slot or all slots
+ * after calling the function.
+ */
+static void kvm_mmu_zap_all_fast(struct kvm *kvm)
+{
+	write_lock(&kvm->mmu_lock);
+	__kvm_mmu_zap_all_fast_front_half(kvm);
+	write_unlock(&kvm->mmu_lock);
+
+	__kvm_mmu_zap_all_fast_back_half(kvm);
+}
+
 int kvm_mmu_init_vm(struct kvm *kvm)
 {
 	int r;
-- 
2.53.0

