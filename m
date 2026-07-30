Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0872137F014;
	Thu, 30 Jul 2026 03:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785380491; cv=none; b=dSUEFt8z0fvs/L9Mqv3LdzoZGqD2VdZxPrbcPrvppVNIhcetqu0cyTAHJAhmYbrP3oMXeIhKLurY7yYMVuYZFvTtXTW8sgTf9tR3m0FJapjcaYrDcMrK1mI0p6Av//iyjEDhyHEbJ3M2OGMB+byWGHxxskv8r02dnNMMVjuWJsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785380491; c=relaxed/simple;
	bh=PADfhq9IlcxYkFge9t3Awg1WHo9oQLWHaRF7TLtzY4Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=A+KsdGTBanQbmPbUWniRgPk0KwPrLtVMorGGbtKHJmT9D/rsrbpX6pEca+U/R6177ctsIxnqWMJZ+kjxIsy+sAOJZZvmE0MXgeaOc2f9ht4uzQ/Dy8DYlduNOm+cz5HavEKIachfTIVMJTA6kyc4Wi7LHD/+bzd57ZgPG6OaxGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a60Bm23+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a60Bm23+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE1F1F000E9;
	Thu, 30 Jul 2026 03:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785380489;
	bh=ZbDAMpcDYdvZrUn/eTSwKKqDRSCBsLNaQd23zQxbA6w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=a60Bm23+AR5el/WMydQ2tACYvNZ1Ru6iIMfFCl63jHYLOh1unYDsyZ7iLHd7n/XVN
	 yWiW/YhdZJQx7ij/CEMH/X14We9D4+Zz1qjBQ40JKn2ek25AFb0C+mP2I0bqDQy4ee
	 wjYk9qhMH//+PUmhI90qYCjoSAZzy9eVgXtGqIsk03QaRsmCRa0AqTTGZZHrpiJL2+
	 +1/Ug3XHQznJSQa6E7hne6LRVoiOWrqOrPlqp+aZ79dSuYVb0ibRbvQ9ieB/QQFrXg
	 boYZw5/v40Jt/auZRYemfkpXfaAYpgxWaXEZ21yl93dDWouDUh7OZ/jlPmxeQd1NZo
	 uPR4IGwR8M65A==
Date: Thu, 30 Jul 2026 12:01:22 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: <bpf@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <song@kernel.org>,
 <jolsa@kernel.org>, <rostedt@goodmis.org>, <naveen@kernel.org>,
 <davem@davemloft.net>, <mhiramat@kernel.org>, <stable@vger.kernel.org>,
 <linux-open-source@crowdstrike.com>
Subject: Re: [RFC PATCH bpf-next 2/3] kprobes: mark ftrace-based kprobe ops
 permanent
Message-Id: <20260730120122.bc7a0daa4b28a8577f9a2038@kernel.org>
In-Reply-To: <20260729005959.3853865-3-andrey.grodzovsky@crowdstrike.com>
References: <20260729005959.3853865-1-andrey.grodzovsky@crowdstrike.com>
	<20260729005959.3853865-3-andrey.grodzovsky@crowdstrike.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jul 2026 20:59:58 -0400
Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com> wrote:

> kernel.ftrace_enabled=0 silently kills ftrace-based kprobes/kretprobes
> the same way it does BPF trampolines: arm succeeds, the probe stops
> firing with no error, and re-enabling silently restores it. Unlike
> trampolines this is not a regression -- ftrace-based kprobes have
> never carried this protection, so the bug is long-standing.
> 
> kprobe_ftrace_ops/kprobe_ipmodify_ops are shared only among
> ftrace-based kprobe attachers, not with any other tracer, so the same
> unconditional FTRACE_OPS_FL_PERMANENT livepatch already uses applies
> cleanly here too, with no kernel/trace/ftrace.c changes needed.
> 
> Known limitation: kprobe.multi/kretprobe.multi/kprobe.session
> (fprobe-backed, kernel/trace/fprobe.c) are not covered. Entry-only
> fprobes could take the same fix, but return-capturing fprobes route
> through the function-graph tracer's shared subops manager, which is
> also used by unrelated tracers (function_graph, irqsoff, wakeup
> latency, function profiler) -- marking it permanent would block
> ftrace_enabled=0 for those too. Left for a follow-up.
> 

In the another thread, Steve and you agreed to just remove
ftrace_enabled, so I assume we will drop this patch.
But from the kprobes point of view this seems reasonable change.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>


Thank you,

> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> ---
>  kernel/kprobes.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index bfc89083daa9..5a54511eee79 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1122,14 +1122,15 @@ static struct kprobe *alloc_aggr_kprobe(struct kprobe *p)
>  #endif /* CONFIG_OPTPROBES */
>  
>  #ifdef CONFIG_KPROBES_ON_FTRACE
> +/* Same protection livepatch gives its own ftrace_ops. */
>  static struct ftrace_ops kprobe_ftrace_ops __read_mostly = {
>  	.func = kprobe_ftrace_handler,
> -	.flags = FTRACE_OPS_FL_SAVE_REGS,
> +	.flags = FTRACE_OPS_FL_SAVE_REGS | FTRACE_OPS_FL_PERMANENT,
>  };
>  
>  static struct ftrace_ops kprobe_ipmodify_ops __read_mostly = {
>  	.func = kprobe_ftrace_handler,
> -	.flags = FTRACE_OPS_FL_SAVE_REGS | FTRACE_OPS_FL_IPMODIFY,
> +	.flags = FTRACE_OPS_FL_SAVE_REGS | FTRACE_OPS_FL_IPMODIFY | FTRACE_OPS_FL_PERMANENT,
>  };
>  
>  static int kprobe_ipmodify_enabled;
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
