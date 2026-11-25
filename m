Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795609429;
	b=Px+6D7W05a8enUH/VCgshoY1r9OrZdlvfIEiIpbPu2bEwDMrzw5x+MjAsrW0sTCYviow
	 TE5+a/TYDvwwU6dQrmm7XYebI/rnH3l++l6yrpsnAMHFA6nBhyrVkPOp7AyZDnBP7GeKi
	 0Kl8ZsyKVkrhAOUAihI8Vwmb1ZoeMfWFHM2z6Wd0GJz7ywkgqY5feDMu2t316127hiw4L
	 SOUoNKxY+ieHlal7ewT9g5JvqdDIUMkmCQTHfFvkisFWJNysv+9OPyDPD5R+UK5EVIHjT
	 8soUt0YLa6K6z0ih6BfRj0FyqeONlqjX3cdZeOHT1NXz4+A/PbREzMrXl2zHeUnZwXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795609429;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xifUfNgYid6Ysp2b3KMr3OiN1rYqSjfCX9D3vmFNDo0=;
	b=B69c8bkO8u/iN90JQEPTEvBb10irnJ+06EsD6ZNfOyNe2Ca5RvWtcZq1DGXZiwsOJyLF
	 XbirKgXPlHubruZvf92So+YCj+H/GoN10ApTm4DXVX7ucv6HCymZYZjH6V0NQYyEXt8eK
	 cLSPuMDEGfw4xEMKGbGPuE2JBTsrGPS6hdCv2S8cP/wmZJyew9YzP4HjF3TaFn8lBCzkL
	 u5HSUyh6u+syFL7PViuCw4A/V9jHFD13su3qTA5zULxwBLKZyNh9WuE7DVys6qsXTI+za
	 ekgVwbadDopTeNR1JR6KPzDi6my0mYFYif6j3QF++z/obPJlVCyyJh2DqeXas8PltqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=q4gSU4Yk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C10606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=q4gSU4Yk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC551F000CF;
	Wed, 25 Nov 2026 12:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795609429;
	bh=xifUfNgYid6Ysp2b3KMr3OiN1rYqSjfCX9D3vmFNDo0=;
	h=Subject:To:Cc:From:Date;
	b=q4gSU4Yk2LIVNWepu7xeT+l36risKNfZf1dC0+eFaeOBRgmmXGz28BPM7vB6PiNoX
	 2yfcz/z40z0eR7R4oYK20dtVLkiftyZDbw+sBzOJwS2ix930vbKubsVFbK1LMvAJKw
	 C537cPAtINyEbwCxDtlH4YDp9DqQRoihnx095wGU=
Subject: FAILED: patch "[PATCH] USB: serial: io_edgeport: move initial termios update to" failed to apply to 5.10-stable tree
To: johan@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 13:17:44 +0100
Message-ID: <2026112543-alright-levers-a3d2@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x febadc65a4ef8d08a12e76d6ec50834d72cc0e59
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112543-alright-levers-a3d2@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From febadc65a4ef8d08a12e76d6ec50834d72cc0e59 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Fri, 23 Oct 2026 14:15:22 +0200
Subject: [PATCH] USB: serial: io_edgeport: move initial termios update to
 open()

Explicitly update the terminal settings on open() instead of doing so
from the interrupt completion handler when receiving an open command
response, which in theory can be received after a failed open attempt.

Note that this will be used to fix a FIFO corruption issue and also
allows for switching to synchronous commands.

Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>

diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
index e8e641e9a197..cdcff02c435b 100644
--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -281,8 +281,7 @@ static void handle_new_lsr(struct edgeport_port *edge_port, __u8 lsrData,
 static int  send_iosp_ext_cmd(struct edgeport_port *edge_port, __u8 command,
 				__u8 param);
 static int  calc_baud_rate_divisor(struct device *dev, int baud_rate, int *divisor);
-static void change_port_settings(struct tty_struct *tty,
-				struct edgeport_port *edge_port,
+static void edge_set_termios(struct tty_struct *tty, struct usb_serial_port *port,
 				const struct ktermios *old_termios);
 static int  send_cmd_write_uart_register(struct edgeport_port *edge_port,
 				__u8 regNum, __u8 regValue);
@@ -923,6 +922,9 @@ static int edge_open(struct tty_struct *tty, struct usb_serial_port *port)
 		return -ENOMEM;
 	}
 
+	if (tty)
+		edge_set_termios(tty, port, NULL);
+
 	spin_lock_irq(&edge_port->ep_lock);
 	edge_port->open = true;
 	spin_unlock_irq(&edge_port->ep_lock);
@@ -1443,30 +1445,6 @@ static void edge_unthrottle(struct tty_struct *tty)
 }
 
 
