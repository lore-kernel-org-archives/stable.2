Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792757816;
	b=xXNjiSMKNY5JsMpEnwWJzs0jMzU7FLKbBrmRduZteAj46fXCb6m7YBu200L5L3+/SzdK
	 0MbNgo6ndCKiRWa5dZOe4j2bxnMl62ni/RInAC1vxLTkM67P2IHODNOo8qtBvfB6KVydm
	 q2qY4uhKQEEGVbvAhOp0sftd0Yn49elEw4QoENSSbsnCY6Li5hofXkQf0sFNlWouPx42Y
	 LmGhM1f6NNNmbNp3wi/hzm3eZzk7Zg6M52XRK+OwuBygQlWYICmGXFVIU3SCqdTBeTipy
	 3gXKKd9F7GyzHCRC6opVTct8AFn1kNCFFjC0VRl+WvrRU0pjU7ThReGfDFWW2htllLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792757816;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Mf7RWAGVbmmDg34dbKZ6D21+aia9oitvh7Q4ICqrokM=;
	b=mkMx0Dx+8mDEspQXWMqe03bdhlpLDckwqQJJsgg+iN64tm58rHqXoi66fEDOrOPKhkOL
	 iPYQwzoqJQnpP+qGub5VeXSykaYtgJUtd3bEu8EzabOzFpB1Vmgg2vZEpxaGr4hJPP/6v
	 AlONh99teV23INA5/cHBjrXQg78fdm8Gk6H3hBsR7dMJjHdkB7w5LYkZMtDN6LFSO6YGZ
	 TjxKVhm8qD9/a7neW/iTOOfPuQTC8Orp7YtKfSp3MLrKsZCrmxR6si87Rs5DXofTUrgN1
	 HkYSY1/aEtLpadRIZO1524uaJK7rI87R6n51d5EEy2lEai47Z3nfmDRi3bDjJ9+kIaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dkOaNSye;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF38606A326;
	Fri, 23 Oct 2026 12:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dkOaNSye
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618EA1F031E3;
	Fri, 23 Oct 2026 12:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792757815;
	bh=Mf7RWAGVbmmDg34dbKZ6D21+aia9oitvh7Q4ICqrokM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dkOaNSyeCQmROQNRMpcUUZ8KrlO+BFAwurGmfOMGnRNZnd8B+YQUGIVEBlNTcW6I1
	 uCR7YP+YVUFMxOEcSl7pfNPRQS50VLLOGXx0F7WMhzSuE9+aRyCJsHgUtRFnX+WIkQ
	 c4CYFueiRoaVwA2eFqK9b3KNXQqXz3OE6/uS5ISumjn6kIhPaQ0Y+9ojcq56jHEawG
	 eHZcqOuHvkEHpGc7UhsW6CVyJvDMSJCRDvlLi112bwtX7RhOiZjU0QyU4H9hHvOg+B
	 K1pjDlav6FWRujjkBPe0TpvMFLmyI6vF70ufvoATKGlHt9vjlKstatHar5wbdrGo2p
	 HyFfZynANfylA==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xKECb-00000000mZb-0d70;
	Fri, 23 Oct 2026 14:16:53 +0200
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 07/12] USB: serial: io_edgeport: serialise MCR accesses
Date: Fri, 23 Oct 2026 14:15:25 +0200
Message-ID: <20261023121530.186541-8-johan@kernel.org>
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
index 0fe7495c47f4..0fd68faa8427 100644
--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -168,6 +168,7 @@ struct edgeport_port {
 	struct urb		*write_urb;		/* write URB for this port */
 	bool			write_in_progress;	/* 'true' while a write URB is outstanding */
 	spinlock_t		ep_lock;
+	struct mutex		mutex;
 
 	__u8			shadowLCR;		/* last LCR value received */
 	__u8			shadowMCR;		/* last MCR value received */
@@ -877,7 +878,10 @@ static int edge_open(struct tty_struct *tty, struct usb_serial_port *port)
 	spin_unlock_irq(&edge_port->ep_lock);
 
 	/* Must always set this bit to enable ints! */
+	mutex_lock(&edge_port->mutex);
 	edge_port->shadowMCR = MCR_MASTER_IE;
+	mutex_unlock(&edge_port->mutex);
+
 	edge_port->chaseResponsePending = false;
 
 	/* send a open port command */
@@ -1398,9 +1402,11 @@ static void edge_throttle(struct tty_struct *tty)
 
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
@@ -1435,9 +1441,11 @@ static void edge_unthrottle(struct tty_struct *tty)
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
 
@@ -1478,6 +1486,7 @@ static int edge_tiocmset(struct tty_struct *tty,
 	struct edgeport_port *edge_port = usb_get_serial_port_data(port);
 	unsigned int mcr;
 
+	mutex_lock(&edge_port->mutex);
 	mcr = edge_port->shadowMCR;
 	if (set & TIOCM_RTS)
 		mcr |= MCR_RTS;
@@ -1496,6 +1505,7 @@ static int edge_tiocmset(struct tty_struct *tty,
 	edge_port->shadowMCR = mcr;
 
 	send_cmd_write_uart_register(edge_port, MCR, edge_port->shadowMCR);
+	mutex_unlock(&edge_port->mutex);
 
 	return 0;
 }
@@ -1509,6 +1519,7 @@ static int edge_tiocmget(struct tty_struct *tty)
 	unsigned int mcr;
 
 	msr = edge_port->shadowMSR;
+	mutex_lock(&edge_port->mutex);
 	mcr = edge_port->shadowMCR;
 	result = ((mcr & MCR_DTR)	? TIOCM_DTR: 0)	  /* 0x002 */
 		  | ((mcr & MCR_RTS)	? TIOCM_RTS: 0)   /* 0x004 */
@@ -1516,6 +1527,7 @@ static int edge_tiocmget(struct tty_struct *tty)
 		  | ((msr & EDGEPORT_MSR_CD)	? TIOCM_CAR: 0)   /* 0x040 */
 		  | ((msr & EDGEPORT_MSR_RI)	? TIOCM_RI:  0)   /* 0x080 */
 		  | ((msr & EDGEPORT_MSR_DSR)	? TIOCM_DSR: 0);  /* 0x100 */
+	mutex_unlock(&edge_port->mutex);
 
 	return result;
 }
@@ -2430,12 +2442,14 @@ static void edge_set_termios(struct tty_struct *tty, struct usb_serial_port *por
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
 
@@ -2930,6 +2944,7 @@ static int edge_port_probe(struct usb_serial_port *port)
 		return -ENOMEM;
 
 	spin_lock_init(&edge_port->ep_lock);
+	mutex_init(&edge_port->mutex);
 
 	init_waitqueue_head(&edge_port->wait_open);
 	init_waitqueue_head(&edge_port->wait_chase);
-- 
2.55.0

