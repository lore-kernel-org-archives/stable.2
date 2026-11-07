Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050440;
	b=S3S9Wyy8vZqvGqbecobaHwdKrqm9o/30/BWn9udtHnP4J3QMkD+hY8crxMyKtnoq9O2l
	 e6CjL9yWHT9vmVxpM7xPY+EQMtfhlET8kznk0uzSc+N0C/oV94ptwd76cs0kGq8M6RdIi
	 XKCYmHv7mWqiK4ntRMKbsBK4ivp6pEGQofAW9Mbnq4F+YAmX4UW51xsQ5wwaZ2ILqwxG0
	 GNoATzU1B7RDfq3hH0IULt0w86uT8c3icX71UIPE5uDV/9rcWNQlRuF9FtW+mGHZMXsvc
	 VXgVmEQBTh+CFzLH1f1dFUIXaVJ42kjsoADYNDaxtXRcImT6fjN86baGaxduLGfMjuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050440;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=23XVQE8Kiox2DwvSX/4HrjcRUZW8WbAIO+60d+0WAWQ=;
	b=3M3DqBNaC0nFHfCfhratTBT191gMiT5rpZCzJbWFKyChlp5TSoUkBh1micPVPYIORcNf
	 DuIAREGeRt0nFXFEW7h86W8J/9l8e+00go/ijkAccbL8BgKVtAfutU2ehQH1yOu8n2zgW
	 t0faaqKA2u4xbVUnJFNasyx+/CY3QkvtCDCdBcSrZ2nkD0huGMXbO+HumQEsDMPefxx17
	 Hr+SjC3N6U7CI+PPhgcI7y/bT7aMDjp4kQkaQK2gEGnHDRhDCR8TmzQ4wWT/pEVrt8wfc
	 smY0T5MZpqLDE3WiLbIJ5swo3P0TbMCj/1oemnAii6IA4j9rwayiBtL1+usZUcg1w/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=WtfChfIx;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57708606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:20:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57708606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=WtfChfIx
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CFC0DA1583;
	Sat, 07 Nov 2026 12:20:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1794050437; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=23XVQE8Kiox2DwvSX/4HrjcRUZW8WbAIO+60d+0WAWQ=;
	b=WtfChfIxrCNDLg2j+BFkV6EMP5Syua++J8jqM9892a8ZgMrHSpfl0tFu4Zgto6Cy1AMrCe
	UkxvtlOflu791qVknmf83o6J5IBxQ6jEdj8MAImqUhhYjx1HMXKt1jtFF18ulwEQA6HVLF
	iIYyTe119NZdHiUqUr5Fm/M9JlbXUoWZ2+qkLghGyaJ/9VJsiAW8ENZnRvBiGBIET0Zxgt
	P96Cictl6d+mGcKu7IKIgF1eyLDOF8Y/x22ATFDc2erYb4IIpbMgrNLsMq0X2NxzWG1WaG
	k8BCmviIxghMIGyoV6E32dt/obsfC+6+XB2T96Mq88WPqsttWtqj9Y3gb3dzLQ==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: stable@vger.kernel.org
Cc: Nicolai Buchwitz <nb@tipi-net.de>,
	stable@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.1.y] serial: amba-pl011: keep transmitter enabled when disabling RS485
Date: Sat,  7 Nov 2026 12:20:26 +0100
Message-ID: <7a904030ebf7bf315685f21f5b57fb4e6938a46e.1794050290.git.nb@tipi-net.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054856-failed-6.1-97f85204275a@kernel.org>
References: <20261107054856-failed-6.1-97f85204275a@kernel.org>
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
X-Last-TLS-Session-Version: TLSv1.3

commit 97f85204275ae4d7fb530e451f3acc65c1ec1155 upstream.

Disabling RS485 on an open port calls pl011_rs485_tx_stop(), which
turns off the transmitter. Only the RS485 TX path turns it back on, so
any later output stays queued and tcdrain() hangs until the port is
closed.

pl011_rs485_tx_stop() also checks only the hardware FIFO. If a DMA
transfer has started but has not filled the FIFO yet, the transmitter
is turned off under the transfer and the DMA channel never recovers.

When leaving RS485 mode, cancel pending deferred starts and stops, leave
the transmitter enabled and start any TX that was still waiting for
delay_rts_before_send.

Fixes: 8d479237727c ("serial: amba-pl011: add RS485 support")
Cc: stable@kernel.org
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
Link: https://patch.msgid.link/20261012-fix-pl011-rs485-txe-v2-1-e9bf7d218389@tipi-net.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[nb: Use rs485_tx_started and omit timer handling on older kernels.]
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/tty/serial/amba-pl011.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index d61ecbb06d94e..ca970fad7f103 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2235,8 +2235,21 @@ static int pl011_rs485_config(struct uart_port *port, struct ktermios *termios,
 	struct uart_amba_port *uap =
 		container_of(port, struct uart_amba_port, port);
 
-	if (port->rs485.flags & SER_RS485_ENABLED)
+	if ((port->rs485.flags & SER_RS485_ENABLED) &&
+	    !(rs485->flags & SER_RS485_ENABLED)) {
+		u32 cr = pl011_read(uap, REG_CR);
+
+		/*
+		 * Leaving RS485 mode, which only enables the transmitter while
+		 * sending. Don't stop it, as that stalls a DMA transfer still
+		 * in flight. Keep the transmitter and receiver enabled.
+		 */
+		uap->rs485_tx_started = false;
+		cr |= UART011_CR_TXE | UART011_CR_RXE;
+		pl011_write(cr, uap, REG_CR);
+	} else if (port->rs485.flags & SER_RS485_ENABLED) {
 		pl011_rs485_tx_stop(uap);
+	}
 
 	/* Make sure auto RTS is disabled */
 	if (rs485->flags & SER_RS485_ENABLED) {

base-commit: c75b0cf0982c00cddfd88d1acf3872f79b40980c
-- 
2.53.0

