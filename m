Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981711;
	b=xjS04vPPMbvxCF7caMcGk1c/KxGMfCbxY4wjISuLJkrMns9bBcsJX3NDCpwi38HoHKVL
	 SaXStK9zsUIWIUcaMAaSZW+24UkSEJMWP0w1Wmjy7Utgayj1hTKkBMEZWNqkZZmuKDjyf
	 ArFxYdvuOuK1uUvn7qgEKAkpDqf2smd+0REKvUU0nCaQ2M1mjjudqBeiJiEFmki92yp4z
	 WF8Sy7H7vo2sgdkBHxUWLBlhLAnJIeYgR3iCBzNY7IvRQ2rn/m+n5cvHnoTHiPBeO2t2m
	 ZEi5E0l2AUzM9WQjFqXlzO9MjcA02K9ws503K13m20FgF6NcoT2XW8lyQX/9w0Y8UsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981711;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=sVfAXVYZ6FXAyGhrwa2GYGqDIM1fZELZB/+nyD7WsYo=;
	b=Kt5xDDbCbu1JG6W59ks/cZ2XIzZmMFIt8689P+5LQL+1Upn68erJ44TZzYGo0gkmoFZI
	 IjI7lWBnt3aCnKtVCWJh1gcG6r+S+iewUPP9pulkHb34X9riJLgNKqiVXSUS7nZHRxxQ/
	 5Zxed0N0hBFjyZsFTwTt4ttLdYA4ffsnpaml8qWm81ymUB3w5kG5pw6XFc1dYMll9SuVa
	 A5ihvL3nPas4gm2UYO7zbWslL6OMlxQ4tOcCt2Pn3hN8pJFmoBB+Vwr5+IWuXiwuflIPe
	 mda8EI+F/hKlM936JcGte2tZ1gB3tC5ZHlPBuxnLiClJrZJSfUdr/hitL7nKlWn28JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=sVAFxjo3;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5483606A336;
	Fri,  6 Nov 2026 16:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5483606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=sVAFxjo3
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85702143D;
	Fri,  6 Nov 2026 08:15:06 -0800 (PST)
Received: from [10.2.213.24] (e137867.arm.com [10.2.213.24])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01B1E3F673;
	Fri,  6 Nov 2026 08:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793981709; bh=IQ3sgomSiBn9gKzrzkAyQrVz3yw2Rr15QPLg09Ba0Ec=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sVAFxjo38ELex2XbmZkIS1mAV1VYURD8Ona57+AktCEEwLskVfJZUuxu2N8T7MXY6
	 8X2PYWYpvfi41yClUaZl4MyK5hSGCA2d/d/g5GMAvllrNAQJXemnhWZ1qOmdSyLVuR
	 CRKaR5f8Xa7TeLY4e0CHDNv2YWThOD02s62PxpcI=
Message-ID: <1bae50ad-a65e-4ccb-b247-8d9544e4c5ee@arm.com>
Date: Fri, 6 Nov 2026 16:14:56 +0000
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
Subject: Re: [PATCH v2 1/2] arm64: sdei: Run the event handler on the kernel
 vectors
To: Kiryl Shutsemau <kirill@shutemov.name>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, James Morse <james.morse@arm.com>,
 Usama Arif <usama.arif@linux.dev>
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Doug Anderson <dianders@chromium.org>, Breno Leitao <leitao@debian.org>,
 Jinjie Ruan <ruanjinjie@huawei.com>,
 Vladimir Murzin <vladimir.murzin@arm.com>, Linus Walleij
 <linusw@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Huth <thuth@redhat.com>, Dawei Li <dawei.li@linux.dev>,
 mrigendrachaubey <mrigendra.chaubey@gmail.com>, kernel-team@meta.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Ada Couprie Diaz <ada.coupriediaz@arm.com>
References: <20261105120835.3321912-1-kirill@shutemov.name>
 <20261105120835.3321912-2-kirill@shutemov.name>
From: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Content-Language: en-US, en-GB, fr
Organization: Arm Ltd.
In-Reply-To: <20261105120835.3321912-2-kirill@shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

On 05/11/2026 12:08, Kiryl Shutsemau wrote:

> From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
>
> With KPTI, VBAR_EL1 holds the trampoline vectors from the return to EL0
> until the next exception from EL0 maps the kernel and installs the
> kernel vectors. The trampoline vectors only handle exceptions from EL0;
> their current-EL half is zero-filled.
>
> An SDEI event is dispatched regardless of PSTATE.DAIF, so it lands there
> whenever the CPU is in user space. The SDEI entry trampoline maps the
> kernel but leaves VBAR_EL1 alone. [...]

This quite broken indeed, thank you for sending a patch !

However, given this and Catalin's comment regarding PMR save/restore,
to me this sounds more like `arch/arm64/entry.S` is not doing its job
properly for SDEI events, rather than the SDEI handler missing something.

In fact, it appears that the SDEI trampoline misses a fair amount of
the "regular" kernel and trampoline entry in general, which might subtly
break more assumptions...

> [...]
>
> Install the kernel vectors in __sdei_handler() when VBAR_EL1 holds the
> trampoline vectors, and restore it before returning to firmware. [...]

Given that this is done in `entry.S` for a regular kernel entry,
I feel like this should be done there too for SDEI : bringing the two
paths closer rather than needing to do some additional special handling
in the handler.

`__sdei_asm_entry_trampoline` and `__sdei_asm_exit_trampoline` already
check if the CPU was running at EL0 and maps/unmaps the kernel accordingly.
We could swap VBAR to the EL1 vectors and back to the EL0 trampoline there...

> The IRQ-like resume into user space must still go through the
> trampoline to map the kernel. do_sdei_event() takes the interrupted
> VBAR_EL1 and keeps basing the resume address on it.

