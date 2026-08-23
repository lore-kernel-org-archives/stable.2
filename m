Received: from www5210.sakura.ne.jp (www5210.sakura.ne.jp [133.167.8.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5043CF212
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 13:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=133.167.8.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787490539; cv=none; b=s/5m3rSc2JTIGFMd4fj+dQu8LDrSv/FjFBrrNTqlavdup90fNVtm1D0nvVRDeAvrV08Rm2pirRhmRyaJANGIeqLe73EWYt5DD8cjam9DoAuvq+ETTlMAuKZIySDdDb3R1m8dhBepvCt1dpZ/npellxRDbGXJ4jbKUdyUbana8zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787490539; c=relaxed/simple;
	bh=uLpC4fWmOQt3vZE4td0mVSsGf5M0+1Df32+MplqJnSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hkt4JvIs5T+jkgHdDnIZBPti68dZaBswMclScIXZTLlQKI9N+DIWw00wYRkZE5j0rlJT3lslSPuMRfn5swhUIAGO8XEQNfA3pOdekxoIjp+3cavNDyipu4Y4D5LKtYlR8iE2+46GPcfstcMVQj8562P5Nbdx+9DtjHN5fBGb7ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me; spf=pass smtp.mailfrom=mgml.me; dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b=C1weFnTy; arc=none smtp.client-ip=133.167.8.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mgml.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b="C1weFnTy"
Received: from fedora (p4270056-ipxg00p01tokaisakaetozai.aichi.ocn.ne.jp [153.201.103.56])
	(authenticated bits=0)
	by www5210.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 67ND8380016116
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 23 Aug 2026 22:08:40 +0900 (JST)
	(envelope-from k@mgml.me)
DKIM-Signature: a=rsa-sha256; bh=zGd/b4rb/T0FL14oy29J4ZDWsxOPfNMDftEHWXUtBuA=;
        c=relaxed/relaxed; d=mgml.me;
        h=From:Message-ID:To:Subject:Date;
        s=rs20250315; t=1787490520; v=1;
        b=C1weFnTydyV0Yx1tt0c7Ch4eAZXebK/PEGtEPBPfATQ5vhIVtmmuZ0MhdQ9sQzOM
         j2gUfoZ3kopyHWeHn2Bw+8fukPvWzo9XGlQUt4US+9Sc4ne6kkq524/rretBU+qB
         70oW8c7oK1msk0a06+r3Fbew0nBDQA9lEintQwxC1/718Z1kLf4BQppGh4XJeMNd
         dysy2AKc+P6BVqqyTidM6pxII/BYLdybiqLUwlDvViq2e2hzW/7GKL2/vfvhigJc
         insF3a6Sh/BwWMa7kVXKkNosldPaowI/96iIxwRYypqSQjd22ho7+sM+uVa06UEQ
         MP8Ytz9Mnd+ZDv3RM73p2Q==
From: Kenta Akagi <k@mgml.me>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Sasha Levin <sashal@kernel.org>,
        Kenta Akagi <k@mgml.me>
Subject: [PATCH 5.15.y v2 4/8] KVM: x86/mmu: Document the "rules" for using host_pfn_mapping_level()
Date: Sun, 23 Aug 2026 22:07:47 +0900
Message-ID: <20260823130751.2880-5-k@mgml.me>
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

[ Upstream commit 65e3b446bcceaac7448cb25a2a5bf4adbcf25fe6 ]

Add a comment to document how host_pfn_mapping_level() can be used safely,
as the line between safe and dangerous is quite thin.  E.g. if KVM were
to ever support in-place promotion to create huge pages, consuming the
level is safe if the caller holds mmu_lock and checks that there's an
existing _leaf_ SPTE, but unsafe if the caller only checks that there's a
non-leaf SPTE.

Opportunistically tweak the existing comments to explicitly document why
KVM needs to use READ_ONCE().

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20220715232107.3775620-3-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: 2abd5287f083 ("KVM: x86: Check for invalid/obsolete root *after* making MMU pages available")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Kenta Akagi <k@mgml.me>
---
 arch/x86/kvm/mmu/mmu.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 610125291a48..5cb3362e1653 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2873,6 +2873,31 @@ static void direct_pte_prefetch(struct kvm_vcpu *vcpu, u64 *sptep)
 	__direct_pte_prefetch(vcpu, sp, sptep);
 }
 
+/*
+ * Lookup the mapping level for @gfn in the current mm.
+ *
+ * WARNING!  Use of host_pfn_mapping_level() requires the caller and the end
+ * consumer to be tied into KVM's handlers for MMU notifier events!
+ *
+ * There are several ways to safely use this helper:
+ *
+ * - Check mmu_notifier_retry_hva() after grabbing the mapping level, before
+ *   consuming it.  In this case, mmu_lock doesn't need to be held during the
+ *   lookup, but it does need to be held while checking the MMU notifier.
+ *
+ * - Hold mmu_lock AND ensure there is no in-progress MMU notifier invalidation
+ *   event for the hva.  This can be done by explicit checking the MMU notifier
+ *   or by ensuring that KVM already has a valid mapping that covers the hva.
+ *
+ * - Do not use the result to install new mappings, e.g. use the host mapping
+ *   level only to decide whether or not to zap an entry.  In this case, it's
+ *   not required to hold mmu_lock (though it's highly likely the caller will
+ *   want to hold mmu_lock anyways, e.g. to modify SPTEs).
+ *
+ * Note!  The lookup can still race with modifications to host page tables, but
+ * the above "rules" ensure KVM will not _consume_ the result of the walk if a
+ * race with the primary MMU occurs.
+ */
 static int host_pfn_mapping_level(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
 				  const struct kvm_memory_slot *slot)
 {
-- 
2.51.2

