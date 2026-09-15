Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5519A3C060F
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 12:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789473697; cv=none; b=me4qtL7Kl0+SpigrrYS6IfuKg45ai5DEXn1cRWyKgF3Ao6QrTX8Vv/VjGk8bqikC1Pz9k39kpI1lleLBYn1dS4nSNv0/IVMzatQ+rTNpbnG9n/nqtN1v37gML/IWBCJf93S7hFfqWgIDfqOuwN6xA3tYP4cbrVWDjUYvW2q+UZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789473697; c=relaxed/simple;
	bh=QrsZfU+YSzGs0fdvbD5v+rX7myXysTM1Djl4St/cXe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uYf885xWJSk3JzMHvOdgp3FEvTlvnp+OQLQUjxE0lDMlnewlQDPCA2+QGxtNVledLkdaOexWOwTsTIEewFsCTNeDmHFxEE1NQLxcjVBxt/nGoMy583GRVsokxqExShUsUBTEa1v1nA/tKAVMqmq2n2lyO5nvTzfh0uOCG5UUpDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=XkTqiiKT; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XkTqiiKT"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33550152B;
	Tue, 15 Sep 2026 05:01:31 -0700 (PDT)
Received: from [10.0.152.207] (unknown [10.0.152.207])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F9DD3F882;
	Tue, 15 Sep 2026 05:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789473694; bh=QrsZfU+YSzGs0fdvbD5v+rX7myXysTM1Djl4St/cXe8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XkTqiiKT9oIHsj3qAVTJKKfrSI6xAu+euBALssMBEdEpy/tdYDgZ5g+l5hDVxwc/i
	 nJ65KAcr+PonZmpbCcriAJ97RhBNzmmz8CnwAcg8oAphdYCCM9c39a6DmUXCJ30Jbv
	 Zzme/7G8i8FDpLJwo7jhPxmKiQrJ+w3uUsbZKJ3Y=
Message-ID: <6833d578-9e79-4230-931d-c583d95db5d3@arm.com>
Date: Tue, 15 Sep 2026 13:01:29 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/21] arm64: percpu: Implement preemptible void RMW
 ops
To: Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: ada.coupriediaz@arm.com, ardb@kernel.org, catalin.marinas@arm.com,
 cl@gentwo.org, david@kernel.org, david.laight.linux@gmail.com,
 james.morse@arm.com, ljs@kernel.org, maz@kernel.org, peterz@infradead.org,
 ruanjinjie@huawei.com, ryan.roberts@arm.com, stable@vger.kernel.org,
 usama.anjum@arm.com, will@kernel.org, yang@os.amperecomputing.com
References: <20260908151741.394589-1-mark.rutland@arm.com>
 <20260908151741.394589-17-mark.rutland@arm.com>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <20260908151741.394589-17-mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/26 16:17, Mark Rutland wrote:
