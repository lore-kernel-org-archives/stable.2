Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCC43B8406
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 22:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788214816; cv=none; b=XihCl1vCrvPL3ECPFaLNE7FiLPKa4dVpJ1mJVLxTAwl5R6W2RmH2/TkK9Dr0Z/ot3HhSgSgg35TX51BST0BCw3q9yu7x8yd0ifKibQUXbRQiEeT9PMZVmfpx76D9Q4Tt2RhuoQ7/EzmUIlAtqBDoB52Tdd3nblIYSavcNbjUnmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788214816; c=relaxed/simple;
	bh=IB/I3IRgulDOoIeBErw/8HMCHNgPH0vgFiBkAmkoEvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X3Rfi1khMFtjLSXfK/KsDr7VlymzoWPWQ59PUexf84+CWiHH99rHVHO/ETM6QxCuQ3tUX7EVaGoKk+II/af149LiCx8M7jTTtOV02hRI/Jq2hKhkWPJBwWSIGOC0rQqLtbNKBjmPXgakC/ZbkOsmBvsxWeTGcuVMsmrYzPf/qpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=el7vYBRt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="el7vYBRt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6FA1F00A3D;
	Mon, 31 Aug 2026 22:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788214815;
	bh=A+KXEPXzZ8TKDkzRelTMdqch9hJl4wi7+pshZq6ThZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=el7vYBRtRTNz6/tcoGaY3tGdOm7I2/4JbRD+N0x9JvAWpeSIa7tGpVVvJlPhqGTPj
	 j3Q5za1nxhzRcnWYDGPtS+R7yGYAqmduvkHB5f9FiMramMKnJ1CIynnsTkBpd/xsr5
	 79+MKopeHvj2GimnC+7E6MYjjmwl1xQA8UmbioTuJE+C5p1wb/VXYehM1hce9AVI61
	 HO5NChMSbRGRDgUXobwReZ2qgKDcyKaMoH/Tk14GuKm2jB+BL6RUTgTofiPNRplNwg
	 z0tyO3UwrB+rTjhXu/GjU5pW8LQ9shLix1ZCmNYyi3Zb393+Jj8n+DHKWDTMZShVf+
	 CShtTeHA0fAsg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Michael Roth <michael.roth@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 5/8] KVM: x86/mmu: Fold kvm_mmu_zap_memslot() into kvm_arch_flush_shadow_memslot()
Date: Mon, 31 Aug 2026 18:20:07 -0400
Message-ID: <20260831222010.1859431-5-sashal@kernel.org>
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

[ Upstream commit 06d38eaa78fdac1cc889f261fa420eba8e9caa1a ]

Fold kvm_mmu_zap_memslot() into its sole caller so that its GFN range
structure can be used to trigger guest_memfd invalidations regardless of
whether KVM will do a partial or full zap of the MMU.

No functional change intended.

Cc: stable@vger.kernel.org # 6.12.x
Reviewed-by: Michael Roth <michael.roth@amd.com>
Link: https://patch.msgid.link/20260709204948.1988414-8-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Stable-dep-of: d1a3c2162334 ("KVM: SEV: Forcefully invalidate SNP VMSA if its backing gmem page is zapped")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/mmu/mmu.c | 35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index a61750f8e1e37..acab7005b0adc 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -7535,8 +7535,14 @@ static void kvm_mmu_zap_memslot_pages_and_flush(struct kvm *kvm,
 	kvm_mmu_remote_flush_or_zap(kvm, &invalid_list, flush);
 }
 
-static void kvm_mmu_zap_memslot(struct kvm *kvm,
-				struct kvm_memory_slot *slot)
+static inline bool kvm_memslot_flush_zap_all(struct kvm *kvm)
+{
+	return kvm->arch.vm_type == KVM_X86_DEFAULT_VM &&
+	       kvm_check_has_quirk(kvm, KVM_X86_QUIRK_SLOT_ZAP_ALL);
+}
+
+void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
+				   struct kvm_memory_slot *slot)
 {
 	struct kvm_gfn_range range = {
 		.slot = slot,
@@ -7547,25 +7553,14 @@ static void kvm_mmu_zap_memslot(struct kvm *kvm,
 	};
 	bool flush;
 
-	write_lock(&kvm->mmu_lock);
-	flush = kvm_unmap_gfn_range(kvm, &range);
-	kvm_mmu_zap_memslot_pages_and_flush(kvm, slot, flush);
-	write_unlock(&kvm->mmu_lock);
-}
-
-static inline bool kvm_memslot_flush_zap_all(struct kvm *kvm)
-{
-	return kvm->arch.vm_type == KVM_X86_DEFAULT_VM &&
-	       kvm_check_has_quirk(kvm, KVM_X86_QUIRK_SLOT_ZAP_ALL);
-}
-
-void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
-				   struct kvm_memory_slot *slot)
-{
-	if (kvm_memslot_flush_zap_all(kvm))
+	if (kvm_memslot_flush_zap_all(kvm)) {
 		kvm_mmu_zap_all_fast(kvm);
-	else
-		kvm_mmu_zap_memslot(kvm, slot);
+	} else {
+		write_lock(&kvm->mmu_lock);
+		flush = kvm_unmap_gfn_range(kvm, &range);
+		kvm_mmu_zap_memslot_pages_and_flush(kvm, slot, flush);
+		write_unlock(&kvm->mmu_lock);
+	}
 }
 
 void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, u64 gen)
-- 
2.53.0

