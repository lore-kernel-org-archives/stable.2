Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A77645DF6C
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 10:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789037820; cv=none; b=WN8ZJ57mF4fr8r7gWTCm3KvvOmETsCkzSWnH4/dLyNFfBls3uUFUn6vdpKiCYNnvmh3fBejQrhcZioLJ96KLfQbEnVil695tZPrxMX5QpOrvAmwl7eEeHPCRJCpOuLZgcRu4uXtBSRUyET/eZqfU6Y9hG5mZz8wbfXdW23HGRMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789037820; c=relaxed/simple;
	bh=0XVud+aFs7SjXyrBbSbz9+RlhMfbfwciyLfpZ2J7E6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNHma+Hibyf/siRsxWIgQjsVqm4mjTnlSSyRVXbv/a2Hi8JrsVkYEKYUAhZcrkSGaw0UgZwx9FIpj6xoQ6FAXoekrj7X/4wqrqBogRNJytGXnALa+ivNoUNaZDuofIwg8OkcLmUD0JApYJ9oGMnQtCMPI7u9qaRFEuiEp3pN2Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QugRe20W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QugRe20W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB9B1F000FF;
	Thu, 10 Sep 2026 10:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789037810;
	bh=vy0obgvg0nf8qGQKnYvGOGI82XsQ6j8jix882VNn/Nc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QugRe20W6g3MjyJ+mgnoAlyfxdfcW8qlXrm53ytBcd1jTs5KN6YljfasGpJHQ0FQC
	 lJJ8Iz4hQN99WZlHJTKqfF/kSqZzxDE8ON4Tn0fE32XSyUBMPn1rR8LgiuOW2M878K
	 IUqWJIUeZGXkk0wxvGn871PZGtXDYfzvQIs+jTnvvUk30CtHJy9Md9Lwyocou+5qj7
	 7Ztlfmjx6Ut7DVwCSWsi6zclwPdLt9a7YrjX+Ng831FVWh59qswdmYF6ayEBsnwjQ8
	 wA7QPytJP5GbfpiXZ+cnkByeHec4QR/zQYz07ap+c3GctQRu/thP7omkDpUpFa4OUL
	 bvSon05EQ/nWw==
Date: Thu, 10 Sep 2026 11:56:43 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, ada.coupriediaz@arm.com, 
	ardb@kernel.org, catalin.marinas@arm.com, cl@gentwo.org, david@kernel.org, 
	david.laight.linux@gmail.com, james.morse@arm.com, maz@kernel.org, peterz@infradead.org, 
	ruanjinjie@huawei.com, ryan.roberts@arm.com, stable@vger.kernel.org, 
	usama.anjum@arm.com, vladimir.murzin@arm.com, will@kernel.org, 
	yang@os.amperecomputing.com
Subject: Re: [PATCH v4 01/21] arm64: percpu: Fix this_cpu_write() casting
Message-ID: <aqKMAXthAIfa409I@gremlin>
References: <20260908151741.394589-1-mark.rutland@arm.com>
 <20260908151741.394589-2-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908151741.394589-2-mark.rutland@arm.com>

