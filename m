Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E038405C5C;
	Thu, 30 Jul 2026 10:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785408978; cv=none; b=h5Qpoo1WZBS6asaYrFYPnbZOQztGDvqz24Fl81RIv/F/+rTHO1LdvXfzfLErXiv+puyTBAetSxBkZCKyQ7uF+YJzXWDRhMlGvZGHpqxOpB4cR80pKJ2HWHAAXo9R50wzfW6Sbul1b+VcO/Q35GhECFdD+5bIjnO9aqyKgItzhIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785408978; c=relaxed/simple;
	bh=IRgSi/0LFnuUZJKJpz25rLsHbrN3WwCytgcKhXlMJd0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MwXbgdq9Gr3mx94kZEN65l4FUKFiBNxLBLlgZeTvELsiSE48t9EMiJ9We1XLkL9//RQ8H3JxWpFUN1gYLqNgvPMzc2dTiz6PLx2rRReM0d50uupkc8ANQA33fPHa77dAx0F10uhGnO6QwyY0B981e8v8UyIrIg8xLSdvPpg4GC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtLn6gsx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtLn6gsx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91001F000E9;
	Thu, 30 Jul 2026 10:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785408977;
	bh=e9Xu4NzS9+9i6cOnOquw83IQLYolWiz6Ch/ixPkboEw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OtLn6gsx+Ixlq8bL/+lhu9UmxDYQA4TlXUIHW/LOkcWBYcNIgmYtoD32dB5SQ1vLk
	 eu5q1YpYggWlu12BXlPOZvIgmX8pGkvqYBEkxZGNj9uFyjR/UDbpbKf13ViUHE5GzN
	 /sllPPXoRMGaahC78COX3PpLet+vx5LWCVFrbFTnYApMSliAWeEEcN5KcwxUFzYz5i
	 KKyRaf2yM9Mgeflf+/XE8TE02O8zC7Gud/8XQSEIfOuqL5r2XwkAGIJ/ta3jmgZijK
	 5fJjn1u6Ti7pnS3+4ugN0Y60/jz6cmvAVdi7OBAkb7SynurmBkUGGNdKo0mRadOknK
	 UIVNaCKIqQc5g==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Thu, 30 Jul 2026 11:55:47 +0100
Subject: [PATCH mm-hotfixes v2 1/2] mm/huge_memory: fix huge_zero_pfn race
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-fix-refcounted-huge-zero-v2-1-c5d8a41b317f@kernel.org>
References: <20260730-fix-refcounted-huge-zero-v2-0-c5d8a41b317f@kernel.org>
In-Reply-To: <20260730-fix-refcounted-huge-zero-v2-0-c5d8a41b317f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7999; i=ljs@kernel.org;
 h=from:subject:message-id; bh=IRgSi/0LFnuUZJKJpz25rLsHbrN3WwCytgcKhXlMJd0=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLKydXetn9m84jd/QjhvdcOloFX6Mw8I1K0+9alFbF9Cx
 O9LG+wndpSyMIhxMciKKbI8/yK+P0gkbF7nBX83mDmsTCBDGLg4BWAij7YzMjwQPrx8em5uxtRe
 7sy6AmszhTC3qmVXXy1x3rHr1tF8rv2MDEfuBZ/+y6SkwrL8lzdjda0B95kJxgulm5TUo+rzf32
 czQUA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

If !CONFIG_PERSISTENT_HUGE_ZERO_FOLIO, the huge_zero_folio is refcounted by
huge_zero_refcount and returned by mm_get_huge_zero_folio().

When the caller is done with the huge zero page, its reference count is
decremented. Only a shrinker can set the reference count to zero.

A race can unfortunately occur between a shrinker decrementing the
reference count to zero and a concurrent page fault.

This is because shrink_huge_zero_folio_scan() might, if very
unlucky, be preempted between setting huge_zero_refcount to zero
and writing an invalid value.

