Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C0C31D72E;
	Wed, 14 Oct 2026 23:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792019163; cv=none; b=Nyjd5I2lkwg7nS3Muw2x52CrhDIVh0feMkAmE3tUuM4a4PZCVBwhgQopKbKw1MtmEy9knD3t5mA4FQXCRulwJxzkxR3Z3wyp9gKeu9Nz2al2MWQdNwTZTSHH1K+EqtTE7jy5+1kpzSEyQe+91ZgBz7+p350e4+LOhuul7kVVwjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792019163; c=relaxed/simple;
	bh=viStcgQS+Evh9lIszlZTzpBJigJ3S2QX4OYSBZv188Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tY/84tGBIcBo+uthXrbSQI5PNiTICm1lFKqoQM7sTQ25jw51BosYJOEFJLaHdg7D1diXKCm5TIZtzIf+U+KX0endrAchglXS99+sBe+HgFryMcHyFsqRU95QA61DwsvIEfgLaqmJq6ubN/4I7V7hpL1s3t39ZV6+yQg8u/tivXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=LyiXR31B; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="LyiXR31B"
Received: from omf10.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 2A979C0848;
	Wed, 14 Oct 2026 23:05:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 4369835;
	Wed, 14 Oct 2026 23:05:57 +0000 (UTC)
Date: Wed, 14 Oct 2026 19:05:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Hao Ge <hao.ge@linux.dev>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix crash in print_graph_function_event()
Message-ID: <20261014190556.6e113c4f@gandalf.local.home>
In-Reply-To: <20260920042139.70736-1-hao.ge@linux.dev>
References: <20260920042139.70736-1-hao.ge@linux.dev>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 4369835
X-Stat-Signature: p5af1dtb6nfmhscqh8dqrjxe4mruto48
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX186FOJBCmFSpVKJVYH8nVANmLGYfoSt51c=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=brFl1SQr8Y8t70MpvFpnURcjVLyEJHX36hWXFywYHww=; b=LyiXR31B6G/OZettYfSEb4zgx6k7f7nrIv+AR9/nFKEfJUYM6N7h/71972+90D2Bxl2oSyNEbUrgCvDngWGwRx1wspDsH9ngItb3aVoDALJccN8F+B5jt5xnuxQEhvj738bFmCSqMOY6wp/+bhk0te6A+XcNRPjmH/9nQFjI9hk=
X-HE-Tag: 1792019157-426779
X-HE-Meta: U2FsdGVkX1+T2p0hW3vxgE9mkA0JhsImcauHezigSEy/OjNSPrKYpDnZNCimumlH4b5peKypqnxWfn7XWYRwjlV6PJJn+dLKvNConoIbH/iJg3E2TgSO1/Sj6tEYSwVPHBwOsNrV7WumxSZk4nKcFjVGbRDkdw/yCrHXZCxWx7cKCm15PuwfPULLvxz8ZCqYwEAHOHdtxT24SPQjKS2lpNq5+sDXfJYT6dfhayEsihAX0n48HnKym+OP85GeXzVAJkXzf8/eec6HLEvpmJ8kewpXncSsMIbOd8lT/ZWkZggu3EOThx4IZ7jdISsIcKT24aiHck2dNftG3Q1QwKH4o5ndUyDA6JZQ

On Sun, 20 Sep 2026 12:21:39 +0800
Hao Ge <hao.ge@linux.dev> wrote:

> tracing_set_tracer() assigns the flags of the newly selected tracer
> with:
> 
> 	tr->current_trace_flags = t->flags ? : t->tracer->flags;
> 
> If the new tracer defines neither static flags nor default flags, like
> hwlat, irqsoff or wakeup, add_tracer() has no per instance flags copy
> for it, and both operands are NULL, so tr->current_trace_flags ends up
> being NULL as well.
> 
> The ring buffer is not cleared when switching tracers: it is reset
> inside tracer_init(), after current_trace_flags was already assigned.
> If the buffer still holds function_graph entries of the previous
> tracer, printing one of them dereferences the NULL pointer. This was
> hit by cat trace during an ftrace stress test:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   #PF: supervisor read access in kernel mode
>   RIP: 0010:print_graph_function_event+0xe/0x20
>   Call Trace:
>    s_show+0x4d/0x110
>    seq_read_iter+0x2d4/0x490
>    seq_read+0x130/0x170
>    vfs_read+0xb5/0x370
>    ksys_read+0x6d/0xe0
>    do_syscall_64+0xbc/0x450
> 
> The snapshot buffer is not reset at all, so this can be reproduced
> without a race:
> 
>   echo function_graph > /sys/kernel/tracing/current_tracer
>   echo 1 > /sys/kernel/tracing/snapshot
>   echo hwlat > /sys/kernel/tracing/current_tracer
>   cat /sys/kernel/tracing/snapshot
> 
> Rather than teaching every user of tr->current_trace_flags about this
> corner case, make sure every tracer has a set of flags:
> register_tracer() assigns the empty no_tracer_flags to tracers that
> define none. The existing users already handle opts == NULL, so these
> tracers keep behaving as before.

Nice catch, but unfortunately this patch causes this:

