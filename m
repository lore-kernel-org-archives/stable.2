Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8233CB2F8;
	Tue,  1 Sep 2026 13:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268741; cv=none; b=he8wyg8an8osmFc21dVynCeAiOJau9OAMEOXIxf/vQmf3j7nGHvpIPIA03F3pBNZSGarfGV8se9k5B9uTExOD3y6nJTUdoqF0//AqzkuAdYL6nJ/z/axxzzQc0+DK8FZy9exO2mZUWEG9hRaNepUAso9kUperU4wgXTZ8bGyG04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268741; c=relaxed/simple;
	bh=5AGJ58CxaHUHnA7OwFTsM+2rMQoeaY6UpbD7qoJcoXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QEiHOinV1HCf5BmBCCOd+k/sxHEqi4WatI0O1OMx8l4l4p3BrG9SLcB1DVYlTNNwdkeRr/sKM3QpgzgunB34Rf0LAXCjHitSVOa4grr3pSF8zb3lKT0N4R5UPqKN0vyIM4HeuGcLTWa08gzqKAofLtC61LMNEtCX6Z/Q8FcO5kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKaTg89x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKaTg89x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B645C1F00A3F;
	Tue,  1 Sep 2026 13:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788268740;
	bh=nSTjwnDV8A+NiGPVQu+FC6bukzN4Edj/bjp5VqLzRxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LKaTg89xFTeHYyTU0AYlP5vP6CBoCrQY+li5Smev5n/gqRqavoXXXL2OkN/kD6Vgm
	 XgbB27M94hUc2eLdsd64j9MYA/F1dC3ikoy+VUUqSCyem0Xwq9qW5R/55RRwsfqF5o
	 MH5W7MLxavzLWxZmFKmrVaU1opKhs8Y3LvivBsF1hsd0KYQrdmd+sw9Di30uVWhtIX
	 dtQ5N7irsZmSpYO3RoKtDHp7fBf8fjvZVPx3QLA8+f4UK4fX0AC6a7ZBYPjo/J9Qjy
	 Yx0bVYJG/yQ+n8bqIXUn5flvjNOzeIqisuHGjajW+S1xBGBUM/s9NcJekTBTYSdHCc
	 MazJtTNWXOctA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Yueyang Pan <pyyjason@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/8] mm/damon/vaddr: respect folio end for DAMOS_STAT
Date: Tue,  1 Sep 2026 06:18:45 -0700
Message-ID: <20260901131850.98037-5-sj@kernel.org>
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

For applying DAMOS_STAT action to a region, DAMON virtual address space
operation set (vaddr) calls walk_page_range[_vma]() for the region.  The
pmd walk entry function, namely damon_va_stat_pmd_entry(), applies DAMOS
filters to folios of addresses of the region in the pmd.  It starts from
the walking address and advances the address by the size of the folio of
the address until it goes out of the pmd or the region.

Let's suppose it is for the first pmd of the region, and the region
start address is in the middle of a large folio.  Also, the next folios
are small.  Then, some of the next folios could be skipped.  Fix the
issue by advancing the address to exactly the start address of the next
folio.

The user impact is that the DAMOS_STAT-based page level monitoring
results become inaccurate.  Since the page level monitoring is supposed
to provide relatively high precision, this is definitely a problem.  It
is arguably not critical since it is only monitoring quality
degradation.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260514015053.149396-1-sj@kernel.org

Fixes: 63f39737d1e3 ("mm/damon/vaddr: support stat-purpose DAMOS filters")
Cc: <stable@vger.kernel.org> # 6.18.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/vaddr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 0648400b2d65b..4b0b5edf67952 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -831,6 +831,8 @@ static int damos_va_stat_pmd_entry(pmd_t *pmd, unsigned long addr,
 		return 0;
 
 	for (; addr < next; pte += nr, addr += nr * PAGE_SIZE) {
+		unsigned long page_idx;
+
 		nr = 1;
 		ptent = ptep_get(pte);
 
@@ -844,7 +846,8 @@ static int damos_va_stat_pmd_entry(pmd_t *pmd, unsigned long addr,
 
 		if (!damos_va_filter_out(s, folio, vma, addr, pte, NULL))
 			*sz_filter_passed += folio_size(folio);
-		nr = folio_nr_pages(folio);
+		page_idx = folio_page_idx(folio, pte_page(ptent));
+		nr = folio_nr_pages(folio) - page_idx;
 		s->last_applied = folio;
 	}
 	pte_unmap_unlock(start_pte, ptl);
-- 
2.47.3