-/*****************************************************************************
- * SerialSetTermios
- *	this function is called by the tty driver when it wants to change
- * the termios structure
- *****************************************************************************/
-static void edge_set_termios(struct tty_struct *tty,
-			     struct usb_serial_port *port,
-			     const struct ktermios *old_termios)
-{
-	struct edgeport_port *edge_port = usb_get_serial_port_data(port);
-
-	if (edge_port == NULL)
-		return;
-
-	if (!edge_port->open) {
-		dev_dbg(&port->dev, "%s - port not opened\n", __func__);
-		return;
-	}
-
-	/* change the port settings to the new ones specified */
-	change_port_settings(tty, edge_port, old_termios);
-}
-
-
 /*****************************************************************************
  * get_lsr_info - get line status register info
  *
@@ -1756,7 +1734,6 @@ static void process_rcvd_status(struct edgeport_serial *edge_serial,
 {
 	struct usb_serial_port *port;
 	struct edgeport_port *edge_port;
-	struct tty_struct *tty;
 	struct device *dev;
 	__u8 code = edge_serial->rxStatusCode;
 
@@ -1808,15 +1785,6 @@ static void process_rcvd_status(struct edgeport_serial *edge_serial,
 			__func__, edge_serial->rxPort, byte2, edge_port->txCredits);
 		handle_new_msr(edge_port, byte2);
 
-		/* send the current line settings to the port so we are
-		   in sync with any further termios calls */
-		tty = tty_port_tty_get(&edge_port->port->port);
-		if (tty) {
-			change_port_settings(tty,
-				edge_port, &tty->termios);
-			tty_kref_put(tty);
-		}
-
 		/* we have completed the open */
 		edge_port->openPending = false;
 		wake_up(&edge_port->wait_open);
@@ -2328,18 +2296,12 @@ static int send_cmd_write_uart_register(struct edgeport_port *edge_port,
 }
 
 
-/*****************************************************************************
- * change_port_settings
- *	This routine is called to set the UART on the device to match the
- *	specified new settings.
- *****************************************************************************/
-
-static void change_port_settings(struct tty_struct *tty,
-	struct edgeport_port *edge_port, const struct ktermios *old_termios)
+static void edge_set_termios(struct tty_struct *tty, struct usb_serial_port *port,
+		const struct ktermios *old_termios)
 {
-	struct device *dev = &edge_port->port->dev;
-	struct edgeport_serial *edge_serial =
-			usb_get_serial_data(edge_port->port->serial);
+	struct edgeport_serial *edge_serial = usb_get_serial_data(port->serial);
+	struct edgeport_port *edge_port = usb_get_serial_port_data(port);
+	struct device *dev = &port->dev;
 	int baud;
 	unsigned cflag;
 	__u8 mask = 0xff;
@@ -2350,12 +2312,6 @@ static void change_port_settings(struct tty_struct *tty,
 	__u8 txFlow;
 	int status;
 
-	if (!edge_port->open &&
-	    !edge_port->openPending) {
-		dev_dbg(dev, "%s - port not opened\n", __func__);
-		return;
-	}
-
 	cflag = tty->termios.c_cflag;
 
 	switch (cflag & CSIZE) {
@@ -2489,7 +2445,7 @@ static void change_port_settings(struct tty_struct *tty,
 
 	dev_dbg(dev, "%s - baud rate = %d\n", __func__, baud);
 	status = send_cmd_write_baud_rate(edge_port, baud);
-	if (status == -1) {
+	if (status == -1 && old_termios) {
 		/* Speed change was not possible - put back the old speed */
 		baud = tty_termios_baud_rate(old_termios);
 		tty_encode_baud_rate(tty, baud, baud);

