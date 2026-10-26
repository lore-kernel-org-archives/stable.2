Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793021729;
	b=Jl5PE5USq2ufQsGKJ+UlwPko886zXnZLJPB5ayDydKFTguDtlkNxAYYKIWXZNRkcraWm
	 a1j7GmO2pr3nGk9DNdSCO4cSrq4GUtDJwOOwl3nFoemp+R8kTrr3NyvLKMTavPjyrj7R6
	 din75YoRjjuLck4R4gzzvCt40olOHOrT7whOjBjLSrGjtwogU8y5aGqesnLp6o5GV375O
	 W3Qw9v5O5EgBkpoSmkQU+BMQdNFH6lrLHgt+RpR+s818lkDAwnuop+0FtdvrPSX+19Y4x
	 IUbo3b7CtHic9Kbld4u7lF6BN+KHTMpSDbVtt5fS7K3xIMDV4rwZizyVBJGwdEiFa3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793021729;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=fF1MSlIiDQGJ99F7TNI4VCTjEmTKG6i+WR1t1FFhbBI=;
	b=J/CKEQk8KGY/etahYnapwik4/bIZ+W3ZCG5laSZYitOtN0UKp6Kk/5ZY8flZj0Ebd3iX
	 piT2G/NNhB1nbFlMhTjhulV4oxHW6eHGizItVR4/IHRXPzOU82hiQ7WY6YdLRYRB76rtM
	 Q8zLSINkNz3/b8TFRs+xZZXZDQvcjWcpOhJsxZVyGpH2pBLpSyWzv14/OA5qnqo2Hd9ZU
	 wgIiIfr1G6vAULuvzS/FKDnOfK6I+XM38eu0AlgTRn4uK+ysYDDVclGyGzar02Qw+z+77
	 pnxSFAWbGAaPPL8jjJOEv5ANJVmIp4EYwrJXORCxkNWA2WCY1lX37PGG3lG6BFxiQiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="h/TLgRu5";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D90606A31A;
	Mon, 26 Oct 2026 13:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h/TLgRu5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2691F01825;
	Mon, 26 Oct 2026 13:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793021728;
	bh=fF1MSlIiDQGJ99F7TNI4VCTjEmTKG6i+WR1t1FFhbBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h/TLgRu5RASOSvwGFj2fy9MGo8WWDBCVlDiEyi4EPZDWpJNEgoCCyigVUZsHlEzZA
	 E8++3x2xIsw1+TYBorLbgF8lmBv7YirSstDWz9WLhpFiutM61r7S8CVyco0RdOW0/1
	 O4ytovkDePgvRxA7DwUAIrgA/bdlUqEQXOUuEfHDORdjDF0pMbB8BINadAoKPuaRWn
	 6xfphyPAjr0ZNty3/GjfZH4aD1EmHVgFVGgZrfv4HfapHtmuBAc6dAhJFdxaQNVC55
	 lIyJbhG8Fr91pWLp4wDzH3rZRl5ZrG2cysi+7LYb/QNfCUO6s0s1lOdp8ghk6dfCeb
	 GHxySojtTy/Ug==
Date: Mon, 26 Oct 2026 13:35:23 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Suren Baghdasaryan <surenb@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH] fs/proc/task_mmu: fix missed VMAs when reading
 /proc/PID/maps and friends
Message-ID: <at8-42OwXk2z6-HB@gremlin>
References: <20261025-per_vma_maps-v1-1-c4eec45b9387@kernel.org>
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
In-Reply-To: <20261025-per_vma_maps-v1-1-c4eec45b9387@kernel.org>

Another note about this - we need to update the tests to actually add
something that can catch this. The selftests only check the last line of
one page and first of next, and latter always implies vma_iter_init() in
m_start() so it never tests the iterator actually being cached.

Obviously something for a follow-up.

On Sun, Oct 25, 2026 at 11:43:15AM +0100, David Hildenbrand (Arm) wrote:
> Reading /proc/PID/maps under per-VMA locks can skip continuously mapped
> address ranges during concurrent VMA splits or merges. This violates the
> guarantee in Documentation/filesystems/proc.rst:
>
>   "If there is something at a given vaddr during the entirety of the
>    life of the smaps/maps walk, there will be some output for it."

