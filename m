Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795615248;
	b=ibiHCOHkPN/Zj187uRV/KXzfXoEseqxxrE6CNnD1trmKKljSTqjyPoGPkvo35SlT1wgZ
	 0TH0ZpwZ5KS/mJktVHiU3cRHS4EW1GFaAXFKahPL2PK2POMpI5s7Y2KYlAswq4uZgQF0y
	 pkQqdBcSrL9PfDYEnz/SDsDzdbAowO7Sf26mlbZbTWCuSv5B7J47+j66Fycr2A6ZUMpgC
	 LuTii/SAvSex29Tqxch0w2IGyi3Ja+jmOGVGYn5SPtYpd1k9R264V/Gox+fLIM53OS4zB
	 1UvgZ2JOybfyK4Z7pkhr+c55lEB5/LK2/u96cUbpW+ZRVpsHUMEw6bKc6+ixKt1JMCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795615248;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Z0bHnKY18Sj6WcXxQyinu2JH9QaCsosfzwkAijHIYb4=;
	b=c5C2/VmOMPulCUYL2Bk4xLIS4YWlkiyzvwkqBY2fS8qTsbQ9IwlDJRSw9/iIeTcuoDZ7
	 JSbSOROrXBKW/v0UoQzSmY7ebkhLx4fVdb+S0o3YYc5htRs51k7IagsDPu11ap0+m2/we
	 uRM1ao2DXtajacCW/1xaeMzokupQEmHPDL0XevuYDGI5tQM1W0JmWsOTIRQhsmwjR3gz4
	 mzV9l01tqFG51KhWOiPVBYFgoVlppYjvqLjPGJptI+DT6McKNdN+jcWw7yoi869gz+R8f
	 hQgBWH8nMl6kjJ+1m6e+jbA6RiCeq0XM8ahOLHAflp8V3azFzRygCQpQqXueLE857kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UbWI4eZe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC18606A32D
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UbWI4eZe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B241F000D3;
	Wed, 25 Nov 2026 14:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795615248;
	bh=Z0bHnKY18Sj6WcXxQyinu2JH9QaCsosfzwkAijHIYb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UbWI4eZeRteujIZd5MPk06V94cl1sNONzrM0toh6SKwb7AwYFjj8MtCdX3pZaD416
	 R88GcU8SpSfviZfMXfm964s5ba1erNPxBTEXZbaDo6XworvzdEfUd3vYk24/L/qi+g
	 TuZ7PM7WMT6rcWlOhGenYOvFvykt+W+OO7LJIApiWJIFsPmUqcmzMVWVv44ufA3rky
	 tLYAmePdpmENS2V/EiZ/5oBd8ZMtDO1rjL8ppIoSpPIAipadH9QGe/ePaCldERRDOo
	 nqAiz9axllYYwC/MU5rHKU0N7dFXDsnv3p6DgG8PEJqOWqv64KlKq7jY+tqOtp7jv6
	 y5tIZ03Jfw3fA==
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfauth.ams.internal (Postfix) with ESMTP id 82BF71980047;
	Wed, 25 Nov 2026 09:00:42 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 25 Nov 2026 09:00:45 -0500
X-ME-Sender: <xms:CeoGa2sbyq-knPaAr3polUCbTbAfusbSEbQkIuv3RGnGMDeE4I0IpA>
    <xme:CeoGa5XUKPcBCJPbEyYstOF2hF5CZuHf8u0_gDMsgSIBKBgaSp8f4AMl65r0kymk4
    6IpJz6zjcIMAjwll9tB_wwZqtlLcCs9sI-2RPpw8cu5Pqt0zY_kZDLI>
X-ME-Received: <xmr:CeoGa63VkcYmI44d81-pIkWLwEJV3_2mriNLyrNKXgF5TBl-s4g4hEvoXsA>
X-ME-Proxy-Cause: dmFkZTE1O4eBS6dBEH9F3C68qqyjyJ1vnOzgFGQ7e1lDYlMXiP0Bqwgudxue3EzhshTdfZ
    wxdOsHNh21Us4t2qr8NIs2D82OWq8GrNR1+ApgjQnugMMUoOefB61JIxFry+YnlrEEPH0k
    1lulqQ/KbfKwP3+h1Eq7NvvIazNhJ+RPZPqAUo6W6yvezRDAuG1Y9F4WydegAGsGXmWudY
    uU/N0qF8rm1u8E23C3PBv/eYYSy65rIJIibXjAFAeda30En8uHkgplstM2XZioKLBowZJu
    OQY/fboU+VsjF9UxxOTbEw3f2yad/ggXJ3hOpEq6coiUonOsSwIgZaZ/EJfocaRDTuU9B2
    bpLH5GD503xlV1pw+X3TwoVttniLzFa5tkg/BlSGvpUUmV95buRKk+ZEFQkeCc6gNdHDR9
    cZknIrGoR1hZBn+WTQ4ax3Cm/YYmBNK6WUDb2wLj/L4AojiXVzVUGY9OlSme68dHnVCJPC
    EBZDvP5pgx4DOZIu8Pcv3syC6zvvEJQ++fneb7YiYAACWex4c8LaUOQ8NOxhFFt+6aqcCQ
    ara+dxH+3HxYKIl4QBtspz+zZnTvm4tdjBZMgMgZS92PFHfDbLm6/QNtlRk3cKCE/HMKfa
    vRoeL7e0y6AjGDREEe0jC3Ar91Wm0pEXHArWXQP9hAdrsG4pq4nqvpDQTPig
