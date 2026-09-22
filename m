Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DF64BB271
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 09:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790070207; cv=none; b=bPP9WQsvVNbc7XfvBsyoCYhAbEIlbs4djlg3N7qU1fTSmfRt7ENmWEnR1SZrwlHqeS3iAhd0m82nIU+cuyIMlF2mW5vCD+ZgkeDrJfsfGaUc9WjhEAE/zZKcTl7wpQ6aQlnIf19xZsBHWQM1xSPijVrpWdF2RK/A8LMFZ+r5dVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790070207; c=relaxed/simple;
	bh=OsDMFFxZrWIyOXSPzYKPNPsHUM2r3kxi7fab5LOUWrI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PzUXK05qZ8u7RSod+OS6mpgkAou4yAkM82Q4nagOLqimDp1xbMdHQHg28PY140hOZ3vsDbskoFIfeGwviYLsqGimRfsjSRfNBogVPaENC1vQ8B+ijXp5g8m/6OoVnZrUCZIAebc9bQAfRucCo4hYGKRsG2k6XYEXstg+lSy8qgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yAft6YxO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yAft6YxO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2127D1F00899;
	Tue, 22 Sep 2026 09:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790070205;
	bh=aqIl+KsILpysAM4ReIRg/GWuSssoHnH+7vujlHegzk4=;
	h=Subject:To:Cc:From:Date;
	b=yAft6YxOH1SW2mFATZDgY9n33Py5i2sebpVNfIn+IwRuY4QDF4YFtQccZPhnSLdgC
	 fagUK1DlYm8wBpfnl81DT+qCdm1Xa897sxflZFsam+Kb+o9adU0RBGT21bokvZz+69
	 b3Tq38735x8EO3yVK3Drhdx6mtZWJn5JlII6AJXU=
Subject: FAILED: patch "[PATCH] mm/mlock: use the IRQ-safe accessor for NR_MLOCK in" failed to apply to 6.1-stable tree
To: shakeel.butt@linux.dev,akpm@linux-foundation.org,hughd@google.com,jannh@google.com,liam@infradead.org,ljs@kernel.org,pfalcato@suse.de,stable@vger.kernel.org,vbabka@kernel.org,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 11:37:14 +0200
Message-ID: <2026092214-ranged-caucasian-42c9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x e14a3454806468b086fe2e4ca2e1bff95b528531
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092214-ranged-caucasian-42c9@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e14a3454806468b086fe2e4ca2e1bff95b528531 Mon Sep 17 00:00:00 2001
From: Shakeel Butt <shakeel.butt@linux.dev>
Date: Tue, 1 Sep 2026 11:01:09 -0700
Subject: [PATCH] mm/mlock: use the IRQ-safe accessor for NR_MLOCK in
 __munlock_folio()

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

