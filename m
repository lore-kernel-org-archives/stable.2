Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48C3414A05
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 16:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785427289; cv=none; b=nZeXdnrhd95DzKxxYYXCHEGzba9KoCZWWFluIGG8lJFLrPE3mF5DHY1VnNko8vvYborh3LD947g1R3JJkuOILdxS0H6YWuArWwS09HJNxizv/z5Gw6S78YzlPtk3tpqDwE8zEyaoZz4CCOB/+HvhKdpDGPkWO9ha58aJmgiOibc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785427289; c=relaxed/simple;
	bh=rk2fWyb6MuMt6fz6qgIOdWylxcFOXsstBPlNmtwkceg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQEnUxQI9Bm27SGt/EWSR1Ti9mZza5dhQ+wTI1q5a2sLtqsxdqMckHqXub90oXrgtMLwwhYH2cWBNaDZkSwAKNhNN/KtZz/hk1lA5BDaju/0bIqwfKUwvj4aMIbE/7+YI0KuAQQRWW/LLaDVv6IEQ2L+J1pmk0UJs4atkigLvrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oo2dr/vX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oo2dr/vX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E1A1F00ACA;
	Thu, 30 Jul 2026 16:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785427287;
	bh=JO6gKMsvLqb6gY9+tMveXWHfDVrS6fu1bqZiTy9w978=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oo2dr/vXEUh7nTu4GHpWHjQo5X9HZLD/l5Dne/Ym2gfsFj6GtMVz5ryrxB447tZ4H
	 2KUC7TyHHu2GBZ03+CrY+lk6qZs7nbRtv/zPFpMJggL4M2C8Z6+L4ccmzfubiHUA5R
	 EusyfItnjNVwnCkVqIyaYYMRxBxt/DmlGdCahC8o3jPoZqft+uUpNuEFA3MX4Or8AP
	 ezPInh/vrRM7ouXQWxumnILJ6HfsJUvOx5CtWaXCyiab01Bost3TChgGbNmKqVRcNP
	 rh3NAr6NUeF6fFOFJbPqy1kPGr27pglKoUdYePwng3l0o/ZK1lVLuGQ5nKyvtknnE3
	 uMpKVmhxcEadA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/5] USB: serial: keyspan_pda: clean up comments and whitespace
Date: Thu, 30 Jul 2026 12:01:21 -0400
Message-ID: <20260730160123.2768188-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730160123.2768188-1-sashal@kernel.org>
References: <2026072756-mountain-living-62e9@gregkh>
 <20260730160123.2768188-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 491d6927f0de587c1d322d8b29a1187b7e06a221 ]

Clean up comment style, remove some stale or redundant comments and drop
superfluous white space.

Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Stable-dep-of: 42a97c0480f9 ("USB: serial: keyspan_pda: fix data loss on receive throttling")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/serial/keyspan_pda.c | 97 ++++++++++++++++----------------
 1 file changed, 47 insertions(+), 50 deletions(-)

diff --git a/drivers/usb/serial/keyspan_pda.c b/drivers/usb/serial/keyspan_pda.c
index 3dfac896572c..bfc23694a6fe 100644
--- a/drivers/usb/serial/keyspan_pda.c
+++ b/drivers/usb/serial/keyspan_pda.c
@@ -11,7 +11,6 @@
  * driver
  */
 
-
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
@@ -146,8 +145,10 @@ static void keyspan_pda_request_unthrottle(struct work_struct *work)
 
 	dev_dbg(&port->dev, "%s\n", __func__);
 
-	/* ask the device to tell us when the tx buffer becomes
-	   sufficiently empty */
+	/*
+	 * Ask the device to tell us when the tx buffer becomes
+	 * sufficiently empty.
+	 */
 	result = usb_control_msg(serial->dev,
 				 usb_sndctrlpipe(serial->dev, 0),
 				 7, /* request_unthrottle */
@@ -233,7 +234,6 @@ static void keyspan_pda_rx_interrupt(struct urb *urb)
 
 			keyspan_pda_write_start(port);
 
-			/* queue up a wakeup at scheduler time */
 			usb_serial_port_softint(port);
 			break;
 		default:
@@ -317,8 +317,6 @@ static speed_t keyspan_pda_setbaud(struct usb_serial *serial, speed_t baud)
 		baud = 9600;
 	}
 
