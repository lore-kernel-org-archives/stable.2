Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA323C2BB4
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 22:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791239103; cv=none; b=Jw0cSoGFbeJlCyUvLtG5HWqIYPMRMkHblo/WtnDgO0OgBbKSkpDKHp4bd02Eloy21ctF1wxUOfyAeiGgUbyL7iGK8geIXu69v9JyYJEDGS1X+UGEdpjP2NDlFxlwqAvDSTpn3llu+qkIT7+QFtLuhz25//f7lCeBtJZ4LOMOn1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791239103; c=relaxed/simple;
	bh=ML3BHKGAs4z3gsWJ+J7Q7i61cWzNYi/I65rci5Zt9KI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mUhE8T+ugK4XIIUmWE0jBbUZ298sS+s8TmthDgPDXC3Eg5FzaqDWsiHQdPxUoSffkBuXxvIaNnY6QnRIWfTALKYsISRYgQ+VnWyhnDhWUnx0HNIeeqK7TGFL006Vq/uXFn3LnvMLD5lbnOqN/cvkmdXqvlLB8YCxdPMM14FV4TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abNlLk0v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abNlLk0v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91F81F00893;
	Mon,  5 Oct 2026 22:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791239100;
	bh=yd7WmBDm7GIYN5MU/Xoy4nWwC+1DR72eabLhwaXx1fQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=abNlLk0veEw8d6Duf7NXmOxX1JFhRsBdlQvWsDCOMzb2ULSym0RJ+cn/qXLahyms/
	 moCpKe4XTRaw8qf+1s0D84M+p0qEd3X3/3zeLl7Vb+8n8Pue/6A7fZaAJ2/nMhTjee
	 BWvMqKOoRSq0OWsZwH1Ud2vC2wkIjY7OfVb63bM7qWfiBb/IhRn1DuZoLAfnhUDLYo
	 xCYCZ0MUslNgi4KqPZzX8SvPyQn2Sm/P9Ef/uLYOiSplH3WR7Nb2cYf3UNjiHhitdY
	 r3Kn8XLnCzoBsF0win0u4M0fV6L5x0pSYhU0xV0v5pRBnbAVvN4jhQcXwFAKJ3eImR
	 BEWQ4yDD1pT1w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] serial: serial_core: use guard()s
Date: Mon,  5 Oct 2026 18:24:54 -0400
Message-ID: <20261005222419.3425745-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005222419.3425745-1-sashal@kernel.org>
References: <2026100556-skincare-lumping-5e28@gregkh>
 <20261005222419.3425745-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>

[ Upstream commit 56609c0500514d35c7e35adca3bfe6f0061785bf ]

Having all the new guards, use them in the serial_core code. This
improves readability, makes error handling easier, and marks locked
portions of code explicit.

Signed-off-by: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Link: https://lore.kernel.org/r/20250814072456.182853-9-jirislaby@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Leave uart_wait_modem_status() using explicit locking, as required by the
following ioctl hangup fix, and preserve the ordering that sets the task
state before sampling modem counters to avoid lost wakeups.

Include the uart_ioctl() early-return cleanup and the mutex guard in
uart_set_ldisc(). These prepare the ioctl call site and ensure that the
hangup fix can return early from uart_set_ldisc() with the mutex released.

Stable-dep-of: 8ca59f7baee7 ("serial: fix ioctl hangup race")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/serial_core.c | 168 ++++++++++++-------------------
 1 file changed, 63 insertions(+), 105 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 2a33ad1e039d0..381758f640824 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -176,15 +176,13 @@ static void uart_start(struct tty_struct *tty)
 static void
 uart_update_mctrl(struct uart_port *port, unsigned int set, unsigned int clear)
 {
-	unsigned long flags;
 	unsigned int old;
 
-	uart_port_lock_irqsave(port, &flags);
+	guard(uart_port_lock_irqsave)(port);
 	old = port->mctrl;
 	port->mctrl = (old & ~clear) | set;
 	if (old != port->mctrl && !(port->rs485.flags & SER_RS485_ENABLED))
 		port->ops->set_mctrl(port, port->mctrl);
-	uart_port_unlock_irqrestore(port, flags);
 }
 
 #define uart_set_mctrl(port, set)	uart_update_mctrl(port, set, 0)
