Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6573D31197C;
	Thu,  3 Sep 2026 16:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788453295; cv=none; b=jRn43mvLwtOUTPtuz8NWCe85//dsI36m+qQj8mOPibgNf3lUwoUGAYoKOTPQkRY16z2WeHg/PTEkLVBCaYAyAwJcxjYD8EtdYJP2GanU4B/8WfNoWOauUqbSaYCekXhg22QXDdE47+fBVVVGTOxgrcsLY0we/g33mSCZK5C3jkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788453295; c=relaxed/simple;
	bh=9tRGciWWFbnSnrrF3OKias/50sPvR/jiJhm8Ny0+9fU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C73huMgxqGurjzPa5Cm3iaWIeTNftgGS6Kp2PQP+xUFl/MlgJeO1AuFecSap88TUZvVFq6bVAwbLF3Gn0eBbgUHb2uVSe1WSAGs8M68f6o7vbBl+Ueg7VJl3m24kWfN024EGDzthdMLbEVc6ydO038tFGUVyFhCV8iw4V4Onjwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X82RyIC4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X82RyIC4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120841F000E9;
	Thu,  3 Sep 2026 16:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788453294;
	bh=sPpd4BiOXdHYd+zYzn/cAKnpUzJQKqamADjGx4FRbbg=;
	h=From:To:Cc:Subject:Date;
	b=X82RyIC4lRPgB68QH9TN5luNM3hQer7JDQ9pv8s2F/T1B9UNcc6lJv8ZrGK2dpJ+R
	 qLdUspXMlBvpD7vwky5WTyhTEaTE80Mj/mbacCRgK479OEztJPoBR7gW6Oi+iowa+R
	 +0k9d2NMhzbvuUK2NUnkzaFtSoHTEWfO3DDRnRMM7CpJyXoT//lewSpcSFw+MMyeCt
	 IMsSefabYVodb71U290jeXIC/fPqoHL7hAm9u/k5r9H/FQ6yfS1OOnKiC9iryU5Urn
	 UefwbigKR7mIKWaypOsNKJfyYotyGaKpCHnSmg++1U5Uw3yE8zBpnPtoBKA1RW17O2
	 fk70xU7XuBcsw==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x2AOp-00000006Hyn-3s1J;
	Thu, 03 Sep 2026 18:34:51 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] serial: fix ioctl hangup race
Date: Thu,  3 Sep 2026 18:34:39 +0200
Message-ID: <20260903163439.1499055-1-johan@kernel.org>
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

Note that TIOCGSERIAL, TIOCGICOUNT and TIOCMIWAIT do not access hardware
and are therefore not affected by the race.

Fixes: 04f378b198da ("tty: BKL pushdown")
Cc: stable@vger.kernel.org	# 2.6.26
Signed-off-by: Johan Hovold <johan@kernel.org>
---

I've just sent a fix for USB serial here:

	https://lore.kernel.org/r/20260903163146.1498497-1-johan@kernel.org

and will take closer look at the other TTY drivers tomorrow.

Johan


 drivers/tty/serial/serial_core.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 95774b0f1484..aac12be4ceac 100644
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
@@ -1646,7 +1646,7 @@ static void uart_set_termios(struct tty_struct *tty,
 	guard(mutex)(&state->port.mutex);
 
 	uport = uart_port_check(state);
-	if (!uport)
+	if (!uport || tty_io_error(tty))
 		return;
 
 	/*
@@ -1798,7 +1798,11 @@ static void uart_wait_until_sent(struct tty_struct *tty, int timeout)
 	 * 'timeout' / 'expire' give us the maximum amount of time
 	 * we wait.
 	 */
-	while (!port->ops->tx_empty(port)) {
+	for (;;) {
+		scoped_guard(mutex, &state->port.mutex) {
+			if (tty_io_error(tty) || port->ops->tx_empty(port))
+				break;
+		}
 		msleep_interruptible(jiffies_to_msecs(char_time));
 		if (signal_pending(current))
 			break;
-- 
2.55.0

