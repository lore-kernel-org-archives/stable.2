Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321262;
	b=FqJhxkyvBoJlAFJpFmTW+xw2dfiNhqIpflUafFpMucATdIJkc26y7AUDv1AhhpWeJ6Nq
	 WxzRS8DpAJL6WWQoysKtF3jbCOMgWQ954LbzRgQBFJmB0u03f/lCaY/xECnavLA3JFTSn
	 /Ohw8ftUUesqJgDhSR5d0GSLxdfH6mWTe19Sv7IJcgkLsfav/SBVtPTn7gCqXA+6IzPyA
	 NHUtQOh3JwbXHOaDbwO/GqpX1rLgXmQgE06ug1mAtzhMz6KL/uZFS0k7QgbWYH9faBP6c
	 rFK2+Dn0QSl5Nn3ZIsCflFJjshqVUKsw1j4fatuTpPrwwXFsPBELyAA0BLGhz4ILBrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321262;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5yAe1YlFUr0XQQswb3HlwiTqS3yi0ITiSJ5COhLlxN8=;
	b=bb4B6eayhNlcrQIIXFO1KFbsA6mfXFyDEJ6S5rUD3U5OjyiGur/8l6IxscAcjhjXXhfI
	 UB7paR1PHXvpk6+42N7Sbuz0aFTgvpQuJzNBGrk7nPLEFbFCUPA4fHUYSiAASFzyG9+ie
	 BqOW6dbc5AILJaRvu2/fOe4ebULudxS8XdKqLdlgODUA0VI68XwkwnDZZ6szOdOT8U1ID
	 KigfvJtznL3IGUGiLn6XjmjpiB6RlPUjQb1YdBszKuYFl4+nFjxAwiYfas+8im4FGV7RH
	 WGpzbrM+j9mgLIXzdi/O4R3wFMuKcrvp1hyoIyPlsj68bGJwcSHn966/D39Vst82Q3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZJhnE8V7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7527A606A33A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZJhnE8V7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB89A1F008A1;
	Tue, 10 Nov 2026 14:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794321262;
	bh=5yAe1YlFUr0XQQswb3HlwiTqS3yi0ITiSJ5COhLlxN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZJhnE8V7eCw924vedv5u31bj3vuazovEN3/YNa6liPE8/CNqqsLRHx3y7S+rL+k1s
	 ps8d/WTTr9t91g87qH7AHrV63qfsSKtvMZh3ADdfLPVXNFQqAY1MAFnt2OEh+CSZ6O
	 lpKU5zSeZjR10WcPaEXtoMgVzur8lbFbYMCfxl1f7fHGt9T15AOD0CsrPCU1rVTzZm
	 a+l4k9yJthwSEPhazDA07pA2uAzOSU2u2DP2BZTnEilU/QM1/wXLHsrM6Qa0CiLKaZ
	 7VMtzHw0hC5pw7DqNfmGffc0qsb/ofgOoqb9SK7AQTIa54xf6TzDzSWTj/w3rgvYGD
	 cP5j3VP51eU1w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sidhartha Kumar <sidhartha.kumar@oracle.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Bui Quang Minh <minhquangbui99@gmail.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Mina Almasry <almasrymina@google.com>,
	Muchun Song <songmuchun@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/4] mm/hugetlb_cgroup: convert set_hugetlb_cgroup*() to folios
Date: Tue, 10 Nov 2026 09:34:16 -0500
Message-ID: <20261110143410.1902001-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054727-failed-6.1-23fac055c211@kernel.org>
References: <20261107054727-failed-6.1-23fac055c211@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sidhartha Kumar <sidhartha.kumar@oracle.com>

[ Upstream commit de656ed376c4cb47c5713fba52f8bbfbea44f387 ]

Allows __prep_new_huge_page() to operate on a folio by converting
set_hugetlb_cgroup*() to take in a folio.

Link: https://lkml.kernel.org/r/20221101223059.460937-4-sidhartha.kumar@oracle.com
Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Mina Almasry <almasrymina@google.com>
Cc: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 23fac055c211 ("mm/hugetlb_cgroup: move per-node usage on cgroup reparenting")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/hugetlb_cgroup.h | 12 ++++++------
 mm/hugetlb.c                   | 33 +++++++++++++++++++--------------
 mm/hugetlb_cgroup.c            | 11 ++++++-----
 3 files changed, 31 insertions(+), 25 deletions(-)

diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
index 241bf4fe701ae..f0d9f295413be 100644
--- a/include/linux/hugetlb_cgroup.h
+++ b/include/linux/hugetlb_cgroup.h
@@ -112,16 +112,16 @@ static inline void __set_hugetlb_cgroup(struct folio *folio,
 				 (unsigned long)h_cg);
 }
 
