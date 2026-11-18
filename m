Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795027318;
	b=EoEw+xCTm5Ic7RgO/Sw37WlJfkt245pzcqrF8GyOi252abTPE1Cb/CNWAx+X5JS1m/Sq
	 Xk1zI6Hw16YTZQlTpQmJN4Fr1UP+7WfmHDVa08FpRPmxDqMxz/dxBJZHIRNCV9TWFxNNn
	 VBRKAi+NPAnPQW2KoRsQdKY3vXBE9sidmiWalg4d5CLtF7P3izFxBVaBSS68fA7sdi0ri
	 iWIAVHZWiYtIWHilFrSusy4qyL2N6yXccTWJ8fcPS5NJiDR1tfuYYPuxYPurEnZE2HuVb
	 8st4FqmsiLj0KEqh+N0KNyIqkpo8LJcDZ6zYHCzO45LvmiTA9sYwrAyD/zlZhPdvcGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795027318;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=spjX/AP+q48PaOrXYRssOriUKxZG5CEsdblcdLqAMNA=;
	b=iM7SgVqg/RA2pdQUTKHcDDC27jge9HsDVlyJeKkua00evYauqPGqrackJZMQl2O1nG74
	 1eHj6qvIfoNUnxXvZGNeWZ+AgX7Nw+1pkR0kOzRtCLQitcVYi8wKt5UBbs+Exb6J6BJes
	 xfOZ4dNRq8kzX73ErFK/pXK33CFysIh6EU64rHz8B6X192F3QbN4E0D1hdQQtTDlmvIUc
	 WaseqfuPSrKbUNrxx3tV+PgXE+klY/K95QgzLw/QGIlGC/l/RL90W+Ol1y9j+CkTLzFwN
	 1i1r+0UiUMTm645j3him1jHUh+qEJegcefLElEyjW65pRuWIfZ2QF5UqwEV52lem6aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=KAQnh+6l;
	arc=none smtp.remote-ip=216.40.44.16
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCFF606A338;
	Wed, 18 Nov 2026 18:41:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDCFF606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=KAQnh+6l
Received: from omf11.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id DC508C0854;
	Wed, 18 Nov 2026 18:41:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id C2E3320029;
	Wed, 18 Nov 2026 18:41:47 +0000 (UTC)
Date: Wed, 18 Nov 2026 13:41:46 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 co+bba0c6b49150bef3@bugs.sh, Xiang Mei <xmei5@asu.edu>,
 stable@vger.kernel.org
Subject: Re: [PATCH 1/2] ftrace: Wait for graph readers before releasing
 operations
Message-ID: <20261118134146.3577fcad@gandalf.local.home>
In-Reply-To: <20261103175832.3374540-1-bestswngs@gmail.com>
References: <20261103175832.3374540-1-bestswngs@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: C2E3320029
X-Stat-Signature: 7s4gj4buybzgq1fkstuqfg57qojonwt3
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19XrPjGFbL7NhknHsEsWmykqf4O1VC3d2s=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=spjX/AP+q48PaOrXYRssOriUKxZG5CEsdblcdLqAMNA=; b=KAQnh+6lRo99s81nk3jTg59Dy38EX/msxPLzbjDnFRaG6E2xJ+PjlWkiuhrBBAtfrV8RI7nQ8U0zoNsVlJxqDByq/jU2v29cqSvQzdhzuImFdeVaZtK+I9PloWK2Jl7V9j5cgJKPS45RnbD3LlvcL+Fnu+bYFCrtFtDjKMnK2wY=
X-HE-Tag: 1795027307-44282
X-HE-Meta: U2FsdGVkX187V8teZLv/nwiP+uWPrXw3ueZ5JdZdR1zaQDQ/DMZWDFYtNFqZA58Pm+7h7MUyZnSeW6X2zV4DvmGJxMdsS5JrZAoPJDGxZ5ARmUPa+OvTJpu8A03uJ4Ay7abqVYaQI0H2GDSiWwm16KxbcKaeCHCWyMYcW2durbWtvvNQ3WhJZwrmb6EJU7Ov2oOrOUnAMHYvw8Ewxj5UajWSrkfaJfpj3LEwwpPYlJOZ+sONVsPo9ih3Tsten9CoNc/ih/eolyAi2GgbBlGiLjZPiEt0D0gNKgzIVO4YTm49UEpqHFPHKsMRU9QmYQB1DUanNBhXIrsoDIKMB1rzC2PJivZz2t7uklJwxTiJKMCs+L5lCVYOcw==

