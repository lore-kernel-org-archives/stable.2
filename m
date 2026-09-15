Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483D73B8D7E;
	Tue, 15 Sep 2026 12:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476036; cv=none; b=Mrfr9iWlgXKgofvgEuSPjfuRCxQ3JpcI2mIUhTqCkMT4eCEFqx5L8sSwvIZEYh3eVtvpOhXAX3RT2PcJN2gscO2cZsozcOVi+kTVy3c2NmFMVsjbDSHQtMeeGrMoUOalZW3W3nKAT4PWz56hokbA5xD00tEaxaU4pbT3F6SPFvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476036; c=relaxed/simple;
	bh=snT6Yz9RSt19k2+lENWpwl0vksvJTAQQkBH3UvjeBWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJ7SfNKWN7n/iVa7zFyP0qDwPVogiDPExu6lc+CEjIFy1BSsekczpglh2/vi7uhJcJjOZgnG1Piv3Ki3D3s2ogAA/cg9CSvXVUDOWmk5qUFA6OhTyMeFuZQDQp/3y5Ea401GhUBE9PZqPFKLyOh/U/dwpSJsbkU8KkKpL8r5KcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KE5xeMCb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KE5xeMCb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0D51F00898;
	Tue, 15 Sep 2026 12:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789476035;
	bh=5kziq8mwhiUUnzUkkV2DS+y2m3ZeYHn6bUEVx6OwQWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KE5xeMCbR/Vk0h6jiSGr9UWEWm5APziOdEjfyicr9wAlRPmQfNAGELW3Uk4y4sHzX
	 r89RA8GcNJhgdOAtU8xJTiYj05nHch6r6gLj38LczFrS+S6A1n71T0kQc9nmiu0oUB
	 s9PDmikKMtTfwg6WfPRScNQm5hNTNYsELI+Oo1htuMuMIEqeSAIL90bjcQZ652yxpg
	 g5jE34XccdtaLoQ0s3eIT+PKKCJMr03jVCAye4w5jQsE+5dFhtbxj+795vY9nXHogJ
	 np8msI3Zz8SGPokp4wSCEIbh4cFAGtxkQfTdTQ/PqoJnuiB7JN8ylb0lrsEtzFHP1E
	 3k/0SjHLC6psg==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x6SSc-00000005fOs-1Y24;
	Tue, 15 Sep 2026 14:40:30 +0200
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bill Pemberton <wfp5p@virginia.edu>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] USB: serial: quatech2: fix baud rate overflow
Date: Tue, 15 Sep 2026 14:40:12 +0200
Message-ID: <20260915124012.1350748-3-johan@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915124012.1350748-1-johan@kernel.org>
References: <20260915124012.1350748-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The requested baud rate is incorrectly truncated to 16 bits so that
line speeds above 65535 bps cannot be set.

Use 32 bits for the rate while rejecting rates outside of
[50,921600] to avoid having the 16-bit divisor overflow.

Fixes: f7a33e608d9a ("USB: serial: add quatech2 usb to serial driver")
Cc: stable@vger.kernel.org	# 3.5
Cc: Bill Pemberton <wfp5p@virginia.edu>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/quatech2.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/serial/quatech2.c b/drivers/usb/serial/quatech2.c
index dc2b39810a26..3b4df3ac7c73 100644
--- a/drivers/usb/serial/quatech2.c
+++ b/drivers/usb/serial/quatech2.c
@@ -52,6 +52,7 @@
 #define QT2_XMIT_FLUSH      0x05  /* no following info */
 #define QT2_CONTROL_ESCAPE  0xff  /* pass through previous 2 control bytes */
 
+#define  MIN_BAUD_RATE              50
 #define  MAX_BAUD_RATE              921600
 #define  DEFAULT_BAUD_RATE          9600
 
@@ -156,7 +157,7 @@ static inline int calc_baud_divisor(int baudrate)
 
 static inline int qt2_set_port_config(struct usb_device *dev,
 				      unsigned char port_number,
-				      u16 baudrate, u16 lcr)
+				      speed_t baudrate, u16 lcr)
 {
 	int divisor = calc_baud_divisor(baudrate);
 	u16 index = ((u16) (lcr << 8) | (u16) (port_number));
@@ -257,9 +258,9 @@ static void qt2_set_termios(struct tty_struct *tty,
 	struct usb_device *dev = port->serial->dev;
 	struct qt2_port_private *port_priv;
 	struct ktermios *termios = &tty->termios;
-	u16 baud;
 	unsigned int cflag = termios->c_cflag;
 	u16 new_lcr = 0;
+	speed_t baud;
 	int status;
 
 	port_priv = usb_get_serial_port_data(port);
@@ -277,6 +278,18 @@ static void qt2_set_termios(struct tty_struct *tty,
 	if (!baud)
 		baud = 9600;
 
+	if (baud < MIN_BAUD_RATE || baud > MAX_BAUD_RATE) {
+		if (old_termios)
+			baud = tty_termios_baud_rate(old_termios);
+		else
+			baud = clamp(baud, MIN_BAUD_RATE, MAX_BAUD_RATE);
+
+		tty_encode_baud_rate(tty, baud, baud);
+
+		if (!baud)
+			baud = 9600;
+	}
+
 	status = qt2_set_port_config(dev, port_priv->device_port, baud,
 				     new_lcr);
 	if (status < 0)
@@ -373,7 +386,7 @@ static int qt2_open(struct tty_struct *tty, struct usb_serial_port *port)
 	port_priv->device_port = (u8) device_port;
 
 	if (tty)
-		qt2_set_termios(tty, port, &tty->termios);
+		qt2_set_termios(tty, port, NULL);
 
 	return 0;
 
-- 
2.55.0

