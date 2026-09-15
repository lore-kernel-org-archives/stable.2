Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3E03B27EA
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 14:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789482017; cv=none; b=E4xdqRDfob7C4EvDY4jtxTwDtaj1SFEi6pKeVFbQBeFmTnK6naIHX+FquDU4U11dAgxMnVEXeDlj0TtopPWSv9AD+Yo/S5ghJjNMAmLT29L6gVcNFgCyORiWsu2AG+r2nH1cI4G1ffT84hn+ARZSLZ+mLNi2jrMQ8+5FdtWpcS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789482017; c=relaxed/simple;
	bh=AWr97DSOTJYws7q8KCNIbK2lz9EJ0f4I0BcfbeHrEVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=by4IEd6uGPihjQ5wfavZqr+E/gy50qEWM8BcblYpsdzv5JlDRv0s0BeMlKC9vaEs5TG2+QoQJmt/mPIpiGAkimG88BOFvnDvkJG4CgRjmKYErKEKhUkqnY03bYVueMyTJrL3ylIRtDlFapXd/XoT/NJgqGH4bvAnKoTIDdrYqsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=hGF751q8; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hGF751q8"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FE8A1516;
	Tue, 15 Sep 2026 07:20:11 -0700 (PDT)
Received: from [10.0.152.207] (unknown [10.0.152.207])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA2D63F7B4;
	Tue, 15 Sep 2026 07:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789482015; bh=AWr97DSOTJYws7q8KCNIbK2lz9EJ0f4I0BcfbeHrEVc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hGF751q8nw+1hc5c2uKRbfKRtNV4ldKFZX1ff5t+ObVCY3aCZkvoOmiBTMoqX9MoV
	 qB6NfnkHvGGTC/HX/U5i/0g/rprC4jIo7DDuhDM4mNTPpIQ0LfcVxeqDrhobnfxvNE
	 h3892h4fU1tR4ODOHZpSmgpbUgkjqoQfmRPrmOlk=
Message-ID: <60469883-465f-46dd-a1e1-9d2d746d826a@arm.com>
Date: Tue, 15 Sep 2026 15:20:09 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 19/21] arm64: percpu: Implement preemptible CMPXCHG ops
To: Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: ada.coupriediaz@arm.com, ardb@kernel.org, catalin.marinas@arm.com,
 cl@gentwo.org, david@kernel.org, david.laight.linux@gmail.com,
 james.morse@arm.com, ljs@kernel.org, maz@kernel.org, peterz@infradead.org,
 ruanjinjie@huawei.com, ryan.roberts@arm.com, stable@vger.kernel.org,
 usama.anjum@arm.com, will@kernel.org, yang@os.amperecomputing.com
References: <20260908151741.394589-1-mark.rutland@arm.com>
 <20260908151741.394589-20-mark.rutland@arm.com>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <20260908151741.394589-20-mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/26 16:17, Mark Rutland wrote:
> Use the PCPU GPR infrastructure to implement all of the {8,16,32,64}-bit
> cmpxchg ops.
> 
> Note that before this patch, the LL/SC and LSE implementation was chosen
> with an alternative branch. After this patch the implementations are
> patched inline, matching the style of the other percpu ops.
> 
> Test case:
> 
> | u64 outline_this_cpu_cmpxchg_u64(u64 __percpu *p, u64 o, u64 n)
> | {
> | 	return this_cpu_cmpxchg(*p, o, n);
> | }
> 
> Generated code before this patch (v7.2-rc4):
> 
> | <outline_this_cpu_cmpxchg_u64>:
> |        paciasp
> |        stp     x29, x30, [sp, #-32]!
> |        mrs     x4, sp_el0
> |        mov     x29, sp
> |        ldr     w3, [x4, #8]
> |        add     w3, w3, #0x1
> |        str     w3, [x4, #8]
> |        mrs     x3, tpidr_el1
> |        add     x3, x0, x3
> |        b       4f		// alternative branch
> |        cas     x1, x2, [x3]
> |        mov     x0, x1
> | 1:     mrs     x2, sp_el0
> |        ldr     x1, [x2, #8]
> |        sub     x1, x1, #0x1
> |        str     w1, [x2, #8]
> |        cbz     x1, 2f
> |        ldr     x1, [x2, #8]
> |        cbnz    x1, 3f
> | 2:     str     x0, [sp, #24]
> |        bl      preempt_schedule_notrace
> |        ldr     x0, [sp, #24]
> | 3:     ldp     x29, x30, [sp], #32
> |        autiasp
> |        ret
> | 4:     prfm    pstl1strm, [x3]
> | 5:     ldxr    x0, [x3]
> |        eor     x4, x0, x1
> |        cbnz    x4, 6f
> |        stxr    w4, x2, [x3]
> |        cbnz    w4, 5b
> | 6:     b       1b
> 
> Generated code after this patch:
> 
> | <outline_this_cpu_cmpxchg_u64>:
> |        mrs     x4, sp_el0
> |        mov     w6, #0x14c0
> |        strh    w6, [x4, #20]
> |        mrs     x6, tpidr_el1
> |        add     x5, x0, x6
> |        prfm    pstl1strm, [x5]
> | 1:     ldxr    x3, [x5]
> |        eor     x7, x3, x1
> |        cbnz    x7, 2f
> |        stxr    w7, x2, [x5]
> |        cbnz    w7, 1b
> | 2:     strh    wzr, [x4, #20]
> |        mov     x0, x3
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
>  arch/arm64/include/asm/percpu.h | 69 +++++++++++++++++++++++++++++++--
>  1 file changed, 65 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
> index 820340c61d70f..f19a82437b3fd 100644
> --- a/arch/arm64/include/asm/percpu.h
> +++ b/arch/arm64/include/asm/percpu.h
> @@ -306,12 +306,67 @@ __percpu_xchg_case_##sz(void __percpu *pcp, u##sz val)			\
>  	return ret;							\
>  }
>  
> +#define PERCPU_CMPXCHG_OP(w, sfx, sz)					\
> +static inline unsigned long						\
> +__percpu_cmpxchg_case_##sz(void __percpu *pcp,				\
> +			   u##sz old,					\
> +			   u##sz new)					\
> +{									\
> +	/*                                                              \
> +	 * Sub-word sizes require zero extension so that EOR+CBNZ don't	\
> +	 * consume non-zero upper bits of the register containing "old".\
> +	 */								\
> +	xwreg_t(w) cmpval = xwreg_zero_extend(old, w, sz);		\
> +	u16 *gprs = &current_thread_info()->pcpu_gprs;			\
> +	unsigned long addr;						\
> +	unsigned long off;						\
> +	unsigned long tmp;						\
> +	unsigned long oldval;						\
> +									\
> +	asm volatile (							\
> +	__PCPU_GPRS_BEGIN("%[gprs]", "%[pcp]", "%[off]", "%[addr]")	\
> +	ARM64_LSE_ATOMIC_INSN(						\
> +	/* LL/SC */							\
> +	"	prfm	pstl1strm, [%[addr]]\n"				\
> +	"1:	ldxr" #sfx "\t%" #w "[oldval], [%[addr]]\n"		\
> +	"	eor	%" #w "[tmp], %" #w "[oldval], %" #w "[old]\n"	\
> +	"	cbnz	%" #w "[tmp], 2f\n"				\
> +	"	stxr" #sfx "\t%w[tmp], %" #w "[new], [%[addr]]\n"	\
> +	"	cbnz	%w[tmp], 1b\n"					\
> +	"2:\n"								\
> +	,								\
> +	/* LSE atomics */						\
> +	"	mov	%" #w "[oldval], %" #w "[old]\n"		\
> +	"	cas" #sfx "\t%" #w "[oldval], %" #w "[new], [%[addr]]\n"\
> +		__nops(4)						\
> +	)								\
> +	__PCPU_GPRS_END("%[gprs]")					\
> +	: [gprs] "=Qo" (*gprs),						\
> +	  [addr] "=&r" (addr),						\
> +	  [off] "=&r" (off),						\
> +	  [tmp] "=&r" (tmp),						\
> +	  [oldval] "=&r" (oldval)					\
> +	: [pcp] "r" (pcp),						\
> +	  [old] "r" (cmpval),						\
> +	  [new] "r" (new)						\
> +	: "memory"							\
> +	);								\
> +									\
> +	return oldval;							\
> +}
> +
>  PERCPU_XCHG_OP(w, b, 8)
>  PERCPU_XCHG_OP(w, h, 16)
>  PERCPU_XCHG_OP(w,  , 32)
>  PERCPU_XCHG_OP(x,  , 64)
>  
> +PERCPU_CMPXCHG_OP(w, b, 8)
> +PERCPU_CMPXCHG_OP(w, h, 16)
> +PERCPU_CMPXCHG_OP(w,  , 32)
> +PERCPU_CMPXCHG_OP(x,  , 64)
> +
>  #undef PERCPU_XCHG_OP
> +#undef PERCPU_CMPXCHG_OP
>  
>  /*
>   * It would be nice to avoid the conditional call into the scheduler when
> @@ -355,6 +410,12 @@ PERCPU_XCHG_OP(x,  , 64)
>  	(typeof(pcp))op(&(pcp), (unsigned long)(val));			\
>  })
>  
> +#define _pcp_wrap_cmpxchg(op, pcp, old, new)				\
> +({									\
> +	(typeof(pcp))op(&(pcp), (unsigned long)(old),			\
> +			(unsigned long)(new));				\
> +})
> +
>  #define this_cpu_read_1(pcp)		\
>  	_pcp_wrap_return(__percpu_read_8, pcp)
>  #define this_cpu_read_2(pcp)		\
> @@ -419,13 +480,13 @@ PERCPU_XCHG_OP(x,  , 64)
>  	_pcp_wrap_xchg(__percpu_xchg_case_64, pcp, val)
>  
>  #define this_cpu_cmpxchg_1(pcp, o, n)	\
> -	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> +	_pcp_wrap_cmpxchg(__percpu_cmpxchg_case_8, pcp, o, n)
>  #define this_cpu_cmpxchg_2(pcp, o, n)	\
> -	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> +	_pcp_wrap_cmpxchg(__percpu_cmpxchg_case_16, pcp, o, n)
>  #define this_cpu_cmpxchg_4(pcp, o, n)	\
> -	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> +	_pcp_wrap_cmpxchg(__percpu_cmpxchg_case_32, pcp, o, n)
>  #define this_cpu_cmpxchg_8(pcp, o, n)	\
> -	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> +	_pcp_wrap_cmpxchg(__percpu_cmpxchg_case_64, pcp, o, n)
>  
>  #define this_cpu_cmpxchg64(pcp, o, n)	this_cpu_cmpxchg_8(pcp, o, n)
>  
> -- 2.30.2
> 

FWIW,

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>

