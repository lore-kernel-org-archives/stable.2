Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936484314AA;
	Tue, 28 Jul 2026 12:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785240377; cv=none; b=m39bVFdMXRumsHbXvtq+zIB7yDFKQWNyDlIpAzp1YnYzAkZ/TVOmHfCeqyfbhjTDh8EjMjPvsmU06w1BQwW2rKTEgoYsT+SB0uyZy4e9i42+oYOGAoL07+a56b+dMam+Jv0jnJ305CytM9+adCPpBN5FUETqZdwBySGeRWpJ5vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785240377; c=relaxed/simple;
	bh=a2sgHY75/sCkkIEJ+2hyk3OnRW+f6UoOzAj9DJaHb5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DYQT1vwTg1MjMZoPv6sm0yRQPno7FGnNzDDL21EavPwb1H8+Vk7Ch0/CPxRiGUpIXx4OAKJ1fzcNkVQ2+AF8awm7x98HEIDhPplPoAWGje/4JXUBxxi4M8IswI56eCYV8t3wAHtkpeCkCjgMgKn+dPVQZs/sEfhAqRt2itP3/R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTCPnacC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTCPnacC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17191F00A3A;
	Tue, 28 Jul 2026 12:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785240376;
	bh=RjgKH/kkJdGm2VMudiDfggXGTukvUfp1G7/FRSrbX4M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RTCPnacCxEmlvezLDHXwR/oIW5fGnB70RoTj2f/08M6cydz+roZXGqI2TnwI3hV94
	 1uJYBvj34CrUoQ958hn1gfHGnRIZwlYg/wfVeP3pn1V9BxIpHzz8KTwp/305RZhHFq
	 KyjqOSAJFt37wN66bl3ZlCMYrKpYVVucPEapaaknBtA2FJdE7V7iGwqbQtQPb1dbt+
	 VPZMgIn1DmajkR1je8GuMl2sNOh2ipHRJ+RDm2E41n6LO2E7zFJcqI0xZ6Sia/OLDV
	 RSbTYbVs2wuwhbayZI+tbWO8nxipeLS/+JYjfJcRf5ryFUtRwvbagAZCEm3//tiGPC
	 Iy38jRzYGicQg==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 28 Jul 2026 13:05:44 +0100
Subject: [PATCH mm-hotfixes 1/2] mm/huge_memory: separate out
 CONFIG_PERSISTENT_HUGE_ZERO_FOLIO logic
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-fix-refcounted-huge-zero-v1-1-3f261f5447b4@kernel.org>
References: <20260728-fix-refcounted-huge-zero-v1-0-3f261f5447b4@kernel.org>
In-Reply-To: <20260728-fix-refcounted-huge-zero-v1-0-3f261f5447b4@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <npache@redhat.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Pankaj Raghav <p.raghav@samsung.com>, 
 Hannes Reinecke <hare@suse.de>, Hugh Dickins <hughd@google.com>, 
 Yang Shi <shy828301@gmail.com>, Kiryl Shutsemau <kas@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Hengbin Zhang <uqbarz@gmail.com>, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7572; i=ljs@kernel.org;
 h=from:subject:message-id; bh=a2sgHY75/sCkkIEJ+2hyk3OnRW+f6UoOzAj9DJaHb5g=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLIyZist4VjtpSfbaZKku6qHgbnERVEjpfRg+//da/6vT
 rjesWtSRykLgxgXg6yYIsvzL+L7g0TC5nVe8HeDmcPKBDKEgYtTACby6C7DH47Xx/i/KHYvzF5R
 Ozd4bhy70u/7T2ZOn3C0TaIwZG3Mh80Mf+Vn2dnlnL6/WZfnX5P+clNVR4Unqu+7/skv37k9vfb
 KKjYA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Rather than mixing the refcounted and non-refcounted
CONFIG_PERSISTENT_HUGE_ZERO_FOLIO logic, separate the two out cleanly
so it is clear what happens when this configuration option is set and what
happens when it is not.

Introduce HUGE_ZERO_UNSET_PFN to abstract the ~0UL assignment, only
introduce the refcount and shrinker if !CONFIG_PERSISTENT_HUGE_ZERO_FOLIO,
abstract initialisation and teardown, abstract the huge zero folio
allocation from refcounting.

Also change a BUG_ON() to WARN_ON_ONCE() while we're at it.

Without this change, the subsequent fix for a subtle race is harder to
understand thus this is a dependency of it.

