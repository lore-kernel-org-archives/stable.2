Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050383;
	b=f1OcRMdqopn9eOnE3ROInK9hkP7CM/Axlu6bxFHO94MnbLYpUjv/hErZ834o6GP6IElU
	 TF8aDdTm05GihPQeOHU+uu9ygm1hXKMRrODuE0//S0r3V4CJYO8nPBs7Lkh/3Ve9k166o
	 GAV7RZU5hPMbD+yIzLnmQX7oWNOISNQ/LrGjLLLzx3qtcDQk0P7+TcDl4mSozBemrvHc6
	 lIuwNTn39RDDGlhqzrcjH3xBBeNNR6Mey1VBBfq038GHnA+Z8lm6WAUcNRxQ1RS33eY/d
	 N9XZLmg1zAHmvvBzu7qbnTM3y/PKyA88GGhxZrMEWqsMYwY74FqEygu8CSuU+/XdPhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050383;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=OBCxO6UnSn43VJ7OPyNToXRlmZ0mZ13qRVn6nJqSntM=;
	b=vkEzBf+RyftGxhNmjXoIuz2BJKBIf7PdpNMd9MAtp2/fXf2WalLFp34mOUyaZih+wzvb
	 u9fNGKwmfOChzuRgdULyTiBLszTL9A3VVXazEgZgogyN7QF2a84rJILKqT3axqGvL31Mc
	 9yhAYHL2Sa0mxu7XpJVprOt+fYoOP++29snIHQbiFIRWZ4x4YGnh9RSu2AArxBAwdFtNC
	 bJmiax0ACfMl7ewXI5aPZyRyjsC3zDZU9OBrN1tUh8JYQOifEZEOIwwT5lvojK1L4AH2I
	 bOc83dWDv9FMokN2fBVqGnRc979LGxDV1C0rF0WdK4nvvGY4TpPClVDsjWTAkwgrKNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b="17o/qz/I";
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E63D606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:19:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E63D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=17o/qz/I
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6B86BA02C3;
	Sat, 07 Nov 2026 12:19:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1794050372; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=OBCxO6UnSn43VJ7OPyNToXRlmZ0mZ13qRVn6nJqSntM=;
	b=17o/qz/IlLzh00QBb54u5bpCmPp3RX/yaXGT/+/NKoX48tBIirNdMeIU7+jbQdx/3upgh2
	fUtKvEcrtHMzTd6BTEBhDcOK4lw0KhqtZi0FkBz7lQxkqIlLloHa6cH4nJHC3gca4N20X8
	LYIxQZvboz3fxp+ZWljWmPdTUwnjIDN7pSNOiwvdhJsAthVHdevAW5eDw57ZKNCVVXRR/l
	q2xZygcxtbRdGRem2oof1cPnh0qKCz/y2U2kabWwSnSDmZoLMacnQnzFDckM4B1jKMg7ga
	ruEirTQkKDd/7UYp2zQxuUHdpxUKXOJINghQ+PHTa452B/EMIn7FlWoxFDze9w==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: stable@vger.kernel.org
Cc: Nicolai Buchwitz <nb@tipi-net.de>,
	stable@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.12.y] serial: amba-pl011: keep transmitter enabled when disabling RS485
Date: Sat,  7 Nov 2026 12:19:12 +0100
Message-ID: <e4c9ee387b1009df337f3a98da5ecf1216b4c04a.1794050290.git.nb@tipi-net.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052237-failed-6.12-97f85204275a@kernel.org>
References: <20261107052237-failed-6.12-97f85204275a@kernel.org>
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
index 3e1932a3bfbbd..a0e20bffefba8 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2224,8 +2224,21 @@ static int pl011_rs485_config(struct uart_port *port, struct ktermios *termios,
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

base-commit: 5c40a1750f44dd6c7292d8c8d0b4ffff1734576e
-- 
2.53.0

