Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78B54314AA;
	Tue, 28 Jul 2026 12:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785240383; cv=none; b=ou4rvIVDXUTRz64Ip5gSzmsIxIrcysAtPw1U99bEGhD6X/dnrd+81YP51XagBW4lDl2l+c4Yau67Sojzixd///Y4gxvII4lP607xBMfmRofdlcjp+eeB4lpao1mfXKOfWw1mnVQz6UFpBcjQtlTWqoQyo1qLK5nO4UquFdd9oz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785240383; c=relaxed/simple;
	bh=SFsjnbS3bJ4c9YZbrBfrJ8CJOq95OQeiVYiHgM8GtWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r5b/wVdWB8SfWDzDLokHjByjE8OIt5sejfm8AKwg+HNCp70C/lKyp4U3IAHy9I904lUv/bGoNhi+jiFOn+2EsYtERdtj6C3JHnnYDOP2Fty8XwKkzNK0L6EjmTyfY9nMZE47/+wCIthMKGy75lDSThoVyd9ZqbsSlgbqfo9jUsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqSKJNkA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqSKJNkA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68571F000E9;
	Tue, 28 Jul 2026 12:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785240381;
	bh=mjKJkRa62Aqd+bRag3pI+uHr2P4wVFC3OXxyekYF02Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZqSKJNkAF/KlE3tup6g34OnBj0G+C23d3mRL8v1BQTh5fLKVxJRin1b4vsO4WDzAC
	 jeHL9nHBkp8TJ1lMzZmwSUII9IC+xE2ai/QRjduaPfzoi9xjHpXr6A/PD3yFwYj9Hn
	 Mx+4qdSvW8IjxkW0Gm6vDebs5GXnTBGSQRjmsS4TpSDoK9/+Iu3Tm6yFDZ9NJyXeHd
	 RuiEOpQdH0O/6srOMhVsfYgHj8Q8ewpXThszUmnAhLFaGTTzXxB9Ctb7FADihuCYp7
	 N9nZGFo76pKTMWHS6wVRGJCvamsbCKltfuv+ADwbT2Obszh0BpwMaULe6RUmGtv+iP
	 Xw1yzEbOnkT0A==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 28 Jul 2026 13:05:45 +0100
Subject: [PATCH mm-hotfixes 2/2] mm/huge_memory: fix huge_zero_pfn race
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-fix-refcounted-huge-zero-v1-2-3f261f5447b4@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7361; i=ljs@kernel.org;
 h=from:subject:message-id; bh=SFsjnbS3bJ4c9YZbrBfrJ8CJOq95OQeiVYiHgM8GtWU=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLIyZivJJb7nrmHbskx1Qt6a7x+kD25K5Ur9PTO73/zCJ
 F/L9ktrOkpZGMS4GGTFFFmefxHfHyQSNq/zgr8bzBxWJpAhDFycAjARbRaG/wUzi9Lf8z158GPb
 uhJOiUN+Ljd8o++q+bOJ79mTE/BAzZLhN8s5nsCGi0rnytVmhUdkrXHsW2NWs+B3KMvb+VIJdzf
 bsgAA
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
outside of the critical section when !CONFIG_PERSISTENT_HUGE_ZERO_FOLIO,
and means huge zero allocation is gated on zero huge_zero_refcount.

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

* Only updating huge_zero_refcount in the huge_zero_lock critical section
  in get_huge_zero_folio() and shrink_huge_zero_folio_scan().

* Using atomic_set_release(&huge_zero_refcount) in get_huge_zero_folio()
  after huge_zero_[pfn, folio] are set. This is paired with
  atomic_inc_not_zero() to ensure atomic_inc_not_zero() only observes a
  non-zero value if huge_zero_[pfn, folio] are set.

* Using atomic_cmpxchg() in shrink_huge_zero_folio_scan() to ensure that it
  is set zero only when equal to 1 and set atomically.

* atomic_cmpxchg() being fully ordered ensures this is done prior to
  huge_zero_[folio, pfn] being set to NULL and ~0UL respectively.

Note that only the huge zero shrinker (via shrink_huge_zero_folio_scan())
can actually set huge_zero_refcount to zero, which is the count of mm's
which have at least one huge zero folio installed plus one shrinker pin.

Additionally convert a BUG_ON() to a VM_WARN_ON_ONCE().

Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
Reported-by: Hengbin Zhang <uqbarz@gmail.com>
Closes: https://lore.kernel.org/linux-mm/20260727154001.4102341-1-uqbarz@gmail.com/
Fixes: 3b77e8c8cde5 ("mm/thp: make is_huge_zero_pmd() safe and quicker")
Cc: stable@vger.kernel.org # 6.18.x: dependent on prior commit
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/huge_memory.c | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0f60bc82e87a..acee2d28b9bb 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -41,6 +41,7 @@
 #include <linux/pgalloc.h>
 #include <linux/pgalloc_tag.h>
 #include <linux/pagewalk.h>
+#include <linux/cleanup.h>
 
 #include <asm/tlb.h>
 #include "internal.h"
@@ -82,6 +83,7 @@ struct folio *huge_zero_folio __read_mostly;
 unsigned long huge_zero_pfn __read_mostly = HUGE_ZERO_UNSET_PFN;
 #ifndef CONFIG_PERSISTENT_HUGE_ZERO_FOLIO
 static atomic_t huge_zero_refcount;
+static DEFINE_SPINLOCK(huge_zero_lock);
 static struct shrinker *huge_zero_folio_shrinker;
 #endif
 
@@ -270,7 +272,8 @@ void mm_put_huge_zero_folio(struct mm_struct *mm)
 static bool get_huge_zero_folio(void)
 {
 	struct folio *zero_folio;
-retry:
+
+	/* Paired with atomic_set_release(). */
 	if (likely(atomic_inc_not_zero(&huge_zero_refcount)))
 		return true;
 
@@ -278,17 +281,21 @@ static bool get_huge_zero_folio(void)
 	if (unlikely(!zero_folio))
 		return false;
 
-	preempt_disable();
-	if (cmpxchg(&huge_zero_folio, NULL, zero_folio)) {
-		preempt_enable();
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
@@ -312,15 +319,22 @@ static unsigned long shrink_huge_zero_folio_count(struct shrinker *shrink,
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
+		VM_WARN_ON_ONCE(!huge_zero_folio);
+		WRITE_ONCE(huge_zero_folio, NULL);
 		WRITE_ONCE(huge_zero_pfn, HUGE_ZERO_UNSET_PFN);
-		folio_put(zero_folio);
-		return HPAGE_PMD_NR;
 	}
 
-	return 0;
+	folio_put(zero_folio);
+	return HPAGE_PMD_NR;
 }
 
 static int __init huge_zero_init(void)

-- 
2.55.0

