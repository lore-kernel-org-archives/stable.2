Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C3122FDE6
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785921851; cv=none; b=W831vSiuwmFOv+2uYzoapPp8iP1iR/MEv9p5jBg+g9BIilVUmoK2KxKqwuSpiTvIen0FQZV3WBx0OSvXiLFzAXjp7i+YmJba9x6rNN4C0NY0ZuZdvZ92dsXMO0V68tRBRFDzJtb+Sz13GAUzxRAholrj6hWlRul1yrtbo/4f3LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785921851; c=relaxed/simple;
	bh=5+i+m9WSJqQvin47phulhm8sOavejG6eTb3No4RAakM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nWnVzTIGknouYC96InbfrSQUi7uu1Hw2++fEsvssBaZHKyLRUUJeczirR6IUgo3FP0Z5zcI44Pk3IkhsCB25opj0KtCODGYYQhSXvE6o3HyGzfsbAS2jScjTwMLeLjPltRDAKxi0ji+xjVcuk5ziPDDUnAlRyqywDytcPlw/ozE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=eDff7BAR; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="eDff7BAR"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4602153B;
	Wed,  5 Aug 2026 02:24:04 -0700 (PDT)
Received: from [10.57.87.98] (unknown [10.57.87.98])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 110153F66F;
	Wed,  5 Aug 2026 02:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785921848; bh=5+i+m9WSJqQvin47phulhm8sOavejG6eTb3No4RAakM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eDff7BARSdi7ra/VdL2bJTZukrenI2Tt4LT4fWY3+q70NkU3JCSd+PqI3aSfZHl5w
	 jrlwfn37FLQWw1+Z2J542shyCC6COzZ2orte9z1AkShbf61cGe1r+RdM1EojbSfcf1
	 kBIcp4VTByONOgeSJ0j+npDX1QaIOSNUf3Zfih/Q=
Message-ID: <00a85d9a-8727-4b89-b33b-ce2d3358355c@arm.com>
Date: Wed, 5 Aug 2026 10:24:04 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/20] arm64: percpu: Implement preemptible read/write
 ops
Content-Language: en-GB
To: Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: ada.coupriediaz@arm.com, ardb@kernel.org, catalin.marinas@arm.com,
 cl@gentwo.org, david@kernel.org, david.laight.linux@gmail.com,
 james.morse@arm.com, ljs@kernel.org, maz@kernel.org, peterz@infradead.org,
 ruanjinjie@huawei.com, stable@vger.kernel.org, vladimir.murzin@arm.com,
 will@kernel.org, yang@os.amperecomputing.com
References: <20260804170503.3513916-1-mark.rutland@arm.com>
 <20260804170503.3513916-15-mark.rutland@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20260804170503.3513916-15-mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/08/2026 18:04, Mark Rutland wrote:
