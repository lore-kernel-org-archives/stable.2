Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B59741D13B
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 12:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786970589; cv=none; b=Xo1avcutX99oaNtSgWXB8OuXKyvnbTahCUaHSKXMVa9elvXaUJvkZei/z8OxlaFWkHQTqsZy6x1wGv63S+fE9QiONbIBvck08f3/LdMmT0v6q7BCsFFkHz6ZUIwD7yK/AgTzYeRvJ6HKNPvSlaesfL0ZXlHTr/QET+sJWRA+tPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786970589; c=relaxed/simple;
	bh=W6QHAwjX7CQJP20w8zYuViJgPWQ90DCdacmgtppJtvI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=l/zz0toRX09BJWpw9UrvkQXvDFhJ+Cl6TyxwXV3EuvXcPI+XgaFzQlK6TXcgKuaRMA8nu3LMotRS2yl/mGBfvcKHl3XZScreDLIhbNwEXwI3GlCOQJhWnSH6v2ChHzfIHGyDpNxwB7EGuSsc8S5WQaJuzQEOOXVuvKGSO2jMTkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zxr9ykBW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zxr9ykBW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3072A1F000E9;
	Mon, 17 Aug 2026 12:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786970587;
	bh=DRPrgBTJ0jsHKY43bPKNNz8A6UYmhosPlia5dEAxpt4=;
	h=Subject:To:Cc:From:Date;
	b=Zxr9ykBWpr5C3YzXJW8FE6kjAsR0YQTS37BmL+gDcG6Q47C4rUNP9f4fXzAyy8QoP
	 4GuDQ33nVIDsael0pFFxtJaaEWHHnKCpdIxsdA0rpInih9tKgBbi1OrBLeZX6zNRM6
	 GnL3vGVflveTZ1VkP15n2/VF+oaGrWEuVoqkpN3Q=
Subject: FAILED: patch "[PATCH] mm/huge_memory: separate out" failed to apply to 6.12-stable tree
To: ljs@kernel.org,akpm@linux-foundation.org,baohua@kernel.org,baolin.wang@linux.alibaba.com,david@kernel.org,dev.jain@arm.com,hare@suse.de,hughd@google.com,kas@kernel.org,lance.yang@linux.dev,liam@infradead.org,npache@redhat.com,p.raghav@samsung.com,ryan.roberts@arm.com,shy828301@gmail.com,stable@vger.kernel.org,uqbarz@gmail.com,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Aug 2026 14:40:35 +0200
Message-ID: <2026081735-epileptic-rinsing-dea4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 98bd3af0bb6bfdb0fb39cbfa05456acb374b691e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081735-epileptic-rinsing-dea4@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 98bd3af0bb6bfdb0fb39cbfa05456acb374b691e Mon Sep 17 00:00:00 2001
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Thu, 30 Jul 2026 11:55:48 +0100
Subject: [PATCH] mm/huge_memory: separate out
 CONFIG_PERSISTENT_HUGE_ZERO_FOLIO logic

Rather than mixing the refcounted and non-refcounted
CONFIG_PERSISTENT_HUGE_ZERO_FOLIO logic, separate the two out cleanly so
it is clear what happens when this configuration option is set and what
happens when it is not.

Introduce HUGE_ZERO_UNSET_PFN to abstract the ~0UL assignment, only
introduce the refcount, lock and shrinker if
!CONFIG_PERSISTENT_HUGE_ZERO_FOLIO, abstract initialisation and teardown,
abstract the huge zero folio allocation from refcounting.

Also change a BUG_ON() to WARN_ON_ONCE() while we're at it.

No functional change intended.

Link: https://lore.kernel.org/20260730-fix-refcounted-huge-zero-v2-2-c5d8a41b317f@kernel.org
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Fixes: 3b77e8c8cde5 ("mm/thp: make is_huge_zero_pmd() safe and quicker")
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <baohua@kernel.org>
Cc: David Hildenbrand (Arm) <david@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Hengbin Zhang <uqbarz@gmail.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Kiryl Shutsemau <kas@kernel.org>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Nico Pache <npache@redhat.com>
Cc: Pankaj Raghav <p.raghav@samsung.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f43852ef9944..f84fe7913d88 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -78,10 +78,15 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 					 struct shrink_control *sc);
 static bool split_underused_thp = true;
 
+#define HUGE_ZERO_UNSET_PFN (~0UL)
+struct folio *huge_zero_folio __read_mostly;
+unsigned long huge_zero_pfn __read_mostly = HUGE_ZERO_UNSET_PFN;
+#ifndef CONFIG_PERSISTENT_HUGE_ZERO_FOLIO
 static atomic_t huge_zero_refcount;
 static DEFINE_SPINLOCK(huge_zero_lock);
-struct folio *huge_zero_folio __read_mostly;
-unsigned long huge_zero_pfn __read_mostly = ~0UL;
+static struct shrinker *huge_zero_folio_shrinker;
+#endif
+
 unsigned long huge_anon_orders_always __read_mostly;
 unsigned long huge_anon_orders_madvise __read_mostly;
 unsigned long huge_anon_orders_inherit __read_mostly;
@@ -223,6 +228,47 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 	return orders;
 }
 
+static struct folio *alloc_huge_zero_folio(void)
+{
+	struct folio *zero_folio;
+
+	zero_folio = folio_alloc((GFP_TRANSHUGE | __GFP_ZERO | __GFP_ZEROTAGS) &
+				 ~__GFP_MOVABLE,
+			HPAGE_PMD_ORDER);
+	if (!zero_folio) {
+		count_vm_event(THP_ZERO_PAGE_ALLOC_FAILED);
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
+	}
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
 static bool get_huge_zero_folio(void)
 {
 	struct folio *zero_folio;
@@ -231,15 +277,9 @@ static bool get_huge_zero_folio(void)
 	if (likely(atomic_inc_not_zero(&huge_zero_refcount)))
 		return true;
 
-	zero_folio = folio_alloc((GFP_TRANSHUGE | __GFP_ZERO | __GFP_ZEROTAGS) &
-				 ~__GFP_MOVABLE,
-			HPAGE_PMD_ORDER);
-	if (!zero_folio) {
-		count_vm_event(THP_ZERO_PAGE_ALLOC_FAILED);
+	zero_folio = alloc_huge_zero_folio();
+	if (unlikely(!zero_folio))
 		return false;
-	}
-	/* Ensure zero folio won't have large_rmappable flag set. */
-	folio_clear_large_rmappable(zero_folio);
 
 	/* Paired with critical section in shrink_huge_zero_folio_scan(). */
 	spin_lock(&huge_zero_lock);
@@ -266,33 +306,7 @@ static void put_huge_zero_folio(void)
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
@@ -316,14 +330,53 @@ static unsigned long shrink_huge_zero_folio_scan(struct shrinker *shrink,
 		zero_folio = huge_zero_folio;
 		VM_WARN_ON_ONCE(!zero_folio);
 		WRITE_ONCE(huge_zero_folio, NULL);
-		WRITE_ONCE(huge_zero_pfn, ~0UL);
+		WRITE_ONCE(huge_zero_pfn, HUGE_ZERO_UNSET_PFN);
 	}
 
 	folio_put(zero_folio);
 	return HPAGE_PMD_NR;
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
@@ -987,39 +1040,14 @@ static int __init thp_shrinker_init(void)
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

