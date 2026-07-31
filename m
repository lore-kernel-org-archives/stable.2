Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D47213A258;
	Fri, 31 Jul 2026 09:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785488428; cv=none; b=mtyg4fs8ri8ibixezJbU3Ru6JDzkfR3VlPExtafnvGEw72b3SkFS30ryD4V0OMLcIoZ2YVNs/OAE2lutcys9QJ/YzorLdrplUk/pGEqqPMglAH97KIfmQgIF3N+dhYEd+t3vgSJD8DxNcoo7+fmwEiCC4kVWAwGIOJL27BQvSV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785488428; c=relaxed/simple;
	bh=RAvzM+hyqhMET+0kh2pL2XKORp71JrMeYeQ8Hkkl8dY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HyX5csHYY82rDJjs4CR72LCfy+q46gE305SO4JvRnY+ZFuiCkueXhry2JK3qP3bjtoRplJf2gcl/bHktLE7B50KOJQDDBtWe7W6QtDttwu4nFlrcjBcvgr3/M3a9NyRbSCvcWOQB++ETFFF1McnEkH+Cz6b5w/VccuBQN5YHgkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wAHIX0dZGxqJ2pTAA--.3293S3;
	Fri, 31 Jul 2026 17:00:13 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app4 (Coremail) with SMTP id zi_KCgB3fDYaZGxqvp_CAg--.43373S3;
	Fri, 31 Jul 2026 17:00:12 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: linux@armlinux.org.uk,
	gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH v2 1/3] serial: amba-pl011: fix indefinite RS485 post-send delay
Date: Fri, 31 Jul 2026 08:59:13 +0000
Message-Id: <20260731085915.326775-2-fanwu01@zju.edu.cn>
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
X-CM-TRANSID:zi_KCgB3fDYaZGxqvp_CAg--.43373S3
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?t1IxGgXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnXz+g1OQfMo27QHy5TwQyZzZ0ZzJ4V0ypg1/R1cPfCk3LJLLPouM96QrQijSMggK2hMq
	l8kLwkGb+F/+Z/18/iap9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoW7KrW3uw17tFW7Zw47XF4xGrX_yoW8uryfpr
	4kCrZFkFW0qa10qF47ZFW8WFWFqasxJwsI9FWUKa4rA3W3trn5GwnxJFZFgrZ7Z398WayY
	yryYyrs8GayIgagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Gb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8D5r7UUUUU==

The RS485 stop hrtimer is used both to drain the transmitter and to wait
out delay_rts_after_send. The callback cannot tell the two apart, so it
restarts the post-send delay on every expiry and the timer never stops.

Add a WAIT_AFTER_SEND_DELAY state so its expiry ends the stop sequence
instead of restarting the delay.

Fixes: 2c1fd53af21b ("serial: amba-pl011: Fix RTS handling in RS485 mode")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/tty/serial/amba-pl011.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 7f17d288c807..b212e2bcd41a 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -253,6 +253,7 @@ enum pl011_rs485_tx_state {
 	WAIT_AFTER_RTS,
 	SEND,
 	WAIT_AFTER_SEND,
+	WAIT_AFTER_SEND_DELAY,
 };
 
 /*
@@ -1285,6 +1286,7 @@ static void pl011_rs485_tx_stop(struct uart_amba_port *uap)
 			return;
 		}
 		if (port->rs485.delay_rts_after_send > 0) {
+			uap->rs485_tx_state = WAIT_AFTER_SEND_DELAY;
 			hrtimer_start(&uap->trigger_stop_tx,
 				      ms_to_ktime(port->rs485.delay_rts_after_send),
 				      HRTIMER_MODE_REL);
@@ -1350,7 +1352,8 @@ static void pl011_rs485_tx_start(struct uart_amba_port *uap)
 		uap->rs485_tx_state = SEND;
 		return;
 	}
-	if (uap->rs485_tx_state == WAIT_AFTER_SEND) {
+	if (uap->rs485_tx_state == WAIT_AFTER_SEND ||
+	    uap->rs485_tx_state == WAIT_AFTER_SEND_DELAY) {
 		hrtimer_try_to_cancel(&uap->trigger_stop_tx);
 		uap->rs485_tx_state = SEND;
 		return;
@@ -1417,7 +1420,8 @@ static enum hrtimer_restart pl011_trigger_stop_tx(struct hrtimer *t)
 	unsigned long flags;
 
 	uart_port_lock_irqsave(&uap->port, &flags);
-	if (uap->rs485_tx_state == WAIT_AFTER_SEND)
+	if (uap->rs485_tx_state == WAIT_AFTER_SEND ||
+	    uap->rs485_tx_state == WAIT_AFTER_SEND_DELAY)
 		pl011_rs485_tx_stop(uap);
 	uart_port_unlock_irqrestore(&uap->port, flags);
 
-- 
2.34.1

