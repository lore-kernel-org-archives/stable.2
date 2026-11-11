Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794404013;
	b=uENl6rVt8zGCjI9sEWk/gIOmdvWrWwV6W/Z0bsNYiG05m04y7sjbZo6yRWcJTMclF0qr
	 ALsCwhH9cXjLXrpPqNblK+Xrl9y0jNhuubDa6+5LKa4e07q9fyYXY8eoCT7e5188YZQ0Z
	 4vD2vvWy7gTAQZ8boEzNNFUgQhCS2yKijossW4tvROF3dsxgSthghfTIin0ec6EtHJSeh
	 9HJ+aKQaVFVKmmV+Z6zus7pFhb6Xl4Ugz6upUJK26NV7fF0gDCfFo9e6cITNWUwRIgL/m
	 d2h4t2JxC0V25x73Ulvl/LBJqDnDGlcRlpv/H1dmVrYnn7t1y9utclw+HLCBWxlng0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794404013;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=GQKJXNTQW9v+01dsyTFFERDStZLJXqLVmjUwVOCY3Dw=;
	b=Oa6Ke0LXvBqhtSmFlud19um1hcb8lwg4ZIqD++KnDP7Mp0bUByBZLYW9fcr6zoR8tq7L
	 ScbwP/zShOZg7Eiu05qWSuVDFL87p28u4tzqRA73M6TQk1yg+ZIsfsnKwqJbezcMq9922
	 NHJPfBqlxWVwOVKprbBt2d+mLyqtBtwqtiIJnyEcqEbaBhcBhATUZFfJj1TYmYp6Ml/HB
	 7l6vU1s0g2CGdrMc6aJx5gbbhu9TkCcs+j0cH6YdQe3Ytkj0p3t5fHlzlSYyPBtDudiw5
	 ZUjZabCrh6w2CpsSc0RO24rnJs+jJUDaK/pckSXySiXohk1Yi/kVQ2qpmBuInoPhEmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=YV0jBzAA;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EB4606A31C;
	Wed, 11 Nov 2026 13:33:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90EB4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=YV0jBzAA
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72D591576;
	Wed, 11 Nov 2026 05:33:28 -0800 (PST)
Received: from [10.0.154.42] (e121487-lin.cambridge.arm.com [10.0.154.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D2BA83F673;
	Wed, 11 Nov 2026 05:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794404011; bh=o3tyiYm4DJAr6V2NiisE1PtJ+Fj0j7GWcQIp093iIn0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YV0jBzAAJbiQ8M0NjHzMqF97YbOZ3nYwy8vmXccgy0CldPbNLNEaY73UEUCDryope
	 rPRlrP0y8fD6ryfLpFYfFnS9/OeVK2Ws8ikjIalXF75XRMgVfaJzeKdH6ZXPc2fxPw
	 R6gHqC2gvutG1voSrqleT0of6OOEw2YW2T41ardY=
Message-ID: <3479391a-ec0f-46a8-9384-ec084017d344@arm.com>
Date: Wed, 11 Nov 2026 13:33:27 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: suspend: Save POR_EL0 over suspend
To: Mark Brown <broonie@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Joey Gouly <joey.gouly@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261105-arm64-fix-sysreg-suspend-v1-0-f4d9a99fec46@kernel.org>
 <20261105-arm64-fix-sysreg-suspend-v1-1-f4d9a99fec46@kernel.org>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <20261105-arm64-fix-sysreg-suspend-v1-1-f4d9a99fec46@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/26 16:05, Mark Brown wrote:
> POR_EL0 is a live EL0 register on systems with S1POE but it is not saved
> and restored by cpu_do_suspend()/cpu_do_resume(). This means that the task
> that initiated suspend can return to userspace with an UNKNOWN value. Fix
> this by saving and restoring the value over suspend.
> 
> This increases the size of struct cpu_suspend_ctx.

This seems to be implied since we need storage to keep register value, no?

> 
> Fixes: bf83dae90fbc ("arm64: enable the Permission Overlay Extension for EL0")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>  arch/arm64/include/asm/suspend.h | 2 +-
>  arch/arm64/mm/proc.S             | 8 ++++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/suspend.h
> index a5abf0615594..eb9ce315f146 100644
> --- a/arch/arm64/include/asm/suspend.h
> +++ b/arch/arm64/include/asm/suspend.h
> @@ -2,7 +2,7 @@
>  #ifndef __ASM_SUSPEND_H
>  #define __ASM_SUSPEND_H
>  
> -#define NR_CTX_REGS 15
> +#define NR_CTX_REGS 16
>  #define NR_CALLEE_SAVED_REGS 12
>  
>  /*
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index b1516630904d..664ea9e3b9ad 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -117,6 +117,10 @@ alternative_else_nop_endif
>  alternative_if ARM64_SME
>  	mrs_s	x2, SYS_TPIDR2_EL0
>  	str	x2, [x0, #112]
> +alternative_else_nop_endif
> +alternative_if ARM64_HAS_S1POE
> +	mrs	x2, REG_POR_EL0
> +	str	x2, [x0, #120]
>  alternative_else_nop_endif
>  	ret
>  SYM_FUNC_END(cpu_do_suspend)
> @@ -160,6 +164,10 @@ alternative_if ARM64_SME
>  	ldr	x2, [x0, #112]
>  	msr_s	SYS_TPIDR2_EL0, x2
>  alternative_else_nop_endif
> +alternative_if ARM64_HAS_S1POE
> +	ldr	x2, [x0, #120]
> +	msr	REG_POR_EL0, x2
> +alternative_else_nop_endif
>  
>  	msr	sctlr_el1, x12
>  	set_this_cpu_offset x13
> 
> -- 2.47.3
> 

FWIW,

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
