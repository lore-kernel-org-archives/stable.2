Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5241B3F8ED6
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 09:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096332; cv=none; b=VFL7iI8HFGP4JyvWf0QyLW+0NS6ElSLumX4zPr+Lo0DKKGcuexOTAR+tqA3n8ecDqUnPGN6jBUne/IMfVC7WmtNHtw1CB3PnFxFmyKctgdNhuUcNYN+650My9vfcMgexcI/9AdnWKNlQhuxnj8WJ7m7SYrfQNKHiZg0wyWVGOLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096332; c=relaxed/simple;
	bh=o4dVQ9MlprH7HOaaloWKwDdexd53cnZffz6QEa58Uhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lMfzPpuslZckjbKFnuqe+1FOhAJx01Db8p/ZZeYx02cOCM2hi5rnT4sYY1WZxHfRr9Hb5Bn5EpFbJRGeJugJ8pc29te3LOIl6eQPbo9ZQbWb5a/nX6cDeOoXexRnxhnXIEAs7eMG5+8bPO5QWJHoE3xHwsB0+OxWqkVVJlfPJJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=BKgknH5j; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="BKgknH5j"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=7wIyNcLqed5ZVpQIQecWwGt1wAPqTwpYyb9INfK67g4=;
	b=BKgknH5jfAI9E72DWVubPI/Eol/+zWF0BcqV15fW6gH66tKjlge4rG9iEBzyotx4Y+SxA5VcR
	ERODHCwUBvvEytOAeDt7B7hCbQG6vpp0u6O/Fivy6//hLMPP6SBwr1SzVG8Hfmy+mvfGx3fD4Q9
	40yeQvqUihSHzF5OEYWx5V0=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4hGfL23PF9zLlXX;
	Fri,  7 Aug 2026 17:41:30 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 467E44048B;
	Fri,  7 Aug 2026 17:52:04 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 7 Aug 2026 17:52:03 +0800
Message-ID: <6b549b5b-5d90-4d75-94e9-b5f7cf7605f5@huawei.com>
Date: Fri, 7 Aug 2026 17:52:02 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/20] arm64: percpu: Fix this_cpu_and() mask
 generation
To: Mark Rutland <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>
CC: <ada.coupriediaz@arm.com>, <ardb@kernel.org>, <catalin.marinas@arm.com>,
	<cl@gentwo.org>, <david@kernel.org>, <david.laight.linux@gmail.com>,
	<james.morse@arm.com>, <ljs@kernel.org>, <maz@kernel.org>,
	<peterz@infradead.org>, <ryan.roberts@arm.com>, <stable@vger.kernel.org>,
	<vladimir.murzin@arm.com>, <will@kernel.org>, <yang@os.amperecomputing.com>
References: <20260804170503.3513916-1-mark.rutland@arm.com>
 <20260804170503.3513916-3-mark.rutland@arm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260804170503.3513916-3-mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500011.china.huawei.com (7.185.36.131)



