Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DBD26CE32;
	Wed,  1 Jul 2026 23:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782949547; cv=none; b=mA0NBWB4iYDlgPMYHCmEFGiGPlT2xEkT9VafEvZWN291xCG5gjMj2lkq5v1kyNDPfqS6sUUczR8NrilGG1XoFmyULR+ERP4MOeo1ajJIV69OlvQgUUQaYJ5xZWWUt1CG4Vt+GhHpnCYb8wC0vP8cYaA9sPtJmbFlbcfS9dlmRlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782949547; c=relaxed/simple;
	bh=s2lPydgYOczQyPYwZ8AI3vZB7rMisutqZLPAyHm1W3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcEXNuyK7Hf3d3t5hwenEp7dnoVvssP/3otuEzEFcpnO/m7mMoLDxOm0twBF1v++a09TABmSkIX+bcwhc6EndLzz4FZS1/XzHk6C91gCjIzaAjs//MMshlcJXdGzNxJV3hEIGPmXIPcl8IL+BnWxLxzXibHJtu1AjY8gBo4SH4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFU227dB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFU227dB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7379C1F000E9;
	Wed,  1 Jul 2026 23:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782949545;
	bh=CjDwefjv1AyM6E5mlH5FqnsJuTuUDUpYfBrPdP92PPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FFU227dB/thlEfqyQeBLjjYcz78UnSO2U27UwZJj9qRALcl0SZVeUJ2cYh9N24eSe
	 UOUb0mIsVvaSU0QOEpfk4PzmFzIlfRtfnGL2Iqs+LF5mB9Y/JMQLMRydkVmdlsrDcp
	 HwmApjgNK0D3VOeyBWoe2Kz/N6u9KOgYAZqkPkZKGseuhY745VDyvLO64XrbqIC3lo
	 WICLgo+SK+6peCB8HVzbsx93uzYKuUXtupqQ7Xmv2v8Hxmp2oEOVLfVlKbuC8BEPNH
	 b+p0Hw4xWWSFXBf9uDg5wvh9Hi+tn/uhxGgaLsPu7ACr/brXnUTjV0LgFfano2sA9D
	 8gpvFQD29zDgQ==
Date: Wed, 1 Jul 2026 16:45:44 -0700
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
	linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Ahmed Genidi <ahmed.genidi@arm.com>,
	Ben Horgan <ben.horgan@arm.com>, Leo Yan <leo.yan@arm.com>
Subject: Re: [PATCH 4/5] KVM: arm64: Initialize HCR_EL2.E2H early
Message-ID: <akWmqLQ31UvRLCxt@kernel.org>
References: <20260701204342.2654385-1-coltonlewis@google.com>
 <20260701204342.2654385-5-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701204342.2654385-5-coltonlewis@google.com>

