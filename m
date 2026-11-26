Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795699216;
	b=4++XclxsesfzZAiTDjYYPro/BG5X+Blpi7ulZZKQmZkBOY2AQJA+LnSCKTA7UpnGPmHy
	 v4LSfKTVSbajFrd4wKdeSeLEDzjdzqa9JUev649o1AUtdozZm6K223nBPK2flkNonOIp9
	 CkQNW3/slb7zAX78MuDN8/Qfs8pFlpxaJ0RklPE7FzIYHXA/z5PLszXKfiTRXgWWB/7/N
	 RqESCARzGhsAwbXDtQh/0HPbpWwuuHOCTHIwOAGky0ESdfOzOTg+LNQfnA4nAPpdqWy05
	 4dZJr0Th7XhSN9Z7aUlIlisU+txDWPDB2FNa/FjEOrwvZbZL/h129BULSZLTSH7d1UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699216;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type:Content-Transfer-Encoding;
	bh=6EARNOFZKtzyHY8UuNeSqkUT2fUq1Xc+ICVwn502b0w=;
	b=Mdqsk1Uc9JwDSSELcU43GZOEaW4z+Q0qRJroPuF4gKw1h8DM2+a2OL85OOxzvob0YvK1
	 hWVm/TU9FiCG97Ma9VsudRpx5S94JH152EtpfbkSND3Sp/Im6fY5bBOKmTmI3kZoM4+oM
	 zZgTkUyFGOoCki1sAYaO5QueLq0N/l+hNwz+H02ocgISuOWJmTPXUeF/+Wpj9+cU0nb04
	 8JtIktbc/jgVFX5sXLlWk4rnGhHK79gDMO1c7sB0DRv9gp2y9B5pkl4nn1zHt9IpajS2i
	 ErjHgpiUUHt4K7vQos7KzyTDlRWrYPk048Hr0AxQ6s7vk5/+mQ7X/1gzgzDo/i6528g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ORXP9UZ/";
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56512606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 13:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56512606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ORXP9UZ/
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-38699cf08dfso8565846eec.1
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 05:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795699215; x=1796304015; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6EARNOFZKtzyHY8UuNeSqkUT2fUq1Xc+ICVwn502b0w=;
        b=ORXP9UZ/t/ra/f+z69Ix6iaxlBotX2StQJ3h/OAOsy8fUdANsVG/74ClVaN5b4cxO/
         8a8EgK+ZlNNg8jpvGxzcF3MPcnDHT2tByvUdPXWsVPX7RerMAwZgYzcn2NjvQcW1K46N
         ojuGTqryPBvsetn8zA0fX1VGFhL5+B/LQnCVXwDEKpBNqLQ28P2Okh2kRkcv3izcG5gX
         +tz/jkzA8KAfAYO8nejkya1K4EWM9SNxdnmc8GtJHq3d+rb9g2XTZdBc0yDLJ0UlGYf7
         52YIYDyjZ5h3+DbcPekMk/tHLvHjoQjkh1uaGUhxtUjDCFycCI7VFbKo6OWuVMsdO3jZ
         uAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795699215; x=1796304015;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6EARNOFZKtzyHY8UuNeSqkUT2fUq1Xc+ICVwn502b0w=;
        b=R9Dq5lI62xB5VDtQPe2lxyAJ8SOWYcEGibRht+PgutNWVmNvBsxYNZDFPJeGbrlQ9r
         K6q5NbVfA3ioQMyNBwevsMx3RfkYaWabeBAZZtyeXfMocsu1es7cyyVv3QzP7/Ftqzyi
         1Pa836uXHrHM8tSB+o7wQUHL2YEJz0ZSB24lnRK6afheIl5XFCHTTi8R7kDaDNJy/VZk
         6zSvehmtqnrqQdlK9QkpxyOWH4nTVhvdGeoAlBoRB+XMZ4d+wIsKgc8hUQicj88Zlto+
         OO61TnxrotaZ4D9eOJFgaMwtn19i1UxxByXb73X/RG/tgJTFTNma8QX5JlQimE/RtMix
         IQrg==
