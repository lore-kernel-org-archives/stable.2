Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700339;
	b=3FcP6OTN1WkwOmCjjOMrndVoZvcYnDp5xIVNpSz/H2aIs8Mxw4HPIGEcqp/76KLZmH9P
	 wwEuDjBN7avnt0UkG6P8IEq5EIr/6dybf9NAGYjCWMK4z5Vdnu2Vaja+trPbgQARaWbtG
	 R0UAguCcVhai1XixRM9cfIvgBH48WE48r9yuhlRrUDEgGa+rVywXuVs7dtzWpswwfk237
	 KeeLfCiN0ZhyrWwBBy3W/DOvbs+WMGHAp33/ETafRy2SVDcJg3RbdlO1ybZdcMq37JWaP
	 x2Vxg+0z0XoPNW3m7vg+3EL9dq2lCA3rdneVAff54n3E32fbZ2hfrmKRG4Zhn1iNw+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700339;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=gJbduYY+2MLz7vY8LSMtIk42i7cqHj5q97uCgEORjb8=;
	b=v7BEwnt7Z4uE5wQJ6m8Zv+T06H+u/KEKoPkD6Hw01RDJAHJ72YhheXlt1bAiSz3Jm/hg
	 VJ43tBE7g4LyGiQtow8O8snu3Ac2dLBiElhFByZ6f4xgcFM275RpWZ2WOr2iPf3oOgO6L
	 jJ11dJt9vdS7IMg2j/BUtJ/Rp5UX05SMvRZJN44I5EPxKjLkulnqFn6OpJ3zhgqWs89Ne
	 qYfwSt5U7MG9g/O3kfQ3Po6OOdlDkUHR8UpadqcRpOdDVqt3xDJmeeCrNPHygXmT7O9vI
	 Rg4FOfxT4xUrEmCI3b2Qo6PhqX+16E9dlrs4Fdhlm0cvCFnrMtlo7NLq1PkERTqDQ4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D3460A381C;
	Tue,  3 Nov 2026 10:05:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30D3460A381C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAAXIZLmselqnXs7AA--.2519S2;
	Tue, 03 Nov 2026 18:05:26 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: mvpp2: free pending TX timestamp skbs when the port is stopped
Date: Tue,  3 Nov 2026 10:05:35 +0000
Message-Id: <20261103100535.1310088-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAXIZLmselqnXs7AA--.2519S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KrW3ArW5ZryxGr4fZrW7CFg_yoW8urW7pF
	WjyryYyFWkXF47Z347Wa1jyr1Fqw1xtF43GFWIk34Yq347Grykur409a90vFW8JrWkXry7
	AF4xKFsrGr4DXFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9a14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4UJVW0owAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6r
	yUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_Gc
	JvcSsGvfC2KfnxnUUI43ZEXa7VU8jQ6JUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAEAA2rpnOFgbAAAs8

mvpp2_tx_hw_tstamp() takes an extra reference on skbs that need a TX
timestamp and stores them in port->tx_hwtstamp_queue[]. The reference is
dropped by mvpp2_isr_handle_ptp_queue() when the hardware reports the
timestamp. Nothing drains the queues when the port is stopped, so skbs
still waiting for a timestamp keep their reference until their queue
slot is reused, and are leaked for good when the port is removed.

Free the queued skbs in mvpp2_stop(), after the interrupts have been
released.

Fixes: f5015a594c50 ("net: mvpp2: ptp: add support for transmit timestamping")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 317af54369cf..fc020b8c8830 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -3419,6 +3419,22 @@ static void mvpp2_isr_handle_ptp(struct mvpp2_port *port)
 		mvpp2_isr_handle_ptp_queue(port, 1);
 }
 
+static void mvpp2_tx_hwtstamp_flush(struct mvpp2_port *port)
+{
+	struct mvpp2_hwtstamp_queue *queue;
+	int nq, i;
+
+	for (nq = 0; nq < ARRAY_SIZE(port->tx_hwtstamp_queue); nq++) {
+		queue = &port->tx_hwtstamp_queue[nq];
+		for (i = 0; i < ARRAY_SIZE(queue->skb); i++) {
+			if (!queue->skb[i])
+				continue;
+			dev_kfree_skb_any(queue->skb[i]);
+			queue->skb[i] = NULL;
+		}
+	}
+}
+
 static void mvpp2_isr_handle_link(struct mvpp2_port *port,
 				  struct phylink_pcs *pcs, bool link)
 {
@@ -4914,6 +4930,7 @@ static int mvpp2_stop(struct net_device *dev)
 		free_irq(port->port_irq, port);
 
 	mvpp2_irqs_deinit(port);
+	mvpp2_tx_hwtstamp_flush(port);
 	if (!port->has_tx_irqs) {
 		for (thread = 0; thread < port->priv->nthreads; thread++) {
 			port_pcpu = per_cpu_ptr(port->pcpu, thread);
-- 
2.34.1

