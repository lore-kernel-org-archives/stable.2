Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5089233A9E1
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 01:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788312447; cv=none; b=VMpwNR6g2Z2bo1e8BaAU15L+vEHKknUbc6ol3xR2e7mt5+8OWGPE8GNQ2mbame5Y8Ue1X2D60D7kjPAiUgQmyMSI1z2j1ORu/MrXO+F89wxZG6lFDzJQVIaRdKFM9oywYGuy0nFWABa+yT5yWCZflHpmJ10jguYYGsIms9zGEvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788312447; c=relaxed/simple;
	bh=KbyjCdIgbhFf19+CmWBXyWFyDDtmWh84afqqGOVaJuA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Bvmf4ljzClI7Ur8q5dhEIrDqtoapRzZpndWou0b+EQ/kXaDRH3tN09YACu8IVx9f8+1s7IC6xHPya54UbVOVgjas5rXISi9GRKZQ9YmfJ3zba+bOqoiVoByqOF6Zd8o/f7sa+4fwsJudSRSlHkzqPCW5L3ymNE8N4PHImLcsWLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bnpg4L5K; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bnpg4L5K"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-836c8bdac50so7935917b3.0
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 18:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788312444; x=1788917244; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zUMTfAI7ONprrYSeDVVm7zPC919OUwaHos5tY6hqkXQ=;
        b=Bnpg4L5KED8hw2Q0Ia0+nqTZ7Mc1fqRSPK8P4I6rkfHRu5WPm6njRH9whOIAt925zA
         /c3Bxqlge/ESJdaZRylKuqgF2kHexmfaqgjDTaRQN5Zkfn66/EyBv+Hu2cjq2ftG38Ra
         WMx0ZEustCPKjRfLDv/K6jLQDaFLkNh2MRewckGAhIWm+2LgAPMaXHla7tIINd6RPnSi
         +35Ua0ofkmX9wRjFyMAm4RlwYef+HrqCwsKbjAjYa4RrpczzKIKJaH+b+bJf4V3uUjGJ
         iVyubOyRkTqrxMFheeti2K/wepLhAh214Qqs9vqaVJyd7e6N1h581kyl3EwMN4f5Gd0p
         pDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788312444; x=1788917244;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zUMTfAI7ONprrYSeDVVm7zPC919OUwaHos5tY6hqkXQ=;
        b=GJPSofCHZ0PtSs02SgP/VfFfnAR3sgUXLZ/L/NkFV1UP6Vf5jCdwZssrKWlof/5SyG
         20SJKE05Tu6QhgUHMqKQLps62nSRi57hu5mAb04AUJauM6UOk5Cikm4+xLutny1A76X8
         wH4DkaBrcvhcXoJFqrTWGCm3PEndC8sVcblOfyUKt7Ji/4bKEzMYLcvKf3Yt6jBMyuW6
         ZCh8bYQjniVmWC9bLLZ/dUkpApGLsKqi3pzPI7LnPoNZMESldVdaurcPzqknwgwdUJN/
         p4SAibirxwwCYCCc07zrItnwvVCbjIc2YdE3k0mFBmm/7kvM1JOrwZV58Vkxg3Gn6ozB
         CjVQ==
X-Forwarded-Encrypted: i=1; AKwUvBxXpORd0wSJGOvEbuH2Sdac79B4BxoJrYOybwUWU8IFgsya8qfjjOEK8R4jZBxuw/H0KAIxlEM=@vger.kernel.org
X-Gm-Message-State: AFuF++l8VH4HPMXThGIO0VkNMCxtCoEuD/190E9c3+hK2rIY1rVQVYLy
	4NGZ5QVyFEb2/SoiD4QSl7K874e+j8AEqVSvu8P3G8n88DHYUO0whHm46po6dwUntA==
X-Gm-Gg: AYBFou0w+huvwSRMVla+1pX9V2R2JoSkRPBvw08UmjGSVXkNRWT0yKTCk1WO9pvQmm8
	DRQGdwAzCmCNT5sAIbJdz2qjcHOIvB6U30MuX583fk7GYft9qWuVrLJ6GY72ruOIZ2bL4kKmgRT
	YTGjCdqJE5P/SLiHK0P4ZDDQDkDNF4fjGOi7mlTIsviGR4kJ1Z2+wNR95eqedAR5nGaw2e/T5d5
	mEtdGq/bvXAmRH3BR9sjuNQ1ti+mPFWZOtqETwYy9ArVcCiU7WEV6UBLRPkA+2YTyqX7Y8Wgdc2
	Xanho9f0u/V/hHOa22Or25l1gpR/bnNbSrcxw+NSOT8Q+s9F7tl6D7WOLT8KX83CiP/qFyHRRRi
	OyNnoJUdf7+9dXwaDCbZm+DGKEUNeseADdIhsdpL4JIF0d/xP+wbhCL0ljqmfeo3KkC3z9Oz/RZ
	xOV3vyyNTnBHGT5/CdoeC0mNsgalwpwm2D+iu3zPkS4O95qtNtu2KPzHda4oQzOoC2PYLrE8Z23
	mlV27vlFOBeby1UWbjFwRjgfZg7XpPCq2fer2bxDEPez7iJ
