Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0283546C9
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786519755; cv=none; b=KTqs2rTxs7XcgiHw3rY9+ueJgL1KBuibZdB2s240tQepWRxOV5OZvgiQN4jnqdMvHeeEZIJZ810R9MqAmw8IYKUQGUy5UePG/w6eBL17ZgcUmy0BfLEDKtafk0F3PVV+vNHyEXtvLc02sbY9W7+naxHe/vxk7kCJmIAsqHOfyZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786519755; c=relaxed/simple;
	bh=4wYPvCbTq/8BkD2bsvkf5s7HshKHTy5IG6ljzWwvcaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=etyo76NbAxlojGctjjpTwHq4S2b6u+eUGExhXYZfL8NW88sXP0CxG0yhUG8FEG9Y1yv52NrvSEBKjucEdTStzDHJKFLhhDer9oa4+GGGKhFN8mcDHvtYxsUFe0IKQRt+ELnTBNotNYvpFkYXFMBQO7+bSR9y+PeIaRrbWMMfn98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPSkYXKS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPSkYXKS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6721F00A3F
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 07:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786519752;
	bh=4wYPvCbTq/8BkD2bsvkf5s7HshKHTy5IG6ljzWwvcaI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=MPSkYXKSjFROOmHtlJBFofz4meQ5xG35mJ+r5QQPY/2VMVNmHNQ60I7VBIR8FJItN
	 qlcUNGDidxt91y5xNJgqqfRXCn1I3vjhuCZy2I8seQI9YwSJa43rFOrjLzQsUpMpne
	 TW2Rc/InlAsg92iRrunY67TSb5ecpjVeDUEAsuWQgu+2h2HnK92rqb+zj1N/990z5D
	 VgNqRVm413H5q5TgjuYCUGjCYH3sIXCbmxZqvkyYSJyaqux5i0RO9+1f7dolT/4TPI
	 +xDlmOGaLy+4AhJdVaP+kLGeF3HXXtqrxJ5d+r2E7zV/t2/ZXfqxSqJz98yrpgGi1n
	 USFtfv7pDuiaw==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3a0f1e57254so5319631fa.1
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 00:29:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqHMwuYOOOoju4SUMgqAgNO3PQbvR62Lp0uk4hx08oxOfcPRWZULTsgsA1L7S5fsK9weXTjTpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSQQJ+Qwtgs2g4rHFMQ9ROi4AL+aoyMsOOs/1ij7OvqTZ6pmh4
	ugOO4MOsDbhbbNOZzhIbSUmuCQ6tbsLaRWU4lVHy6ftlZiF5v6AU0rxuP/Dn1UD5s4olagxnciz
	oKkJMpwM2AanZ2jMwo1Rk3EHJy9Qh8cg=
X-Received: by 2002:a2e:bc0a:0:b0:39c:6d58:a6e3 with SMTP id
 38308e7fff4ca-3a10d57f6c7mr2289731fa.21.1786519751181; Wed, 12 Aug 2026
 00:29:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811164528.65747-1-kmehltretter@gmail.com>
In-Reply-To: <20260811164528.65747-1-kmehltretter@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 12 Aug 2026 09:28:59 +0200
X-Gmail-Original-Message-ID: <CAD++jLmVQw15yW2+En2FwZsq7qxUGy8B7xv8QvFSYCybTuZ14A@mail.gmail.com>
X-Gm-Features: AUfX_mySWsnAe9XtBvawNadOQALKRD0MZYPbPofiyEVi3GwFSKQx95g1Gz4umsY
Message-ID: <CAD++jLmVQw15yW2+En2FwZsq7qxUGy8B7xv8QvFSYCybTuZ14A@mail.gmail.com>
Subject: Re: [PATCH RESEND] ARM: alignment: restore uaccess state on emulation fault
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>, Ard Biesheuvel <ardb@kernel.org>, 
	Florian Fainelli <f.fainelli@gmail.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 6:45=E2=80=AFPM Karl Mehltretter <kmehltretter@gmai=
l.com> wrote:

> The alignment handlers enable access to user memory while emulating
> unaligned instructions. If a checked access faults, its exception table
> fixup jumps to the handler's fault label and bypasses uaccess_restore().
> This leaves DOMAIN_USER as DOMAIN_CLIENT with SW domain PAN, or leaves
> TTBR0 page table walks enabled with TTBR0 PAN, while the fault is handled=
.
>
> An ARM926 QEMU test using LDMIA across an unmapped page boundary reports
> DOMAIN_USER=3D1 at TYPE_FAULT before this change and DOMAIN_USER=3D0 afte=
r it.
> SW domain PAN is the default on ARMv5, ARMv6, and non-LPAE ARMv7 builds.
>
> Keep the saved uaccess state at function scope and track whether it was
> saved. Restore it at the fault label only when needed. Paths that did not
> enable user access continue to skip the restore.
>
> Fixes: 274e91b81ed2 ("ARM: alignment: fix alignment handling for uaccess =
changes")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Wow nice patch!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Please put this patch into Russell's patch tracker so he can
apply it!
https://www.arm.linux.org.uk/developer/patches/

Yours,
Linus Walleij
