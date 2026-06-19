Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAA0EADC;
	Fri, 19 Jun 2026 00:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781827969; cv=none; b=iXnU2TxcxXR0PHIsx4A2jR9y7ssWsXslFxOEsH/COdgAS2avEAJMmunL/Fk+K3Q9hGEDaQsERjPw1MYVSkaTEt7FgGEKIhSIrD/uHtKvR5bTidiTE/L3TrwgBpSjqLN/nwzPMDeS+w3F06tV0CszZzb7fbWavs1k4TRbW2OdxFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781827969; c=relaxed/simple;
	bh=bsBnTx3gl7TK2ctjlQyCNJnjbm9ANa7b5EunSHH50bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJ9O2JulE0oYaIx5BKmKzcLthxV8TM4nf6buTaXvbyVtldfkmZLF+5v9tRLxDYedU23AK9nhnpMJgWO50Ayhaqakl0tcPERVxdKYp9w987zt5Ptf2IRUo2izS8/5NWET2LCvtuFxv0yBRwVnVgqDE8AFUV1YroGndICEt9AD/1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=heLzk5JH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="heLzk5JH"
Received: from CPC-beaub-VBQ1L.localdomain (unknown [70.37.26.61])
	by linux.microsoft.com (Postfix) with ESMTPSA id EA65820B7167;
	Thu, 18 Jun 2026 17:12:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EA65820B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1781827966;
	bh=SSkIICZ8h1BSVDyzYNM7A9hhWoKXQKTBLXiqQHyHy20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=heLzk5JHGVm75LllzOIIYXkdSOvelqq4+CDBH40n+6KKlELEGW6rFGEeKiEV6LEcD
	 CO8nv8h5jMsNyIhh9Dwo3VyPtz57taFWl+/a8cvMgR4kSS0uw2kMzuj2MPUSyM0/SW
	 KsxwxJEw+Hvba7jx30OHS/1kFu9XyyIf+EsXWJ78=
Date: Fri, 19 Jun 2026 00:12:37 +0000
From: Beau Belgrave <beaub@linux.microsoft.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] tracing/user_events: fix use-after-free of enabler in
 user_event_mm_dup()
Message-ID: <20260619001237.GA844-beaub@linux.microsoft.com>
References: <20260618222743.538915-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618222743.538915-1-michael.bommarito@gmail.com>

On Thu, Jun 18, 2026 at 06:27:43PM -0400, Michael Bommarito wrote:
> user_event_enabler_destroy() removes an enabler from the per-mm
> mm->enablers list with list_del_rcu() and then frees it immediately with
> kfree(). That list is walked locklessly by user_event_mm_dup() during
> fork(), under rcu_read_lock() only:
> 
> 	rcu_read_lock();
> 	list_for_each_entry_rcu(enabler, &old_mm->enablers, mm_enablers_link)
> 		...
> 
> user_event_mm_dup() does not take event_mutex. The per-enabler destroy
> path user_events_ioctl_unreg() (DIAG_IOCSUNREG) takes event_mutex but
> nothing that excludes the dup walk. Threads that share an mm share one
> user_event_mm and one enabler list, so an unregister on one thread can
> free an enabler while another thread is forking and user_event_mm_dup()
> is mid-walk. The walk then dereferences the freed enabler (for example
> enabler->event in user_event_enabler_dup()).
> 
> This is reachable by an unprivileged task that can open user_events_data:
> a single multithreaded process that registers an enabler and then
> concurrently unregisters it and calls fork() triggers the race. KASAN
> reports a slab-use-after-free read in user_event_enabler_dup() called
> from user_event_mm_dup() and copy_process() during clone(); with
> kasan.fault=panic the kernel panics.
> 
> Free the enabler after a grace period with kfree_rcu(), matching the
> list_del_rcu() removal and the rcu_read_lock() readers in
> user_event_mm_dup(). Add an rcu_head to struct user_event_enabler for
> this. The error path in user_event_enabler_create() keeps using kfree()
> because that enabler is freed before it is published to the RCU list.
> 
> Cc: stable@vger.kernel.org
> Fixes: 7235759084a4 ("tracing/user_events: Use remote writes for event enablement")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> 
> Notes:
>     KASAN on the unpatched tree (v7.1, x86-64, CONFIG_KASAN=y, SMP):
>     
>       BUG: KASAN: slab-use-after-free in user_event_enabler_dup+0x50a/0x540
>       Read of size 8 (enabler->event, 16 bytes into a freed kmalloc-cg-64):
>         user_event_enabler_dup
>         user_event_mm_dup
>         copy_process
>         __do_sys_clone
>       Allocated by the registering task; freed on another CPU via the
>       DIAG_IOCSUNREG path. With kasan.fault=panic the access panics.
>     
>     After the patch the same reproducer runs cleanly (no splat, no panic)
>     across the full window, and a serialized control (same paths, no
>     concurrency) is clean on both stock and patched.
>     
>     Re-ran tools/testing/selftests/user_events on stock and patched, both
>     clean: abi_test pass:6/6, dyn_test pass:4/4, ftrace_test pass:6/6.
> 
>  kernel/trace/trace_events_user.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index c4ba484f7b38b..412ca1e3a40cf 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -109,6 +109,9 @@ struct user_event_enabler {
>  
>  	/* Track enable bit, flags, etc. Aligned for bitops. */
>  	unsigned long		values;
> +
> +	/* Defer free so RCU list readers (user_event_mm_dup) are safe. */
> +	struct rcu_head		rcu;
>  };
>  
>  /* Bits 0-5 are for the bit to update upon enable/disable (0-63 allowed) */
> @@ -404,7 +407,12 @@ static void user_event_enabler_destroy(struct user_event_enabler *enabler,
>  	/* No longer tracking the event via the enabler */
>  	user_event_put(enabler->event, locked);
>  
> -	kfree(enabler);
> +	/*
> +	 * The enabler is removed from an RCU-traversed list
> +	 * (user_event_mm_dup walks mm->enablers under rcu_read_lock only),
> +	 * so the backing memory must outlive a grace period.
> +	 */
> +	kfree_rcu(enabler, rcu);
>  }
>  
>  static int user_event_mm_fault_in(struct user_event_mm *mm, unsigned long uaddr,
> -- 
> 2.53.0

Thanks for fixing this!

Acked-by: Beau Belgrave <beaub@linux.microsoft.com>

Thanks,
-Beau
