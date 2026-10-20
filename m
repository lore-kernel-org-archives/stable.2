Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792506830;
	b=Tjmk6u/y2KI5sJGgoTXYv7fXmVu696iXc/WPcdmAPrpTsZ45L6cFqdpUYmQEVLEEhOns
	 FizAxNXANUjKARi1ZT4l+B91RK9sYCap86Ea2ZfaBBopIwObSWVeS0Dc2QtuMXqj4Eetk
	 RRkGVix5e4Lk9X2guDIRmhjvOqkE0wh9yLOZh/7N+PM+tma0jHu0okP4ISCAnBcul1n5R
	 R7bD9w5+ZgwO0n+Os4nFBopwPcLxHASoC8ehblBWpvEgKwU7ybCV+zq0YyKS9DuZHgZXa
	 YrKXZvNMcSisSIdr70k2VYqg80ypP+BZvotqO5ECJ2S6/M+dVY62HWXJmsQ561myfXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792506830;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=jgBP6EKFLKQOqmUz1y5zZ5Oa+0CSE6XMZuv6E8iGQVs=;
	b=NAKwF7LUdIQbub0glPvAXo/HHjdscTRYeaehXZzEezBQGidgrPeAmc+kOl4hJgezrUDI
	 pNk9pd5/jgMbep91u7fqFseaRO00exdA3gaoBwLvuqxATSTYoq5/TgdYHw3gNHi5K16nt
	 RKVOSK6iowCGiCwTDzudToAY/T2uqZObywU9blFB5Uddg1kBnEvdYFBszn4Oj/Ci3EyaQ
	 Vxvoc3+T5A6TGk2FXnZm9QejJEMLFKmXAmFhDDs8bxB5F7s0CCxdGsggqj+kaThjswf/l
	 dJmbGR5HypxMwpggB2whua0/8jpkrqY46pYGjFgmHQ5GDy4+FC79JkTttYnhfJr932Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=5NYSg1zR;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D066C606A327;
	Tue, 20 Oct 2026 14:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D066C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=5NYSg1zR
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B5B2AA1624;
	Tue, 20 Oct 2026 16:33:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792506826; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=jgBP6EKFLKQOqmUz1y5zZ5Oa+0CSE6XMZuv6E8iGQVs=;
	b=5NYSg1zRo1zuFPsW9GAz3/9Sxch8QjGpzXwO3S48xCWbHprU5dZmoYNs/UO/isZ4TjX+tB
	UrHV9kuhVM/asWHzhuLxn8Hpv1CKQy7ueTLpWJNGr4I39zjRfbJNke4185wgB2V5ahkZnM
	UGcpgXvJubboz83e6+w3+14LquVThUHn+Cgw3ZV3qHSNOIWg0rvMCLRXgJXJAb24F0b/Oh
	itNSmaIsb06FRQy3QrYKYwYsSW47KaVZQE2XG6CeRwk5P3RYA/HJ6QG5a/d41Ox+1KhTz1
	7CtKwr+rNGOzhghlhMgndAUBumnKwsbCyEIudgh4ciCB1JDSyL0Uo4YJe0ug7w==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Tue, 20 Oct 2026 16:33:38 +0200
Subject: [PATCH 1/4] usb: usbtmc: handle undersized high-speed bulk IN
 packets
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-fix-usbtmc-short-packets-v1-1-903f4d029193@tipi-net.de>
References: <20261020-fix-usbtmc-short-packets-v1-0-903f4d029193@tipi-net.de>
In-Reply-To: <20261020-fix-usbtmc-short-packets-v1-0-903f4d029193@tipi-net.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Steve Bayless <steve_bayless@keysight.com>, 
 Guido Kiener <guido@kiener-muenchen.de>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolai Buchwitz <nb@tipi-net.de>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

The Siglent SDM4065A-SC advertises 64-byte bulk endpoints at high
speed. USB 2.0 requires 512 bytes there, and xHCI uses 512. The device
still sends 64-byte packets, so each packet ends the transfer and
usbtmc_read() returns only the first one. The rest is read as the next
reply:

  usbtmc 1-1.3:1.0: Device sent too small first packet: 8 < 12
  usbtmc 1-1.3:1.0: Device sent reply with wrong bTag: 4 != 6

Read one packet per URB in usbtmc_read() on this device. Also check for
a full first transfer before stripping the alignment bytes, otherwise a
reply whose padding fills that transfer leaves its trailing ZLP behind.
The existing 4096-byte path had the same problem.

Fixes: d7604ff0dc01 ("usb: usbtmc: Optimize usbtmc_read")
Cc: stable@vger.kernel.org
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/usb/class/usbtmc.c | 60 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 53 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index 51cd9320a7366..7a2ea14aa524b 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -54,6 +54,16 @@ static const struct usb_device_id usbtmc_devices[] = {
 };
 MODULE_DEVICE_TABLE(usb, usbtmc_devices);
 
+/*
+ * Devices advertising high-speed bulk packets smaller than the 512 bytes
+ * xHCI uses. Transfers are limited to one advertised packet so the
+ * device's packet boundaries are preserved.
+ */
+static const struct usb_device_id usbtmc_packet_io_devices[] = {
+	{ USB_DEVICE(0xf4ec, 0x1220) },	/* Siglent SDM4065A-SC */
+	{ } /* terminating entry */
+};
+
 /*
  * This structure is the capabilities for the device
  * See section 4.2.1.8 of the USBTMC specification,
@@ -84,6 +94,10 @@ struct usbtmc_device_data {
 
 	/* packet size of IN bulk */
 	u16            wMaxPacketSize;
+	/* packet size of OUT bulk */
+	u16            out_wMaxPacketSize;
+	/* one URB per advertised bulk packet */
+	bool           packet_io;
 
 	/* data for interrupt in endpoint handling */
 	u8             bNotify1;
