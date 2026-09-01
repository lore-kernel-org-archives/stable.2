Received: from mta1.migadu.com (out-65.mta1.migadu.com [95.215.58.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961FF493645
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 18:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788285684; cv=none; b=sHGT/x5xHV28I8kV2bflYs7p+RuhV8SDi/a7+WvxMl7lSsRaqKDv5cLlknB6aMf15t7OG3NjT5NX57257ULbA0kJlvA5ssKXQtDw8JpYpHU5qT5IAPiozN/U8vaFZU09hyWUriESLcAAfeDWcaMmumlimkupjgkENyD6p5L+Ra0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788285684; c=relaxed/simple;
	bh=nqYmKjd9b9ej6SRWcnIOWJeONPy2vtwt8S3/sMfIUtY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FhiWiHhz0HEJoc3j0Ek5ApT2BzNuRJdYgLfbcIChhmg8GOwg2ULAtis2SH+jvpOPfhFdR5O2HTqnZo/HLkefcOsdV6Cg8y5XpMKtoF3jSeg9gSV48ukgeD/p5HNZTs5bfeIHVni3WBJFVmViiBHz/vALY/Z92EKkV8CvvT9c+Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q6d6LXw5; arc=none smtp.client-ip=95.215.58.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q6d6LXw5"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=nqYmKjd9b9ej6SRWcnIOWJeONPy2vtwt8S3/sMfIUtY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788285680; v=1; x=1788890480;
 b=q6d6LXw5C7LRW32fkzga2wLw7TSXkpXDll/8iUnvQEoZ14NRnxa41tilgeEnscAopuufaDKV
 Kde3G4BMAos8MOxMYnZy0mrzOmr4bEtRvzXCpqilDG5DZ2mKe66DWsRDQIaDaEQ527BwOvUUd0U
 tBY/fp83+1EuC7Zj3egqFu74=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id dc1bc49c649213e5;
	Tue, 01 Sep 2026 18:01:20 +0000
X-Mizu-Trace-ID: dc1bc49c649213e5
X-Migadu-Flow: FLOW_OUT
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Vlastimil Babka <vbabka@kernel.org>
Cc: "Liam R . Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Matthew Wilcox <willy@infradead.org>,
	Meta kernel team <kernel-team@meta.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] mm/mlock: use the IRQ-safe accessor for NR_MLOCK in __munlock_folio()
Date: Tue,  1 Sep 2026 11:01:09 -0700
Message-ID: <20260901180109.3797944-1-shakeel.butt@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NR_MLOCK is updated from interrupt context.  __free_pages_prepare() clears
a stray PG_mlocked and adjusts NR_MLOCK, and a folio can reach it with the
flag still set from a bio completion handler:

  __free_pages_ok+0x6af/0x7a0
  <IRQ>
  __bio_release_pages+0xde/0x260
  __iomap_dio_bio_end_io+0x16e/0x1a0
  blk_update_request+0x14b/0x3d0
  blk_mq_end_request+0x18/0x30
  blk_done_softirq+0x49/0x60

The folio gets there like this.  A MAP_SHARED file mapping is mlocked, so
its page cache folios carry PG_mlocked, and an O_DIRECT write sourced from
that mapping GUP-pins those same folios.  munlock() then runs
mlock_vma_pages_range(), which clears VM_LOCKED before walking the page
tables to munlock each folio.  A concurrent hole punch reaches the folio
through the rmap (i_mmap_rwsem, not mmap_lock) and can land inside that
window: __folio_remove_rmap() -> munlock_vma_folio() sees VM_LOCKED
already clear, so it neither queues the folio on the mlock batch nor takes
a reference, and the pte it clears makes the pending mlock_pte_range()
walk skip the folio at its !pte_present() check.  filemap_remove_folio()
then drops the page cache reference, leaving the bio's pin as the last
one, released from the completion handler above.

So __zone_stat_mod_folio() here needs interrupts disabled, not merely
preemption, and __munlock_folio() has a path where they are not: when the
folio has already been taken off the LRU by somebody else the function
jumps straight to the counter update without taking the lruvec lock.  The
read-modify-write of the per-CPU NR_MLOCK diff can then be interrupted by
the softirq above, and one of the two decrements is lost, leaving Mlocked
in /proc/meminfo permanently overstated.

Use zone_stat_mod_folio().  mod_zone_state()'s this_cpu_try_cmpxchg() is
atomic against a same-CPU interrupt and retries, and on the path where the
lruvec lock is held its cost is negligible next to the lock itself.

The UNEVICTABLE_PG* events are deliberately left on the __ accessors:
they occupy different vm_event_states slots from the UNEVICTABLE_PGCLEARED
that __free_pages_prepare() bumps, and nothing updates those two from
interrupt context.

Fixes: 2fbb0c10d1e8 ("mm/munlock: mlock_page() munlock_page() batch by pagevec")
Cc: <stable@vger.kernel.org>
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/mlock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index efa6716e4dfb..39215a3eab1f 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -141,7 +141,7 @@ static struct lruvec *__munlock_folio(struct folio *folio, struct lruvec *lruvec
 
 munlock:
 	if (folio_test_clear_mlocked(folio)) {
-		__zone_stat_mod_folio(folio, NR_MLOCK, -nr_pages);
+		zone_stat_mod_folio(folio, NR_MLOCK, -nr_pages);
 		if (isolated || !folio_test_unevictable(folio))
 			__count_vm_events(UNEVICTABLE_PGMUNLOCKED, nr_pages);
 		else
-- 
2.53.0-Meta

