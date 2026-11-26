Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795706659;
	b=LIc511Kz7bpxOU8Aw/1jbKd4m2Bn1hfVAco2azBgLFHXrs8Y3M/g45QVV1WnGbykkr5r
	 jhhi84TzLM646iOPHMFlV1UhA/+53K6npZ2OJlo0WkUm/0tgfPlsdf6u1/rILUMRko/Eq
	 /SPGqJmdW3mmsNZcUixGXzaOQsNddd822odVEqvNyb+9yOC3ONH7dwyIZdJ9/WgA5sNpf
	 MzAdD5fmykK3dirPrTK2vRL4xgGniBCLesXHZoIdsaNCCw6P64qlrgmwAXqwi+8MJcs0S
	 lhm7Cg9rX+zlYd7BFSye0QYgfhQWD2BUPsFM9ygMdecG17cnw8TgeLjT78+BCFOHMpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795706659;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=f3eXtHG/OgumbOMqprO0FjcGi85PJbxno9KLK+JsuJM=;
	b=bm0OkY3/cCliFx8Rgnqt0Se6TFpbG17BThmZjswUNUjjOdfSuFHAARI3S+naxs1XGk70
	 Hi8TpPrrUP4M/PI5E7+U3ttVY13hTpYiRcIa1qf47Lr2DMVSBNIXmSjabYWu+WgfjgU4U
	 F6NGXdaRdTp6xH5zOC+86X+LJYmMUps8P/eWnQjMLUKhWgkOkNpqPKtdGQ34e3zA29Oaj
	 InsYJTc7lCI6WLLVgO2fnSYNes8jkTG0V7uhZwpG20sYQUuJyZoEaED57oDwT8LtjEKtf
	 81kPcaCt+nOTP9fxSl1EdHFo0qapaCOcyhx+Kff5p4u4sIkmq/NKEfowMrZ5GNH5pKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=e3uG4rbf;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0157F606A31C;
	Thu, 26 Nov 2026 15:24:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0157F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=e3uG4rbf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=f3eXtHG/OgumbOMqprO0FjcGi85PJbxno9KLK+JsuJM=; b=e3uG4rbf7CWYaRgrTj/LvrfmPt
	dUZWTBgn/Cp6zkldAU9Wde2I9hQEvtwlW7f9XyETU9mEmEDNmutm32bQHp7+6VYYEfqDh/d3FdKe/
	guU5CPsKGGnGsxRXJBIyn2wrNe/cXduSeuTl/MNUGdv1XGB5QRfKoBTRnuALeFLr3WCF5RT/N2ScY
	0S+kCUXl2QzO5dR6wPI40KHcOC2uv0VwbpabA0ZF+QI4zzntiaDsijIJheNS6qttOdvmW4j5e8yKZ
	LFTNRB8xslFQ/914stpcDz++pzIg76T8a30euRt5ruWUqYrbiuKhFZSg+kW3xOfT9bI5KbK447tqF
	GW3+SBsg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWbKZ-00000006o8o-33bP;
	Thu, 26 Nov 2026 15:24:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 48CBF302186; Thu, 26 Nov 2026 16:24:14 +0100 (CET)
Date: Thu, 26 Nov 2026 16:24:14 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] perf: look up address filter files without
 ctx->mutex held
Message-ID: <20261126152414.GH49833@noisy.programming.kicks-ass.net>
References: <20261126-work-exec-update_lock-leftovers-v1-0-1024b26792bc@kernel.org>
 <20261126-work-exec-update_lock-leftovers-v1-1-1024b26792bc@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261126-work-exec-update_lock-leftovers-v1-1-1024b26792bc@kernel.org>

