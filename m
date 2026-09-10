Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C4A360EF6
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 13:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789046623; cv=none; b=tNlIDSW6DJ4CbSmNaFY9CRnlIo5IuqXAs3lE/uu7JOKCtdb/mZYaU1tDzVb74zjaxDMaVZKFsqFwifj3URUUksQrobTGG+EIH44mzuI59z3HUkZFayfFIVCuAw9f1LI/609rVj5SlyRrVP9h6TJDxXRXKnkoYPYDBxsMHrXV47w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789046623; c=relaxed/simple;
	bh=gsvDoeKpYWDzmfj/0yAWf3xNdwUAHKrN24wD0Pebdog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OaekaA+F+22TSYeK8GcrUeHBe0kMKh6bKoRnIITOI+m/62rYb2e64coUviOzlZ3kKo04r2rhwTxVPR2HOxqkWe+0io8iEvVdDDvRei/IENJ+n9lMUvsbmjQHmipl80hufhLZdNm3Bkf9zQak+/z2aoAA90EQo5QRsfDFaiasMmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmY7oWsk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmY7oWsk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F02D1F00893;
	Thu, 10 Sep 2026 13:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789046622;
	bh=fNTaSoieeH83C1FizKN+BDjmtc0IDbOqQnx4iu8TnVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZmY7oWskwLH71BbzfozC5AmDgo5JjOnwVevjgaNuOD78t7Qijt8njbbrF0+SUhfU2
	 YCRLrD/k3CM9D1MkNZYiWQvuamuX5Kn8HJwXhoSm14E2Sxo/trtxSrhtXeMIfTaab2
	 MmD8eENiQMZDZF0wbNjsCf2TKP1jzuauNJM8N9yOBW2nl8WqKy0GrIt/9psKUiWLij
	 fzjxeduQA+frfJ+QK/pQp7WKFTLH5qRRe5bXOGetNkfZATM3KiJtiQEae7u3hsrngF
	 IrPlvdrnfFOMHnNMmHMMzE7LcKWJTTWiPg1SxnLruDY7hx8VoqXobKtPvGbwFx71Mn
	 vqucB9ahQ5uag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yang Yingliang <yangyingliang@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] spi: bcm63xx-hsspi: switch to use modern name
Date: Thu, 10 Sep 2026 09:23:38 -0400
Message-ID: <20260910132339.247410-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910132339.247410-1-sashal@kernel.org>
References: <2026090832-duration-catering-fe4f@gregkh>
 <20260910132339.247410-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yang Yingliang <yangyingliang@huawei.com>

[ Upstream commit 2c40be6bc95bd2b9681b4acc434feda05b16eb00 ]

Change legacy name master to modern name host or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Link: https://lore.kernel.org/r/20230728093221.3312026-8-yangyingliang@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>

Backport notes for 5.15:
Apply the host/controller renaming only to functions present in this tree.
Drop hunks for the absent polling/sysfs and prepend-transfer support, and
preserve the existing transfer, chip-select, interrupt and remove behavior.
Retain spi_alloc_master(), since spi_alloc_host() is unavailable in 5.15;
no new helpers or functions are needed.

