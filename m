Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795724902;
	b=z2hEQlyHJGZYayM1QhHFB/nvHXs1xFjVhdHupBD/pj+hx94vYUObAEhHWDFvHdKkj8FV
	 V57qTt1QvHtOIhMOQnZS3e+uq1QpEZfGFw6rNg7WoQ62o0Nluvp33opHF8EaSwWwuEu7H
	 cwINztyG0p18nKRGavR0bJ16WZAIDZeVfhGU+nOa6KlZei+l3c/jpLxATuUmfeLMpkSWd
	 b6/Vs5ZviYCHLsFrLZArlsjKrxlHHQionzkGNuZ472TZLqXaq4fB0jeXB0eZeelbkaq38
	 /rdk+wR+GKKlmHc+FlUHwZea1P6AeTjbJVEzlnn8ukRi7FbWRA2tnTpnc0AOTf8CcSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795724902;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=y+PZxCBsSa9CaPD1mxweKbYUrMjw4HQHJ4ZtYjAEGa8=;
	b=o8t/4ZC4xgQd02PqNSEdyMUEzf/A5+4qp1uITRmDe1s6IzZVFomWJUL1rQ4ucX2HY0Si
	 vOjKOnvsq2ngk6gCFFr1M+uMm/smv+gaSeJl2J+MYbmycOneR4EV2ylqzqB7HB1Pm+Zjq
	 VYJSj9mhAHNrv1snZ9kDSrld54QYYKvAq2uqbBWpwjURYGpBZu472+3Q2RfbJZFEVvRD4
	 WHlpra0ft8L7W8mJ57uPbHRalzIZnz35u+hQw02joPrbSgR0YANFgmdC0GUYrX/LDTDuB
	 1Zn4Kyk/WWvFGbvMekXfdW4wfW5C9qGdfu4Sd3viiwiMy+rJ+sVGxDIqp9gPGO7k2ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=SFw+Al6F;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADB6606A321;
	Thu, 26 Nov 2026 20:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9ADB6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=SFw+Al6F
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=y+PZxCBsSa9CaPD1mxweKbYUrMjw4HQHJ4ZtYjAEGa8=; b=SFw+Al6FlSMRL+KFWLN6+G3aW1
	rGeeoQojH84twShugOLsskqJ0kZzHYpcEdebm80H4xCeChVYAHnSNM6k7KT95ZDIvqUSXO2FZgxjG
	5ygr5vaNTbzURCs6K286zjkA0CAX2X7Me742aRJY9Y1A8u8mimmTmYfLgNQ3Ppmt9NhK4v09qB7w7
	sXyJJysxMP42R5N88/unub5bpAGyyhQwHvoS0MYE72PU+x+Q6+Mom+l0bSco0K+KIhRNqKs2LfE2x
	uFqD0VVEkY/X5asxOZOy66pOAtQGlkz+73HHzIxNWL9+O5uD1i2RJlxrsXokPhxhnDm9mHMiaiqhl
	NXOh0vOA==;
Received: from [38.23.173.23] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWg4i-0000000ESgO-0GDX;
	Thu, 26 Nov 2026 20:28:12 +0000
Date: Thu, 26 Nov 2026 15:28:08 -0500
From: "Liam R. Howlett" <liam@infradead.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Kees Cook <kees@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Pedro Falcato <pfalcato@suse.de>, Jann Horn <jannh@google.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Chris Mason <mason@kernel.org>, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/vma: drop mm asynchronously in vma_start_read()
Message-ID: <mhibvp7socozh4kdctbopbkpngta7a6mol3u57hly7cu35rgpo@s6yvqaq2dm5y>
References: <20261124-vma-read-lock-mmdrop-async-v2-1-8139b5cf24bb@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124-vma-read-lock-mmdrop-async-v2-1-8139b5cf24bb@kernel.org>

