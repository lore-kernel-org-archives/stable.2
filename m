Received: from mta1.migadu.com (out-30.mta1.migadu.com [95.215.58.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0191037A496
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 07:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792048657; cv=none; b=dIL175rTFxCMjXg/emAV/mQkx19nPxuS4M5Gh9CgN7lJOyfov45Zp4wTDO1a8YT/8hJ/bFscfoDBshg+PkmapT12jAV4DMW3UPLL5dZCUHDz06c1sWOTrzrqPg/nebpr05QdpaTGb1194SXBdAcNqxGvSAR+D3IMUB/8frz+Se0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792048657; c=relaxed/simple;
	bh=60JfGjqc3DHPJ7EdbVJFZDzO0JqUrAEZj+gbv4nkQvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aN2XYBebmVgBtEa3RKgN9sORIdUqVvf8Jtd/6CaiCqFAVmMEwbjcXzJxV6Dc2hzsTqs5ePefiXFzXgay6KNx/jYMEcOmyO5r2HBHBNRa4PDahwpCHREePBKs9l0uNEAkJMmZP6DpKVJBlyPNHp5Eqphd7m+TWl+FbpwfVtiKKmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l+9uRC7Y; arc=none smtp.client-ip=95.215.58.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l+9uRC7Y"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=60JfGjqc3DHPJ7EdbVJFZDzO0JqUrAEZj+gbv4nkQvk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792048642; v=1; x=1792653442;
 b=l+9uRC7YLshnpAwj/A3Hs54pHc94nJ82MM4/ehOq5zWzq0x5fBXSm0rwHkepSoBkdDKZzIW1
 LaDYCNvZs06dgnhx0FLkD3/KF3Xm4ppoSFYaGhv0S0gO0OiSde1szmnTiK63Sw/CHVF8d8KE24z
 n4cBbHcR29d0DSdJD5tlML9Q=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id bfd8d4e994055eab;
	Thu, 15 Oct 2026 07:17:22 +0000
X-Mizu-Trace-ID: bfd8d4e994055eab
X-Migadu-Flow: FLOW_OUT
Message-ID: <5d36dc8a-b26b-4522-826b-65a9274db94f@linux.dev>
Date: Thu, 15 Oct 2026 15:18:27 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: Fix crash in print_graph_function_event()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260920042139.70736-1-hao.ge@linux.dev>
 <20261014190556.6e113c4f@gandalf.local.home>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <20261014190556.6e113c4f@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Steven

On 2026/10/15 07:05, Steven Rostedt wrote:
> On Sun, 20 Sep 2026 12:21:39 +0800
> Hao Ge <hao.ge@linux.dev> wrote:
> 
>> tracing_set_tracer() assigns the flags of the newly selected tracer
>> with:
>>
>> 	tr->current_trace_flags = t->flags ? : t->tracer->flags;
>>
>> If the new tracer defines neither static flags nor default flags, like
>> hwlat, irqsoff or wakeup, add_tracer() has no per instance flags copy
>> for it, and both operands are NULL, so tr->current_trace_flags ends up
>> being NULL as well.
>>
>> The ring buffer is not cleared when switching tracers: it is reset
>> inside tracer_init(), after current_trace_flags was already assigned.
>> If the buffer still holds function_graph entries of the previous
>> tracer, printing one of them dereferences the NULL pointer. This was
>> hit by cat trace during an ftrace stress test:
>>
>>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>>   #PF: supervisor read access in kernel mode
>>   RIP: 0010:print_graph_function_event+0xe/0x20
>>   Call Trace:
>>    s_show+0x4d/0x110
>>    seq_read_iter+0x2d4/0x490
>>    seq_read+0x130/0x170
>>    vfs_read+0xb5/0x370
>>    ksys_read+0x6d/0xe0
>>    do_syscall_64+0xbc/0x450
>>
>> The snapshot buffer is not reset at all, so this can be reproduced
>> without a race:
>>
>>   echo function_graph > /sys/kernel/tracing/current_tracer
>>   echo 1 > /sys/kernel/tracing/snapshot
>>   echo hwlat > /sys/kernel/tracing/current_tracer
>>   cat /sys/kernel/tracing/snapshot
>>
>> Rather than teaching every user of tr->current_trace_flags about this
>> corner case, make sure every tracer has a set of flags:
>> register_tracer() assigns the empty no_tracer_flags to tracers that
>> define none. The existing users already handle opts == NULL, so these
>> tracers keep behaving as before.
> 
> Nice catch, but unfortunately this patch causes this:
> 
> [   13.937660] WARNING: kernel/trace/trace.c:8123 at add_tracer.part.0+0x495/0x930, CPU#3: swapper/0/1
> [   13.947844] Modules linked in:
> [   13.949520] CPU: 3 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.3.0-rc7-test-00017-g26bd9362561c #543 PREEMPT(lazy) 
> [   13.953831] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
> [   13.957723] RIP: 0010:add_tracer.part.0+0x495/0x930
> [   13.959852] Code: 85 73 03 00 00 49 3b 6d 10 74 26 4c 89 e8 48 c1 e8 03 42 80 3c 38 00 0f 85 3c 03 00 00 4d 8b 6d 00 49 81 fd 28 5b d8 85 75 c5 <0f> 0b e9 73 ff ff ff 48 b8 00 00 00 00 00 fc ff df 49 8d 7d 18 48
> [   13.967362] RSP: 0000:ffff888100e67bf0 EFLAGS: 00010246
> [   13.969686] RAX: 1ffff11020012790 RBX: ffff888109fc62c0 RCX: ffff888109fc62d0
> [   13.972635] RDX: ffff888109fc63c0 RSI: 1ffff1102013c3f2 RDI: ffff888100093c90
> [   13.975626] RBP: ffffffff865c0640 R08: 1ffffffff1006101 R09: 1ffffffff0cb7da4
> [   13.980293] R10: 0000000000000003 R11: fffffbfff0cb7da5 R12: ffff8881009e0000
> [   13.983285] R13: ffffffff85d85b28 R14: fffffbfff0cb80db R15: dffffc0000000000
> [   13.986297] FS:  0000000000000000(0000) GS:ffff8882b4cbf000(0000) knlGS:0000000000000000
> [   13.989781] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   13.992213] CR2: 0000000000000000 CR3: 0000000005aec001 CR4: 0000000000172ef0
> [   13.995221] Call Trace:
> [   13.996469]  <TASK>
> [   13.997680]  ? __pfx_init_hwlat_tracer+0x10/0x10
> [   13.999725]  register_tracer+0x30f/0x470
> [   14.001594]  ? __pfx_init_hwlat_tracer+0x10/0x10
> [   14.003632]  init_hwlat_tracer+0x2c/0x120
> [   14.005539]  ? __pfx_init_hwlat_tracer+0x10/0x10
> [   14.007604]  do_one_initcall+0x11e/0x540
> [   14.011129]  ? __pfx_do_one_initcall+0x10/0x10
> [   14.013124]  ? __pfx_parse_args+0x10/0x10
> [   14.015006]  ? kernel_init_freeable+0x4cb/0x710
> [   14.017032]  ? rcu_is_watching+0x16/0xb0
> [   14.018887]  kernel_init_freeable+0x65c/0x710
> [   14.020853]  ? __pfx_kernel_init_freeable+0x10/0x10
> [   14.023036]  ? _raw_spin_unlock_irq+0x38/0x60
> [   14.024995]  ? __pfx_do_raw_spin_lock+0x10/0x10
> [   14.027045]  ? __pfx_kernel_init+0x10/0x10
> [   14.028894]  ? rcu_is_watching+0x16/0xb0
> [   14.030718]  ? __pfx_kernel_init+0x10/0x10
> [   14.032555]  kernel_init+0x21/0x150
> [   14.034249]  ? __pfx_kernel_init+0x10/0x10
> [   14.036086]  ret_from_fork+0x65c/0x9e0
> [   14.037893]  ? __pfx_ret_from_fork+0x10/0x10
> [   14.041417]  ? __switch_to+0x3ad/0xda0
> [   14.043154]  ? __switch_to_asm+0x39/0x70
> [   14.044953]  ? __switch_to_asm+0x33/0x70
> [   14.046792]  ? __pfx_kernel_init+0x10/0x10
> [   14.048646]  ret_from_fork_asm+0x1a/0x30
>

Thanks for catching this.

I was confused at first why I didn't hit this in my testing.
Then after reading the code, I found it needs an instance to
exist before hwlat registers. So it's reliably reproducible with
trace_instance=xxx on the cmdline.

>>
>> Fixes: e29aa918a928 ("tracing: Have function graph tracer define options per instance")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
>> ---
>>  kernel/trace/trace.c | 13 +++++++++----
>>  1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
>> index e4a490d3d08c..1bd757b65be4 100644
>> --- a/kernel/trace/trace.c
>> +++ b/kernel/trace/trace.c
>> @@ -99,6 +99,12 @@ struct tracers {
>>  	struct tracer_flags	*flags;
>>  };
>>  
>> +/*
>> + * Tracers that do not define their own flags use these empty flags,
>> + * as tr->current_trace_flags must never be NULL.
>> + */
>> +static struct tracer_flags no_tracer_flags;
>> +
>>  /*
>>   * To prevent the comm cache from being overwritten when no
>>   * tracing is active, only save the comm when a trace event
>> @@ -1485,9 +1491,11 @@ int __init register_tracer(struct tracer *type)
>>  		}
>>  	}
>>  
>> -	/* store the tracer for __set_tracer_option */
>> +	/* All tracers must have flags, use the empty flags if none are defined */
>>  	if (type->flags)
>>  		type->flags->trace = type;
>> +	else if (!type->default_flags)
>> +		type->default_flags = &no_tracer_flags;
>>  
>>  	ret = do_run_tracer_selftest(type);
>>  	if (ret < 0)
>> @@ -8096,9 +8104,6 @@ static int add_tracer(struct trace_array *tr, struct tracer *tracer)
>>  
>>  	flags = tracer->flags;
>>  	if (!flags) {
>> -		if (!tracer->default_flags)
>> -			return 0;
>> -
>>  		/*
>>  		 * If the tracer defines default flags, it means the flags are
>>  		 * per trace instance.
> 
> Instead of assigning to the tracer, how about just updating
> tr->current_trace_flags?
> 
> Like this:
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 3b22e70c6016..b6b7d86866ef 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -5001,6 +5001,12 @@ static void tracing_set_nop(struct trace_array *tr)
>  
>  static bool tracer_options_updated;
>  
> +/*
> + * Tracers that do not define their own flags use these empty flags,
> + * as tr->current_trace_flags must never be NULL.
> + */
> +static struct tracer_flags no_tracer_flags;
> +
>  int tracing_set_tracer(struct trace_array *tr, const char *buf)
>  {
>  	struct tracer *trace = NULL;
> @@ -5090,6 +5096,8 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
>  	}
>  
>  	tr->current_trace_flags = t->flags ? : t->tracer->flags;
> +	if (!tr->current_trace_flags)
> +		tr->current_trace_flags = &no_tracer_flags;
>  
>  	if (trace->init) {
>  		ret = tracer_init(trace, tr);
> 
> 
> It appears to fix the issue you found without any other side effects.

Right, I verified this patch; both the crash and WARN are gone.
But I think we also need to add this logic inside run_tracer_selftest.

@@ -1319,6 +1325,8 @@ static int run_tracer_selftest(struct tracer *type)
 
        tr->current_trace = type;
        tr->current_trace_flags = type->flags ? : type->default_flags;
+       if (!tr->current_trace_flags)
+               tr->current_trace_flags = &no_tracer_flags;


> 
> Care to send a v2?

With the above changes, I'll send out a v2 shortly.

Thanks
Best Regard
Hao

> 
> Thanks,
> 
> -- Steve
