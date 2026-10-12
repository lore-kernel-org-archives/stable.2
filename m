Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF41748E0D3;
	Mon, 12 Oct 2026 14:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815045; cv=none; b=U3J2sQZ3V0US61PGWNcmYV45HzgShNiRRSICSE/IrxHr4Z6ARoiHmdUUAbC3aXmQnv3Qd49/WSKV1EZItCq08Yxhg6OUye9nQp9BmGJFdzB/BvuWmLWNSytsUpdZY6h3w0bIT2VHA5zBACUep9JmFhCQuYQv/ghKS0rdiVIOJ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815045; c=relaxed/simple;
	bh=e5u7Q6/lf+tkTUuzF7jxOV25e2hAJ1vVxdBBAWz1Occ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Pwhbmb2477E4DzsnYM5rTJ0jw7Uw4V9n3A4UTQMN1oyJIwesMhXg9aTQmmfTLSLvWUUs6z9KMaQ19LTKXQ6RsH8A9o4ZNXYrAQ5ko4gUFNH9St80FQWdsjUWCGZna92+x+xrNXF++1jYR5jNDNP8JfdaVDt/Kb8LFXIjii2ztN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=zf7kh9tQ; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="zf7kh9tQ"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 55138A012B;
	Mon, 12 Oct 2026 16:23:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791815032; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=QVj3/QJ0hK8bdL+nizOsq34wKHXNf3Wx2LzCotAFaeM=;
	b=zf7kh9tQpNkyVPBEAXbq81UOCDmvnBwRxr9dZoexhY3/rU/YDft8JwSL7vg7fJxTS5ce5x
	cEZjfxQqwHX4uRIGeDLMfQEDSX+ZKrlmwjVIM744fEabEnsVfSpEHwSU0A9eM2ky/pHgWc
	6zl0Mm+KKZDcRWgxDshLoIrO2DtljfkVvMczC8PdyHoYG5XeHe29NPXyyxRwie8Rnvqhtn
	C0MjHlWBc6phmNRB0p8oHzzGJ0hUBxUpa8pMcTajjj1KjFydWPJljAl/KV2BGlbaZPhJlM
	iQc1VYF458G9zvGcX08HRTdT++PeyKRPZ4baNE5TBd38FhXzvVL6Z7qxCJ2Wlw==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Mon, 12 Oct 2026 16:23:50 +0200
Subject: [PATCH v2] serial: amba-pl011: keep transmitter enabled when
 disabling RS485
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-fix-pl011-rs485-txe-v2-1-e9bf7d218389@tipi-net.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NwQ6CMBBEf4X07JpuwSqe/A/DAcpW1hggbSUY0
 n+3xbu3ecmbmU14ckxeXItNOFrY8zQmUIdCmKEdHwTcJxZKKo0SESyvML9ycr66nCCsBFYjoal
 1betWpObsKGn76r35sX93TzIhT2VjYB8m99lvF8ze/4cFAaGUqtNGllV3trfAM8NI4diTaGKMX
 xkdK0XKAAAA
X-Change-ID: 20261011-fix-pl011-rs485-txe-f61e1c969f9a
To: Russell King <linux@armlinux.org.uk>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 stable@vger.kernel.org, Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

Disabling RS485 on an open port calls pl011_rs485_tx_stop(), which
turns off the transmitter. Only the RS485 TX path turns it back on, so
any later output stays queued and tcdrain() hangs until the port is
closed.

pl011_rs485_tx_stop() also checks only the hardware FIFO. If a DMA
transfer has started but has not filled the FIFO yet, the transmitter
is turned off under the transfer and the DMA channel never recovers.

When leaving RS485 mode, cancel pending deferred starts and stops, leave
the transmitter enabled and start any TX that was still waiting for
delay_rts_before_send.

Fixes: 8d479237727c ("serial: amba-pl011: add RS485 support")
Cc: stable@vger.kernel.org
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
Noticed while implementing a DMX master on a CM5 with its PL011.
Userspace turns RS485 mode off to send the break, and the port then
stopped transmitting.

Tested on that board with an RS485 transceiver at 9600, 115200 and
250000 baud.
---
Changes in v2:
- Start TX that was still waiting for delay_rts_before_send instead of
  dropping it (sashiko)
- Link to v1: https://patch.msgid.link/20261011-fix-pl011-rs485-txe-v1-1-302b6c034b7f@tipi-net.de

To: Russell King <linux@armlinux.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
To: Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org
---
 drivers/tty/serial/amba-pl011.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index c4824c201e1c..2ad6ccfdb52c 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2397,8 +2397,31 @@ static int pl011_rs485_config(struct uart_port *port, struct ktermios *termios,
 	struct uart_amba_port *uap =
 		container_of(port, struct uart_amba_port, port);
 
-	if (port->rs485.flags & SER_RS485_ENABLED)
+	if ((port->rs485.flags & SER_RS485_ENABLED) &&
+	    !(rs485->flags & SER_RS485_ENABLED)) {
+		bool tx_pending = uap->rs485_tx_state == WAIT_AFTER_RTS;
+		u32 cr = pl011_read(uap, REG_CR);
+
+		/*
+		 * Leaving RS485 mode, which only enables the transmitter while
+		 * sending. Don't stop it, as that stalls a DMA transfer still
+		 * in flight. Drop pending deferred starts and stops and keep
+		 * it enabled.
+		 */
+		hrtimer_try_to_cancel(&uap->trigger_start_tx);
+		hrtimer_try_to_cancel(&uap->trigger_stop_tx);
+		uap->rs485_tx_state = OFF;
+
+		cr |= UART011_CR_TXE | UART011_CR_RXE;
+		pl011_write(cr, uap, REG_CR);
+
+		/* Start TX that was still waiting for delay_rts_before_send */
+		if (tx_pending && !uart_tx_stopped(port) &&
+		    !pl011_dma_tx_start(uap))
+			pl011_start_tx_pio(uap);
+	} else if (port->rs485.flags & SER_RS485_ENABLED) {
 		pl011_rs485_tx_stop(uap);
+	}
 
 	/* Make sure auto RTS is disabled */
 	if (rs485->flags & SER_RS485_ENABLED) {

---
base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
change-id: 20261011-fix-pl011-rs485-txe-f61e1c969f9a

Best regards,
--  
Nicolai Buchwitz <nb@tipi-net.de>

