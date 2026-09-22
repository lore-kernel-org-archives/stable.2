Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582663E4C6B
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 17:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790099460; cv=none; b=bJH3T97RO8fh0J0Fz3IQpYPbT0hKQxdaR30ms8W9fsew1cO/OqVXxzOXxurWWnRUURm5gk4v3h+gQicYveFmJ71W5bfQeFBTAa9JAV2GrqcSJoROk59yqs8htJjSbZsIsQv1lH7QqYQzsjCDFkAzJAtjjCfTUcFdcCg+1H0MPPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790099460; c=relaxed/simple;
	bh=h6ZqLD9Igm5EMhoJBPVzM81sjF7ve9i1mQWntAP+HiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VsVr5JP1s0lb1aZg8qQmyZf0daFdXKRAtqJ8We+g6yrx7zlw2PDgROqJu06wxj6I3ymkVI25J+tBPaHShko2Q0izAbhf5oLRPnVfj7ZvGZoS4rXnExO/6qTcsvtfj65ZxdQz9oAZkjQT0G+LMIYPdt5mJMKqgpHJajQlxX/H7Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OU8OTmyU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OU8OTmyU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0CB1F000FF;
	Tue, 22 Sep 2026 17:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790099458;
	bh=ce3vlyngO6BLUFzcYwuU1Yuzd5Y+Tf7r5veH9LZ1Jo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OU8OTmyU7VfklvulF104sVS5aMehlKNvoL1npUUWHwaNoxFi7oPSbsm7NasJ0s/BQ
	 kLjbCV+UDL8RKPZpG6poGGEzJabV2C/GN6Hyxbapmv7Fqte/MGGFXF1DdGV52y7+LA
	 CVu0ZwQokIG6FiwuUZoPOfTkaummbRrBxAimSMvXcXEoDLGF7JpQS84RoCoYn+kZJb
	 iNze41EVNBD30ZVEomC9Evw6z5cs033VcG/2Jkswd9R9UU1Oc17X8e9aufbUd9jmUU
	 /HeM4osFh2czawG1vHKcgP5dSnL+BN3i8KDgFWfrTMHCB0oOrHACboWAGzSyAfTZrG
	 lKnjDVmowP3Vw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	syzbot+cd2073ee6d958a8d0fcd@syzkaller.appspotmail.com,
	Hugh Dickins <hughd@google.com>,
	Jann Horn <jannh@google.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Vlastimil Babka <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mm/mlock: use the IRQ-safe accessor for NR_MLOCK in __munlock_folio()
Date: Tue, 22 Sep 2026 13:50:55 -0400
Message-ID: <20260922175055.3307750-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092214-ranged-caucasian-42c9@gregkh>
References: <2026092214-ranged-caucasian-42c9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shakeel Butt <shakeel.butt@linux.dev>

[ Upstream commit e14a3454806468b086fe2e4ca2e1bff95b528531 ]

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

The UNEVICTABLE_PG* events are deliberately left on the __ accessors: they
occupy different vm_event_states slots from the UNEVICTABLE_PGCLEARED that
__free_pages_prepare() bumps, and nothing updates those two from interrupt
context.

Link: https://lore.kernel.org/20260901180109.3797944-1-shakeel.butt@linux.dev
Fixes: 2fbb0c10d1e8 ("mm/munlock: mlock_page() munlock_page() batch by pagevec")
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Reported-by: syzbot+cd2073ee6d958a8d0fcd@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-mm/6a931c5a.08e933ee.dbf97.0093.GAE@google.com/
Acked-by: Hugh Dickins <hughd@google.com>
Cc: Jann Horn <jannh@google.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mlock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 3bf9e1d263da4..0124022f0f379 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -141,7 +141,7 @@ static struct lruvec *__munlock_page(struct page *page, struct lruvec *lruvec)
 
 munlock:
 	if (TestClearPageMlocked(page)) {
-		__mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
+		mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
 		if (isolated || !PageUnevictable(page))
 			__count_vm_events(UNEVICTABLE_PGMUNLOCKED, nr_pages);
 		else
-- 
2.53.0

