Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795706748;
	b=YqD0nu8ApdmC3IeXzZzg4UizilWuUbRWaH4eAk6/OCqBkxlKvTvc4rXyd6jmJHx7UCyy
	 CX/LydcWPti7Nnn5olpXb6m6p2wwJ/FuJpFJLhoSYLPjq47fPtlsEac9tKTUq8g133SHq
	 dcJ/kr42MQ7qrmz+YBEjVIH78sgXrbW0qWmSs4LSFFa/LF4JtOlQ7012cJiNAsy06Cp2e
	 c9Mn1fdU7ezD0UdhYEb8kbOT+FjUK9U4l2wNLLlhSRZ6U5IVrNxnhXGzaWnwIha1xdIjN
	 fNgBIzdEsVpkiJvR5D1H4SZ8hdFkqRlUSLf5cGtukskBsWqeACA6AvtQUdGF8ug7N4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795706748;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qwzAWBfF3VyuVH6O/s7BKj/r0HjYkICJ3XJ+bzNzbdM=;
	b=Rn8iqDlFD737Lo/PeH6IaqYZI0qZ8hfMWQdeBhOxW7oYWWcmEAxIzxfPVFBpOPIDdA52
	 8RFsgF8UhDJmToPXKP3xhPV34UUPgA6C5rZ6Iya4ofu8Uo4cJNLgoM3j8igMu5OFwoKxN
	 bvi9xxJBWe8Y5Os0SIRcOkeQRgWIRByoJpFjn0O8g6GcGKCwTBPaSnkRdEikn8aSladDg
	 08p1+IHgfozRtPrS8ZYW0RdkC5dZzV/eHGYZgzoFl2lK/0PA4XyKofvj86Ykfnk1Rhj/X
	 wWdd7OhqPTnE6tHzoI/5Dp4caxYr787y4+AKx8pp62r+BE6gFmO7kw1y/rXFGolVGow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WsLdiveo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16330606A327
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WsLdiveo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500121F000C0;
	Thu, 26 Nov 2026 15:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795706747;
	bh=qwzAWBfF3VyuVH6O/s7BKj/r0HjYkICJ3XJ+bzNzbdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WsLdiveoGtyHllkRevCwFQjs7yMp/VS8TpH40xKQBXw9yap+fG8LrAZjM+PsjELr1
	 J2Ke9U0/GP5rMP1ZeBY6Vf3fhY6YAN151+L165I5wNxj2EoHV4mbhJiWBLsIvNor0u
	 cfhJHfqbvWjb7lQEkKFMtA8rMzSRiGXzeuTD5RYtKUXLl5SDMz+CKrfr18PGAdL3n6
	 tIEQ09eWvr3gD0VXle76vilN5ACc6Hf0l7YzxpmRsGYFYQDzHRJomXTtQwoyTBF0WS
	 HmcQyGaeyDjvqtf/fEsDwPipXn8rWm4evMOmAnrasvtd3kNMLiCFY0Ch+PrRgOx4bc
	 o2NGS5Fsn4/hA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] serial: rda: Use port lock wrappers
Date: Thu, 26 Nov 2026 10:25:44 -0500
Message-ID: <20261126152537.2443991-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112540-fiber-tribute-8e1c@gregkh>
References: <2026112540-fiber-tribute-8e1c@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 7c572c17ca898870822bf7d3a6c32f357527f132 ]

When a serial port is used for kernel console output, then all
modifications to the UART registers which are done from other contexts,
e.g. getty, termios, are interference points for the kernel console.

So far this has been ignored and the printk output is based on the
principle of hope. The rework of the console infrastructure which aims to
support threaded and atomic consoles, requires to mark sections which
modify the UART registers as unsafe. This allows the atomic write function
to make informed decisions and eventually to restore operational state. It
also allows to prevent the regular UART code from modifying UART registers
while printk output is in progress.

All modifications of UART registers are guarded by the UART port lock,
which provides an obvious synchronization point with the console
infrastructure.

To avoid adding this functionality to all UART drivers, wrap the
spin_[un]lock*() invocations for uart_port::lock into helper functions
which just contain the spin_[un]lock*() invocations for now. In a
subsequent step these helpers will gain the console synchronization
mechanisms.

