Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792592152;
	b=SMf+Rppxv/JnOD8cnVP4nMWNOzHRsv7Hi8ugPJnmIGeR4dejK6hVU5XmPepA+r0AhTHO
	 yx2p7Va7+NetN1VSemV86JqwdSCedu9LZ2kKQgvkvLDv0XsFPsUl3ay5sweKpixtnpRU2
	 eVimBRX7mp6h7y1dBbUGoOydf0wWuyMz9Eb+AjTAQMm7TpynA3iyL5D2q06OR7qn1HEd/
	 UDdRCsQx3RuVZtghsWXPMnJQ/k5P+gdJFU2QXAPIeGwNa6lW1Lkpt4Bn+L/iXYvhaN+8E
	 x3GOyxBs1sm03yZdZZUBZW8Tm2qccxCX6i39B+Npca4lxiafVkSOluLTD8vfEbBQfHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792592152;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZJbe5cYVO4U8yxqaxqVg8A5xUiWt5CTFjIdnbaBCgEE=;
	b=S/UgS17AeBfTtdqTm7Dy1krNJVHUion5Q0jaZh3FcHLQjgoWMr2SRtfzNbW3UsoQ4sOq
	 4GkYvV0HalZz+pdg+xCxnTMM3j27ZiNA/RQZSgPto4xn/bk63gLO5HNuxAG9pyiUyHEqA
	 bPAdmjPBLNDZZz+pqO4f3ljQ4TdnP4s7u1rB2tXXeLS3fp5f8gvE4QhNUVQG0Trl1AYPi
	 oRMFGVpgXcATysGy12dfvkExkKPud7GRgvQj5Oj4dzRrg96rBL0w7C1u1GhBacSEed4o/
	 AuvLi242LzRX3TZNShbVn0y/nk9mebzfWQzYd6dmR6bUfPfPv+G8NpqMhAi6DJORDaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hKYJGIEL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD41F606A324;
	Wed, 21 Oct 2026 14:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hKYJGIEL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191241F000C9;
	Wed, 21 Oct 2026 14:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792592150;
	bh=ZJbe5cYVO4U8yxqaxqVg8A5xUiWt5CTFjIdnbaBCgEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hKYJGIELBZx9wGdlcYcgeqn4LT5N5jSuC5j+Nr5xWJhy6Rguinkk9J8enSnBiiDhp
	 J2La8lW11HILqZzH1XenPHHqbKl4EVvpVvcEemUt2d5VEQ6KMwewm6+YFFrOaORF6X
	 1msnL87ZwuxwsnXiFhV/WZnNt8bl3ZhUS+MTtJ00zv6QX3r3QMUXmfICWubdAbhHUz
	 7lzfX5VE07G95L8hqU7XR4CqyNwc6G5IyEcZrgZQSWp1Oe/uIOEDvfp8+f1bBIYKMS
	 YQe6GCouglS6DlReLwlIwJUML+7mqcLg8lCBt3EwODNUwC37FvCBdmYBTvUWE9JxI9
	 O/tjby5bvO14w==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xJX6Z-00000009kqH-2TIh;
	Wed, 21 Oct 2026 16:15:47 +0200
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 05/11] USB: serial: io_edgeport: serialise MCR accesses
Date: Wed, 21 Oct 2026 16:11:48 +0200
Message-ID: <20261021141154.2324793-6-johan@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261021141154.2324793-1-johan@kernel.org>
References: <20261021141154.2324793-1-johan@kernel.org>
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

Add a mutex to serialise modem control register updates to prevent
concurrent tasks from interfering with each other.

