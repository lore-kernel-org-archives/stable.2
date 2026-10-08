Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1607E33556D
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791469053; cv=none; b=se2vu9sRgtGtMOFoRbkcZ1/MiCofTX8yfmUV2D2jbhQyphBv802SS5YKm2UQ0Pqxojs2LTNnwk33qhoSTBjdtklLH7UoDI2oK5kiWsbzNrUy6d/TS6JSm9k9TOEpJvJsLTk+G/WHaeFxN/CwKp4CXHgFJVrMdbHa/f+/h9wkF/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791469053; c=relaxed/simple;
	bh=3bZD2hptXdCpPNHUoPDSp49UIZcQ94mEXp5PNRQY+2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FTrm4ijE+1X5pLX1hvu4MPsR03uhcVL9k6OLqRyRbDV7gKwK+WoEoToaahZQ3aY//INxRb2gIxxL2KfA+e400lwe8JhUt/DieuWJgc4uPIX05A4TQbsOyMwnKjddvI3IWd2T75KaOmj93E2WoKJfJtOJtm7dOztImbg26CLK9Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o7lWZXW8; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o7lWZXW8"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3a706146559so2346858a91.2
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 07:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791469051; x=1792073851; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c4c88g8MqGd3Qhr1ZxJXYofderT7iOA1fSH3+pjot1E=;
        b=o7lWZXW8tpphGjINssFioiTWA1rG+AorGcvWVXYf1IF3O//eO0IBlbk0cKxJZSKA9c
         i5f2XTdAsVB9VMaxjAiW6ieH4HsFYKyptjGKApOXmS0Q5Lb2QZm040t0sZNkXOHqfvsd
         olC6OXFjPbaG3Zr6VqrA/P/CaaUNGMbmRwe4xeU67GRJ/COts3W5lnbClhcn7cKowm4J
         gLY0447PxP2gcuqhhGh+IEJ5MW3CnPxKvxPTBLfwo5ubYSeXVP2KHgMFPDD7heW3aVx6
         TGTY7ZqeN1kdSTd9hzKA8QS4jwSWjW2ifFc0MB4hg9Rll3MeBbn2tfhXs8c7hkp3N1c8
         V60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791469051; x=1792073851;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c4c88g8MqGd3Qhr1ZxJXYofderT7iOA1fSH3+pjot1E=;
        b=mCj27lZhOjXonjDEWnx4QfGCGh52lBiUMPFrhbx+SDQPbyWEmLvtviXd3NpMY7Lpb6
         Y8mSk54bzpymdM9R4hW99J2ID1MWOsBXmaQ0OR3SWYoUcYXK+L/azVRDULEAP8dfR8Xy
         rlPuINoUjcD0nWjzh+C2XSh99nwlLDt2/pwRyaOFNObxC5mAtb9kRLNXpnQvfKaRfKrI
         zb+2dwlEYcN7oSHTyKmx0EuiOcQHjN+Kqf/gLTZ4e025czABtniYu4ruvwk6cvJ3KZP1
         9Rig/FehjtOvKltWh7FLZK7lVTNqy6JpldqgE4xRHpfcZqb7P9YKAxqjAgfuQhHLxA7v
         R2kg==
X-Gm-Message-State: AFq9FYLLDtzJT/zDS4Cd04TLmXQ0IyhO0LFNThoEMr+FTKLzYVJmoKUw
	LBaLAwvfgTGIRJXmSqmHQB9ww/mvXhBLDl52QTbkOc4b1LzEsle9HUCYr/Ez1pbf
