Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB1434CFD0;
	Thu,  6 Aug 2026 05:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785992747; cv=none; b=eQTVJ/HZTS+G7cO6ZBret6ltsGwGNU8vuH0vcp7PaxRv33r9ZQ5Vdn3KzQFnteqe9txST0x/wiIs0x5tgSEtzVaEgQ8xQfzxclSts5qCHV+nmkOiPqTJO+eBweyUPGvk1SAZjR1H1AYbf/Wk6IXTGlhQlCGCTwP84hWbjbsm3Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785992747; c=relaxed/simple;
	bh=mEj63TRaST/oKqFY1pmIZ6Sri3W/nvqY7ej7DXbr/ZI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K58GOQEloQ8zGZsYVXPCd/ClTPpt6X3K+lkd7ce1TfPZo8axDjR3mlaULp4hUa8UJwbCJ3mDQ3nJi2gy4CX7SSuA+F4K2gbczU1MrHMHZbtcVFA9I64C6ZAnf7JFL+1KBb+Ak2TNW3N2YDUtnIqhf5fT6GMdUHKh6t4hB3SdSic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wDnv_wOFnRqf5lsAA--.30629S3;
	Thu, 06 Aug 2026 13:05:19 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app1 (Coremail) with SMTP id yy_KCgBXyKENFnRqQGiSAw--.12767S2;
	Thu, 06 Aug 2026 13:05:17 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: linux-wpan@vger.kernel.org
Cc: Stefan Schmidt <stefan@datenfreihafen.org>,
	Alexander Aring <alex.aring@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Varka Bhadram <varkab@cdac.in>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ieee802154: cc2520: fix FIFOP work use-after-free
Date: Thu,  6 Aug 2026 05:03:28 +0000
Message-Id: <20260806050328.422480-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgBXyKENFnRqQGiSAw--.12767S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?zD6DNgXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnVCjTgEH9dVomQuWcozCBBHzRKAK4G0UH2H3fB4lQ+lr007xFaOoG+XTwS7zUjcLREga
	4iWHFLcsO4Je6co+FqOp9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoWxCw4UJw1fXw15Gw4rCFWUWrX_yoWrCF47pa
	nxWa93Kry0qw40k39xJF18WFn5Ca18Kay8Ca4xGas7AwnxAr90qr1SyFy0vFWrJFyvvayS
	9rs8Jr45uan8AFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU85l1PUUUUU==

The FIFOP interrupt handler queues cc2520_fifop_irqwork.  On
removal, cc2520_remove() only flushes the work.  The devm-managed
FIFOP IRQ remains active until after ->remove() returns and can queue
the work again after that flush, allowing it to run after the private
data is released.

Release the FIFOP IRQ and cancel the work before unregistering and
freeing the hardware.  Keep the SFD IRQ active while
ieee802154_unregister_hw() flushes the mac802154 workqueue: synchronous
TX waits in cc2520_tx() for the completion signalled by the SFD handler.
Release the SFD IRQ afterwards.  Destroy buffer_mutex last, since
unregistering can invoke the driver's stop callback, which uses it.

Install the SFD IRQ before cc2520_register(), so it is available when
the netdev becomes visible.  Install the FIFOP IRQ afterwards, so a
registration failure cannot schedule RX work while its hardware is
being released.  Move ieee802154_free_hw() to the probe cleanup.

Found by an in-house static analysis tool.

Fixes: 0da6bc8cc341 ("ieee802154: cc2520: adds driver for TI CC2520 radio")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/net/ieee802154/cc2520.c | 51 ++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index 2b7034193..464e896e3 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -206,6 +206,8 @@ struct cc2520_private {
 	bool is_tx;			/* Flag for sync b/w Tx and Rx */
 	bool amplified;			/* Flag for CC2591 */
 	struct gpio_desc *fifo_pin;	/* FIFO GPIO pin number */
+	int fifop_irq;
+	int sfd_irq;
 	struct work_struct fifop_irqwork;/* Workqueue for FIFOP */
 	spinlock_t lock;		/* Lock for is_tx*/
 	struct completion tx_complete;	/* Work completion for Tx */
@@ -857,12 +859,10 @@ static int cc2520_register(struct cc2520_private *priv)
 	dev_vdbg(&priv->spi->dev, "registered cc2520\n");
 	ret = ieee802154_register_hw(priv->hw);
 	if (ret)
-		goto err_free_device;
+		goto err_ret;
 
 	return 0;
 
-err_free_device:
-	ieee802154_free_hw(priv->hw);
 err_ret:
 	return ret;
 }
@@ -1116,21 +1116,10 @@ static int cc2520_probe(struct spi_device *spi)
 	if (ret)
 		goto err_hw_init;
 
-	/* Set up fifop interrupt */
+	/* SFD completes synchronous TX; install before cc2520_register(). */
+	priv->sfd_irq = gpiod_to_irq(sfd);
 	ret = devm_request_irq(&spi->dev,
-			       gpiod_to_irq(fifop),
-			       cc2520_fifop_isr,
-			       IRQF_TRIGGER_RISING,
-			       dev_name(&spi->dev),
-			       priv);
-	if (ret) {
-		dev_err(&spi->dev, "could not get fifop irq\n");
-		goto err_hw_init;
-	}
-
-	/* Set up sfd interrupt */
-	ret = devm_request_irq(&spi->dev,
-			       gpiod_to_irq(sfd),
+			       priv->sfd_irq,
 			       cc2520_sfd_isr,
 			       IRQF_TRIGGER_FALLING,
 			       dev_name(&spi->dev),
@@ -1142,13 +1131,31 @@ static int cc2520_probe(struct spi_device *spi)
 
 	ret = cc2520_register(priv);
 	if (ret)
-		goto err_hw_init;
+		goto err_free_sfd;
+
+	/* FIFOP arms the RX work; install after cc2520_register(). */
+	priv->fifop_irq = gpiod_to_irq(fifop);
+	ret = devm_request_irq(&spi->dev,
+			       priv->fifop_irq,
+			       cc2520_fifop_isr,
+			       IRQF_TRIGGER_RISING,
+			       dev_name(&spi->dev),
+			       priv);
+	if (ret) {
+		dev_err(&spi->dev, "could not get fifop irq\n");
+		goto err_unregister;
+	}
 
 	return 0;
 
+err_unregister:
+	ieee802154_unregister_hw(priv->hw);
+err_free_sfd:
+	devm_free_irq(&spi->dev, priv->sfd_irq, priv);
+	if (priv->hw)
+		ieee802154_free_hw(priv->hw);
 err_hw_init:
 	mutex_destroy(&priv->buffer_mutex);
-	flush_work(&priv->fifop_irqwork);
 	return ret;
 }
 
@@ -1156,11 +1163,13 @@ static void cc2520_remove(struct spi_device *spi)
 {
 	struct cc2520_private *priv = spi_get_drvdata(spi);
 
-	mutex_destroy(&priv->buffer_mutex);
-	flush_work(&priv->fifop_irqwork);
+	devm_free_irq(&spi->dev, priv->fifop_irq, priv);
+	cancel_work_sync(&priv->fifop_irqwork);
 
 	ieee802154_unregister_hw(priv->hw);
+	devm_free_irq(&spi->dev, priv->sfd_irq, priv);
 	ieee802154_free_hw(priv->hw);
+	mutex_destroy(&priv->buffer_mutex);
 }
 
 static const struct spi_device_id cc2520_ids[] = {

