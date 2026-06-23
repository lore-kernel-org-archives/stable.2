Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506CF30BF4E;
	Tue, 23 Jun 2026 16:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782230627; cv=none; b=io/2ctHIJ9VMa33IcUQDI5DYXMq9M3EAH2huQj/4xqMPeHpaYIPZLqH9rNqFz88+t9C1HI3icmqGG8UA6vh9NPJKTLbGAwzLXNAbsC0gCF5JwfrT3izUwGLGQNTzSU29vJi9CPr3akr6hSMuy0/sX9lO7WDUbtkNok5wcChXkbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782230627; c=relaxed/simple;
	bh=xA9YfqTuGRMnUD7VqfUSzd8lOI9h6g5dP4YXGJmaJZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TZAgh8l8wfCHvoCr2A3NvLUWXc4HXuh/saNpAFSSJTc9tZOu6b4aVc+kSWNW7Ip6e4KEcC2InczT3nvHK3YV8LEYRJcbp/6Q9nrzgehTuJaApXRxPgQ1fnjhRyeVgAyyQaUd+BycOqI/inW97HLQB0RbKLpsu30zj31VQTfOTxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=roH4qtC/; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="roH4qtC/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782230623;
	bh=qp76MOZfkgfbvVC3NAMXAD7D03E4T9rNo0rJqkiEJiI=;
	h=From:To:Cc:Subject:Date:From;
	b=roH4qtC/vCJAmrGeyJBBp+EBB3owg2oMpGfPEaMRjNOAHg+SZF+HbaoH7bG+8ARfx
	 yJC1StVlOmpPO41qaaT090JQeNsMxzxy3dj2t3pZ2vozAHaQ8/gG/z4iiTiGQXj1aj
	 JaiMqrPOchzCEWycjntF7H8RSOUdN6qXqfCDOtw4=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4gl8xq50DFz110W;
	Tue, 23 Jun 2026 16:03:43 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4gl8xp6CCYz10hk;
	Tue, 23 Jun 2026 16:03:42 +0000 (UTC)
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
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bradley Morgan <include@grrlz.net>,
	stable@vger.kernel.org
Subject: [PATCH] KVM: arm64: skip pKVM cache flushes for non cacheable mappings
Date: Tue, 23 Jun 2026 16:03:39 +0000
Message-ID: <20260623160339.15143-1-include@grrlz.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pKVM keeps its own mapping list for stage 2 operations. Its flush path
uses that list directly, so it lost the PTE attribute check done by the
generic stage 2 walker.

Record whether a mapping is cacheable and skip cache maintenance for
mappings that are not cacheable.

Fixes: e912efed485a ("KVM: arm64: Introduce the EL1 pKVM MMU")
Cc: stable@vger.kernel.org
Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 arch/arm64/include/asm/kvm_pkvm.h | 1 +
 arch/arm64/kvm/pkvm.c             | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_pkvm.h b/arch/arm64/include/asm/kvm_pkvm.h
index 74fedd9c5ff0..d9dd8239910d 100644
--- a/arch/arm64/include/asm/kvm_pkvm.h
+++ b/arch/arm64/include/asm/kvm_pkvm.h
@@ -196,6 +196,7 @@ struct pkvm_mapping {
 	u64 gfn;
 	u64 pfn;
 	u64 nr_pages;
+	bool cacheable;
 	u64 __subtree_last;	/* Internal member for interval tree */
 };
 
diff --git a/arch/arm64/kvm/pkvm.c b/arch/arm64/kvm/pkvm.c
index 428723b1b0f5..105ab1258066 100644
--- a/arch/arm64/kvm/pkvm.c
+++ b/arch/arm64/kvm/pkvm.c
@@ -473,6 +473,8 @@ int pkvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
 	mapping->gfn = gfn;
 	mapping->pfn = pfn;
 	mapping->nr_pages = size / PAGE_SIZE;
+	mapping->cacheable = !(prot & (KVM_PGTABLE_PROT_DEVICE |
+				       KVM_PGTABLE_PROT_NORMAL_NC));
 	pkvm_mapping_insert(mapping, &pgt->pkvm_mappings);
 
 	return ret;
@@ -517,9 +519,13 @@ int pkvm_pgtable_stage2_flush(struct kvm_pgtable *pgt, u64 addr, u64 size)
 	struct pkvm_mapping *mapping;
 
 	lockdep_assert_held(&kvm->mmu_lock);
-	for_each_mapping_in_range_safe(pgt, addr, addr + size, mapping)
+	for_each_mapping_in_range_safe(pgt, addr, addr + size, mapping) {
+		if (!mapping->cacheable)
+			continue;
+
 		__clean_dcache_guest_page(pfn_to_kaddr(mapping->pfn),
 					  PAGE_SIZE * mapping->nr_pages);
+	}
 
 	return 0;
 }
-- 
2.53.0

