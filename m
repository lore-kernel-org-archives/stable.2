Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3DA4CF48C;
	Fri, 16 Oct 2026 21:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792186284; cv=none; b=jBWP/pxomqGQILl0dxMllyTPorXCbaQfVy7abENUA3YrvK7f95PUqRwnmsqeK40CRYpbJR8SVTWnOqY8v7UbqSdKwjE4nyJ7X9QLtlezeTwTdFM+Du+u0FNA4M4KTX3ubaHUaAiK73rYS4ll5vlQ8bC+IF14hjtt73IW7KPza2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792186284; c=relaxed/simple;
	bh=tv1Xmifa3z2JYzB+wTFFeiSz+jO0/Ocbi0W99Nl3H8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M9oiR1Et92LP9Ke6NGQq5SBHCrnk4YJeelS0n2KMcNsTn9sJ261AAGT/2LX8ayu+4Em5pRUZElw9cD1HkoutYl9jLGoYGr4CaeqIFfQihaLAEYVji/EkHjQa/f+TgcUR7lquFMB+3+ldQ7cLZqRoni06kXQ8phAbe0ROspVHffg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELUOrHbZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELUOrHbZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB52D1F000C4;
	Fri, 16 Oct 2026 21:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792186283;
	bh=6xXCI1y+KIL4EzZd1UBU0Rx2a4JShmZFF+y9QS0NW0s=;
	h=From:To:Cc:Subject:Date;
	b=ELUOrHbZ/x6S19d8SFb6r93LmJRMj8w8VM7M0XrgbI5tqbBF8NAzMi7O6GsYQENqb
	 vOxC/Ra8idG//RrWiFTSy3mTZosZ9ME6EwO7kRhKJi+pgN1P/e3G2WZ1EI7csRy6U2
	 Ii/2uLoE4qTdNk4t16BUBvRXr0i3Fz8DZT/vIR0e6wYnToK51qtCAAcovCPhHjqMeU
	 qRglTLYlT9UJ4yhJLXJ1yTtMsre4IAeUKLlIFR+su9q+TSg3NoJ9nBdT9jwfBjG5GT
	 YeFA5WXgKj16/BhQ26sF+HC/a6XNFNWQe7jCCh4Nns/Y42zQXWsixmNVKj36zUK/qD
	 VvXefLWmItnew==
From: "Barry Song (Xiaomi)" <baohua@kernel.org>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: ehab.ababneh@intel.com,
	axelrasmussen@google.com,
	baohua@kernel.org,
	kasong@tencent.com,
	lance.yang@linux.dev,
	linux-kernel@vger.kernel.org,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	weixugc@google.com,
	yuanchu@google.com,
	yuzhao@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	stable@vger.kernel.org
