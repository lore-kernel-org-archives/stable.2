Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DBD2561A7;
	Wed,  5 Aug 2026 00:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785890515; cv=none; b=jmp7g5FvF5ZhX+VdtbupjhNhIZ1ClvkGmhR+blBhA4UMcD/9BKEfcx9GwJ3WuId4Zr1laTHxp0t90LT/FsvjY5e5JtU0xLW0007tXooHNIUxhPi1dVuSPgxz+sMmLDoBIj8MvQ+S4EQZznuvIUtdLxSMddSkgdCfyIpG17QmqxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785890515; c=relaxed/simple;
	bh=QL1C8oriicwyazzjRilusfKw0JwNpaWhAYQxMfbAdSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FHAvJmDFah7R8RmlNe2asTBePV5RhCMucGJHeTK35BWq5CcE5nMfYK+xoPeN6a4dSJ/xJjVIvdNgcUc7YT0wxXjmSqijW8kMEKxgzriblDWkFIlLXJMQHgYG17tYtsT5yrFmI5OAZ+Yciv8GYOU973ScywuEzP77zqFtngYXdDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wDX3y_AhnJq2NNmAA--.15575S3;
	Wed, 05 Aug 2026 08:41:37 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app4 (Coremail) with SMTP id zi_KCgCXyTC+hnJqZfnlAg--.1858S2;
	Wed, 05 Aug 2026 08:41:35 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	broonie@kernel.org,
	zhao.xicheng@vivo.com,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH v3] tty: serial: max3100: shut down timer before freeing port
Date: Wed,  5 Aug 2026 00:40:39 +0000
Message-Id: <20260805004039.382698-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2026080353-bats-jailhouse-804f@gregkh>
References: <2026080353-bats-jailhouse-804f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgCXyTC+hnJqZfnlAg--.1858S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?xCuIiQXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnXz+g1OQfMo27QHy5TwQyZyOVMmQOkizLkuaexDcogPgrmCuPT5teSqe6ob3RG8e4pvW
	RyO2L90EXdLxFDLi2GMB5rM+H8XhqwExY4Cjs2QP
X-Coremail-Antispam: 1Uk129KBj93XoW7Ar1xXFWrJF48JrWfZrWxZrc_yoW5JF45pF
	s3urs8KFWrWr47uFnxCwsxXF15Wa1fJw47Gr1xKw1a9r15JryYg3WxKay7KFW5AFWkWF4D
	JF95ta98Ar1qy3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Cb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Cr1j6rxdM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57
	IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE
	14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2
	IYc2Ij64vIr41lF7xvr2IYc2Ij64vIr40E4x8a64kEw24l42xK82IYc2Ij64vIr41l4I8I
	3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
	wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcI
	k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j
	6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jbo7NUUUUU=

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

This issue was found by an in-house static analysis tool.

Fixes: 7831d56b0a35 ("tty: MAX3100")
Cc: stable@vger.kernel.org # 6.2+
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
Changes since v2:
  - Drop irq_registered; use the workqueue lifetime to decide whether
    remove must release an IRQ left by the suspend path.

v1: https://lore.kernel.org/all/20260721035631.3186613-1-fanwu01@zju.edu.cn/
v2: https://lore.kernel.org/all/20260801061208.356142-1-fanwu01@zju.edu.cn/
---
 drivers/tty/serial/max3100.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 44b745fa26c6..48c66b6e1c18 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -537,9 +537,8 @@ static void max3100_shutdown(struct uart_port *port)
 	if (s->workqueue) {
 		destroy_workqueue(s->workqueue);
 		s->workqueue = NULL;
-	}
-	if (port->irq)
 		free_irq(port->irq, s);
+	}
 
 	/* set shutdown mode to save power */
 	max3100_sr(s, MAX3100_WC | MAX3100_SHDN, &rx);
@@ -752,6 +751,14 @@ static void max3100_remove(struct spi_device *spi)
 		if (max3100s[i] == s) {
 			dev_dbg(&spi->dev, "%s: removing port %d\n", __func__, i);
 			uart_remove_one_port(&max3100_uart_driver, &max3100s[i]->port);
+
+			s->force_end_work = 1;
+			timer_shutdown_sync(&s->timer);
+			if (s->workqueue) {
+				destroy_workqueue(s->workqueue);
+				s->workqueue = NULL;
+				free_irq(s->port.irq, s);
+			}
 			kfree(max3100s[i]);
 			max3100s[i] = NULL;
 			break;
-- 
2.34.1

