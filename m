Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881ED36F906;
	Sun, 27 Sep 2026 06:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790488872; cv=none; b=fwTe7uTts91chdBpNpsuewx7jlMpRp7T87NZHjmK52hIaccGtFZTXcYfWaDtAPjknKI3mM6BbyY3CNC9WxOcjCH3IbQMXmEbgFDMjtIDmczwJGloOJ/0QqZeaycykrfwqZ28y0chJ5kc97I04QUZnl/gThMkjtoOo10x4uT/7as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790488872; c=relaxed/simple;
	bh=oQxe6umVUJbikpUv/f8hHxreXu4kY1/eFn7bii5vHQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tm2aGOj3k6bGOHiLTkOovXLdQgqIimkoqWnH5qNOlA8Y8SGatZsUCzV+NyleqnDwT5KO0vvYWYhW4wdg7+BjT7JspHJ+i0cwdYQomMq+62TVSOVBLjnuX3lbLr52JaMP6eziDqgs+xK5YZtDK2v6wdJ1B02ZDjoFZzUWo0PPAhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wA3NHwUsbhqLpU9AQ--.13599S3;
	Sun, 27 Sep 2026 14:00:54 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app2 (Coremail) with UTF8SMTPA id zC_KCgCH3nwUsbhqcp0NAA--.11892S2;
	Sun, 27 Sep 2026 14:00:52 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	broonie@kernel.org,
	zhao.xicheng@vivo.com,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH v4] tty: serial: max3100: shut down timer before freeing port
Date: Sun, 27 Sep 2026 05:59:57 +0000
Message-Id: <20260927055957.561030-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2026092346-sizzling-dallying-a3c1@gregkh>
References: <2026092346-sizzling-dallying-a3c1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgCH3nwUsbhqcp0NAA--.11892S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?EZDsSAXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnVvLbuoOKy0xUR2OEh/Lyhm3j5bhF2Nn1BrV1PeMo1kyTuVQxMtiELFgkQ9fhJq+H2ID
	iyHaSQzY+6oFgUCRQwep9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoWxur4xXryfuryxArykWryUurX_yoWrXw4fpF
	sakws8tFWrKr42kF9xtw47XF1rWa1rJw47Gr1Ig3yYkw15AryYg3WIkayjkayrCFykXFsr
	AFZYq398AryqyFbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
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
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8
	JbIYCTnIWIevJa73UjIFyTuYvjxU7gAwDUUUU

max3100_shutdown() stops the polling timer but returns early during
system suspend. If the SPI device is unbound before resume, the serial
core does not call max3100_shutdown() again, so max3100_remove() frees
the port while the timer remains armed. max3100_timeout() may then
access the freed port and re-arm the timer.

Add final timer teardown to max3100_remove() and use
timer_shutdown_sync() to prevent a racing callback from re-arming it.
Also free the IRQ and destroy the workqueue there before freeing the
port. Keep timer_delete_sync() in max3100_shutdown() so that a
subsequent open() can re-arm the timer.

The workqueue is created before request_irq() and destroyed on both
request_irq() failure and normal shutdown. Its presence at remove thus
identifies the IRQ left registered when suspend bypasses shutdown.

Free the IRQ before destroying the workqueue, in both
max3100_shutdown() and max3100_remove(), and cancel the pending work
in between. free_irq() waits for a running interrupt handler to
finish and no new handler can start afterwards, so a racing handler
cannot queue work on a workqueue that is being destroyed; the
force_end_work check in max3100_dowork() only narrows that window, as
a handler delayed between the check and queue_work() could still run
after the teardown has cleared the workqueue pointer. Cancelling the
work also keeps destroy_workqueue() from waiting on a queued work item
in case remove() ever runs while the freezable workqueue is still
frozen, e.g. device removal during the resume window, before
workqueues are thawed.

This issue was found by an in-house static analysis tool.

Fixes: 7831d56b0a35 ("tty: MAX3100")
Cc: stable@vger.kernel.org # 6.2+
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
Changes since v3:
  - Free the IRQ before destroying the workqueue in both
    max3100_shutdown() and max3100_remove(), and cancel the pending
    work in between. This closes a race where an interrupt handler
    that already passed the force_end_work check in max3100_dowork()
    could queue work on a cleared or destroyed workqueue pointer. It
    also keeps destroy_workqueue() from waiting on a queued work item
    should remove() ever run while the freezable workqueue is still
    frozen, e.g. device removal during the resume window, before
    workqueues are thawed.

No MAX3100 hardware was available for this change: verified by
inspection and compilation only.

v1: https://lore.kernel.org/all/20260721035631.3186613-1-fanwu01@zju.edu.cn/
v2: https://lore.kernel.org/all/20260801061208.356142-1-fanwu01@zju.edu.cn/
v3: https://lore.kernel.org/all/20260805004039.382698-1-fanwu01@zju.edu.cn/
---
 drivers/tty/serial/max3100.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 44b745fa26c6..e8027c09c619 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -535,11 +535,11 @@ static void max3100_shutdown(struct uart_port *port)
 	timer_delete_sync(&s->timer);
 
 	if (s->workqueue) {
+		free_irq(port->irq, s);
+		cancel_work_sync(&s->work);
 		destroy_workqueue(s->workqueue);
 		s->workqueue = NULL;
 	}
-	if (port->irq)
-		free_irq(port->irq, s);
 
 	/* set shutdown mode to save power */
 	max3100_sr(s, MAX3100_WC | MAX3100_SHDN, &rx);
@@ -752,6 +752,15 @@ static void max3100_remove(struct spi_device *spi)
 		if (max3100s[i] == s) {
 			dev_dbg(&spi->dev, "%s: removing port %d\n", __func__, i);
 			uart_remove_one_port(&max3100_uart_driver, &max3100s[i]->port);
+
+			s->force_end_work = 1;
+			timer_shutdown_sync(&s->timer);
+			if (s->workqueue) {
+				free_irq(s->port.irq, s);
+				cancel_work_sync(&s->work);
+				destroy_workqueue(s->workqueue);
+				s->workqueue = NULL;
+			}
 			kfree(max3100s[i]);
 			max3100s[i] = NULL;
 			break;
-- 
2.34.1

