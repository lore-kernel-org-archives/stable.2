Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FE64AA3E4
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 15:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789053542; cv=none; b=bcqrgNT1/jEXDUQ3Fs37qaOMdbpY3M3Tu+AGmNvN4lfWLGdVbsPNny4yeZAe9RJeVjckKOcIEmpcBt6pXhDn7kyxp0JYVZkYBSyTeaX1Wym+H+H2WOSAqeQkGJ0e1ojcfZYZvjbqFg17vXW3uQ/3ZgMzuKqb1OKSi0vy7m4PzRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789053542; c=relaxed/simple;
	bh=L24XCAY42o+vXWCHtSAqHdGIfTKiNnN51PX4L4Lt9HM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Va1bS7ffBGQw7vEBETunbFsTcBoaxhn6sgPGwVdTZuKpFf3Tw5RccWou6TA2hu4Cm9k0K46pUogqZl6mQAt8ftVnGjQjQSBm3LyntYYYdCNn62PZ6ClOdD0Ttl0uO6QpygnwYnpGJwuUaAZDWiOa3fN+0hNW3dMTP+FcwwOFkv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=G0Y0pKB4; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="G0Y0pKB4"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9FFA22C8;
	Thu, 10 Sep 2026 08:18:48 -0700 (PDT)
Received: from [10.0.152.207] (unknown [10.0.152.207])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1CD33F59E;
	Thu, 10 Sep 2026 08:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789053532; bh=L24XCAY42o+vXWCHtSAqHdGIfTKiNnN51PX4L4Lt9HM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=G0Y0pKB4kZOkk0qnITI6T8sUKH3z1GLATPlQAlIv3gEciFafKv4FG6L2tUTLbbvVN
	 dN7wYsYHdBINYYzzzqd9QkcddymiO7+Oixfny+E/gRiRS2nSQVAd2Mx0XUuNENDte7
	 w07epDGtDLgyjY8fZBoFwacqccCv1XJHDDeJb8yE=
Message-ID: <3f2fe813-b6ae-461c-9a95-5cf62c087cc6@arm.com>
Date: Thu, 10 Sep 2026 16:18:46 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/21] arm64: percpu: Fix LSE operations on {8,16}-bit
 types
To: Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: ada.coupriediaz@arm.com, ardb@kernel.org, catalin.marinas@arm.com,
 cl@gentwo.org, david@kernel.org, david.laight.linux@gmail.com,
 james.morse@arm.com, ljs@kernel.org, maz@kernel.org, peterz@infradead.org,
 ruanjinjie@huawei.com, ryan.roberts@arm.com, stable@vger.kernel.org,
 usama.anjum@arm.com, will@kernel.org, yang@os.amperecomputing.com
References: <20260908151741.394589-1-mark.rutland@arm.com>
 <20260908151741.394589-4-mark.rutland@arm.com>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <20260908151741.394589-4-mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/26 16:17, Mark Rutland wrote:
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
> Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: James Morse <james.morse@arm.com>
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
>  		__nops(2))						\
>  	: [loop] "=&r" (loop), [ret] "=&r" (ret),			\
> -- 2.30.2
> 

FWIW,

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>

