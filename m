Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795545465;
	b=SBvb0gxn2rjCN+6mZoeh12GkkRdWvpWbcOwhtiFgMzJFmMLjbHAs8PoXW1JCbX5VJoc9
	 LTjeJiLnWrlKlJYF0dpi5tcoTY8E2awoj5Jcz19JPZvbMELhpaXlOxBHlYs8adZXCA2fG
	 1/xk2OgMhyETVJauNWP26CekCoWtgXzPKa854xtwcySgb7HYKp3NVfGXQHE3kFlVsBGnh
	 rR9ECODDxIoKCY1qFVSRiQszxa59C++bkm3ymu5jF9TDnK201AJENw8UBI8WKSgDtdj/e
	 l34fDpacSh+oUKjOsizN2Pf65b4LMsBilqkUYH6G2Tkun/Wg2cN8H59NYdAmi8ZWssQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795545465;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=1zoOCvzXXxSjQ7psF4Sy29PKoeBfrrhdMZ3HpFuOxUw=;
	b=O3TU7EzLeqk1jMXW8i2QkvqfSqBiV16F/Ci4LpAzBtTwqYt3/mDiduxM3L6OJ0Fn6MVj
	 LYGNd0aII7eAuk5Nhh0RoJGGbDhNrDr8pn2izSf2phEI6aB+lDFyEOeMUi2v6E40YdJW+
	 kuTyeIJuL2Qrb7hpdNQBm9v3eIL3lJmdFB5f4IhgN9le/xb1keVP1kfumLrix8ue9EdhT
	 Ta9aMIHShM4g240l3pVASCrcztyDWnAKEjQMR0pp+GEgbwLvTZoEFC8ozf2uG60pm+OB1
	 NXnaZXrzT58txn5Sp0ua6NBEf1zMnHD3q5B6SeOBff0dng5CPLn/k2JaQjYFUQA80gA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XV4ByG2X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC9D606A31E;
	Tue, 24 Nov 2026 18:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XV4ByG2X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913561F000CF;
	Tue, 24 Nov 2026 18:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795545464;
	bh=1zoOCvzXXxSjQ7psF4Sy29PKoeBfrrhdMZ3HpFuOxUw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XV4ByG2XuzrRqRUkVee62FtVwtGgTWPmdUBklGJb424G4LLlpAtHqrmXf6s0G3W+A
	 Q3NrSDu7uJHYRw5azuUfvjpsjI8bgbSorFLdlAJSfNw45tvlIcrrFVD38ufggAp4w8
	 VG2xL/O5+lREKTAZu+jda5NIwR8XVt8/6JgLaZR3gdh12O0AsG9v6faZj4zUQninYN
	 y20o4UKbarZ+wPITdIarifBBNF7cZx59m44UsYvivZPDArXuZD9cAyTxM9snwDeDsE
	 Y9lMggrHiyjs07iCopzSQIdIEd8e/bHVww0DWHMUVP++Ey2MvhqfafsQRlgjPWrhvP
	 H2JsNFWKnROiQ==
Message-ID: <5e26dc91-37e9-4c29-b88a-bb3a3358709c@kernel.org>
Date: Tue, 24 Nov 2026 19:37:38 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/vma: drop mm asynchronously in vma_start_read()
Content-Language: en-US
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, Kees Cook <kees@kernel.org>,
 David Hildenbrand <david@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>,
 Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>, Shakeel Butt
 <shakeel.butt@linux.dev>, Pedro Falcato <pfalcato@suse.de>,
 Jann Horn <jannh@google.com>, Puranjay Mohan <puranjay@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org
References: <20261124-vma-read-lock-mmdrop-async-v1-1-257f99f551de@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20261124-vma-read-lock-mmdrop-async-v1-1-257f99f551de@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/24/26 13:26, Lorenzo Stoakes (ARM) wrote:
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
> For the sake of a backported fix, retain this behaviour, however drop the
> RCU lock last and remove the now irrelevant comment.
> 
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: bee9ef4a40a2 ("bpf: switch task_vma iterator from mmap_lock to per-VMA locks")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/DN267JUKDRNS.2VMV07CQ58R4X@gmail.com/
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Given how it should be rare to actually drop the mm here, it should be fine.

Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

> ---
>  kernel/fork.c  | 16 ----------------
>  mm/internal.h  |  3 +++
>  mm/mmap_lock.c | 21 ++++++++++++++++++---
>  3 files changed, 21 insertions(+), 19 deletions(-)
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
> index 073c5125b424..28b387fe543a 100644
> --- a/mm/mmap_lock.c
> +++ b/mm/mmap_lock.c
> @@ -306,11 +306,10 @@ static struct vm_area_struct *vma_start_read(struct mm_struct *mm,
>  	 */
>  	other_mm = vma->vm_mm; /* use a copy as vma can be freed after we drop vm_refcnt */
>  
> -	/* __mmdrop() is a heavy operation, do it after dropping RCU lock. */
> -	rcu_read_unlock();
>  	mmgrab(other_mm);
>  	vma_refcount_put(vma);
> -	mmdrop(other_mm);
> +	mmdrop_async(other_mm);
> +	rcu_read_unlock();
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

