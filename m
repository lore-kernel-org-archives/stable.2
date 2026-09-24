Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB14921A459;
	Sat, 26 Sep 2026 06:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790402754; cv=none; b=UsewXeAlBIuOgUjCNkJv1/fUf0lw4+0/bNJOdj9TYhZZjfc6xXFVAc+kLcGSnOdbbjpWvkp0pyfmRyuCuJjI4fAT45obmWO2XV7ZNhCvDdEmWGsTLsTBpc61gU0GBZKNX+WpzqFcO9Q51+QIZbMzVpEJZQA9nDvmRFLSyZcDsss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790402754; c=relaxed/simple;
	bh=y0iSA6CkkRZXBJlnPdmaPVBqWLmPQTnW4S0f2YMCeI4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=eAO+kWdfKw68BoKAQvraN1ihhGPwks5BKjMlV3ok1N7RhF5QeWo/TuSkDO8tQMdCslJpiginDlqZkWuqMwAPpIq781zf/ktBNPp163RrIaaNd34WVWw7Dg2uFLd6nk0oHl830V0WXWvpbezg9gQyvf4DKP7WQNs4dy4O3nFvMgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=gEuPlTA1; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="gEuPlTA1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=VKdbGETBLwi9Hn8tuGEEEP6FcTEQde8mSORi1uttLV0=; b=gEuPlTA1dTwmlkB/UQ+W3KlHQm
	60aOj16cihQVTDJzPlMuY3WR0WEcfOCYCpPj4tEEzyUXl+NGAdL56/CSk7NoZWLczgx7qdkOtbQ20
	jnJCyMWODX7YdHlBENYMyhcaDmJC1SMeCtkd9WS5y6Img0S8ukCZZklZeKCJdi8tpH0s=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1x9jt3-000000005Ky-18pH;
	Thu, 24 Sep 2026 09:53:21 -0400
Date: Thu, 24 Sep 2026 09:53:20 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>
Cc: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
 <hvilleneuve@dimonoff.com>, <stable@vger.kernel.org>, Tobias Gannert
 <tobias.gannert@ziehl-abegg.de>, Joachim Knorr
 <joachim.knorr@ziehl-abegg.de>
Subject: Re: [PATCH 1/2] serial: sc16is7xx: fix TX gap caused by kfifo
 circular buffer wrap-around
Message-Id: <20260924095320.3038105d452dcfbe44cabc60@hugovil.com>
In-Reply-To: <20260825095741.6dbe87760a2401ba93ed9035@hugovil.com>
References: <20260623112225.82386-1-paultyson.mbewe@ziehl-abegg.de>
	<20260623112225.82386-2-paultyson.mbewe@ziehl-abegg.de>
	<20260825095741.6dbe87760a2401ba93ed9035@hugovil.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam_score: -2.0
X-Spam_bar: --

On Tue, 25 Aug 2026 09:57:41 -0400
Hugo Villeneuve <hugo@hugovil.com> wrote:

> Hi Paul,
> 
> On Tue, 23 Jun 2026 13:22:24 +0200
> Paul Mbewe <paultyson.mbewe@ziehl-abegg.de> wrote:
> 
> > kfifo_out_linear_ptr() returns only one contiguous linear segment of the
> > circular kfifo buffer. When transmit data wraps around the end of the
> > buffer, only the first segment (up to the buffer end) is sent. The
> > remaining data at the start of the buffer is not sent until the next TX
> > interrupt fires, resulting in a visible inter-frame gap on the wire.
> > 
> > This gap violates the Modbus RTU 1.5 character-time inter-character
> > silence limit. Receivers interpret any silence exceeding 1.5 character
> > times as an end-of-frame marker, splitting a single valid frame into
> > two malformed fragments and corrupting communication on the bus.
> > 
> > The incomplete transfer also causes unnecessary TX interrupts: instead
> > of draining the full available FIFO space in one pass, the driver fires
> > an extra interrupt per wrap-around just to send the remaining bytes.
> > 
> > The pre-kfifo code handled wrap-around by copying bytes one at a time
> > from the circ_buf into a linear staging buffer. The conversion to kfifo
> > replaced this with a single kfifo_out_linear_ptr() call, losing the
> > wrap-around handling. The max310x driver (a similar SPI UART) correctly
> > handles this with a while loop.
> > 
> > Fix this by calling kfifo_out_linear_ptr() in a loop, advancing through
> > all contiguous segments until the available TX FIFO space is exhausted
> > or the kfifo is empty.
> > 
> > Tested on SC16IS752 (SPI) driving RS-485 at 115200 baud 8N1 on an
> > i.MX6ULL based board. Oscilloscope confirmed mid-frame breaks at the
> > kfifo wrap-around boundary before the fix; no breaks observed after.
> > 
> > Fixes: 1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo")
> > Cc: stable@vger.kernel.org
> > Reported-by: Tobias Gannert <tobias.gannert@ziehl-abegg.de>
> > Tested-by: Tobias Gannert <tobias.gannert@ziehl-abegg.de>
> > Reviewed-by: Joachim Knorr <joachim.knorr@ziehl-abegg.de>
> > Signed-off-by: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>
> > ---
> >  drivers/tty/serial/sc16is7xx.c | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> > index 1a2c4c14f6aa..395a219280be 100644
> > --- a/drivers/tty/serial/sc16is7xx.c
> > +++ b/drivers/tty/serial/sc16is7xx.c
> > @@ -730,9 +730,17 @@ static void sc16is7xx_handle_tx(struct uart_port *port)
> >  		txlen = 0;
> >  	}
> >  
> > -	txlen = kfifo_out_linear_ptr(&tport->xmit_fifo, &tail, txlen);
> > -	sc16is7xx_fifo_write(port, tail, txlen);
> > -	uart_xmit_advance(port, txlen);
> > +	/* Handle circular buffer wrap-around by sending in contiguous segments */
> 
> Maybe I would drop "by sending in contiguous segments", because it is
> more confusing than helping for me, because before your patch it was
> already sending one contiguous segment...
> Or maybe change to "... by sending multiple segments"?
> 
> 
> > +	while (txlen > 0 && !kfifo_is_empty(&tport->xmit_fifo)) {
> > +		unsigned int to_send;
> 
> You can now move this variable here since it is used only in the
> while() scope:
>                 unsigned char *tail;
> 
> > +
> > +		to_send = kfifo_out_linear_ptr(&tport->xmit_fifo, &tail, txlen);
> > +		if (!to_send)
> > +			break;
> 
> Insert empty line
> 
> > +		sc16is7xx_fifo_write(port, tail, to_send);
> > +		uart_xmit_advance(port, to_send);
> > +		txlen -= to_send;
> > +	}
> >  
> >  	uart_port_lock_irqsave(port, &flags);
> >  	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
> > -- 
> > 2.43.0

Hi Paul,
do you still have plans to resubmit that patch (also with my suggestions
above)? If you do, you can probably send it as a standalone patch
independent of this series...

-- 
Hugo Villeneuve
