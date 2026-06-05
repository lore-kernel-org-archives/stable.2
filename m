Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6133264DA
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780667609; cv=none; b=jA4FM7wIlf1UbAD6bKarGiaBT0wHnnvKoFsIqZ489Dl3MBezTDDlGeSYvsMlIuSAkMP3JMzsvMejylTwZMvU0hqw7ClDfb9eSZhskrrnmoepTn/nNS7pWax1iO8f94nAXBYIZW0KqVtGkXmtjAKzxRA6qUXsjnNN/SUrWHZCFKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780667609; c=relaxed/simple;
	bh=mqEt80kSj8JumJFKhu7HQRKzEwEi80ftu1LQPW6s67k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZlI3/9xMC4HR7ZRNaEOC9/Y5Purl4KdcgF3cecCm6IcTWp6NbOQvuM9c39b4bJvkcoERzDKFxJFRCW847hMpPd3rAv4ya72OSYDpqTjg0+h4yL+yqqUL4YsxN+xjTfh5SnAmjKN0W4eJqyALGkPJW5osoNeucHuczcvBIUXbiUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kb2K0rIu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kb2K0rIu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6161F00893;
	Fri,  5 Jun 2026 13:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780667607;
	bh=hOOl24Z75D8OczN5w2hbGNKgjcHhQnUQJW7AqaWOyag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kb2K0rIuUfVgurDcfBzJzMvDaSIz3KCAlZvUSVuF112eIDZaf9eOS/D4hqRl0Fmla
	 9+zFjG9SzO3MsxyLjZkd88y96KaMIL0NHlV7tSYBVDrlj5ACCISjMpG9lxVgzScO9Z
	 s6/2WvdFUfh3PMYoco4zsEVI+v75XFDvJp/8ajzRyrjSY1OekV+L4qqwKCXtiGVK5c
	 mtbgJzvqhN14p3k50h6VYm/iG+VLYp7FldFqUHy39xRsVLirYWqbD7qZDy2Rq+uMEy
	 fktUWiNG9UaTBwCvONuKysphrJ/J6SeuPMPEkxgg64BQJT9VvDJYVbkxsJrYY+a4OX
	 XAfY6zA4tpXLg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] serial: samsung_tty: Use port lock wrappers
Date: Fri,  5 Jun 2026 09:53:22 -0400
Message-ID: <20260605135324.928676-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060427-payroll-estimator-0ec1@gregkh>
References: <2026060427-payroll-estimator-0ec1@gregkh>
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
index 5a4d88e134715d..a82b65155f6ee9 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -248,7 +248,7 @@ static void s3c24xx_serial_rx_enable(struct uart_port *port)
 	unsigned int ucon, ufcon;
 	int count = 10000;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	while (--count && !s3c24xx_serial_txempty_nofifo(port))
 		udelay(100);
@@ -262,7 +262,7 @@ static void s3c24xx_serial_rx_enable(struct uart_port *port)
 	wr_regl(port, S3C2410_UCON, ucon);
 
 	ourport->rx_enabled = 1;
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void s3c24xx_serial_rx_disable(struct uart_port *port)
@@ -271,14 +271,14 @@ static void s3c24xx_serial_rx_disable(struct uart_port *port)
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
@@ -344,7 +344,7 @@ static void s3c24xx_serial_tx_dma_complete(void *args)
 				dma->tx_transfer_addr, dma->tx_size,
 				DMA_TO_DEVICE);
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	uart_xmit_advance(port, count);
 	ourport->tx_in_progress = 0;
@@ -353,7 +353,7 @@ static void s3c24xx_serial_tx_dma_complete(void *args)
 		uart_write_wakeup(port);
 
 	s3c24xx_serial_start_next_tx(ourport);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void enable_tx_dma(struct s3c24xx_uart_port *ourport)
@@ -619,7 +619,7 @@ static void s3c24xx_serial_rx_dma_complete(void *args)
 	received  = dma->rx_bytes_requested - state.residue;
 	async_tx_ack(dma->rx_desc);
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	if (received)
 		s3c24xx_uart_copy_rx_to_tty(ourport, t, received);
@@ -631,7 +631,7 @@ static void s3c24xx_serial_rx_dma_complete(void *args)
 
 	s3c64xx_start_rx_dma(ourport);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void s3c64xx_start_rx_dma(struct s3c24xx_uart_port *ourport)
