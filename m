Received: from www5210.sakura.ne.jp (www5210.sakura.ne.jp [133.167.8.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D605237DE9B;
	Sun, 13 Sep 2026 16:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=133.167.8.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789317458; cv=none; b=Jt33oPCrUi79HbqeLBQdYJP8tQYvIsskfh7iBr6j92fV0+KdRGA5gc8tIkr0nQG75eX5WcAvSzSpxcyMg5t8chvdfhw9ABs3o0dAazLFZF2HFUL+k158z2qFsWLxYr8oWe+hP8sdFsJAHUKsc9j65NW1jNzo4RLxauSOYAme43Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789317458; c=relaxed/simple;
	bh=5C2SbOtkyUoqeQdkPA3Ebp0XAKFZct1yG6BK+sDxttE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QwFhc+de/NwEqpDp5FR/A1v+Q/Th0QCem77p4rNF3OKC6MIZ+5PUDH4C7x2mnDDDgwpg8dv5ceRwucik1dJhGj/dqINqVSuKF+4coA4tlHc+k8Xgwk4PDeJpTRenYBwNWSeIuM1UGq69IBG3MKIhzGUAJMIN10C3/vdlC/Cq88w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me; spf=pass smtp.mailfrom=mgml.me; dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b=kXBChM8p; arc=none smtp.client-ip=133.167.8.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mgml.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b="kXBChM8p"
Received: from fedora (p3233127-ipxg00b01tokaisakaetozai.aichi.ocn.ne.jp [180.17.90.127])
	(authenticated bits=0)
	by www5210.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68DFtZE9020593
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 14 Sep 2026 00:55:48 +0900 (JST)
	(envelope-from k@mgml.me)
DKIM-Signature: a=rsa-sha256; bh=pNPAfQf6/2IBhXvxqMcBuNLv8oIzKY2JGuQKmXs1nPY=;
        c=relaxed/relaxed; d=mgml.me;
        h=From:Message-ID:To:Subject:Date;
        s=rs20250315; t=1789314948; v=1;
        b=kXBChM8pyrwasQjtrtj9Y2S1kWbGxA5dz5I/hZ5HgBg9MI81bAx1jw+YyXAIz8/w
         taPQFaFoAFFSKB84KiMuvk/7RH1y/wcQswu5Upu3W5IG0ckxqHnEc7cWOOAWf7na
         VhFcfInckRv+IWG6I/lzci+F4W4t3vPim8zDtHM/XJShAHGqvKAyQ0HF/O2plt9N
         rwyH7TXiBUBwk/wYxmN/6jWtTMbFsjsNsc41N8kfZrB5M7kGnu1Cl37HzQ/0PVkk
         ECBw6fdHXk1lMdqT1/3ZRv1h0ClUUHFp2FU9D7uP+l9HlTo+48TskWXqHWcOgq6T
         51hTRPKZKpGY8cwhG9okUQ==
From: Kenta Akagi <k@mgml.me>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, stable@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Matlack <dmatlack@google.com>,
        Kenta Akagi <k@mgml.me>
Subject: [PATCH 5.15.y v3 4/7] KVM: x86/mmu: Always pass 0 for @quadrant when gptes are 8 bytes
Date: Mon, 14 Sep 2026 00:55:20 +0900
Message-ID: <20260913155523.7423-5-k@mgml.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913155523.7423-1-k@mgml.me>
References: <20260913155523.7423-1-k@mgml.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Bonzini <pbonzini@redhat.com>

commit 7f49777550e55a7d6832cbb0873f48f91c175b9c upstream.

The quadrant is only used when gptes are 4 bytes, but
mmu_alloc_{direct,shadow}_roots() pass in a non-zero quadrant for PAE
page directories regardless. Make this less confusing by only passing in
a non-zero quadrant when it is actually necessary.

Signed-off-by: David Matlack <dmatlack@google.com>
Message-Id: <20220516232138.1783324-6-dmatlack@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Kenta Akagi <k@mgml.me>
---
 arch/x86/kvm/mmu/mmu.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index b0504d40ac8c..b7801690ea17 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3474,9 +3474,10 @@ static hpa_t mmu_alloc_root(struct kvm_vcpu *vcpu, gfn_t gfn, int quadrant,
 	struct kvm_mmu_page *sp;
 
 	role.level = level;
+	role.quadrant = quadrant;
 
-	if (!role.gpte_is_8_bytes)
-		role.quadrant = quadrant;
+	WARN_ON_ONCE(quadrant && role.gpte_is_8_bytes);
+	WARN_ON_ONCE(role.direct && !role.gpte_is_8_bytes);
 
 	sp = kvm_mmu_get_page(vcpu, gfn, role);
 	++sp->root_count;
@@ -3512,7 +3513,7 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
 		for (i = 0; i < 4; ++i) {
 			WARN_ON_ONCE(IS_VALID_PAE_ROOT(mmu->pae_root[i]));
 
-			root = mmu_alloc_root(vcpu, i << (30 - PAGE_SHIFT), i,
+			root = mmu_alloc_root(vcpu, i << (30 - PAGE_SHIFT), 0,
 					      PT32_ROOT_LEVEL);
 			mmu->pae_root[i] = root | PT_PRESENT_MASK |
 					   shadow_me_mask;
@@ -3536,9 +3537,8 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	struct kvm_mmu *mmu = vcpu->arch.mmu;
 	u64 pdptrs[4], pm_mask;
 	gfn_t root_gfn, root_pgd;
+	int quadrant, i, r;
 	hpa_t root;
-	unsigned i;
-	int r;
 
 	root_pgd = mmu->get_guest_pgd(vcpu);
 	root_gfn = root_pgd >> PAGE_SHIFT;
@@ -3621,7 +3621,15 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 			root_gfn = pdptrs[i] >> PAGE_SHIFT;
 		}
 
-		root = mmu_alloc_root(vcpu, root_gfn, i, PT32_ROOT_LEVEL);
+		/*
+		 * If shadowing 32-bit non-PAE page tables, each PAE page
+		 * directory maps one quarter of the guest's non-PAE page
+		 * directory. Othwerise each PAE page direct shadows one guest
+		 * PAE page directory so that quadrant should be 0.
+		 */
+		quadrant = !mmu->mmu_role.base.gpte_is_8_bytes ? i : 0;
+
+		root = mmu_alloc_root(vcpu, root_gfn, quadrant, PT32_ROOT_LEVEL);
 		mmu->pae_root[i] = root | pm_mask;
 	}
 
-- 
2.53.0

