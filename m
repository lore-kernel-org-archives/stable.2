Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795712933;
	b=hCLwrUV0n5h8H0WW0CdUZi2TOLm/3EZ73x/RotbD/9fwiE8b2yJJg351jsBXGnfXl6ri
	 e93BpddrRXV9BP/IPF2MPR3+40nszchpaSxCQybRx78kq3kJzQ/kxmkUEKJi1lKsf6en+
	 KnS3O2YDcLSBMMO1P0bNU9S6SDQZ2HjMpz5nLPmrfuoSFymZMYGlzQQgr8sPfCvXO0IR6
	 UYQeWU0OSH8eSHgK9SJvwHHErmdyZpHU7Yrey0MlQ+8sFBiMT5SNde4mP6/E5KXgKUd7/
	 ID3V0YssifXbs+u1c3yFqZVJlDuKT9JD2EObtfnIau/ODj7o7MwZhTco7sXMsYSj9AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795712933;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JpXFePBpnJsaKYzXtk8NszNEhZsxWr+Kr3f+euyMIgc=;
	b=GBf3rmSytdws1aEcNjVGdOzVwSnt3cishKFd6SOOF7QtDEzZseCB2sGIgjiTzWdPrkXz
	 k6iOHjdRf9UVzU7Z++H4CeUQOzPyAdMKmjhWWlss1VVEMo8icfClxt534gB1RsEgQRbqx
	 SRZWPXyu15PKOw8GN9iWpd/I1H/I2V5dwbXvJY9D4WFUq/oyRqSPWpmTqUT69gt99m4gV
	 yr57wc7bOHTywWorGjkbA3EzdBqZOIJZk7Q7P3u253yYkVPEWv9B4iwI1KgmxmzB5Q/8l
	 c22hNYAAevpcr+y2h0IibjKOuhhzM/UZHP5D4RREqPhjcpAQmE2rAyGAEIxx5WfAVag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O+y9xG0r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F3B606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 17:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O+y9xG0r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B3F1F000D2;
	Thu, 26 Nov 2026 17:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795712932;
	bh=JpXFePBpnJsaKYzXtk8NszNEhZsxWr+Kr3f+euyMIgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O+y9xG0r2ICCm3b/9IqfUNWBELeob/1Y1WfjpDI9IUenCugXdWWe+M3jCEx5ycY3i
	 7xpmPlrUM5KJTU7NDmGRejMrFdXKalZETkVKq4teckycmBhs0VpVT/u7g8cFDofciR
	 Hkx7USJ4gxofn64D486lwE6HIEZAU76dAjrXlQXdpvguJ+I+KMXb2zvcIPbw8XpDHI
	 j0TThfhYa+WiZgTF1GbJLzuR+2HpxNyVIk9GpXgH7Va0nZ5jY1D4r1b9zopmTgI0SM
	 NZ6LNGpH3CDcgmmrSq1efwovluVwI5rt3DKLfFG4LP3jHwlF/wStOwcQSKFnb3ykxK
	 bnisCCVlUrfTg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] USB: serial: io_edgeport: move initial termios update to open()
Date: Thu, 26 Nov 2026 12:08:51 -0500
Message-ID: <20261126170836.2685524-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112543-alright-levers-a3d2@gregkh>
References: <2026112543-alright-levers-a3d2@gregkh>
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
[ sashal: Changed struct ktermios *old_termios to non-const to match the older set_termios ops signature, and dropped the extra edge_set_termios() prototype since one already exists. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/serial/io_edgeport.c | 63 +++++---------------------------
 1 file changed, 9 insertions(+), 54 deletions(-)

diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
index 1cedc108a47cc..a9ff844697638 100644
--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -312,9 +312,6 @@ static int  send_iosp_ext_cmd(struct edgeport_port *edge_port, __u8 command,
 static int  calc_baud_rate_divisor(struct device *dev, int baud_rate, int *divisor);
 static int  send_cmd_write_baud_rate(struct edgeport_port *edge_port,
 				int baudRate);
-static void change_port_settings(struct tty_struct *tty,
-				struct edgeport_port *edge_port,
-				struct ktermios *old_termios);
 static int  send_cmd_write_uart_register(struct edgeport_port *edge_port,
 				__u8 regNum, __u8 regValue);
 static int  write_cmd_usb(struct edgeport_port *edge_port,
@@ -1000,6 +997,9 @@ static int edge_open(struct tty_struct *tty, struct usb_serial_port *port)
 		return -ENOMEM;
 	}
 
+	if (tty)
+		edge_set_termios(tty, port, NULL);
+
 	spin_lock_irq(&edge_port->ep_lock);
 	edge_port->open = true;
 	spin_unlock_irq(&edge_port->ep_lock);
@@ -1549,29 +1549,6 @@ static void edge_unthrottle(struct tty_struct *tty)
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
@@ -1881,7 +1858,6 @@ static void process_rcvd_status(struct edgeport_serial *edge_serial,
 {
 	struct usb_serial_port *port;
 	struct edgeport_port *edge_port;
-	struct tty_struct *tty;
 	struct device *dev;
 	__u8 code = edge_serial->rxStatusCode;
 	unsigned long flags;
@@ -1940,15 +1916,6 @@ static void process_rcvd_status(struct edgeport_serial *edge_serial,
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
@@ -2459,18 +2426,12 @@ static int send_cmd_write_uart_register(struct edgeport_port *edge_port,
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
@@ -2481,12 +2442,6 @@ static void change_port_settings(struct tty_struct *tty,
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
@@ -2622,7 +2577,7 @@ static void change_port_settings(struct tty_struct *tty,
 
 	dev_dbg(dev, "%s - baud rate = %d\n", __func__, baud);
 	status = send_cmd_write_baud_rate(edge_port, baud);
-	if (status == -1) {
+	if (status == -1 && old_termios) {
 		/* Speed change was not possible - put back the old speed */
 		baud = tty_termios_baud_rate(old_termios);
 		tty_encode_baud_rate(tty, baud, baud);
-- 
2.53.0

