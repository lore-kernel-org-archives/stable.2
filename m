Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DF118C332
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 15:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780673468; cv=none; b=GCEL6N0VHne3tbnH12qn7lrAf2gawf1yjRHDhO8gUUGdeaFQTq/p2l/5KgyG+fvz7XhetSDXLGkTALbIQ/aPnd9pKUhvqZnLDSgyBdTiatAV1H+unW1+R+RvsFb7Pb9hc6Z/PgXl2qGHwL1LZV/V6GqHndsoX4rmmKaJ6HYseo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780673468; c=relaxed/simple;
	bh=LrB0WBrTirA/+Oy764yY+ZvCGsi0OImeTAPAjTYYIZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ouLYnCjY1t0cB/s1oTRlr3iGEgUMPP8Cupm3YjZGYd41qGn64ZvHD9bGsKBuODvqY/rmYtgqAJPRzO8Ak79krGHyTt60OXfBDCEY6FDhZpfIJKLk2MRdEMvbmBba3bNtOd+qwGoFfZE19ofY6ruTxRME+Wy6b2tuAH/I5OX+PoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzwOK/0d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzwOK/0d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33ACA1F00899;
	Fri,  5 Jun 2026 15:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780673466;
	bh=+nkQ2bvfirnp8pIzWMAnzy3GHGW81OnbXGHKV+JCNnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XzwOK/0doQYFH4Gapi6HG6rshtBrV+TWIsbdnFx6pZlC7edpxWScIP2mSVHEiqNMU
	 Vpd3FtCTGycF/UgvNrFJqouhnEYh5DjdOCARb8Zjawb9+0l2vy7Ec39iZZkeTh65q1
	 kJnus5tbiHm/kJtGnHMA4aldGs2Vaw1PTfwDzcyCQc2z8B0XFnbAb0d/yN6lZ47TPR
	 x7FW461020mRf9gJ3djpVQsP8tcqZ95PFlYRe89kBcTmhMUgp7yXNq7vwQZuZeEsp7
	 xFmTUU8hYpb5XKFp+DjAyneiwcDLAYviyHAOCDkZ+7jr/LFX1zKFzDtyAx8tAyzSJA
	 3jGc6AUEmfQfQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] serial: samsung_tty: Use port lock wrappers
Date: Fri,  5 Jun 2026 11:31:02 -0400
Message-ID: <20260605153104.1929085-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060428-showdown-storeroom-5e99@gregkh>
References: <2026060428-showdown-storeroom-5e99@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 97d7a9aeba1d424c2359f1686d02c75d798ad184 ]

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
Link: https://lore.kernel.org/r/20230914183831.587273-54-john.ogness@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: a3bb136bff5e ("tty: serial: samsung: Remove redundant port lock acquisition in rx helpers")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/samsung_tty.c | 50 ++++++++++++++++----------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 589daed19e625a..eff5f55e44a533 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -251,7 +251,7 @@ static void s3c24xx_serial_rx_enable(struct uart_port *port)
 	unsigned int ucon, ufcon;
 	int count = 10000;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	while (--count && !s3c24xx_serial_txempty_nofifo(port))
 		udelay(100);
@@ -265,7 +265,7 @@ static void s3c24xx_serial_rx_enable(struct uart_port *port)
 	wr_regl(port, S3C2410_UCON, ucon);
 
 	ourport->rx_enabled = 1;
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void s3c24xx_serial_rx_disable(struct uart_port *port)
@@ -274,14 +274,14 @@ static void s3c24xx_serial_rx_disable(struct uart_port *port)
 	unsigned long flags;
 	unsigned int ucon;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	ucon = rd_regl(port, S3C2410_UCON);
 	ucon &= ~S3C2410_UCON_RXIRQMODE;
 	wr_regl(port, S3C2410_UCON, ucon);
 
 	ourport->rx_enabled = 0;
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void s3c24xx_serial_stop_tx(struct uart_port *port)
@@ -349,7 +349,7 @@ static void s3c24xx_serial_tx_dma_complete(void *args)
 				dma->tx_transfer_addr, dma->tx_size,
 				DMA_TO_DEVICE);
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	xmit->tail = (xmit->tail + count) & (UART_XMIT_SIZE - 1);
 	port->icount.tx += count;
@@ -359,7 +359,7 @@ static void s3c24xx_serial_tx_dma_complete(void *args)
 		uart_write_wakeup(port);
 
 	s3c24xx_serial_start_next_tx(ourport);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void enable_tx_dma(struct s3c24xx_uart_port *ourport)
@@ -625,7 +625,7 @@ static void s3c24xx_serial_rx_dma_complete(void *args)
 	received  = dma->rx_bytes_requested - state.residue;
 	async_tx_ack(dma->rx_desc);
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	if (received)
 		s3c24xx_uart_copy_rx_to_tty(ourport, t, received);
@@ -637,7 +637,7 @@ static void s3c24xx_serial_rx_dma_complete(void *args)
 
 	s3c64xx_start_rx_dma(ourport);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void s3c64xx_start_rx_dma(struct s3c24xx_uart_port *ourport)