On 26/11/24 06:56PM, Lorenzo Stoakes (ARM) wrote:
> Commit bee9ef4a40a2 ("bpf: switch task_vma iterator from mmap_lock to
> per-VMA locks") open-codes a lock_next_vma() implementation that does
> roughly the same thing in bpf_iter_task_vma_find_next(), only without
> fallback to an mmap_lock.
> 
> This is because bpf_iter_task_vma_find_next() can be called from
> non-sleepable contexts.
> 
> However, lock_vma_under_rcu() gave no guarantee as to which contexts it is
> safe to be called from, and indeed it turns out this assumption is unsafe.
> 
> Since commit 9bbffee67ffd ("mm: fix a UAF when vma->mm is freed after
> vma->vm_refcnt got dropped"), this call chain is possible on x86:
> 
> lock_vma_under_rcu()
>   -> vma_start_read()
>     -> mmdrop()
>       -> __mmdrop()
>         -> mm_free_pgd()
>           -> pgd_free()
>             -> pgd_dtor()
>               -> spin_lock(&pgd_lock)
> 
> Thus, a plain spin_lock() can occur when lock_vma_under_rcu() is
> called. Since bpf_iter_task_vma_find_next() can be called in softirq
> context, this can deadlock, for example:
> 
> pgd_alloc()
>   -> spin_lock(&pgd_lock)
>     <softirq>
>     bpf_iter_task_vma_next()
>       -> lock_vma_under_rcu()
>         ...
> 	  -> spin_lock(&pgd_lock) [ DEADLOCK ]
> 
> Alexei Starovoitov also pointed out that a BPF program attached to
> trace_contention_end() can similarly cause a deadlock:
> 
>   pgd_alloc()
>     spin_lock(&pgd_lock)
>       queued_spin_lock_slowpath()
>         trace_contention_end()          <- pgd_lock is held
>           tp_btf/contention_end prog
>             bpf_iter_task_vma_next()
>               lock_vma_under_rcu()
>                 vma_start_read()
>                   mmdrop(other_mm)      <- last put takes pgd_lock again
> 
> Resolve the issue by having vma_start_read() use mmdrop_async() instead of
> mmdrop() so the work is deferred to a work queue.
> 
> Make mmdrop_async() an internal mm function, defined in mm/internal.h, to
> avoid abuse elsewhere (kernel/fork.c includes this header, so still retains
> access).
> 
> Commit 0b16f8bed19c ("mm: change vma_start_read() to drop RCU lock on
> failure") accounted for the fact that the RCU lock had to be dropped for
> this operation, which is no longer applicable.
> 
> Remove the now-defunct comment on the 'heavy operation', but leave
> examining that to a follow up.
> 
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: bee9ef4a40a2 ("bpf: switch task_vma iterator from mmap_lock to per-VMA locks")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/DN267JUKDRNS.2VMV07CQ58R4X@gmail.com/
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Acked-by: Pedro Falcato <pfalcato@suse.de>
> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Liam R. Howlett (Google) <liam@infradead.org>

> ---
> v2:
> * Put the rcu_read_unlock() back where it was, a follow-up can address
>   anything else here.
> 
> v1:
> https://lore.kernel.org/r/20261124-vma-read-lock-mmdrop-async-v1-1-257f99f551de@kernel.org
> ---
>  kernel/fork.c  | 16 ----------------
>  mm/internal.h  |  3 +++
>  mm/mmap_lock.c | 19 +++++++++++++++++--
>  3 files changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 5efceb8d58a7..4d5866c83481 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -744,22 +744,6 @@ void __mmdrop(struct mm_struct *mm)
>  }
>  EXPORT_SYMBOL_GPL(__mmdrop);
>  
> -static void mmdrop_async_fn(struct work_struct *work)
> -{
> -	struct mm_struct *mm;
> -
> -	mm = container_of(work, struct mm_struct, async_put_work);
> -	__mmdrop(mm);
> -}
> -
> -static void mmdrop_async(struct mm_struct *mm)
> -{
> -	if (unlikely(atomic_dec_and_test(&mm->mm_count))) {
> -		INIT_WORK(&mm->async_put_work, mmdrop_async_fn);
> -		schedule_work(&mm->async_put_work);
> -	}
> -}
> -
>  static inline void free_signal_struct(struct signal_struct *sig)
>  {
>  	taskstats_tgid_free(sig);
> diff --git a/mm/internal.h b/mm/internal.h
> index de4593b3e3b6..cc95019c7e4b 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1671,4 +1671,7 @@ static inline bool can_spin_trylock(void)
>  /* char-mem.c */
>  bool file_is_dev_zero(const struct file *file);
>  
> +/* mmap_lock.c */
> +void mmdrop_async(struct mm_struct *mm);
> +
>  #endif	/* __MM_INTERNAL_H */
> diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> index 073c5125b424..d28bbc3ba734 100644
> --- a/mm/mmap_lock.c
> +++ b/mm/mmap_lock.c
> @@ -306,11 +306,10 @@ static struct vm_area_struct *vma_start_read(struct mm_struct *mm,
>  	 */
>  	other_mm = vma->vm_mm; /* use a copy as vma can be freed after we drop vm_refcnt */
>  
> -	/* __mmdrop() is a heavy operation, do it after dropping RCU lock. */
>  	rcu_read_unlock();
>  	mmgrab(other_mm);
>  	vma_refcount_put(vma);
> -	mmdrop(other_mm);
> +	mmdrop_async(other_mm);
>  
>  	return NULL;
>  }
> @@ -560,6 +559,22 @@ void __mm_reset_vma_seqcounts(struct mm_struct *mm)
>  }
>  EXPORT_SYMBOL(__mm_reset_vma_seqcounts);
>  
> +static void mmdrop_async_fn(struct work_struct *work)
> +{
> +	struct mm_struct *mm;
> +
> +	mm = container_of(work, struct mm_struct, async_put_work);
> +	__mmdrop(mm);
> +}
> +
> +void mmdrop_async(struct mm_struct *mm)
> +{
> +	if (unlikely(atomic_dec_and_test(&mm->mm_count))) {
> +		INIT_WORK(&mm->async_put_work, mmdrop_async_fn);
> +		schedule_work(&mm->async_put_work);
> +	}
> +}
> +
>  #ifdef CONFIG_LOCK_MM_AND_FIND_VMA
>  #include <linux/extable.h>
>  
> 
> ---
> base-commit: 913390e679e23e3a45643028ee7f992889094051
> change-id: 20261124-vma-read-lock-mmdrop-async-ba417cd1c1f0
> 
> Cheers,
> -- 
> Lorenzo Stoakes (ARM) <ljs@kernel.org>
> 
