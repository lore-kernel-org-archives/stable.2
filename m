Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795707115;
	b=QuVt0YoxrBXTJkm2tfnTPg1yjWx1wtQI+kJ2Q8AGPjrcRVKVo1Fow3WnEuvbf0zG9H6q
	 yfCuVSd1o+OX7vc0WOjooyruHuami68l8ZBzcHA7ZswHU/6c+lIxQT3tTjd/uiOdx2vnh
	 l7110cmfCqfN8MZZIHy9VxEG2ZgtFDMlzkC+PcMEzzjVF5GVTbyvJqlXy4OVQTLh1xLyN
	 uiHvhp1phq3b9KIIRkmWArjOHIUMO3OvncLcifM0+0f4HvwMTJpLTCJqjxf1mMtXXrZ2b
	 BsQbapYu6Km7eh5j42LREYATXJ1GB4EWnf50KTW0weNJ75x7PjpIoQUs781kwldE9ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795707115;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FkpEZKPI2hA94m4urlurDcfKXrpqgkpcP4+2gXSJxJg=;
	b=vvFAi9zpJP+MZe/OUzLALdHhmSCBzZ0Z7KX5Qw6dumVsypolArCRwDQO/aijx1vVzwgs
	 8lPlvBYb2uDVYRm7+CHdpAgMokNSGWq9D07z+I0uCRoadOBYsv3fKjo37n82YCTC9u7L9
	 wOxXv3AQEczC/Y1VPd0tfGn/EVsFfr64GSB6AL66xR35gSilbP9zq4qpjcG/u/SYn2PbX
	 wvSbqexFDqikv23/AgaKOyeExSXWrmDF/U25BtrOyydBVPyZzqT35xMXKiYdibk80nFem
	 1YytHdiGr+1rET8reSoK4kHax/wpO+26fBjlDTN1X64LN7GxFtaRPR7n8cF8GKKu0xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z6qOvaDk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9221A606A689
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z6qOvaDk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFFD1F000C6;
	Thu, 26 Nov 2026 15:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795707115;
	bh=FkpEZKPI2hA94m4urlurDcfKXrpqgkpcP4+2gXSJxJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z6qOvaDk7h1f6g+NYD93pq9T7UeSrRl61nPXb+gQXu3rxaTsSJIZiTwy9RsT9d0z3
	 RUaCYiZdYYwTxzbxx4MM+JnZFVzkWwNVWQ7AEje40fb6v5D8jK/BIBxzrGYz47HpN7
	 t7TAPKT30635lD7XqdjrwmEltvUpl9zh2cBM69YXp+axTQu+MeU2IUo5Pz7ssQEHr4
	 V2TKTtuLPVcnF1s1L+UeZzKiGJwxfkWVXgBqLZEMeVf64KfUNHu1FFgjNLWQGRxUCS
	 mOogwKCZbrdeI/uLvyZNe5GlSoNst9DYzJMKJnhZXPd5Mq163NMCF9G561p2PKiNtD
	 +bOtLAICgEvaw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] serial: rda: Use port lock wrappers
Date: Thu, 26 Nov 2026 10:31:52 -0500
Message-ID: <20261126153133.2455392-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112541-comfort-tidiness-5bde@gregkh>
References: <2026112541-comfort-tidiness-5bde@gregkh>
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
index a45069e7ebea9..993fa7a91aeaa 100644
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
@@ -411,7 +411,7 @@ static irqreturn_t rda_interrupt(int irq, void *dev_id)
 	unsigned long flags;
 	u32 val, irq_mask;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	/* Clear IRQ cause */
 	val = rda_uart_read(port, RDA_UART_IRQ_CAUSE);
@@ -428,7 +428,7 @@ static irqreturn_t rda_interrupt(int irq, void *dev_id)
 		rda_uart_send_chars(port);
 	}
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	return IRQ_HANDLED;
 }
@@ -439,16 +439,16 @@ static int rda_uart_startup(struct uart_port *port)
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
@@ -459,7 +459,7 @@ static int rda_uart_startup(struct uart_port *port)
 	val |= (RDA_UART_RX_DATA_AVAILABLE | RDA_UART_RX_TIMEOUT);
 	rda_uart_write(port, val, RDA_UART_IRQ_MASK);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	return 0;
 }
@@ -469,7 +469,7 @@ static void rda_uart_shutdown(struct uart_port *port)
 	unsigned long flags;
 	u32 val;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	rda_uart_stop_tx(port);
 	rda_uart_stop_rx(port);
@@ -478,7 +478,7 @@ static void rda_uart_shutdown(struct uart_port *port)
 	val &= ~RDA_UART_ENABLE;
 	rda_uart_write(port, val, RDA_UART_CTRL);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static const char *rda_uart_type(struct uart_port *port)
@@ -518,7 +518,7 @@ static void rda_uart_config_port(struct uart_port *port, int flags)
 		rda_uart_request_port(port);
 	}
 
-	spin_lock_irqsave(&port->lock, irq_flags);
+	uart_port_lock_irqsave(port, &irq_flags);
 
 	/* Clear mask, so no surprise interrupts. */
 	rda_uart_write(port, 0, RDA_UART_IRQ_MASK);
@@ -526,7 +526,7 @@ static void rda_uart_config_port(struct uart_port *port, int flags)
 	/* Clear status register */
 	rda_uart_write(port, 0, RDA_UART_STATUS);
 
-	spin_unlock_irqrestore(&port->lock, irq_flags);
+	uart_port_unlock_irqrestore(port, irq_flags);
 }
 
 static void rda_uart_release_port(struct uart_port *port)
@@ -600,9 +600,9 @@ static void rda_uart_port_write(struct uart_port *port, const char *s,
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
 
@@ -618,7 +618,7 @@ static void rda_uart_port_write(struct uart_port *port, const char *s,
 	rda_uart_write(port, old_irq_mask, RDA_UART_IRQ_MASK);
 
 	if (locked)
-		spin_unlock(&port->lock);
+		uart_port_unlock(port);
 
 	local_irq_restore(flags);
 }
-- 
2.53.0