On Thu, Nov 26, 2026 at 12:45:37PM +0100, Christian Brauner wrote:
> PERF_EVENT_IOC_SET_FILTER parses the address filters with the mutex of
> the event's context held. A filter can name a file and the parser looks
> that file up with kern_path(). So the mutex is held for as long as the
> lookup takes and on a FUSE filesystem it's the caller who decides how
> long that is.
> 
> Since commit 2e498d0a74e5 ("perf: Add support for event removal on
> exec") perf_event_exec() takes that mutex with exec_update_lock held
> whenever the task has a perf context. So an exec of the task the event
> counts for hangs past the point of no return until the lookup is done
> and can't be killed. And everyone who needs the exec_update_lock of the
> task waits with it.

Nah, we do this per commit:

79c9ce57eb2d ("perf/core: Fix perf_event_open() vs. execve() race").
6914303824bb ("perf: Use new infrastructure to fix deadlocks in execve")
f7cfd871ae0c ("exec: Transform exec_update_mutex into a rw_semaphore")

> It gets worse. Since commit 6255da28d4bb ("proc: protect
> ptrace_may_access() with exec_update_lock (FD links)") looking up
> /proc/<pid>/exe takes the exec_update_lock of the task. So with such a
> file in a filter the ioctl takes the two locks the other way round:
> 
>   WARNING: possible circular locking dependency detected
>   ------------------------------------------------------
>   perf-addr-filte/113 is trying to acquire lock:
>   (&sig->exec_update_lock){++++}-{4:4}, at: call_proc_get_link+0x4f/0x110
> 
>   but task is already holding lock:
>   (&ctx->mutex){+.+.}-{4:4}, at: perf_event_ctx_lock_nested+0xb2/0x200
> 
>          CPU0                    CPU1
>          ----                    ----
>     lock(&ctx->mutex);
>                                  lock(&sig->exec_update_lock);
>                                  lock(&ctx->mutex);
>     rlock(&sig->exec_update_lock);
> 
> and an exec of the task deadlocks with it:
> 
>   task:exec-task       state:D pid:114
>   Call Trace:
>    __schedule+0x53e/0x13f0
>    schedule+0x36/0x100
>    schedule_preempt_disabled+0x11/0x20
>    __mutex_lock+0x7bf/0x11f0
>    perf_event_exec+0xb9/0x640
>    begin_new_exec+0x622/0xf90
>    load_elf_binary+0x12a/0x1990
>    bprm_execve+0x39d/0x870
>    do_execveat_common.isra.0+0x165/0x180
>    __x64_sys_execve+0x38/0x50
>    do_syscall_64+0x110/0x600
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
>   task:paf-setter      state:D pid:116
>   Call Trace:
>    __schedule+0x53e/0x13f0
>    schedule+0x36/0x100
>    schedule_preempt_disabled+0x11/0x20
>    rwsem_down_read_slowpath+0x186/0x5f0
>    down_read_killable+0x78/0x1b0
>    call_proc_get_link+0x4f/0x110
>    proc_pid_get_link+0x3c/0x70
>    pick_link+0x52b/0x640
>    step_into_slowpath+0x16a/0x3a0
>    path_lookupat+0x169/0x2e0
>    filename_lookup+0x124/0x230
>    kern_path+0x2c/0x50
>    _perf_ioctl+0xbd9/0xea0
>    perf_ioctl+0x50/0x90
>    __x64_sys_ioctl+0xb4/0x100
>    do_syscall_64+0x110/0x600
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> The parser doesn't need the mutex. So drop it while the filters are
> parsed like perf_event_set_filter() already does for the filter of a
> tracepoint. The pmu may be unregistered in the meantime so check again
> whether the event has been revoked once the mutex is back.
> 
> The parser bumped the event's count of file based filters as it went
> along and looked at event->ctx->task. Count in a local, store that when
> the new filters are installed and test PERF_ATTACH_TASK instead.
> 
> This also makes the count exact. It was only ever reset when a set of
> filters was refused. So once an event had a file based filter every
> later set took the mmap lock of the task and for a task without an mm
> the new ranges were never written.
> 
> Fixes: 2e498d0a74e5 ("perf: Add support for event removal on exec")
> Fixes: 6255da28d4bb ("proc: protect ptrace_may_access() with exec_update_lock (FD links)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Somewhat hard to read; and I'm not sure I follow. You're saying:

  ioctl(PERF_EVENT_IOC_SET_FILTER)
    perf_ioctl()
      perf_event_ctx_lock()		// perf_event_context::mutex
      _perf_ioctl()
        perf_event_set_filter()
	  perf_event_set_addr_filter()
	    perf_event_parse_addr_filter()
	      kern_path()
	        ...
		  call_proc_get_link()
		    down_read_killable(&exec_update_lock)

This violates established locking order; which is correct.

(Why can we add proc files to the filter?)

But then:

> @@ -12323,6 +12324,8 @@ perf_event_parse_addr_filter(struct perf_event *event, char *fstr,
>  static int
>  perf_event_set_addr_filter(struct perf_event *event, char *filter_str)
>  {
> +	struct perf_event_context *ctx = event->ctx;
> +	unsigned int nr_file_filters = 0;
>  	LIST_HEAD(filters);
>  	int ret;
>  
> @@ -12330,14 +12333,30 @@ perf_event_set_addr_filter(struct perf_event *event, char *filter_str)
>  	 * Since this is called in perf_ioctl() path, we're already holding
>  	 * ctx::mutex.
>  	 */
> -	lockdep_assert_held(&event->ctx->mutex);
> +	lockdep_assert_held(&ctx->mutex);
>  
>  	if (WARN_ON_ONCE(event->parent))
>  		return -EINVAL;
>  
> -	ret = perf_event_parse_addr_filter(event, filter_str, &filters);
> +	/*
> +	 * Parsing the filters looks up the files they refer to. That can
> +	 * block for as long as the filesystem likes and a lookup below /proc
> +	 * takes exec_update_lock which nests outside of ctx->mutex. So don't
> +	 * hold ctx->mutex for it. As per perf_event_ctx_lock() we already
> +	 * have a reference on ctx and an event with address filters isn't
> +	 * moved to another context.

I'm not sure about this. That is, it is probably true with the current
drivers (intel_pt, coresight and some pending risc-v thing) but in
general there really isn't anything that stops an event from being
migrated.

But there's worse; the ctx->lock is also the thing that serializes
ioctl(), dropping it can get you another ioctl going on the same event,
and you can end up doing nested SET_FILTER for example.

And yes, perf_event_set_filter() drops ctx->mutex for the tracepoint
crud, but that has its own internal locking and never ever uses ctx
again afterwards.

I would really rather exclude procfs if at all possible.

> +	 */
> +	mutex_unlock(&ctx->mutex);
> +	ret = perf_event_parse_addr_filter(event, filter_str, &filters,
> +					   &nr_file_filters);
> +	mutex_lock(&ctx->mutex);
>  	if (ret)
> -		goto fail_clear_files;
> +		return ret;
> +
> +	/* The pmu may have gone away while ctx->mutex was dropped. */
> +	ret = -ENODEV;
> +	if (event->state <= PERF_EVENT_STATE_REVOKED)
> +		goto fail_free_filters;
>  
>  	ret = event->pmu->addr_filters_validate(&filters);
>  	if (ret)
> @@ -12345,6 +12364,7 @@ perf_event_set_addr_filter(struct perf_event *event, char *filter_str)
>  
>  	/* remove existing filters, if any */
>  	perf_addr_filters_splice(event, &filters);
> +	event->addr_filters.nr_file_filters = nr_file_filters;
>  
>  	/* install new filters */
>  	perf_event_for_each_child(event, perf_event_addr_filters_apply);
> @@ -12353,10 +12373,6 @@ perf_event_set_addr_filter(struct perf_event *event, char *filter_str)
>  
>  fail_free_filters:
>  	free_filters_list(&filters);
> -
> -fail_clear_files:
> -	event->addr_filters.nr_file_filters = 0;
> -
>  	return ret;
>  }
>  
> 
> -- 
> 2.53.0
> 