On Wed, Jul 01, 2026 at 08:43:41PM +0000, Colton Lewis wrote:
> From: Mark Rutland <mark.rutland@arm.com>
> 
> [ Upstream commit 7a68b55ff39b0d2dcd92ee241b12b23a7e03c621 ]
> 
> On CPUs without FEAT_E2H0, HCR_EL2.E2H is RES1, but may reset to an
> UNKNOWN value out of reset and consequently may not read as 1 unless it
> has been explicitly initialized.
> 
> We handled this for the head.S boot code in commits:
> 
>   3944382fa6f22b54 ("arm64: Treat HCR_EL2.E2H as RES1 when ID_AA64MMFR4_EL1.E2H0 is negative")
>   b3320142f3db9b3f ("arm64: Fix early handling of FEAT_E2H0 not being implemented")
> 
> Unfortunately, we forgot to apply a similar fix to the KVM PSCI entry
> points used when relaying CPU_ON, CPU_SUSPEND, and SYSTEM SUSPEND. When
> KVM is entered via these entry points, the value of HCR_EL2.E2H may be
> consumed before it has been initialized (e.g. by the 'init_el2_state'
> macro).
> 
> Initialize HCR_EL2.E2H early in these paths such that it can be consumed
> reliably. The existing code in head.S is factored out into a new
> 'init_el2_hcr' macro, and this is used in the __kvm_hyp_init_cpu()
> function common to all the relevant PSCI entry points.
> 
> For clarity, I've tweaked the assembly used to check whether
> ID_AA64MMFR4_EL1.E2H0 is negative. The bitfield is extracted as a signed
> value, and this is checked with a signed-greater-or-equal (GE) comparison.
> 
> As the hyp code will reconfigure HCR_EL2 later in ___kvm_hyp_init(), all
> bits other than E2H are initialized to zero in __kvm_hyp_init_cpu().
> 
> Fixes: 3944382fa6f22b54 ("arm64: Treat HCR_EL2.E2H as RES1 when ID_AA64MMFR4_EL1.E2H0 is negative")
> Fixes: b3320142f3db9b3f ("arm64: Fix early handling of FEAT_E2H0 not being implemented")
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Ahmed Genidi <ahmed.genidi@arm.com>
> Cc: Ben Horgan <ben.horgan@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Leo Yan <leo.yan@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Oliver Upton <oliver.upton@linux.dev>
> Cc: Will Deacon <will@kernel.org>
> Link: https://lore.kernel.org/r/20250227180526.1204723-2-mark.rutland@arm.com
> [maz: fixed LT->GE thinko]
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> 
> [ Backport: Resolved conflict in arch/arm64/kvm/hyp/nvhe/hyp-init.S
>   by extracting EL2 state initialization into __kvm_init_el2_state
>   and calling it after HCR setup. ]
> ---
>  arch/arm64/include/asm/el2_setup.h | 26 ++++++++++++++++++++++++++
>  arch/arm64/kernel/head.S           | 19 +------------------
>  arch/arm64/kvm/hyp/nvhe/hyp-init.S | 16 +++++++++++++---
>  3 files changed, 40 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
> index b7afaa026842b..3498dc5d02c18 100644
> --- a/arch/arm64/include/asm/el2_setup.h
> +++ b/arch/arm64/include/asm/el2_setup.h
> @@ -16,6 +16,32 @@
>  #include <asm/sysreg.h>
>  #include <linux/irqchip/arm-gic-v3.h>
>  
> +.macro init_el2_hcr	val
> +	mov_q	x0, \val
> +
> +	/*
> +	 * Compliant CPUs advertise their VHE-onlyness with
> +	 * ID_AA64MMFR4_EL1.E2H0 < 0. On such CPUs HCR_EL2.E2H is RES1, but it
> +	 * can reset into an UNKNOWN state and might not read as 1 until it has
> +	 * been initialized explicitly.
> +	 *
> +	 * Fruity CPUs seem to have HCR_EL2.E2H set to RAO/WI, but
> +	 * don't advertise it (they predate this relaxation).
> +	 *
> +	 * Initalize HCR_EL2.E2H so that later code can rely upon HCR_EL2.E2H
> +	 * indicating whether the CPU is running in E2H mode.
> +	 */
> +	mrs_s	x1, SYS_ID_AA64MMFR4_EL1
> +	sbfx	x1, x1, #ID_AA64MMFR4_EL1_E2H0_SHIFT, #ID_AA64MMFR4_EL1_E2H0_WIDTH
> +	cmp	x1, #0
> +	b.ge	.LnVHE_\@
> +
> +	orr	x0, x0, #HCR_E2H
> +.LnVHE_\@:
> +	msr	hcr_el2, x0
> +	isb
> +.endm
> +
>  .macro __init_el2_sctlr
>  	mov_q	x0, INIT_SCTLR_EL2_MMU_OFF
>  	msr	sctlr_el2, x0
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index e0e710b36da37..ff7769821166a 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -575,25 +575,8 @@ SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
>  	msr	sctlr_el2, x0
>  	isb
>  0:
> -	mov_q	x0, HCR_HOST_NVHE_FLAGS
> -
> -	/*
> -	 * Compliant CPUs advertise their VHE-onlyness with
> -	 * ID_AA64MMFR4_EL1.E2H0 < 0. HCR_EL2.E2H can be
> -	 * RES1 in that case. Publish the E2H bit early so that
> -	 * it can be picked up by the init_el2_state macro.
> -	 *
> -	 * Fruity CPUs seem to have HCR_EL2.E2H set to RAO/WI, but
> -	 * don't advertise it (they predate this relaxation).
> -	 */
> -	mrs_s	x1, SYS_ID_AA64MMFR4_EL1
> -	tbz	x1, #(ID_AA64MMFR4_EL1_E2H0_SHIFT + ID_AA64MMFR4_EL1_E2H0_WIDTH - 1), 1f
> -
> -	orr	x0, x0, #HCR_E2H
> -1:
> -	msr	hcr_el2, x0
> -	isb
>  
> +	init_el2_hcr	HCR_HOST_NVHE_FLAGS
>  	init_el2_state
>  
>  	/* Hypervisor stub */
> diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
> index 1cc06e6797bda..a08363b9b10fd 100644
> --- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
> +++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
> @@ -75,6 +75,16 @@ __do_hyp_init:
>  	eret
>  SYM_CODE_END(__kvm_hyp_init)
>  
> +/*
> + * Initialize EL2 CPU state to sane values.
> + *
> + * HCR_EL2.E2H must have been initialized already.
> + */
> +SYM_CODE_START_LOCAL(__kvm_init_el2_state)
> +	init_el2_state				// Clobbers x0..x2
> +	finalise_el2_state
> +	ret
> +SYM_CODE_END(__kvm_init_el2_state)
>  /*
>   * Initialize the hypervisor in EL2.
>   *
> @@ -202,9 +212,9 @@ SYM_CODE_START_LOCAL(__kvm_hyp_init_cpu)
>  
>  2:	msr	SPsel, #1			// We want to use SP_EL{1,2}
>  
> -	/* Initialize EL2 CPU state to sane values. */
> -	init_el2_state				// Clobbers x0..x2
> -	finalise_el2_state
> +	init_el2_hcr	0
> +
> +	bl	__kvm_init_el2_state

Please don't churn unrelated code. Leave everything where it is and make
sure init_el2_hcr is done before the others.

Thanks,
Oliver
