Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A60736CDE9
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 18:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788459456; cv=none; b=IT13n5+Gn4tRR9ihDlhK9iV0wBC/tWSKFBUVyKzbIuot2zBn9WRwpfVGfmcxzUC7ZayLmVMCWymgRTqwoy4dHtStkPfknwyWrhyR4NNvxtjvu9vOj/w01iZ27XsWcEZX9/d2/gXIgbvXpgJ/bFYNbrbzHKNRL7H4jdh+Gi8WaXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788459456; c=relaxed/simple;
	bh=1TIaloxu099FtMUtCsWCB27Jzna73WLmd6mT2Ap6W2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XsRQqsrTYpmRhXYQKxLi8Khs4l+cpaGJhBKxHCQE03UTSHeMduKXh03dmyRoSP1vZA6+aoXb1t/QmQYtsgdSx0vow+KmK/B3m20YHfUULHN+Am7fJtQ8I3Dzrgaes1SNmFdsZd3NAFqals+sWV0/raaoHJ8Cp2sdf4BH5/PuNxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUFYQ62Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUFYQ62Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A8B1F00A3E;
	Thu,  3 Sep 2026 18:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788459453;
	bh=JwjUkT2BuddcjxyzVEw5EH4CQB656WxrioWQy5BKBiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fUFYQ62QP2zBGK1WSoa8XJ8haBtlI5iwVQaNTXNATG7sVrTGYhz4IuvK/jO8KlIzl
	 WTTQ0lH1dKqe8YY9zDfvqUw4Csx5CsjVlKDsArLS/F2tWBXwqIWB81cmG/lkmf3zW4
	 Z9VHjN1grkueQ2Luge0fdx6kiEVeAOlEkH6b1UhSweRXd5+6auHZ+Pmn/4DpDN5GsQ
	 jZJyVnN7uMIO+zS1N+CwvNGwYbqas4gejnERZYZno5+hKFEyYZiqZyVeOrfqMFilp2
	 4CXDVPRZJqLwalSHYiJaUqsaa6MTlnc3PiLzgCzP0vT/lrJSs28mA4OuzISmbKMEjy
	 krCelri6QRI6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Andy Lutomirks^H^Hski <luto@kernel.org>,
	Borislav Betkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jann Horn <jannh@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Lance Yang <ioworker0@gmail.com>,
	Liam Howlett <liam.howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Matthew Wilcow (Oracle)" <willy@infradead.org>,
	Michal Koutn <mkoutny@suse.com>,
	Muchun Song <muchun.song@linux.dev>,
	tejun heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zefan Li <lizefan.x@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] mm: move _pincount in folio to page[2] on 32bit
Date: Thu,  3 Sep 2026 14:17:26 -0400
Message-ID: <20260903181727.1432502-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903181727.1432502-1-sashal@kernel.org>
References: <2026090339-stapling-ecosystem-7341@gregkh>
 <20260903181727.1432502-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Hildenbrand <david@redhat.com>

[ Upstream commit 31a31da8a6187f1e5448ec73222e01d7d3fed4aa ]

Let's free up some space on 32bit in page[1] by moving the _pincount to
page[2].

For order-1 folios (never anon folios!) on 32bit, we will now also use the
GUP_PIN_COUNTING_BIAS approach.  A fully-mapped order-1 folio requires 2
references.  With GUP_PIN_COUNTING_BIAS being 1024, we'd detect such
folios as "maybe pinned" with 512 full mappings, instead of 1024 for
order-0.  As anon folios are out of the picture (which are the most
relevant users of checking for pinnings on *mapped* pages) and we are
talking about 32bit, this is not expected to cause any trouble.

In __dump_page(), copy one additional folio page if we detect a folio with
an order > 1, so we can dump the pincount on order > 1 folios reliably.

Note that THPs on 32bit are not particularly common (and we don't care too
much about performance), but we want to keep it working reliably, because
likely we want to use large folios there as well in the future,
independent of PMD leaf support.

Once we dynamically allocate "struct folio", fortunately the 32bit
specifics will likely go away again; even small folios could then have a
pincount and folio_has_pincount() would essentially always return "true".

Link: https://lkml.kernel.org/r/20250303163014.1128035-6-david@redhat.com
Signed-off-by: David Hildenbrand <david@redhat.com>
Cc: Andy Lutomirks^H^Hski <luto@kernel.org>
Cc: Borislav Betkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Lance Yang <ioworker0@gmail.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Matthew Wilcow (Oracle) <willy@infradead.org>
Cc: Michal Koutn <mkoutny@suse.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: tejun heo <tj@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Zefan Li <lizefan.x@bytedance.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

On 6.6, __dump_page() reads the live folio instead of taking the upstream
snapshot.  Guard the pincount read directly, so copying page[2] is neither
applicable nor necessary.  Express the pincount predicate as a macro because
new functions are unsuitable for this backport and folio_order() is not
const-qualified in this tree.

