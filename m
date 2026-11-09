Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794249842;
	b=uUB0oBBSvNaTDHSwvr3FlZGlUg3NXsvctxldZBKf2GaeVCbVxLU6oa2fc56Qdv/BQvM5
	 j83SpzBsTjsPBx3vaIsG6ddp6UXpQT8SEVa6DxdThGMJdFGG40VxOlTWLFkOaLZYbmujq
	 25w3pUtY3m84pXk/CNcnksZfImfX5GT/BYT2M0g8SaCPYOc+VPEWcg+YmnbN6T0hKabnb
	 V+HViCzSYw9vYBW+v4qyvyfNHB1Q52GL/CdJOIPf+EpuuA+hoZsl9VJotA0lhUFi21/7Z
	 x749GdEOj0RbNatUe7iTIqzE99Uj6z/zTAF6Gq8h7fik7jfJ1iUUvercFjwqWX5Flzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794249842;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=da11Hl37urAgXVs2QJqiBOsIxcQzXPZKoHryymoOheY=;
	b=nYZerp2OTFqo/n15Dr3CV/7nm3Hy4OHpsobJ3/N7Bpc58yu57WdbUQQHmbh+V2CxuXDh
	 3DXJVtzayM5l6NBQ5oAKsLG0Ns6nH/JIG8My6cNM23inbTbRn4UPAy6+wnnWen9C17XpE
	 TFrJmTJT6RXYCVw8B80t1TMS5XEJGc+xuW9pYM75wkg5I8R00KwmA6Wmy/gJhIIOU7JpU
	 AnmBATSnMumltjD6/l9vfW5jNUp4kwAA/Wf9jzmPBrZeitEMmTKf21LfJEZdDKxIvAzrD
	 MpSIpV7FiVwFxOsYvtTQRjZXBvbMDxvLMVXwumQ11PGTYwFk/FJo8ubJt2JlLy9bb7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=runbox.com;
	spf=pass smtp.mailfrom=runbox.com;
	dkim=pass header.d=runbox.com header.i=@runbox.com header.a=rsa-sha256 header.s=selector1 header.b=VSonogea;
	arc=none smtp.remote-ip=185.226.149.37
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C190606A326;
	Mon,  9 Nov 2026 18:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C190606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=runbox.com header.i=@runbox.com header.a=rsa-sha256 header.s=selector1 header.b=VSonogea
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <m.v.b@runbox.com>)
	id 1xQUL4-00DZYI-Px; Mon, 09 Nov 2026 19:43:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References
	:Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=da11Hl37urAgXVs2QJqiBOsIxcQzXPZKoHryymoOheY=; b=VSonogeaVwrcJihCTyhQfzij8C
	elBF0spskqW9NzZmR4pFpcg/iiUuzTIpIdef8MxHPluh13A5C0DUa8XMgKigjeMZ62tBUV6ahyd43
	4kJEf8C4AxtzVtqYNZYpuLHDtLrQNZj8i7nq41+sfBKjs/LE9lhjHtke260cJDAqn70ehgHrGyazG
	6/bQsNaLW5aWAGyxLCtkDBCKSge49jZN+Q/4g+L1SjaaHfbKP7sKvD6aZEJJYtjaz4EDRloXMt7yg
	2dE2vh3tKpPMbXEsoObeMwwekpJWKTULl5BB4ZrNxRt2QaNafXZ8RYL5zDXIdIfaT/pij1yGXKEZu
	xCNO721g==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <m.v.b@runbox.com>)
	id 1xQUKa-0004D0-VI; Mon, 09 Nov 2026 19:43:01 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (536975)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xQUKJ-00DckN-Bo;
	Mon, 09 Nov 2026 19:42:43 +0100
