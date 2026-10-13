Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAB53C0621;
	Tue, 13 Oct 2026 23:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791933461; cv=none; b=fB9ACjUL8luWaUD+lX81Z1+ZHuCYLdVcC3aB4u+jzJ58L64kQU8BR8JsPRha2rCU40+vvcr/i/ojm1a9sk2b220+AI+9n8T2RrmBcOlzAk9Ru5GzAwRUB+bdMBkRMfmabmm1ujui3hEHpm90TUgHCOs743jvHSJzWfpK3ZIeHaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791933461; c=relaxed/simple;
	bh=N+QuY7jOUaTog5mihZYTkDizuIk/wKQu6E8r/TLcB20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TaI1OwYGKEJdFQtmPnarot8td1+viotia9r85Q6CyV9FdCbCfrmAO2XCwVsqh/mLpj5Splk1xAqIFBQ0w//u1T61D2nuW4YabSVGmRwUrmCHXtDFqXu8MNO8e0cWM8ppxJl1dAQO6626tQ8uP4Xx2l+fSyEDQBcBEDLFJYkOgOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSoaz6Wa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSoaz6Wa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742E81F00899;
	Tue, 13 Oct 2026 23:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791933458;
	bh=4xzWyHD1dvLnqjxEawX73VA1q7KC44KCJfhrkSUuGUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NSoaz6WaJBo8ZOYdRLJG+8Xw0LunnC+rBvUHQUcWrzEU6YfyU6u7w9xku/uEYRNC2
	 zp5qpMVJatpsqRfSLxZby4GFJzmFSXYQQqDSSNqbbF8QLgeyqoH78Q9qCTuM8HqxpP
	 vSq1EhfYmo8alDXxx94CvYuuY822agkS+N4IHLyu2DIIkDOgV1bcXwLLIvXj0LwwgA
	 4RLwv2AI/5FnykHyLlvGz2hmROKI3rf9Q5AAbia6yFVpztMMPnVXpPMMKhdsqEtSG5
	 u5Qb0Nwe0xypMHWaw9Bt8ePMvjO7XXmpspXCJcAIH/Bichgb2rBQdSVjKps/regtK7
	 Lp6whd91rjTlA==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 2/4] KVM: x86/mmu: Drop for_each_shadow_entry_using_root()
Date: Tue, 13 Oct 2026 23:17:26 +0000
Message-ID: <20261013231728.883001-3-yosry@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261013231728.883001-1-yosry@kernel.org>
References: <20261013231728.883001-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop for_each_shadow_entry_using_root() and open code the walk in
__kvm_mmu_invalidate_addr(), the macro's only user, in preparation for
handling failure to initialize the walk, e.g. if a cached root was created
for a different MMU context and so can't be walked.

No functional change intended.

Suggested-by: Sean Christopherson <seanjc@google.com>
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/mmu/mmu.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 126faef5a6476..2fc23a36433c5 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -166,12 +166,6 @@ struct kvm_shadow_walk_iterator {
 	unsigned index;
 };
 
-#define for_each_shadow_entry_using_root(_vcpu, _root, _addr, _walker)     \
-	for (shadow_walk_init_using_root(&(_walker), (_vcpu),              \
-					 (_root), (_addr));                \
-	     shadow_walk_okay(&(_walker));			           \
-	     shadow_walk_next(&(_walker)))
-
 #define for_each_shadow_entry(_vcpu, _addr, _walker)            \
 	for (shadow_walk_init(&(_walker), _vcpu, _addr);	\
 	     shadow_walk_okay(&(_walker));			\
@@ -6754,7 +6748,8 @@ static void __kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu
 		return;
 
 	write_lock(&vcpu->kvm->mmu_lock);
-	for_each_shadow_entry_using_root(vcpu, root_hpa, addr, iterator) {
+	shadow_walk_init_using_root(&iterator, vcpu, root_hpa, addr);
+	for ( ; shadow_walk_okay(&iterator); shadow_walk_next(&iterator)) {
 		struct kvm_mmu_page *sp = sptep_to_sp(iterator.sptep);
 
 		if (sp->unsync) {
-- 
2.56.0.385.gd3acb90ef8-goog

