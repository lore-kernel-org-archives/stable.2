Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792779237;
	b=NsHp0k2GRCWpdip4L31aDImWV5/Kc6rSV0yWnqGtCTyL81HhSkQO3kEQ1fzREcuxnJxX
	 HRIPtM/QW/LE8qqt/Zs8ElOt72+CdsuJnHVImPnh8T/7dvl99uRonJ4mTzqcH5nfTAwyo
	 +AelvhwbTPehRy+dwhdaeN5GOvGBMmoMxa84riFGf3LtOQJUXSI0bOjZWys7oE+24rSLg
	 DyE3mh9B0AfcpCcOWaz+VRiuJJEYEmS8NuKrUBgmMn9ZiOvdPqtzafetPGQphmrjJ+1pb
	 oCtSOGB3xPMrIy/SwZN0s9RvCXMwEtsULXPMvea+vgC6oNp/hQSgh9VNU43neLlTgeQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792779237;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=a8AhxehP29nTMFMYLaAQmj4iROvDwdVGWATuOgUSYxE=;
	b=3xeWbEM7G2m02B1YZZ215vxI7Fuwlp7hMXsX9VN5SG25iI53qE1ggZ/VmDWQK6Pv5tNx
	 6Tce9pXNplgXyYaeikYLQKFif3Toe7erCpTAKzg6fm94q4ZXT8U0G3RKlLsgrKFatQz0/
	 W6nLxbviwH2kKMGeMoP2+NV9iA+wqcZcELYxbRp+OSfBSvfYPYPBmmzxPXJi957cdETzl
	 pbcc47y+J3959bu1mq/dTSzJS0xXb7YnWF236DPz5pL/qWsxOrV2kYTFNOKbFrLifiuBw
	 UJo0aauJi0IUZi5GiT7enpzFthEhAy0tkR0GI9K3bCPuVQwmUjq1akNu1G77t2AvAvA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XsJdhaxl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8C7606A31E
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 18:13:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F8C7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XsJdhaxl
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ab41538192so885650a91.0
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 11:13:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792779236; cv=none;
        d=google.com; s=arc-20260327;
        b=RYFJPR9vO70tu1NFwRD727AbJzDTNxMD/4Nu3OQ75FNIudTKVha61t+/YWnBbTFaDZ
         ccr9IjIjgnEWO20MqvKQWtvZe7Dv7in30eS3/d/LRf9RvpAECoM4ooVHmbDnB6s8+PHx
         +KqNtUjcy2+QFulA7VoZx4n0/IGfmok/llAyrf/OwjQap77edx7racbdgA4Cq2A7NhSn
         oVT9PTNA90dWn1XTtAzcfpTuB3NMU+wMmkDFgnDcyzF3ii9n+F8Nv+xHnKB2QJUdDAb5
         Bcg43lYQVKEDg39X/+nnw5RPnYMg0hR9O+o3QGEKTWXlM0mZsd/daAKq1XfI1rI3yTzP
         q+3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a8AhxehP29nTMFMYLaAQmj4iROvDwdVGWATuOgUSYxE=;
        fh=A7KzBehLnAyXTMx25izVpXRVP3mKCtCwvl/raXhp38g=;
        b=Lw0ly+YcsMOY47hZB3rsDQt91dGqLlbWWTbFKRE/KDeqxkatV+DHrZ9D0feBNNjxQE
         vry4YbgH63RZ/Z4HgpoENQNTFzD3LDD5YhFaxw7x5b8s9wAwpZ/mh1L+F28vzvczwMUL
         rwr/YvXEx/X/WpbgZ51IuDTkVoqdAHPlJ3frQbBe0765+yf8FAzFmBpHi22Pk+AFpwLT
         1Ru3Tdz6Bnyn41cWweDFz3mG4h9oBQ2X4FqdViwsFxoG20o7qtin5EnY3XRSfYt5bUWy
         kj4wuL5zmPqpd+kUO3de3w9ESRPJoUn8OXTIMcurHRDienpEVDhbIQUzD3tzdZB1tLVf
         QQWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792779236; x=1793384036; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a8AhxehP29nTMFMYLaAQmj4iROvDwdVGWATuOgUSYxE=;
        b=XsJdhaxlHUIV+RHxX+IslIZvg/0cJk3Jas2+lOtbhCi5h3POK3aAQYWGAKJSlgSlBG
         PhLR7BWQrw7Lws805TJLiOxUxCYox/cbyo4xrtd0HceO+4KwX9i4Nlce0IyMPdsWdlVV
         L5pukF/Oov+6kshOmkGgpaqb8xh79aydURJ1gFFD2CftTIC5HXlnO3WRbrM3oI6Y8lw6
         reoF7CnBh73ZCi97+S//5V1iLynG/2Rj3N9MfqCHha8tBhAACD4DxgxGobSCF0A/Fb+n
         /Y2K19+87cdeUnqExRe2K9eHCBr/y6OyI248S7cS3s80HJ1jVG+DZZIDfvOxB+//DgQb
         V5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792779236; x=1793384036;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a8AhxehP29nTMFMYLaAQmj4iROvDwdVGWATuOgUSYxE=;
        b=h+ITLFLGnkK8IGQWH4Vy47m/t1dFMsVV/2QxAiAvztuTyjcJkkKmsZ8Dx0t6KeeUxg
         wX9opO2t8aoDNVUxevLsQtLD+w4kI0Wd6F+HsZLzkyPCCYFFHjWX/S8VoaAVMogjQp3f
         ZfnZZwgnpuDy/Pqwmv4UZJYSbScqel78Zx8BXR2BGD3F7nTOz7Lx+axjxs2Pd3fYk2t3
         wNYE5H7EIBXSfc/tm7oToLrhuKb7jwX5eY3lPBLFdxKtSDmh5TW/RPRTbtMuIaTadW1E
         s2PyOB6yLthKBqAA4kJxKkzKXMQ8V7v7S+qk0tubMiLpgQmxvbmV7flT5ntCXB2YJwQ4
         uC0A==
