Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3983B38B8
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 16:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785427286; cv=none; b=tjqEJIviUdFgAzXViCsrrMd5uLY/9nTexh1EOSfOApz4TGibfEGiBi2FWobucEjKCDYgLTut8nH994EEEdXXoL6dZg+ddxBth6DsZQjTrLlKWWm3bwnMJ7jIhzw5WPANCchtNdXvyJgMrmJPhRsFnMQYb48ijvz32A4Altmwvjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785427286; c=relaxed/simple;
	bh=mjNjEfsj4wDbX8dHivADY8KzP/YYWNMCaWa/IS27lVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YN+WS/ZF6a1uD9ufn9U5CWl+byR38wY+WZY6Or8x0u7UU1RQuHWVu+8o+T1O0uKbOWo7EBMQZDcdoMrUFBNWKO9NiGImONkavnULXf4WQAs2I2TdeIpX2BXtQpUI336ySiYloBB1e1ejND4mJO/aXZ94FxHEfipNeMsVNe1Ghgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MaQ+bS9U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MaQ+bS9U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A66B1F000E9;
	Thu, 30 Jul 2026 16:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785427285;
	bh=hPa4ErL+a2M2owlFEkGfJCGVaPDYXI6IoNEQpBOFZos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MaQ+bS9UEEVpo7hROJq7GdMPNSrF+vTKKh1iKVkDTqQli8v3IWj48x3mnc6kGY9jw
	 OpBV4nqe6IDMbeK2ym7iI4eFkKr7Fahx6KUMqymb4b4ScA7WQtqfhvWp/Wsb0UoBEb
	 jFzMjyd56ZtNCsg6xT1eRHzicZuQE3+3OFEs5l8LFRRp7EsfmKe1unTpoYjtFjgkuy
	 LT9cZLiaIEMKSz4n7VwAfiIwrgUQ7yh1S+JUn0IAbBFWBDdkkOXZdHfLIRZ9rlx7pf
	 NJX9ol/anjHQwgUctFhoc5McQGyNLB0oseDqJFG7/Q9rbnbjdoepL5b5QZ2UQV8zgX
	 0XIqHT5IAdhYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/5] USB: serial: keyspan_pda: refactor write-room handling
Date: Thu, 30 Jul 2026 12:01:18 -0400
Message-ID: <20260730160123.2768188-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072756-mountain-living-62e9@gregkh>
References: <2026072756-mountain-living-62e9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 79fe6826a5ebee2724d432a736ec04d8dca143ba ]

Add helper to retrieve the available device transfer-buffer space.

Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Stable-dep-of: 42a97c0480f9 ("USB: serial: keyspan_pda: fix data loss on receive throttling")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/serial/keyspan_pda.c | 113 ++++++++++++++-----------------
 1 file changed, 50 insertions(+), 63 deletions(-)

diff --git a/drivers/usb/serial/keyspan_pda.c b/drivers/usb/serial/keyspan_pda.c
index aec32bf06e01..0f5528061170 100644
--- a/drivers/usb/serial/keyspan_pda.c
+++ b/drivers/usb/serial/keyspan_pda.c
@@ -98,6 +98,42 @@ static const struct usb_device_id id_table_fake_xircom[] = {
 };
 #endif
 
