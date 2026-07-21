Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56D23B6C05;
	Tue, 21 Jul 2026 20:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784665973; cv=none; b=onkkl/mH9POsdNdWRwR6q0iPc8uTNlzv8A9dllz0atGYt7tKmJUg3RpeX6tvIPCBEJ1bEPO0YbKfDYUAt6iwmD6EyyGPt5a65kdVI82Caq67i/2xYnvQe5U/WLEHpiMA4naxLqlVcaLj5OZAJBcSbpcX6oeCUU1PG0U56xQ5fC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784665973; c=relaxed/simple;
	bh=1+h4zq1AG+7urr50BUxWAny/4AJktyEULCT72ovDebw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M0qlvFjfuuJNLIRjxv5m1CU7BvkTkwuz9guFPwBwZ21ZJsSXXdcemBSbMBQEl6fu6t4zPjd67KxGFu/O6Xcq2ZqlTuMOE/Tl3qhslTrH3sOb3aqp4gKGeW0E1hHEq5P3PmriA0C+YFMOPricsDYBD6fNUhuYJbpiFc+aUU1F/rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id A5A16C0234;
	Tue, 21 Jul 2026 20:32:43 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id B706420029;
	Tue, 21 Jul 2026 20:32:40 +0000 (UTC)
Date: Tue, 21 Jul 2026 16:32:59 -0400
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
Message-ID: <20260721163259.07621992@gandalf.local.home>
In-Reply-To: <20260706105715.769ba488@gandalf.local.home>
References: <20260706095445.1683434-1-xiangzao@linux.alibaba.com>
	<20260706105715.769ba488@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 5fp9ood6eym3qq79x4rya5n9gz7axt4t
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: B706420029
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX188vQwmYwjFUT2xnIWRpbnYgXhyeZZEof0=
X-HE-Tag: 1784665960-299532
X-HE-Meta: U2FsdGVkX1+xWd2kIUO6mU/GFTQIGyAoIwPAaMsBBG40+CBVvdi7rzxu9z1BYK/t8SvYR9agYl7qvzUngksENEy3HB7ZS6fqR9CQ9csh1AOGo75fGChv3fmoKuA9+0T1p/MtST0x+w0kbE7wK1z25P3gWpYaQA3yF7kbCXfBn0vv7J6eC/HGkxfeygZ6bpWm701+kk8br1BfnIkEhMJm6ksYmZVwbGwtb+PXExrz/rznMRiW9xcBCMd1voF3RLzN+38nWB2Aqydu1t6DpsNuwPtN+kna4CMfliUQ3VIqXNOeZyj49i7IOqmZ+h5glIil5tXWi719u3WTGmpcTuy69lIKN2VdAlk/ZRz8vwizp2wblxXWm1TawSU2GVskGJxTliknvEAnG/BSLUhC97gMDQ==

On Mon, 6 Jul 2026 10:57:15 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon,  6 Jul 2026 17:54:45 +0800
> Yuanhe Shu <xiangzao@linux.alibaba.com> wrote:
> 
> > When the function tracer's func_stack_trace option and the function graph
> > profiler (function_profile_enabled) are both active, a recursive ftrace
> > reentrance can occur, leading to a hard lockup. This was observed during
> > ftrace selftest (ftracetest-ktap) execution:
> > 
> >   watchdog: Watchdog detected hard LOCKUP on cpu 204
> >   RIP: profile_graph_entry+0xa0/0x160
> >   Call Trace:
> >    function_graph_enter+0xc9/0x120
> >    arch_ftrace_ops_list_func+0x112/0x230
> >    ftrace_call+0x5/0x44
> >    unwind_next_frame+0x5/0x870     <-- traced by ftrace
> >    arch_stack_walk+0x88/0xf0
> >    stack_trace_save+0x4b/0x70
> >    __ftrace_trace_stack+0x12e/0x170
> >    function_stack_trace_call+0x7c/0xa0
> >    arch_ftrace_ops_list_func+0x112/0x230
> >    ftrace_call+0x5/0x44
> >    irqtime_account_irq+0x5/0xb0
> >    __irq_exit_rcu+0x12/0xc0
> >    ...
> > 
> > The root cause is a recursive ftrace reentrance:
> > function_stack_trace_call() invokes __trace_stack() ->
> > arch_stack_walk() -> unwind_next_frame() to capture a backtrace.
> > Since the unwinder functions (__unwind_start(),
> > unwind_next_frame(), unwind_get_return_address(),
> > unwind_get_return_address_ptr()) are not marked notrace, the
> > function graph tracer instruments them, re-entering the ftrace
> > infrastructure from within an ftrace callback. This results in a
> > hard lockup with interrupts disabled, detected by the watchdog NMI.  
> 
> I'm fine with this change, but I'm wondering why the recursion protection
> didn't catch this. There may be a missing check somewhere. I'll ack this
> change, but I also want to add the check that would have prevented this
> lockup.

I tried to reproduce it, but it appears to be a case where things slow down
so much that it triggers a lockup when it's not really locked up, but is
moving so slow that the watchdog triggers.

The recursive protection *is* working, but it still allows one recursion to
take place (there's an unrelated reason for that). Thus what we have is
that every time the function profiler does a stack trace, the function
tracer recurses the unwind functions and it too does a stack trace. This
just slows things down a lot more.

With CONFIG_FTRACE_RECORD_RECURSION enabled, I get the following:

  # echo 1 > /sys/kernel/tracing/function_profile_enabled
  # trace-cmd start -p function -l 'unwind_*' --func-stack
  # cat /sys/kernel/tracing/recursed_functions
 __unwind_start+0x3c3/0x7e0:     unwind_next_frame+0x4/0x2220
 arch_stack_walk+0xb7/0x100:     unwind_get_return_address+0x4/0xe0


Thus unwind_next_frame and unwind_get_return_address both had recursion
from just tracing functions that started with "unwind_". It would be much
worse if you traced more.

Since function stack tracing is known to cause slowdowns and is even
documented as possibly locking up the machine, this is *not* a fix nor
belongs in stable. But it is OK to be added in the next merge window.

x86 maintainers, feel free to take this with my ack, but you can remove the
fixes and stable tags.

-- Steve

