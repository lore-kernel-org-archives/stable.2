Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A777A1D416C;
	Tue, 29 Sep 2026 23:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790725584; cv=none; b=e/9v84vGCp3oud/T53Gqd9AnjP8uSKi1HR9uInNot1WxyGbMo6oLEgGrOdHcRuKVCiD4OQtBOo+hL3luiMGKwxlkUOaj6objG0RnsdJxD/9p3fEytUCiI0DImRaHPV0zFyTVRwoIf1KbzNed4PgJlHUimxp0qyVOzwSf3XNlBJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790725584; c=relaxed/simple;
	bh=LRq4vU2UaNtO/ieQAH8HDx9+750FfkGFV8Zr+vB8jWw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=X+4N43FUROXPisi8e4+5L9Xfaxkcq+OnfoHpQS2/07JsgyP11ZSfSyDr0IwGrExQnic90x44o3AiBX0TzZdeHuaeTL65CWnfdNmV76bV9DSIt8CPn/DpgOpaYFSTlNZSxkxMmCXEQ9BbOGoxdcuUv8JL0dpRorhS73j9Qh4/e+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etKZjUUL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etKZjUUL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783C01F000FF;
	Tue, 29 Sep 2026 23:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790725582;
	bh=eUgBSVCxg479HmVb1My7cssnKyEELh39OZi+wobzssQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=etKZjUULIUryUFPFnSFpQgqe7lgC025pLBPcfJBgF7EIj6RaQUqZQ9lhv5XN8CyaA
	 +yX9+Emy+4optmeHZfwi3fDFg1Aa7/+1YBXdwQ2Ckg948/SfDYt2Awk/2GMKWHoiYh
	 /LtK9tB+/lO6D/tmanLNFiHlETt9k7+MYxFBAZFt/4aFeAcFUDnwhDcEUe6KV8stEN
	 JJmS8poo2aZDL13MgKszUJdqFmnsOWFoD8teIhI0mr2KHBTJDtraL8SUnDeFRt0By7
	 O4jmVK4ksdsABn2xdPjH1ny3i0pgiS5DQagH3NU2493hELsyE8ZJU0D1eXGYSXNsd6
	 T3NVyX0leAAnw==
Content-Type: multipart/mixed; boundary="===============5723665362160622272=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2dc04cf6f1e0c474da152cb4afcd0e264930b4d1d9b969de1b7cfbdd50b1bd35@mail.kernel.org>
In-Reply-To: <20260929005411.4105448-2-vineet.gupta@linux.dev>
References: <20260929005411.4105448-2-vineet.gupta@linux.dev>
Subject: Re: [PATCH v2 1/1] tracing: fgraph: allocate shadow stacks inline with GFP_NOWAIT
From: bot+bpf-ci@kernel.org
To: vineet.gupta@linux.dev,rostedt@goodmis.org,mhiramat@kernel.org
Cc: mark.rutland@arm.com,mathieu.desnoyers@efficios.com,andrii@kernel.org,peterz@infradead.org,linux-trace-kernel@vger.kernel.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,kernel-team@meta.com,vineet.gupta@linux.dev,stable@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 29 Sep 2026 23:46:21 +0000 (UTC)

--===============5723665362160622272==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index ed455b53513b..336f40dc6618 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -1036,10 +1036,9 @@ trace_func_graph_ent_t ftrace_graph_entry = ftrace_graph_entry_stub;
>  /* Try to assign a return stack array on FTRACE_RETSTACK_ALLOC_SIZE tasks. */
>  static int alloc_retstack_tasklist(unsigned long **ret_stack_list)
>  {

Does this comment still match the function's behavior? Before the patch,
alloc_retstack_tasklist() assigned at most FTRACE_RETSTACK_ALLOC_SIZE
stacks per call and returned -EAGAIN to trigger another batch. After the
patch, it walks every thread in one pass, allocating inline with
GFP_NOWAIT. The FTRACE_RETSTACK_ALLOC_SIZE pre-allocated entries are now
only a fallback when GFP_NOWAIT fails, and in the normal case they're all
freed at the free: label.

> -	int i;
> -	int ret = 0;
>  	int start = 0, end = FTRACE_RETSTACK_ALLOC_SIZE;
>  	struct task_struct *g, *t;
> +	int i, ret = 0;
>
>  	if (WARN_ON_ONCE(!fgraph_stack_cachep))
>  		return -ENOMEM;
> @@ -1054,26 +1053,37 @@ static int alloc_retstack_tasklist(unsigned long **ret_stack_list)
>  		}
>  	}
>
> -	rcu_read_lock();
> -	for_each_process_thread(g, t) {
> -		if (start == end) {
> -			ret = -EAGAIN;
> -			goto unlock;
> -		}
> +	scoped_guard (rcu) {
> +		for_each_process_thread(g, t) {
> +			unsigned long *rs;
> +
> +			if (t->ret_stack)
> +				continue;
> +
> +			rs = kmem_cache_alloc(fgraph_stack_cachep, GFP_NOWAIT);
> +			if (!rs) {
> +				/*
> +				 * Returning from inside scoped_guard() drops
> +				 * the RCU read lock, but skips the free loop
> +				 * below. That is only safe because start ==
> +				 * end here, which leaves that loop nothing to
> +				 * free. Keep the two in step if this
> +				 * exhaustion check ever changes.
> +				 */
> +				if (start == end)
> +					return -EAGAIN;
> +				rs = ret_stack_list[start++];
> +			}
>
> -		if (t->ret_stack == NULL) {
>  			atomic_set(&t->trace_overrun, 0);
> -			ret_stack_init_task_vars(ret_stack_list[start]);
> +			ret_stack_init_task_vars(rs);
>  			t->curr_ret_stack = 0;
>  			t->curr_ret_depth = -1;
>  			/* Make sure the tasks see the 0 first: */
> -			smp_wmb();
> -			t->ret_stack = ret_stack_list[start++];
> +			smp_store_release(&t->ret_stack, rs);
>  		}
>  	}
>
> -unlock:
> -	rcu_read_unlock();
>  free:
>  	for (i = start; i < end; i++)
>  		kmem_cache_free(fgraph_stack_cachep, ret_stack_list[i]);


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36644771324
--===============5723665362160622272==--
