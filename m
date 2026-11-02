Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793644695;
	b=MPD0HaGAu2nlAJQ/kBwOk0ODdBQFm5Nx+EQ0Ir9ubxXfEnTsChKQFNUToBNcWAcxjReJ
	 GCmSfQZ3h2St8mevshCw/8DzhcPVLSdGpwlWFZDPg1JFk3Jg8g1xdX1hpbszdW2IEx8W2
	 Ws0b2GhSoUkUDUWRWuqlUh3v4WLtLzRcmeR3XpUO3DcI73kudfw9avHBQP1/CZlgZUqzn
	 3K+Sh61RLBJ0x74Dxgl7b2YZO/m5BewIAmvWGpfNKX2/w8PrCGonuE4q8FBkDmwAbGVIM
	 b3RCj8h80Wo5PjE2JM6ofjtYJRFYK7w8VQGdeughjNXwtRh+m8qbwnFv4aXd+vylLXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793644695;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=CvKjhSbJQ64yej8CMcvSWHlywJ3U5WGeaWL/y+D+TmE=;
	b=TED6hvqbRgKLjWIVfMPk+xYpyUx9aWjCSiTEbIxJAwVbG9sPcAMfgaDlVDaXNzPh2IgR
	 8zvNCpWn3xQjaQOTuaDJ7BZPiSrdJyafhBZYWPmsP2vHIvzlGBLIKjPwnbviwYvS1csUW
	 8ghZQAViqzb3QdYrU27fT4GZ4v218xxOjXfsGKMLgWNR54maPAnL0X3v6gFspNZbKmXjb
	 AlkPVSFmniz5bYEW/CBxLkGksRpBguarl2c20GIf76fV378ArprIWPQfB1xJ/iFM51Kzp
	 ebT0jCiVmBwes72J0igB0TJHIGa+dH6/aNJwO+nWXDpXQCCscieQAMA8fnEwGcjME5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gNFFt+gG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6251C606A324;
	Mon,  2 Nov 2026 18:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gNFFt+gG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3AA1F00A16;
	Mon,  2 Nov 2026 18:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793644694;
	bh=CvKjhSbJQ64yej8CMcvSWHlywJ3U5WGeaWL/y+D+TmE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=gNFFt+gGp1PdCFm2zN7wLPMeJh8eWhbYcmz0DA4ESe0Ejn6RWJXcXRwUqNHIugyfL
	 aOF/c92f3lq+deLdHuD+n91tEpZSseiPV6kENrQO6Mg+u0NMVm3c6S0Wbgm6VpuwvS
	 V4L+KjUd9yEVNM/Byh6VC47LNV1KmEOx/lLeyNWqIN7cffrxx/Zbtv/CvPTfbvGxxX
	 h6/okYy/ejX7pf7m3UKXJU+aKmh+a23tfQEiN1WuEClseE9/SkyTt3jcfQsWL38dN9
	 Bd/FUPkymq5dGRNDwt94Q3pxgGOQqV6rzCd/TsCd8/QpgvTta5MgsUH3FdLwBoCp6U
	 sLMUnC29XjXYw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 76756CE0B0B; Mon,  2 Nov 2026 10:38:14 -0800 (PST)
Date: Mon, 2 Nov 2026 10:38:14 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Marco Elver <elver@google.com>
Cc: Alexander Potapenko <glider@google.com>,
	Boqun Feng <boqun.feng@gmail.com>, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Kees Cook <kees@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] kcsan: Reset per-task KCSAN state on fork
Message-ID: <10162189-3057-4c84-8a23-056ad33d401e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261030145655.439579-1-elver@google.com>
 <b32fabb0-a9ee-4a9f-acd6-3511548a7f65@paulmck-laptop>
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
In-Reply-To: <b32fabb0-a9ee-4a9f-acd6-3511548a7f65@paulmck-laptop>

