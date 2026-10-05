Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AA8400DFC
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 10:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791195378; cv=none; b=a2+ay3YTXDIfpLy0e/1a/ph47f9WEYh5Ao/Ty87BW76EYYMSLH1dq+y05E5F4Syn8KIvv+QHAg5HEfMEZPkIollINi23ZdWTkw399UMmHUxjkxuFiOyo56ZG9xKtvp5CLcc3QGgzy6jR5nI7s7Aw3juwjmoMGMhfAVXJioZAu0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791195378; c=relaxed/simple;
	bh=nR3QTs4JJKRovKpw3argNjf/cKYcJpIAThOCpSh4n1c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bCpLP9GCXEoUX/aE7kFxvtgsCDJa/GGf+x96nsFdLPR3MDcZnQ2OGgq5ZpqA+ttxRCdHtGX1k3Ek5loyWvMruAa9AJExa6vam6AJRGnKFYgc5wx52ga+U8+fRn+zeTYvZc3rNfGwu3OiZNraNNuWqCJXau6FWQGnvZmb9PNd8Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lPRdzVua; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lPRdzVua"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D31761F000FF;
	Mon,  5 Oct 2026 10:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791195376;
	bh=kjE8rAGPaxckAj+OjuYBiImtE2QtABl1Bi2XwsBU5fc=;
	h=Subject:To:Cc:From:Date;
	b=lPRdzVua3eHKHPtKypedyuqUbMvKks4XP8Sa1E4IzVRCE+WZfigDSgCCg4nJVKWbD
	 B+MEVD6f1p+dArczcJnaDufa68LxnYKxoxDLc5fkr2+LdcZAqNNFVnzdYznWNDQrWs
	 E5YGs9vdVleMSKriRhqhTpwMNdDak3DzYyQzgryI=
Subject: FAILED: patch "[PATCH] serial: fix ioctl hangup race" failed to apply to 5.10-stable tree
To: johan@kernel.org,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 12:16:01 +0200
Message-ID: <2026100501-washer-faceless-b279@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 8ca59f7baee7c72cf7729950b4ab2e7f910c9549
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100501-washer-faceless-b279@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8ca59f7baee7c72cf7729950b4ab2e7f910c9549 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Thu, 10 Sep 2026 15:08:14 +0200
Subject: [PATCH] serial: fix ioctl hangup race

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

