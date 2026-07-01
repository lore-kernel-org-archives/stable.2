Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA4C3EDAA6;
	Wed,  1 Jul 2026 23:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782948606; cv=none; b=Nxfwz1Zh+LRuaW9xx2w3K7CUmATVHtc7Nr3o9nyWcZf+HE53zC7HFtS5o2rdKRObIkPctCg12u5ej+l3A4UMH460R7oW39jtafWF9Re/btqTl2ZUIpdUeBbbSdMb7qGLmtaqmx8nlLEfRdAQgy4KIABmTs+lEG62wjZnRcgUog4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782948606; c=relaxed/simple;
	bh=dxK21AX57+TJYaG8cyTJzF2QwTKNKokDDXvnAYFhGOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3vKYV1K9S6Awv8QL19uVLZvCk6Qk4PP7kBSrlF6nDG79JDA317IDf4yXfEr/gyTLbzmYhIwdvTg2yiOtDwGZ8JE9CpMIwgyerKDJk+TmNkqjWKsEYsDom6Ocnre1DiMXhcklAEtdnM1MO2HeiQ8WjKvZSvRSsja6A4cJxHHCH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBEnYSsC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBEnYSsC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D4C1F000E9;
	Wed,  1 Jul 2026 23:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782948605;
	bh=bArU32dZH6f5UF8IuQnAtSTa5QhA69SwqVteecUtE6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eBEnYSsCxJdg72eWOKTR5Rv0bJWUTRCZU9fOfcmDJxaSt+7zbmJ2FNXB8eR8dt1KS
	 iZL4lw4FbGX/6pTZRtNO9mfjU3tmDP5DP/G0EuRPuPLqdZ2dxDjZzNckB0Hqi7po2L
	 7kHtHs/lYGymzDEbci+Alz3QtLPrmL9QNdiMOOU8LKaMW/2bqjmoTYJaNbP9bsII9h
	 d0ZALwM40qqeANKijTiJoDE0miHVC9cHQ+T2SE7yMxDC4X3/OkP9HWA06AJ18flJJV
	 4SSxqvJgEb3xCpFy9Q7dUzbdsJhP5R1MNcoHEvvLN7P9QYcBjCNl3pPBX0RtsyQEv0
	 3AxOE+Cl+dR1A==
Date: Wed, 1 Jul 2026 16:30:04 -0700
From: Oliver Upton <oupton@kernel.org>
To: Colton Lewis <coltonlewis@google.com>
Cc: stable@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Mingwei Zhang <mizhang@google.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] arm64: Treat HCR_EL2.E2H as RES1 when
 ID_AA64MMFR4_EL1.E2H0 is negative
Message-ID: <akWi_E_tQPzhlfc-@kernel.org>
References: <20260701204342.2654385-1-coltonlewis@google.com>
 <20260701204342.2654385-3-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701204342.2654385-3-coltonlewis@google.com>

On Wed, Jul 01, 2026 at 08:43:39PM +0000, Colton Lewis wrote:
> From: Marc Zyngier <maz@kernel.org>
> 
> [ Upstream commit 3944382fa6f22b54bc3624c9657b98ec34b5ba59 ]

What is this? I have the commit in question as

3944382fa6f22b54fd399632b1af92c28123979b

> For CPUs that have ID_AA64MMFR4_EL1.E2H0 as negative, it is important
> to avoid the boot path that sets HCR_EL2.E2H=0. Fortunately, we
> already have this path to cope with fruity CPUs.
> 
> Tweak init_el2 to look at ID_AA64MMFR4_EL1.E2H0 first.
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Link: https://lore.kernel.org/r/20240122181344.258974-8-maz@kernel.org
> Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
> ---
>  arch/arm64/kernel/head.S | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 6517bf2644a08..e32c8dd0b17a7 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -589,25 +589,32 @@ SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
>  	mov_q	x1, INIT_SCTLR_EL1_MMU_OFF
>  
>  	/*
> -	 * Fruity CPUs seem to have HCR_EL2.E2H set to RES1,
> -	 * making it impossible to start in nVHE mode. Is that
> -	 * compliant with the architecture? Absolutely not!
> +	 * Compliant CPUs advertise their VHE-onlyness with
> +	 * ID_AA64MMFR4_EL1.E2H0 < 0. HCR_EL2.E2H can be
> +	 * RES1 in that case.
> +	 *
> +	 * Fruity CPUs seem to have HCR_EL2.E2H set to RES1, but
> +	 * don't advertise it (they predate this relaxation).
>  	 */
> +	mrs_s	x0, SYS_ID_AA64MMFR4_EL1
> +	ubfx	x0, x0, #ID_AA64MMFR4_EL1_E2H0_SHIFT, #ID_AA64MMFR4_EL1_E2H0_WIDTH
> +	tbnz	x0, #(ID_AA64MMFR4_EL1_E2H0_SHIFT + ID_AA64MMFR4_EL1_E2H0_WIDTH - 1), 1f
> +
>  	mrs	x0, hcr_el2
>  	and	x0, x0, #HCR_E2H
> -	cbz	x0, 1f
> -
> +	cbz	x0, 2f
> +1:
>  	/* Set a sane SCTLR_EL1, the VHE way */
>  	pre_disable_mmu_workaround
>  	msr_s	SYS_SCTLR_EL12, x1
>  	mov	x2, #BOOT_CPU_FLAG_E2H
> -	b	2f
> +	b	3f
>  
> -1:
> +2:
>  	pre_disable_mmu_workaround
>  	msr	sctlr_el1, x1
>  	mov	x2, xzr
> -2:
> +3:
>  	__init_el2_nvhe_prepare_eret
>  
>  	mov	w0, #BOOT_CPU_MODE_EL2
> -- 
> 2.55.0.rc2.803.g1fd1e6609c-goog
> 
> 