@@ -826,13 +840,13 @@ static ssize_t usbtmc_generic_read(struct usbtmc_file_data *file_data,
 				   void __user *user_buffer,
 				   u32 transfer_size,
 				   u32 *transferred,
-				   u32 flags)
+				   u32 flags, bool packet_mode)
 {
 	struct usbtmc_device_data *data = file_data->data;
 	struct device *dev = &data->intf->dev;
+	const u32 bufsize = packet_mode ? data->wMaxPacketSize : USBTMC_BUFSIZE;
 	u32 done = 0;
 	u32 remaining;
-	const u32 bufsize = USBTMC_BUFSIZE;
 	int retval = 0;
 	u32 max_transfer_size;
 	unsigned long expire;
@@ -852,7 +866,13 @@ static ssize_t usbtmc_generic_read(struct usbtmc_file_data *file_data,
 		 * packet
 		 */
 		remaining = transfer_size;
-		if ((max_transfer_size % data->wMaxPacketSize) == 0)
+		/*
+		 * Packet-sized reads must also consume a trailing short packet
+		 * when alignment bytes fill the last data packet.
+		 */
+		if (packet_mode)
+			max_transfer_size += data->wMaxPacketSize;
+		else if ((max_transfer_size % data->wMaxPacketSize) == 0)
 			max_transfer_size += (data->wMaxPacketSize - 1);
 	} else {
 		/* round down to bufsize to avoid truncated data left */
@@ -899,6 +919,12 @@ static ssize_t usbtmc_generic_read(struct usbtmc_file_data *file_data,
 			bufcount = MAX_URBS_IN_FLIGHT -
 					file_data->in_urbs_used;
 		}
+		/*
+		 * Queue one URB at a time. A trailer URB queued ahead would be
+		 * killed after most replies and log -ENOENT.
+		 */
+		if (packet_mode)
+			bufcount = min(bufcount, 1);
 	}
 	spin_unlock_irq(&file_data->err_lock);
 
@@ -1072,7 +1098,7 @@ static ssize_t usbtmc_ioctl_generic_read(struct usbtmc_file_data *file_data,
 
 	retval = usbtmc_generic_read(file_data, msg.message,
 				     msg.transfer_size, &msg.transferred,
-				     msg.flags);
+				     msg.flags, false);
 
 	if (put_user(msg.transferred,
 		     &((struct usbtmc_message __user *)arg)->transferred))
@@ -1377,7 +1403,8 @@ static ssize_t usbtmc_read(struct file *filp, char __user *buf,
 	struct usbtmc_file_data *file_data;
 	struct usbtmc_device_data *data;
 	struct device *dev;
-	const u32 bufsize = USBTMC_BUFSIZE;
+	u32 bufsize = USBTMC_BUFSIZE;
+	bool full_buffer;
 	u32 n_characters;
 	u8 *buffer;
 	int actual;
@@ -1390,6 +1417,9 @@ static ssize_t usbtmc_read(struct file *filp, char __user *buf,
 	data = file_data->data;
 	dev = &data->intf->dev;
 
+	if (data->packet_io)
+		bufsize = data->wMaxPacketSize;
+
 	buffer = kmalloc(bufsize, GFP_KERNEL);
 	if (!buffer)
 		return -ENOMEM;
@@ -1488,6 +1518,8 @@ static ssize_t usbtmc_read(struct file *filp, char __user *buf,
 
 	remaining = n_characters;
 
+	full_buffer = actual == bufsize;
+
 	/* Remove the USBTMC header */
 	actual -= USBTMC_HEADER_SIZE;
 
@@ -1504,11 +1536,12 @@ static ssize_t usbtmc_read(struct file *filp, char __user *buf,
 		goto exit;
 	}
 
-	if ((actual + USBTMC_HEADER_SIZE) == bufsize) {
+	if (full_buffer) {
 		retval = usbtmc_generic_read(file_data, buf + actual,
 					     remaining,
 					     &done,
-					     USBTMC_FLAG_IGNORE_TRAILER);
+					     USBTMC_FLAG_IGNORE_TRAILER,
+					     data->packet_io);
 		if (retval < 0)
 			goto exit;
 	}
@@ -2378,6 +2411,12 @@ static void usbtmc_free_int(struct usbtmc_device_data *data)
 	kref_put(&data->kref, usbtmc_delete);
 }
 
+static bool usbtmc_packet_io_ok(u16 maxpacket)
+{
+	return maxpacket >= USBTMC_HEADER_SIZE && maxpacket < 512 &&
+	       !(maxpacket & 3);
+}
+
 static int usbtmc_probe(struct usb_interface *intf,
 			const struct usb_device_id *id)
 {
@@ -2429,8 +2468,15 @@ static int usbtmc_probe(struct usb_interface *intf,
 	dev_dbg(&intf->dev, "Found bulk in endpoint at %u\n", data->bulk_in);
 
 	data->bulk_out = bulk_out->bEndpointAddress;
+	data->out_wMaxPacketSize = usb_endpoint_maxp(bulk_out);
 	dev_dbg(&intf->dev, "Found Bulk out endpoint at %u\n", data->bulk_out);
 
+	/* Packets must carry the header and keep writes 32-bit aligned */
+	data->packet_io = usb_match_id(intf, usbtmc_packet_io_devices) &&
+			  data->usb_dev->speed == USB_SPEED_HIGH &&
+			  usbtmc_packet_io_ok(data->wMaxPacketSize) &&
+			  usbtmc_packet_io_ok(data->out_wMaxPacketSize);
+
 	/* Find int endpoint */
 	retcode = usb_find_int_in_endpoint(iface_desc, &int_in);
 	if (!retcode) {

-- 
2.53.0

