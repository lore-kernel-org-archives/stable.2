Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4196D4C10D9
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 18:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791828130; cv=none; b=NUHPxVjwO+wME3hKUt3dl4UfQTVBZY4sz6l4xV1k9XXaMhz8UyLR/VwKbgdwLa9EWtZ/zLKzy4gc0vArrRy3k+PTL3lvS2ATH5YXZfn+dQuB5WTEkuau7sd0u4NzCvCh96rUUaNJl5yxRGhlG+gNb0xhqZQSnOFSmWtTRyLFUhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791828130; c=relaxed/simple;
	bh=Z6sQzfOjJE3zZ6rA3iiYJzCKffn9Za8LnqtjvIZELqs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gv+7V+YQsjBtOeSAwSMxivpi+qKTy0jQIx3JUbxFovsQrdmgZhjYI/c+jnxutoKPDRatY+jPHtL4y8i00BUqNCDDPQEyEGK/xp4pz1X5KNEeSk+3Hazcr21GO6y5ChhGCaTDtGhP2liPdwB5DHmiouHfiTNN6QKB0QDnBvXq/AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tAcam95N; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="tAcam95N"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8713B4E411FE;
	Mon, 12 Oct 2026 18:02:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4FE39601A6;
	Mon, 12 Oct 2026 18:02:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6B4CC11D709B8;
	Mon, 12 Oct 2026 20:01:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791828119; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=eN09B8iBlF64T0aTmOSgm5Y2C78SY2TacmK0ll+reUk=;
	b=tAcam95NZ1BivOLoK77OxsuB56U3i0Qppo9vGls9cATCKGIw5agJkxwfoWDG/OthDNehCN
	a78TLjuOsJBlAb9c9IbeUtFCXWg+wRRZUZST+frVgrNrwFyHR9/S1ky2uGhvcLosGJq9A3
	reiFa2cJApB3cf3l+Hou1A6jAIM47qX3oh6EpXUPzIlSg7zerEABZa+iQUXPtWBoCgP2w2
	xMAzUAHMsNZVbdUPaDt4CKC2Dtc6NGpogZ9SIu+0Ir/lObyEebBL0verhlnaylrZfdc3hN
	aX6MJq9RcvIOfQOFogsYem2rkhG6H2k3+A65BQJ60k0NftyLS3qCnM4730lBbA==
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
In-Reply-To: <20260914-submit-sunxi-nand-vendor-oob-layout-v1-v6-1-2fb084fe0751@gmail.com>
	(James Hilliard's message of "Mon, 14 Sep 2026 15:09:47 -0600")
References: <20260914-submit-sunxi-nand-vendor-oob-layout-v1-v6-0-2fb084fe0751@gmail.com>
	<20260914-submit-sunxi-nand-vendor-oob-layout-v1-v6-1-2fb084fe0751@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 12 Oct 2026 20:01:51 +0200
Message-ID: <8733ua23xs.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi James,

On 14/09/2026 at 15:09:47 -06, James Hilliard <james.hilliard1@gmail.com> w=
rote:

> A timed-out wait can return while the interrupt handler is still using
> the previous operation's interrupt status and enable mask. Starting the
> next wait calls init_completion() on the same object, which can reset its
> waitqueue lock while the old handler calls complete(). The old handler
> can also complete the new wait or restore an obsolete interrupt mask.
>
> Initialize the completion once in probe and use reinit_completion() for
> each interrupt-driven wait. On timeout, disable and synchronize the IRQ
> before masking controller interrupts and acknowledging the waited-for
> events. Draining the handler first also prevents a partial-event handler
> from rewriting the enable mask after it has been cleared. Flush these
> register writes before re-enabling the IRQ line, leaving the controller's
> interrupt sources masked.
>
> For successful waits, move complete() after the handler's register updates
> so that the next operation cannot race with those updates. Keep polling
> unchanged and leave controller and DMA abort handling to the existing
> callers.
>
> Fixes: 1fef62c1423b ("mtd: nand: add sunxi NAND flash controller support")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---

So from the commit log I understand that you are fixing a race. The
problem seems legitimate.

>  drivers/mtd/nand/raw/sunxi_nand.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
>

...

> @@ -414,12 +416,13 @@ static irqreturn_t sunxi_nfc_interrupt(int irq, voi=
d *dev_id)
>  	if (!(ien & st))
>  		return IRQ_NONE;
>=20=20
> -	if ((ien & st) =3D=3D ien)
> -		complete(&nfc->complete);
> -
> +	/* Finish updating the interrupt state before waking the next operation=
. */
>  	writel(st & NFC_INT_MASK, nfc->regs + NFC_REG_ST);
>  	writel(~st & ien & NFC_INT_MASK, nfc->regs + NFC_REG_INT);
>=20=20
> +	if ((ien & st) =3D=3D ien)
> +		complete(&nfc->complete);
> +
>  	return IRQ_HANDLED;
>  }
>=20=20
> @@ -435,16 +438,19 @@ static int sunxi_nfc_wait_events(struct sunxi_nfc *=
nfc, u32 events,
>  		timeout_ms =3D NFC_DEFAULT_TIMEOUT_MS;
>=20=20
>  	if (!use_polling) {
> -		init_completion(&nfc->complete);
> +		reinit_completion(&nfc->complete);

The whole change around (re)init_completion looks relevant (here and in the=
 handler).

>=20=20
>  		writel(events, nfc->regs + NFC_REG_INT);
>  		ret =3D wait_for_completion_timeout(&nfc->complete,
>  						msecs_to_jiffies(timeout_ms));
> -		if (!ret)
> +		if (!ret) {
> +			/* Drain the handler before it can restore an old IRQ mask. */
> +			disable_irq(nfc->irq);

disable_irq() for serializing accesses to a single register? It
certainly works but I don't think it is so common to use it like that,
for such simple cases. Typically in this case I would have used a
spinlock maybe? Or even better, why not just avoid the race entirely
and handle the register in the waiter? You certainly don't need to write
it in the IRQ handler. You can handle the IRQ configuration at the
device level, which will also prevent the need for your extra
readl "barrier" before enabling the IRQ.

Furthermore, now that I have a better understanding, re-reading the
commit log, I now disagree with the first part of:

>The old handler can also complete the new wait or restore an obsolete inte=
rrupt mask.

"complete the new wait"? I don't see how a stale handler completes the
next wait given the handler is a hard IRQ and the interrupt enable
register is cleared on timeout.

Thanks,
Miqu=C3=A8l
