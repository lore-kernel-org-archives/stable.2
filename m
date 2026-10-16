Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44FE42901D;
	Fri, 16 Oct 2026 07:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792136342; cv=none; b=WFIA+eJQqdmTZCAAV8x9n7Jkh2Cl5zvDcd8DX87C3WZ/hhU05HpMvgbRBiuTrQ0somgAwlmYEatRAL9QSRep0KFrXnnILWr/Y7fp7I3mSHXvXFYaDeqwLUd8UCA9lb/uiUZWE7ogR4hYCwriamlNn4ryd7JOjmleSerU3LvStRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792136342; c=relaxed/simple;
	bh=BZvAZnQANLuzvghCGwyaPh762DurruGeQxqgfQJnGe0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WHBtB6RNvf395UlGlXFLGKVahvJGdTRR/x8LbKtHCxAGZuq3Ylq9Gb57pKlmVnrFQUEMIXITadKtRR48h39/i1tsOmoZl2uJTc+tsFFsXo5u+NXyKL6Cp7bKz/dRsejRY08wHlMrOSrP5y/m4Ly08H/4vfmz8AJr/elc4dvDhds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=0vQRl67X; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="0vQRl67X"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DE10BA159E;
	Fri, 16 Oct 2026 09:38:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792136330; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=NovLrR8n2u6L1oVVVWRg+h+5OQA03kyE8bFrAQfqfwI=;
	b=0vQRl67X1i/m/ZO/OoB+cJp9Chem7HZt563lYQMN/rH8P9unUPEpH2fTmjlEsTgbWNOxSZ
	srIZUPktJiwWimLnIY/X4rLpwK8U2dIvAAnULk0ApqS4XwsEEQZcrWekBxpiiErOcukzzY
	dNonmV83iQnPLfTecqp2Ik9tAFiKH5AKC9kWxBK9NwAohTffkN9eOdiDt6kEZDxhDo1EWT
	TJbSwyoqrLvEYRiowPcd9WEZ4PzxcM+7xuunPwF/Aq44obTzfiDx3UgY+KHfwCnnC4KFjf
	acBEsZ1hbw5yBB1Fqv2IrLp9kJ25JFpMWE1J/VHJlqkwrKtcTVh0cPVP2Chr0Q==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Fri, 16 Oct 2026 09:38:22 +0200
Subject: [PATCH 2/2] serial: amba-pl011: keep RS485 transmission running on
 reconfiguration
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-devel-nbuchwitz-pl011-rs485-reconfig-stall-v1-2-f07d4da714be@tipi-net.de>
References: <20261016-devel-nbuchwitz-pl011-rs485-reconfig-stall-v1-0-f07d4da714be@tipi-net.de>
In-Reply-To: <20261016-devel-nbuchwitz-pl011-rs485-reconfig-stall-v1-0-f07d4da714be@tipi-net.de>
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
Cc: stable@vger.kernel.org
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/tty/serial/amba-pl011.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 057bb74f3d85..66130a6d41fc 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2504,12 +2504,13 @@ static int pl011_rs485_config(struct uart_port *port, struct ktermios *termios,
 	struct uart_amba_port *uap =
 		container_of(port, struct uart_amba_port, port);
 
-	uap->rs485_break = false;
 	if ((port->rs485.flags & SER_RS485_ENABLED) &&
 	    !(rs485->flags & SER_RS485_ENABLED)) {
 		bool tx_pending = uap->rs485_tx_state == WAIT_AFTER_RTS;
 		u32 cr = pl011_read(uap, REG_CR);
 
+		uap->rs485_break = false;
+
 		/*
 		 * Leaving RS485 mode, which only enables the transmitter while
 		 * sending. Don't stop it, as that stalls a DMA transfer still
@@ -2530,7 +2531,9 @@ static int pl011_rs485_config(struct uart_port *port, struct ktermios *termios,
 	} else if ((rs485->flags & SER_RS485_ENABLED) &&
 		   uap->rs485_tx_state == OFF && pl011_tx_pending(uap)) {
 		pl011_rs485_tx_resume(uap, rs485);
-	} else if (port->rs485.flags & SER_RS485_ENABLED) {
+	} else if ((port->rs485.flags & SER_RS485_ENABLED) &&
+		   uap->rs485_tx_state == OFF) {
+		/* Set the idle level now, a transmission sets it when done */
 		pl011_rs485_tx_stop(uap);
 	}
 

-- 
2.53.0

