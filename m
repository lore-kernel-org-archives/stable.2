Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792757817;
	b=qw+WjgIoR9dL56eVOnXZolrc2TgOZSw200EHL2+IHg25tz/z/p+E5dfHkDSU0kowcdZI
	 WsWNKiLOWzRd7VW/+//VDprE8FPxxa3zTvAcK092lLCS5QeeqFzTI5HEuSErHgn+k+1Pm
	 +9a62Ky3fKy4fJHNB6LhuHqpYkdB99oeCCxFnrMf1ClinBpuYHFVg5y/9fDnrtQiytdK7
	 yDgimInSiYS36QJJcoa+akc9dxX6pZ9xKvrIhZKNUTBjk/7RpVmR2QFd1nZm8ou77i35r
	 rjq94iFbx0Wr0xybHZ5UrObk+FWhUcjySIyFk0WKqTCKJO/6LD68Ay0q/CoBxy5mnqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792757817;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SVSuqNFXRzJdweZbIl5CgsES0sa6BwC26/iLpu01XDc=;
	b=4A8VOajJcSbsjZ0Ztkpb+O3aft+Ef/dX/T2mhUSYh2qGwXmBlGlZg6HqPfH2dZJBGp2d
	 g2Tj1NnKNP8M0QoH2xDLpLRUXM5E1BOMrCxVrxb1NIPwwWnXrkNbSnxM4QwaZEQIXqZV6
	 1N9ONO6goPDUfdtu/4+SdeKHY96ZX2fgIHoE5FWqfV632kCzA1D+gVN52YFO7mDvobDcO
	 Wbb0fYHjmTyoZHPqnSIm5Cq1lF6zTZyCjOZOFxarH9quejf31GFgpaMQjIaL69EfzwZCE
	 3kjVlJLAqLC/DbW8X9k2XbcsxdCxWOIA7/wp2HaASuVWLUjsGI8PSlGZmiW28ZJru7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=azrCbsaN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF633606A339;
	Fri, 23 Oct 2026 12:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=azrCbsaN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755F41F031ED;
	Fri, 23 Oct 2026 12:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792757815;
	bh=SVSuqNFXRzJdweZbIl5CgsES0sa6BwC26/iLpu01XDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=azrCbsaNTWuQVVNAWBA2awP+DuvLZ8zqr2ln9EaFXoQhg+MptU5BGWZrlsB8owUx+
	 OBxQgZ8N7khoxTyA77wEKgdBTLXRHB69sKdrHE2PB9P3OyPsLewrB+EcAmrvl8M/Lq
	 KOBgfMwg6ZyZ5O2KRVECtLA9qxHeBiSQcc+3tbW9W8mQSgYPpUre9SJhRakDjkHsJH
	 R5+agskh1TtOZLYstizIpHr4l747eJaQzuGse9gyrRQQgZ7H2RFGzj/rdEla5qygQo
	 LSkzwLw5QXUBy6HoOzyP3s64TojmDqvUB9ceMjkII9G7w+9g0Txg1LLRzMvGYDbbIt
	 ZgdeKSexbsCSQ==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xKECb-00000000mZU-0SqV;
	Fri, 23 Oct 2026 14:16:53 +0200
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 04/12] USB: serial: io_edgeport: move initial termios update to open()
Date: Fri, 23 Oct 2026 14:15:22 +0200
Message-ID: <20261023121530.186541-5-johan@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023121530.186541-1-johan@kernel.org>
References: <20261023121530.186541-1-johan@kernel.org>
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

Explicitly update the terminal settings on open() instead of doing so
from the interrupt completion handler when receiving an open command
response, which in theory can be received after a failed open attempt.

Note that this will be used to fix a FIFO corruption issue and also
allows for switching to synchronous commands.

Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/io_edgeport.c | 64 +++++---------------------------
 1 file changed, 10 insertions(+), 54 deletions(-)

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
-- 
2.55.0

