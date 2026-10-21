Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792583134;
	b=mWG1k0vVMvx3iw0dnsjSNQvSd7U+6Wh6I+DdpUxZ668SvxYIbqlPjUvwsa7Tf7coXXPZ
	 C5dU38y/Q0Ahd7J+1Wv/rdvnqVNp4w93KmQTDhG7+VLSuWtBuaGmdkpBxa9k9QGHBXhbM
	 Gfu6FySnovtZIcoj2ZfOwJNMBdsDqDNjifzQtz00Pr/9RmTGu3xb499ZPOiClK7XdMGsg
	 BMj2HAwoukdhxQv/26nmUAh2ORIuMCGXNzNw5sAAQeDwXFRRG37RPQvq6XfvTNTjQMJcv
	 17r1YjgVBeNryKO5w2r0hxzaZWp2RZ+1x2Z5q2wqtYVVYNksplm/gMTJ21ZJHgD02VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792583134;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=5/P62vb/ZNyefYOwa+qCrYlNMuVyORREsEtxcqhPkOE=;
	b=QbudopnYb5JUvs7c80OD//rlHXY4Gx9SC4jvrS2P4gKowIdEVQlpTwB5jY9bb3IQHBA8
	 Kg2gLdpo/MHER6YCR5aLqS2yUlp6SeYPguu20VrN+WEbLpTDOV4Vt1ZmlcLDrJ+Q3YdI6
	 tgSDlCLKb9cYwh80SYNDTfzMoYd3Tt4o8HvSU5EU5fJsbyzVOURn+wLA7Div3En2pNKRP
	 uEsa8CaCN1p52mQvXiQp6fBkiPJ0UJrpoO84dP64KN8tn3en4aST8C7viipWrhv4TShO9
	 bIuRUBQS9t28+sBWhHW00Fj1h/Wq68iICSzqV1/avnATrplLCvehA9TNLmijt4WSTTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=Q5gd7c7D;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B81A606A31E;
	Wed, 21 Oct 2026 11:45:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B81A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=Q5gd7c7D
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 322C4A4B86;
	Wed, 21 Oct 2026 13:45:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792583131; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5/P62vb/ZNyefYOwa+qCrYlNMuVyORREsEtxcqhPkOE=;
	b=Q5gd7c7DpmaeVgfMTIZRPQOPCy6p/5zzYQ/WIAnTHy27FaIxeW4Xc93ivAXPpP1v2zgP70
	euKi7T2PzcUfEc3FT+LALuJptd0eul4w7lOOqfyYCun+aIhTERgsNcRZyZO1JL8t6mIzrH
	jFG54ZnxTiyUK+IKg00iFhwYBVYMSOa/uWMFHrfulriPL848HERT8aS/4UV2Ie9c8MSAwV
	uIdU/pPt+esxPg0px314Bzcb7xhG4Quv/jprxkTLq67/UDF22TIAlPXZ1bJp7runwKo/le
	2DmkWplpNfR4vwF8SK//+kngDst/A24zoM+21Rzwr8qcH9YlKYRzF176/UZRLg==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Wed, 21 Oct 2026 13:45:23 +0200
Subject: [PATCH v4 2/2] serial: amba-pl011: keep RS485 transmission running
 on reconfiguration
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
Message-Id: <20261021-devel-nbuchwitz-pl011-rs485-reconfig-stall-v4-2-ed10e219159a@tipi-net.de>
References: <20261021-devel-nbuchwitz-pl011-rs485-reconfig-stall-v4-0-ed10e219159a@tipi-net.de>
In-Reply-To: <20261021-devel-nbuchwitz-pl011-rs485-reconfig-stall-v4-0-ed10e219159a@tipi-net.de>
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