@@ -219,7 +217,7 @@ static void uart_change_line_settings(struct tty_struct *tty, struct uart_state
 	/*
 	 * Set modem status enables based on termios cflag
 	 */
-	uart_port_lock_irq(uport);
+	guard(uart_port_lock_irq)(uport);
 	if (termios->c_cflag & CRTSCTS)
 		uport->status |= UPSTAT_CTS_ENABLE;
 	else
@@ -240,7 +238,6 @@ static void uart_change_line_settings(struct tty_struct *tty, struct uart_state
 		else
 			__uart_start(state);
 	}
-	uart_port_unlock_irq(uport);
 }
 
 static int uart_alloc_xmit_buf(struct tty_port *port)
@@ -710,7 +707,6 @@ static void uart_send_xchar(struct tty_struct *tty, u8 ch)
 {
 	struct uart_state *state = tty->driver_data;
 	struct uart_port *port;
-	unsigned long flags;
 
 	port = uart_port_ref(state);
 	if (!port)
@@ -719,11 +715,10 @@ static void uart_send_xchar(struct tty_struct *tty, u8 ch)
 	if (port->ops->send_xchar)
 		port->ops->send_xchar(port, ch);
 	else {
-		uart_port_lock_irqsave(port, &flags);
+		guard(uart_port_lock_irqsave)(port);
 		port->x_char = ch;
 		if (ch)
 			port->ops->start_tx(port);
-		uart_port_unlock_irqrestore(port, flags);
 	}
 	uart_port_deref(port);
 }
@@ -1104,7 +1099,6 @@ static int uart_tiocmget(struct tty_struct *tty)
 	struct uart_state *state = tty->driver_data;
 	struct tty_port *port = &state->port;
 	struct uart_port *uport;
-	int result;
 
 	guard(mutex)(&port->mutex);
 
@@ -1112,12 +1106,9 @@ static int uart_tiocmget(struct tty_struct *tty)
 	if (!uport || tty_io_error(tty))
 		return -EIO;
 
-	uart_port_lock_irq(uport);
-	result = uport->mctrl;
-	result |= uport->ops->get_mctrl(uport);
-	uart_port_unlock_irq(uport);
+	guard(uart_port_lock_irq)(uport);
 
-	return result;
+	return uport->mctrl | uport->ops->get_mctrl(uport);
 }
 
 static int
