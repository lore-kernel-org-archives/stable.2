Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5EC379C5D;
	Sun, 21 Jun 2026 22:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782081670; cv=none; b=kNNJfiQwnxIWbwYO3HMksTTUs3EsdwRCCo7D0hqh+4ClRX1jpopLsZvkbIeE0GqdssW0slj1s5XfxYWq+VlgABnkzZcU3eMb63Kr6so9jWB2S9DDiYxK9TQmDKykRv3wmVKF2l5bdCw1qA4YPY00J/pPMRASjuuYJ2UywYBJNks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782081670; c=relaxed/simple;
	bh=5OsyGYWO0BitPR7WlUQKmJwrz5QaICAwzRltLRCB7Rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDQB8f+kDVqmuEujPlPg/74Qd9+rXJJS3ri/x8jPGPNdtEv/PcUIc3dGDhKWGGAmB4uatj1mZqkUTM29glZJYJJstarPVlgeJSpo1cMT+KiIt5Yry6jzNLVmQr19MALBl93d9Fs/HSnhmQPT3PoZ9UOsZFS8cmmhZpynfk7jOWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Oq9zlQy1; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Oq9zlQy1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iwTFHNV/aTfQPhvFidiebrpj/3OUv1TcrUfEdGj5eJI=; b=Oq9zlQy1UDL0y/wuEpvGm82T3S
	3DBzfAxUgzzJZQ4KBpW7ebXM6mIQ2tCYb7wadA/LKz//qnTtIQZX5u5G/ltY6hEAUQdnDNWSPfPB5
	ua1AteA0mdl+vf8vJiFIoakZLsZ3jv1umFQWhz35dmO/u7NzLouaRuqEr0hOztvaglUB8Uux8hTLP
	lYNvVgl5oGkonZX7OWihuPQ/TcepAmLEOKWKZMT10S4ZW8zR4urFG0BQJSk8hjtA+he+YRtUrP3qc
	LyDsqr7q0VIQ/3o0Co5+F5IQl2J4HkalYd4OPV9cONTVEVDQ/GA0Gado4Z2nzYRd8DrUoU4J9r3Qm
	FIAaP9KA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42186)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wbQqe-000000004ey-3m0G;
	Sun, 21 Jun 2026 23:41:04 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wbQqd-000000006f2-2MZ5;
	Sun, 21 Jun 2026 23:41:03 +0100
Date: Sun, 21 Jun 2026 23:41:03 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: slipher <slipher@protonmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] 32-bit ARM's BKPT instruction no longer works
Message-ID: <ajhof3cRtiN0Hk7k@shell.armlinux.org.uk>
References: <kJqktbpLphg_Pk5I5SPptgTLjl3E3eq5mN5UzCslyFj7Q1Irp-wDid4mj5eQVd2iZtRGXgeZd8goq195EkXdjyt864YMc8mVb2B9NGH91NQ=@protonmail.com>
 <ajhHYKyvL9nCUvG5@shell.armlinux.org.uk>
 <zbEOoL4_phCCh7td7DwqQtyhleFJ_G3yRBc8AFjT5hwIwcRipRMsjtIVJgLi3t5vJk5QsuKjY9c8I91nuVSYk4-xlzrAqigMWIE0iNMc9PM=@protonmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zbEOoL4_phCCh7td7DwqQtyhleFJ_G3yRBc8AFjT5hwIwcRipRMsjtIVJgLi3t5vJk5QsuKjY9c8I91nuVSYk4-xlzrAqigMWIE0iNMc9PM=@protonmail.com>
Sender: "Russell King,,," <linux@armlinux.org.uk>

On Sun, Jun 21, 2026 at 09:53:17PM +0000, slipher wrote:
> 
> On Sunday, June 21st, 2026 at 3:19 PM, Russell King (Oracle) <linux@armlinux.org.uk> wrote:
> 
> > On Sun, Jun 21, 2026 at 07:15:27PM +0000, slipher wrote:
> > > Consider the C program for 32-bit ARM architectures:
> > >
> > > int main() {
> > > 	__asm__ __volatile__ ("BKPT");
> > > 	return 0;
> > > }
> > >
> > >
> > > Expected behavior is that this raises SIGTRAP. Since Linux 6.10 this no
> > > longer happens; instead execution perpetually resumes at the same
> > > instruction, using 100% of CPU. It does not matter whether GDB is
> > > attached. I have tested with an armv7l CPU, but I imagine any other
> > > variants with the BKPT instruction would be equally affected.
> > 
> > Looking at the code, I doubt this has ever cleanly raised SIGTRAP (can
> > you check whether it does in kernels without c3f89986fde please?)
> > 
> > What I suspect instead is you get an "Unhandled ... abort" instead
> > and the program forcefully killed as hw_breakpoint_pending() would
> > have ARM_DSCR_MOE(dscr) == 3, and the switch() would set ret = 1.
> > That triggers the fault handlers in arch/arm/mm/fault.c to
> > complain bitterly, and forced a SIGTRAP to the program to kill it
> > off. No resumption from an unhandled trap is expected.
> 
> I have tested with a 6.6 kernel. All of that is correct, as detailed in
> the aforementioned blog post, except the last sentence. The switch does
> set ret = 1, thereby passing on the exception. The kernel complains,
> with such lines in dmesg output:
> 
> [ 1547.164526] Unhandled prefetch abort: breakpoint debug exception (0x222) at 0x0001051c

