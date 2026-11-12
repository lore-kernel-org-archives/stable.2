Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794470938;
	b=vLjSgNDo4WxdUbPqxp27ksywsrLt7oFUw+xDivG/8JgiEyFNbPRaV19NsFc1GdNn6PcM
	 thbfel3E2g/0lzYMreFwAwYQs/V+bmkQSlOoLQInrFjrnMlnhKBdBla23w+E7+F83bfl+
	 4n2od6fmj0Wwy6Fy44etXj0l4F3Mnf67b0KH88ZCBAjm5bZR3eAWzhVXP1ZSRcWTXKw57
	 KYy28urIM4t3tcwkApfkERgGbUmGmrWBTquqF41xa9eO+vtpc/IMyN8+nyBssA0H8igmY
	 w6WJtwk/3mY+UykUnGPvBThVJDGEL36AyqFp2D+B9GyclYDZXYaVQ2vso+i9PG1qx5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794470938;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=5/P62vb/ZNyefYOwa+qCrYlNMuVyORREsEtxcqhPkOE=;
	b=HQyJIsBXGUQupsTLZkZp9GtJvXs4YUrLFfk8ZVJWJnvefOiv9JpkqEsoHzDJTRTEvCa/
	 wY0zHG/0Mpa1nEjKza4dieskk9CDpz/jYnNXxPk8ysZn8DhOWtzi7ywDXyAAIxoko+vB9
	 GkjsAghzgLG/IWuYATiQQGSYX21JrO7vWUC36//4Zc5CfNmHW6hazdudg+YtLvDd5cGUr
	 zhe/ThaDR64pYRl5esYUzSulEFJ7x2Y8+S1/YEUxNzn7Gg/UmitK77UhWbee2rGdpSby2
	 37tcz6vxFrzRw0cayMAZ7jo/Z+ZUcRq7187UKaeCMQYMOhG43c+v8wnOUvSLu6BR+xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=OdzZUljI;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25789606A8AC;
	Thu, 12 Nov 2026 08:08:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25789606A8AC
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=OdzZUljI
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6124EA3763;
	Thu, 12 Nov 2026 09:08:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1794470936; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5/P62vb/ZNyefYOwa+qCrYlNMuVyORREsEtxcqhPkOE=;
	b=OdzZUljI3/UltoxoXtl/plww3SgDCRQlukR1EIrYgmks9hd9PFXzM3leURiThpha2EH0gs
	UOUpRcjAFqv90ZqzucJ1LId3IbX1Wqi+CsEKAJmgrJHRHIR8iPWbey4M/8A1HEp9GHSYUF
	ozD91oSVvXBwgjCxvlutNVDZG2GQYhnDT9ABZsHXfBnG3ErI/S2PG91AMdzE5FwlM69+4O
	yIz2u3lmoqWuIZ8hwgGppRE9Pg8Cp01E50eHl8/N7dqIAjOLfP7c6jLj/pBgN62Q7/Eo0q
	LMNLJZPr8d+WNyH9w6k7WrWQ8DnMfiR89ltiKr8Ujh4CGshaRPvCj8aZrwyXVg==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Thu, 12 Nov 2026 09:08:52 +0100
Subject: [PATCH RESEND v4 2/2] serial: amba-pl011: keep RS485 transmission
 running on reconfiguration
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
Message-Id: <20261112-devel-nbuchwitz-pl011-rs485-reconfig-stall-v4-2-b5c58ff3a376@tipi-net.de>
References: <20261112-devel-nbuchwitz-pl011-rs485-reconfig-stall-v4-0-b5c58ff3a376@tipi-net.de>
In-Reply-To: <20261112-devel-nbuchwitz-pl011-rs485-reconfig-stall-v4-0-b5c58ff3a376@tipi-net.de>
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
 drivers/tty/serial/amba-pl011.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 1edbe75611e63..e4ac9225cdcba 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2512,12 +2512,13 @@ static int pl011_rs485_config(struct uart_port *port, struct ktermios *termios,
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
@@ -2540,7 +2541,9 @@ static int pl011_rs485_config(struct uart_port *port, struct ktermios *termios,
 		   tty_port_initialized(&port->state->port) &&
 		   (pl011_tx_active(uap) || !pl011_tx_empty(port))) {
 		pl011_rs485_tx_resume(uap, rs485);
-	} else if (port->rs485.flags & SER_RS485_ENABLED) {
+	} else if ((port->rs485.flags & SER_RS485_ENABLED) &&
+		   uap->rs485_tx_state == OFF) {
+		/* Set the idle level now, a transmission sets it when done */
 		pl011_rs485_tx_stop(uap);
 	}
 

-- 
2.53.0

