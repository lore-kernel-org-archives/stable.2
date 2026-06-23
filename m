Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF7C14B977;
	Tue, 23 Jun 2026 02:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782180342; cv=none; b=FrQjmPU3aaAVhk21j+VcOa0NEZ/3wk0F9g1rxAzUjteIvYRvlqEQT1kAVMe2eCKfbpXTouU5+tAh6XsBeS8hobNiv+sOVJtILksWXW8iuo1+EvHG2R4xZlVz/jYp6iYTOutTqU0shzyQL7Lv+2shmEDfnGTgH2J6pyGvfFyYn6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782180342; c=relaxed/simple;
	bh=/jvy4haJ3eRvxf1Rqi6359AYQenYT8ncexbLKJKy1fQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F7Y751nivZWhPS8OYW6UuI++MrV6Kqe9AFq2nC3k81/lS2CsQllhdgb7/5oPL6yJywhTZ65323mL6H2mqtTQTKPDkfMGrqo5waHQtJO85zyYHD1ARlcKVlfSmb2a4N6dHqF9pxdepoJLONpV9Nq2Xy9eyYqvyIBUs7/C3OMWBUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=LrsLi9n4; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="LrsLi9n4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1782180332; x=1782439532;
	bh=GFVCLRORvenW6J8JLKQ2MdfZdUSFXCOn7GgSskTF2Fs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=LrsLi9n4Iarc4cPiCIRXRNyv8nRdrGjnO1gw/a1JgfzOiNnqYCJjHiV7Crubbi5c+
	 tOfHNW3xl1KtVIqtf4nNxJDlvnZ6mrgBeHjnlPXqW0wrjNYoZEFxrvwMZmOX5J84H8
	 fI6aG455yeyb7HIMSQ8oRJLYz8Jja8moe+Mu/g8D3pIPEjH9dOSXBokWHgOGltWbmA
	 f0JRTpnmGgM1B3FjLrt4bNsgiTbtpC0iTJP52i8xAdJTq7AnDMXAlhhzcgdCMtHDIP
	 B/EeqgfW4R8FBAPDjTpLxVnP5b+/DXl4oZtMXnaFEbnp59Y6w0pMNSrLT1VZiGbU/a
	 DekXI2Uv5Wa0Q==
Date: Tue, 23 Jun 2026 02:05:29 +0000
To: Russell King <linux@armlinux.org.uk>
From: slipher <slipher@protonmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] 32-bit ARM's BKPT instruction no longer works
Message-ID: <DUmi3WqfISs6WPqSP0CfEAYosyWQN5F7owhotvDcuyyv7WFoloOeHyoatIx6TKimecbF_OFncDikItB-0ubyO5doBOvsIhEKMQsT2wHyeuE=@protonmail.com>
In-Reply-To: <ajhyyq_SscBAOFFY@shell.armlinux.org.uk>
References: <kJqktbpLphg_Pk5I5SPptgTLjl3E3eq5mN5UzCslyFj7Q1Irp-wDid4mj5eQVd2iZtRGXgeZd8goq195EkXdjyt864YMc8mVb2B9NGH91NQ=@protonmail.com> <ajhHYKyvL9nCUvG5@shell.armlinux.org.uk> <zbEOoL4_phCCh7td7DwqQtyhleFJ_G3yRBc8AFjT5hwIwcRipRMsjtIVJgLi3t5vJk5QsuKjY9c8I91nuVSYk4-xlzrAqigMWIE0iNMc9PM=@protonmail.com> <ajhof3cRtiN0Hk7k@shell.armlinux.org.uk> <ajhyyq_SscBAOFFY@shell.armlinux.org.uk>
Feedback-ID: 10906495:user:proton
X-Pm-Message-ID: 9b8f94f203839f5f60512ed960cecb4e1c022695
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Sunday, June 21st, 2026 at 6:25 PM, Russell King <linux@armlinux.org.uk>=
 wrote:

> On Sun, Jun 21, 2026 at 11:41:03PM +0100, Russell King (Oracle) wrote:
> > On Sun, Jun 21, 2026 at 09:53:17PM +0000, slipher wrote:
> > >
> > > On Sunday, June 21st, 2026 at 3:19 PM, Russell King (Oracle) <linux@a=
rmlinux.org.uk> wrote:
> > >
> > > > On Sun, Jun 21, 2026 at 07:15:27PM +0000, slipher wrote:
> > > > > Consider the C program for 32-bit ARM architectures:
> > > > >
> > > > > int main() {
> > > > > =09__asm__ __volatile__ ("BKPT");
> > > > > =09return 0;
> > > > > }
> > > > >
> > > > >
> > > > > Expected behavior is that this raises SIGTRAP. Since Linux 6.10 t=
his no
> > > > > longer happens; instead execution perpetually resumes at the same
> > > > > instruction, using 100% of CPU. It does not matter whether GDB is
> > > > > attached. I have tested with an armv7l CPU, but I imagine any oth=
er
> > > > > variants with the BKPT instruction would be equally affected.
> > > >
> > > > Looking at the code, I doubt this has ever cleanly raised SIGTRAP (=
can
> > > > you check whether it does in kernels without c3f89986fde please?)
> > > >
> > > > What I suspect instead is you get an "Unhandled ... abort" instead
> > > > and the program forcefully killed as hw_breakpoint_pending() would
> > > > have ARM_DSCR_MOE(dscr) =3D=3D 3, and the switch() would set ret =
=3D 1.
> > > > That triggers the fault handlers in arch/arm/mm/fault.c to
> > > > complain bitterly, and forced a SIGTRAP to the program to kill it
> > > > off. No resumption from an unhandled trap is expected.
> > >
> > > I have tested with a 6.6 kernel. All of that is correct, as detailed =
in
> > > the aforementioned blog post, except the last sentence. The switch do=
es
> > > set ret =3D 1, thereby passing on the exception. The kernel complains=
,
> > > with such lines in dmesg output:
> > >
> > > [ 1547.164526] Unhandled prefetch abort: breakpoint debug exception (=
0x222) at 0x0001051c
> >
> > This message is printed at Alert level. It's just not supposed to
> > happen, and if anyone sees it, it means someone cocked up in the kernel
> > and didn't provide the code to handle a fault that can be generated.
> >
> > In these situations, the kernel's response is to try and keep the syste=
m
> > running by delivering a signal that should result in the process being
> > terminated. In this case, the hardware breakpoint code tells the
> > generic code to deliver a SIGTRAP / TRAP_HWBKPT, and this will be
> > delivered by force_sig_fault() after the noisy kernel message has been
> > produced.
> >
> > force_sig_fault() will unblock the signal and set the handler to
> > default if it was blocked or ignored. The default action for SIGTRAP
> > should be to generate a coredump and terminate the program.
> >
> > > Indeed, it is not clean or efficient; the blog
> > > (https://www.jwhitham.org/2015/04/the-mystery-of-fifteen-millisecond.=
html)
> > > even has a proposed patch to improve the performance when raising
> > > SIGTRAP. However, it is possible to catch the signal, and even resume
> > > with something like this:
> > >
> > >
> > > #include <ucontext.h>
> > > #include <signal.h>
> > > #include <stdio.h>
> > >
> > > void handl(int a, siginfo_t *b, void *uc) {
> > >         puts("caught SIGTRAP");
> > >         ((ucontext_t*)uc)->uc_mcontext.arm_pc +=3D 4;
> > > }
> > >
> > > int main() {
> > >         struct sigaction s;
> > >         s.sa_flags =3D SA_SIGINFO;
> > >         s.sa_sigaction =3D handl;
> > >         sigemptyset(&s.sa_mask);
> > >         sigaction(SIGTRAP, &s, 0);
> > >         puts("start");
> > >         __asm__ __volatile__("BKPT");
> > >         puts("resumed");
> > >         return 0;
> > > }
> > >
> > > Re-testing, I realized there is a huge caveat: SIGTRAP is *not* raise=
d
> > > when running under a debugger! If GDB is attached, either of the C
> > > programs above will repeatedly resume at the faulting instruction on
> > > Linux 6.6, just as they will with the latest kernels. So the regressi=
on
> > > only affects the perhaps-obscure case of using BKPT without any
> > > intention of attaching a debugger, unless that worked in even-earlier
> > > versions of Linux.
> >
> > ... and while it's repeatedly raising the same fault, it's flooding the
> > kernel console with Alert level messages telling you the fault hasn't
> > been handled even on older kernels... yet you seem to be under the
> > impression that this is supposed to work.
> >
> > You are testing something that has never been tested before, and are
> > hitting behaviour that isn't _supposed_ to be clean.
> >
> > That said, the change of behaviour is wrong. If
> > hw_breakpoint_cfi_handler() doesn't understand the reason its been
> > called, it should cause the old behaviour (where the alert message
> > is printed) to be actioned.
> >
> > The issue over whether BKPT should correctly raise a SIGTRAP that
> > is appropriately handled is an entirely separate issue, which I
> > would regard as a feature request rather than a regression.
> >
> > Let me put it slightly differently. BKPT in userspace hasn't been
> > supported by the kernel, and the behaviour you've seen from the
> > kernel is incidental to the kernel's abort handling - it is not
> > by design.
> >
> > Architecturally, BKPT is used with JTAG debuggers, causing the
> > processor to enter debug mode so a JTAG debugger can do its
> > stuff. There was some discussion ten years ago whether LLVM
> > should use BKPT for setting software breakpoints, and it seems
> > they decided against it because of interfering with JTAG
> > debuggers. See https://reviews.llvm.org/D16853?id=3D46899#347119
> >
> > Also see the linked discussion from that post, where using BKPT
> > was discussed with gdb. Basically, if a hardware JTAG debugger is
> > connected, BKPT goes straight to the hardware debugger not the
> > kernel. However, note that the sourceware discussion is talking
> > about Thumb2 rather than ARM, but the same will apply there.
> >
> > In essence, the decision was to stick with the UDF instructions
> > for software breakpoints handled by the kernel, and leave BKPT
> > for hardware JTAG debuggers. Consequently, explicitly executing
> > BKPT without a hardware JTAG debugger is unexpected, the results
> > of which are not guaranteed.
> >
> > Indeed, under older architectures, you'll get an undefined
> > instruction exception and the program killed by a SIGILL not a
> > SIGTRAP, because BKPT isn't architecturally defined there.
>=20
> For further clarification, see the ARM Architecture Reference Manual,
> DDI0100E, which introduced BKPT, page 114, but specifically page 115
> which states in the notes:
>=20
> "Hardware override
> "Debug hardware in an implementation is specifically permitted to
> override the normal behavior of the BKPT instruction. Because of
> this, software must not use this instruction for purposes other than
> those documented by the debug system being used (if any). In
> particular, software cannot rely on the Prefetch Abort exception
> occurring, unless either there is guaranteed to be no debug hardware
> in the system or the debug system specifies that it will occur.
>=20
> "For more information, consult the documentation for the debug
> system being used."
>=20
> DDI0406C also mentions C2.2 states that if DBGEN is enabled, then
> all debug events become halting and cause the CPU to enter debug
> state (for a hardware debugger to respond to.) However, the above
> statement is no longer present, but is covered via other means.
> Indeed, a JTAG hardware debugger can still override BKPT to
> put the CPU into debug mode and omit to generate the Prefetch
> Abort exception.
>=20
> Thus, BKPT isn't guaranteed to raise a prefetch abort depending
> on whether there's a hardware debugger connected and how that
> debugger has configured the interface.
>=20
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
>=20

To be clear, I'm not coming at this from a standpoint of "BKPT must be
the one true breakpoint instruction because it's the one named after
breakpoints". A piece of legacy software than I use relies on this
instruction generating SIGTRAP (and then longjmp'ing out of the signal
handler). A program stopped working, so I understood that to be a
regression according to the definitions on kernel.org. If the
maintainers consider my use case to be too xkcd.com/1172 to care about,
that's understandable. I'm not concerned about whether fixes are
backported; it shouldn't be that hard to fix by swapping with UDF
instructions.

Anyhow, regardless of how previous kernel versions behave, I would like
to simply report some buggy behavior. I think we agree that resuming at
a faulting instruction to create an infinite loop can't be the right
thing to do. Additionally, it seems fishy that the software-defined(?)
CFI fault code coincides with one of the method-of-entry codes generated
by the processor, or that an error in user-space code can trigger a jump
into the CFI fault path. Maybe this is intentional and it is somehow
expedient to do this, but it should be better documented at least.
