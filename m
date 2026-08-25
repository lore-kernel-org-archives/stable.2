Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2376D45C70B;
	Tue, 25 Aug 2026 13:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787666265; cv=none; b=XdHYMY446mjPvOtY35ndawLdAl1hAENAGMfNJVaaK/X6xk2YZNRgdTcXMZIXlGhid2p/dsdiqQrDxSEXd146ajU/6YYDKODsEbYC0gCz2EcgZg6SubE0mrlCg5YHzyQTcss1NtrGT5eZ0JArHri+mDVWZozuR1fL0DKaO/CMDLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787666265; c=relaxed/simple;
	bh=ccfp13Ex/bdX/+cSPLI8OfotNi6PEzN0nmjiCvtjVPg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Kg2ntHmbNoG8Pb4B01+lSZ+wau8oh55LqUsYnkXcToEDVEbGtrjFW3ILK75knPProEEeQI1OBXrXW2oV2OIDhtlPB2JAh052Vl8ddC821Rl69/hpZYp1w6lJeHarv0P+NRmwkHqXZTeNmXR6lnMSlOp/KyCbGpMBuyJQVM/cAao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=U4Ztk9M0; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="U4Ztk9M0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=LSkFSJdgSktGSdc7N8X9eD+ZySBXU7m+wuK4INimUOE=; b=U4Ztk9M0ruthWfCxn1ve0FOymH
	uG5ye3ScD4xXWpadtvOYsGd74qW8ZbexSZSj1srAe+UX1+/mTXhLlffVdG8StprgU3ReQ/Y2TxHYC
	d0kS2EBApUQr4JNf4KZngx+mHy74IcLZMugRZj/dRijpLWSXlKoz7LBgfH5DABt4BhLw=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wyreo-000000006c7-1upT;
	Tue, 25 Aug 2026 09:57:42 -0400
Date: Tue, 25 Aug 2026 09:57:41 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>
Cc: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
 <hvilleneuve@dimonoff.com>, <stable@vger.kernel.org>, Tobias Gannert
 <tobias.gannert@ziehl-abegg.de>, Joachim Knorr
 <joachim.knorr@ziehl-abegg.de>
Subject: Re: [PATCH 1/2] serial: sc16is7xx: fix TX gap caused by kfifo
 circular buffer wrap-around
Message-Id: <20260825095741.6dbe87760a2401ba93ed9035@hugovil.com>
In-Reply-To: <20260623112225.82386-2-paultyson.mbewe@ziehl-abegg.de>
References: <20260623112225.82386-1-paultyson.mbewe@ziehl-abegg.de>
	<20260623112225.82386-2-paultyson.mbewe@ziehl-abegg.de>
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

Hi Paul,

On Tue, 23 Jun 2026 13:22:24 +0200
Paul Mbewe <paultyson.mbewe@ziehl-abegg.de> wrote:

> kfifo_out_linear_ptr() returns only one contiguous linear segment of the
> circular kfifo buffer. When transmit data wraps around the end of the
> buffer, only the first segment (up to the buffer end) is sent. The
> remaining data at the start of the buffer is not sent until the next TX
> interrupt fires, resulting in a visible inter-frame gap on the wire.
> 
> This gap violates the Modbus RTU 1.5 character-time inter-character
> silence limit. Receivers interpret any silence exceeding 1.5 character
> times as an end-of-frame marker, splitting a single valid frame into
> two malformed fragments and corrupting communication on the bus.
> 
> The incomplete transfer also causes unnecessary TX interrupts: instead
> of draining the full available FIFO space in one pass, the driver fires
> an extra interrupt per wrap-around just to send the remaining bytes.
> 
> The pre-kfifo code handled wrap-around by copying bytes one at a time
> from the circ_buf into a linear staging buffer. The conversion to kfifo
> replaced this with a single kfifo_out_linear_ptr() call, losing the
> wrap-around handling. The max310x driver (a similar SPI UART) correctly
> handles this with a while loop.
> 
> Fix this by calling kfifo_out_linear_ptr() in a loop, advancing through
> all contiguous segments until the available TX FIFO space is exhausted
> or the kfifo is empty.
> 
> Tested on SC16IS752 (SPI) driving RS-485 at 115200 baud 8N1 on an
> i.MX6ULL based board. Oscilloscope confirmed mid-frame breaks at the
> kfifo wrap-around boundary before the fix; no breaks observed after.
> 
> Fixes: 1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo")
> Cc: stable@vger.kernel.org
> Reported-by: Tobias Gannert <tobias.gannert@ziehl-abegg.de>
> Tested-by: Tobias Gannert <tobias.gannert@ziehl-abegg.de>
> Reviewed-by: Joachim Knorr <joachim.knorr@ziehl-abegg.de>
> Signed-off-by: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>
> ---
>  drivers/tty/serial/sc16is7xx.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index 1a2c4c14f6aa..395a219280be 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -730,9 +730,17 @@ static void sc16is7xx_handle_tx(struct uart_port *port)
>  		txlen = 0;
>  	}
>  
> -	txlen = kfifo_out_linear_ptr(&tport->xmit_fifo, &tail, txlen);
> -	sc16is7xx_fifo_write(port, tail, txlen);
> -	uart_xmit_advance(port, txlen);
> +	/* Handle circular buffer wrap-around by sending in contiguous segments */

Maybe I would drop "by sending in contiguous segments", because it is
more confusing than helping for me, because before your patch it was
already sending one contiguous segment...
Or maybe change to "... by sending multiple segments"?


> +	while (txlen > 0 && !kfifo_is_empty(&tport->xmit_fifo)) {
> +		unsigned int to_send;

You can now move this variable here since it is used only in the
while() scope:
                unsigned char *tail;

> +
> +		to_send = kfifo_out_linear_ptr(&tport->xmit_fifo, &tail, txlen);
> +		if (!to_send)
> +			break;

Insert empty line

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
> 
> 


-- 
Hugo Villeneuve
