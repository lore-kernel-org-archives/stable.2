Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5409841D635;
	Mon, 12 Oct 2026 19:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791832006; cv=none; b=Zsyc/fhS1vceCGg84bA010pGpoMVr6MsOx8jqdv6H2eZOSTpRQOYYAia7zP1RyIdVW5nXrSD+w69bbRYxNeEvJ08k7qMXMYoPgiIjV3htxGP1ROoV+EaEVonIAIHttEHmgE8uNnQxRERZtL54Y6YZ0SZ8ADb2epH2U0Tkl24G3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791832006; c=relaxed/simple;
	bh=qc27dw1bGRtz0RsRjqoL5oDeZuL03UbAX3nPsjTnkxU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jp7rwQybW2GZMIVtZ+KruPxM1CbGZxKkKm1+FaCwHDy/L5IYhmE6QLv+XAsARERbzc4SsCJxr5ONcgxCyabQ0cCh1kQcjilA8NHJUx6YyaaiEPY9UgmNKQ4LT87/YZERBw5KUxiZTzXU1W9gbs1dUWSYp3MtSS5SrOkgOtKy5tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vS3NyB/2; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vS3NyB/2"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 960321A11EB;
	Mon, 12 Oct 2026 19:06:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2603C601A6;
	Mon, 12 Oct 2026 19:06:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EFFD411D70CA7;
	Mon, 12 Oct 2026 21:06:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791831996; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Bw7bv2pnfae4cMWiRM1MW1DbGUPZqrWolE0VMUTTkds=;
	b=vS3NyB/2AQirlZc3zwonhlMtCW4/+Tm5UyQ7Um01rVmMrRno6RPzmzdCh8FU2cjHcaW3Th
	5uHwUXZRnhNN+3Cnipgeglik203ebVueIHnAIS4Hdssa3eZ9OSIENz9o4BHC3Pl0W9YKh1
	ne1qHRrPxjWs35WdViC8YO02zulN+MPqxYAUsTBHzZdQnrFaJL8K6+Dq6Wtr283XK1AFos
	WWDG4W+AMdAIsRWfVef557tOkwe5WQNGfxMhePfq0y2CeEusWB8KA6k1vUaPBkidP1enHT
	iPPJK8u8FDOfHxS8g3M7M0oVbJvFQ52fVNjzQIIX4EsLCpXM82TAyDtK9a84Gw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Chen-Yu Tsai
 <wens@kernel.org>,  Jernej Skrabec <jernej.skrabec@gmail.com>,  Samuel
 Holland <samuel@sholland.org>,  Maxime Ripard <mripard@kernel.org>,
  Richard Genoud <richard.genoud@bootlin.com>,  Masahiro Yamada
 <yamada.masahiro@socionext.com>,  Boris Brezillon <bbrezillon@kernel.org>,
  Brian Norris <computersforpeace@gmail.com>,
  linux-mtd@lists.infradead.org,  devicetree@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-sunxi@lists.linux.dev,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH v6 01/18] mtd: rawnand: sunxi: drain interrupts before
 reusing the completion
