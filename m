Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792506829;
	b=a+Ig5CxT47m4ZeJvSfvAKsd3XaMuq0dg41fQDiEaRrBg6OnuR8kZcu/zI22iCjYCyS7q
	 UrGuNsFSNcbp5cKR+e5lttNy05arFovqIwdDjAqfTr8GvN4gnaPgBzl1SmosbMHB2iJ65
	 3BlGbotSNk3JoW1M/eW++ZAmeBNBsl2iU8VJqx0hmwAPitKZFJ9B5IGB8sgBXhren8O5G
	 P+xmoyfVgQyTCBD9d7Hr49E7Wmu5rH31WHFwsgBwyjOGMN5mnMAiRbzAPo5Wk2KUcn2eR
	 QluTR7zK4nOM0Dsu2MdLaHKFtC2SI1opj+uWlA+sgNoY3B1A32iLO/meGC5K5wpbyCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792506829;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=jCLU6VpZB9zkK3E06QIoKskBS0pUXooDENBfFnNVqbM=;
	b=Zeup72nA7UXINRRGLjh6fNL6km84gTriFRfTRJmYz8gJku4cZKMk6GSrbpGQw8Rm8z42
	 EtP3W3GjCfefd7p5/mdpo2P76PifUngNi1oQqHY66Pt+7LhU/zFKWH71DKn1FG7gxL4Fd
	 lQn3rvENBRbj+BE38EtQkGCwuy0oF6RS9hMfUVQfb8MoqxaZBruxzgQosKlWIVNLQggor
	 nQ5xFW0SVH2CZ7s6bXpTUdPJ5WXqlPD/mMMUqqFvuLFpzxZDQ5O1M/UWwxQ5QiizYcXfH
	 efHnfxvrqfRRFO48jLzLAIoHjnXlZpunEV4O9Ki4mcp3bcUB19VM2beOUF9bAfLrmTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=IZkNM48P;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A07606A32E;
	Tue, 20 Oct 2026 14:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7A07606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=IZkNM48P
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 324E4A1625;
	Tue, 20 Oct 2026 16:33:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792506827; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=jCLU6VpZB9zkK3E06QIoKskBS0pUXooDENBfFnNVqbM=;
	b=IZkNM48PzIjfkC5GK52WuO40FLo5/cd8mccfgiDsUFOknM/uqlsMa25IdSVR6xgFBF/VoD
	sDYWlKgCkibREauewxVdFEG1t73bonPoUErHJas5C6xzDiM2bFYPoRKDyBeOeRIBiY/IN1
	IVK8MlRzQQaaYulYtvUZQdG/z+uJmvPC1y5+34jGIvTBOkRlLWzOXMeyvZ2KekAZhsMa7h
	cITxlImO0TDvrZLZe8IDJy06WueE+1Hr6ePv3ikaNPBo+M/9tlgAxd4+f007q+mP08E1FF
	fB9E7LuB1s80eY2BKzLnO+PpTIf8CAOpD7SmKWadBgzCOBtfN+vZDyBxU3gJyQ==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Tue, 20 Oct 2026 16:33:39 +0200
Subject: [PATCH 2/4] usb: usbtmc: handle undersized high-speed bulk OUT
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
Message-Id: <20261020-fix-usbtmc-short-packets-v1-2-903f4d029193@tipi-net.de>
References: <20261020-fix-usbtmc-short-packets-v1-0-903f4d029193@tipi-net.de>
In-Reply-To: <20261020-fix-usbtmc-short-packets-v1-0-903f4d029193@tipi-net.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Steve Bayless <steve_bayless@keysight.com>, 
 Guido Kiener <guido@kiener-muenchen.de>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolai Buchwitz <nb@tipi-net.de>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

The Siglent SDM4065A-SC hangs its OUT endpoint when xHCI sends a packet
larger than the 64 bytes it advertises. Every transfer after that times
out until a USB reset:

  usbtmc 1-1.3:1.0: Unable to send data, error -110
  usbtmc 1-1.3:1.0: send_request_dev_dep_msg_in returned -110

Limit usbtmc_write() to URBs of the advertised packet size on this
device and send them one at a time. Some devices with this bug also
stall on back-to-back OUT packets.

Cc: stable@vger.kernel.org
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
The write path never handled this device, so there is no Fixes: target.
---
 drivers/usb/class/usbtmc.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index 7a2ea14aa524b..679ab5908e203 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -1145,14 +1145,15 @@ static ssize_t usbtmc_generic_write(struct usbtmc_file_data *file_data,
 				    const void __user *user_buffer,
 				    u32 transfer_size,
 				    u32 *transferred,
-				    u32 flags)
+				    u32 flags, bool packet_mode)
 {
 	struct usbtmc_device_data *data = file_data->data;
+	const u32 bufsize = packet_mode ? data->out_wMaxPacketSize :
+					  USBTMC_BUFSIZE;
 	struct device *dev;
 	u32 done = 0;
 	u32 remaining;
 	unsigned long expire;
-	const u32 bufsize = USBTMC_BUFSIZE;
 	struct urb *urb = NULL;
 	int retval = 0;
 	u32 timeout;
@@ -1190,6 +1191,14 @@ static ssize_t usbtmc_generic_write(struct usbtmc_file_data *file_data,
 		u32 this_part, aligned;
 		u8 *buffer = NULL;
 
+		/* Some packet mode devices stall on back-to-back OUT packets */
+		if (packet_mode &&
+		    !usb_wait_anchor_empty_timeout(&file_data->submitted,
+						   timeout)) {
+			retval = -ETIMEDOUT;
+			goto error;
+		}
+
 		if (flags & USBTMC_FLAG_ASYNC) {
 			if (down_trylock(&file_data->limit_write_sem)) {
 				retval = (done)?(0):(-EAGAIN);
@@ -1309,7 +1318,7 @@ static ssize_t usbtmc_ioctl_generic_write(struct usbtmc_file_data *file_data,
 
 	retval = usbtmc_generic_write(file_data, msg.message,
 				      msg.transfer_size, &msg.transferred,
-				      msg.flags);
+				      msg.flags, false);
 
 	if (put_user(msg.transferred,
 		     &((struct usbtmc_message __user *)arg)->transferred))
@@ -1605,6 +1614,9 @@ static ssize_t usbtmc_write(struct file *filp, const char __user *buf,
 	buffer = urb->transfer_buffer;
 	buflen = urb->transfer_buffer_length;
 
+	if (data->packet_io)
+		buflen = data->out_wMaxPacketSize;
+
 	if (count > INT_MAX) {
 		transfersize = INT_MAX;
 		buffer[8] = 0;
@@ -1671,7 +1683,7 @@ static ssize_t usbtmc_write(struct file *filp, const char __user *buf,
 
 	/* call generic_write even when remaining = 0 */
 	retval = usbtmc_generic_write(file_data, buf + transfersize, remaining,
-				      &done, USBTMC_FLAG_APPEND);
+				      &done, USBTMC_FLAG_APPEND, data->packet_io);
 	/* truncate alignment bytes */
 	if (done > remaining)
 		done = remaining;

-- 
2.53.0

