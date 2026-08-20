Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5F347886E
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 15:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787240096; cv=none; b=EjtCr4tgSm03axfjwbtJPm8Af+VzrNK3Y2tQs8XzddEeWh0StcXjiSBuDE+VKXDr77EARLFQOi9Dv94OPv/FHT7fyCjDcopyCXocmUfd3jVPz+i66PtXmi+S6vE2yMv4anDr17wkttts3vFnIOS8E03wfOnAFvcBmJxsIouDe2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787240096; c=relaxed/simple;
	bh=e8+3g38OIGBev3BOHgsUTc2DmA3YCj8+Z1UZbPe8LuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+jI0ENyFkiqh4RuCOd6FypnjlAwf2WRT1gcNHaUkecUMEm5UZY9J3/hPgbiHyaHJDnYCIp7Razy9eM3x6ayAy2HmHtMkvNAyhNOOO/M5aJ4quX4X1B/N2C24Kqwoldh70p9gweddAfuhVl/pp0lXp7EmRF/CnjQJWO/kXrDJUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YB/bdLDT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YB/bdLDT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB941F000E9;
	Thu, 20 Aug 2026 15:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787240094;
	bh=n747UQRuEvhfb9Z+fbNCdlB08RvX058xm5jp8rwCPZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YB/bdLDTvtqW4sTxA73+XtAtW2nUIrksqAtZh9GYjb7ij3CiVWMzHzCsc2bxWQVtL
	 FaeNC2LMbC6gwJIirgMcirp1BcE29bFcK9LYnwXsl30JyDY/wSLNE1VvgtNDwmBJdZ
	 DVXCW7p32BRzyb0FLWLtGvxejUakzHN0Iq3E2lULjf/OMiguHTILv17RrF5eB6lMcS
	 BFRVavRjWAZlOr4bpY1GZubT+mD2h/qRKAT7TAOrc8eEFqloQOcBWLnUayFMe4nkyN
	 PmXKNM9WrH37JxXtLW/nRBId4M6fUQ6TKb3c8u8JtUFIHtG5YWpeUkj7MhhCBlvXUP
	 LI+PZ6kYknRyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Hengbin Zhang <uqbarz@gmail.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Hannes Reinecke <hare@suse.de>,
	Hugh Dickins <hughd@google.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	"Liam R. Howlett" <liam@infradead.org>,
	Nico Pache <npache@redhat.com>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yang Shi <shy828301@gmail.com>,
	Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] mm/huge_memory: fix huge_zero_pfn race
Date: Thu, 20 Aug 2026 11:34:50 -0400
Message-ID: <20260820153450.2079191-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081714-licking-credit-6cdf@gregkh>
References: <2026081714-licking-credit-6cdf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>

[ Upstream commit 33192a26cddea7a7e4ca66e5c3eebd36fa8be2bb ]

Patch series "mm/huge_memory: fix huge_zero_pfn race", v2.

There is a subtle race in the reference-counted huge_zero_folio
implementation.

The fast path atomic logic fails to account for the fact that the shrinker
(which drops the final huge_zero_refcount pin) can overwrite huge_zero_pfn
with the ~0UL sentinel value in shrink_huge_zero_folio_scan() after a
racing get_huge_zero_folio() installed a valid value there.

This results in huge_zero_folio being correctly set but huge_zero_pfn
being set incorrectly and thus is_huge_zero_pfn() and consequently
is_huge_zero_pmd() will misidentify the huge zero folio as being an
ordinary THP folio.

This can result in the huge zero folio being split and otherwise treated
incorrectly.

The solution to this is very subtle as there is an atomic fast path, and
thus ordering in weakly ordered architectures has to be treated very
carefully.

The first commit fixes the issue by introducing a spinlock around
huge_zero_[pfn, folio, refcount] write, with careful consideration paid to
load/store ordering in the fast path.  It is placed first and kept as
small as possible so that it can be backported on its own.

The second commit is a pure cleanup which reworks the
CONFIG_PERSISTENT_HUGE_ZERO_FOLIO logic to better separate the persistent
logic from the dynamically allocated one.

This patch (of 2):

If !CONFIG_PERSISTENT_HUGE_ZERO_FOLIO, the huge_zero_folio is refcounted
by huge_zero_refcount and returned by mm_get_huge_zero_folio().

When the caller is done with the huge zero page, its reference count is
decremented.  Only a shrinker can set the reference count to zero.

A race can unfortunately occur between a shrinker decrementing the
reference count to zero and a concurrent page fault.

This is because shrink_huge_zero_folio_scan() might, if very unlucky, be
preempted between setting huge_zero_refcount to zero and writing an
invalid value.

During this time get_huge_zero_folio() could write to huge_zero_pfn before
shrink_huge_zero_folio_scan() resumes.

