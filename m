Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDD9229B12
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 10:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789034830; cv=none; b=Wk+pnGq0DwJ5Vf9zzkxAjEzsxYlfkgFLL4a8QNJTpOXhOigHzqCD0wIyzaXMn2qNRZJXEmSvrUAxgWZMEd5K16OxYXfcJyUuCUDB7sUDczzJyuGL1TekMwDfBlrAhAizJVoKnbvVsWEZgxWTjBn6BVU4LD2ffsXEcnvh619PX10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789034830; c=relaxed/simple;
	bh=lce7eZgPvqANonEGS3VS67nJrhS6SudXV3cK2BAWgs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MM1IbjOzHVZ+FrdytkT28sI0EcFspPrTJPbsWkdvVapfVuznrAyPB5cdiA1sZQWxfRKkcf1m1kd4bLYqHtGMhs7J0agT4B/4mrpmz9trKVczWYfWqrJkWO5Tbe5SCyHvMvF0wn0CSr2gdfsYeRlbWz/EvPu3KOUvOTBltlmMbnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=vf0kfV5O; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="vf0kfV5O"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5541B1570;
	Thu, 10 Sep 2026 03:06:50 -0700 (PDT)
Received: from [10.0.152.207] (unknown [10.0.152.207])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1125B3F7B4;
	Thu, 10 Sep 2026 03:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789034814; bh=lce7eZgPvqANonEGS3VS67nJrhS6SudXV3cK2BAWgs0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vf0kfV5OIaN7jKxvjKPwTyTlUxc3ZBVV4uFgxlPVebmRDuKTgxR8f9qbyMJnM1o/c
	 VhZD3Il4io51hiUkWHSYNDMnfW/r5kUs7gnEN2s/y9Re1lWJhnBJRT/uL4iIcm3MfP
	 DF40HNXkIDSkQzyjzHupSnGGQ/oeGdoPLrisNR58=
Message-ID: <1b0a435e-68c1-46c2-8fc0-310694728772@arm.com>
Date: Thu, 10 Sep 2026 11:06:48 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/21] arm64: cmpxchg128: LSE: Remove redundant
 operands
To: Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: ada.coupriediaz@arm.com, ardb@kernel.org, catalin.marinas@arm.com,
 cl@gentwo.org, david@kernel.org, david.laight.linux@gmail.com,
 james.morse@arm.com, ljs@kernel.org, maz@kernel.org, peterz@infradead.org,
 ruanjinjie@huawei.com, ryan.roberts@arm.com, stable@vger.kernel.org,
 usama.anjum@arm.com, will@kernel.org, yang@os.amperecomputing.com
References: <20260908151741.394589-1-mark.rutland@arm.com>
 <20260908151741.394589-6-mark.rutland@arm.com>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <20260908151741.394589-6-mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/26 16:17, Mark Rutland wrote:
> The LSE assembly for cmpxhg128*() has redundant operands which cause
> unnecessary register pressure. These operands can be removed without
> adverse effects, as described below.
> 
> It is necessary to force specific registers for the 64-bit halves of
> 'old' and 'new', as the encoding of CASP[A][L] requires that these
> halves are allocated into even/odd register pairs, and contemporary
> versions of LLVM don't support a mechanism to allocate a value into an
> even/odd register pair for inline assembly. We manually allocate these
> into x0/x1/x2/x3.
> 
> It is not necessary to force the address into a specific register, as
> the encoding of CASP[A][L] can accept this in any GPR or SP. Hence, it
> is not necessary to manually allocate the address into x4 for the
> '[ptr]' operand. The assembly uses the '[v]' operand, and contemporary
> compilers happen to allocate '[v]' into a separate register from
> '[ptr]', meaning that '[ptr]' only serves to create register pressure.
> 
> It is not necessary to allocate the '[oldval1]' and '[oldval2]'
> operands, as these are not used by the assembly. The assembly uses the
> '[old1]' and '[old2]' operands for both input and output. The
> '[oldval1]' and '[oldval2]' operands only serve to create register
> pressure.
> 
> Remove the redundant operands. This saves on register pressure, as
> demonstrated by the test case below. There's still some unfortunate
> register shuffling due to the manual allocation of 'old' and 'new', but
> this should be less prominent within a larger function.
> 
> Test case:
> 
> | u128 outline_cmpxchg128(u128 *p, u128 old, u128 new)
> | {
> | 	return cmpxchg128(p, old, new);
> | }
> 
> Generated code before this patch:
> 
> | <outline_cmpxchg128>:
> |        mov     x6, x0
> |        mov     x1, x3
> |        mov     x0, x2
> |        b       1f
> |        mov     x2, x4
> |        mov     x3, x5
> |        mov     x4, x6
> |        mov     x5, x0
> |        mov     x7, x1
> |        caspal  x0, x1, x2, x3, [x6]
> |        ret
> | 1:     prfm    pstl1strm, [x6]
> | 2:     ldxp    x8, x7, [x6]
> |        cmp     x8, x0
> |        ccmp    x7, x3, #0x0, eq
> |        b.ne    3f
> |        stlxp   w2, x4, x5, [x6]
> |        cbnz    w2, 2b
> |        dmb     ish
> | 3:     mov     x0, x8
> |        mov     x1, x7
> |        ret
> 
> Generated code after this patch:
> 
> | <outline_cmpxchg128>:
> |        mov     x6, x0
> |        mov     x0, x2
> |        b       1f
> |        mov     x1, x3
> |        mov     x2, x4
> |        mov     x3, x5
> |        caspal  x0, x1, x2, x3, [x6]
> |        ret
> | 1:     prfm    pstl1strm, [x6]
> | 2:     ldxp    x8, x7, [x6]
> |        cmp     x8, x0
> |        ccmp    x7, x3, #0x0, eq
> |        3f
> |        stlxp   w2, x4, x5, [x6]
> |        cbnz    w2, 2b
> |        dmb     ish
> | 3:     mov     x0, x8
> |        mov     x1, x7
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
>  arch/arm64/include/asm/atomic_lse.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/atomic_lse.h b/arch/arm64/include/asm/atomic_lse.h
> index afad1849c4cf5..d588af0565331 100644
> --- a/arch/arm64/include/asm/atomic_lse.h
> +++ b/arch/arm64/include/asm/atomic_lse.h
> @@ -291,15 +291,13 @@ __lse__cmpxchg128##name(volatile u128 *ptr, u128 old, u128 new)		\
>  	register unsigned long x1 asm ("x1") = o.high;			\
>  	register unsigned long x2 asm ("x2") = n.low;			\
>  	register unsigned long x3 asm ("x3") = n.high;			\
> -	register unsigned long x4 asm ("x4") = (unsigned long)ptr;	\
>  									\
>  	asm volatile(							\
>  	__LSE_PREAMBLE							\
>  	"	casp" #mb "\t%[old1], %[old2], %[new1], %[new2], %[v]\n"\
>  	: [old1] "+&r" (x0), [old2] "+&r" (x1),				\
>  	  [v] "+Q" (*(u128 *)ptr)					\
> -	: [new1] "r" (x2), [new2] "r" (x3), [ptr] "r" (x4),		\
> -	  [oldval1] "r" (o.low), [oldval2] "r" (o.high)			\

Both 'old1' and #old are read and write and that reflected by '+' constraint modifier.
However, I do not fully understand why we need earlyclobber for them:
 - they are not written before read
 - we already constrained registers, so they do not overlap
 - cmpxchg few lines above doesn't need it

I had a look at ll/sc counterpart and both earlyclobebr and '=' constraint modifier
make sense there, since we do not want registers to overlap and they are written.

I admit might be missing something. Anyway, FWIW

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>

> +	: [new1] "r" (x2), [new2] "r" (x3)				\
>  	: cl);								\
>  									\
>  	r.low = x0; r.high = x1;					\
> -- 2.30.2
> 