X-Received: by 2002:a05:690c:e206:20b0:861:d742:8c1 with SMTP id 00721157ae682-86c4da2b5a1mr5004487b3.2.1788312443615;
        Tue, 01 Sep 2026 18:27:23 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-86c186d7370sm6729127b3.37.2026.09.01.18.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 18:27:23 -0700 (PDT)
Date: Tue, 1 Sep 2026 18:27:06 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, 
    Vlastimil Babka <vbabka@kernel.org>, 
    "Liam R . Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
    Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
    Matthew Wilcox <willy@infradead.org>, 
    Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/mlock: use the IRQ-safe accessor for NR_MLOCK in
 __munlock_folio()
In-Reply-To: <20260901180109.3797944-1-shakeel.butt@linux.dev>
Message-ID: <1ddfa7dc-2dd8-406d-8454-59a349972106@google.com>
References: <20260901180109.3797944-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 1 Sep 2026, Shakeel Butt wrote:

> NR_MLOCK is updated from interrupt context.  __free_pages_prepare() clears
> a stray PG_mlocked and adjusts NR_MLOCK, and a folio can reach it with the
> flag still set from a bio completion handler:
> 
>   __free_pages_ok+0x6af/0x7a0
>   <IRQ>
>   __bio_release_pages+0xde/0x260
>   __iomap_dio_bio_end_io+0x16e/0x1a0
>   blk_update_request+0x14b/0x3d0
>   blk_mq_end_request+0x18/0x30
>   blk_done_softirq+0x49/0x60
> 
> The folio gets there like this.  A MAP_SHARED file mapping is mlocked, so
> its page cache folios carry PG_mlocked, and an O_DIRECT write sourced from
> that mapping GUP-pins those same folios.  munlock() then runs
> mlock_vma_pages_range(), which clears VM_LOCKED before walking the page
> tables to munlock each folio.  A concurrent hole punch reaches the folio
> through the rmap (i_mmap_rwsem, not mmap_lock) and can land inside that
> window: __folio_remove_rmap() -> munlock_vma_folio() sees VM_LOCKED
> already clear, so it neither queues the folio on the mlock batch nor takes
> a reference, and the pte it clears makes the pending mlock_pte_range()
> walk skip the folio at its !pte_present() check.  filemap_remove_folio()
> then drops the page cache reference, leaving the bio's pin as the last
> one, released from the completion handler above.

I'm hardly ashamed to admit that I've not tried to digest
that paragraph. You're writing about the rare fallback cases when
PG_mlocked is cleared late, and unevictable_pgs_cleared incremented to
notify us of that defect: yes, I accept that might happen at interrupt
time, and so we ought not to take the __shortcut in __munlock_folio()
which you fix  below.

> 
> So __zone_stat_mod_folio() here needs interrupts disabled, not merely
> preemption, and __munlock_folio() has a path where they are not: when the
> folio has already been taken off the LRU by somebody else the function
> jumps straight to the counter update without taking the lruvec lock.  The
> read-modify-write of the per-CPU NR_MLOCK diff can then be interrupted by
> the softirq above, and one of the two decrements is lost, leaving Mlocked
> in /proc/meminfo permanently overstated.
> 
> Use zone_stat_mod_folio().  mod_zone_state()'s this_cpu_try_cmpxchg() is
> atomic against a same-CPU interrupt and retries, and on the path where the
> lruvec lock is held its cost is negligible next to the lock itself.
> 
> The UNEVICTABLE_PG* events are deliberately left on the __ accessors:
> they occupy different vm_event_states slots from the UNEVICTABLE_PGCLEARED
> that __free_pages_prepare() bumps, and nothing updates those two from
> interrupt context.
> 
> Fixes: 2fbb0c10d1e8 ("mm/munlock: mlock_page() munlock_page() batch by pagevec")
> Cc: <stable@vger.kernel.org>

Okay: just a wrong stat, but it ought to go back to 0, so Cc stable yes.

> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Hugh Dickins <hughd@google.com>

But I do think you (or Andrew :-) should include

Reported-by: syzbot+cd2073ee6d958a8d0fcd@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-mm/6a931c5a.08e933ee.dbf97.0093.GAE@google.com/

That was indeed reporting a different way to get a WARNING from this,
when offlining a CPU: but it should be acknowledged for bringing you
here, and we should tell syzbot it's fixed by this.

I've been trying to work out whether you're going to come back in a
day or two, changing the __count_vm_events() too: and had raised in
that thread the question of why lru_add_drain()'s __count_vm_events
were not also reported by syzbot; but now I can see
 * vm counters are allowed to be racy. Use raw_cpu_ops to avoid the
 * local_irq_disable overhead.
and realize that they're not a problem; so this looks complete, we
shouldn't need local_lock()ing in mlock_drain_remote() after all.

Thanks,
Hugh

> ---
>  mm/mlock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/mlock.c b/mm/mlock.c
> index efa6716e4dfb..39215a3eab1f 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -141,7 +141,7 @@ static struct lruvec *__munlock_folio(struct folio *folio, struct lruvec *lruvec
>  
>  munlock:
>  	if (folio_test_clear_mlocked(folio)) {
> -		__zone_stat_mod_folio(folio, NR_MLOCK, -nr_pages);
> +		zone_stat_mod_folio(folio, NR_MLOCK, -nr_pages);
>  		if (isolated || !folio_test_unevictable(folio))
>  			__count_vm_events(UNEVICTABLE_PGMUNLOCKED, nr_pages);
>  		else
> -- 
> 2.53.0-Meta
