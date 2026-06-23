Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC0230F816;
	Tue, 23 Jun 2026 16:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782232685; cv=none; b=f2IMCahCCESfovf1XQu5B/BhHp/FlJeNKGM4Kfdk9W+CLSeoNlPi9pOTy+aGRPjKV9WVNr3YWOQMBLqDQDoO7Ru84hzFKox0mkzLRkWNT2ZSWg+kxYxdvDAGET8hJISDxLZ3Z/OnpkYhEELQMCiurUx/i+v9W+EDsVkbGA4LN5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782232685; c=relaxed/simple;
	bh=2aQ7BkU4NZeFpXLMc+Ibd+6a2ttSQ+izjF9vuC4rBsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eA6HyxUPkMj47G+uH2R0F1U8aUJaePG3Yk2hecfVVyJokDNUdHZmQ7rdMHA162lvF34bGYTCCfBz4O7JL3Hd3LGa2oMG9dKHfCxtqhK/sOPxYuX1wFQvFeocc3LBqyxAzQ4/Lc+3bEvVOqqssy2dYdRKxr+R2d0V6XnOIStXLs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=ExT/Z7YP; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="ExT/Z7YP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782232682;
	bh=RdA+tt6udTEt4Fk49QJIhcJwNDLh2tJtFcBL+wwe0sQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ExT/Z7YP3YU2JyOSNY+wfEgfr1FclDxQhziKlNhcpUHbxY8mcWfOjjq4YzjPuHw5Y
	 hccwO75cxy5vP5bEMPwh1tBvMV53kOMb2b7y+DDGVcBnSDTpwJa61p5thIDifzVmov
	 nFS/JLf8aAZoIks+RfDfn3ZTcujMEOwvnyDRUPZs=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4gl9jQ64Lwz110l;
	Tue, 23 Jun 2026 16:38:02 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4gl9jP69RNz10xM;
	Tue, 23 Jun 2026 16:38:01 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	kvmarm@lists.linux.dev
Cc: Fuad Tabba <tabba@google.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Quentin Perret <qperret@google.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bradley Morgan <include@grrlz.net>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] KVM: arm64: top up pKVM mapping cache for permission faults
Date: Tue, 23 Jun 2026 16:37:56 +0000
Message-ID: <20260623163756.4591-2-include@grrlz.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623163756.4591-1-include@grrlz.net>
References: <20260623160339.15143-1-include@grrlz.net>
 <20260623163756.4591-1-include@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Permission faults normally only relax an existing leaf, so the fault path
does not top up the memcache.

With pKVM, a permission fault can also replace page mappings with a
PMD mapping. That path needs a fresh pkvm_mapping object, and can
dereference a NULL cache->mapping if the cache was not topped up.

Allocate just that object for pKVM permission faults.

The issue was discovered [1] by Sashiko.

Link: https://lore.kernel.org/all/20260623161545.EA08E1F000E9@smtp.kernel.org/ [1]

Fixes: db14091d8f75 ("KVM: arm64: Stage-2 huge mappings for np-guests")
Cc: stable@vger.kernel.org
Signed-off-by: Bradley Morgan <include@grrlz.net>
---
Changes in v2:
- New patch.

 arch/arm64/kvm/mmu.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 6c941aaa10c6..3f57f6825a33 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1177,17 +1177,26 @@ void free_hyp_memcache(struct kvm_hyp_memcache *mc)
 	__free_hyp_memcache(mc, hyp_mc_free_fn, kvm_host_va, mc);
 }
 
+static int topup_hyp_memcache_mapping(struct kvm_hyp_memcache *mc)
+{
+	if (mc->mapping)
+		return 0;
+
+	mc->mapping = kzalloc_obj(struct pkvm_mapping,
+				  GFP_KERNEL_ACCOUNT);
+	return mc->mapping ? 0 : -ENOMEM;
+}
+
 int topup_hyp_memcache(struct kvm_hyp_memcache *mc, unsigned long min_pages)
 {
+	int ret;
+
 	if (!is_protected_kvm_enabled())
 		return 0;
 
-	if (!mc->mapping) {
-		mc->mapping = kzalloc_obj(struct pkvm_mapping,
-					  GFP_KERNEL_ACCOUNT);
-		if (!mc->mapping)
-			return -ENOMEM;
-	}
+	ret = topup_hyp_memcache_mapping(mc);
+	if (ret)
+		return ret;
 
 	return __topup_hyp_memcache(mc, min_pages, hyp_mc_alloc_fn,
 				    kvm_host_pa, mc);
@@ -2113,7 +2122,9 @@ static int user_mem_abort(const struct kvm_s2_fault_desc *s2fd)
 	 * Permission faults just need to update the existing leaf entry,
 	 * and so normally don't require allocations from the memcache. The
 	 * only exception to this is when dirty logging is enabled at runtime
-	 * and a write fault needs to collapse a block entry into a table.
+	 * and a write fault needs to collapse a block entry into a table. With
+	 * pKVM, they may still need a fresh mapping object if the fault turns
+	 * page entries into a block entry.
 	 */
 	memcache = get_mmu_memcache(s2fd->vcpu);
 	if (!perm_fault || (memslot_is_logging(s2fd->memslot) &&
@@ -2121,6 +2132,10 @@ static int user_mem_abort(const struct kvm_s2_fault_desc *s2fd)
 		ret = topup_mmu_memcache(s2fd->vcpu, memcache);
 		if (ret)
 			return ret;
+	} else if (is_protected_kvm_enabled()) {
+		ret = topup_hyp_memcache_mapping(memcache);
+		if (ret)
+			return ret;
 	}
 
 	/*
-- 
2.53.0