X-Forwarded-Encrypted: i=1; AL+hErHwHnn6BkPgMaFgArRJcvrb7jgPgcRZI3Oovnt87wNNM6xRMKHcCb/GwvxLX9HYF0Z92Ffgus0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8rULNmqcK0oqHv1D/LLwEruRYEyuj/ByYWwe4VSEVPbeDl5JtP
	ZKgsaQ8luF9jnoHUKLMg09/Dh/Yl8sOzhZ4tSZDda3AZCxF4HAtMRrcpcvjTeA==
X-Gm-Gg: AZFdTZd99GFZ4+bJEsezh7w+mhnw+9QqIr05NE8GFJRkgINLa+CK4R5LAIZNPXIKr2u
	weo2SN460sTMKvYM9ytVyoZbX5hetx0D6LBHXLT+6dOcSG8yHcs85HtJzNCIsTGN+Wm/bYBQ77G
	q3Dc2JrmR9oPKBkYQ6qfOLypTZjxqcvFxQIPDAbh4mdunb+Bm9TYrXTlcXoW4HgwWfCKLjx3Q1v
	exJIHUacda4CTa7L1QEo2FYzgcuzAirEOw4a2pQMiZ8NX1/3BTKD5j575DIP6YJfYAA8/R23i/Z
	laPHfWJ46ZuNV3+ovrwRp+/0lkhaddTh+xKNeLk0PWpD0dtirhMF795zDVfCEN9HK8UTaC7Phkj
	ZVQa+SNUUcFZSrz6/GbBtm3hKlxWFylqeV8gCLym3U0ZqCO1536eu2IudOmsnTZ+PxGfXoZLKF6
	yOtb3XHKErSRY+L60VduElc2jBvdGD6sE9CgfvH4fwRzL9Vgmi0OV2jCrdVOBdNd6NyYr2Vc0aE
	NzngNX5S6/2eLvCUo7/kF5PzYbId921Ge8/kFJOwN69e3/0we5NeUDyeX4VTwQsxEC6O3BTZM7f
	J1jjMlF/iMxhKMsigypOhdMuKfY=
X-Received: by 2002:a05:7300:d40e:b0:386:bc40:1508 with SMTP id 5a478bee46e88-386cfc4cb54mr4950902eec.14.1795699215149;
        Thu, 26 Nov 2026 05:20:15 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385f68bc0adsm59029622eec.13.2026.11.26.05.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 05:20:14 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCHv3 2/4] powerpc/watchdog: Disable preemption in arch_touch_nmi_watchdog()
In-Reply-To: <76a1d48f-7425-4cd9-a88b-dbb453c6f95c@kernel.org>
Date: Thu, 26 Nov 2026 18:06:40 +0530
Message-ID: <jylzkbvr.ritesh.list@gmail.com>
References: <cover.1795441238.git.ritesh.list@gmail.com> <8a70fa42449a63a73b8340d3296974cc519b5826.1795441238.git.ritesh.list@gmail.com> <awZ2qXSxXPO3XUUb@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com> <o6bdjkq1.ritesh.list@gmail.com> <76a1d48f-7425-4cd9-a88b-dbb453c6f95c@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Christophe Leroy (CS GROUP)" <chleroy@kernel.org> writes:

