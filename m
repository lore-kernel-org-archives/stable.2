Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BF047D937;
	Thu, 10 Sep 2026 13:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789045710; cv=none; b=UNikXQyjQqOd+N4823xqrEQNeH5s5xO2IcZwLodRkCA6N1JAHtTTSnEJRQKx+bgx+F6c3m509cTgsLvjPBa4zyXqwjgA0qnX3V3dBR/5G/g9QPV2Z4eUaxqIsj36xKyQifr9vNxVQLT0NPLkVW5a9vbgAKb3XxD2KWJS+7xP4zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789045710; c=relaxed/simple;
	bh=7Sf219SBMBIoNX+uta/5SIML5xwHKgiCYaKlSbo7OsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=no0bN9ijkynU57kde6eLGAzUdJFco7ioeMeCEJSRWqS4ssNAmA8mQnIl0D/EOPNH6xb12dxuXWlsPD2Gwj4dxT40ZNlLrw+3Rx3m8l4gQOrlSClodq7MBtZ7Js2z9ykA26z8tP6L1lYEuxAapsqH9pdTwGIfM3+edLpPFsZ4Olk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7HNQtwe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7HNQtwe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50DE11F000FF;
	Thu, 10 Sep 2026 13:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789045708;
	bh=Ui4F1VkpBaEZyC0gBYNTL3IsB7lD8TzpkDFInVEz5/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c7HNQtweifsoMKhqIgbdVmvDkfKj/DOaeR+/hCau0+O4c/5cglrog4QK8MU4knnLM
	 P+1dQYdzmqP6AtKrtt1ywaK0u/JrtFz51a54umvT04PxdE81NnSxVCuGz0P32LkJoK
	 EKWppD5TjpV6Gajlt0jtsJc65toEsB5IOWdX+/ZOVYB29mptP9V2W2mvzhjhYvo0XK
	 Lhpa+ZiVWHx/6lYXK8uUGWIU0eKaE7Mpf7oO5QFPzRucXkkBhVbVaqxsxjb3RcI+Bf
	 ys2m2a98S2n7HPJjW40IzvyNhzBsVxw1NK9qMBm21Jane35+1ux+WVmhZ3UKMl5Djm
	 R0h5henAcAyiA==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x4eVu-00000002hCf-008J;
	Thu, 10 Sep 2026 15:08:26 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v4 2/4] serial: fix ioctl hangup race
Date: Thu, 10 Sep 2026 15:08:14 +0200
Message-ID: <20260910130816.642699-3-johan@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910130816.642699-1-johan@kernel.org>
References: <20260910130816.642699-1-johan@kernel.org>
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

Also note that the initialised check in uart_set_ldisc() added by commit
2f70e49ed860 ("serial_core: Check for port state when tty is in error
state") should have been done under the port lock to avoid racing with
uart_do_autoconfig().

Fixes: 04f378b198da ("tty: BKL pushdown")
Cc: stable@vger.kernel.org	# 2.6.26
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/serial_core.c | 41 ++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 1553bc6cbe7b..139b93876229 100644
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
@@ -1213,11 +1213,21 @@ static int uart_wait_modem_status(struct uart_state *state, unsigned long arg)
 	uport = uart_port_ref(state);
 	if (!uport)
 		return -EIO;
+
+	mutex_lock(&port->mutex);
+	if (tty_io_error(tty)) {
+		mutex_unlock(&port->mutex);
+		ret = -EIO;
+		goto out_deref;
+	}
+
 	uart_port_lock_irq(uport);
 	memcpy(&cprev, &uport->icount, sizeof(struct uart_icount));
 	uart_enable_ms(uport);
 	uart_port_unlock_irq(uport);
 
+	mutex_unlock(&port->mutex);
+
 	add_wait_queue(&port->delta_msr_wait, &wait);
 	for (;;) {
 		uart_port_lock_irq(uport);
@@ -1246,6 +1256,7 @@ static int uart_wait_modem_status(struct uart_state *state, unsigned long arg)
 	}
 	__set_current_state(TASK_RUNNING);
 	remove_wait_queue(&port->delta_msr_wait, &wait);
+out_deref:
 	uart_port_deref(uport);
 
 	return ret;
@@ -1568,7 +1579,7 @@ uart_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 
 	/* This should only be used when the hardware is present. */
 	if (cmd == TIOCMIWAIT)
-		return uart_wait_modem_status(state, arg);
+		return uart_wait_modem_status(tty, state, arg);
 
 	/* rs485_config requires more locking than others */
 	if (cmd == TIOCSRS485)
@@ -1624,14 +1635,13 @@ static void uart_set_ldisc(struct tty_struct *tty)
 {
 	struct uart_state *state = tty->driver_data;
 	struct uart_port *uport;
-	struct tty_port *port = &state->port;
-
-	if (!tty_port_initialized(port))
-		return;
 
 	guard(mutex)(&state->port.mutex);
 	uport = uart_port_check(state);
-	if (uport && uport->ops->set_ldisc)
+	if (!uport || tty_io_error(tty))
+		return;
+
+	if (uport->ops->set_ldisc)
 		uport->ops->set_ldisc(uport, &tty->termios);
 }
 
@@ -1647,7 +1657,7 @@ static void uart_set_termios(struct tty_struct *tty,
 	guard(mutex)(&state->port.mutex);
 
 	uport = uart_port_check(state);
-	if (!uport)
+	if (!uport || tty_io_error(tty))
 		return;
 
 	/*
@@ -1799,7 +1809,14 @@ static void uart_wait_until_sent(struct tty_struct *tty, int timeout)
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