[   13.937660] WARNING: kernel/trace/trace.c:8123 at add_tracer.part.0+0x495/0x930, CPU#3: swapper/0/1
[   13.947844] Modules linked in:
[   13.949520] CPU: 3 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.3.0-rc7-test-00017-g26bd9362561c #543 PREEMPT(lazy) 
[   13.953831] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
[   13.957723] RIP: 0010:add_tracer.part.0+0x495/0x930
[   13.959852] Code: 85 73 03 00 00 49 3b 6d 10 74 26 4c 89 e8 48 c1 e8 03 42 80 3c 38 00 0f 85 3c 03 00 00 4d 8b 6d 00 49 81 fd 28 5b d8 85 75 c5 <0f> 0b e9 73 ff ff ff 48 b8 00 00 00 00 00 fc ff df 49 8d 7d 18 48
[   13.967362] RSP: 0000:ffff888100e67bf0 EFLAGS: 00010246
[   13.969686] RAX: 1ffff11020012790 RBX: ffff888109fc62c0 RCX: ffff888109fc62d0
[   13.972635] RDX: ffff888109fc63c0 RSI: 1ffff1102013c3f2 RDI: ffff888100093c90
[   13.975626] RBP: ffffffff865c0640 R08: 1ffffffff1006101 R09: 1ffffffff0cb7da4
[   13.980293] R10: 0000000000000003 R11: fffffbfff0cb7da5 R12: ffff8881009e0000
[   13.983285] R13: ffffffff85d85b28 R14: fffffbfff0cb80db R15: dffffc0000000000
[   13.986297] FS:  0000000000000000(0000) GS:ffff8882b4cbf000(0000) knlGS:0000000000000000
[   13.989781] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.992213] CR2: 0000000000000000 CR3: 0000000005aec001 CR4: 0000000000172ef0
[   13.995221] Call Trace:
[   13.996469]  <TASK>
[   13.997680]  ? __pfx_init_hwlat_tracer+0x10/0x10
[   13.999725]  register_tracer+0x30f/0x470
[   14.001594]  ? __pfx_init_hwlat_tracer+0x10/0x10
[   14.003632]  init_hwlat_tracer+0x2c/0x120
[   14.005539]  ? __pfx_init_hwlat_tracer+0x10/0x10
[   14.007604]  do_one_initcall+0x11e/0x540
[   14.011129]  ? __pfx_do_one_initcall+0x10/0x10
[   14.013124]  ? __pfx_parse_args+0x10/0x10
[   14.015006]  ? kernel_init_freeable+0x4cb/0x710
[   14.017032]  ? rcu_is_watching+0x16/0xb0
[   14.018887]  kernel_init_freeable+0x65c/0x710
[   14.020853]  ? __pfx_kernel_init_freeable+0x10/0x10
[   14.023036]  ? _raw_spin_unlock_irq+0x38/0x60
[   14.024995]  ? __pfx_do_raw_spin_lock+0x10/0x10
[   14.027045]  ? __pfx_kernel_init+0x10/0x10
[   14.028894]  ? rcu_is_watching+0x16/0xb0
[   14.030718]  ? __pfx_kernel_init+0x10/0x10
[   14.032555]  kernel_init+0x21/0x150
[   14.034249]  ? __pfx_kernel_init+0x10/0x10
[   14.036086]  ret_from_fork+0x65c/0x9e0
[   14.037893]  ? __pfx_ret_from_fork+0x10/0x10
[   14.041417]  ? __switch_to+0x3ad/0xda0
[   14.043154]  ? __switch_to_asm+0x39/0x70
[   14.044953]  ? __switch_to_asm+0x33/0x70
[   14.046792]  ? __pfx_kernel_init+0x10/0x10
[   14.048646]  ret_from_fork_asm+0x1a/0x30

> 
> Fixes: e29aa918a928 ("tracing: Have function graph tracer define options per instance")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---
>  kernel/trace/trace.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index e4a490d3d08c..1bd757b65be4 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -99,6 +99,12 @@ struct tracers {
>  	struct tracer_flags	*flags;
>  };
>  
> +/*
> + * Tracers that do not define their own flags use these empty flags,
> + * as tr->current_trace_flags must never be NULL.
> + */
> +static struct tracer_flags no_tracer_flags;
> +
>  /*
>   * To prevent the comm cache from being overwritten when no
>   * tracing is active, only save the comm when a trace event
> @@ -1485,9 +1491,11 @@ int __init register_tracer(struct tracer *type)
>  		}
>  	}
>  
> -	/* store the tracer for __set_tracer_option */
> +	/* All tracers must have flags, use the empty flags if none are defined */
>  	if (type->flags)
>  		type->flags->trace = type;
> +	else if (!type->default_flags)
> +		type->default_flags = &no_tracer_flags;
>  
>  	ret = do_run_tracer_selftest(type);
>  	if (ret < 0)
> @@ -8096,9 +8104,6 @@ static int add_tracer(struct trace_array *tr, struct tracer *tracer)
>  
>  	flags = tracer->flags;
>  	if (!flags) {
> -		if (!tracer->default_flags)
> -			return 0;
> -
>  		/*
>  		 * If the tracer defines default flags, it means the flags are
>  		 * per trace instance.

Instead of assigning to the tracer, how about just updating
tr->current_trace_flags?

Like this:

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 3b22e70c6016..b6b7d86866ef 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5001,6 +5001,12 @@ static void tracing_set_nop(struct trace_array *tr)
 
 static bool tracer_options_updated;
 
+/*
+ * Tracers that do not define their own flags use these empty flags,
+ * as tr->current_trace_flags must never be NULL.
+ */
+static struct tracer_flags no_tracer_flags;
+
 int tracing_set_tracer(struct trace_array *tr, const char *buf)
 {
 	struct tracer *trace = NULL;
@@ -5090,6 +5096,8 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
 	}
 
 	tr->current_trace_flags = t->flags ? : t->tracer->flags;
+	if (!tr->current_trace_flags)
+		tr->current_trace_flags = &no_tracer_flags;
 
 	if (trace->init) {
 		ret = tracer_init(trace, tr);


It appears to fix the issue you found without any other side effects.

Care to send a v2?

Thanks,

-- Steve
