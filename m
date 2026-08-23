Received: from www5210.sakura.ne.jp (www5210.sakura.ne.jp [133.167.8.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B466B3CCFBD
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 13:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=133.167.8.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787490539; cv=none; b=fEsEMRSVgrLHkaKrYqpPw4Dt6QZ3xfVszANferEY2/5uLRSFJ+IlW/kI2Q/Xf9iFdnkmADYHu3r5Uw3u8a+7MRaxj3bQc6ryUwUN63yQF1SgrE0BE+7tdactn+6gk4zBWwFQy4yOqc6tNTJ/apaQN/6UV+6J5Y4gxlGF5hMaCMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787490539; c=relaxed/simple;
	bh=gXuYowNtw/L/oLt4qTvU/4Be2wreUsrBp3bzbE9K50Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mDq5ZVTv0fXJlKAU/ytM5xk5/PD6i+z2TR6NoNewo6P5Az88xCoqgjuG31+2ruv9VoER03fghZlec+TayByNtgib4ViPx8m83L3w++e0ysf0n2xTytLNLazqjtpUyR700MjAWIUM9+TI8zu/7T7qTiptzEE1nfxiwTaG66ZTpDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me; spf=pass smtp.mailfrom=mgml.me; dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b=ddQ7dIZg; arc=none smtp.client-ip=133.167.8.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mgml.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b="ddQ7dIZg"
Received: from fedora (p4270056-ipxg00p01tokaisakaetozai.aichi.ocn.ne.jp [153.201.103.56])
	(authenticated bits=0)
	by www5210.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 67ND837w016116
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 23 Aug 2026 22:08:40 +0900 (JST)
	(envelope-from k@mgml.me)
DKIM-Signature: a=rsa-sha256; bh=3zZEFWCzdoGxb0oD0K/FsV8hj82IxZsp9Jx1XgTdpis=;
        c=relaxed/relaxed; d=mgml.me;
        h=From:Message-ID:To:Subject:Date;
        s=rs20250315; t=1787490520; v=1;
        b=ddQ7dIZgIeurP/pOrQ0MV5/fvxIzM2A6XIkPBHScm/sCkG1tjKHVTGoFygrhaJ96
         JewuF69mn5EObQ6F/JNCEnEVP/dvR1xZ6D2QaUJ3Newr7x9VtZq4cRwywVu/l09S
         tRP/cWb+8iyd5MOxHwuxpKNBdxQA6+SrGmkOx7dFUK7In3MVnDSWWlZNiVUA8c4v
         dY7F+5+mtrMSnLhxnYHMl+ZxNYo3TH96jGsEuryNjhWG06xVdjdQmqFRFjQXsvzB
         MV1rvv1g9vY2kit+nhrYfmo7bleG7psYdOZibRtHKI800FW22g0av8o5az5lK/LR
         ZItHzXs8r6iQGlKLjLp7Mw==
From: Kenta Akagi <k@mgml.me>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Sasha Levin <sashal@kernel.org>,
        Kenta Akagi <k@mgml.me>
Subject: [PATCH 5.15.y v2 2/8] KVM: x86/mmu: Directly "destroy" PTE list when recycling rmaps
Date: Sun, 23 Aug 2026 22:07:45 +0900
Message-ID: <20260823130751.2880-3-k@mgml.me>
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
Signed-off-by: Kenta Akagi <k@mgml.me>
---
 arch/x86/kvm/mmu/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 2fbe71dbab6f..0addde562ed6 100644
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
2.51.2