The renamed controller and host in bcm63xx_hsspi_resume() provide the
context required by 3b0cee026640 ("spi: bcm63xx-hsspi: disable clocks on
resume failure").

Stable-dep-of: 3b0cee026640 ("spi: bcm63xx-hsspi: disable clocks on resume failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-bcm63xx-hsspi.c | 62 ++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 9948c2a459c12..34e7001191c0d 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -158,7 +158,7 @@ static void bcm63xx_hsspi_set_clk(struct bcm63xx_hsspi *bs,
 
 static int bcm63xx_hsspi_do_txrx(struct spi_device *spi, struct spi_transfer *t)
 {
-	struct bcm63xx_hsspi *bs = spi_master_get_devdata(spi->master);
+	struct bcm63xx_hsspi *bs = spi_controller_get_devdata(spi->controller);
 	unsigned int chip_select = spi->chip_select;
 	u16 opcode = 0;
 	int pending = t->len;
@@ -232,7 +232,7 @@ static int bcm63xx_hsspi_do_txrx(struct spi_device *spi, struct spi_transfer *t)
 
 static int bcm63xx_hsspi_setup(struct spi_device *spi)
 {
-	struct bcm63xx_hsspi *bs = spi_master_get_devdata(spi->master);
+	struct bcm63xx_hsspi *bs = spi_controller_get_devdata(spi->controller);
 	u32 reg;
 
 	reg = __raw_readl(bs->regs +
@@ -267,10 +267,10 @@ static int bcm63xx_hsspi_setup(struct spi_device *spi)
 	return 0;
 }
 
-static int bcm63xx_hsspi_transfer_one(struct spi_master *master,
+static int bcm63xx_hsspi_transfer_one(struct spi_controller *host,
 				      struct spi_message *msg)
 {
-	struct bcm63xx_hsspi *bs = spi_master_get_devdata(master);
+	struct bcm63xx_hsspi *bs = spi_controller_get_devdata(host);
 	struct spi_transfer *t;
 	struct spi_device *spi = msg->spi;
 	int status = -EINVAL;
@@ -315,7 +315,7 @@ static int bcm63xx_hsspi_transfer_one(struct spi_master *master,
 	mutex_unlock(&bs->bus_mutex);
 
 	msg->status = status;
-	spi_finalize_current_message(master);
+	spi_finalize_current_message(host);
 
 	return 0;
 }
@@ -357,7 +357,7 @@ static irqreturn_t bcm63xx_hsspi_interrupt(int irq, void *dev_id)
 
 static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 {
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct bcm63xx_hsspi *bs;
 	void __iomem *regs;
 	struct device *dev = &pdev->dev;
@@ -413,13 +413,13 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 		}
 	}
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*bs));
-	if (!master) {
+	host = spi_alloc_master(&pdev->dev, sizeof(*bs));
+	if (!host) {
 		ret = -ENOMEM;
 		goto out_disable_pll_clk;
 	}
 
-	bs = spi_master_get_devdata(master);
+	bs = spi_controller_get_devdata(host);
 	bs->pdev = pdev;
 	bs->clk = clk;
 	bs->pll_clk = pll_clk;
@@ -430,10 +430,10 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 	mutex_init(&bs->bus_mutex);
 	init_completion(&bs->done);
 
-	master->mem_ops = &bcm63xx_hsspi_mem_ops;
-	master->dev.of_node = dev->of_node;
+	host->mem_ops = &bcm63xx_hsspi_mem_ops;
+	host->dev.of_node = dev->of_node;
 	if (!dev->of_node)
-		master->bus_num = HSSPI_BUS_NUM;
+		host->bus_num = HSSPI_BUS_NUM;
 
 	of_property_read_u32(dev->of_node, "num-cs", &num_cs);
 	if (num_cs > 8) {
@@ -441,15 +441,15 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 			 num_cs);
 		num_cs = HSSPI_SPI_MAX_CS;
 	}
-	master->num_chipselect = num_cs;
-	master->setup = bcm63xx_hsspi_setup;
-	master->transfer_one_message = bcm63xx_hsspi_transfer_one;
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH |
+	host->num_chipselect = num_cs;
+	host->setup = bcm63xx_hsspi_setup;
+	host->transfer_one_message = bcm63xx_hsspi_transfer_one;
+	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH |
 			    SPI_RX_DUAL | SPI_TX_DUAL;
-	master->bits_per_word_mask = SPI_BPW_MASK(8);
-	master->auto_runtime_pm = true;
+	host->bits_per_word_mask = SPI_BPW_MASK(8);
+	host->auto_runtime_pm = true;
 
-	platform_set_drvdata(pdev, master);
+	platform_set_drvdata(pdev, host);
 
 	/* Initialize the hardware */
 	__raw_writel(0, bs->regs + HSSPI_INT_MASK_REG);
@@ -467,12 +467,12 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 			       pdev->name, bs);
 
 	if (ret)
-		goto out_put_master;
+		goto out_put_host;
 
 	pm_runtime_enable(&pdev->dev);
 
 	/* register and we are done */
-	ret = devm_spi_register_master(dev, master);
+	ret = devm_spi_register_controller(dev, host);
 	if (ret)
 		goto out_pm_disable;
 
@@ -480,8 +480,8 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 
 out_pm_disable:
 	pm_runtime_disable(&pdev->dev);
-out_put_master:
-	spi_master_put(master);
+out_put_host:
+	spi_controller_put(host);
 out_disable_pll_clk:
 	clk_disable_unprepare(pll_clk);
 out_disable_clk:
@@ -492,8 +492,8 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 
 static int bcm63xx_hsspi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct bcm63xx_hsspi *bs = spi_master_get_devdata(master);
+	struct spi_controller *host = platform_get_drvdata(pdev);
+	struct bcm63xx_hsspi *bs = spi_controller_get_devdata(host);
 
 	/* reset the hardware and block queue progress */
 	__raw_writel(0, bs->regs + HSSPI_INT_MASK_REG);
@@ -506,10 +506,10 @@ static int bcm63xx_hsspi_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int bcm63xx_hsspi_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct bcm63xx_hsspi *bs = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct bcm63xx_hsspi *bs = spi_controller_get_devdata(host);
 
-	spi_master_suspend(master);
+	spi_controller_suspend(host);
 	clk_disable_unprepare(bs->pll_clk);
 	clk_disable_unprepare(bs->clk);
 
@@ -518,8 +518,8 @@ static int bcm63xx_hsspi_suspend(struct device *dev)
 
 static int bcm63xx_hsspi_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct bcm63xx_hsspi *bs = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct bcm63xx_hsspi *bs = spi_controller_get_devdata(host);
 	int ret;
 
 	ret = clk_prepare_enable(bs->clk);
@@ -534,7 +534,7 @@ static int bcm63xx_hsspi_resume(struct device *dev)
 		}
 	}
 
-	spi_master_resume(master);
+	spi_controller_resume(host);
 
 	return 0;
 }
-- 
2.53.0

