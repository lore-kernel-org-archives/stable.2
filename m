Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F91B38F254;
	Sun, 11 Oct 2026 19:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791748146; cv=none; b=g88ZDuN7W8ldU+6q/tZ1UrmhwWhyFHs1OeH7FWvb53JuNB+uC3OhlScGL5IdO9o+4ttBlAQSdQUL/go8lPJyH645J4f6CadI4+WKstPdDUTHd1FOuQMrGwCJZtYVjgoViDWasfUB5aDHj/nk6x/wJ+ILnhK0RHiDItfgXEBuoKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791748146; c=relaxed/simple;
	bh=dR+mDlARsXsAOi2WnTyiymG8xQQx1HwvRtW+WvS0xgE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZVD731Bg3+Q1hccpLOOUjkT/ToopTF2Va8DZJI7YjLdg0oCSbuBuRpY0mMzKQXTZM+MG76/CUlj74EyJPfW73A34zTgxm2Q0KY0XPJ4gH3GS7th2fdSapqUEZIY+UI2NJIeSPNOaXIvlAbjQv6V+LMuy5c7NphFrnoIY5zSUeYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=LFECCvQ4; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="LFECCvQ4"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A837BA012B;
	Sun, 11 Oct 2026 21:48:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791748138; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=3ZhABzJtKtvhooUQgNsjPBzJBD+nepwXgLB54+0/Zzg=;
	b=LFECCvQ4dky8fHFQWgmSO1arVaQ4fre0TZpCWUUF7rTFfnAyDJhJuc6YmtnN5TS17CX6zE
	cy6aoDrDZ3QwTJPnpffLzpqVkCuBzIpBZdOxA9dEmiUzCbb2883qsRn/NeD1bHbEm3DPQs
	UNETB28RARU7g1IyW41qMfp+JOWVyz5gln9/yii7jICfa2BTC/Rw4MSA7buKGMuL96LBHM
	d3J4XuqEgBvn8lopU0J9eWjbytWK0A8WF6C0ELTPz9wdrPeSPwxETqs3Rvqiuy1ZuUyrTb
	nZPRfQo6n0VuxrGnYgBUkttCPCPuOLLUuQyth0TrQtUblROwhxI2RWf4r3Zazg==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Sun, 11 Oct 2026 21:48:45 +0200
Subject: [PATCH] serial: amba-pl011: keep transmitter enabled when
 disabling RS485
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-fix-pl011-rs485-txe-v1-1-302b6c034b7f@tipi-net.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQqDMBBFryKz7kBGbDC9SulC04mOlFQyKoJ4d
 6Pu/oP/3gbKSVjhVWyQeBGVf8xAjwJ838SOUb6ZoTSlJUOEQVYcf+dKWtVPnFbGYInJO+uCayC
 bY+J8u6rvz806twP76UzBvh/Mjc8IdwAAAA==
X-Change-ID: 20261011-fix-pl011-rs485-txe-f61e1c969f9a
To: Russell King <linux@armlinux.org.uk>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 stable@vger.kernel.org, Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

Disabling RS485 on an open port calls pl011_rs485_tx_stop(), which
turns off the transmitter. Only the RS485 TX path turns it back on, so
any later output stays queued and tcdrain() hangs until the port is
closed.

pl011_rs485_tx_stop() also checks only the hardware FIFO. If a DMA
transfer has started but has not filled the FIFO yet, the transmitter
is turned off under the transfer and the DMA channel never recovers.

When leaving RS485 mode, cancel any pending deferred stop and leave the
transmitter enabled.

Fixes: 8d479237727c ("serial: amba-pl011: add RS485 support")
Cc: stable@vger.kernel.org
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
Noticed while implementing a DMX master on a CM5 with its PL011.
Userspace turns RS485 mode off to send the break, and the port then
stopped transmitting.

Tested on that board with an RS485 transceiver at 9600, 115200 and
250000 baud.
---
 drivers/tty/serial/amba-pl011.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index c4824c201e1c..d53dd934cc74 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2397,8 +2397,24 @@ static int pl011_rs485_config(struct uart_port *port, struct ktermios *termios,
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
+		 * in flight. Drop a pending deferred stop and keep it enabled.
+		 */
+		hrtimer_try_to_cancel(&uap->trigger_start_tx);
+		hrtimer_try_to_cancel(&uap->trigger_stop_tx);
+		uap->rs485_tx_state = OFF;
+
+		cr |= UART011_CR_TXE | UART011_CR_RXE;
+		pl011_write(cr, uap, REG_CR);
+	} else if (port->rs485.flags & SER_RS485_ENABLED) {
 		pl011_rs485_tx_stop(uap);
+	}
 
 	/* Make sure auto RTS is disabled */
 	if (rs485->flags & SER_RS485_ENABLED) {

---
base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
change-id: 20261011-fix-pl011-rs485-txe-f61e1c969f9a

Best regards,
--  
Nicolai Buchwitz <nb@tipi-net.de>