@@ -728,7 +728,7 @@ static irqreturn_t s3c24xx_serial_rx_chars_dma(void *dev_id)
 	utrstat = rd_regl(port, S3C2410_UTRSTAT);
 	rd_regl(port, S3C2410_UFSTAT);
 
-	spin_lock(&port->lock);
+	uart_port_lock(port);
 
 	if (!(utrstat & S3C2410_UTRSTAT_TIMEOUT)) {
 		s3c64xx_start_rx_dma(ourport);
@@ -757,7 +757,7 @@ static irqreturn_t s3c24xx_serial_rx_chars_dma(void *dev_id)
 	wr_regl(port, S3C2410_UTRSTAT, S3C2410_UTRSTAT_TIMEOUT);
 
 finish:
-	spin_unlock(&port->lock);
+	uart_port_unlock(port);
 
 	return IRQ_HANDLED;
 }
@@ -854,9 +854,9 @@ static irqreturn_t s3c24xx_serial_rx_chars_pio(void *dev_id)
 	struct s3c24xx_uart_port *ourport = dev_id;
 	struct uart_port *port = &ourport->port;
 
-	spin_lock(&port->lock);
+	uart_port_lock(port);
 	s3c24xx_serial_rx_drain_fifo(ourport);
-	spin_unlock(&port->lock);
+	uart_port_unlock(port);
 
 	return IRQ_HANDLED;
 }
@@ -938,11 +938,11 @@ static irqreturn_t s3c24xx_serial_tx_irq(int irq, void *id)
 	struct s3c24xx_uart_port *ourport = id;
 	struct uart_port *port = &ourport->port;
 
-	spin_lock(&port->lock);
+	uart_port_lock(port);
 
 	s3c24xx_serial_tx_chars(ourport);
 
-	spin_unlock(&port->lock);
+	uart_port_unlock(port);
 	return IRQ_HANDLED;
 }
 
@@ -1038,7 +1038,7 @@ static void s3c24xx_serial_break_ctl(struct uart_port *port, int break_state)
 	unsigned long flags;
 	unsigned int ucon;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	ucon = rd_regl(port, S3C2410_UCON);
 
@@ -1049,7 +1049,7 @@ static void s3c24xx_serial_break_ctl(struct uart_port *port, int break_state)
 
 	wr_regl(port, S3C2410_UCON, ucon);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static int s3c24xx_serial_request_dma(struct s3c24xx_uart_port *p)
@@ -1308,7 +1308,7 @@ static int s3c64xx_serial_startup(struct uart_port *port)
 	ourport->rx_enabled = 1;
 	ourport->tx_enabled = 0;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	ufcon = rd_regl(port, S3C2410_UFCON);
 	ufcon |= S3C2410_UFCON_RESETRX | S5PV210_UFCON_RXTRIG8;
@@ -1318,7 +1318,7 @@ static int s3c64xx_serial_startup(struct uart_port *port)
 
 	enable_rx_pio(ourport);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	/* Enable Rx Interrupt */
 	s3c24xx_clear_bit(port, S3C64XX_UINTM_RXD, S3C64XX_UINTM);
@@ -1346,7 +1346,7 @@ static int apple_s5l_serial_startup(struct uart_port *port)
 	ourport->rx_enabled = 1;
 	ourport->tx_enabled = 0;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	ufcon = rd_regl(port, S3C2410_UFCON);
 	ufcon |= S3C2410_UFCON_RESETRX | S5PV210_UFCON_RXTRIG8;
@@ -1356,7 +1356,7 @@ static int apple_s5l_serial_startup(struct uart_port *port)
 
 	enable_rx_pio(ourport);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	/* Enable Rx Interrupt */
 	s3c24xx_set_bit(port, APPLE_S5L_UCON_RXTHRESH_ENA, S3C2410_UCON);
@@ -1633,7 +1633,7 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
 		ulcon |= S3C2410_LCON_PNONE;
 	}
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	dev_dbg(port->dev,
 		"setting ulcon to %08x, brddiv to %d, udivslot %08x\n",
@@ -1691,7 +1691,7 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
 	if ((termios->c_cflag & CREAD) == 0)
 		port->ignore_status_mask |= RXSTAT_DUMMY_READ;
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static const char *s3c24xx_serial_type(struct uart_port *port)
@@ -2476,14 +2476,14 @@ s3c24xx_serial_console_write(struct console *co, const char *s,
 	if (cons_uart->sysrq)
 		locked = false;
 	else if (oops_in_progress)
-		locked = spin_trylock_irqsave(&cons_uart->lock, flags);
+		locked = uart_port_trylock_irqsave(cons_uart, &flags);
 	else
-		spin_lock_irqsave(&cons_uart->lock, flags);
+		uart_port_lock_irqsave(cons_uart, &flags);
 
 	uart_console_write(cons_uart, s, count, s3c24xx_serial_console_putchar);
 
 	if (locked)
-		spin_unlock_irqrestore(&cons_uart->lock, flags);
+		uart_port_unlock_irqrestore(cons_uart, flags);
 }
 
 /* Shouldn't be __init, as it can be instantiated from other module */
-- 
2.53.0

