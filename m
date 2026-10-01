Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9882F4B5CA2
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 13:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790860769; cv=pass; b=Tr4HO1f5m2QEOWkszmKCvQa6wHpjBSFuOCVnFPiEXEVwncRxoJ+n3EFAx2kwWHqP+99GPnwlbf2FoAnVTczj8I/ies9QOu6ufmRLLqVEQIIqOeSfQ6ORx7jI39KC2+/utgPu+sqAM6C/BoUuHS5G7ycD9IfBsdW8tGjrNJwL4GI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790860769; c=relaxed/simple;
	bh=MGoLCFq6aq9zjFkPP2Nfb6QnY8ZNRoyt4k7h8AtCGr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mZkMmZgL3cHDBMuDdUHf7yZhcgu9o4JK9CVBibR5BmmBp83n8snzdnUh2agxENFSkzgEx3NntOe8ieHgAZ0cQtBV0/l+sr6ORTjhI29IeHc8F6kEDQCADoYtknXR1zEMgv2mcdQD2Pq8jlS1XCfISt27eOMapx73RFoIFv19Jms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r+YdNX2x; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+YdNX2x"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d91ede8035so54626355ad.3
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 06:19:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790860766; cv=none;
        d=google.com; s=arc-20260327;
        b=iVrULmRhnun0rH21vn2Dx15LGJprwoIeiNgcsN6d4RRVQjin9WWYo9/docv8Z3O3vY
         wNfTu2J+CgPkXrgUMPfXYqxoiu90+wLVJpdNnqWG112Gwb6uRvgN9Pv+b2Z39iZL6+V6
         vx2H3qshpHZTcMMU428Qi7AN8e2QRjr1MG4evlDvGjY7L8w6zlnYBewKDthzq0g1Ma2i
         QQ4xW5AqD56KvGmaQ/0KDAM0NtSiPSfBW9tjwH7SMGiaRvwKDuAsZk59j3Akz0PwLtne
         Nk6mi71gavugg1Gcrc75RL1fWZ0ue78NTRZV8hwqqVyjyZW996imLLpGlE4xyebRKC2z
         yQng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A3+Wqr49x4V2nVh+8mNnV24xRF8uklacV4tlWKmUiY0=;
        fh=fhK3v/zz11MDa4D2CGWhTjSjvfnk/gMxfnrpk3RWM0s=;
        b=K9/lPetO6GfIUCFb2Fy6QkFrYOEYEQ+8GKsr2vHvw1WV2G9HjsR6zquYgIIFwhRlEe
         hRc7rqe3DiZ8GhxP+LqQSw5ku8okUEtnoCX6Q6yvmJPMGWZIm6VZeJpSWK7DRANlDoh1
         TQNMmCKc+EdtdHl/hwr4g3P9ijGFprRMOKQSPkITxJjfMrX+aj2xZt/Cq0EOSEUTj8RD
         0lBaEqnPx8GOxVkAWZwPCqNfhyojEzO7s/Go2IEbYaL7K1iticGs4e3oTVWYjz6+DMKT
         NNoPEowGfRLRO/S2+fUfmkAOs673DfUpif3tWHCZ6Y7SFnduqtoescXRrRMr/8cdymJt
         qKTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790860766; x=1791465566; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A3+Wqr49x4V2nVh+8mNnV24xRF8uklacV4tlWKmUiY0=;
        b=r+YdNX2xClnVd6gznQXkY03q6gNlYyHYeg16KYRhORS13jq/TxPSZEkkK7+uD8uuHk
         Rfw9WCwz0/qU3hcZsHlx6L4gHH43YpaCzr2px7tz+clFFXuymYWxhBnYVOphgPvHsrjt
         xyjaQ+plzMQB7bdCMLxKZSJbxX9V9+0FBMvTShK/iyHr9WxgE7Wx7UwjgdYOqE/4sY0S
         Vt7mlGcDadrgI8g1+pp55x6pgIBjTsnlAt+7Y0F21DOg/dzeI3dYyzqSir1Rx3KPlrdZ
         7l6JEJhtqx5+l9B+Wbvvhsl7lO7v2HKrVeP2XN0DIFLfYRUvv8POQGUu39/uNavdIxTq
         bBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790860766; x=1791465566;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A3+Wqr49x4V2nVh+8mNnV24xRF8uklacV4tlWKmUiY0=;
        b=kPacC5yLpv8a3oS/CkO6Pk4SRUqYbWzhVFzQ6GNKDVk2lgfbcPWCuloUpzDCPrtNZJ
         zpk6DrdNnuOXxQgBwkjW8czK+IYiHotso8dzMBxIG6r7MWVNUtjGkJqklBE96tcMwuPh
         SIZoU7h/GOWQ3RhxcSHZJdjhEl3U1mH0pNnQ9O7ucrLgpLpF0cWKdOPiWnqXDFTqIdaA
         l8a7r6eg9zdx73El1yZkXjy+iC4s+WdIrDLG4EaapERkU3ccC4vOrh3zPMkYPnHv71YZ
         CDjaHfXfVJJomebUdvBhWP+whgQRdgC3UYluaZXU/u8NbAK0yq4TnpeaLInr+ExsUCWL
         bG1w==
