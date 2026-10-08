Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C3B32FA2E
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 14:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791469023; cv=none; b=NETkZapPBgrTooBO4lBqo7nOjW861ltPrlEYMSXuYKeU4Pl5wkLOCokD663xKIT6XIDydMYuj6n6bOWQtsifPcCshb9tTDA4GiywmDrnZqZbWG//u6Lw0rCnW5QiZ7dm75nNsXSPTzCAhPiii0b+aA+xa9f/VWuC+VIzf8dee2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791469023; c=relaxed/simple;
	bh=0tNO9cRHu/MlZ/F8PWJ0TPhO7ZScBtF2+rQE0G4hLa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FDiouRTbKwc8KoodXr1E5P9qaI7h6SXO9WDkxKRa3Sr1d6x3nDTIaTndx0ybh+Ea63mMLdf/99mxJV4VxjKen26/4f/sOTz4TNn+Vwgt8i/ruqeSiYGc8E1pqZpAWxoQyHYYSNOIe4D3dLasGXs1cj27fvw7F4Wst801Wufl8nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxxEtNE4; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxxEtNE4"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ab27c7e68aso30964a91.3
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 07:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791469021; x=1792073821; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ji68ba1+Ah6gXvbQ3iJZgKoTAkZjzNIJJloODons5mU=;
        b=GxxEtNE4scmj2EyTFbNkyTYoKZE7G3ONi0OwNui2PYRUFIpP4ICoidQqf0ecYbDHiS
         kJJgXFriyYZFzYU2dbFTB+MljmkExfg92PJttzvxFoDLl6cD/rZpK28oMKlgkOLfv7kb
         Dwr6AfnIUIvYieIvLnYycjtUj3KXUE4PibhK2C3lDRw4/9BeLVNuzg9MTq8vOzqNWrP7
         7uzu/H1geD9CMSQWZ8meQ7mGAuatFZmc699dj3HmPjqncRCtZ3gfhHgBDGMwM7SMDaXQ
         zM+2wD1ca0vFFPrIwsVZaJIH31N5nHc7XZNW8YfcEotDKMdxKUOvfWaS5whsK4TUvPKu
         V7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791469021; x=1792073821;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ji68ba1+Ah6gXvbQ3iJZgKoTAkZjzNIJJloODons5mU=;
        b=WLlLYnKFnVKQAEH6+MX6QHHzVZye2T/eGXtarS4OEb9BNsJavipGWpPczXoHuDkyaf
         fugkM1dQrStFUAO1BuccLc2HheIlqwzT7nGts1beNhSHcOW8YqICNvqUhYxjPWsJht3s
         sDrwcG2SMpOtnJCeAgEBAgMNZsh7QT/2k/4xbc2khgUccj5ECNFhkFQ6LOwV/IP3SKdR
         jftG5OgnJBR3eMan/Hd1agnXFto1oltWwCpoz8eoqN+u1xCVu3t5mI8mJvTh3FjI+L1E
         u/qSlyBorbedLV1dl3hdF0NpPZwwfYtDhS6O2T5xPWuo919BKwiGu2URJSaSO/hqyEat
         7eaA==
X-Gm-Message-State: AFq9FYLCzabMkTbmm+bUnTWKKmK3cQGVhz91PbvwX8UZVyi4FRTxlo8Y
	ZdKs1DSM2NDBZGS7vuPEEBlWzaohY5aRL20fXa3Llz/AvGQb79qlOYAUU36JWvo3
X-Gm-Gg: AYBFou09I7ub57dXq80MXpHejQfRS00wmOqzQJelmojud4xYOkSakUy351iU+f3+xRF
	KB3p3Obri3QJCaa1QpYJtm0Ic1lZX5RCwTXc5l8wg8sKGrXqSFJhYeXYZ0TaWslfyJ5oSe6RSzY
	5ZfaQCEJ1NyhQYUELbwaeq97ehRXnjzaEthJ2YtFZQwxTn2gj5BUuDaYufOHrc4XGIaA70aBXWd
	cgdSeBUxeefrEBZx/5rMOgecTjYQee08BtTnyGupPrThSuvc7foK9mF5Xr6krXclsGNub6eF6YX
	K37PeBI9k04Cg9fi4pk9yQ2lRhXGRl4DZN7ArvfiD144OfJEyHGvg8si7Skn1MxhWxWKWDwNSom
	kMdpinnBzNrsTQw+Bf1UNs1VLrLMKXbMJtL9v67xZzy+fntWjtgiw5DKMwJ4MHg7K4IDJIUyHcG
	KF1607ImkfHjbLyeC0qjN9Pams0PQAAHb512oOyt7jXqKinjlBFB62Ns5N8d8GTYrTiMY1OxQaz
	PBejBbNQaohOQewJEBcOajXBvNYhkaADcpJXuKEMNHetZ2QLDgyMX6CN0L+8EAPgYVMvBAPdRCu
	Bop/N0B4kZV5bRFRGHclqIrkkDd9TfycFy3cv0kAlM+/AT56mTGtcbUN5lcm2ekkWBluV6HbeWO
	Y2MBsfdcWppWfjMSatEqs/7cJKTdrZvX2
X-Received: by 2002:a17:90b:518e:b0:3a4:b8f2:7686 with SMTP id 98e67ed59e1d1-3a8a192c4c8mr5085351a91.12.1791469020959;
        Thu, 08 Oct 2026 07:17:00 -0700 (PDT)