Subject: [PATCH] mm/mglru: fix using folio_mark_accessed to replace folio_set_active
Date: Sat, 17 Oct 2026 05:31:15 +0800
Message-Id: <20261016213115.70515-1-baohua@kernel.org>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 6cbdd9726fb5 ("mm/mglru: use folio_mark_accessed to
replace folio_set_active") attempted to avoid over-protecting
in-fault read-ahead file folios by placing them in the
second-oldest generation rather than the young generations.

However, it repurposes `PG_referenced` on in-fault read-ahead
file folios for this purpose, potentially coupling their
handling with that of regular file accesses through syscalls,
which also use `PG_referenced`.

This could regress some workloads, as reported by Kairui Song[1]
and Ehab Ababneh[2]. Many thanks to both for reporting these
issues!

The long-term fix is Kairui's MGLRU-FG, but in the meantime,
we also need a quick fix that can be backported to stable.

This patch reverts the original commit's abuse of `PG_referenced`
while preserving its goal of avoiding over-protection of
in-fault read-ahead file folios by adjusting only
`lru_gen_folio_seq()`.

Specifically, in-fault read-ahead file folios with `PG_active`
set but `PG_workingset` clear are placed in the second-oldest
generation (the third-youngest generation). Activated file
folios and refaulted workingset file folios remain in the
youngest generations.

Kernel build tests in a memcg show that this approach not only
preserves the original patch's benefits but also further
improves performance.

w/o fix:

real    1m49.094s
user    25m31.484s
sys     3m40.959s
pswpin: 662112
pswpout: 2504415
pgpgin: 4424336
pgpgout: 10355273
refault_file: 359626
refault_anon: 670724

w/ fix:

real    1m48.913s
user    25m31.639s
sys     3m30.875s
pswpin: 689815
pswpout: 2689894
pgpgin: 4422659
pgpgout: 11043464
refault_file: 326566
refault_anon: 697138

Revert original patch:

real    1m50.044s
user    25m37.137s
sys     4m4.493s
pswpin: 1349087
pswpout: 4317933
pgpgin: 7083597
pgpgout: 17602735
refault_file: 337676
refault_anon: 1368542

[1] https://lore.kernel.org/linux-mm/20261003-mglru-fg-v3-0-cbd4546a5bd9@tencent.com/
[2] https://lore.kernel.org/linux-mm/20260901180704.168106-1-ehab.ababneh@intel.com/
Fixes: 6cbdd9726fb5 ("mm/mglru: use folio_mark_accessed to replace folio_set_active")
Cc: <stable@vger.kernel.org>
Signed-off-by: Barry Song (Xiaomi) <baohua@kernel.org>
---
 * An earlier discussion can be found here:
 https://lore.kernel.org/linux-mm/20261016084256.12955-1-baohua@kernel.org/
 Thanks for Kairui's comment on it.

 include/linux/mm_inline.h |  5 +++--
 mm/folio.c                | 16 +++-------------
 mm/vmscan.c               |  9 ++-------
 mm/workingset.c           | 10 ++++------
 4 files changed, 12 insertions(+), 28 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index ab69b9930893..97f157aafd58 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -319,7 +319,8 @@ static inline unsigned long lru_gen_folio_seq(const struct lruvec *lruvec,
 	 * |<---------------------------- MAX_NR_GENS ---------------------------->|
 	 */
 	if (folio_test_active(folio))
-		gen = MIN_NR_GENS - folio_test_workingset(folio);
+		gen = MIN_NR_GENS - folio_test_workingset(folio) +
+		      (type ? !folio_test_workingset(folio) : 0);
 	else if (reclaiming)
 		gen = MAX_NR_GENS;
 	else if ((!folio_is_file_lru(folio) && !folio_test_swapcache(folio)) ||
@@ -327,7 +328,7 @@ static inline unsigned long lru_gen_folio_seq(const struct lruvec *lruvec,
 		  (folio_test_dirty(folio) || folio_test_writeback(folio))))
 		gen = MIN_NR_GENS;
 	else
-		gen = MAX_NR_GENS - (folio_test_workingset(folio) || folio_test_referenced(folio));
+		gen = MAX_NR_GENS - folio_test_workingset(folio);
 
 	return max(READ_ONCE(lrugen->max_seq) - gen + 1, READ_ONCE(lrugen->min_seq[type]));
 }
diff --git a/mm/folio.c b/mm/folio.c
index 35e242b48870..2af724cecb31 100644
--- a/mm/folio.c
+++ b/mm/folio.c
@@ -474,20 +474,10 @@ void folio_add_lru(struct folio *folio)
 			folio_test_unevictable(folio), folio);
 	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
 
-	/*
-	 * For refaulted workingset folios, set PG_active so they
-	 * can be added to active generations.
-	 * For prefaulted file folios, folio_mark_accessed() sets
-	 * PG_referenced so lru_gen_folio_seq() places them into
-	 * the second oldest generation.
-	 */
+	/* see the comment in lru_gen_folio_seq() */
 	if (lru_gen_enabled() && !folio_test_unevictable(folio) &&
-	    lru_gen_in_fault() && !(current->flags & PF_MEMALLOC)) {
-		if (folio_test_workingset(folio))
-			folio_set_active(folio);
-		else if (!folio_test_referenced(folio))
-			folio_mark_accessed(folio);
-	}
+	    lru_gen_in_fault() && !(current->flags & PF_MEMALLOC))
+		folio_set_active(folio);
 
 	folio_batch_add_and_move(folio, lru_add);
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index daa7e37c2236..e82ba737c028 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -952,13 +952,8 @@ static bool lru_gen_set_refs(struct folio *folio, const vma_flags_t *vma_flags)
 		return false;
 	}
 
-	/* Promote on second access */
-	if (folio_lru_refs(folio) > 1) {
-		folio_set_workingset(folio);
-		folio_set_lru_refs(folio, 0);
-	} else {
-		folio_mark_accessed(folio);
-	}
+	folio_set_workingset(folio);
+	folio_set_lru_refs(folio, 0);
 	return true;
 }
 #else
diff --git a/mm/workingset.c b/mm/workingset.c
index 1504f91cdca5..10d4ce202cca 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -319,13 +319,11 @@ static void lru_gen_refault(struct folio *folio, void *shadow)
 
 	atomic_long_add(delta, &lrugen->refaulted[hist][type][tier]);
 
+	/* see folio_add_lru() where folio_set_active() will be called */
+	if (lru_gen_in_fault())
+		mod_lruvec_state(lruvec, WORKINGSET_ACTIVATE_BASE + type, delta);
+
 	if (workingset) {
-		/*
-		 * see folio_add_lru(), where folio_set_active() is
-		 * called for workingset folios
-		 */
-		if (lru_gen_in_fault())
-			mod_lruvec_state(lruvec, WORKINGSET_ACTIVATE_BASE + type, delta);
 		folio_set_workingset(folio);
 		mod_lruvec_state(lruvec, WORKINGSET_RESTORE_BASE + type, delta);
 	} else
-- 
2.34.1