This message is printed at Alert level. It's just not supposed to
happen, and if anyone sees it, it means someone cocked up in the kernel
and didn't provide the code to handle a fault that can be generated.

In these situations, the kernel's response is to try and keep the system
running by delivering a signal that should result in the process being
terminated. In this case, the hardware breakpoint code tells the
generic code to deliver a SIGTRAP / TRAP_HWBKPT, and this will be
delivered by force_sig_fault() after the noisy kernel message has been
produced.

force_sig_fault() will unblock the signal and set the handler to
default if it was blocked or ignored. The default action for SIGTRAP
should be to generate a coredump and terminate the program.

> Indeed, it is not clean or efficient; the blog
> (https://www.jwhitham.org/2015/04/the-mystery-of-fifteen-millisecond.html)
> even has a proposed patch to improve the performance when raising
> SIGTRAP. However, it is possible to catch the signal, and even resume
> with something like this:
> 
> 
> #include <ucontext.h>
> #include <signal.h>
> #include <stdio.h>
> 
> void handl(int a, siginfo_t *b, void *uc) {
>         puts("caught SIGTRAP");
>         ((ucontext_t*)uc)->uc_mcontext.arm_pc += 4;
> }
> 
> int main() {
>         struct sigaction s;
>         s.sa_flags = SA_SIGINFO;
>         s.sa_sigaction = handl;
>         sigemptyset(&s.sa_mask);
>         sigaction(SIGTRAP, &s, 0);
>         puts("start");
>         __asm__ __volatile__("BKPT");
>         puts("resumed");
>         return 0;
> }
> 
> Re-testing, I realized there is a huge caveat: SIGTRAP is *not* raised
> when running under a debugger! If GDB is attached, either of the C
> programs above will repeatedly resume at the faulting instruction on
> Linux 6.6, just as they will with the latest kernels. So the regression
> only affects the perhaps-obscure case of using BKPT without any
> intention of attaching a debugger, unless that worked in even-earlier
> versions of Linux.

... and while it's repeatedly raising the same fault, it's flooding the
kernel console with Alert level messages telling you the fault hasn't
been handled even on older kernels... yet you seem to be under the
impression that this is supposed to work.

You are testing something that has never been tested before, and are
hitting behaviour that isn't _supposed_ to be clean.

That said, the change of behaviour is wrong. If
hw_breakpoint_cfi_handler() doesn't understand the reason its been
called, it should cause the old behaviour (where the alert message
is printed) to be actioned.

The issue over whether BKPT should correctly raise a SIGTRAP that
is appropriately handled is an entirely separate issue, which I
would regard as a feature request rather than a regression.

Let me put it slightly differently. BKPT in userspace hasn't been
supported by the kernel, and the behaviour you've seen from the
kernel is incidental to the kernel's abort handling - it is not
by design.

Architecturally, BKPT is used with JTAG debuggers, causing the
processor to enter debug mode so a JTAG debugger can do its
stuff. There was some discussion ten years ago whether LLVM
should use BKPT for setting software breakpoints, and it seems
they decided against it because of interfering with JTAG
debuggers. See https://reviews.llvm.org/D16853?id=46899#347119

Also see the linked discussion from that post, where using BKPT
was discussed with gdb. Basically, if a hardware JTAG debugger is
connected, BKPT goes straight to the hardware debugger not the
kernel. However, note that the sourceware discussion is talking
about Thumb2 rather than ARM, but the same will apply there.

In essence, the decision was to stick with the UDF instructions
for software breakpoints handled by the kernel, and leave BKPT
for hardware JTAG debuggers. Consequently, explicitly executing
BKPT without a hardware JTAG debugger is unexpected, the results
of which are not guaranteed.

Indeed, under older architectures, you'll get an undefined
instruction exception and the program killed by a SIGILL not a
SIGTRAP, because BKPT isn't architecturally defined there.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
