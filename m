Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153AA1632DD;
	Wed,  8 Jul 2026 14:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783521146; cv=none; b=XAiEt5mQKfTPJ8+WPVc2j9vlK6oLvwk3zIbOelaFkbuxSE0iIUPNYgogNoQmMqzDcDpyJLlp6TBEO8YpByQ8t2l/m7JF4kcyyUf/m4zw6UUPsJlPw/BykW+us/KNNrKJ0iTYhk5rWUCpdx8aSg9xeliiJPdwO3MT+lnaGb0wHUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783521146; c=relaxed/simple;
	bh=U9w3vBbUFtCRr7V74TjBeG0Ub0+BiHRRY3xEHPSW6Gc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uxg9G9EQBIeUrZFRfZZSKvWYMd8mbEHavvSRJPefIBKnzu3GGj5YhyT7IGWKWeH1zFsP/rMfdRMrhb4glahho2QuU6Bi9MNjFYgBc1ko6remJYebhRdiTnBgIwLq3odrunzJvgl4hSFoI7JjR1AkE+rjcaPu9xK2ohV9l20p4C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLXWU18v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLXWU18v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B741F000E9;
	Wed,  8 Jul 2026 14:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783521144;
	bh=AcGbi6GcbL2Ly4SptMLqyaUlu9is1dK/XOQRRPvfuiw=;
	h=From:To:Cc:Subject:Date;
	b=VLXWU18vLVxb9NdenyOP9B3ro6bILYXuZF4ps9Sdp9fV4AYWb2I6Rr9x5jPrsjE6S
	 FDQ4BNwnFWOgAlJX6GrjU7YVZ1HoXuB+nwBybG9cOcRfYAb4f9KocxhztU3t1hDiJM
	 0nCrZ+cBCYmKZPLNlBFPriSmIipgvCKcXLn9ljC2xuT3tjAD9uJHVvFvdJZczWUf8+
	 2yueX95IDJD0WGr2llm6MxvlLdWIuNNmyP4XSFbHV+L+NBUS/zb3GCRNIzG6T84pUs
	 svRbC/EWxTKTFQEdtRk+cSTzf0Rq/UaqIQDcy31x67pj/B2bMAeVKYhakd8eI7NMEN
	 sSVlIUBoJcTNw==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1whTK2-000000036EZ-1uZR;
	Wed, 08 Jul 2026 16:32:22 +0200
From: Johan Hovold <johan@kernel.org>
To: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] USB: serial: keyspan_pda: fix data loss on receive throttling
Date: Wed,  8 Jul 2026 16:31:35 +0200
Message-ID: <20260708143135.738899-1-johan@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Killing the interrupt-in urb when the line disciple requests throttling
may lead to data loss if an ongoing transfer is cancelled.

Instead set a flag to prevent the completion handler from resubmitting
the urb until the port is unthrottled.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/keyspan_pda.c | 44 +++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/serial/keyspan_pda.c b/drivers/usb/serial/keyspan_pda.c
index f05bcce60600..dd4cfd17f7ad 100644
--- a/drivers/usb/serial/keyspan_pda.c
+++ b/drivers/usb/serial/keyspan_pda.c
@@ -33,6 +33,8 @@ struct keyspan_pda_private {
 	struct work_struct	unthrottle_work;
 	struct usb_serial	*serial;
 	struct usb_serial_port	*port;
+	bool			throttled;
+	bool			throttle_req;
 };
 
 static int keyspan_pda_write_start(struct usb_serial_port *port);
@@ -148,6 +150,7 @@ static void keyspan_pda_rx_interrupt(struct urb *urb)
 	int retval;
 	int status = urb->status;
 	struct keyspan_pda_private *priv;
+	bool throttled = false;
 	unsigned long flags;
 
 	priv = usb_get_serial_port_data(port);
@@ -209,16 +212,24 @@ static void keyspan_pda_rx_interrupt(struct urb *urb)
 	}
 
 exit:
-	retval = usb_submit_urb(urb, GFP_ATOMIC);
-	if (retval)
-		dev_err(&port->dev,
-			"%s - usb_submit_urb failed with result %d\n",
-			__func__, retval);
+	spin_lock_irqsave(&port->lock, flags);
+	if (priv->throttle_req) {
+		priv->throttled = true;
+		throttled = true;
+	}
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	if (!throttled) {
+		retval = usb_submit_urb(urb, GFP_ATOMIC);
+		if (retval)
+			dev_err(&port->dev, "failed to resubmit in urb: %d\n", retval);
+	}
 }
 
 static void keyspan_pda_rx_throttle(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
+	struct keyspan_pda_private *priv = usb_get_serial_port_data(port);
 
 	/*
 	 * Stop receiving characters. We just turn off the URB request, and
@@ -228,16 +239,29 @@ static void keyspan_pda_rx_throttle(struct tty_struct *tty)
 	 * send an XOFF, although it might make sense to foist that off upon
 	 * the device too.
 	 */
-	usb_kill_urb(port->interrupt_in_urb);
+	spin_lock_irq(&port->lock);
+	priv->throttle_req = true;
+	spin_unlock_irq(&port->lock);
 }
 
 static void keyspan_pda_rx_unthrottle(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
+	struct keyspan_pda_private *priv = usb_get_serial_port_data(port);
+	bool throttled;
+	int ret;
 
-	/* just restart the receive interrupt URB */
-	if (usb_submit_urb(port->interrupt_in_urb, GFP_KERNEL))
-		dev_dbg(&port->dev, "usb_submit_urb(read urb) failed\n");
+	spin_lock_irq(&port->lock);
+	throttled = priv->throttled;
+	priv->throttled = false;
+	priv->throttle_req = false;
+	spin_unlock_irq(&port->lock);
+
+	if (throttled) {
+		ret = usb_submit_urb(port->interrupt_in_urb, GFP_KERNEL);
+		if (ret)
+			dev_err(&port->dev, "failed to submit in urb: %d\n", ret);
+	}
 }
 
 static speed_t keyspan_pda_setbaud(struct usb_serial *serial, speed_t baud)
@@ -577,6 +601,8 @@ static int keyspan_pda_open(struct tty_struct *tty,
 
 	spin_lock_irq(&port->lock);
 	priv->tx_room = rc;
+	priv->throttled = false;
+	priv->throttle_req = false;
 	spin_unlock_irq(&port->lock);
 
 	rc = usb_submit_urb(port->interrupt_in_urb, GFP_KERNEL);
-- 
2.54.0

