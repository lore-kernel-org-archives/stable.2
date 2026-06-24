Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9BA322B8C;
	Wed, 24 Jun 2026 16:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782316861; cv=none; b=PMp46vI+w49rCddCSHor192NhD3RdiBOJN+BFxK9GxKfiC/6vI6+8QI9Pki45IRazhKPyQduHnfpKQ1S9Y6UnkLWFKwD5cSOMsv4N01aaXGkyDokVbLOf7+/Ku2O0Pu1Dbf2JiKvmxooUgERXv2H2ReEPI+CJ7TESrJ1DT1Ba/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782316861; c=relaxed/simple;
	bh=Gm/4FKTU+gt1JezxjVVCvg6kUKRimNY4bQzZTDgn0+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FykwMYl3SEVUB09crnt6zHxFy5OsJ9SR6Vtob3um4hCMDLsMrccOlxiQgC0LVfdalc7cCGtaARet70LkUa3b5C0bEr31u78VeapMMoTe8NOKTaAbO3pFJSVI0xYxyGbH+FqxZeaU53GY/3Y0xVGq88OKxzVL+WbaPZgwePoH7aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=NUupqmco; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="NUupqmco"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782316858;
	bh=27eGtMV/VL4SJZrnEukuEHZvKKeCvPLD9+eyEw2LS6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NUupqmcoxFOZW7w6cbF6SS8jwwQVbWz+gOcb+zEcrheYM8cxFDxmlaSDvetRxD6gA
	 C4m86f7RlFKMS0F/wAbs3M5QSyJorsWGRGkbyh9RLhtvKyGfEEv5GseZfFQGR3FViS
	 0rcjZNYlsNCtqCAfHj+7bJavfoVXBHiBzmV/g3hI=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4glmrB4K0Gz10v5;
	Wed, 24 Jun 2026 16:00:58 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4glmr813dGz10v2;
	Wed, 24 Jun 2026 16:00:56 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>
Cc: Fuad Tabba <tabba@google.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Quentin Perret <qperret@google.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Gavin Shan <gshan@redhat.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Bradley Morgan <include@grrlz.net>,
	stable@vger.kernel.org
Subject: [PATCH v3 3/3] KVM: arm64: top up stage 2 memcache for dirty logging faults
Date: Wed, 24 Jun 2026 16:00:28 +0000
Message-ID: <20260624160028.15591-4-include@grrlz.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624160028.15591-1-include@grrlz.net>
References: <20260624160028.15591-1-include@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dirty logging forces new stage 2 mappings down to page size, but
it does not always remove an existing block mapping before the next
fault. Eager splitting is best effort and is disabled by default.

A permission fault on such a block can still need a page table page
to install the smaller mapping. Top up the memcache for any permission
fault while dirty logging is active, not only for write faults.

The issue was discovered [1] by Sashiko.

Link: https://lore.kernel.org/all/59984F6D-06F2-4302-BDD7-92DF334E8FA0@grrlz.net/T/#t [1]

Fixes: 6f745f1bb5bf ("KVM: arm64: Convert user_mem_abort() to generic page-table API")
Cc: stable@vger.kernel.org
Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 arch/arm64/kvm/mmu.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 3f57f6825a33..8911e319e6fa 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -2122,13 +2122,12 @@ static int user_mem_abort(const struct kvm_s2_fault_desc *s2fd)
 	 * Permission faults just need to update the existing leaf entry,
 	 * and so normally don't require allocations from the memcache. The
 	 * only exception to this is when dirty logging is enabled at runtime
-	 * and a write fault needs to collapse a block entry into a table. With
-	 * pKVM, they may still need a fresh mapping object if the fault turns
-	 * page entries into a block entry.
+	 * and a fault needs to collapse a block entry into a table. With pKVM,
+	 * they may still need a fresh mapping object if the fault turns page
+	 * entries into a block entry.
 	 */
 	memcache = get_mmu_memcache(s2fd->vcpu);
-	if (!perm_fault || (memslot_is_logging(s2fd->memslot) &&
-			    kvm_is_write_fault(s2fd->vcpu))) {
+	if (!perm_fault || memslot_is_logging(s2fd->memslot)) {
 		ret = topup_mmu_memcache(s2fd->vcpu, memcache);
 		if (ret)
 			return ret;
-- 
2.53.0

