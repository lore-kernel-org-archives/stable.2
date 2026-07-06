Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB3E2701DC;
	Mon,  6 Jul 2026 14:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783349846; cv=none; b=jTXi4CIPY8m5sTlMwLvSqpLfhWQFnkzcpSCwF8UN/bB7KcgFuf1iGrXqIK6gBQ9any5lsjfEWBBcCPOhYgcp1UaNpSjTsuVuDbRmNNpdfqMH14sLuZJF9MLXrCMHlaPwyCLMBybe46Peh7VuUvobPDRwnO4f25KWPpGMT8Dq6Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783349846; c=relaxed/simple;
	bh=LAA4qWVnCC/SpR6bRRHW87rLHdrNT+nhJRGAscM+NiM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=urrkreTWy276Zzb6QOZGhFB8n08EcGvhnWx3586W/4Z0oltYABXQqgBJHzez0lGmAS4Et9g+o/9yBUYU4395/6u+nkNQShlK3Xh6EZ9dxl6Yn6oosXPiKdMwpbjzCVyZecitzl/qUIw4RPqJp0bvv4ocWCpbBYvxPHZRbQODNxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 88F92160FBA;
	Mon,  6 Jul 2026 14:57:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id EF6E417;
	Mon,  6 Jul 2026 14:57:14 +0000 (UTC)
Date: Mon, 6 Jul 2026 10:57:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Yuanhe Shu <xiangzao@linux.alibaba.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H . Peter Anvin"
 <hpa@zytor.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] x86/stacktrace: Mark arch_stack_walk() and unwinder
 functions notrace
Message-ID: <20260706105715.769ba488@gandalf.local.home>
In-Reply-To: <20260706095445.1683434-1-xiangzao@linux.alibaba.com>
References: <20260706095445.1683434-1-xiangzao@linux.alibaba.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: EF6E417
X-Stat-Signature: iitf39djh3mortxwxkq86eue6b3bpy57
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18rqGyHfpsRGsVI+iAO+GsZU/8T+xxEMog=
X-HE-Tag: 1783349834-194698
X-HE-Meta: U2FsdGVkX197Tep2RR2qfA4PEZs0l1tULf6JEJzzHABGv3FNxddOIVtPOtoE//LPdUhpuYpqlNq05jowOd9RE3orplMiiyPW0oJq6pvn1mLh5bEgKywBCNeVl81IqsYklCos7InQyy7k0lt84Gqv0qhWf1pQ8IfAsYfGnQlZeYmi+be0ZNcgOHUnawLuCXWZuBZA5v6g7lDHVTol5g7VS7tcgsrHR2fIGYsLnmMGf8DCiN0kO9MawfkgdES8tn1L0OjM3Wr+DNFFXoLAbl+/Z5ZGca78Hf6I6pttmZEBYBpY0nET3ST3/3wl3/EBbqRJzAGXpY37F3JXa1mT9B1zf7ZKeE7bNZJfOLVHmH6+AQLS4R3BTmngZGj0iXDy/cBYyOEXMMXw+yJwxUxIx8poXQ==

On Mon,  6 Jul 2026 17:54:45 +0800
Yuanhe Shu <xiangzao@linux.alibaba.com> wrote:

> When the function tracer's func_stack_trace option and the function graph
> profiler (function_profile_enabled) are both active, a recursive ftrace
> reentrance can occur, leading to a hard lockup. This was observed during
> ftrace selftest (ftracetest-ktap) execution:
> 
>   watchdog: Watchdog detected hard LOCKUP on cpu 204
>   RIP: profile_graph_entry+0xa0/0x160
>   Call Trace:
>    function_graph_enter+0xc9/0x120
>    arch_ftrace_ops_list_func+0x112/0x230
>    ftrace_call+0x5/0x44
>    unwind_next_frame+0x5/0x870     <-- traced by ftrace
>    arch_stack_walk+0x88/0xf0
>    stack_trace_save+0x4b/0x70
>    __ftrace_trace_stack+0x12e/0x170
>    function_stack_trace_call+0x7c/0xa0
>    arch_ftrace_ops_list_func+0x112/0x230
>    ftrace_call+0x5/0x44
>    irqtime_account_irq+0x5/0xb0
>    __irq_exit_rcu+0x12/0xc0
>    ...
> 
> The root cause is a recursive ftrace reentrance:
> function_stack_trace_call() invokes __trace_stack() ->
> arch_stack_walk() -> unwind_next_frame() to capture a backtrace.
> Since the unwinder functions (__unwind_start(),
> unwind_next_frame(), unwind_get_return_address(),
> unwind_get_return_address_ptr()) are not marked notrace, the
> function graph tracer instruments them, re-entering the ftrace
> infrastructure from within an ftrace callback. This results in a
> hard lockup with interrupts disabled, detected by the watchdog NMI.

I'm fine with this change, but I'm wondering why the recursion protection
didn't catch this. There may be a missing check somewhere. I'll ack this
change, but I also want to add the check that would have prevented this
lockup.

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve

