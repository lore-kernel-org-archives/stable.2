Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D119934CFDA;
	Tue, 21 Jul 2026 04:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784608207; cv=none; b=ubB3cx0RvNrbBRIPAAKg9CenRblZd9Az+vbJn6j4XozmH5rG7gx3cJVF7Uzk3PNTHislwGBAbPefQKu7YOoEXqp7R3Rj7NC0z+VfGMnIMCCfcAjFmDP9iyQ9f4lx6VZV2Q4S08b7QXJkW5ghRpeTLZvkaC4b71KpiSu9+6PBWG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784608207; c=relaxed/simple;
	bh=CxkQ3oUlQ1uz4oraCWpo+vbITfKSGlK9Lxu64kzTqBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZsUkMT/L6B5M0YrD8LaWHdCIOcZef10aQZFQ5OfyKkXFVNzTUX4MySCMDv4Ev5QB2TCB4wJJE/IiDd4JgG8IxRiCDfGJCJYn6uC82wcoQ5OdotJcPUvxlXdVNNKRsaKT6y77GYnetf2gsLM8rIPvcf62wKQCa/D7ajGjq8nm8PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wDX33_C9V5q+_8fAA--.17309S3;
	Tue, 21 Jul 2026 12:29:55 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app4 (Coremail) with SMTP id zi_KCgB3fDbB9V5qGkJ5Ag--.16336S2;
	Tue, 21 Jul 2026 12:29:53 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: linux@armlinux.org.uk,
	gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH] tty: serial: amba-pl011: cancel RS485 trigger hrtimers before removal
Date: Tue, 21 Jul 2026 04:28:58 +0000
Message-Id: <20260721042858.3187311-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgB3fDbB9V5qGkJ5Ag--.16336S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?yHOMxwXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnXz+g1OQfMo27QHy5TwQyZy3ddmrETN3A+9+69D57uW6Tpv0HXn7+zqXhoV1xRwirYmS
	9K6+8SutCR7xqwechcup9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoWxGF45Kr48GF48JrWUGry7CFX_yoW5KFW3p3
	yv9rZ8A3yvqa18Aa1DZ3W8WFy5Jrs8JrW3Gry8K3WFgas8Gr18trsIya1Syay3uaykAay2
	qr1Fyw4UC34xCagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8
	JbIYCTnIWIevJa73UjIFyTuYvjxU7gAwDUUUU

pl011_shutdown() calls pl011_rs485_tx_stop() when RS485 is enabled and
the transmit state machine is still active.  That function may re-arm
the trigger_stop_tx hrtimer via hrtimer_start() when the TX FIFO is not
yet empty, or when delay_rts_after_send is configured, and the trigger
timers can equally be left armed from a prior pl011_rs485_tx_start().

On removal, uart_remove_one_port() can finish without draining the RS485
hrtimers, and devm frees the uart_amba_port once pl011_remove() returns.
The existing teardown syncs do not help here: pl011_disable_interrupts()
only masks the UART IMSC register, pl011_dma_shutdown() cancels a
different (DMA rx) timer_list, and free_irq() plus serial_core's
synchronize_irq() only drain the UART interrupt handler, not the hrtimer
softirq callbacks.  Either trigger callback can therefore recover uap
from its embedded hrtimer and access uap->port after the free.

Cancel both RS485 trigger hrtimers in pl011_shutdown(), after the
re-arming pl011_rs485_tx_stop() call and before free_irq(), and again
in pl011_remove() after uart_remove_one_port().  The remove-side
calls cover paths such as suspend followed by unbind, where serial
core need not invoke the driver's shutdown callback.  The
callbacks pl011_trigger_start_tx and pl011_trigger_stop_tx return
HRTIMER_NORESTART, so hrtimer_cancel() fully drains any pending and
concurrently running callback without a self-restart loop.  As
pl011_trigger_start_tx() may re-enable the TX interrupt via
pl011_start_tx(), call pl011_disable_interrupts() again after the
cancels to re-mask IMSC before free_irq().  The cancel site does not
hold uart_port_lock across the cancel
(pl011_disable_interrupts() already released it) and the callbacks take
that lock internally, so there is no self-deadlock.  This mirrors the
RS485 teardown pattern in 8250_port.c (serial8250_em485_destroy),
which cancels both hrtimers before the embedding object is freed.

This issue was found by an in-house static analysis tool.

Fixes: 2c1fd53af21b ("serial: amba-pl011: Fix RTS handling in RS485 mode")
Cc: stable@vger.kernel.org   # v6.14+
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/tty/serial/amba-pl011.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 8ed91e1da22b..021b542b3d99 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2083,6 +2083,16 @@ static void pl011_shutdown(struct uart_port *port)
 	if ((port->rs485.flags & SER_RS485_ENABLED && uap->rs485_tx_state != OFF))
 		pl011_rs485_tx_stop(uap);
 
+	/*
+	 * pl011_rs485_tx_stop() above may have (re-)armed the RS485 trigger
+	 * hrtimers.  A callback may also re-enable the TX interrupt, so
+	 * cancel them and mask interrupts again before freeing the IRQ.
+	 * pl011_remove() cancels them again before freeing the owner.
+	 */
+	hrtimer_cancel(&uap->trigger_start_tx);
+	hrtimer_cancel(&uap->trigger_stop_tx);
+	pl011_disable_interrupts(uap);
+
 	free_irq(uap->port.irq, uap);
 
 	pl011_disable_uart(uap);
@@ -3063,6 +3073,8 @@ static void pl011_remove(struct amba_device *dev)
 	struct uart_amba_port *uap = amba_get_drvdata(dev);
 
 	uart_remove_one_port(&amba_reg, &uap->port);
+	hrtimer_cancel(&uap->trigger_start_tx);
+	hrtimer_cancel(&uap->trigger_stop_tx);
 	pl011_unregister_port(uap);
 }
 
-- 
2.34.1

