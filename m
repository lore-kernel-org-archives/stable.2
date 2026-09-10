Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3532B3D9DDB
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 11:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789039104; cv=none; b=OMNQg3QsXSTo5xd3HG5vbecsx6VE/MA+8isEJoq9pjSZKsWFjHX3npP5blHlQaRb1YiT3S/GvualPU+pIWMpeiSCA2W9QfCcHjr0871OlCd4ng1TCuVSAVac/mzZzDiWk+8Q/UTg82++PSR4cEW78PMqZI5k6l4QtWejxgsQjQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789039104; c=relaxed/simple;
	bh=ZgWPDcEtK2L7TqjuFyf/Rn4MPNg/K/+WOc/g3vqheF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HeX2N2M+2sRm2tcV+cnmpqMCLix34kXsGkC3VUVJw+51y8E4FsoJPZ80Gi7emMmNqoSeVaq2v0VqSu4a4jUWpfFX75psjVm7gqT4DFR2OiDdlzhiws1/uz5ZmhdOJ1k4LPYXrCBtgbhhScg0uvy73+IY2OAj4ATU5+fA7DBDJUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2p76dyd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2p76dyd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D311F000FF;
	Thu, 10 Sep 2026 11:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789039102;
	bh=se8lgHQ33IuSUcquC8P4Zjt8rCeMAIRtfgZcPAzrQso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V2p76dydgwqrHAazAozV+qAEBem1VqMgqgVq2Atucd8wJh61TxjR1PJB+uEfs3aeY
	 9ZzNYXX3t99PXqnxYTOEHaRPVjJb8vcIYoqQmESGVGWDQHKSLg6uvjHWdkPk36hscN
	 i8mLwS4ygWbiGDGEUFo6tERty7C30JBuW69OKBIXmFnVnqoHgHx84D9gLjBHjFlF4O
	 +mfPQYer30vsIR8lX09z0WAZTzF0Eai8prmAhh+djKBDSvBYYinEY0EEob6//XxQoJ
	 XjtjMShij0QqeCoHCUxEuF8fKl8sWbhPehvjQQjNvYmRoFYAljbmvhyAUoHUmFQaFT
	 ElQHavtOUjopA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yang Yingliang <yangyingliang@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] spi: bcm63xx: switch to use modern name
Date: Thu, 10 Sep 2026 07:18:19 -0400
Message-ID: <20260910111820.6891-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090843-repaint-untwist-90f3@gregkh>
References: <2026090843-repaint-untwist-90f3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yang Yingliang <yangyingliang@huawei.com>

[ Upstream commit 1a9e76190f72e4e3aaf7eb89da22876846ff9b3d ]

