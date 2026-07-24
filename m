Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925413AE71C
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 20:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784924612; cv=none; b=C2E+YMhDCVgcb+aUimpbxx9X/vKwYJreoEpuNgdmL8ECefQ0T1OyW5cRTaujzq2JR23KIwlzC+AAQYeYMN+gW2XGuOzDH1i68ViWjeQfpC1Kk+g7uplLUIpqKwkcuqiEBYnbpvMIro9FSusfOfa/sZKb0mdxnjErosPYNjPVWdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784924612; c=relaxed/simple;
	bh=TfKhnpfoZGid4lUQS3hdMUvrMV4BeOLirnVzOmlaZGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oTHK/SA37E+5d7xc5hjOcCafo4T9ucoIIhgKv7b34BbQZaIQTTpn4w0Z3I6mEb+hNrmWxzP1pkC8YXdIRu9xDlcR1UO7DbrYLzD/4JzAIBAiPiS7uY/YJaS+VK336vvvbVFz/3mk0XR0cqh1axtKkAjDUSwGEk+UGfXJVpltdAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l3wHa/h6; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l3wHa/h6"
Message-ID: <4aa21cf3-0ed6-424c-9c96-425e2e5ed586@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784924607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u9/FnaqJCQNFnMxcYpixMPndBjkyhNtP1Lu7zU8vlWM=;
	b=l3wHa/h66fAXY4/nX37qOASuW6ga50HSR8bLkkzGOI4kahMhBYSVudfuCsYZeMGOrL1w9e
	p8cXFYmLA78R7EM33KkZSRcYsYPZb/3TutbJNQRtV7f/JuEtx4zElrU3Ez0a9lO50M9Pp8
	k2Sr8Q8Yv1ywdRMgg90rKTXPWl8b7JE=
Date: Fri, 24 Jul 2026 13:23:21 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 9/9] bpf: Disable preemption in __bpf_get_stack
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: stable@vger.kernel.org, Tao Chen <chen.dylane@linux.dev>,
 STAR Labs SG <info@starlabs.sg>, bpf@vger.kernel.org,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <songliubraving@fb.com>,
 Yonghong Song <yhs@fb.com>, Quentin Monnet <qmo@kernel.org>
References: <20260720085351.655075-1-jolsa@kernel.org>
 <20260720085351.655075-10-jolsa@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260720085351.655075-10-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026-07-20 1:53 a.m., Jiri Olsa wrote:
> From: Daniel Borkmann <borkmann@iogearbox.net>
> 
> get_perf_callchain() returns a per-CPU perf_callchain_entry buffer and
> releases its recursion slot via put_callchain_entry() before returning,
> so nothing keeps the entry reserved while __bpf_get_stack() consumes
> it below.
> 
> A preemptible BPF program (e.g. a non-sleepable raw tracepoint program
> on a PREEMPT kernel, which runs under migrate_disable() but not
> preempt_disable()) can be scheduled out between obtaining the entry
> and the copy. Another task scheduled on the same CPU then reuses the
> same per-CPU buffer and overwrites trace->nr with a larger value.
> copy_len is then computed from the inflated trace->nr and can exceed
> the caller's buffer, causing an out-of-bounds write in the memcpy()
> and in the build_id path.
> 
> The rcu_read_lock() previously taken here does not prevent this. It is
> only taken on the may_fault path, and under CONFIG_PREEMPT_RCU it does
> not disable preemption; it merely keeps perf's callchain buffer array
> alive (freed via call_rcu()) and does nothing to stop another task
> from reusing the entry.
> 
> Disable preemption around obtaining the callchain entry and copying
> it into the caller's buffer, so the entry cannot be reused underneath
> us and trace->nr stays bounded by max_depth. Build ID resolution may
> fault and is therefore deferred until after preemption is re-enabled;
> by then the instruction pointers have already been copied into buf,
> so it operates only on that private copy. Note, preempt_disable() also
> subsumes the buffer-lifetime guarantee the rcu_read_lock() provided,
> since a preempt-disabled section is an RCU read-side critical section
> for the callchain buffers' call_rcu() reclaim.
> 
> Cc: stable@vger.kernel.org
> Fixes: c195651e565a ("bpf: add bpf_get_stack helper")
> Reported-by: Tao Chen <chen.dylane@linux.dev>
> Closes: https://lore.kernel.org/bpf/20260206090653.1336687-1-chen.dylane@linux.dev/
> Reported-by: STAR Labs SG <info@starlabs.sg>
> Signed-off-by: Daniel Borkmann <borkmann@iogearbox.net>
> [ changed Fixes: commit ]
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>   kernel/bpf/stackmap.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 57cd4c33403b..37f8e46319b3 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -819,8 +819,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>   
>   	max_depth = stack_map_calculate_max_depth(size, elem_size, flags);
>   
> -	if (may_fault)
> -		rcu_read_lock(); /* need RCU for perf's callchain below */
> +	preempt_disable();

