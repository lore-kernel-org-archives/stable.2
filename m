Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EE93FC5D8
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782491762; cv=none; b=qRssr/gES9LHZCLZpn+648krb8t4zJHyI8tMD0fV9qBSvI5+K3w0TvCDoTsv5gPrGy0J7TzpfO5kz8yUbNaVwoz4+Mn6BqQD/06g67+DlQvhWlO0tFFulIVIr/M4ve0ybzjejrMfgNUjqCtYwfxicjpATAVp+i7y719W33fZBWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782491762; c=relaxed/simple;
	bh=jfKMfNtA0m2tzWAAaJhQh72SwYzYGPRTh1/ufIvgsvY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QxwuSI9NaG4fzVfR2Z59NZHXYsaHlLUj9tTN9mJSuDTLho/ED2UDqSAWJa8e4HUw2x20SJmxRRlU/ph6oQiR5T3HeHxvi1NiKG840+puH5o9h4WSbpeqN3bp5WXknZukPBbfjfsqiKhsAnEyv74zCf6i8X2Xw8RnXpvJeRguQ/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q0hW2IO/; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q0hW2IO/"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4927014c0deso2342735e9.2
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 09:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782491758; x=1783096558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+4pZ54hLA2erkBLlLpycb2Ho8SVAKzZfrHin6zD0vY=;
        b=q0hW2IO/GrwT+uAMmBU4TREeOiXUHrv13fY8ZaCbIDcGOKwZBdaswKa3thqgcKFCHH
         Xu4IAC/i+TqS8F3if9219TtQuBHA7SGma3enYHgP+NBWizO2o1UItF6F1KyH+/rEfh+9
         jOxHmgvjTQhhWYlGaDCpTe295IzifHPY8fIa71pdsRLHR/RS+4f34WYpStMQVArfCMQZ
         WKClu2BvUEehcgkKzbJPwj1z15KypFa4WKNI5yXL6OH3NeAa5/k9mSH62O2dP7/WmWyc
         KMvmZmzYjj+0Htt6XnAxtcN4fdyNHsxGhX8DSk5viHH2m8L9y1Fc3KtXPn0hedHnEo3k
         8iJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782491758; x=1783096558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l+4pZ54hLA2erkBLlLpycb2Ho8SVAKzZfrHin6zD0vY=;
        b=c0Z45M/Kx3CwZMtE3HIF21DMzJ/W3MEoFYr/W0liDkV+iw1oZkhmMiDpF61667W8Xz
         Nsj9symEZ2UrXze6lj/DUiVEdUbzOJgekyZT1mwK5IlsJYbrIZvVRIUAELeDXLp/9cMk
         FFYO0XAUbQG8zJGswq0sf9HqeerPQ1lXFyraV3imC8fi/urmGhMUzdAdqilekx9ECIOR
         3I5cmCl0/N1Lcp3aiyatvjr2OGpF3RkGTrL75I+W/Q2XV8+QTWs1aThWy6+9ZPQnyu/8
         +KO3Q0XF2z+AM8otoe3+bvnOsH/ejVnWzj9WLg7gG3bY3SNoZ93C40DyvhAmGPQDyHMK
         vNQg==
X-Forwarded-Encrypted: i=1; AFNElJ+c5IbDGySmWe/R8bGA3aC6/kylFlMr5AefifCDB03jun4OFRfys5NC+WO7Yl2c4UD4qu5sqtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX6Xi3KnGwE/Kweea2hTn8xoiEg9F8KwPNWanznOypPqmjWdTN
	dNl93I+d/zznWZ6ehkdhYuqCZS+rzMTLXeeql90mSv8x+VxjVdVxA2Hy
