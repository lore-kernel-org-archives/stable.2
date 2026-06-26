Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA453F1AC9
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 13:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782482041; cv=none; b=sHYjXm6wPVMRZnRbUGGoiBOsgAfLItbPxLsptNaW7lIkF0gQrT7Rdu4p/b3nBQ+mWu0QfCX3fon9spCro0OB7hZKAlrh4Cx5FpN1GgracfvSWY9QsLW+BlAsq1FxhtePTFN2K8mh8NfVT7XembCeyJfiHadi2AASsy1072HZwu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782482041; c=relaxed/simple;
	bh=Ymg67ountFGp5KFG5LV3HpbomYh4sLi7Sd3XabQzjvo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hjOZkyJQVSfyKWcZxZRhu0v2/WhUg3CshXzYLR6cQWJex0XevbEyshv6cpOSt9Q5OLwcN5wbtFahqGJd4hKQB5NAx33oLKe6L4IZjvJHTxDqnoyv54Tu1CEMS62Y26YcseDUv11Xe1NzJxC4xhK5J+aQ3hPMQc1owux8esbvY2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aiV/MC02; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiV/MC02"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49263703c6eso9254695e9.0
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 06:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782482038; x=1783086838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POFjX2Hf+49RKb0BHhcjZkT/UVCjs6ACVOPFKwDMwD0=;
        b=aiV/MC02gz+XelEb4U+vy+g/cygXJFfcDlhL++DCbI3JszriZEt5OwarsoeMsRtCbN
         cFBxjbapt5TRaTktFJb29T2uJto5IhHhOLtnSc2UE1txhBF+f7Pi+VXJA3iy0J8DnqHA
         L5tHq/m6NVaEjNQPtEdrKO1MxkROfb/7u839Y2dVaonoF8FkVDnY3wpRKxJq/AqH1c9r
         2mgHQtL21V02ji1q+FYS2fjv5K8arvsEBtAguTOqvSKkbYe6AjuH5TfXH5jg2Tpr3bbR
         avZ/c9EEb6zn0Gq85OAB/aT9xTsTjAwRnbsgSSXnN1igdMxBjGAIIfII9RmCq4Z0SCxs
         b+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782482038; x=1783086838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=POFjX2Hf+49RKb0BHhcjZkT/UVCjs6ACVOPFKwDMwD0=;
        b=dx0Qgub9EKI/UsDjqsAWf1Tob8eGMWgzbue8SjkGVw+W/kyxuyjfB/+KtHxhBosWw3
         1YtLyqPHajsQ+iXMwKp0fammaMp5ySCVx+/dMQqqaWzGcl0VjYvVJbLC6ESk8844YiMO
         a79ZVmrg9K5iRgW0jT3rHHDUrZySc7RormEim+zen3GXiN4j825Snid+t07phrdvToZ7
         eAfqtBLp7OGNvZsAyHVYWlLMCekhMwjHge++XVCFsJIfe3mpQhRrvodeWeQJFTgKhaYu
         sab0lLzfPc5a30TGADkOapR8bwUsFhIcGfoCAXqUT/HsiITUoqtY3yNP6n02KWpvd8Wj
         8Zow==
X-Forwarded-Encrypted: i=1; AFNElJ9n0oi0O5AcNk+HDkxuS2jkKseN6zNqOUtLTMmGZeqXtZpJFU7NyyR7Ld3DpFfwK0dRst2sT/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN0Ueigq1jt/yLRbXIHmm6k4mCvpHXQ0eiBAnn5roOsJie8iQM
	1mARSEMmmLHyWV/xeDB3BsrPFihHU73mTVhVSEzf0HHq3L1w0VpXTaxE
X-Gm-Gg: AfdE7cmFe7hc/wu0n/6WF0Q/9qOLbnjZ3tE6SLVGvt+lSNzG3+i+JwfqrLROwb1bDFN
	qrbJt/ZmJZ9JvV/OotvGWvAre0C59wKKLUxtzqihgnWb7OtxNfrZ2u0kgKpawxW7Y9OZu8BitgS
	yLi5bEpeWfRJ5vo1NAZqk5gr/827GJGli1nvMWGN7ZlR/s13hDlmJbthUO+FVu5jW9BX9fKO6tD
	B1thPNGT/cLFkamCmOZQKNbmA2Hf+4Ef7vEcRsctgjh//BZxFTAfSYDUidoAKY/docZ+f89jq/C
	RZyran6fRE7YZmcYflTnR927AnY4DQumePcB0JgLiCjcfq4yThRxEnyv7YPIJVYo7e38jFStoqL
	bWfqQPCHbmn0bQH4UWTec/mwQuQOYFUOvXHezLxyQ26qF3zMv1V+8eQ1Wlp/sRmlouesxq/kINV
	ichwgjunYR9CzSO4AvED+QoW0eOT8PI2t6oY0Tl2tbnFClmU5dnA==
