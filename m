Received: from mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A164A99DA
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 16:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788367553; cv=none; b=D+vKjqHfj586xu+78DEcYil3njpfXyzv6Y8KoCR0IgQyQSBMK0ArwnaZdiTLWFe6poDIS1GEpVxFQaZYpx5H8kQUFlA5rHXVngYQn5YVSU5+i+xMKlG81BK2dByvGOil9CnESMigq+oEQ2DqCilvIZICqqIVAtMsfx72KpcToS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788367553; c=relaxed/simple;
	bh=eBbY4iMBTmEAonlduKED6Icf9+LbGVlV12xAIrCk42s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKhZW+/Jq7DROJLF09VA2tBbJwHMU3fxQFq0F6SqolsSyKaCe/CkoAhI97PaebSaOJJKKgEj2ecTFqffIE7C55kyfwRIeRZKXzcYNtUFpTZohye9ytQCFwn5fYwzn4kM18gNJb/R5xpFYb4pXA75zrPNKjsQW7C9ciUOTJgiXJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EzK0NrID; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EzK0NrID"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=eBbY4iMBTmEAonlduKED6Icf9+LbGVlV12xAIrCk42s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788367548; v=1; x=1788972348;
 b=EzK0NrIDej/JH7z8uxUn4qy2Z9j2Ozo5h3VjpfOv0oek/exCtwG55atrJvO9DYZzl5iaLYZW
 QzY6hZGmQfNavtJh5Qh9HjU8piCnG3OeRdAs6XwmiIE0WGW6CmPHCpebabDMO+q+pFY8CkGXOdF
 dM4PbO4TLeW522m5zDDvu/RI=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7a7ca504685ebf88;
	Wed, 02 Sep 2026 16:45:48 +0000
X-Mizu-Trace-ID: 7a7ca504685ebf88
X-Migadu-Flow: FLOW_OUT
Date: Wed, 2 Sep 2026 09:45:43 -0700
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, "Liam R . Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Matthew Wilcox <willy@infradead.org>, Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/mlock: use the IRQ-safe accessor for NR_MLOCK in
 __munlock_folio()
Message-ID: <aphSajBg4a-e-Iyv@linux.dev>
References: <20260901180109.3797944-1-shakeel.butt@linux.dev>
 <1ddfa7dc-2dd8-406d-8454-59a349972106@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ddfa7dc-2dd8-406d-8454-59a349972106@google.com>

On Tue, Sep 01, 2026 at 06:27:06PM -0700, Hugh Dickins wrote:
> On Tue, 1 Sep 2026, Shakeel Butt wrote:
> 
> > NR_MLOCK is updated from interrupt context.  __free_pages_prepare() clears
> > a stray PG_mlocked and adjusts NR_MLOCK, and a folio can reach it with the
> > flag still set from a bio completion handler:
> > 
> >   __free_pages_ok+0x6af/0x7a0
> >   <IRQ>
> >   __bio_release_pages+0xde/0x260
> >   __iomap_dio_bio_end_io+0x16e/0x1a0
> >   blk_update_request+0x14b/0x3d0
> >   blk_mq_end_request+0x18/0x30
> >   blk_done_softirq+0x49/0x60
> > 
> > The folio gets there like this.  A MAP_SHARED file mapping is mlocked, so
> > its page cache folios carry PG_mlocked, and an O_DIRECT write sourced from
> > that mapping GUP-pins those same folios.  munlock() then runs
> > mlock_vma_pages_range(), which clears VM_LOCKED before walking the page
> > tables to munlock each folio.  A concurrent hole punch reaches the folio
> > through the rmap (i_mmap_rwsem, not mmap_lock) and can land inside that
> > window: __folio_remove_rmap() -> munlock_vma_folio() sees VM_LOCKED
> > already clear, so it neither queues the folio on the mlock batch nor takes
> > a reference, and the pte it clears makes the pending mlock_pte_range()
> > walk skip the folio at its !pte_present() check.  filemap_remove_folio()
> > then drops the page cache reference, leaving the bio's pin as the last
> > one, released from the completion handler above.
> 
> I'm hardly ashamed to admit that I've not tried to digest
> that paragraph. You're writing about the rare fallback cases when
> PG_mlocked is cleared late, and unevictable_pgs_cleared incremented to
> notify us of that defect: yes, I accept that might happen at interrupt
> time, and so we ought not to take the __shortcut in __munlock_folio()
> which you fix  below.
> 
> > 
> > So __zone_stat_mod_folio() here needs interrupts disabled, not merely
> > preemption, and __munlock_folio() has a path where they are not: when the
> > folio has already been taken off the LRU by somebody else the function
> > jumps straight to the counter update without taking the lruvec lock.  The
> > read-modify-write of the per-CPU NR_MLOCK diff can then be interrupted by
> > the softirq above, and one of the two decrements is lost, leaving Mlocked
> > in /proc/meminfo permanently overstated.
> > 
> > Use zone_stat_mod_folio().  mod_zone_state()'s this_cpu_try_cmpxchg() is
> > atomic against a same-CPU interrupt and retries, and on the path where the
> > lruvec lock is held its cost is negligible next to the lock itself.
> > 
> > The UNEVICTABLE_PG* events are deliberately left on the __ accessors:
> > they occupy different vm_event_states slots from the UNEVICTABLE_PGCLEARED
> > that __free_pages_prepare() bumps, and nothing updates those two from
> > interrupt context.
> > 
> > Fixes: 2fbb0c10d1e8 ("mm/munlock: mlock_page() munlock_page() batch by pagevec")
> > Cc: <stable@vger.kernel.org>
> 
> Okay: just a wrong stat, but it ought to go back to 0, so Cc stable yes.
> 
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> Acked-by: Hugh Dickins <hughd@google.com>
> 
> But I do think you (or Andrew :-) should include
> 
> Reported-by: syzbot+cd2073ee6d958a8d0fcd@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-mm/6a931c5a.08e933ee.dbf97.0093.GAE@google.com/
> 
> That was indeed reporting a different way to get a WARNING from this,
> when offlining a CPU: but it should be acknowledged for bringing you
> here, and we should tell syzbot it's fixed by this.
> 
> I've been trying to work out whether you're going to come back in a
> day or two, changing the __count_vm_events() too: and had raised in
> that thread the question of why lru_add_drain()'s __count_vm_events
> were not also reported by syzbot; but now I can see
>  * vm counters are allowed to be racy. Use raw_cpu_ops to avoid the
>  * local_irq_disable overhead.
> and realize that they're not a problem; so this looks complete, we
> shouldn't need local_lock()ing in mlock_drain_remote() after all.
> 

Thanks a lot Hugh for taking a look and Andrew has already added the syzbot
tags.