+static int keyspan_pda_get_write_room(struct keyspan_pda_private *priv)
+{
+	struct usb_serial_port *port = priv->port;
+	struct usb_serial *serial = priv->serial;
+	u8 *room;
+	int rc;
+
+	room = kmalloc(1, GFP_KERNEL);
+	if (!room)
+		return -ENOMEM;
+
+	rc = usb_control_msg(serial->dev,
+			     usb_rcvctrlpipe(serial->dev, 0),
+			     6, /* write_room */
+			     USB_TYPE_VENDOR | USB_RECIP_INTERFACE
+			     | USB_DIR_IN,
+			     0, /* value: 0 means "remaining room" */
+			     0, /* index */
+			     room,
+			     1,
+			     2000);
+	if (rc != 1) {
+		if (rc >= 0)
+			rc = -EIO;
+		dev_dbg(&port->dev, "roomquery failed: %d\n", rc);
+		goto out_free;
+	}
+
+	dev_dbg(&port->dev, "roomquery says %d\n", *room);
+	rc = *room;
+out_free:
+	kfree(room);
+
+	return rc;
+}
+
 static void keyspan_pda_request_unthrottle(struct work_struct *work)
 {
 	struct keyspan_pda_private *priv =
@@ -436,7 +472,6 @@ static int keyspan_pda_tiocmset(struct tty_struct *tty,
 static int keyspan_pda_write(struct tty_struct *tty,
 	struct usb_serial_port *port, const unsigned char *buf, int count)
 {
-	struct usb_serial *serial = port->serial;
 	int request_unthrottle = 0;
 	int rc = 0;
 	struct keyspan_pda_private *priv;
@@ -479,38 +514,11 @@ static int keyspan_pda_write(struct tty_struct *tty,
 	   device how much room it really has.  This is done only on
 	   scheduler time, since usb_control_msg() sleeps. */
 	if (count > priv->tx_room && !in_interrupt()) {
-		u8 *room;
-
-		room = kmalloc(1, GFP_KERNEL);
-		if (!room) {
-			rc = -ENOMEM;
+		rc = keyspan_pda_get_write_room(priv);
+		if (rc < 0)
 			goto exit;
-		}
 
-		rc = usb_control_msg(serial->dev,
-				     usb_rcvctrlpipe(serial->dev, 0),
-				     6, /* write_room */
-				     USB_TYPE_VENDOR | USB_RECIP_INTERFACE
-				     | USB_DIR_IN,
-				     0, /* value: 0 means "remaining room" */
-				     0, /* index */
-				     room,
-				     1,
-				     2000);
-		if (rc > 0) {
-			dev_dbg(&port->dev, "roomquery says %d\n", *room);
-			priv->tx_room = *room;
-		}
-		kfree(room);
-		if (rc < 0) {
-			dev_dbg(&port->dev, "roomquery failed\n");
-			goto exit;
-		}
-		if (rc == 0) {
-			dev_dbg(&port->dev, "roomquery returned 0 bytes\n");
-			rc = -EIO; /* device didn't return any data */
-			goto exit;
-		}
+		priv->tx_room = rc;
 	}
 
 	if (count >= priv->tx_room) {
@@ -612,48 +620,27 @@ static void keyspan_pda_dtr_rts(struct usb_serial_port *port, int on)
 static int keyspan_pda_open(struct tty_struct *tty,
 					struct usb_serial_port *port)
 {
-	struct usb_serial *serial = port->serial;
-	u8 *room;
-	int rc = 0;
-	struct keyspan_pda_private *priv;
+	struct keyspan_pda_private *priv = usb_get_serial_port_data(port);
+	int rc;
 
 	/* find out how much room is in the Tx ring */
-	room = kmalloc(1, GFP_KERNEL);
-	if (!room)
-		return -ENOMEM;
+	rc = keyspan_pda_get_write_room(priv);
+	if (rc < 0)
+		return rc;
 
-	rc = usb_control_msg(serial->dev, usb_rcvctrlpipe(serial->dev, 0),
-			     6, /* write_room */
-			     USB_TYPE_VENDOR | USB_RECIP_INTERFACE
-			     | USB_DIR_IN,
-			     0, /* value */
-			     0, /* index */
-			     room,
-			     1,
-			     2000);
-	if (rc < 0) {
-		dev_dbg(&port->dev, "%s - roomquery failed\n", __func__);
-		goto error;
-	}
-	if (rc == 0) {
-		dev_dbg(&port->dev, "%s - roomquery returned 0 bytes\n", __func__);
-		rc = -EIO;
-		goto error;
-	}
-	priv = usb_get_serial_port_data(port);
-	priv->tx_room = *room;
-	priv->tx_throttled = *room ? 0 : 1;
+	priv->tx_room = rc;
+	priv->tx_throttled = rc ? 0 : 1;
 
 	/*Start reading from the device*/
 	rc = usb_submit_urb(port->interrupt_in_urb, GFP_KERNEL);
 	if (rc) {
 		dev_dbg(&port->dev, "%s - usb_submit_urb(read int) failed\n", __func__);
-		goto error;
+		return rc;
 	}
-error:
-	kfree(room);
-	return rc;
+
+	return 0;
 }
+
 static void keyspan_pda_close(struct usb_serial_port *port)
 {
 	struct keyspan_pda_private *priv = usb_get_serial_port_data(port);
-- 
2.53.0

