Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050420;
	b=YUMKBpNiN0Q3JPJOEAbI1F/VrqJBYcid937rVrz5QsZTzcMI7Qq45NMPMsiFJs9m0hqZ
	 t4wv6d6M3NFefaLGZasdlm9fT3AGttTGW/89gTD7jxFHsstsijN1Pu12IIc8Q4mjOb1tX
	 K1bcpDwkEjZsZLt5YtSFMDrW9gOilQx+WjNCapu4x4+exEgBe0Ye5XGcbpO6QvXD/lIjK
	 1aEhgqHjUrHuH0UJXPS4+ZZw2qSBhSnXdVrYmFCz4k9gzasr0gqilNKYvWEnBGq4tU5nx
	 gv+Oi2jIWSv8OkfHpmFKmMiziv642+2czaRHHxkh4eroeD3BzOTQft3FERNI+i54GLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050420;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=7lJq3zjrCdb3/Kci2Xd2dr95m6yoQ8Kd15x70oIxTkk=;
	b=apgkOwmTvbGw213zfpoUavYzmAX3+utQxToaPCG59s05pdFr3Ar+xLiQjsHDjE0yTF7P
	 CuH/p7GYSXR7b7tMbz+cmyAY+W/gl32/Tcq8z8ktnG0UFcJOMjWpqDBp7WMsyG+3XCoJf
	 W6ojQpIIiD4JnJn6GLVIQ+xH6mib0mzO9Kr8WIlz2b8kGZaKhsJBfe2vdEpW3P/Fxxvdr
	 gH8IrgGjcV/hlDrjSpZLcvJLr0CFNlyVCf9eLtG5ScKaBACP05fJS8M50SpLs8gxM7LGj
	 peLTmWodF0mKTpZU1GtIC3lmpCzuY6IZ2BI6D2pc+Jc8uMSIXzldvBmyir0RshlH+4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=QgllUKZ2;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFBB606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AFBB606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=QgllUKZ2
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 561E8A1583;
	Sat, 07 Nov 2026 12:20:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1794050415; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=7lJq3zjrCdb3/Kci2Xd2dr95m6yoQ8Kd15x70oIxTkk=;
	b=QgllUKZ2uka+e91jCfzxbNQIFiRISN3sR8iJsbWES0AkYPX7Q1lDhqzi7pGa3DERNXPd3r
	k2V75VjkI5t7HTBODtVEELkG1d9XYpY2Ylm/bs1eLeHdJ4acofnb26BmNyHsYTjFqShsAh
	E30xEiZE+Ozv5HOv/QkK6mgGxxwvCH4zph0QPoAiPBtzhFcbub37dtiah5zwer+9NwcbkE
	XDUh+GDSCJsAf0zKW4qwsna10NagSVGB2SVBDFhg4cNsVDE6QG2yZhdbnRPpP2iPsWtH1t
	qSQh5BzFQqPIeCdCVSB2jWbvWvNPXRIF/HcsGnQXYQU/QhX+QTfzO2lGjeWS6A==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: stable@vger.kernel.org
Cc: Nicolai Buchwitz <nb@tipi-net.de>,
	stable@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.6.y] serial: amba-pl011: keep transmitter enabled when disabling RS485
Date: Sat,  7 Nov 2026 12:20:10 +0100
Message-ID: <c649ede67d8a2e4bb0c86e322bc07eda86c1ae5c.1794050290.git.nb@tipi-net.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053504-failed-6.6-97f85204275a@kernel.org>
References: <20261107053504-failed-6.6-97f85204275a@kernel.org>
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
index 17b8b56565194..d7dbd4c0eae15 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2242,8 +2242,21 @@ static int pl011_rs485_config(struct uart_port *port, struct ktermios *termios,
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

base-commit: 5139929c698c273e07cb0635732f6a918a7b8e78
-- 
2.53.0