Right.

>
> lock_next_vma() reuses a tree iterator across calls under RCU. The iterator
> remembers the range of its last entry. When its node is replaced,
> mas_next_slot() walks the tree again at the last index of that range, then
> advances past the entry containing that index. If VMA boundaries changed,
> this can skip a range that has not been reported:
>
>  - A lookup finds [A, C), then mprotect() splits it into [A, B) and [B, C)
>    before vma_start_read() locks the first VMA. The reader reports [A, B),
>    but the iterator still covers [A, C). The next call starts from B yet
>    advances past C, omitting [B, C).
>
>  - The reader reports [A, B) and unlocks it. A concurrent mprotect() then
>    merges it with [B, C). On the next call, the iterator resumes at B - 1,
>    which now belongs to [A, C), and advances past C. Again, [B, C) is lost.

OK so the key thing here is that the _iterator_ is the issue.

Essentially what 'next' means changes depending on the state of the
tree. All very subtle.

I wonder whether we shouldn't have a vma_iter_next_after() or something
where you can specify the position you are at in terms of an address rather
than a node.

But that's one for a follow-up.

>
> Checking the mmap_lock sequence only within the next call misses writers
> that completed before that call began. Also, a NULL result is currently
> accepted without validation, so a race can terminate the walk early.

Ugh.

>
> Even a fresh lookup can skip a mapping. Suppose it finds a gap before
> [B, C). A writer inserts an adjacent VMA at the end of that gap, then
> merges it into [B, C), replacing the node. The lookup resumes at the old
> gap's last index, now inside the merged VMA, and steps past it. The
> original [B, C) remains mapped throughout. Repeating the forward lookup
> is insufficient: another merge can make it skip the same mapping again,
> returning the same later VMA or NULL.
>
> The fresh-lookup race also affects /proc/PID/smaps, numa_maps and
> smaps_rollup. Resetting the iterator after gathering each VMA's statistics
> does not prevent a merge during the next lookup. Fixing lock_next_vma()
> also prevents omitted entries and incomplete rollup statistics.
>
> Keep a saved sequence in the proc maps locking context and validate it
> before each lookup with mmap_lock_speculate_retry(). If it is even (no
> pending writer) and still matches, reuse both the iterator and the saved
> sequence. Otherwise, restart at from_addr and sample the current sequence
> before looking up the VMA. Only refresh the sample when resetting the
> iterator, so a writer between validation and the lookup cannot go
> undetected.

I think this bit is unnecessary, see below.

>
> The smp_rmb() in mmap_lock_speculate_retry() orders the previous lookup
> before rereading the sequence. It pairs with smp_wmb() in
> do_raw_write_seqcount_begin(), which separates the sequence increment in
> mmap_write_lock() from subsequent tree updates.

I'm glad this is at least abstracted :)

>
> Validate detected gaps (from_addr < vma->vm_start) and NULL from
> vma_next() against the sequence. If there were concurrent writes, use
> mas_walk() to check if the writer could have interfered with the range
> of interest. If the range is not empty, something interfered concurrently
> so we retry under mmap_lock. Checking for empty ranges avoids taking the
> mmap_lock just because an unrelated writer changed the sequence.
>
> Original fix generated by an LLM and sent by Josef Bacik in private.
>
> Fixes: 5631da56c9a8 ("fs/proc/task_mmu: read proc/pid/maps under per-vma lock")
> Fixes: ea3085dd7a4e ("fs/proc/task_mmu: read proc/pid/{smaps|numa_maps} under per-vma lock")
> Fixes: 0e985559d72a ("proc/task_mmu: read proc/pid/smaps_rollup under per-vma lock")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
> I neither understood nor liked the original LLM generated fix that was
> provided to me, and I (and codex) think it was incomplete. So I tried to
> come up with a better fix that avoids additional fallbacks to the mmap_lock
> while trying to keep it simple.
>
> I won't claim that I am now an expert on the code, or that this is the
> most elegant fix. It is quite complicated what we built ... too
> complicated. So if this goes into the wrong direction I'll be happy

