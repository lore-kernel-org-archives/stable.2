Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD1A492E5A
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211291; cv=none; b=quCbC/0EEZEWzQRZ3ZkMIH1QwTFKrYfRZJBHyU+OZ37Wv0Su5s66llm64rnBb+l3aCmU7OuDQy4rytPydJO8fuj+uUothSF34vcf2/GawhBiRfFmii+FvCkLtOPLYGxjkbZyXiJH8l1pURD0iR35WcqMOqMrb1mbCe8yYEi2HNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211291; c=relaxed/simple;
	bh=371V+wQ5pgPn4hiJ+VEsTHEa9eBZAQnBU36GS3rdRZo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eRI98E+xLr/zoJwMM+UnaY/3WFpXRSe+M+cUlCPlzdAGgCxLMg7akUA9P1+7WA3XjVZk9WFsihODD1/wwhdYqG9DgpmP+0kNZMWq8FKgYuFe4yA0Io+2EXZwoinRa/v0qVistBya3WKOd2JuOoeRx0ylLBixnbRX3Inwvoue+II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VjVeRx1/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VjVeRx1/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1E91F00893;
	Mon,  5 Oct 2026 14:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791211281;
	bh=QehrnE8cMHVLw7n1eTKg8TrfhKuuOrRMjXPNEGH49jI=;
	h=Subject:To:Cc:From:Date;
	b=VjVeRx1/eJfh86MgKL4pLxb+JTCffxF1lw+sfTWa6suGjLvmcGGMoXBUNpV4Qt/6i
	 Rp/fe4veM4bIESedTFZ75bjN2lMXFdJMXQxQUOc62z1vW5qVj9YJzPMh8vi33E2cN9
	 hRBq4dxroEQWsKdfaqBz2Gi6eWH+0FfyeO69Fh1A=
Subject: FAILED: patch "[PATCH] USB: serial: fix ioctl hangup race" failed to apply to 5.15-stable tree
To: johan@kernel.org,nbowler@draconx.ca
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 16:41:08 +0200
Message-ID: <2026100508-sacrifice-antarctic-98c5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x ae0e61d95677efa778379853e495d748e6efbf95
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100508-sacrifice-antarctic-98c5@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ae0e61d95677efa778379853e495d748e6efbf95 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Thu, 3 Sep 2026 18:31:46 +0200
Subject: [PATCH] USB: serial: fix ioctl hangup race

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