@@ -1446,7 +1437,6 @@ static void uart_set_rs485_rx_during_tx(struct uart_port *port,
 static int uart_rs485_config(struct uart_port *port)
 {
 	struct serial_rs485 *rs485 = &port->rs485;
-	unsigned long flags;
 	int ret;
 
 	if (!(rs485->flags & SER_RS485_ENABLED))
@@ -1456,9 +1446,8 @@ static int uart_rs485_config(struct uart_port *port)
 	uart_set_rs485_termination(port, rs485);
 	uart_set_rs485_rx_during_tx(port, rs485);
 
-	uart_port_lock_irqsave(port, &flags);
-	ret = port->rs485_config(port, NULL, rs485);
-	uart_port_unlock_irqrestore(port, flags);
+	scoped_guard(uart_port_lock_irqsave, port)
+		ret = port->rs485_config(port, NULL, rs485);
 	if (ret) {
 		memset(rs485, 0, sizeof(*rs485));
 		/* unset GPIOs */
@@ -1472,12 +1461,10 @@ static int uart_rs485_config(struct uart_port *port)
 static int uart_get_rs485_config(struct uart_port *port,
 			 struct serial_rs485 __user *rs485)
 {
-	unsigned long flags;
 	struct serial_rs485 aux;
 
-	uart_port_lock_irqsave(port, &flags);
-	aux = port->rs485;
-	uart_port_unlock_irqrestore(port, flags);
+	scoped_guard(uart_port_lock_irqsave, port)
+		aux = port->rs485;
 
 	if (copy_to_user(rs485, &aux, sizeof(aux)))
 		return -EFAULT;
@@ -1490,7 +1477,6 @@ static int uart_set_rs485_config(struct tty_struct *tty, struct uart_port *port,
 {
 	struct serial_rs485 rs485;
 	int ret;
-	unsigned long flags;
 
 	if (!(port->rs485_supported.flags & SER_RS485_ENABLED))
 		return -ENOTTY;
@@ -1505,16 +1491,16 @@ static int uart_set_rs485_config(struct tty_struct *tty, struct uart_port *port,
 	uart_set_rs485_termination(port, &rs485);
 	uart_set_rs485_rx_during_tx(port, &rs485);
 
-	uart_port_lock_irqsave(port, &flags);
-	ret = port->rs485_config(port, &tty->termios, &rs485);
-	if (!ret) {
-		port->rs485 = rs485;
+	scoped_guard(uart_port_lock_irqsave, port) {
+		ret = port->rs485_config(port, &tty->termios, &rs485);
+		if (!ret) {
+			port->rs485 = rs485;
 
-		/* Reset RTS and other mctrl lines when disabling RS485 */
-		if (!(rs485.flags & SER_RS485_ENABLED))
-			port->ops->set_mctrl(port, port->mctrl);
+			/* Reset RTS and other mctrl lines when disabling RS485 */
+			if (!(rs485.flags & SER_RS485_ENABLED))
+				port->ops->set_mctrl(port, port->mctrl);
+		}
 	}
-	uart_port_unlock_irqrestore(port, flags);
 	if (ret) {
 		/* restore old GPIO settings */
 		gpiod_set_value_cansleep(port->rs485_term_gpio,
@@ -1533,15 +1519,13 @@ static int uart_set_rs485_config(struct tty_struct *tty, struct uart_port *port,
 static int uart_get_iso7816_config(struct uart_port *port,
 				   struct serial_iso7816 __user *iso7816)
 {
-	unsigned long flags;
 	struct serial_iso7816 aux;
 
 	if (!port->iso7816_config)
 		return -ENOTTY;
 
-	uart_port_lock_irqsave(port, &flags);
-	aux = port->iso7816;
-	uart_port_unlock_irqrestore(port, flags);
+	scoped_guard(uart_port_lock_irqsave, port)
+		aux = port->iso7816;
 
 	if (copy_to_user(iso7816, &aux, sizeof(aux)))
 		return -EFAULT;
@@ -1553,8 +1537,7 @@ static int uart_set_iso7816_config(struct uart_port *port,
 				   struct serial_iso7816 __user *iso7816_user)
 {
 	struct serial_iso7816 iso7816;
-	int i, ret;
-	unsigned long flags;
+	int i;
 
 	if (!port->iso7816_config)
 		return -ENOTTY;
@@ -1570,11 +1553,11 @@ static int uart_set_iso7816_config(struct uart_port *port,
 		if (iso7816.reserved[i])
 			return -EINVAL;
 
-	uart_port_lock_irqsave(port, &flags);
-	ret = port->iso7816_config(port, &iso7816);
-	uart_port_unlock_irqrestore(port, flags);
-	if (ret)
-		return ret;
+	scoped_guard(uart_port_lock_irqsave, port) {
+		int ret = port->iso7816_config(port, &iso7816);
+		if (ret)
+			return ret;
+	}
 
 	if (copy_to_user(iso7816_user, &port->iso7816, sizeof(port->iso7816)))
 		return -EFAULT;
@@ -1594,37 +1577,20 @@ uart_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 	void __user *uarg = (void __user *)arg;
 	int ret = -ENOIOCTLCMD;
 
-
-	/*
-	 * These ioctls don't rely on the hardware to be present.
-	 */
-	switch (cmd) {
-	case TIOCSERCONFIG:
+	/* This ioctl doesn't rely on the hardware to be present. */
+	if (cmd == TIOCSERCONFIG) {
 		down_write(&tty->termios_rwsem);
 		ret = uart_do_autoconfig(tty, state);
 		up_write(&tty->termios_rwsem);
-		break;
-	}
-
-	if (ret != -ENOIOCTLCMD)
-		goto out;
-
-	if (tty_io_error(tty)) {
-		ret = -EIO;
-		goto out;
+		return ret;
 	}
 
-	/*
-	 * The following should only be used when hardware is present.
-	 */
-	switch (cmd) {
-	case TIOCMIWAIT:
-		ret = uart_wait_modem_status(state, arg);
-		break;
-	}
+	if (tty_io_error(tty))
+		return -EIO;
 
-	if (ret != -ENOIOCTLCMD)
-		goto out;
+	/* This should only be used when the hardware is present. */
+	if (cmd == TIOCMIWAIT)
+		return uart_wait_modem_status(state, arg);
 
 	/* rs485_config requires more locking than others */
 	if (cmd == TIOCSRS485)
@@ -1672,7 +1638,7 @@ uart_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 	mutex_unlock(&port->mutex);
 	if (cmd == TIOCSRS485)
 		up_write(&tty->termios_rwsem);
-out:
+
 	return ret;
 }
 
@@ -1685,11 +1651,10 @@ static void uart_set_ldisc(struct tty_struct *tty)
 	if (!tty_port_initialized(port))
 		return;
 
-	mutex_lock(&state->port.mutex);
+	guard(mutex)(&state->port.mutex);
 	uport = uart_port_check(state);
 	if (uport && uport->ops->set_ldisc)
 		uport->ops->set_ldisc(uport, &tty->termios);
-	mutex_unlock(&state->port.mutex);
 }
 
 static void uart_set_termios(struct tty_struct *tty,
@@ -1786,9 +1751,8 @@ static void uart_tty_port_shutdown(struct tty_port *port)
 	if (WARN(!uport, "detached port still initialized!\n"))
 		return;
 
-	uart_port_lock_irq(uport);
-	uport->ops->stop_rx(uport);
-	uart_port_unlock_irq(uport);
+	scoped_guard(uart_port_lock_irq, uport)
+		uport->ops->stop_rx(uport);
 
 	serial_base_port_shutdown(uport);
 	uart_port_shutdown(port);
@@ -2062,9 +2026,8 @@ static void uart_line_info(struct seq_file *m, struct uart_driver *drv, int i)
 		pm_state = state->pm_state;
 		if (pm_state != UART_PM_STATE_ON)
 			uart_change_pm(state, UART_PM_STATE_ON);
-		uart_port_lock_irq(uport);
-		status = uport->ops->get_mctrl(uport);
-		uart_port_unlock_irq(uport);
+		scoped_guard(uart_port_lock_irq, uport)
+			status = uport->ops->get_mctrl(uport);
 		if (pm_state != UART_PM_STATE_ON)
 			uart_change_pm(state, pm_state);
 
@@ -2400,9 +2363,8 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
 	 */
 	if (!console_suspend_enabled && uart_console(uport)) {
 		if (uport->ops->start_rx) {
-			uart_port_lock_irq(uport);
+			guard(uart_port_lock_irq)(uport);
 			uport->ops->stop_rx(uport);
-			uart_port_unlock_irq(uport);
 		}
 		device_set_awake_path(uport->dev);
 		return 0;
@@ -2418,15 +2380,15 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
 		tty_port_set_suspended(port, true);
 		tty_port_set_initialized(port, false);
 
-		uart_port_lock_irq(uport);
-		ops->stop_tx(uport);
-		if (!(uport->rs485.flags & SER_RS485_ENABLED))
-			ops->set_mctrl(uport, 0);
-		/* save mctrl so it can be restored on resume */
-		mctrl = uport->mctrl;
-		uport->mctrl = 0;
-		ops->stop_rx(uport);
-		uart_port_unlock_irq(uport);
+		scoped_guard(uart_port_lock_irq, uport) {
+			ops->stop_tx(uport);
+			if (!(uport->rs485.flags & SER_RS485_ENABLED))
+				ops->set_mctrl(uport, 0);
+			/* save mctrl so it can be restored on resume */
+			mctrl = uport->mctrl;
+			uport->mctrl = 0;
+			ops->stop_rx(uport);
+		}
 
 		/*
 		 * Wait for the transmitter to empty.
@@ -2495,9 +2457,8 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 			uart_change_pm(state, UART_PM_STATE_ON);
 		uport->ops->set_termios(uport, &termios, NULL);
 		if (!console_suspend_enabled && uport->ops->start_rx) {
-			uart_port_lock_irq(uport);
+			guard(uart_port_lock_irq)(uport);
 			uport->ops->start_rx(uport);
-			uart_port_unlock_irq(uport);
 		}
 		if (console_suspend_enabled)
 			console_start(uport->cons);
@@ -2508,10 +2469,9 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 		int ret;
 
 		uart_change_pm(state, UART_PM_STATE_ON);
-		uart_port_lock_irq(uport);
-		if (!(uport->rs485.flags & SER_RS485_ENABLED))
-			ops->set_mctrl(uport, 0);
-		uart_port_unlock_irq(uport);
+		scoped_guard(uart_port_lock_irq, uport)
+			if (!(uport->rs485.flags & SER_RS485_ENABLED))
+				ops->set_mctrl(uport, 0);
 		if (console_suspend_enabled || !uart_console(uport)) {
 			/* Protected by port mutex for now */
 			struct tty_struct *tty = port->tty;
@@ -2521,11 +2481,11 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 				if (tty)
 					uart_change_line_settings(tty, state, NULL);
 				uart_rs485_config(uport);
-				uart_port_lock_irq(uport);
-				if (!(uport->rs485.flags & SER_RS485_ENABLED))
-					ops->set_mctrl(uport, uport->mctrl);
-				ops->start_tx(uport);
-				uart_port_unlock_irq(uport);
+				scoped_guard(uart_port_lock_irq, uport) {
+					if (!(uport->rs485.flags & SER_RS485_ENABLED))
+						ops->set_mctrl(uport, uport->mctrl);
+					ops->start_tx(uport);
+				}
 				tty_port_set_initialized(port, true);
 			} else {
 				/*
@@ -2619,8 +2579,6 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 	}
 
 	if (port->type != PORT_UNKNOWN) {
-		unsigned long flags;
-
 		uart_report_port(drv, port);
 
 		/* Synchronize with possible boot console. */
@@ -2635,11 +2593,11 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 		 * keep the DTR setting that is set in uart_set_options()
 		 * We probably don't need a spinlock around this, but
 		 */
-		uart_port_lock_irqsave(port, &flags);
-		port->mctrl &= TIOCM_DTR;
-		if (!(port->rs485.flags & SER_RS485_ENABLED))
-			port->ops->set_mctrl(port, port->mctrl);
-		uart_port_unlock_irqrestore(port, flags);
+		scoped_guard(uart_port_lock_irqsave, port) {
+			port->mctrl &= TIOCM_DTR;
+			if (!(port->rs485.flags & SER_RS485_ENABLED))
+				port->ops->set_mctrl(port, port->mctrl);
+		}
 
 		uart_rs485_config(port);
 
-- 
2.53.0

