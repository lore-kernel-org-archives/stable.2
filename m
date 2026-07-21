Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6112DF144;
	Tue, 21 Jul 2026 03:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784606266; cv=none; b=WBBx31uyOyBFVhFEr9oD9Ech/NmBp49lbpPO7CocDbMhlIcrM8pysdd2ql2pCa2z8bils8cvE0ZDigIMhZGjKLeuI41nuMN77/ShScA2ubbUD/f2rYNAYzRBiLlBkkOpTFWqeZUNU8Wn+LA5tGxeA5tYIV75gChFNG1mNai75nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784606266; c=relaxed/simple;
	bh=5v6xU5sNB0P7VeWMsdybI50JFTbhfCKGhDdPP4crLdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bX1jqH9T96oQHKQVwdMmm451psVkto5tqzzQSxZgty6KZIt8oFwahYsE+bhm7Yz11KabLp6RjQKzpieLqlASidGdyYQHr2YrMyF3Fo0iL3OJL+jgJ5x8PzJs/8Eq4WCMdHbycQq3mOEhTNto3LfO3iGGym6njNPtD8H0RJ2b81U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wBHA34n7l5q588fAA--.1621S3;
	Tue, 21 Jul 2026 11:57:28 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app2 (Coremail) with SMTP id zC_KCgB35com7l5qf6kTAw--.50170S2;
	Tue, 21 Jul 2026 11:57:26 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	broonie@kernel.org,
	zhao.xichao@vivo.com,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH] tty: serial: max3100: drain async producers in remove() to fix timer UAF
Date: Tue, 21 Jul 2026 03:56:31 +0000
Message-Id: <20260721035631.3186613-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgB35com7l5qf6kTAw--.50170S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?fEO3LQXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfncGSG+szpQCInt5Y8rbJUI1/PTMMwWm4rIWFnTCvd1Va+N+PtAATrNebvM7n2CtUojJQ
	foKMrIuJxhHIysilKeSp9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoW3Gw17ArWDurykWFW8Wr13Jrc_yoW7Ar17pa
	9a9rsxKrs8WF47Zrn3Gw4DXF1fXw1rJw47Jr1xG3sY9rs5GrWUKF10yasFvFW5ur9xtFnF
	yF9Yv39xCr4jyFbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
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

All teardown of the driver's async producers (polling timer, SPI
workqueue, IRQ) lives in the max3100_shutdown() uart_ops callback.
On the suspend-then-remove path, max3100_shutdown() returns without
draining these producers, so max3100_remove() can call kfree() while
the polling timer remains armed.

max3100_startup() arms the polling timer via max3100_enable_ms().  The
timer callback max3100_timeout() unconditionally re-arms itself with
mod_timer(), and on each tick dereferences the owning struct
max3100_port (recovered via container_of(), then uart_poll_timeout on
s->port).

max3100_shutdown() opens with "if (s->suspending) return;", which
short-circuits the whole drain block.  max3100_suspend() sets
s->suspending before calling uart_suspend_port().
uart_suspend_port() (serial_core.c) clears tty_port_initialized() and
then invokes ops->shutdown = max3100_shutdown, which takes the
s->suspending early return above and runs none of the drain.  The
timer stays armed.

On a later SPI unbind, max3100_remove() calls uart_remove_one_port(),
which (serial_core_remove_one_port) invokes tty_port_tty_vhangup() but
does not invoke ops->shutdown() directly.  ops->shutdown() is reachable
only through tty_port_shutdown() and uart_port_shutdown(), but
tty_port_shutdown() is gated on tty_port_initialized(), which suspend
clears.  The removal path therefore does not invoke max3100_shutdown(),
and max3100_remove() proceeds directly to kfree(max3100s[i]) with the
timer still armed.

A port that was opened before system suspend can retain its polling
timer.  If the SPI device is then unbound before resume, max3100_remove()
frees the port while the timer can still run and re-arm itself.

Factor a drain helper with a final-teardown argument.  Both variants
stop the timer, IRQ, and workqueue in that order.  Normal shutdown uses
timer_delete_sync(), which preserves the timer for a later open.  Final
remove uses timer_shutdown_sync(), because max3100_timeout() re-arms via
mod_timer() and the object is about to be freed; shutdown makes a racing
re-arm a no-op.

Track whether request_irq() succeeded separately from port->irq.  The
latter is the hardware resource number and must survive a normal close
for the next startup; irq_requested makes the drain idempotent without
changing it.

Call the non-final form from max3100_shutdown() and the final form
after uart_remove_one_port() in max3100_remove().  The s->suspending
early return in max3100_shutdown() remains intact, while remove()
drains unconditionally.

timer_shutdown_sync() is available since v6.2.

This issue was found by an in-house static analysis tool.

Fixes: 7831d56b0a35 ("tty: MAX3100")
Cc: stable@vger.kernel.org # 6.2+
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/tty/serial/max3100.c | 37 ++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 44b745fa26c6..9dac733a9b81 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -107,6 +107,7 @@ struct max3100_port {
 	int  force_end_work;
 	/* need to know we are suspending to avoid deadlock on workqueue */
 	int suspending;
+	bool irq_requested;
 
 	struct timer_list	timer;
 };
@@ -306,6 +307,29 @@ static void max3100_dowork(struct max3100_port *s)
 		queue_work(s->workqueue, &s->work);
 }
 
+/*
+ * Stop async producers before tearing down the workqueue.  A normal
+ * shutdown must leave the timer re-armable for the next open, while final
+ * removal uses timer_shutdown_sync() to prevent max3100_timeout() from
+ * re-arming a timer embedded in an object about to be freed.
+ */
+static void max3100_drain_async(struct max3100_port *s, bool final)
+{
+	s->force_end_work = 1;
+	if (final)
+		timer_shutdown_sync(&s->timer);
+	else
+		timer_delete_sync(&s->timer);
+	if (s->irq_requested) {
+		free_irq(s->port.irq, s);
+		s->irq_requested = false;
+	}
+	if (s->workqueue) {
+		destroy_workqueue(s->workqueue);
+		s->workqueue = NULL;
+	}
+}
+
 static void max3100_timeout(struct timer_list *t)
 {
 	struct max3100_port *s = timer_container_of(s, t, timer);
@@ -530,16 +554,7 @@ static void max3100_shutdown(struct uart_port *port)
 	if (s->suspending)
 		return;
 
-	s->force_end_work = 1;
-
-	timer_delete_sync(&s->timer);
-
-	if (s->workqueue) {
-		destroy_workqueue(s->workqueue);
-		s->workqueue = NULL;
-	}
-	if (port->irq)
-		free_irq(port->irq, s);
+	max3100_drain_async(s, false);
 
 	/* set shutdown mode to save power */
 	max3100_sr(s, MAX3100_WC | MAX3100_SHDN, &rx);
@@ -581,6 +596,7 @@ static int max3100_startup(struct uart_port *port)
 		return -EBUSY;
 	}
 
+	s->irq_requested = true;
 	s->conf_commit = 1;
 	max3100_dowork(s);
 	/* wait for clock to settle */
@@ -752,6 +768,7 @@ static void max3100_remove(struct spi_device *spi)
 		if (max3100s[i] == s) {
 			dev_dbg(&spi->dev, "%s: removing port %d\n", __func__, i);
 			uart_remove_one_port(&max3100_uart_driver, &max3100s[i]->port);
+			max3100_drain_async(max3100s[i], true);
 			kfree(max3100s[i]);
 			max3100s[i] = NULL;
 			break;
-- 
2.34.1

