Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5873BB9E0;
	Tue, 15 Sep 2026 12:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476036; cv=none; b=YXoptCsXpVd91jZGnjaIc8oSADNcL09dIBB6G9VLuyK0vXpKnwpeRQ2owOFSOqvdw57NDpHPFeGBTfnl64FBNKzSdf+JfxJfwwC3ojIYRSVRVmCpAVkkRjcRXdoGU/3NqLE4qHJNdiZgiaVKhPioJqiyLonCEwTe0/DJ+Nz5C1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476036; c=relaxed/simple;
	bh=BJT96WdpoTYg1mrvs2FJBIkYL9ipWM4ZwsTWOOa+HiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UsipktNvDGtUXb+CCgdYfoPFwuAzAfNqNYA91NRc0IsITrlLaIg1kIMZcNvFwuALQhXrFc4EqGc1lpbUGLvoO9EO5Xck6cvRuaLklV5fSgVaj6QuJk11ACSZGMV2upEADYxXGAe8Tg1PEIReX4GCTaSblA1K8k0tIu3N1/x3JY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtCS7682; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtCS7682"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B87601F000FF;
	Tue, 15 Sep 2026 12:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789476034;
	bh=LjLl7wY41qwcnZfUWfKo1m3T60O9v0bsQzCwwo7kMBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QtCS7682CH3DlD1hVH2QgNx5f731gmblH01hXHupM5KEKbYKy8MIeTYpqiqICfF8h
	 Akhli9YuyjJY5voQfnQEcMjew5RlyFr87hTxsMZ1G1z7LcNiGHlhFRobdxvPMTgpoG
	 q1/i8ZDR8G8ZhX9RPRZaWUI15R64CD8Ps+xXV9Ea/2pQs8SUvwpfnZsoFzNPm/h098
	 iY/q4x/kf/AH2o4yuyqsrWFI7bAkQ1AG62d2KD9EI/31m9P/FXPrQemI2WST8mLGzO
	 XOOyfFaxten5xgL4hmN1jNJVa0pV4blikKeaji25Dai5+fVoWEvhcGzXALY3nW55Rt
	 5xuhdvNuLgc+g==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x6SSc-00000005fOp-1UyE;
	Tue, 15 Sep 2026 14:40:30 +0200
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bill Pemberton <wfp5p@virginia.edu>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] USB: serial: ssu100: fix baud rate overflow
Date: Tue, 15 Sep 2026 14:40:11 +0200
Message-ID: <20260915124012.1350748-2-johan@kernel.org>
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

Use 32 bits for the rate and remainder while rejecting rates outside of
[50,460800] to avoid having the divisor or remainder overflow.

This issue was flagged by an LLM.

Fixes: 52af95459939 ("USB: add USB serial ssu100 driver")
Cc: stable@vger.kernel.org	# 2.6.36
Cc: Bill Pemberton <wfp5p@virginia.edu>
Assisted-by: LLM
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/ssu100.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/serial/ssu100.c b/drivers/usb/serial/ssu100.c
index b0d51558b73c..8c5b9ef708b3 100644
--- a/drivers/usb/serial/ssu100.c
+++ b/drivers/usb/serial/ssu100.c
@@ -32,6 +32,7 @@
 
 #define  SERIAL_EVEN_PARITY         (UART_LCR_PARITY | UART_LCR_EPAR)
 
+#define  MIN_BAUD_RATE              50
 #define  MAX_BAUD_RATE              460800
 
 #define ATC_DISABLED                0x00
@@ -217,9 +218,10 @@ static void ssu100_set_termios(struct tty_struct *tty,
 {
 	struct usb_device *dev = port->serial->dev;
 	struct ktermios *termios = &tty->termios;
-	u16 baud, divisor, remainder;
+	speed_t baud, remainder;
 	unsigned int cflag = termios->c_cflag;
 	u16 urb_value = 0; /* will hold the new flags */
+	u16 divisor;
 	int result;
 
 	if (cflag & PARENB) {
@@ -235,6 +237,18 @@ static void ssu100_set_termios(struct tty_struct *tty,
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
 	dev_dbg(&port->dev, "%s - got baud = %d\n", __func__, baud);
 
 
@@ -310,7 +324,7 @@ static int ssu100_open(struct tty_struct *tty, struct usb_serial_port *port)
 		dev_dbg(&port->dev, "%s - set uart failed\n", __func__);
 
 	if (tty)
-		ssu100_set_termios(tty, port, &tty->termios);
+		ssu100_set_termios(tty, port, NULL);
 
 	return usb_serial_generic_open(tty, port);
 }
-- 
2.55.0