> Le 25/11/2026 à 10:58, Ritesh Harjani a écrit :
>> Mukesh Kumar Chaurasiya <mkchauras@gmail.com> writes:
>> 
>>> On Mon, Nov 23, 2026 at 07:21:51PM +0530, Ritesh Harjani (IBM) wrote:
>>>> touch_nmi_watchdog() can be called from preemptible context, e.g.
>>>> sysrq-w via /proc/sysrq-trigger. The powerpc implementation uses
>>>> smp_processor_id(), so with DEBUG_PREEMPT we get:
>>>>
>>>>    root@buildroot:/# echo w > /proc/sysrq-trigger
>>>>    sysrq: Show Blocked State
>>>>    BUG: using smp_processor_id() in preemptible [00000000] code: bash/238
>>>>    caller is arch_touch_nmi_watchdog+0x3c/0xd4
>>>>    CPU: 0 UID: 0 PID: 238 Comm: bash Not tainted 7.4.0-rc2-00029-g7664547149ae-dirty #126 PREEMPT
>>>>    Call Trace:
>>>>     dump_stack_lvl+0x138/0x150 (unreliable)
>>>>     check_preemption_disabled+0x120/0x158
>>>>     arch_touch_nmi_watchdog+0x3c/0xd4
>>>>     show_state_filter+0xf0/0x338
>>>>     sysrq_handle_showstate_blocked+0x24/0x38
>>>>     __handle_sysrq+0x134/0x3a8
>>>>     write_sysrq_trigger+0x178/0x22c
>>>>     proc_reg_write+0xf4/0x150
>>>>     vfs_write+0xfc/0x71c
>>>>     ksys_write+0x8c/0x150
>>>>     system_call_exception+0x310/0x590
>>>>     system_call_vectored_common+0x15c/0x2ec
>>>>    ---- interrupt: 3000 at 0x7ffd01755b98
>>>>
>>>> Unlike the generic version, which only sets a flag, we update the CPU's
>>>> timebase stamp and its SMP watchdog pending bit, so a migration in
>>>> between touches the state of a CPU we are no longer on.
>>>>
>>>> Disable preemption across the update. While at it, let's also mark the
>>>> function as notrace (since we might be within a tracer when this
>>>> function gets called).
>>> Do we need to also mark wd_smp_clear_cpu_pending as notrace?
>>>
>> 
>> aah yes, I didn't see that there is another function which is not
>> inlined. Thanks for spotting that. The reason I added "notrace" was
>> mainly to have consistency with kernel/watchdog.c which is due to this
>> commit:
>> 
>> cb9d7fd51d9f ("watchdog: Mark watchdog touch functions as notrace")
>> 
>> 
>> However, after looking more closely now, I don't think we need notrace
>> here at all. To simply put, on powerpc, we don't use stop_machine() from
>> within arch_ftrace_update_code() like how arch/arm does and besides, I
>> think it is even safe for one cpu to be executing the instruction on
>> powerpc, while another cpu modifying that atomically.
>
> But haven't we identified in another discussion that it might be needed 
> to use stop_machine() ? See 
> https://lore.kernel.org/all/qzh06fxn.ritesh.list@gmail.com/
>

Yes, that is why I also quoted second reason too on why we don't need it
on powerpc. But here is the detailed explaination of what I understood -
while looking at the history of changes on why "notrace" was added to
some arch (like arm or to the generic definition) in the first place.

