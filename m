Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFBA409624;
	Fri,  4 Sep 2026 11:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788522317; cv=none; b=Lue9i4nY+as8LSzOzpEPbovd7J/wk+M25UVQA3DXMNT5yEVR1gw+Lqt+1JwsEguKsSEjpiReAv+bODanEKjntIoL+W+x7eUfmZL6W63JNaPExfjLh4WT0G++TrIBsFdC16EshBSrqLzerAP4LiltnZqTjTtHLKHVvcblWdUNDkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788522317; c=relaxed/simple;
	bh=FaBeAMRHl+rx7geJPB4JImFJWNXCPdDdVLQ6qarzyo0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pJCznAd8kv3YIJPm82d0bumJrIAoWDBAJ//kVTbQoiHWzBm6IaIexSXhzWcEZaU+zK7clq/iuRxH9Bl6vBle1vmbPEvMh0vDi8eQQD/3pG3GNc43LTHX8/S18aiNaNnWfoXBwBNQfg0FIcSTRQWgdFIsgArL19aBj0cfkB+gBco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdD6/emr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdD6/emr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59FA61F00A3E;
	Fri,  4 Sep 2026 11:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788522315;
	bh=LwuY1rXitDNsVaFuMeOwWfQr8oiaOeC08TkleCwI42o=;
	h=From:To:Cc:Subject:Date;
	b=XdD6/emrU5rkPfWMRVXbfIoandoNpOuK2XWf3WDm0OP26AYSRWpMzTsFfU7HrdQnZ
	 mCrcJSxldahWmJ//fy7ZJDhV9dmwO4URUVvEd/H3WBwm6dnrUZ6hipQ4qryJ2f7io1
	 55Kx82LGhDfnDaPVLKbKvXBv2NzhUcHiSpNFg7SDFDIA3unXb8/Lot6tlqy2tdG2ED
	 sF9QsTlSZBlGjq0DDDbOUEVlQat1217qT3MPJwm+PNzovt+IZWxT+WGvA+WF4YbTCR
	 s5QEZqWeMEyaMEcP5oLW7lF12CXEL0XYxplGRRC1HZQGzrl+6ANr+HXiPbg7NnUZ0I
	 GQ4zV8l6BueYw==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x2SM4-00000006z1P-40Db;
	Fri, 04 Sep 2026 13:45:12 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] serial: fix ioctl hangup race
Date: Fri,  4 Sep 2026 13:44:48 +0200
Message-ID: <20260904114448.1664502-1-johan@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tty ioctls can race with hangup and end up calling into a tty
driver for a device that is already gone or powered down.

Add the missing checks to make sure the port has not been hung up before
accessing the hardware to avoid issues like kernel panic due to
unclocked accesses.

Note that TIOCGSERIAL, TIOCGICOUNT do not access hardware and are
therefore not affected by the race.

Fixes: 04f378b198da ("tty: BKL pushdown")
Cc: stable@vger.kernel.org	# 2.6.26
Signed-off-by: Johan Hovold <johan@kernel.org>
---

I botched the scoped_guard() conversion as Sashiko pointed out so here's
a v2.

Johan


Changes in v2
 - include TIOCMIWAIT which also access hardware
 - replace broken scoped_guard() construct in wait loop


 drivers/tty/serial/serial_core.c | 36 +++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 95774b0f1484..b0d3902fe4fc 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -896,7 +896,7 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 	upf_t old_flags, new_flags;
 	int retval;
 
-	if (!uport)
+	if (!uport || tty_io_error(tty))
 		return -EIO;
 
 	new_port = new_info->port;
@@ -1119,7 +1119,7 @@ static int uart_break_ctl(struct tty_struct *tty, int break_state)
 	guard(mutex)(&port->mutex);
 
 	uport = uart_port_check(state);
-	if (!uport)
+	if (!uport || tty_io_error(tty))
 		return -EIO;
 
 	if (uport->type != PORT_UNKNOWN && uport->ops->break_ctl)
@@ -1144,7 +1144,7 @@ static int uart_do_autoconfig(struct tty_struct *tty, struct uart_state *state)
 	 */
 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &port->mutex) {
 		uport = uart_port_check(state);
-		if (!uport)
+		if (!uport || tty_io_error(tty))
 			return -EIO;
 
 		if (tty_port_users(port) != 1)
@@ -1199,7 +1199,7 @@ static void uart_enable_ms(struct uart_port *uport)
  * FIXME: This wants extracting into a common all driver implementation
  * of TIOCMWAIT using tty_port.
  */
-static int uart_wait_modem_status(struct uart_state *state, unsigned long arg)
+static int uart_wait_modem_status(struct tty_struct *tty, struct uart_state *state, unsigned long arg)
 {
 	struct uart_port *uport;
 	struct tty_port *port = &state->port;
@@ -1213,9 +1213,17 @@ static int uart_wait_modem_status(struct uart_state *state, unsigned long arg)
 	uport = uart_port_ref(state);
 	if (!uport)
 		return -EIO;
-	scoped_guard(uart_port_lock_irq, uport) {
-		memcpy(&cprev, &uport->icount, sizeof(struct uart_icount));
-		uart_enable_ms(uport);
+
+	scoped_guard(mutex, &port->mutex) {
+		if (tty_io_error(tty)) {
+			ret = -EIO;
+			goto out_deref;
+		}
+
+		scoped_guard(uart_port_lock_irq, uport) {
+			memcpy(&cprev, &uport->icount, sizeof(struct uart_icount));
+			uart_enable_ms(uport);
+		}
 	}
 
 	add_wait_queue(&port->delta_msr_wait, &wait);
@@ -1245,6 +1253,7 @@ static int uart_wait_modem_status(struct uart_state *state, unsigned long arg)
 	}
 	__set_current_state(TASK_RUNNING);
 	remove_wait_queue(&port->delta_msr_wait, &wait);
+out_deref:
 	uart_port_deref(uport);
 
 	return ret;
@@ -1567,7 +1576,7 @@ uart_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 
 	/* This should only be used when the hardware is present. */
 	if (cmd == TIOCMIWAIT)
-		return uart_wait_modem_status(state, arg);
+		return uart_wait_modem_status(tty, state, arg);
 
 	/* rs485_config requires more locking than others */
 	if (cmd == TIOCSRS485)
@@ -1646,7 +1655,7 @@ static void uart_set_termios(struct tty_struct *tty,
 	guard(mutex)(&state->port.mutex);
 
 	uport = uart_port_check(state);
-	if (!uport)
+	if (!uport || tty_io_error(tty))
 		return;
 
 	/*
@@ -1798,7 +1807,14 @@ static void uart_wait_until_sent(struct tty_struct *tty, int timeout)
 	 * 'timeout' / 'expire' give us the maximum amount of time
 	 * we wait.
 	 */
-	while (!port->ops->tx_empty(port)) {
+	for (;;) {
+		mutex_lock(&state->port.mutex);
+		if (tty_io_error(tty) || port->ops->tx_empty(port)) {
+			mutex_unlock(&state->port.mutex);
+			break;
+		}
+		mutex_unlock(&state->port.mutex);
+
 		msleep_interruptible(jiffies_to_msecs(char_time));
 		if (signal_pending(current))
 			break;
-- 
2.55.0