X-Gm-Gg: AfdE7cnVGMW030tshHSC+BHJrvRwaf01tARXXOjunNwv/hv5+JmOdgELaUAYlIls5Os
	/LligDuGFS22d4KHqa3eU9cYHWydHhS4m7uybuLmwJrgED2gSL7OM3+9j8xQ2iVGL+CedYeiCu+
	n8JmpwP7UwD1K7ztHRmaKcX/Q25fB09Ii9ykrmtTqSm5hnD221Ri3RzjkU64yb5oRivWfZqE/Uy
	AajfGRPTHQI4We/SWW55UPn13jjaqitPEd+/KlCvIx1rsOVLV3pD9nX2hFfuCnA3NiC3L4zdb4C
	x/IK9v0HyP3PfH4BxUoZy1i+nrnrdBuAIbfrI8XQRKENbxLghz3gdJD4RNlSluoFQ4tpQJ8fjhs
	O3ORMWXpqNJ4l7PSVFA0dIQTbb/k2p8PGmXHXgp/hS1FxeJtjRXcq68fgdjwdDTRMzlX5VrxKnx
	bAKCjqP4SpaBrIrfp8Y8a4c3/xOPAPDM96U9BYecz0gLHSBZ1Ro6xO8c84UfIe
X-Received: by 2002:a05:600d:6452:10b0:492:1e36:85dc with SMTP id 5b1f17b1804b1-4926689ac37mr92438895e9.36.1782491758352;
        Fri, 26 Jun 2026 09:35:58 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49268ffe204sm92361655e9.7.2026.06.26.09.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 09:35:57 -0700 (PDT)
Date: Fri, 26 Jun 2026 17:35:56 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Russell King <linux@armlinux.org.uk>
Cc: Linus Walleij <linusw@kernel.org>, slipher <slipher@protonmail.com>,
 Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>, Sami
 Tolvanen <samitolvanen@google.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>, "regressions@lists.linux.dev"
 <regressions@lists.linux.dev>, "linus.walleij@linaro.org"
 <linus.walleij@linaro.org>
Subject: Re: [REGRESSION] 32-bit ARM's BKPT instruction no longer works
Message-ID: <20260626173556.0535ffe5@pumpkin>
In-Reply-To: <aj6c2gW6h7xNwGnh@shell.armlinux.org.uk>
References: <kJqktbpLphg_Pk5I5SPptgTLjl3E3eq5mN5UzCslyFj7Q1Irp-wDid4mj5eQVd2iZtRGXgeZd8goq195EkXdjyt864YMc8mVb2B9NGH91NQ=@protonmail.com>
	<CAD++jL=YJGFf+9o8KV+OO_61EL+_z3b7P+eLK=6=r+GOuJiWAg@mail.gmail.com>
	<20260626145356.4183d8c5@pumpkin>
	<aj6c2gW6h7xNwGnh@shell.armlinux.org.uk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 26 Jun 2026 16:38:02 +0100
Russell King <linux@armlinux.org.uk> wrote:

> On Fri, Jun 26, 2026 at 02:53:56PM +0100, David Laight wrote:
> > On Fri, 26 Jun 2026 14:53:56 +0200
> > Linus Walleij <linusw@kernel.org> wrote:
> >  =20
> > > [Adding Nathan and Kees so we can figure out how best to deal with th=
is]
> > >=20
> > > On Sun, Jun 21, 2026 at 9:15=E2=80=AFPM slipher <slipher@protonmail.c=
om> wrote:
> > >  =20
> > > > Consider the C program for 32-bit ARM architectures:
> > > >
> > > >
> > > > int main() {
> > > >         __asm__ __volatile__ ("BKPT");
> > > >         return 0;
> > > > }
> > > >
> > > > Expected behavior is that this raises SIGTRAP. Since Linux 6.10 thi=
s no
> > > > longer happens; instead execution perpetually resumes at the same
> > > > instruction, using 100% of CPU. It does not matter whether GDB is
> > > > attached. I have tested with an armv7l CPU, but I imagine any other
> > > > variants with the BKPT instruction would be equally affected.
> > > >
> > > > I believe the culprit to be commit
> > > > c3f89986fde7bb9ccc86a901bf28e1f7d69fc3b3 "ARM: 9391/2: hw_breakpoin=
t:
> > > > Handle CFI breakpoints".  The commit defines the method-of-entry co=
de 3
> > > > as "ARM_ENTRY_CFI_BREAKPOINT", but this is the code used for any BK=
PT
> > > > instruction - see
> > > > https://developer.arm.com/documentation/ddi0379/a/Debug-Register-Re=
ference/Control-and-status-registers/Debug-Status-and-Control-Register--DSC=
R-?lang=3Den
> > > > "Method of Debug Entry (MOE), bits [5:2]". If the CFI option is dis=
abled
> > > > in the kernel config,  hw_breakpoint_pending() returns 0 indicating=
 the
