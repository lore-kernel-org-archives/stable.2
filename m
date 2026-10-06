Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512E83C3432
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 22:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791327448; cv=none; b=T2M5VRG2x4fHkov/AuLzh921ugiMMn781Gh0nDw++qeTZ0gZ/52UW4Vlx1OFhN0vnxObQTzty8GJ8rflheoKtYd6Szi5evjzyXmnV/a9Hhq2KggsT3gb9KKgzZN5UnA4l+JTEdXKiSJTIFfCrwytr2IZ/hR/+jAqjdtkrutRIJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791327448; c=relaxed/simple;
	bh=KlORaD7bbZS5Wcpw5lk5UbOG47iqj7PMbqqXJE3kd4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJJfxAy069mztIYe/R6voy57yceIQUxyXztH4299QiDViAwix0r7pOeBMv7DWD4sc+pRGBLh03z1Z55AYYmXZh3rMjRpuvMvW3AZ0I6kIMo4XQE+1y+J8EMSTKHY5n+GYfCVPJqioTvYxr94DuluTVNgwn8jlbG2v8iC8rVZtBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOhc7ETI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOhc7ETI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8C51F0089C;
	Tue,  6 Oct 2026 22:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791327448;
	bh=0X0eHx/+vLvizFsQZ0dvmA9K1eZRSWQ/6aMCpzLAjTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jOhc7ETI3ZkqWvK/uId413+Wbz/Gh75dEKmLMOrlPU9RblqYhBBLT59KLbJvSVjtS
	 CHwnKJsoew0FaDFvPo8cCYG0tFJ+buU/NpLgKTcA8ND4zD0llOoMb6NK6a1f+Dx+/T
	 UdQsHxP94MUwfhaMSxnyo5VFcOGZoJWDEyXUM1+eBzl07CvP1Twl0zQFrzKsW2Hgsk
	 ViNTEty+sBTXJPpPUkzUm0hr9FwnCJiPdP1VwMd/mtJJJh8lPHBSkO1psJZzBrvSbR
	 ADnVLKqXnrSnl7pIQD1vRsYvsk7TH2iz07IM5nDfyDfeI7SlMEoxWdHK/x73slFO5S
	 fm2+Zj158TqHQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Nick Bowler <nbowler@draconx.ca>,
	syzbot+473d7477c523b41d4046@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] USB: serial: fix ioctl hangup race
Date: Tue,  6 Oct 2026 18:57:21 -0400
Message-ID: <20261006225449.1126693-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006225449.1126693-1-sashal@kernel.org>
References: <2026100507-couch-zit-6026@gregkh>
 <20261006225449.1126693-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit ae0e61d95677efa778379853e495d748e6efbf95 ]

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
[ sashal: Omitted XR driver hunks because the RS-485 ioctl helpers are absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/serial/generic.c    | 10 +++-
 drivers/usb/serial/usb-serial.c | 94 ++++++++++++++++++++++++++-------
 2 files changed, 83 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/serial/generic.c b/drivers/usb/serial/generic.c
index 15b6dee3a8e50..64890f6d78e03 100644
--- a/drivers/usb/serial/generic.c
+++ b/drivers/usb/serial/generic.c
@@ -268,6 +268,7 @@ EXPORT_SYMBOL_GPL(usb_serial_generic_chars_in_buffer);
 void usb_serial_generic_wait_until_sent(struct tty_struct *tty, long timeout)
 {
 	struct usb_serial_port *port = tty->driver_data;
+	struct tty_port *tport = &port->port;
 	unsigned int bps;
 	unsigned long period;
 	unsigned long expire;
@@ -287,7 +288,14 @@ void usb_serial_generic_wait_until_sent(struct tty_struct *tty, long timeout)
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
index c7140aa8c5908..6ebe5dcce0c00 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -403,17 +403,13 @@ static unsigned int serial_chars_in_buffer(struct tty_struct *tty)
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
@@ -441,8 +437,13 @@ static int serial_get_serial(struct tty_struct *tty, struct serial_struct *ss)
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
@@ -455,10 +456,10 @@ static int serial_get_serial(struct tty_struct *tty, struct serial_struct *ss)
 
 	if (port->serial->type->get_serial)
 		port->serial->type->get_serial(tty, ss);
-
+out_unlock:
 	mutex_unlock(&tport->mutex);
 
-	return 0;
+	return ret;
 }
 
 static int serial_set_serial(struct tty_struct *tty, struct serial_struct *ss)
@@ -474,6 +475,10 @@ static int serial_set_serial(struct tty_struct *tty, struct serial_struct *ss)
 		closing_wait = msecs_to_jiffies(closing_wait * 10);
 
 	mutex_lock(&tport->mutex);
+	if (tty_io_error(tty)) {
+		ret = -EIO;
+		goto out_unlock;
+	}
 
 	if (!capable(CAP_SYS_ADMIN)) {
 		if (close_delay != tport->close_delay ||
@@ -501,6 +506,7 @@ static int serial_ioctl(struct tty_struct *tty,
 					unsigned int cmd, unsigned long arg)
 {
 	struct usb_serial_port *port = tty->driver_data;
+	struct tty_port *tport = &port->port;
 	int retval = -ENOIOCTLCMD;
 
 	dev_dbg(&port->dev, "%s - cmd 0x%04x\n", __func__, cmd);
@@ -511,8 +517,21 @@ static int serial_ioctl(struct tty_struct *tty,
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
@@ -522,25 +541,40 @@ static void serial_set_termios(struct tty_struct *tty,
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
@@ -581,24 +615,44 @@ static int serial_proc_show(struct seq_file *m, void *v)
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
-- 
2.53.0

