Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9630445C6E2
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 16:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785427289; cv=none; b=a4lfJ/4Heu7um5bxNDAnMFSmKwtSSJeu9hox/TkPAb0JTaRo2faDvmOcCYWKnhmceY4VBFfsBdoEeT7nVYoV0/Yg+PCjHUg35+A9qpxu2ZiRGzMaxdD45bI/PkxhuLbExIHXoVhcind1AaiwokadVOSREh36od2gsPtp2fMHHoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785427289; c=relaxed/simple;
	bh=BNhRZxP3+jQcKoA1xOq13S2rqBxyUNOv0hhT2KIlOgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nr9AFV/gRqiwD3A5bi/DdmyOYLx9xQR8WLiZ4wkTHTdry5G+A4B/L9r3HsEX5/dbdeGwHBnoaFpDpoaShzvPqtRpYmpM8ElwJy38wa9rmnUukoCELDMXjbiHUA6okdhfsycmgyB+/Hk82qtf+jKT5M0/M8IGDsjnxu6tmH1IBds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=noQVOKtD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="noQVOKtD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1623A1F000E9;
	Thu, 30 Jul 2026 16:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785427288;
	bh=VuWfY58gfoysBxnVgRwAqaJMB6Q0GezM5tUD3f8eJho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=noQVOKtDVTiSH/BSVo1CXSuHp8mLeo0X1DcG9qLHtapwHn1Wok2PzafnZOAphztoM
	 qRxmwgkGgPEQ3B+H06Gj7WmsHWo6inNNfAhU0fUmeLj0nlOttIoKVoPWq8RqqUX/PJ
	 v+JTLU/dA/KJRqROU6WOL1JoSDsTPR9hFJJA4OTYhoFpwxM4oTOepfEiJAoDaN7RpC
	 EVZqRYDyxxWiSc5xhxna20pWkiZ6kybp46N5GyxuYKqR52j2iZGwjMThpF1aD4dTiP
	 8+m0GDxpD2yKbYk5Ro0EfNojk4aX91LDlQVvx6IJLHBM5a2cbMpT8ewYMBxhtLY8Ub
	 Rx6iGC3f6Ug2A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 5/5] USB: serial: keyspan_pda: fix data loss on receive throttling
Date: Thu, 30 Jul 2026 12:01:22 -0400
Message-ID: <20260730160123.2768188-5-sashal@kernel.org>
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

[ Upstream commit 42a97c0480f96a2977e6d51ce512adc780f1ef5d ]

Killing the interrupt-in urb when the line disciple requests throttling
may lead to data loss if an ongoing transfer is cancelled.

Instead set a flag to prevent the completion handler from resubmitting
the urb until the port is unthrottled.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/serial/keyspan_pda.c | 44 +++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/serial/keyspan_pda.c b/drivers/usb/serial/keyspan_pda.c
index bfc23694a6fe..7141660d5d59 100644
--- a/drivers/usb/serial/keyspan_pda.c
+++ b/drivers/usb/serial/keyspan_pda.c
@@ -47,6 +47,8 @@ struct keyspan_pda_private {
 	struct work_struct	unthrottle_work;
 	struct usb_serial	*serial;
 	struct usb_serial_port	*port;
+	bool			throttled;
+	bool			throttle_req;
 };
 
 static int keyspan_pda_write_start(struct usb_serial_port *port);
@@ -184,6 +186,7 @@ static void keyspan_pda_rx_interrupt(struct urb *urb)
 	int retval;
 	int status = urb->status;
 	struct keyspan_pda_private *priv;
+	bool throttled = false;
 	unsigned long flags;
 
 	priv = usb_get_serial_port_data(port);
@@ -245,16 +248,24 @@ static void keyspan_pda_rx_interrupt(struct urb *urb)
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
@@ -264,16 +275,29 @@ static void keyspan_pda_rx_throttle(struct tty_struct *tty)
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
@@ -609,6 +633,8 @@ static int keyspan_pda_open(struct tty_struct *tty,
 
 	spin_lock_irq(&port->lock);
 	priv->tx_room = rc;
+	priv->throttled = false;
+	priv->throttle_req = false;
 	spin_unlock_irq(&port->lock);
 
 	rc = usb_submit_urb(port->interrupt_in_urb, GFP_KERNEL);
-- 
2.53.0

