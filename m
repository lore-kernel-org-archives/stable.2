Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D31630C359;
	Tue, 23 Jun 2026 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782208119; cv=none; b=LSkWP0z4W0yCJOWRaHCt2gzrn64wusZCFgbnODIs6n1jlR9Ofv7AP1q9rFVGuMWdduEnwLf/nQlTZCazw2v+hZG1xuERGc8eXG3nlXw9B1q0TGZr89quT2Xe8TqoS9QrcthbwoMExP5kHpn5tF1dgzTYQailgxagohSPeuxIF5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782208119; c=relaxed/simple;
	bh=IF4gWCNZk2omMNW560g5FqVRIKPXatV4IwnQF5H9cco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/ewSk8m5QY1Iyk/Fs/OvK36n2DVbD0WhsS33A091YaqxK0tPZTA3NqbCQEV0MQ3ryPzRP6mtujjTjOTnI7eJqI37NoGmfHYWYUKf/6UWbgOytt7mocwQgPHj9aY2J97xNDw63akOQrWNa+3aVmEqsxwXmuCydaM0TBpGzMm+Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=yhDB/S8y; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="yhDB/S8y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HNjRQhDwzAGeREHXOt2VQ6LJ3P68mlwUzA90xKgjR20=; b=yhDB/S8yQNu6K3I5OUZ2/8se1c
	gqqqbtDFoG5rkHLm2cddchC8NTs1FvMEaGdiekGb4qp6db+uQSQCrSIFsAKFRh0sXp2/mel8KOsrE
	kcGFqGd3oLiWF3ecagBYJsjbiST6/r1exZwGksvkTPD/oOcF5jyQ4jLuINv2kqyda+vr8q1y0Fii2
	/EYYxd9RsxKi+TPIfV42qVRwTKuVBxLKqNa4IZQZIKsJzhnjpsvySYqYyAQTYO368EwLspMizWUGU
	ThL3awoLRIIn1+LL/8cF0BSDK0eoA9P281ogzLO4KWs7OkdrGYLQ/bpOqHZNyiPm/TYnK1R5kIxG9
	Q24EJfQQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59356)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wbxk3-000000006ab-2S6Y;
	Tue, 23 Jun 2026 10:48:27 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wbxk2-000000008LS-0IId;
	Tue, 23 Jun 2026 10:48:26 +0100
Date: Tue, 23 Jun 2026 10:48:25 +0100
From: Russell King <linux@armlinux.org.uk>
To: slipher <slipher@protonmail.com>, Linus Walleij <linusw@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] 32-bit ARM's BKPT instruction no longer works
Message-ID: <ajpWaTW9uXWqX1OA@shell.armlinux.org.uk>
References: <kJqktbpLphg_Pk5I5SPptgTLjl3E3eq5mN5UzCslyFj7Q1Irp-wDid4mj5eQVd2iZtRGXgeZd8goq195EkXdjyt864YMc8mVb2B9NGH91NQ=@protonmail.com>
 <ajhHYKyvL9nCUvG5@shell.armlinux.org.uk>
 <zbEOoL4_phCCh7td7DwqQtyhleFJ_G3yRBc8AFjT5hwIwcRipRMsjtIVJgLi3t5vJk5QsuKjY9c8I91nuVSYk4-xlzrAqigMWIE0iNMc9PM=@protonmail.com>
 <ajhof3cRtiN0Hk7k@shell.armlinux.org.uk>
 <ajhyyq_SscBAOFFY@shell.armlinux.org.uk>
 <DUmi3WqfISs6WPqSP0CfEAYosyWQN5F7owhotvDcuyyv7WFoloOeHyoatIx6TKimecbF_OFncDikItB-0ubyO5doBOvsIhEKMQsT2wHyeuE=@protonmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DUmi3WqfISs6WPqSP0CfEAYosyWQN5F7owhotvDcuyyv7WFoloOeHyoatIx6TKimecbF_OFncDikItB-0ubyO5doBOvsIhEKMQsT2wHyeuE=@protonmail.com>
Sender: "Russell King,,," <linux@armlinux.org.uk>

