Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175464CDDE9
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 13:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790776092; cv=none; b=okO25rVjERPTOSDnk/MBcKlJRAMUT/Hagd4JZrO2NtItINf7pivv0U5MGMiBhAMtBW28ISgL7PnG06x4XP9AU2bpYDgZOg/ZB0a5irXS1pWOCIvCJNAMLgInkXeamHzZ1UXot1ejhWiDUZv1Z6jIOFmWgSqWq9ij3d4zb/3sPSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790776092; c=relaxed/simple;
	bh=WjCz6JAZS0HSOCrU5Ee5SsK7FvbR3ROeIbDCxFVSHWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h/eAzdZeHNPD2WzBdWdchpgAdmSYoWSzU2pv3N3SYFx6KaT99UKmvgE6moF33Lr7tbCdJELHh12+hI83FYU0ZvmYEmu5TeygPBK17+qQ9eJmWxuRuJmzXDVlYh5yk/Jrec2wDvkEVXPayKm7Nnxq88nUn2y+J0xrSSm2sWhMSpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyoIrjF+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyoIrjF+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E13C1F00893;
	Wed, 30 Sep 2026 13:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790776079;
	bh=AnO6nmrGen/+f9SsxJ0pdCjtsggSsN98Vya1o8BBmrY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GyoIrjF+EvvJrTsHWv1OQhLs7U6ptHn1g9YRXP+743uV1mn2/7DBgK3zgsP+wR6dT
	 KEPDkZzpSsH0UYcIS7KvPSz26U3/+RpwWXYFu9G+Fh15LHfBa8Io6/iUPRQaJkbUxM
	 0fA3ucudDipjmC0sNylqcjrxmnDHFOPQlQKwQXpiyuJTLOXEmARLk7Ft2XWsKb5MQk
	 VAgfxIzrENC9Tom/vwmZtj8zL5Ystt4g+w7/RKodGxqki+8P0HPk2c20RL8xsDbvOm
	 rTJlGhZ4QT+hHBRh9XFrpY1Ghfd864H1a+DhhgzqABCt1V6zCociTvpzv27qMUA+Lg
	 MYv53VTZbuy+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Kai Huang <kai.huang@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 1/6] KVM: x86/mmu: Move kvm_arch_async_page_ready() below kvm_tdp_page_fault()
Date: Wed, 30 Sep 2026 09:47:52 -0400
Message-ID: <20260930134757.1797371-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092938-mantis-spearfish-5a96@gregkh>
References: <2026092938-mantis-spearfish-5a96@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 31a2cf735cc00c01526bcb676f111d5c0b711d17 ]

Move the implementation of kvm_arch_async_page_ready() "down" in mmu.c so
that it lives below kvm_tdp_page_fault().  This will allow moving
kvm_mmu_do_page_fault() into mmu.c without needing a forward declaration.

No functional change intended.

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Message-ID: <20260613000329.732085-29-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: c1214f293d77 ("KVM: x86: Fill kvm_run exit fields in common get_nested_state_pages() error paths")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/mmu/mmu.c | 62 +++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 51ba46aa6b7e5..ab1cbc0ff0eb9 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4600,37 +4600,6 @@ static bool kvm_arch_setup_async_pf(struct kvm_vcpu *vcpu,
 				  kvm_vcpu_gfn_to_hva(vcpu, fault->gfn), &arch);
 }
 
-void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu, struct kvm_async_pf *work)
-{
-	int r;
-
-	if (WARN_ON_ONCE(work->arch.error_code & PFERR_PRIVATE_ACCESS))
-		return;
-
-	if ((vcpu->arch.mmu->root_role.direct != work->arch.direct_map) ||
-	      work->wakeup_all)
-		return;
-
-	r = kvm_mmu_reload(vcpu);
-	if (unlikely(r))
-		return;
-
-	if (!vcpu->arch.mmu->root_role.direct &&
-	      work->arch.cr3 != kvm_mmu_get_guest_pgd(vcpu, vcpu->arch.mmu))
-		return;
-
-	r = kvm_mmu_do_page_fault(vcpu, work->cr2_or_gpa, work->arch.error_code,
-				  true, NULL, NULL);
-
-	/*
-	 * Account fixed page faults, otherwise they'll never be counted, but
-	 * ignore stats for all other return times.  Page-ready "faults" aren't
-	 * truly spurious and never trigger emulation
-	 */
-	if (r == RET_PF_FIXED)
-		vcpu->stat.pf_fixed++;
-}
-
 static void kvm_mmu_finish_page_fault(struct kvm_vcpu *vcpu,
 				      struct kvm_page_fault *fault, int r)
 {
@@ -5088,6 +5057,37 @@ long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
 	return min(range->size, end - range->gpa);
 }
 
+void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu, struct kvm_async_pf *work)
+{
+	int r;
+
+	if (WARN_ON_ONCE(work->arch.error_code & PFERR_PRIVATE_ACCESS))
+		return;
+
+	if ((vcpu->arch.mmu->root_role.direct != work->arch.direct_map) ||
+	      work->wakeup_all)
+		return;
+
+	r = kvm_mmu_reload(vcpu);
+	if (unlikely(r))
+		return;
+
+	if (!vcpu->arch.mmu->root_role.direct &&
+	      work->arch.cr3 != kvm_mmu_get_guest_pgd(vcpu, vcpu->arch.mmu))
+		return;
+
+	r = kvm_mmu_do_page_fault(vcpu, work->cr2_or_gpa, work->arch.error_code,
+				  true, NULL, NULL);
+
+	/*
+	 * Account fixed page faults, otherwise they'll never be counted, but
+	 * ignore stats for all other return times.  Page-ready "faults" aren't
+	 * truly spurious and never trigger emulation
+	 */
+	if (r == RET_PF_FIXED)
+		vcpu->stat.pf_fixed++;
+}
+
 #ifdef CONFIG_KVM_GUEST_MEMFD
 static void kvm_assert_gmem_invalidate_lock_held(struct kvm_memory_slot *slot)
 {
-- 
2.53.0

