Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF76F469842
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 18:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791829574; cv=pass; b=fdw54vJK/4DWl7m92wf5QNxJW41gkzQJEIPcp25kj1paegJdkXN7yEI5sPxlTN7y3JhbuOw9a0Je04G0Qx2NhweDowq3vXec8ef1Jh3U1UXk39IMh5fA0YZWF0Xn2VwasWvRZDbVazsOfUiNojcYCeGFdP55VALkWG2farkwypw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791829574; c=relaxed/simple;
	bh=i4NUyyNT6Z+Ov6SBreB/v9GEhH7h3KQp3Gl3VKlI4o0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OcKsOWRPNBiu4Erf8qNxkHPyUQhUx35usSolXJuH19jCx0J0GjI6FBbwCn77XwPgoCTgS8oMfVpJGPvtGzutmiUdGdFs1LsDoj1HJ9qZT7mNYKsUDvBNy0hwKNuJhR1G2lTkdqoRz/2x0F59CC2r4/Rnn4yM2KfIgjD4X6YrVPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/CJ+866; arc=pass smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/CJ+866"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-78fb1fb9508so3757639137.1
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 11:26:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791829572; cv=none;
        d=google.com; s=arc-20260327;
        b=kVntegGPe02RN5c7XpTwZvukI7Ji/ww+TZ5opk9bJqc/688i4G2K2X9Jr7NTxR7GoJ
         SI0fDV+xu1uiAgmGW052TDVXrI7SdKYuk6lT4mirj0pCPBx8TtZkhk7dw2Daa+08DXXf
         sNNdtyDter3fLBCMYksRHuYub9Dh+fdzBFZ6fFY+y1JjWvoo0LPkKcT9aU0kQAKmgyG3
         FYhyD1GRrBkJaA7ZkIrpA/ROLCFdnxj2GAfiG9cK3UaM1I7JTwvzsea//J351r6WVl//
         6Ae4WYsbg7TeQknefau7HwmTQYkPlZ466J2OCMT9SQHy7hMkOaItq5T8lc59XFD+n3ep
         eChw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uS0kC1tZmKLnFAc3gpM2J8lvwjycam1N7G0nExBvzCY=;
        fh=5yhFSzge6SXOc9XnoPrWgjXRKqBEAHsr5PpckLHDaTI=;
        b=pQTi5uqmA7N1/RP4YeYeAT105NEcyC5TvCsWBYWBjVum8PTYuOklDAPMz7KmQZrNAR
         tG5NKxUwyO6I4p50Du4BaaVw3NGL01YifMWuNygLnQhw+H3SlR5fepKCGJ5TEH2EsmEq
         5rcGjuRtcJ98DRXZ4PiZcWR3Qv81IEmkCLnkF3RoIfwOmSTghMCL55fjG8w5Jm5btNJo
         VbUH6qYFWGRE3i7Gs2MrwbJV7e6OKFeDqkDQkADvVBFZ4X+Y/9lyXdeVkW0qdMIhvbw2
         9y8pfgh21PQSaxuW5/AVb0DOB+rAUKckKg33PSUh4ztSjIS27kKKR10HrzqbogQyCRt9
         y0ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791829572; x=1792434372; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uS0kC1tZmKLnFAc3gpM2J8lvwjycam1N7G0nExBvzCY=;
        b=E/CJ+866mDD9tPBP5rjqFjDvRDpM3D+vLunz9Xw5ApPH0nmIfO8Uy+qfdxfbTFGT/P
         JRbHjRrqXLoHiuLU3mbwqcicRl+t9AwJ3hSPydpLu02luNc14zkyK2pb4NHa0H0GUqYG
         R05RzOOZw/DAuOLo9QtQdjSP+H8deyC0lueJBnoXDkbJECkgkfrZfxc0aH32iHMs4Evk
         Qjg7iHQ3lSH0SjNttIlrV3dMX05xgbKDxbR2x3uQ4IQfziHwApHdjnDEfcehkknC8YhQ
         mZ3DtAZvnGniWoShUqf0wTSDxdc9L1OAHVBOpcDOkWdlAGuEVsqF0ZT+rae/GfRDxpz1
         V+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791829572; x=1792434372;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uS0kC1tZmKLnFAc3gpM2J8lvwjycam1N7G0nExBvzCY=;
        b=VYSuGPVoxcliI8rcZWgHenbY+XN0t9hviffIp0O0Zm2rD9KBphP/zu87LuFCecESiK
         vSs4jjImksAE79wufwXJFEs2XtmXzx0yFRh3hGQsL8GhU6FTIvYgApsPnV4mwJ7/WyRS
         Is+aGEj4XNsELbZn/ZP0TPPFckl33VVVF9rrZQS3gIWrXUIKOzojfayTviGbXGjh1b7o
         xkc33mYP9CFpeeoa03QAZqRxJN6uAcou5N0pyJxq4TleHqPLdBWQqxg61w8yn++JbxDO
         uFxRfFpt1lLzB0YGMuaRukJKgBBmD06InS7t5eJamLSzr60ppq0tgZv6ZxT00Y7gv+9I
         L/Pg==
