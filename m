Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5643D093C;
	Tue,  1 Sep 2026 13:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268741; cv=none; b=G30PW2r3SmH3ivjvrTNYsTW88k5AatlWtgRvByH+am4gADtRk8ItArZRbZSR7z3ed1T3/37nXh67R2NR4CQL6c1KMAcoETnv9Y9IS8bDwbSNeruYgSyKP0EYmtmifvbVoYiY39ADsGL77Pi2qsmptLDFQCChowlr/pbQ/8Kwcuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268741; c=relaxed/simple;
	bh=6Z73CbNxQYTOYNM3TzN9z5SgCwrzw1We6fTUP5ae8l4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KyMub0yHvdH/c/S9UagLBWQR6vrNqeHUxUOg2vpJ6zMCu/hzWMngHuFZSPty8UBfJZ1n9W1HMFGCCmE2WVrKDvRk5nh+NNn1OTQGB8XeGXuZXx8sUVsYoWr0alVJH2+WaG7QmcDY6f3RQoiMjKg1/a4pjSL+UgBnL4JDU+jT8Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkOGbXHt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkOGbXHt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205671F000E9;
	Tue,  1 Sep 2026 13:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788268740;
	bh=SLM/iGuOERBTFxu8mql/4ATf4p59p9Me6R2GTZoj17M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BkOGbXHtNIV35nOD5BO38v1EVSPQbb31jM9e4LeI3O8uWXuBhWBo26gj2J8OGjLyA
	 bfkqbYKmd4jKEKq4DT5PjTxpucmJ3jX62oeonMNLCn2iuBLx7v/zkOn4cFcNx8bnXP
	 N3eM8+zvmHvTrM+Jr9oBoI+blmqUHzNMiDt2+/Nufo4giN+U0slj6n1VyeaakH/Ocx
	 R9pMr52UT7DuImtFuJq78RdTnmyazUlmpGAUH5tnRlIGl80T863jBTjmNoVhCay7sl
	 0bZNFQAD/fVDF3jQWDuVk5+X+n5bZp8Qvh5IyVv1ANMJZT+kW4VU6Vao7kENYxmTOZ
	 f++qIJtRLtwMA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 5/8] mm/damon/vaddr: respect folio end for DAMOS_MIGRATE_{HOT,COLD}
Date: Tue,  1 Sep 2026 06:18:46 -0700
Message-ID: <20260901131850.98037-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901131850.98037-1-sj@kernel.org>
References: <20260901131850.98037-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For applying DAMOS_MIGRATE_{HOT,COLD} actions to a region, DAMON virtual
address space operation set (vaddr) calls walk_page_range[_vma]() for
the region.  The pmd walk entry function, namely
damon_va_migrate_pmd_entry(), collects folios of addresses of the region
in the pmd.  It starts from the walking address and advances the address
by the size of the folio of the address until it goes out of the pmd or
the region.

Let's suppose it is for the first pmd of the region, and the region
start address is in the middle of a large folio.  Also, the next folios
are small.  Then, some of the next folios could be skipped.  Fix the
issue by advancing the address to exactly the start address of the next
folio.

The user impact is that DAMOS action is applied to less than expected
amount of memory.  Given the best effort nature of DAMON, it is no big
problem, but it is clearly a bug that is better to be fixed.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260514015053.149396-1-sj@kernel.org

Fixes: 09efc56a3b1c ("mm/damon/vaddr: consistently use only pmd_entry for damos_migrate")
Cc: <stable@vger.kernel.org> # 6.19.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/vaddr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 4b0b5edf67952..c8c32b2ae0402 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -669,6 +669,8 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
 		return 0;
 
 	for (; addr < next; pte += nr, addr += nr * PAGE_SIZE) {
+		unsigned long page_idx;
+
 		nr = 1;
 		ptent = ptep_get(pte);
 
@@ -681,7 +683,8 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
 			continue;
 		damos_va_migrate_dests_add(folio, walk->vma, addr, dests,
 				migration_lists);
-		nr = folio_nr_pages(folio);
+		page_idx = folio_page_idx(folio, pte_page(ptent));
+		nr = folio_nr_pages(folio) - page_idx;
 	}
 	pte_unmap_unlock(start_pte, ptl);
 	return 0;
-- 
2.47.3