During this time get_huge_zero_folio() could write to huge_zero_pfn
before shrink_huge_zero_folio_scan() resumes.

In this event the huge zero folio will be persistently
misidentified causing the THP code path to be entered
inappropriately for the huge zero folio:

                CPU 0                                   CPU 1
=======================================|=================================
shrink_huge_zero_folio_scan()          |
   atomic_cmpxchg() sets refcount to 0 |
   xchg() sets huge_zero_folio to NULL | get_huge_zero_folio()
                 |                     |    atomic_inc_not_zero() -> zero
      preempted for a long time        |    Allocate new huge zero folio
                 |                     |    Write valid huge_zero_folio
                 v                     |    Write valid huge_zero_pfn
  Overwrite huge_zero_pfn with ~0UL   <--- Invalid overwrite!

This results in is_huge_zero_pfn() and is_huge_zero_pmd() incorrectly
returning false for a huge zero page which could result in issues like the
huge zero folio being incorrectly split.

Note that the issue is with huge_zero_pfn not huge_zero_folio, as
get_huge_zero_folio() uses cmpxchg() gated on huge_zero_folio being NULL
with a retry loop and shrink_huge_zero_folio_scan() uses xchg() to set
huge_zero_folio.

Fix the issue by introducing a spinlock, huge_zero_lock, to prevent
concurrent write of huge_zero_folio, huge_zero_pfn and huge_zero_refcount.

There needs to be significant care taken here to ensure correctness:

The fast path in get_huge_zero_folio() uses atomic_inc_not_zero(), which is
outside of the critical section, and means huge zero allocation is gated on
zero huge_zero_refcount.

The fast path doesn't use huge_zero_lock, so the critical section is
irrelevant to it.

So invariants are required - huge_zero_refcount MUST:

* Only be set in the huge_zero_lock critical section to ensure
  serialisation of huge_zero_pfn, huge_zero_folio and huge_zero_refcount
  writes.

* Be set non-zero only AFTER huge_zero_[pfn, folio] are set to valid values
  so installation of the huge zero folio on read page fault ensures
  concurrent is_huge_zero_*() calls correctly identify the huge zero folio.

* Be set zero only BEFORE huge_zero_[pfn, folio] are set to NULL and ~0UL
  respectively, and atomically.

Establish these by:

* Only setting huge_zero_refcount to zero or an absolute value in the
  huge_zero_lock critical section in get_huge_zero_folio() and
  shrink_huge_zero_folio_scan(), and always updating atomically there
  and elsewhere.

* Using atomic_set_release(&huge_zero_refcount) in get_huge_zero_folio()
  after huge_zero_[pfn, folio] are set. This is paired with
  atomic_inc_not_zero() to ensure atomic_inc_not_zero() only observes a
  non-zero value if huge_zero_[pfn, folio] are set.

* Using atomic_cmpxchg() in shrink_huge_zero_folio_scan() (as before) to
  ensure that it is set zero only when equal to 1 and set atomically.

* atomic_cmpxchg() being fully ordered ensures this is done prior to
  huge_zero_[folio, pfn] being set to NULL and ~0UL respectively.

Eliminate the retry loop in get_huge_zero_folio() as the atomic_cmpxchg()
in shrink_huge_zero_folio_scan() is now performed under the lock, and
replace with an equally locked atomic_inc() to set the reference count
should the caller be raced on huge zero folio installation.

folio_put() naturally implies a full memory barrier so its ordering is
maintained correctly.

The huge zero folio also cannot be released except when the shrinker does
so as it is non-LRU and non-rmappable.

Note that only the huge zero shrinker (via shrink_huge_zero_folio_scan())
can actually set huge_zero_refcount to zero, which is the count of mm's
which have at least one huge zero folio installed plus one shrinker pin.

