Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793269204;
	b=LFbuoVNKHI4lECtB5kU03WK1AlBoDrQShpPi2GmA+VgILk7m1I05MbcnFHVD9UUU2R6h
	 pR3X8XGFQaORERuXBRnL6W1wSX22tfCkb58ruSZgW49GSz2ExywsRykzmYMVPJfs2X/fB
	 itQ8YlKJdokYTw8ye67bzJZkhjStapup3H0NUuXF/5SLw9xiNHapqTPoQuK0o3MWRUgEH
	 67oIMGK1ZBy5k5SbL7TcxOpx3UIibCQsx+4h0IZYwirSeLGpzRs1sFElfgS0Dl70vIpbc
	 oXdJ5FjePtW0BkO1BfHPSn0RDPLAhThRQpu5l8hAdP6+44MGYR8qZET7HcZr1c6/pTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793269204;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=IjR+gIehqXANQZyuqwSHZLOhJs5tTLHYFHBu8EhuMv4=;
	b=WBz5qTTOb5ENQNm5iW0LmyZhZj4Ut+8vfCv/Ce4JJBeeIfcBt/CgQaE1XHD3/RIilpNI
	 pdVcyllckAVrCQVrGJvQYe/cfNu9nYavqBLnbSlRyi4L9LOVQhJtux+4tiPuYlRdCe2Ov
	 GnFYDstF0mGnYMWA4A1potN2o5EyQrlstn770E2Nlki46DCyTak8LGKBc1Ji/rvFoLtRv
	 cNGCfieXFBhSDOswcwo04Y4X3ftN117FJmKdv2oiea5yZjXMwwVNq1XVTkDtoYHyguXFk
	 EXKX0ikBfQU4Y+t6go+eiANzGCrC6wpBmmxYIu7386U/UTnrFTVy5HlL4Sf/QH4YjRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bhgSFJ3y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DCF606B79F;
	Thu, 29 Oct 2026 10:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bhgSFJ3y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A281F031E2;
	Thu, 29 Oct 2026 10:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793269204;
	bh=IjR+gIehqXANQZyuqwSHZLOhJs5tTLHYFHBu8EhuMv4=;
	h=From:To:Cc:Subject:Date;
	b=bhgSFJ3yy13ejJOo4xjMFwLtgDk8H8n1uWBZIfW+U7tQWqKZUj8lHbnB3sW02wu6a
	 DZ4i0utw6RfDTwBI0flEEBong7rCKpbh7DzYEnEoSD5aS0LtKq5jj73FQN6YhSzJX8
	 37wrKplc3RhNc48pLigad7zTXhN8qDER6bzidT+LeeQ5/lIFD01su3iZrjznwQ+WL7
	 SF3HnUHSmaCJgA7yht9WzYvDSbEeBlqyRDlDnOBrqgglKp3EdiTFWmrKiGc0Xzvrpw
	 VVnmeWAkjsUep3LMB2GEOr8c80HX4uhSJRyuL/1mkFI3UhS8HSWdryWL1Xm/M2FhaS
	 DO4mGeaBhtd/Q==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xMNEo-00000003dHm-0h1N;
	Thu, 29 Oct 2026 11:20:02 +0100
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>,
	stable@vger.kernel.org
Subject: [PATCH] USB: serial: garmin_gps: fix deadlock on reset request
Date: Thu, 29 Oct 2026 11:18:28 +0100
Message-ID: <20261029101828.865915-1-johan@kernel.org>
X-Mailer: git-send-email 2.55.0
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

The garmin_gps driver has a reset feature that is supposed to reset the
device when writing a private reset request packet. The reset is however
done synchronously from the write() callback (and without holding the
required device lock) which leads to a deadlock in the line discipline
when hanging up the port as part of disconnect.

Switch to using the asynchronous reset interface while dropping the
redundant and synchronous stopping of the interrupt urb (write()
callbacks are supposed to be atomic and USB core, USB serial core and
the driver itself will unlink and kill all URBs during disconnect).

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Josef Bacik <josef@toxicpanda.com>
Link: https://lore.kernel.org/2026102733-prayer-drainer-56f3@gregkh
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/garmin_gps.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/serial/garmin_gps.c b/drivers/usb/serial/garmin_gps.c
index abfc03e44ca9..f1e69eca2601 100644
--- a/drivers/usb/serial/garmin_gps.c
+++ b/drivers/usb/serial/garmin_gps.c
@@ -823,10 +823,9 @@ static void priv_status_resp(struct usb_serial_port *port)
  * Garmin specific driver functions
  ******************************************************************************/
 
-static int process_resetdev_request(struct usb_serial_port *port)
+static void process_resetdev_request(struct usb_serial_port *port)
 {
 	unsigned long flags;
-	int status;
 	struct garmin_data *garmin_data_p = usb_get_serial_port_data(port);
 
 	spin_lock_irqsave(&garmin_data_p->lock, flags);
@@ -835,13 +834,8 @@ static int process_resetdev_request(struct usb_serial_port *port)
 	garmin_data_p->serial_num = 0;
 	spin_unlock_irqrestore(&garmin_data_p->lock, flags);
 
-	usb_kill_urb(port->interrupt_in_urb);
-	dev_dbg(&port->dev, "%s - usb_reset_device\n", __func__);
-	status = usb_reset_device(port->serial->dev);
-	if (status)
-		dev_dbg(&port->dev, "%s - usb_reset_device failed: %d\n",
-			__func__, status);
-	return status;
+	dev_dbg(&port->dev, "%s - usb_queue_reset_device\n", __func__);
+	usb_queue_reset_device(port->serial->interface);
 }
 
 
-- 
2.55.0