X-Forwarded-Encrypted: i=1; AKwUvBwzTR2/stHmeZZ0ykOuKoXsaCL8PZT03txD7XRVBNNKWB5OJqL7FMp5rrndZplIM+5o/6Jj+8M=@vger.kernel.org
X-Gm-Message-State: AFq9FYICP0xl6oIVJlelt/P5wMvFM4YRjoIeXxKW3WkHWgc3qGAJuPeK
	WOfXzFeqd99r4CUMfW/jsSCNsno5TwMgcfKBKqKLHLYXgQZ6K861bTExKBA75QFmkMz3LrzhPnQ
	cLDTbln4zgLkhplvQ/14HgChCiYhgvgY=
X-Gm-Gg: AYBFou2DXoIOiwWHfVrrIzcJFUAVL6muIvAjLsQ6sAFStNOGhfFqgVutt8QeLQBvzzv
	NWlswWJDqnPBCaSvWsqLnuvsDoO16x3H69D4iVrLpMbHviq/GDbYC4qdWjLMu9q49Ae3NfzuVL4
	ctzVgzlTOhVYzDxYjr87ZLP2fJVZ+TINNIxL1oPg8WiyAWdkxOJki2BgLvt4YnnDMsL72de+VxL
	aBZjDRxCTqoS6Ar3QkwCtYDn7SVlsPNoW26CWpwSbps9BKZ0qoJUhfjxO8MfOFMj64TjvLcKGDP
	JF6Du7mwhRh1tlA2C38Zrmy33J7rwXp0jeeRq5PKfuWRDkbL8pZSu2X9lFdhZlqfQyZtvlJmL8x
	8FrMhblFxvzPSEONlD+PMVwB+mEd3gWbkwlugUw/+fiOEXyACRUAV9kPTvHD1jvrG5gPUGKqatU
	dtvjp7nnElUKeP2S5+zg==
X-Received: by 2002:a17:90a:ec8e:b0:3ac:e9d4:5530 with SMTP id
 98e67ed59e1d1-3adeae84a18mr82020a91.24.1792779236236; Fri, 23 Oct 2026
 11:13:56 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021174406.2891598-1-vineet.gupta@linux.dev> <20261021174406.2891598-2-vineet.gupta@linux.dev>
