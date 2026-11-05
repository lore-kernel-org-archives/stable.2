Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793903874;
	b=aBERii3vRzZBQyyOJYdw/W1TPL4VqCkbCjsDnx/okxYRmvJ4F/n9O9rU70AEO8ul8Mk1
	 6rQPiOGndQ5mNKj8H2SbHr9jX+vP3eiGLmgn5B0pD3wRcVUNrqEPQOH8YC3Gx6NKnlxPv
	 oXLuc2tbDGvhLH3VtEPeceGPCaSfPyGcncKPG5xlLiBoYmS/ntwgTOSN4Nc87zU567Hzd
	 RvBWIcv+x+KeS6xwQ3cwHwzf2Jhig9ChrjIp7ZHmKDNQ8mpqLCFTFkka723cnFF92F+Z8
	 FLgaJQi22GepbUjdSoEeUZYg0CNS51NxyPzU/Vr7nFdjB+1sb010AdesHgQvhR++KXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793903874;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=42B23m+JIdyvXG0sW7UzXbkef8/A6+4jMboFfV5//zI=;
	b=bkoF+lyirnRTHtZLzZAZFL1x2SWu0vPiT/qy7iif7fZHYR0CiX0wnAfiMFJiRsUPx92I
	 ulq92p3BzWPLS3nJYkYiTK5jkYnZSUN8O4z8x31AoxEn2K88Mpod53n4SvtYNPcnAnrFH
	 YL0h8XxNwTrBuwczjjnv0f4JkpnDCVGTrLilPS6aTG3gnZNP9NGqwzf1EZzGYlpISbpRs
	 zC9tXotsv9P1XZ53Dq34+KDuvH+jO8dv4vkJgfZZXtS7Jts5rTMlPXj8KgKDxQLj2yC2U
	 JbT/Z8ERizrfhVeQhDTqn0hPADA1874YYsW8LqFeJ90lbqZVOEqe+P8K5CKh4JH5WiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=nifLGVmn;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3224606A31B;
	Thu,  5 Nov 2026 18:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3224606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=nifLGVmn
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCC64168F;
	Thu,  5 Nov 2026 10:37:49 -0800 (PST)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D67BD3F632;
	Thu,  5 Nov 2026 10:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793903872; bh=9Qhj0s746e4V1R4BU+HoKxTE/pluQc6iZNeXaD38eeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nifLGVmnqXYcirsAZF6IszdTwzH5oMaXh0Z+dSQ4QKp9pkzRNqjBRKUBp/25yWrCP
	 xU8XxQQj3RD6yqa54ohcJh44ntqKmEEcuQXhu0YHvBCN4CC/iPNCv97/T6KqwD1+Wf
	 0l8BtR9y/1prJ4J5hTD5yWGu2QSD3R6G3rPp7qo0=
Date: Thu, 5 Nov 2026 18:37:46 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	James Morse <james.morse@arm.com>,
	Usama Arif <usama.arif@linux.dev>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	Breno Leitao <leitao@debian.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Linus Walleij <linusw@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Huth <thuth@redhat.com>, Dawei Li <dawei.li@linux.dev>,
	mrigendrachaubey <mrigendra.chaubey@gmail.com>,
	kernel-team@meta.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arm64: sdei: Run the event handler on the kernel
 vectors
Message-ID: <auzM-l40BLsT3clg@arm.com>
References: <20261105120835.3321912-1-kirill@shutemov.name>
 <20261105120835.3321912-2-kirill@shutemov.name>
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
In-Reply-To: <20261105120835.3321912-2-kirill@shutemov.name>

On Thu, Nov 05, 2026 at 12:08:33PM +0000, Kiryl Shutsemau wrote:
> @@ -1065,10 +1067,27 @@ __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
>  	else if (cpu_has_pan())
>  		set_pstate_pan(0);
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

Sashiko had a comment that the above should be raw_cpu_read() since with
preempt debugging and pseudo-NMIs, irqs_disabled() is false here and the
check in __this_cpu_read() will warn.

Thinking about it, further down on the irqentry_nmi_enter() ->
lockdep_hardirqs_off() we'll hit the irqs_disabled() issue again. We
could just do a raw_local_irq_save/restore() around this function.
Unnecessary for DAIF but useful with pseudo-NMIs.

Alternatively, __sdei_asm_handler() could save/restore PMR and change
the priorities similar to the kernel_entry code. Actually, this may be
better since do_sdei_event() also checks regs_irqs_disabled() and we
don't have any regs->pmr populated.

Worth a separate patch to fix SDEI handling with pseudo-NMI on and no
changes to __this_cpu_read() above needed. So, for this patch:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

(I'll probably queue it for -rc but waiting to see if there are more
comments)

-- 
Catalin
