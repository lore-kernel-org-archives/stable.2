Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD1043B3E6
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 16:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701846; cv=none; b=XgmfEJVnA3HrsptQFRV7OLJWgHlr8H8WDGknQGg+oyW4AFsBOoD653ddCh7SwaxAgtEqtyO9D4nkBNOH5NsG9beAZQ3EsPxoR9slhZXsDhQnVGNVLuirCj+051RgesgSJvrwJZaNoEKIp5vQpNUBkjI4vHg4cED5blAMeKytSNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701846; c=relaxed/simple;
	bh=k/DYohfKDSxjiqdIraTgAZUOXPWe4X+vqJQlCDRJ/no=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=aJVA4b4jZrsDvJc0DUqqBmtGERJNWGc1AEnAd0G1H7aiWt342Y9eHER7rSGVM8zlJU39v3WJH1A3vZHIpNpDdMfP2aIpo2T8SLBStYVrGaiEiZmrsl2rG/xCVUOYEIEaZAHDyEQFYy35ebgVvDSuDOAf3Vycyj+Hx3CgzkLJzOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fWcSTkxW; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fWcSTkxW"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 158ECC2C64A;
	Fri, 10 Jul 2026 16:44:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 28CE160342;
	Fri, 10 Jul 2026 16:44:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6711F11BD2463;
	Fri, 10 Jul 2026 18:43:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783701841; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5klLTY7luf2N9VlmtEJ+qRL3gV5Uke3/bj3Rh06DY0c=;
	b=fWcSTkxWyhHL8JKpgTOxN2xozIVxTBZypNlJvyUgsrxQRH8slqs+/Op0GxLihj02cXSlXo
	yw9iMeTzEicnruefJszL/LGcgKWGzxSorztU8r3IUwi4KVdd+chMC/OgX4uxnuE/oLu2QZ
	xuVEU8PVZB+HVTs0Of+s8t3kMJ+WgSOoNBc/9mB4ieIPVRER4P9Mf55K5myLdsL6seSFHs
	eSQITggZYkoemSi46v+enW0STR7BMC67fi0Cveo1rXmPaJWKu/ZW+fMLWF9JcoVQze0kfS
	OyxwiDD6F6YPSBBaL+qAWPDE0o1g9JpsKiruJSXx92FLPbO7zvy9IFItLdN6DA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Jul 2026 18:43:54 +0200
Message-Id: <DJV1J2JKZ6KW.1RXOBM28WTVGG@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net 2/2] net: macb: mask TXUBR during TX NAPI poll to
 prevent IRQ storms
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-rt-devel@lists.linux.dev>, <stable@vger.kernel.org>
To: <christian.taedcke@weidmueller.com>,
 <christian.taedcke-oss@weidmueller.com>, "Conor Dooley"
 <conor.dooley@microchip.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Kevin Hao" <haokexin@gmail.com>, "Simon Horman" <horms@kernel.org>,
 "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>, "Clark Williams"
 <clrkwllms@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>, "Robert
 Hancock" <robert.hancock@calian.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260706-upstreaming-macb-irq-storm-v1-0-ab3115b5a13a@weidmueller.com> <20260706-upstreaming-macb-irq-storm-v1-2-ab3115b5a13a@weidmueller.com>
In-Reply-To: <20260706-upstreaming-macb-irq-storm-v1-2-ab3115b5a13a@weidmueller.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Christian,

My biggest gripe with this patch is the commit message. It's a massive
block of text which goes here and there without enough structure.

Let me try to pick issues I have with it and try to give a better
alternative (hoping I understood the topic clearly enough).

On Mon Jul 6, 2026 at 4:02 PM CEST, Christian Taedcke via B4 Relay wrote:
> From: Christian Taedcke <christian.taedcke@weidmueller.com>
>
> macb_interrupt() defers TX completion handling to NAPI, but when it
> schedules the poll it only masks TCOMP, even though TXUBR is enabled
> alongside it (both are part of MACB_TX_INT_FLAGS). macb_tx_poll() is
> asymmetric in the same way and only re-enables TCOMP. TXUBR is thus
> left unmasked while responsibility for handling it has been deferred
> to NAPI.

Yes, so said differently:

   TXUBR is acknowledged by the NAPI poll function. The IRQ signal is
   active until then but signal is left unmasked. Do as with TCOMP and
   mask the signal until its acknowledgment.

This sounds much more straight forward to me. And it also explains what
we do to solve the issue, which is info we expect to find in the first
commit message paragraph. The rest is to go into details onto the
specifics, the decisionmaking, etc.