On Tue, Sep 08, 2026 at 04:17:21PM +0100, Mark Rutland wrote:
> The arm64 implementation of this_cpu_write() casts 'val' to unsigned
> long. This is necessary to handle cases where 'val' is a pointer type,
> and to avoid spurious compiler warnings for the (unreachable!) cases
> where the pointer type would be cast to a smaller integer type.
>
> Unfortunately, the cast is applied to 'val' rather than '(val)', which
> won't always generate the expected value when 'val' is an expression.
>
> For example, for this_cpu_write(pcp, zero - 1), where 'pcp' is a u64 and
> 'zero' is a u32:
>
> * 'zero'                      ===> (u32) 0x00000000
> * 'zero - 1'                  ===> (u32) 0xffffffff
> * '(unsigned long)zero - 1'   ===> (u64) 0xffffffffffffffff
> * '(unsigned long)(zero - 1)' ===> (u64) 0x00000000ffffffff
>
> Fix this by adding brackets around 'val'
>
> The bug described above can be seen from the disassembly of the
> following test code:
>
> | void this_cpu_write_zero_minus_1(u64 __percpu *pcp)
> | {
> | 	u32 zero = 0;
> | 	this_cpu_write(*pcp, zero - 1);
> | }
> |
> | void this_cpu_write_zero_minus_1_brackets(u64 __percpu *pcp)
> | {
> | 	u32 zero = 0;
> | 	this_cpu_write(*pcp, (zero - 1));
> | }
>
> Generated code before this patch:
>
> | <this_cpu_write_zero_minus_1>:
> |        paciasp
> |        stp     x29, x30, [sp, #-16]!
> |        mrs     x1, sp_el0
> |        mov     x29, sp
> |        ldr     w2, [x1, #8]
> |        add     w2, w2, #0x1
> |        str     w2, [x1, #8]
> |        mov     x3, #0xffffffffffffffff
> |        mrs     x2, tpidr_el1
> |        str     x3, [x0, x2]
> |        ldr     x0, [x1, #8]
> |        add     x0, x0, x3
> |        str     w0, [x1, #8]
> |        cbz     x0, 1f
> |        ldr     x0, [x1, #8]
> |        cbnz    x0, 2f
> | 1:     bl      preempt_schedule_notrace
> | 2:     ldp     x29, x30, [sp], #16
> |        autiasp
> |        ret
> |
> | <this_cpu_write_zero_minus_1_brackets>:
> |        paciasp
> |        stp     x29, x30, [sp, #-16]!
> |        mrs     x1, sp_el0
> |        mov     x29, sp
> |        ldr     w2, [x1, #8]
> |        add     w2, w2, #0x1
> |        str     w2, [x1, #8]
> |        mov     x3, #0xffffffff
> |        mrs     x2, tpidr_el1
> |        str     x3, [x0, x2]
> |        ldr     x0, [x1, #8]
> |        sub     x0, x0, #0x1
> |        str     w0, [x1, #8]
> |        cbz     x0, 1f
> |        ldr     x0, [x1, #8]
> |        cbnz    x0, 2f
> | 1:     bl      preempt_schedule_notrace
> | 2:     ldp     x29, x30, [sp], #16
> |        autiasp
> |        ret
>
> Generated code after this patch:
>
> | <this_cpu_write_zero_minus_1>:
> |        paciasp
> |        stp     x29, x30, [sp, #-16]!
> |        mrs     x1, sp_el0
> |        mov     x29, sp
> |        ldr     w2, [x1, #8]
> |        add     w2, w2, #0x1
> |        str     w2, [x1, #8]
> |        mov     x3, #0xffffffff
> |        mrs     x2, tpidr_el1
> |        str     x3, [x0, x2]
> |        ldr     x0, [x1, #8]
> |        sub     x0, x0, #0x1
> |        str     w0, [x1, #8]
> |        cbz     x0, 1f
> |        ldr     x0, [x1, #8]
> |        cbnz    x0, 2f
> | 1:     bl      preempt_schedule_notrace
> | 2:     ldp     x29, x30, [sp], #16
> |        autiasp
> |        ret
> |
> | <this_cpu_write_zero_minus_1_brackets>:
> |        b       this_cpu_write_zero_minus_1
>
> Fixes: 959bf2fd03b5 ("arm64: percpu: Rewrite per-cpu ops to allow use of LSE atomics")
> Reported-by: David Laight <david.laight.linux@gmail.com>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>

Ah the fun of arithmetic conversions in C :)

LGTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> Reviewed-by: David Laight <david.laight.linux@gmail.com>
> Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
> Acked-by: Christopher Lameter (Ampere) <cl@gentwo.org>
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
>  arch/arm64/include/asm/percpu.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
> index b57b2bb009677..63bbfd4944a37 100644
> --- a/arch/arm64/include/asm/percpu.h
> +++ b/arch/arm64/include/asm/percpu.h
> @@ -179,13 +179,13 @@ PERCPU_RET_OP(add, add, ldadd)
>  	_pcp_protect_return(__percpu_read_64, pcp)
>
>  #define this_cpu_write_1(pcp, val)	\
> -	_pcp_protect(__percpu_write_8, pcp, (unsigned long)val)
> +	_pcp_protect(__percpu_write_8, pcp, (unsigned long)(val))
>  #define this_cpu_write_2(pcp, val)	\
> -	_pcp_protect(__percpu_write_16, pcp, (unsigned long)val)
> +	_pcp_protect(__percpu_write_16, pcp, (unsigned long)(val))
>  #define this_cpu_write_4(pcp, val)	\
> -	_pcp_protect(__percpu_write_32, pcp, (unsigned long)val)
> +	_pcp_protect(__percpu_write_32, pcp, (unsigned long)(val))
>  #define this_cpu_write_8(pcp, val)	\
> -	_pcp_protect(__percpu_write_64, pcp, (unsigned long)val)
> +	_pcp_protect(__percpu_write_64, pcp, (unsigned long)(val))
>
>  #define this_cpu_add_1(pcp, val)	\
>  	_pcp_protect(__percpu_add_case_8, pcp, val)
> --
> 2.30.2
>

--
Cheers, Lorenzo
