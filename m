Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA10B40682A;
	Mon,  7 Sep 2026 06:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763502; cv=none; b=D6ImQ4Lxp8wh7UEIJKsxvV0xW/ClfNg8370aD5iF+dqTc3Q0L+aobJYppnPCzQFWPj1U7ElcrzYjaF0RKE8mK6C649q47bVnShm4r2GMOhTkS35bkyCP7XPEzeEw/x9oREXjy/6yilRSzEAOgIo0JdsgVAduFoOqF40CESsmlkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763502; c=relaxed/simple;
	bh=auKLqhMwg3dsI5arYX0V0bGcmqAU8FBqmqwUCuVOO58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XuH7Z/80+R+yifNPYQ3PEGcYRxAmblsvCTFmIXc15HzPyUSpI4UReDGCDU2G+ppuEenr/FhRIPPtyjEeZHFW1SJW8C+H53ACHQa8s4p1aeyUraGC26M48DY3W1sXL1zLCEHO4eE4aB/yJmJ4FsaqIy2oQTwYL9EkUiotIlaW6XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THLXCQUd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THLXCQUd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F921F00A3F;
	Mon,  7 Sep 2026 06:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788763500;
	bh=5ciWv+qybpfCuW2uA3wmFySIxPMaj+n/n0VME7/q3TE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=THLXCQUds5p9tyRs1jwotE2H1MR3KO7qpL2cQQUO4LAxbIMAggiOlsgChOJoTurjU
	 bKTlfJ/NTzcopQTixOKX+FyZrASh5mr8DNaWvmZh3mtr7AjoqwwO7EQJgEMwW3svpm
	 3h2TZEMi6Ew8E+pDpwWehyUflPWE2bwoluvWF8uUx4la5c4PZ0ZcGLWc6ppx4HA144
	 3Zwxd5fFbq5YSGvjrme3DrxraZD0EOeBB42Xp9NPObcnhtzPtFh3BXUV0VU++fqqoM
	 SKylec4q0UEzbXMTPNUsurO4A6gDxqJZjC8czjO9AZ428NUeJUkJ4um6farRxixt7x
	 s769XqNv62S3Q==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x3T69-00000000OC6-3kke;
	Mon, 07 Sep 2026 08:44:57 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/4] serial: fix ioctl hangup race
Date: Mon,  7 Sep 2026 08:44:16 +0200
Message-ID: <20260907064418.92953-3-johan@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907064418.92953-1-johan@kernel.org>
References: <20260907064418.92953-1-johan@kernel.org>
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
 drivers/tty/serial/serial_core.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 1553bc6cbe7b..4213fa3dc988 100644
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
@@ -1647,7 +1658,7 @@ static void uart_set_termios(struct tty_struct *tty,
 	guard(mutex)(&state->port.mutex);
 
 	uport = uart_port_check(state);
-	if (!uport)
+	if (!uport || tty_io_error(tty))
 		return;
 
 	/*
@@ -1799,7 +1810,14 @@ static void uart_wait_until_sent(struct tty_struct *tty, int timeout)
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

