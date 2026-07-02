Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EF6346795;
	Thu,  2 Jul 2026 05:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782969294; cv=none; b=Gke5n+0YEC5enLuSnkPJ8Hxp1sBEVPcxYGmRGu6Zi8JHxM7BmQx+T+l4Rd7/VV/m6teU1QEc9Sr1BokeGdKIqppVvY+/E4Gf0gERCaUD47X71XqhNj/kJjy4ad43EkOqJUb5A+I2oOOGV7BWp2/tqyHLRJW3ncEbSmP9mFIaOto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782969294; c=relaxed/simple;
	bh=tWPUJM3ApyzUL1CLJURNBUdDRGtvetjvWdOoXK1V7p0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MFaOybVT9iTqpXr1RdKuY1JgMCS/AYtLYHJL0Yrq2SvKB8M5ctZ2OhgThM11LtdWheq7pg2aSJkxM/fhwrg7dV2n9r/zNnGM923nO1TFUmsXfvj3n81m+inQJr6KiqQpQ0SngOwtsbZxLqRIg3LL/8c1iDO7X/Dy9NabisTTWpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DDrlaq0+; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DDrlaq0+"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94A043583;
	Wed,  1 Jul 2026 22:14:47 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-01.blr.arm.com (cesw-amp-gbt-1s-m12830-01.blr.arm.com [10.164.195.31])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6B8DA3F85F;
	Wed,  1 Jul 2026 22:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782969292; bh=tWPUJM3ApyzUL1CLJURNBUdDRGtvetjvWdOoXK1V7p0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DDrlaq0+IWhU237/v+5Xe0K3EQV2aB3VOTY4IgfYNaGwE1udm/NmcgAzHAGuUJJqi
	 BjQok5c+LK1adWHLW3RfQr7KfM0iR8CHgZALpIbYJYoRS1MuWLJK4D2PvUTOnzL+54
	 HG17AfutxHvYMucTCwxfnz+MRst0pYFqhR0D9lUo=
From: Dev Jain <dev.jain@arm.com>
To: muchun.song@linux.dev,
	osalvador@suse.de,
	akpm@linux-foundation.org,
	ljs@kernel.org,
	david@kernel.org,
	liam@infradead.org
Cc: Dev Jain <dev.jain@arm.com>,
	riel@surriel.com,
	vbabka@kernel.org,
	harry@kernel.org,
	jannh@google.com,
	lance.yang@linux.dev,
	kas@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	rcampbell@nvidia.com,
	apopple@nvidia.com,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	j-nomura@ce.jp.nec.com,
	nao.horiguchi@gmail.com,
	ak@linux.intel.com,
	mel@csn.ul.ie,
	pfalcato@suse.de,
	jpoimboe@kernel.org,
	dave.hansen@intel.com,
	tglx@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	stable@vger.kernel.org
Subject: [PATCH v2 4/6] mm/migrate: use huge_ptep_get() in remove_migration_pte()
Date: Thu,  2 Jul 2026 05:13:38 +0000
Message-ID: <20260702051341.126509-5-dev.jain@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702051341.126509-1-dev.jain@arm.com>
References: <20260702051341.126509-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

remove_migration_pte() converts migration entries back to present PTEs
after folio migration completes. For hugetlb folios,
page_vma_mapped_walk() returns the pte pointer to the hugetlb folio in
pvmw.pte, but the code reads it with ptep_get().

On arches which provide their own huge_ptep_get() to dereference a huge
pte pointer, accessing via ptep_get() would cause pte_pfn(),
pte_present() etc to misbehave.

It is not clear whether this has a trivially visible effect to userspace.

Use huge_ptep_get() to dereference a huge pte pointer.

Fixes: 290408d4a250 ("hugetlb: hugepage migration core")
Cc: stable@vger.kernel.org
Acked-by: Muchun Song <muchun.song@linux.dev>
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 mm/migrate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index d9b23909d716c..c65f0f43df7eb 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -371,7 +371,11 @@ static bool remove_migration_pte(struct folio *folio,
 			continue;
 		}
 #endif
-		old_pte = ptep_get(pvmw.pte);
+		if (folio_test_hugetlb(folio))
+			old_pte = huge_ptep_get(vma->vm_mm, pvmw.address,
+						pvmw.pte);
+		else
+			old_pte = ptep_get(pvmw.pte);
 		if (rmap_walk_arg->map_unused_to_zeropage &&
 		    try_to_map_unused_to_zeropage(&pvmw, folio, old_pte, idx))
 			continue;
-- 
2.43.0

