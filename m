Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B4E4D9577;
	Tue, 13 Oct 2026 23:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791934287; cv=none; b=lefhtNMHEhNHtT0GsAavc8z4uRsGm5ozbOFO3oYZqrMielScaq2DJeJuVM1sfxZ/jNKMX2JNqsUe3F2FVaETD68yboSDuEwBqRXEaogpidYLy1GONYUxtdfFTr3D77m+pQk10563DogE27IV2EHIqAvMHfeBkKJsJkwO1kX5R+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791934287; c=relaxed/simple;
	bh=u1Ha/Si/8J2pD8iT4rc/MZ9ssmdEQ0bjMSk9Wd6XVKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-Id; b=eBRVYAy9SH73co8A8yY14b91C4h3dXVvpngK4AKYQ24rcbuYsnXIosIMR6h6Gjz6e1EsxIWaEr7ViN0MzOwJQCjbsBYwCkZr8KPzXbozQO95gxzJHw75KHbQrhL6OsQ6+PbGifjYvkNJb+u4RLJ1eXqF0giJzjDOgMl4RpacV48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXSJPJb3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXSJPJb3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF091F000FF;
	Tue, 13 Oct 2026 23:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791934286;
	bh=APi2ZfgZmahKqfvONReNmB6QiAyaVs+ZKVZwZPGqYh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PXSJPJb3ZwyaTyYxBAjLq6sUf5snAqcUWFn5362P9BKVrs69z5jtuKBXOK7MgZFhj
	 vaIbebRCBcIe3qo7EX2QIue+IYOQk85QSc1HSf9sog366F2tvfexS+4+S0Srs9rlY3
	 tu9PBp5qMgAgFN+zmTzdwu2xBFeDEkwqgrWouzNrV28buHFQbMQrXeYfcVVIMxZgcq
	 hjnr/maN5XTmY681pZxlgFkAb9xYESxFz0fnpityZ/sHYBe/AIEYgBNRv806/E/nBk
	 hSVqJ0W5gFuHRjiF+QaIJcH/1crTop/LBq9EC2QpYdFjbiODK4riQu7gxG9kWuUbrU
	 C3mBPZ7oZAHDw==
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: amachhiw@linux.ibm.com
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Amit Machhiwal <amachhiw@linux.ibm.com>,
 Michal =?utf-8?q?Such=C3=A1nek?= <msuchanek@suse.de>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Mark-PK Tsai <mark-pk.tsai@mediatek.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: Do not initialize tracefs work if tracing is
 disabled
Date: Wed, 14 Oct 2026 08:31:21 +0900
X-Mailer: UndineD 0.1
In-Reply-To: <20261009163557.88467-2-amachhiw@linux.ibm.com>
References: 20261009163557.88467-1-amachhiw@linux.ibm.com
 <20261009163557.88467-2-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20261013233123.5FF091F000FF@smtp.kernel.org>

On Fri, 09 Oct 2026 22:05:56 +0530, Amit Machhiwal <amachhiw@linux.ibm.com> wrote:
> If trace buffer allocation fails during early boot (e.g.  in
> early_trace_init() -> allocate_trace_buffers()), tracing_disabled is
> left set to 1 and the global trace array events list remains
> uninitialized.
>
> Later during boot, tracer_init_tracefs() (invoked via fs_initcall)
> queues tracerfs_init_work asynchronously without checking if tracing was
> disabled.  When tracer_init_tracefs_work_func() runs, it calls
> event_trace_init() and init_tracer_tracefs(&global_trace, NULL)
> unconditionally.  This leads to __find_event_file() dereferencing an
> uninitialized tr->events list, causing an early boot NULL pointer
> dereference Oops:
>
>   BUG: Kernel NULL pointer dereference on read at 0x00000010
>   Faulting instruction address: 0xc000000000485be0
>   Oops: Kernel access of bad area, sig: 7 [#1]
>   ...
>   NIP [c000000000485be0] __find_event_file+0x70/0x3c0
>   LR  [c000000000448874] init_tracer_tracefs+0x274/0xc80
>   Call Trace:
>    init_tracer_tracefs+0x274/0xc80
>    tracer_init_tracefs_work_func+0x50/0x320
>    process_one_work+0x1e8/0x5c0
>    worker_thread+0x1dc/0x3d0
>    kthread+0x194/0x1b0
>    start_kernel_thread+0x14/0x18
>
> Check tracing_disabled at the beginning of tracer_init_tracefs_work_func()
> and return immediately if tracing is disabled or failed to initialize,
> preventing the crash.
>

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> Fixes: 6621a7004684 ("tracing: make tracer_init_tracefs initcall asynchronous")
> Cc: stable@vger.kernel.org
> Reported-by: Michal Suchánek <msuchanek@suse.de>
> Closes: https://lore.kernel.org/all/arYskzbiaNzBR9MD@kunlun.suse.cz/
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>  kernel/trace/trace.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index e4a490d3d08c..7ac9e1c92702 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -9287,6 +9287,12 @@ static struct notifier_block trace_module_nb = {
>  
>  static __init void tracer_init_tracefs_work_func(struct work_struct *work)
>  {
> +	/*
> +	 * Do not attempt to initialize tracefs if tracing was disabled or
> +	 * failed to allocate
> +	 */
> +	if (tracing_disabled)
> +		return;
>  
>  	event_trace_init();
>  
> -- 
> 2.54.0 (Apple Git-157)
>

Thanks!

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
