Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653423B637E
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 12:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782478452; cv=none; b=Yew0f2Trg12twgDE6Iukdjhw2+H8dJRSI3nDVwHJNIbcYyHCRlOsmvH8YnH+gEEAEOBM31EfnYcKq8GTg9la8iWATq0YFQBBQwqoeKGT4EQ18GbzbpRXI+xDP6u0t+C6Npy5zM7XV8Kce0tYU2jMg1OPk2OkNIEZ2dr7XP6L0T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782478452; c=relaxed/simple;
	bh=v/aB+4XObJl2hgdsV4eb6n+rU8/fCF9koyw0AyTg5GA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OSTFKcofBstsBvU30gdYxeKmm6XYOdibILjr1TwNQcmdgXgosuKJw7PypQlvvBXTK8kXFwsZzFazeL1m6HHmF8V4NYky4puW1f5Qcotadzes69ZyIbI2Wo5wnqb5fYQnVLbDTxTGrUrSBAHduCcAh5H6TPGULzpZ0+/TvpF3oCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5dqnI/z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5dqnI/z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1FB1F000E9
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 12:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782478451;
	bh=gOZngT+Ri4gGCfrzkPoShqljnzYJYp5zUHHKBBaWlgo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=P5dqnI/zegeuNH9Nt4PbfYssL9dYV9fSLDJgSoVAccD9VUg1Bbjud/5WCoBvJYDJ+
	 mB9fBTHEY3nsEqY9C2JksyB0BjMyOozYcYEP+YtuL4z2/R+1dFlJoIbCAw+Pxi6QDv
	 gkwmSd7tUc3lU1+jOyw6dDpiC8O4wWVOSc7nKr7Et7g7kQjSYaSegZzaba8bjpGCja
	 K1qBEKyY73P/8n4T79T6jb/Km+yckkEC2AJ6jKpb5svp4VV38hlngcT/TJgmM+X4pK
	 X8YNXYLuEr0GciW1VoIJKkAPlxCpLQP257Xdr/vcoIJjhQNyJ1g+Rlh7QbmAeZKl1k
	 fs61s4/srWrxA==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5ad5e719157so808649e87.2
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 05:54:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoPoBgi9U29GE1cxm662L/ZCT6p0o7QfiTEVcLtShxRL0+0XqUNx8UMgoKQ4ZalYmtFgk0sk7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh4INp+XjajQlxwz/OHnmx2My2fwjTgLwE003GfO0+RSRsSxiI
	SJQy7iop9FF+fkn1ZW1ht3gLg7idpZ12NncXCDj8DJHL43RawdnnMwDz9k7cldoZyGkdOiX7AIy
	1b1RvVFHDcTg1kr7ETzJQVpI9KSzBIWg=
X-Received: by 2002:a05:6512:6712:b0:5ad:4ebc:e072 with SMTP id
 2adb3069b0e04-5aea1f293e2mr2033119e87.11.1782478450038; Fri, 26 Jun 2026
 05:54:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <kJqktbpLphg_Pk5I5SPptgTLjl3E3eq5mN5UzCslyFj7Q1Irp-wDid4mj5eQVd2iZtRGXgeZd8goq195EkXdjyt864YMc8mVb2B9NGH91NQ=@protonmail.com>
In-Reply-To: <kJqktbpLphg_Pk5I5SPptgTLjl3E3eq5mN5UzCslyFj7Q1Irp-wDid4mj5eQVd2iZtRGXgeZd8goq195EkXdjyt864YMc8mVb2B9NGH91NQ=@protonmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 26 Jun 2026 14:53:56 +0200
X-Gmail-Original-Message-ID: <CAD++jL=YJGFf+9o8KV+OO_61EL+_z3b7P+eLK=6=r+GOuJiWAg@mail.gmail.com>
X-Gm-Features: AVVi8Cf7mdL5Xz9eEcaUEG2_vqpf6O9ZpYfxv2z6UZl9xqnxBWGbraHskpl3Kmc
Message-ID: <CAD++jL=YJGFf+9o8KV+OO_61EL+_z3b7P+eLK=6=r+GOuJiWAg@mail.gmail.com>
Subject: Re: [REGRESSION] 32-bit ARM's BKPT instruction no longer works
To: slipher <slipher@protonmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Kees Cook <kees@kernel.org>, Sami Tolvanen <samitolvanen@google.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>, 
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>, 
	"rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[Adding Nathan and Kees so we can figure out how best to deal with this]

On Sun, Jun 21, 2026 at 9:15=E2=80=AFPM slipher <slipher@protonmail.com> wr=
ote:

> Consider the C program for 32-bit ARM architectures:
>
>
> int main() {
>         __asm__ __volatile__ ("BKPT");
>         return 0;
> }
>
> Expected behavior is that this raises SIGTRAP. Since Linux 6.10 this no
> longer happens; instead execution perpetually resumes at the same
> instruction, using 100% of CPU. It does not matter whether GDB is
> attached. I have tested with an armv7l CPU, but I imagine any other
> variants with the BKPT instruction would be equally affected.
>
> I believe the culprit to be commit
> c3f89986fde7bb9ccc86a901bf28e1f7d69fc3b3 "ARM: 9391/2: hw_breakpoint:
> Handle CFI breakpoints".  The commit defines the method-of-entry code 3
> as "ARM_ENTRY_CFI_BREAKPOINT", but this is the code used for any BKPT
> instruction - see
> https://developer.arm.com/documentation/ddi0379/a/Debug-Register-Referenc=
e/Control-and-status-registers/Debug-Status-and-Control-Register--DSCR-?lan=
g=3Den
> "Method of Debug Entry (MOE), bits [5:2]". If the CFI option is disabled
> in the kernel config,  hw_breakpoint_pending() returns 0 indicating the
> breakpoint was handled, but takes no action. So breakpoints cannot be
> used by user-space code, regardless of how CONFIG_CFI is set. The blog
> post
> https://www.jwhitham.org/2015/04/the-mystery-of-fifteen-millisecond.html
> gives a nice overview of the control flow in older, working kernels.

Does simply reverting the patch solve the issue?

> The following Systemtap script can be used to demonstrate that the
> ARM_ENTRY_CFI_BREAKPOINT path is used, when running the above C program.

Yeah it's definitely that one causing it.

I sent the naive solution to it, and before anyone point it out: no it does
not allow custom breakpoints to be mixed with kernel CFI, but it
probably makes legacy systems work on newer kernels since they
probably don't select CFI.
https://lore.kernel.org/linux-arm-kernel/20260626-arm32-cfi-bug-v1-1-a467b5=
050c0b@kernel.org/T/#u

I understand that this is not solving everything.

If it is under all circumstances unacceptable to be able to construct
a userspace which will change the user-facing behaviour of BKPT,
I think we need to revert CFI breakpoint handling, back put the patch,
disable CFI on ARM and wait for the compiler(s) to start behaving
differently on ARM.

CFI folks: any ideas on what we could do instead of BKPT
when we hit a CFI snag? Any ideas from other architectures?

Yours,
Linus Walleij