> Unlike an edge event, TXUBR is a persistent condition: the controller
> keeps it asserted for as long as the transmitter reads a buffer
> descriptor whose used bit is set. Leaving a level-triggered source
> enabled while NAPI owns its processing means the interrupt refires
> immediately after the handler returns, before the poll has had a
> chance to clear the underlying condition. This turns into a hard
> interrupt storm that pegs a CPU in the (threaded) MAC IRQ handler and,
> on PREEMPT_RT, triggers RT throttling ("sched: RT throttling
> activated"), taking the network interface down.

This whole paragraph is somewhat moot to me. It highlights level versus
edge interrupts but even with edge events the bug is present: it blocks
any other IRQ from the HW until the TXUBR ACK (in NAPI context).

Describing how the bug surfaces on your HW is interesting however.

> Several situations can keep the used-bit read asserted across a poll -
> for example unreaped completed descriptors still sitting at tx_tail,
> or a transmit restart racing with macb_start_xmit(). The specific
> trigger does not matter: as long as the source stays unmasked, any
> persistent assertion is enough to storm, so the interrupt handling
> itself must be made self-limiting.

But this is unrelated? Whether TXUBR stays asserted across the poll
processing doesn't change the fact the IRQ is unmasked until we reach
NAPI context and the signal is still not ACKed.

> Mask TXUBR together with TCOMP in the IDR write when scheduling the TX
> NAPI, and re-enable both from the napi_complete path in
> macb_tx_poll(), making the TX interrupt mask/unmask symmetric and
> consistent with how the driver already treats every other
> NAPI-serviced source. The pending TXUBR is still recorded in
> queue->txubr_pending before masking and acted on by macb_tx_restart(),
> so no event is lost. A persistent TXUBR now degrades to NAPI-paced
> polling instead of a CPU-pegging hard interrupt storm.

Again a lot of words for little info. Usually the patch change
(the "mask TXUBR with TCOMP" part) belongs to the first commit message
paragraph, we shouldn't have to wait until the last paragraph to know
about what a patch does.

Some question that is left in my head after reading, that could have
been answered by your commit message: your approach of masking TXUBR
until NAPI is one way, another would have been to ACK TXUBR from
macb_interrupt(). Have you investigated that approach? The answer might
be super straight forward.

> Fixes: 138badbc21a0 ("net: macb: use NAPI for TX completion path")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Christian Taedcke <christian.taedcke@weidmueller.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ether=
net/cadence/macb_main.c
> index b11cb8f068b7..f75cf2ffdf6f 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -1971,7 +1971,7 @@ static int macb_tx_poll(struct napi_struct *napi, i=
nt budget)
>  		    (unsigned int)(queue - bp->queues), work_done, budget);
> =20
>  	if (work_done < budget && napi_complete_done(napi, work_done)) {
> -		queue_writel(queue, IER, MACB_BIT(TCOMP));
> +		queue_writel(queue, IER, MACB_BIT(TCOMP) | MACB_BIT(TXUBR));
>
>  		/* Packet completions only seem to propagate to raise
>  		 * interrupts when interrupts are enabled at the time, so if
> @@ -2161,7 +2161,8 @@ static irqreturn_t macb_interrupt(int irq, void *de=
v_id)
> =20
>  		if (status & (MACB_BIT(TCOMP) |
>  			      MACB_BIT(TXUBR))) {
> -			queue_writel(queue, IDR, MACB_BIT(TCOMP));
> +			queue_writel(queue, IDR, MACB_BIT(TCOMP) |
> +						 MACB_BIT(TXUBR));
>  			macb_queue_isr_clear(bp, queue, MACB_BIT(TCOMP) |
>  							MACB_BIT(TXUBR));
>  			if (status & MACB_BIT(TXUBR)) {

We risk some race condition here, but that was present before your
patch. macb_interrupt() already grabs bp->lock but macb_tx_poll() does
zero efforts. (I'm not saying that macb_tx_poll() should grab bp->lock
which would throw away the benefits of our separate queues, the solution
is more complex.)

Sashiko reports that as well.

It's not up to you to fix this. Or if you do it, it should be a separate
patch. It is weird that our IRQ handlers all grab the interface-global
bp->lock rather than a queue-specific primitive, it would probably be a
big rework.

--

TLDR: if patch 2/2 fixes your bug, I'm OK with it. Please rewrite your
commit message though. I suspect patch 1/2 is not needed.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

