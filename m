Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794470938;
	b=GPDApRYSph+cxWDZQRGcRN6VVwr/HnuPDxblSs1G2ktBjIhpG47wAClGc+XSgNxeL+cf
	 JhPQi3NpmvIeA7DV5R+2XxdClC3waLRDh2fj1UsjYYkHk2xgawWGUZmuolUDm+O1Z4MoW
	 EoMJ6WHIHZpPfAYn1ChzJ8OlT5MzxJjqlMVnvCwgJy8nBdvfl2tvBB5OV4JZ6BXz6jDAW
	 71n2naIv0gYMCuSKbAdCgMkww9MRkip52ksW9PcL4n9JZULWxZoB+970RtspZK+zDhJo7
	 RJJr7brGSMx8SDEZ7qFUb5wBGIp5/2kGrGqW1qUXcgEqEooH/sKHz3lg5Og+sq5bxmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794470938;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=YXumx7zTrHr94qWuIde28XemX3sHJ1fMcOG+i6oYMSA=;
	b=TtHpnYoutyodDfXqgy3l2tvjZ7CJZAsi5mFUodB4RC6JPp47Kr+iLJ5QV1FUrJDacdvC
	 aoXr3R2ipM1s/xcS0Ri1lUJZ/zWs0DHsUPOMFxOSGZzTK1nZWAPkRLebkMp+mrzoZhYEk
	 g/2FoKibAkSjIYNyRpENb7b5k2nynfRWD2d4yrW6d6TpMJGwEHuUG0GdnCAyF83MbYN0q
	 IAHi7CCzOG/xhxKEu/JgiNATmPwaAIH6SfYRZd7czchfz9Y6PbVJXre7HaAtRfimItJxI
	 6xYCONZncsulUC0NzTmdeDg1+9Pqp8Wq2KOKmJXafg3On71xyxprZHHCWQnJi8Dybyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=pMvl4Lvt;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73DA606A32A;
	Thu, 12 Nov 2026 08:08:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A73DA606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=pMvl4Lvt
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D3254A1678;
	Thu, 12 Nov 2026 09:08:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1794470936; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=YXumx7zTrHr94qWuIde28XemX3sHJ1fMcOG+i6oYMSA=;
	b=pMvl4Lvt2V47+U2PYDpdBsU2O/GboGPD/aklRyvVLbOdzrZcVJF+h4rJo6PS6GnTeY8RTK
	sVCrIefMaQHG5+hNk4i3diY2DsqBbZyo0pY+To+iDxZ2pi6+fwiUrUyTxfB/UT3n3iW1Ie
	wdPpRoWtDs33YxKlX805Ga6gsBOXAVp/G0+T59fYjb0LjCEntKVafRap9OZWNuKLEMnfVo
	/NwrWZwD2uI2uuT0qHiRJoP4nC1J7VOMxu9tYGDgAIiQVxBxGE5Sv/U5GLV39+kAxYQ9d/
	qf69HlikJg21NhinLABJdWjjNbXMjAwd9iBsF5IuGO7ZwD865PhVeyj+1bmh1w==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Thu, 12 Nov 2026 09:08:51 +0100
Subject: [PATCH RESEND v4 1/2] serial: amba-pl011: finish a transmission
 still running when RS485 is enabled
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-devel-nbuchwitz-pl011-rs485-reconfig-stall-v4-1-b5c58ff3a376@tipi-net.de>
References: <20261112-devel-nbuchwitz-pl011-rs485-reconfig-stall-v4-0-b5c58ff3a376@tipi-net.de>
In-Reply-To: <20261112-devel-nbuchwitz-pl011-rs485-reconfig-stall-v4-0-b5c58ff3a376@tipi-net.de>
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
port. While PIO or DMA still feeds the FIFO, assert RTS and mark it as
sending, so that the TX path ends it like any other. With only the FIFO
left, drain it from trigger_stop_tx instead. Data that is queued but not
started yet, for example while output is stopped, is not part of the
transmission.

Fixes: 97f85204275a ("serial: amba-pl011: keep transmitter enabled when disabling RS485")
Cc: stable@vger.kernel.org # 6.18.x: 1b6d660e038b: serial: amba-pl011: drive the bus during break in RS485 mode
Cc: stable@vger.kernel.org # 6.18.x
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/tty/serial/amba-pl011.c | 57 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 79776a882ae35..1edbe75611e63 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1285,6 +1285,11 @@ static inline bool pl011_dma_tx_queued(struct uart_amba_port *uap)
 	return uap->dmatx.queued;
 }
 
+static inline bool pl011_dma_tx_active(struct uart_amba_port *uap)
+{
+	return uap->dmacr & UART011_TXDMAE;
+}
+
 #else
 /* Blank functions if the DMA engine is not available */
 static inline void pl011_dma_remove(struct uart_amba_port *uap)
@@ -1341,6 +1346,11 @@ static inline bool pl011_dma_tx_queued(struct uart_amba_port *uap)
 	return false;
 }
 
+static inline bool pl011_dma_tx_active(struct uart_amba_port *uap)
+{
+	return false;
+}
+
 #define pl011_dma_flush_buffer	NULL
 #endif
 
@@ -1734,6 +1744,12 @@ static unsigned int pl011_tx_empty(struct uart_port *port)
 							0 : TIOCSER_TEMT;
 }
 
+/* PIO or DMA still feeds the FIFO */
+static bool pl011_tx_active(struct uart_amba_port *uap)
+{
+	return (uap->im & UART011_TXIM) || pl011_dma_tx_active(uap);
+}
+
 static void pl011_maybe_set_bit(bool cond, unsigned int *ptr, unsigned int mask)
 {
 	if (cond)
@@ -2454,6 +2470,42 @@ static int pl011_verify_port(struct uart_port *port, struct serial_struct *ser)
 	return ret;
 }
 
+/*
+ * Data from before RS485 was enabled is still going out. Finish it as an
+ * RS485 transmission, so that its end sets the idle level.
+ */
+static void pl011_rs485_tx_resume(struct uart_amba_port *uap,
+				  const struct serial_rs485 *rs485)
+{
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
+	if (pl011_tx_active(uap)) {
+		uap->rs485_tx_state = SEND;
+		return;
+	}
+
+	/* Only the FIFO is left. The timer drains it with the new settings */
+	uap->rs485_tx_state = WAIT_AFTER_SEND;
+	hrtimer_start(&uap->trigger_stop_tx, uap->rs485_tx_drain_interval,
+		      HRTIMER_MODE_REL);
+}
+
 static int pl011_rs485_config(struct uart_port *port, struct ktermios *termios,
 			      struct serial_rs485 *rs485)
 {
@@ -2483,6 +2535,11 @@ static int pl011_rs485_config(struct uart_port *port, struct ktermios *termios,
 		if (tx_pending && !uart_tx_stopped(port) &&
 		    !pl011_dma_tx_start(uap))
 			pl011_start_tx_pio(uap);
+	} else if ((rs485->flags & SER_RS485_ENABLED) &&
+		   uap->rs485_tx_state == OFF &&
+		   tty_port_initialized(&port->state->port) &&
+		   (pl011_tx_active(uap) || !pl011_tx_empty(port))) {
+		pl011_rs485_tx_resume(uap, rs485);
 	} else if (port->rs485.flags & SER_RS485_ENABLED) {
 		pl011_rs485_tx_stop(uap);
 	}

-- 
2.53.0

