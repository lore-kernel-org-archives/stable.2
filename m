Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2B23B27E7
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 10:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786359457; cv=none; b=TpNz6zmaPrH1Fxl8VXXR0Q71G6U+RqDXmvo4JR1tjOYJz3v+VXS47Zaccs9y6+dfuTkIDveb9u3+HsXOhFdbdO/voNAPyDb+lyIrWbU7qLc3PXPOnfo+aw9rtx7Av6jbpbiL0PLt7WhyIcdE6SAdOT6cSQ+jzy0qkVbhOT0GaEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786359457; c=relaxed/simple;
	bh=JIfKBbBB5uqqf/rD76vqJBwMIEdNkm8HQD3UoBHmD3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kLKgMPXS52JYyFYZRlkUgdY/dLIt5QijRBFZGr/phocky5q36AFjLPDfOmd+jaJXB9zSmK7twTkzP7TcsJXJ9wBs+Fsy0niECvTxQfjAn8PjUA78EIDT+WjUZy/I11/RdXQojctbwu8mN0U12BC6KQyXzp2zEQu6+/iKhVDEcY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neuaAsJl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neuaAsJl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DDA11F000E9;
	Mon, 10 Aug 2026 10:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786359454;
	bh=D7PdSJX2KVIzYgwJDyMbnkuVWxlr7lURH5N5dx2LbSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=neuaAsJlcJWW/WzvcmYaWm/pFCoXP6MR5cld0KsmDhxSuRBQGVkThC1ij0+E2BkuA
	 s0AEsm8Ai4njph2wP9gRzilgZV0wU8shi1ZCd7HeBMwqzZaUHH/C1OfrPOY2NnqE+Y
	 IEIvw5sGYDqwCU7/pBMpgO5d2xE7T035RUg1T52WkGcWIveH9ia4LkV1Z9L97XI1VB
	 T5UGBF3B+Y0Szbb4XeLag1NsS75/QAupxZbyRLcdj9e9fbRp84XC6458Vy6pVYOjS6
	 YLjGWmfPDexc7zRX3Pnt9KHdZlpRIvjgeR6rnETQp/m18sWy321PGzD+qyeOibRDeG
	 iqg3JWWp4a0Ug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Muchun Song <songmuchun@bytedance.com>,
	Peter Xu <peterx@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] mm/migrate_device: page_remove_rmap() -> folio_remove_rmap_pte()
Date: Mon, 10 Aug 2026 06:57:29 -0400
Message-ID: <20260810105730.578433-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080539-snowsuit-kept-385b@gregkh>
References: <2026080539-snowsuit-kept-385b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Hildenbrand <david@redhat.com>

[ Upstream commit 5b205c7f2684764c8a9cc3442986623d4d6e87f1 ]

Let's convert migrate_vma_collect_pmd().  While at it, perform more folio
conversion.

Link: https://lkml.kernel.org/r/20231220224504.646757-30-david@redhat.com
Signed-off-by: David Hildenbrand <david@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Yin Fengwei <fengwei.yin@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 63867c82d0c0 ("mm: migrate_device: fix pte_pfn/pte_dirty called on non-present PTE")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/migrate_device.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index afe3b2d2e7b9d..e198569bb3324 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -114,6 +114,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 
 	for (; addr < end; addr += PAGE_SIZE, ptep++) {
 		unsigned long mpfn = 0, pfn;
+		struct folio *folio;
 		struct page *page;
 		swp_entry_t entry;
 		pte_t pte;
@@ -175,41 +176,43 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 		}
 
 		/*
-		 * By getting a reference on the page we pin it and that blocks
+		 * By getting a reference on the folio we pin it and that blocks
 		 * any kind of migration. Side effect is that it "freezes" the
 		 * pte.
 		 *
-		 * We drop this reference after isolating the page from the lru
-		 * for non device page (device page are not on the lru and thus
+		 * We drop this reference after isolating the folio from the lru
+		 * for non device folio (device folio are not on the lru and thus
 		 * can't be dropped from it).
 		 */
-		get_page(page);
+		folio = page_folio(page);
+		folio_get(folio);
 
 		/*
-		 * We rely on trylock_page() to avoid deadlock between
+		 * We rely on folio_trylock() to avoid deadlock between
 		 * concurrent migrations where each is waiting on the others
-		 * page lock. If we can't immediately lock the page we fail this
+		 * folio lock. If we can't immediately lock the folio we fail this
 		 * migration as it is only best effort anyway.
 		 *
-		 * If we can lock the page it's safe to set up a migration entry
-		 * now. In the common case where the page is mapped once in a
+		 * If we can lock the folio it's safe to set up a migration entry
+		 * now. In the common case where the folio is mapped once in a
 		 * single process setting up the migration entry now is an
 		 * optimisation to avoid walking the rmap later with
 		 * try_to_migrate().
 		 */
-		if (trylock_page(page)) {
+		if (folio_trylock(folio)) {
 			bool anon_exclusive;
 			pte_t swp_pte;
 
-			flush_cache_page(vma, addr, pte_pfn(*ptep));
-			anon_exclusive = PageAnon(page) && PageAnonExclusive(page);
+			flush_cache_page(vma, addr, pte_pfn(pte));
+			anon_exclusive = folio_test_anon(folio) &&
+					  PageAnonExclusive(page);
 			if (anon_exclusive) {
 				pte = ptep_clear_flush(vma, addr, ptep);
 
 				if (page_try_share_anon_rmap(page)) {
 					set_pte_at(mm, addr, ptep, pte);
-					unlock_page(page);
-					put_page(page);
+					folio_unlock(folio);
+					folio_put(folio);
 					mpfn = 0;
 					goto next;
 				}
@@ -221,7 +224,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 
 			/* Set the dirty flag on the folio now the pte is gone. */
 			if (pte_dirty(pte))
-				folio_mark_dirty(page_folio(page));
+				folio_mark_dirty(folio);
 
 			/* Setup special migration page table entry */
 			if (mpfn & MIGRATE_PFN_WRITE)
@@ -255,16 +258,16 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 
 			/*
 			 * This is like regular unmap: we remove the rmap and
-			 * drop page refcount. Page won't be freed, as we took
-			 * a reference just above.
+			 * drop the folio refcount. The folio won't be freed, as
+			 * we took a reference just above.
 			 */
 			page_remove_rmap(page, vma, false);
-			put_page(page);
+			folio_put(folio);
 
 			if (pte_present(pte))
 				unmapped++;
 		} else {
-			put_page(page);
+			folio_put(folio);
 			mpfn = 0;
 		}
 
-- 
2.53.0

