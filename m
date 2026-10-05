Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D992B41F378
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 22:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791239104; cv=none; b=e7cdnOtnAc9nQA3J6XSVfhUiU6TOcS65UvuHIaaJHGak6YW6ZlMbdq7iJhX4deJ+Qu0X2c5lOQopu0/FrYn5NMQ2ZNopvWr9uW1VP7pZMXD3fDzkrhdsgmBwCIEuYLGTUrSOilJUZLwEfY0FZST2wGZVEzrqs710sbytioWwPbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791239104; c=relaxed/simple;
	bh=wKwCJIeaKuGVxro5GHU3XMuwOSmGAg77f6uoE9tRg5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=opM4TpDBwvFdSWwpp3U+j5Z6QuWV8bG6oIaJfE/kqd7P3QBCf3Z6+xs/9eMq12ybFjIVBCEXIuBmB4QQWZ8U7PnWBmuToCpqSipY3tDO8UYWJEfOOU4lwi2kS82+EM5w1ljHsucTeUE/nzVijr3vGBP/3L9YuCTCrNDzpGR+vag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YydqjZZQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YydqjZZQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504E41F000FF;
	Mon,  5 Oct 2026 22:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791239102;
	bh=IiAS/4u+nCPjI7XI1JC/k3bRwVvQknqbK1TbLyuZ/dU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YydqjZZQrbTHgbJ1NeH63W6Jitsj0wX14wz+n3yb+H6yny13Aaof/Ljwze2qdYTiP
	 ckI3Ct2di6rK7Ye9jpCf08pCD9hzTtAggtrbrLl3zDNFEVqn2dfd1KAYVOb5M/Q5bA
	 iobd5yDO+cbRe1IBA417uRdakZCJTbcB9Npou6k78uKb90K+etRylP7rMrhY4cLc1Y
	 +eA+0ssCnk/YS+nAMlNFPWSnt//j+ljlt227IGtMNK2aqAiSho33wuTF/BPmmD4fmG
	 +z855oFmvEYN6QCxqPhNj1LFnyRovuFXMbJDVZHOqW95yT1RIdI72l4ca8cn+LH0fQ
	 FTHnIoMqvwZhg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	stable@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] serial: fix ioctl hangup race
Date: Mon,  5 Oct 2026 18:24:55 -0400
Message-ID: <20261005222419.3425745-3-sashal@kernel.org>
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

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 8ca59f7baee7c72cf7729950b4ab2e7f910c9549 ]

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
Cc: stable@kernel.org	# 2.6.26
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260910130816.642699-3-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/serial_core.c | 41 ++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 381758f640824..68e13c1ba498d 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -844,7 +844,7 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 	upf_t old_flags, new_flags;
 	int retval = 0;
 
-	if (!uport)
+	if (!uport || tty_io_error(tty))
 		return -EIO;
 
 	new_port = new_info->port;
@@ -1138,7 +1138,7 @@ static int uart_break_ctl(struct tty_struct *tty, int break_state)
 	guard(mutex)(&port->mutex);
 
 	uport = uart_port_check(state);
-	if (!uport)
+	if (!uport || tty_io_error(tty))
 		return -EIO;
 
 	if (uport->type != PORT_UNKNOWN && uport->ops->break_ctl)
@@ -1163,7 +1163,7 @@ static int uart_do_autoconfig(struct tty_struct *tty, struct uart_state *state)
 	 */
 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &port->mutex) {
 		uport = uart_port_check(state);
-		if (!uport)
+		if (!uport || tty_io_error(tty))
 			return -EIO;
 
 		if (tty_port_users(port) != 1)
@@ -1218,7 +1218,7 @@ static void uart_enable_ms(struct uart_port *uport)
  * FIXME: This wants extracting into a common all driver implementation
  * of TIOCMWAIT using tty_port.
  */
-static int uart_wait_modem_status(struct uart_state *state, unsigned long arg)
+static int uart_wait_modem_status(struct tty_struct *tty, struct uart_state *state, unsigned long arg)
 {
 	struct uart_port *uport;
 	struct tty_port *port = &state->port;
@@ -1232,11 +1232,21 @@ static int uart_wait_modem_status(struct uart_state *state, unsigned long arg)
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
 		set_current_state(TASK_INTERRUPTIBLE);
@@ -1265,6 +1275,7 @@ static int uart_wait_modem_status(struct uart_state *state, unsigned long arg)
 	}
 	__set_current_state(TASK_RUNNING);
 	remove_wait_queue(&port->delta_msr_wait, &wait);
+out_deref:
 	uart_port_deref(uport);
 
 	return ret;
@@ -1590,7 +1601,7 @@ uart_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 
 	/* This should only be used when the hardware is present. */
 	if (cmd == TIOCMIWAIT)
-		return uart_wait_modem_status(state, arg);
+		return uart_wait_modem_status(tty, state, arg);
 
 	/* rs485_config requires more locking than others */
 	if (cmd == TIOCSRS485)
@@ -1646,14 +1657,13 @@ static void uart_set_ldisc(struct tty_struct *tty)
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
 
@@ -1669,7 +1679,7 @@ static void uart_set_termios(struct tty_struct *tty,
 	guard(mutex)(&state->port.mutex);
 
 	uport = uart_port_check(state);
-	if (!uport)
+	if (!uport || tty_io_error(tty))
 		return;
 
 	/*
@@ -1822,7 +1832,14 @@ static void uart_wait_until_sent(struct tty_struct *tty, int timeout)
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
2.53.0