With the series applied on bpf-ci-like kconfig I get a "suspicious RCU
usage" splat on BPF selftests, pasted at the bottom.

AFAIU, the rcu_read_lock() that's removed here was not only
controlling the lifetime (which is now covered by preempt_disable),
but also putting the RCU read-side annotation for the

	entries = rcu_dereference(callchain_cpus_entries);

in get_callchain_entry() (callchain.c:163).

preempt_disable() never takes rcu_lock_map, and a sleepable program
holds only rcu_read_lock_trace() (rcu_tasks_trace_srcu_struct), which
is a different lockmap. So on PREEMPT_RCU + PROVE_RCU the
rcu_dereference_check() there now fails (see the splat).

The non-sleepable path is fine because it enters with rcu_read_lock()
held via rcu_read_lock_dont_migrate().

I think to fix this we have to keep if (may_fault) rcu_read_lock();
alongside preempt_disable(). Something like this:

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 37f8e46319b3..6be413072ef6 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -820,6 +820,8 @@ static long __bpf_get_stack(struct pt_regs *regs, 
struct task_struct *task,
         max_depth = stack_map_calculate_max_depth(size, elem_size, flags);

         preempt_disable();
+       if (may_fault)
+               rcu_read_lock();

         if (kernel && task) {
                 trace = get_callchain_entry_for_task(task, max_depth);
@@ -829,6 +831,8 @@ static long __bpf_get_stack(struct pt_regs *regs, 
struct task_struct *task,
         }

         if (unlikely(!trace) || trace->nr < skip) {
+               if (may_fault)
+                       rcu_read_unlock();
                 preempt_enable();
                 goto err_fault;
         }
@@ -836,6 +840,8 @@ static long __bpf_get_stack(struct pt_regs *regs, 
struct task_struct *task,
         trace_nr = callchain_store(trace, buf, size, elem_size, flags);

         /* trace should not be dereferenced after this point */
+       if (may_fault)
+               rcu_read_unlock();
         preempt_enable();

         return callchain_finalize(buf, size, trace_nr, elem_size, 
user_build_id, user, may_fault);


I confirmed this diff fixes the splat below.

I guess teaching the perf side to accept rcu_read_lock_sched_held()
would also work, but that's out of scope for a bpf fix and may be no
less tricky.


[    9.083612] =============================
[    9.083795] WARNING: suspicious RCU usage
[    9.085691] 7.2.0-rc3-gd7530927491c #2 Tainted: G           OE
[    9.086212] -----------------------------
[    9.086394] kernel/events/callchain.c:163 suspicious 
rcu_dereference_check() usage!
[    9.086736]
[    9.086736] other info that might help us debug this:
[    9.086736]
[    9.087108]
[    9.087108] rcu_scheduler_active = 2, debug_locks = 1
[    9.087394] 2 locks held by uprobe_multi/237:
[    9.087612]  #0: ffffffff85479e38 
(rcu_tasks_trace_srcu_struct){....}-{0:0}, at: 
uprobe_notify_resume+0x2af/0xe40
[    9.088091]  #1: ffffffff85479e38 
(rcu_tasks_trace_srcu_struct){....}-{0:0}, at: uprobe_prog_run+0x5e3/0xb20
[    9.088553]
[    9.088553] stack backtrace:
[    9.088752] CPU: 0 UID: 0 PID: 237 Comm: uprobe_multi Tainted: G 
      OE       7.2.0-rc3-gd7530927491c #2 PREEMPT(full)
[    9.088760] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[    9.088762] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 1.16.3-5.el9 11/05/2023
[    9.088766] Call Trace:
[    9.088769]  <TASK>
[    9.088773]  dump_stack_lvl+0x83/0xa0
[    9.088783]  lockdep_rcu_suspicious+0x151/0x1c0
[    9.088798]  get_callchain_entry+0x19b/0x260
[    9.088808]  get_perf_callchain+0x352/0x7f0
[    9.088818]  ? __pfx_get_perf_callchain+0x10/0x10
[    9.088822]  ? unwind_get_return_address+0x5e/0xa0
[    9.088829]  ? __pfx_stack_trace_consume_entry+0x10/0x10
[    9.088835]  ? srso_return_thunk+0x5/0x5f
[    9.088851]  ? srso_return_thunk+0x5/0x5f
[    9.088855]  ? __lock_acquire+0x41f/0x2520
[    9.088870]  __bpf_get_stack+0x2f1/0x420
[    9.088886]  ? __pfx___bpf_get_stack+0x10/0x10
[    9.088900]  ? srso_return_thunk+0x5/0x5f
[    9.088913]  bpf_prog_51bb4c0f31ae471b_uprobe_sleepable+0x2d/0x42
[    9.088921]  uprobe_prog_run+0x405/0xb20
[    9.088929]  ? srso_return_thunk+0x5/0x5f
[    9.088937]  ? __pfx_uprobe_prog_run+0x10/0x10
[    9.088947]  ? lock_acquire+0x176/0x2e0
[    9.088953]  ? srso_return_thunk+0x5/0x5f
[    9.088971]  ? uprobe_multi_link_handler+0x4c/0xb0
[    9.088977]  uprobe_multi_link_handler+0x4c/0xb0
[    9.088987]  handler_chain+0x1bb/0x1530
[    9.089002]  ? lock_acquire+0x176/0x2e0
[    9.089007]  ? __kmalloc_cache_noprof+0xd4/0x610
[    9.089016]  ? __pfx_handler_chain+0x10/0x10
[    9.089023]  ? srso_return_thunk+0x5/0x5f
[    9.089030]  ? srso_return_thunk+0x5/0x5f
[    9.089034]  ? kasan_save_track+0x14/0x30
[    9.089040]  ? srso_return_thunk+0x5/0x5f
[    9.089045]  ? __kasan_kmalloc+0x7f/0x90
[    9.089053]  ? srso_return_thunk+0x5/0x5f
[    9.089057]  ? srso_return_thunk+0x5/0x5f
[    9.089062]  ? lockdep_init_map_type+0x4b/0x220
[    9.089069]  ? srso_return_thunk+0x5/0x5f
[    9.089073]  ? timer_init_key+0xfc/0x240
[    9.089081]  ? srso_return_thunk+0x5/0x5f
[    9.089085]  ? lockdep_init_map_type+0x4b/0x220
[    9.089098]  uprobe_notify_resume+0x53d/0xe40
[    9.089102]  ? srso_return_thunk+0x5/0x5f
[    9.089107]  ? srso_return_thunk+0x5/0x5f
[    9.089111]  ? find_held_lock+0x2b/0x80
[    9.089118]  ? atomic_notifier_call_chain+0x7a/0x110
[    9.089127]  ? __pfx_uprobe_notify_resume+0x10/0x10
[    9.089139]  ? srso_return_thunk+0x5/0x5f
[    9.089143]  ? atomic_notifier_call_chain+0x84/0x110
[    9.089150]  ? srso_return_thunk+0x5/0x5f
[    9.089158]  ? notify_die+0x8b/0x110
[    9.089174]  exit_to_user_mode_loop+0x9a/0x430
[    9.089192]  exc_int3+0x295/0x2c0
[    9.089204]  asm_exc_int3+0x39/0x40
[    9.089210] RIP: 0033:0x6c4176
[    9.089216] Code: 13 55 48 89 e5 e8 7a ff ff ff c6 05 0b 6f 2d 00 01 
5d c3 90 c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f3 0f 1e fa eb 
8a <cc> 48 89 e5 b8 00 00 00 00 5d c3 55 48 89 e5 b8 00 00 00 00 5d c3
[    9.089219] RSP: 002b:00007fff8e88c458 EFLAGS: 00000246
[    9.089223] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
00007f4babb9404b
[    9.089226] RDX: 00007fff8e88c47f RSI: 0000000000001000 RDI: 
00000000007a0000
[    9.089229] RBP: 00007fff8e88c490 R08: 00007f4babc88330 R09: 
00007f4babce40c0
[    9.089231] R10: 00007f4baba90d98 R11: 0000000000000202 R12: 
00007fff8e88c5c8
[    9.089233] R13: 0000000000793ac1 R14: 000000000099ade8 R15: 
00007f4babd17000
[    9.089259]  </TASK>


pw-bot: cr


>   
>   	if (kernel && task) {
>   		trace = get_callchain_entry_for_task(task, max_depth);
> @@ -830,16 +829,14 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>   	}
>   
>   	if (unlikely(!trace) || trace->nr < skip) {
> -		if (may_fault)
> -			rcu_read_unlock();
> +		preempt_enable();
>   		goto err_fault;
>   	}
>   
>   	trace_nr = callchain_store(trace, buf, size, elem_size, flags);
>   
>   	/* trace should not be dereferenced after this point */
> -	if (may_fault)
> -		rcu_read_unlock();
> +	preempt_enable();
>   
>   	return callchain_finalize(buf, size, trace_nr, elem_size, user_build_id, user, may_fault);
>   