Converted with coccinelle. No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Link: https://lore.kernel.org/r/20230914183831.587273-51-john.ogness@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 859f7c56709b ("serial: rda: free the interrupt on shutdown")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/rda-uart.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/rda-uart.c b/drivers/tty/serial/rda-uart.c
index a8fe1c3ebcd98..b59331fc360bc 100644
--- a/drivers/tty/serial/rda-uart.c
+++ b/drivers/tty/serial/rda-uart.c
@@ -139,12 +139,12 @@ static unsigned int rda_uart_tx_empty(struct uart_port *port)
 	unsigned int ret;
 	u32 val;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	val = rda_uart_read(port, RDA_UART_STATUS);
 	ret = (val & RDA_UART_TX_FIFO_MASK) ? TIOCSER_TEMT : 0;
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	return ret;
 }
@@ -246,7 +246,7 @@ static void rda_uart_set_termios(struct uart_port *port,
 	unsigned int baud;
 	u32 irq_mask;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	baud = uart_get_baud_rate(port, termios, old, 9600, port->uartclk / 4);
 	rda_uart_change_baudrate(rda_port, baud);
@@ -325,7 +325,7 @@ static void rda_uart_set_termios(struct uart_port *port,
 	/* update the per-port timeout */
 	uart_update_timeout(port, termios->c_cflag, baud);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void rda_uart_send_chars(struct uart_port *port)
@@ -409,7 +409,7 @@ static irqreturn_t rda_interrupt(int irq, void *dev_id)
 	unsigned long flags;
 	u32 val, irq_mask;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	/* Clear IRQ cause */
 	val = rda_uart_read(port, RDA_UART_IRQ_CAUSE);
@@ -426,7 +426,7 @@ static irqreturn_t rda_interrupt(int irq, void *dev_id)
 		rda_uart_send_chars(port);
 	}
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	return IRQ_HANDLED;
 }
@@ -437,16 +437,16 @@ static int rda_uart_startup(struct uart_port *port)
 	int ret;
 	u32 val;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	rda_uart_write(port, 0, RDA_UART_IRQ_MASK);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	ret = request_irq(port->irq, rda_interrupt, IRQF_NO_SUSPEND,
 			  "rda-uart", port);
 	if (ret)
 		return ret;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	val = rda_uart_read(port, RDA_UART_CTRL);
 	val |= RDA_UART_ENABLE;
@@ -457,7 +457,7 @@ static int rda_uart_startup(struct uart_port *port)
 	val |= (RDA_UART_RX_DATA_AVAILABLE | RDA_UART_RX_TIMEOUT);
 	rda_uart_write(port, val, RDA_UART_IRQ_MASK);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	return 0;
 }
@@ -467,7 +467,7 @@ static void rda_uart_shutdown(struct uart_port *port)
 	unsigned long flags;
 	u32 val;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	rda_uart_stop_tx(port);
 	rda_uart_stop_rx(port);
@@ -476,7 +476,7 @@ static void rda_uart_shutdown(struct uart_port *port)
 	val &= ~RDA_UART_ENABLE;
 	rda_uart_write(port, val, RDA_UART_CTRL);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static const char *rda_uart_type(struct uart_port *port)
@@ -516,7 +516,7 @@ static void rda_uart_config_port(struct uart_port *port, int flags)
 		rda_uart_request_port(port);
 	}
 
-	spin_lock_irqsave(&port->lock, irq_flags);
+	uart_port_lock_irqsave(port, &irq_flags);
 
 	/* Clear mask, so no surprise interrupts. */
 	rda_uart_write(port, 0, RDA_UART_IRQ_MASK);
@@ -524,7 +524,7 @@ static void rda_uart_config_port(struct uart_port *port, int flags)
 	/* Clear status register */
 	rda_uart_write(port, 0, RDA_UART_STATUS);
 
-	spin_unlock_irqrestore(&port->lock, irq_flags);
+	uart_port_unlock_irqrestore(port, irq_flags);
 }
 
 static void rda_uart_release_port(struct uart_port *port)
@@ -598,9 +598,9 @@ static void rda_uart_port_write(struct uart_port *port, const char *s,
 	if (port->sysrq) {
 		locked = 0;
 	} else if (oops_in_progress) {
-		locked = spin_trylock(&port->lock);
+		locked = uart_port_trylock(port);
 	} else {
-		spin_lock(&port->lock);
+		uart_port_lock(port);
 		locked = 1;
 	}
 
@@ -616,7 +616,7 @@ static void rda_uart_port_write(struct uart_port *port, const char *s,
 	rda_uart_write(port, old_irq_mask, RDA_UART_IRQ_MASK);
 
 	if (locked)
-		spin_unlock(&port->lock);
+		uart_port_unlock(port);
 
 	local_irq_restore(flags);
 }
-- 
2.53.0