> Use the PCPU GPR infrastructure to implement preemptible this_cpu_read()
> and this_cpu_write().
> 
> This change means that this_cpu_read() will always use a plain LDR, even
> in LTO configurations where READ_ONCE() will use LDA[P]R. Using plain
> LDR is preferable, given that the rationale for using LDA[P]R in
> READ_ONCE() was to retain address dependencies against values written by
> other CPUs, which isn't expected usage for this_cpu_read(). Using plain
> LDR will enforce fewer ordering constraints.
> 
> Test case:
> 
> | void outline_this_cpu_write_u64(u64 __percpu *p, u64 v)
> | {
> | 	this_cpu_write(*p, v);
> | }
> 
> Generated code before this patch (v7.2-rc4):
> 
> | <outline_this_cpu_write_u64>:
> |        paciasp
> |        stp     x29, x30, [sp, #-16]!
> |        mrs     x2, sp_el0
> |        mov     x29, sp
> |        ldr     w3, [x2, #8]
> |        add     w3, w3, #0x1
> |        str     w3, [x2, #8]
> |        mrs     x3, tpidr_el1
> |        str     x1, [x0, x3]
> |        ldr     x0, [x2, #8]
> |        sub     x0, x0, #0x1
> |        str     w0, [x2, #8]
> |        cbz     x0, 1f
> |        ldr     x0, [x2, #8]
> |        cbnz    x0, 2f
> | 1:     bl      preempt_schedule_notrace
> | 2:     ldp     x29, x30, [sp], #16
> |        autiasp
> |        ret
> 
> Generated code after this patch:
> 
> | <outline_this_cpu_write_u64>:
> |        mrs     x2, sp_el0
> |        mov     w3, #0x7c60
> |        strh    w3, [x2, #20]
> |        mrs     x3, tpidr_el1
> |        str     x1, [x0, x3]
> |        strh    wzr, [x2, #20]
> |        ret
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Jinjie Ruan <ruanjinjie@huawei.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Vladimir Murzin <vladimir.murzin@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Yang Shi <yang@os.amperecomputing.com>
> ---
FYI I'm seeing build warnings caused by this patch (with ftrace enabled - based 
on the warnings, I'm guessing that's the key bit), using:

aarch64-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

I haven't investigated the cause.

Thanks,
Ryan

---8<---
In file included from linux/arch/arm64/include/asm/spectre.h:17,                                                                                                                                                                       
                 from linux/arch/arm64/include/asm/processor.h:47,
                 from linux/include/linux/sched.h:13,
                 from linux/include/linux/ratelimit.h:6,
                 from linux/include/linux/dev_printk.h:16,
                 from linux/include/linux/device.h:15,
                 from linux/include/linux/node.h:18,
                 from linux/include/linux/cpu.h:17,
                 from linux/include/linux/stop_machine.h:5,
                 from linux/kernel/trace/ftrace.c:17:
linux/kernel/trace/ftrace.c: In function 'ftrace_filter_pid_sched_switch_probe':
linux/arch/arm64/include/asm/percpu.h:295:42: warning: conversion from 'long unsigned int' to 'u8' {aka 'unsigned char'} changes value from '18446744073709551615' to '255' [-Woverflow]                                               
  295 |         _pcp_wrap(__percpu_write_8, pcp, (unsigned long)(val))
      |                                          ^~~~~~~~~~~~~~~~~~~~
linux/arch/arm64/include/asm/percpu.h:277:20: note: in definition of macro '_pcp_wrap'
  277 |         op(&(pcp), __VA_ARGS__);                                        \
      |                    ^~~~~~~~~~~
linux/include/linux/percpu-defs.h:369:25: note: in expansion of macro 'this_cpu_write_1'
  369 |                 case 1: stem##1(variable, __VA_ARGS__);break;           \
      |                         ^~~~
linux/include/linux/percpu-defs.h:500:41: note: in expansion of macro '__pcpu_size_call'
  500 | #define this_cpu_write(pcp, val)        __pcpu_size_call(this_cpu_write_, pcp, val)
      |                                         ^~~~~~~~~~~~~~~~
linux/kernel/trace/ftrace.c:8628:17: note: in expansion of macro 'this_cpu_write'
 8628 |                 this_cpu_write(tr->array_buffer.data->ftrace_ignore_pid,
      |                 ^~~~~~~~~~~~~~
linux/arch/arm64/include/asm/percpu.h:297:43: warning: conversion from 'long unsigned int' to 'u16' {aka 'short unsigned int'} changes value from '18446744073709551615' to '65535' [-Woverflow]
  297 |         _pcp_wrap(__percpu_write_16, pcp, (unsigned long)(val))
      |                                           ^~~~~~~~~~~~~~~~~~~~
linux/arch/arm64/include/asm/percpu.h:277:20: note: in definition of macro '_pcp_wrap'
  277 |         op(&(pcp), __VA_ARGS__);                                        \
      |                    ^~~~~~~~~~~
linux/include/linux/percpu-defs.h:370:25: note: in expansion of macro 'this_cpu_write_2'
  370 |                 case 2: stem##2(variable, __VA_ARGS__);break;           \
      |                         ^~~~
linux/include/linux/percpu-defs.h:500:41: note: in expansion of macro '__pcpu_size_call'
  500 | #define this_cpu_write(pcp, val)        __pcpu_size_call(this_cpu_write_, pcp, val)
      |                                         ^~~~~~~~~~~~~~~~
linux/kernel/trace/ftrace.c:8628:17: note: in expansion of macro 'this_cpu_write'
 8628 |                 this_cpu_write(tr->array_buffer.data->ftrace_ignore_pid,
      |                 ^~~~~~~~~~~~~~
linux/arch/arm64/include/asm/percpu.h:299:43: warning: conversion from 'long unsigned int' to 'u32' {aka 'unsigned int'} changes value from '18446744073709551615' to '4294967295' [-Woverflow]
  299 |         _pcp_wrap(__percpu_write_32, pcp, (unsigned long)(val))
      |                                           ^~~~~~~~~~~~~~~~~~~~
linux/arch/arm64/include/asm/percpu.h:277:20: note: in definition of macro '_pcp_wrap'
  277 |         op(&(pcp), __VA_ARGS__);                                        \
      |                    ^~~~~~~~~~~
linux/include/linux/percpu-defs.h:371:25: note: in expansion of macro 'this_cpu_write_4'
  371 |                 case 4: stem##4(variable, __VA_ARGS__);break;           \
      |                         ^~~~
linux/include/linux/percpu-defs.h:500:41: note: in expansion of macro '__pcpu_size_call'
  500 | #define this_cpu_write(pcp, val)        __pcpu_size_call(this_cpu_write_, pcp, val)
      |                                         ^~~~~~~~~~~~~~~~
linux/kernel/trace/ftrace.c:8628:17: note: in expansion of macro 'this_cpu_write'
 8628 |                 this_cpu_write(tr->array_buffer.data->ftrace_ignore_pid,
      |                 ^~~~~~~~~~~~~~
linux/kernel/trace/ftrace.c: In function 'ignore_task_cpu':
linux/arch/arm64/include/asm/percpu.h:295:42: warning: conversion from 'long unsigned int' to 'u8' {aka 'unsigned char'} changes value from '18446744073709551615' to '255' [-Woverflow]
  295 |         _pcp_wrap(__percpu_write_8, pcp, (unsigned long)(val))
      |                                          ^~~~~~~~~~~~~~~~~~~~
linux/arch/arm64/include/asm/percpu.h:277:20: note: in definition of macro '_pcp_wrap'
  277 |         op(&(pcp), __VA_ARGS__);                                        \
      |                    ^~~~~~~~~~~
linux/include/linux/percpu-defs.h:369:25: note: in expansion of macro 'this_cpu_write_1'
  369 |                 case 1: stem##1(variable, __VA_ARGS__);break;           \
      |                         ^~~~
linux/include/linux/percpu-defs.h:500:41: note: in expansion of macro '__pcpu_size_call'
  500 | #define this_cpu_write(pcp, val)        __pcpu_size_call(this_cpu_write_, pcp, val)
      |                                         ^~~~~~~~~~~~~~~~
linux/kernel/trace/ftrace.c:8898:17: note: in expansion of macro 'this_cpu_write'
 8898 |                 this_cpu_write(tr->array_buffer.data->ftrace_ignore_pid,
      |                 ^~~~~~~~~~~~~~
linux/arch/arm64/include/asm/percpu.h:297:43: warning: conversion from 'long unsigned int' to 'u16' {aka 'short unsigned int'} changes value from '18446744073709551615' to '65535' [-Woverflow]
  297 |         _pcp_wrap(__percpu_write_16, pcp, (unsigned long)(val))
      |                                           ^~~~~~~~~~~~~~~~~~~~
linux/arch/arm64/include/asm/percpu.h:277:20: note: in definition of macro '_pcp_wrap'
  277 |         op(&(pcp), __VA_ARGS__);                                        \
      |                    ^~~~~~~~~~~
linux/include/linux/percpu-defs.h:370:25: note: in expansion of macro 'this_cpu_write_2'
  370 |                 case 2: stem##2(variable, __VA_ARGS__);break;           \
      |                         ^~~~
linux/include/linux/percpu-defs.h:500:41: note: in expansion of macro '__pcpu_size_call'
  500 | #define this_cpu_write(pcp, val)        __pcpu_size_call(this_cpu_write_, pcp, val)
      |                                         ^~~~~~~~~~~~~~~~
linux/kernel/trace/ftrace.c:8898:17: note: in expansion of macro 'this_cpu_write'
 8898 |                 this_cpu_write(tr->array_buffer.data->ftrace_ignore_pid,
      |                 ^~~~~~~~~~~~~~
linux/arch/arm64/include/asm/percpu.h:299:43: warning: conversion from 'long unsigned int' to 'u32' {aka 'unsigned int'} changes value from '18446744073709551615' to '4294967295' [-Woverflow]
  299 |         _pcp_wrap(__percpu_write_32, pcp, (unsigned long)(val))
      |                                           ^~~~~~~~~~~~~~~~~~~~
linux/arch/arm64/include/asm/percpu.h:277:20: note: in definition of macro '_pcp_wrap'
  277 |         op(&(pcp), __VA_ARGS__);                                        \
      |                    ^~~~~~~~~~~
linux/include/linux/percpu-defs.h:371:25: note: in expansion of macro 'this_cpu_write_4'
  371 |                 case 4: stem##4(variable, __VA_ARGS__);break;           \
      |                         ^~~~
linux/include/linux/percpu-defs.h:500:41: note: in expansion of macro '__pcpu_size_call'
  500 | #define this_cpu_write(pcp, val)        __pcpu_size_call(this_cpu_write_, pcp, val)
      |                                         ^~~~~~~~~~~~~~~~
linux/kernel/trace/ftrace.c:8898:17: note: in expansion of macro 'this_cpu_write'
 8898 |                 this_cpu_write(tr->array_buffer.data->ftrace_ignore_pid,
      |                 ^~~~~~~~~~~~~~
---8<---


