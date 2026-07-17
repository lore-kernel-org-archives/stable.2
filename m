Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AC1380FD4;
	Fri, 17 Jul 2026 23:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784331931; cv=none; b=kQEiE4BlXd00m1elJiT7Gvffs0ntL29gzO49EZSoYXclWr5uVu8FEfjgLCvaJsECkIVh5Zb2ax3DTMxMAStDPDHe90D2aOJbBbpuPL+Ivewsk7lti4RbSYkiPCPyoKgySNbKH/gbqqseDImbPZZx2lj4EJzok5c22g9OJAl/GF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784331931; c=relaxed/simple;
	bh=GRt7KkB88gPFQXlQ9xP34WSMD6x47Jtchmy4QAp+0O0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pZegBprEEh43+zJ8AUNN5VuKM2kTDOoVaZetghd7WC/APcYc6coTRN0fwfuugRsWFTNH3pY4zdz6O4fbLGwmdSqRs7pSIJLr7dxLPiJ0oAW0E9ktZO+Ckon0/Ab+iNxyXq3J9IBdh4VvNjNORRqeR3qZ8dNXnrPQNrrPKChDOKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3+n9W4a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3+n9W4a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5231F000E9;
	Fri, 17 Jul 2026 23:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784331926;
	bh=t92nG5HOJRBg9LyAAWTooX92pMDv7O5FeBYwyZhCWZs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=m3+n9W4aL1bfen8MiaRECrI/KDcOlfLylLc9IGFlVquEnaS4muHalDMO4Ia3rbMPr
	 7JsGZ5sNIYkQl6oY3v9L04i8QA5Enn6tRSMtvQw2+Wu/sRJruletC49VYQ5FGPZDCk
	 aGS+K5giY78qjodaympjeYubnt/T4ZOOdwHaFfNlsz9+L86RrfWiue2g2ee3tKERFJ
	 q0YnvjCjdWJf5Z4gFWbSW+YDrTdsrd+7Z9HRKC0Qy78LX1GkQz/7S6FKrPLNqnY/LW
	 Bnmbrwo06Arf0caSbZ17Hha2yGuGOPIIg68kNRHc/SoUI0sb0cTcApw/3Iu7K3kpkH
	 fklHdEoWUhc5g==
Date: Sat, 18 Jul 2026 08:45:22 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, rostedt@goodmis.org, leitao@debian.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix context switch counter truncation
Message-Id: <20260718084522.055fc8a671eaf2d2cd927fc2@kernel.org>
In-Reply-To: <20260717173252.3431565-1-usama.arif@linux.dev>
References: <20260717173252.3431565-1-usama.arif@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jul 2026 10:32:52 -0700
Usama Arif <usama.arif@linux.dev> wrote:

> trace_user_fault_read() samples nr_context_switches_cpu() before enabling
> preemption and retries the user copy if the counter changes. The helper
> returns unsigned long long because rq->nr_switches is u64, but the saved
> value is unsigned int.
> 
> Once a CPU has performed 2^32 context switches, assigning the counter to
> cnt discards its upper bits. The comparison after the copy promotes cnt
> back to unsigned long long, but the lost bits remain zero, so it reports a
> change even when the task was never scheduled out. Every retry then fails
> the same way until the 100-try guard warns and the user copy is abandoned.
> 
> This affects long-running systems and workloads with high context-switch
> rates. A CPU switching 1,000 times per second takes about 50 days.
> 
> Store the sampled count in unsigned long long so the full value is
> preserved.

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> 
> Fixes: 64cf7d058a00 ("tracing: Have trace_marker use per-cpu data to read user space")
> Cc: stable@vger.kernel.org
> Reported-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> ---
>  kernel/trace/trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 1146b83b711a..412a8daf2162 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -6188,7 +6188,7 @@ char *trace_user_fault_read(struct trace_user_buf_info *tinfo,
>  {
>  	int cpu = smp_processor_id();
>  	char *buffer = per_cpu_ptr(tinfo->tbuf, cpu)->buf;
> -	unsigned int cnt;
> +	unsigned long long cnt;
>  	int trys = 0;
>  	int ret;
>  
> -- 
> 2.53.0-Meta
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
