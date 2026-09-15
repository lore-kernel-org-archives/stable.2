Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F6639BFF1
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 14:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789481980; cv=none; b=swD7rEZbYjIMkmosUHi+kD/DHgck1RBNktOeIZwtyTlB+VOchps0+DRJ0WA62Js+/SCTokPyCyM7meocobVxFukMbyO4VCunYRuJGjtsN1jYveo65+08lXI6Gv63wErdaweVriQu7wSGBgNEIuC0Y4ONVXuqHh+1zEL+wZvKIz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789481980; c=relaxed/simple;
	bh=oqAEOjEnKOpLIX3eTtTetknKcZMUIk+H0j/BiuidvKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X9GNtmbyCg4ylbRDr5cErTv3kg3WlVPqdrSa7jAhHFL2cyDdWmb8kc6nPNUw7/P6+tyyAJRBgwsrz1vr8tOhlVXfTY6Nzc9dDQNiNgTEkkeW5INxAksXL7UCUnqm8tZi+gMf5YRer7peGJRvPJrRb34S8ENLJT8plrw8sS37H6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kE9q7Xmc; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kE9q7Xmc"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84E8E1516;
	Tue, 15 Sep 2026 07:19:34 -0700 (PDT)
Received: from [10.0.152.207] (unknown [10.0.152.207])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BD9B3F7B4;
	Tue, 15 Sep 2026 07:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789481978; bh=oqAEOjEnKOpLIX3eTtTetknKcZMUIk+H0j/BiuidvKs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kE9q7XmcAAoww+pOawSATsWyA+iJcBv0Uq3SXF0+To3NPayeiOrUV/3kQyTkaFiRC
	 SHkM0Ky9WB+3UiuKYYj+bmCWf/Iff3aE2Nee2Z4zbJ9dTnSHUhLa2xv+OTAYvxMUgU
	 t/oPlp7Z2UcZrYnmJQi7k+G4uM0l+XAnbaapVsLA=
Message-ID: <01f4cf62-eb8f-4435-bc92-6e8a2d196a20@arm.com>
Date: Tue, 15 Sep 2026 15:19:32 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/21] arm64: percpu: Add infrastructure for
 preemptible this_cpu_*() ops
To: Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: ada.coupriediaz@arm.com, ardb@kernel.org, catalin.marinas@arm.com,
 cl@gentwo.org, david@kernel.org, david.laight.linux@gmail.com,
 james.morse@arm.com, ljs@kernel.org, maz@kernel.org, peterz@infradead.org,
 ruanjinjie@huawei.com, ryan.roberts@arm.com, stable@vger.kernel.org,
 usama.anjum@arm.com, will@kernel.org, yang@os.amperecomputing.com
References: <20260908151741.394589-1-mark.rutland@arm.com>
 <20260908151741.394589-15-mark.rutland@arm.com>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <20260908151741.394589-15-mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/26 16:17, Mark Rutland wrote:
> Currently arm64's this_cpu_*() ops transiently disable preemption in
> order to guarantee that the address generation and memory access(es)
> occur on the same CPU.
> 
> Transiently disabling preemption can be  expensive. When re-enabling
> preemption it is necessary to make a conditional function call to
> preempt_schedule[_notrace]() in order to handle the rare case that the
> task needs to be rescheduled. The potential function call has a number
> of negative effects on code generation (e.g. due to the need to create a
> stack frame and spill registers), and the conditionality can result in
> poor code generation and/or poor branch prediction.
> 
> This patch adds infrastructure for a scheme where this_cpu_*() ops do
> not need to transiently disable preemption, avoiding the negative
> impacts described above. Individual operations will be converted in
> subsequent patches.
> 
> Each operation registers a critical section during which the exception
> return code will adjust the offset and addresses if preemption occurs
> mid-sequence. The critical section is registered/unregistered with a
> small prologue and epilogue which encodes three distinct GPRRs (<pcp>,
> <off>, <addr>) into a new thread_info::pcp_gprs field:
> 
>          // Prologue. Enable fixups for <off> and <addr>.
>          mrs	<tsk>, sp_el0
>          mov	<tmp>, #__VAL_PCPU_GPRS(<pcp>, <off>, <addr>)
>          strh	<tmp>, [<tsk>, #TSK_TI_PCPU_GPRS]
> 
>          // Generate cpu-specific address
>          mrs	<off>, TPIDR_ELx
>          add	<addr>, <pcp>, <off>
> 
>          // Perform access sequence
>          ldr	<val>, [<addr>]
> 
>          // Epilogue. Disable fixups
>          strh	wzr, [<tsk>, #TSK_TI_PCPU_GPRS]
> 
> If an exception is taken from within the critical section, the exception
> return code will adjust <off> to be the current CPU's offset, and will
> adjust <addr> to be (<pcp> + <off>). Distinct registers are used for
> <pcp>, <off>, and <addr>, so that the fixup can be applied safely at any
> point during the critical section.
> 
> To ensure that this_cpu_*() operations within exception handlers work
> correctly and do not corrupt state, thread_info::pcpu_gprs is saved
> into a new pt_regs::pcpu_gprs field upon exception entry, and restored
> upon exception return.
> 
> Looking at a simple this_cpu_operation:
> 
> | void outline_this_cpu_add_u64(u64 __percpu *p, u64 v)
> | {
> | 	this_cpu_add(*p, v);
> | }
> 
> Atop v7.2-rc4, with GCC 15.2.0 and defconfig, this is compiled as:
> 
> | <outline_this_cpu_add_u64>:
> |        paciasp
> |        stp     x29, x30, [sp, #-16]!
> |        mrs     x2, sp_el0
> |        mov     x29, sp
> |        ldr     w3, [x2, #8]
> |        add     w3, w3, #0x1
> |        str     w3, [x2, #8]
> |        mrs     x3, tpidr_el1
> |        add     x0, x0, x3
> | 1:     ldxr    x5, [x0]
> |        add     x5, x5, x1
> |        stxr    w4, x5, [x0]
> |        cbnz    w4, 1b
> |        ldr     x0, [x2, #8]
> |        sub     x0, x0, #0x1
> |        str     w0, [x2, #8]
> |        cbz     x0, 2f
> |        ldr     x0, [x2, #8]
> |        cbnz    x0, 3f
> | 2:     bl      preempt_schedule_notrace
> | 3:     ldp     x29, x30, [sp], #16
> |        autiasp
> |        ret
> 
> With the scheme added in this patch, this can be compiled as:
> 
> | <outline_this_cpu_add_u64>:
> |        mrs     x2, sp_el0
> |        mov     x4, #0xc80     // __VAL_PCPU_GPRS(x0, x4, x3)
> |        strh    w4, [x2, #20]
> |        mrs     x4, tpidr_el1
> |        add     x3, x0, x4
> | 1:     ldxr    x6, [x3]
> |        add     x6, x6, x1
> |        stxr    w5, x6, [x3]
> |        cbnz    w5, 1b
> |        strh    wzr, [x2, #20]
> |        ret
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
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
>  arch/arm64/include/asm/percpu.h      | 71 ++++++++++++++++++++++++++++
>  arch/arm64/include/asm/ptrace.h      |  5 ++
>  arch/arm64/include/asm/thread_info.h |  1 +
>  arch/arm64/kernel/asm-offsets.c      |  2 +
>  arch/arm64/kernel/entry-common.c     | 38 +++++++++++++++
>  arch/arm64/kernel/entry.S            | 22 +++++++++
>  6 files changed, 139 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
> index 746d2a56f48bb..03fa916030fd1 100644
> --- a/arch/arm64/include/asm/percpu.h
> +++ b/arch/arm64/include/asm/percpu.h
> @@ -5,10 +5,13 @@
>  #ifndef __ASM_PERCPU_H
>  #define __ASM_PERCPU_H
>  
> +#include <linux/bits.h>
>  #include <linux/preempt.h>
> +#include <linux/stringify.h>
>  
>  #include <asm/alternative.h>
>  #include <asm/cmpxchg.h>
> +#include <asm/gpr-num.h>
>  #include <asm/stack_pointer.h>
>  #include <asm/sysreg.h>
>  
> @@ -51,6 +54,74 @@ static inline unsigned long __kern_my_cpu_offset(void)
>  	return off;
>  }
>  
> +#define PCPU_GPR_PCP_SHIFT		0
> +#define PCPU_GPR_PCP			GENMASK(4, 0)
> +#define PCPU_GPR_OFF_SHIFT		5
> +#define PCPU_GPR_OFF			GENMASK(9, 5)
> +#define PCPU_GPR_ADDR_SHIFT		10
> +#define PCPU_GPR_ADDR			GENMASK(14, 10)
> +
> +#define __VAL_PCPU_GPRS(pcp, off, addr)							\
> +	"("										\
> +		"(" __GPR_NUM(pcp)  " << " __stringify(PCPU_GPR_PCP_SHIFT) ") | "	\
> +		"(" __GPR_NUM(off)  " << " __stringify(PCPU_GPR_OFF_SHIFT) ") | "	\
> +		"(" __GPR_NUM(addr) " << " __stringify(PCPU_GPR_ADDR_SHIFT) ")"		\
> +	")"
> +
> +#define __ASSERT_PCPU_GPRS_DISTINCT(pcp, off, addr)			\
> +	".if ("								\
> +		"(" __GPR_NUM(pcp) " == " __GPR_NUM(off) ") || "	\
> +		"(" __GPR_NUM(pcp) " == " __GPR_NUM(addr) ") || "	\
> +		"(" __GPR_NUM(off) " == " __GPR_NUM(addr) ")"		\
> +	"    )\n"							\
> +	".error \"PCPU GPRS overlap: {" pcp "," off "," addr "}\"\n"	\
> +	".endif\n"
> +
> +#define ____PCPU_GPRS_BEGIN(gprs, pcp, off, addr)			\
> +	"// ____PCPU_GPRS_BEGIN(" gprs ", " pcp ", " off ", " addr")\n"	\
> +	__DEFINE_ASM_GPR_NUMS						\
> +	__DEFINE_ASM_GPR_ALIASES					\
> +	__ASSERT_PCPU_GPRS_DISTINCT(pcp, off, addr)			\
> +	"	mov w" off ", #" __VAL_PCPU_GPRS(pcp, off, addr) "\n"	\
> +	"	strh	w" off ", " gprs "\n"				\
> +	__KERN_ASM_CPU_OFFSET(off) "\n"
> +
> +/*
> + * Begin a PCPU GPR critical section which requires <addr> (and <off>).
> + *
> + * At the start of the critical section, and upon any (preemptible) exception
> + * until __PCPU_GPRS_END():
> + * - <off>  will be set to the current CPU's percpu offset.
> + * - <addr> will be set to <pcp> + <off>.
> + *
> + * The <pcp>, <off>, and <addr> registers must be distinct GPRs.
> + *
> + * <gprs> must be '&current_thread_info()->gprs', as a memory operand which can
> + * be written both at the start and end of the critical section (e.g. using
> + * "=Qo" constraints).
> + */
> +#define __PCPU_GPRS_BEGIN(gprs, pcp, off, addr)				\
> +	____PCPU_GPRS_BEGIN(gprs, pcp, off, addr)			\
> +	"	add	" addr ", " pcp ", " off "\n"
> +
> +/*
> + * Begin a PCPU GPR critical section which only requires <off> and does not
> + * require <addr>.
> + *
> + * This is only for operations that can use register-offset addressing,
> + * e.g. STR <Xt>, [<Xn>, <Xm].
> + *
> + * All other details are the same as __PCPU_GPRS_BEGIN().
> + */
> +#define __PCPU_GPRS_BEGIN_OFFSET(gprs, pcp, off)			\
> +	____PCPU_GPRS_BEGIN(gprs, pcp, off, "xzr")
> +
> +/*
> + * End a PCU GPR critical section.
> + */
> +#define __PCPU_GPRS_END(gprs)						\
> +	"	strh	wzr, " gprs "\n"
> +
>  #ifdef __KVM_NVHE_HYPERVISOR__
>  #define __my_cpu_offset __hyp_my_cpu_offset()
>  #else
> diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
> index f635c3453a858..25c70374cb7b4 100644
> --- a/arch/arm64/include/asm/ptrace.h
> +++ b/arch/arm64/include/asm/ptrace.h
> @@ -167,6 +167,11 @@ struct pt_regs {
>  
>  	u64 sdei_ttbr1;
>  	struct frame_record_meta stackframe;
> +
> +	u16	pcpu_gprs;
> +	u16	__unused1;
> +	u32	__unused2;
> +	u64	__unused3;
>  };
>  
>  /* For correct stack alignment, pt_regs has to be a multiple of 16 bytes. */
> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
> index 5d7fe3e153c85..6db5fa72211d1 100644
> --- a/arch/arm64/include/asm/thread_info.h
> +++ b/arch/arm64/include/asm/thread_info.h
> @@ -46,6 +46,7 @@ struct thread_info {
>  	u64			mpam_partid_pmg;
>  #endif
>  	u32			cpu;
> +	u16			pcpu_gprs;
>  };
>  
>  #define thread_saved_pc(tsk)	\
> diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
> index 9c853ed3ceab8..9d603317eeb99 100644
> --- a/arch/arm64/kernel/asm-offsets.c
> +++ b/arch/arm64/kernel/asm-offsets.c
> @@ -36,6 +36,7 @@ int main(void)
>    DEFINE(TSK_TI_SCS_BASE,	offsetof(struct task_struct, thread_info.scs_base));
>    DEFINE(TSK_TI_SCS_SP,		offsetof(struct task_struct, thread_info.scs_sp));
>  #endif
> +  DEFINE(TSK_TI_PCPU_GPRS,	offsetof(struct task_struct, thread_info.pcpu_gprs));
>    DEFINE(TSK_STACK,		offsetof(struct task_struct, stack));
>  #ifdef CONFIG_STACKPROTECTOR
>    DEFINE(TSK_STACK_CANARY,	offsetof(struct task_struct, stack_canary));
> @@ -78,6 +79,7 @@ int main(void)
>    DEFINE(S_PMR,			offsetof(struct pt_regs, pmr));
>    DEFINE(S_STACKFRAME,		offsetof(struct pt_regs, stackframe));
>    DEFINE(S_STACKFRAME_TYPE,	offsetof(struct pt_regs, stackframe.type));
> +  DEFINE(S_PCPU_GPRS,		offsetof(struct pt_regs, pcpu_gprs));
>    DEFINE(PT_REGS_SIZE,		sizeof(struct pt_regs));
>    BLANK();
>  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index 72c03ccea59fe..11d3f888fcd87 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -25,12 +25,49 @@
>  #include <asm/irq_regs.h>
>  #include <asm/kprobes.h>
>  #include <asm/mmu.h>
> +#include <asm/percpu.h>
>  #include <asm/processor.h>
>  #include <asm/sdei.h>
>  #include <asm/stacktrace.h>
>  #include <asm/sysreg.h>
>  #include <asm/system_misc.h>
>  
> +/*
> + * Where the context being returned to had an active percpu GPR critical
> + * section, ensure that the offset and address GPRs are updated to match the
> + * current CPU.
> + *
> + * For simplicity we always update the GPRs when a critical section is active
> + * and preemption was *possible*, regardless of whether preemption actually
> + * occurred. Where preemption did not occur, the updates are redundant but not
> + * harmful.
> + */
> +static __always_inline void irqentry_exit_pcpu_adjust(struct pt_regs *regs)
> +{
> +	int reg_pcp, reg_off, reg_addr;
> +	unsigned long pcp, off, addr;
> +	u16 gprs = regs->pcpu_gprs;
> +
> +	/*
> +	 * Zero means no active PCPU GPRs. As the PCPU GPRs must be distinct,
> +	 * a PCPU critical section cannot possibly use {x0,x0,x0}.
> +	 */
> +	if (likely(!gprs))
> +		return;
> +
> +	reg_pcp  = FIELD_GET(PCPU_GPR_PCP,  gprs);
> +	reg_off  = FIELD_GET(PCPU_GPR_OFF,  gprs);
> +	reg_addr = FIELD_GET(PCPU_GPR_ADDR, gprs);
> +
> +	pcp = pt_regs_read_reg(regs, reg_pcp);
> +
> +	off = __kern_my_cpu_offset();
> +	pt_regs_write_reg(regs, reg_off, off);
> +
> +	addr = pcp + off;
> +	pt_regs_write_reg(regs, reg_addr, addr);
> +}
> +
>  /*
>   * Handle IRQ/context state management when entering from kernel mode.
>   * Before this function is called it is not safe to call regular kernel code,
> @@ -56,6 +93,7 @@ static void noinstr __arm64_exit_to_kernel_mode(struct pt_regs *regs,
>  						irqentry_state_t state)
>  {
>  	local_daif_mask();
> +	irqentry_exit_pcpu_adjust(regs);
>  	mte_check_tfsr_exit();
>  	irqentry_exit_to_kernel_mode_after_preempt(regs, state);
>  }
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 0902c1bd9dd3d..8d17f61d1b5b2 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -194,6 +194,17 @@ alternative_cb_end
>  #endif
>  	.endm
>  
> +	.macro pcpu_gprs_entry, tsk:req, regs:req, tmp:req
> +	ldrh	w\tmp, [\tsk, #TSK_TI_PCPU_GPRS]
> +	strh	w\tmp, [\regs, #S_PCPU_GPRS]
> +	strh	wzr, [\tsk, #TSK_TI_PCPU_GPRS]
> +	.endm
> +
> +	.macro pcpu_gprs_exit, tsk:req, regs:req, tmp:req
> +	ldrh	w\tmp, [\regs, #S_PCPU_GPRS]
> +	strh	w\tmp, [\tsk, #TSK_TI_PCPU_GPRS]
> +	.endm
> +

For my own refernce. The reason we disable critical section on entry
and re-enable on exit is to deal with nested exceptions, for insatnce,

< exception #1 >
     regs->pcpu_gpr = tsk->pcpu_gpr // assume non-zero
(1)  tsk->pcpu_gpr = 0
     ...
     < exception #2 >
       regs->pcpu_gpr = tsk->pcpu_gpr // effecevly 0
       tsk->pcpu_gpr = 0
       ...
       irqentry_exit_pcpu_adjust()
(2)      retrun;
       ...
       tsk->pcpu_gpr = regs->pcpu_gpr // effectivly 0
(3)  ...
     irqentry_exit_pcpu_adjust()
       ...
       pt_regs_write_reg(...)
       ...
     tsk->pcpu_gpr = regs->pcpu_gpr // effectivly 0
     ...

witout (1), (2) could update regs, so once returned to (3)
registers for exception #1 could be corrupted.


>  	.macro	kernel_entry, el, regsize = 64
>  	.if	\el == 0
>  	alternative_insn nop, SET_PSTATE_DIT(1), ARM64_HAS_DIT
> @@ -277,6 +288,7 @@ alternative_else_nop_endif
>  	.else
>  	add	x21, sp, #PT_REGS_SIZE
>  	get_current_task tsk
> +	pcpu_gprs_entry	tsk, sp, x0
>  	.endif /* \el == 0 */
>  	mrs	x22, elr_el1
>  	mrs	x23, spsr_el1
> @@ -333,6 +345,10 @@ alternative_else_nop_endif
>  	.endm
>  
>  	.macro	kernel_exit, el
> +	.if	\el != 0
> +	pcpu_gprs_exit	tsk, sp, x0
> +	.endif
> +
>  #ifdef CONFIG_ARM64_PSEUDO_NMI
>  alternative_if_not ARM64_HAS_GIC_PRIO_MASKING
>  	b	.Lskip_pmr_restore\@
> @@ -1040,10 +1056,16 @@ SYM_CODE_START(__sdei_asm_handler)
>  	stp	x29, x4, [sp, #-16]!
>  	mov	x29, sp
>  
> +	add	x16, x19, #SDEI_EVENT_INTREGS
> +	pcpu_gprs_entry tsk, x16, x17
> +
>  	add	x0, x19, #SDEI_EVENT_INTREGS
>  	mov	x1, x19
>  	bl	__sdei_handler
>  
> +	add	x16, x19, #SDEI_EVENT_INTREGS
> +	pcpu_gprs_exit tsk, x16, x17
> +
>  	msr	sp_el0, x20
>  	/* restore regs >x17 that firmware won't restore */
>  	mov	x4, x19         // keep x4 for __sdei_asm_exit_trampoline
> -- 2.30.2
> 

FWIW,

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>

