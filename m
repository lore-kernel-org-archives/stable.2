Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F341A23A6;
	Wed, 10 Jun 2026 13:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781097766; cv=none; b=XwtXWvnQiF0wd6qJ1ZuBQSKzqc2s7FZiATlQSiutnY5ySrSgWEnGC1N9GqTd6bgDYAUauHUPGcsjjXdSfwu3cr43D5ndh4pbHTATDRMtaTU8K/MENf3g4pHPj2i+2h8vrJF8JwsiVFflrz0JPlfw0c9zwC7fo0SJVZdOPaTDw8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781097766; c=relaxed/simple;
	bh=PycbBQPZZyCJCTUuPX2HtE2xWpJSRs0mhK5Sf9MdOXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AIyWxkAKZsXl87325otG3RokhDvgXz+NuDPHNiQd1K/YXGcOqd91kCmTLmErvaO+Zb3Z68LVmhRkJpLtWOoT0r+4JGjeGdsHmReJdpVz4jZj5nRBql9+TMm2SQeyEK2IU+xuedgEMzAenxdPiSClL6Tfi/YzSU1XbrV3XbZXSxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjRop2jP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjRop2jP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720011F0089B;
	Wed, 10 Jun 2026 13:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781097765;
	bh=rQX6i/W4eJ+DvVMiB34BqW0gmYDeIBL0zSWxOy9n1hA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hjRop2jPnh8RXhmQ3XxFcFcEptCROeKd+t0YJkFNjwOwWnIwG3MG+0tcDV/2CCHp8
	 ghVXrc0q87dZKmqvZu+T1CMAEINqSLjqitNIJwo4yGxTbDpq3K/ukShqwhKIzLzKr+
	 YwTX30+ak9FfZlZnU0ey7RE9VN4veIlIMh/05YA+60yjciJpt1A6T45X67lIPZavv4
	 FioMbYz0i7o1Vq1ahZ7KtgFYQkJ54zBc6JT0T/kgAeMZlu6pVzlQpRnxGK9uvGzuuO
	 fSBWbA912sCMOFWeCqbpbKneLlIKOrahs5JKKq6ggC+03qXk93D0luHt3k5We3kd8L
	 iyHScrz+LO9+A==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wXItH-00000001Uez-1Sx3;
	Wed, 10 Jun 2026 15:22:43 +0200
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 01/11] USB: serial: digi_acceleport: fix port registration order
Date: Wed, 10 Jun 2026 15:22:22 +0200
Message-ID: <20260610132232.356139-2-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260610132232.356139-1-johan@kernel.org>
References: <20260610132232.356139-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver submits the read URBs for all ports when the first port is
opened, which could happen before the other ports have been probed and
their private data set up.

If such an URB completes before the port has been probed, the completion
handler will not resubmit it, thus preventing any further reads.

Fix the ordering issue by not submitting the port read URBs until the
port is opened.

This also avoids wasting resources (e.g. power) when ports are not in
use.

Note that the port write URBs are already stopped on close (unless
unbinding, but they are also stopped by core on disconnect).

Fixes: fb44ff854e14 ("USB: digi_acceleport: fix port-data memory leak")
Cc: stable@vger.kernel.org	# 3.7
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/digi_acceleport.c | 43 ++++++++++++++--------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/serial/digi_acceleport.c b/drivers/usb/serial/digi_acceleport.c
index a75813a57fbe..d10d60b5d356 100644
--- a/drivers/usb/serial/digi_acceleport.c
+++ b/drivers/usb/serial/digi_acceleport.c
@@ -1096,6 +1096,13 @@ static int digi_open(struct tty_struct *tty, struct usb_serial_port *port)
 		not_termios.c_iflag = ~tty->termios.c_iflag;
 		digi_set_termios(tty, port, &not_termios);
 	}
+
+	ret = usb_submit_urb(port->read_urb, GFP_KERNEL);
+	if (ret) {
+		dev_err(&port->dev, "failed to submit read urb: %d\n", ret);
+		return ret;
+	}
+
 	return 0;
 }
 
@@ -1107,6 +1114,8 @@ static void digi_close(struct usb_serial_port *port)
 	unsigned char buf[32];
 	struct digi_port *priv = usb_get_serial_port_data(port);
 
+	usb_kill_urb(port->read_urb);
+
 	mutex_lock(&port->serial->disc_mutex);
 	/* if disconnected, just clear flags */
 	if (port->serial->disconnected)
@@ -1169,15 +1178,15 @@ static void digi_close(struct usb_serial_port *port)
 /*
  *  Digi Startup Device
  *
- *  Starts reads on all ports.  Must be called AFTER startup, with
+ *  Starts read on the OOB port.  Must be called AFTER startup, with
  *  urbs initialized.  Returns 0 if successful, non-zero error otherwise.
  */
 
 static int digi_startup_device(struct usb_serial *serial)
 {
-	int i, ret = 0;
 	struct digi_serial *serial_priv = usb_get_serial_data(serial);
-	struct usb_serial_port *port;
+	struct usb_serial_port *oob_port = serial_priv->ds_oob_port;
+	int ret;
 
 	/* be sure this happens exactly once */
 	spin_lock(&serial_priv->ds_serial_lock);
@@ -1188,19 +1197,13 @@ static int digi_startup_device(struct usb_serial *serial)
 	serial_priv->ds_device_started = 1;
 	spin_unlock(&serial_priv->ds_serial_lock);
 
-	/* start reading from each bulk in endpoint for the device */
-	/* set USB_DISABLE_SPD flag for write bulk urbs */
-	for (i = 0; i < serial->type->num_ports + 1; i++) {
-		port = serial->port[i];
-		ret = usb_submit_urb(port->read_urb, GFP_KERNEL);
-		if (ret != 0) {
-			dev_err(&port->dev,
-				"%s: usb_submit_urb failed, ret=%d, port=%d\n",
-				__func__, ret, i);
-			break;
-		}
+	ret = usb_submit_urb(oob_port->read_urb, GFP_KERNEL);
+	if (ret) {
+		dev_err(&serial->interface->dev, "failed to submit OOB read urb: %d\n", ret);
+		return ret;
 	}
-	return ret;
+
+	return 0;
 }
 
 static int digi_port_init(struct usb_serial_port *port, unsigned port_num)
@@ -1252,13 +1255,11 @@ static int digi_startup(struct usb_serial *serial)
 
 static void digi_disconnect(struct usb_serial *serial)
 {
-	int i;
+	struct digi_serial *serial_priv = usb_get_serial_data(serial);
+	struct usb_serial_port *oob_port = serial_priv->ds_oob_port;
 
-	/* stop reads and writes on all ports */
-	for (i = 0; i < serial->type->num_ports + 1; i++) {
-		usb_kill_urb(serial->port[i]->read_urb);
-		usb_kill_urb(serial->port[i]->write_urb);
-	}
+	usb_kill_urb(oob_port->read_urb);
+	usb_kill_urb(oob_port->write_urb);
 }
 
 
-- 
2.53.0

