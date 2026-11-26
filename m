Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795711962;
	b=T531sAxdzfx3KKUrE/HwXbu16eaG+EsIH8rKY+VNHOPSqcgQcydH3EKU/ygelmtXCfCU
	 rYgqBJKRILPw463kOgG+tGhBn1eK+bY6RpdtBPMuX+V21Q4j0O2jYTWzvLKwAg7of3A/T
	 r80z05/3HO16wcmK7FgR6mEQbfouMey9nQLavOHeDE+iQmVIjMcb6Jasnogk8xOD4i9TF
	 FnnpV54CTyRiQU8GRpQAIOJVhkrOwrNaSs6nb6iPZwCWg6bix7EM99t2dFQtMvLC7XmQN
	 H2uRWihvtLe1nzcsuuSuiyIL3KI0oLlJfNU1VDMf3T2v1ZB7AV93jWn3EGIVL0/1I3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795711962;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WXgiRd7p3GgvBS1rUE/KkvRzg/YV0dvHl55eN2fBa+0=;
	b=Q4sgQ8/gSs8mfvp4pIdMb+tfBhxmUPBpvXJSws76SLxUIzQpAsWn0WizfBzGFPYKuu35
	 v3JvXEC4TqT973WC4PIejV5LeQbY5+2fSC+OjZAc+cjBDvHSUJn7OIr/2l1jm0WtQU8jr
	 WUdeY7YfbXiJJ+Yi23CHFMYYtZnAIXiUPargs7Xx921b+77ou5AIsBKWt7QH4/dgKErTl
	 9aX19YcA9wp97UF2PkiKAnE267wQy9EHHnoW9SLUTZlxai0uPxFpbsctWX+iPIa52uuP1
	 i+Hxag0C4TChHvcyb8ehD9AluNoq7s0v+ABMwQmFSRmEGovdh9ZXUTvqVgj+gtrumxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D4UqUWsF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825D4606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D4UqUWsF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3A11F000C0;
	Thu, 26 Nov 2026 16:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795711962;
	bh=WXgiRd7p3GgvBS1rUE/KkvRzg/YV0dvHl55eN2fBa+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D4UqUWsFcwjiGI3ru//7LQiU6APfxDunnhEyMx8Dhp/jLp5Ro0m8rbUsbJ0K0OIa6
	 oN5usUFfUf9QNLth7La5IW7L5NVB50AV5wRqWBSiHzeg3/8EsGLJaYiJ2rKaXUDiu6
	 /W5Q4qwcbbKiK4BG0I9XAuEySoC66J7KeDhdhoWjVFcC8iDd+skvbLAJI1xRg5NTM5
	 pNYPMno1WgDjmq0H1cZd3QXYJXfupRjtIY/9CHdl0QlrgHaME3BbY3ZwBFipVYZSLn
	 Iih8Fqv0lhSyy7K0y9LzaVeb7yaa5KQ/dUEu9CnSvAupV5nuyuCDviCaXia+ak5Lge
	 rG21ZP/lsXtQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] USB: serial: io_edgeport: move initial termios update to open()
Date: Thu, 26 Nov 2026 11:52:40 -0500
Message-ID: <20261126165226.2630796-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112543-possible-impish-f0e1@gregkh>
References: <2026112543-possible-impish-f0e1@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit febadc65a4ef8d08a12e76d6ec50834d72cc0e59 ]

Explicitly update the terminal settings on open() instead of doing so
from the interrupt completion handler when receiving an open command
response, which in theory can be received after a failed open attempt.

Note that this will be used to fix a FIFO corruption issue and also
allows for switching to synchronous commands.

Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
[ sashal: Dropped const from the old_termios parameter of edge_set_termios() (prototype and definition) to match this tree's non-const set_termios callback; the rest matches upstream. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/serial/io_edgeport.c | 63 +++++---------------------------
 1 file changed, 10 insertions(+), 53 deletions(-)

diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
index 4ec2ae2165803..03b51d2f9bf64 100644
--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -280,8 +280,7 @@ static void handle_new_lsr(struct edgeport_port *edge_port, __u8 lsrData,
 static int  send_iosp_ext_cmd(struct edgeport_port *edge_port, __u8 command,
 				__u8 param);
 static int  calc_baud_rate_divisor(struct device *dev, int baud_rate, int *divisor);
-static void change_port_settings(struct tty_struct *tty,
-				struct edgeport_port *edge_port,
+static void edge_set_termios(struct tty_struct *tty, struct usb_serial_port *port,
 				struct ktermios *old_termios);
 static int  send_cmd_write_uart_register(struct edgeport_port *edge_port,
 				__u8 regNum, __u8 regValue);
@@ -924,6 +923,9 @@ static int edge_open(struct tty_struct *tty, struct usb_serial_port *port)
 		return -ENOMEM;
 	}
 
+	if (tty)
+		edge_set_termios(tty, port, NULL);
+
 	spin_lock_irq(&edge_port->ep_lock);
 	edge_port->open = true;
 	spin_unlock_irq(&edge_port->ep_lock);
@@ -1448,29 +1450,6 @@ static void edge_unthrottle(struct tty_struct *tty)
 }
 
 
-/*****************************************************************************
- * SerialSetTermios
- *	this function is called by the tty driver when it wants to change
- * the termios structure
- *****************************************************************************/
-static void edge_set_termios(struct tty_struct *tty,
-	struct usb_serial_port *port, struct ktermios *old_termios)
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
@@ -1762,7 +1741,6 @@ static void process_rcvd_status(struct edgeport_serial *edge_serial,
 {
 	struct usb_serial_port *port;
 	struct edgeport_port *edge_port;
-	struct tty_struct *tty;
 	struct device *dev;
 	__u8 code = edge_serial->rxStatusCode;
 	unsigned long flags;
@@ -1821,15 +1799,6 @@ static void process_rcvd_status(struct edgeport_serial *edge_serial,
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
 		spin_unlock_irqrestore(&edge_port->ep_lock, flags);
@@ -2340,18 +2309,12 @@ static int send_cmd_write_uart_register(struct edgeport_port *edge_port,
 }
 
 
-/*****************************************************************************
- * change_port_settings
- *	This routine is called to set the UART on the device to match the
- *	specified new settings.
- *****************************************************************************/
-
-static void change_port_settings(struct tty_struct *tty,
-	struct edgeport_port *edge_port, struct ktermios *old_termios)
+static void edge_set_termios(struct tty_struct *tty, struct usb_serial_port *port,
+		struct ktermios *old_termios)
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
@@ -2362,12 +2325,6 @@ static void change_port_settings(struct tty_struct *tty,
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
@@ -2503,7 +2460,7 @@ static void change_port_settings(struct tty_struct *tty,
 
 	dev_dbg(dev, "%s - baud rate = %d\n", __func__, baud);
 	status = send_cmd_write_baud_rate(edge_port, baud);
-	if (status == -1) {
+	if (status == -1 && old_termios) {
 		/* Speed change was not possible - put back the old speed */
 		baud = tty_termios_baud_rate(old_termios);
 		tty_encode_baud_rate(tty, baud, baud);
-- 
2.53.0

