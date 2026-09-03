Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5325146AF2D;
	Thu,  3 Sep 2026 16:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788453131; cv=none; b=sO4VH70HImFWJ9lT19fE3cxbdolsENdUn99Pa+i/9b2hkdoh7PpvQ9vqqt3pUw04P5lQ84St6mfT9CC2D+Gh4uYDAUjTqSxLUmrQjoUFrP8kR7PrK9K/hHA7No0dM1KoJAeapiZnIjDLhhfXkRhfotIA/9nbGNP0s1yq109KQQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788453131; c=relaxed/simple;
	bh=WUZokowoDkDS2Yc9+UMoiB2ZIr5Goq5O5KsmBl4Zvpw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PPa236YGtO3EU5/jfRMs6JXjTH80txsxSCZ4wWAe6LQyuUiRTsIG4pOmfx+0nobo06ASFYvyaD4nOnNlbVEDcIZSF2zW1fhMsh+8fDGS25MalHRebfHF1lmDBiivJx4+oy/i0kM5vcAck7+qpiH/nTU3udAXNYa2ty8B9H92IJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkIaq77Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkIaq77Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15E81F000E9;
	Thu,  3 Sep 2026 16:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788453129;
	bh=4DCsX+XCpCFPdqcsEllnbWXW7cI8TsWxWBiP3bjx1x0=;
	h=From:To:Cc:Subject:Date;
	b=kkIaq77QuIJsumSR9O0s/7aZvDNXWayhe8/MONY79XNcjHpXez4a/BnVb8a8Os8Nn
	 AfVnju2fI3WOqDAh+OgfQ4TbB/ld8OiTvzoWCAPSbyyUvwMjiyTZE0Fx5p5z059ciu
	 sXIuRpOJQS6L2sRBglXE2b7HD6itGal/EQzHT7RzwepMdBaxZOyWLvOnJXVNuwSU2c
	 wRgkOWIli9jYl43Y977gUE5+G2B8Brp0iZpIPydqrJExCazkvwShfrYQfG5KM/wFpV
	 S1oH7htRi/E8kBZoymNeOqTyd7Gjp0CR+XtyoKZAjpRAnn4uhR0fR2kO1Pmy9dkt+D
	 XA/LbUevwUsvA==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x2AMB-00000006Hpk-1vjj;
	Thu, 03 Sep 2026 18:32:07 +0200
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nick Bowler <nbowler@draconx.ca>,
	syzbot+473d7477c523b41d4046@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] USB: serial: fix ioctl hangup race
Date: Thu,  3 Sep 2026 18:31:46 +0200
Message-ID: <20260903163146.1498497-1-johan@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tty ioctls can race with hangup and end up calling into a tty driver
for a device that is already gone or powered down.

Serialise the callbacks using the tty port mutex and add the missing
checks to make sure the port has not been hung up before accessing port
driver data or hardware.

This specifically avoids dereferencing a NULL-pointer if a device is
disconnected during lengthy break signalling.

Note that TIOCGICOUNT and TIOCMIWAIT do not access port driver data or
hardware and are therefore not affected by the race.

Fixes: f34d7a5b7010 ("tty: The big operations rework")
Reported-by: Nick Bowler <nbowler@draconx.ca>
Link: https://lore.kernel.org/all/CADyTPExB2kYOOwkO0JqGhKaYVDqO9uS9WCw0J=MCTdVhcGOogA@mail.gmail.com/
Reported-by: syzbot+473d7477c523b41d4046@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/6a9087a4.4d659fcc.734b4.0013.GAE@google.com
Cc: stable@vger.kernel.org	# 2.6.26
Signed-off-by: Johan Hovold <johan@kernel.org>
---

Note that the port driver data NULL-deref is unique for USB serial and
does specifically not affect cdc-acm.

I'm posting fixes for serial core and USB serial today will take a
closer look at the other TTY drivers tomorrow.

Johan


 drivers/usb/serial/generic.c    | 10 +++-
 drivers/usb/serial/usb-serial.c | 94 ++++++++++++++++++++++++++-------
 drivers/usb/serial/xr_serial.c  | 10 ++--
 3 files changed, 86 insertions(+), 28 deletions(-)