On ARM, ftrace call sites were patched under stop_machine() and the code
used to rely on other CPUs not executing any call site meanwhile. (Note
that this itself is not needed on PowerPC see commit ee456bb346e7).
However, with a THUMB-2 instruction set on ARM, a 4byte instruction is
only 2 byte aligned, so while patching the instruction it can result
into a 2 x 16bit stores. Now after commit ce4f06dcbb5d ("stop_machine:
Touch_nmi_watchdog() after MULTI_STOP_PREPARE"), stopped cpus started
calling the watchdog touch functions (which were not marked notrace yet)
from multi_cpu_stop(), so a stopped cpu could therefore execute the
ftrace call site of those functions between the two stores. This
resulted into kernel crashes as seen on ARM while enabling/disabling
ftrace on ARM kernels built with THUMB-2 instruction set.
Therefore commit cb9d7fd51d9f ("watchdog: Mark watchdog touch functions
as notrace") was needed on ARM to fix these crashes.

So I still think we don't need a "notrace" on arch_touch_nmi_watchdog()
on powerpc, even if tomorrow, we extend the use of stop_machine() for
patching usecase, as we discussed on that other thread.

Btw, we already use stop_machine() on powerpc for several usecases today like...

# git grep "stop_machine" arch/powerpc/
arch/powerpc/lib/feature-fixups.c:#include <linux/stop_machine.h>
arch/powerpc/lib/feature-fixups.c:       * then stop_machine runs which will ensure all CPUs are out of the
arch/powerpc/lib/feature-fixups.c:      stop_machine(__do_stf_barrier_fixups, &types, NULL);
arch/powerpc/lib/feature-fixups.c:       * Note we are protected by stop_machine() from other CPUs executing the code in a
arch/powerpc/lib/feature-fixups.c:      stop_machine(__do_entry_flush_fixups, &types, NULL);
arch/powerpc/lib/feature-fixups.c:       * stop_machine gets all CPUs out of the interrupt exit handler same
arch/powerpc/lib/feature-fixups.c:       * without stop_machine, so this could be achieved with a broadcast
arch/powerpc/lib/feature-fixups.c:      stop_machine(__do_rfi_flush_fixups, &types, NULL);
arch/powerpc/mm/book3s64/hash_pgtable.c:#include <linux/stop_machine.h>
arch/powerpc/mm/book3s64/hash_pgtable.c:                stop_machine_cpuslocked(change_memory_range_fn, &chmem_parms,
arch/powerpc/mm/numa.c:#include <linux/stop_machine.h>
arch/powerpc/platforms/powernv/subcore.c:#include <linux/stop_machine.h>
arch/powerpc/platforms/powernv/subcore.c:       stop_machine_cpuslocked(cpu_update_split_mode, &new_mode,
arch/powerpc/platforms/pseries/lpar.c:#include <linux/stop_machine.h>
arch/powerpc/platforms/pseries/lpar.c:  rc = stop_machine_cpuslocked(pseries_lpar_resize_hpt_commit,
arch/powerpc/platforms/pseries/mobility.c:#include <linux/stop_machine.h>
arch/powerpc/platforms/pseries/mobility.c:              ret = stop_machine(do_join, &info, cpu_online_mask);

> Christophe
>

Thanks for the review! 

-ritesh


>> 
>> For e.g. see this -
>> 
>> commit ee456bb346e75a9b6d941224b108250e6ee5f79f
>> Author: Steven Rostedt <srostedt@redhat.com>
>> Date:   Thu Apr 26 08:31:17 2012 +0000
>> 
>>      powerpc/ftrace: Have PPC skip updating with stop_machine()
>>      
>>      PowerPC does not have the synchronization issues that x86 has with
>>      modifying code on one CPU while another CPU is executing it.
>>      The other CPU will either see the old or new code without any
>>      issues, unlike x86 which may issue a GPF.
>>      
>>      Instead of calling the heavy stop_machine, just update the code.
>>   
>> 
>> And as I see it, this problem only exists on ARM with THUMB2
>> instruction, as can be seen from their implementation of
>> arch_ftrace_update_code(), which uses stop_machine().
>> 
>> 
>> So, let me drop the "notrace" as it is not really needed here and
>> re-spin a v4 with it being dropped.
>> 
>> -ritesh
>> 
>>>> Fixes: 2104180a5369 ("powerpc/64s: implement arch-specific hardlockup watchdog")
>>>> Cc: stable@vger.kernel.org
>>>> Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>>>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>>>> ---
>>>>   arch/powerpc/kernel/watchdog.c | 8 ++++++--
>>>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
>>>> index 44f178e07531..32d4e716cb0a 100644
>>>> --- a/arch/powerpc/kernel/watchdog.c
>>>> +++ b/arch/powerpc/kernel/watchdog.c
>>>> @@ -456,12 +456,16 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
>>>>   	return HRTIMER_RESTART;
>>>>   }
>>>>   
>>>> -void arch_touch_nmi_watchdog(void)
>>>> +notrace void arch_touch_nmi_watchdog(void)
>>>>   {
>>>>   	unsigned long ticks = tb_ticks_per_usec * wd_timer_period_ms * 1000;
>>>> -	int cpu = smp_processor_id();
>>>> +	int cpu;
>>>>   	u64 tb;
>>>>   
>>>> +	/* Callers may be preemptible. Stay on this CPU for the update. */
>>>> +	guard(preempt_notrace)();
>>>> +	cpu = raw_smp_processor_id();
>>>> +
>>>>   	if (!cpumask_test_cpu(cpu, &watchdog_cpumask))
>>>>   		return;
>>>>   
>>>> -- 
>>>> 2.39.5
>>>>
