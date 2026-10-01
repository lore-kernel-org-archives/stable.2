Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286803F58FE;
	Thu,  1 Oct 2026 16:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790870973; cv=none; b=OGfMZF3wNd5Q2cHwQvFl28ZlDCQ8ldLaj0Ci6IN+hwbt4oHaauwoIptHCw5Xk9E22GtGXWOiReJO31GKkiDAGoO6tuf4AC43DVpgYe/B4joYOXPpFeQzlCbtZvG4/NQD22m7RWuryxCh+c868u2LLFPkvcT404TKH33/Q0LoLNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790870973; c=relaxed/simple;
	bh=4J85n7cRjMcnoZ/gPqiiFZECv6dJuTMif6V+qxrYfLY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=k3GFpMZmjEQXOlVk1tdSC5tAa/BPtxLCrPKAWe+Amiw4QpoDuzs0OIdEDhhP2wS9kvXOsmgwg/aT8mkStl7R/nEGJfPGWLAgfDdSg4C6LrPYFKrGM3xekrlahnQcTtd4Z36kgtP852ng3nS1sN389u95nNwL6sltT25Lvl4beVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=Q4mJhzLV; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="Q4mJhzLV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=lBo883r8w3pgm+W8UU6o096i0cn8wqWe+bE8Br/hz68=; b=Q4mJhzLVwXiCGwpvr501Ot/G7m
	LZwKYbN5JDn/YoDBllec3AkklP7nJrkJTMz0exzZl1dkZ1qn6kTY3mUr5AjoHF57ruTf3j1/qbTzc
	i0zZuCm41qR6v5ZDwS41CsJKWNrgdzBBfxgp9lMbKFtw81a+i2kvQriAAn0ClE7fz9NQ=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1xCJLW-0000000066q-0aSJ;
	Thu, 01 Oct 2026 12:09:22 -0400
Date: Thu, 1 Oct 2026 12:09:21 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>
Cc: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
 <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <tobias.gannert@ziehl-abegg.de>, <joachim.knorr@ziehl-abegg.de>,
 <david.laight.linux@gmail.com>, <Maarten.Brock@sttls.nl>,
 <crescentcy.hsieh@moxa.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2 RESEND] serial: sc16is7xx: fix TX gap caused by kfifo
 circular buffer wrap-around
Message-Id: <20261001120921.97b56c43423f40fcff265e97@hugovil.com>
In-Reply-To: <20260930143207.542930-1-paultyson.mbewe@ziehl-abegg.de>
References: <20260930143207.542930-1-paultyson.mbewe@ziehl-abegg.de>
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

On Wed, 30 Sep 2026 16:32:07 +0200
Paul Mbewe <paultyson.mbewe@ziehl-abegg.de> wrote:

> kfifo_out_linear_ptr() returns only one contiguous linear segment of the
> xmit kfifo. When transmit data wraps around the end of the kfifo, only
> the first segment up to the buffer end is sent. The remaining data at
> the start of the kfifo is not sent until the next TX interrupt fires,
> resulting in a visible mid-frame TX gap on the wire.
> 
> The resulting gap is unintended: data remains queued in the xmit kfifo,
> but the hardware TX FIFO drains empty before the remaining segment is
> sent. Such gaps can break timing-sensitive serial protocols such as
> Modbus RTU.
> 
> Modbus RTU requires a message to be transmitted as a continuous stream.
> For baud rates above 19200, the Modbus Serial Line guide recommends a
> fixed 750 us inter-character timeout. On the tested 115200-baud system,
> oscilloscope measurements showed mid-frame gaps exceeding that value.
> Receivers using the recommended timeout may therefore discard the
> incomplete message.
> 
> The incomplete transfer also causes unnecessary TX interrupts: instead
> of using all available hardware TX FIFO space in one go, the driver
> requires an extra interrupt to send the remaining segment after the
> wrap.
> 
> After the tty xmit buffer was converted to a kfifo, the driver used
> uart_fifo_out() to copy data into a linear staging buffer, allowing a
> transfer to span the kfifo wrap-around boundary. Commit 133f4c00b8b2
> ("serial: sc16is7xx: fix TX fifo corruption") replaced uart_fifo_out()
> with a single kfifo_out_linear_ptr() call to remove the shared TX/RX
> buffer. Since kfifo_out_linear_ptr() exposes only one contiguous
> segment, that change lost the wrap-around handling.
> 
> Fix this by calling kfifo_out_linear_ptr() in a loop, advancing through
> all contiguous segments until the available hardware TX FIFO space is
> exhausted or the xmit kfifo is empty.
> 
> This fixes the kfifo wrap-around gap independently of the stale-TXLVL
> refill issue.
> 
> Tested on SC16IS752 over SPI driving RS-485 at 115200 baud 8N1 on an
> i.MX6ULL-based board. Oscilloscope measurements confirmed mid-frame
> breaks at the kfifo wrap-around boundary before the fix; no such breaks
> were observed afterward.
> 
> Fixes: 133f4c00b8b2 ("serial: sc16is7xx: fix TX fifo corruption")
> Cc: stable@vger.kernel.org
> Reported-by: Tobias Gannert <tobias.gannert@ziehl-abegg.de>
> Reviewed-by: Joachim Knorr <joachim.knorr@ziehl-abegg.de>
> Link: https://lore.kernel.org/linux-serial/20260623112225.82386-2-paultyson.mbewe@ziehl-abegg.de/
> Signed-off-by: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>

Reviewed-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Tested with a basic loopback test with RS-485 on imx8mn and imx6
custom boards:

Tested-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

I suggest you add these tags and resend as a clean V3 because of all
the signature confusion...


> ---
> Resent after fixing the mail configuration so that all CC'd reviewers receive
> an unmodified plain-text copy of the patch. No patch changes since v2.
> 
> Changes in v2:
>   - Corrected the Modbus RTU timing description for baud rates above 19200
>   - Distinguished the xmit kfifo from the hardware TX FIFO
>   - Clarified that this fixes one independent TX gap source
>   - Corrected the introducing-commit history for direct kfifo access
>   - Removed the max310x comparison
>   - Addressed Hugo Villeneuve's review: clarified that multiple segments
>     are sent, scoped tail to the loop, and added the requested blank line
> 
>  drivers/tty/serial/sc16is7xx.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index 7107a0fb1e7b..fa7805d2cde2 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -652,7 +652,6 @@ static void sc16is7xx_handle_tx(struct uart_port *port)
>  	struct tty_port *tport = &port->state->port;
>  	unsigned long flags;
>  	unsigned int txlen;
> -	unsigned char *tail;
>  
>  	if (unlikely(port->x_char)) {
>  		sc16is7xx_port_write(port, SC16IS7XX_THR_REG, port->x_char);
> @@ -677,9 +676,19 @@ static void sc16is7xx_handle_tx(struct uart_port *port)
>  		txlen = 0;
>  	}
>  
> -	txlen = kfifo_out_linear_ptr(&tport->xmit_fifo, &tail, txlen);
> -	sc16is7xx_fifo_write(port, tail, txlen);
> -	uart_xmit_advance(port, txlen);
> +	/* Handle circular buffer wrap-around by sending multiple segments */
> +	while (txlen > 0 && !kfifo_is_empty(&tport->xmit_fifo)) {
> +		unsigned char *tail;
> +		unsigned int to_send;
> +
> +		to_send = kfifo_out_linear_ptr(&tport->xmit_fifo, &tail, txlen);
> +		if (!to_send)
> +			break;
> +
> +		sc16is7xx_fifo_write(port, tail, to_send);
> +		uart_xmit_advance(port, to_send);
> +		txlen -= to_send;
> +	}
>  
>  	uart_port_lock_irqsave(port, &flags);
>  	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
> -- 
> 2.43.0
> 


-- 
Hugo Villeneuve
