Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C8F3B893F;
	Sat,  1 Aug 2026 17:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785605768; cv=none; b=V/aKqwIy5jk0VTHSMbTrcbg7SgEXR+FG7pheFaqV68hKYobTzXbrVWfE+11RQORAftk9kTqbnH9yFf/4hpAMrKNyjS9CjG1Sm5EFC3Z2S/7dMkq2OXGZCEMW5z9aKApSK8R+QCHgXDzqHMw35+3a03bzU/cJsIceNiNf7lphqhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785605768; c=relaxed/simple;
	bh=WKMBurie6Z+ycsPihLvmZk3twze0eXZmOYItbK5Vsz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qOmz/tkpcZus2XIVF8PGcT+O+4iJMqoXKlAo3NP3kyQOqAHZXy8YaDfZco19LIgvnVNyLg6BFUMdPlj6qSYTCyc33N/Ol6L/Jtu1S+88mjHR4H3n5engJkzzitd8kL1RQJwkU5L1vcQ+Ej+yLLmzYA8HOZUsSvziNiq8uiQCm5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYq63uts; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYq63uts"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C941F00ADF;
	Sat,  1 Aug 2026 17:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785605766;
	bh=uiWMed+e4y9TXxwRAiQ3Fg56ABB5uO8dHBY+Ne9IA7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jYq63uts2BX3RT8QBWXV1P7DCrKOFcTgxo9PGxsrjQSW+hcplom+EoZzSFzf8zyDA
	 YBfSaEi2as9OOiT8vi6D8MV/9GKLCWMM3kvoPfq+W7ffAMYGDFxY71gCPSbLDOkzI5
	 VqipxAaAfN2yf6IBxsVuuVlLpkCwxjA0HlYy4l7NOn+zNUEh64PO49gfnQZbfyTJNk
	 IwZ3TYq5lpv8dYAk3/puCw4SLj3Plg4lggsOnf0Mi4n+HJpB/OKbgsWgSXQWy2iCCE
	 7jxncCePmxG+KBBYCeDEVblgL8GClZ6kWUS3y1RnCd0wztk45h7K3hWPYQSqsPXQYt
	 fi5DaXe+Fi1+w==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 6/9] mm/damon/vaddr: respect folio end for DAMOS_MIGRATE_{HOT,COLD}
Date: Sat,  1 Aug 2026 10:35:49 -0700
Message-ID: <20260801173554.94710-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260801173554.94710-1-sj@kernel.org>
References: <20260801173554.94710-1-sj@kernel.org>
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
index 035cd509f6b58..aa833c2c4fa35 100644
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
+		page_idx = folio_page_idx(folio, pte_page(*pte));
+		nr = folio_nr_pages(folio) - page_idx;
 	}
 	pte_unmap_unlock(start_pte, ptl);
 	return 0;
-- 
2.47.3
