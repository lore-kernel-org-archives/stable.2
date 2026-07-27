Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F123F0765
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 10:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785147053; cv=none; b=BfWVEzhv946M5vLjqefuhTAXtS22yzz5qwwSmqgomz18kRVVRsIijPV1qBpqDkCoO0yAEvL6Pedy4Q01E69+mXzr/fSmI6MOd9ovepvgSp82msJ4snCs6e5jFaCpxgLaipymbl4JLTFBwVwtSQSbRL+kKEdPFfryZeQX9H6X1tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785147053; c=relaxed/simple;
	bh=81KWZfVGL5O48f5ct6n1xE+qTqvmejayvMfGtVKn7Ec=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PsD8hG7gWfD2BQU1XfzBS7DS30fxXSaM/nZeLEBDk4Eet0ErNf9qR+XMUb49DXAE6aa8CQj/n5DNtCPMlup+nkdeFTTBo2zfBNkrsVh8yd1faYeZClcErM+3uAXX20LIAHAsTwW0YUPVcBjgT072hporsA7qACqMb+YSrYHJfv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXa+b2/4; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXa+b2/4"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493f75f7172so21919905e9.1
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 03:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785147050; x=1785751850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nLnBsTaRkUVSdEkbIlIrpALA+/Jwu41Chu/aPM4eBsw=;
        b=IXa+b2/4i9icXDPKasI62U9pXoQAULCXlSE/jchyMZ80nGnNnoDG452x0f4AozMJYC
         MRfAYf/MDNK1VFcG5MCpSuaG2FJ+rpfXoKDkwx1tuLtHyEFcasEb2ylqWLLdkwCuNqSh
         lY5+UiaxyLaQi712HVRRk/nylNN0gPHKnP0BrV6V9WdNhuICtg+N7kB3tXwSCcKZGAFn
         n5dLQN4qXbIXAZsqZ0z24ki5HRjgU3/nokFCLS5e4K5+BtEcNUU5G0g6xU7XyVZ73iNU
         kxm7oxH+SvY25jGXOpDG7Bnu2fehusskhmcUMRt6hEa4WxU765nHqegUM6sCJ06yV7Ow
         SsZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785147050; x=1785751850;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nLnBsTaRkUVSdEkbIlIrpALA+/Jwu41Chu/aPM4eBsw=;
        b=BcE3AFzUudpgVVI2LUba7xEM8EvXsiUWmCNnofyJ9HkxtYy/2y/2h6PwUxenMrSawv
         CIXywmONXtysL+ZQ7TDXBgGXQVcrhMWn08dxVuue9D/SmxG4HvPckYucu4bfmAXIy1hX
         MihYAJzFvMfQP8TjX2v/dw20zLVpj7UMdY9NY4iYghOBXq8GY6npOvmByZMLEJcxFRNo
         gf+AjCuEvbxDII6+Aa195y7jW2xMXRi5C6LFkJNGRxiVRQktfa8IhhuMTQwLV1Mvrk0u
         bOPsqpYlDsLDjMEcgJz6G9lk0tZZbOA6bOoQTm7znirULcYIx3AOmrDspOWfmg+CpDiD
         bc+g==
X-Forwarded-Encrypted: i=1; AHgh+RoqPi5ZH7h/h1FO3iYE6mgIJkVp/qo21/lW2WK+0CewqfHuVJJukNif2lvn+FNfYj3OwnpKBMw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt3k8Ag3m3lAD+SXsdHBk00BibnVOggCOIT01Nj9oXcDfIA9lt
	jj9M4Wjt1Q960P2qR0PbhYMzJV1OkR3MmeKPXT4x0TRPioYsMgUgZzNg
X-Gm-Gg: AR+sD11gYIyeLZaujydVnHO6OhRfDozgi2J/lKYiDtg/d7jJ1XKfIPFQ+mbpViFQhzp
	i3FOjzlCLEi0r1JNg1GZIrElBWT9yn4iru9vktG9mkOESDqTLaP6vDogaGdSajI/uneeEeiUyQb
	Z/WtgKQ9LYM8G8rQrpaoZs7g4rhK86b0egS5jQuUzAvxHzwuLIXJQjCX39XDuaJy8XtTpSNUltY
	YBkl8RVyqmL9Fs0Rh62Fd+PtwEQDrvUAB+pj5j5H4qy5Iz/9+EQ07r4N4XQhJhb56NgYx4yW2iz
	dtKxP7+EgDx9GTnyBfek3k8ynvkttyxjgj+qTmnCrBvFXHVyV3k04MjC8z0nsJ0OjX+N2JjQPPs
	6GjpEOfjyxOy3xFuyjgfLNNJ2XHBfe7Z8CrMtlTcAwBkOJe4KHrXhsaE0ErrlCjyHX2zq3iuoKD
	fvwEE4YBj6y4N87zTgPt8BQCM=
X-Received: by 2002:a05:600c:5487:b0:495:6c44:633f with SMTP id 5b1f17b1804b1-496b6d30541mr85884115e9.31.1785147049718;
        Mon, 27 Jul 2026 03:10:49 -0700 (PDT)
