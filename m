Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27523890F0;
	Wed,  8 Jul 2026 10:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783505269; cv=none; b=Z0dmoCCCWX13YvTxIbN/da5UmNTtXNNiOfzZBRGW3A9xybdeRqZit/K0ruGJULJniNDFrIjKNpoMWFzUk9KbVcyWfHJ9QE/3fy/2T+9YjaSmnhinkZsE1wUX0BJs45ERyTBepnf7WCNMacOV7+ELXXlbJDtzVKRJClVyY7LBZGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783505269; c=relaxed/simple;
	bh=qRfICO+zSRYi7qGYt9Oniq8is/xiGOo6Y50prqMdBQo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g94hPT5Rws/+JGT/XhtSMo5hJv3G0lP+9bhJ4pCAqRen/5oTRd0Z8GlOhyqknYMmurVak14lKVf61qKQIixHfOiBUtPKX3it3shDi5T9MFbT4f8vMZA6oUpMZ6LVHdQnOlBCYkx0EiQQycCZX82RijawQnLqPIHC/dVX5wtafqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=arfSaPPa; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="arfSaPPa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1783505251; x=1783764451;
	bh=8AxW5UCVB9I4ZEmDnXWZt7AxoAiw3x+AAtvOHLu6Hgg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=arfSaPPakPaNeAXqtZOtRvJD30MJNLmGd/c2hxmASJY84RPOmnifqQCcZgTHfeAOX
	 OZ/bdF3dFif9P9zO+cIxhQFZlJriFucxJG18LJndXc93eM11cbDPfF//Cj1nkgEgBv
	 rf6pGhJXW3EtoT8iyFELZBXalNGSUx/Pj4PnYRDJMvO+qsy2R9tuAT/kb901jI2LcX
	 Bz85ANRxx+q3ouiLWE8Z1jLh7Uhhe8Usu8h+ECdFD6xNO6Ff/oAZkB/jPQZbNbwH7E
	 irL/F1MSs9t7VUYaZgWISvME/zXSyqq2bzgVfVyIjY9u+mQkFmv9MenwUF74dIwnc+
	 Tg4E/PW2r9x1w==
Date: Wed, 08 Jul 2026 10:07:27 +0000
To: Linus Walleij <linusw@kernel.org>
From: slipher <slipher@protonmail.com>
Cc: Russell King <linux@armlinux.org.uk>, Nathan Chancellor <nathan@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] ARM: breakpoint: CFI breakpoints only on demand
Message-ID: <qlzOoC3H1cezSCgEcSHFAsIzjIpiey39PPOkvJETHWONt4zEGNKvfAvczIlUrGK_d97QWDAzUcu8XEN1nMtAVjF09P78iJ2DWEB4LmsWQNs=@protonmail.com>
In-Reply-To: <20260703-arm32-cfi-bug-v4-1-c26acb640a8f@kernel.org>
References: <20260703-arm32-cfi-bug-v4-1-c26acb640a8f@kernel.org>
Feedback-ID: 10906495:user:proton
X-Pm-Message-ID: 4dda027aceb9c323b5aa45b7394259e04fd93134
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Friday, July 3rd, 2026 at 7:25 AM, Linus Walleij <linusw@kernel.org> wro=
te:

> This removes the stub hw_breakpoint_cfi_handler() from ARM, making
> it not steal breakpoint type 0x03 (ARM_ENTRY_CFI_BREAKPOINT) unless
> CFI is actively used in the kernel.
>=20
> When not instrumenting with CFI, or when a breakpoint is issued in
> userspace, we fall through to return 1 from hw_breakpoint_pending()
> "unhandled fault" so userspace can make use of this breakpoint.
>=20
> Tested with LKDTM and this command line:
> echo CFI_FORWARD_PROTO > /sys/kernel/debug/provoke-crash/DIRECT
> still works as expected.
>=20
> Fixes: c3f89986fde7 ("ARM: 9391/2: hw_breakpoint: Handle CFI breakpoints"=
)
> Reported-by: slipher <slipher@protonmail.com>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Closes: https://lore.kernel.org/lkml/kJqktbpLphg_Pk5I5SPptgTLjl3E3eq5mN5U=
zCslyFj7Q1Irp-wDid4mj5eQVd2iZtRGXgeZd8goq195EkXdjyt864YMc8mVb2B9NGH91NQ=3D@=
protonmail.com/
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
> Trying to solve the CFI bug. Let's see of this first
> approach is acceptable for the reporter.
> ---
> Changes in v4:
> - Dodge the BKPT if we are coming from userspace!
> - Would be great if the reporter can test this with and without
>   CONFIG_CFI.
> - Link to v3: https://patch.msgid.link/20260701-arm32-cfi-bug-v3-1-e3c37e=
2b80a4@kernel.org
>=20
> Changes in v3:
> - Actually strip the RFC prefix...
> - Link to v2: https://patch.msgid.link/20260701-arm32-cfi-bug-v2-1-9bf922=
593e00@kernel.org
>=20
> Changes in v2:
> - Resending as non-RFC so it can be applied as a band-aid.
> - Link to v1: https://patch.msgid.link/20260626-arm32-cfi-bug-v1-1-a467b5=
050c0b@kernel.org
>=20
> To: Will Deacon <will@kernel.org>
> To: Mark Rutland <mark.rutland@arm.com>
> To: Russell King <linux@armlinux.org.uk>
> To: Kees Cook <kees@kernel.org>
> To: Sami Tolvanen <samitolvanen@google.com>
> To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
> To: Linus Walleij <linusw@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/arm/kernel/hw_breakpoint.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpo=
int.c
> index cd4b34c96e35..38feb30dfb5f 100644
> --- a/arch/arm/kernel/hw_breakpoint.c
> +++ b/arch/arm/kernel/hw_breakpoint.c
> @@ -929,10 +929,6 @@ static void hw_breakpoint_cfi_handler(struct pt_regs=
 *regs)
>  =09=09break;
>  =09}
>  }
> -#else
> -static void hw_breakpoint_cfi_handler(struct pt_regs *regs)
> -{
> -}
>  #endif
>=20
>  /*
> @@ -964,9 +960,14 @@ static int hw_breakpoint_pending(unsigned long addr,=
 unsigned int fsr,
>  =09case ARM_ENTRY_SYNC_WATCHPOINT:
>  =09=09watchpoint_handler(addr, fsr, regs);
>  =09=09break;
> +#ifdef CONFIG_CFI
>  =09case ARM_ENTRY_CFI_BREAKPOINT:
> -=09=09hw_breakpoint_cfi_handler(regs);
> +=09=09if (user_mode(regs))
> +=09=09=09ret =3D 1; /* Don't handle userspace BKPT */
> +=09=09else
> +=09=09=09hw_breakpoint_cfi_handler(regs);
>  =09=09break;
> +#endif
>  =09default:
>  =09=09ret =3D 1; /* Unhandled fault. */
>  =09}
>=20
> ---
> base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
> change-id: 20260626-arm32-cfi-bug-10fb960749c4
>=20
> Best regards,
> --
> Linus Walleij <linusw@kernel.org>
>=20
>=20

I tested the program experiencing the regression with this patch applied to=
 v7.2-rc2. It works with and without CONFIG_CFI. Thank you everyone!