...and to maintain the expected behaviour on return, rather than using
VBAR (which would bypass the trampoline in the EL0 IRQ-like resume case),
we could explicitly choose the correct vector base for KPTI=on ?
Something along those lines in `do_sdei_event()` :

	/* KPTI=off => vectors or the appropriate mitigation, KPTI=on => trampoline */
	unsigned long vbar = __raw_this_cpu_read(this_cpu_vector)
	[...]
	/* KPTI=on => have to bypass unmapped EL1 exceptions of the trampoline vector */
	if (arm64_kernel_unmapped_at_el0() && mode == kernel_mode)
		vbar = vectors
	[...]
	if (mode == kernel_mode)
		return vbar + 0x280;
	else if (mode & PSR_MODE32_BIT)
		return vbar + 0x680;

	return vbar + 0x480;

> Fixes: 79e9aa59dc29 ("arm64: sdei: Add trampoline code for remapping the kernel")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> ---
>   arch/arm64/include/asm/sdei.h    |  3 ++-
>   arch/arm64/kernel/entry-common.c | 21 ++++++++++++++++++++-
>   arch/arm64/kernel/sdei.c         |  6 ++++--
>   3 files changed, 26 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/include/asm/sdei.h b/arch/arm64/include/asm/sdei.h
> index b2248bd3cb58..a78a5337ff85 100644
> --- a/arch/arm64/include/asm/sdei.h
> +++ b/arch/arm64/include/asm/sdei.h
> @@ -44,7 +44,8 @@ asmlinkage unsigned long __sdei_handler(struct pt_regs *regs,
>   					struct sdei_registered_event *arg);
>   
>   unsigned long do_sdei_event(struct pt_regs *regs,
> -			    struct sdei_registered_event *arg);
> +			    struct sdei_registered_event *arg,
> +			    unsigned long vbar);
>   
>   unsigned long sdei_arch_get_entry_point(int conduit);
>   #define sdei_arch_get_entry_point(x)	sdei_arch_get_entry_point(x)
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index 11d3f888fcd8..8a17e3720f81 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -31,6 +31,7 @@
>   #include <asm/stacktrace.h>
>   #include <asm/sysreg.h>
>   #include <asm/system_misc.h>
> +#include <asm/vectors.h>
>   
>   /*
>    * Where the context being returned to had an active percpu GPR critical
> @@ -1040,6 +1041,7 @@ asmlinkage void noinstr __noreturn handle_bad_stack(struct pt_regs *regs)
>   asmlinkage noinstr unsigned long
>   __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
>   {
> +	unsigned long vbar;
>   	irqentry_state_t state;
>   	unsigned long ret;
>   
> @@ -1065,10 +1067,27 @@ __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
>   	else if (cpu_has_pan())
>   		set_pstate_pan(0);
>   
> +	/*
> +	 * With KPTI, VBAR_EL1 holds the trampoline vectors from the return to
> +	 * EL0 until the next exception from EL0 maps the kernel. They only
> +	 * handle exceptions from EL0: an exception taken here would run their
> +	 * empty current-EL half and never come back. Switch to the kernel
> +	 * vectors. The IRQ-like resume keeps using the interrupted VBAR, so it
> +	 * still goes through the trampoline.
> +	 */
> +	vbar = read_sysreg(vbar_el1);
> +	if (arm64_kernel_unmapped_at_el0() &&
> +	    vbar == (unsigned long)__this_cpu_read(this_cpu_vector)) {
> +		write_sysreg((unsigned long)vectors, vbar_el1);
> +		isb();
> +	}
> +
>   	state = irqentry_nmi_enter(regs);
> -	ret = do_sdei_event(regs, arg);
> +	ret = do_sdei_event(regs, arg, vbar);
>   	irqentry_nmi_exit(regs, state);
>   
> +	write_sysreg(vbar, vbar_el1);
> +
>   	return ret;
>   }

With what I mentioned above, this would be completely replaced by the
changes in `entry.S`, with no change in `__sdei_handler()`.

>   #endif /* CONFIG_ARM_SDE_INTERFACE */
> diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
> index 778f2a1faac8..260c13106009 100644
> --- a/arch/arm64/kernel/sdei.c
> +++ b/arch/arm64/kernel/sdei.c
> @@ -200,16 +200,18 @@ unsigned long sdei_arch_get_entry_point(int conduit)
>    *  SDEI_EV_HANDLED -  success, return to the interrupted context.
>    *  SDEI_EV_FAILED  -  failure, return this error code to firmware.
>    *  virtual-address -  success, return to this address.
> + *
> + * vbar is the interrupted context's VBAR_EL1, for the IRQ-like resume.
>    */
>   unsigned long __kprobes do_sdei_event(struct pt_regs *regs,
> -				      struct sdei_registered_event *arg)
> +				      struct sdei_registered_event *arg,
> +				      unsigned long vbar)
>   {
>   	u32 mode;
>   	int i, err = 0;
>   	int clobbered_registers = 4;
>   	u64 elr = read_sysreg(elr_el1);
>   	u32 kernel_mode = read_sysreg(CurrentEL) | 1;	/* +SPSel */
> -	unsigned long vbar = read_sysreg(vbar_el1);
>   
>   	if (arm64_kernel_unmapped_at_el0())
>   		clobbered_registers++;

And this part would be made more explicit as to what vector base
we should be jumping back to on return from firmware.


What are your thoughts ?
I understand that this is a completely different approach, but I feel it
would be more in line with what we already do for other entry paths.
This might even allow us to de-duplicate them in the future and reduce
the chance of this happening again.

If my suggestion is not sound, apart from what Catalin already mentioned
the patch looks good to me !

Kind regards,
Ada

