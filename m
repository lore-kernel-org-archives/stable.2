Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9173603FB;
	Wed,  1 Jul 2026 17:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782927775; cv=none; b=Lnx5KV40Qu1fAQD+d1dOIjmVQ+glD6uSlQOilje8KuUH6vhDnBR0xtDg0/BjeB+krGM0tWUTzErx1mtl3kuK+lv975gJxcDXqSBvy8bq0zkLpTix+raWH7RmMnKFzMkKl2XGO7QMLM/ISFF3L2FuRSsDPKpZh9ngg1acr3gfUxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782927775; c=relaxed/simple;
	bh=Ad6Xk62GzctfafG/trIpvRHzUHHwhPLtxtvUB5RGcVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tzGxiNc0WTDNRDJYZyPvWJEvbx64zxDd3vHdy6Uz3tdCwv7xVWpYiwuiklWG06A6YWxmoS2cf9mllZvj2xzXWNrSINsnx+/nLjwbaKrZ5p2nKWOe44wRxzk2AGR8TivXJjsmtrx4dXoexMdy41Ctnf5iQANQDLz2hlZaC1C2EEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=SSXpINOv; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="SSXpINOv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Hp/MTWF1U4k7tJMPR2GAr/ulpfpcYIO72EJRz51U5t8=; b=SSXpINOveD8VhloC7JTauZovRR
	fOUQ5g2Tvtw7dPtYWx05YTxhikBrKzdOzVzx38IdQlHwJKzLqNLjcMd6OekNDacYUNolYyoP1CEAc
	i0VMk9qVe1FU6Mmc2cvxjLNsDgTgZyx6UvBw68jhSV7bQD/Yma5nnsOhKpwZ6jaYmFAzwNGT8w2CI
	fWbFSkGLe/v9FhqoTfQJ146y5fbQOcKRYaN+738hq2KVdQCc9VrinNW/3JLXSn0ryieUnEOuMxSYE
	2f8bhuLEm0eADjplGvR5EdSNoXrr3toaMQU+bLrzVKxxaWt1ZXWXejaOLzYSgJRJysPdLXXh5RleL
	pCPnyTWA==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1weyxN-000000001Vx-0nsW;
	Wed, 01 Jul 2026 13:42:41 -0400
From: Rik van Riel <riel@surriel.com>
To: linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	yang@os.amperecomputing.com,
	Rik van Riel <riel@surriel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] mm/huge_memory: set PG_has_hwpoisoned only after new folio head is established
Date: Wed,  1 Jul 2026 13:42:34 -0400
Message-ID: <20260701174235.3173401-1-riel@surriel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__split_folio_to_order() copies the hwpoison state onto each new
sub-folio while splitting a folio to a non-zero order.  It does so via

	if (handle_hwpoison && page_range_has_hwpoisoned(new_head, new_nr_pages))
		folio_set_has_hwpoisoned(new_folio);

*before* clear_compound_head(new_head)/prep_compound_page(new_head, ...)
turns @new_head from a tail page into a proper folio head.

PG_has_hwpoisoned is a FOLIO_SECOND_PAGE flag, so folio_set_has_hwpoisoned()
resolves to folio_flags(folio, 1).  With the new compound_info-based
page-flags layout, folio_flags() asserts the page is not a tail:

	VM_BUG_ON_PGFLAGS(page->compound_info & 1, page);
	VM_BUG_ON_PGFLAGS(n > 0 && !test_bit(PG_head, &page->flags.f), page);

At the current call site @new_head still has the tail marker
(compound_info bit 0 set, PG_head clear), so on CONFIG_DEBUG_VM kernels
this hits:

  kernel BUG at include/linux/page-flags.h:354
  folio_flags+0x82
  folio_set_has_hwpoisoned
  __split_folio_to_order
  __split_unmapped_folio
  __folio_split
  truncate_inode_partial_folio  (shmem hole-punch / MADV_REMOVE)

Reproduced by syzkaller: hwpoison-inject a few subpages of a large shmem
folio, then MADV_REMOVE (fallocate punch hole) on the same range, which
splits the partial folio to a non-zero order.

memory_failure() tries to split the poisoned folio to order 0 first, but
that split is best-effort; when it fails the folio is left large with
PG_has_hwpoisoned set, the case fa5a06170036 added this hwpoison copying
for.

Move the folio_set_has_hwpoisoned() call to after
clear_compound_head()/prep_compound_page(), where @new_folio is a real
order-new_order head folio (handle_hwpoison implies new_order != 0, so a
second page always exists).  The flag still lands on the same struct page
(page[1] of the new folio); only the ordering relative to compound-head
setup changes, satisfying the FOLIO_SECOND_PAGE precondition.

Fixes: fa5a06170036 ("mm/huge_memory: preserve PG_has_hwpoisoned if a folio is split to >0 order")
Signed-off-by: Rik van Riel <riel@surriel.com>
Assisted-by: Claude:claude-opus-4-8
Reviewed-by: Zi Yan <ziy@nvidia.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Tested-by: Lance Yang <lance.yang@linux.dev>
Cc: stable@vger.kernel.org
---
v2:
 - cleaned up comment (Lorenzo)
 - consistent changelog grammar, plus rationale on why this path exists (David)
 - Cc: stable (Zi)

 mm/huge_memory.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2bccb0a53a0a..b5d1e9d4463d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3587,10 +3587,6 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
 				 (1L << PG_dropbehind) |
 				 LRU_GEN_MASK | LRU_REFS_MASK));
 
-		if (handle_hwpoison &&
-		    page_range_has_hwpoisoned(new_head, new_nr_pages))
-			folio_set_has_hwpoisoned(new_folio);
-
 		new_folio->mapping = folio->mapping;
 		new_folio->index = folio->index + i;
 
@@ -3612,6 +3608,14 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
 			folio_set_large_rmappable(new_folio);
 		}
 
+		/*
+		 * PG_has_hwpoisoned is on the 2nd page, so set it after
+		 * the compound head is prepped.
+		 */
+		if (handle_hwpoison &&
+		    page_range_has_hwpoisoned(new_head, new_nr_pages))
+			folio_set_has_hwpoisoned(new_folio);
+
 		if (folio_test_young(folio))
 			folio_set_young(new_folio);
 		if (folio_test_idle(folio))
-- 
2.53.0-Meta