On Tue,  3 Nov 2026 09:58:30 -0800
Weiming Shi <bestswngs@gmail.com> wrote:

> unregister_ftrace_graph() removes an operation from the graph array before
> returning. A graph callback may already hold the operation or its filter,
> however, while the caller can release them as soon as unregistration
> completes.
> 
> This can happen without a hash update failure. For example, consider three
> graph operations with identical filters where one also enables PID
> filtering. Removing that operation leaves the manager hashes unchanged, so
> an in-flight fgraph_pid_func() may call gops->saved_func after unregister
> has cleared it.

Can you give an actual example of the above? That is, show command lines
that could possibly create the scenario.

Because honestly, the above is very confusing.

> 
> Graph callbacks run with preemption disabled and may run while RCU is not
> watching.

This is no longer the case. All function tracing should now have RCU watching.

> Separate removing the operation from graph dispatch from waiting
> for callbacks that may still be using it. Keep unregister_ftrace_graph()
> synchronous by performing both steps, and require internal users of the
> split interface to pair every successful removal with a reader wait.
> 
> For fprobes, unpublish the graph operation and release its slot
> synchronously, then queue the reader waits and filter release. This keeps
> the waits out of unregister_fprobe_async(). Flush the work before reusing
> the shared graph operation.
> 
> Disable fprobe return dispatch before unpublishing the operation and check
> that state inside the callback's RCU critical section. Re-enable dispatch
> only after graph registration succeeds, so a return callback cannot use a
> released fprobe while cleanup is pending.
> 

The above is 100% AI generated and not parseable by humans. Please rewrite.

