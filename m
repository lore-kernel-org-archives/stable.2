Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EB52F3C19;
	Fri, 26 Jun 2026 15:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782488297; cv=none; b=M41gu+N7K10wPSY9M25cSdabKQLdC2joE+2Sh30KGtHg0B8fev1a+Y5/Nf+JPVepvjn6CFJvF9jrZMTQ3HwwjGb1+0pxC9+ryyT7nDRlFuA6F8K2MEyswQ8L4ofnAdo7Nm6jl3eSTIw4dWVC+v1mmVPrVoyTyA6K24xzKI3JE0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782488297; c=relaxed/simple;
	bh=NeXCoKuDCrshG1g9bcQ9YcGFTAKzOyKZCNufdciKCxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMe0Rh79XGOcqDgyBgNZZJBox+irZXX7DQ0szIIb2HiJZoX0gTAdIFbUW8Eb+6IKYymlqTIeIKtZ09enedA8Tvmb8DUwul1gspLEgZK1bO5nrRp+VbhG17rQHJ5Xg3smpwlsksouBEMYEGSpLDoctwqDbHVamrNAEbkfWsXt+Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Tu+45veW; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Tu+45veW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6YpByXEBWhbXWiSsknrsfNoYT0AoTQRyxzLLpnB+y/A=; b=Tu+45veWSCjjZuDd19I5ebk6Hb
	WzCWY5CJ981i7z5jHhcfFG20UThn7wNnwa8oadRVpw2Jkb2hkEmrWEmVYVgms6DOJrzoYqBENNXGG
	w3kRGW2jREQ+IhG+mrhdP1chMN0pb50M5tjkDbhaz/6kQJVjHU/EqHVUBsDxCuCDVQ8uAelk22omU
	joIBVDQYgfkUpgJjWm/qqWwgU4Pi3wlvv5c3v3Gkm3wyUp98BL2/9Q6S63VFew6dJxi6KdYOXed/e
	PZQtYcKhVHofXBXY8u019bk7Q+LMWA/d9R9rk2G+lXxE40P9wbGdNEdne+xhALbPjEc0m+kfwbcQg
	X+D7uPqQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48114)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wd8d2-000000002Os-3Pib;
	Fri, 26 Jun 2026 16:38:04 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wd8d0-0000000038o-33NE;
	Fri, 26 Jun 2026 16:38:02 +0100
Date: Fri, 26 Jun 2026 16:38:02 +0100
From: Russell King <linux@armlinux.org.uk>
To: David Laight <david.laight.linux@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, slipher <slipher@protonmail.com>,
	Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>
Subject: Re: [REGRESSION] 32-bit ARM's BKPT instruction no longer works
Message-ID: <aj6c2gW6h7xNwGnh@shell.armlinux.org.uk>
References: <kJqktbpLphg_Pk5I5SPptgTLjl3E3eq5mN5UzCslyFj7Q1Irp-wDid4mj5eQVd2iZtRGXgeZd8goq195EkXdjyt864YMc8mVb2B9NGH91NQ=@protonmail.com>
 <CAD++jL=YJGFf+9o8KV+OO_61EL+_z3b7P+eLK=6=r+GOuJiWAg@mail.gmail.com>
 <20260626145356.4183d8c5@pumpkin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260626145356.4183d8c5@pumpkin>
Sender: "Russell King,,," <linux@armlinux.org.uk>

