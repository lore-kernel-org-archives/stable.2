Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603585;
	b=mFUxA5OMVDAqWu7SCU0khzsnq1hT8WartE0rxDQ1Io90pce772cXYF1EE0xxaf4My/bn
	 pRLy7EUg5drwdfiJbToGys8WP0Jld3oX7Hx2+1I9R8tVpssV7YVzJ5+FdWxzdVa0oIKJX
	 GnwU0twhPUB/2xnC0P7FDvgD8b7h0Hu0BbtxGEg8gwSEeKLf355QOAcF7UfFuBoazB85S
	 8XbRVQrNX4teecdjoEaqvq2vlQMUWGetgfCB4DsRIf2OrCHmRI7jKJ9lJ1tLxHovYhA2e
	 5c1is24YAVDl25uGsW4BtoYvD5CcNzBP5Y7/6tKEq/6vmc9RYZ5HwbfRz7gMC0ZlZRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603585;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References;
	bh=75ck5Fj+CO5o/O7K369aVkulZ3SEZBEXUvPGoP4of14=;
	b=0l9fzDJfqzx1aF/Wqt1tzLgQYKPzLQGEMRxKWh7OurD3WxC3EtPIN8aoaIoJV1V0xK1L
	 NLA9sxZ6t9I5wOcE6xyi0OghxudZ7Ga1Zuku1eXzhD+GF9BycHoTYyht7JEd25j7z806L
	 q0S9fQwTwSTSKdW+f1LGFEeGP00bo+0D3h475YDhkMJiygvwaB6iHODOBbWWuCkfhvrL5
	 XfLZq+26n8yC3y0f23z57OlbdxC3W/Cwr4d03uFV5ceC4xmqpsxdLRUS09obQNL7wiF63
	 60FULoiQ5vDur/tl3iOVWnUXvPAQ5IxpDdpPFSe1hcYTYajsu2SR1hNGNCza7BtssMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=THgzfaNh;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28945606A327
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28945606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=THgzfaNh
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3282db206d3so5446938eec.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 02:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795603584; x=1796208384; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=75ck5Fj+CO5o/O7K369aVkulZ3SEZBEXUvPGoP4of14=;
        b=THgzfaNhKvHiE7nCcWeM2XJm99zLhiEzN8T+3FjFzB5BR7H5J/+TAMgGZS8wTRMOZl
         AkK9sN/QR6O3tpchGnNUTg6RUEi+uJp9pc8ukJiD3Kp5Vj3BBKcfXDWbHLBBlFIUYDiL
         AfHNupsOQnIcomE2UsW1/nD3OgidAzKScMGHaddXzWgcJ+hXAq6j/jTPpEyZ4YtfiBUt
         Z2L2M0EX7gHtTJv3dnMeDLowVZ86LfS0ak8nYXE/0XCO4K0IhrACHV9QzD4eW36oqA8L
         5XYM7ELPbX3BZwTpnHB1k2bo7xnwo7BUTG3MlNmBLYxQJMge17tRV9yHbyXXGAxcvh8n
         h/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795603584; x=1796208384;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=75ck5Fj+CO5o/O7K369aVkulZ3SEZBEXUvPGoP4of14=;
        b=JGtvMbU1EnR5/Uo2m0Bf3cGgUJ9xMxTShfNkvoVqkgVuEP4pRM1M/pTtYMwwd4rqxx
         VRgdOLgjhgxj2vB2yRlI5pBjPWnGJUyJFrzffrJiNPudedZ0EVLzjYPmcG8jrqqPmuJH
         IlYI5x57ikErGtxZ/GwS3Nwz9Rys/FJBFiKyodUFIxsdTH9Ik78Hlr/FfbFrhj9recvG
         F505m2QmWRIZAaXwuhyPTxOC1Jl3ieK20mAXD+93/Perdw16i6kGjX/qayFa1mdTySA1
         EGvSkyD19FlOHJDudnkO3fQ7wQJN/wEeCRtfAQ7YDFcbSdrNUHOj7bfoQRW/ZaN9d92r
         xpDg==
