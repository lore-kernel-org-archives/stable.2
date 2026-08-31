Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455F0396B98
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 22:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788214817; cv=none; b=uPpo//6Qhud1PPQWmWN03gxUp1KcpC4BpzUKUaJWDj5vhVU//nmxBAHYn7kBdUM63hLjE3vMATV8yMMYYg46VN28niSk5JlFxiBbbcgQEuugVT276Y+VgatQcQF+WfDiVE/6I2NapBEg7JVLayQwMx5ZsvHBEo1GzI/NEShdF48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788214817; c=relaxed/simple;
	bh=STcvwjpAvaZKHa3+LhYvLXsPfJB9si4Mm9pGCAx/fCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k41q/DlVbL7b+wyPsGZR8BrW4DLNPII5QfD+fR9yfjFcsYn2wEyFaiKfJX6hET/7k6Q07Sn+C1ITocVktPWyG9hPn6Lq5G5RrCqSgnGJFKLxxi3cuk9PPzqsedmrOh+RYMDwreYBN6pplsol8/WjU5Bw51L11fEaD9AZwP+H72E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWcDJ/Mn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWcDJ/Mn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7DCB1F00A3E;
	Mon, 31 Aug 2026 22:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788214816;
	bh=P13i+rVeqweARGNERKokDmUHsjPUaVnT1kzYeBcjJts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hWcDJ/MnTsiJU3RQn5m0JObMkp7IqzOCahi1uUlUDc2AtH+AYuRzHr9mECHh8afF4
	 fUqdvCxV6RBuR1yv2L+tO4FeI0mtTvne9lMpH8MvCbRiHkjUXZIZ+7OKiQqAyGuekv
	 qv0Al/gaQuhFYMOtxFwxD7Yd7MHpOgVxLWjfnOvVADJCaphcDO2aWFpwUrU4Q8XYoE
	 dXxS0pCYhcxzIW5YgSv/dBuGMfxEV8y5gxwnKT0c3r1fCI1ugFZtB9ksC1PZFTmb5+
	 FlZCn0TazJKu25XAA248KmNK4moCzDCTIQZJOQelIbdi/5A43D+T1SoMYNQxrQdT2r
	 pVg2G7g7PZI3Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Michael Roth <michael.roth@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 6/8] KVM: x86/mmu: Split kvm_mmu_zap_all_fast() into "front" and "back" halves
Date: Mon, 31 Aug 2026 18:20:08 -0400
Message-ID: <20260831222010.1859431-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831222010.1859431-1-sashal@kernel.org>
References: <2026083158-cornmeal-overhang-51bb@gregkh>
 <20260831222010.1859431-1-sashal@kernel.org>
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
Stable-dep-of: d1a3c2162334 ("KVM: SEV: Forcefully invalidate SNP VMSA if its backing gmem page is zapped")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/mmu/mmu.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index acab7005b0adc..b98192d29b877 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6896,20 +6896,11 @@ static void kvm_zap_obsolete_pages(struct kvm *kvm)
 	kvm_mmu_commit_zap_page(kvm, &invalid_list);
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
@@ -6946,8 +6937,12 @@ static void kvm_mmu_zap_all_fast(struct kvm *kvm)
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
@@ -6961,6 +6956,24 @@ static void kvm_mmu_zap_all_fast(struct kvm *kvm)
 		kvm_tdp_mmu_zap_invalidated_roots(kvm, true);
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
 	int r, i;
-- 
2.53.0

