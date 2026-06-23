Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5613D7D87;
	Tue, 23 Jun 2026 15:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782227348; cv=none; b=kgyMQ0VC3KBb2mTvXMUVh/FVwImASmeYQsGwip/GN6iPpQeMTTbR980siqI2dVftP/Z8DkFpOfUsg7cqGKYCGwE2wu2e6yiE1kzvo7G+UwgU83pjKPj2dKF0YC00zVRws9uP2DwReBCxYnu0FZrUBtbFAZX2ikZdeqEKbM71HYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782227348; c=relaxed/simple;
	bh=LFXVGn0AB4Vc7NNwMwZs07pPOvgfs3WxtWUFk6HZIg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dq9N7xs9ykwel1UIbTKAVi0ChkwwHgLVha0Xmgn64OJUrKM5OxzdUmmeSZ3BmXRKR5zAMVinJ1MsJuGzmoIVcKkijxg7Wk0OZd9DWOibyX6MdYPQkiAAUHA/RjzZxZeVPollc5uk2CLgcykkZPL92TrNVHfFfznvb85LIhqpW+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EN301KBm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EN301KBm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8221E1F00ADE;
	Tue, 23 Jun 2026 15:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782227344;
	bh=DWPE7uMKDwzrRjN7fQifmJYNitpXFckBXF3zqc8Uo30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EN301KBmyR2rwxFGgEpIj98O9eN4wNvyOYmZzGSlCw/qwrrBHArVyTXSnqFrdHM+s
	 0pI6pnXniiyIJ72KFfprihs5q/Jr1y1rLptmCuYzIEPoxEVt7wgRyfoq+pkECXvr4I
	 wvW+sN5c3yv5f5FMthN8ulLIFFVrU3FwvuAdUBmxmnrfTplPG414yFKj1wH6acLd4j
	 jAlH6EjW5n4TXzfSs1HQGqXwHvqstsBiNGQ5UOYw/3LsqY6EuyjX4us0yk4PydOn5f
	 olLMbw5c+AV0XscS/syXuon2DJTab5fVk0kvn3wfX68ra4Vbu/uFDTl3U4PHitLXRI
	 yUpBFlUT4Ft4w==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wc2kI-00000001JuB-1MUW;
	Tue, 23 Jun 2026 17:09:02 +0200
From: Johan Hovold <johan@kernel.org>
To: linux-usb@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 02/12] USB: serial: digi_acceleport: fix port registration order
Date: Tue, 23 Jun 2026 17:08:16 +0200
Message-ID: <20260623150826.314727-3-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623150826.314727-1-johan@kernel.org>
References: <20260623150826.314727-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver submits the read urbs for all ports when the first port is
opened, which could happen before the other ports have been probed and
their private data set up.

If such an urb completes before the port has been probed, the completion
handler will not resubmit it, thus preventing any further reads.

Fix the ordering issue by not submitting the port read urbs until the
port is opened.

This also avoids wasting resources (e.g. power) when ports are not in
use.

Note that the port write urbs are already stopped on close (unless
unbinding, but they are also stopped by core on disconnect).

Fixes: fb44ff854e14 ("USB: digi_acceleport: fix port-data memory leak")
Cc: stable@vger.kernel.org	# 3.7
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/digi_acceleport.c | 48 +++++++++++-----------------
 1 file changed, 19 insertions(+), 29 deletions(-)

diff --git a/drivers/usb/serial/digi_acceleport.c b/drivers/usb/serial/digi_acceleport.c
index 097769525ca4..046cd9d57600 100644
--- a/drivers/usb/serial/digi_acceleport.c
+++ b/drivers/usb/serial/digi_acceleport.c
@@ -1069,7 +1069,6 @@ static int digi_open(struct tty_struct *tty, struct usb_serial_port *port)
 	unsigned char buf[32];
 	struct digi_port *priv = usb_get_serial_port_data(port);
 	struct ktermios not_termios;
-	int throttled;
 
 	/* be sure the device is started up */
 	if (digi_startup_device(port->serial) != 0)
@@ -1099,17 +1098,14 @@ static int digi_open(struct tty_struct *tty, struct usb_serial_port *port)
 	}
 
 	spin_lock_irq(&priv->dp_port_lock);
-	throttled = priv->dp_throttle_restart;
 	priv->dp_throttled = 0;
 	priv->dp_throttle_restart = 0;
 	spin_unlock_irq(&priv->dp_port_lock);
 
-	if (throttled) {
-		ret = usb_submit_urb(port->read_urb, GFP_KERNEL);
-		if (ret) {
-			dev_err(&port->dev, "failed to submit read urb: %d\n", ret);
-			return ret;
-		}
+	ret = usb_submit_urb(port->read_urb, GFP_KERNEL);
+	if (ret) {
+		dev_err(&port->dev, "failed to submit read urb: %d\n", ret);
+		return ret;
 	}
 
 	return 0;
@@ -1123,6 +1119,8 @@ static void digi_close(struct usb_serial_port *port)
 	unsigned char buf[32];
 	struct digi_port *priv = usb_get_serial_port_data(port);
 
+	usb_kill_urb(port->read_urb);
+
 	mutex_lock(&port->serial->disc_mutex);
 	/* if disconnected, just clear flags */
 	if (port->serial->disconnected)
@@ -1185,15 +1183,15 @@ static void digi_close(struct usb_serial_port *port)
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
@@ -1204,19 +1202,13 @@ static int digi_startup_device(struct usb_serial *serial)
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
@@ -1287,13 +1279,11 @@ static int digi_startup(struct usb_serial *serial)
 
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