Received: from krava (ip-94-113-247-31.net.vodafone.cz. [94.113.247.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c532d4sm46839260f8f.22.2026.07.27.03.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 03:10:49 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 27 Jul 2026 12:10:47 +0200
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, stable@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>, STAR Labs SG <info@starlabs.sg>,
	bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH bpf-next 9/9] bpf: Disable preemption in __bpf_get_stack
Message-ID: <amcup1unyLB6rXZ3@krava>
References: <20260720085351.655075-1-jolsa@kernel.org>
 <20260720085351.655075-10-jolsa@kernel.org>
 <4aa21cf3-0ed6-424c-9c96-425e2e5ed586@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4aa21cf3-0ed6-424c-9c96-425e2e5ed586@linux.dev>

On Fri, Jul 24, 2026 at 01:23:21PM -0700, Ihor Solodrai wrote:
> On 2026-07-20 1:53 a.m., Jiri Olsa wrote:
> > From: Daniel Borkmann <borkmann@iogearbox.net>
> > 
> > get_perf_callchain() returns a per-CPU perf_callchain_entry buffer and
> > releases its recursion slot via put_callchain_entry() before returning,
> > so nothing keeps the entry reserved while __bpf_get_stack() consumes
> > it below.
> > 
> > A preemptible BPF program (e.g. a non-sleepable raw tracepoint program
> > on a PREEMPT kernel, which runs under migrate_disable() but not
> > preempt_disable()) can be scheduled out between obtaining the entry
> > and the copy. Another task scheduled on the same CPU then reuses the
> > same per-CPU buffer and overwrites trace->nr with a larger value.
> > copy_len is then computed from the inflated trace->nr and can exceed
> > the caller's buffer, causing an out-of-bounds write in the memcpy()
> > and in the build_id path.
> > 
> > The rcu_read_lock() previously taken here does not prevent this. It is
> > only taken on the may_fault path, and under CONFIG_PREEMPT_RCU it does
> > not disable preemption; it merely keeps perf's callchain buffer array
> > alive (freed via call_rcu()) and does nothing to stop another task
> > from reusing the entry.
> > 
> > Disable preemption around obtaining the callchain entry and copying
> > it into the caller's buffer, so the entry cannot be reused underneath
> > us and trace->nr stays bounded by max_depth. Build ID resolution may
> > fault and is therefore deferred until after preemption is re-enabled;
> > by then the instruction pointers have already been copied into buf,
> > so it operates only on that private copy. Note, preempt_disable() also
> > subsumes the buffer-lifetime guarantee the rcu_read_lock() provided,
> > since a preempt-disabled section is an RCU read-side critical section
> > for the callchain buffers' call_rcu() reclaim.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: c195651e565a ("bpf: add bpf_get_stack helper")
> > Reported-by: Tao Chen <chen.dylane@linux.dev>
> > Closes: https://lore.kernel.org/bpf/20260206090653.1336687-1-chen.dylane@linux.dev/
> > Reported-by: STAR Labs SG <info@starlabs.sg>
> > Signed-off-by: Daniel Borkmann <borkmann@iogearbox.net>
> > [ changed Fixes: commit ]
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >   kernel/bpf/stackmap.c | 9 +++------
> >   1 file changed, 3 insertions(+), 6 deletions(-)
> > 
> > diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> > index 57cd4c33403b..37f8e46319b3 100644
> > --- a/kernel/bpf/stackmap.c
> > +++ b/kernel/bpf/stackmap.c
> > @@ -819,8 +819,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
> >   	max_depth = stack_map_calculate_max_depth(size, elem_size, flags);
> > -	if (may_fault)
> > -		rcu_read_lock(); /* need RCU for perf's callchain below */
> > +	preempt_disable();
> 
> With the series applied on bpf-ci-like kconfig I get a "suspicious RCU
> usage" splat on BPF selftests, pasted at the bottom.
> 
> AFAIU, the rcu_read_lock() that's removed here was not only
> controlling the lifetime (which is now covered by preempt_disable),
> but also putting the RCU read-side annotation for the
> 
> 	entries = rcu_dereference(callchain_cpus_entries);
> 
> in get_callchain_entry() (callchain.c:163).
> 
> preempt_disable() never takes rcu_lock_map, and a sleepable program
> holds only rcu_read_lock_trace() (rcu_tasks_trace_srcu_struct), which
> is a different lockmap. So on PREEMPT_RCU + PROVE_RCU the
> rcu_dereference_check() there now fails (see the splat).
> 
> The non-sleepable path is fine because it enters with rcu_read_lock()
> held via rcu_read_lock_dont_migrate().
> 
> I think to fix this we have to keep if (may_fault) rcu_read_lock();
> alongside preempt_disable(). Something like this:
> 
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 37f8e46319b3..6be413072ef6 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -820,6 +820,8 @@ static long __bpf_get_stack(struct pt_regs *regs, struct
> task_struct *task,
>         max_depth = stack_map_calculate_max_depth(size, elem_size, flags);
> 
>         preempt_disable();
> +       if (may_fault)
> +               rcu_read_lock();
> 
>         if (kernel && task) {
>                 trace = get_callchain_entry_for_task(task, max_depth);
> @@ -829,6 +831,8 @@ static long __bpf_get_stack(struct pt_regs *regs, struct
> task_struct *task,
>         }
> 
>         if (unlikely(!trace) || trace->nr < skip) {
> +               if (may_fault)
> +                       rcu_read_unlock();
>                 preempt_enable();
>                 goto err_fault;
>         }
> @@ -836,6 +840,8 @@ static long __bpf_get_stack(struct pt_regs *regs, struct
> task_struct *task,
>         trace_nr = callchain_store(trace, buf, size, elem_size, flags);
> 
>         /* trace should not be dereferenced after this point */
> +       if (may_fault)
> +               rcu_read_unlock();
>         preempt_enable();
> 
>         return callchain_finalize(buf, size, trace_nr, elem_size,
> user_build_id, user, may_fault);
> 
> 
> I confirmed this diff fixes the splat below.

yes, I managed to reproduce it as well.. basically just to add
the preemption_disable/enable hunks and keey rcu locks in place

> 
> I guess teaching the perf side to accept rcu_read_lock_sched_held()
> would also work, but that's out of scope for a bpf fix and may be no
> less tricky.

will check, but you might be right it'd be tricky

thanks,
jirka
