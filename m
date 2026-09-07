Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2A0442FB3
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 08:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788770545; cv=none; b=BkeaDe5nFIeGzsQCVp9ej526ivILRLHDGP/2VSM8kbvWJbYJYpJewEOrm+QuImBUMymNXOHFZ/eDjKBCwDfHRW/hLD1pYkUHNoP9vTr+bvAn3O+gvg5O0t8wqJSxSLj3peuVu1chQcCzltu6SyGN0okbLdDFcC1Zji7bSNopT24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788770545; c=relaxed/simple;
	bh=zX716zJx7KSMRR8dXUAvYZxYwu9/Gu9F70czLst6CVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LKYWm61ogB8Pcjs8sdLoStWFeQQYxwh04nyL0yH+cuiL880pLqi73aRqDDWKXsuw2ksKDYV932B/UWM8m2Q64COpdeLevH3kJvQhQMY/6JUxqd0C3PiAKraK+t3uqGDgiUHSpEU6gb9hQ+wUGSiVsy1FEQVqKDeFzSEjeioPV1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=P2RWmTb+; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="P2RWmTb+"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=gHi9jwxYYlWob1RbsNrMERTMavRnB+OdzDhRWHhPn0M=;
	b=P2RWmTb+rgrGN8pqOXPsmmFZ9VlR7g48tZb4KgQ8XV/nNRalroZhm7DHY6gLSYfH5jNJZ81/g
	bmvHbZTd5XCMXHI3QwupoT9glCauq8QlGi3OkZpZme8J30WGl6qJXqRlgtQgD6Bvmac9tFpZKAt
	chFJHGaV2JLjcDKZU85LTto=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hdgJK5f7kznV03;
	Mon,  7 Sep 2026 16:30:57 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 1BA6A40565;
	Mon,  7 Sep 2026 16:42:08 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemk200008.china.huawei.com (7.202.194.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 7 Sep 2026 16:42:07 +0800
Message-ID: <abacb170-d448-4571-92ff-cb9196d50e90@huawei.com>
Date: Mon, 7 Sep 2026 16:42:06 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/20] arm64: cmpxchg128: LSE: Remove redundant
 operands
To: Mark Rutland <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>
CC: <ada.coupriediaz@arm.com>, <ardb@kernel.org>, <catalin.marinas@arm.com>,
	<cl@gentwo.org>, <david@kernel.org>, <david.laight.linux@gmail.com>,
	<james.morse@arm.com>, <ljs@kernel.org>, <maz@kernel.org>,
	<peterz@infradead.org>, <ryan.roberts@arm.com>, <stable@vger.kernel.org>,
	<vladimir.murzin@arm.com>, <will@kernel.org>, <yang@os.amperecomputing.com>
References: <20260804170503.3513916-1-mark.rutland@arm.com>
 <20260804170503.3513916-5-mark.rutland@arm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260804170503.3513916-5-mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk200008.china.huawei.com (7.202.194.74)



在 2026/8/5 1:04, Mark Rutland 写道:
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
> +	: [new1] "r" (x2), [new2] "r" (x3)				\

Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>

>  	: cl);								\
>  									\
>  	r.low = x0; r.high = x1;					\

