Received: from mta1.migadu.com (out-140.mta1.migadu.com [95.215.58.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C22395ACA
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 18:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788977880; cv=none; b=s63/gLTswIZv7pGwOTnXDp0Sf8eHecZyOrXtK5VlhUwQRzVqzE+aSU0cggRd5OAE/LFRH0svuhC4YmYuxM8eBGU0xt7u3Qdy2mjWJwhC2BAsSSaMpk5ZzQavI+TeP5RSNgPUCIvJtvbYFVBob3/LWzmKHA72WZUpXMDd5lYq6Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788977880; c=relaxed/simple;
	bh=a5KoTsru4QeX3ourrXoG/HiW8Ls4AkpUlsNfQy7SGEw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hatnBqtyuSiLhC+PvXOfLx4VE/0Cw+O7309hM6XGf3ypZrdkhM3sYm4/h4ANVt/H+7rqfT8K3is0mOUU7mGIYH1U7fsQOERh0Kd574NZ73qYJl9sN4fU5/Vs50/BrIJklq6h7JqyRvo38AalQ+NGxSbVjeh1A3wM3q1ghX91ALc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hPS3R6FZ; arc=none smtp.client-ip=95.215.58.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hPS3R6FZ"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=a5KoTsru4QeX3ourrXoG/HiW8Ls4AkpUlsNfQy7SGEw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788977874; v=1; x=1789582674;
 b=hPS3R6FZ/bOOovAHZdFzdDlRydNTo1aeniCMI93ZZ3l3di3ytdQSNkp6CtrVkq6Vokb2Bguj
 nzoZsN0pnHlW08e60iKem1Z54LqFa/w126jeUlLKhuxw1kcJoju02bcKMkrH5+TpgZqxdC4wrmg
 +U0bR5KujZanYeuzhuYaVtg8=
X-Envelope-To: stable@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 7a7c3fb00e682847;
	Wed, 09 Sep 2026 18:17:54 +0000
X-Mizu-Trace-ID: 7a7c3fb00e682847
X-Migadu-Flow: FLOW_OUT
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  David Hildenbrand
 <david@kernel.org>,  Lorenzo Stoakes <ljs@kernel.org>,  "Liam R. Howlett"
 <liam@infradead.org>,  Vlastimil Babka <vbabka@kernel.org>,  Mike Rapoport
 <rppt@kernel.org>,  Suren Baghdasaryan <surenb@google.com>,  Michal Hocko
 <mhocko@suse.com>,  Jan Kara <jack@suse.cz>,  Tejun Heo <tj@kernel.org>,
  Dennis Zhou <dennis@kernel.org>,  "Matthew Wilcox (Oracle)"
 <willy@infradead.org>,  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  bpf@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH] writeback: report a Tasks-RCU quiescent state per cgwb
 drain pass
In-Reply-To: <20260909-cgwb-tasks-rcu-qs-v1-1-967a7754771f@toxicpanda.com>
	(Josef Bacik's message of "Wed, 09 Sep 2026 18:01:07 +0000")
References: <20260909-cgwb-tasks-rcu-qs-v1-1-967a7754771f@toxicpanda.com>
User-Agent: mu4e 1.12.15; emacs 30.2
Date: Wed, 09 Sep 2026 18:17:45 +0000
Message-ID: <7ia4ik4ep9va.fsf@castle.c.googlers.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Josef Bacik <josef@toxicpanda.com> writes:

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

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!
