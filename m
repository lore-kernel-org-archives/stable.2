Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054373FA5CC
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 10:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783681017; cv=none; b=r39s5e0cT4duGKV2M2ynfzFdWPXngr6SdG3tttllh5sXXn/g81bTzfL5MCDR+5R/XtXQoSBB2crrEC2HB6DicojUWh/u6G62nMj4xrNsQ7TBCZURchx6TbiKexqPtD4BJaNH4xTaxuDMBlZj8Ea5ysqlWh1AcNjTzA3R6k5x72k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783681017; c=relaxed/simple;
	bh=1x+NshX1eIw2gkam3oEwwHZWNLI0M0/9eJ491FZMcYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lqQQqXu+ha7khdBjZk9aH0jxZgC5XcZ/Z8TlcJfaTNtb0VDYuU0x1c3EGihJp74QBi0pe/9RaH7len06urjLgPhSIWYsTtve+1fWNIdH/RalLEBJwAV0XYHzb2YzVwMW0fTS1OSXQ8ovnGU73FQyfTbzuP9owlF6TfEIqWFM1YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OCQ9off4; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OCQ9off4"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783681001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9+cZtzCSgj0oqYkJlHKXjgXLag2Yp/++TMmV/k7LrHM=;
	b=OCQ9off4uSBieuNMdiqSXYI9BbZC99ylbynli+MY5iwLPMJwgNX7zyVGsQPB+4Cg7Uh7zA
	wgNSWCW1NuX4+wBtWiAo3RNAOESXyPjb0+0Usvz5cwtmG4/FEfFp76IcZOk3k8miSJ/Ipd
	Ns+LNpp7tGEcaKdjiQuRubHhH2yK2bM=
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	apopple@nvidia.com,
	balbirs@nvidia.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	byungchul@sk.com,
	david@kernel.org,
	dev.jain@arm.com,
	gourry@gourry.net,
	jannh@google.com,
	joshua.hahnjy@gmail.com,
	lance.yang@linux.dev,
	liam@infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	matthew.brost@intel.com,
	npache@redhat.com,
	rakie.kim@sk.com,
	ryan.roberts@arm.com,
	usama.arif@linux.dev,
	vbabka@kernel.org,
	ying.huang@linux.alibaba.com,
	ziy@nvidia.com,
	shakeel.butt@linux.dev,
	hannes@cmpxchg.org
Cc: stable@vger.kernel.org
Subject: [PATCH v3 3/3] mm/huge_memory: skip device-private PMDs in madvise_free_huge_pmd
Date: Fri, 10 Jul 2026 03:55:23 -0700
Message-ID: <20260710105557.1987433-4-usama.arif@linux.dev>
In-Reply-To: <20260710105557.1987433-1-usama.arif@linux.dev>
References: <20260710105557.1987433-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

madvise_free_pte_range() checks pmd_trans_huge(*pmd) unlocked, then
madvise_free_huge_pmd() takes pmd_trans_huge_lock(). pmd_is_huge()
returns true for a device-private PMD, so orig_pmd can be device-private
and enter the !pmd_present() branch.

Skip device-private PMDs in that non-present branch and continue to out
before calling pmd_folio(). Downgrade the check to VM_WARN_ON_ONCE() so
an unexpected PMD softleaf logs a warning rather than panicking. Drop
the thp_migration_supported() guard: it expands to
IS_ENABLED(CONFIG_ARCH_SUPPORTS_PMD_SOFTLEAF), and both
pmd_is_migration_entry() and pmd_is_device_private_entry() already
return false when that config is not selected, so the guard suppresses
only the case where the warning would already be silent.

Potential trigger: an HMM-based GPU driver races with madvise(MADV_FREE):
migrate_vma_pages() flips the PMD to a device-private entry between the
caller's pmd_trans_huge() check and the callee's pmd_trans_huge_lock().

Fixes: 368076f52ebe ("mm/huge_memory: add device-private THP support to PMD operations")
Cc: <stable@vger.kernel.org>
Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Balbir Singh <balbirs@nvidia.com>
Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 mm/huge_memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c0892cc533a9..7ae21b006b68 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2297,8 +2297,8 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		goto out;
 
 	if (unlikely(!pmd_present(orig_pmd))) {
-		VM_BUG_ON(thp_migration_supported() &&
-				  !pmd_is_migration_entry(orig_pmd));
+		VM_WARN_ON_ONCE(!pmd_is_migration_entry(orig_pmd) &&
+				!pmd_is_device_private_entry(orig_pmd));
 		goto out;
 	}
 
-- 
2.53.0-Meta

