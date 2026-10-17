Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB95738A736;
	Sat, 17 Oct 2026 06:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792217898; cv=none; b=fzC1o/yaKQ1s5clKyXlsgbltI+O7fS7C4oEh6Z25Cm4YnIYaHSjkDA9XgJaqJ3AIGYVHehbCYmVmr6/aPEolBD3CO2ZndygWmdDmTxFb5qXfFUIv9NGRi12vj2yR5KoQuh2rkzhass1Zo+mDptgFknfm+v9adfoj5gixHwDl/Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792217898; c=relaxed/simple;
	bh=92PihwIrcm9Bn4OhD6jLOBZHPXOkpOe4ZlLVlv4p/pQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MA9BRd0xfL4gYEyDIAJlgsU1J99J82axJirALX6rTy4ftJ9voHEWE0mA4j+EauCIa2MqOQrxLdYnGMNwMxS8DGMXhKBr5uQZIRXKu7/SDTcSvAzxaGGPlCOhuSALgovbXgbdd52ASTaYIL54LE5GS/wpyPuze5DVwlzsE4q+q38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=Rg7sLCW1; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="Rg7sLCW1"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B9BB0A158D;
	Sat, 17 Oct 2026 08:18:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792217894; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=42wKMMQFh3spqODjLGtklg6Rbi4rQOr5XxFcQu63PKA=;
	b=Rg7sLCW1vfO+t8S5x8aMnz7WNjD/EmlkyKaDOLYxOqvlosGo7544cKr+CDBnSemRjcGyp2
	ogg2Lf3nrs7m4aCnYsMRPnA8IypLrRbSmIMx3JWGDvmvb3qFcMJLdfEaxvfsaA1qx/1mCQ
	VfGaAFdw5ikySaQbY3dDHZNMZIrdjoKXReb7NLsHwNVFwblRT6XJejEcOrR5ZDIPcz5CFX
	InaPTSmUNOyeaESFML6svtT0TfBl4NvAZ2JHHJwrjhjMo/rYezC0+qi0kP/qFfg2CL9Hq+
	pplZjUpCH4edRdOK6dOCB16ywTErtMr1Eq8TSDBIoc4i/Kbgrl+SsB+2vQ5Y7g==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Sat, 17 Oct 2026 08:18:04 +0200
Subject: [PATCH v2 2/2] serial: amba-pl011: keep RS485 transmission running
 on reconfiguration
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-devel-nbuchwitz-pl011-rs485-reconfig-stall-v2-2-6f457a1ee527@tipi-net.de>
References: <20261017-devel-nbuchwitz-pl011-rs485-reconfig-stall-v2-0-6f457a1ee527@tipi-net.de>
In-Reply-To: <20261017-devel-nbuchwitz-pl011-rs485-reconfig-stall-v2-0-6f457a1ee527@tipi-net.de>
To: Russell King <linux@armlinux.org.uk>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Lino Sanfilippo <LinoSanfilippo@gmx.de>, 
 Nicolai Buchwitz <nb@tipi-net.de>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

Changing the RS485 settings while RS485 stays enabled calls
pl011_rs485_tx_stop(), also while a transmission is in progress. Unlike
pl011_stop_tx() it leaves the TX interrupt enabled, so the remaining
data is still pushed into the FIFO after the drain turned off the
transmitter. The FIFO never empties, the port stalls, and closing it
hangs in pl011_dma_shutdown() waiting for the transmitter to go idle.
A start still waiting for delay_rts_before_send is dropped as well.

Only stop the transmitter when no transmission is in progress. The
call is still needed there, it sets the idle RTS level when the port
is configured or resumed. A transmission in progress sets that level
when it ends.

An active break counts as a transmission too. Forget it only when
leaving RS485 mode, so that pl011_break_ctl() still ends the
transmission when the break ends.

Fixes: 8d479237727c ("serial: amba-pl011: add RS485 support")
Cc: stable@vger.kernel.org # 6.18.x
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/tty/serial/amba-pl011.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 3b9cce435c650..036a7245f1f29 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2506,8 +2506,6 @@ static int pl011_rs485_config(struct uart_port *port, struct ktermios *termios,
 		container_of(port, struct uart_amba_port, port);
 	bool tx_stopped = uart_tx_stopped(port);
 
-	uap->rs485_break = false;
-
 	/*
 	 * Output is marked stopped before stop_tx pauses DMA. Pause it now, so
 	 * that clearing TXE below cannot strand DMA data in the FIFO. Output
@@ -2521,6 +2519,8 @@ static int pl011_rs485_config(struct uart_port *port, struct ktermios *termios,
 		bool tx_pending = uap->rs485_tx_state == WAIT_AFTER_RTS;
 		u32 cr = pl011_read(uap, REG_CR);
 
+		uap->rs485_break = false;
+
 		/*
 		 * Leaving RS485 mode, which only enables the transmitter while
 		 * sending. Don't stop it, as that stalls a DMA transfer still
@@ -2543,7 +2543,9 @@ static int pl011_rs485_config(struct uart_port *port, struct ktermios *termios,
 		   tty_port_initialized(&port->state->port) &&
 		   pl011_tx_pending(uap, tx_stopped)) {
 		pl011_rs485_tx_resume(uap, rs485, tx_stopped);
-	} else if (port->rs485.flags & SER_RS485_ENABLED) {
+	} else if ((port->rs485.flags & SER_RS485_ENABLED) &&
+		   uap->rs485_tx_state == OFF) {
+		/* Set the idle level now, a transmission sets it when done */
 		pl011_rs485_tx_stop(uap);
 	}
 

-- 
2.53.0

