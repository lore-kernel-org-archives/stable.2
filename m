Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F036D3BFAEE
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 22:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788216266; cv=none; b=gzDToDrvOjVTVPwIT9K3BuIQQ2r6bzkp5ADx2xpzfMKikS6sw22uvJYKCAtpS3DwvsP9UP9kDCOpwIUmwBW/RQiS8eps5YGtkQXmc9LBLb9z5qMix8dMPkXauzjBFVAZ0stn2ONQMYzhwnhnW9nEdWF2Zvpf+Whafphkc1wyjVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788216266; c=relaxed/simple;
	bh=8KocehJBGbso28ztOpskdY5PgnP/KnQch27E1KeQWx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tpMI91gsWlsN4Rlhhc849UsXT/H9Dwx7GAdp0PFEoONlH9ezIZTYW2ia7dK6I3ZdF0JGcn2rEhMZoyDSRVrZ/c8/iKTv/huBR2txDD4k6TYmLvxjjvmABHZLp0oSTtyuZkuYoVmkKDiPqWo23kLq7Py06TpKDeOizCNYAXbGTKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtoEuD06; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtoEuD06"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A10B1F000E9;
	Mon, 31 Aug 2026 22:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788216264;
	bh=QNFS2w3OB+C83/WExP0RqiJDCIAzBzXfcvOu8YDEdGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VtoEuD06Py404/VtYenhy9WfnL328u81JXjIhSqXwUq0AE3kYXlzTUNqcfZYV/qyf
	 tSl/bT51+RNs99RFBmcP3JP58FbTED//eQiNGbUX5aNjDslgbbdBTBmbwCFzsjetuQ
	 Hs+trz29lmaJk22+zr9FatN5Nq9JCQLyBSiCIK731V6yNYphto08x8EeHZ8rdiBdBN
	 33smaHFbGoXx5kVxlIupiBPqXqybUiFaIHDC5X8AxfrjXc0u8Mxj4t9GKIYpKLYzY6
	 xSBm06WJlhKTSTwmGdKx/CHi+e8KNT67mf86NfoM43xOInuZTitXvXc6V+Urqm6TQV
	 UO0MN2XuIDzyw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Michael Roth <michael.roth@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 7/8] KVM: x86/mmu: Use split "zap all fast" helpers when invalidating memslot
Date: Mon, 31 Aug 2026 18:44:16 -0400
Message-ID: <20260831224417.1903154-7-sashal@kernel.org>
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

[ Upstream commit db095727ff5739f4f46ee641ee6ef450032886db ]

Manually invoke the front half and back half of the "zap all fast" flow
when invalidating a memslot so that mmu_lock is acquired at function scope
in kvm_arch_flush_shadow_memslot().   This will allow putting more code
inside the critical section without having to take mmu_lock twice in quick
succession.

Opportunistically open code checking whether or not to do the fast zap, to
discourage removing the local "zap_all" in a future cleanup, i.e. to ensure
the SLOT_ZAP_ALL quirk is queried exactly once.  Processing the front half
but not the back half of the fast zap (if SLOT_ZAP_ALL were disabled
concurrently) would result in KVM unnecessarily keeping invalid TDP MMU
roots until the VM is destroyed.

No functional change intended.

Cc: stable@vger.kernel.org # 6.12.x
Reviewed-by: Michael Roth <michael.roth@amd.com>
Link: https://patch.msgid.link/20260709204948.1988414-10-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Stable-dep-of: d1a3c2162334 ("KVM: SEV: Forcefully invalidate SNP VMSA if its backing gmem page is zapped")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/mmu/mmu.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 10c28f78bf276..43fadc53a1b92 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -7454,12 +7454,6 @@ static void kvm_mmu_zap_memslot_pages_and_flush(struct kvm *kvm,
 	kvm_mmu_remote_flush_or_zap(kvm, &invalid_list, flush);
 }
 
-static inline bool kvm_memslot_flush_zap_all(struct kvm *kvm)
-{
-	return kvm->arch.vm_type == KVM_X86_DEFAULT_VM &&
-	       kvm_check_has_quirk(kvm, KVM_X86_QUIRK_SLOT_ZAP_ALL);
-}
-
 void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
 				   struct kvm_memory_slot *slot)
 {
@@ -7470,16 +7464,23 @@ void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
 		.may_block = true,
 		.attr_filter = KVM_FILTER_PRIVATE | KVM_FILTER_SHARED,
 	};
+	bool zap_all = kvm->arch.vm_type == KVM_X86_DEFAULT_VM &&
+		       kvm_check_has_quirk(kvm, KVM_X86_QUIRK_SLOT_ZAP_ALL);
 	bool flush;
 
-	if (kvm_memslot_flush_zap_all(kvm)) {
-		kvm_mmu_zap_all_fast(kvm);
+	write_lock(&kvm->mmu_lock);
+
+	if (zap_all) {
+		__kvm_mmu_zap_all_fast_front_half(kvm);
 	} else {
-		write_lock(&kvm->mmu_lock);
 		flush = kvm_unmap_gfn_range(kvm, &range);
 		kvm_mmu_zap_memslot_pages_and_flush(kvm, slot, flush);
-		write_unlock(&kvm->mmu_lock);
 	}
+
+	write_unlock(&kvm->mmu_lock);
+
+	if (zap_all)
+		__kvm_mmu_zap_all_fast_back_half(kvm);
 }
 
 void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, u64 gen)
-- 
2.53.0