In this event the huge zero folio will be persistently misidentified
causing the THP code path to be entered inappropriately for the huge zero
folio:

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

The fast path in get_huge_zero_folio() uses atomic_inc_not_zero(), which
is outside of the critical section, and means huge zero allocation is
gated on zero huge_zero_refcount.

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

Link: https://lore.kernel.org/20260730-fix-refcounted-huge-zero-v2-0-c5d8a41b317f@kernel.org
Link: https://lore.kernel.org/20260730-fix-refcounted-huge-zero-v2-1-c5d8a41b317f@kernel.org
Fixes: 3b77e8c8cde5 ("mm/thp: make is_huge_zero_pmd() safe and quicker")
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reported-by: Hengbin Zhang <uqbarz@gmail.com>
Closes: https://lore.kernel.org/linux-mm/20260727154001.4102341-1-uqbarz@gmail.com/
Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Hannes Reinecke <hare@suse.de>
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
[ replaced scoped_guard() with explicit spin_lock()/spin_unlock() and returned the page pointer instead of bool due to 5.10's gnu89 and older get_huge_zero_page() signature ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/huge_memory.c | 46 +++++++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f620861d00995..ecbd84a4a97b0 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -60,6 +60,7 @@ unsigned long transparent_hugepage_flags __read_mostly =
 static struct shrinker deferred_split_shrinker;
 
 static atomic_t huge_zero_refcount;
+static DEFINE_SPINLOCK(huge_zero_lock);
 struct page *huge_zero_page __read_mostly;
 unsigned long huge_zero_pfn __read_mostly = ~0UL;
 
@@ -90,7 +91,8 @@ bool transparent_hugepage_active(struct vm_area_struct *vma)
 static struct page *get_huge_zero_page(void)
 {
 	struct page *zero_page;
-retry:
+
+	/* Paired with atomic_set_release(). */
 	if (likely(atomic_inc_not_zero(&huge_zero_refcount)))
 		return READ_ONCE(huge_zero_page);
 
@@ -101,17 +103,22 @@ static struct page *get_huge_zero_page(void)
 		return NULL;
 	}
 	count_vm_event(THP_ZERO_PAGE_ALLOC);
-	preempt_disable();
-	if (cmpxchg(&huge_zero_page, NULL, zero_page)) {
-		preempt_enable();
+
+	/* Paired with critical section in shrink_huge_zero_page_scan(). */
+	spin_lock(&huge_zero_lock);
+	if (huge_zero_page) {
+		/* Somebody else already installed it. */
+		atomic_inc(&huge_zero_refcount);
+		spin_unlock(&huge_zero_lock);
 		__free_pages(zero_page, compound_order(zero_page));
-		goto retry;
+		return READ_ONCE(huge_zero_page);
 	}
+	WRITE_ONCE(huge_zero_page, zero_page);
 	WRITE_ONCE(huge_zero_pfn, page_to_pfn(zero_page));
+	/* Paired with atomic_inc_not_zero(). +1 for shrinker pin. */
+	atomic_set_release(&huge_zero_refcount, 2);
+	spin_unlock(&huge_zero_lock);
 
-	/* We take additional reference here. It will be put back by shrinker */
-	atomic_set(&huge_zero_refcount, 2);
-	preempt_enable();
 	return READ_ONCE(huge_zero_page);
 }
 
@@ -154,15 +161,24 @@ static unsigned long shrink_huge_zero_page_count(struct shrinker *shrink,
 static unsigned long shrink_huge_zero_page_scan(struct shrinker *shrink,
 				       struct shrink_control *sc)
 {
-	if (atomic_cmpxchg(&huge_zero_refcount, 1, 0) == 1) {
-		struct page *zero_page = xchg(&huge_zero_page, NULL);
-		BUG_ON(zero_page == NULL);
-		WRITE_ONCE(huge_zero_pfn, ~0UL);
-		__free_pages(zero_page, compound_order(zero_page));
-		return HPAGE_PMD_NR;
+	struct page *zero_page;
+
+	/* Paired with critical section in get_huge_zero_page(). */
+	spin_lock(&huge_zero_lock);
+	/* Paired with atomic_inc_not_zero() in get_huge_zero_page(). */
+	if (atomic_cmpxchg(&huge_zero_refcount, 1, 0) != 1) {
+		spin_unlock(&huge_zero_lock);
+		return 0;
 	}
 
-	return 0;
+	zero_page = huge_zero_page;
+	VM_WARN_ON_ONCE(!zero_page);
+	WRITE_ONCE(huge_zero_page, NULL);
+	WRITE_ONCE(huge_zero_pfn, ~0UL);
+	spin_unlock(&huge_zero_lock);
+
+	__free_pages(zero_page, compound_order(zero_page));
+	return HPAGE_PMD_NR;
 }
 
 static struct shrinker huge_zero_page_shrinker = {
-- 
2.53.0

