Received: from www5210.sakura.ne.jp (www5210.sakura.ne.jp [133.167.8.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45D43BD225
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 13:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=133.167.8.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787490540; cv=none; b=JNXi6vdYZQPuBhIfEFlmVwOS350qF2VXZX5SxibagSJt3TSieXhUy/jONLfPNo9YtjRs30w6slTpwlBPxeHYHHIx9PImZv0bXsHu3ilsx/ifVUpijrZqCteESC+yZ/6X87AZef83z4F3SV4ty8bi8rF84JLMTZxzfeqAnt/wazg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787490540; c=relaxed/simple;
	bh=Cx8V6nukV/5UBsS9sleqRGayB0b9lzIyh7Yxo5a5Ulo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E1ZOTW3Lxe7h/gtFe5FMJWFUim8LLG2aK4aoyDE5SaZlmPVLJjN3H+9fU5LT2n5w3U6mjL61FPwqOjhQw6FCet9Ighw35MQwKIYSL+nwbLRLMYAZHEUWl9+jQO75TNBZCgFgk55NWgSB+3y25Ocgp2sUMBSfTieQzXOsZuhT6wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me; spf=pass smtp.mailfrom=mgml.me; dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b=DC6NGBMy; arc=none smtp.client-ip=133.167.8.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mgml.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b="DC6NGBMy"
Received: from fedora (p4270056-ipxg00p01tokaisakaetozai.aichi.ocn.ne.jp [153.201.103.56])
	(authenticated bits=0)
	by www5210.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 67ND837x016116
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 23 Aug 2026 22:08:40 +0900 (JST)
	(envelope-from k@mgml.me)
DKIM-Signature: a=rsa-sha256; bh=MgN0eEbgN4P4i3t5XW87AavFlkhEtuCS/tKzvJcsByk=;
        c=relaxed/relaxed; d=mgml.me;
        h=From:Message-ID:To:Subject:Date;
        s=rs20250315; t=1787490520; v=1;
        b=DC6NGBMyPr0wHLt4VKZP5PJGRkpIV6JcZbQMmVc553i5kJ0eFLEsFKaECaDEawVL
         PJEz0ONhjYtWQ2airhoMbxajPE77kbvYefDLvx6kqlUSAi+eW0iAybviIli4Au+3
         AkHa7AMaoO1Wn8qHKqPU9PJ6A2ji1rtMZFdajfoAT1S2WIAtsfwD8E0zvUgiisMF
         8H4jEfrTFM444qC8ZGMf7O1H6OSTLSWlRNUGGt+epndfGSjTtJYXUWIihngY+xx1
         AZsjySvT8hudHAMxy9Oqo2nbkE6c7CIOsa6LKL5LiwpcozbOGdqohFROR1EyD2Di
         bZnL2qXBb24uk+JtNLYRjQ==
From: Kenta Akagi <k@mgml.me>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Sasha Levin <sashal@kernel.org>,
        Kenta Akagi <k@mgml.me>
Subject: [PATCH 5.15.y v2 3/8] KVM: x86/mmu: Rename pte_list_{destroy,remove}() to show they zap SPTEs
Date: Sun, 23 Aug 2026 22:07:46 +0900
Message-ID: <20260823130751.2880-4-k@mgml.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260823130751.2880-1-k@mgml.me>
References: <2026072557-gem-defensive-a757@gregkh>
 <20260823130751.2880-1-k@mgml.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 9202aee816c84d69179f94193c5dd321bb0e8530 ]

Rename pte_list_remove() and pte_list_destroy() to kvm_zap_one_rmap_spte()
and kvm_zap_all_rmap_sptes() respectively to document that (a) they zap
SPTEs and (b) to better document how they differ (remove vs. destroy does
not exactly scream "one vs. all").

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20220715224226.3749507-7-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: 2abd5287f083 ("KVM: x86: Check for invalid/obsolete root *after* making MMU pages available")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Kenta Akagi <k@mgml.me>
---
 arch/x86/kvm/mmu/mmu.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 0addde562ed6..610125291a48 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -999,15 +999,16 @@ static void __pte_list_remove(u64 *spte, struct kvm_rmap_head *rmap_head)
 	}
 }
 
-static void pte_list_remove(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
-			    u64 *sptep)
+static void kvm_zap_one_rmap_spte(struct kvm *kvm,
+				  struct kvm_rmap_head *rmap_head, u64 *sptep)
 {
 	mmu_spte_clear_track_bits(kvm, sptep);
 	__pte_list_remove(sptep, rmap_head);
 }
 
-/* Return true if rmap existed, false otherwise */
-static bool pte_list_destroy(struct kvm *kvm, struct kvm_rmap_head *rmap_head)
+/* Return true if at least one SPTE was zapped, false otherwise */
+static bool kvm_zap_all_rmap_sptes(struct kvm *kvm,
+				   struct kvm_rmap_head *rmap_head)
 {
 	struct pte_list_desc *desc, *next;
 	int i;
@@ -1434,7 +1435,7 @@ static bool rmap_write_protect(struct kvm_vcpu *vcpu, u64 gfn)
 static bool kvm_zap_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
 			  const struct kvm_memory_slot *slot)
 {
-	return pte_list_destroy(kvm, rmap_head);
+	return kvm_zap_all_rmap_sptes(kvm, rmap_head);
 }
 
 static bool kvm_unmap_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
@@ -1465,7 +1466,7 @@ static bool kvm_set_pte_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
 		need_flush = 1;
 
 		if (pte_write(pte)) {
-			pte_list_remove(kvm, rmap_head, sptep);
+			kvm_zap_one_rmap_spte(kvm, rmap_head, sptep);
 			goto restart;
 		} else {
 			new_spte = kvm_mmu_changed_pte_notifier_make_spte(
@@ -1639,7 +1640,7 @@ static void rmap_add(struct kvm_vcpu *vcpu, u64 *spte, gfn_t gfn)
 	rmap_count = pte_list_add(vcpu, spte, rmap_head);
 
 	if (rmap_count > RMAP_RECYCLE_THRESHOLD) {
-		pte_list_destroy(vcpu->kvm, rmap_head);
+		kvm_zap_all_rmap_sptes(vcpu->kvm, rmap_head);
 		kvm_flush_remote_tlbs_with_address(
 				vcpu->kvm, sp->gfn, KVM_PAGES_PER_HPAGE(sp->role.level));
 	}
@@ -5873,7 +5874,7 @@ static bool kvm_mmu_zap_collapsible_spte(struct kvm *kvm,
 		    !kvm_is_reserved_pfn(pfn) &&
 		    sp->role.level < kvm_mmu_max_mapping_level(kvm, slot, sp->gfn,
 							       pfn, PG_LEVEL_NUM)) {
-			pte_list_remove(kvm, rmap_head, sptep);
+			kvm_zap_one_rmap_spte(kvm, rmap_head, sptep);
 
 			if (kvm_available_flush_tlb_with_range())
 				kvm_flush_remote_tlbs_with_address(kvm, sp->gfn,
-- 
2.51.2

