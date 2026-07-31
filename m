Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [40.65.178.148])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE60311C2C;
	Fri, 31 Jul 2026 09:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=40.65.178.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785488427; cv=none; b=Sgtvsdw7WGbenF7nXx+tG7RartQZEzJjn9tbb/vluMDyEg5NtTX3AvP5fI9SGk8c1ARoKoL8VOqVhxbRkpMlOPaWl3US+wj0PnUP8w6jY69cW3knef1b1uAjxgNsx6yTeONRx0hA1pEhHZ6M2j5P9bDKsU5UBM28euGLNUU93rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785488427; c=relaxed/simple;
	bh=02sX0rKTtEOBC+vjlisHqKfWmTZEapicdyQ5ZRTxPKY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YAEMT5cBJ3/88xFSFr1wv2TD/j0mJDctky/7zdcDnSBxLOBlEbTx23fs3u58icUQ+5pOyjEe58+05tp9t7sRBqGFy5LU6XyzzQUvQXUrcXl+W4jtgbJ2CtOjkbpyRGdTA6T35Cspv5X7JOOzUReKCY//UkFYW8YCmZrzlkEl9m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=40.65.178.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wBXBD4dZGxqKGpTAA--.789S3;
	Fri, 31 Jul 2026 17:00:13 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app4 (Coremail) with SMTP id zi_KCgB3fDYaZGxqvp_CAg--.43373S4;
	Fri, 31 Jul 2026 17:00:12 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: linux@armlinux.org.uk,
	gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH v2 2/3] serial: amba-pl011: cancel RS485 hrtimers after freeing IRQ
Date: Fri, 31 Jul 2026 08:59:14 +0000
Message-Id: <20260731085915.326775-3-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731085915.326775-1-fanwu01@zju.edu.cn>
References: <2026073047-unsorted-stick-b16f@gregkh>
 <20260731085915.326775-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgB3fDYaZGxqvp_CAg--.43373S4
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?4ubHZQXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnXz+g1OQfMo27QHy5TwQyZzn0nZMIneE74XNUApPxMArLJLLPouM96QrQijSMggK2oV2
	+xkMrP3buNJLDZ648tup9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoWxGr45AF4UCF1UXrWkXr4fZwc_yoW5uFW8pr
	4vkrZ8ArW0qa10vFsFvFW8WFW5trn3try7GrW7K3WFka47trn5G3W5AFZavFZxZaykXay2
	kFn0yFs8GryxuFbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Gb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zc_3UUUUU==

The RS485 trigger hrtimers are embedded in the devm-managed port and can
fire after it is freed. The IRQ handler can arm a timer, so free the IRQ
first and then cancel both timers.

Complete the RS485 stop without arming a timer, and cancel the timers
in remove() for the suspend-then-unbind path, where shutdown is not
called.

This issue was found by an in-house static analysis tool.

Fixes: 2c1fd53af21b ("serial: amba-pl011: Fix RTS handling in RS485 mode")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/tty/serial/amba-pl011.c | 52 ++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index b212e2bcd41a..e686835d5150 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1269,11 +1269,30 @@ static inline bool pl011_dma_rx_running(struct uart_amba_port *uap)
 #define pl011_dma_flush_buffer	NULL
 #endif
 
-static void pl011_rs485_tx_stop(struct uart_amba_port *uap)
+static void pl011_rs485_tx_stop_now(struct uart_amba_port *uap)
 {
 	struct uart_port *port = &uap->port;
 	u32 cr;
 
+	cr = pl011_read(uap, REG_CR);
+
+	if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
+		cr &= ~UART011_CR_RTS;
+	else
+		cr |= UART011_CR_RTS;
+
+	/* Disable the transmitter and reenable the transceiver */
+	cr &= ~UART011_CR_TXE;
+	cr |= UART011_CR_RXE;
+	pl011_write(cr, uap, REG_CR);
+
+	uap->rs485_tx_state = OFF;
+}
+
+static void pl011_rs485_tx_stop(struct uart_amba_port *uap)
+{
+	struct uart_port *port = &uap->port;
+
 	if (uap->rs485_tx_state == SEND)
 		uap->rs485_tx_state = WAIT_AFTER_SEND;
 
@@ -1297,19 +1316,7 @@ static void pl011_rs485_tx_stop(struct uart_amba_port *uap)
 		hrtimer_try_to_cancel(&uap->trigger_start_tx);
 	}
 
-	cr = pl011_read(uap, REG_CR);
-
-	if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
-		cr &= ~UART011_CR_RTS;
-	else
-		cr |= UART011_CR_RTS;
-
-	/* Disable the transmitter and reenable the transceiver */
-	cr &= ~UART011_CR_TXE;
-	cr |= UART011_CR_RXE;
-	pl011_write(cr, uap, REG_CR);
-
-	uap->rs485_tx_state = OFF;
+	pl011_rs485_tx_stop_now(uap);
 }
 
 static void pl011_stop_tx(struct uart_port *port)
@@ -2019,11 +2026,20 @@ static void pl011_shutdown(struct uart_port *port)
 
 	pl011_dma_shutdown(uap);
 
-	if ((port->rs485.flags & SER_RS485_ENABLED && uap->rs485_tx_state != OFF))
-		pl011_rs485_tx_stop(uap);
-
 	free_irq(uap->port.irq, uap);
 
+	/*
+	 * free_irq() drains the UART interrupt handler, which can arm either
+	 * timer.  Cancel the timers afterwards to drain their callbacks too.
+	 */
+	hrtimer_cancel(&uap->trigger_start_tx);
+	hrtimer_cancel(&uap->trigger_stop_tx);
+
+	uart_port_lock_irq(port);
+	if (uap->rs485_tx_state != OFF)
+		pl011_rs485_tx_stop_now(uap);
+	uart_port_unlock_irq(port);
+
 	pl011_disable_uart(uap);
 
 	/*
@@ -2941,6 +2957,8 @@ static void pl011_remove(struct amba_device *dev)
 	struct uart_amba_port *uap = amba_get_drvdata(dev);
 
 	uart_remove_one_port(&amba_reg, &uap->port);
+	hrtimer_cancel(&uap->trigger_start_tx);
+	hrtimer_cancel(&uap->trigger_stop_tx);
 	pl011_unregister_port(uap);
 }
 
-- 
2.34.1