> > > > breakpoint was handled, but takes no action. So breakpoints cannot =
be
> > > > used by user-space code, regardless of how CONFIG_CFI is set. The b=
log
> > > > post
> > > > https://www.jwhitham.org/2015/04/the-mystery-of-fifteen-millisecond=
.html
> > > > gives a nice overview of the control flow in older, working kernels=
.   =20
> > >=20
> > > Does simply reverting the patch solve the issue?
> > >  =20
> > > > The following Systemtap script can be used to demonstrate that the
> > > > ARM_ENTRY_CFI_BREAKPOINT path is used, when running the above C pro=
gram.   =20
> > >=20
> > > Yeah it's definitely that one causing it.
> > >=20
> > > I sent the naive solution to it, and before anyone point it out: no i=
t does
> > > not allow custom breakpoints to be mixed with kernel CFI, but it
> > > probably makes legacy systems work on newer kernels since they
> > > probably don't select CFI.
> > > https://lore.kernel.org/linux-arm-kernel/20260626-arm32-cfi-bug-v1-1-=
a467b5050c0b@kernel.org/T/#u
> > >=20
> > > I understand that this is not solving everything. =20
> >=20
> > I'm confused.
> > Why would building a kernel with CFI (to check kernel indirect calls)
> > change the behaviour of executing anything in userspace?
> >=20
> > If userspace is compiled with CFI and gets an equivalent fail then you'd
> > (probably) want a fatal signal - but isn't that entirely unrelated to
> > the kernel code.
> > Do those checks even need kernel support? I know shadow stacks do. =20
>=20
> CFI generates instructions that can check the type of the function
> against the caller. It appears that on 32-bit ARM, Clang close that,
> in the case of a mismatch, it would cause a BKPT instruction to be
> executed.
>=20
> Linus' code in commit c3f89986fde7 ("ARM: 9391/2: hw_breakpoint:
> Handle CFI breakpoints") added code to handle this BKPT use.
>=20
> However, we now have a regression reported as a result of that commit
> where there is a userspace program that has explicit BKPT instructions
> encoded within it, and the program relies on the kernel behaviour that
> was introduced in f81ef4a920c8 ("ARM: 6356/1: hw-breakpoint: add ARM
> backend for the hw-breakpoint framework") in 2.6.37 - and this "new"
> behaviour is conditional on CONFIG_PERF_EVENTS being enabled - where
> it raises a SIGTRAP.
>=20
> Prior to this commit, or whenever CONFIG_PERF_EVENTS is disabled, the
> kernel will raise a SIGBUS instead.
>=20
> Both SIGTRAP and SIGBUS are "forced" signals - the kernel will force
> them to be delivered to the program irrespective of whether the program
> has blocked or ignored these signals, since this is the kernel trying
> to save the system (because it doesn't know how to handle it.)
>=20
> Moreover, BKPT was only introduced around the ARMv5TE era, and the
> FSR code for it was only added in later architecture reference manuals,
> changing an existing FSR code from an implementation defined "Terminal
> Exception" to an architecturally defined "Debug Exception".
>=20
> Support for this "Debug Exception" was only added with patch 6356/1,
> but that did not handle the BKPT instruction. Linus' commit above
> (9391/1) added support for the CFI case, but meant that userspace
> would now spin on a BKPT instruction rather than force a signal,
> thereby causing the regression.
>=20
> We can't fix BKPT handling - this userspace program relies on the fact
> that the kernel doesn't handle this instruction (for example, it relies
> on the PC not being advanced) and advancing the PC by one instruction
> after a SIGTRAP handler returns may not be the correct way to handle
> it anyway. Consider BKPT being used as an "assert" type context, where
> the compiler doesn't expect execution to continue, and a literal pool
> following the instruction.
>=20
> We are now stuck with the sorry state that BKPT is, and as I have said
> many times now, BKPT should be avoided - it's an utter trainwreck. The
> only sensible use that BKPT has is with a hardware debugger that traps
> the BKPT entry into debug mode (a special hardware debugger mode that
> the CPU enters which software can't see).
>=20

I'd probably forgotten a bit in the middle of that.
(Possibly backing up the pc.)
I guess it would need a flag in an elf header/section to set the behaviour
on a per program basis (horrid).

	David

