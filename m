Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792592151;
	b=5NiNk5kkxRSm1GR+UwywQLkA+08u1G3UPg5xC64zrIQQx7/0sTfktWH0/0vIBBznRyaX
	 /29QOoVOjnn9uJTFQL2mHgUFwlBANYMCHKmbVJeNa73usqYrxHOEv63z54yJvDWrszD+2
	 /eMoE1bztFc6Fn/EmgnrUSPuRF+6AE5DDJMs6/bSGL9b9EPrFhzNt+fFjhVssigW8nmu8
	 McNnVSWLPtk2hgBMsdmhx7AGeO8xnC4BSNajaPnXS0QaIGwBGZghVcC5IrxvG0xi9gljN
	 oRYGDXuXym4KUsThEmclCE85h5f/5p0y2Ql1ymI7/CebNH/iCajlNIiQjNab7wWXkpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792592151;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=x0CdyLtOlM6pOcDzRjfbdfaCsPxFMV595GfpX+mBzAM=;
	b=HisrOvdnEGFpRzHUFLianAYwZPJIJcb2QGTfdtWQB7MqsnqwQ0wD6L/2oejuwDbb/CAy
	 J4d4WTpr6T1WVU2f/X70OePWcThV46YqUcIZbRYlugVq/uH13SuZr9C44tucqf/E6tBRe
	 HqysljYW3cB4VxtVOEqG5AF6dv/McHQLSOCvQW9W7bzVRmQR7F/RqrOwmQ0/oTt0CmB+8
	 fxEDFURlDw2WfS6H4J28+QYGo85qSkECbaTJw2NKVQjztubLQWtVY3tnnY+HPIzPJH11S
	 bZb0tu0HibGF2lx229vzky4wXTAz3dJPwaZiRQxu5VnWYicKLuXn6SDoG/b06GlThUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wp6qFXgQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76760606A31A;
	Wed, 21 Oct 2026 14:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wp6qFXgQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB521F000C4;
	Wed, 21 Oct 2026 14:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792592150;
	bh=x0CdyLtOlM6pOcDzRjfbdfaCsPxFMV595GfpX+mBzAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wp6qFXgQE2P6ovcVs1ZQXf56NzZwncOU8o07b47wrgixzTN4rohEMd0Q0ebMpq1PR
	 NLDWPQqvA8byfFFdFsKNxini4mk8d3dWCft1LFYVW5OKTQyZZaaWjcQu3Vl8oX8+C1
	 bY9xM3sVs/nZgE3t2Mr5/iuZSQhqsGpjC3Cdo3/79pi8L7Q0sXpROG7qxTfIl0+uuR
	 wnuuQwIFEbvZQACnzMVBnch6tRfRExlRB36/XQgURdCcp7UdEDrh1GpD/hVvOwNc6W
	 kCjvlElCZzGxuuQb3o8lbXYI6kfrzb2mirK8g/ZgO8LO2u2ClXLusq0LcrQQq65iXJ
	 m97aT/4CZri5g==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xJX6Z-00000009kqF-2Qjb;
	Wed, 21 Oct 2026 16:15:47 +0200
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 04/11] USB: serial: io_edgeport: fix potential NULL-deref at open
Date: Wed, 21 Oct 2026 16:11:47 +0200
Message-ID: <20261021141154.2324793-5-johan@kernel.org>
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

Do not mark the port as open until after the write FIFO has been
allocated and initialised to prevent a racing interrupt completion from
attempting to send stale data and dereferencing the FIFO buffer pointer.

Note that the open flag defaults to false and is cleared on close() so
there is no need to reinitialise it on every open().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/io_edgeport.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
index a2410c063ffe..38f58ca115eb 100644
--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -889,9 +889,8 @@ static int edge_open(struct tty_struct *tty, struct usb_serial_port *port)
 
 	/* send a open port command */
 	edge_port->openPending = true;
-	edge_port->open        = false;
-	response = send_iosp_ext_cmd(edge_port, IOSP_CMD_OPEN_PORT, 0);
 
+	response = send_iosp_ext_cmd(edge_port, IOSP_CMD_OPEN_PORT, 0);
 	if (response < 0) {
 		dev_err(dev, "%s - error sending open port command\n", __func__);
 		edge_port->openPending = false;
@@ -901,8 +900,7 @@ static int edge_open(struct tty_struct *tty, struct usb_serial_port *port)
 	/* now wait for the port to be completely opened */
 	wait_event_timeout(edge_port->wait_open, !edge_port->openPending,
 								OPEN_TIMEOUT);
-
-	if (!edge_port->open) {
+	if (edge_port->openPending) {
 		/* open timed out */
 		dev_dbg(dev, "%s - open timeout\n", __func__);
 		edge_port->openPending = false;
@@ -930,6 +928,10 @@ static int edge_open(struct tty_struct *tty, struct usb_serial_port *port)
 		return -ENOMEM;
 	}
 
+	spin_lock_irq(&edge_port->ep_lock);
+	edge_port->open = true;
+	spin_unlock_irq(&edge_port->ep_lock);
+
 	dev_dbg(dev, "%s - Initialize TX fifo to %d bytes\n",
 		__func__, edge_port->maxTxCredits);
 
@@ -1092,7 +1094,6 @@ static void edge_close(struct usb_serial_port *port)
 	spin_lock_irq(&edge_port->ep_lock);
 	edge_port->open = false;
 	spin_unlock_irq(&edge_port->ep_lock);
-	edge_port->openPending = false;
 
 	usb_kill_urb(edge_port->write_urb);
 
@@ -1824,7 +1825,6 @@ static void process_rcvd_status(struct edgeport_serial *edge_serial,
 
 		/* we have completed the open */
 		edge_port->openPending = false;
-		edge_port->open = true;
 		wake_up(&edge_port->wait_open);
 		return;
 	}
-- 
2.55.0

