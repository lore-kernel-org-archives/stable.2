Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706609;
	b=pNo8syGZ1Og/rTn4DuppeQxUFCxS8NbYgXuBryJkjb4gCqUb0wLcqMF+RQH6fdZGN+az
	 AMPhKPAKVvvsoSc0wUvf+4sMnZXk1rYfK9B/ZsojOZdw63uiYZJLmzWiKkKf/9amsiXqN
	 uEROQEPUBomoX9AA3dN0LCOv/0VQ0+zU0/xG64wwpWvF3JkvBASf0ltbPzNuSIi5+MMWM
	 0LOAJ8QKh2bLUtSS+DK9VR6Vh39ZQ14/3zP/8Xx8pf59nSVtLgj6AxKAcjZvLURfgSfd5
	 LSrw3wN1maXQEtg8s4JxBZrloBupEI30RCad/rIVnML1wZtzliVCdDTNF/Wzb8ypG2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706609;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=21vYI0bQVUl3hCiSLmuD6Wo76ikPKRN+C6h2vCMSb/E=;
	b=VRtUxdGx8WKgu1Dy4chhC3aOcfeXKrG8KxBJRNZGRuV3YCDG3K+XadMGIv/O56QfOWCh
	 Xhsd9tdJw/Ix0N50l/p3oi+Il+fHWUzJMUJzpUcsMjWbSl6l2xqPxTf1Ew53kF2NdaRF8
	 LfWhBq5/7LY3Mq8jFEIx8iyiM5hsIgneeYwtk4B42m2PqoM3K1yEI72rPotFUmHAXL9bN
	 tqmemiZxauhG+7iam3nhhSc6TAFCJ6b7nr51JjNhh8/XONeG2Ie/bC8envpUb2LieHWji
	 /fCBhPLPFaEjzZYH4ZI3/5BOX8LtoZ7iiKDMOHS7TxO65bdUn9DwGVbcOiB18Rf3SZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NTzqHn6U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20CB606A32F;
	Tue,  3 Nov 2026 11:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NTzqHn6U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF13B1F00A1E;
	Tue,  3 Nov 2026 11:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793706608;
	bh=21vYI0bQVUl3hCiSLmuD6Wo76ikPKRN+C6h2vCMSb/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NTzqHn6UV0XlvZnKXNpull1pI9vC844ALQF1QB7ewEHwqFQiUxyCsX1vR+MKE0t3r
	 y935niEs67SECOk8icBrppwNaHDapOCSo4lYsI9LV+Jh3Jjn1Fwlw5SFMDjEPHbzYp
	 fallXfTmScstELEyPZU/q8ctAZXnUDFYs9sHj8qV+GqrKukjw+ot07vYiWCmgQ0bde
	 /zKZbJeHE3MHwOiOqL7ug13nzBn6nMhZdERc3wzWDlDmpxqSjOakD4fg1zI7oqzmYQ
	 1DNre6XTfOXizmQ9gtggy3llNS+vRrnNSB9eSeoUwNO/nU0cXwmqZ45F445dV1Ead6
	 28Saxt+cZEROA==
Date: Tue, 3 Nov 2026 11:50:03 +0000
From: Will Deacon <will@kernel.org>
To: Wei Wang <wvw@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	wei.vince.wang@gmail.com
Subject: Re: [PATCH] arm64: suspend: Save and restore TPIDR2_EL0 across CPU
 suspend
Message-ID: <aunKa8uBZJTCzVjd@willie-the-truck>
References: <20261102234813.1069156-1-wvw@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102234813.1069156-1-wvw@google.com>

