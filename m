Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8388A1C84DC;
	Fri, 14 Aug 2026 18:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786730789; cv=pass; b=PFEyLVy3USPq9Ab2fMluyXeYF2bbMTTHHZLac5E6s7WtNJBHtt/U0UMCGW5ue9ycRFdAsrwXSyxvPSmM02tS/mZ4aqA0V4NUrGfn45aVW3YIisRjNy1vVf0699nrbr8WGNGx13y2nJ9Nrio48gN0yFxKky0f50qpg37ZgvElE/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786730789; c=relaxed/simple;
	bh=hwfWHYjrewKQrNSxzEgH626HlmpmxBapKykPYac4pis=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HtBG4GvMaa24McSG+awwvZ9xRbL6wvOMSN1OuutYturXm70pd6Mj6M3nRlNpMCnA8oMy0SDW3rc0wHDVzBWIk0Ln/FRXaOp9bTBLJ7+Yyfr90RaA8kG181xAHWpCUMSjzIIl79n9CmK3bCfCbfc/xAzCmNFPjf31oWkdzocM9uw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ikuyo.dev; spf=pass smtp.mailfrom=ikuyo.dev; dkim=pass (1024-bit key) header.d=ikuyo.dev header.i=eritque-arcus@ikuyo.dev header.b=CbXJ3M+6; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ikuyo.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ikuyo.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ikuyo.dev header.i=eritque-arcus@ikuyo.dev header.b="CbXJ3M+6"
ARC-Seal: i=1; a=rsa-sha256; t=1786730772; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gRBzGmaATX5rcofJ4L6aCM2cB3Cv/HxDifz+7jrRToz0plheuKSop6jR1aChp3+MeSq+8B03XjTvj5LxbzFN9aYTmzQgluY8ttcqwnpui5T/BOVQ/lH6hb7bmGSXS8YjgYdHAsSsDKqepeicrCj8JHcMuj+bg4dge5xBQOXfYWo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786730772; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WTUPKcza5IvPfBeHwG59CoJeJWVMUAntwdqncF6fbcU=; 
	b=n0L8r3J6csMVTgpxoMyjqXvmM4YSkTSMRkyZe0RUGZYZNhiB7WS+huxfGj6voQtZGtBuKGomP5SAdizqVT3dzkBpBe0+E1Sh8yoQ9JXnb0ZA+15TR/Jkh3qJQ0yRZH0+OdVj12RJJvqga4zsK1Fx1UuMNR86IiueQ5tMWd436S8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ikuyo.dev;
	spf=pass  smtp.mailfrom=eritque-arcus@ikuyo.dev;
	dmarc=pass header.from=<eritque-arcus@ikuyo.dev>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786730772;
	s=zmail; d=ikuyo.dev; i=eritque-arcus@ikuyo.dev;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=WTUPKcza5IvPfBeHwG59CoJeJWVMUAntwdqncF6fbcU=;
	b=CbXJ3M+6P5VrbBdwXfC5elzAvOdT2F9Eif/2/mNaJYW8DC3lQ4goTZrtPE2l/UxR
	v0vAeMrQ/pdlbDIM3fD+XRCzMssOULGFoIz+AUcEi0iMwpsfiA+PDZj26YTiDGF8nwT
	0SbtyVwkQ0RpKjhsKdHPWdBFRO54k+il73KvJTiI=
Received: by mx.zohomail.com with SMTPS id 178673077072385.638967822533;
	Fri, 14 Aug 2026 11:06:10 -0700 (PDT)
From: Yiran Qiu <eritque-arcus@ikuyo.dev>
Date: Sat, 15 Aug 2026 02:05:46 +0800
Subject: [PATCH 1/2] can: esd_usb: validate received message length before
 use
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260815-can-esd-hydra-fixes-v1-1-de644cbeaec2@ikuyo.dev>
References: <20260815-can-esd-hydra-fixes-v1-0-de644cbeaec2@ikuyo.dev>
In-Reply-To: <20260815-can-esd-hydra-fixes-v1-0-de644cbeaec2@ikuyo.dev>
To: Frank Jungclaus <frank.jungclaus@esd.eu>, socketcan@esd.eu, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yiran Qiu <eritque-arcus@ikuyo.dev>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7546;
 i=eritque-arcus@ikuyo.dev; h=from:subject:message-id;
 bh=hwfWHYjrewKQrNSxzEgH626HlmpmxBapKykPYac4pis=;
 b=owGbwMvMwCW2M2qh3ooTh9cxnlZLYsiqj+T5slM24MqsiR4zL7i7Fc6dOvHCfz/xdGFVVzezp
 dUebfNudpSyMIhxMciKKbJMN9ixmLPdmm2ZgUQozBxWJpAhDFycAjCRT6EM/0yU1jmUlPic7zc5
 cGpr8d+da1da5X+v+n1RSlfBSTRxuRwjw5mPEg/8fatYpx7ocnc+vr+xaa5G8ke/5hr79cUX92Z
 u4AQA
