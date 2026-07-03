Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7625C1DDC3F;
	Fri,  3 Jul 2026 09:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783070858; cv=none; b=mzvF4ON/rD0AwECFeZYasl6VlzxTDHfyuUH1nBSSEtaFISdRN1rK8CnjVU7wYDrHvO433U79ST2cVRQdQz7FXgtBstpRRxfqXPpeaO2nc3gwkswy8xHmSjL1HNnVmcfAbDj5U4lRJCCDlXyf2Nu9uIF2R5ZzExPZhCtBRAErl1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783070858; c=relaxed/simple;
	bh=JvoU5nbICVMIWRHb0kIPGUpPkes8KJNpKqGQHTJwF10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnDdu1FZIHoFlFzEEJPNU4dHMXjRegCjW+M7vpykqJnqpCxFjT+929duPZ0mP4jL+TMb4Qpbu2LFWVJNxvKJZqqUbw+AjvXG9HxBK0ssW46EHd4qkF0dLLuglrfnSfZt3kpvwlpZ7PG8VzNx3Pkqu2wWQnRe0KAYVg1o8WOOh7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ikRQDQNa; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ikRQDQNa"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFE8F1EDB;
	Fri,  3 Jul 2026 02:27:27 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F0003F673;
	Fri,  3 Jul 2026 02:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783070852; bh=JvoU5nbICVMIWRHb0kIPGUpPkes8KJNpKqGQHTJwF10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ikRQDQNahGHiJFINP6/dnNmuIEPdANlrfpfBFrGxrRs/b4KK68wYKWhOXNc+EJNEa
	 vFWsp4D+IrAq/iI69qM2zxoeC9EXqgUPCoYNtcZ2cIZu8S4wc6UUpcRfTYT+KhIOPl
	 THZ9ggf4tGc+y83nvTHAdrGYDpeQhXtGYAoR248Q=
Date: Fri, 3 Jul 2026 10:27:28 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>,
	Nathan Chancellor <nathan@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Kees Cook <kees@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, slipher <slipher@protonmail.com>
Subject: Re: [PATCH v3] ARM: breakpoint: CFI breakpoints only on demand
Message-ID: <akeAgEBWyAshTI9H@J2N7QTR9R3>
References: <20260701-arm32-cfi-bug-v3-1-e3c37e2b80a4@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701-arm32-cfi-bug-v3-1-e3c37e2b80a4@kernel.org>

On Wed, Jul 01, 2026 at 12:42:09PM +0200, Linus Walleij wrote:
> This removes the stub hw_breakpoint_cfi_handler() from ARM, making
> it not steal breakpoint type 0x03 (ARM_ENTRY_CFI_BREAKPOINT) unless
> CFI is actively used in the kernel.
> 
> When not instrumenting with CFI, we fall through to return 1 from
> hw_breakpoint_pending() "unhandled fault" so userspace can make use
> of this breakpoint.
> 
> This of course does not work if userspace want to use CFI and custom
> breakpoints at the same time, and CONFIG_CFI does exist as something
> users might want to select for their kernel. If this is not good
> acceptable we need to think about other ways for CFI to interfer, such
> as not using BKPT at all (rather something like BUG()) and back out
> the offending patch until the compiler behaviour has changed.
> 
> Fixes: c3f89986fde7 ("ARM: 9391/2: hw_breakpoint: Handle CFI breakpoints")
> Reported-by: slipher <slipher@protonmail.com>
> Closes: https://lore.kernel.org/lkml/kJqktbpLphg_Pk5I5SPptgTLjl3E3eq5mN5UzCslyFj7Q1Irp-wDid4mj5eQVd2iZtRGXgeZd8goq195EkXdjyt864YMc8mVb2B9NGH91NQ=@protonmail.com/
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
> Trying to solve the CFI bug. Let's see of this first
> approach is acceptable for the reporter.
> ---
> Changes in v3:
> - Actually strip the RFC prefix...
> - Link to v2: https://patch.msgid.link/20260701-arm32-cfi-bug-v2-1-9bf922593e00@kernel.org
> 
> Changes in v2:
> - Resending as non-RFC so it can be applied as a band-aid.
> - Link to v1: https://patch.msgid.link/20260626-arm32-cfi-bug-v1-1-a467b5050c0b@kernel.org
> ---
>  arch/arm/kernel/hw_breakpoint.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
> index cd4b34c96e35..007023db6a5d 100644
> --- a/arch/arm/kernel/hw_breakpoint.c
> +++ b/arch/arm/kernel/hw_breakpoint.c
> @@ -929,10 +929,6 @@ static void hw_breakpoint_cfi_handler(struct pt_regs *regs)
>  		break;
>  	}
>  }
> -#else
> -static void hw_breakpoint_cfi_handler(struct pt_regs *regs)
> -{
> -}
>  #endif
>  
>  /*
> @@ -964,9 +960,11 @@ static int hw_breakpoint_pending(unsigned long addr, unsigned int fsr,
>  	case ARM_ENTRY_SYNC_WATCHPOINT:
>  		watchpoint_handler(addr, fsr, regs);
>  		break;
> +#ifdef CONFIG_CFI
>  	case ARM_ENTRY_CFI_BREAKPOINT:
>  		hw_breakpoint_cfi_handler(regs);
>  		break;
> +#endif

As commented on v2, I don't think this is the right fix.

I think you should look at which privilege level the exception was taken
from (e.g. useing user_mode(regs), such that a BKPT from user mode never
results in a call into hw_breakpoint_cfi_handler(), an can be treated as
unhandled.

That way the user mode behaviour would be consistent regardless of
CONFIG_CFI, and even when CONFIG_CFI=y, user mode cannot cause the
kernel to die() by executing a BKPT.

Mark.

>  	default:
>  		ret = 1; /* Unhandled fault. */
>  	}
> 
> ---
> base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
> change-id: 20260626-arm32-cfi-bug-10fb960749c4
> 
> Best regards,
> --  
> Linus Walleij <linusw@kernel.org>
> 
> 
