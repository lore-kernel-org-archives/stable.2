Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE3E3A0E80
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 19:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785439780; cv=none; b=mvnc85Ogg/dNAWCFyQ0d7H/tkRsWuuUxpwQDI0eDmqF/vPhahtlD2HybImQh9XOsd064fXgkwwfzhf4AGBMg3E/YudF3zReUxap6WNDus1aXW7yijjSN8YbrfEXcN/MQQVnCoHN7TnX6ZaLsGr1WpVam6PpqJpYaCacAbG0fz5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785439780; c=relaxed/simple;
	bh=269kx0iH6KreLZ8QZ8D/rj/94z76bvS+qBsWl288cS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hD0wBkU4iu4BwAwgdi38uB+U/Hd37Hyg4eshPf+p/FyVO7zK1MKGd2VxFm+JEBLGItGud2rccaCSwrtBsF+B3VwJ9lsIGLXt74BQCP4EIvUyRX7jkeDeZYnaC3ILXtoe6rp14TNKejR2afEmWOgY0kPwCJ4JC8AaCcblCK5g9IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOwwi93n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOwwi93n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6FB11F00A3A;
	Thu, 30 Jul 2026 19:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785439777;
	bh=KoDOyH2Yq3i+hj0RDlFW3XKQoANCslm2vxbxgMetNQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZOwwi93nUTEdpZPpB4k/j5KdShFn4RqV1KS148wAuQw4wt6g+kJx4Sq0idSR0DzZP
	 zdRL6/Pq55yFk2oJyB9GSqIkL5oa1mA6KTFcP0azcGWnA2Clxl14SfzABiMgotEriQ
	 OCb73zu5Sr3suprx23LRrOHyYGIqTHaNa5Ay7omPP8Q1QSLQCLZf9V7nHCUAv4EQ5M
	 VQWa9Bh/Fi1R3jMOskXU0ffl5O5hqmzRbw6uLifL3AHP8PMh0n9hU82K7xrut6yuJX
	 HAV1Zk1bApC/9Z92sigb0LYVHDcXHwGRFC5QJx3atySev2pJcUaADkyXr09VuvMRhI
	 L3X+oV66N6TMw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/6] KVM: x86/mmu: Document the "rules" for using host_pfn_mapping_level()
Date: Thu, 30 Jul 2026 15:29:30 -0400
Message-ID: <20260730192933.3123642-3-sashal@kernel.org>
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
---
 arch/x86/kvm/mmu/mmu.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 415293bc6d1b..c00bcfadc068 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2869,6 +2869,31 @@ static void direct_pte_prefetch(struct kvm_vcpu *vcpu, u64 *sptep)
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
2.53.0

