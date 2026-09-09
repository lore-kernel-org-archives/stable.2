Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809D42264CA;
	Wed,  9 Sep 2026 19:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980602; cv=none; b=ATW+hdEsvye8OKJKrK/ZHPYw0ItT6pqOXjpIXLHw/AOn5rJXTSmOsomLyXru2OetTr19ldS+2+9MtLyHzgXN2sogX36ehgySbPK+tIl1y4lWvRo3IYJ7AlPNoqn8zJ1iCAMrogKIKjChb5n3aaux2mJQhSYwE1HyUCMT8ku1j70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980602; c=relaxed/simple;
	bh=KUj61GVQi2NG5F49OI5FUGknSGFoptP8TIhmfzQfeTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcESwADVUBxSHuRf0glU997unuF4XTzTuvAMbUtizgrO1oK+8eGX1I089TUKP5dPVwPAX0lMtlMGPf0AK4+jq8l1bSCwRBXHKPuhfcdVMSIJ9zNLTZJceL455AxkptBeqHhBqFBCiQY4XXfE2MdeRH5cRtvh947agqpzpC/8hWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aADKDxRu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aADKDxRu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8991F000FF;
	Wed,  9 Sep 2026 19:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788980601;
	bh=AErWR7vucLM7Tga+zO6Gil5K2nYfIKbJaptyhsoLRXE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=aADKDxRumdTzR//o4YXfDT7LkMdzRDMU+xa47yvoTtTp8OE7XZcs/dZzoDOkO7+dJ
	 ah/VujNCccgP86+HXxrpKnnYRUHTg9zGWFlYyLcFWi3DR3E6YmZkaReH4EqthbJnFz
	 bFaC+N/N1Ijd8IaOtm8HWkg6FatUTvWKrl6jTw82yecUA3rSXWmPRRlFUfcJNJ0NBW
	 wI9AgYc8nQ5bN9CfGus6Uv2ZVxYVru+jWGmBPC2fZTsJSc8xc6LD/ez7/sRJzuVBGm
	 qjp0EzaVMCJ8dAm1OSUDBf5e+uw7bL26+EdUpJFXWO1oidxIMm2PTssGx2OqPxOSlX
	 OJnROI/qfpyWg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B05C7CE086B; Wed,  9 Sep 2026 12:03:20 -0700 (PDT)
Date: Wed, 9 Sep 2026 12:03:20 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>,
	Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <16d13239-8911-4597-bfd6-18aa02135137@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260909-cgwb-tasks-rcu-qs-v1-1-967a7754771f@toxicpanda.com>
 <aqGilhgcEd0qaHjI@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqGilhgcEd0qaHjI@slm.duckdns.org>

On Wed, Sep 09, 2026 at 08:16:54AM -1000, Tejun Heo wrote:
> (cc'ing Paul)
> 
> On Wed, Sep 09, 2026 at 06:01:07PM +0000, Josef Bacik wrote:
> > cleanup_offline_cgwbs_workfn() drains a dying cgwb by calling
> > cleanup_offline_cgwb() until it returns false, with a cond_resched()
> > between passes.  On a CONFIG_PREEMPTION kernel that cond_resched() does
> > nothing: _cond_resched() is a plain "return 0", and under
> > PREEMPT_DYNAMIC the full and lazy modes disable it.  Since commit
> > 7dadeaa6e851 ("sched: Further restrict the preemption modes") those are
> > the only two models on the architectures with PREEMPT_LAZY support,
> > arm64 and x86 among them, so the drain loop never reports a Tasks-RCU
> > quiescent state.
> > 
> > A worker draining a cgwb with millions of attached inodes runs for
> > minutes.  On a 6.18 arm64 host in lazy mode the cgwb worker drained one
> > dying cgroup's writeback domain for over 11 minutes.  A BPF program
> > unlink (bpf_trampoline_unlink_prog -> bpf_trampoline_update ->
> > unregister_ftrace_direct -> ftrace_shutdown -> synchronize_rcu_tasks())
> > waited on that grace period while holding the trampoline mutex, 42
> > tasks queued behind it in D state, and the hung task detector fired at
> > 614 s and panicked the host.  Any BPF or ftrace detach during a long
> > drain inherits the drain's length.
> > 
> > Fix this by calling cond_resched_tasks_rcu_qs() so we do not stall out
> > anybody who calls sycnrhonize_rcu_tasks().  We put this in a do { } while
> > loop because if we have many small cgroups cleanup_offline_cgwb() will
> > return false and we will never call cond_resched_tasks_rcu_qs(), creating
> > the same problem.
> > 
> > Fixes: c22d70a162d3 ("writeback, cgroup: release dying cgwbs by switching attached inodes")
> > Cc: stable@vger.kernel.org
> > Link: https://lore.kernel.org/bpf/9d444098-7c03-4163-af12-bd0a79a51443@paulmck-laptop/
> > Assisted-by: LLM
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> 
> > ---
> >  mm/backing-dev.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> > index cecbcf9060a6..18e999053bae 100644
> > --- a/mm/backing-dev.c
> > +++ b/mm/backing-dev.c
> > @@ -910,8 +910,9 @@ static void cleanup_offline_cgwbs_workfn(struct work_struct *work)
> >  			continue;
> >  
> >  		spin_unlock_irq(&cgwb_lock);
> > -		while (cleanup_offline_cgwb(wb))
> > -			cond_resched();
> > +		do {
> > +			cond_resched_tasks_rcu_qs();
> > +		} while (cleanup_offline_cgwb(wb));
> 
> The patch looks fine but this overall seems fragile. cond_resched() was
> already marking "stuff that can take too long" but we need to use
> cond_resched_tasks_rcu_qs() if it can take *really* long. There gotta be a
> way to make this more maintainable. If always doing tasks_rcu_qs from
> cond_resched() is too expensive, can it be be gated behind something cheaper
> e.g. some tick based test?

This is the business end of cond_resched_tasks_rcu_qs() in preemptible
kernels (in which cond_resched() is nothingness):

# define rcu_tasks_classic_qs(t, preempt)				\
	do {								\
		if (!(preempt) && READ_ONCE((t)->rcu_tasks_holdout))	\
			WRITE_ONCE((t)->rcu_tasks_holdout, false);	\
	} while (0)

This is pretty lightweight.  Adding a jiffies check would likely make
it more expensive.

Or am I missing your point?

							Thanx, Paul
