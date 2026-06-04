Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D163E275F
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 12:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780575104; cv=none; b=BGmP71/JNoa24AJJHIaq8Z+y5JKW9kejmtXzLEpXurcTA2U1QmDG0Fz8I2ToQmsbof9JVoI1o2xzyNaoFR4uteSSVKB0/Jxwvpvg2SJ8fPhxhI5c0b80+wpYD02HgbDft7wKk9iuQr9CuY8l0bjJuvuP2kIa/WnOr6xrx1Dfh/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780575104; c=relaxed/simple;
	bh=MATNYRjbOQHWoQWtTBzRQXdf7Ds7t7sQzUaUTlaSSuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bENSuPFrCDhv6kVz/xxA1HKO23OV8XU/J8l+sh0+/1WqHGmMK03RfPBhNHJtZdOSnxGVgLj09enGjmh1CbW+RWPnKa2hiYMOnMj3vUEPWXrkGx2mARZAXdzdkTfVlCsjFF1nyY1a0b0RaCFOmwI/rUOomD9/PRsvaM+YSfc3bx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbVU/Upc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbVU/Upc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7601F00893;
	Thu,  4 Jun 2026 12:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780575103;
	bh=y5/Ml3r7ezO5x6yZw9e2cVnqJ2v+OLdac6V7BRUJqAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DbVU/UpcgsxEpZEeuD81NKtCy/5e6FJxn+RLKTY72MvEwVOYvSmD5FolO9ZUapgV5
	 kpFuEzmch7ByQ4nWtHDpy06UbU6OTaytF61+KXPpshhRbyCkga+CCAc1H4v7Ej4xMb
	 M6dse6XpOP9ljj5V49PUKh0Ncv5pKljh4lbec296FuwSw+l3+sIjDO7whqUA8ts7ZQ
	 2Fnl1g2jQLydWtdVb8BhQe5fckZDWLHWUcUw+rxZVBOunefyBa9MbJfvXQlRDWytjK
	 WBrAnrdy2nWEb+9ohzPbKfITzso5/pcgSsVyf9H70Js1YN++1RMXqVtadclgzgADTH
	 1BCtVBfXUA9qQ==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wV6vF-0000000Bd4q-1gxQ;
	Thu, 04 Jun 2026 14:11:41 +0200
From: Johan Hovold <johan@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.18.y] USB: serial: mct_u232: fix memory corruption with small endpoint
Date: Thu,  4 Jun 2026 14:11:33 +0200
Message-ID: <20260604121133.2771807-1-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060400-renewal-coagulant-3a75@gregkh>
References: <2026060400-renewal-coagulant-3a75@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 915b36d701950503c4ea0f6e314b10868e59fce3 upstream.

The driver overrides the maximum transfer size for a specific device
which only accepts 16 byte packets for its 32 byte bulk-out endpoint.

Make sure to never increase the maximum transfer size to prevent slab
corruption should a malicious device report a smaller endpoint max
packet size than expected.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/mct_u232.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/serial/mct_u232.c b/drivers/usb/serial/mct_u232.c
index 2bce8cc03aca..b0b299c5e8a3 100644
--- a/drivers/usb/serial/mct_u232.c
+++ b/drivers/usb/serial/mct_u232.c
@@ -378,6 +378,7 @@ static int mct_u232_port_probe(struct usb_serial_port *port)
 {
 	struct usb_serial *serial = port->serial;
 	struct mct_u232_private *priv;
+	u16 pid;
 
 	/* check first to simplify error handling */
 	if (!serial->port[1] || !serial->port[1]->interrupt_in_urb) {
@@ -385,6 +386,16 @@ static int mct_u232_port_probe(struct usb_serial_port *port)
 		return -ENODEV;
 	}
 
+	/*
+	 * Compensate for a hardware bug: although the Sitecom U232-P25
+	 * device reports a maximum output packet size of 32 bytes,
+	 * it seems to be able to accept only 16 bytes (and that's what
+	 * SniffUSB says too...)
+	 */
+	pid = le16_to_cpu(serial->dev->descriptor.idProduct);
+	if (pid == MCT_U232_SITECOM_PID)
+		port->bulk_out_size = min(16, port->bulk_out_size);
+
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
@@ -410,7 +421,6 @@ static void mct_u232_port_remove(struct usb_serial_port *port)
 
 static int  mct_u232_open(struct tty_struct *tty, struct usb_serial_port *port)
 {
-	struct usb_serial *serial = port->serial;
 	struct mct_u232_private *priv = usb_get_serial_port_data(port);
 	int retval = 0;
 	unsigned int control_state;
@@ -418,15 +428,6 @@ static int  mct_u232_open(struct tty_struct *tty, struct usb_serial_port *port)
 	unsigned char last_lcr;
 	unsigned char last_msr;
 
-	/* Compensate for a hardware bug: although the Sitecom U232-P25
-	 * device reports a maximum output packet size of 32 bytes,
-	 * it seems to be able to accept only 16 bytes (and that's what
-	 * SniffUSB says too...)
-	 */
-	if (le16_to_cpu(serial->dev->descriptor.idProduct)
-						== MCT_U232_SITECOM_PID)
-		port->bulk_out_size = 16;
-
 	/* Do a defined restart: the normal serial device seems to
 	 * always turn on DTR and RTS here, so do the same. I'm not
 	 * sure if this is really necessary. But it should not harm
-- 
2.53.0

