Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795705792;
	b=Igu+v1gcUnd3tFkEGnvSn0tpPGm2WHsnOIs67jZfar+45gbmzWAGExRoupz/k2nAkKHS
	 iWfq/tMB5kzCFEt079a9n0AW9gRHXi14QcN6UBp3PRzbpGz1Prlyp8/VPmLDjc7oXTQZo
	 WOtjVIkgIj4XsCVuE1tFUrs+yD8EDXiCG/UCeZEqjeaht0wTG+cU4lmoDBtRE0gJzCGht
	 v8oP3MXLLvNgFTNfRjJC1ePvsLBxuvPq11xUrkGFAiBoS9nuoZbbR9u926r7CTH5Co9Ff
	 rLy6mbCZDZ/rFYfOKleHd+ZHpQB7bpZM6mL5WHqTZ8mG67lkHbAc0dx+nyqEEbt4YWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705792;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XYXTI29ec0bGEx/UUCDrsd+P6YDZWwWnn7oYD2WTmHc=;
	b=MQz/e58+aGsx6brKn75t19wh8iS2RPXaHEkpZAX7B8/BXXw0ob8Eg6Tv5VoDnM43R5E3
	 Z9QoWzEVq2hk3jCH2rra2FhoImDDMM7eUMCu2qfrvxPqZNG5DyvEg2aMv/A1LaSlflwuV
	 iaKNjR1IrsIuT1CVpAoRsL/WYGSB+k2zqpDDLQM1ap6fBsdMuJKIyk85AuxL/pN78Fsw9
	 UYWmxP94L5NqQBInpa0yxZovBYoFtdgHlQ/NXVtS6LsRVS3B9R3ajwITfwygGrFH6ySBp
	 dts/+MxkD7bWbijDohZKx/eTCpQpJz+kAXGbZ5tQZauFVQvJIj17EOJ8gKOc4O/OP2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zrf0vJSN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E080606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zrf0vJSN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF001F000CF;
	Thu, 26 Nov 2026 15:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795705792;
	bh=XYXTI29ec0bGEx/UUCDrsd+P6YDZWwWnn7oYD2WTmHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zrf0vJSNUG3CNOz6gCh3DbKHm4mZNF1iI3q8IFPx8c4zenhTbiOe5oF1QuYnicmKD
	 h2kOVRdiZXZ3BCf+3ipfj5mj2QjezZ8nCTH/5/uaa6WE6B3j8uQ7EgwCK9FnTqsxRk
	 jK3KxdGhGQPD2I1JsmSM/To0g/zqJjT0/Uv8KlEjYvysUf2G3a5tS5Q6b10PItw54i
	 1+bLyw2YM6qncO0iJx8OATL/4770ZDDFKPMFeJ6i0o6pvfkjAhFAaogdmv7YMpcJW3
	 g81VixtbGCXa+41dWj6ltoyYpgsRL/q0fonSMsOeGg4ZoT7j+MVmDU8e2PR0VrZETL
	 tX+7HgbRziTDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] serial: rda: Use port lock wrappers
Date: Thu, 26 Nov 2026 10:09:49 -0500
Message-ID: <20261126150942.2245374-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112540-stoic-jittery-a891@gregkh>
References: <2026112540-stoic-jittery-a891@gregkh>
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
index be5c842b5ba95..d824c8318f330 100644
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
@@ -408,7 +408,7 @@ static irqreturn_t rda_interrupt(int irq, void *dev_id)
 	unsigned long flags;
 	u32 val, irq_mask;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	/* Clear IRQ cause */
 	val = rda_uart_read(port, RDA_UART_IRQ_CAUSE);
@@ -425,7 +425,7 @@ static irqreturn_t rda_interrupt(int irq, void *dev_id)
 		rda_uart_send_chars(port);
 	}
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	return IRQ_HANDLED;
 }
@@ -436,16 +436,16 @@ static int rda_uart_startup(struct uart_port *port)
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
@@ -456,7 +456,7 @@ static int rda_uart_startup(struct uart_port *port)
 	val |= (RDA_UART_RX_DATA_AVAILABLE | RDA_UART_RX_TIMEOUT);
 	rda_uart_write(port, val, RDA_UART_IRQ_MASK);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	return 0;
 }
@@ -466,7 +466,7 @@ static void rda_uart_shutdown(struct uart_port *port)
 	unsigned long flags;
 	u32 val;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	rda_uart_stop_tx(port);
 	rda_uart_stop_rx(port);
@@ -475,7 +475,7 @@ static void rda_uart_shutdown(struct uart_port *port)
 	val &= ~RDA_UART_ENABLE;
 	rda_uart_write(port, val, RDA_UART_CTRL);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static const char *rda_uart_type(struct uart_port *port)
@@ -515,7 +515,7 @@ static void rda_uart_config_port(struct uart_port *port, int flags)
 		rda_uart_request_port(port);
 	}
 
-	spin_lock_irqsave(&port->lock, irq_flags);
+	uart_port_lock_irqsave(port, &irq_flags);
 
 	/* Clear mask, so no surprise interrupts. */
 	rda_uart_write(port, 0, RDA_UART_IRQ_MASK);
@@ -523,7 +523,7 @@ static void rda_uart_config_port(struct uart_port *port, int flags)
 	/* Clear status register */
 	rda_uart_write(port, 0, RDA_UART_STATUS);
 
-	spin_unlock_irqrestore(&port->lock, irq_flags);
+	uart_port_unlock_irqrestore(port, irq_flags);
 }
 
 static void rda_uart_release_port(struct uart_port *port)
@@ -597,9 +597,9 @@ static void rda_uart_port_write(struct uart_port *port, const char *s,
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
 
@@ -615,7 +615,7 @@ static void rda_uart_port_write(struct uart_port *port, const char *s,
 	rda_uart_write(port, old_irq_mask, RDA_UART_IRQ_MASK);
 
 	if (locked)
-		spin_unlock(&port->lock);
+		uart_port_unlock(port);
 
 	local_irq_restore(flags);
 }
-- 
2.53.0

