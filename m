Received: from www5210.sakura.ne.jp (www5210.sakura.ne.jp [133.167.8.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B524EFFC4;
	Mon, 28 Sep 2026 16:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=133.167.8.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613901; cv=none; b=sZZ/MT1+13vWUlyVtELgenIIAzZ2JAjofkwoEhrahFUtLajTkZtp0yqX9wVmQv7CxhTd6JUbk6CuoCA2G3gBF07vUuwriSe2e/c+p0PBuLaA++HMt9dDxFv9K7x1j52rL57J8/x0Zo6yY3cIcfwiIpHhaZc0JKUQLPDjCkaDgCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613901; c=relaxed/simple;
	bh=fF6BrxNabZ8uYURYJMaZdKHpbdY2dl7YO/LwAZZNXE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qa3q+FKDcNfkr6rcpRWhkZ8/hlinjD54nW0vySF+61e/D6dml72SZo2xLjRkxDQkVXHgWdjRSlTRLPbaQV15jqVCLGMGVjbynpjZ/YWU4dC9GTYwkauaNqO14dX3LjRdS4MWNCamwS2roGYoycayOUSrB7iPvQT0fzfuzszJRqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me; spf=pass smtp.mailfrom=mgml.me; dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b=i17TUazq; arc=none smtp.client-ip=133.167.8.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mgml.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b="i17TUazq"
Received: from fedora ([104.28.225.80])
	(authenticated bits=0)
	by www5210.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68SGijNn080644
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 29 Sep 2026 01:44:50 +0900 (JST)
	(envelope-from k@mgml.me)
DKIM-Signature: a=rsa-sha256; bh=ONwTd27hGGlJTVKeH/5etwyHj4/yEw8xYsr/hYa0hl0=;
        c=relaxed/relaxed; d=mgml.me;
        h=From:Message-ID:To:Subject:Date;
        s=rs20250315; t=1790613890; v=1;
        b=i17TUazqkMbgdFGVYyBmzAOW/zOWUq97Pnm3ZS0vFM4OXle5Mqco16+o0JvFc5UE
         q8p4o1p6p6bHkwAX2Cd5LzrrHV+vvrKVX8xVbKAaHynqe/JwfToOI/y/Kv0JkW6w
         VPn7EhkB5IuJqHaN/aTON+cGqBu5FRA679vUCT9j+N3dIqAyzC0lKqWK9zosOWxb
         Rw7Qzxcij41NVBQkF4edvEiuT/N9DKz9Ep4p2pEZCQI3oePZXRdVagqhJBwa85fK
         aZoED5lz85i/MgLkGsjbd2vPCC2DE4KVzFAN6vlj32M9y7veXj7qD0lvbtBlMyAo
         nOfO/ibco9UxaXUyT4SrEg==
From: Kenta Akagi <k@mgml.me>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, stable@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Matlack <dmatlack@google.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, Kenta Akagi <k@mgml.me>
Subject: [PATCH 5.15.y v4 02/11] KVM: x86/mmu: Stop passing "direct" to mmu_alloc_root()
Date: Tue, 29 Sep 2026 01:44:18 +0900
Message-ID: <20260928164427.4699-3-k@mgml.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928164427.4699-1-k@mgml.me>
References: <20260928164427.4699-1-k@mgml.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Matlack <dmatlack@google.com>

commit 86938ab6925b8fe174ca6abf397e6ea9d3c054a4 upstream.

The "direct" argument is vcpu->arch.mmu->root_role.direct,
because unlike non-root page tables, it's impossible to have
a direct root in an indirect MMU.  So just use that.

Suggested-by: Lai Jiangshan <jiangshanlai@gmail.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Message-Id: <20220516232138.1783324-4-dmatlack@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Kenta Akagi <k@mgml.me>
---
 arch/x86/kvm/mmu/mmu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index f5cfbf973e85..9f193b1620a9 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3439,8 +3439,9 @@ static int mmu_check_root(struct kvm_vcpu *vcpu, gfn_t root_gfn)
 }
 
 static hpa_t mmu_alloc_root(struct kvm_vcpu *vcpu, gfn_t gfn, gva_t gva,
-			    u8 level, bool direct)
+			    u8 level)
 {
+	bool direct = vcpu->arch.mmu->mmu_role.base.direct;
 	struct kvm_mmu_page *sp;
 
 	sp = kvm_mmu_get_page(vcpu, gfn, gva, level, direct, ACC_ALL);
@@ -3466,7 +3467,7 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
 		root = kvm_tdp_mmu_get_vcpu_root_hpa(vcpu);
 		mmu->root_hpa = root;
 	} else if (shadow_root_level >= PT64_ROOT_4LEVEL) {
-		root = mmu_alloc_root(vcpu, 0, 0, shadow_root_level, true);
+		root = mmu_alloc_root(vcpu, 0, 0, shadow_root_level);
 		mmu->root_hpa = root;
 	} else if (shadow_root_level == PT32E_ROOT_LEVEL) {
 		if (WARN_ON_ONCE(!mmu->pae_root)) {
@@ -3478,7 +3479,7 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
 			WARN_ON_ONCE(IS_VALID_PAE_ROOT(mmu->pae_root[i]));
 
 			root = mmu_alloc_root(vcpu, i << (30 - PAGE_SHIFT),
-					      i << 30, PT32_ROOT_LEVEL, true);
+					      i << 30, PT32_ROOT_LEVEL);
 			mmu->pae_root[i] = root | PT_PRESENT_MASK |
 					   shadow_me_mask;
 		}
@@ -3541,7 +3542,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	 */
 	if (mmu->root_level >= PT64_ROOT_4LEVEL) {
 		root = mmu_alloc_root(vcpu, root_gfn, 0,
-				      mmu->shadow_root_level, false);
+				      mmu->shadow_root_level);
 		mmu->root_hpa = root;
 		goto set_root_pgd;
 	}
@@ -3587,7 +3588,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 		}
 
 		root = mmu_alloc_root(vcpu, root_gfn, i << 30,
-				      PT32_ROOT_LEVEL, false);
+				      PT32_ROOT_LEVEL);
 		mmu->pae_root[i] = root | pm_mask;
 	}
 
-- 
2.53.0

