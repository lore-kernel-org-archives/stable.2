Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27A03CE4B5
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 11:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786015320; cv=none; b=Mxo7lFTBqi+m7UP3cCaR0ZNgAx2KEpioRx9KRA6fLWuoa7zDJeSAalbxtT2x7B1xIdnlE0U6IqYQvR6tORxd7qNDxBXbheCBwa4P+v87zpI144wnMthVq6SHR80sM8ICuFuwR21d8yFA38J3wWCJp5jUgwdPE3sZ+ir3FdA40HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786015320; c=relaxed/simple;
	bh=NxvDQNUaxLdXEBOORglSp9h3tEgNpMWW3m9cpoWPstw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shMfarn5o7OWIrCenFLhEwtR7Z2i+muO/Jc/7j5JHrmX806fFKcEotK2P8PFeTSkqOq/1Wj2DvzHNsv07bK/3BcxvF2ncZDdcbyP5LJi8F+hnSw8IkG9UeNbMLtf4JbUTO2tF8sR1UjLncPhNJr9EsCWyGDI1+FZMeeKIy3UPuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ge6pnxV1; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ge6pnxV1"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90784153B;
	Thu,  6 Aug 2026 04:21:52 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E4753F66F;
	Thu,  6 Aug 2026 04:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786015316; bh=NxvDQNUaxLdXEBOORglSp9h3tEgNpMWW3m9cpoWPstw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ge6pnxV1Fubr8Qf/BlaxjwFA9FcvmWmwAOcMjbmy/xhWZznGrFdl2G8X+S9wNbJzm
	 TNGnyKVyombig3MpytVxqOG7/D4ybXCWFfUgY1RZ4RgxViO9f3/Vt8Gtql6RWD9nSR
	 E9svhYLwwPHhMkHcaOLXXIZEoJNpmf86rg5JYf6Y=
Date: Thu, 6 Aug 2026 12:21:51 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, ada.coupriediaz@arm.com,
	ardb@kernel.org, catalin.marinas@arm.com, cl@gentwo.org,
	david.laight.linux@gmail.com, james.morse@arm.com, ljs@kernel.org,
	maz@kernel.org, peterz@infradead.org, ruanjinjie@huawei.com,
	ryan.roberts@arm.com, stable@vger.kernel.org,
	vladimir.murzin@arm.com, will@kernel.org,
	yang@os.amperecomputing.com
Subject: Re: [PATCH v2 13/20] arm64: percpu: Add infrastructure for
 preemptible this_cpu_*() ops
Message-ID: <anRuT1Psmar9mW5L@J2N7QTR9R3>
References: <20260804170503.3513916-1-mark.rutland@arm.com>
 <20260804170503.3513916-14-mark.rutland@arm.com>
 <7df18d5e-886e-43d1-b53d-52a1d08aba49@kernel.org>
 <d600d0db-5109-4386-9a49-955be74cc432@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d600d0db-5109-4386-9a49-955be74cc432@kernel.org>

On Wed, Aug 05, 2026 at 08:47:08AM +0200, David Hildenbrand (Arm) wrote:
> On 8/5/26 08:45, David Hildenbrand (Arm) wrote:
> >> Atop v7.2-rc4, with GCC 15.2.0 and defconfig, this is compiled as:
> >>
> >> | <outline_this_cpu_add_u64>:
> >> |        paciasp
> >> |        stp     x29, x30, [sp, #-16]!
> >> |        mrs     x2, sp_el0
> >> |        mov     x29, sp
> >> |        ldr     w3, [x2, #8]
> >> |        add     w3, w3, #0x1
> >> |        str     w3, [x2, #8]
> >> |        mrs     x3, tpidr_el1
> >> |        add     x0, x0, x3
> >> | 1:     ldxr    x5, [x0]
> >> |        add     x5, x5, x1
> >> |        stxr    w4, x5, [x0]
> >> |        cbnz    w4, 1b
> >> |        ldr     x0, [x2, #8]
> >> |        sub     x0, x0, #0x1
> >> |        str     w0, [x2, #8]
> >> |        cbz     x0, 2f
> >> |        ldr     x0, [x2, #8]
> >> |        cbnz    x0, 3f
> >> | 2:     bl      preempt_schedule_notrace
> >> | 3:     ldp     x29, x30, [sp], #16
> >> |        autiasp
> >> |        ret
> > 
> > FWIW, in a recent discussion on some prototype hacking [1] we saw some overhead
> > in micro-benchmarks that would really hammer on a path that would now do a
> > preempt_disable()+preempt_enable().
> > 
> > Switching from preempt_disable() to preempt_enable_no_resched() made it turn to
> > noise. Of course, that has other undesirable impacts, and I am not sure if we
> > are in the territory of code layout changes affecting the numbers.
> > 
> > Just mentioning it as some data point.
> 
> [1] https://lore.kernel.org/linux-mm/20260630174852-mutt-send-email-mst@kernel.org/

Thanks for the pointer.

IIUC in those cases you're using preempt_disable() .. preempt_enable()
directly, not this_cpu_*(), right?

If so, patches 5 and 6 of this series [2,3] might have an impact, but I
wouldn't expect a significant change unless you're calling
preempt_enable a lot.

Please beware that it's not safe to use preempt_enable_no_resched()
UNLESS it is immediately followed by a call to schedule(). That's not
documented today (and I couldn't find a good reference), so more folk
are likely to be tempted to use it...

I'll send a patch to clarify that (or at least start the discussion with
scheduler/preempt folk).

Mark.

[2] https://lore.kernel.org/linux-arm-kernel/20260804170503.3513916-6-mark.rutland@arm.com/
[3] https://lore.kernel.org/linux-arm-kernel/20260804170503.3513916-7-mark.rutland@arm.com/