X-Forwarded-Encrypted: i=1; AKwUvBycp1lz3Ri2/yWK76/dwv8ZFrnCFg7q3yHysyv3PQmJm2xjcso44AN1OV55vRNqHJXTHtyxKhk=@vger.kernel.org
X-Gm-Message-State: AFq9FYI7rsHJQF0i+70fguGRbYx1DcviP1mlffwSVxyYDaJwKU5PZMkH
	jll94vh+gR2bGoiBMuzgurPE7KaWuj1xf8mAIgFs3MBPOF8Lv3nWuHFOY4jYowFYOqJJ4ABGu5F
	ftHusHmZ10tRRRxWdwDlAhxxGhZGyg/o=
X-Gm-Gg: AYBFou07NnDQ3DurDNJqFKy1zJlEcOXPJjk4+vTZa1ze83uhlSFZRd3vHuwa7gfl06M
	al5ZzSVin3B3O5GPY+0QWZ7T9Slqsz8aS2eP1xuUz6gKfg0KEjfV4Qq+y1Gv/H87EUnyo/uixpU
	yyTBItTCuqfmTIJ/CLHS5ZO/L+KcttiUg/OW/fyfUqLG3eAG+XX56Ryc7O5tq/RAKjA1P934Tx1
	EilduYJwSHbO5rvzgTtMkgqz7ODa4VnwHZoejQ7e4N3sEjmTwc1lsUVBWcEnqDCx27MK2Eib8ez
	j0guBDPTY5xIP9j66wSmdBA6IHiwNLjTU5kVtrr/1Kv/9ozBCIAptgxQISccCbzb5567LpqqAhx
	8/nONXOESO7aYeBE26efPcT+hhUGjHP4rXFXIp3/dgm4j0ER7RVWoRhLKg6xT5B7yMNRoKBVPuE
	f74qOVI3d2tc/Pon0G34FDd7LOGdpYr6U9+eZddJTSSZq7
X-Received: by 2002:a05:6102:370f:b0:798:24e8:23f4 with SMTP id
 ada2fe7eead31-7cb42a03e2dmr2294757137.7.1791829571647; Mon, 12 Oct 2026
 11:26:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914-submit-sunxi-nand-vendor-oob-layout-v1-v6-0-2fb084fe0751@gmail.com>
 <20260914-submit-sunxi-nand-vendor-oob-layout-v1-v6-1-2fb084fe0751@gmail.com> <8733ua23xs.fsf@bootlin.com>
In-Reply-To: <8733ua23xs.fsf@bootlin.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 12 Oct 2026 12:26:00 -0600
X-Gm-Features: AclHuK-YE9EZvdISkdO2ItcawmmP4G9wFY0yyJFRi71wZBtPLVkiWianJdKsR5A
Message-ID: <CADvTj4pmtGZ4c04q+5AE3trrfshToD7BPtF-8kPxPRZ25hOTRw@mail.gmail.com>
Subject: Re: [PATCH v6 01/18] mtd: rawnand: sunxi: drain interrupts before
 reusing the completion
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Maxime Ripard <mripard@kernel.org>, Richard Genoud <richard.genoud@bootlin.com>, 
	Masahiro Yamada <yamada.masahiro@socionext.com>, Boris Brezillon <bbrezillon@kernel.org>, 
	Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 12:02=E2=80=AFPM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> Hi James,
>
> On 14/09/2026 at 15:09:47 -06, James Hilliard <james.hilliard1@gmail.com>=
 wrote:
>
> > A timed-out wait can return while the interrupt handler is still using
> > the previous operation's interrupt status and enable mask. Starting the
> > next wait calls init_completion() on the same object, which can reset i=
ts
> > waitqueue lock while the old handler calls complete(). The old handler
> > can also complete the new wait or restore an obsolete interrupt mask.
> >
> > Initialize the completion once in probe and use reinit_completion() for
> > each interrupt-driven wait. On timeout, disable and synchronize the IRQ
> > before masking controller interrupts and acknowledging the waited-for
> > events. Draining the handler first also prevents a partial-event handle=
r
> > from rewriting the enable mask after it has been cleared. Flush these
> > register writes before re-enabling the IRQ line, leaving the controller=
's
> > interrupt sources masked.
> >
> > For successful waits, move complete() after the handler's register upda=
tes
> > so that the next operation cannot race with those updates. Keep polling
> > unchanged and leave controller and DMA abort handling to the existing
> > callers.
> >
> > Fixes: 1fef62c1423b ("mtd: nand: add sunxi NAND flash controller suppor=
t")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
>
> So from the commit log I understand that you are fixing a race. The
> problem seems legitimate.
>
> >  drivers/mtd/nand/raw/sunxi_nand.c | 26 ++++++++++++++++++++------
> >  1 file changed, 20 insertions(+), 6 deletions(-)
> >
>
> ...
>
> > @@ -414,12 +416,13 @@ static irqreturn_t sunxi_nfc_interrupt(int irq, v=
oid *dev_id)
> >       if (!(ien & st))
> >               return IRQ_NONE;
> >
> > -     if ((ien & st) =3D=3D ien)
> > -             complete(&nfc->complete);
> > -
> > +     /* Finish updating the interrupt state before waking the next ope=
ration. */
> >       writel(st & NFC_INT_MASK, nfc->regs + NFC_REG_ST);
> >       writel(~st & ien & NFC_INT_MASK, nfc->regs + NFC_REG_INT);
> >
> > +     if ((ien & st) =3D=3D ien)
> > +             complete(&nfc->complete);
> > +
> >       return IRQ_HANDLED;
> >  }
> >
> > @@ -435,16 +438,19 @@ static int sunxi_nfc_wait_events(struct sunxi_nfc=
 *nfc, u32 events,
> >               timeout_ms =3D NFC_DEFAULT_TIMEOUT_MS;
> >
> >       if (!use_polling) {
> > -             init_completion(&nfc->complete);
> > +             reinit_completion(&nfc->complete);
>
> The whole change around (re)init_completion looks relevant (here and in t=
he handler).
>
> >
> >               writel(events, nfc->regs + NFC_REG_INT);
> >               ret =3D wait_for_completion_timeout(&nfc->complete,
> >                                               msecs_to_jiffies(timeout_=
ms));
> > -             if (!ret)
> > +             if (!ret) {
> > +                     /* Drain the handler before it can restore an old=
 IRQ mask. */
> > +                     disable_irq(nfc->irq);
>
> disable_irq() for serializing accesses to a single register?

The intention was to drain an in-flight handler before cleaning up the
timed-out wait, rather than just serialize the register write.
disable_irq() provides that synchronization as well as masking the line.
It is only used on timeout, and this IRQ is requested without IRQF_SHARED.

A spinlock could also address this, provided it covers the handler's
status/enable reads through complete(), together with the waiter's
cleanup and rearming. Protecting only the register writes would leave
the handler able to act on an old snapshot.

> It
> certainly works but I don't think it is so common to use it like that,
> for such simple cases. Typically in this case I would have used a
> spinlock maybe? Or even better, why not just avoid the race entirely
> and handle the register in the waiter?

One detail to account for is that the MBUS DMA path waits for both
NFC_CMD_INT_FLAG and NFC_DMA_INT_FLAG. The handler currently acknowledges
and masks each event as it arrives, leaving the remaining event enabled
until both have completed.

Moving the register handling to the waiter would therefore need to
preserve partial-event tracking and avoid leaving an asserted interrupt
source enabled while waiting for the task to run.

> You certainly don't need to write
> it in the IRQ handler. You can handle the IRQ configuration at the
> device level, which will also prevent the need for your extra
> readl "barrier" before enabling the IRQ.
>
> Furthermore, now that I have a better understanding, re-reading the
> commit log, I now disagree with the first part of:
>
> >The old handler can also complete the new wait or restore an obsolete in=
terrupt mask.
>
> "complete the new wait"? I don't see how a stale handler completes the
> next wait given the handler is a hard IRQ and the interrupt enable
> register is cleared on timeout.

The case I had in mind is an already-running handler on another CPU:

CPU 0: Read st and ien for operation A.
CPU 1: Time out operation A, mask/acknowledge its interrupts,
       then eventually reinitialize the completion for operation B.
CPU 0: Call complete() based on the saved st and ien from operation A.

Clearing the device's enable register does not invalidate those local
values or wait for the running handler to finish. Hard-IRQ context
prevents this overlap on the same CPU, but not across CPUs.

That distinction was not explicit enough in the commit message. I'm
open to a different implementation; the requirement I wanted to preserve
is that the old handler cannot update the mask or signal the completion
after the waiter has cleaned up and reused it.

>
> Thanks,
> Miqu=C3=A8l
