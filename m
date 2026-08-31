Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627D13C0A08
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 22:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788216264; cv=none; b=OS/+xtR+Wx9PvQsSRZiWLb0oP9ZZI3wuSJ2gS15Keci7Xl9ZBYBVKi0gP6DEYw6F64thc5IE3vYbp9Nw+O5opg3BiGinPiNnLkSUX1CI9180/lT3+0P6I+S2m+8Ah9eGchK3YidGv2dPLAcH3/zVZijHYJE0wcY/D3bqnkLxS1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788216264; c=relaxed/simple;
	bh=Mc69LPszmFlkeTpUnMRCjYvlNAeJET1a+SEVE1opi50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJ7oEri5S+SdN+Pntn61A8vim/tHcncOSk2FuKlkFC4b2pUVbb5ldaMsFfaXWsYEv62lZREPFoQ025Lypn6gn9RgHauZTtSn+OGxHwr4sFFV86yc30t+0oYpRJCR7RKBGrAmkjElTXiN27g3j2zoA8hQgGzZm5ggdgfbx9061Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZheMhLG0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZheMhLG0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C569B1F00A3E;
	Mon, 31 Aug 2026 22:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788216263;
	bh=m/FGZyYNtXAnMHL4ua+LEFatGcIlcey+I1GmLUw9jYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZheMhLG0CQtQ+RsB0vxMaqP83q23vD832ZrNDo5r+A0d026alrUFdRpKIcntqG3RH
	 XifIPoxYFvgQGgEfX+XNVDbCsL2BhgEJV2XnwXE/W9RTI8WSvyFPff/6dmS8ZkUdXL
	 kjgF1781rNYhvOkGTwMYNBi0A5aWzXgCHgyoiFLI6Y5yMgJqpZzTpouZelfLkfDMLV
	 bUSr+qBjs+t5wB/3mOSFC2A31YR/+RsC+j1YI9Bl+d/qSG/y1RMkqSHCbtSfJ1ZdRh
	 dDGRUwxGx8PhDPQ9AWGLF6Fg+R/Eqq+eiC7/QBTwFBsm7+1IHhyRkYcuzsv7CDUst6
	 kG0bSxb/dZEoQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Michael Roth <michael.roth@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 5/8] KVM: x86/mmu: Fold kvm_mmu_zap_memslot() into kvm_arch_flush_shadow_memslot()
Date: Mon, 31 Aug 2026 18:44:14 -0400
Message-ID: <20260831224417.1903154-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831224417.1903154-1-sashal@kernel.org>
References: <2026083159-request-customs-f573@gregkh>
 <20260831224417.1903154-1-sashal@kernel.org>
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
index 0e918f35bfbea..73358100e0018 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -7441,8 +7441,14 @@ static void kvm_mmu_zap_memslot_pages_and_flush(struct kvm *kvm,
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
@@ -7453,25 +7459,14 @@ static void kvm_mmu_zap_memslot(struct kvm *kvm,
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

