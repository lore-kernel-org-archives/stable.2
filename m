Received: from mail-oo2-f40.google.com (mail-oo2-f40.google.com [74.125.231.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86578330659
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 03:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789354901; cv=none; b=MMGEHQRp7srtsKF0cHMJXLrASZRbD3plJkz4r2BXghPvU1QGagJUTvhXOYZLbOt7W4fSgm1ZBFjTpDduuXQ9Xzi2S2M3eTemcDstKSBXXT0J/6+OHy0NfSpiUbbs5TgBhfzuLxJCDHT51WU1620ujfaJWO0xkwQ5c6LynrwoAlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789354901; c=relaxed/simple;
	bh=Lpu8BYiYZNteYXFlDSxlBr4C2CnU/Gx0SiTFgcn6nP0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mnqSRoDyG1H2cm0Qym9wS/xawuGakAGzY0aQsJ1WJYtCfhIhD+TWOSeWVHLp2r4/72N6ghsZ2Qav+rJtKNaLBUa1pl0JZFOtjGVAha8jn5ZzdQ8pN0JSzANtX4IRr7fDUuLYLUuxBndBpa3+6GKS3g+sHMeD6G1gVct74vlpomE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XboecROT; arc=none smtp.client-ip=74.125.231.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XboecROT"
Received: by mail-oo2-f40.google.com with SMTP id 46e09a7af769-7f4f0d298ccso453886a34.3
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 20:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789354898; x=1789959698; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EsI+dpw6vMR742jYDR1gddCVyVHs7LTF48bPd8UEx9g=;
        b=XboecROTiiF/twGa3ijeSfV3GI9qYzxHiizXpeYKaNNYEozshQN7YpoqR5QuZyHp9F
         qGjRb7Cm7TW/45XLJnHDpXnEJ6dSxml+ZFo0J/I9uQ4Sl1CcCuLMWho3zR2Nr4gexS5r
         ILu6960jwe1ayy+QyledRYw6OomzOGjE3ic/3nlNgHcjMkeKEvoAwV0A2A7dNmJpFsOk
         14QyoLMQwEfJ7pMYl363Wm+j+FITaeQF/jXNESG8H4Nuqo69HV/Q0sV2NtsZUotLTI+L
         chFPWHoDlN2JdgQY+RUjlrQMCAp7FFTYufJGeo9FmYtoDW4pnO2TUQV+jYgutLiHqJQf
         X//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789354898; x=1789959698;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EsI+dpw6vMR742jYDR1gddCVyVHs7LTF48bPd8UEx9g=;
        b=s8qvUizBLvNMho/IXSQqpQwOv6r8zCELWxlvPQBYOtpjmTw3HN0vuNjfOhtVUXmisX
         vj665uaKt9iehHMu47ADOp5C74fw1PDh50Nfuc8K6VyGmNARKz7HZCzw/GnY48z5d+Gi
         4WXHdV9G8Ud+WjFWoQ9uOOgihKKXFrC8Ks98FLgRXXah4eDst6Z4xYbNvKJJFUkqG4y2
         qEHs+LZORNZaT6Bw14ZXNYPH7Fm4HNdFti35ZIKxOLmYEtm5SjcW3THz4q8qqp/KCVg5
         4rpZ8Qv/jEGYGoFeeEqtqR+70EYju6FDwlO4rlyv+7zIbzgFt+mK3GHtCs1ZVuGLpLul
         88ag==
X-Forwarded-Encrypted: i=1; AKwUvByvtJwXNkFgFskhccNZeBAexhjfSBcljZl5Znwbkfk6pSq6X3uuQ8rcssTrBlUOA2wQ1vl8vlE=@vger.kernel.org
X-Gm-Message-State: AFuF++liBKtBI8hVZHa6HchIFJyiz77OtQTpu/dWMeCGsTXHoWZ8m2uS
	FiZ0a7AbdouK+EsItPZEbg6gbwf2vGh4mwDqpEcMOJyv0SkPZ5XqxfRH
X-Gm-Gg: AYBFou2OcEJTdSH3UIMJHs2JcTfj32HB2R/k6cBgGPc4lcUChkl1Maf/DwxBAL1ebNL
	K2eEV3heL31zAUKAAIwidma58BnCtPaCoG7z2xoF/sXzzHuxVfVQQFwYPeEvEZ/VJVau8ejxEEq
	3fOcmyMT9pMFHi9JPZ0WHqgNlTJT8YHKqH9dfCz4UdbmldYe7BI+PxmOWEpEFDTJaSw20uiEUw9
	g7h/fmH9tdqe3QrQ/Vg4ri4NaJOdVF+gexJFOOPIpRs1RRopyfjjJfNeagZ6PL946HYxRnMwiUh
	UIbQT9LnQklD1Wq7gOPmZLehedAp90yYTw4opJbq4U0CFq9EwtKCYWrw5eyyFF/Lh3VQcDCNea2
	3mmbrcf0WHd20DD+UY/pONnf5WC18IPOZ5WlnjxYJ3HhKyj45xY1V4mLmVt5p95pEuE+fEiKYm5
	LyVlFq3nR1k9rTDF2w4Zokfu4B2Nm38SVlN9tsJwcDCV2HU0nOoR48aBeZyKy4MqP3kF404IpBs
	u9hX+JUb7140K0OhiYzNYl9OqZa6JUHJBTYnBKibg3BNEWe9n7P0934AwjFzVPlxpzNfCqKF/Ze
	MLOpWzTcFlBAjHL+L3Ae9OD25zd1Nx8oBB7ZwiogMSiuHqrOnAg1fk6LEYTq4HuOTU9US0l6/ae
	YqkOxscAMDL/WhoCZP6wJhW/kp6Bw5lqWgUZulYlv
X-Received: by 2002:a05:6830:81fb:b0:7fb:547f:98bc with SMTP id 46e09a7af769-80897394cd9mr261168a34.5.1789354898430;
        Sun, 13 Sep 2026 20:01:38 -0700 (PDT)
Received: from [127.0.1.1] (184-96-157-145.hlrn.qwest.net. [184.96.157.145])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-803f60feba1sm10619014a34.13.2026.09.13.20.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 20:01:37 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 13 Sep 2026 21:01:07 -0600
Subject: [PATCH v5 01/18] mtd: rawnand: sunxi: drain interrupts before
 reusing the completion
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-submit-sunxi-nand-vendor-oob-layout-v1-v5-1-7d711076a6f7@gmail.com>
References: <20260913-submit-sunxi-nand-vendor-oob-layout-v1-v5-0-7d711076a6f7@gmail.com>
In-Reply-To: <20260913-submit-sunxi-nand-vendor-oob-layout-v1-v5-0-7d711076a6f7@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Masahiro Yamada <yamada.masahiro@socionext.com>, 
 Boris Brezillon <bbrezillon@kernel.org>, 
 Brian Norris <computersforpeace@gmail.com>
Cc: linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2

A timed-out wait can return while the interrupt handler is still using
the previous operation's interrupt status and enable mask. Starting the
next wait calls init_completion() on the same object, which can reset its
waitqueue lock while the old handler calls complete(). The old handler
can also complete the new wait or restore an obsolete interrupt mask.

Initialize the completion once in probe and use reinit_completion() for
each interrupt-driven wait. On timeout, disable and synchronize the IRQ
before masking controller interrupts and acknowledging the waited-for
events. Draining the handler first also prevents a partial-event handler
from rewriting the enable mask after it has been cleared. Flush these
register writes before re-enabling the IRQ line, leaving the controller's
interrupt sources masked.

For successful waits, move complete() after the handler's register updates
so that the next operation cannot race with those updates. Keep polling
unchanged and leave controller and DMA abort handling to the existing
callers.

Fixes: 1fef62c1423b ("mtd: nand: add sunxi NAND flash controller support")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index f41feebe4257..e50cf5b6a730 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -374,6 +374,7 @@ struct sunxi_nfc_caps {
  * @chips: a list containing all the NAND chips attached to this NAND
  *	   controller
  * @complete: a completion object used to wait for NAND controller events
+ * @irq: NAND controller interrupt
  * @dmac: the DMA channel attached to the NAND controller
  * @use_mdma: use an internal MBUS DMA backend
  * @mdma_desc: H6-style MBUS DMA descriptor
@@ -393,6 +394,7 @@ struct sunxi_nfc {
 	unsigned long clk_rate;
 	struct list_head chips;
 	struct completion complete;
+	int irq;
 	struct dma_chan *dmac;
 	bool use_mdma;
 	struct sunxi_nfc_mdma_desc *mdma_desc;
@@ -414,12 +416,13 @@ static irqreturn_t sunxi_nfc_interrupt(int irq, void *dev_id)
 	if (!(ien & st))
 		return IRQ_NONE;
 
-	if ((ien & st) == ien)
-		complete(&nfc->complete);
-
+	/* Finish updating the interrupt state before waking the next operation. */
 	writel(st & NFC_INT_MASK, nfc->regs + NFC_REG_ST);
 	writel(~st & ien & NFC_INT_MASK, nfc->regs + NFC_REG_INT);
 
+	if ((ien & st) == ien)
+		complete(&nfc->complete);
+
 	return IRQ_HANDLED;
 }
 
@@ -435,16 +438,19 @@ static int sunxi_nfc_wait_events(struct sunxi_nfc *nfc, u32 events,
 		timeout_ms = NFC_DEFAULT_TIMEOUT_MS;
 
 	if (!use_polling) {
-		init_completion(&nfc->complete);
+		reinit_completion(&nfc->complete);
 
 		writel(events, nfc->regs + NFC_REG_INT);
 
 		ret = wait_for_completion_timeout(&nfc->complete,
 						msecs_to_jiffies(timeout_ms));
-		if (!ret)
+		if (!ret) {
+			/* Drain the handler before it can restore an old IRQ mask. */
+			disable_irq(nfc->irq);
 			ret = -ETIMEDOUT;
-		else
+		} else {
 			ret = 0;
+		}
 
 		writel(0, nfc->regs + NFC_REG_INT);
 	} else {
@@ -457,6 +463,12 @@ static int sunxi_nfc_wait_events(struct sunxi_nfc *nfc, u32 events,
 
 	writel(events & NFC_INT_MASK, nfc->regs + NFC_REG_ST);
 
+	if (!use_polling && ret) {
+		/* Flush the mask and acknowledgment before re-enabling the IRQ. */
+		readl(nfc->regs + NFC_REG_INT);
+		enable_irq(nfc->irq);
+	}
+
 	if (ret)
 		dev_err(nfc->dev, "wait interrupt timedout\n");
 
@@ -2617,6 +2629,7 @@ static int sunxi_nfc_probe(struct platform_device *pdev)
 	nfc->dev = dev;
 	nand_controller_init(&nfc->controller);
 	INIT_LIST_HEAD(&nfc->chips);
+	init_completion(&nfc->complete);
 
 	nfc->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
 	if (IS_ERR(nfc->regs))
@@ -2625,6 +2638,7 @@ static int sunxi_nfc_probe(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
+	nfc->irq = irq;
 
 	nfc->caps = of_device_get_match_data(dev);
 	if (!nfc->caps)

-- 
2.53.0