Change legacy name master to modern name host or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Link: https://lore.kernel.org/r/20230728093221.3312026-9-yangyingliang@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 2b62c2c134fa ("spi: bcm63xx: disable clock on resume failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-bcm63xx.c | 68 +++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index e57e1f75cd9f9..80a88d38ec00d 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -196,7 +196,7 @@ static const unsigned int bcm63xx_spi_freq_table[SPI_CLK_MASK][2] = {
 static void bcm63xx_spi_setup_transfer(struct spi_device *spi,
 				      struct spi_transfer *t)
 {
-	struct bcm63xx_spi *bs = spi_master_get_devdata(spi->master);
+	struct bcm63xx_spi *bs = spi_controller_get_devdata(spi->controller);
 	u8 clk_cfg, reg;
 	int i;
 
@@ -227,7 +227,7 @@ static void bcm63xx_spi_setup_transfer(struct spi_device *spi,
 static int bcm63xx_txrx_bufs(struct spi_device *spi, struct spi_transfer *first,
 				unsigned int num_transfers)
 {
-	struct bcm63xx_spi *bs = spi_master_get_devdata(spi->master);
+	struct bcm63xx_spi *bs = spi_controller_get_devdata(spi->controller);
 	u16 msg_ctl;
 	u16 cmd;
 	unsigned int i, timeout = 0, prepend_len = 0, len = 0;
@@ -336,10 +336,10 @@ static int bcm63xx_txrx_bufs(struct spi_device *spi, struct spi_transfer *first,
 	return 0;
 }
 
-static int bcm63xx_spi_transfer_one(struct spi_master *master,
+static int bcm63xx_spi_transfer_one(struct spi_controller *host,
 					struct spi_message *m)
 {
-	struct bcm63xx_spi *bs = spi_master_get_devdata(master);
+	struct bcm63xx_spi *bs = spi_controller_get_devdata(host);
 	struct spi_transfer *t, *first = NULL;
 	struct spi_device *spi = m->spi;
 	int status = 0;
@@ -409,18 +409,18 @@ static int bcm63xx_spi_transfer_one(struct spi_master *master,
 	}
 exit:
 	m->status = status;
-	spi_finalize_current_message(master);
+	spi_finalize_current_message(host);
 
 	return 0;
 }
 
-/* This driver supports single master mode only. Hence
+/* This driver supports single host mode only. Hence
  * CMD_DONE is the only interrupt we care about
  */
 static irqreturn_t bcm63xx_spi_interrupt(int irq, void *dev_id)
 {
-	struct spi_master *master = (struct spi_master *)dev_id;
-	struct bcm63xx_spi *bs = spi_master_get_devdata(master);
+	struct spi_controller *host = (struct spi_controller *)dev_id;
+	struct bcm63xx_spi *bs = spi_controller_get_devdata(host);
 	u8 intr;
 
 	/* Read interupts and clear them immediately */
@@ -437,7 +437,7 @@ static irqreturn_t bcm63xx_spi_interrupt(int irq, void *dev_id)
 
 static size_t bcm63xx_spi_max_length(struct spi_device *spi)
 {
-	struct bcm63xx_spi *bs = spi_master_get_devdata(spi->master);
+	struct bcm63xx_spi *bs = spi_controller_get_devdata(spi->controller);
 
 	return bs->fifo_size;
 }
@@ -505,7 +505,7 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 	const unsigned long *bcm63xx_spireg;
 	struct device *dev = &pdev->dev;
 	int irq, bus_num;
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct clk *clk;
 	struct bcm63xx_spi *bs;
 	int ret;
@@ -551,16 +551,16 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 	if (IS_ERR(reset))
 		return PTR_ERR(reset);
 
-	master = spi_alloc_master(dev, sizeof(*bs));
-	if (!master) {
+	host = spi_alloc_host(dev, sizeof(*bs));
+	if (!host) {
 		dev_err(dev, "out of memory\n");
 		return -ENOMEM;
 	}
 
-	bs = spi_master_get_devdata(master);
+	bs = spi_controller_get_devdata(host);
 	init_completion(&bs->done);
 
-	platform_set_drvdata(pdev, master);
+	platform_set_drvdata(pdev, host);
 	bs->pdev = pdev;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -576,21 +576,21 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 	bs->fifo_size = bs->reg_offsets[SPI_MSG_DATA_SIZE];
 
 	ret = devm_request_irq(&pdev->dev, irq, bcm63xx_spi_interrupt, 0,
-							pdev->name, master);
+			       pdev->name, host);
 	if (ret) {
 		dev_err(dev, "unable to request irq\n");
 		goto out_err;
 	}
 
-	master->dev.of_node = dev->of_node;
-	master->bus_num = bus_num;
-	master->num_chipselect = num_cs;
-	master->transfer_one_message = bcm63xx_spi_transfer_one;
-	master->mode_bits = MODEBITS;
-	master->bits_per_word_mask = SPI_BPW_MASK(8);
-	master->max_transfer_size = bcm63xx_spi_max_length;
-	master->max_message_size = bcm63xx_spi_max_length;
-	master->auto_runtime_pm = true;
+	host->dev.of_node = dev->of_node;
+	host->bus_num = bus_num;
+	host->num_chipselect = num_cs;
+	host->transfer_one_message = bcm63xx_spi_transfer_one;
+	host->mode_bits = MODEBITS;
+	host->bits_per_word_mask = SPI_BPW_MASK(8);
+	host->max_transfer_size = bcm63xx_spi_max_length;
+	host->max_message_size = bcm63xx_spi_max_length;
+	host->auto_runtime_pm = true;
 	bs->msg_type_shift = bs->reg_offsets[SPI_MSG_TYPE_SHIFT];
 	bs->msg_ctl_width = bs->reg_offsets[SPI_MSG_CTL_WIDTH];
 	bs->tx_io = (u8 *)(bs->regs + bs->reg_offsets[SPI_MSG_DATA]);
@@ -614,7 +614,7 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 		goto out_clk_disable;
 
 	/* register and we are done */
-	ret = devm_spi_register_master(dev, master);
+	ret = devm_spi_register_controller(dev, host);
 	if (ret) {
 		dev_err(dev, "spi register failed\n");
 		goto out_clk_disable;
@@ -628,14 +628,14 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 out_clk_disable:
 	clk_disable_unprepare(clk);
 out_err:
-	spi_master_put(master);
+	spi_controller_put(host);
 	return ret;
 }
 
 static int bcm63xx_spi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct bcm63xx_spi *bs = spi_master_get_devdata(master);
+	struct spi_controller *host = platform_get_drvdata(pdev);
+	struct bcm63xx_spi *bs = spi_controller_get_devdata(host);
 
 	/* reset spi block */
 	bcm_spi_writeb(bs, 0, SPI_INT_MASK);
@@ -649,10 +649,10 @@ static int bcm63xx_spi_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int bcm63xx_spi_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct bcm63xx_spi *bs = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct bcm63xx_spi *bs = spi_controller_get_devdata(host);
 
-	spi_master_suspend(master);
+	spi_controller_suspend(host);
 
 	clk_disable_unprepare(bs->clk);
 
@@ -661,15 +661,15 @@ static int bcm63xx_spi_suspend(struct device *dev)
 
 static int bcm63xx_spi_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct bcm63xx_spi *bs = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct bcm63xx_spi *bs = spi_controller_get_devdata(host);
 	int ret;
 
 	ret = clk_prepare_enable(bs->clk);
 	if (ret)
 		return ret;
 
-	spi_master_resume(master);
+	spi_controller_resume(host);
 
 	return 0;
 }
-- 
2.53.0

