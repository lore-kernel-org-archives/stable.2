Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F9A47728D
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 12:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789130594; cv=none; b=r91G3cO3MpO3Ha8Ln/J8UtXkkE/BhxJKH4Y23oyQ9wz5jd8K7lVoFIl3gHBZ5Wcg28ZYty5ehzU8QVeV3Qzw7dAX5zXE0Uml8KUNQF8aIYDdM/ugeNuZeJoWmxsV6t6vQec5mQgN+beFPaerrXNMnTdlgMIw09nmGJilm1zUW3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789130594; c=relaxed/simple;
	bh=8fDkzR3xz7bUOtv2VBFNlhKTI6GaTQbh45cNz7auKIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FhOzMMGTxtwNZKkDNVmGd5Ej+kByuA3xSJrOZEHazMO/OucKZ9BtavdNn1QcxiLvDFX0L5Q930K+Dqp/pie7NbAWCmSLJwi0aP/2UmTJrnJMjx6GhD7+S5xdpjrBXk71dWZNTHs/btLnlsX6XterG0kSa35evlIiIFwo2/GF410=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jdmjoc5Y; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jdmjoc5Y"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07CA716A3;
	Fri, 11 Sep 2026 05:43:08 -0700 (PDT)
Received: from [10.0.152.207] (unknown [10.0.152.207])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E4A13F86C;
	Fri, 11 Sep 2026 05:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789130591; bh=8fDkzR3xz7bUOtv2VBFNlhKTI6GaTQbh45cNz7auKIE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jdmjoc5YXFimKoPrWtsGzDiGgZpv8L6ol0veAddLpi+DieVRLlBFhpQBd0mkoA76D
	 OOlnQrdfnw4UKHK+7cK+fo2vr5+ik6SxvUJVyTIlViR8/usYl5Ck27rAZQg6TijAje
	 mas5G9cZFd7DT/ro51xOYv4lY+2i/wYZqT81irwY=
Message-ID: <e99bf73a-d46b-42ac-9608-32c3b1b6f083@arm.com>
Date: Fri, 11 Sep 2026 13:43:06 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/21] arm64: gpr-num: Add wxN aliases for wN registers
To: Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: ada.coupriediaz@arm.com, ardb@kernel.org, catalin.marinas@arm.com,
 cl@gentwo.org, david@kernel.org, david.laight.linux@gmail.com,
 james.morse@arm.com, ljs@kernel.org, maz@kernel.org, peterz@infradead.org,
 ruanjinjie@huawei.com, ryan.roberts@arm.com, stable@vger.kernel.org,
 usama.anjum@arm.com, will@kernel.org, yang@os.amperecomputing.com
References: <20260908151741.394589-1-mark.rutland@arm.com>
 <20260908151741.394589-11-mark.rutland@arm.com>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <20260908151741.394589-11-mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/26 16:17, Mark Rutland wrote:
> Some A64 instructions require a W register name for specific register
> arguments, and will not accept an X register name. For example:
> 
> 	STRH <Wt>, [<Xn|SP>, (<Wm>|<Xm>){, <extend> {<amount>}}]
> 
> This is painful when writing macros for inline assembly, especially
> where a single register is used as both an X register and a W register.
> 
> We solved this for plain assembly by adding a wxN alias for each xN
> register in commit:
> 
>   4c4dcd3541f83d21 ("arm64: assembler: introduce wxN aliases for wN registers")
> 
> Add the same facility for inline assembly, with a new
> __DEFINE_ASM_GPR_ALIASES macro.
> 
> As with the other macros in gpr-num.h, different escaping is necessary
> for inline vs non-inline assembly, so we can't share a single definition
> that we stringify().
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
>  arch/arm64/include/asm/gpr-num.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/gpr-num.h b/arch/arm64/include/asm/gpr-num.h
> index a114e4f8209b0..240cd25d55c5a 100644
> --- a/arch/arm64/include/asm/gpr-num.h
> +++ b/arch/arm64/include/asm/gpr-num.h
> @@ -21,6 +21,11 @@
>  "	.equ	.L__gpr_num_xzr, 31\n"				\
>  "	.equ	.L__gpr_num_wzr, 31\n"
>  
> +#define __DEFINE_ASM_GPR_ALIASES									\
> +"	.irp	n,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30\n"	\
> +"	wx\\n	.req	w\\n\n"										\
> +"	.endr\n"
> +
>  #endif /* __ASSEMBLER__ */
>  
>  #endif /* __ASM_GPR_NUM_H */
> -- 2.30.2
> 

FWIW,

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>

