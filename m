Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D96743C7DE
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 19:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785439779; cv=none; b=Pem5hYwmpie5rbyPt44c1PztQ05cyT6gRAWfl+5Cmc5cy0dlMZHhbJ2Ar6tuTsiyrVZYAfFco2g1BFs6M+VuzFnW6EmDCJlmJZ+ZVhyuzoYEsP1FO7QO70zjSLKHlHY0CP3zJJvlOc5PYsGTju+y6C/A9QLyOVmyKUT5cruurNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785439779; c=relaxed/simple;
	bh=+kRAwuU2pdhWiChh4iqlHpSQrXRjcapDV6gyD8GxEjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ipoaPvKL50eWJ0UDcnVrAR2HUeeS3DoWI2cvjfYSk1fj6sq1IAL8UrxqKwcUHQeYeXdmiXpmY1wTkOsD35RIlY+VElzzKL0LKLDw46NXlV1pbS9fFxYBD9lQ4Gcj5EAX3I5sgCLHIsI1VCaoJBLhGobgyPxJNB8+Fyy4wAwKy+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NFGk0bu1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFGk0bu1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C7C1F00A3D;
	Thu, 30 Jul 2026 19:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785439776;
	bh=A2F0rv/EPMiiQwCBAXEX/k4XlMTGSzxb1LoLv1ptNO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NFGk0bu1ShdEpS44qmGF4TYJT4cp0buMIzKbZTqUudI6Rq7SXpOxHKl8YeV7kekkm
	 4Sw0TXHOOAhGzYuAP+M6ja+8OOIPrek6boho9gF9AqZPEag84v0B7zEw4xIILUiPko
	 N3ojLvRyCFsK3Gb4Xk3Ohr453q3ZuANo3EeyZZlEKcxtTam9IDR/Sr/Uf93Y/x4c85
	 KGYb7k1VAEjfDemTK2LO3BJndVsjaINPjoKNZ3ojq3uuBdu8efGT0ICTWn82lX/KMr
	 jAO8v0qCI2vEePjj6iGmKgA8zO4BrkivjvtdIRdFS5cEp1MCkvMLUMqmIvPFjIfp5Y
	 exAn3VYM1Xa4Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/6] KVM: x86/mmu: Rename pte_list_{destroy,remove}() to show they zap SPTEs
Date: Thu, 30 Jul 2026 15:29:29 -0400
Message-ID: <20260730192933.3123642-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730192933.3123642-1-sashal@kernel.org>
References: <2026072557-gem-defensive-a757@gregkh>
 <20260730192933.3123642-1-sashal@kernel.org>
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
---
 arch/x86/kvm/mmu/mmu.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index a84d9ddfdc2c..415293bc6d1b 100644
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
@@ -5855,7 +5856,7 @@ static bool kvm_mmu_zap_collapsible_spte(struct kvm *kvm,
 		    !kvm_is_reserved_pfn(pfn) &&
 		    sp->role.level < kvm_mmu_max_mapping_level(kvm, slot, sp->gfn,
 							       pfn, PG_LEVEL_NUM)) {
-			pte_list_remove(kvm, rmap_head, sptep);
+			kvm_zap_one_rmap_spte(kvm, rmap_head, sptep);
 
 			if (kvm_available_flush_tlb_with_range())
 				kvm_flush_remote_tlbs_with_address(kvm, sp->gfn,
-- 
2.53.0

