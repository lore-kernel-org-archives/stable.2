Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFCE3033E1;
	Mon, 28 Sep 2026 13:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790603264; cv=none; b=RxAB68KZPhd36bLrp+9HdnMPKdWrlCN/fwClO9Pm5cNC2syy4b2Am3raPP6t0vjovpplHc+qnFz0+aa6FcQDUknBOoT5qrIYGTWVqWTEw0p2Q2is3zoa8UyjNLWm/Ok0ljoXao1i7BaANap3cRQml/xtXJQIzQQBVv9DuMagexc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790603264; c=relaxed/simple;
	bh=TdVrV+XoStnJHbbdcVolHs0UuEHkirus5Mdxuy/jvY8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rjiGUBEoo4b2FtEdCYlSFEI9huaJ8fM0zGFtNAVcKzQs/taQqP6g8JzoXWvRo+HcanKg1mPEh/QXJj7jA8vgNcg4fhbg5O1ZcZ/S9EiN2M8gRpvrxJl8mAVjVaADbblDVyU2oZDWkTOdOvv+ci4nw1uasv1ua7JG4a/W8mi+i94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=tXESBM8Y; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="tXESBM8Y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=WaPXt9W8ERF/Z/EHBhvmEv9MDXT+s5lvbmV4Y5KaIMo=; b=tXESBM8YW0rRFBU9XH/usc/ipN
	9PDFH0HnDTj8lY4vQBrYf45bbJ0w2VVIZmLwN0ao2Wd/CTsAGTKk5aFUTsKvWvSlfpjbs2CRfI/k6
	74XLbTMKWm7kGlWqF6vfijKMp66rGiZ9uDJFSalld6blD9ihd2ZDkQj3xcWFq0rP5eqs=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1xBBhe-000000006c9-1WVR;
	Mon, 28 Sep 2026 09:47:34 -0400
Date: Mon, 28 Sep 2026 09:47:33 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>
Cc: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
 <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <tobias.gannert@ziehl-abegg.de>, <joachim.knorr@ziehl-abegg.de>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH v2 RESEND] serial: sc16is7xx: fix TX gap caused by kfifo
 circular buffer wrap-around
Message-Id: <20260928094733.09482cd6d6565588e2ecd267@hugovil.com>
In-Reply-To: <20260928085559.3341419-1-paultyson.mbewe@ziehl-abegg.de>
References: <418f9ae5-8827-475c-b465-1271a784fbf1.bc56e27e-ecd8-43ae-bb87-75bfd472a28d.58f59cf9-4c99-4e79-8e3b-28e6fccd454d@emailsignatures365.codetwo.com>
	<20260928085559.3341419-1-paultyson.mbewe@ziehl-abegg.de>
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

On Mon, 28 Sep 2026 10:55:59 +0200
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
> ---
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
>          struct tty_port *tport = &port->state->port;
>          unsigned long flags;
>          unsigned int txlen;
> -       unsigned char *tail;
>  
>          if (unlikely(port->x_char)) {
>                  sc16is7xx_port_write(port, SC16IS7XX_THR_REG, port->x_char);
> @@ -677,9 +676,19 @@ static void sc16is7xx_handle_tx(struct uart_port *port)
>                  txlen = 0;
>          }
>  
> -       txlen = kfifo_out_linear_ptr(&tport->xmit_fifo, &tail, txlen);
> -       sc16is7xx_fifo_write(port, tail, txlen);
> -       uart_xmit_advance(port, txlen);
> +       /* Handle circular buffer wrap-around by sending multiple segments */
> +       while (txlen > 0 && !kfifo_is_empty(&tport->xmit_fifo)) {
> +               unsigned char *tail;
> +               unsigned int to_send;
> +
> +               to_send = kfifo_out_linear_ptr(&tport->xmit_fifo, &tail, txlen);
> +               if (!to_send)
> +                       break;
> +
> +               sc16is7xx_fifo_write(port, tail, to_send);
> +               uart_xmit_advance(port, to_send);
> +               txlen -= to_send;
> +       }
>  
>          uart_port_lock_irqsave(port, &flags);
>          if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
> --
> 2.43.0
> 
> _______________________________________ 
> 
> ZIEHL-ABEGG 
> 
> Executive Board: Joachim Ley (Chairman), Marco Altherr, Wolfgang Mayer
> Supervisory Board: Dennis Ziehl (Chairman) 
> 
> Court of Registry: District Court Stuttgart HRB 746188
> Company Seat: K&#xFC;nzelsau, Germany 
> 
> Der Inhalt dieser E-Mail und/oder jegliche Anh&#xE4;nge k&#xF6;nnen vertrauliche Mitteilungen enthalten und sind ausschlie&#xDF;lich f&#xFC;r den bezeichneten Adressaten bestimmt.
> Wenn Sie nicht der vorgesehene Adressat dieser E-Mail oder dessen Vertreter sein sollten, so beachten Sie bitte, dass jede Form der Kenntnisnahme, Ver&#xF6;ffentlichung,
> Vervielf&#xE4;ltigung oder Weitergabe des Inhalts dieser E-Mail einschlie&#xDF;lich Anh&#xE4;ngen unzul&#xE4;ssig ist.
> Wir bitten Sie, sich in diesem Fall mit dem Absender der E-Mail in Verbindung zu setzen. 
> 
> The content of this e-mail and/or attachments may contain confidential information and is intended solely for the named recipient.
> If you are not the intended recipient of this e-mail or on its distribution list, please note that any type of disclosure, publication,
> copying or distribution of the content of this e-mail including attachments is strictly forbidden.
> In this case, we would kindly ask you to notify the sender of the e-mail.

It seems you keep sending your patches with that signature, which you
can't do on public kernel mailing lists, and that is why Greg deleted
your previous patch submission.

-- 
Hugo Villeneuve
