Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794404685;
	b=AzM7luZWD/8h4lrDvoZP5Gvk1sxRp+Y37sLxIU12w/I4+C2znwjjY43s/UCHUJUdwqFf
	 bPILVfpM/HE5cZDmbsFc96RCpdr1n8kwpDKCC3DnrgV26iG6Y+LCEkko2WKJG6MyNLOqr
	 nV6w/iEXOHWCzbgMof5VclPhnAv+3pwZtuq7R8xHQdYWJwGr1OVsizXW+0ipoL9qpz4Al
	 ISw8nR52SJuxbA43Ws+aHWSSR3hIsSt8foO+Olfcl3ArNcAIDJFPgt6rPE3a2UoG6qtHI
	 9j+8nQB2er5Iygl+AW4zSl3RI/NybQ+pv+Ks6ub5NvjmO1KvPuGfnilRV4XdEzJyaIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794404685;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=C/nooMgmJG/3mp0rQ1JdOcq7TiihZwhR9+Lq4gd1ZqA=;
	b=Bj+vNYYF308rg+ngwzsblP00Nbsoo4frE9ffUMqlR0ncCn/J+8WWdVZAleatPefqxLpR
	 w02mX9G2DsMZjeWvSI0ivbQImPXqwD9FzAOR/wpcItOCaZ1pPbliUgppzZcLRTJwFiSlW
	 jVt7mbcZwTRRD3OuMoSTVl449rjDRW6pRObY1Sb6SpYXNNP4qcutZejk6AOHiuxYuOyuG
	 YqT7TZMWkNKkfW0Ab8/3LIjSqKs6i59oxudNZyCX5Mp15uhq5/saaUd1nQOCa9dLl4trW
	 AiHdzwfiMsq1WswPFXHmDVqJodQY7D3VUS8XMrRsP8ZbWE6VfS8cT6QknvaY6zE8Rxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=XMZDjw8K;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55187606A31C;
	Wed, 11 Nov 2026 13:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55187606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=XMZDjw8K
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 841C31576;
	Wed, 11 Nov 2026 05:44:41 -0800 (PST)
Received: from [10.0.154.42] (e121487-lin.cambridge.arm.com [10.0.154.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC9EA3F673;
	Wed, 11 Nov 2026 05:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794404684; bh=w2VNZqXDGorpHrLLSd9Lolnep92uG7Tj6Jtn26G8qZc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XMZDjw8KwZgkZXf/BmInpGUc/Nu/+rD12k7JhOUze6J6Xxre4SfOdq5WVwxjfiWTa
	 9/eDyVHQTNWpHi+d18HTtRra8Hh3YqU0K4XAOeQV5OSptnSeNSVquJujUod3s+tLxQ
	 jSMziHEiA/pMBzLCDPi5kiv7vPRnqrAFnAB9u5XQ=
Message-ID: <282608f5-a13b-4695-aa17-f834bf5d8272@arm.com>
Date: Wed, 11 Nov 2026 13:44:40 +0000
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
Subject: Re: [PATCH 2/2] arm64: suspend: Save GCS state over suspend
To: Mark Brown <broonie@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Joey Gouly <joey.gouly@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261105-arm64-fix-sysreg-suspend-v1-0-f4d9a99fec46@kernel.org>
 <20261105-arm64-fix-sysreg-suspend-v1-2-f4d9a99fec46@kernel.org>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <20261105-arm64-fix-sysreg-suspend-v1-2-f4d9a99fec46@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/26 16:05, Mark Brown wrote:
> GCSCRE0_EL1 and GCSPR_EL0 are live registers for EL0 on systems with GCS
> but are not saved and restored by cpu_do_suspend()/cpu_do_resume(). This
> means that the task that initiated suspend can return to userspace with
> UNKNOWN or incorrect values for GCSPR_EL0 and GCSCRE0_EL1 (many fields
> in GCSCRE0_EL1 reset to 0).  This will in turn lead to ongoing
> corruption, including not restoring mode until a task with a different
> GCS mode is run.  Fix this by saving and restoring the values over
> suspend.
> 
> This increases the size of struct cpu_suspend_ctx by 16 bytes.
> 
> Fixes: 5d8b172e7005 ("arm64: Add Kconfig for Guarded Control Stack (GCS)")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>  arch/arm64/include/asm/suspend.h |  2 +-
>  arch/arm64/mm/proc.S             | 12 ++++++++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/suspend.h
> index eb9ce315f146..8e9c97aab15a 100644
> --- a/arch/arm64/include/asm/suspend.h
> +++ b/arch/arm64/include/asm/suspend.h
> @@ -2,7 +2,7 @@
>  #ifndef __ASM_SUSPEND_H
>  #define __ASM_SUSPEND_H
>  
> -#define NR_CTX_REGS 16
> +#define NR_CTX_REGS 18
>  #define NR_CALLEE_SAVED_REGS 12
>  
>  /*
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 664ea9e3b9ad..99aacf03367d 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -121,6 +121,12 @@ alternative_else_nop_endif
>  alternative_if ARM64_HAS_S1POE
>  	mrs	x2, REG_POR_EL0
>  	str	x2, [x0, #120]
> +alternative_else_nop_endif
> +alternative_if ARM64_HAS_GCS
> +	mrs	x2, REG_GCSPR_EL0
> +	str	x2, [x0, #128]
> +	mrs	x2, REG_GCSCRE0_EL1
> +	str	x2, [x0, #136]

Have you considered using stp?

>  alternative_else_nop_endif
>  	ret
>  SYM_FUNC_END(cpu_do_suspend)
> @@ -168,6 +174,12 @@ alternative_if ARM64_HAS_S1POE
>  	ldr	x2, [x0, #120]
>  	msr	REG_POR_EL0, x2
>  alternative_else_nop_endif
> +alternative_if ARM64_HAS_GCS
> +	ldr	x2, [x0, #128]
> +	msr	REG_GCSPR_EL0, x2
> +	ldr	x2, [x0, #136]
> +	msr	REG_GCSCRE0_EL1, x2

Have you considered using ldp?


Cheers
Vladimir
