Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CBF3C13E9;
	Tue, 13 Oct 2026 23:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791933459; cv=none; b=jgfgkRVPCqnvFfT68NCROcre8KiaDeJwqrPr2ZRh9ysyI3IAbNy7R1ReWrf99WxBMe1aV5cif6Kx7YXORiGa24vQwZDsz3gmxRr+vwMnQaQvcMJHeZwoW/wN55LTWiQqjJ1Sdnm4Fuln3s7Len7mP99ZQ+acg9NOfBFORntboBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791933459; c=relaxed/simple;
	bh=33JnG/F84+g7dW9gc7B9FgRHqcmovFDITnsF1eHITJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gD04bTWA3FFdwAw4WLw9d1qcao0sgQGofL/0U9cl1382c77UjRqt1NZKZE7A9+LjxZC964qwQEnbCieK6Cw6N3lREY6pEHfan+JM2GoafC01UqnaUl1iWm6YS8Qd6KNDpwqJ/ldoYePwv4xr1daRg/baH0o7Ayz2n+XwnZlHWmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGP5oktP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGP5oktP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6721F00898;
	Tue, 13 Oct 2026 23:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791933458;
	bh=EY8kA5PqbX97Y5Nf/7EbUqW1b4OJop/vthxq+shRPtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BGP5oktP75MG5jRkn713lv4F5JBoczj6kimNZ/HWRyzQbwqS+u+q2m9/9YNY0ll3p
	 3dB2Yl1qvGIsBfednV9soMEDvw6tVzu9VKBpdw17zrkJOY4Z4IIa20X8x6UPJCtGP3
	 lI+6du/q6yK3h8UQ+5Yairv+DwgAXdUimo5cbdEln6HYVZpIDDXHic6mcSkXNoFldF
	 MAmnX+zPoS6AbI+TWseXV5BvYMRfRHUdBEo7GJrQF4NOvOPixmeMhqALuQsNOn9buk
	 cV+/MrwXfGpss/ELpGVKgyGS6SmaumEFcv/7EWTQ7zEp9vFzP/wY8zsC3mBXRvGYnJ
	 YoYzw/LMvARLw==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/4] KVM: x86/mmu: WARN, don't BUG, when walking a cached root with a PAE MMU
Date: Tue, 13 Oct 2026 23:17:25 +0000
Message-ID: <20261013231728.883001-2-yosry@kernel.org>
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

Replace the BUG_ON() in shadow_walk_init_using_root() that guards against
walking a cached (previous) root while the MMU is configured for PAE
paging with a WARN_ON_ONCE(), and terminate the walk if the WARN fires.
Walking a cached root with a PAE MMU is a KVM bug, as PAE roots are never
cached, but there's no need to bring down the host, as KVM can simply
bail from the walk.

Note, the BUG_ON() is currently reachable by a guest if TDP is disabled,
as KVM walks cached roots even if they were created for a different MMU
context, e.g. if L2 executes INVLPG while using PAE paging, L1 doesn't
intercept INVLPG, and L1's 64-bit root is cached.

Add a common error label for terminating the walk, and use it for the
existing invalid/dummy root check as well.

Fixes: 7eb77e9f5fcf ("kvm: x86: Add a root_hpa parameter to kvm_mmu->invlpg()")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/mmu/mmu.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index aadd5bdc2c97a..126faef5a6476 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2558,10 +2558,8 @@ static void shadow_walk_init_using_root(struct kvm_shadow_walk_iterator *iterato
 	iterator->addr = addr;
 	iterator->shadow_addr = root;
 
-	if (WARN_ON_ONCE(!VALID_PAGE(root)) || kvm_mmu_is_dummy_root(root)) {
-		iterator->level = 0;
-		return;
-	}
+	if (WARN_ON_ONCE(!VALID_PAGE(root)) || kvm_mmu_is_dummy_root(root))
+		goto error;
 
 	iterator->level = vcpu->arch.mmu->root_role.level;
 
@@ -2575,7 +2573,8 @@ static void shadow_walk_init_using_root(struct kvm_shadow_walk_iterator *iterato
 		 * prev_root is currently only used for 64-bit hosts. So only
 		 * the active root_hpa is valid here.
 		 */
-		BUG_ON(root != vcpu->arch.mmu->root.hpa);
+		if (WARN_ON_ONCE(root != vcpu->arch.mmu->root.hpa))
+			goto error;
 
 		iterator->shadow_addr
 			= vcpu->arch.mmu->pae_root[(addr >> 30) & 3];
@@ -2584,6 +2583,10 @@ static void shadow_walk_init_using_root(struct kvm_shadow_walk_iterator *iterato
 		if (!iterator->shadow_addr)
 			iterator->level = 0;
 	}
+	return;
+
+error:
+	iterator->level = 0;
 }
 
 static void shadow_walk_init(struct kvm_shadow_walk_iterator *iterator,
-- 
2.56.0.385.gd3acb90ef8-goog

