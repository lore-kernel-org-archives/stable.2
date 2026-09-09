Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517A239A057;
	Wed,  9 Sep 2026 18:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788977820; cv=none; b=rKC3vj+aT/AhpFz7cDJ80JR3BikmVoo270lzLu841rCEc+uPcBZ+rUx1FUibbZnmW0ePqtwWiJGp0Tye45gAwxZRo83cBcPTtiZJKvCArILEd4WkYhvMF+4WJDU45N1wF5ZjqOI5LkIZNiJaOzVGIPBT3AE9aTaOESIuut/tqqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788977820; c=relaxed/simple;
	bh=kXOctfXUltwhqjTzoFtLL3gVUi//FVz1XuWVTcVuNN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewZXILoY6r8KJmLlmqVafpOlv1VoQ7ZkpESMAO0ZRL6l1WfOBigkd3vCvYJIshsWySu1g1qPslAy8r1hAw8vw8dRI0J3vzfvVm2Smuhq9qXvbuNnLV15DEbMx4gLC1722Mq0jNGHnhak8Bh9/NzqS6X/pg1xYn/oqBV4WE+YhUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F84p0yyr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F84p0yyr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962401F00893;
	Wed,  9 Sep 2026 18:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788977815;
	bh=rmS7BNxOqmi+BeNsZ4oZ5oXHisCR+XOxA/iRVryaknE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F84p0yyrHbvT3bpXj+VWGL3evahoR6zG0wTE9+bL32gjOuuHYOcp5jRBCTbBmoesc
	 nUKlyiNo9zgpaA1uQE+puCh0ulCe9TAqCoBisChJDtgib1rgRlKWc7+knS+n4fuz4S
	 7nSvSwwxqSBsjpa10PXbYDQrFUAV4uGXkFkb2cegO3tPzaqvJNFR9GsDup3MBJdb/o
	 fei0wlIm+cnIeuSWoNfnkZ1S+pAZI84YMz6dsergpXxLlscYpxsi9ZysTp12TVyTtQ
	 b3Y46Ko+oZeGMBiX61KqHlpy4oI7w2IMj6zZPs5hTSlM2IzjYjJGpK1FxVMWDoLj8y
	 b9Pscs7SP3o2A==
Date: Wed, 9 Sep 2026 08:16:54 -1000
From: Tejun Heo <tj@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Dennis Zhou <dennis@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] writeback: report a Tasks-RCU quiescent state per cgwb
 drain pass
Message-ID: <aqGilhgcEd0qaHjI@slm.duckdns.org>
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

(cc'ing Paul)

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
> 
> A worker draining a cgwb with millions of attached inodes runs for
> minutes.  On a 6.18 arm64 host in lazy mode the cgwb worker drained one
> dying cgroup's writeback domain for over 11 minutes.  A BPF program
> unlink (bpf_trampoline_unlink_prog -> bpf_trampoline_update ->
> unregister_ftrace_direct -> ftrace_shutdown -> synchronize_rcu_tasks())
> waited on that grace period while holding the trampoline mutex, 42
> tasks queued behind it in D state, and the hung task detector fired at
> 614 s and panicked the host.  Any BPF or ftrace detach during a long
> drain inherits the drain's length.
> 
> Fix this by calling cond_resched_tasks_rcu_qs() so we do not stall out
> anybody who calls sycnrhonize_rcu_tasks().  We put this in a do { } while
> loop because if we have many small cgroups cleanup_offline_cgwb() will
> return false and we will never call cond_resched_tasks_rcu_qs(), creating
> the same problem.
> 
> Fixes: c22d70a162d3 ("writeback, cgroup: release dying cgwbs by switching attached inodes")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/bpf/9d444098-7c03-4163-af12-bd0a79a51443@paulmck-laptop/
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Acked-by: Tejun Heo <tj@kernel.org>

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

The patch looks fine but this overall seems fragile. cond_resched() was
already marking "stuff that can take too long" but we need to use
cond_resched_tasks_rcu_qs() if it can take *really* long. There gotta be a
way to make this more maintainable. If always doing tasks_rcu_qs from
cond_resched() is too expensive, can it be be gated behind something cheaper
e.g. some tick based test?

Thanks.

-- 
tejun
