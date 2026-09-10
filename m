Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F146489FC4
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 13:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789045593; cv=none; b=P7mKBgY5yODgk6yx0kGxHIlS6EkbSdiQrwL9O0NGa1NLJG0Iqp0cHKQjhQnHFMtcCxFkPclo9u1rRHI108umUpMOlS/wQibCwWt2bJXNquzz2fbma2/JkgUmGRZJWONnu3BRn5z+Oh0eYca1obLYQ8tW5stzKXF3ADyiZyxr8vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789045593; c=relaxed/simple;
	bh=9oh0tRsiE7/HLFt8r6X8tMaYM8mBg3BROU8swZkRWsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nt5+5bFKrfekktNFW+QodkYWVqo/eE1kMd/P5KbbpfE4nAH+PJqYfb3zXvoiCna7e7MxPF0RXXz1c8oNTawjADUTh8v0ydnWvCHVCWajcVT7PSJfsXidYkssUduPW3SFaX2jeDZMC2cAGB+LqAWvh1N0OKRbqnyLx65bN092SxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lAfSamYl; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lAfSamYl"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0669153B;
	Thu, 10 Sep 2026 06:06:20 -0700 (PDT)
Received: from [10.0.152.207] (unknown [10.0.152.207])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FFDF3F528;
	Thu, 10 Sep 2026 06:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789045584; bh=9oh0tRsiE7/HLFt8r6X8tMaYM8mBg3BROU8swZkRWsQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lAfSamYliz+Q0kxriRDfahYx7Nc3nPsVXdPfieSxUc7MIr99c9ZYLex0O8CgNlSDx
	 Ccrn2p8xcHVCMkP3Ji5+sRlrLrxHgsszXQ15gbR6O13D0Qva206Z5Xr/PNIabxLTMJ
	 i2vMs5qsX6L7KRxrHyj0DP2jpyzZLwgHsBCg7U+M=
Message-ID: <fd611971-17dd-44a6-acf0-f498f58bb1c0@arm.com>
Date: Thu, 10 Sep 2026 14:06:14 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/21] arm64: entry: sdei: Make 'tsk' available
To: Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: ada.coupriediaz@arm.com, ardb@kernel.org, catalin.marinas@arm.com,
 cl@gentwo.org, david@kernel.org, david.laight.linux@gmail.com,
 james.morse@arm.com, ljs@kernel.org, maz@kernel.org, peterz@infradead.org,
 ruanjinjie@huawei.com, ryan.roberts@arm.com, stable@vger.kernel.org,
 usama.anjum@arm.com, will@kernel.org, yang@os.amperecomputing.com
References: <20260908151741.394589-1-mark.rutland@arm.com>
 <20260908151741.394589-14-mark.rutland@arm.com>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <20260908151741.394589-14-mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/26 16:17, Mark Rutland wrote:
> For regular entry/exit sequences, we use 'tsk' (x28) to hold the current
> task pointer, allowing this to be used by various assembly macros. The
> SDEI entry/exit sequence uses x28 to hold the value of the interrupted
> sp_el0, and doesn't retain the current task pointer in a register.
> 
> These differences makes it awkward to share assembly macros across
> regular entry/exit and SDEI entry/exit, and risk surprises.
> 
> Align the SDEI entry/exit sequence with regular entry/exit, keeping the
> current task pointer in 'tsk', and preserving the interrupted sp_el0 in
> another (callee-saved) register. I've used x20 as x19 was already in
> used for the relevant sdei_registered_event, and these are the
> lowest-numbered registers above x18 (which we must preserve for shadow
> call stack).
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
>  arch/arm64/kernel/entry.S | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index a6ec5c5a2d29c..0902c1bd9dd3d 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -1023,11 +1023,12 @@ SYM_CODE_START(__sdei_asm_handler)
>  
>  	/*
>  	 * We may have interrupted userspace, or a guest, or exit-from or
> -	 * return-to either of these. We can't trust sp_el0, restore it.
> +	 * return-to either of these. Preserve the interrupted sp_el0, and
> +	 * initialize sp_el0 to the current task.
>  	 */
> -	mrs	x28, sp_el0
> -	ldr_this_cpu	dst=x0, sym=__entry_task, tmp=x1
> -	msr	sp_el0, x0
> +	mrs	x20, sp_el0
> +	ldr_this_cpu    dst=tsk, sym=__entry_task, tmp=x1
> +	msr	sp_el0, tsk
>  
>  	/* If we interrupted the kernel point to the previous stack/frame. */
>  	and     x0, x3, #0xc
> @@ -1043,7 +1044,7 @@ SYM_CODE_START(__sdei_asm_handler)
>  	mov	x1, x19
>  	bl	__sdei_handler
>  
> -	msr	sp_el0, x28
> +	msr	sp_el0, x20
>  	/* restore regs >x17 that firmware won't restore */
>  	mov	x4, x19         // keep x4 for __sdei_asm_exit_trampoline
>  	ldp	x18, x19, [x4, #SDEI_EVENT_INTREGS + 16 * 9]
> -- 2.30.2
> 

I'm sure you are already pretty much aware that Will's series touches
this code as well... :)  

FWIW,

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