> Use the PCPU GPR infrastructure to implement all of the RMW ops which do
> not return a value.
> 
> Test case:
> 
> | void outline_this_cpu_add_u64(u64 __percpu *p, u64 v)
> | {
> | 	this_cpu_add(*p, v);
> | }
> 
> Generated code before this patch (v7.2-rc4):
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
> Generated code after this patch:
> 
> | <outline_this_cpu_add_u64>:
> |        mrs     x2, sp_el0
> |        mov     w4, #0xc80
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
>  arch/arm64/include/asm/percpu.h | 52 ++++++++++++++++++++-------------
>  1 file changed, 32 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
> index 984f69846cc09..504a7fefa2015 100644
> --- a/arch/arm64/include/asm/percpu.h
> +++ b/arch/arm64/include/asm/percpu.h
> @@ -168,23 +168,35 @@ static inline void __percpu_write_##sz(void __percpu *pcp, unsigned long val)	\
>  
>  #define __PERCPU_OP_CASE(w, sfx, name, sz, op_llsc, op_lse)		\
>  static inline void							\
> -__percpu_##name##_case_##sz(void *ptr, unsigned long val)		\
> +__percpu_##name##_case_##sz(void __percpu *pcp, unsigned long val)	\
>  {									\
> +	u16 *gprs = &current_thread_info()->pcpu_gprs;			\
> +	unsigned long addr;						\
> +	unsigned long off;						\
>  	unsigned int loop;						\
>  	u##sz tmp;							\
>  									\
> -	asm volatile (ARM64_LSE_ATOMIC_INSN(				\
> +	asm volatile (							\
> +	__PCPU_GPRS_BEGIN("%[gprs]", "%[pcp]", "%[off]", "%[addr]")	\
> +	ARM64_LSE_ATOMIC_INSN(						\
>  	/* LL/SC */							\
> -	"1:	ldxr" #sfx "\t%" #w "[tmp], %[ptr]\n"			\
> +	"1:	ldxr" #sfx "\t%" #w "[tmp], [%[addr]]\n"		\
>  		#op_llsc "\t%" #w "[tmp], %" #w "[tmp], %" #w "[val]\n"	\
> -	"	stxr" #sfx "\t%w[loop], %" #w "[tmp], %[ptr]\n"		\
> +	"	stxr" #sfx "\t%w[loop], %" #w "[tmp], [%[addr]]\n"	\
>  	"	cbnz	%w[loop], 1b",					\
>  	/* LSE atomics */						\
> -		#op_lse #sfx "\t%" #w "[val], %" #w "[tmp], %[ptr]\n"	\
> +		#op_lse #sfx "\t%" #w "[val], %" #w "[tmp], [%[addr]]\n"\
>  		__nops(3))						\
> -	: [loop] "=&r" (loop), [tmp] "=&r" (tmp),			\
> -	  [ptr] "+Q"(*(u##sz *)ptr)					\
> -	: [val] "r" ((u##sz)(val)));					\
> +	__PCPU_GPRS_END("%[gprs]")					\
> +	: [gprs] "=Qo" (*gprs),						\
> +	  [addr] "=&r" (addr),						\
> +	  [off] "=&r" (off),						\
> +	  [loop] "=&r" (loop),						\
> +	  [tmp] "=&r" (tmp)						\
> +	: [pcp] "r" (pcp),						\
> +	  [val] "r" ((u##sz)(val))					\
> +	: "memory"							\
> +	);								\
>  }
>  
>  #define __PERCPU_RET_OP_CASE(w, sfx, name, sz, op_llsc, op_lse)		\
> @@ -301,13 +313,13 @@ PERCPU_RET_OP(add, add, ldadd)
>  	_pcp_wrap(__percpu_write_64, pcp, (unsigned long)(val))
>  
>  #define this_cpu_add_1(pcp, val)	\
> -	_pcp_protect(__percpu_add_case_8, pcp, val)
> +	_pcp_wrap(__percpu_add_case_8, pcp, val)
>  #define this_cpu_add_2(pcp, val)	\
> -	_pcp_protect(__percpu_add_case_16, pcp, val)
> +	_pcp_wrap(__percpu_add_case_16, pcp, val)
>  #define this_cpu_add_4(pcp, val)	\
> -	_pcp_protect(__percpu_add_case_32, pcp, val)
> +	_pcp_wrap(__percpu_add_case_32, pcp, val)
>  #define this_cpu_add_8(pcp, val)	\
> -	_pcp_protect(__percpu_add_case_64, pcp, val)
> +	_pcp_wrap(__percpu_add_case_64, pcp, val)
>  
>  #define this_cpu_add_return_1(pcp, val)	\
>  	_pcp_protect_return(__percpu_add_return_case_8, pcp, val)
> @@ -319,22 +331,22 @@ PERCPU_RET_OP(add, add, ldadd)
>  	_pcp_protect_return(__percpu_add_return_case_64, pcp, val)
>  
>  #define this_cpu_and_1(pcp, val)	\
> -	_pcp_protect(__percpu_andnot_case_8, pcp, ~(u8)(val))
> +	_pcp_wrap(__percpu_andnot_case_8, pcp, ~(u8)(val))
>  #define this_cpu_and_2(pcp, val)	\
> -	_pcp_protect(__percpu_andnot_case_16, pcp, ~(u16)(val))
> +	_pcp_wrap(__percpu_andnot_case_16, pcp, ~(u16)(val))
>  #define this_cpu_and_4(pcp, val)	\
> -	_pcp_protect(__percpu_andnot_case_32, pcp, ~(u32)(val))
> +	_pcp_wrap(__percpu_andnot_case_32, pcp, ~(u32)(val))
>  #define this_cpu_and_8(pcp, val)	\
> -	_pcp_protect(__percpu_andnot_case_64, pcp, ~(u64)(val))
> +	_pcp_wrap(__percpu_andnot_case_64, pcp, ~(u64)(val))
>  
>  #define this_cpu_or_1(pcp, val)		\
> -	_pcp_protect(__percpu_or_case_8, pcp, val)
> +	_pcp_wrap(__percpu_or_case_8, pcp, val)
>  #define this_cpu_or_2(pcp, val)		\
> -	_pcp_protect(__percpu_or_case_16, pcp, val)
> +	_pcp_wrap(__percpu_or_case_16, pcp, val)
>  #define this_cpu_or_4(pcp, val)		\
> -	_pcp_protect(__percpu_or_case_32, pcp, val)
> +	_pcp_wrap(__percpu_or_case_32, pcp, val)
>  #define this_cpu_or_8(pcp, val)		\
> -	_pcp_protect(__percpu_or_case_64, pcp, val)
> +	_pcp_wrap(__percpu_or_case_64, pcp, val)
>  
>  #define this_cpu_xchg_1(pcp, val)	\
>  	_pcp_protect_return(xchg_relaxed, pcp, val)
> -- 2.30.2
> 

FWIW,

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>

