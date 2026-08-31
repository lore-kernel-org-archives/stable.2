Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E883D955C;
	Mon, 31 Aug 2026 09:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788166907; cv=none; b=jpVJ2JdHtVbK4fFtRjejRK6S6p8s/QL+zk5RXw9yjjqQOy4QHRPcdXBQr5+DXGo/mcysIQKKIWqaSENo9lHU98fJ8lxv7t3kzAIsPc6UhQxsHoRA6otWt3anXHcLEhL2GXtrlD0/OYsjtMd28086TlGSlpTDIVQY9EB23KUMasg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788166907; c=relaxed/simple;
	bh=rWW0Sd75RD7JLyjzzxHOtXUROgfiidBsWdfL7FvEpHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIqYPseFykdtGrC1Fvr0grJyE0sWjbzgPoRPdLHESjcsOHNssbjvJD/Q5dLmigLK88g02hCeLIHZn8axRvqcQADJcVsY57gPDgvTjsS7YR7pfuZ4aCGi8ge2jVa8sgpAD40X4PGbBwn/55qVfz3llIDO0/YlKWBj5sA7KYFTzJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d71Y5RCK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d71Y5RCK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OYRSOawd6vcTxwuQX4pDZjdCib09XYXK5IrwEcOAgjg=; b=d71Y5RCKgHgDhKWnoRtHnbuxeU
	Y9MmfELLPxRzGZ0j1u5tiFZg3rdvT7hoRdU9sGf+SXuFz1VrpwYwg1BtjWBCmH7aKGwovdDuGCC8m
	KxjALCk/4dZemIAEvKx9/l+0fumIVxXX+omCMoZGnvfd+LlsE2SsTkFNEEQfy+9OF+HlNdZOm2uma
	ukWqjsHXbyE+SqRLk/m5ZHwDlmuYwBsOi0yqdnyKlAuyy8mjdyO/yVJ4/buU6pkaPSvlzEQNCLO6Y
	Ahgvw0TbPMOBGqybopkkC0VisMk6rbq2cGgIjgOBi5FYF8QWUMmqjbW0em3dKadMqA6TZ85noh6nY
	yWTtzGbg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0xtN-00000002x3x-188S;
	Mon, 31 Aug 2026 09:01:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CE641300E7E; Mon, 31 Aug 2026 11:01:24 +0200 (CEST)
Date: Mon, 31 Aug 2026 11:01:24 +0200
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
Message-ID: <20260831090124.GH4120091@noisy.programming.kicks-ass.net>
References: <20260827150022.1618235-1-xiangzao@linux.alibaba.com>
 <20260827150022.1618235-3-xiangzao@linux.alibaba.com>
 <20260829094207.GD776954@noisy.programming.kicks-ass.net>
 <20260831085912.2485095-1-xiangzao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831085912.2485095-1-xiangzao@linux.alibaba.com>

On Mon, Aug 31, 2026 at 04:59:11PM +0800, Yuanhe Shu wrote:
> On Sat, Aug 29, 2026 at 11:42:07AM +0200, Peter Zijlstra wrote:
> > I'm not sold on this being a CONFIG symbol, we have far too many of
> > those. [...]
> 
> Fair enough - v2 uses your pattern and drops the Kconfig symbol.  The
> fallback goes next to its only user in kernel/stacktrace.c; putting it in
> linux/stacktrace.h would make that header pull in asm/sections.h.  x86
> defines the macro next to the markers it tests in asm/sections.h, which
> also gets rid of the arch/x86/kernel/stacktrace.c hunk.
> 
> > This is all confusing at best. __fred_entry_text covers all entries, it
> > cannot distinguish between irqentry and syscall. Why is that not a
> > problem?
> 
> It can't.  But the only consumer, filter_irq_stacks(), does not use the
> range to classify entries - it uses it to find where the event stack
> began, and cuts there.  For anything entered from ring 3 the entry frame
> is the outermost frame of the trace: the unwinder follows the pt_regs
> the entry pushed and stops there because user_mode(regs) is true
> (unwind_orc.c, "End-of-stack check for user tasks").  So the cut is a
> no-op: the syscall trace is stored whole, same as under the IDT, where
> entry_SYSCALL_64 sits outside the range.  An IRQ hitting a task
> mid-syscall cuts at the inner kernel entrypoint and drops the interrupted
> syscall frames, which is also what the IDT range does today at the
> asm_sysvec_* stub.
> 
> Only ring-0 events and the IRQ/NMI forwarded through
> asm_fred_entry_from_kvm() have an unrelated context below the entry
> frame, and those are the ones filling the depot.
> 
> The existing markers are not irq-only either: they wrap the whole
> asm/idtentry.h expansion, asm_exc_* stubs included, so this range means
> the same thing they do.  If you would rather it covered only the ring-0
> entry, moving the start marker to asm_fred_entrypoint_kernel (+256)
> makes no behavioural difference - I went with the whole block for
> symmetry with the IDT side, but have no preference either way.

I would still argue the function name is incorrect, and the user might
want a comment explaining this.
