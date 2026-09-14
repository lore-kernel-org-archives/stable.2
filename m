Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A179463B8D
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 21:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789420201; cv=none; b=NbCmqpi86Vrmq6kWbEkZ48hCS7yLjQdX1chs7mWHFlU6/XukR+LUrH7xnVp/VUP9yN8bsQwfKJWsLewTTvkgM+QG8eXLMYN/Hq56smm+5KvCIV/8v7hxd5N9M0aF96hyFEjjvjqdo5KJ+VIuQtWmMb7ZaPAIRmYW5OouWI2+vkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789420201; c=relaxed/simple;
	bh=Lpu8BYiYZNteYXFlDSxlBr4C2CnU/Gx0SiTFgcn6nP0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aI80agxcCk6aVj+9BfyvgXPYahEmVSegH/YktD4P1GGu0kDRIJRiu5pD+GxXNzGqDO20MqqUM4AKlpLVMuvI2DO2z4YZY0YF7EtgZCG64PGbUsBw5hSziUFdDdGWSpmawbcMg4oglG7JiWCvWN3w/xC1GRkDoiPkRLtfPm7VzW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ESj1jxDE; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESj1jxDE"
Received: by mail-oo2-f41.google.com with SMTP id 006d021491bc7-6b1ae7166ebso1500214eaf.1
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 14:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789420196; x=1790024996; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EsI+dpw6vMR742jYDR1gddCVyVHs7LTF48bPd8UEx9g=;
        b=ESj1jxDEdiHSeFw3lDieeXpPuAefVmMpIAIIciJkypCfYQgHlVRYZ9C3caqNiGHkg2
         DsibmWK7k/EXsbddZvTopM2CLO1xA2cx7OsQW+iMhcHgM9xV0cDfD4g4V0ksxVbWyLD3
         YYPZ2CiRlQkwU/l7eAo/BsGbfSWCAbXDHjwo06o4ZQymHwfMcdQn6AdUWzzoCLttvL7N
         Jb8MccZUNvHo76t7ZqTr/JbYp1X1gOkLrmhKA+fUta6zBgHBMhB5eGnynjCimKf2g0n5
         ijvjnFGRMgqTKtReFk8MMj6sDYjRP/5Ty430yUqY+9xbmIMblcpE+Dhgo6R1mJJLdhHt
         bUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789420196; x=1790024996;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EsI+dpw6vMR742jYDR1gddCVyVHs7LTF48bPd8UEx9g=;
        b=zDwN5PKGxYQE6WItTfLQmgzCt1J+8OJNRhqHgXoa3s6OUEQ4SyG7JvkqCy1OXXmIsv
         TRkRHS2yGRP7dYGLX9qhjLkiWjvduJ3g64cc+26ucO3nH9NlxRVif0ahKntZbh35qvHu
         CAmtsi6D/bQr3/JIQoXj5Tw3FBn2RN2ETqN9n4TliSfMHF1bRdVOtcNzLqxOiBu6u7R2
         xnGmmHuatqMKtjgVtK3EykEYjTKS7vNI8wVp7R5nSP1UOdhFyLbXDLonWyf0seQPbMHw
         VVDbq1FNBr+xbQPkDS3J9a7FQWCaQ2cRxn2ElynDqyGtrI/DqQt4tUr17uX+H1Q82+gA
         ba1Q==
X-Forwarded-Encrypted: i=1; AKwUvBzNOcpH1s9se0DxgHmATeN1Wkn1vPpdWZvYWDSE8moffPYLvpwdxWwUfO8v+088sbIL/N90FIk=@vger.kernel.org
X-Gm-Message-State: AFuF++nJ1QEr636atwvytV5ZV1EeTxK35tjfX+r3GG1/7U0FDnJ55Wns
	DN91GMYdmhK03Fee+hOtw3BLR3mW04zB+ZCNNYHcmG7nguzJFc4eJRNS
X-Gm-Gg: AYBFou1y2DGu1RYvBxOosHMpq7/i+uJl219p0l6BgtR6VFFO2lULN0CuMBk79XimFNT
	TZttL9HhkuA841+RKJk7bcivjuYkdeVDTk/LtzSuG/ZX9rFe/EthGM/cdj7PHU01KvxB5jZRe4f
	am/7oQiegoDOJp8AW/a0ibKjbSw+zhGVFYkp9gvNdbWoKNd+fheYd+joFi/FJMs4tZ2hKnEq98C
	Bl1h5FGWYe4p0kqeVc6cGO0EeqKpWXA3pe8JLRMzVcb2l403wHPmDgcU1SgaY6CWyWR13cDXh/4
	bjb62YyNdIVNmUfprohHpWW0n9j4dtArZ2KAG4O8L3QEsGe2HK7UoGo3m+Ir9PUxyPm9sKLwB6A
	Zy4xpYwsZ+Ev6wjCZn6zEHoffnwKDlfkrvzIvT2MnDluPaCUG0agPRAk1kpDi2VxyGG2eTxCMmL
	z+XuLu6JQhxJRcWpCB5xjYPWWAqC66ZuWkbBwWMKQTmFi14FVg0PHbHtHWBWh06puT6bFF+ehDI
	YNSn7y7f9MkbPG8Y7tmPHkgtPXcRyT61jKUQQJNfA/9hcDIzMpPbGhgTpKteHmvqJbKI13qPbRJ
	+9/OaLiLlIZb4wCQKYRj1ctzAGejo/AMCJm3br0iYfiB062j7y8rkq5rMGHDKKF8eFiPHqpapb/
	6HexLL9DHQO+FpbLtGvUJITBctDNZ
X-Received: by 2002:a05:6820:4d01:b0:6a1:4507:3544 with SMTP id 006d021491bc7-6c540d62bbfmr2624632eaf.28.1789420196428;
        Mon, 14 Sep 2026 14:09:56 -0700 (PDT)
Received: from [127.0.1.1] (184-96-157-145.hlrn.qwest.net. [184.96.157.145])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c45bfc3fe9sm4698544eaf.15.2026.09.14.14.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 14:09:55 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 14 Sep 2026 15:09:47 -0600
Subject: [PATCH v6 01/18] mtd: rawnand: sunxi: drain interrupts before
 reusing the completion
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-submit-sunxi-nand-vendor-oob-layout-v1-v6-1-2fb084fe0751@gmail.com>
References: <20260914-submit-sunxi-nand-vendor-oob-layout-v1-v6-0-2fb084fe0751@gmail.com>
In-Reply-To: <20260914-submit-sunxi-nand-vendor-oob-layout-v1-v6-0-2fb084fe0751@gmail.com>
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

