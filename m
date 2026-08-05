Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4B746EF8B
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 12:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931739; cv=none; b=PJ53D/V8fnVCk1kggB+V02uvhD7IFSs7XUMnRsEDMcWWVkPM3BXIjc/f/CY8ejiMVliFhj1AY6vjJ2En5HS1d/OvOGde77GxazgZ6lH+wWxZsREiASpZIThDxQG2cYNG9EK7QnPfvxeO+CaZgiiRpMXjJUn9IJ+GMlkFX9XSt6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931739; c=relaxed/simple;
	bh=36qWji24aaLdm1mlOA43jOfdLLk9V3CSEiD2MFW4eOo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hZaf4rqeZ55gnhbydok3ftb4b/HhNfQBa6jEbewhLwefY9KZTM9V3pCpyV6Q7A8cVlGxKwdDy2jBSLpGi/DMeslDT5z61KgMqFWI0LjTlgASanrcWjGySUpHIHLgtTBQEkIBebatgsoARcOz/4fboeN/lqrUAdx/n9UPbeRPcO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpnIsKpO; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpnIsKpO"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47f703a9d05so593905f8f.0
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 05:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785931732; x=1786536532; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L58QuRttbq8ipfvicwBxGanLWWeJ0MgayPUEKQeAujc=;
        b=XpnIsKpO0sq/tZ4HPK8XEJq2WcLYe67qTRCwtRRG/fr6/WrOSYJ2+I09HMyPsdGnLO
         n9WlmiSm5MJSROFJCvKhhggnB72CeyJDADjr/IHKdtCnqHcFoYXqWPSN1awYINYxgvVP
         4TfNz1p9ea+9fhKypa6S+XA60luzDx2oAgwq3W1BAeEjlfkgqmTlGjusulDq0G2nR57s
         EpZAOWpMkKt7jfp+NhL4RU7Sa2qM1DEn0YPHT0WqUC9ejCFfAsrQ8ncMIrLygQRlqqEC
         7LfCcemGeZKozFpWmfUoHFyevu99/YldkWWKautDaJ8dzF+0qdWhvZYTpvaHOD3M0ap7
         J5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785931732; x=1786536532;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L58QuRttbq8ipfvicwBxGanLWWeJ0MgayPUEKQeAujc=;
        b=XXn266KOvBcc+jlZv5/YA6DNvPUT/CQUFTZjDFz19rW4kOovsPz9ZLkC9CnPPSPkxi
         al3Gvy9+f/S5UxHpWG6dA+WnWtytJ7qJiC9I0jXMVP9aocFZmgZasy0WXGxTxbiOVlbz
         BipX9l72jjdwYJ6PHO2gAp4qQ9z3N4aH48lBkDwX+pZiuIMa4Grsslnh+zTWW5au9/7y
         cC1RDgcdS1827ViF0fZ1oNAaJZKdkKxY2AZeO3XXEf6/dJN06k+72VWY2LpfY9FWFrHJ
         SYfnfsnpYGYrVQhzigFceIisnxjKv45cOj7vmwH37HN+7+vX6VVxvAXM77BkPhSsYrN9
         O2qg==
X-Forwarded-Encrypted: i=1; AHgh+RpdkJbvG1zeOC9+lrU6Jy+j/nenYEkfuNxNiFioIONSh2XWoIC9/pp0duqbqA+vu83i6VVM4o4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU168sDw4dy0lB4HFD9HGBNjF4tIpdbOdB8tHWdPGWFwFkuiqK
	h2Nh1c+RrqlHeQs1mK88OLyZq79cdFR2r1wH8p/JltOL/KISwagkoLlC
X-Gm-Gg: AR+sD12wnC1FTGUqAxePWGxqRrigHNFhOrvhdfBGVAgPFX6fzQKNqAyquHalpAmHL4H
	kw5sQukfXOHhe9MxklYovoBi76aHd78n50W1nLELr2Myr2NKlTwANJHnLX08o5svgyQ4M5/iDGC
	eYsd8I4yAgfoGJoFPuvtN3LWCeDx8b7zkJIV+Wzb5uw9fmqR8wUQ3jZScE3gjYlnnWBnQuoq8BX
	iojagSy143R30FhlB6+DBtxBQoZhVRFTs0/iwJMAKw5N5swK5gSHrsP1xqxAHq7upyZt9RPiFDC
	aKDmijpzXtzmaF4/SwEYH+8kZYFsiwmhf8WK0AL0R0C3W+VbcohJb/+5uz6Vmr6u6kMEZoIuG6h
	/bvAfQGIkRCY8oPipJEIhNx35isnWem9vZAEL4fl4MLNdkn6lp3J8ShKfB/PUP5FNqvEvlekKU5
	lyL1/3H6eb7waqKnPa//C8d7NIXKjRFqXLjoPMkn/u+GRC+GteKg9ZPyeyVispRaTs8O0Q7yzlC
	oUL3KbqVpZNPyyfDUxpldN95g==