X-Developer-Key: i=eritque-arcus@ikuyo.dev; a=openpgp;
 fpr=9730B8A309873B06A6301855B95AA12EA8C8C3AE

esd_usb_read_bulk_callback() walks a sequence of variable-length
messages out of the RX URB buffer. The only length check,
"pos > urb->actual_length", runs *after* the current message has been
dispatched and after @pos has been advanced, so it can neither protect
the message being processed nor stop the loop:

 - The per-message handlers dereference fixed offsets of the message.
   esd_usb_rx_can_msg() reads the 32-bit CAN id at offset 8 and copies
   up to CANFD_MAX_DLEN payload bytes from offset 12; the error-event
   path reads four status bytes at offset 12; esd_usb_tx_done_msg()
   reads the tx handle at offset 4. A malicious or malfunctioning
   device can place a short ESD_USB_CMD_CAN_RX header near the end of
   actual_length so that these reads fall past the buffer, leaking
   adjacent kernel heap into a received CAN(-FD) skb.

 - hdr.len is the message length in 32-bit words. A message with
   hdr.len == 0 never advances @pos, spinning this URB-completion
   softirq forever.

Validate the header and the declared message length before dispatch:
reject a message whose header is not fully present, whose length is
zero, or which extends past the received data, and advance @pos by the
validated length. Pass the validated length to the message handlers so
they can confirm that the fields they read (and the payload they copy)
were actually received.

