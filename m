Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390C1217F27;
	Tue,  7 Jul 2026 06:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783404622; cv=none; b=emSa5dNHopU4xUqiO3m40n+DKGhoKK3nqqUG3Tgs2w8A854UtH9GHNilrQBSTpBB4R2/t+n28Vg0GC3ptOFTfbmPbYZFrGE2QDh/Cp7vhKN0k+mJy4R6kPQT0uguJFgOIgUnOkCydMr54UhpuKgRo9D64OEMd9dzdVelVx9wXEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783404622; c=relaxed/simple;
	bh=EqpZfHi1bCaqP6NL8EAd2N5fLRl5b9vzswnYHDcYwUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kg1qBm7GyApo7K7VOBmabUKRSxHX3Lh4PjMrWqbIDsb3gFAcFk1a6WmWs9rwAdDKyzIZu4GIRhASXZh+vdR95KYa+5lMfYW+tVdJrOhARK9O1P1kH+pbBBqJP7SeK74IRUz/9y8vjIkCbFexvdu/3Kv2/skCymrDFRlRyOL6r9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZwmlMDRN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sy2kZwDT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZwmlMDRN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sy2kZwDT"
Date: Tue, 7 Jul 2026 08:10:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783404619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0G9aukPV8pHjfG+rgqcQ/xQgpRWVh1vDYEUguo9B9Ag=;
	b=ZwmlMDRN9xRHfKOH5ruRR1URwK7dGw9QLIo/Qh0p5RPvQiLOMmbvkJHa+C1B/tAF1xi7OC
	20fO60M/VWCv1vtHjBCf52h+pqyXJ/5toDs0w07W0z7YpSyhRmEM7KkA9HwCNBcHKApK4C
	etG9k7ICTkBGR0zg3mNq6YQUUwfkDdeJNuOs4AccYHNfqIwn9AGL52TPKzdDXInSOBTIqM
	RGQ64SNvm57vbngaxCUM6O/xCVcLxboCaXCd1W91xOKwLtpxLRdQ1si92oJOAaCUZkUBPu
	gV6Jbb5haelguk1Q8vJfZT/rdvFonH4uvUAVlR64Uyfm8uV8lc1n/ROAtmc7qA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783404619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0G9aukPV8pHjfG+rgqcQ/xQgpRWVh1vDYEUguo9B9Ag=;
	b=sy2kZwDTxAMLzqOr8h49dlNPDrKsyK/x6j4NGuclLiX5Jz+hKAwucdCw92/wYzD7GQORNZ
	iQTynay+/hT3JeAA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Conor Dooley <conor.dooley@microchip.com>, Wende Tan <twd2.me@gmail.com>, 
	Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Nam Cao <namcao@linutronix.de>, kernel test robot <lkp@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] riscv: vdso: Do not use LTO for the vDSO
Message-ID: <20260707080753-4e88aca1-b88d-4f6c-b37a-f7f3064bda5e@linutronix.de>
References: <20260701-riscv-vdso-lto-v1-0-89db0cd82077@linutronix.de>
 <20260701-riscv-vdso-lto-v1-1-89db0cd82077@linutronix.de>
 <20260706210158.GA73349@ax162>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260706210158.GA73349@ax162>

On Mon, Jul 06, 2026 at 02:01:58PM -0700, Nathan Chancellor wrote:
> On Wed, Jul 01, 2026 at 11:21:22AM +0200, Thomas Weiﬂschuh wrote:
> > With LTO enabled the compiler assumes that the vDSO functions are not
> > used and optimizes them away completely. Currently this happens to
> > __vdso_clock_getres(), __vdso_clock_gettime(), __vdso_getrandom(),
> > __vdso_gettimeofday() and __vdso_riscv_hwprobe().
> > 
> > Disable LTO for the vDSO, as these functions are hand-optimized anyways.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202606301855.WvkSC4kD-lkp@intel.com/
> 
> While this change seems correct, is this really the fix for that report?
> It seems like that error happens in clang but I would expect this sort
> of issue to only appear once LTO has run through ld.lld?

At this point the vDSO userspace library has already run through ld.lld.
That has optimized away the futex symbols, which means their offsets are not
defined when building the regular vDSO *kernel* code.

> > Fixes: 021d23428bdb ("RISC-V: build: Allow LTO to be selected")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > ---
> >  arch/riscv/kernel/vdso/Makefile | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
> > index a842dc034571..43ee881f6c6f 100644
> > --- a/arch/riscv/kernel/vdso/Makefile
> > +++ b/arch/riscv/kernel/vdso/Makefile
> > @@ -69,9 +69,9 @@ CPPFLAGS_$(vdso_lds) += -DHAS_VGETTIMEOFDAY
> >  endif
> >  
> >  # Disable -pg to prevent insert call site
> > -CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS)
> > -CFLAGS_REMOVE_getrandom.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS)
> > -CFLAGS_REMOVE_hwprobe.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS)
> > +CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS) $(CC_FLAGS_LTO)
> > +CFLAGS_REMOVE_getrandom.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS) $(CC_FLAGS_LTO)
> > +CFLAGS_REMOVE_hwprobe.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS) $(CC_FLAGS_LTO)
> >  
> >  # Force dependency
> >  $(obj)/$(vdso_o): $(obj)/$(vdso_so)
> > 
> > -- 
> > 2.55.0
> > 
> 
> -- 
> Cheers,
> Nathan
