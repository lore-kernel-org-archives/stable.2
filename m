Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B6E2765D7;
	Tue, 11 Aug 2026 01:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786410339; cv=none; b=WdrFWVD6yRobDAaXT+e2B76uuUg9iJo0ZKJE8IyqUZzK66OMQc1C2Z4JDgA4hLpWdCEYHlIOit30jwLiUTtxgE00J2Es+MfgvMYZhPo17K8S0bUoCI8lg5wAZHiemnGfNew81FnxSN+EADyAzeKEccKVIj+7fCWry7a27FjGsK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786410339; c=relaxed/simple;
	bh=MeOVnt1pfpLAuJ3pd7znGcTUQxTwr3IXeKifitSeQ7A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=obEQHXowpBISn8heQFLddMSzvggGWwMRYFNQSI7Um/N/Sb0rL8LnuuCt0ZmXgb72btg7hYIvl91Eqv4tiA0y5dSuniaZdhMbntMXrOoMryILyoYUgTwovjvL+apz4/gynr/L/8rkfjJA9VJcXpoym9kOPoN24vuWs/v2AEatSHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wCXrnxDdXpqsFKCAA--.43717S3;
	Tue, 11 Aug 2026 09:05:07 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app2 (Coremail) with SMTP id zC_KCgBn2c4_dXpqGPDCAw--.32215S4;
	Tue, 11 Aug 2026 09:05:07 +0800 (CST)
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
Subject: [PATCH v3 2/2] ieee802154: cc2520: fix RX tasklet use-after-free
Date: Tue, 11 Aug 2026 01:03:59 +0000
Message-Id: <20260811010359.131381-3-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260811010359.131381-1-fanwu01@zju.edu.cn>
References: <20260811010359.131381-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgBn2c4_dXpqGPDCAw--.32215S4
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?24W27gXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfncGSG+szpQCInt5Y8rbJUI0/3bNnH6IBHUXrR+z64Goh9rMe/2+9ZL9dpEOuyDwloWQ8
	J5wDK7E/7D2LJ3LwSiCp9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoWxArW8Zw1xGw47Zr47Kw47KFX_yoW5Ww18pw
	sxWas3Kr10qw40y3y3JF18XF98Ca1xtay8uay8G39rAwnIvrnYqr4IvFySvrW8JFWkZayS
	vFn8Jr45uws8CagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8-6pPUUUUU==

The FIFOP interrupt was requested before cc2520_register(), so a failed
registration could still have let the FIFOP handler queue RX work.  That
work calls ieee802154_rx_irqsafe(), scheduling the mac802154 RX tasklet,
which is killed only by ieee802154_unregister_hw(); on a failed
registration that does not run, so ieee802154_free_hw() could free it
while still pending.

Request the FIFOP interrupt after cc2520_register() so a registration
failure cannot schedule RX work, and the SFD interrupt before it, so
synchronous TX has its completion available once the netdev is visible.
cc2520_register() no longer frees the hardware on its own failure; the
probe cleanup does.

Found by an in-house static analysis tool.

Fixes: 0da6bc8cc341 ("ieee802154: cc2520: adds driver for TI CC2520 radio")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/net/ieee802154/cc2520.c | 38 +++++++++++++++++----------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index abfcfe072..1b588f8d3 100644
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
 
-- 
2.34.1