This is the esd_usb counterpart of the kvaser_usb_leaf fix,
commit 0293dd153f9d ("can: kvaser_usb_leaf: kvaser_usb_leaf_wait_cmd():
validate received command extents"). esd_usb has the same unbounded
receive-buffer walk and was not touched by that fix.

Reproduced with USB_RAW_GADGET + dummy_hcd on a KASAN build: a bulk-IN
frame whose first message has hdr.len == 255 (advancing @pos to 1020)
followed by an ESD_USB_CMD_CAN_RX header at offset 1020 yields

  BUG: KASAN: slab-out-of-bounds in esd_usb_read_bulk_callback+0x38f/0xd70
  Read of size 4 at addr ffff88800c0a9c04 by task init/1
   kasan_check_range
   esd_usb_read_bulk_callback+0x38f/0xd70
   __usb_hcd_giveback_urb
   dummy_timer
  The buggy address belongs to the object at ffff88800c0a9800
   which belongs to the cache kmalloc-1k of size 1024
  The buggy address is located 4 bytes to the right of
   allocated 1024-byte region [ffff88800c0a9800, ffff88800c0a9c00)

Fixes: 96d8e90382dc ("can: Add driver for esd CAN-USB/2 device")
Cc: stable@vger.kernel.org
Signed-off-by: Yiran Qiu <eritque-arcus@ikuyo.dev>
---
 drivers/net/can/usb/esd_usb.c | 69 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 55 insertions(+), 14 deletions(-)

diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index f41d4a0d140f7..13356e68f3f60 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -298,7 +298,7 @@ struct esd_usb_net_priv {
 };
 
 static void esd_usb_rx_event(struct esd_usb_net_priv *priv,
-			     union esd_usb_msg *msg)
+			     union esd_usb_msg *msg, unsigned int msg_len)
 {
 	struct net_device_stats *stats = &priv->netdev->stats;
 	struct can_frame *cf;
@@ -306,8 +306,14 @@ static void esd_usb_rx_event(struct esd_usb_net_priv *priv,
 	u32 id = le32_to_cpu(msg->rx.id) & ESD_USB_IDMASK;
 
 	if (id == ESD_USB_EV_CAN_ERROR_EXT) {
-		u8 state = msg->rx.ev_can_err_ext.status;
-		u8 ecc = msg->rx.ev_can_err_ext.ecc;
+		u8 state;
+		u8 ecc;
+
+		if (msg_len < offsetofend(struct esd_usb_rx_msg, ev_can_err_ext))
+			return;
+
+		state = msg->rx.ev_can_err_ext.status;
+		ecc = msg->rx.ev_can_err_ext.ecc;
 
 		priv->bec.rxerr = msg->rx.ev_can_err_ext.rec;
 		priv->bec.txerr = msg->rx.ev_can_err_ext.tec;
@@ -395,7 +401,7 @@ static void esd_usb_rx_event(struct esd_usb_net_priv *priv,
 }
 
 static void esd_usb_rx_can_msg(struct esd_usb_net_priv *priv,
-			       union esd_usb_msg *msg)
+			       union esd_usb_msg *msg, unsigned int msg_len)
 {
 	struct net_device_stats *stats = &priv->netdev->stats;
 	struct can_frame *cf;
@@ -407,10 +413,19 @@ static void esd_usb_rx_can_msg(struct esd_usb_net_priv *priv,
 	if (!netif_device_present(priv->netdev))
 		return;
 
+	/* The device controls the message length; make sure the fixed rx
+	 * header (up to and including the CAN id) was actually received
+	 * before it is dereferenced.
+	 */
+	if (msg_len < offsetofend(struct esd_usb_rx_msg, id)) {
+		stats->rx_length_errors++;
+		return;
+	}
+
 	id = le32_to_cpu(msg->rx.id);
 
 	if (id & ESD_USB_EVENT) {
-		esd_usb_rx_event(priv, msg);
+		esd_usb_rx_event(priv, msg, msg_len);
 	} else {
 		if (msg->rx.dlc & ESD_USB_FD) {
 			skb = alloc_canfd_skb(priv->netdev, &cfd);
@@ -446,6 +461,15 @@ static void esd_usb_rx_can_msg(struct esd_usb_net_priv *priv,
 		if (id & ESD_USB_EXTID)
 			cfd->can_id |= CAN_EFF_FLAG;
 
+		/* Reject a frame that claims more payload than was actually
+		 * received, to avoid copying past the URB buffer.
+		 */
+		if (len > msg_len - offsetofend(struct esd_usb_rx_msg, id)) {
+			stats->rx_length_errors++;
+			dev_kfree_skb_any(skb);
+			return;
+		}
+
 		memcpy(cfd->data, msg->rx.data_fd, len);
 		stats->rx_bytes += len;
 		stats->rx_packets++;
@@ -455,7 +479,7 @@ static void esd_usb_rx_can_msg(struct esd_usb_net_priv *priv,
 }
 
 static void esd_usb_tx_done_msg(struct esd_usb_net_priv *priv,
-				union esd_usb_msg *msg)
+				union esd_usb_msg *msg, unsigned int msg_len)
 {
 	struct net_device_stats *stats = &priv->netdev->stats;
 	struct net_device *netdev = priv->netdev;
@@ -464,6 +488,9 @@ static void esd_usb_tx_done_msg(struct esd_usb_net_priv *priv,
 	if (!netif_device_present(netdev))
 		return;
 
+	if (msg_len < offsetofend(struct esd_usb_tx_done_msg, hnd))
+		return;
+
 	context = &priv->tx_contexts[msg->txdone.hnd & (ESD_USB_MAX_TX_URBS - 1)];
 
 	if (!msg->txdone.status) {
@@ -507,8 +534,27 @@ static void esd_usb_read_bulk_callback(struct urb *urb)
 
 	while (pos < urb->actual_length) {
 		union esd_usb_msg *msg;
+		unsigned int msg_len;
+
+		/* The header must be fully present before hdr.len / hdr.cmd
+		 * (and the net index below) are read.
+		 */
+		if (pos + sizeof(struct esd_usb_header_msg) > urb->actual_length) {
+			dev_err(dev->udev->dev.parent, "format error\n");
+			break;
+		}
 
 		msg = (union esd_usb_msg *)(urb->transfer_buffer + pos);
+		msg_len = msg->hdr.len * sizeof(u32); /* convert to # of bytes */
+
+		/* A zero-length message would never advance @pos and would
+		 * spin this URB-completion softirq forever; a message must
+		 * also fit within the received data.
+		 */
+		if (msg->hdr.len == 0 || msg_len > urb->actual_length - pos) {
+			dev_err(dev->udev->dev.parent, "format error\n");
+			break;
+		}
 
 		switch (msg->hdr.cmd) {
 		case ESD_USB_CMD_CAN_RX:
@@ -517,7 +563,7 @@ static void esd_usb_read_bulk_callback(struct urb *urb)
 				break;
 			}
 
-			esd_usb_rx_can_msg(dev->nets[msg->rx.net], msg);
+			esd_usb_rx_can_msg(dev->nets[msg->rx.net], msg, msg_len);
 			break;
 
 		case ESD_USB_CMD_CAN_TX:
@@ -527,16 +573,11 @@ static void esd_usb_read_bulk_callback(struct urb *urb)
 			}
 
 			esd_usb_tx_done_msg(dev->nets[msg->txdone.net],
-					    msg);
+					    msg, msg_len);
 			break;
 		}
 
-		pos += msg->hdr.len * sizeof(u32); /* convert to # of bytes */
-
-		if (pos > urb->actual_length) {
-			dev_err(dev->udev->dev.parent, "format error\n");
-			break;
-		}
+		pos += msg_len;
 	}
 
 resubmit_urb:

-- 
2.55.0