-static inline void set_hugetlb_cgroup(struct page *page,
+static inline void set_hugetlb_cgroup(struct folio *folio,
 				     struct hugetlb_cgroup *h_cg)
 {
-	__set_hugetlb_cgroup(page_folio(page), h_cg, false);
+	__set_hugetlb_cgroup(folio, h_cg, false);
 }
 
-static inline void set_hugetlb_cgroup_rsvd(struct page *page,
+static inline void set_hugetlb_cgroup_rsvd(struct folio *folio,
 					  struct hugetlb_cgroup *h_cg)
 {
-	__set_hugetlb_cgroup(page_folio(page), h_cg, true);
+	__set_hugetlb_cgroup(folio, h_cg, true);
 }
 
 static inline bool hugetlb_cgroup_disabled(void)
@@ -199,12 +199,12 @@ hugetlb_cgroup_from_folio_rsvd(struct folio *folio)
 	return NULL;
 }
 
-static inline void set_hugetlb_cgroup(struct page *page,
+static inline void set_hugetlb_cgroup(struct folio *folio,
 				     struct hugetlb_cgroup *h_cg)
 {
 }
 
-static inline void set_hugetlb_cgroup_rsvd(struct page *page,
+static inline void set_hugetlb_cgroup_rsvd(struct folio *folio,
 					  struct hugetlb_cgroup *h_cg)
 {
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index de805b385d06b..89c82bdf2f217 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1986,19 +1986,21 @@ static void __prep_account_new_huge_page(struct hstate *h, int nid)
 	h->nr_huge_pages_node[nid]++;
 }
 
-static void __prep_new_huge_page(struct hstate *h, struct page *page)
+static void __prep_new_hugetlb_folio(struct hstate *h, struct folio *folio)
 {
-	hugetlb_vmemmap_optimize(h, page);
-	INIT_LIST_HEAD(&page->lru);
-	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
-	hugetlb_set_page_subpool(page, NULL);
-	set_hugetlb_cgroup(page, NULL);
-	set_hugetlb_cgroup_rsvd(page, NULL);
+	hugetlb_vmemmap_optimize(h, &folio->page);
+	INIT_LIST_HEAD(&folio->lru);
+	folio->_folio_dtor = HUGETLB_PAGE_DTOR;
+	hugetlb_set_folio_subpool(folio, NULL);
+	set_hugetlb_cgroup(folio, NULL);
+	set_hugetlb_cgroup_rsvd(folio, NULL);
 }
 
 static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
 {
-	__prep_new_huge_page(h, page);
+	struct folio *folio = page_folio(page);
+
+	__prep_new_hugetlb_folio(h, folio);
 	spin_lock_irq(&hugetlb_lock);
 	__prep_account_new_huge_page(h, nid);
 	spin_unlock_irq(&hugetlb_lock);
@@ -2970,8 +2972,10 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 					struct list_head *list)
 {
 	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
-	int nid = page_to_nid(old_page);
+	struct folio *old_folio = page_folio(old_page);
+	int nid = folio_nid(old_folio);
 	struct page *new_page;
+	struct folio *new_folio;
 	int ret = 0;
 
 	/*
@@ -2984,16 +2988,17 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 	new_page = alloc_buddy_huge_page(h, gfp_mask, nid, NULL, NULL);
 	if (!new_page)
 		return -ENOMEM;
-	__prep_new_huge_page(h, new_page);
+	new_folio = page_folio(new_page);
+	__prep_new_hugetlb_folio(h, new_folio);
 
 retry:
 	spin_lock_irq(&hugetlb_lock);
-	if (!PageHuge(old_page)) {
+	if (!folio_test_hugetlb(old_folio)) {
 		/*
 		 * Freed from under us. Drop new_page too.
 		 */
 		goto free_new;
-	} else if (page_count(old_page)) {
+	} else if (folio_ref_count(old_folio)) {
 		/*
 		 * Someone has grabbed the page, try to isolate it here.
 		 * Fail with -EBUSY if not possible.
@@ -3002,7 +3007,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 		ret = folio_isolate_hugetlb(old_page, list);
 		spin_lock_irq(&hugetlb_lock);
 		goto free_new;
-	} else if (!HPageFreed(old_page)) {
+	} else if (!folio_test_hugetlb_freed(old_folio)) {
 		/*
 		 * Page's refcount is 0 but it has not been enqueued in the
 		 * freelist yet. Race window is small, so we can succeed here if
@@ -3040,7 +3045,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 free_new:
 	spin_unlock_irq(&hugetlb_lock);
 	/* Page has a zero ref count, but needs a ref to be freed */
-	set_page_refcounted(new_page);
+	folio_ref_unfreeze(new_folio, 1);
 	update_and_free_page(h, new_page, false);
 
 	return ret;
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 32f4408eda240..001828b062d43 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -212,7 +212,7 @@ static void hugetlb_cgroup_move_parent(int idx, struct hugetlb_cgroup *h_cg,
 	/* Take the pages off the local counter */
 	page_counter_cancel(counter, nr_pages);
 
-	set_hugetlb_cgroup(page, parent);
+	set_hugetlb_cgroup(folio, parent);
 out:
 	return;
 }
@@ -890,6 +890,7 @@ void hugetlb_cgroup_migrate(struct page *oldhpage, struct page *newhpage)
 	struct hugetlb_cgroup *h_cg_rsvd;
 	struct hstate *h = page_hstate(oldhpage);
 	struct folio *old_folio = page_folio(oldhpage);
+	struct folio *new_folio = page_folio(newhpage);
 
 	if (hugetlb_cgroup_disabled())
 		return;
@@ -897,12 +898,12 @@ void hugetlb_cgroup_migrate(struct page *oldhpage, struct page *newhpage)
 	spin_lock_irq(&hugetlb_lock);
 	h_cg = hugetlb_cgroup_from_folio(old_folio);
 	h_cg_rsvd = hugetlb_cgroup_from_folio_rsvd(old_folio);
-	set_hugetlb_cgroup(oldhpage, NULL);
-	set_hugetlb_cgroup_rsvd(oldhpage, NULL);
+	set_hugetlb_cgroup(old_folio, NULL);
+	set_hugetlb_cgroup_rsvd(old_folio, NULL);
 
 	/* move the h_cg details to new cgroup */
-	set_hugetlb_cgroup(newhpage, h_cg);
-	set_hugetlb_cgroup_rsvd(newhpage, h_cg_rsvd);
+	set_hugetlb_cgroup(new_folio, h_cg);
+	set_hugetlb_cgroup_rsvd(new_folio, h_cg_rsvd);
 	list_move(&newhpage->lru, &h->hugepage_activelist);
 	spin_unlock_irq(&hugetlb_lock);
 	return;
-- 
2.53.0

