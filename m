Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1476E483811;
	Mon, 19 Oct 2026 09:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792401268; cv=none; b=CKVW3SlEJrtb9G8dv7ld/nXHHyg9jS3svPrRC+jnTwpoLixqpq2XfPPOdVlHW+3sklHKmeREoa9MydNFgOOD7ZcqgcG+RncxroN4x/R7wi+oGzVBeG8ekMqZ4aDiIThpZrKJDQBHPGV4+2D2u8T49gvPe+spi6SbYLXn++FBI9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792401268; c=relaxed/simple;
	bh=ETsdBunU5Pm9sm6F94Q+a8Fh5KMzgM/XJRIn2yqYrbU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BzEykOrGiWmvGbrjSKWlxLU3faYi/jv8hSCkfeWvFUynUUVuV/62yfjIOOXG5oiDWbq3J1sbFhGM7c7uJteSiyoT+3/uER3Cd1RZIerHBZLrISbk/Be9+b8aQBsmNkZPAtDn81u2SXIiEKMRYDsjhmoUtr9NPhu/UrWobv10NHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=5r9nG45Y; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="5r9nG45Y"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6688CA161E;
	Mon, 19 Oct 2026 11:14:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792401261; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=qJgFV+rbIgkZlkrw2Uy+ooquHPD+BJRODHYc0jMUxHc=;
	b=5r9nG45YK3n4xriFlF1j0fRmwGYQv/GmA/6R/OBBc/y6I6WwhiLDsDZmBIrcfJxz/11VgK
	UhO3ApqmZje9V2yvDxrwCrY2aeUUIivTgO6z42lQswhosVsH288+a2onLLOcdGn87g/Lzn
	beWidF7ayXRc94Zdqkyrc/Bq8PB6iDN1dp72Ux1V148gwvC9XGzvNbwPjCM1o5W8U1FXlt
	NDYW9ciyIJ+BuDLuOTo4+v5C0OXp7BS1sWkJRJ6vNTXc8B07mk++cqcCQiO+uIxsXgBzaz
	Cy7YmrCpWX2cQGoxS4iTcJ0CmQTH6qYvQXJ2HpsQHlNw/IsjR+26J7rT0EDcfw==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Mon, 19 Oct 2026 11:14:12 +0200
Subject: [PATCH v3 1/2] serial: amba-pl011: finish a transmission still
 running when RS485 is enabled
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-devel-nbuchwitz-pl011-rs485-reconfig-stall-v3-1-072a9c82ea5e@tipi-net.de>
References: <20261019-devel-nbuchwitz-pl011-rs485-reconfig-stall-v3-0-072a9c82ea5e@tipi-net.de>
In-Reply-To: <20261019-devel-nbuchwitz-pl011-rs485-reconfig-stall-v3-0-072a9c82ea5e@tipi-net.de>
To: Russell King <linux@armlinux.org.uk>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Lino Sanfilippo <LinoSanfilippo@gmx.de>, 
 Nicolai Buchwitz <nb@tipi-net.de>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

Disabling RS485 during a transmission keeps it running. If RS485 is
enabled again before it ends, the state is OFF while data is still going
out. The TX path does not end a transmission in state OFF, so nothing
sets the idle RTS level afterwards and the transceiver keeps driving the
bus.

Hand such a transmission back to RS485 when it is enabled on an open
port. Assert RTS and mark it as sending, so that the TX path ends it
like any other. With only the FIFO left or output stopped, the TX path
won't run again, so drain the FIFO from trigger_stop_tx instead. Data
queued while output is stopped is not part of the transmission. Pause
DMA first, as output is marked stopped before the driver pauses it.

Fixes: 97f85204275a ("serial: amba-pl011: keep transmitter enabled when disabling RS485")
Cc: stable@vger.kernel.org # 6.18.x: 1b6d660e038b: serial: amba-pl011: drive the bus during break in RS485 mode
Cc: stable@vger.kernel.org
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/tty/serial/amba-pl011.c | 67 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 79776a882ae35..6adfe7a1e0487 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1734,6 +1734,18 @@ static unsigned int pl011_tx_empty(struct uart_port *port)
 							0 : TIOCSER_TEMT;
 }
 
