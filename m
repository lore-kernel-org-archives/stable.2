Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08F345D1BD;
	Thu, 24 Sep 2026 10:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790244058; cv=none; b=r//11qQYTCpN/aln+dLx8lwz7EgM50i/XRCn3WJWZcP0hZ55wpKV2fYKgL0aILwVFXH8E5wh91zJwrwAQHgFF46Je5AZaKWNV9fCdgvyHFtEfvg8Vr4qtATKu3SlQbtZfw8CqsqYR+C2Xodc0h7FcgnRL5l8Aw653T5s45Lh9iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790244058; c=relaxed/simple;
	bh=FFQYnczjBATsnDZ529OE5mhMgnVzXRtQTsOmc4nStHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSCpLgDx2uo2VC2PUDQ8GeBj4FsGAFI4vnf+UBVhQaFdMiggypFrnype7m8Tqs3SPeHAocnwmhK/rEvupahnaTlyDjJu7s0/iNRUtQFnphF9/eBJj2lIVxNxKvITlSsI7+g/WtF6DivTUxkKdtuQF9HrSHjONbE+DkvAD2g3xYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=L3+eDnBY; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L3+eDnBY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xt0MlUmSz2PI0Rs6KjVEiWXP3SZQmqgbE8xNOYhlUnA=; b=L3+eDnBYBrBBegfejLjGVQpoZv
	/m8mslbFtnH9L8vWjDaNeyXWjMY2P9g87gq/2DlbW6dgm5krE+axEuXWAEQV2AlfQpGYRKnDTmp92
	cjxKuQekxs8N4Um2Bc8KBI+DqKDG8AQj7skY2Z+kCuIj/TES9CPd4yTVx0CacEtesQsE1v+Buqzi5
	EtQwx51aV42yiPeg+dNdnQTFfyFh6znXD3qFAVfJtU2Kb1SCcK9JrICp7aTJz5Pj9AmqG3mceluQM
	8KxA9F1VmJFoDOudBJwMsSZcZAryBqXRjrQNAZk1/7kC091pkZ50wPz275IOnQ4vo4XkiuZy/WDQw
	MigtAWYw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x9gFt-0000000FoXH-3bW0;
	Thu, 24 Sep 2026 10:00:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A08433006DD; Thu, 24 Sep 2026 12:00:40 +0200 (CEST)
Date: Thu, 24 Sep 2026 12:00:40 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Vineet Gupta <vineet.gupta@linux.dev>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com, andrii@kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: fgraph: Raise FTRACE_RETSTACK_ALLOC_SIZE to
 1024
Message-ID: <20260924100040.GD4121339@noisy.programming.kicks-ass.net>
References: <20260922225526.1554758-1-vineet.gupta@linux.dev>
 <20260922225526.1554758-2-vineet.gupta@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922225526.1554758-2-vineet.gupta@linux.dev>

On Tue, Sep 22, 2026 at 03:55:25PM -0700, Vineet Gupta wrote:
> When ftrace graphing is turned on, all tasks in the system missing
> return stack page are assigned one. This is done in a simplistic
> multi-sweep loop of FTRACE_RETSTACK_ALLOC_SIZE (currently 32) tasks
> at a time as follows:
> 
>    start_graph_tracing()
> 	do {
> 		alloc_retstack_tasklist
> 	} while (-EAGAIN);
> 
>    alloc_retstack_tasklist()
> 	alloc x32           # GFP_KERNEL, may sleep
> 	rcu_read_lock()     # preempt off
> 		for_each_process_thread    walk N_total, no cond_resched
>                      t->ret_stack = new_page
> 	rcu_read_unlock()   # preempt enable but no explicit yield
> 
> Each successive iteration of loop invokes for_each_process_thread()
> which doesn't support cursor based resume and always restarts from the
> init_task. Thus each successive loop needs to skip the tasks assigned
> ret_stack in prior sweeps and thus take longer and longer to find the
> candidate 32 tasks. 

Does this work?

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index ed455b53513b..155dafad474d 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1036,10 +1036,9 @@ trace_func_graph_ent_t ftrace_graph_entry = ftrace_graph_entry_stub;
 /* Try to assign a return stack array on FTRACE_RETSTACK_ALLOC_SIZE tasks. */
 static int alloc_retstack_tasklist(unsigned long **ret_stack_list)
 {
-	int i;
-	int ret = 0;
 	int start = 0, end = FTRACE_RETSTACK_ALLOC_SIZE;
 	struct task_struct *g, *t;
+	int i, ret = 0;
 
 	if (WARN_ON_ONCE(!fgraph_stack_cachep))
 		return -ENOMEM;
@@ -1054,26 +1053,29 @@ static int alloc_retstack_tasklist(unsigned long **ret_stack_list)
 		}
 	}
 
-	rcu_read_lock();
-	for_each_process_thread(g, t) {
-		if (start == end) {
-			ret = -EAGAIN;
-			goto unlock;
-		}
+	scoped_guard (rcu) {
+		for_each_process_thread(g, t) {
+			unsigned long *rs;
+
+			if (t->ret_stack)
+				continue;
+
+			rs = kmem_cache_alloc(fgraph_stack_cachep, GFP_NOWAIT);
+			if (!rs) {
+				if (start == end)
+					return -EAGAIN;
+				rs = ret_stack_list[start++];
+			}
 
-		if (t->ret_stack == NULL) {
 			atomic_set(&t->trace_overrun, 0);
-			ret_stack_init_task_vars(ret_stack_list[start]);
+			ret_stack_init_task_vars(rs);
 			t->curr_ret_stack = 0;
 			t->curr_ret_depth = -1;
 			/* Make sure the tasks see the 0 first: */
-			smp_wmb();
-			t->ret_stack = ret_stack_list[start++];
+			smp_store_release(&t->ret_stack, rs);
 		}
 	}
 
-unlock:
-	rcu_read_unlock();
 free:
 	for (i = start; i < end; i++)
 		kmem_cache_free(fgraph_stack_cachep, ret_stack_list[i]);
