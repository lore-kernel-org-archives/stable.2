Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793067423;
	b=SS65mFgK6ASLdIa33COBxFrYQti6H/cma2zPdXoXQ+yzBXXG9qv8vrKiG5k5C78eF07O
	 0BrBvF0AwSuxo2ZM36hFUBxJpWyrwg72qQSwG+EK0//hSZT8PAqN++h2WM6N7DIJA++VJ
	 9u0DBFfGh3kiE1fsLDu35Hu9ClLovZV08JZL1vcapRHRETcJM9dhSAZL5XOTW/TLwtbXv
	 DgVEObkdQJ26CBxIlIvDhyZpshwPx1zIx6dQBsSrJaeoeMhpqdWU7lGSsjhf4HDWOdzLV
	 2CT3dBuMeh4m/rMoiH7zeh6G3XzyjEoxgI7FMRqlV91wQpOyAJUYANTIB0Uk/oqSfBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793067423;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
	bh=3ojf1XO/iaoieDVB5HRoBecDQ4hVUQJNCe5eIUaEZK4=;
	b=DaxOD7mdHHOClRMiemj07VWJCqNUsOGPfAGjLcBgdgmbDRCoaHbDhVO9F8MfDTYobCUt
	 0unP8P1l3t1UEQe/wph7YGRzI5gg/eyyoIMSM12jkcVX4zTb9ayNCQkb0ZfiwJAPOC2YX
	 GDsT8jA6neNAWh8JgAZ9d1bXEvnWAAQn+QFkBEIQVDTkBqJXxb+FCbkAo/zgTfJChlrHH
	 XTok+WQ4WCfz3TisTOkTlUjLtzXogbohkCNhKdtdzGqLLgL/hrJpi+nb6nYIAeDXo+4iE
	 gSeGGK0scx/MDzMXAkMvcd+kI3z5TkOguXE4G4nFBt5Q7bdhvzavPkdSxI2YpONBhiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=aTRpZpwI;
	arc=none smtp.remote-ip=113.46.200.227
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C972C606A31A;
	Tue, 27 Oct 2026 02:17:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C972C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=aTRpZpwI
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=3ojf1XO/iaoieDVB5HRoBecDQ4hVUQJNCe5eIUaEZK4=;
	b=aTRpZpwIaUse7idT5YcevWycXV8LRBZTmAYLN9/oO0O2FtjxoA9njNUBWYqR110b+uedkCvVh
	yFt54UxtY7gFUi8KNV/fqbktKgXs2UQn+0IIxG/L77dZ1ZAfunULJZNNYJFzn+4SzB6basB5GPj
	+fd+7nv/JvLP/wzV031+VpU=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4jDDdp5RnSznV2X;
	Tue, 27 Oct 2026 10:17:02 +0800 (CST)
Received: from dggpemr500006.china.huawei.com (unknown [7.185.36.185])
	by mail.maildlp.com (Postfix) with ESMTPS id CED2E4048B;
	Tue, 27 Oct 2026 10:16:57 +0800 (CST)
