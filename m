Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CEF19D092;
	Fri, 19 Jun 2026 23:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781913295; cv=none; b=afIdoAz/yuAhUq1DHxtmTHiwhgoL/P5WkxSKJSh2nZK3WcE2VeagMVNCpXPo0VFlUQRe/T5IHkA12uDxAm+7gLG1KCigiZOgtCipWi/BVnFkW5eSvVcalkdFnKy/2kjQbbBLOiwnTF8+5plF3nDIyrFxF0pKPIy4G8hk4xNobNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781913295; c=relaxed/simple;
	bh=4uDAlJGIuj1sxAgSiHnZekE5owd/QoOV8Dk33leZ13Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+TblBg3dtQjAhl+JHFhZndGgVntqh4WyEgbOxJDTqY0bGa50eXp9jlfxiC9zJMoe6GkZVCv5qAbsEEj8d0d9kaULSGehRT66KKBfEQzqfRFOsD+K2hPSj4OpBrmr6fT7daGkLXL5m/YBvsT7Q6vhateHqt0MRbHklbYkffYSgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFSFWYrM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFSFWYrM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6ED1F000E9;
	Fri, 19 Jun 2026 23:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781913293;
	bh=T2U6mD5Mi888Hcm8xp1sqPPOMOUnXskbr2jM/AcqYN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MFSFWYrMI30DpGUYSviB3mF0oMxLpUDKjrBft2OtFxA5uWy0f01420l8cek0mMKZm
	 SPBoIfC1iKg02qhAv6VtWy2neMROUeTEPxOE3SLlr/WZ/N7wgLVl910xr3NObOx+Ub
	 8vT92jPm0m5RzKdtlZM++nW7awockcRqxBZlg4s03nT1z3hwSSje+94MrTRPc6yDAV
	 xutiuMxLRaImQGCgxbm0wP5QbIsg2dcQAapoHOGx2j8FYUuGxtQwgYEzT/AnVSKtme
	 uhaMtdDBzVia1xtMuLlxV5mfVa/ZLQ3XAZTTOnxcYeBjYqLv/5Ixk1+duLPC0tHkeR
	 pKwQXvtH2vAKw==
Date: Fri, 19 Jun 2026 16:54:53 -0700
From: Kees Cook <kees@kernel.org>
To: guoren@kernel.org
Cc: arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
	peterz@infradead.org, luto@kernel.org, conor.dooley@microchip.com,
	heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
	falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
	atishp@atishpatra.org, mark.rutland@arm.com, bjorn@kernel.org,
	palmer@dabbelt.com, bjorn@rivosinc.com, daniel.thompson@linaro.org,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, stable@vger.kernel.org,
	Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] riscv: entry: Fixup do_trap_break from kernel side
Message-ID: <202606191652.38297DE51@keescook>
References: <20230702025708.784106-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230702025708.784106-1-guoren@kernel.org>

*thread encromancy*

On Sat, Jul 01, 2023 at 10:57:07PM -0400, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> The irqentry_nmi_enter/exit would force the current context into in_interrupt.
> That would trigger the kernel to dead panic, but the kdb still needs "ebreak" to
> debug the kernel.
> 
> Move irqentry_nmi_enter/exit to exception_enter/exit could correct handle_break
> of the kernel side.
> 
> Before the fixup:
> $echo BUG > /sys/kernel/debug/provoke-crash/DIRECT
>   lkdtm: Performing direct entry BUG
>   ------------[ cut here ]------------
>   kernel BUG at drivers/misc/lkdtm/bugs.c:78!
> [...]
>   Kernel panic - not syncing: Aiee, killing interrupt handler!

This appears to still be unfixed. What's the blocker? The solutions in
this thread seem to work...

I'd like to be exercising an Oops path via KUnit (for KCFI), and riscv
just instantly falls over instead of thread-killing on the exception.

Thanks!

-Kees

-- 
Kees Cook
