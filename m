Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14824483BFA;
	Mon, 19 Oct 2026 09:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792401268; cv=none; b=PWo1+3lxC3lkMqiB/rBqH3zn4mEs0+NkDs1HbF4DjKR7eL1Pqs7+qFpqV/IgLr311GA0CKhZaf4gj4cPVQUlwtg3YSaC6w4Xat7CIZ2lnVfTeqRL1y7AaSQGpWAZa24ego+xU846U0EJ+u87jmIToiDZ+FWA7CMY5iWITx/VS0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792401268; c=relaxed/simple;
	bh=yRXagBuaJxsDY2VfPZj52w7WTfhNTlSatMVfACzoS6A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pz+0gJLpGlWSJiP7Wu9MOMHQtazTfCCHtd+bW+fBoqmxOdqTy8Qt8loCoURb1Wh4rbAALiKAJb9AcJxV0ar+Dd5/kkPNIy0gO8cc3XROpatxYVy1Jbl16OwXAHg6Vk+rUlGK8hcFRR0F0vZGBJWWWj4x4w181AlQrakM/35wMPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=3f1GmWoQ; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="3f1GmWoQ"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D9BC2A161F;
	Mon, 19 Oct 2026 11:14:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792401262; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=D2FZhEuWGfcHkZJXHIKapH9bw99lywluT49CTI5wUOw=;
	b=3f1GmWoQnVOd66Sc9IZu5NHb0MX+VNhRDalIP867IF94aOb4aBW7oIoXL+965GHxIOHTzV
	HR1kjl2C8AJntdVk4wItWom7DrapsYQdP6Ya1bTAO0Bb3C8QBnmAuTslEH2yvdRUCgZ1AZ
	6R5gCkP2PZXQVqJzkpCmqPHwWPy5PZnvhiTeCDsIO/xzvmpVdYlElqP5TPTtNNyeWYxBdP
	cB63/kpBzm2gd7+XnqWyM6BbDPJlFwDPGySI2iJt5lzmim9KC92KStGddRgSaTcj52584e
	t95eQMzjv/y6i+uRpgQoIRG0Y2MLgQtHVF68u4eB+jx5vOIK6U2p5SIU8Le/xg==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Mon, 19 Oct 2026 11:14:13 +0200
Subject: [PATCH v3 2/2] serial: amba-pl011: keep RS485 transmission running
 on reconfiguration
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-devel-nbuchwitz-pl011-rs485-reconfig-stall-v3-2-072a9c82ea5e@tipi-net.de>
References: <20261019-devel-nbuchwitz-pl011-rs485-reconfig-stall-v3-0-072a9c82ea5e@tipi-net.de>
In-Reply-To: <20261019-devel-nbuchwitz-pl011-rs485-reconfig-stall-v3-0-072a9c82ea5e@tipi-net.de>
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
index 6adfe7a1e0487..14f0e8aa56fd2 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2513,8 +2513,6 @@ static int pl011_rs485_config(struct uart_port *port, struct ktermios *termios,
 		container_of(port, struct uart_amba_port, port);
 	bool tx_stopped = uart_tx_stopped(port);
 
-	uap->rs485_break = false;
-
 	/*
 	 * Output is marked stopped before stop_tx pauses DMA. Pause it now, so
 	 * that clearing TXE below cannot strand DMA data in the FIFO. Output
@@ -2528,6 +2526,8 @@ static int pl011_rs485_config(struct uart_port *port, struct ktermios *termios,
 		bool tx_pending = uap->rs485_tx_state == WAIT_AFTER_RTS;
 		u32 cr = pl011_read(uap, REG_CR);
 
+		uap->rs485_break = false;
+
 		/*
 		 * Leaving RS485 mode, which only enables the transmitter while
 		 * sending. Don't stop it, as that stalls a DMA transfer still
@@ -2550,7 +2550,9 @@ static int pl011_rs485_config(struct uart_port *port, struct ktermios *termios,
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

