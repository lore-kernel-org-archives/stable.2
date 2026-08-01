Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFE732A3FE;
	Sat,  1 Aug 2026 06:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785564798; cv=none; b=iuP3VORIeKdoJytMWAuVtMawwKNdLDm9zwjjU4oFLkR74pnJjjbrP1SC+fA4j+uLwF9Ha9BzqW98l3Tc/QGWfZxeSv4joFClmBFFLQw/0iiKT+P4kw6/YkV9kYrICqzOWJ9+X6OMLC+afWQtBOgmL9LpPtLx0NUCz2e2m3t1XiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785564798; c=relaxed/simple;
	bh=wuqrYoATRlUAZx4Wf6savsECmKGxoBN772/mB2Jmb4g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jdhFMKykeMpGuv7l3aQWU4lLf37wNsxPsJOXtLOK9OW8fGzLd1njGzC3FBqXOTfLrY6wFYXak99r4XzJnPSoY1uHfJnPulpTnE4IOz2LgWjnIsyaXpVhZ2k3rZI25liutfH3Wj2/mgpHvrFhEHBmWZ60DYxImAy+Ajcl09x8nF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wDX0yhxjm1qW01WAA--.6985S3;
	Sat, 01 Aug 2026 14:13:06 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app4 (Coremail) with SMTP id zi_KCgCn2TBvjm1qiH3IAg--.56844S2;
	Sat, 01 Aug 2026 14:13:03 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	broonie@kernel.org,
	zhao.xicheng@vivo.com,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH v2] tty: serial: max3100: shut down timer before freeing port
Date: Sat,  1 Aug 2026 06:12:08 +0000
Message-Id: <20260801061208.356142-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2026073036-coping-starter-ad07@gregkh>
References: <2026073036-coping-starter-ad07@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgCn2TBvjm1qiH3IAg--.56844S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?U6rxkwXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnXz+g1OQfMo27QHy5TwQyZx8ip4GzWcoSbngUcs54ItVPSSNJ/DvGQkI7W74mBEVp3cA
	ErY8ECTpFPfTVkRooMvN5RPxYw6l01w8CbPzC/8w
X-Coremail-Antispam: 1Uk129KBj93XoWxur4xXryfuryxArWkXryfKrX_yoW5ZFW7pa
	n3Crsxta15Xr47Z393Gws7XFyFg3WfJw47Cr17G3ya9r45GryYg3W0ya42gFWFyrZ8XF1D
	AFWkta9xCrs0yFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Gb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU86c_DUUUUU==

max3100_shutdown() stops the polling timer but returns early during
system suspend. If the SPI device is unbound before resume, the serial
core does not call max3100_shutdown() again, so max3100_remove() frees
the port while the timer remains armed. max3100_timeout() can then
access the freed port and re-arm the timer.

Add final timer teardown to max3100_remove() and use
timer_shutdown_sync() to prevent a racing callback from re-arming it.
Also drain the IRQ and workqueue before freeing the port.

Keep timer_delete_sync() in max3100_shutdown() so that a subsequent
open() can re-arm the timer.

Introduce an irq_registered flag to track whether the IRQ is registered,
independently of port->irq, so a failed request_irq() can be retried on
the next open().

Found by static analysis.

Fixes: 7831d56b0a35 ("tty: MAX3100")
Cc: stable@vger.kernel.org # 6.2+
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
Changes since v1:
  - Drop the shared drain helper; call timer_shutdown_sync() only in
    max3100_remove(), keeping timer_delete_sync() in max3100_shutdown()
    so a later open() can re-arm the timer.
  - Track IRQ registration with a flag instead of clearing port->irq,
    so a failed request_irq() can be retried on the next open().

v1: https://lore.kernel.org/all/20260721035631.3186613-1-fanwu01@zju.edu.cn/
---
 drivers/tty/serial/max3100.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 44b745fa26c6..7bc3c5cfe886 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -107,6 +107,7 @@ struct max3100_port {
 	int  force_end_work;
 	/* need to know we are suspending to avoid deadlock on workqueue */
 	int suspending;
+	bool irq_registered;
 
 	struct timer_list	timer;
 };
@@ -538,8 +539,10 @@ static void max3100_shutdown(struct uart_port *port)
 		destroy_workqueue(s->workqueue);
 		s->workqueue = NULL;
 	}
-	if (port->irq)
+	if (s->irq_registered) {
 		free_irq(port->irq, s);
+		s->irq_registered = false;
+	}
 
 	/* set shutdown mode to save power */
 	max3100_sr(s, MAX3100_WC | MAX3100_SHDN, &rx);
@@ -575,12 +578,12 @@ static int max3100_startup(struct uart_port *port)
 	ret = request_irq(port->irq, max3100_irq, IRQF_TRIGGER_FALLING, "max3100", s);
 	if (ret < 0) {
 		dev_warn(&s->spi->dev, "cannot allocate irq %d\n", port->irq);
-		port->irq = 0;
 		destroy_workqueue(s->workqueue);
 		s->workqueue = NULL;
 		return -EBUSY;
 	}
 
+	s->irq_registered = true;
 	s->conf_commit = 1;
 	max3100_dowork(s);
 	/* wait for clock to settle */
@@ -752,6 +755,17 @@ static void max3100_remove(struct spi_device *spi)
 		if (max3100s[i] == s) {
 			dev_dbg(&spi->dev, "%s: removing port %d\n", __func__, i);
 			uart_remove_one_port(&max3100_uart_driver, &max3100s[i]->port);
+
+			s->force_end_work = 1;
+			timer_shutdown_sync(&s->timer);
+			if (s->irq_registered) {
+				free_irq(s->port.irq, s);
+				s->irq_registered = false;
+			}
+			if (s->workqueue) {
+				destroy_workqueue(s->workqueue);
+				s->workqueue = NULL;
+			}
 			kfree(max3100s[i]);
 			max3100s[i] = NULL;
 			break;
-- 
2.34.1