On Tue, Jun 23, 2026 at 02:05:29AM +0000, slipher wrote:
> 
> On Sunday, June 21st, 2026 at 6:25 PM, Russell King <linux@armlinux.org.uk> wrote:
> 
> > On Sun, Jun 21, 2026 at 11:41:03PM +0100, Russell King (Oracle) wrote:
> > > On Sun, Jun 21, 2026 at 09:53:17PM +0000, slipher wrote:
> > > >
> > > > On Sunday, June 21st, 2026 at 3:19 PM, Russell King (Oracle) <linux@armlinux.org.uk> wrote:
> > > >
> > > > > On Sun, Jun 21, 2026 at 07:15:27PM +0000, slipher wrote:
> > > > > > Consider the C program for 32-bit ARM architectures:
> > > > > >
> > > > > > int main() {
> > > > > > 	__asm__ __volatile__ ("BKPT");
> > > > > > 	return 0;
> > > > > > }
> > > > > >
> > > > > >
> > > > > > Expected behavior is that this raises SIGTRAP. Since Linux 6.10 this no
> > > > > > longer happens; instead execution perpetually resumes at the same
> > > > > > instruction, using 100% of CPU. It does not matter whether GDB is
> > > > > > attached. I have tested with an armv7l CPU, but I imagine any other
> > > > > > variants with the BKPT instruction would be equally affected.
> > > > >
> > > > > Looking at the code, I doubt this has ever cleanly raised SIGTRAP (can
> > > > > you check whether it does in kernels without c3f89986fde please?)
> > > > >
> > > > > What I suspect instead is you get an "Unhandled ... abort" instead
> > > > > and the program forcefully killed as hw_breakpoint_pending() would
> > > > > have ARM_DSCR_MOE(dscr) == 3, and the switch() would set ret = 1.
> > > > > That triggers the fault handlers in arch/arm/mm/fault.c to
> > > > > complain bitterly, and forced a SIGTRAP to the program to kill it
> > > > > off. No resumption from an unhandled trap is expected.
> > > >
> > > > I have tested with a 6.6 kernel. All of that is correct, as detailed in
> > > > the aforementioned blog post, except the last sentence. The switch does
> > > > set ret = 1, thereby passing on the exception. The kernel complains,
> > > > with such lines in dmesg output:
> > > >
> > > > [ 1547.164526] Unhandled prefetch abort: breakpoint debug exception (0x222) at 0x0001051c
> > >
> > > This message is printed at Alert level. It's just not supposed to
> > > happen, and if anyone sees it, it means someone cocked up in the kernel
> > > and didn't provide the code to handle a fault that can be generated.
> > >
> > > In these situations, the kernel's response is to try and keep the system
> > > running by delivering a signal that should result in the process being
> > > terminated. In this case, the hardware breakpoint code tells the
> > > generic code to deliver a SIGTRAP / TRAP_HWBKPT, and this will be
> > > delivered by force_sig_fault() after the noisy kernel message has been
> > > produced.
> > >
> > > force_sig_fault() will unblock the signal and set the handler to
> > > default if it was blocked or ignored. The default action for SIGTRAP
> > > should be to generate a coredump and terminate the program.
> > >
> > > > Indeed, it is not clean or efficient; the blog
> > > > (https://www.jwhitham.org/2015/04/the-mystery-of-fifteen-millisecond.html)
> > > > even has a proposed patch to improve the performance when raising
> > > > SIGTRAP. However, it is possible to catch the signal, and even resume
> > > > with something like this:
> > > >
> > > >
> > > > #include <ucontext.h>
> > > > #include <signal.h>
> > > > #include <stdio.h>
> > > >
> > > > void handl(int a, siginfo_t *b, void *uc) {
> > > >         puts("caught SIGTRAP");
> > > >         ((ucontext_t*)uc)->uc_mcontext.arm_pc += 4;
> > > > }
> > > >
> > > > int main() {
> > > >         struct sigaction s;
> > > >         s.sa_flags = SA_SIGINFO;
> > > >         s.sa_sigaction = handl;
> > > >         sigemptyset(&s.sa_mask);
> > > >         sigaction(SIGTRAP, &s, 0);
> > > >         puts("start");
> > > >         __asm__ __volatile__("BKPT");
> > > >         puts("resumed");
> > > >         return 0;
> > > > }
> > > >
> > > > Re-testing, I realized there is a huge caveat: SIGTRAP is *not* raised
> > > > when running under a debugger! If GDB is attached, either of the C
> > > > programs above will repeatedly resume at the faulting instruction on
> > > > Linux 6.6, just as they will with the latest kernels. So the regression
> > > > only affects the perhaps-obscure case of using BKPT without any
> > > > intention of attaching a debugger, unless that worked in even-earlier
> > > > versions of Linux.
> > >
> > > ... and while it's repeatedly raising the same fault, it's flooding the
> > > kernel console with Alert level messages telling you the fault hasn't
> > > been handled even on older kernels... yet you seem to be under the
> > > impression that this is supposed to work.
> > >
> > > You are testing something that has never been tested before, and are
> > > hitting behaviour that isn't _supposed_ to be clean.
> > >
> > > That said, the change of behaviour is wrong. If
> > > hw_breakpoint_cfi_handler() doesn't understand the reason its been
> > > called, it should cause the old behaviour (where the alert message
> > > is printed) to be actioned.
> > >
> > > The issue over whether BKPT should correctly raise a SIGTRAP that
> > > is appropriately handled is an entirely separate issue, which I
> > > would regard as a feature request rather than a regression.
> > >
> > > Let me put it slightly differently. BKPT in userspace hasn't been
> > > supported by the kernel, and the behaviour you've seen from the
> > > kernel is incidental to the kernel's abort handling - it is not
> > > by design.
> > >
> > > Architecturally, BKPT is used with JTAG debuggers, causing the
> > > processor to enter debug mode so a JTAG debugger can do its
> > > stuff. There was some discussion ten years ago whether LLVM
> > > should use BKPT for setting software breakpoints, and it seems
> > > they decided against it because of interfering with JTAG
> > > debuggers. See https://reviews.llvm.org/D16853?id=46899#347119
> > >
> > > Also see the linked discussion from that post, where using BKPT
> > > was discussed with gdb. Basically, if a hardware JTAG debugger is
> > > connected, BKPT goes straight to the hardware debugger not the
> > > kernel. However, note that the sourceware discussion is talking
> > > about Thumb2 rather than ARM, but the same will apply there.
> > >
> > > In essence, the decision was to stick with the UDF instructions
> > > for software breakpoints handled by the kernel, and leave BKPT
> > > for hardware JTAG debuggers. Consequently, explicitly executing
> > > BKPT without a hardware JTAG debugger is unexpected, the results
> > > of which are not guaranteed.
> > >
> > > Indeed, under older architectures, you'll get an undefined
> > > instruction exception and the program killed by a SIGILL not a
> > > SIGTRAP, because BKPT isn't architecturally defined there.
> > 
> > For further clarification, see the ARM Architecture Reference Manual,
> > DDI0100E, which introduced BKPT, page 114, but specifically page 115
> > which states in the notes:
> > 
> > "Hardware override
> > "Debug hardware in an implementation is specifically permitted to
> > override the normal behavior of the BKPT instruction. Because of
> > this, software must not use this instruction for purposes other than
> > those documented by the debug system being used (if any). In
> > particular, software cannot rely on the Prefetch Abort exception
> > occurring, unless either there is guaranteed to be no debug hardware
> > in the system or the debug system specifies that it will occur.
> > 
> > "For more information, consult the documentation for the debug
> > system being used."
> > 
> > DDI0406C also mentions C2.2 states that if DBGEN is enabled, then
> > all debug events become halting and cause the CPU to enter debug
> > state (for a hardware debugger to respond to.) However, the above
> > statement is no longer present, but is covered via other means.
> > Indeed, a JTAG hardware debugger can still override BKPT to
> > put the CPU into debug mode and omit to generate the Prefetch
> > Abort exception.
> > 
> > Thus, BKPT isn't guaranteed to raise a prefetch abort depending
> > on whether there's a hardware debugger connected and how that
> > debugger has configured the interface.
> > 
> > --
> > RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> > FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
> > 
> 
> To be clear, I'm not coming at this from a standpoint of "BKPT must be
> the one true breakpoint instruction because it's the one named after
> breakpoints". A piece of legacy software than I use relies on this
> instruction generating SIGTRAP (and then longjmp'ing out of the signal
> handler). A program stopped working, so I understood that to be a
> regression according to the definitions on kernel.org. If the
> maintainers consider my use case to be too xkcd.com/1172 to care about,
> that's understandable. I'm not concerned about whether fixes are
> backported; it shouldn't be that hard to fix by swapping with UDF
> instructions.

Sigh. It is not that we don't care - in fact, I've already told Linus W
(as author of the commit causing your issue - who you should have Cc'd
on this report) that this needs to be fixed so that the behaviour that
userspace sees doesn't change - as per kernel rules.

However, what I'm also pointing out is that your use case results in
behaviours that can't be relied upon in userspace to work from an
architectural point of view, and that have historically always produced
a kernel alert message - thus are slow - and I'd say by intention
because BPKT has never actually been supported.

If one disables PERF_EVENTS in the kernel configuration, you won't
even get the SIGTRAP for BKPT, but instead get a SIGBUS. That is also
how the kernel would handle BKPT propr to 3rd September 2010 (v2.6.37)
even with PERF_EVENTS enabled.

Hence, the raising of SIGTRAP instead of SIGBUS can also be regarded as
a regression /if/ someone pop up and say that they're relying on that
behaviour - and if that were to be reported, under kernel rules, that
regression would also need to be fixed, which means that generating
SIGTRAP for BKPT no longer becomes possible, and thus your program
breaks - but the historical nature of the older behaviour wins out.

So, what I'm saying is that your program is relying on unstable
foundations here, but let me be clear: because you have reported the
change of behaviour, it will get fixed. We just can't guarantee that
it will remain fixed for the reasons I've pointed out in my various
emails to you.

Sadly, that's what happens when every i isn't dotted and every t isn't
crossed when it comes to "features" that the CPU supports but the
kernel doesn't.

Let me also be clear: I expect Linus W to fix this - firstly, his
commit introduced the breakage, and secondly, I have little time at
the moment to do any kernel hacking (ongoing long term family issues.)

> Anyhow, regardless of how previous kernel versions behave, I would like
> to simply report some buggy behavior. I think we agree that resuming at
> a faulting instruction to create an infinite loop can't be the right
> thing to do. Additionally, it seems fishy that the software-defined(?)
> CFI fault code coincides with one of the method-of-entry codes generated
> by the processor, or that an error in user-space code can trigger a jump
> into the CFI fault path. Maybe this is intentional and it is somehow
> expedient to do this, but it should be better documented at least.

It is documented as I have pointed out in the architecture reference
manuals. It is not the kernel's job to document architectural details.

I suspect that the CFI fault code was a decision by compiler authors,
but I can't say because I don't have a setup that generates the code
for CFI.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
