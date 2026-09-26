Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E19435507;
	Sat, 26 Sep 2026 12:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790427286; cv=none; b=qyJY6p+lVN9lbr/7OnbjcvHp9gsBK5+Csmfol7m8dJoClOOvooQG2ThTE5YdtdizL5Q9dMZut957wcPzBKlrfP18Fezl0vv+BEu3JgC5T6C7VkYAQh/GfnvLfYukvsaBRQ9Vjf4HpZgyihxJ4KWNwdN5/39bcN/DZCIRF5RsmOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790427286; c=relaxed/simple;
	bh=oNz6sell6XKOwLw0TDtcAFRmwEe1yrH4ncDfkV/vayY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y85Hfy6S+smS9zkoHaI4zOdBTMu/JopXbOY24DXIjwaX3i0xXyLTOE3AJVtDzalrNz3ZieEAg/5Ej+uO8G+gXB3BHcx23qkp+kqUyhL92iYBpqaU3XXW1F2YKmIb9CHCISmAL+YJeW12bCaZc4L5utDT1Fn0B+czT1ORk14EZCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=lIqGliNq; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="lIqGliNq"
Received: from omf14.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id AF45E160896;
	Sat, 26 Sep 2026 12:46:57 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 14D5532;
	Sat, 26 Sep 2026 12:46:50 +0000 (UTC)
Date: Sat, 26 Sep 2026 08:46:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Vineet Gupta <vineet.gupta@linux.dev>, mhiramat@kernel.org,
 mark.rutland@arm.com, mathieu.desnoyers@efficios.com, andrii@kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: fgraph: Raise FTRACE_RETSTACK_ALLOC_SIZE
 to 1024
Message-ID: <20260926084647.3685ae85@fedora>
In-Reply-To: <20260924100040.GD4121339@noisy.programming.kicks-ass.net>
References: <20260922225526.1554758-1-vineet.gupta@linux.dev>
	<20260922225526.1554758-2-vineet.gupta@linux.dev>
	<20260924100040.GD4121339@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: e1bao6t1cr5fu77wybj3uqnu9hyppfu9
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 14D5532
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+detvj2Mb+Uir/a8JKayUwPlIX+aqfpKA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=GOey0FkJywmjr6DnXdW757XDcEKE+vQJiVsQMU+r0d8=; b=lIqGliNqnjMEDUA15BokywbL6Uemv/GjVpc8UmoiZxKnMK3xlv6QlBgm1KEQnAA+lCVykoZhLXTsT3vzEHf4C7QAWu3Bdgb6amxW9omw061d6/3YBnWbrKFbmvNCuKamlJkTYTmWf0jVUuCxApDLEy4I0NnByHyhlSXg2pAAaQ8=
X-HE-Tag: 1790426810-931399
X-HE-Meta: U2FsdGVkX1/K9XxuXgRvlIpfTDDGDxRxFQCYlS5kemVW+V4Br8IotJW9C1NsQnLsLD0e8W3AvaNk7Ox9uVr6hTspzptgGu2WPJyAFIlJH8XitKFQOuku8j5z+vSq2xidnW+BYgnKn9gIXrLBn/f7d7eVdtW9F53TGWXpu2E+SVK+l+OVXAxfcBJBHVx25XT8jDcThU5uI+d7pZfTA5qIL7uWR/v0i8Uodmu/Caut/dknD9b9sulB7/HT+b1czHUFoWNU42neQ5uhlO2HVhWxk987I2wj/McCrGhKmk+JHtaQ06iDHU3B2vH9HooX3wE88GD+q6Kb/VYtRgbLLrek8DuWTjmBqp/Kz1RmSwY8zGAG5W5zqkYDaSbtKUNdx62l

On Thu, 24 Sep 2026 12:00:40 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> 
> Does this work?
> 
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index ed455b53513b..155dafad474d 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -1036,10 +1036,9 @@ trace_func_graph_ent_t ftrace_graph_entry = ftrace_graph_entry_stub;
>  /* Try to assign a return stack array on FTRACE_RETSTACK_ALLOC_SIZE tasks. */
>  static int alloc_retstack_tasklist(unsigned long **ret_stack_list)
>  {
> -	int i;
> -	int ret = 0;
>  	int start = 0, end = FTRACE_RETSTACK_ALLOC_SIZE;
>  	struct task_struct *g, *t;
> +	int i, ret = 0;
>  
>  	if (WARN_ON_ONCE(!fgraph_stack_cachep))
>  		return -ENOMEM;
> @@ -1054,26 +1053,29 @@ static int alloc_retstack_tasklist(unsigned long **ret_stack_list)
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
> +				if (start == end)
> +					return -EAGAIN;
> +				rs = ret_stack_list[start++];
> +			}

Yeah this is fine. This iteration code goes back to when function graph
was first added back in 2008. Back then, looping all tasks required
taking the task_list lock and I remember we didn't want to call
kmalloc() while holding that. This code could definitely use some
reassessment.

-- Steve


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