Note that the register updates are currently asynchronous so a task may
read back a value which has not yet taken effect.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/io_edgeport.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
index 38f58ca115eb..0b50c6b99b0a 100644
--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -168,6 +168,7 @@ struct edgeport_port {
 	struct urb		*write_urb;		/* write URB for this port */
 	bool			write_in_progress;	/* 'true' while a write URB is outstanding */
 	spinlock_t		ep_lock;
+	struct mutex		mutex;
 
 	__u8			shadowLCR;		/* last LCR value received */
 	__u8			shadowMCR;		/* last MCR value received */
@@ -884,7 +885,10 @@ static int edge_open(struct tty_struct *tty, struct usb_serial_port *port)
 	spin_unlock_irq(&edge_port->ep_lock);
 
 	/* Must always set this bit to enable ints! */
+	mutex_lock(&edge_port->mutex);
 	edge_port->shadowMCR = MCR_MASTER_IE;
+	mutex_unlock(&edge_port->mutex);
+
 	edge_port->chaseResponsePending = false;
 
 	/* send a open port command */
@@ -1397,9 +1401,11 @@ static void edge_throttle(struct tty_struct *tty)
 
 	/* if we are implementing RTS/CTS, toggle that line */
 	if (C_CRTSCTS(tty)) {
+		mutex_lock(&edge_port->mutex);
 		edge_port->shadowMCR &= ~MCR_RTS;
 		status = send_cmd_write_uart_register(edge_port, MCR,
 							edge_port->shadowMCR);
+		mutex_unlock(&edge_port->mutex);
 		if (status != 0)
 			return;
 	}
@@ -1434,9 +1440,11 @@ static void edge_unthrottle(struct tty_struct *tty)
 	}
 	/* if we are implementing RTS/CTS, toggle that line */
 	if (C_CRTSCTS(tty)) {
+		mutex_lock(&edge_port->mutex);
 		edge_port->shadowMCR |= MCR_RTS;
 		send_cmd_write_uart_register(edge_port, MCR,
 						edge_port->shadowMCR);
+		mutex_unlock(&edge_port->mutex);
 	}
 }
 
@@ -1501,6 +1509,7 @@ static int edge_tiocmset(struct tty_struct *tty,
 	struct edgeport_port *edge_port = usb_get_serial_port_data(port);
 	unsigned int mcr;
 
+	mutex_lock(&edge_port->mutex);
 	mcr = edge_port->shadowMCR;
 	if (set & TIOCM_RTS)
 		mcr |= MCR_RTS;
@@ -1519,6 +1528,7 @@ static int edge_tiocmset(struct tty_struct *tty,
 	edge_port->shadowMCR = mcr;
 
 	send_cmd_write_uart_register(edge_port, MCR, edge_port->shadowMCR);
+	mutex_unlock(&edge_port->mutex);
 
 	return 0;
 }
@@ -1532,6 +1542,7 @@ static int edge_tiocmget(struct tty_struct *tty)
 	unsigned int mcr;
 
 	msr = edge_port->shadowMSR;
+	mutex_lock(&edge_port->mutex);
 	mcr = edge_port->shadowMCR;
 	result = ((mcr & MCR_DTR)	? TIOCM_DTR: 0)	  /* 0x002 */
 		  | ((mcr & MCR_RTS)	? TIOCM_RTS: 0)   /* 0x004 */
@@ -1539,6 +1550,7 @@ static int edge_tiocmget(struct tty_struct *tty)
 		  | ((msr & EDGEPORT_MSR_CD)	? TIOCM_CAR: 0)   /* 0x040 */
 		  | ((msr & EDGEPORT_MSR_RI)	? TIOCM_RI:  0)   /* 0x080 */
 		  | ((msr & EDGEPORT_MSR_DSR)	? TIOCM_DSR: 0);  /* 0x100 */
+	mutex_unlock(&edge_port->mutex);
 
 	return result;
 }
@@ -2477,12 +2489,14 @@ static void change_port_settings(struct tty_struct *tty,
 		return;
 
 	/* set up the MCR register and send it to the EdgePort */
+	mutex_lock(&edge_port->mutex);
 	edge_port->shadowMCR = MCR_MASTER_IE;
 	if (cflag & CBAUD)
 		edge_port->shadowMCR |= (MCR_DTR | MCR_RTS);
 
 	status = send_cmd_write_uart_register(edge_port, MCR,
 						edge_port->shadowMCR);
+	mutex_unlock(&edge_port->mutex);
 	if (status != 0)
 		return;
 
@@ -2974,6 +2988,7 @@ static int edge_port_probe(struct usb_serial_port *port)
 		return -ENOMEM;
 
 	spin_lock_init(&edge_port->ep_lock);
+	mutex_init(&edge_port->mutex);
 
 	init_waitqueue_head(&edge_port->wait_open);
 	init_waitqueue_head(&edge_port->wait_chase);
-- 
2.55.0