在 2026/8/5 1:04, Mark Rutland 写道:
> The arm64 implementation of this_cpu_and(pcp, val) is built in terms of
> ANDNOT operations, which requires the 'val' argument to be bitwise
> negated. The bitwise negation is not implemented correctly, with two
> bugs described below.
> 
> (1) The bitwise negation is performed as '~val' rather than '~(val)'.
>     This won't always generate the expected value when 'val' is an
>     expression.
> 
>     For example, for this_cpu_and(pcp, 1 - 1):
> 
>     * 'val'    is  '1 - 1'   ===> (int) 0x00000000
>     * '~val'   is '~1 - 1'   ===> (int) 0xfffffffd
>     * '~(val)' is '~(1 - 1)' ===> (int) 0xffffffff
> 
>     ... and thus bit[1] of 'pcp' would be preserved unexpectedly by the
>     ANDNOT operation.
> 
> (2) The bitwise negation is performed on 'val' before it has been cast
>     to (at least) the width of 'pcp'. This won't always generate the
>     expected value for the upper bits.
> 
>     For example, for this_cpu_and(pcp, zero), where 'pcp' is a u64 and
>     'zero' is a u32:
> 
>     * 'zero'           ===> (u32) 0x00000000
>     * '~(zero)'        ===> (u32) 0xffffffff
>     * '(u64)~(zero)'   ===> (u64) 0x00000000ffffffff
>     * '~((u64)(zero))' ===> (u64) 0xffffffffffffffff
> 
>     ... and thus bits[63:32] of 'pcp' would be preserved unexpectedly by
>     the ANDNOT operation.
> 
> Fix these issues by adding brackets around 'val', and by casting 'val'
> to an appropriately-sized type before bitwise negation.
> 
> The bugs described above can be seen from the disassembly of the
> following test code:
> 
> | void this_cpu_and_u64_zero(u64 __percpu *pcp)
> | {
> |         u64 zero = 0;
> |         this_cpu_and(*pcp, zero);
> | }
> |
> | void this_cpu_and_u32_zero(u64 __percpu *pcp)
> | {
> |         u32 zero = 0;
> |         this_cpu_and(*pcp, zero);
> | }
> |
> | void this_cpu_and_expr_zero(u64 __percpu *pcp)
> | {
> |         this_cpu_and(*pcp, 1 - 1);
> | }
> |
> | void this_cpu_and_expr_zero_brackets(u64 __percpu *pcp)
> | {
> |         this_cpu_and(*pcp, (1 - 1));
> | }
> 
> Before this patch:
> 
> | <this_cpu_and_u64_zero>:
> |        paciasp
> |        stp     x29, x30, [sp, #-16]!
> |        mrs     x1, sp_el0
> |        mov     x29, sp
> |        ldr     w2, [x1, #8]
> |        add     w2, w2, #0x1
> |        str     w2, [x1, #8]
> |        mov     x3, #0xffffffffffffffff         // #-1
> |        mrs     x2, tpidr_el1
> |        add     x0, x0, x2
> | 1:     ldxr    x5, [x0]
> |        bic     x5, x5, x3
> |        stxr    w4, x5, [x0]
> |        cbnz    w4, 1b
> |        ldr     x0, [x1, #8]
> |        add     x0, x0, x3
> |        str     w0, [x1, #8]
> |        cbz     x0, 2f
> |        ldr     x0, [x1, #8]
> |        cbnz    x0, 3f
> | 2:     bl      preempt_schedule_notrace
> | 3:     ldp     x29, x30, [sp], #16
> |        autiasp
> |        ret
> |
> | <this_cpu_and_u32_zero>:
> |        paciasp
> |        stp     x29, x30, [sp, #-16]!
> |        mrs     x1, sp_el0
> |        mov     x29, sp
> |        ldr     w2, [x1, #8]
> |        add     w2, w2, #0x1
> |        str     w2, [x1, #8]
> |        mov     x3, #0xffffffff                 // #4294967295
> |        mrs     x2, tpidr_el1
> |        add     x0, x0, x2
> | 1:     ldxr    x5, [x0]
> |        bic     x5, x5, x3
> |        stxr    w4, x5, [x0]
> |        cbnz    w4, 1b
> |        ldr     x0, [x1, #8]
> |        sub     x0, x0, #0x1
> |        str     w0, [x1, #8]
> |        cbz     x0, 2f
> |        ldr     x0, [x1, #8]
> |        cbnz    x0, 3f
> | 2:     bl      preempt_schedule_notrace
> | 3:     ldp     x29, x30, [sp], #16
> |        autiasp
> |        ret
> |
> | <this_cpu_and_expr_zero>:
> |        paciasp
> |        stp     x29, x30, [sp, #-16]!
> |        mrs     x1, sp_el0
> |        mov     x29, sp
> |        ldr     w2, [x1, #8]
> |        add     w2, w2, #0x1
> |        str     w2, [x1, #8]
> |        mov     x3, #0xfffffffffffffffd         // #-3
> |        mrs     x2, tpidr_el1
> |        add     x0, x0, x2
> | 1:     ldxr    x5, [x0]
> |        bic     x5, x5, x3
> |        stxr    w4, x5, [x0]
> |        cbnz    w4, 1b
> |        ldr     x0, [x1, #8]
> |        sub     x0, x0, #0x1
> |        str     w0, [x1, #8]
> |        cbz     x0, 2f
> |        ldr     x0, [x1, #8]
> |        cbnz    x0, 3f
> | 2:     bl      preempt_schedule_notrace
> | 3:     ldp     x29, x30, [sp], #16
> |        autiasp
> |        ret
> 
> After this patch:
> 
> | <this_cpu_and_u64_zero>:
> |        paciasp
> |        stp     x29, x30, [sp, #-16]!
> |        mrs     x1, sp_el0
> |        mov     x29, sp
> |        ldr     w2, [x1, #8]
> |        add     w2, w2, #0x1
> |        str     w2, [x1, #8]
> |        mov     x3, #0xffffffffffffffff         // #-1
> |        mrs     x2, tpidr_el1
> |        add     x0, x0, x2
> | 1:     ldxr    x5, [x0]
> |        bic     x5, x5, x3
> |        stxr    w4, x5, [x0]
> |        cbnz    w4, 1b
> |        ldr     x0, [x1, #8]
> |        add     x0, x0, x3
> |        str     w0, [x1, #8]
> |        cbz     x0, 2f
> |        ldr     x0, [x1, #8]
> |        cbnz    x0, 3f
> | 2:     bl      0 <preempt_schedule_notrace>
> | 3:     ldp     x29, x30, [sp], #16
> |        autiasp
> |        ret
> |
> | <this_cpu_and_u32_zero>:
> |        b       this_cpu_and_u64_zero
> |
> | <this_cpu_and_expr_zero>:
> |        b       this_cpu_and_u64_zero
> |
> | <this_cpu_and_expr_zero_brackets>:
> |        b       this_cpu_and_u64_zero
> 
> Fixes: 959bf2fd03b5 ("arm64: percpu: Rewrite per-cpu ops to allow use of LSE atomics")
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
> Cc: stable@vger.kernel.org
> ---
>  arch/arm64/include/asm/percpu.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
> index 63bbfd4944a37..31193bcf89a2b 100644
> --- a/arch/arm64/include/asm/percpu.h
> +++ b/arch/arm64/include/asm/percpu.h
> @@ -206,13 +206,13 @@ PERCPU_RET_OP(add, add, ldadd)
>  	_pcp_protect_return(__percpu_add_return_case_64, pcp, val)
>  
>  #define this_cpu_and_1(pcp, val)	\
> -	_pcp_protect(__percpu_andnot_case_8, pcp, ~val)
> +	_pcp_protect(__percpu_andnot_case_8, pcp, ~(u8)(val))
>  #define this_cpu_and_2(pcp, val)	\
> -	_pcp_protect(__percpu_andnot_case_16, pcp, ~val)
> +	_pcp_protect(__percpu_andnot_case_16, pcp, ~(u16)(val))
>  #define this_cpu_and_4(pcp, val)	\
> -	_pcp_protect(__percpu_andnot_case_32, pcp, ~val)
> +	_pcp_protect(__percpu_andnot_case_32, pcp, ~(u32)(val))
>  #define this_cpu_and_8(pcp, val)	\
> -	_pcp_protect(__percpu_andnot_case_64, pcp, ~val)
> +	_pcp_protect(__percpu_andnot_case_64, pcp, ~(u64)(val))

Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>

>  
>  #define this_cpu_or_1(pcp, val)		\
>  	_pcp_protect(__percpu_or_case_8, pcp, val)