In-Reply-To: <20261021174406.2891598-2-vineet.gupta@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 23 Oct 2026 11:13:44 -0700
X-Gm-Features: AclHuK_b8jFh1n9PBk8gfcCMD41lkp9YMQ4GmFMcfbETjnWBAQczU9_yN8yeaC4
Message-ID: <CAEf4BzaTYgNwiBtvYoSw1wzuFZchs-2CCP93gh2OeDt-919-eQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] tracing: fgraph: allocate shadow stacks inline
 with GFP_NOWAIT
To: Vineet Gupta <vineet.gupta@linux.dev>, mhiramat@kernel.org, rostedt@goodmis.org
Cc: mark.rutland@arm.com, mathieu.desnoyers@efficios.com, andrii@kernel.org, 
	peterz@infradead.org, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 10:44=E2=80=AFAM Vineet Gupta <vineet.gupta@linux.d=
ev> wrote:
>
> When ftrace graphing is turned on, all tasks in the system missing
> return stack page are assigned one. This is done in a simplistic
> multi-sweep loop of FTRACE_RETSTACK_ALLOC_SIZE (currently 32) tasks
> at a time as follows:
>
>    start_graph_tracing()
>         do {
>                 alloc_retstack_tasklist
>         } while (-EAGAIN);
>
>    alloc_retstack_tasklist()
>         alloc x32           # GFP_KERNEL, may sleep
>         rcu_read_lock()     # preempt off
>                 for_each_process_thread    walk N_total, no cond_resched
>                      t->ret_stack =3D new_page
>         rcu_read_unlock()   # preempt enable but no explicit yield
>
> Each successive iteration of loop invokes for_each_process_thread()
> which doesn't support cursor based resume and always restarts from the
> init_task. Thus each successive loop needs to skip the tasks assigned
> ret_stack in prior sweeps and thus take longer and longer to find the
> candidate 32 tasks. And while the loop end calls rcu unlock,
> and re-enables preemption briefly, there is no explicit yield.
>
> The total number of iterations turn out to be
>
>         N_total * N_null / (2 * FTRACE_RETSTACK_ALLOC_SIZE)
>
> where N_total is the number of threads on the system and N_null the numbe=
r
> of those whose ret_stack is still NULL. After boot with no fgraph user th=
at
> is every thread.
>
> This is not a tracing-only path. Since commit 4346ba160409 ("fprobe:
> Rewrite fprobe on function-graph tracer") fprobe is built on fgraph,
> so an ordinary kprobe_multi BPF attach that flips ftrace_graph_active
> from 0 to 1 pays the whole cost inside one bpf() syscall. Commit
> 2c67dc457bc6 ("tracing: fprobe: optimization for entry only case")
> narrows that to return and session probes but does not remove it.
>
> A host running hundreds of thousands of threads, with the current batch
> size of 32, turns the ftrace_graph_active 0 -> 1 transition into a
> multi-second, and eventually multi-minute, operation which showed up as
> RCU stall and softlockup_panic on heavily loaded Meta Fleet machines
> with preemption disabled.
>
>     rcu: INFO: rcu_sched self-detected stall on CPU
>     rcu: 0-....: (20718 ticks this GP) (t=3D21000 jiffies g=3D913 q=3D8 n=
cpus=3D8)
>     CPU: 0 UID: 0 PID: 160141 Comm: bpftrace
>      ___slab_alloc+0x549/0xa20
>      kmem_cache_alloc_noprof+0x16c/0x340
>      register_ftrace_graph+0x3d7/0x6c0
>      register_fprobe_ips+0x2d5/0x310
>      bpf_kprobe_multi_link_attach+0x218/0x7e0
>      __sys_bpf+0x267a/0x27a0
>
> Fix this by allocating inline with GFP_NOWAIT instead of pre-allocating
> a fixed batch. GFP_NOWAIT does not sleep, so it is legal inside the RCU
> read-side critical section.
>
> A single sweep now serves every task, so the walk becomes O(N) rather
> than O(N_total * N_null), and the retry loop is no longer the normal
> path.
>
> The pre-allocated array remains as the fallback when GFP_NOWAIT fails.
> The runs below never needed it, so it was exercised with failslab
> injection: at a 100% failure rate every task falls back and -EAGAIN
> retries ~1560 times for 50000 threads, with no stall or splat.
>
> The open-coded rcu_read_lock() and the goto unwind are kept as-is so
> this stays easy to backport; converting them to scope-based cleanup is
> left to a follow-up.
>
> smp_store_release() is a drop-in replacement for the smp_wmb() and
> plain store it replaces.
>
> Measured on a 60-core Sapphire Rapids machine running a PREEMPT_LAZY
> kernel (CONFIG_PREEMPT_DYNAMIC=3Dy, mode lazy), timing the write that
> drives the ftrace_graph_active 0 -> 1 transition. Threads are spawned
> while fgraph is inactive so every one of them has ret_stack =3D=3D NULL,
> and the loop was instrumented to count sweeps:
>
>         threads   before              after
>                   sweeps   time       sweeps   time
>         100000     3126     15.3 s      1       0.019 s
>         200000     6253     59.1 s      1       0.047 s
>         400000    12503    227.8 s      1       0.092 s
>
> The sweep count is 1 throughout. Time now scales linearly with the
> thread count at roughly 230 ns per task, which is the allocation and
> initialisation of one shadow stack.
>
> Fixes: f201ae2356c7 ("tracing/function-return-tracer: store return stack =
into task_struct and allocate it dynamically")
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
> Tested-by: Vineet Gupta <vineet.gupta@linux.dev>
> Cc: stable@vger.kernel.org
> ---
>  kernel/trace/fgraph.c | 39 ++++++++++++++++++++++++---------------
>  1 file changed, 24 insertions(+), 15 deletions(-)
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>

I presume this will go through Masami and Steven's tree, is that right?

> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index ed455b53513b..4c74f1a15ad4 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -1033,13 +1033,16 @@ void ftrace_stub_graph(struct ftrace_graph_ret *t=
race, struct fgraph_ops *gops,
>  trace_func_graph_ret_t ftrace_graph_return =3D ftrace_stub_graph;
>  trace_func_graph_ent_t ftrace_graph_entry =3D ftrace_graph_entry_stub;
>
> -/* Try to assign a return stack array on FTRACE_RETSTACK_ALLOC_SIZE task=
s. */
> +/*
> + * Loop thru all the tasks in the system and assign ret_stack.
> + * The @ret_stack_list is a small pre-allocated fallback, in case
> + * the GFP_NOWAIT allocations here fail.
> + */
>  static int alloc_retstack_tasklist(unsigned long **ret_stack_list)
>  {
> -       int i;
> -       int ret =3D 0;
>         int start =3D 0, end =3D FTRACE_RETSTACK_ALLOC_SIZE;
>         struct task_struct *g, *t;
> +       int i, ret =3D 0;
>
>         if (WARN_ON_ONCE(!fgraph_stack_cachep))
>                 return -ENOMEM;
> @@ -1056,20 +1059,26 @@ static int alloc_retstack_tasklist(unsigned long =
**ret_stack_list)
>
>         rcu_read_lock();
>         for_each_process_thread(g, t) {
> -               if (start =3D=3D end) {
> -                       ret =3D -EAGAIN;
> -                       goto unlock;
> -               }
> +               unsigned long *rs;
>
> -               if (t->ret_stack =3D=3D NULL) {
> -                       atomic_set(&t->trace_overrun, 0);
> -                       ret_stack_init_task_vars(ret_stack_list[start]);
> -                       t->curr_ret_stack =3D 0;
> -                       t->curr_ret_depth =3D -1;
> -                       /* Make sure the tasks see the 0 first: */
> -                       smp_wmb();
> -                       t->ret_stack =3D ret_stack_list[start++];
> +               if (t->ret_stack)
> +                       continue;
> +
> +               rs =3D kmem_cache_alloc(fgraph_stack_cachep, GFP_NOWAIT);
> +               if (!rs) {
> +                       if (start =3D=3D end) {
> +                               ret =3D -EAGAIN;
> +                               goto unlock;
> +                       }
> +                       rs =3D ret_stack_list[start++];
>                 }
> +
> +               atomic_set(&t->trace_overrun, 0);
> +               ret_stack_init_task_vars(rs);
> +               t->curr_ret_stack =3D 0;
> +               t->curr_ret_depth =3D -1;
> +               /* Make sure the tasks see the 0 first: */
> +               smp_store_release(&t->ret_stack, rs);
>         }
>
>  unlock:
>
> base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
> --
> 2.53.0-Meta
>