On Fri, Oct 30, 2026 at 09:37:41AM -0700, Paul E. McKenney wrote:
> On Fri, Oct 30, 2026 at 02:56:19PM +0000, Marco Elver wrote:
> > arch_dup_task_struct() copies the parent's task_struct verbatim, which
> > includes kcsan_ctx and kcsan_stack_depth; nothing reinitializes them for
> > the child.
> > 
> > With CONFIG_KCSAN_WEAK_MEMORY this leaks a live reorder_access: an
> > access whose simulated reordering is only valid until the parent returns
> > from the frame that performed it (tracked via kcsan_stack_depth and
> > cleared by __tsan_func_exit()). The child inherits both the entry and
> > the parent's stack depth, but never returns through the parent's frames,
> > so the entry is never invalidated and is replayed on every subsequent
> > check_access() of the child.
> > 
> > The most direct way to hit this is the copy itself: __tsan_memcpy()
> > runs check_access() on the destination before copying. If that access is
> > selected for a watchpoint, set_reorder_access() records it (ptr = the
> > child's task_struct, ip in arch_dup_task_struct()) in the parent's ctx,
> > and the memcpy then copies that entry into the child. For an idle task
> > created by fork_idle(), the stale access covers thread_info.flags, which
> > other CPUs frequently access, resulting in false positive reports and:
> > 
> >   WARNING: kernel/kcsan/report.c:344 at sanitize_stack_entries+0x120/0x12c
> >   Cannot find frame for arch_dup_task_struct+0x40/0x154 in stack trace
> >   ...
> >   Call trace:
> >    sanitize_stack_entries+0x120/0x12c (P)
> >    print_report+0x84/0x488
> >    kcsan_report_known_origin+0x14c/0x1ec
> >    kcsan_setup_watchpoint+0x578/0x864
> >    __kcsan_check_access+0x1ec/0x1f8
> >    do_raw_spin_lock+0xa4/0x1c4
> >    _raw_spin_lock+0x70/0x88
> >    rcutree_report_cpu_starting+0x1ac/0x4b8
> >    secondary_start_kernel+0xe8/0x28c
> >    __secondary_switched+0xc0/0xc4
> > 
> > Reset the child's KCSAN state in dup_task_struct() after the copy,
> > alongside the existing kcov/kmsan initializers.
> > 
> > Reported-by: Paul E. McKenney <paulmck@kernel.org>
> > Link: https://lore.kernel.org/all/97f6213a-1dec-494e-96d1-abe546bce993@paulmck-laptop/
> > Fixes: 69562e4983d9 ("kcsan: Add core support for a subset of weak memory modeling")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Marco Elver <elver@google.com>
> 
> Thank you, Marco!  I will be testing this over the weekend.

And the testing went well:

Tested-by: Paul E. McKenney <paulmck@kernel.org>

							Thanx, Paul

> > ---
> >  include/linux/kcsan.h | 10 ++++++++++
> >  kernel/fork.c         |  2 ++
> >  kernel/kcsan/core.c   | 13 +++++++++++++
> >  3 files changed, 25 insertions(+)
> > 
> > diff --git a/include/linux/kcsan.h b/include/linux/kcsan.h
> > index c07c71f5ba4f..c7e9d15dd7bd 100644
> > --- a/include/linux/kcsan.h
> > +++ b/include/linux/kcsan.h
> > @@ -13,6 +13,8 @@
> >  #include <linux/kcsan-checks.h>
> >  #include <linux/types.h>
> >  
> > +struct task_struct;
> > +
> >  #ifdef CONFIG_KCSAN
> >  
> >  /*
> > @@ -66,9 +68,17 @@ struct kcsan_ctx {
> >   */
> >  void kcsan_init(void);
> >  
> > +/**
> > + * kcsan_task_init - initialize KCSAN state of a new task
> > + *
> > + * @task: task to initialize; must have been copied from its parent already.
> > + */
> > +void kcsan_task_init(struct task_struct *task);
> > +
> >  #else /* CONFIG_KCSAN */
> >  
> >  static inline void kcsan_init(void)			{ }
> > +static inline void kcsan_task_init(struct task_struct *task) { }
> >  
> >  #endif /* CONFIG_KCSAN */
> >  
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 5ef413368912..62a096ca8dce 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -93,6 +93,7 @@
> >  #include <linux/compiler.h>
> >  #include <linux/sysctl.h>
> >  #include <linux/kcov.h>
> > +#include <linux/kcsan.h>
> >  #include <linux/livepatch.h>
> >  #include <linux/thread_info.h>
> >  #include <linux/kstack_erase.h>
> > @@ -986,6 +987,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
> >  
> >  	kcov_task_init(tsk);
> >  	kmsan_task_create(tsk);
> > +	kcsan_task_init(tsk);
> >  	kmap_local_fork(tsk);
> >  
> >  #ifdef CONFIG_FAULT_INJECTION
> > diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> > index a3aa5e5b039d..26755add7cdb 100644
> > --- a/kernel/kcsan/core.c
> > +++ b/kernel/kcsan/core.c
> > @@ -828,6 +828,19 @@ void __init kcsan_init(void)
> >  	}
> >  }
> >  
> > +void kcsan_task_init(struct task_struct *task)
> > +{
> > +	/*
> > +	 * dup_task_struct() copies the parent's kcsan_ctx, including a
> > +	 * reorder_access that is still live in the parent's frame.
> > +	 */
> > +	memset(&task->kcsan_ctx, 0, sizeof(task->kcsan_ctx));
> > +	task->kcsan_ctx.scoped_accesses = (struct list_head){ LIST_POISON1, NULL };
> > +#ifdef CONFIG_KCSAN_WEAK_MEMORY
> > +	task->kcsan_stack_depth = 0;
> > +#endif
> > +}
> > +
> >  /* === Exported interface =================================================== */
> >  
> >  void kcsan_disable_current(void)
> > -- 
> > 2.56.0.317.g454f8302e1-goog
> > 