Yep, I do think the VMA locking implementation is too complicated in general. I
did work to simplify the structure of the implementation at least so it was more
intelligible.

Hopefully with this and other fixes we get somewhere better.

I think we could do work to simplify the VMA iterators also.

> if someone else wants to take over ;)

I think we can make this a bit smaller. Patch attached.

But that incurs a perf penalty, so if not that, I also suggest some small
wrappers that de-duplicate and make things much clearer.

>
> I reproduced the races with /proc/PID/maps, and with this patch they are
> resolved. I did not manage to reproduce the races with the new
> smaps/smaps_rollup, but the races are slightly different and harder to
> trigger.
>
> There is the issue with seqcount overflows that Lorenzo is tackling. It
> probably interacts here as well? Likely, but that's an independent issue
> to resolve.

That impacts VMA seqcount, and this logic only touches mm seqcount so all
good (claude agrees...)

> ---
>  fs/proc/internal.h        |  1 +
>  fs/proc/task_mmu.c        |  6 +++--
>  include/linux/mmap_lock.h |  5 ++--
>  mm/mmap_lock.c            | 58 +++++++++++++++++++++++++++++++++++------------
>  4 files changed, 51 insertions(+), 19 deletions(-)
>
> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> index df873df9afc56..f3e846b574d79 100644
> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -386,6 +386,7 @@ struct mem_size_stats;
>  struct proc_maps_locking_ctx {
>  	struct mm_struct *mm;
>  	bool mmap_locked;
> +	unsigned int mm_wr_seq;
>  	struct vm_area_struct *locked_vma;
>  };
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index ee9fc2fd2b2fe..dc3adcffb6d9c 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -148,6 +148,7 @@ static void reset_lock_ctx(struct proc_maps_locking_ctx *lock_ctx)
>  {
>  	lock_ctx->locked_vma = NULL;
>  	lock_ctx->mmap_locked = false;
> +	lock_ctx->mm_wr_seq = UINT_MAX;

Kinda horrible to just have to know this needs to be odd etc.

>  }
>
>  static struct vm_area_struct *get_next_vma(struct proc_maps_private *priv,
> @@ -160,7 +161,8 @@ static struct vm_area_struct *get_next_vma(struct proc_maps_private *priv,
>  		return vma_next(&priv->iter);
>
>  	unlock_ctx_vma(lock_ctx);
> -	vma = lock_next_vma(lock_ctx->mm, &priv->iter, last_pos);
> +	vma = lock_next_vma(lock_ctx->mm, &priv->iter, last_pos,
> +			    &lock_ctx->mm_wr_seq);
>  	if (!IS_ERR_OR_NULL(vma))
>  		lock_ctx->locked_vma = vma;
>
> @@ -523,7 +525,7 @@ static struct vm_area_struct *query_vma_find_by_addr(struct proc_maps_locking_ct
>  	unlock_ctx_vma(lock_ctx);
>  	rcu_read_lock();
>  	vma_iter_init(&vmi, mm, addr);
> -	vma = lock_next_vma(mm, &vmi, addr);
> +	vma = lock_next_vma(mm, &vmi, addr, &lock_ctx->mm_wr_seq);

I think this is challenging to reason about.

But with the suggestion simplification we can avoid it.

Otherwise, it should probably be tied to the iterator to which it belongs, like:

	struct vma_rcu_iter {
		struct vma_iterator vmi;
		unsigned int mm_wr_seq;
	};

And pass that around instead, e.g. change the signature to:

struct vm_area_struct *lock_next_vma(struct mm_struct *mm,
		struct vma_rcu_iter *rvmi, unsigned long from_addr)

And have something like:

	static void vma_rcu_iter_init(struct vma_rcu_iter *rvmi,
			struct mm_struct *mm, unsigned long from_addr)
	{
		vma_iter_init(&rvmi->vmi, mm, from_addr);
		/* Set write-locked so initially treated as maybe changed. */
		rvmi->mm_wr_seq = UINT_MAX;
	}

>  	rcu_read_unlock();
>
>  	if (!vma)
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index 28e3696ce9ff3..e33d15ce6a876 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -511,12 +511,13 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
>   * Locks next vma pointed by the iterator. Confirms the locked vma has not
>   * been modified and will retry under mmap_lock protection if modification
>   * was detected. Should be called from read RCU section.
> + * *last_seq must initially be odd and is kept across calls.

It's quite odd to have callers need to know about this, feels like a leaked
abstraction.

>   * Returns either a valid locked VMA, NULL if no more VMAs or -EINTR if the
>   * process was interrupted.
>   */
>  struct vm_area_struct *lock_next_vma(struct mm_struct *mm,
> -				     struct vma_iterator *iter,
> -				     unsigned long address);
> +		struct vma_iterator *vmi, unsigned long from_addr,
> +		unsigned int *last_seq);
>
>  static inline void vma_assert_can_modify(struct vm_area_struct *vma)
>  {
> diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> index 2f94ee0fdee2a..0f3a4e0c5520d 100644
> --- a/mm/mmap_lock.c
> +++ b/mm/mmap_lock.c
> @@ -400,21 +400,50 @@ static struct vm_area_struct *lock_next_vma_under_mmap_lock(struct mm_struct *mm
>  	return vma;
>  }
>
> +static bool vma_range_is_empty(struct mm_struct *mm, unsigned long start,
> +		unsigned long last)

Be good to add an RCU assert (lockdep only). Yes, lock_next_vma() holds
the RCU lock over this but it also releases it at certain points and it
makes things clearer and zero cost.

> +{
> +	MA_STATE(mas, &mm->mm_mt, start, start);
> +
> +	return !mas_walk(&mas) && mas.last >= last;
> +}
> +
>  struct vm_area_struct *lock_next_vma(struct mm_struct *mm,
> -				     struct vma_iterator *vmi,
> -				     unsigned long from_addr)
> +		struct vma_iterator *vmi, unsigned long from_addr,
> +		unsigned int *last_seq)
>  {
>  	struct vm_area_struct *vma;
> -	unsigned int mm_wr_seq;
>  	bool mmap_unlocked;
>
>  	RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "no rcu read lock held");
>  retry:
> -	/* Start mmap_lock speculation in case we need to verify the vma later */
> -	mmap_unlocked = mmap_lock_speculate_try_begin(mm, &mm_wr_seq);
> +	/*
> +	 * Restart by address if a writer could have changed the cached range.
> +	 * The retry check's smp_rmb() orders the previous lookup before reading
> +	 * the sequence and pairs with smp_wmb() in do_raw_write_seqcount_begin().
> +	 *
> +	 * The vma_range_is_empty() checks below avoid unnecessary mmap_lock
> +	 * fallbacks.
> +	 */
> +	mmap_unlocked = !(*last_seq & 1);

If we keep this logic, this really has to be abstracted out, e.g.:

static bool mm_seq_is_write_locked(unsigned int mm_seq)
{
	/* By convention, odd means locked, even means unlocked. */
	return mm_seq & 1;
}

> +	if (!mmap_unlocked || mmap_lock_speculate_retry(mm, *last_seq)) {

This is pretty subtle, and the VMA lock code is confusing enough as it is.

So abstracting the speculate/retry bit would be helpful I think.

Maybe something like:

static bool vma_tree_maybe_changed(struct mm_struct *mm, unsigned int last_seq)
{
	/*
	 * Write lock held when sampled (VMA can change), or write lock acquired
	 *  + dropped since.
	 */
	return mm_seq_is_write_locked(last_seq) ||
		mmap_lock_speculate_retry(mm, last_seq);
}

/* Returns true if mmap write unlocked. */
static bool reset_walk_if_mmap_lock_dropped(struct vma_iterator *vmi,
		struct mm_struct *mm, unsigned long from_addr,
		unsigned int *last_seq)
{
	if (vma_tree_maybe_changed(mm, *last_seq)) {
		/* Reset walk and re-speculate. */
		vma_iter_set(vmi, from_addr);
		return mmap_lock_speculate_try_begin(mm, last_seq);
	}

	return true;
}

(Can return true at the end because the write lock can't be held at the
point of being sampled.)

Then this becomes the self-documenting:

	mmap_unlocked = reset_walk_if_mmap_lock_dropped(vmi, mm, from_addr, last_seq);

> +		vma_iter_set(vmi, from_addr);
> +		mmap_unlocked = mmap_lock_speculate_try_begin(mm, last_seq);
> +	}
> +

This seems like a bit of an over-optimisation for a fix, we can always
reintroduce it later.

Simpler I think to just keep the mmap_lock_speculate_try_begin() and
unconditionally perform the vma_iter_set().

Also easier to reason about. Better to reason that the vma iterator might be in
a questionable state, so just reset it.

Also eliminates adding last_seq + all the churn in the fix.

Patch suggestion attached below.


>  	vma = vma_next(vmi);
> -	if (!vma)
> -		return NULL;
> +	if (!vma) {
> +		/*
> +		 * There is no reason to fallback if there really isn't anything
> +		 * in the remaining range.
> +		 */
> +		if ((mmap_unlocked && !mmap_lock_speculate_retry(mm, *last_seq)) ||
> +		    vma_range_is_empty(mm, from_addr, ULONG_MAX))

Quite a lot packed into this single expression.

If the write lock is not held (VMA can't change) and it wasn't acquired and
dropped since last we checked, or, if when explicitly checking the range to
see if anything is left, stop.

It seems to amount to me to 'can we trust that vma_next() didn't just skip
us over stuff?'

With the vma_tree_maybe_changed() helper could be:

	if (!vma_tree_maybe_changed(mm, *last_seq) ||
	    vma_range_is_empty(mm, from_addr, ULONG_MAX))
		return NULL;

Which self-documents this.

Actually given the logic below you could have:

static bool should_traverse_range(struct mm_struct *mm,
		unsigned int last_seq, unsigned long from, unsigned long to)
{
	return vma_tree_maybe_changed(mm, last_seq) &&
		!vma_range_is_empty(mm, from, to);
}

Then this would simply be:

	if (!should_traverse_range(mm, *last_seq, from_addr, ULONG_MAX))
		return NULL;

> +			return NULL;
> +
> +		rcu_read_unlock();
> +		goto fallback;
> +	}
>  	vma = vma_start_read(mm, vma);
>  	if (IS_ERR_OR_NULL(vma)) {
> @@ -442,15 +471,14 @@ struct vm_area_struct *lock_next_vma(struct mm_struct *mm,
>  	 * it was not shrunk after we found it and another vma has not been
>  	 * installed ahead of it. Otherwise we might observe a gap that should
>  	 * not be there.
> +	 *
> +	 * If speculation fails, avoid taking the mmap_lock when a direct lookup
> +	 * confirms that the gap is empty.
>  	 */
> -	if (from_addr < vma->vm_start) {
> -		/* Verify only if the address space might have changed since vma lookup. */
> -		if (!mmap_unlocked || mmap_lock_speculate_retry(mm, mm_wr_seq)) {
> -			vma_iter_set(vmi, from_addr);
> -			if (vma != vma_next(vmi))
> -				goto fallback_unlock;
> -		}
> -	}
> +	if (from_addr < vma->vm_start &&
> +	    (!mmap_unlocked || mmap_lock_speculate_retry(mm, *last_seq)) &&
> +	    !vma_range_is_empty(mm, from_addr, vma->vm_start - 1))
> +		goto fallback_unlock;

Again a lot of stuff on the same line, and a lot of duplication.

With above could be:

	if (from_addr < vma->vm_start &&
	    should_traverse_range(mm, *last_seq, from_addr, vma->vm_start - 1))
	    goto fallback_unlock;

Which also self-documents.

So if the perf penalty for simplification is too much, this stuff can make
this a lot more understandable and avoid code duplication.

>
>  	return vma;
>
>
> ---
>
> base-commit: 21a7f44fd0765fcc5194130b28767786eba1d1e7
>
> change-id: 20261025-per_vma_maps-ceab0eb860d5
>
> --
>
> Cheers,
>
> David
>

The simplification eats the cost of a new tree traversal each time from
root (ugh).  It makes the fix a LOT simpler, but incurs (claude says)
13-17ns/VMA cost i.e. 10-25% of the per-line cost of reading
/proc/$pid/maps.

I think we care more about lock contention than raw /proc/$pid/maps
traversal time, however, so I'm not sure this matters.

In any case, an optimisation can be introduced with appropriate abstraction
as a follow-up, I think better to do the simpler-to-reason-about version as
the fix.

But if we are bothered about this, then it needs abstracting as suggested.

----8<----
From 2c87f4865b415b90b6b833b51323f2267d1a4f1f Mon Sep 17 00:00:00 2001
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Mon, 26 Oct 2026 12:11:21 +0000
Subject: [PATCH] simplification

---
 mm/mmap_lock.c | 47 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
index 83b7d3ded0dc..6568dda0aba4 100644
--- a/mm/mmap_lock.c
+++ b/mm/mmap_lock.c
@@ -428,6 +428,16 @@ static struct vm_area_struct *lock_next_vma_under_mmap_lock(struct mm_struct *mm
 	return vma;
 }

+static bool vma_range_is_empty(struct mm_struct *mm, unsigned long start,
+		unsigned long last)
+{
+	MA_STATE(mas, &mm->mm_mt, start, start);
+
+	RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "no rcu lock held");
+
+	return !mas_walk(&mas) && mas.last >= last;
+}
+
 struct vm_area_struct *lock_next_vma(struct mm_struct *mm,
 				     struct vma_iterator *vmi,
 				     unsigned long from_addr)
@@ -438,11 +448,29 @@ struct vm_area_struct *lock_next_vma(struct mm_struct *mm,

 	RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "no rcu read lock held");
 retry:
+	/*
+	 * No lock was held since the last call, so the iterator's cached range
+	 * may no longer be valid. Always restart by address.
+	 *
+	 * The vma_range_is_empty() checks below avoid unnecessary mmap_lock
+	 * fallbacks.
+	 */
+	vma_iter_set(vmi, from_addr);
 	/* Start mmap_lock speculation in case we need to verify the vma later */
 	mmap_unlocked = mmap_lock_speculate_try_begin(mm, &mm_wr_seq);
 	vma = vma_next(vmi);
-	if (!vma)
-		return NULL;
+	if (!vma) {
+		/*
+		 * There is no reason to fallback if there really isn't anything
+		 * in the remaining range.
+		 */
+		if ((mmap_unlocked && !mmap_lock_speculate_retry(mm, mm_wr_seq)) ||
+		    vma_range_is_empty(mm, from_addr, ULONG_MAX))
+			return NULL;
+
+		rcu_read_unlock();
+		goto fallback;
+	}

 	vma = vma_start_read(mm, vma);
 	if (IS_ERR_OR_NULL(vma)) {
@@ -470,15 +498,14 @@ struct vm_area_struct *lock_next_vma(struct mm_struct *mm,
 	 * it was not shrunk after we found it and another vma has not been
 	 * installed ahead of it. Otherwise we might observe a gap that should
 	 * not be there.
+	 *
+	 * If speculation fails, avoid taking the mmap_lock when a direct lookup
+	 * confirms that the gap is empty.
 	 */
-	if (from_addr < vma->vm_start) {
-		/* Verify only if the address space might have changed since vma lookup. */
-		if (!mmap_unlocked || mmap_lock_speculate_retry(mm, mm_wr_seq)) {
-			vma_iter_set(vmi, from_addr);
-			if (vma != vma_next(vmi))
-				goto fallback_unlock;
-		}
-	}
+	if (from_addr < vma->vm_start &&
+	    (!mmap_unlocked || mmap_lock_speculate_retry(mm, mm_wr_seq)) &&
+	    !vma_range_is_empty(mm, from_addr, vma->vm_start - 1))
+		goto fallback_unlock;

 	return vma;

--
2.56.0