X-Forwarded-Encrypted: i=1; AL+hErGEb4cJZVkJsIw6i9JLLpMr642v9IPayL8AwN5cWjkFffJPD7rkshMDFFatt0TP+V1a/+qAZtM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+d9MYv6a7oLmCgrwNa3xoX/VocJ64je05B72mE4ARk0sOkiTIN
	ge998zrNrt7fZhRDSQDN4/b4sT+/yVQmOLYrwRNu4n/B5MiK2Web8aJd/ehrXA==
X-Gm-Gg: AZFdTZdx+24HEoIbReT76RqeCRXBX5AK+wU9Dpyw1Mm1qy5qit8/dtpIro2Ko8TuFAL
	oTFJ/WxZyadl+cFB7O2id6sF9YBNlAzzDUrUtF01Z1cFvOKubqnXXH7pxsneq8NwzoZ+cXONLAk
	TNJsdvzqU7QeM0FKVi473y1jeAmTTOdyvZjoEaAuARGNSlWBmQsEq956gioyeFua0M2e+resXTK
	z1GvWeD8yXEtQzqhju/48ab9EHcSJzncWGpkB5JsfqEaFWn+n7vV3j6oGMO+eogV02Y9Ll731mv
	1YWFTQ8WNioLvBly2avmaId3f4mHJMbPPXofq6CoqJfLs4UYcKngjdnyt99lvTnpQePrZ7zKblj
	b5GmeYh5KM8FANpGgcwawn+RPm1CHTXv6dv78zjwaU8nYrdMJei6uoIovMU8i8hvdEtdWmRe1+g
	zFr5AXaH9aiQ/hXPFJGNyvTfTln800GBAQeH0A8WEDztK+YpIzJ7BOoPwYgEHRPU3M/x38FwN67
	DFGuNjTDU73jMGsqPIEcmePhoUR+tIWb2VzRtRbSSDdH7ruTKdHN+eBLisk4gVClUCdNtJws3wQ
	kZHY1KcZvS9BV1V+ztKZRz59q4g=
X-Received: by 2002:a05:7022:1711:b0:1b3:aee5:20c5 with SMTP id a92af1059eb24-1b5568ac791mr15438030c88.22.1795603584073;
        Wed, 25 Nov 2026 02:46:24 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5568592adsm40526601c88.15.2026.11.25.02.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 02:46:23 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, linux-kernel@vger.kernel.org, chleroy@kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCHv3 2/4] powerpc/watchdog: Disable preemption in arch_touch_nmi_watchdog()
In-Reply-To: <awZ2qXSxXPO3XUUb@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
Date: Wed, 25 Nov 2026 15:28:46 +0530
Message-ID: <o6bdjkq1.ritesh.list@gmail.com>
References: <cover.1795441238.git.ritesh.list@gmail.com> <8a70fa42449a63a73b8340d3296974cc519b5826.1795441238.git.ritesh.list@gmail.com> <awZ2qXSxXPO3XUUb@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list

Mukesh Kumar Chaurasiya <mkchauras@gmail.com> writes:

> On Mon, Nov 23, 2026 at 07:21:51PM +0530, Ritesh Harjani (IBM) wrote:
>> touch_nmi_watchdog() can be called from preemptible context, e.g.
>> sysrq-w via /proc/sysrq-trigger. The powerpc implementation uses
>> smp_processor_id(), so with DEBUG_PREEMPT we get:
>> 
>>   root@buildroot:/# echo w > /proc/sysrq-trigger
>>   sysrq: Show Blocked State
>>   BUG: using smp_processor_id() in preemptible [00000000] code: bash/238
>>   caller is arch_touch_nmi_watchdog+0x3c/0xd4
>>   CPU: 0 UID: 0 PID: 238 Comm: bash Not tainted 7.4.0-rc2-00029-g7664547149ae-dirty #126 PREEMPT
>>   Call Trace:
>>    dump_stack_lvl+0x138/0x150 (unreliable)
>>    check_preemption_disabled+0x120/0x158
>>    arch_touch_nmi_watchdog+0x3c/0xd4
>>    show_state_filter+0xf0/0x338
>>    sysrq_handle_showstate_blocked+0x24/0x38
>>    __handle_sysrq+0x134/0x3a8
>>    write_sysrq_trigger+0x178/0x22c
>>    proc_reg_write+0xf4/0x150
>>    vfs_write+0xfc/0x71c
>>    ksys_write+0x8c/0x150
>>    system_call_exception+0x310/0x590
>>    system_call_vectored_common+0x15c/0x2ec
>>   ---- interrupt: 3000 at 0x7ffd01755b98
>> 
>> Unlike the generic version, which only sets a flag, we update the CPU's
>> timebase stamp and its SMP watchdog pending bit, so a migration in
>> between touches the state of a CPU we are no longer on.
>> 
>> Disable preemption across the update. While at it, let's also mark the
>> function as notrace (since we might be within a tracer when this
>> function gets called).
> Do we need to also mark wd_smp_clear_cpu_pending as notrace?
>

aah yes, I didn't see that there is another function which is not
inlined. Thanks for spotting that. The reason I added "notrace" was
mainly to have consistency with kernel/watchdog.c which is due to this
commit:

cb9d7fd51d9f ("watchdog: Mark watchdog touch functions as notrace")


However, after looking more closely now, I don't think we need notrace
here at all. To simply put, on powerpc, we don't use stop_machine() from
within arch_ftrace_update_code() like how arch/arm does and besides, I
think it is even safe for one cpu to be executing the instruction on
powerpc, while another cpu modifying that atomically.

For e.g. see this -

commit ee456bb346e75a9b6d941224b108250e6ee5f79f
Author: Steven Rostedt <srostedt@redhat.com>
Date:   Thu Apr 26 08:31:17 2012 +0000

    powerpc/ftrace: Have PPC skip updating with stop_machine()
    
    PowerPC does not have the synchronization issues that x86 has with
    modifying code on one CPU while another CPU is executing it.
    The other CPU will either see the old or new code without any
    issues, unlike x86 which may issue a GPF.
    
    Instead of calling the heavy stop_machine, just update the code.
 

And as I see it, this problem only exists on ARM with THUMB2
instruction, as can be seen from their implementation of
arch_ftrace_update_code(), which uses stop_machine().


So, let me drop the "notrace" as it is not really needed here and
re-spin a v4 with it being dropped.

-ritesh

>> Fixes: 2104180a5369 ("powerpc/64s: implement arch-specific hardlockup watchdog")
>> Cc: stable@vger.kernel.org
>> Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>  arch/powerpc/kernel/watchdog.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
>> index 44f178e07531..32d4e716cb0a 100644
>> --- a/arch/powerpc/kernel/watchdog.c
>> +++ b/arch/powerpc/kernel/watchdog.c
>> @@ -456,12 +456,16 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
>>  	return HRTIMER_RESTART;
>>  }
>>  
>> -void arch_touch_nmi_watchdog(void)
>> +notrace void arch_touch_nmi_watchdog(void)
>>  {
>>  	unsigned long ticks = tb_ticks_per_usec * wd_timer_period_ms * 1000;
>> -	int cpu = smp_processor_id();
>> +	int cpu;
>>  	u64 tb;
>>  
>> +	/* Callers may be preemptible. Stay on this CPU for the update. */
>> +	guard(preempt_notrace)();
>> +	cpu = raw_smp_processor_id();
>> +
>>  	if (!cpumask_test_cpu(cpu, &watchdog_cpumask))
>>  		return;
>>  
>> -- 
>> 2.39.5
>> 
