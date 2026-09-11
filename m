Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B206049EC71;
	Fri, 11 Sep 2026 16:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789142922; cv=none; b=NGv85Dqbankz2uYGay2Y9IqR+1Y5pELwAvEPLhyo1PrI0yRaXEqXeW0/39FGPUD7q+/qd+9UumQFsck0Eqg+5C0zcjzMEjLxbIs1yPQyp8wq+rm6uo7LesvqLGLmJQGlWVzbCW6z/ZlNhPqKgd7iulvjcmQwLmV0aG2A33UDrZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789142922; c=relaxed/simple;
	bh=41a7MW2ibJiO5eDWOwshyo2zSrDT85hQBMNpsVfBD2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwA4TRiqbR417F0iCppHOSSK9Vk5iqQK5cXHoCzf7hkSsyKl4C2KG0+Hd0CQB2g9IC8Suk/4DFCD17yTpDhd0K2fLJ95tvZb4G8bW3E+Rr2H7iuSb1BAOHl1BFHm6pQe+PvFg6jLT89vVfeJt9AT5fegLnEXPfj5wt1NFH3huDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/7De1Zj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/7De1Zj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 273A51F000FF;
	Fri, 11 Sep 2026 16:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789142920;
	bh=xnCshcIoWhJMLbbpjD+kSB2RQWWN3gtcsfG9Qvmj05c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N/7De1ZjCZaLOY85gfXq7OouuwJ8uDEexXhtxrc9S5HqY0Wtv3bRFUg+Z0AXlvBNJ
	 usTMbaKC1mB1d8KqQkBj7/v5i8T+WnlVxNrRWSnqe1o7+Zj+eo2+TPq7vOWA4oHqFD
	 NrhiyNLPlF7+2HkWdQaYCuC7x/v/RQGdDA3iKNjAsgfEksb3y8k1qM4HJe2edezKPl
	 u6SJnN2GHgQWa3t1cEMi62NfXqPd+xSpWbnTYL8F5LryK/saDWM/d9Dh5vHNGc1rKO
	 ARtVinN/r7z1HjZ5frK4sYk+D0qBIvB0LzyJGLbdQylVDZID+enlWwwYQ4tV8mXbmJ
	 nPpCx8dkBIqsw==
Date: Fri, 11 Sep 2026 17:08:32 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>, 
	Tejun Heo <tj@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Dennis Zhou <dennis@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	stable@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>
Subject: Re: [PATCH] writeback: report a Tasks-RCU quiescent state per cgwb
 drain pass
Message-ID: <aqQb_Jzl--8So9p_@gremlin>
References: <20260909-cgwb-tasks-rcu-qs-v1-1-967a7754771f@toxicpanda.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-cgwb-tasks-rcu-qs-v1-1-967a7754771f@toxicpanda.com>

+cc cgroup guys + paulmcr for rcu aspect + willy, pedro for fs stuff

On Wed, Sep 09, 2026 at 06:01:07PM +0000, Josef Bacik wrote:
> cleanup_offline_cgwbs_workfn() drains a dying cgwb by calling
> cleanup_offline_cgwb() until it returns false, with a cond_resched()
> between passes.  On a CONFIG_PREEMPTION kernel that cond_resched() does
> nothing: _cond_resched() is a plain "return 0", and under
> PREEMPT_DYNAMIC the full and lazy modes disable it.  Since commit
> 7dadeaa6e851 ("sched: Further restrict the preemption modes") those are
> the only two models on the architectures with PREEMPT_LAZY support,
> arm64 and x86 among them, so the drain loop never reports a Tasks-RCU
> quiescent state.

Hmm, I thought that for all intents and purposes cond_resched() was unimportant
and something we wanted to get rid of or it was silly to use?

So it seems very strange that it's so critical here.

I think there's probably a bigger algorithmic issue underlying this.

And I don't think cond_resched() is really relevant here:

Looking at my RCU notes it says that [rcu_tasks_kthread] polls and snapshots all
CPUs which have undergone _voluntary_ rescheduling, and quiescent state is
determined by that.

It tracks holdouts and then at 100-200ms it forces a context switch for those
holdouts.

But AFAIU cond_resched() isn't a _voluntary_ context switch from task RCU's
point of view.

So this whole bit is just wrong I think.