X-Gm-Gg: AYBFou3wOS2Vw8Eac3LT1wKqhN2hzHJ3+eoLb0mnu6K/kTJtce2mh3kG+i8WRgn3rVY
	SEx+N0IVpzAGFxaH+Ci9IWbMCK26OORier2D7pyoTPLK+8v05RJ7NlkthVo/xna5QAhEJR4vg7b
	GMzdM88hJxko4VxlnxAp4rRNevzC7zwgYTBIxH+E4lpbp4WaOLVlUNowigEi87DhAaJL3VKbNg2
	JlhwC4ND+IBhK/mtNxEKIl5ayDTt4Wft2oAzlGeM9tCcF0qfzBJvOmpp9C7g7lq8ffVac0FxAHI
	t9pl1mGJNSk99wKc2dFSXSpajbZupoRClo+2i349Q55mFHatd39vvrBq9sY2goC8q9STuYs9e45
	fVrwHvEetfihigy7PNtk+gB5PcXWmmNCAg/dQ4ymqKwd87hBUztg8G4tuORcBcwpCqtPU4VIuvt
	h8SgyBKnBM0+l1nBhGg+Z2r6MQaW621/dlWOmQcaU0NlJoLkVQzueFEXGgFr6BdtOc2+1ItmAzo
	Q2rrC5FeRo0uHUqF0CgdZjBbvy1ka8C2b8D7x41ENDn9lFWdJCAmgoPSazMJIAHTyxo3AMhNafj
	1geTp64smQ+W0q8u8GKeCu6oEVrBN2I/0b0IIhlP9OiXgfwPSHPg+bVxMCqkQQTl2ICU2QBzmhw
	Gf1oQ+j/+DBOuozX4dsTMDReRyF2ZSDZ2
X-Received: by 2002:a17:90b:1b0a:b0:3a7:8c68:6446 with SMTP id 98e67ed59e1d1-3a8a1569ac0mr4559743a91.63.1791469051089;
        Thu, 08 Oct 2026 07:17:31 -0700 (PDT)
