Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC53770836
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 12:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782218743; cv=none; b=JJm++RFZrxirWV92mWQKF/NtoAy+6lzYvXZdHMSh6ZxAwDftl3odeYwbdhHkqEDbe4vVcXR9CSms9jl9U5A0NRc3mPj1AWa4ZNItaUTxKU4H/xWUe4UlFtqma7vRaVA5HhE7ogSqGd+Y/9E6RINiGKE3aalhQxUxpiHMQe1Cq4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782218743; c=relaxed/simple;
	bh=12XLuvcFEdpiLjg8m6O4SlfogygmG0J+88QKluZo+pc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q8Rry0PwTUqlak0zdgWBq0IqmB4rgqwmZEj0H1/drtcdbXzI/IsKEV/LZRRAH4dWwJrjAb5D0rUt8V0xgqr0WGlft8345PKIA/kdjT7fMqiT/+b14/M2Fhlj93kwUMS1wGjNMxUM16LEO3jjkfaco6dWZGR1xAXSJ7qcCUU4Iq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9D9AxeH; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9D9AxeH"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4908b92904fso79710585e9.0
        for <stable@vger.kernel.org>; Tue, 23 Jun 2026 05:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782218740; x=1782823540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4mJg0nUfH/qXV/LDdhbPnN4vwQCHkWrUXyQyrAvL/o=;
        b=i9D9AxeH9/dn4V2S2LUgyFmq3nrVFApjq46te3ONZ3a1qtkomjj48NmZzBA5+QFtUY
         iC2Y+9rXL0DDWAbTTfbdvHCXRIkZsbd8MeClrpyVpSzHWyfhN1PaYdKHgFFFRxlzBlpN
         0dR/P3T0/mf4oHgCC+UzJvzj2DD/hB4X1quWg5yIK8UUgXb/0cqdpKbbF6+utc4KAKY2
         PccmxuRLZ11PM3K98oiJqzwbdhcRIi3GjlCnzLIZfDH47ckQQod+oZgH5La79iLZsD5d
         opWpZ1RxH0Xy48KYQ8vk+dhYkC5g21y0HX9Ke634HG2ymfFdoM8JMWDA4FkkybAcGRY4
         cPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782218740; x=1782823540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t4mJg0nUfH/qXV/LDdhbPnN4vwQCHkWrUXyQyrAvL/o=;
        b=LgnQXWvqkVJi5qGCq9+RXljHl7z9RNOsFO7+iK+qcRxIdnS9+UaTtkKTXvGvTgX44n
         NAvqti6AmqEDF4njfcFabXXltoX/qN97pfDknPL4xwsYpQBTVxLLN/cB7hd7f8UkadZH
         gmIWmMvMM2/VuVTa46ybY5YfOXbdIxK9Pw1Q932iuZKeNytJYAhr1CJkbWYpOXdc+DnQ
         QIUOfTtLopdP7ZArpZHSisoYKBKog1W3qC8ImWV669Xrq+ZQMNR2Tn4kzxuxqZu2vNYP
         HtTNBRvi2nBEMZWSQN2aI+GJQIopjOFO/sYCMNuVNEzO07uYj1Z8c7QH9SZ3ffVS0ocH
         pnCQ==
X-Forwarded-Encrypted: i=1; AFNElJ/M9vKmK3QGva6saJcYPoSyX0jGDnJOeqlhJQE7WsmPtuTiPGrKKinietlh5/MCgHQXFENdjrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsLfNrbWN5VxcKUylHTXDrWNzbAhDO+kxi/K4kyFOzmjTSRgRQ
	wzacjSzZiKg5aSaITvVnIzuTK33hrbgw59Ty4SxhjpZxMJN/z1bRdgdf
X-Gm-Gg: AfdE7ck/BMWSgJQWS5pcqzZum2Lr4JYb2ac3DsLYtUIKVvuyBRv04dfcrLlQSUQkSm1
	1AaPoVnUSk+OQ1bEcrSE4D9IOysMXAOpWtatP1Lk48rewQryVwYFVxJgtIR38ABtt6xgKtRdEg1
	EReVtvP7zL+oKTZxarkDwSaLnrpofgA4iC8j0DLd6j3OL8rgLCeGxEDdm1n3bv9r9UX6D0nugSw
	ked6nSs3oHb7EvWWC99NPvgSBclfmE9GC1kU00gqPREn6CR8AJZNMdMFYmBZAkdapq6FcUEr/Nx
	Pd2yRZje72JqH4xuYw/k5ok7YS+3NCdqhXzoVzZECYoRlXokPFAIN6L2WK9w0wuhpHdc/t3xeLd
	FxEWJC6dTbcTua05Wv51ckrfSLTH5ZhdKB6exuEaM1y0C4G+j0cOd6yhhg9GYhdV34rp8n+huoZ
	+SWk0VU4PsA7HMnzdaiDJRRZgBAWeJE1vkmefzek8ea1XjJwSvpQ==
X-Received: by 2002:a05:600c:8716:b0:492:4fda:7720 with SMTP id 5b1f17b1804b1-4925b35d3b5mr37719745e9.14.1782218739953;
        Tue, 23 Jun 2026 05:45:39 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492494496cdsm266226755e9.10.2026.06.23.05.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 05:45:39 -0700 (PDT)
