Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792583134;
	b=qesGlIRIGTxoPD6BSXs6WgY5sBr5991VtIU+EmXuuIXFwFyFrsSZo2Z+WYtAdbDNzhE9
	 QIbFAWS35vFbhjFeE5UGnPYU55++m0fgekAjeVNKivlAyKM4u8HHXHSBsobdSSnOX3dlc
	 /pOTufdW7arsOK2uP3VL9kpCFLzlEG/4KrKEuNzd1mUUE5otxDQPTYaBwh/WI+cU+43PF
	 DItf6aeA9tTN/fyd+fH/oL86vgIQsJaaGmtqO0P6VjXzA5Y9bkMaEI5q6bIsXmrSDtC46
	 HD9WPV7/wm3NcdbatL2TZZQ+np0i+NKFcmr0yG6l3b1HxfD3L3tT7Fgw7C4q/3lE43Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792583134;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=YXumx7zTrHr94qWuIde28XemX3sHJ1fMcOG+i6oYMSA=;
	b=LROSmcamWfrWHVh9cnKlooJhwF9F9E7tscCTOIKOewygEYlvAqRAothGJk7z7zDrqxAW
	 yI9STwej7pFvNnl5XW0VlzTMwXtdR/LOdTT9LJSKY9hiysrlXkJ/l3mkAml6/KmZIzVJf
	 7qXYyf1T7X/JHKCwpFpsO5Dx0TJWKQNeawM3giiGT02eUyrtLY+euCYOzgUpu6CyriOoF
	 Y5GdXcRqPrmZdKVWdoKgYBUu7hivFR892Y4eiucv364AUzAcLPM6o8CKW4vIeFUFGR0/3
	 HtGmF++1XhoQBUwfhMJZEjLqgr+DDCU/dqrUFEFjsL203B/FzQN4pCkAel/rS8mofHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=gkJLLH9M;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63F1606A321;
	Wed, 21 Oct 2026 11:45:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B63F1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=gkJLLH9M
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ABB19A1626;
	Wed, 21 Oct 2026 13:45:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792583130; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=YXumx7zTrHr94qWuIde28XemX3sHJ1fMcOG+i6oYMSA=;
	b=gkJLLH9MgMRr6QtFERcHA97HdEJs7eubvmK2oH9Qz4QvlVnvYNHBiiUFVQab9BjcSroBw8
	PxjcP1YWvCZQ5UIgv1aCoVBL2JO4cM4ymKvarwm4ZQoljqPGavb/nmE4rokl8Scw+2sQU/
	3pO1Icz26tXFw7UlhkGXLfBxxpEx6UQlBRRSE1D/ryIhNIxTGSLYSo9hDaB23Lvdm6WOad
	nirXl1EgASxdSyURt7i8gIt9Eg39teu3OR+ecC4TlNsV/2sfAvm4OQQglrwZ01CfRJTMz0
	TbFpBHG6/mme7yBuo6b91rQMdWRYt9z/QjSpJIPuVpkV+kdFA3Yg9Nwg0sbDzw==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Wed, 21 Oct 2026 13:45:22 +0200
Subject: [PATCH v4 1/2] serial: amba-pl011: finish a transmission still
 running when RS485 is enabled
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
Message-Id: <20261021-devel-nbuchwitz-pl011-rs485-reconfig-stall-v4-1-ed10e219159a@tipi-net.de>
References: <20261021-devel-nbuchwitz-pl011-rs485-reconfig-stall-v4-0-ed10e219159a@tipi-net.de>
In-Reply-To: <20261021-devel-nbuchwitz-pl011-rs485-reconfig-stall-v4-0-ed10e219159a@tipi-net.de>
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

