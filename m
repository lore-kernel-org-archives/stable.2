Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A309C440647;
	Tue,  1 Sep 2026 13:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268418; cv=none; b=Z7Vn44OM25PQjlsjvP5zJZkLcWIFuHHQjs/eOhhecG/SWRGFv/LTGsomlVMiaC0pQde4M5s7TTKPjbAudn6+mejFqyGcyTf71pZ1mgtACzmr4y7ZUpLrBypCnAdcI7crOVtwFZiSYBQMYf2zQUf2NaQi+N0E7RD2fQiiWCtzvBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268418; c=relaxed/simple;
	bh=5AGJ58CxaHUHnA7OwFTsM+2rMQoeaY6UpbD7qoJcoXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sVAXtAk35TTK0E/wVk8MxJaXquLISTFMF7zd3fGWuNxFXgOV/OhGqVytb4CknJogEytcEHDyn5LZkEPWba9wwie/0VclN56fGvfwV9RPxnSje8xDRiwRYfDwKCt8aAao5p/1ELpwwKH8JfsWGVtE8Brlr0k0IXA4DlbUwQ6PbNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4pt0221; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4pt0221"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA72F1F00ACA;
	Tue,  1 Sep 2026 13:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788268416;
	bh=nSTjwnDV8A+NiGPVQu+FC6bukzN4Edj/bjp5VqLzRxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O4pt02213qlx6vaOUorj4+qScp9QUGMdKg0r2z7Ig1+cTKFLdGATxgOPJmG+0ausZ
	 9k7uxgUAbpuj1hA2+pe7xKB9/ya+XvAms303tM+x4cVqEKT8XVnbEGYCgBYdl2+8zR
	 NT4u3lOIHDm+eDIXGl9A22qGzY1KWJL8UXKa4WK2fIuKlN+Yeo7mIbBMhLdrw+Zc0O
	 e6Lr/ANyMNKg3RHSWVhgEJm1RZQOapI3KuQ2uAKfzH5n+ZTA1DzzdPDLsFHuYvUEp1
	 lJj2cwxm2pQr9wtVpR0Pgx63/x8BcbQBW0qufPtI437MoV+XatD9W9DN9mBIlcQpgM
	 vrGgioAlPAYVA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Yueyang Pan <pyyjason@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/7] mm/damon/vaddr: respect folio end for DAMOS_STAT
Date: Tue,  1 Sep 2026 06:13:20 -0700
Message-ID: <20260901131326.97615-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901131326.97615-1-sj@kernel.org>
References: <20260901131326.97615-1-sj@kernel.org>
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