Keep the existing page-array GUP iterator, but give it the iterator spelling
used by the target fix so that fix applies without the newer folio-array
infrastructure.

Stable-dep-of: 078e1a0fc41a ("mm/gup: fix always draining LRU caches in collect_longterm_unpinnable_folios()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/mm.h       |  8 ++++++--
 include/linux/mm_types.h |  7 +++++--
 mm/debug.c               |  7 ++++++-
 mm/gup.c                 | 42 ++++++++++++++++++++++++++--------------
 mm/internal.h            |  3 ++-
 mm/page_alloc.c          | 14 +++++++++++---
 6 files changed, 57 insertions(+), 24 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 09669ea23084a..a7acead3f5a06 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1908,6 +1908,10 @@ static inline struct folio *pfn_folio(unsigned long pfn)
 	return page_folio(pfn_to_page(pfn));
 }
 
+#define folio_has_pincount(folio) \
+	(IS_ENABLED(CONFIG_64BIT) ? folio_test_large(folio) : \
+	 folio_order(folio) > 1)
+
 /**
  * folio_maybe_dma_pinned - Report if a folio may be pinned for DMA.
  * @folio: The folio.
@@ -1924,7 +1928,7 @@ static inline struct folio *pfn_folio(unsigned long pfn)
  * get that many refcounts, and b) all the callers of this routine are
  * expected to be able to deal gracefully with a false positive.
  *
- * For large folios, the result will be exactly correct. That's because
+ * For most large folios, the result will be exactly correct. That's because
  * we have more tracking data available: the _pincount field is used
  * instead of the GUP_PIN_COUNTING_BIAS scheme.
  *
@@ -1935,7 +1939,7 @@ static inline struct folio *pfn_folio(unsigned long pfn)
  */
 static inline bool folio_maybe_dma_pinned(struct folio *folio)
 {
-	if (folio_test_large(folio))
+	if (folio_has_pincount(folio))
 		return atomic_read(&folio->_pincount) > 0;
 
 	/*
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 469db1973362b..37843b3e64651 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -330,10 +330,10 @@ struct folio {
 	/* public: */
 			atomic_t _entire_mapcount;
 			atomic_t _nr_pages_mapped;
-			atomic_t _pincount;
 #ifdef CONFIG_64BIT
+			atomic_t _pincount;
 			unsigned int _folio_nr_pages;
-#endif
+#endif /* CONFIG_64BIT */
 	/* private: the union with struct page is transitional */
 		};
 		struct page __page_1;
@@ -344,6 +344,9 @@ struct folio {
 			unsigned long _head_2;
 	/* public: */
 			struct list_head _deferred_list;
+#ifndef CONFIG_64BIT
+			atomic_t _pincount;
+#endif /* !CONFIG_64BIT */
 	/* private: the union with struct page is transitional */
 		};
 		struct page __page_2;
diff --git a/mm/debug.c b/mm/debug.c
index ee533a5ceb79d..202d4c0c970a8 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -99,11 +99,16 @@ static void __dump_page(struct page *page)
 			page, page_ref_count(head), mapcount, mapping,
 			page_to_pgoff(page), page_to_pfn(page));
 	if (compound) {
+		int pincount = 0;
+
+		if (folio_has_pincount(folio))
+			pincount = atomic_read(&folio->_pincount);
+
 		pr_warn("head:%p order:%u entire_mapcount:%d nr_pages_mapped:%d pincount:%d\n",
 				head, compound_order(head),
 				folio_entire_mapcount(folio),
 				folio_nr_pages_mapped(folio),
-				atomic_read(&folio->_pincount));
+				pincount);
 	}
 
 #ifdef CONFIG_MEMCG
diff --git a/mm/gup.c b/mm/gup.c
index 60006de1219ee..67620c13acd8f 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -103,7 +103,7 @@ static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
 		if (is_zero_folio(folio))
 			return;
 		node_stat_mod_folio(folio, NR_FOLL_PIN_RELEASED, refs);
-		if (folio_test_large(folio))
+		if (folio_has_pincount(folio))
 			atomic_sub(refs, &folio->_pincount);
 		else
 			refs *= GUP_PIN_COUNTING_BIAS;
