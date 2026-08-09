Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC2916F288;
	Sun,  9 Aug 2026 02:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786242076; cv=none; b=LnFc71zDWhA8p6Qn66b10AbtjIQ/ahVruKtYpF2VWl9fKwiu+VwyTbTq9+vCJeVxD9ACU9RYs2rL3s+qPZE/RTZ0TsquoSlOdPzzP0Lc/IljmIncPzgPwRW3XPOFMRtvkUZaQQx1EzFcAtroAZMLX9iFSxKK/R+MTESxSy1K/bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786242076; c=relaxed/simple;
	bh=n//xP7ruFUGk8nqCbY/7PNVJO7R8acD6Fe6Ntc6kfjk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O0++6ww1xYfYme29U37Wttz6vfB6WVp+BS6u7KqC9KLC3iNTLLCQ1C0i3dqWg8aA0UX2g1Z5DIEXZMdENUa7LhI15WjLi4siNmVPqdDu5265C6+d6VqFKdDOu3tAwll0lYy65iu1d3iDau9gD8fz1bgYDWL4UAGlvO4DQ/NCOdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wD3EH3e43dqFaF5AA--.56086S3;
	Sun, 09 Aug 2026 10:20:15 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app2 (Coremail) with SMTP id zC_KCgBn2c7d43dqHxuyAw--.28571S2;
	Sun, 09 Aug 2026 10:20:14 +0800 (CST)
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
Subject: [PATCH v2] ieee802154: cc2520: fix FIFOP work use-after-free
Date: Sun,  9 Aug 2026 02:19:17 +0000
Message-Id: <20260809021917.102947-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgBn2c7d43dqHxuyAw--.28571S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?X9XDlgXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfncGSG+szpQCInt5Y8rbJUI3Iyn0vUCpoKo2OqjH8YQvuoAYyx/tXC+HxcRCAXh74glU1
	sNhNI50YIJo/twPgPy+p9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoWxCw1kZw45Ar15Zr1xtrWxXwc_yoWrJw45pa
	nxGas3KrW8Xw10k3y3Jr18XF95Ca1xKay8u34xG3s3AwnxAryvqrWIyFy0vFyrJFWvva1S
	yFs8Xr45u398AFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
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
	WxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU85l1PUUUUU==

The FIFOP interrupt handler queues cc2520_fifop_irqwork.  On removal,
cc2520_remove() only flushes the work.  The devm-managed FIFOP IRQ
remains active until after ->remove() returns and can queue the work
again after that flush, allowing it to run after the private data is
released.

Disable the work with disable_work_sync() instead of flushing it, so
the handler can no longer queue it once removal begins.  Destroy
buffer_mutex last, since unregistering can invoke the driver's stop
callback, which uses it.

Install the SFD IRQ before cc2520_register(), so it is available when
the netdev becomes visible.  Install the FIFOP IRQ afterwards, so a
registration failure cannot schedule RX work while its hardware is
being released; cc2520_register() no longer frees the hardware on its
own failure, leaving that to the probe cleanup.

Found by an in-house static analysis tool.

Fixes: 0da6bc8cc341 ("ieee802154: cc2520: adds driver for TI CC2520 radio")
Cc: stable@vger.kernel.org #v6.10+
Suggested-by: Miquel Raynal <miquel.raynal@bootlin.com>
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/net/ieee802154/cc2520.c | 43 +++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

Changes in v2:
- Use disable_work_sync() for the FIFOP work instead of explicitly
  freeing the interrupts. Drops the interrupt-number fields and the
  manual devm_free_irq() calls.

diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index 2b7034193..1b588f8d3 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -857,12 +857,10 @@ static int cc2520_register(struct cc2520_private *priv)
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
@@ -1116,19 +1114,7 @@ static int cc2520_probe(struct spi_device *spi)
 	if (ret)
 		goto err_hw_init;
 
-	/* Set up fifop interrupt */
-	ret = devm_request_irq(&spi->dev,
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
+	/* SFD completes synchronous TX; install before cc2520_register(). */
 	ret = devm_request_irq(&spi->dev,
 			       gpiod_to_irq(sfd),
 			       cc2520_sfd_isr,
@@ -1142,13 +1128,29 @@ static int cc2520_probe(struct spi_device *spi)
 
 	ret = cc2520_register(priv);
 	if (ret)
-		goto err_hw_init;
+		goto err_free_hw;
+
+	/* FIFOP arms the RX work; install after cc2520_register(). */
+	ret = devm_request_irq(&spi->dev,
+			       gpiod_to_irq(fifop),
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
+err_free_hw:
+	if (priv->hw)
+		ieee802154_free_hw(priv->hw);
 err_hw_init:
 	mutex_destroy(&priv->buffer_mutex);
-	flush_work(&priv->fifop_irqwork);
 	return ret;
 }
 
@@ -1156,11 +1158,10 @@ static void cc2520_remove(struct spi_device *spi)
 {
 	struct cc2520_private *priv = spi_get_drvdata(spi);
 
-	mutex_destroy(&priv->buffer_mutex);
-	flush_work(&priv->fifop_irqwork);
-
+	disable_work_sync(&priv->fifop_irqwork);
 	ieee802154_unregister_hw(priv->hw);
 	ieee802154_free_hw(priv->hw);
+	mutex_destroy(&priv->buffer_mutex);
 }
 
 static const struct spi_device_id cc2520_ids[] = {

