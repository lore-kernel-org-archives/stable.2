Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FAC38A73B;
	Sun, 11 Oct 2026 20:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791750232; cv=none; b=gLQsBnGWEoMq+ug9jipS5Q9eCiHeECkoBAMjH5q2X9nbG1msbWRBtKD1IUyGBVLi1ULpMn6QFvs2MVjYe4qn9mnIur833oU59FZ/LrrisWBQxXgSTWU/D/oiBdu9ul8vOa/0JHBZegMqAdkglBmoFb0meaIg8hAN6BqNCsAOGkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791750232; c=relaxed/simple;
	bh=OsekOoMWUp1sEIOlyQjkDPmeFUttFjczZH/BP6uvCDw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sI6V5yKthz6eC6d9FBOL2Q6TLt+EG/W1l/xxb/W1Oephkx+dUulfnj5+5mcg6oEzkbvuh6KKTZZwStI0IDJQyVa8fa2t59pwEuknLjXNXjcpP596oWVkk1umDoYEOdKMUBAIpux8ef2TjTVqozGvLqJg1YUNc+pDO8lCM5MqtQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=zHeAb5xI; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="zHeAb5xI"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AD1F2A155F;
	Sun, 11 Oct 2026 22:23:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791750228; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=INJQe6paOwtdLO99XY5b6szNASacCk5MfFyywcH7fqs=;
	b=zHeAb5xIJYV8F6p9eICUAzLhVoqRog6hmZnMgQ44ajYW7KTWeIY6cZdl0sxBYiad4ssxn2
	B8xU0pGEO4FV2dpdBGWIXKmK8XxzABJ1KcfIH8U9cFCD2GOPQtnmXHYnewqHfXOmRdwnn4
	4K8JIU1VJ7jG2sRr0f12DnbxsPt/JqMyIGgVsysR5V9wd/l0ldnd7p8elhpCRrJGz1ULds
	RDvb5mT1sk4YlNzOhUV5iO1H9W+H1Zn3lEx+PvdZcTPYO6qxrwnm5K2it78d3QgedKmD1r
	rsNFibmFEbUPAm2VKmmIvCx4ZYwJhQAp9ZwXc+lFOM5TaYN0bcoey1HNTLnUcg==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Sun, 11 Oct 2026 22:23:44 +0200
Subject: [PATCH] serial: amba-pl011: honour delay_rts_before_send for every
 write
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-fix-pl011-rs485-rts-delay-v1-1-5078e61bc408@tipi-net.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQqDQAxFryJZG5gZtJReRVyMk7RNEZVEpUW8e
 0fd/Qf/vQ2MVdjgUWygvIrJOGTwZQHpHYcXo1BmCC7cvPMen/LFqT+WWnWvUWdD4j7+MEWqmCK
 F2nWQ/Uk5n892015sS/fhNB9B2Pc/EYfrj30AAAA=
X-Change-ID: 20261011-fix-pl011-rs485-rts-delay-cad4edad250b
To: Russell King <linux@armlinux.org.uk>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Miroslav Ondra <ondra@faster.cz>
Cc: Lino Sanfilippo <LinoSanfilippo@gmx.de>, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, stable@vger.kernel.org, 
 Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

While the driver waits out delay_rts_before_send, another write calls
pl011_start_tx() again. pl011_rs485_tx_start() then switches straight
to SEND, and the data goes out before the delay has passed.

Leave the start to the trigger_start_tx timer while it is pending.

Fixes: 2c1fd53af21b ("serial: amba-pl011: Fix RTS handling in RS485 mode")
Cc: stable@vger.kernel.org
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
Noticed while implementing a DMX master on a CM5 with its PL011.
Tested on that board with delay_rts_before_send set to 1 ms and two
quick writes. With ftrace, the first pl011_tx_chars() came 0.03 ms
after pl011_start_tx() before this patch and 1.03 ms after with it.
---
 drivers/tty/serial/amba-pl011.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index c4824c201e1c..759124a2a1a8 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1420,10 +1420,6 @@ static void pl011_rs485_tx_start(struct uart_amba_port *uap)
 	struct uart_port *port = &uap->port;
 	u32 cr;
 
-	if (uap->rs485_tx_state == WAIT_AFTER_RTS) {
-		uap->rs485_tx_state = SEND;
-		return;
-	}
 	if (uap->rs485_tx_state == WAIT_AFTER_SEND ||
 	    uap->rs485_tx_state == WAIT_AFTER_SEND_DELAY) {
 		hrtimer_try_to_cancel(&uap->trigger_stop_tx);
@@ -1462,6 +1458,10 @@ static void pl011_start_tx(struct uart_port *port)
 
 	if ((uap->port.rs485.flags & SER_RS485_ENABLED) &&
 	    uap->rs485_tx_state != SEND) {
+		/* trigger_start_tx starts TX once delay_rts_before_send passed */
+		if (uap->rs485_tx_state == WAIT_AFTER_RTS)
+			return;
+
 		pl011_rs485_tx_start(uap);
 		if (uap->rs485_tx_state == WAIT_AFTER_RTS)
 			return;
@@ -1478,8 +1478,10 @@ static enum hrtimer_restart pl011_trigger_start_tx(struct hrtimer *t)
 	unsigned long flags;
 
 	uart_port_lock_irqsave(&uap->port, &flags);
-	if (uap->rs485_tx_state == WAIT_AFTER_RTS)
+	if (uap->rs485_tx_state == WAIT_AFTER_RTS) {
+		uap->rs485_tx_state = SEND;
 		pl011_start_tx(&uap->port);
+	}
 	uart_port_unlock_irqrestore(&uap->port, flags);
 
 	return HRTIMER_NORESTART;

---
base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
change-id: 20261011-fix-pl011-rs485-rts-delay-cad4edad250b

Best regards,
--  
Nicolai Buchwitz <nb@tipi-net.de>