X-ME-Proxy: <xmx:CeoGayfGny5F21riOaLOveSjwn-EJAzPaJzk4-vqnbHv7Pj2nN2sfg>
    <xmx:CuoGa_VqJrc_CqPIcNU_aqo4LWnmsfqTTBV008mUeuWEwrI1fvFrAA>
    <xmx:CuoGaw86kLMVxJ-7NBMr55J-FMvV0cQxvHDDazJAmckz17uJpjue6A>
    <xmx:CuoGa0ixiJ8Vgnu-6JNrddSNMUl08zogEhc0hAW983Iq7YrEfhFSpA>
    <xmx:CuoGa9VZt9XGvySBLdrZn4-zvJMAa5b6m1fu_TiYaJjV86Zb5hFoyQGY>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 09:00:41 -0500 (EST)
Date: Wed, 25 Nov 2026 14:00:40 +0000
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: YinFengwei <fengwei_yin@linux.alibaba.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	James Morse <james.morse@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Vladimir Murzin <vladimir.murzin@arm.com>, Ada Couprie Diaz <ada.coupriediaz@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Liao Chang <liaochang1@huawei.com>, Ashok Raj <ashok.raj@oss.qualcomm.com>, 
	Doug Anderson <dianders@chromium.org>, Pengjie Zhang <zhangpengjie2@huawei.com>, 
	Cong Wang <cwang@multikernel.io>, kernel-team@meta.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] firmware: arm_sdei: Do not signal event 0 to a
 masked PE
Message-ID: <awblcOnI8JVhpmPK@shutemov.name>
References: <20261124194707.1030653-1-kas@kernel.org>
 <20261124194707.1030653-2-kas@kernel.org>
 <awavUsKX4XLRMbUq@U-V2QX163P-2032.local>
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
In-Reply-To: <awavUsKX4XLRMbUq@U-V2QX163P-2032.local>

On Wed, Nov 25, 2026 at 05:50:10PM +0800, YinFengwei wrote:
> Hi Kirill,
> 
> On Tue, Nov 24, 2026 at 07:47:04PM +0000, Kiryl Shutsemau (Meta) wrote:
> > The SDEI NMI backtrace signals event 0 to every other CPU, idle ones
> <snip>
> > +static void sdei_block_signal(void)
> > +{
> > +	struct sdei_pe *pe = this_cpu_ptr(&sdei_pe);
> > +	unsigned long flags;
> > +
> > +	/*
> > +	 * A panic from an SDEI event or a pseudo-NMI may have left the lock
> > +	 * held by this CPU. The CPUs that could signal it are stopped by now.
> > +	 */
> > +	if (panic_on_this_cpu()) {
> > +		WRITE_ONCE(pe->unmasked, false);
> If the panic didn't take the lock, should lock be taken
> just like "else" path?

If another CPU holds it at this point, that CPU was stopped in the
middle of signalling this one, and it will never drop the lock. The
panic would hang on it.

If nobody holds it, there is nothing for it to keep out. This runs at
the end of smp_send_stop(), after the other CPUs have been stopped. A
sender stopped after it took the lock has either counted its signal,
which sdei_wait_in_flight() waits for, or never sent one.

Telling the two apart takes a trylock, and on failure we would go ahead
without the lock anyway.

> > +	} else {
> > +		raw_spin_lock_irqsave(&pe->lock, flags);
> > +		WRITE_ONCE(pe->unmasked, false);
> > +		raw_spin_unlock_irqrestore(&pe->lock, flags);
> > +	}
> > +
> > +	sdei_wait_in_flight(pe);
> > +}
> > +
> >  static int sdei_pm_notifier(struct notifier_block *nb, unsigned long action,
> >  			    void *data)
> >  {
> > +	struct sdei_pe *pe = this_cpu_ptr(&sdei_pe);
> >  	int rv;
> >  
> >  	WARN_ON_ONCE(preemptible());
> >  
> >  	switch (action) {
> >  	case CPU_PM_ENTER:
> > +		/*
> > +		 * Leave alone a PE that is masked already: before
> > +		 * sdei_cpuhp_up(), or after sdei_cpuhp_down(), as cpuidle runs
> > +		 * until CPU_OFF. CPU_PM_EXIT must not unmask it.
> > +		 */
> > +		if (!pe->unmasked)
> I am wondering whether READ_ONCE() should be used here?

No.

We read the flag of this CPU, and only this CPU writes pe->unmasked.
The notifier runs with IRQs off, so no store can race with this load.

What can still interrupt it, a stop or a panic from an SDEI event or a
pseudo-NMI, does not return here.

READ_ONCE()/WRITE_ONCE() are for sdei_event_signal(), which reads the
flag from another CPU.

Left plain, KCSAN will report it if that ever changes. See item 5 under
"Use of Plain C-Language Accesses" in
tools/memory-model/Documentation/access-marking.txt.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