In-Reply-To: <CADvTj4pmtGZ4c04q+5AE3trrfshToD7BPtF-8kPxPRZ25hOTRw@mail.gmail.com>
	(James Hilliard's message of "Mon, 12 Oct 2026 12:26:00 -0600")
References: <20260914-submit-sunxi-nand-vendor-oob-layout-v1-v6-0-2fb084fe0751@gmail.com>
	<20260914-submit-sunxi-nand-vendor-oob-layout-v1-v6-1-2fb084fe0751@gmail.com>
	<8733ua23xs.fsf@bootlin.com>
	<CADvTj4pmtGZ4c04q+5AE3trrfshToD7BPtF-8kPxPRZ25hOTRw@mail.gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 12 Oct 2026 21:06:28 +0200
Message-ID: <877bjmzqkr.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 12/10/2026 at 12:26:00 -06, James Hilliard <james.hilliard1@gmail.com> w=
rote:

> On Mon, Oct 12, 2026 at 12:02=E2=80=AFPM Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:
>>
>> Hi James,
>>
>> On 14/09/2026 at 15:09:47 -06, James Hilliard <james.hilliard1@gmail.com=
> wrote:
>>
>> > A timed-out wait can return while the interrupt handler is still using
>> > the previous operation's interrupt status and enable mask. Starting the
>> > next wait calls init_completion() on the same object, which can reset =
its
>> > waitqueue lock while the old handler calls complete(). The old handler
>> > can also complete the new wait or restore an obsolete interrupt mask.
>> >
>> > Initialize the completion once in probe and use reinit_completion() for
>> > each interrupt-driven wait. On timeout, disable and synchronize the IRQ
>> > before masking controller interrupts and acknowledging the waited-for
>> > events. Draining the handler first also prevents a partial-event handl=
er
>> > from rewriting the enable mask after it has been cleared. Flush these
>> > register writes before re-enabling the IRQ line, leaving the controlle=
r's
>> > interrupt sources masked.
>> >
>> > For successful waits, move complete() after the handler's register upd=
ates
>> > so that the next operation cannot race with those updates. Keep polling
>> > unchanged and leave controller and DMA abort handling to the existing
>> > callers.
>> >
>> > Fixes: 1fef62c1423b ("mtd: nand: add sunxi NAND flash controller suppo=
rt")
>> > Cc: stable@vger.kernel.org
>> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>> > ---
>>
>> So from the commit log I understand that you are fixing a race. The
>> problem seems legitimate.
>>
>> >  drivers/mtd/nand/raw/sunxi_nand.c | 26 ++++++++++++++++++++------
>> >  1 file changed, 20 insertions(+), 6 deletions(-)
>> >
>>
>> ...
>>
>> > @@ -414,12 +416,13 @@ static irqreturn_t sunxi_nfc_interrupt(int irq, =
void *dev_id)
>> >       if (!(ien & st))
>> >               return IRQ_NONE;
>> >
>> > -     if ((ien & st) =3D=3D ien)
>> > -             complete(&nfc->complete);
>> > -
>> > +     /* Finish updating the interrupt state before waking the next op=
eration. */
>> >       writel(st & NFC_INT_MASK, nfc->regs + NFC_REG_ST);
>> >       writel(~st & ien & NFC_INT_MASK, nfc->regs + NFC_REG_INT);
>> >
>> > +     if ((ien & st) =3D=3D ien)
>> > +             complete(&nfc->complete);
>> > +
>> >       return IRQ_HANDLED;
>> >  }
>> >
>> > @@ -435,16 +438,19 @@ static int sunxi_nfc_wait_events(struct sunxi_nf=
c *nfc, u32 events,
>> >               timeout_ms =3D NFC_DEFAULT_TIMEOUT_MS;
>> >
>> >       if (!use_polling) {
>> > -             init_completion(&nfc->complete);
>> > +             reinit_completion(&nfc->complete);
>>
>> The whole change around (re)init_completion looks relevant (here and in =
the handler).
>>
>> >
>> >               writel(events, nfc->regs + NFC_REG_INT);
>> >               ret =3D wait_for_completion_timeout(&nfc->complete,
>> >                                               msecs_to_jiffies(timeout=
_ms));
>> > -             if (!ret)
>> > +             if (!ret) {
>> > +                     /* Drain the handler before it can restore an ol=
d IRQ mask. */
>> > +                     disable_irq(nfc->irq);
>>
>> disable_irq() for serializing accesses to a single register?
>
> The intention was to drain an in-flight handler before cleaning up the
> timed-out wait, rather than just serialize the register write.

I guess here you relate to the race explained below.

> disable_irq() provides that synchronization as well as masking the line.
> It is only used on timeout, and this IRQ is requested without
> IRQF_SHARED.

This is clearly debatable, since we can identify the IRQ, that flag
could (should, maybe) have been set. With your approach it would have
been even more impacting. But that's not the point.

> A spinlock could also address this, provided it covers the handler's
> status/enable reads through complete(), together with the waiter's
> cleanup and rearming. Protecting only the register writes would leave
> the handler able to act on an old snapshot.

I'm not sure what you call "only the register writes", you can call
complete() from within the lock if that makes sense for this case,
yes. complete() does not block so it is fine.

...

>> commit log, I now disagree with the first part of:
>>
>> >The old handler can also complete the new wait or restore an obsolete i=
nterrupt mask.
>>
>> "complete the new wait"? I don't see how a stale handler completes the
>> next wait given the handler is a hard IRQ and the interrupt enable
>> register is cleared on timeout.
>
> The case I had in mind is an already-running handler on another CPU:
>
> CPU 0: Read st and ien for operation A.
> CPU 1: Time out operation A, mask/acknowledge its interrupts,
>        then eventually reinitialize the completion for operation B.
> CPU 0: Call complete() based on the saved st and ien from operation A.

For this to fire, the hard IRQ handler on CPU0 would have to be stopped
between reading st/ien and calling complete() long enough to span:
- A's timeout
- A's cleanup
- B's wait being rearmed
On this hardware, how is this reachable?

> Clearing the device's enable register does not invalidate those local
> values or wait for the running handler to finish. Hard-IRQ context
> prevents this overlap on the same CPU, but not across CPUs.
>
> That distinction was not explicit enough in the commit message. I'm
> open to a different implementation; the requirement I wanted to preserve
> is that the old handler cannot update the mask or signal the completion
> after the waiter has cleaned up and reused it.

Miqu=C3=A8l