X-Received: by 2002:a05:600c:524a:b0:495:5890:8f6c with SMTP id 5b1f17b1804b1-4994e71d349mr61612425e9.7.1785931731173;
        Wed, 05 Aug 2026 05:08:51 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec23e250sm9440714f8f.26.2026.08.05.05.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 05:08:50 -0700 (PDT)
Date: Wed, 5 Aug 2026 13:08:48 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
 linux-arm-kernel@lists.infradead.org, ada.coupriediaz@arm.com,
 ardb@kernel.org, catalin.marinas@arm.com, cl@gentwo.org, david@kernel.org,
 james.morse@arm.com, ljs@kernel.org, maz@kernel.org, peterz@infradead.org,
 ruanjinjie@huawei.com, stable@vger.kernel.org, vladimir.murzin@arm.com,
 will@kernel.org, yang@os.amperecomputing.com
Subject: Re: [PATCH v2 14/20] arm64: percpu: Implement preemptible
 read/write ops
Message-ID: <20260805130848.6d533293@pumpkin>
In-Reply-To: <00a85d9a-8727-4b89-b33b-ce2d3358355c@arm.com>
References: <20260804170503.3513916-1-mark.rutland@arm.com>
	<20260804170503.3513916-15-mark.rutland@arm.com>
	<00a85d9a-8727-4b89-b33b-ce2d3358355c@arm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Aug 2026 10:24:04 +0100
Ryan Roberts <ryan.roberts@arm.com> wrote:

> On 04/08/2026 18:04, Mark Rutland wrote:
> > Use the PCPU GPR infrastructure to implement preemptible this_cpu_read()
> > and this_cpu_write().
> > 
> > This change means that this_cpu_read() will always use a plain LDR, even
> > in LTO configurations where READ_ONCE() will use LDA[P]R. Using plain
> > LDR is preferable, given that the rationale for using LDA[P]R in
> > READ_ONCE() was to retain address dependencies against values written by
> > other CPUs, which isn't expected usage for this_cpu_read(). Using plain
> > LDR will enforce fewer ordering constraints.
> > 
> > Test case:
> > 
> > | void outline_this_cpu_write_u64(u64 __percpu *p, u64 v)
> > | {
> > | 	this_cpu_write(*p, v);
> > | }
> > 
> > Generated code before this patch (v7.2-rc4):
> > 
> > | <outline_this_cpu_write_u64>:
> > |        paciasp
> > |        stp     x29, x30, [sp, #-16]!
> > |        mrs     x2, sp_el0
> > |        mov     x29, sp
> > |        ldr     w3, [x2, #8]
> > |        add     w3, w3, #0x1
> > |        str     w3, [x2, #8]
> > |        mrs     x3, tpidr_el1
> > |        str     x1, [x0, x3]
> > |        ldr     x0, [x2, #8]
> > |        sub     x0, x0, #0x1
> > |        str     w0, [x2, #8]
> > |        cbz     x0, 1f
> > |        ldr     x0, [x2, #8]
> > |        cbnz    x0, 2f
> > | 1:     bl      preempt_schedule_notrace
> > | 2:     ldp     x29, x30, [sp], #16
> > |        autiasp
> > |        ret
> > 
> > Generated code after this patch:
> > 
> > | <outline_this_cpu_write_u64>:
> > |        mrs     x2, sp_el0
> > |        mov     w3, #0x7c60
> > |        strh    w3, [x2, #20]
> > |        mrs     x3, tpidr_el1
> > |        str     x1, [x0, x3]
> > |        strh    wzr, [x2, #20]
> > |        ret
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: James Morse <james.morse@arm.com>
> > Cc: Jinjie Ruan <ruanjinjie@huawei.com>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Vladimir Murzin <vladimir.murzin@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Yang Shi <yang@os.amperecomputing.com>
> > ---  
> FYI I'm seeing build warnings caused by this patch (with ftrace enabled - based 
> on the warnings, I'm guessing that's the key bit), using:
> 
> aarch64-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> 
> I haven't investigated the cause.

It'll be the earlier patch that changed the casts.
The code is doing:
		this_cpu_write(tr->array_buffer.data->ftrace_ignore_pid,
			       FTRACE_PID_IGNORE);
where the constant is -1.
I suspect the warning messages are coming from the switch case that are
optimised away because the size if wrong (ftrace_ignore_pid seems to
be a pid number to ignore and is 32 bits.

That does seem a long-winded way to access per-cpu data.
To make any sense the code must be running with preemption disabled and
be caching info in per-cpu memory.
In which case it can just access it directly.
OTOH it could save the 'global' address of the per-cpu data and then access
it using the pointer so that access would be a normal one.

	David

> 
> Thanks,
> Ryan
> 
> ---8<---
> In file included from linux/arch/arm64/include/asm/spectre.h:17,                                                                                                                                                                       
>                  from linux/arch/arm64/include/asm/processor.h:47,
>                  from linux/include/linux/sched.h:13,
>                  from linux/include/linux/ratelimit.h:6,
>                  from linux/include/linux/dev_printk.h:16,
>                  from linux/include/linux/device.h:15,
>                  from linux/include/linux/node.h:18,
>                  from linux/include/linux/cpu.h:17,
>                  from linux/include/linux/stop_machine.h:5,
>                  from linux/kernel/trace/ftrace.c:17:
> linux/kernel/trace/ftrace.c: In function 'ftrace_filter_pid_sched_switch_probe':
> linux/arch/arm64/include/asm/percpu.h:295:42: warning: conversion from 'long unsigned int' to 'u8' {aka 'unsigned char'} changes value from '18446744073709551615' to '255' [-Woverflow]                                               
>   295 |         _pcp_wrap(__percpu_write_8, pcp, (unsigned long)(val))
>       |                                          ^~~~~~~~~~~~~~~~~~~~
> linux/arch/arm64/include/asm/percpu.h:277:20: note: in definition of macro '_pcp_wrap'
>   277 |         op(&(pcp), __VA_ARGS__);                                        \
>       |                    ^~~~~~~~~~~
> linux/include/linux/percpu-defs.h:369:25: note: in expansion of macro 'this_cpu_write_1'
>   369 |                 case 1: stem##1(variable, __VA_ARGS__);break;           \
>       |                         ^~~~
> linux/include/linux/percpu-defs.h:500:41: note: in expansion of macro '__pcpu_size_call'
>   500 | #define this_cpu_write(pcp, val)        __pcpu_size_call(this_cpu_write_, pcp, val)
>       |                                         ^~~~~~~~~~~~~~~~
> linux/kernel/trace/ftrace.c:8628:17: note: in expansion of macro 'this_cpu_write'
>  8628 |                 this_cpu_write(tr->array_buffer.data->ftrace_ignore_pid,
>       |                 ^~~~~~~~~~~~~~
> linux/arch/arm64/include/asm/percpu.h:297:43: warning: conversion from 'long unsigned int' to 'u16' {aka 'short unsigned int'} changes value from '18446744073709551615' to '65535' [-Woverflow]
>   297 |         _pcp_wrap(__percpu_write_16, pcp, (unsigned long)(val))
>       |                                           ^~~~~~~~~~~~~~~~~~~~
> linux/arch/arm64/include/asm/percpu.h:277:20: note: in definition of macro '_pcp_wrap'
>   277 |         op(&(pcp), __VA_ARGS__);                                        \
>       |                    ^~~~~~~~~~~
> linux/include/linux/percpu-defs.h:370:25: note: in expansion of macro 'this_cpu_write_2'
>   370 |                 case 2: stem##2(variable, __VA_ARGS__);break;           \
>       |                         ^~~~
> linux/include/linux/percpu-defs.h:500:41: note: in expansion of macro '__pcpu_size_call'
>   500 | #define this_cpu_write(pcp, val)        __pcpu_size_call(this_cpu_write_, pcp, val)
>       |                                         ^~~~~~~~~~~~~~~~
> linux/kernel/trace/ftrace.c:8628:17: note: in expansion of macro 'this_cpu_write'
>  8628 |                 this_cpu_write(tr->array_buffer.data->ftrace_ignore_pid,
>       |                 ^~~~~~~~~~~~~~
> linux/arch/arm64/include/asm/percpu.h:299:43: warning: conversion from 'long unsigned int' to 'u32' {aka 'unsigned int'} changes value from '18446744073709551615' to '4294967295' [-Woverflow]
>   299 |         _pcp_wrap(__percpu_write_32, pcp, (unsigned long)(val))
>       |                                           ^~~~~~~~~~~~~~~~~~~~
> linux/arch/arm64/include/asm/percpu.h:277:20: note: in definition of macro '_pcp_wrap'
>   277 |         op(&(pcp), __VA_ARGS__);                                        \
>       |                    ^~~~~~~~~~~
> linux/include/linux/percpu-defs.h:371:25: note: in expansion of macro 'this_cpu_write_4'
>   371 |                 case 4: stem##4(variable, __VA_ARGS__);break;           \
>       |                         ^~~~
> linux/include/linux/percpu-defs.h:500:41: note: in expansion of macro '__pcpu_size_call'
>   500 | #define this_cpu_write(pcp, val)        __pcpu_size_call(this_cpu_write_, pcp, val)
>       |                                         ^~~~~~~~~~~~~~~~
> linux/kernel/trace/ftrace.c:8628:17: note: in expansion of macro 'this_cpu_write'
>  8628 |                 this_cpu_write(tr->array_buffer.data->ftrace_ignore_pid,
>       |                 ^~~~~~~~~~~~~~
> linux/kernel/trace/ftrace.c: In function 'ignore_task_cpu':
> linux/arch/arm64/include/asm/percpu.h:295:42: warning: conversion from 'long unsigned int' to 'u8' {aka 'unsigned char'} changes value from '18446744073709551615' to '255' [-Woverflow]
>   295 |         _pcp_wrap(__percpu_write_8, pcp, (unsigned long)(val))
>       |                                          ^~~~~~~~~~~~~~~~~~~~
> linux/arch/arm64/include/asm/percpu.h:277:20: note: in definition of macro '_pcp_wrap'
>   277 |         op(&(pcp), __VA_ARGS__);                                        \
>       |                    ^~~~~~~~~~~
> linux/include/linux/percpu-defs.h:369:25: note: in expansion of macro 'this_cpu_write_1'
>   369 |                 case 1: stem##1(variable, __VA_ARGS__);break;           \
>       |                         ^~~~
> linux/include/linux/percpu-defs.h:500:41: note: in expansion of macro '__pcpu_size_call'
>   500 | #define this_cpu_write(pcp, val)        __pcpu_size_call(this_cpu_write_, pcp, val)
>       |                                         ^~~~~~~~~~~~~~~~
> linux/kernel/trace/ftrace.c:8898:17: note: in expansion of macro 'this_cpu_write'
>  8898 |                 this_cpu_write(tr->array_buffer.data->ftrace_ignore_pid,
>       |                 ^~~~~~~~~~~~~~
> linux/arch/arm64/include/asm/percpu.h:297:43: warning: conversion from 'long unsigned int' to 'u16' {aka 'short unsigned int'} changes value from '18446744073709551615' to '65535' [-Woverflow]
>   297 |         _pcp_wrap(__percpu_write_16, pcp, (unsigned long)(val))
>       |                                           ^~~~~~~~~~~~~~~~~~~~
> linux/arch/arm64/include/asm/percpu.h:277:20: note: in definition of macro '_pcp_wrap'
>   277 |         op(&(pcp), __VA_ARGS__);                                        \
>       |                    ^~~~~~~~~~~
> linux/include/linux/percpu-defs.h:370:25: note: in expansion of macro 'this_cpu_write_2'
>   370 |                 case 2: stem##2(variable, __VA_ARGS__);break;           \
>       |                         ^~~~
> linux/include/linux/percpu-defs.h:500:41: note: in expansion of macro '__pcpu_size_call'
>   500 | #define this_cpu_write(pcp, val)        __pcpu_size_call(this_cpu_write_, pcp, val)
>       |                                         ^~~~~~~~~~~~~~~~
> linux/kernel/trace/ftrace.c:8898:17: note: in expansion of macro 'this_cpu_write'
>  8898 |                 this_cpu_write(tr->array_buffer.data->ftrace_ignore_pid,
>       |                 ^~~~~~~~~~~~~~
> linux/arch/arm64/include/asm/percpu.h:299:43: warning: conversion from 'long unsigned int' to 'u32' {aka 'unsigned int'} changes value from '18446744073709551615' to '4294967295' [-Woverflow]
>   299 |         _pcp_wrap(__percpu_write_32, pcp, (unsigned long)(val))
>       |                                           ^~~~~~~~~~~~~~~~~~~~
> linux/arch/arm64/include/asm/percpu.h:277:20: note: in definition of macro '_pcp_wrap'
>   277 |         op(&(pcp), __VA_ARGS__);                                        \
>       |                    ^~~~~~~~~~~
> linux/include/linux/percpu-defs.h:371:25: note: in expansion of macro 'this_cpu_write_4'
>   371 |                 case 4: stem##4(variable, __VA_ARGS__);break;           \
>       |                         ^~~~
> linux/include/linux/percpu-defs.h:500:41: note: in expansion of macro '__pcpu_size_call'
>   500 | #define this_cpu_write(pcp, val)        __pcpu_size_call(this_cpu_write_, pcp, val)
>       |                                         ^~~~~~~~~~~~~~~~
> linux/kernel/trace/ftrace.c:8898:17: note: in expansion of macro 'this_cpu_write'
>  8898 |                 this_cpu_write(tr->array_buffer.data->ftrace_ignore_pid,
>       |                 ^~~~~~~~~~~~~~
> ---8<---
> 
> 