Additionally convert a BUG_ON() to a VM_WARN_ON_ONCE().

Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
Reported-by: Hengbin Zhang <uqbarz@gmail.com>
Closes: https://lore.kernel.org/linux-mm/20260727154001.4102341-1-uqbarz@gmail.com/
Fixes: 3b77e8c8cde5 ("mm/thp: make is_huge_zero_pmd() safe and quicker")
Cc: stable@vger.kernel.org
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/huge_memory.c | 43 +++++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 032702a4637b..1f0535721652 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -41,6 +41,7 @@
 #include <linux/pgalloc.h>
 #include <linux/pgalloc_tag.h>
 #include <linux/pagewalk.h>
+#include <linux/cleanup.h>
 
 #include <asm/tlb.h>
 #include "internal.h"
@@ -78,6 +79,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 static bool split_underused_thp = true;
 
 static atomic_t huge_zero_refcount;
+static DEFINE_SPINLOCK(huge_zero_lock);
 struct folio *huge_zero_folio __read_mostly;
 unsigned long huge_zero_pfn __read_mostly = ~0UL;
 unsigned long huge_anon_orders_always __read_mostly;
@@ -224,7 +226,8 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 static bool get_huge_zero_folio(void)
 {
 	struct folio *zero_folio;
-retry:
+
+	/* Paired with atomic_set_release(). */
 	if (likely(atomic_inc_not_zero(&huge_zero_refcount)))
 		return true;
 
@@ -237,17 +240,22 @@ static bool get_huge_zero_folio(void)
 	}
 	/* Ensure zero folio won't have large_rmappable flag set. */
 	folio_clear_large_rmappable(zero_folio);
-	preempt_disable();
-	if (cmpxchg(&huge_zero_folio, NULL, zero_folio)) {
-		preempt_enable();
+
+	/* Paired with critical section in shrink_huge_zero_folio_scan(). */
+	spin_lock(&huge_zero_lock);
+	if (huge_zero_folio) {
+		/* Somebody else already installed it. */
+		atomic_inc(&huge_zero_refcount);
+		spin_unlock(&huge_zero_lock);
 		folio_put(zero_folio);
-		goto retry;
+		return true;
 	}
+	WRITE_ONCE(huge_zero_folio, zero_folio);
 	WRITE_ONCE(huge_zero_pfn, folio_pfn(zero_folio));
+	/* Paired with atomic_inc_not_zero(). +1 for shrinker pin. */
+	atomic_set_release(&huge_zero_refcount, 2);
+	spin_unlock(&huge_zero_lock);
 
-	/* We take additional reference here. It will be put back by shrinker */
-	atomic_set(&huge_zero_refcount, 2);
-	preempt_enable();
 	count_vm_event(THP_ZERO_PAGE_ALLOC);
 	return true;
 }
@@ -297,15 +305,22 @@ static unsigned long shrink_huge_zero_folio_count(struct shrinker *shrink,
 static unsigned long shrink_huge_zero_folio_scan(struct shrinker *shrink,
 						 struct shrink_control *sc)
 {
-	if (atomic_cmpxchg(&huge_zero_refcount, 1, 0) == 1) {
-		struct folio *zero_folio = xchg(&huge_zero_folio, NULL);
-		BUG_ON(zero_folio == NULL);
+	struct folio *zero_folio;
+
+	/* Paired with critical section in get_huge_zero_folio(). */
+	scoped_guard(spinlock, &huge_zero_lock) {
+		/* Paired with atomic_inc_not_zero() in get_huge_zero_folio(). */
+		if (atomic_cmpxchg(&huge_zero_refcount, 1, 0) != 1)
+			return 0;
+
+		zero_folio = huge_zero_folio;
+		VM_WARN_ON_ONCE(!zero_folio);
+		WRITE_ONCE(huge_zero_folio, NULL);
 		WRITE_ONCE(huge_zero_pfn, ~0UL);
-		folio_put(zero_folio);
-		return HPAGE_PMD_NR;
 	}
 
-	return 0;
+	folio_put(zero_folio);
+	return HPAGE_PMD_NR;
 }
 
 static struct shrinker *huge_zero_folio_shrinker;

-- 
2.55.0

