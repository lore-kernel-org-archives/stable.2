Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA25477E20
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 12:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789130835; cv=none; b=b15Alp55UXeNXE9HYnvWR2ewMZSLEyfXjU2lFcml1kfyAm7epfKmK26QdInrG7l1YQM2x1Tcdwh/9Ei3aQsz9tnkX5W8DTmWwNgQdS0nV1qiopU9Ll1BdWUbAbHTmGpmTaBboZSwtJI4PHrajDfIr6RCTkBykKttPmBDOk1pYAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789130835; c=relaxed/simple;
	bh=id96Lk+HpLVgNjIVup4+7EebLweifTMRP/9y9m7oEJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uLCmJACb4MbaBsHpb8WFWohgHn1aPRnZ69psuhDi3feN2D15GyCo4zhxQyAhtpj+QDwb0CL648Ta0GIsGUYSNT2z+ELgJfvcrF7aBx7luVI/5UUZQMH87Kc12E0/YU+hQQNfWGU2MHXyhJL2kZm4oKfzHFka98AbzhweroaJ8tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ias0IPMU; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ias0IPMU"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D15F216A3;
	Fri, 11 Sep 2026 05:47:06 -0700 (PDT)
Received: from [10.0.152.207] (unknown [10.0.152.207])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBD8B3F7B4;
	Fri, 11 Sep 2026 05:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789130830; bh=id96Lk+HpLVgNjIVup4+7EebLweifTMRP/9y9m7oEJE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ias0IPMUgeA6nzUHI6Z5ZM7GoPxgPuUUUDADBiMCIR7EKtcam6ybraYlVw1V+Rql7
	 PrDiQI2k/4+OxCpOArrbzlnZOHhlFLx+Wm1Pmbs4fnuux4TVU8qyJ8lbbj0WzTsmuS
	 tmQKpXbkF7fs/1Kt2R8IsuaM5Nw09VVZxF0jywpQ=
Message-ID: <5760123e-6e18-4f7a-beb4-8179c0795c6d@arm.com>
Date: Fri, 11 Sep 2026 13:47:06 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/21] arm64: entry: sdei: Restore all clobberable GPRs
To: Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: ada.coupriediaz@arm.com, ardb@kernel.org, catalin.marinas@arm.com,
 cl@gentwo.org, david@kernel.org, david.laight.linux@gmail.com,
 james.morse@arm.com, ljs@kernel.org, maz@kernel.org, peterz@infradead.org,
 ruanjinjie@huawei.com, ryan.roberts@arm.com, stable@vger.kernel.org,
 usama.anjum@arm.com, will@kernel.org, yang@os.amperecomputing.com
References: <20260908151741.394589-1-mark.rutland@arm.com>
 <20260908151741.394589-13-mark.rutland@arm.com>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <20260908151741.394589-13-mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/26 16:17, Mark Rutland wrote:
> Currently __sdei_asm_handler() avoids restoring x20 to x27, as these are
> not be clobbered by existing code. This is correct today, but it makes
> it awkward to rework __sdei_asm_handler(). Given the rarity of SDEI
> events, restoring x20 to x27 should not have a measurable impact.
> 
> Restore x20 to x27 when returning from an SDEI event handler. This will
> free up those GPRs for usage in __sdei_asm_handler() prior to return.
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
>  arch/arm64/kernel/entry.S | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index f63049ac32dc6..a6ec5c5a2d29c 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -1044,10 +1044,14 @@ SYM_CODE_START(__sdei_asm_handler)
>  	bl	__sdei_handler
>  
>  	msr	sp_el0, x28
> -	/* restore regs >x17 that we clobbered */
> +	/* restore regs >x17 that firmware won't restore */
>  	mov	x4, x19         // keep x4 for __sdei_asm_exit_trampoline
> -	ldp	x28, x29, [x4, #SDEI_EVENT_INTREGS + 16 * 14]
>  	ldp	x18, x19, [x4, #SDEI_EVENT_INTREGS + 16 * 9]
> +	ldp	x20, x21, [x4, #SDEI_EVENT_INTREGS + 16 * 10]
> +	ldp	x22, x23, [x4, #SDEI_EVENT_INTREGS + 16 * 11]
> +	ldp	x24, x25, [x4, #SDEI_EVENT_INTREGS + 16 * 12]
> +	ldp	x26, x27, [x4, #SDEI_EVENT_INTREGS + 16 * 13]
> +	ldp	x28, x29, [x4, #SDEI_EVENT_INTREGS + 16 * 14]
>  	ldp	lr, x1, [x4, #SDEI_EVENT_INTREGS + S_LR]
>  	mov	sp, x1
>  
> -- 2.30.2
> 

FWIW,

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>