Received: from [100.103.109.15] (100.103.109.15) by
 dggpemr500006.china.huawei.com (7.185.36.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 27 Oct 2026 10:16:57 +0800
Message-ID: <810801c8-55b2-45f9-81b8-cd95847fe530@huawei.com>
Date: Tue, 27 Oct 2026 10:16:56 +0800
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
Subject: Re: [PATCH] rseq: Prevent self-preemption when granting a time slice
 extension
To: Peter Zijlstra <peterz@infradead.org>
CC: Thomas Gleixner <tglx@kernel.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, <linux-kernel@vger.kernel.org>,
	<liuyongqiang13@huawei.com>, <stable@vger.kernel.org>
References: <20261023040439.3829110-1-yaokai34@huawei.com>
 <20261026114038.GE2668200@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Yao Kai <yaokai34@huawei.com>
In-Reply-To: <20261026114038.GE2668200@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemr500006.china.huawei.com (7.185.36.185)



On 10/26/2026 7:40 PM, Peter Zijlstra wrote:
> On Fri, Oct 23, 2026 at 12:04:39PM +0800, Yao Kai wrote:
>> __rseq_grant_slice_extension() makes the grant visible to user space and
>> then reads the clock to compute the expiry time before it clears the
>> pending reschedule request. This runs in the exit to user mode loop with
>> interrupts enabled.
>>
>> Clocksource read functions are free to disable and enable preemption.
>> kvm_clock_read(), xen_clocksource_read() and the arm64 architected timer
>> counter accessors, which are used when a counter erratum workaround is
>> active, do so. With full or lazy preemption, when the request which
>> triggered the grant is a non-lazy TIF_NEED_RESCHED, e.g. a lazy request
>> upgraded by the scheduler tick, then preempt_enable_notrace() in the clock
>> read function schedules right away, e.g. in a KVM guest:
>>
>>    __schedule
>>    preempt_schedule_notrace
>>    preempt_schedule_notrace_thunk
>>    kvm_clock_get_cycles
>>    ktime_get_mono_fast_ns
>>    irqentry_exit
>>    asm_sysvec_apic_timer_interrupt
>>
>> The task is preempted with the grant already handed out to user space,
>> i.e. in the middle of the critical section which the extension is supposed
>> to protect. The stale grant is cleaned up when the task goes back to user
>> space, so the damage is limited to the extension silently not working for
>> such preemptions on systems which use one of these clocksources.
>>
>> Read the clock in the interrupt disabled section after the reschedule
>> request has been cleared.
>>
>> Fixes: dfb630f548a7 ("rseq: Implement rseq_grant_slice_extension()")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Yao Kai <yaokai34@huawei.com>
>> ---
>>   include/linux/rseq_entry.h | 14 ++++++++++++--
>>   1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/rseq_entry.h b/include/linux/rseq_entry.h
>> index 31ce349ed42c..3e6a339175f8 100644
>> --- a/include/linux/rseq_entry.h
>> +++ b/include/linux/rseq_entry.h
>> @@ -174,8 +174,6 @@ static __always_inline bool __rseq_grant_slice_extension(bool work_pending)
>>   	rseq_stat_inc(rseq_stats.s_granted);
>>   
>>   	curr->rseq.slice.state.granted = true;
>> -	/* Store expiry time for arming the timer on the way out */
>> -	curr->rseq.slice.expires = data_race(rseq_slice_ext_nsecs) + ktime_get_mono_fast_ns();
>>   	/*
>>   	 * This is racy against a remote CPU setting TIF_NEED_RESCHED in
>>   	 * several ways:
>> @@ -222,6 +220,18 @@ static __always_inline bool __rseq_grant_slice_extension(bool work_pending)
>>   	scoped_guard(irq) {
>>   		clear_tsk_need_resched(curr);
>>   		clear_preempt_need_resched();
>> +		/*
>> +		 * Store expiry time for arming the timer on the way out.
>> +		 *
>> +		 * Read the clock only after the reschedule request has been
>> +		 * cleared and with interrupts disabled. Clocksource read
>> +		 * functions, e.g. kvm_clock_read(), may disable and enable
>> +		 * preemption, which would otherwise schedule right here on a
>> +		 * pending request and void the grant which was just handed
>> +		 * out to user space.
>> +		 */
>> +		curr->rseq.slice.expires = data_race(rseq_slice_ext_nsecs) +
>> +					   ktime_get_mono_fast_ns();
>>   	}
>>   	return true;
> 
> I am confused; even with this patch on, a tick that happens after
> unsafe_put_user() can cause things to get rescheduled 'instantly'. That
> preemption happens from irqentry_exit_cond_resched(), and needs no help
> from any preempt_enable() usage.

Right, that window still exists and this patch does not close it. An
interrupt which hits between unsafe_put_user() and the interrupt
disabled section preempts via irqentry_exit_cond_resched() as before.
That's a race against a handful of instructions though.

The clock read does not need an interrupt at all. The request which the
grant is made for is still pending and folded into the preempt count when
preempt_enable_notrace() in kvm_clock_read() runs, so the task schedules
on every grant for a non-lazy request. I verified that in a KVM guest
with kvm-clock: without the patch the extension does not work there.

If that makes sense to you, I'll send a V2 which spells out that
distinction in the changelog.

Thanks,
Yao


