Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.188
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816929;
	b=3nH09Rn20OBmDbVhxjuANgwb7GZpU8pe15ijumA8sCN3/1ZJceHM5t8UTYW89m6y6Z06
	 hQDfiYsIDzRgF/E0dHFBO5cC56VuH5QZjHfyJM7Z6iP2ZuArgwozJB0f4mWEaU+DI7dqf
	 BzDVJ7BLje+qxDGnNIMPgeR6rs5iqA8dWs/91LihAFmjbWrdEm4w0Ijt3sQAtgeqlwzf8
	 1K2CHvI+uaZ0crUR2zlaBBMXVMnGsgpxAW9wtNwpZiEtcY83KhJEhcCfLtAypTNDHJDi9
	 T4ZgaTaIjsf6vof8Tvm+T6DWirX4+lv/ujSu0/Su57PJh2BbUblWEw3QXI3PG+bQlxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816929;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8AMRBsRaVVrjH9DufOp64hCzIFx64y5T91ZTRdXBHRQ=;
	b=sCQYndiwfMxK/0iA5QgWwX1EeBW91Yqx3mR2CLgF6Ek75sl+bot6JC1jLE+gnX3wD4Yy
	 sBVCT9D1snbB/fCRLtoUTyReD5qLKlzviyWUGiDlvPUziSjJM9/Hj+ujkPDT0iDv4ZMod
	 ES8q5G6A+XhSO8ay7X3N4OPeao64PmYV9F2NhS5gnOo5D9HtPgmZt0sPXsVx1r2ZWCEy/
	 gqdD00tbyck61LXjAjdTIS2k18V1z4u2SCv4ZtgMGtsqnvqkhGKzIKHbjwpW0DWeyXzru
	 Xzf+AlBj8V1mGiNBa8Up5oETq/8LLNRfxhQS8piF/N9oF1zhLk+rUk9cx9l8GLbrlzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=q4HJidW4;
	arc=none smtp.remote-ip=95.215.58.188
Received: from mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1ED4606A8C8
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:28:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1ED4606A8C8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=q4HJidW4
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=mrdhsCyYkgJCthcE9mwZdhKXoi0YwuzvcjVgzOgRLv8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793816925; v=1; x=1794421725;
 b=q4HJidW4HJrNqiFBIHcbsJipJ2hJej+ltF1PWamu0xne+Xed0E5vOFgrYxsiM7Mk/cLRO0Cd
 mQDxrG4cRPCdBoLfFjJAE1TL/NnuDUq0T1RrBM+K5gGsxUq+467GsBSKISbUQPXrkMyqMGtZkrm
 Hib/cFoyMAjhnXZA3vZKnplc=
X-Envelope-To: stable@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id fb19e5cc26c67389;
	Wed, 04 Nov 2026 18:28:45 +0000
X-Mizu-Trace-ID: fb19e5cc26c67389
X-Migadu-Flow: FLOW_OUT
From: Usama Arif <usama.arif@linux.dev>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: Usama Arif <usama.arif@linux.dev>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	James Morse <james.morse@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	Breno Leitao <leitao@debian.org>,
	Dawei Li <dawei.li@linux.dev>,
	mrigendrachaubey <mrigendra.chaubey@gmail.com>,
	kernel-team@meta.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: sdei: Run the event handler on the kernel vectors
Date: Wed,  4 Nov 2026 10:28:41 -0800
Message-ID: <20261104182842.3436759-1-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104180936.2981070-2-kas@kernel.org>
References: 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  4 Nov 2026 18:09:33 +0000 "Kiryl Shutsemau (Meta)" <kas@kernel.org> wrote:

> With KPTI, VBAR_EL1 holds the trampoline vectors from the return to EL0
> until the next exception from EL0 maps the kernel and installs the
> kernel vectors. The trampoline vectors only handle exceptions from EL0;
> their current-EL half is zero-filled.
> 
> An SDEI event is dispatched regardless of PSTATE.DAIF, so it lands there
> whenever the CPU is in user space. The SDEI entry trampoline maps the
> kernel but leaves VBAR_EL1 alone. An exception taken by the handler then
> executes the zeros, takes an undefined instruction exception to the same
> vector, and loops there forever. The event never completes and the CPU
> is lost; RCU stall reports are the first sign of it.
> 
> RAS notifications land in user space whenever a task consumes the
> error, and NMI backtraces land wherever the CPU happens to be. The GHES
> handler takes no exception on its own, but any exception in the handler
> path does it: a WARN, a kprobe hit, or a fault fixed up by a _nofault()
> accessor.
> 
> Install the kernel vectors in do_sdei_event() when VBAR_EL1 holds the
> trampoline vectors, and restore it before returning to firmware,
> including when the handler fails. The IRQ-like resume into user space
> keeps using the interrupted value, as it must go through the trampoline
> to map the kernel.
> 
> Fixes: 79e9aa59dc29 ("arm64: sdei: Add trampoline code for remapping the kernel")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> ---
>  arch/arm64/kernel/sdei.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
> index 778f2a1faac8..9fa2a3aeed48 100644
> --- a/arch/arm64/kernel/sdei.c
> +++ b/arch/arm64/kernel/sdei.c
> @@ -18,6 +18,7 @@
>  #include <asm/sections.h>
>  #include <asm/stacktrace.h>
>  #include <asm/sysreg.h>
> +#include <asm/vectors.h>
>  #include <asm/vmap_stack.h>
>  
>  unsigned long sdei_exit_mode;
> @@ -214,6 +215,20 @@ unsigned long __kprobes do_sdei_event(struct pt_regs *regs,
>  	if (arm64_kernel_unmapped_at_el0())
>  		clobbered_registers++;
>  
> +	/*
> +	 * With KPTI, VBAR_EL1 holds the trampoline vectors from the return to
> +	 * EL0 until the next exception from EL0 maps the kernel. They only
> +	 * handle exceptions from EL0: an exception taken by the handler would
> +	 * run their empty current-EL half and never come back. Run the handler
> +	 * on the kernel vectors. The IRQ-like resume below keeps using the
> +	 * interrupted VBAR, so it still goes through the trampoline.
> +	 */
> +	if (arm64_kernel_unmapped_at_el0() &&
> +	    vbar == (unsigned long)this_cpu_read(this_cpu_vector)) {
> +		write_sysreg((unsigned long)vectors, vbar_el1);
> +		isb();
> +	}
> +

Does this cover the whole path that can take an exception?  The
swap is done inside do_sdei_event(), but __sdei_handler() calls
irqentry_nmi_enter() before it and irqentry_nmi_exit() after it,
and both of those still run with the trampoline vectors in
VBAR_EL1 when the event interrupted user space.

Both can take an exception.  ct_nmi_enter() opens with
WARN_ON_ONCE(ct_nmi_nesting() < 0), and ct_nmi_exit() has
WARN_ON_ONCE(ct_nmi_nesting() <= 0) and
WARN_ON_ONCE(!rcu_is_watching_curr_cpu()).  A WARN is a BRK, so
either would run the zero filled current-EL half and lose the CPU
in the way the commit message describes.

Would doing the swap in __sdei_handler(), around the whole NMI
entry and exit pair, close that window?


>  	/* Retrieve the missing registers values */
>  	for (i = 0; i < clobbered_registers; i++) {
>  		/* from within the handler, this call always succeeds */
> @@ -221,8 +236,6 @@ unsigned long __kprobes do_sdei_event(struct pt_regs *regs,
>  	}
>  
>  	err = sdei_event_handler(regs, arg);
> -	if (err)
> -		return SDEI_EV_FAILED;
>  
>  	if (elr != read_sysreg(elr_el1)) {
>  		/*
> @@ -233,6 +246,11 @@ unsigned long __kprobes do_sdei_event(struct pt_regs *regs,
>  		pr_warn("unsafe: exception during handler\n");
>  	}
>  
> +	write_sysreg(vbar, vbar_el1);
> +
> +	if (err)
> +		return SDEI_EV_FAILED;
> +
>  	mode = regs->pstate & (PSR_MODE32_BIT | PSR_MODE_MASK);
>  
>  	/*
> -- 
> 2.54.0
> 
> 