+/* While output is stopped, only data already in the FIFO counts */
+static bool pl011_tx_pending(struct uart_amba_port *uap, bool stopped)
+{
+	struct tty_port *tport = &uap->port.state->port;
+
+	if (!pl011_tx_empty(&uap->port))
+		return true;
+
+	return !stopped &&
+	       (!kfifo_is_empty(&tport->xmit_fifo) || pl011_dma_tx_queued(uap));
+}
+
 static void pl011_maybe_set_bit(bool cond, unsigned int *ptr, unsigned int mask)
 {
 	if (cond)
@@ -2454,13 +2466,63 @@ static int pl011_verify_port(struct uart_port *port, struct serial_struct *ser)
 	return ret;
 }
 
+/*
+ * Data from before RS485 was enabled is still going out. Finish it as an
+ * RS485 transmission, so that its end sets the idle level.
+ */
+static void pl011_rs485_tx_resume(struct uart_amba_port *uap,
+				  const struct serial_rs485 *rs485, bool stopped)
+{
+	struct tty_port *tport = &uap->port.state->port;
+	u32 cr = pl011_read(uap, REG_CR);
+
+	cr |= UART011_CR_TXE;
+	if (!(rs485->flags & SER_RS485_RX_DURING_TX))
+		cr &= ~UART011_CR_RXE;
+	if (rs485->flags & SER_RS485_RTS_ON_SEND)
+		cr &= ~UART011_CR_RTS;
+	else
+		cr |= UART011_CR_RTS;
+	pl011_write(cr, uap, REG_CR);
+
+	/* pl011_break_ctl() ends the transmission when the break ends */
+	if (pl011_read(uap, REG_LCRH_TX) & UART01x_LCRH_BRK) {
+		uap->rs485_break = true;
+		uap->rs485_tx_state = SEND;
+		return;
+	}
+
+	/*
+	 * With only the FIFO left or output stopped, the TX path won't end it.
+	 * The timer does, once the new settings are stored.
+	 */
+	if (stopped ||
+	    (kfifo_is_empty(&tport->xmit_fifo) && !pl011_dma_tx_queued(uap))) {
+		uap->rs485_tx_state = WAIT_AFTER_SEND;
+		hrtimer_start(&uap->trigger_stop_tx, uap->rs485_tx_drain_interval,
+			      HRTIMER_MODE_REL);
+	} else {
+		uap->rs485_tx_state = SEND;
+	}
+}
+
 static int pl011_rs485_config(struct uart_port *port, struct ktermios *termios,
 			      struct serial_rs485 *rs485)
 {
 	struct uart_amba_port *uap =
 		container_of(port, struct uart_amba_port, port);
+	bool tx_stopped = uart_tx_stopped(port);
 
 	uap->rs485_break = false;
+
+	/*
+	 * Output is marked stopped before stop_tx pauses DMA. Pause it now, so
+	 * that clearing TXE below cannot strand DMA data in the FIFO. Output
+	 * stopped after this check is ended by stop_tx.
+	 */
+	if ((rs485->flags & SER_RS485_ENABLED) && tx_stopped)
+		pl011_dma_tx_stop(uap);
+
 	if ((port->rs485.flags & SER_RS485_ENABLED) &&
 	    !(rs485->flags & SER_RS485_ENABLED)) {
 		bool tx_pending = uap->rs485_tx_state == WAIT_AFTER_RTS;
@@ -2483,6 +2545,11 @@ static int pl011_rs485_config(struct uart_port *port, struct ktermios *termios,
 		if (tx_pending && !uart_tx_stopped(port) &&
 		    !pl011_dma_tx_start(uap))
 			pl011_start_tx_pio(uap);
+	} else if ((rs485->flags & SER_RS485_ENABLED) &&
+		   uap->rs485_tx_state == OFF &&
+		   tty_port_initialized(&port->state->port) &&
+		   pl011_tx_pending(uap, tx_stopped)) {
+		pl011_rs485_tx_resume(uap, rs485, tx_stopped);
 	} else if (port->rs485.flags & SER_RS485_ENABLED) {
 		pl011_rs485_tx_stop(uap);
 	}

-- 
2.53.0