X-Received: by 2002:a05:600c:3593:b0:492:6cd0:41b2 with SMTP id 5b1f17b1804b1-4926cd04404mr30657765e9.32.1782482038008;
        Fri, 26 Jun 2026 06:53:58 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926c00a34esm34262945e9.0.2026.06.26.06.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 06:53:57 -0700 (PDT)
Date: Fri, 26 Jun 2026 14:53:56 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Linus Walleij <linusw@kernel.org>
Cc: slipher <slipher@protonmail.com>, Nathan Chancellor <nathan@kernel.org>,
 Kees Cook <kees@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>
Subject: Re: [REGRESSION] 32-bit ARM's BKPT instruction no longer works
Message-ID: <20260626145356.4183d8c5@pumpkin>
In-Reply-To: <CAD++jL=YJGFf+9o8KV+OO_61EL+_z3b7P+eLK=6=r+GOuJiWAg@mail.gmail.com>
References: <kJqktbpLphg_Pk5I5SPptgTLjl3E3eq5mN5UzCslyFj7Q1Irp-wDid4mj5eQVd2iZtRGXgeZd8goq195EkXdjyt864YMc8mVb2B9NGH91NQ=@protonmail.com>
	<CAD++jL=YJGFf+9o8KV+OO_61EL+_z3b7P+eLK=6=r+GOuJiWAg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 26 Jun 2026 14:53:56 +0200
Linus Walleij <linusw@kernel.org> wrote:

> [Adding Nathan and Kees so we can figure out how best to deal with this]
>=20
> On Sun, Jun 21, 2026 at 9:15=E2=80=AFPM slipher <slipher@protonmail.com> =
wrote:
>=20
> > Consider the C program for 32-bit ARM architectures:
> >
> >
> > int main() {
> >         __asm__ __volatile__ ("BKPT");
> >         return 0;
> > }
> >
> > Expected behavior is that this raises SIGTRAP. Since Linux 6.10 this no
> > longer happens; instead execution perpetually resumes at the same
> > instruction, using 100% of CPU. It does not matter whether GDB is
> > attached. I have tested with an armv7l CPU, but I imagine any other
> > variants with the BKPT instruction would be equally affected.
> >
> > I believe the culprit to be commit
> > c3f89986fde7bb9ccc86a901bf28e1f7d69fc3b3 "ARM: 9391/2: hw_breakpoint:
> > Handle CFI breakpoints".  The commit defines the method-of-entry code 3
> > as "ARM_ENTRY_CFI_BREAKPOINT", but this is the code used for any BKPT
> > instruction - see
> > https://developer.arm.com/documentation/ddi0379/a/Debug-Register-Refere=
nce/Control-and-status-registers/Debug-Status-and-Control-Register--DSCR-?l=
ang=3Den
> > "Method of Debug Entry (MOE), bits [5:2]". If the CFI option is disabled
> > in the kernel config,  hw_breakpoint_pending() returns 0 indicating the
> > breakpoint was handled, but takes no action. So breakpoints cannot be
> > used by user-space code, regardless of how CONFIG_CFI is set. The blog
> > post
> > https://www.jwhitham.org/2015/04/the-mystery-of-fifteen-millisecond.html
> > gives a nice overview of the control flow in older, working kernels. =20
>=20
> Does simply reverting the patch solve the issue?
>=20
> > The following Systemtap script can be used to demonstrate that the
> > ARM_ENTRY_CFI_BREAKPOINT path is used, when running the above C program=
. =20
>=20
> Yeah it's definitely that one causing it.
>=20
> I sent the naive solution to it, and before anyone point it out: no it do=
es
> not allow custom breakpoints to be mixed with kernel CFI, but it
> probably makes legacy systems work on newer kernels since they
> probably don't select CFI.
> https://lore.kernel.org/linux-arm-kernel/20260626-arm32-cfi-bug-v1-1-a467=
b5050c0b@kernel.org/T/#u
>=20
> I understand that this is not solving everything.

I'm confused.
Why would building a kernel with CFI (to check kernel indirect calls)
change the behaviour of executing anything in userspace?

If userspace is compiled with CFI and gets an equivalent fail then you'd
(probably) want a fatal signal - but isn't that entirely unrelated to
the kernel code.
Do those checks even need kernel support? I know shadow stacks do.

	David

>=20
> If it is under all circumstances unacceptable to be able to construct
> a userspace which will change the user-facing behaviour of BKPT,
> I think we need to revert CFI breakpoint handling, back put the patch,
> disable CFI on ARM and wait for the compiler(s) to start behaving
> differently on ARM.
>=20
> CFI folks: any ideas on what we could do instead of BKPT
> when we hit a CFI snag? Any ideas from other architectures?
>=20
> Yours,
> Linus Walleij
>=20

