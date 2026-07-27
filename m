Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B7C41D21A
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 13:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159130; cv=none; b=EmHZ4bsl/1lLlKjoCqjxpd1h3Zn6MEE2iDkI82u2mLuEXb1QG1MfUOjbGm3BPllpZVWjTpimqaWtlTBeTMDLKT3r/qq6Q0wiwmmKDXfmUTGTHUcjDxI1GQwCcN4jImxCqoO13ve0dfFY9kKHkvm9s/wkvwWqUTcqyLVljtEYyOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159130; c=relaxed/simple;
	bh=N5t64hA85F0y1IkKCpjhwIt3r+2/j8zJ446YL0xMBBc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Nq9oWFO1/8eFHhkyDTmzj/VH3zucZHpGMEhLpDKlGL7iuMjC5HVwiTknRhOyj7xUXBGln0RdQuwxWvszxRCZJPjQtP1t8tcWZSatQ3Qonw0cErdr0qTExSXwySil7zjOr9xQoYZBK8EwtmT2jRHq3xQAPno9VdOgmFGNu5MlSTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FpXNLrTd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FpXNLrTd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA881F000E9;
	Mon, 27 Jul 2026 13:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785159129;
	bh=KhXhsBk6Pi+UBRtI4M3FaTrFxjkPgm0HoJMhUNMuIxw=;
	h=Subject:To:Cc:From:Date;
	b=FpXNLrTdm6uWCyzUWLCYKrFNoaXfeLa8fuUUyRmrFcCqwi3FPCEN6cYkUemPxd7Zj
	 4UYh4pKhm3xbWksJc0LrbRu5DvxWZjyKs/0yNFtQyWdFvDlgkqQBE9EgTPneRECmQG
	 2nR+HxdFPwxKl5n+D5le50GMxyw3p6bfK5+ME404=
Subject: FAILED: patch "[PATCH] USB: serial: keyspan_pda: fix data loss on receive throttling" failed to apply to 5.10-stable tree
To: johan@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 27 Jul 2026 15:31:56 +0200
Message-ID: <2026072756-mountain-living-62e9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 42a97c0480f96a2977e6d51ce512adc780f1ef5d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072756-mountain-living-62e9@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 42a97c0480f96a2977e6d51ce512adc780f1ef5d Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Wed, 8 Jul 2026 16:31:35 +0200
Subject: [PATCH] USB: serial: keyspan_pda: fix data loss on receive throttling

Killing the interrupt-in urb when the line disciple requests throttling
may lead to data loss if an ongoing transfer is cancelled.

Instead set a flag to prevent the completion handler from resubmitting
the urb until the port is unthrottled.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>

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

