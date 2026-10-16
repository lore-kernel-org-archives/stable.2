Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BF941E6D9;
	Fri, 16 Oct 2026 07:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792136343; cv=none; b=LtR0bT25ww9mzJvFjl7i/MamgKELANr8LZf9TJpd135EPxLsrgmTr+lbjQcv0JYNFURm0cmcWztHE3j2VOj5+EZRt3wMasE+X8KBZdeD8zJgehM9aKByiGgPo8LhKzsN/Z347P7N4kNvGWV281QIIUs345nwRPSis0n9l4/Jcnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792136343; c=relaxed/simple;
	bh=P1Vpz241oCnRIVsQNvELb3+qCJNFtHXP0ufKgSWVGFM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PFuO5XDvQ0aktvGSUEVxfT6LlcQ6tp4fe9yPHCU4vELeqwq6lKPYktbsQf3jEQlWVJiust+4LSgyvspPge2QTdcYIdc6VILbhd9Wy9dYvYMc2fTnbqlvsj9G23YDP4aiD40+u5ZMQjd2vI0Nx++84eDht/shiU6WjIdFCgZQ9jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=ekNQvxVZ; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="ekNQvxVZ"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 68F7EA159C;
	Fri, 16 Oct 2026 09:38:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792136329; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6ORstuGpI2xwaV4htJJupzMmSZXKkEYkJCvOPYd3cFg=;
	b=ekNQvxVZizSNYLX8aawzi23/5e7xbjGQxTkJteceg+KNbSCRvCDplNVqUkyWPsRma6/YwD
	lqOVdXYjmFPzySL6Qn20dv5xS97798EM0J4drUxq7aUqrwmFYc48cgO6chy85wUnGMMGNY
	LimvauuG4NICKrohQjN6Tj9AxrgT76WqdiOQ/UmVqXAs81YN3o43w1yS5SFKHZ1A0f5e1H
	12pTHOPRM57jhw+ECUjgK+ByZ/m6MCFC24StjV/UUC7DwsaIbav+phxSv34pbl6NbKNIag
	Gk51gWPKlIB7CkDp+B7IvSvjcDttnJFrk+/lJcrYBy58qRH8uH1sHpcfMKu2wg==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Fri, 16 Oct 2026 09:38:21 +0200
Subject: [PATCH 1/2] serial: amba-pl011: finish a transmission still
 running when RS485 is enabled
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-devel-nbuchwitz-pl011-rs485-reconfig-stall-v1-1-f07d4da714be@tipi-net.de>
References: <20261016-devel-nbuchwitz-pl011-rs485-reconfig-stall-v1-0-f07d4da714be@tipi-net.de>
In-Reply-To: <20261016-devel-nbuchwitz-pl011-rs485-reconfig-stall-v1-0-f07d4da714be@tipi-net.de>
To: Russell King <linux@armlinux.org.uk>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Lino Sanfilippo <LinoSanfilippo@gmx.de>, 
 Nicolai Buchwitz <nb@tipi-net.de>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

Disabling RS485 keeps a transmission in progress running. If RS485 is
enabled again before it ends, the state is OFF while data is still
going out. The TX path does not stop a transmission in state OFF, so
nothing sets the idle RTS level once the data is out and the
transceiver keeps driving the bus.

Hand such a transmission back to RS485 when it is enabled. Assert RTS
and mark it as sending, so that the TX path ends it like any other.
With only the FIFO left the TX path is already done, so drain it from
trigger_stop_tx instead.

Fixes: 97f85204275a ("serial: amba-pl011: keep transmitter enabled when disabling RS485")
Cc: stable@vger.kernel.org
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/tty/serial/amba-pl011.c | 47 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 79776a882ae3..057bb74f3d85 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1734,6 +1734,18 @@ static unsigned int pl011_tx_empty(struct uart_port *port)
 							0 : TIOCSER_TEMT;
 }
 
+/*
+ * Data still queued or on its way out. After RS485 was turned off and on
+ * again during a transmission, the state is OFF while this is true.
+ */
+static bool pl011_tx_pending(struct uart_amba_port *uap)
+{
+	struct tty_port *tport = &uap->port.state->port;
+
+	return !kfifo_is_empty(&tport->xmit_fifo) || pl011_dma_tx_queued(uap) ||
+	       !pl011_tx_empty(&uap->port);
+}
+
 static void pl011_maybe_set_bit(bool cond, unsigned int *ptr, unsigned int mask)
 {
 	if (cond)
@@ -2454,6 +2466,38 @@ static int pl011_verify_port(struct uart_port *port, struct serial_struct *ser)
 	return ret;
 }
 
+/*
+ * RS485 is enabled while data sent before is still going out. Finish it as
+ * an RS485 transmission, so that its end sets the idle level.
+ */
+static void pl011_rs485_tx_resume(struct uart_amba_port *uap,
+				  const struct serial_rs485 *rs485)
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
+	/*
+	 * With only the FIFO left, the TX path does not stop the transmission.
+	 * Drain it from the timer, which runs once the new settings are stored.
+	 */
+	if (kfifo_is_empty(&tport->xmit_fifo) && !pl011_dma_tx_queued(uap)) {
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
@@ -2483,6 +2527,9 @@ static int pl011_rs485_config(struct uart_port *port, struct ktermios *termios,
 		if (tx_pending && !uart_tx_stopped(port) &&
 		    !pl011_dma_tx_start(uap))
 			pl011_start_tx_pio(uap);
+	} else if ((rs485->flags & SER_RS485_ENABLED) &&
+		   uap->rs485_tx_state == OFF && pl011_tx_pending(uap)) {
+		pl011_rs485_tx_resume(uap, rs485);
 	} else if (port->rs485.flags & SER_RS485_ENABLED) {
 		pl011_rs485_tx_stop(uap);
 	}

-- 
2.53.0