Message-ID: <d2577859-1468-4892-af5b-7912aabd402a@runbox.com>
Date: Mon, 9 Nov 2026 10:42:32 -0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "M. Vefa Bicakci" <m.v.b@runbox.com>
Subject: Re: [PATCH] x86/xen: Fix lazy MMU pause count wrap-around
To: Juergen Gross <jgross@suse.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261102-xen-lazy-mmu-v1-1-d99a3050b76d@runbox.com>
 <36064075-fbf0-40ac-8448-60bd36ad2a28@suse.com>
Content-Language: en-US
In-Reply-To: <36064075-fbf0-40ac-8448-60bd36ad2a28@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-11-09 01:40, Juergen Gross wrote:

> On 02.11.26 16:31, M. Vefa Bicakci wrote:
>> Commit bec6f41a6fe5 ("x86/xen: Get rid of last XEN_LAZY_MMU uses")
>> unintentionally prevents the activation of lazy MMU mode for most tasks
>> running on Xen PV VMs (including dom0).
>>
>> That commit made xen_end_context_switch() call
>> __task_lazy_mmu_mode_resume() with the task being switched to. However,
>> the latter function decrements the pause_count field of the task without
>> checking whether that task's lazy MMU mode was paused or not. A task
>> being switched to for the first time has never been switched from, so
>> attempting to resume lazy MMU mode can wrap-around (underflow) the
>> pause_count from 0 to 255 (U8_MAX).
>>
>> Furthermore, the non-zero pause_count is copied to child tasks at fork,
>> so all descendants (including the idle tasks of the non-boot CPUs)
>> inherit the non-zero pause_count. This prevents enabling lazy MMU mode
>> for them, because lazy_mmu_mode_enable() does not do anything when
>> pause_count is non-zero.
>>
>> Hence, call __task_lazy_mmu_mode_resume() from xen_end_context_switch()
>> only if lazy MMU mode was paused.
>>
>> This issue was discovered with CONFIG_DEBUG_VM=y, which enables
>> pause_count underflow and overflow warnings. In the examples quoted
>> below, the first warning shows the underflow with PID 1. The second
>> warning shows the overflow from 255 (U8_MAX) to 0, also for PID 1, as
>> indicated by the same RDI register value.
>>
>> Example pause_count underflow warning:
>>
>>    WARNING: include/linux/pgtable.h:362 at xen_end_context_switch+0x4e/0x60, CPU#0: swapper/0/0
>>    CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.2.4-1 #2 PREEMPT(full)
>>    RIP: e030:xen_end_context_switch+0x4e/0x60
>>    ...
>>    RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888004930000
>>
>> Note: The PID is shown as 0 above, because current_task is updated in
>> __switch_to() after arch_end_context_switch(). arch_end_context_switch()
>> calls xen_end_context_switch() indirectly.
>>
>> Example pause_count overflow warning:
>>
>>    WARNING: include/linux/pgtable.h:319 at xen_start_context_switch+0x64/0x70, CPU#0: swapper/0/1
>>    CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W  7.2.4-1 #2 PREEMPT(full)
>>    ...
>>    RIP: e030:xen_start_context_switch+0x64/0x70
>>    ...
>>    RDX: 0000000000000000 RSI: 0000000013f7894d RDI: ffff888004930000
>>    ...
>>    Call Trace:
>>     <TASK>
>>     __schedule+0x36a/0x1a90
>>     schedule+0x27/0xa0
>>     schedule_timeout+0xbd/0x100
>>     __wait_for_common+0x97/0x1b0
>>     wait_for_completion_killable+0x24/0x40
>>     __kthread_create_on_node+0x13e/0x240
>>     kthread_create_worker_on_node+0xee/0x1c0
>>     workqueue_init+0x26/0x420
>>     kernel_init_freeable+0x101/0x360
>>     kernel_init+0x1a/0x130
>>     ret_from_fork+0x2b0/0x340
>>     ret_from_fork_asm+0x1a/0x30
>>     </TASK>
>>
>> Fixes: bec6f41a6fe5 ("x86/xen: Get rid of last XEN_LAZY_MMU uses")
>> Cc: stable@vger.kernel.org # 7.2.x
>> Signed-off-by: M. Vefa Bicakci <m.v.b@runbox.com>
>> ---
>> === Testing notes ===
>> This commit was tested with kernel v7.3-16755-gd135ab453a74 and v7.4-rc1
>> with a domU PV VM, and versions from v7.2.4 to v7.2.14 with dom0 and
>> domU PV VMs running on Xen v4.19.5. CONFIG_DEBUG_VM=y was set for all
>> tests, and no warnings were observed.
>>
>> === Debugging notes ===
>> For debugging, I instrumented xen_start_context_switch(),
>> xen_end_context_switch() and copy_process(), and I confirmed that the
>> inherited pause_count value is decremented for each level of the process
>> tree, starting from 255.
>>
>> === Credits ===
>> The patch was hand-written, but the commit message was polished with a
>> few rounds of LLM review.
>> ---
>>   arch/x86/xen/enlighten_pv.c | 10 +++++++++-
>>   include/linux/sched.h       | 19 +++++++++++++++++++
>>   2 files changed, 28 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
>> index c5117a7730d6..68f8a977999b 100644
>> --- a/arch/x86/xen/enlighten_pv.c
>> +++ b/arch/x86/xen/enlighten_pv.c
>> @@ -431,7 +431,15 @@ static void xen_end_context_switch(struct task_struct *next)
>>         xen_mc_flush();
>>       this_cpu_write(xen_cpu_lazy_mode, false);
>> -    __task_lazy_mmu_mode_resume(next);
>> +
>> +    /*
>> +     * A newly created task can be switched to without ever having been
>> +     * switched from, so it will not have a prior lazy MMU pause to undo
>> +     * from xen_start_context_switch(). Hence, resume lazy MMU only if it
>> +     * was paused.
>> +     */
>> +    if (__task_lazy_mmu_mode_paused(next))
>> +        __task_lazy_mmu_mode_resume(next);
>>   }
>>     static unsigned long xen_store_tr(void)
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index 1c93da75226e..3f9341f1f827 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -1791,6 +1791,25 @@ static inline bool is_lazy_mmu_mode_active(void)
>>         return __task_lazy_mmu_mode_active(current);
>>   }
>> +
>> +/**
>> + * __task_lazy_mmu_mode_paused() - Return a task's lazy MMU mode pause state
>> + * @tsk: The task to check.
>> + *
>> + * Test whether @tsk has its lazy MMU mode state set to paused
>> + * (i.e., pause_count > 0).
>> + *
>> + * This function is intended for architectures that implement the lazy MMU
>> + * mode; it must not be called from generic code.
>> + *
>> + * Return: Whether task @tsk has paused lazy MMU mode.
>> + */
>> +static inline bool __task_lazy_mmu_mode_paused(struct task_struct *tsk)
>> +{
>> +    struct lazy_mmu_state *state = &tsk->lazy_mmu_state;
>> +
>> +    return state->pause_count > 0;
>> +}
>>   #endif
>>     extern struct pid __rcu *cad_pid;
> Thanks for finding this issue.

Thanks for taking the time to review and provide feedback!

> While your patch is fixing the problem, I'd prefer fixing the root cause:
> When setting up a new struct task_struct, the initial lazy_mmu_state state
> should be initialized accordingly. This would require another lazy_mmu_state
> hook for initializing it, probably via a simple static_call(). Xen could use
> that for setting the pause count to 1.
> 
> At the same time __task_lazy_mmu_mode_resume() should probably WARN() if
> the pause count is 0 already and NOT decrement the pause count.
> 
> Thoughts?

I agree that your proposed approach is indeed more elegant.

To confirm my understanding: Setting every new task's pause count to 1
will ensure that the first context switch into that task will not underflow
the pause count. Also, making __task_lazy_mmu_mode_resume() return early
with a warning if the pause_count is already zero would guard against
encountering the same issue again.

Do you intend to take this on, or would you like me to take a stab at this?

Thank you,

Vefa
