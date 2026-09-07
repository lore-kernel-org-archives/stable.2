Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A7C364EB2
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 08:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788770949; cv=none; b=m3WPposmuenmk0hiCYmcgMFr8s37YhzqdSnI+jnmofuoDVIBZphKc3C4+NNh/tbkEiyTUOW8s8WuVWb/nuO24304wbmeUTIBI6jNiRiwfEbwNeS0OuWL/voiLSxQXpXQi0BbAaEBZvqhPyC/6uZg1LlI7q6PhCfDQv7XFcoSsok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788770949; c=relaxed/simple;
	bh=eqn0OOWrIRbfELyDLFRqsaHtVt1EJFfMxVspuXMRUT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=i47mdvKfPTYsJuMGUwaRyUoBegZR/Tp0KDbTZGeJnWoEaNnE6YBpLKbmOLw6RtrxykWZJ+fVx2+paMjp8N03csb8OusxWpU3CD+zgORVBvEwfTHXGvJwp+N+yDTZ72b6BhIryfpYRsInBSXzr3iksOYHU7J++OrQEoo0K/H3+nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Tmr3qKK2; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Tmr3qKK2"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=c4GIZGT4TyXoHHB1gMPoDnQG3lKJ5Fhq9LS0nG+kawY=;
	b=Tmr3qKK2UZTVAKGyV1HXzzOlhYSd+2g/gxsOMAmf1W7o+6V/djRr41cLbVpbg/cziClc4SjkX
	UFLphzUI0iCCGIX2Ns3ouTKOljyqNN94EVQSHXVwvsL+NzGHUTju+9lJIVsTVldBhzCWcGPkIer
	51myB+T37h202XyHNs8eUyA=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4hdgRq3dwyz1T4Mc;
	Mon,  7 Sep 2026 16:37:27 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 2235E40579;
	Mon,  7 Sep 2026 16:48:56 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemk200008.china.huawei.com (7.202.194.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 7 Sep 2026 16:48:55 +0800
Message-ID: <b5194b06-ec4b-42f7-b879-9d3082aa58d7@huawei.com>
Date: Mon, 7 Sep 2026 16:48:54 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/21] arm64: percpu: Fix LSE operations on {8,16}-bit
 types
To: Mark Rutland <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>
CC: <ada.coupriediaz@arm.com>, <ardb@kernel.org>, <catalin.marinas@arm.com>,
	<cl@gentwo.org>, <david.laight.linux@gmail.com>, <james.morse@arm.com>,
	<maz@kernel.org>, <peterz@infradead.org>, <stable@vger.kernel.org>,
	<usama.anjum@arm.com>, <vladimir.murzin@arm.com>, <will@kernel.org>,
	<yang@os.amperecomputing.com>
References: <20260904161758.376504-1-mark.rutland@arm.com>
 <20260904161758.376504-4-mark.rutland@arm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260904161758.376504-4-mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk200008.china.huawei.com (7.202.194.74)



在 2026/9/5 0:17, Mark Rutland 写道:
> The assembly for __percpu_##name##_case_##sz() and
> __percpu_##name##_return_case_##sz() doesn't use the 'sfx' macro
> argument to form the LSE instruction. Without 'sfx', a W register
> argument will imply a 32-bit memory location, and consequently
> {8,16}-bit ops will erroneously read and write 32 bits of memory when
> the LSE instruction is used.
> 
> Fix this by appending 'sfx' to 'op_lse' to LSE instruction. It is not
> necessary (and not valid) to append 'sfx' to 'op_llsc', as 'op_llsc' is
> a register-register operation which does not access memory (and does not
> take a size suffix).
> 
> Test case:
> 
> | void outline_this_cpu_add_u8(u8 __percpu *p, u8 v)
> | {
> | 	this_cpu_add(*p, v);
> | }
> 
> Generated inline code (same before and after this patch):
> 
> | <outline_this_cpu_add_u8>:
> |        paciasp
> |        stp     x29, x30, [sp, #-16]!
> |        mrs     x2, sp_el0
> |        mov     x29, sp
> |        ldr     w3, [x2, #8]
> |        add     w3, w3, #0x1
> |        str     w3, [x2, #8]
> |        mrs     x3, tpidr_el1
> |        add     x0, x0, x3
> | 1:     ldxrb   w5, [x0]        // <----------------
> |        add     w5, w5, w1      // LL/SC alternative
> |        stxrb   w4, w5, [x0]    // instructions here
> |        cbnz    w4, 1b          // <----------------
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
> Generated LSE alternative before this patch:
> 
> |        ldadd   w1, w5, [x0]    // 32-bit LDADD
> |        nop
> |        nop
> |        nop
> 
> Generated LSE alternative after this patch:
> 
> |        ldaddb  w1, w5, [x0]    // 8-bit LDADDB
> |        nop
> |        nop
> |        nop
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
>  arch/arm64/include/asm/percpu.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
> index 31193bcf89a2b..8cf4068ce1b56 100644
> --- a/arch/arm64/include/asm/percpu.h
> +++ b/arch/arm64/include/asm/percpu.h
> @@ -77,7 +77,7 @@ __percpu_##name##_case_##sz(void *ptr, unsigned long val)		\
>  	"	stxr" #sfx "\t%w[loop], %" #w "[tmp], %[ptr]\n"		\
>  	"	cbnz	%w[loop], 1b",					\
>  	/* LSE atomics */						\
> -		#op_lse "\t%" #w "[val], %" #w "[tmp], %[ptr]\n"	\
> +		#op_lse #sfx "\t%" #w "[val], %" #w "[tmp], %[ptr]\n"	\
>  		__nops(3))						\
>  	: [loop] "=&r" (loop), [tmp] "=&r" (tmp),			\
>  	  [ptr] "+Q"(*(u##sz *)ptr)					\
> @@ -98,7 +98,7 @@ __percpu_##name##_return_case_##sz(void *ptr, unsigned long val)	\
>  	"	stxr" #sfx "\t%w[loop], %" #w "[ret], %[ptr]\n"		\
>  	"	cbnz	%w[loop], 1b",					\
>  	/* LSE atomics */						\
> -		#op_lse "\t%" #w "[val], %" #w "[ret], %[ptr]\n"	\
> +		#op_lse #sfx "\t%" #w "[val], %" #w "[ret], %[ptr]\n"	\
>  		#op_llsc "\t%" #w "[ret], %" #w "[ret], %" #w "[val]\n"	\

Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>

>  		__nops(2))						\
>  	: [loop] "=&r" (loop), [ret] "=&r" (ret),			\

