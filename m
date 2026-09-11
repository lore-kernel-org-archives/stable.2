Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0645F4766B4
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 12:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789130405; cv=none; b=eh3GTlA3X6pVjVLqdprW0WyHdyvLLD1CTsHxLkCPOZpcTr6dHJJKprQfTvigrW54dtTDH+5RP4gf88wRFDqx2eu8QvTOlAb4NzNGHu7RqRT97x616gSNTDCjos4wjOENlW7euEY1+5jSTt53SZe2oKxsR7nwbmEZBb2yVqGayNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789130405; c=relaxed/simple;
	bh=XWfFiVJQd8zBFFXzrkVrZmYAIrf55jggjdeH4rEAhZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ev2QTHTq2XBMdPfDAOmn7N1mG/rEv7BXelmdA99qoiBteTuZZFoPsoI6HjhaYEWtse/01FOwJnCumVOv7kP9i9UrUN0NjitIsnsV0W075zOKPxlVbmLmbvifbablpx60i8udDChSafBZjQOJ/ImfGHCcCv7e8jDNiZcKkkhtti8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KN4FsSrf; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KN4FsSrf"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E5811655;
	Fri, 11 Sep 2026 05:39:58 -0700 (PDT)
Received: from [10.0.152.207] (unknown [10.0.152.207])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AD2E3F7B4;
	Fri, 11 Sep 2026 05:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789130402; bh=XWfFiVJQd8zBFFXzrkVrZmYAIrf55jggjdeH4rEAhZY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KN4FsSrfRC9lwmJZtigkSjR7gNXqFF7FANz0TzckKmWInMpvcvMo+pB8+yKgjAOqE
	 9jcCsLZvHxady43T6hGmNthEKXvu68EFA4buVRZTjGM4h/huoQiyLSsufd1/HBWBv+
	 5D8iTAJMOvJMNziV41314S8ON3oZP1/NHBc+F6uI=
Message-ID: <98386fb5-9545-446c-9681-746b9f7b8b49@arm.com>
Date: Fri, 11 Sep 2026 13:39:57 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/21] arm64: percpu: Factor out percpu offset asm
To: Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: ada.coupriediaz@arm.com, ardb@kernel.org, catalin.marinas@arm.com,
 cl@gentwo.org, david@kernel.org, david.laight.linux@gmail.com,
 james.morse@arm.com, ljs@kernel.org, maz@kernel.org, peterz@infradead.org,
 ruanjinjie@huawei.com, ryan.roberts@arm.com, stable@vger.kernel.org,
 usama.anjum@arm.com, will@kernel.org, yang@os.amperecomputing.com
References: <20260908151741.394589-1-mark.rutland@arm.com>
 <20260908151741.394589-10-mark.rutland@arm.com>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <20260908151741.394589-10-mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/26 16:17, Mark Rutland wrote:
> Depending on whether the kernel runs at EL1 or EL2, the percpu offset is
> stored in either TPIDR_EL1 or TPIDR_EL2, and __kern_my_cpu_offset() uses
> an ALTERNATIVE() sequence to read the relevant TPIDR_ELx.
> 
> In subsequent patches we'll need to read the percpu offset in other
> assembly sequences. Factor the ALTERNATIVE sequence out of
> __kern_my_cpu_offset() into a new __KERN_ASM_CPU_OFFSET() macro so that
> we can share the code sequence.
> 
> There should be no functional change as a result of this patch.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
> Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Vladimir Murzin <vladimir.murzin@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Yang Shi <yang@os.amperecomputing.com>
> ---
>  arch/arm64/include/asm/percpu.h | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
> index 8cf4068ce1b56..746d2a56f48bb 100644
> --- a/arch/arm64/include/asm/percpu.h
> +++ b/arch/arm64/include/asm/percpu.h
> @@ -29,6 +29,11 @@ static inline unsigned long __hyp_my_cpu_offset(void)
>  	return read_sysreg(tpidr_el2);
>  }
>  
> +#define __KERN_ASM_CPU_OFFSET(dst)					\
> +	ALTERNATIVE("mrs " dst ", tpidr_el1",				\
> +		    "mrs " dst ", tpidr_el2",				\
> +		       ARM64_HAS_VIRT_HOST_EXTN)
> +
>  static inline unsigned long __kern_my_cpu_offset(void)
>  {
>  	unsigned long off;
> @@ -37,11 +42,11 @@ static inline unsigned long __kern_my_cpu_offset(void)
>  	 * We want to allow caching the value, so avoid using volatile and
>  	 * instead use a fake stack read to hazard against barrier().
>  	 */
> -	asm(ALTERNATIVE("mrs %0, tpidr_el1",
> -			"mrs %0, tpidr_el2",
> -			ARM64_HAS_VIRT_HOST_EXTN)
> -		: "=r" (off) :
> -		"Q" (*(const unsigned long *)current_stack_pointer));
> +	asm(
> +	__KERN_ASM_CPU_OFFSET("%0")
> +	: "=r" (off)
> +	: "Q" (*(const unsigned long *)current_stack_pointer)
> +	);

Tiny tiny nitpick: named operand, say, [dst] would read nicer :) 
No need to resin just for that. FWIW,

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>


>  
>  	return off;
>  }
> -- 2.30.2
> 