-	/* rather than figure out how to sleep while waiting for this
-	   to complete, I just use the "legacy" API. */
 	rc = usb_control_msg(serial->dev, usb_sndctrlpipe(serial->dev, 0),
 			     0, /* set baud */
 			     USB_TYPE_VENDOR
@@ -331,10 +329,10 @@ static speed_t keyspan_pda_setbaud(struct usb_serial *serial, speed_t baud)
 			     2000); /* timeout */
 	if (rc < 0)
 		return 0;
+
 	return baud;
 }
 
-
 static void keyspan_pda_break_ctl(struct tty_struct *tty, int break_state)
 {
 	struct usb_serial_port *port = tty->driver_data;
@@ -346,6 +344,7 @@ static void keyspan_pda_break_ctl(struct tty_struct *tty, int break_state)
 		value = 1; /* start break */
 	else
 		value = 0; /* clear break */
+
 	result = usb_control_msg(serial->dev, usb_sndctrlpipe(serial->dev, 0),
 			4, /* set break */
 			USB_TYPE_VENDOR | USB_RECIP_INTERFACE | USB_DIR_OUT,
@@ -353,39 +352,35 @@ static void keyspan_pda_break_ctl(struct tty_struct *tty, int break_state)
 	if (result < 0)
 		dev_dbg(&port->dev, "%s - error %d from usb_control_msg\n",
 			__func__, result);
-	/* there is something funky about this.. the TCSBRK that 'cu' performs
-	   ought to translate into a break_ctl(-1),break_ctl(0) pair HZ/4
-	   seconds apart, but it feels like the break sent isn't as long as it
-	   is on /dev/ttyS0 */
 }
 
-
 static void keyspan_pda_set_termios(struct tty_struct *tty,
 		struct usb_serial_port *port, struct ktermios *old_termios)
 {
 	struct usb_serial *serial = port->serial;
 	speed_t speed;
 
-	/* cflag specifies lots of stuff: number of stop bits, parity, number
-	   of data bits, baud. What can the device actually handle?:
-	   CSTOPB (1 stop bit or 2)
-	   PARENB (parity)
-	   CSIZE (5bit .. 8bit)
-	   There is minimal hw support for parity (a PSW bit seems to hold the
-	   parity of whatever is in the accumulator). The UART either deals
-	   with 10 bits (start, 8 data, stop) or 11 bits (start, 8 data,
-	   1 special, stop). So, with firmware changes, we could do:
-	   8N1: 10 bit
-	   8N2: 11 bit, extra bit always (mark?)
-	   8[EOMS]1: 11 bit, extra bit is parity
-	   7[EOMS]1: 10 bit, b0/b7 is parity
-	   7[EOMS]2: 11 bit, b0/b7 is parity, extra bit always (mark?)
-
-	   HW flow control is dictated by the tty->termios.c_cflags & CRTSCTS
-	   bit.
-
-	   For now, just do baud. */
-
+	/*
+	 * cflag specifies lots of stuff: number of stop bits, parity, number
+	 * of data bits, baud. What can the device actually handle?:
+	 * CSTOPB (1 stop bit or 2)
+	 * PARENB (parity)
+	 * CSIZE (5bit .. 8bit)
+	 * There is minimal hw support for parity (a PSW bit seems to hold the
+	 * parity of whatever is in the accumulator). The UART either deals
+	 * with 10 bits (start, 8 data, stop) or 11 bits (start, 8 data,
+	 * 1 special, stop). So, with firmware changes, we could do:
+	 * 8N1: 10 bit
+	 * 8N2: 11 bit, extra bit always (mark?)
+	 * 8[EOMS]1: 11 bit, extra bit is parity
+	 * 7[EOMS]1: 10 bit, b0/b7 is parity
+	 * 7[EOMS]2: 11 bit, b0/b7 is parity, extra bit always (mark?)
+	 *
+	 * HW flow control is dictated by the tty->termios.c_cflags & CRTSCTS
+	 * bit.
+	 *
+	 * For now, just do baud.
+	 */
 	speed = tty_get_baud_rate(tty);
 	speed = keyspan_pda_setbaud(serial, speed);
 
@@ -394,17 +389,19 @@ static void keyspan_pda_set_termios(struct tty_struct *tty,
 		/* It hasn't changed so.. */
 		speed = tty_termios_baud_rate(old_termios);
 	}
-	/* Only speed can change so copy the old h/w parameters
-	   then encode the new speed */
+	/*
+	 * Only speed can change so copy the old h/w parameters then encode
+	 * the new speed.
+	 */
 	tty_termios_copy_hw(&tty->termios, old_termios);
 	tty_encode_baud_rate(tty, speed, speed);
 }
 
-
-/* modem control pins: DTR and RTS are outputs and can be controlled.
-   DCD, RI, DSR, CTS are inputs and can be read. All outputs can also be
-   read. The byte passed is: DTR(b7) DCD RI DSR CTS RTS(b2) unused unused */
-
+/*
+ * Modem control pins: DTR and RTS are outputs and can be controlled.
+ * DCD, RI, DSR, CTS are inputs and can be read. All outputs can also be
+ * read. The byte passed is: DTR(b7) DCD RI DSR CTS RTS(b2) unused unused.
+ */
 static int keyspan_pda_get_modem_info(struct usb_serial *serial,
 				      unsigned char *value)
 {
@@ -428,7 +425,6 @@ static int keyspan_pda_get_modem_info(struct usb_serial *serial,
 	return rc;
 }
 
-
 static int keyspan_pda_set_modem_info(struct usb_serial *serial,
 				      unsigned char value)
 {
@@ -504,10 +500,11 @@ static int keyspan_pda_write_start(struct usb_serial_port *port)
 	 * unthrottle work is scheduled).
 	 */
 
-	/* we might block because of:
-	   the TX urb is in-flight (wait until it completes)
-	   the device is full (wait until it says there is room)
-	*/
+	/*
+	 * We might block because of:
+	 * the TX urb is in-flight (wait until it completes)
+	 * the device is full (wait until it says there is room)
+	 */
 	spin_lock_irqsave(&port->lock, flags);
 
 	room = priv->tx_room;
@@ -566,7 +563,6 @@ static void keyspan_pda_write_bulk_callback(struct urb *urb)
 
 	keyspan_pda_write_start(port);
 
-	/* queue up a wakeup at scheduler time */
 	usb_serial_port_softint(port);
 }
 
@@ -615,7 +611,6 @@ static int keyspan_pda_open(struct tty_struct *tty,
 	priv->tx_room = rc;
 	spin_unlock_irq(&port->lock);
 
-	/*Start reading from the device*/
 	rc = usb_submit_urb(port->interrupt_in_urb, GFP_KERNEL);
 	if (rc) {
 		dev_dbg(&port->dev, "%s - usb_submit_urb(read int) failed\n", __func__);
@@ -673,10 +668,12 @@ static int keyspan_pda_fake_startup(struct usb_serial *serial)
 		return -ENOENT;
 	}
 
-	/* after downloading firmware Renumeration will occur in a
-	  moment and the new device will bind to the real driver */
+	/*
+	 * After downloading firmware renumeration will occur in a moment and
+	 * the new device will bind to the real driver.
+	 */
 
-	/* we want this device to fail to have a driver assigned to it. */
+	/* We want this device to fail to have a driver assigned to it. */
 	return 1;
 }
 
@@ -755,7 +752,7 @@ static struct usb_serial_driver keyspan_pda_device = {
 	.open =			keyspan_pda_open,
 	.close =		keyspan_pda_close,
 	.write =		keyspan_pda_write,
-	.write_bulk_callback = 	keyspan_pda_write_bulk_callback,
+	.write_bulk_callback =	keyspan_pda_write_bulk_callback,
 	.read_int_callback =	keyspan_pda_rx_interrupt,
 	.throttle =		keyspan_pda_rx_throttle,
 	.unthrottle =		keyspan_pda_rx_unthrottle,
-- 
2.53.0