Cc: stable@vger.kernel.org # 6.18.x: dependency of subsequent fix
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/huge_memory.c | 159 ++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 94 insertions(+), 65 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 032702a4637b..0f60bc82e87a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -77,9 +77,14 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 					 struct shrink_control *sc);
 static bool split_underused_thp = true;
 
-static atomic_t huge_zero_refcount;
+#define HUGE_ZERO_UNSET_PFN (~0UL)
 struct folio *huge_zero_folio __read_mostly;
-unsigned long huge_zero_pfn __read_mostly = ~0UL;
+unsigned long huge_zero_pfn __read_mostly = HUGE_ZERO_UNSET_PFN;
+#ifndef CONFIG_PERSISTENT_HUGE_ZERO_FOLIO
+static atomic_t huge_zero_refcount;
+static struct shrinker *huge_zero_folio_shrinker;
+#endif
+
 unsigned long huge_anon_orders_always __read_mostly;
 unsigned long huge_anon_orders_madvise __read_mostly;
 unsigned long huge_anon_orders_inherit __read_mostly;
@@ -221,22 +226,58 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 	return orders;
 }
 
-static bool get_huge_zero_folio(void)
+static struct folio *alloc_huge_zero_folio(void)
 {
 	struct folio *zero_folio;
-retry:
-	if (likely(atomic_inc_not_zero(&huge_zero_refcount)))
-		return true;
 
 	zero_folio = folio_alloc((GFP_TRANSHUGE | __GFP_ZERO | __GFP_ZEROTAGS) &
 				 ~__GFP_MOVABLE,
 			HPAGE_PMD_ORDER);
 	if (!zero_folio) {
 		count_vm_event(THP_ZERO_PAGE_ALLOC_FAILED);
-		return false;
+		return NULL;
+	}
+	folio_clear_large_rmappable(zero_folio); /* Explicitly not rmappable. */
+	return zero_folio;
+}
+
+#ifdef CONFIG_PERSISTENT_HUGE_ZERO_FOLIO
+static int __init huge_zero_init(void)
+{
+	huge_zero_folio = alloc_huge_zero_folio();
+	if (!huge_zero_folio) {
+		pr_warn("Allocating persistent huge zero folio failed\n");
+	} else {
+		huge_zero_pfn = folio_pfn(huge_zero_folio);
+		count_vm_event(THP_ZERO_PAGE_ALLOC);
 	}
-	/* Ensure zero folio won't have large_rmappable flag set. */
-	folio_clear_large_rmappable(zero_folio);
+	return 0;
+}
+
+static void __init huge_zero_shrinker_exit(void)
+{
+}
+
+struct folio *mm_get_huge_zero_folio(struct mm_struct *mm)
+{
+	return huge_zero_folio;
+}
+
+void mm_put_huge_zero_folio(struct mm_struct *mm)
+{
+}
+#else
+static bool get_huge_zero_folio(void)
+{
+	struct folio *zero_folio;
+retry:
+	if (likely(atomic_inc_not_zero(&huge_zero_refcount)))
+		return true;
+
+	zero_folio = alloc_huge_zero_folio();
+	if (unlikely(!zero_folio))
+		return false;
+
 	preempt_disable();
 	if (cmpxchg(&huge_zero_folio, NULL, zero_folio)) {
 		preempt_enable();
@@ -258,33 +299,7 @@ static void put_huge_zero_folio(void)
 	 * Counter should never go to zero here. Only shrinker can put
 	 * last reference.
 	 */
-	BUG_ON(atomic_dec_and_test(&huge_zero_refcount));
-}
-
-struct folio *mm_get_huge_zero_folio(struct mm_struct *mm)
-{
-	if (IS_ENABLED(CONFIG_PERSISTENT_HUGE_ZERO_FOLIO))
-		return huge_zero_folio;
-
-	if (mm_flags_test(MMF_HUGE_ZERO_FOLIO, mm))
-		return READ_ONCE(huge_zero_folio);
-
-	if (!get_huge_zero_folio())
-		return NULL;
-
-	if (mm_flags_test_and_set(MMF_HUGE_ZERO_FOLIO, mm))
-		put_huge_zero_folio();
-
-	return READ_ONCE(huge_zero_folio);
-}
-
-void mm_put_huge_zero_folio(struct mm_struct *mm)
-{
-	if (IS_ENABLED(CONFIG_PERSISTENT_HUGE_ZERO_FOLIO))
-		return;
-
-	if (mm_flags_test(MMF_HUGE_ZERO_FOLIO, mm))
-		put_huge_zero_folio();
+	WARN_ON_ONCE(atomic_dec_and_test(&huge_zero_refcount));
 }
 
 static unsigned long shrink_huge_zero_folio_count(struct shrinker *shrink,
@@ -300,7 +315,7 @@ static unsigned long shrink_huge_zero_folio_scan(struct shrinker *shrink,
 	if (atomic_cmpxchg(&huge_zero_refcount, 1, 0) == 1) {
 		struct folio *zero_folio = xchg(&huge_zero_folio, NULL);
 		BUG_ON(zero_folio == NULL);
-		WRITE_ONCE(huge_zero_pfn, ~0UL);
+		WRITE_ONCE(huge_zero_pfn, HUGE_ZERO_UNSET_PFN);
 		folio_put(zero_folio);
 		return HPAGE_PMD_NR;
 	}
@@ -308,7 +323,46 @@ static unsigned long shrink_huge_zero_folio_scan(struct shrinker *shrink,
 	return 0;
 }
 
-static struct shrinker *huge_zero_folio_shrinker;
+static int __init huge_zero_init(void)
+{
+	huge_zero_folio_shrinker = shrinker_alloc(0, "thp-zero");
+	if (!huge_zero_folio_shrinker) {
+		shrinker_free(deferred_split_shrinker);
+		list_lru_destroy(&deferred_split_lru);
+		return -ENOMEM;
+	}
+
+	huge_zero_folio_shrinker->count_objects = shrink_huge_zero_folio_count;
+	huge_zero_folio_shrinker->scan_objects = shrink_huge_zero_folio_scan;
+	shrinker_register(huge_zero_folio_shrinker);
+	return 0;
+}
+
+static void __init huge_zero_shrinker_exit(void)
+{
+	shrinker_free(huge_zero_folio_shrinker);
+}
+
+struct folio *mm_get_huge_zero_folio(struct mm_struct *mm)
+{
+	if (mm_flags_test(MMF_HUGE_ZERO_FOLIO, mm))
+		return READ_ONCE(huge_zero_folio);
+
+	if (!get_huge_zero_folio())
+		return NULL;
+
+	if (mm_flags_test_and_set(MMF_HUGE_ZERO_FOLIO, mm))
+		put_huge_zero_folio();
+
+	return READ_ONCE(huge_zero_folio);
+}
+
+void mm_put_huge_zero_folio(struct mm_struct *mm)
+{
+	if (mm_flags_test(MMF_HUGE_ZERO_FOLIO, mm))
+		put_huge_zero_folio();
+}
+#endif /* CONFIG_PERSISTENT_HUGE_ZERO_FOLIO */
 
 #ifdef CONFIG_SYSFS
 static ssize_t enabled_show(struct kobject *kobj,
@@ -972,39 +1026,14 @@ static int __init thp_shrinker_init(void)
 	deferred_split_shrinker->scan_objects = deferred_split_scan;
 	shrinker_register(deferred_split_shrinker);
 
-	if (IS_ENABLED(CONFIG_PERSISTENT_HUGE_ZERO_FOLIO)) {
-		/*
-		 * Bump the reference of the huge_zero_folio and do not
-		 * initialize the shrinker.
-		 *
-		 * huge_zero_folio will always be NULL on failure. We assume
-		 * that get_huge_zero_folio() will most likely not fail as
-		 * thp_shrinker_init() is invoked early on during boot.
-		 */
-		if (!get_huge_zero_folio())
-			pr_warn("Allocating persistent huge zero folio failed\n");
-		return 0;
-	}
-
-	huge_zero_folio_shrinker = shrinker_alloc(0, "thp-zero");
-	if (!huge_zero_folio_shrinker) {
-		shrinker_free(deferred_split_shrinker);
-		list_lru_destroy(&deferred_split_lru);
-		return -ENOMEM;
-	}
-
-	huge_zero_folio_shrinker->count_objects = shrink_huge_zero_folio_count;
-	huge_zero_folio_shrinker->scan_objects = shrink_huge_zero_folio_scan;
-	shrinker_register(huge_zero_folio_shrinker);
-
-	return 0;
+	return huge_zero_init();
 }
 
 static void __init thp_shrinker_exit(void)
 {
-	shrinker_free(huge_zero_folio_shrinker);
 	shrinker_free(deferred_split_shrinker);
 	list_lru_destroy(&deferred_split_lru);
+	huge_zero_shrinker_exit();
 }
 
 static int __init hugepage_init(void)

-- 
2.55.0