> Cc: stable@vger.kernel.org
> Fixes: df3ec5da6a1e ("function_graph: Add pid tracing back to function graph tracer")
> Reported-by: <co+bba0c6b49150bef3@bugs.sh>
> Assisted-by: LLM
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>  kernel/trace/fgraph.c          | 47 +++++++++++++++++++++++++++++++---
>  kernel/trace/fprobe.c          | 21 ++++++++++++---
>  kernel/trace/ftrace_internal.h |  2 ++
>  3 files changed, 62 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index ed455b535..14733f519 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -1420,13 +1420,26 @@ int register_ftrace_graph(struct fgraph_ops *gops)
>  	return ret;
>  }
>  
> -void unregister_ftrace_graph(struct fgraph_ops *gops)
> +/**
> + * unregister_ftrace_graph_start - unpublish a function graph operation
> + * @gops: graph operation to remove
> + *
> + * Remove @gops from graph dispatch, release its array slot, and update the
> + * graph and subop state. Existing graph callbacks may still be using @gops
> + * after this returns.
> + *
> + * Return: true if @gops was unpublished. The caller must then invoke

What do you mean by "published" and "unplublished". I don't use that
terminology in ftrace.

> + * unregister_ftrace_graph_finish() exactly once before releasing @gops or its
> + * filter, even if the subop hash update failed.
> + */
> +bool unregister_ftrace_graph_start(struct fgraph_ops *gops)
>  {
>  	int command = 0;
> +	bool removed = false;
>  
>  	if (WARN_ONCE(!(gops->ops.flags & FTRACE_OPS_FL_GRAPH),
>  		      "function graph ops unregistered without registering"))
> -		return;
> +		return false;
>  
>  	guard(mutex)(&ftrace_lock);
>  
> @@ -1440,7 +1453,8 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
>  	if (fgraph_lru_release_index(gops->idx) < 0)
>  		goto out;
>  
> -	fgraph_array[gops->idx] = &fgraph_stub;
> +	WRITE_ONCE(fgraph_array[gops->idx], &fgraph_stub);
> +	removed = true;
>  
>  	ftrace_graph_active--;
>  
> @@ -1460,7 +1474,32 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
>  		unregister_pm_notifier(&ftrace_suspend_notifier);
>  		unregister_trace_sched_switch(ftrace_graph_probe_sched_switch, NULL);
>  	}
> -	gops->saved_func = NULL;
>   out:
>  	gops->ops.flags &= ~FTRACE_OPS_FL_GRAPH;
> +	return removed;
> +}
> +
> +/**
> + * unregister_ftrace_graph_finish - wait for readers of an unpublished operation
> + * @gops: graph operation previously unpublished by unregister_ftrace_graph_start()
> + *
> + * Wait for existing graph readers, then clear the saved callback. This may
> + * sleep. The caller may release @gops and its filter after this returns.
> + */
> +void unregister_ftrace_graph_finish(struct fgraph_ops *gops)
> +{
> +	/*
> +	 * The graph callbacks run with preemption disabled and may run while
> +	 * RCU is not watching. Wait for both kinds of readers before the

This is no longer correct.

-- Steve


> +	 * caller can release the graph ops or its filter.
> +	 */
> +	synchronize_rcu_tasks_rude();
> +	synchronize_rcu_tasks();
> +	gops->saved_func = NULL;
> +}
> +
> +void unregister_ftrace_graph(struct fgraph_ops *gops)
> +{
> +	if (unregister_ftrace_graph_start(gops))
> +		unregister_ftrace_graph_finish(gops);
>  }
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index da286619c..c53ad37a0 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -14,9 +14,11 @@
>  #include <linux/rhashtable.h>
>  #include <linux/slab.h>
>  #include <linux/sort.h>
> +#include <linux/workqueue.h>
>  
>  #include <asm/fprobe.h>
>  
> +#include "ftrace_internal.h"
>  #include "trace.h"
>  
>  #define FPROBE_IP_HASH_BITS 8
> @@ -279,6 +281,14 @@ static struct fgraph_ops fprobe_graph_ops = {
>  static int nr_fgraph_fprobes;
>  /* Is fprobe_graph_ops registered? */
>  static bool fprobe_graph_registered;
> +static void fprobe_graph_cleanup_workfn(struct work_struct *work);
> +static DECLARE_WORK(fprobe_graph_cleanup_work, fprobe_graph_cleanup_workfn);
> +
> +static void fprobe_graph_cleanup_workfn(struct work_struct *work)
> +{
> +	unregister_ftrace_graph_finish(&fprobe_graph_ops);
> +	ftrace_free_filter(&fprobe_graph_ops.ops);
> +}
>  
>  /* Add @addrs to the ftrace filter and register fgraph if needed. */
>  static int fprobe_graph_add_ips(unsigned long *addrs, int num)
> @@ -286,6 +296,7 @@ static int fprobe_graph_add_ips(unsigned long *addrs, int num)
>  	int ret;
>  
>  	lockdep_assert_held(&fprobe_mutex);
> +	flush_work(&fprobe_graph_cleanup_work);
>  
>  	ret = ftrace_set_filter_ips(&fprobe_graph_ops.ops, addrs, num, 0, 0);
>  	if (ret)
> @@ -297,7 +308,7 @@ static int fprobe_graph_add_ips(unsigned long *addrs, int num)
>  			ftrace_free_filter(&fprobe_graph_ops.ops);
>  			return ret;
>  		}
> -		fprobe_graph_registered = true;
> +		WRITE_ONCE(fprobe_graph_registered, true);
>  	}
>  	return 0;
>  }
> @@ -305,9 +316,9 @@ static int fprobe_graph_add_ips(unsigned long *addrs, int num)
>  static void __fprobe_graph_unregister(void)
>  {
>  	if (fprobe_graph_registered) {
> -		unregister_ftrace_graph(&fprobe_graph_ops);
> -		ftrace_free_filter(&fprobe_graph_ops.ops);
> -		fprobe_graph_registered = false;
> +		WRITE_ONCE(fprobe_graph_registered, false);
> +		if (unregister_ftrace_graph_start(&fprobe_graph_ops))
> +			schedule_work(&fprobe_graph_cleanup_work);
>  	}
>  }
>  
> @@ -679,6 +690,8 @@ static void fprobe_return(struct ftrace_graph_ret *trace,
>  	ret_ip = ftrace_regs_get_instruction_pointer(fregs);
>  
>  	guard(rcu_sched_notrace)();
> +	if (!READ_ONCE(fprobe_graph_registered))
> +		return;
>  
>  	curr = 0;
>  	while (size_words > curr) {
> diff --git a/kernel/trace/ftrace_internal.h b/kernel/trace/ftrace_internal.h
> index 3235470e6..abb7776a2 100644
> --- a/kernel/trace/ftrace_internal.h
> +++ b/kernel/trace/ftrace_internal.h
> @@ -52,6 +52,8 @@ static inline int ftrace_shutdown_subops(struct ftrace_ops *ops, struct ftrace_o
>  
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>  extern int ftrace_graph_active;
> +bool unregister_ftrace_graph_start(struct fgraph_ops *gops);
> +void unregister_ftrace_graph_finish(struct fgraph_ops *gops);
>  # ifdef CONFIG_DYNAMIC_FTRACE
>  extern void fgraph_update_pid_func(void);
>  # else