Received: from desktophank.localdomain ([104.28.232.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a8a438f25dsm3760777a91.2.2026.10.08.07.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 07:17:00 -0700 (PDT)
From: Ting-Han Hou <ue081723@gmail.com>
To: stable@vger.kernel.org
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Ting-Han Hou <ue081723@gmail.com>
Subject: [PATCH 5.15.y 1/2] tty: introduce and use tty_port_tty_vhangup() helper
Date: Thu,  8 Oct 2026 22:16:48 +0800
Message-ID: <20261008141649.1183309-1-ue081723@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026100552-dumpster-splashed-bbd3@gregkh>
References: <2026100552-dumpster-splashed-bbd3@gregkh>
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
  called that and keeps its "ret" variable in this version ]
Assisted-by: LLM
Signed-off-by: Ting-Han Hou <ue081723@gmail.com>
---
 drivers/isdn/capi/capi.c         |  8 +-------
 drivers/staging/greybus/uart.c   |  7 +------
 drivers/tty/serial/serial_core.c |  7 +------
 drivers/tty/tty_port.c           | 12 ++++++++----
 drivers/usb/class/cdc-acm.c      |  7 +------
 drivers/usb/serial/usb-serial.c  |  7 +------
 include/linux/tty_port.h         | 12 +++++++++++-
 net/bluetooth/rfcomm/tty.c       |  7 +------
 8 files changed, 25 insertions(+), 42 deletions(-)

diff --git a/drivers/isdn/capi/capi.c b/drivers/isdn/capi/capi.c
index 0f00be62438d..973092543eb7 100644
--- a/drivers/isdn/capi/capi.c
+++ b/drivers/isdn/capi/capi.c
@@ -304,15 +304,9 @@ static void capincci_alloc_minor(struct capidev *cdev, struct capincci *np)
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
index dc4ed0ff1ae2..54ce29fbb9e5 100644
--- a/drivers/staging/greybus/uart.c
+++ b/drivers/staging/greybus/uart.c
@@ -915,7 +915,6 @@ static void gb_uart_remove(struct gbphy_device *gbphy_dev)
 {
 	struct gb_tty *gb_tty = gb_gbphy_get_data(gbphy_dev);
 	struct gb_connection *connection = gb_tty->connection;
-	struct tty_struct *tty;
 	int ret;
 
 	ret = gbphy_runtime_get_sync(gbphy_dev);
@@ -928,11 +927,7 @@ static void gb_uart_remove(struct gbphy_device *gbphy_dev)
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
index 404354727d19..25fb7e700291 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3036,7 +3036,6 @@ int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
 	struct uart_state *state = drv->state + uport->line;
 	struct tty_port *port = &state->port;
 	struct uart_port *uart_port;
-	struct tty_struct *tty;
 	int ret = 0;
 
 	mutex_lock(&port_mutex);
@@ -3064,11 +3063,7 @@ int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
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
index 2f1061a9d926..58d2962bc411 100644
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
index d5ec2a55aa14..d400fe84e40f 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1560,7 +1560,6 @@ static int acm_probe(struct usb_interface *intf,
 static void acm_disconnect(struct usb_interface *intf)
 {
 	struct acm *acm = usb_get_intfdata(intf);
-	struct tty_struct *tty;
 	int i;
 
 	/* sibling interface is already cleaning up */
@@ -1587,11 +1586,7 @@ static void acm_disconnect(struct usb_interface *intf)
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
index 255fb9583c0a..72507f1e5561 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -1175,7 +1175,6 @@ static void usb_serial_disconnect(struct usb_interface *interface)
 	struct usb_serial *serial = usb_get_intfdata(interface);
 	struct device *dev = &interface->dev;
 	struct usb_serial_port *port;
-	struct tty_struct *tty;
 
 	/* sibling interface is cleaning up */
 	if (!serial)
@@ -1190,11 +1189,7 @@ static void usb_serial_disconnect(struct usb_interface *interface)
 
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
diff --git a/include/linux/tty_port.h b/include/linux/tty_port.h
index 6e86e9e118b6..03d889398c5e 100644
--- a/include/linux/tty_port.h
+++ b/include/linux/tty_port.h
@@ -186,7 +186,7 @@ int tty_port_carrier_raised(struct tty_port *port);
 void tty_port_raise_dtr_rts(struct tty_port *port);
 void tty_port_lower_dtr_rts(struct tty_port *port);
 void tty_port_hangup(struct tty_port *port);
-void tty_port_tty_hangup(struct tty_port *port, bool check_clocal);
+void __tty_port_tty_hangup(struct tty_port *port, bool check_clocal, bool async);
 void tty_port_tty_wakeup(struct tty_port *port);
 int tty_port_block_til_ready(struct tty_port *port, struct tty_struct *tty,
 		struct file *filp);
@@ -205,4 +205,14 @@ static inline int tty_port_users(struct tty_port *port)
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
 #endif
diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 6962fa62bd12..2d528faeb3bf 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -439,7 +439,6 @@ static int __rfcomm_release_dev(void __user *arg)
 {
 	struct rfcomm_dev_req req;
 	struct rfcomm_dev *dev;
-	struct tty_struct *tty;
 
 	if (copy_from_user(&req, arg, sizeof(req)))
 		return -EFAULT;
@@ -465,11 +464,7 @@ static int __rfcomm_release_dev(void __user *arg)
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