@@ -722,7 +722,7 @@ static irqreturn_t s3c24xx_serial_rx_chars_dma(void *dev_id)
 	utrstat = rd_regl(port, S3C2410_UTRSTAT);
 	rd_regl(port, S3C2410_UFSTAT);
 
-	spin_lock(&port->lock);
+	uart_port_lock(port);
 
 	if (!(utrstat & S3C2410_UTRSTAT_TIMEOUT)) {
 		s3c64xx_start_rx_dma(ourport);
@@ -751,7 +751,7 @@ static irqreturn_t s3c24xx_serial_rx_chars_dma(void *dev_id)
 	wr_regl(port, S3C2410_UTRSTAT, S3C2410_UTRSTAT_TIMEOUT);
 
 finish:
-	spin_unlock(&port->lock);
+	uart_port_unlock(port);
 
 	return IRQ_HANDLED;
 }
@@ -849,9 +849,9 @@ static irqreturn_t s3c24xx_serial_rx_chars_pio(void *dev_id)
 	struct s3c24xx_uart_port *ourport = dev_id;
 	struct uart_port *port = &ourport->port;
 
-	spin_lock(&port->lock);
+	uart_port_lock(port);
 	s3c24xx_serial_rx_drain_fifo(ourport);
-	spin_unlock(&port->lock);
+	uart_port_unlock(port);
 
 	return IRQ_HANDLED;
 }
@@ -932,11 +932,11 @@ static irqreturn_t s3c24xx_serial_tx_irq(int irq, void *id)
 	struct s3c24xx_uart_port *ourport = id;
 	struct uart_port *port = &ourport->port;
 
-	spin_lock(&port->lock);
+	uart_port_lock(port);
 
 	s3c24xx_serial_tx_chars(ourport);
 
-	spin_unlock(&port->lock);
+	uart_port_unlock(port);
 	return IRQ_HANDLED;
 }
 
@@ -1032,7 +1032,7 @@ static void s3c24xx_serial_break_ctl(struct uart_port *port, int break_state)
 	unsigned long flags;
 	unsigned int ucon;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	ucon = rd_regl(port, S3C2410_UCON);
 
@@ -1043,7 +1043,7 @@ static void s3c24xx_serial_break_ctl(struct uart_port *port, int break_state)
 
 	wr_regl(port, S3C2410_UCON, ucon);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static int s3c24xx_serial_request_dma(struct s3c24xx_uart_port *p)
@@ -1302,7 +1302,7 @@ static int s3c64xx_serial_startup(struct uart_port *port)
 	ourport->rx_enabled = 1;
 	ourport->tx_enabled = 0;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	ufcon = rd_regl(port, S3C2410_UFCON);
 	ufcon |= S3C2410_UFCON_RESETRX | S5PV210_UFCON_RXTRIG8;
@@ -1312,7 +1312,7 @@ static int s3c64xx_serial_startup(struct uart_port *port)
 
 	enable_rx_pio(ourport);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	/* Enable Rx Interrupt */
 	s3c24xx_clear_bit(port, S3C64XX_UINTM_RXD, S3C64XX_UINTM);
@@ -1340,7 +1340,7 @@ static int apple_s5l_serial_startup(struct uart_port *port)
 	ourport->rx_enabled = 1;
 	ourport->tx_enabled = 0;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	ufcon = rd_regl(port, S3C2410_UFCON);
 	ufcon |= S3C2410_UFCON_RESETRX | S5PV210_UFCON_RXTRIG8;
@@ -1350,7 +1350,7 @@ static int apple_s5l_serial_startup(struct uart_port *port)
 
 	enable_rx_pio(ourport);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	/* Enable Rx Interrupt */
 	s3c24xx_set_bit(port, APPLE_S5L_UCON_RXTHRESH_ENA, S3C2410_UCON);
@@ -1625,7 +1625,7 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
 		ulcon |= S3C2410_LCON_PNONE;
 	}
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	dev_dbg(port->dev,
 		"setting ulcon to %08x, brddiv to %d, udivslot %08x\n",
@@ -1683,7 +1683,7 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
 	if ((termios->c_cflag & CREAD) == 0)
 		port->ignore_status_mask |= RXSTAT_DUMMY_READ;
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static const char *s3c24xx_serial_type(struct uart_port *port)
@@ -2375,14 +2375,14 @@ s3c24xx_serial_console_write(struct console *co, const char *s,
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