diff --git a/drivers/usb/serial/generic.c b/drivers/usb/serial/generic.c
index 6eaf74930aa3..17272701fab0 100644
--- a/drivers/usb/serial/generic.c
+++ b/drivers/usb/serial/generic.c
@@ -266,6 +266,7 @@ EXPORT_SYMBOL_GPL(usb_serial_generic_chars_in_buffer);
 void usb_serial_generic_wait_until_sent(struct tty_struct *tty, long timeout)
 {
 	struct usb_serial_port *port = tty->driver_data;
+	struct tty_port *tport = &port->port;
 	unsigned int bps;
 	unsigned long period;
 	unsigned long expire;
@@ -285,7 +286,14 @@ void usb_serial_generic_wait_until_sent(struct tty_struct *tty, long timeout)
 					__func__, jiffies_to_msecs(timeout),
 					jiffies_to_msecs(period));
 	expire = jiffies + timeout;
-	while (!port->serial->type->tx_empty(port)) {
+	for (;;) {
+		mutex_lock(&tport->mutex);
+		if (tty_io_error(tty) || port->serial->type->tx_empty(port)) {
+			mutex_unlock(&tport->mutex);
+			break;
+		}
+		mutex_unlock(&tport->mutex);
+
 		schedule_timeout_interruptible(period);
 		if (signal_pending(current))
 			break;
diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index 9c51b44e2284..f3c594f1a806 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -400,17 +400,13 @@ static unsigned int serial_chars_in_buffer(struct tty_struct *tty)
 static void serial_wait_until_sent(struct tty_struct *tty, int timeout)
 {
 	struct usb_serial_port *port = tty->driver_data;
-	struct usb_serial *serial = port->serial;
 
 	dev_dbg(&port->dev, "%s\n", __func__);
 
 	if (!port->serial->type->wait_until_sent)
 		return;
 
-	mutex_lock(&serial->disc_mutex);
-	if (!serial->disconnected)
-		port->serial->type->wait_until_sent(tty, timeout);
-	mutex_unlock(&serial->disc_mutex);
+	port->serial->type->wait_until_sent(tty, timeout);
 }
 
 static void serial_throttle(struct tty_struct *tty)
@@ -438,8 +434,13 @@ static int serial_get_serial(struct tty_struct *tty, struct serial_struct *ss)
 	struct usb_serial_port *port = tty->driver_data;
 	struct tty_port *tport = &port->port;
 	unsigned int close_delay, closing_wait;
+	int ret = 0;
 
 	mutex_lock(&tport->mutex);
+	if (tty_io_error(tty)) {
+		ret = -EIO;
+		goto out_unlock;
+	}
 
 	close_delay = jiffies_to_msecs(tport->close_delay) / 10;
 	closing_wait = tport->closing_wait;
@@ -452,10 +453,10 @@ static int serial_get_serial(struct tty_struct *tty, struct serial_struct *ss)
 
 	if (port->serial->type->get_serial)
 		port->serial->type->get_serial(tty, ss);
-
+out_unlock:
 	mutex_unlock(&tport->mutex);
 
-	return 0;
+	return ret;
 }
 
 static int serial_set_serial(struct tty_struct *tty, struct serial_struct *ss)
@@ -471,6 +472,10 @@ static int serial_set_serial(struct tty_struct *tty, struct serial_struct *ss)
 		closing_wait = msecs_to_jiffies(closing_wait * 10);
 
 	mutex_lock(&tport->mutex);
+	if (tty_io_error(tty)) {
+		ret = -EIO;
+		goto out_unlock;
+	}
 
 	if (!capable(CAP_SYS_ADMIN)) {
 		if (close_delay != tport->close_delay ||
@@ -498,6 +503,7 @@ static int serial_ioctl(struct tty_struct *tty,
 					unsigned int cmd, unsigned long arg)
 {
 	struct usb_serial_port *port = tty->driver_data;
+	struct tty_port *tport = &port->port;
 	int retval = -ENOIOCTLCMD;
 
 	dev_dbg(&port->dev, "%s - cmd 0x%04x\n", __func__, cmd);
@@ -508,8 +514,21 @@ static int serial_ioctl(struct tty_struct *tty,
 			retval = port->serial->type->tiocmiwait(tty, arg);
 		break;
 	default:
-		if (port->serial->type->ioctl)
+		if (!port->serial->type->ioctl)
+			break;
+
+		if (cmd == TIOCSRS485)
+			down_write(&tty->termios_rwsem);
+
+		mutex_lock(&tport->mutex);
+		if (tty_io_error(tty))
+			retval = -EIO;
+		else
 			retval = port->serial->type->ioctl(tty, cmd, arg);
+		mutex_unlock(&tport->mutex);
+
+		if (cmd == TIOCSRS485)
+			up_write(&tty->termios_rwsem);
 	}
 
 	return retval;
@@ -519,25 +538,40 @@ static void serial_set_termios(struct tty_struct *tty,
 		               const struct ktermios *old)
 {
 	struct usb_serial_port *port = tty->driver_data;
+	struct tty_port *tport = &port->port;
 
 	dev_dbg(&port->dev, "%s\n", __func__);
 
-	if (port->serial->type->set_termios)
-		port->serial->type->set_termios(tty, port, old);
-	else
+	if (!port->serial->type->set_termios) {
 		tty_termios_copy_hw(&tty->termios, old);
+		return;
+	}
+
+	mutex_lock(&tport->mutex);
+	if (!tty_io_error(tty))
+		port->serial->type->set_termios(tty, port, old);
+	mutex_unlock(&tport->mutex);
 }
 
 static int serial_break(struct tty_struct *tty, int break_state)
 {
 	struct usb_serial_port *port = tty->driver_data;
+	struct tty_port *tport = &port->port;
+	int ret;
 
 	dev_dbg(&port->dev, "%s\n", __func__);
 
-	if (port->serial->type->break_ctl)
-		return port->serial->type->break_ctl(tty, break_state);
+	if (!port->serial->type->break_ctl)
+		return -ENOTTY;
 
-	return -ENOTTY;
+	mutex_lock(&tport->mutex);
+	if (tty_io_error(tty))
+		ret = -EIO;
+	else
+		ret = port->serial->type->break_ctl(tty, break_state);
+	mutex_unlock(&tport->mutex);
+
+	return ret;
 }
 
 static int serial_proc_show(struct seq_file *m, void *v)
@@ -578,24 +612,44 @@ static int serial_proc_show(struct seq_file *m, void *v)
 static int serial_tiocmget(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
+	struct tty_port *tport = &port->port;
+	int ret;
 
 	dev_dbg(&port->dev, "%s\n", __func__);
 
-	if (port->serial->type->tiocmget)
-		return port->serial->type->tiocmget(tty);
-	return -ENOTTY;
+	if (!port->serial->type->tiocmget)
+		return -ENOTTY;
+
+	mutex_lock(&tport->mutex);
+	if (tty_io_error(tty))
+		ret = -EIO;
+	else
+		ret = port->serial->type->tiocmget(tty);
+	mutex_unlock(&tport->mutex);
+
+	return ret;
 }
 
 static int serial_tiocmset(struct tty_struct *tty,
 			    unsigned int set, unsigned int clear)
 {
 	struct usb_serial_port *port = tty->driver_data;
+	struct tty_port *tport = &port->port;
+	int ret;
 
 	dev_dbg(&port->dev, "%s\n", __func__);
 
-	if (port->serial->type->tiocmset)
-		return port->serial->type->tiocmset(tty, set, clear);
-	return -ENOTTY;
+	if (!port->serial->type->tiocmset)
+		return -ENOTTY;
+
+	mutex_lock(&tport->mutex);
+	if (tty_io_error(tty))
+		ret = -EIO;
+	else
+		ret = port->serial->type->tiocmset(tty, set, clear);
+	mutex_unlock(&tport->mutex);
+
+	return ret;
 }
 
 static int serial_get_icount(struct tty_struct *tty,
diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
index 352c765d8803..c08f4aa14a3d 100644
--- a/drivers/usb/serial/xr_serial.c
+++ b/drivers/usb/serial/xr_serial.c
@@ -850,12 +850,9 @@ static int xr_get_rs485_config(struct tty_struct *tty,
 	struct usb_serial_port *port = tty->driver_data;
 	struct xr_data *data = usb_get_serial_port_data(port);
 
-	down_read(&tty->termios_rwsem);
-	if (copy_to_user(argp, &data->rs485, sizeof(data->rs485))) {
-		up_read(&tty->termios_rwsem);
+	/* core holds port mutex */
+	if (copy_to_user(argp, &data->rs485, sizeof(data->rs485)))
 		return -EFAULT;
-	}
-	up_read(&tty->termios_rwsem);
 
 	return 0;
 }
@@ -871,10 +868,9 @@ static int xr_set_rs485_config(struct tty_struct *tty,
 		return -EFAULT;
 	xr_sanitize_serial_rs485(&rs485);
 
-	down_write(&tty->termios_rwsem);
+	/* core holds termios rwsem and port mutex */
 	data->rs485 = rs485;
 	xr_set_flow_mode(tty, port, NULL);
-	up_write(&tty->termios_rwsem);
 
 	if (copy_to_user(argp, &rs485, sizeof(rs485)))
 		return -EFAULT;
-- 
2.55.0

