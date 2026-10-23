Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792757817;
	b=Fkxxgd3LP5BcE2Q+qL1CrqaI7Cr6rTgz+KNByc4N90SJRXY2f5vwNC3LxG367Lpjm7vq
	 7MWqn/ll5ed30l0fj4xZ6NP/zSi78HCOFVgLSvLKkTmgZkPlqbcXbTPdWMmPBY+HGrCjy
	 dL7eq/72C+U3yYhB294TArKWmQSYiZAVAkWyt3FaoBuZzJdAeIYClm51S8tH9yHkjSk9F
	 9n+I+AyCAPyiCS6tOf8CTISx/LM6zam/xhr+L09hCuXrP/hsWimHNK0Ac27l9IzW55qcc
	 eAurewyMhPeJEKASAAu9TqYFeAs+hm+HsoejWP54t//LDqkRC0VZLNvzfAl6MHB4aUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792757817;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=85j6uG90tQOeVMPDeiPqaJ0ZvoWKsn7Ee6ZXZHaiL2k=;
	b=aSkM1hixzERiX2wYNqrTqNN9jQPMs9+AObQxS8fTGc4iYjNOIQiXy0ulWUxwZ0jBzkGM
	 tJ6OXVI/aEXDRKDuxEKvXCssK/nYTajFJy3tvj7ckV80ixccw6O0znJl2OQ+DsHagA88o
	 VQNOO2KjEmTaGit7N4WU2N2x2CbV0HAHuBQw74qnj1aITqBAY346d4Y3/jyjJDxMzvoKv
	 USOwqaOUoppmu+X0NJBvk1sLyR0Vf5LYXYekbyJDYz7sWs1UUsbc4B2ekSYzWrEYTnlvR
	 hbQOT3lTXpEn/xR92V4Ucl6yVBHO/7uHHyPUClXIvWXgiJZOSrAbrtSsh2/gkvLmBaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RA7Sv7V6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEF7606A325;
	Fri, 23 Oct 2026 12:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RA7Sv7V6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F55F1F031E2;
	Fri, 23 Oct 2026 12:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792757815;
	bh=85j6uG90tQOeVMPDeiPqaJ0ZvoWKsn7Ee6ZXZHaiL2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RA7Sv7V6Rz7nnd4GMIlnHUuQPrMKhBySYet7y8r7zaGQrSferTVi4iD6nIzRradcq
	 MG7/YgcZPS0oCOq+cx1BsPQnd9+F35/dj/7zA2wyiyZ3Z0g2KQZf7KThnnJBKO9ovk
	 we5xVpjNTZwXxN4W7zarBmIepC4ewM1rZWC4fGjVj7u730nIsOZh88eJ7MoWTqdwOg
	 tZvB8UvDrVaA0XAKbP268vtB3wZSX045OghPYH437Mv0kFkhTRpByxEcp/86jr+5Yp
	 4/InH4/dArM0NaxNk7O/xcoBX83nPEHFhzwhRvcK+7ZSTpyU7nPubQbu2rJv2N2Nps
	 2d2TFTSQw9sHg==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xKECb-00000000mZZ-0Zox;
	Fri, 23 Oct 2026 14:16:53 +0200
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 06/12] USB: serial: io_edgeport: fix potential use-after-free on disconnect
Date: Fri, 23 Oct 2026 14:15:24 +0200
Message-ID: <20261023121530.186541-7-johan@kernel.org>
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

The driver submits command URBs asynchronously but fails to stop them on
disconnect, something which could lead to a use-after-free when
accessing driver data in the completion handler after a port has been
unbound.

Add an URB anchor to track and kill outstanding command URBs on
disconnect.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/io_edgeport.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
index b8fbcc8908d1..0fe7495c47f4 100644
--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -225,6 +225,7 @@ struct edgeport_serial {
 	__u8			rxStatusParam;			/* the receive status parameter */
 	__s16			rxBytesRemaining;		/* the number of port bytes left to read */
 	struct usb_serial	*serial;			/* loop back to the owner of this object */
+	struct usb_anchor	cmd_anchor;
 };
 
 /* baud rate information */
@@ -261,9 +262,6 @@ static const struct divisor_table_entry divisor_table[] = {
 	{   230400,	1},
 };
 
-/* Number of outstanding Command Write Urbs */
-static atomic_t CmdUrbs = ATOMIC_INIT(0);
-
 
 /* function prototypes */
 
@@ -776,11 +774,6 @@ static void edge_bulk_out_cmd_callback(struct urb *urb)
 	struct device *dev = &urb->dev->dev;
 	int status = urb->status;
 
-	atomic_dec(&CmdUrbs);
-	dev_dbg(dev, "%s - FREE URB %p (outstanding %d)\n", __func__, urb,
-		atomic_read(&CmdUrbs));
-
-
 	/* clean up the transfer buffer */
 	kfree(urb->transfer_buffer);
 
@@ -2127,24 +2120,21 @@ static int write_cmd_usb(struct edgeport_port *edge_port,
 	if (!urb)
 		return -ENOMEM;
 
-	atomic_inc(&CmdUrbs);
-	dev_dbg(dev, "%s - ALLOCATE URB %p (outstanding %d)\n",
-		__func__, urb, atomic_read(&CmdUrbs));
-
 	usb_fill_bulk_urb(urb, edge_serial->serial->dev,
 			usb_sndbulkpipe(edge_serial->serial->dev,
 					edge_serial->bulk_out_endpoint),
 			buffer, length, edge_bulk_out_cmd_callback, edge_port);
 
 	edge_port->commandPending = true;
+	usb_anchor_urb(urb, &edge_serial->cmd_anchor);
 	status = usb_submit_urb(urb, GFP_ATOMIC);
 
 	if (status) {
 		/* something went wrong */
 		dev_err(dev, "%s - usb_submit_urb(write command) failed, status = %d\n",
 			__func__, status);
+		usb_unanchor_urb(urb);
 		usb_free_urb(urb);
-		atomic_dec(&CmdUrbs);
 		return status;
 	}
 
@@ -2696,6 +2686,7 @@ static int edge_startup(struct usb_serial *serial)
 
 	spin_lock_init(&edge_serial->es_lock);
 	edge_serial->serial = serial;
+	init_usb_anchor(&edge_serial->cmd_anchor);
 	usb_set_serial_data(serial, edge_serial);
 
 	/* get the name for the device from the device */
@@ -2900,6 +2891,8 @@ static void edge_disconnect(struct usb_serial *serial)
 {
 	struct edgeport_serial *edge_serial = usb_get_serial_data(serial);
 
+	usb_kill_anchored_urbs(&edge_serial->cmd_anchor);
+
 	if (edge_serial->is_epic) {
 		usb_kill_urb(edge_serial->interrupt_read_urb);
 		usb_kill_urb(edge_serial->read_urb);
-- 
2.55.0