It's more so that no voluntary context switch occurs in a context where task RCU
is all you have for RCU.

Also actually I think the comment on cond_resched_rcu_qs() is out of date:

/**
 * cond_resched_tasks_rcu_qs - Report potential quiescent states to RCU
 *
 * This macro resembles cond_resched(), except that it is defined to
 * report potential quiescent states to RCU-tasks even if the cond_resched()
 * machinery were to be shut off, as some advocate for PREEMPTION kernels.
 */

Commit bde6c3aa9930 ("rcu: Provide cond_resched_rcu_qs() to force quiescent
states in long loops") references reluctance to 'instrument' cond_resched().

So it was provided as a means of actually achieving what you need here in a long
loop.

Paul - I think maybe it's worth updating this? And maybe even renaming it? :)

>
> A worker draining a cgwb with millions of attached inodes runs for
> minutes.  On a 6.18 arm64 host in lazy mode the cgwb worker drained one
> dying cgroup's writeback domain for over 11 minutes.  A BPF program

That really sounds like something bigger is broken here... why is so much queued
up by this point with no voluntary context switches to clear any of it down?

> unlink (bpf_trampoline_unlink_prog -> bpf_trampoline_update ->
> unregister_ftrace_direct -> ftrace_shutdown -> synchronize_rcu_tasks())
> waited on that grace period while holding the trampoline mutex, 42
> tasks queued behind it in D state, and the hung task detector fired at
> 614 s and panicked the host.  Any BPF or ftrace detach during a long
> drain inherits the drain's length.

Yikes...

>
> Fix this by calling cond_resched_tasks_rcu_qs() so we do not stall out
> anybody who calls sycnrhonize_rcu_tasks().  We put this in a do { } while
> loop because if we have many small cgroups cleanup_offline_cgwb() will
> return false and we will never call cond_resched_tasks_rcu_qs(), creating
> the same problem.

So I think this looks fine as an immediate, backportable fix.

But I think we need to look deeper into the real cause here.

I've not looked at the writeback code for a while, and am certainly not au-fait
with the cgroup side of it, so asking the LLM:

" - fs/fs-writeback.c:726 isw_prepare_wbs_switch() walks b_attached from the
    head on every pass. Inodes already marked I_WB_SWITCH stay on the old wb's
    list until the consumer moves them at fs/fs-writeback.c:465.

  - Each pass isolates at most about 120 inodes, per fs/fs-writeback.c:269, but
    revisits every already-prepared inode, each costing cgroup_writeback_pin()
    plus an i_lock round trip at fs/fs-writeback.c:624, all under wb->list_lock
    with preemption disabled.

  - The consumer at fs/fs-writeback.c:616 does a synchronize_rcu() per wave, so
    the producer outruns it and the rescans grow. With millions of inodes that
    is quadratic, and it explains minutes of CPU-bound worker time without any
    preemption-mode change.

  A follow-up that makes the producer wait for in-flight switches, or that has
  cleanup_offline_cgwb() resume from where it stopped, would fix both the
  runtime and the Tasks-RCU stall. "

So this DEFINITELY needs some follow up attention I think.

Anyway for the fix as written, it seems sensible and the right way to
immediately address this, so:

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

>
> Fixes: c22d70a162d3 ("writeback, cgroup: release dying cgwbs by switching attached inodes")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/bpf/9d444098-7c03-4163-af12-bd0a79a51443@paulmck-laptop/
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  mm/backing-dev.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index cecbcf9060a6..18e999053bae 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -910,8 +910,9 @@ static void cleanup_offline_cgwbs_workfn(struct work_struct *work)
>  			continue;
>
>  		spin_unlock_irq(&cgwb_lock);
> -		while (cleanup_offline_cgwb(wb))
> -			cond_resched();
> +		do {
> +			cond_resched_tasks_rcu_qs();
> +		} while (cleanup_offline_cgwb(wb));
>  		spin_lock_irq(&cgwb_lock);
>
>  		wb_put(wb);
>
> ---
> base-commit: 893e11787f78e43b534e252249ac3fff4d1333f8
> change-id: 20260909-cgwb-tasks-rcu-qs-42341609f3e1
>
> Best regards,
> --
> Josef Bacik <josef@toxicpanda.com>
>

--
Cheers, Lorenzo
