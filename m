Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6069035C686
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789482048; cv=none; b=LTbA4Zo4/b0Q8arCgTBMpKU61RzicQHUXNFQS8kAMIjafj1Sf/LvT2MRQrXjs10GmpZzCG5/67NGxf3bJCAH1tSc/lRS84rzcZb8xUtfXmyhFQqoNfAy7QuCDmAD90urWEWvlaHNTKs9+uBqP1y6Nkb2sfSzviwxpgk35Xb3v6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789482048; c=relaxed/simple;
	bh=2u1WRwtXNhXm73Ue2XxSdKSGILE1jFRWOpVWkmsxetU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NrsTO9Au8xrZV1eZ5wHpdAMllX3xUaMyz7eLeapuuyHAB3W49YakIHCjg7eikJ9lQP+MRv9Up7gP37ZBgz8ipJGCk237OzKuzglnqRVWqb0sfHEB08I02Nj0CFmNvf85UHrEMS9opGvzo0W2t2iAz4M1wKfIZrwrzHNjUKEQ1ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Mic4QpiY; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Mic4QpiY"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9148D1516;
	Tue, 15 Sep 2026 07:20:40 -0700 (PDT)
Received: from [10.0.152.207] (unknown [10.0.152.207])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22AE93F7B4;
	Tue, 15 Sep 2026 07:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789482044; bh=2u1WRwtXNhXm73Ue2XxSdKSGILE1jFRWOpVWkmsxetU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Mic4QpiY+dhL0ouH2OU0z2B0axfu3sJbz2hWwvyY72H7lDzQ+5hkDdN4BI48BrHYE
	 wgbcPT9ZSXB/InX/24zFCJURl1Nx8pC0vWZtGMjPTOWnIbNHPmA0+5aYdQnr/JUHna
	 KQ1ySVJS3dRYObwDn2HJ2iJGXWzi4LpJVG45eefc=
Message-ID: <625240ea-c4e2-414d-b53f-4b3d361d8b30@arm.com>
Date: Tue, 15 Sep 2026 15:20:38 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 20/21] arm64: percpu: Implement preemptible CMPXCHG128
 ops
To: Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: ada.coupriediaz@arm.com, ardb@kernel.org, catalin.marinas@arm.com,
 cl@gentwo.org, david@kernel.org, david.laight.linux@gmail.com,
 james.morse@arm.com, ljs@kernel.org, maz@kernel.org, peterz@infradead.org,
 ruanjinjie@huawei.com, ryan.roberts@arm.com, stable@vger.kernel.org,
 usama.anjum@arm.com, will@kernel.org, yang@os.amperecomputing.com
References: <20260908151741.394589-1-mark.rutland@arm.com>
 <20260908151741.394589-21-mark.rutland@arm.com>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <20260908151741.394589-21-mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/26 16:17, Mark Rutland wrote:
> Use the PCPU GPR infrastructure to implement this_cpu_cmpxchg128().
> 
> Note that before this patch, the LL/SC and LSE implementation was chosen
> with an alternative branch. After this patch the implementations are
> patched inline, matching the style of the other percpu ops.
> 
> The sub-optimal register shuffling before and after this patch occurs
> because we hard-code specific registers, as LLVM (currently) lacks a way
> to place a 128-bit type in a compiler-allocated even-odd pair of
> registers for inline assembly. We should be able to improve that in
> future, given compiler support.
> 
> Test case:
> 
> | u128 outline_this_cpu_cmpxchg128(u128 __percpu *p, u128 old, u128 new)
> | {
> | 	return this_cpu_cmpxchg128(*p, old, new);
> | }
> 
> Generated code before this patch (v7.2-rc4):
> 
> | <outline_this_cpu_cmpxchg128>:
> |        paciasp
> |        stp     x29, x30, [sp, #-32]!
> |        mov     x6, x0
> |        mov     x0, x2
> |        mov     x29, sp
> |        mov     x1, x3
> |        mrs     x2, sp_el0
> |        ldr     w7, [x2, #8]
> |        add     w7, w7, #0x1
> |        str     w7, [x2, #8]
> |        mrs     x2, tpidr_el1
> |        add     x6, x6, x2
> |        b       4f
> |        mov     x2, x4
> |        mov     x3, x5
> |        mov     x4, x6
> |        mov     x5, x0
> |        mov     x7, x1
> |        casp    x0, x1, x2, x3, [x6]
> | 1:     mrs     x3, sp_el0
> |        ldr     x2, [x3, #8]
> |        sub     x2, x2, #0x1
> |        str     w2, [x3, #8]
> |        cbz     x2, 2f
> |        ldr     x2, [x3, #8]
> |        cbnz    x2, 3f
> | 2:     stp     x0, x1, [sp, #16]
> |        bl      preempt_schedule_notrace
> |        ldp     x0, x1, [sp, #16]
> | 3:     ldp     x29, x30, [sp], #32
> |        autiasp
> |        ret
> | 4:     prfm    pstl1strm, [x6]
> | 5:     ldxp    x8, x7, [x6]
> |        cmp     x8, x0
> |        ccmp    x7, x3, #0x0, eq
> |        b.ne    6f
> |        stxp    w2, x4, x5, [x6]
> |        cbnz    w2, 5b
> | 6:     mov     x0, x8
> |        mov     x1, x7
> |        b       1b
> 
> Generated code after this patch:
> 
> | <outline_this_cpu_cmpxchg128>:
> |        mov     x6, x0
> |        mov     x1, x3
> |        mov     x0, x2
> |        mov     x3, x5
> |        mrs     x7, sp_el0
> |        mov     x2, x4
> |        mov     w5, #0x10a6
> |        strh    w5, [x7, #20]
> |        mrs     x5, tpidr_el1
> |        add     x4, x6, x5
> |        prfm    pstl1strm, [x4]
> | 1:     ldxp    x9, x10, [x4]
> |        cmp     x9, x0
> |        ccmp    x10, x1, #0x0, eq
> |        b.ne    2f
> |        stxp    w8, x2, x3, [x4]
> |        cbnz    w8, 1b
> | 2:     strh    wzr, [x7, #20]
> |        mov     x0, x9
> |        mov     x1, x10
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
>  arch/arm64/include/asm/percpu.h | 70 +++++++++++++++++++++++++++------
>  1 file changed, 57 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
> index f19a82437b3fd..5cd98e20e825d 100644
> --- a/arch/arm64/include/asm/percpu.h
> +++ b/arch/arm64/include/asm/percpu.h
> @@ -490,19 +490,63 @@ PERCPU_CMPXCHG_OP(x,  , 64)
>  
>  #define this_cpu_cmpxchg64(pcp, o, n)	this_cpu_cmpxchg_8(pcp, o, n)
>  
> -#define this_cpu_cmpxchg128(pcp, o, n)					\
> -({									\
> -	typedef typeof(pcp) pcp_op_T__;					\
> -	u128 old__, new__, ret__;					\
> -	pcp_op_T__ *ptr__;						\
> -	old__ = o;							\
> -	new__ = n;							\
> -	preempt_disable_notrace();					\
> -	ptr__ = raw_cpu_ptr(&(pcp));					\
> -	ret__ = cmpxchg128_local((void *)ptr__, old__, new__);		\
> -	preempt_enable_notrace();					\
> -	ret__;								\
> -})
> +static inline u128
> +__percpu_cmpxchg_128(void __percpu *pcp, u128 old, u128 new)
> +{
> +	u16 *gprs = &current_thread_info()->pcpu_gprs;
> +	unsigned long addr;
> +	unsigned long off;
> +	union __u128_halves r, o = { .full = (old) },
> +			       n = { .full = (new) };
> +	register unsigned long ol asm ("x0") = o.low;
> +	register unsigned long oh asm ("x1") = o.high;
> +	register unsigned long nl asm ("x2") = n.low;
> +	register unsigned long nh asm ("x3") = n.high;
> +	unsigned long rl, rh;
> +	unsigned long tmp;
> +
> +	asm volatile (
> +	__PCPU_GPRS_BEGIN("%[gprs]", "%[pcp]", "%[off]", "%[addr]")
> +	ARM64_LSE_ATOMIC_INSN(
> +	/* LL/SC */
> +       "       prfm    pstl1strm, [%[addr]]\n"
> +       "1:     ldxp    %[rl], %[rh], [%[addr]]\n"
> +       "       cmp     %[rl], %[ol]\n"
> +       "       ccmp    %[rh], %[oh], 0, eq\n"
> +       "       b.ne    2f\n"
> +       "       stxp    %w[tmp], %[nl], %[nh], [%[addr]]\n"
> +       "       cbnz    %w[tmp], 1b\n"
> +       "2:\n"
> +	,
> +	/* LSE atomics */
> +	"	casp	%[ol], %[oh], %[nl], %[nh], [%[addr]]\n"
> +	"	mov	%[rl], %[ol]\n"
> +	"	mov	%[rh], %[oh]\n"
> +	__nops(4)
> +	)
> +	__PCPU_GPRS_END("%[gprs]")
> +	: [gprs] "=Qo" (*gprs),
> +	  [addr] "=&r" (addr),
> +	  [off] "=&r" (off),
> +	  [tmp] "=&r" (tmp),
> +	  [ol] "+&r" (ol),
> +	  [oh] "+&r" (oh),
> +	  [rl] "=&r" (rl),
> +	  [rh] "=&r" (rh)
> +	: [pcp] "r" (pcp),
> +	  [nl] "r" (nl),
> +	  [nh] "r" (nh)
> +	: "memory", "cc"
> +	);
> +
> +	r.low = rl;
> +	r.high = rh;
> +
> +	return r.full;
> +}
> +
> +#define this_cpu_cmpxchg128(pcp, o, n)	\
> +	_pcp_wrap_return(__percpu_cmpxchg_128, pcp, o, n)
>  
>  #ifdef __KVM_NVHE_HYPERVISOR__
>  extern unsigned long __hyp_per_cpu_offset(unsigned int cpu);
> -- 2.30.2
> 

FWIW,

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>

