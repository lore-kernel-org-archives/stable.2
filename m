Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B531246AF3C
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 19:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785439783; cv=none; b=p2Im1XQ9b2MrGBmStpi9P0fg2tgqnw8/T5IQzOQKzyC+/3kepKLJJOe9SHThc3evD4vdjA3wyvzFC+wDbAAnnh4koaQJcI7ZJgVAXI2HsIbk+nQ8PNgWzvPWWOcxwgqIg2lBj4f0JH+gU4kbXBsKvgpDWGqLEMpz0ahNTgvV6bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785439783; c=relaxed/simple;
	bh=gGuc6M9VFfkeEp3SBLxUJOg9Qe4jgibMqIlyYs2QLME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cN97KkgPbpKMhhM9zQm/Ck3bcT8UPlZG8Y+xWmwqdDG/Vl6kCAawjK5RPgWZ1BlMEJpakqT4SW0sugXw6oUDntNKGm/Rvq7NDu01yGVgUdLSHvwgDM+9fmwiaeg8nSofE9s4pGmHhbnaE4NHdzL3eaFK8MZPW13Wv+JdwFvt/rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McoBkM/4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McoBkM/4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C531F00A3E;
	Thu, 30 Jul 2026 19:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785439779;
	bh=FL4D64WXgJDm1R3SwRMog0pLt6UVbUZLpvCT5VcVDgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=McoBkM/4wYtk2qc1C4omdgV3GaD/4QVS3YbBHze9DBWMYyKzIAQ5cqllWzmeq/Hdq
	 VEt1XS5/jTJZ9h8WOC/SlsK7FjvnIfYKCLYbUHm/G0iWBsST/zx6vk50jiZcj/CrYn
	 UMZCYugjI/XFdV2bbOBajOcHZNvR2Enqy+xb8BAPZQBwOreI+o/oo+PdM3nklK0wSi
	 fxKFGsuM+rMfeNC53uQmxmiGc+JaXh4cIQs6Ee1pBVpMXKgcNyvu7gdzS4y8GeX8cw
	 bM+8s4EcXpHkCKBbOUW011Lgy6brdfSoFjpx4IFPx/R6jKnkaAm+iscXfeIRLzu6K2
	 8/AlWKIG43uhQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Matlack <dmatlack@google.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 6/6] KVM: x86/mmu: Rename __direct_map() to direct_map()
Date: Thu, 30 Jul 2026 15:29:33 -0400
Message-ID: <20260730192933.3123642-6-sashal@kernel.org>
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

From: David Matlack <dmatlack@google.com>

[ Upstream commit 6c882ef4fc7bd99b67ad152e75428b669281c521 ]

Rename __direct_map() to direct_map() since the leading underscores are
unnecessary. This also makes the page fault handler names more
consistent: kvm_tdp_mmu_page_fault() calls kvm_tdp_mmu_map() and
direct_page_fault() calls direct_map().

Opportunistically make some trivial cleanups to comments that had to be
modified anyway since they mentioned __direct_map(). Specifically, use
"()" when referring to functions, and include kvm_tdp_mmu_map() among
the various callers of disallowed_hugepage_adjust().

No functional change intended.

Signed-off-by: David Matlack <dmatlack@google.com>
Reviewed-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20220921173546.2674386-11-dmatlack@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: 2abd5287f083 ("KVM: x86: Check for invalid/obsolete root *after* making MMU pages available")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/mmu/mmu.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 04e814816b17..c274ab0ceff9 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2991,11 +2991,11 @@ void disallowed_hugepage_adjust(u64 spte, gfn_t gfn, int cur_level,
 	    is_shadow_present_pte(spte) &&
 	    !is_large_pte(spte)) {
 		/*
-		 * A small SPTE exists for this pfn, but FNAME(fetch)
-		 * and __direct_map would like to create a large PTE
-		 * instead: just force them to go down another level,
-		 * patching back for them into pfn the next 9 bits of
-		 * the address.
+		 * A small SPTE exists for this pfn, but FNAME(fetch),
+		 * direct_map(), or kvm_tdp_mmu_map() would like to create a
+		 * large PTE instead: just force them to go down another level,
+		 * patching back for them into pfn the next 9 bits of the
+		 * address.
 		 */
 		u64 page_mask = KVM_PAGES_PER_HPAGE(level) -
 				KVM_PAGES_PER_HPAGE(level - 1);
@@ -3004,9 +3004,9 @@ void disallowed_hugepage_adjust(u64 spte, gfn_t gfn, int cur_level,
 	}
 }
 
-static int __direct_map(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
-			int map_writable, int max_level, kvm_pfn_t pfn,
-			bool prefault, bool is_tdp)
+static int direct_map(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
+		      int map_writable, int max_level, kvm_pfn_t pfn,
+		      bool prefault, bool is_tdp)
 {
 	bool nx_huge_page_workaround_enabled = is_nx_huge_page_enabled();
 	bool write = error_code & PFERR_WRITE_MASK;
@@ -4037,8 +4037,8 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 	if (r)
 		goto out_unlock;
 
-	r = __direct_map(vcpu, gpa, error_code, map_writable, max_level, pfn,
-			 prefault, is_tdp);
+	r = direct_map(vcpu, gpa, error_code, map_writable, max_level, pfn,
+		       prefault, is_tdp);
 
 out_unlock:
 	write_unlock(&vcpu->kvm->mmu_lock);
-- 
2.53.0