Date: Tue, 23 Jun 2026 13:45:36 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>
Cc: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
 <hvilleneuve@dimonoff.com>, <stable@vger.kernel.org>, Tobias Gannert
 <tobias.gannert@ziehl-abegg.de>, Joachim Knorr
 <joachim.knorr@ziehl-abegg.de>
Subject: Re: [PATCH 2/2] serial: sc16is7xx: set TX FIFO trigger level to
 half FIFO to prevent underruns
Message-ID: <20260623134536.24dca506@pumpkin>
In-Reply-To: <20260623112225.82386-3-paultyson.mbewe@ziehl-abegg.de>
References: <20260623112225.82386-1-paultyson.mbewe@ziehl-abegg.de>
	<20260623112225.82386-3-paultyson.mbewe@ziehl-abegg.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jun 2026 13:22:25 +0200
Paul Mbewe <paultyson.mbewe@ziehl-abegg.de> wrote:

> The THRI interrupt (IER[1]) fires when the TX FIFO free space reaches the
> configured threshold. With the reset default (TLR=0), the chip falls back
> to the FCR TX trigger of 8 free spaces (FCR[5:4]=00), causing THRI to
> assert after every 8 bytes drain from the FIFO.
> 
> At 115200 baud 8N1, 8 bytes drain in 694 us. On slow single-core SPI
> hosts, the combined latency of an SPI IIR read, TXLVL read, and 8-byte
> THR write per interrupt, plus kthread scheduling jitter, can exceed this
> window on a loaded system. When the kthread cannot refill the FIFO within
> 694 us, the FIFO empties and produces an idle gap on the TX line.

That seems strange.
The earlier interrupt (8 free fifo spaces) ought to make it less likely
that the fifo will underrun.

Are you sure it isn't the other way around?
So the interrupt happens when there are 8 bytes left in the fifo.
With a 64 byte fifo each interrupt would fill at least 56 bytes.
Increasing it to 32 (bytes left in the fifo) gives more time for the
interrupt latency (etc), but reduces the number of bytes written by
each isr to at least 32.

The other possibility is some error passing the level sensitive 'fifo empty'
state through to scheduling the kthread.

It may well be that the system interrupt latency is small enough that you
can take the interrupt at 'half full', and that the associated reduction
in the number of interrupts makes the system behave better.
But this isn't what the commit message says.

	David

> 
> This violates the Modbus RTU specification, which treats any intra-frame
> silence longer than 1.5 character times (~130 us at 115200 baud) as a
> frame boundary, causing receivers to fragment frames and report CRC errors.
> Oscilloscope measurements confirmed a 757 us inter-burst gap during
> continuous transmission without this fix.
> 
> Setting the TX trigger to 32 free spaces (half FIFO) via TLR[3:0]=8
> widens the refill window to 2778 us at 115200 baud, reducing THRI events
> per 256-byte frame from ~32 to ~8 and eliminating the underrun.
> 
> Only TLR[3:0] is written; TLR[7:4] is left at zero, so the RX trigger
> retains its FCR default. Only TX interrupt timing is affected.
> 
> While increasing the SPI clock would also reduce per-round-trip latency,
> the driver should work correctly regardless of SPI speed. The fix belongs
> in the driver.
> 
> Tested on i.MX6ULL (ARM Cortex-A7, single-core) with SC16IS752IBS over
> SPI at 1 MHz, 115200 baud 8N1, 256-byte Modbus RTU frames under production
> load:
> 
>   IRQ thread (irq/134-spi2.0):  ~15-17%  ->  ~5%    (~67% reduction)
>   sys CPU:                       ~51-61%  ->  ~19-28% (~55% reduction)
>   load average:                  ~2.0-2.2 ->  ~0.65-1.3
> 
> No mid-frame gaps observed after fix. Without fix, oscilloscope confirmed
> 757 us inter-burst gaps causing Modbus frame fragmentation.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Tobias Gannert <tobias.gannert@ziehl-abegg.de>
> Tested-by: Tobias Gannert <tobias.gannert@ziehl-abegg.de>
> Reviewed-by: Joachim Knorr <joachim.knorr@ziehl-abegg.de>
> Signed-off-by: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>
> ---
>  drivers/tty/serial/sc16is7xx.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index 395a219280be..476e0dd3fa7f 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -1196,6 +1196,16 @@ static int sc16is7xx_startup(struct uart_port *port)
>  			     SC16IS7XX_TCR_RX_RESUME(24) |
>  			     SC16IS7XX_TCR_RX_HALT(48));
>  
> +	/*
> +	 * Set TX FIFO trigger level to 32 spaces (half FIFO) via TLR. The reset
> +	 * default (TLR=0) falls back to the FCR TX trigger of 8 free spaces,
> +	 * requiring ~8 SPI round-trips per 64-byte FIFO load. On slow single-core
> +	 * SPI hosts, this accumulated latency can cause a TX FIFO underrun gap
> +	 * between bursts.
> +	 */
> +	sc16is7xx_port_write(port, SC16IS7XX_TLR_REG,
> +			     SC16IS7XX_TLR_TX_TRIGGER(32));
> +
>  	/* Disable TCR/TLR access */
>  	sc16is7xx_port_update(port, SC16IS7XX_MCR_REG, SC16IS7XX_MCR_TCRTLR_BIT, 0);
>  