On Fri, Jun 26, 2026 at 02:53:56PM +0100, David Laight wrote:
> On Fri, 26 Jun 2026 14:53:56 +0200
> Linus Walleij <linusw@kernel.org> wrote:
> 
> > [Adding Nathan and Kees so we can figure out how best to deal with this]
> > 
> > On Sun, Jun 21, 2026 at 9:15 PM slipher <slipher@protonmail.com> wrote:
> > 
> > > Consider the C program for 32-bit ARM architectures:
> > >
> > >
> > > int main() {
> > >         __asm__ __volatile__ ("BKPT");
> > >         return 0;
> > > }
> > >
> > > Expected behavior is that this raises SIGTRAP. Since Linux 6.10 this no
> > > longer happens; instead execution perpetually resumes at the same
> > > instruction, using 100% of CPU. It does not matter whether GDB is
> > > attached. I have tested with an armv7l CPU, but I imagine any other
> > > variants with the BKPT instruction would be equally affected.
> > >
> > > I believe the culprit to be commit
> > > c3f89986fde7bb9ccc86a901bf28e1f7d69fc3b3 "ARM: 9391/2: hw_breakpoint:
> > > Handle CFI breakpoints".  The commit defines the method-of-entry code 3
> > > as "ARM_ENTRY_CFI_BREAKPOINT", but this is the code used for any BKPT
> > > instruction - see
> > > https://developer.arm.com/documentation/ddi0379/a/Debug-Register-Reference/Control-and-status-registers/Debug-Status-and-Control-Register--DSCR-?lang=en
> > > "Method of Debug Entry (MOE), bits [5:2]". If the CFI option is disabled
> > > in the kernel config,  hw_breakpoint_pending() returns 0 indicating the
> > > breakpoint was handled, but takes no action. So breakpoints cannot be
> > > used by user-space code, regardless of how CONFIG_CFI is set. The blog
> > > post
> > > https://www.jwhitham.org/2015/04/the-mystery-of-fifteen-millisecond.html
> > > gives a nice overview of the control flow in older, working kernels.  
> > 
> > Does simply reverting the patch solve the issue?
> > 
> > > The following Systemtap script can be used to demonstrate that the
> > > ARM_ENTRY_CFI_BREAKPOINT path is used, when running the above C program.  
> > 
> > Yeah it's definitely that one causing it.
> > 
> > I sent the naive solution to it, and before anyone point it out: no it does
> > not allow custom breakpoints to be mixed with kernel CFI, but it
> > probably makes legacy systems work on newer kernels since they
> > probably don't select CFI.
> > https://lore.kernel.org/linux-arm-kernel/20260626-arm32-cfi-bug-v1-1-a467b5050c0b@kernel.org/T/#u
> > 
> > I understand that this is not solving everything.
> 
> I'm confused.
> Why would building a kernel with CFI (to check kernel indirect calls)
> change the behaviour of executing anything in userspace?
> 
> If userspace is compiled with CFI and gets an equivalent fail then you'd
> (probably) want a fatal signal - but isn't that entirely unrelated to
> the kernel code.
> Do those checks even need kernel support? I know shadow stacks do.

CFI generates instructions that can check the type of the function
against the caller. It appears that on 32-bit ARM, Clang close that,
in the case of a mismatch, it would cause a BKPT instruction to be
executed.

Linus' code in commit c3f89986fde7 ("ARM: 9391/2: hw_breakpoint:
Handle CFI breakpoints") added code to handle this BKPT use.

However, we now have a regression reported as a result of that commit
where there is a userspace program that has explicit BKPT instructions
encoded within it, and the program relies on the kernel behaviour that
was introduced in f81ef4a920c8 ("ARM: 6356/1: hw-breakpoint: add ARM
backend for the hw-breakpoint framework") in 2.6.37 - and this "new"
behaviour is conditional on CONFIG_PERF_EVENTS being enabled - where
it raises a SIGTRAP.

Prior to this commit, or whenever CONFIG_PERF_EVENTS is disabled, the
kernel will raise a SIGBUS instead.

Both SIGTRAP and SIGBUS are "forced" signals - the kernel will force
them to be delivered to the program irrespective of whether the program
has blocked or ignored these signals, since this is the kernel trying
to save the system (because it doesn't know how to handle it.)

Moreover, BKPT was only introduced around the ARMv5TE era, and the
FSR code for it was only added in later architecture reference manuals,
changing an existing FSR code from an implementation defined "Terminal
Exception" to an architecturally defined "Debug Exception".

Support for this "Debug Exception" was only added with patch 6356/1,
but that did not handle the BKPT instruction. Linus' commit above
(9391/1) added support for the CFI case, but meant that userspace
would now spin on a BKPT instruction rather than force a signal,
thereby causing the regression.

We can't fix BKPT handling - this userspace program relies on the fact
that the kernel doesn't handle this instruction (for example, it relies
on the PC not being advanced) and advancing the PC by one instruction
after a SIGTRAP handler returns may not be the correct way to handle
it anyway. Consider BKPT being used as an "assert" type context, where
the compiler doesn't expect execution to continue, and a literal pool
following the instruction.

We are now stuck with the sorry state that BKPT is, and as I have said
many times now, BKPT should be avoided - it's an utter trainwreck. The
only sensible use that BKPT has is with a hardware debugger that traps
the BKPT entry into debug mode (a special hardware debugger mode that
the CPU enters which software can't see).

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
