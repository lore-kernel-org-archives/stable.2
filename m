Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D84343CEC0
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 12:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783513266; cv=none; b=QhAruh5OEDsBbHlZ8kqnohmCNJl94YyUwli+wIPtVZQNIETCPVEAI0Fm3lHti4WkzX01qYQ3mEdHmS9MHXiyWU1OA6khM10xGeNIGALafo2fTRKa5N0AaiCFfhhutBLbQkJCZ/2S19Nppgu4sIqenV5m8q0awbAyfL/6v3zBwlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783513266; c=relaxed/simple;
	bh=YzyiN7+8WrRJ33CSwMc+ichHwHhAZeaUe0MAjuTW/M8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PhCdw/7kQ5hga7sbRIlfydCa1XYu3ZY6ifu1mwSS5OjoGQrzfcder6OgKRITtVOJbA/wO9RbN+NdmE+T1gAmCymsbf91wveL4YmzM6Fhv/vzPCfRnAoJ3bEVMeMUv48RjtIXCOaa1kcWy7WVWfcA3TqvWtcAHbtjnxN8fjqmNJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ajxAyxBE; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ajxAyxBE"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783513263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qeBPE3qqNKkGc9km/JVfd9nfFQXbGiGolg9akkEkv5A=;
	b=ajxAyxBESal7boD/bi8HZT804WclfFqwcrYVABQRi2Eb4JTN+ed/D2diDMMtnVf2ZtAL6H
	l7flUe5QstIg0w3bY11GKBJ9WQZSIyGWgB/VTG9ZbfKM8Dnug2ZkjRP3HmokIqcyi72Yn9
	b132k257dJ21thKwizSZBaGqG0b1DRo=
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
Subject: [PATCH v2 3/3] mm/huge_memory: skip device-private PMDs in madvise_free_huge_pmd
Date: Wed,  8 Jul 2026 05:20:09 -0700
Message-ID: <20260708122040.861335-4-usama.arif@linux.dev>
In-Reply-To: <20260708122040.861335-1-usama.arif@linux.dev>
References: <20260708122040.861335-1-usama.arif@linux.dev>
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

Allow device-private PMDs in that non-present assertion and continue to
out before calling pmd_folio(). This keeps the assertion for unexpected
PMD softleafs while skipping device-private PMDs like other non-present
PMDs in this path.

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
 mm/huge_memory.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c0892cc533a9..ddbdc83b4cae 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2298,7 +2298,8 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
 	if (unlikely(!pmd_present(orig_pmd))) {
 		VM_BUG_ON(thp_migration_supported() &&
-				  !pmd_is_migration_entry(orig_pmd));
+				  !pmd_is_migration_entry(orig_pmd) &&
+				  !pmd_is_device_private_entry(orig_pmd));
 		goto out;
 	}
 
-- 
2.53.0-Meta

