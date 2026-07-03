Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DDF2F3622;
	Fri,  3 Jul 2026 08:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783069196; cv=none; b=s+rMaCrkeBNakdpkATJvgt5jgYf81LHxtc1y5asNzdvobU+x9Lb0lz+g2qol6dkLzH7zj+rQr6df0s8xvo3Qw2RpayoSo0BXFZyeNPChmA3uucbF5R/311FeAxPqlBPHSzk96D+yDZ2C7sX0Fgx6urumxw4QQh4tE6h9fx4uKfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783069196; c=relaxed/simple;
	bh=ArxNuhsV39DcuOHPL8HguLPPdxicz93aKTFRes9110A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EmGPStdkLgoFYSCCub9ayI10O4L6IVzhbQgB28z5pLyybC+Ypi2zeogCC2jp8MFic/mZfJxEC+AEVIC+b7FUmoqmXv26UTMt5gsxDNl7rulTllZzjwslFSSqnGWJnwLMCfZc2+yvz+zdci1bh9yh4i7h7VsiTDoUAKD9sV+8bgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=JHhH5n1J; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JHhH5n1J"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E91001684;
	Fri,  3 Jul 2026 01:59:43 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DADDB3F905;
	Fri,  3 Jul 2026 01:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783069188; bh=ArxNuhsV39DcuOHPL8HguLPPdxicz93aKTFRes9110A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JHhH5n1Jsgre31CxsoUhig0gdvKRnUF1wE11oMoxGleTt/bYr2cYdcNL4YkNqqXqa
	 VxVbMJ+NnGsJuErudYorxueu1o93h/sUaAZCj4ladyiVYxFOIKgR8HCkrqaNVLXigx
	 n3Jtr+oMjEZrbJ5cnoc5WHZhJgFnNyMMNFdjzYzQ=
Date: Fri, 3 Jul 2026 09:59:40 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>,
	Nathan Chancellor <nathan@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Kees Cook <kees@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, slipher <slipher@protonmail.com>
Subject: Re: [PATCH v2] RFC: ARM: breakpoint: CFI breakpoints only on demand
Message-ID: <akd5_G5oA2dxdg89@J2N7QTR9R3>
References: <20260701-arm32-cfi-bug-v2-1-9bf922593e00@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701-arm32-cfi-bug-v2-1-9bf922593e00@kernel.org>

On Wed, Jul 01, 2026 at 09:11:54AM +0200, Linus Walleij wrote:
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
> users might want to select for their kernel.

I don't follow this part. CONFIG_CFI is for the kernel; it has nothing
to do with what userspace wnats to do.

AFAICT, when the kernel is built with CONFIG_CFI, if userspace uses BKPT
at all, for any reason, it can cause the kernel to die().

> If this is not good acceptable we need to think about other ways for
> CFI to interfer, such as not using BKPT at all (rather something like
> BUG()) and back out the offending patch until the compiler behaviour
> has changed.

See comments below.

> Fixes: c3f89986fde7 ("ARM: 9391/2: hw_breakpoint: Handle CFI breakpoints")
> Reported-by: slipher <slipher@protonmail.com>
> Closes: https://lore.kernel.org/lkml/kJqktbpLphg_Pk5I5SPptgTLjl3E3eq5mN5UzCslyFj7Q1Irp-wDid4mj5eQVd2iZtRGXgeZd8goq195EkXdjyt864YMc8mVb2B9NGH91NQ=@protonmail.com/
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
> Trying to solve the CFI bug. Let's see of this first
> approach is acceptable for the reporter.
> ---
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

AFAICT, hw_breakpoint_cfi_handler() is only intended to handle
BKPT instructions executed in kernel mode, and even when the kernel is
build with CF support, it doesn't make sense to call that for BKPT
instructions executed in user mode.

On arm64, we have separate paths for BRK exceptions from user mode
(do_el0_brk64()) and kernel mode (do_el1_brk64()).

Surely you can check kernel_mode(regs) or user_mode(regs) to distinguish
the two cases, and only call hw_breakpoint_cfi_handler() when the
exception was taken from kernel mode?

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