Received: from desktophank.localdomain ([104.28.232.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a9f1a50d32sm4415458a91.2.2026.10.08.07.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 07:17:30 -0700 (PDT)
From: Ting-Han Hou <ue081723@gmail.com>
To: stable@vger.kernel.org
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Ting-Han Hou <ue081723@gmail.com>
Subject: [PATCH 5.10.y 1/2] tty: introduce and use tty_port_tty_vhangup() helper
Date: Thu,  8 Oct 2026 22:17:22 +0800
Message-ID: <20261008141723.1183340-1-ue081723@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026100552-unscathed-jailer-aa56@gregkh>
References: <2026100552-unscathed-jailer-aa56@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>

[ Upstream commit 2b5eac0f8c6e79bc152c8804f9f88d16717013ab ]

This code (tty_get -> vhangup -> tty_put) is repeated on few places.
Introduce a helper similar to tty_port_tty_hangup() (asynchronous) to
handle even vhangup (synchronous).

And use it on those places.

In fact, reuse the tty_port_tty_hangup()'s code and call tty_vhangup()
depending on a new bool parameter.

Signed-off-by: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: Karsten Keil <isdn@linux-pingi.de>
Cc: David Lin <dtwlin@gmail.com>
Cc: Johan Hovold <johan@kernel.org>
Cc: Alex Elder <elder@kernel.org>
Cc: Oliver Neukum <oneukum@suse.com>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20250611100319.186924-2-jirislaby@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Ting-Han: adjust context in uart_remove_one_port(), which is still
  called that and keeps its "ret" variable in this version; the tty_port
  prototypes live in include/linux/tty.h here, so add the inline helpers
  there instead of include/linux/tty_port.h ]
Assisted-by: LLM
Signed-off-by: Ting-Han Hou <ue081723@gmail.com>
---
 drivers/isdn/capi/capi.c         |  8 +-------
 drivers/staging/greybus/uart.c   |  7 +------
 drivers/tty/serial/serial_core.c |  7 +------
 drivers/tty/tty_port.c           | 12 ++++++++----
 drivers/usb/class/cdc-acm.c      |  7 +------
 drivers/usb/serial/usb-serial.c  |  7 +------
 include/linux/tty.h              | 13 ++++++++++++-
 net/bluetooth/rfcomm/tty.c       |  7 +------
 8 files changed, 26 insertions(+), 42 deletions(-)

diff --git a/drivers/isdn/capi/capi.c b/drivers/isdn/capi/capi.c
index 85767f52fe3c..e893c151bfa0 100644
--- a/drivers/isdn/capi/capi.c
+++ b/drivers/isdn/capi/capi.c
@@ -303,15 +303,9 @@ static void capincci_alloc_minor(struct capidev *cdev, struct capincci *np)
 static void capincci_free_minor(struct capincci *np)
 {
 	struct capiminor *mp = np->minorp;
-	struct tty_struct *tty;
 
 	if (mp) {
-		tty = tty_port_tty_get(&mp->port);
-		if (tty) {
-			tty_vhangup(tty);
-			tty_kref_put(tty);
-		}
-
+		tty_port_tty_vhangup(&mp->port);
 		capiminor_free(mp);
 	}
 }
diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
index 5cdc5dff9f55..d95d1b3a8151 100644
--- a/drivers/staging/greybus/uart.c
+++ b/drivers/staging/greybus/uart.c
@@ -929,7 +929,6 @@ static void gb_uart_remove(struct gbphy_device *gbphy_dev)
 {
 	struct gb_tty *gb_tty = gb_gbphy_get_data(gbphy_dev);
 	struct gb_connection *connection = gb_tty->connection;
-	struct tty_struct *tty;
 	int ret;
 
 	ret = gbphy_runtime_get_sync(gbphy_dev);
@@ -942,11 +941,7 @@ static void gb_uart_remove(struct gbphy_device *gbphy_dev)
 	wake_up_all(&gb_tty->wioctl);
 	mutex_unlock(&gb_tty->mutex);
 
-	tty = tty_port_tty_get(&gb_tty->port);
-	if (tty) {
-		tty_vhangup(tty);
-		tty_kref_put(tty);
-	}
+	tty_port_tty_vhangup(&gb_tty->port);
 
 	gb_connection_disable_rx(connection);
 	tty_unregister_device(gb_tty_driver, gb_tty->minor);
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 6d7d448d0fbf..4a228257710f 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3053,7 +3053,6 @@ int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
 	struct uart_state *state = drv->state + uport->line;
 	struct tty_port *port = &state->port;
 	struct uart_port *uart_port;
-	struct tty_struct *tty;
 	int ret = 0;
 
 	BUG_ON(in_interrupt());
@@ -3083,11 +3082,7 @@ int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
 	 */
 	tty_port_unregister_device(port, drv->tty_driver, uport->line);
 
-	tty = tty_port_tty_get(port);
-	if (tty) {
-		tty_vhangup(port->tty);
-		tty_kref_put(tty);
-	}
+	tty_port_tty_vhangup(port);
 
 	/*
 	 * If the port is used as a console, unregister it
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index cbb56f725bc4..599b749729ad 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -369,15 +369,19 @@ EXPORT_SYMBOL(tty_port_hangup);
  * @port: tty port
  * @check_clocal: hang only ttys with CLOCAL unset?
  */
-void tty_port_tty_hangup(struct tty_port *port, bool check_clocal)
+void __tty_port_tty_hangup(struct tty_port *port, bool check_clocal, bool async)
 {
 	struct tty_struct *tty = tty_port_tty_get(port);
 
-	if (tty && (!check_clocal || !C_CLOCAL(tty)))
-		tty_hangup(tty);
+	if (tty && (!check_clocal || !C_CLOCAL(tty))) {
+		if (async)
+			tty_hangup(tty);
+		else
+			tty_vhangup(tty);
+	}
 	tty_kref_put(tty);
 }
-EXPORT_SYMBOL_GPL(tty_port_tty_hangup);
+EXPORT_SYMBOL_GPL(__tty_port_tty_hangup);
 
 /**
  * tty_port_tty_wakeup - helper to wake up a tty
diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index bdc9ed01077e..1d03cb07c529 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1576,7 +1576,6 @@ static int acm_probe(struct usb_interface *intf,
 static void acm_disconnect(struct usb_interface *intf)
 {
 	struct acm *acm = usb_get_intfdata(intf);
-	struct tty_struct *tty;
 	int i;
 
 	/* sibling interface is already cleaning up */
@@ -1603,11 +1602,7 @@ static void acm_disconnect(struct usb_interface *intf)
 	usb_set_intfdata(acm->data, NULL);
 	mutex_unlock(&acm->mutex);
 
-	tty = tty_port_tty_get(&acm->port);
-	if (tty) {
-		tty_vhangup(tty);
-		tty_kref_put(tty);
-	}
+	tty_port_tty_vhangup(&acm->port);
 
 	cancel_delayed_work_sync(&acm->dwork);
 
diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index e8dd4603b201..b4611a83c98b 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -1079,7 +1079,6 @@ static void usb_serial_disconnect(struct usb_interface *interface)
 	struct usb_serial *serial = usb_get_intfdata(interface);
 	struct device *dev = &interface->dev;
 	struct usb_serial_port *port;
-	struct tty_struct *tty;
 
 	usb_serial_console_disconnect(serial);
 
@@ -1090,11 +1089,7 @@ static void usb_serial_disconnect(struct usb_interface *interface)
 
 	for (i = 0; i < serial->num_ports; ++i) {
 		port = serial->port[i];
-		tty = tty_port_tty_get(&port->port);
-		if (tty) {
-			tty_vhangup(tty);
-			tty_kref_put(tty);
-		}
+		tty_port_tty_vhangup(&port->port);
 		usb_serial_port_poison_urbs(port);
 		wake_up_interruptible(&port->port.delta_msr_wait);
 		cancel_work_sync(&port->work);
diff --git a/include/linux/tty.h b/include/linux/tty.h
index e51d75f5165b..f6e789c66943 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -622,7 +622,8 @@ extern int tty_port_carrier_raised(struct tty_port *port);
 extern void tty_port_raise_dtr_rts(struct tty_port *port);
 extern void tty_port_lower_dtr_rts(struct tty_port *port);
 extern void tty_port_hangup(struct tty_port *port);
-extern void tty_port_tty_hangup(struct tty_port *port, bool check_clocal);
+extern void __tty_port_tty_hangup(struct tty_port *port, bool check_clocal,
+				  bool async);
 extern void tty_port_tty_wakeup(struct tty_port *port);
 extern int tty_port_block_til_ready(struct tty_port *port,
 				struct tty_struct *tty, struct file *filp);
@@ -640,6 +641,16 @@ static inline int tty_port_users(struct tty_port *port)
 	return port->count + port->blocked_open;
 }
 
+static inline void tty_port_tty_hangup(struct tty_port *port, bool check_clocal)
+{
+	__tty_port_tty_hangup(port, check_clocal, true);
+}
+
+static inline void tty_port_tty_vhangup(struct tty_port *port)
+{
+	__tty_port_tty_hangup(port, false, false);
+}
+
 extern int tty_register_ldisc(int disc, struct tty_ldisc_ops *new_ldisc);
 extern int tty_unregister_ldisc(int disc);
 extern int tty_set_ldisc(struct tty_struct *tty, int disc);
diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 6959ab16c2c6..0948ceeca671 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -437,7 +437,6 @@ static int __rfcomm_release_dev(void __user *arg)
 {
 	struct rfcomm_dev_req req;
 	struct rfcomm_dev *dev;
-	struct tty_struct *tty;
 
 	if (copy_from_user(&req, arg, sizeof(req)))
 		return -EFAULT;
@@ -463,11 +462,7 @@ static int __rfcomm_release_dev(void __user *arg)
 		rfcomm_dlc_close(dev->dlc, 0);
 
 	/* Shut down TTY synchronously before freeing rfcomm_dev */
-	tty = tty_port_tty_get(&dev->port);
-	if (tty) {
-		tty_vhangup(tty);
-		tty_kref_put(tty);
-	}
+	tty_port_tty_vhangup(&dev->port);
 
 	if (!test_bit(RFCOMM_TTY_OWNED, &dev->status))
 		tty_port_put(&dev->port);
-- 
2.43.0