@@ -159,7 +159,7 @@ int __must_check try_grab_folio(struct folio *folio, int refs,
 		 * Increment the normal page refcount field at least once,
 		 * so that the page really is pinned.
 		 */
-		if (folio_test_large(folio)) {
+		if (folio_has_pincount(folio)) {
 			folio_ref_add(folio, refs);
 			atomic_add(refs, &folio->_pincount);
 		} else {
@@ -205,7 +205,7 @@ void folio_add_pin(struct folio *folio)
 	 * page refcount field at least once, so that the page really is
 	 * pinned.
 	 */
-	if (folio_test_large(folio)) {
+	if (folio_has_pincount(folio)) {
 		WARN_ON_ONCE(atomic_read(&folio->_pincount) < 1);
 		folio_ref_inc(folio);
 		atomic_inc(&folio->_pincount);
@@ -1943,24 +1943,33 @@ struct page *get_dump_page(unsigned long addr)
 #endif /* CONFIG_ELF_CORE */
 
 #ifdef CONFIG_MIGRATION
+
+/*
+ * Match the iterator spelling used by newer GUP code without pulling in
+ * support for arrays of folios.  This tree only passes arrays of pages.
+ */
+#define pofs_get_folio(pofs, i) \
+	((i) < nr_pages ? gup_folio_next((pofs), nr_pages, (i), &ntails) : NULL)
+#define pofs_next_folio(folio, pofs, index_ptr) \
+	((void)(folio), *(index_ptr) += ntails, \
+	 *(index_ptr) < nr_pages ? pofs_get_folio((pofs), *(index_ptr)) : NULL)
+
 /*
  * Returns the number of collected pages. Return value is always >= 0.
  */
 static unsigned long collect_longterm_unpinnable_pages(
-					struct list_head *movable_page_list,
+					struct list_head *movable_folio_list,
 					unsigned long nr_pages,
 					struct page **pages)
 {
-	unsigned long i, collected = 0;
-	struct folio *prev_folio = NULL;
+	unsigned long i = 0, collected = 0;
+	unsigned int ntails;
+	struct folio *folio;
+	struct page **pofs = pages;
 	int drained = 0;
 
-	for (i = 0; i < nr_pages; i++) {
-		struct folio *folio = page_folio(pages[i]);
-
-		if (folio == prev_folio)
-			continue;
-		prev_folio = folio;
+	for (folio = pofs_get_folio(pofs, i); folio;
+	     folio = pofs_next_folio(folio, pofs, &i)) {
 
 		if (folio_is_longterm_pinnable(folio))
 			continue;
@@ -1971,7 +1980,7 @@ static unsigned long collect_longterm_unpinnable_pages(
 			continue;
 
 		if (folio_test_hugetlb(folio)) {
-			folio_isolate_hugetlb(folio, movable_page_list);
+			folio_isolate_hugetlb(folio, movable_folio_list);
 			continue;
 		}
 
@@ -1991,7 +2000,7 @@ static unsigned long collect_longterm_unpinnable_pages(
 		if (!folio_isolate_lru(folio))
 			continue;
 
-		list_add_tail(&folio->lru, movable_page_list);
+		list_add_tail(&folio->lru, movable_folio_list);
 		node_stat_mod_folio(folio,
 				    NR_ISOLATED_ANON + folio_is_file_lru(folio),
 				    folio_nr_pages(folio));
@@ -2000,6 +2009,9 @@ static unsigned long collect_longterm_unpinnable_pages(
 	return collected;
 }
 
+#undef pofs_next_folio
+#undef pofs_get_folio
+
 /*
  * Unpins all pages and migrates device coherent pages and movable_page_list.
  * Returns -EAGAIN if all pages were successfully migrated or -errno for failure
@@ -2539,7 +2551,7 @@ static struct folio *try_grab_folio_fast(struct page *page, int refs,
 	 * is pinned.  That's why the refcount from the earlier
 	 * try_get_folio() is left intact.
 	 */
-	if (folio_test_large(folio))
+	if (folio_has_pincount(folio))
 		atomic_add(refs, &folio->_pincount);
 	else
 		folio_ref_add(folio,
diff --git a/mm/internal.h b/mm/internal.h
index 03cfd9f736597..7f4d12b662747 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -491,7 +491,8 @@ static inline void prep_compound_head(struct page *page, unsigned int order)
 	folio_set_order(folio, order);
 	atomic_set(&folio->_entire_mapcount, -1);
 	atomic_set(&folio->_nr_pages_mapped, 0);
-	atomic_set(&folio->_pincount, 0);
+	if (IS_ENABLED(CONFIG_64BIT) || order > 1)
+		atomic_set(&folio->_pincount, 0);
 	if (order > 1)
 		INIT_LIST_HEAD(&folio->_deferred_list);
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 93c9a094ee8b0..1bdb87f7a4b71 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1020,9 +1020,11 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
 			bad_page(page, "nonzero nr_pages_mapped");
 			goto out;
 		}
-		if (unlikely(atomic_read(&folio->_pincount))) {
-			bad_page(page, "nonzero pincount");
-			goto out;
+		if (IS_ENABLED(CONFIG_64BIT)) {
+			if (unlikely(atomic_read(&folio->_pincount))) {
+				bad_page(page, "nonzero pincount");
+				goto out;
+			}
 		}
 		break;
 	case 2:
@@ -1031,6 +1033,12 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
 			bad_page(page, "on deferred list");
 			goto out;
 		}
+		if (!IS_ENABLED(CONFIG_64BIT)) {
+			if (unlikely(atomic_read(&folio->_pincount))) {
+				bad_page(page, "nonzero pincount");
+				goto out;
+			}
+		}
 		break;
 	case 3:
 		/* the third tail page: hugetlb specifics overlap ->mappings */
-- 
2.53.0

