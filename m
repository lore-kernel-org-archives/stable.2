Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE509632;
	Sat, 29 Aug 2026 09:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787996551; cv=none; b=KfsngTwhZEIF0H1le7eRnza72lpaNDcbqN5aviXqXn6h4hhdi/xP/U5/iAgofyco9vGv9yIu3TAX/Qe5MioW3gLXTYtcJvAYIEgePhUyAUTXqb8mZu+yXrlct8QpQe3wUJ8sjkaO+BCCa0XiWRzhWMw8vOad0Dub/ykZjAdUGqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787996551; c=relaxed/simple;
	bh=3WbhTlNcJF4Yk2bK6YGrhO8Fs4z46ZUw0CdTxeyPOtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dl/V85q7nNNydfjtPp58oJCNNs4npJfyZZodt/m/RTgEYZf1xdSXG8wQAV+LLOiQiUDI2cUFXAMxypAaXUOZ/QDlUT7q6BEp2DiLnDR0PKw92DPJ8pcAs6Qa3ud/VBYGoL1derHCDVkreatU79w6OJloEF7K6UI4JrqRY8yGp/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IdTPy6eq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IdTPy6eq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TizvrXAhEHBgBs5wwOnXkKk/lvWUZcIhQIwsSoolUC8=; b=IdTPy6eqeIEkdPcfi56nkxrNRk
	+2mUyic5oteUWH5V+/VVV7pyaDFYJoto/5mmnUUBCBzl4gZM8ukQelPdkr6oSrxWYjp4MQYn5F+L/
	+lFYv2R49ln+rv12HXqsbs2t4kgbM0Xg+dkrxGCsLApgkcweikqMDQbMzXT7pmNgImdfQzDq5FdJZ
	MI06PYe6hqS0/xXcdZecQSWEeF7twdbjiJeClv77BgXIyt76zGPVqKo7g8HOb/+MHeJAKV7ywKDty
	q3tEpvOZm+mXlkxUAO+kHFLUNb2buCjSwhXFNgXw/yS0u++LQuNEkRFnr7fJfZsmHzwcQcFRPzB0o
	W80UKoHg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0FZg-0000000GHap-2J8Q;
	Sat, 29 Aug 2026 09:42:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F2DCE300382; Sat, 29 Aug 2026 11:42:07 +0200 (CEST)
Date: Sat, 29 Aug 2026 11:42:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Yuanhe Shu <xiangzao@linux.alibaba.com>
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	xin@zytor.com, luto@kernel.org, jpoimboe@kernel.org,
	rostedt@goodmis.org, akpm@linux-foundation.org,
	rdunlap@infradead.org, elver@google.com, andreyknvl@gmail.com,
	glider@google.com, gor@linux.ibm.com, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/fred: Fix stack depot filtering of FRED event
 stacks
Message-ID: <20260829094207.GD776954@noisy.programming.kicks-ass.net>
References: <20260827150022.1618235-1-xiangzao@linux.alibaba.com>
 <20260827150022.1618235-3-xiangzao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827150022.1618235-3-xiangzao@linux.alibaba.com>

On Thu, Aug 27, 2026 at 11:00:22PM +0800, Yuanhe Shu wrote:

> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 15fd9ec5ecac..78b8eb4a925f 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -555,6 +555,7 @@ config X86_CPU_RESCTRL_INTEL_AET
>  config X86_FRED
>  	bool "Flexible Return and Event Delivery"
>  	depends on X86_64
> +	select ARCH_HAS_IN_IRQENTRY_TEXT
>  	help
>  	  When enabled, use Flexible Return and Event Delivery
>  	  instead of the legacy SYSCALL/SYSENTER/IDT architecture for

I'm not sold on this being a CONFIG symbol, we have far too many of
those. We have many other patterns that might work here.

A common one for example is:

#ifndef arch_in_irqentry_text
static inline bool arch_in_irqentry_text(unsigned long addr) { return false; }
#endif

And then have the arch/x86/include/asm/ header do:

#define arch_in_irqentry_text arch_in_irqentry_text.

> diff --git a/arch/x86/entry/entry_64_fred.S b/arch/x86/entry/entry_64_fred.S
> index b98f8945dfff..620def9039a3 100644
> --- a/arch/x86/entry/entry_64_fred.S
> +++ b/arch/x86/entry/entry_64_fred.S
> @@ -36,6 +36,17 @@
>   */
>  	.align 4096
>  
> +/*
> + * Bounds of the FRED event entry text.  Every event delivered by FRED
> + * enters here, including events which the core entry code forwards
> + * through asm_fred_entry_from_kvm().  This is the FRED counterpart of
> + * __irqentry_text_start..__irqentry_text_end and lets
> + * in_irqentry_text() find the event entry point of a stack, see
> + * arch_in_irqentry_text().
> + */
> +	.globl __fred_entry_text_start
> +__fred_entry_text_start:
> +
>  SYM_CODE_START_NOALIGN(asm_fred_entrypoint_user)
>  	FRED_ENTER
>  	call	fred_entry_from_user
> @@ -150,3 +161,6 @@ SYM_FUNC_START(asm_fred_entry_from_kvm)
>  
>  SYM_FUNC_END(asm_fred_entry_from_kvm)
>  #endif
> +
> +	.globl __fred_entry_text_end
> +__fred_entry_text_end:
> diff --git a/arch/x86/include/asm/sections.h b/arch/x86/include/asm/sections.h
> index 30e8ee7006f9..1b52239fcefd 100644
> --- a/arch/x86/include/asm/sections.h
> +++ b/arch/x86/include/asm/sections.h
> @@ -5,6 +5,7 @@
>  #include <asm-generic/sections.h>
>  #include <asm/extable.h>
>  
> +extern char __fred_entry_text_start[], __fred_entry_text_end[];
>  extern char __relocate_kernel_start[], __relocate_kernel_end[];
>  extern char __brk_base[], __brk_limit[];
>  extern char __end_rodata_aligned[];
> diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
> index ee117fcf46ed..4af7e52d9d97 100644
> --- a/arch/x86/kernel/stacktrace.c
> +++ b/arch/x86/kernel/stacktrace.c
> @@ -9,6 +9,7 @@
>  #include <linux/stacktrace.h>
>  #include <linux/export.h>
>  #include <linux/uaccess.h>
> +#include <asm/sections.h>
>  #include <asm/stacktrace.h>
>  #include <asm/unwind.h>
>  
> @@ -128,3 +129,15 @@ void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
>  	}
>  }
>  
> +#ifdef CONFIG_X86_FRED
> +bool arch_in_irqentry_text(unsigned long addr)
> +{
> +	/*
> +	 * FRED delivers events to entry points in .noinstr.text, which
> +	 * __irqentry_text_start..__irqentry_text_end does not cover.  See
> +	 * __fred_entry_text_start in entry_64_fred.S.
> +	 */
> +	return addr >= (unsigned long)__fred_entry_text_start &&
> +	       addr < (unsigned long)__fred_entry_text_end;
> +}
> +#endif

This is all confusing at best. __fred_entry_text covers all entries, it
cannot distinguish between irqentry and syscall. Why is that not a
problem?