X-Forwarded-Encrypted: i=1; AKwUvBxoB07Zs1gMkZq3Ft2IEXPUeSotdcB6+2QgLVKveEwH/zOrMYFHbCCUqXMWvgSvAX2T4qUf7kY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKMDKNZJXJgLX2ewGt4wgKjJ4ScgbXmQ77B3Ymog0nKpnJg58xN
	S3Mj1h+H35njgL5CH8HiaAAhzG72FIwkf24c8evdUdwfon2Oa0CGSg/Wp+19W5GnkGTkN5KLXNu
	R6UDQTAQwOM9b2VwK0j6JNyj+P7/XbZM=
X-Gm-Gg: AYBFou1d3b+ZOJHFS73Ej4F5dEI3mWj2yGrD6SGDPrLc4Z4US2p9+NfdSFd0Q4F4aOY
	VY6/Bn4b+3RHejgFS7a1lLv1CPHUET7r3w1PLdqrct09dOECGs1+tdURgU0JeyKKU+hcnaTlEB8
	z8uSfxwuLXyMaAUVX9phY0EjHmTdPjGRls8HENwJPSFb9I1x/v5yt5CPdznHnJSozXl74ONB8x2
	YLmyMAHdJmAIaKBC6XACwu+jQW9uWQ2HSD68cQKDZ7JpfVdCb+ONu8zHSVOsb9FekE+8zikqYdB
	DkV/5E2gkr8pDSHU90undgbTriNB+IKiXFVMQvRthoPijekk/F/AtSGHmDp7o81L43+vk7b5gKA
	gfdmt54dO13NUbO7ALsFjtjDqSLP5Ku+z977OKrjoEt1uW5S9uMe5
X-Received: by 2002:a17:903:1a28:b0:2e2:c3a2:9b15 with SMTP id
 d9443c01a7336-2e2e48ada16mr38741635ad.6.1790860765556; Thu, 01 Oct 2026
 06:19:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001102909.1152572-1-vineet.gupta@linux.dev> <20261001102909.1152572-2-vineet.gupta@linux.dev>
In-Reply-To: <20261001102909.1152572-2-vineet.gupta@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 1 Oct 2026 14:19:11 +0100
X-Gm-Features: AclHuK_MvWdsgJmdHLGbWvavOLFidBs-vhdRf7_lOy5zycebQreGhiK9WQ5bEo8
Message-ID: <CAEf4BzYghT0yXELLODsXbHS4_upUDx9cwP9YU0cFVVREM2hmEw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] tracing: fgraph: allocate shadow stacks inline
 with GFP_NOWAIT
To: Vineet Gupta <vineet.gupta@linux.dev>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com, 
	mathieu.desnoyers@efficios.com, andrii@kernel.org, peterz@infradead.org, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 11:29=E2=80=AFAM Vineet Gupta <vineet.gupta@linux.de=
v> wrote:
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
> scoped_guard(rcu) replaces the open-coded rcu_read_lock() and the
> goto unlock, which is what makes returning directly from inside the
> critical section legal.
>
> The pre-allocated array remains as a fallback, although the testing
> below never needed it.
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
>  kernel/trace/fgraph.c | 44 ++++++++++++++++++++++++++++---------------
>  1 file changed, 29 insertions(+), 15 deletions(-)
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]