On Mon, Nov 02, 2026 at 11:48:13PM +0000, Wei Wang wrote:
> On systems with FEAT_SME, TPIDR2_EL0 is part of userspace thread state:
> the AAPCS64 SME ABI uses it as the ZA lazy-save pointer, and the kernel
> context-switches it eagerly in tls_thread_switch(). While a task is
> running, the live register is the only copy of its value.
> 
> The architecture defines TPIDR2_EL0 as UNKNOWN after a warm reset, so
> a CPU power-down through PSCI CPU_SUSPEND or SYSTEM_SUSPEND can lose it.
> cpu_do_suspend() and cpu_do_resume() already preserve TPIDR_EL0 and
> TPIDRRO_EL0, but not TPIDR2_EL0.
> 
> For CPU idle this is harmless: current is the idle task, and the next
> context switch reloads TPIDR2_EL0 from next->thread.tpidr2_el0. For
> suspend-to-RAM and hibernation, however, cpu_suspend() runs in the
> context of the userspace task that wrote /sys/power/state, and that
> task returns to EL0 with an UNKNOWN TPIDR2_EL0. On hardware where the
> reset value is non-zero, the next SME ABI lazy-save check in that
> thread faults. For example, bionic's fork() -> clone() ->
> __arm_za_disable() -> __arm_tpidr2_save() loads from the garbage
> pointer:
> 
>   # echo mem > /sys/power/state; true
>   signal 11 (SIGSEGV), code 1 (SEGV_MAPERR), fault addr 0xa3bad11bcaf72e93
>       x16 a3bad11bcaf72e89
>   #00 pc ... libc.so (__arm_tpidr2_save+24)
>   #01 pc ... libc.so (__arm_za_disable+32)
>   #02 pc ... libc.so (clone+480)
>   #03 pc ... libc.so (fork+60)
> 
> Having firmware zero TPIDR2_EL0 on warm reset avoids the crash. It is
> not enough on its own, though: a thread that enters the kernel with a
> lazy save pending (TPIDR2_EL0 pointing at a valid TPIDR2 block) would
> see TPIDR2_EL0 == 0 on return. It would then wrongly conclude that ZA
> had been committed and restore stale data from its save buffer. The
> kernel owns this state and must preserve it.

There's a lot of unnecessary (AI-generated?) detail in here. Please can
you trim this down a bit? I don't think we care about the firmware part,
the stuff about idle or the bionic crash. The bottom line is that we're
not saving/restoring a live EL0 register across suspend/resume.

> Save TPIDR2_EL0 in cpu_do_suspend() and restore it in cpu_do_resume()
> when SME is present. Placing this in proc.S covers both cpu_suspend()
> and hibernation. The new slot uses ctx_regs[14]; sp moves into what was
> previously tail padding, so sizeof(struct cpu_suspend_ctx) stays 128
> bytes. sp is only accessed through the CPU_CTX_SP asm-offset.
> 
> Fixes: a9d691585950 ("arm64/sme: Implement support for TPIDR2")
> Signed-off-by: Wei Wang <wvw@google.com>
> ---
>  arch/arm64/include/asm/suspend.h | 2 +-
>  arch/arm64/mm/proc.S             | 8 ++++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/suspend.h
> index eb60c9735553..2cc5fb405769 100644
> --- a/arch/arm64/include/asm/suspend.h
> +++ b/arch/arm64/include/asm/suspend.h
> @@ -2,7 +2,7 @@
>  #ifndef __ASM_SUSPEND_H
>  #define __ASM_SUSPEND_H
>  
> -#define NR_CTX_REGS 14
> +#define NR_CTX_REGS 15
>  #define NR_CALLEE_SAVED_REGS 12
>  
>  /*
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 7afbece885a3..c7b7fa6491c3 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -103,6 +103,10 @@ SYM_FUNC_START(cpu_do_suspend)
>  alternative_if ARM64_HAS_TCR2
>  	mrs	x2, REG_TCR2_EL1
>  	str	x2, [x0, #104]
> +alternative_else_nop_endif
> +alternative_if ARM64_SME
> +	mrs_s	x2, SYS_TPIDR2_EL0
> +	str	x2, [x0, #112]
>  alternative_else_nop_endif
>  	ret
>  SYM_FUNC_END(cpu_do_suspend)
> @@ -142,6 +146,10 @@ alternative_if ARM64_HAS_TCR2
>  	ldr	x2, [x0, #104]
>  	msr	REG_TCR2_EL1, x2
>  alternative_else_nop_endif
> +alternative_if ARM64_SME
> +	ldr	x2, [x0, #112]
> +	msr_s	SYS_TPIDR2_EL0, x2
> +alternative_else_nop_endif

nit: We use msr and REG_* for TCR2, so it would be more consistent to do
the same for TPIDR2_EL0 if the assembler is happy with it.

Otherwise, looks ok to me:

Acked-by: Will Deacon <will@kernel.org>

Will
