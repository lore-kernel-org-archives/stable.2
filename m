Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEB146AF0A
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 19:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785439778; cv=none; b=AaIIwmJ/mklnEuGx53bq3/haaKnlHDuxhTnvnHoAdcK8RVrtrdOI4+rtE6mXQSk5Thk5O8OqHrhxudOIoHJIvAh+/jUHKmGm8wlNgbAwEwj/yQ6+Cr5Qq4vqWMDkPeKKpTD428AtLiNvmBOrk5sLU0S9XaDmAGG3PDXIqB0mbug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785439778; c=relaxed/simple;
	bh=/GT06IBsjOmfjCd6sy5n6kvpUJ0Di+MnF4VsiS8qwOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oaYto1NCmqoI+PNdz8VD8rEfrzGVP63CzJXVHsv011QrAHc8FVKxmDMyzDykKTOwxZwWnX6PDo904N/FBfUR+GnOcqhiFHSMbzfPwbZxXpq/Jdibiu30XORsAVLbLt9DlFkSGHn4nieCKmfIHMZiidKpQOpLhvx6G/aPgVCU83M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYSX4tNt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYSX4tNt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E48B1F000E9;
	Thu, 30 Jul 2026 19:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785439775;
	bh=bQzgcSDhWbuh7zRS5kXVdmMWkuj48P0/FDloSuac/S4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KYSX4tNthQUQKOH485dmE6OkdHC4DGbpP8JGJNGmSzzAtipf2B18K2RIR+zrtSz+B
	 OvE1jchYmMXF8wm1zMvZWu0wD8NjsMo8kjPtlwYYw2/2Ob4U2WfAK97GTgge/MYLyW
	 rirfv7FyRieeo2Rawj4f/SBpkHLgXvvX70wrJVUeVpOLK6txkm7HzWrbM6xXqkQbK7
	 I8313gcB3MB+YhL8qm4M69MJ1nn2APx70dNBznuswFOJ+CqzVOKBMlIjjRFLC9ddXW
	 npih5DtIhldMwA7kz+vtRQ80i6PW+6nSd0kFXhuE+mvGSahUFX4NfJs7OtohLCJnm6
	 YkilEGhSFFqkA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/6] KVM: x86/mmu: Directly "destroy" PTE list when recycling rmaps
Date: Thu, 30 Jul 2026 15:29:28 -0400
Message-ID: <20260730192933.3123642-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072557-gem-defensive-a757@gregkh>
References: <2026072557-gem-defensive-a757@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit a42989e7fbb0186d9fee05b29e0ea9cb639d0bd3 ]

Use pte_list_destroy() directly when recycling rmaps instead of bouncing
through kvm_unmap_rmapp() and kvm_zap_rmapp().  Calling kvm_unmap_rmapp()
is unnecessary and odd as it requires passing dummy parameters; passing
NULL for @slot when __rmap_add() already has a valid slot is especially
weird and confusing.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20220715224226.3749507-3-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: 2abd5287f083 ("KVM: x86: Check for invalid/obsolete root *after* making MMU pages available")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/mmu/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 3e95e39d4fb4..a84d9ddfdc2c 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1639,7 +1639,7 @@ static void rmap_add(struct kvm_vcpu *vcpu, u64 *spte, gfn_t gfn)
 	rmap_count = pte_list_add(vcpu, spte, rmap_head);
 
 	if (rmap_count > RMAP_RECYCLE_THRESHOLD) {
-		kvm_unmap_rmapp(vcpu->kvm, rmap_head, NULL, gfn, sp->role.level, __pte(0));
+		pte_list_destroy(vcpu->kvm, rmap_head);
 		kvm_flush_remote_tlbs_with_address(
 				vcpu->kvm, sp->gfn, KVM_PAGES_PER_HPAGE(sp->role.level));
 	}
-- 
2.53.0

