Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415881;
	b=xYgPonzzfBlPmsSSaL0HYR9sGvTFexouYbIkncRf2JOB9nzPSKhYpbgX8Tp1THof5LNV
	 +gYK9Wo766+eh0SlIyQNO6XIC/9domlJrd7ZHU0MjdJHjTGavsrSxU7IDVQceyB3Gbak5
	 5OwtEGCmsvHYaLF6dOP9A3zMjgMjrSq0m5cpZtGL9cE1n8ZO03pfPBGSyGkdE0Jiwv3re
	 q24aT5V5a6vIO1jjFycoOFC0E/RA8TsUsR3igyFSkezEZxPyHt6SF3vXMZ3zopwQbr/xW
	 uxO1aQFS3mtkH+dEmm7oDRacXCEn3zrBSYlPs6MRIiTA/7DqcO3E1ZpEcp3JFJYCRPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415881;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ukl7/ngy2ByT7cQKgP2jrmxv3bx3Wzf6+jhUXppHMqA=;
	b=O3t7xme/c608M9bBUW/nioA2MFbRHW5a8FI04a0H/ntha61QqFA3qob12ff935sPNkYh
	 r+25JJzFS49txBEIOm1MGQSKOlM18oXd8utcWTrzHw2R2KH85xOG1hLsygqAz2G1N3ZdM
	 zH63f6WYq0N0jh9LW24nFttFqWp/18O04qvvDxuC99394WYIB/vJ5nujQFEQiNSi5DyQl
	 6HZMgslzh95KdkVrE4WfNPx4FuxTQk2WS+D9A1iMlEOf/zknlwu0ZZxuc2Y+8tZt1o0va
	 iI9gy1XqDoELmsKjUYuPMdTleTdvliXWhPhj+dKjtztUDk7lG52CoSwJUd5N9Jf83Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bfsb7ssx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6724C606A8A7
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bfsb7ssx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A3F1F00A07;
	Wed, 11 Nov 2026 16:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794415881;
	bh=ukl7/ngy2ByT7cQKgP2jrmxv3bx3Wzf6+jhUXppHMqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bfsb7ssxoRGRU34+saOaztqqh1lEaWB4K3QNupWmJXCsfiRuYwKp73HiIucPoBlhb
	 gzzz2gA7iCsvXogk+T4Q16Ki9zxzWz368UlM4tw3NBNFtoYn62qQoa9MXwf37t4gRY
	 oOIvGj8DrbF5BQ/EW6F9qdO53smZ6ETmqisUQ1W3IEY8ONybcM81ryEOaszuC9JzNC
	 V9PYNeWlxiYWhLqWgVAd+3bl5sQKKGjbIYOmfEOiKNo7faTZqB5XSEszD0y/sBRRJv
	 t2Vkp6WyPpMSQJMchifV0kM0nDdpikpD1CCqmmv/rgm5Z9j3lKmDyuOVrVvdJYiA/r
	 inoyPB2jlKDsQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/5] spi: cadence-xspi: group marvell support code together
Date: Wed, 11 Nov 2026 11:51:16 -0500
Message-ID: <20261111164957.3294291-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111164957.3294291-1-sashal@kernel.org>
References: <20261107052239-failed-6.12-ea9854a169e9@kernel.org>
 <20261111164957.3294291-1-sashal@kernel.org>
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

From: Jisheng Zhang <jszhang@kernel.org>

[ Upstream commit 94d031d26168560e951f8c88cbfb7aa53a57092a ]

We will remove the 64BIT dependency from cadence-xspi for non marvell
platform soon. No functionality change.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Link: https://patch.msgid.link/20260803140728.12747-2-jszhang@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: ea9854a169e9 ("spi: cadence-xspi: reject SDMA transfers larger than the requested length")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-cadence-xspi.c | 455 ++++++++++++++++-----------------
 1 file changed, 227 insertions(+), 228 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 90c6d9fa4dbb9..c12930ce67472 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -316,39 +316,10 @@ struct cdns_xspi_driver_data {
 	u32 rfile_phy_dll_slave_ctrl;
 };
 
-static struct cdns_xspi_driver_data marvell_driver_data = {
-	.mrvl_hw_overlay = true,
-	.dll_phy_ctrl = MARVELL_REGS_DLL_PHY_CTRL,
-	.ctb_rfile_phy_ctrl = MARVELL_CTB_RFILE_PHY_CTRL,
-	.rfile_phy_tsel = MARVELL_RFILE_PHY_TSEL,
-	.rfile_phy_dq_timing = MARVELL_RFILE_PHY_DQ_TIMING,
-	.rfile_phy_dqs_timing = MARVELL_RFILE_PHY_DQS_TIMING,
-	.rfile_phy_gate_lpbk_ctrl = MARVELL_RFILE_PHY_GATE_LPBK_CTRL,
-	.rfile_phy_dll_master_ctrl = MARVELL_RFILE_PHY_DLL_MASTER_CTRL,
-	.rfile_phy_dll_slave_ctrl = MARVELL_RFILE_PHY_DLL_SLAVE_CTRL,
-};
-
 static struct cdns_xspi_driver_data cdns_driver_data = {
 	.mrvl_hw_overlay = false,
 };
 
-static const int cdns_mrvl_xspi_clk_div_list[] = {
-	4,	//0x0 = Divide by 4.   SPI clock is 200 MHz.
-	6,	//0x1 = Divide by 6.   SPI clock is 133.33 MHz.
-	8,	//0x2 = Divide by 8.   SPI clock is 100 MHz.
-	10,	//0x3 = Divide by 10.  SPI clock is 80 MHz.
-	12,	//0x4 = Divide by 12.  SPI clock is 66.666 MHz.
-	16,	//0x5 = Divide by 16.  SPI clock is 50 MHz.
-	18,	//0x6 = Divide by 18.  SPI clock is 44.44 MHz.
-	20,	//0x7 = Divide by 20.  SPI clock is 40 MHz.
-	24,	//0x8 = Divide by 24.  SPI clock is 33.33 MHz.
-	32,	//0x9 = Divide by 32.  SPI clock is 25 MHz.
-	40,	//0xA = Divide by 40.  SPI clock is 20 MHz.
-	50,	//0xB = Divide by 50.  SPI clock is 16 MHz.
-	64,	//0xC = Divide by 64.  SPI clock is 12.5 MHz.
-	128	//0xD = Divide by 128. SPI clock is 6.25 MHz.
-};
-
 struct cdns_xspi_dev {
 	struct platform_device *pdev;
 	struct device *dev;
@@ -380,92 +351,6 @@ struct cdns_xspi_dev {
 	int current_xfer_qword;
 };
 
-static void cdns_xspi_reset_dll(struct cdns_xspi_dev *cdns_xspi)
-{
-	u32 dll_cntrl = readl(cdns_xspi->iobase +
-			      CDNS_XSPI_RF_MINICTRL_REGS_DLL_PHY_CTRL);
-
-	/* Reset DLL */
-	dll_cntrl |= CDNS_XSPI_DLL_RST_N;
-	writel(dll_cntrl, cdns_xspi->iobase +
-			  CDNS_XSPI_RF_MINICTRL_REGS_DLL_PHY_CTRL);
-}
-
-static bool cdns_xspi_is_dll_locked(struct cdns_xspi_dev *cdns_xspi)
-{
-	u32 dll_lock;
-
-	return !readl_relaxed_poll_timeout(cdns_xspi->iobase +
-		CDNS_XSPI_INTR_STATUS_REG,
-		dll_lock, ((dll_lock & CDNS_XSPI_DLL_LOCK) == 1), 10, 10000);
-}
-
-/* Static configuration of PHY */
-static bool cdns_xspi_configure_phy(struct cdns_xspi_dev *cdns_xspi)
-{
-	writel(cdns_xspi->driver_data->dll_phy_ctrl,
-	       cdns_xspi->iobase + CDNS_XSPI_RF_MINICTRL_REGS_DLL_PHY_CTRL);
-	writel(cdns_xspi->driver_data->ctb_rfile_phy_ctrl,
-	       cdns_xspi->auxbase + CDNS_XSPI_PHY_CTB_RFILE_PHY_CTRL);
-	writel(cdns_xspi->driver_data->rfile_phy_tsel,
-	       cdns_xspi->auxbase + CDNS_XSPI_PHY_CTB_RFILE_PHY_TSEL);
-	writel(cdns_xspi->driver_data->rfile_phy_dq_timing,
-	       cdns_xspi->auxbase + CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_DQ_TIMING);
-	writel(cdns_xspi->driver_data->rfile_phy_dqs_timing,
-	       cdns_xspi->auxbase + CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_DQS_TIMING);
-	writel(cdns_xspi->driver_data->rfile_phy_gate_lpbk_ctrl,
-	       cdns_xspi->auxbase + CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_GATE_LPBK_CTRL);
-	writel(cdns_xspi->driver_data->rfile_phy_dll_master_ctrl,
-	       cdns_xspi->auxbase + CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_DLL_MASTER_CTRL);
-	writel(cdns_xspi->driver_data->rfile_phy_dll_slave_ctrl,
-	       cdns_xspi->auxbase + CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_DLL_SLAVE_CTRL);
-
-	cdns_xspi_reset_dll(cdns_xspi);
-
-	return cdns_xspi_is_dll_locked(cdns_xspi);
-}
-
-static bool cdns_mrvl_xspi_setup_clock(struct cdns_xspi_dev *cdns_xspi,
-				       int requested_clk)
-{
-	int i = 0;
-	int clk_val;
-	u32 clk_reg;
-	bool update_clk = false;
-
-	while (i < (ARRAY_SIZE(cdns_mrvl_xspi_clk_div_list) - 1)) {
-		clk_val = MRVL_XSPI_CLOCK_DIVIDED(
-				cdns_mrvl_xspi_clk_div_list[i]);
-		if (clk_val <= requested_clk)
-			break;
-		i++;
-	}
-
-	dev_dbg(cdns_xspi->dev, "Found clk div: %d, clk val: %d\n",
-		cdns_mrvl_xspi_clk_div_list[i],
-		MRVL_XSPI_CLOCK_DIVIDED(
-		cdns_mrvl_xspi_clk_div_list[i]));
-
-	clk_reg = readl(cdns_xspi->auxbase + MRVL_XSPI_CLK_CTRL_AUX_REG);
-
-	if (FIELD_GET(MRVL_XSPI_CLK_DIV, clk_reg) != i) {
-		clk_reg &= ~MRVL_XSPI_CLK_ENABLE;
-		writel(clk_reg,
-		       cdns_xspi->auxbase + MRVL_XSPI_CLK_CTRL_AUX_REG);
-		clk_reg = FIELD_PREP(MRVL_XSPI_CLK_DIV, i);
-		FIELD_MODIFY(MRVL_XSPI_CLK_DIV, &clk_reg, i);
-		clk_reg |= MRVL_XSPI_CLK_ENABLE;
-		clk_reg |= MRVL_XSPI_IRQ_ENABLE;
-		update_clk = true;
-	}
-
-	if (update_clk)
-		writel(clk_reg,
-		       cdns_xspi->auxbase + MRVL_XSPI_CLK_CTRL_AUX_REG);
-
-	return update_clk;
-}
-
 static int cdns_xspi_wait_for_controller_idle(struct cdns_xspi_dev *cdns_xspi)
 {
 	u32 ctrl_stat;
@@ -538,23 +423,6 @@ static void cdns_xspi_set_interrupts(struct cdns_xspi_dev *cdns_xspi,
 	writel(intr_enable, cdns_xspi->iobase + CDNS_XSPI_INTR_ENABLE_REG);
 }
 
-static void marvell_xspi_set_interrupts(struct cdns_xspi_dev *cdns_xspi,
-				     bool enabled)
-{
-	u32 intr_enable;
-	u32 irq_status;
-
-	irq_status = readl(cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG);
-	writel(irq_status, cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG);
-
-	intr_enable = readl(cdns_xspi->iobase + CDNS_XSPI_INTR_ENABLE_REG);
-	if (enabled)
-		intr_enable |= CDNS_XSPI_INTR_MASK;
-	else
-		intr_enable &= ~CDNS_XSPI_INTR_MASK;
-	writel(intr_enable, cdns_xspi->iobase + CDNS_XSPI_INTR_ENABLE_REG);
-}
-
 static int cdns_xspi_controller_init(struct cdns_xspi_dev *cdns_xspi)
 {
 	u32 ctrl_ver;
@@ -599,78 +467,6 @@ static void cdns_xspi_sdma_handle(struct cdns_xspi_dev *cdns_xspi)
 	}
 }
 
-static void m_ioreadq(void __iomem  *addr, void *buf, int len)
-{
-	if (IS_ALIGNED((long)buf, 8) && len >= 8) {
-		u64 full_ops = len / 8;
-		u64 *buffer = buf;
-
-		len -= full_ops * 8;
-		buf += full_ops * 8;
-
-		do {
-			u64 b = readq(addr);
-			*buffer++ = b;
-		} while (--full_ops);
-	}
-
-
-	while (len) {
-		u64 tmp_buf;
-
-		tmp_buf = readq(addr);
-		memcpy(buf, &tmp_buf, min(len, 8));
-		len = len > 8 ? len - 8 : 0;
-		buf += 8;
-	}
-}
-
-static void m_iowriteq(void __iomem *addr, const void *buf, int len)
-{
-	if (IS_ALIGNED((long)buf, 8) && len >= 8) {
-		u64 full_ops = len / 8;
-		const u64 *buffer = buf;
-
-		len -= full_ops * 8;
-		buf += full_ops * 8;
-
-		do {
-			writeq(*buffer++, addr);
-		} while (--full_ops);
-	}
-
-	while (len) {
-		u64 tmp_buf;
-
-		memcpy(&tmp_buf, buf, min(len, 8));
-		writeq(tmp_buf, addr);
-		len = len > 8 ? len - 8 : 0;
-		buf += 8;
-	}
-}
-
-static void marvell_xspi_sdma_handle(struct cdns_xspi_dev *cdns_xspi)
-{
-	u32 sdma_size, sdma_trd_info;
-	u8 sdma_dir;
-
-	sdma_size = readl(cdns_xspi->iobase + CDNS_XSPI_SDMA_SIZE_REG);
-	sdma_trd_info = readl(cdns_xspi->iobase + CDNS_XSPI_SDMA_TRD_INFO_REG);
-	sdma_dir = FIELD_GET(CDNS_XSPI_SDMA_DIR, sdma_trd_info);
-
-	switch (sdma_dir) {
-	case CDNS_XSPI_SDMA_DIR_READ:
-		m_ioreadq(cdns_xspi->sdmabase,
-			    cdns_xspi->in_buffer, sdma_size);
-		break;
-
-	case CDNS_XSPI_SDMA_DIR_WRITE:
-		m_iowriteq(cdns_xspi->sdmabase,
-			     cdns_xspi->out_buffer, sdma_size);
-		break;
-	}
-}
-
 static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
 				       const struct spi_mem_op *op,
 				       bool data_phase)
@@ -760,20 +556,6 @@ static int cdns_xspi_mem_op_execute(struct spi_mem *mem,
 	return ret;
 }
 
-static int marvell_xspi_mem_op_execute(struct spi_mem *mem,
-				    const struct spi_mem_op *op)
-{
-	struct cdns_xspi_dev *cdns_xspi =
-		spi_controller_get_devdata(mem->spi->controller);
-	int ret = 0;
-
-	cdns_mrvl_xspi_setup_clock(cdns_xspi, mem->spi->max_speed_hz);
-
-	ret = cdns_xspi_mem_op(cdns_xspi, mem, op);
-
-	return ret;
-}
-
 static bool cdns_xspi_supports_op(struct spi_mem *mem,
 				  const struct spi_mem_op *op)
 {
@@ -841,12 +623,6 @@ static const struct spi_controller_mem_ops cadence_xspi_mem_ops = {
 	.adjust_op_size = cdns_xspi_adjust_mem_op_size,
 };
 
-static const struct spi_controller_mem_ops marvell_xspi_mem_ops = {
-	.supports_op = PTR_IF(IS_ENABLED(CONFIG_ACPI), cdns_xspi_supports_op),
-	.exec_op = marvell_xspi_mem_op_execute,
-	.adjust_op_size = cdns_xspi_adjust_mem_op_size,
-};
-
 static irqreturn_t cdns_xspi_irq_handler(int this_irq, void *dev)
 {
 	struct cdns_xspi_dev *cdns_xspi = dev;
@@ -928,6 +704,230 @@ static void cdns_xspi_print_phy_config(struct cdns_xspi_dev *cdns_xspi)
 		 readl(cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_DLL_SLAVE_CTRL));
 }
 
+static struct cdns_xspi_driver_data marvell_driver_data = {
+	.mrvl_hw_overlay = true,
+	.dll_phy_ctrl = MARVELL_REGS_DLL_PHY_CTRL,
+	.ctb_rfile_phy_ctrl = MARVELL_CTB_RFILE_PHY_CTRL,
+	.rfile_phy_tsel = MARVELL_RFILE_PHY_TSEL,
+	.rfile_phy_dq_timing = MARVELL_RFILE_PHY_DQ_TIMING,
+	.rfile_phy_dqs_timing = MARVELL_RFILE_PHY_DQS_TIMING,
+	.rfile_phy_gate_lpbk_ctrl = MARVELL_RFILE_PHY_GATE_LPBK_CTRL,
+	.rfile_phy_dll_master_ctrl = MARVELL_RFILE_PHY_DLL_MASTER_CTRL,
+	.rfile_phy_dll_slave_ctrl = MARVELL_RFILE_PHY_DLL_SLAVE_CTRL,
+};
+
+static const int cdns_mrvl_xspi_clk_div_list[] = {
+	4,	//0x0 = Divide by 4.   SPI clock is 200 MHz.
+	6,	//0x1 = Divide by 6.   SPI clock is 133.33 MHz.
+	8,	//0x2 = Divide by 8.   SPI clock is 100 MHz.
+	10,	//0x3 = Divide by 10.  SPI clock is 80 MHz.
+	12,	//0x4 = Divide by 12.  SPI clock is 66.666 MHz.
+	16,	//0x5 = Divide by 16.  SPI clock is 50 MHz.
+	18,	//0x6 = Divide by 18.  SPI clock is 44.44 MHz.
+	20,	//0x7 = Divide by 20.  SPI clock is 40 MHz.
+	24,	//0x8 = Divide by 24.  SPI clock is 33.33 MHz.
+	32,	//0x9 = Divide by 32.  SPI clock is 25 MHz.
+	40,	//0xA = Divide by 40.  SPI clock is 20 MHz.
+	50,	//0xB = Divide by 50.  SPI clock is 16 MHz.
+	64,	//0xC = Divide by 64.  SPI clock is 12.5 MHz.
+	128	//0xD = Divide by 128. SPI clock is 6.25 MHz.
+};
+
+static void cdns_xspi_reset_dll(struct cdns_xspi_dev *cdns_xspi)
+{
+	u32 dll_cntrl = readl(cdns_xspi->iobase +
+			      CDNS_XSPI_RF_MINICTRL_REGS_DLL_PHY_CTRL);
+
+	/* Reset DLL */
+	dll_cntrl |= CDNS_XSPI_DLL_RST_N;
+	writel(dll_cntrl, cdns_xspi->iobase +
+			  CDNS_XSPI_RF_MINICTRL_REGS_DLL_PHY_CTRL);
+}
+
+static bool cdns_xspi_is_dll_locked(struct cdns_xspi_dev *cdns_xspi)
+{
+	u32 dll_lock;
+
+	return !readl_relaxed_poll_timeout(cdns_xspi->iobase +
+		CDNS_XSPI_INTR_STATUS_REG,
+		dll_lock, ((dll_lock & CDNS_XSPI_DLL_LOCK) == 1), 10, 10000);
+}
+
+/* Static configuration of PHY */
+static bool cdns_xspi_configure_phy(struct cdns_xspi_dev *cdns_xspi)
+{
+	writel(cdns_xspi->driver_data->dll_phy_ctrl,
+	       cdns_xspi->iobase + CDNS_XSPI_RF_MINICTRL_REGS_DLL_PHY_CTRL);
+	writel(cdns_xspi->driver_data->ctb_rfile_phy_ctrl,
+	       cdns_xspi->auxbase + CDNS_XSPI_PHY_CTB_RFILE_PHY_CTRL);
+	writel(cdns_xspi->driver_data->rfile_phy_tsel,
+	       cdns_xspi->auxbase + CDNS_XSPI_PHY_CTB_RFILE_PHY_TSEL);
+	writel(cdns_xspi->driver_data->rfile_phy_dq_timing,
+	       cdns_xspi->auxbase + CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_DQ_TIMING);
+	writel(cdns_xspi->driver_data->rfile_phy_dqs_timing,
+	       cdns_xspi->auxbase + CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_DQS_TIMING);
+	writel(cdns_xspi->driver_data->rfile_phy_gate_lpbk_ctrl,
+	       cdns_xspi->auxbase + CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_GATE_LPBK_CTRL);
+	writel(cdns_xspi->driver_data->rfile_phy_dll_master_ctrl,
+	       cdns_xspi->auxbase + CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_DLL_MASTER_CTRL);
+	writel(cdns_xspi->driver_data->rfile_phy_dll_slave_ctrl,
+	       cdns_xspi->auxbase + CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_DLL_SLAVE_CTRL);
+
+	cdns_xspi_reset_dll(cdns_xspi);
+
+	return cdns_xspi_is_dll_locked(cdns_xspi);
+}
+
+static bool cdns_mrvl_xspi_setup_clock(struct cdns_xspi_dev *cdns_xspi,
+				       int requested_clk)
+{
+	int i = 0;
+	int clk_val;
+	u32 clk_reg;
+	bool update_clk = false;
+
+	while (i < (ARRAY_SIZE(cdns_mrvl_xspi_clk_div_list) - 1)) {
+		clk_val = MRVL_XSPI_CLOCK_DIVIDED(
+				cdns_mrvl_xspi_clk_div_list[i]);
+		if (clk_val <= requested_clk)
+			break;
+		i++;
+	}
+
+	dev_dbg(cdns_xspi->dev, "Found clk div: %d, clk val: %d\n",
+		cdns_mrvl_xspi_clk_div_list[i],
+		MRVL_XSPI_CLOCK_DIVIDED(
+		cdns_mrvl_xspi_clk_div_list[i]));
+
+	clk_reg = readl(cdns_xspi->auxbase + MRVL_XSPI_CLK_CTRL_AUX_REG);
+
+	if (FIELD_GET(MRVL_XSPI_CLK_DIV, clk_reg) != i) {
+		clk_reg &= ~MRVL_XSPI_CLK_ENABLE;
+		writel(clk_reg,
+		       cdns_xspi->auxbase + MRVL_XSPI_CLK_CTRL_AUX_REG);
+		clk_reg = FIELD_PREP(MRVL_XSPI_CLK_DIV, i);
+		FIELD_MODIFY(MRVL_XSPI_CLK_DIV, &clk_reg, i);
+		clk_reg |= MRVL_XSPI_CLK_ENABLE;
+		clk_reg |= MRVL_XSPI_IRQ_ENABLE;
+		update_clk = true;
+	}
+
+	if (update_clk)
+		writel(clk_reg,
+		       cdns_xspi->auxbase + MRVL_XSPI_CLK_CTRL_AUX_REG);
+
+	return update_clk;
+}
+
+static void marvell_xspi_set_interrupts(struct cdns_xspi_dev *cdns_xspi,
+				     bool enabled)
+{
+	u32 intr_enable;
+	u32 irq_status;
+
+	irq_status = readl(cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG);
+	writel(irq_status, cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG);
+
+	intr_enable = readl(cdns_xspi->iobase + CDNS_XSPI_INTR_ENABLE_REG);
+	if (enabled)
+		intr_enable |= CDNS_XSPI_INTR_MASK;
+	else
+		intr_enable &= ~CDNS_XSPI_INTR_MASK;
+	writel(intr_enable, cdns_xspi->iobase + CDNS_XSPI_INTR_ENABLE_REG);
+}
+
+static int marvell_xspi_mem_op_execute(struct spi_mem *mem,
+				    const struct spi_mem_op *op)
+{
+	struct cdns_xspi_dev *cdns_xspi =
+		spi_controller_get_devdata(mem->spi->controller);
+	int ret = 0;
+
+	cdns_mrvl_xspi_setup_clock(cdns_xspi, mem->spi->max_speed_hz);
+
+	ret = cdns_xspi_mem_op(cdns_xspi, mem, op);
+
+	return ret;
+}
+
+static void m_ioreadq(void __iomem  *addr, void *buf, int len)
+{
+	if (IS_ALIGNED((long)buf, 8) && len >= 8) {
+		u64 full_ops = len / 8;
+		u64 *buffer = buf;
+
+		len -= full_ops * 8;
+		buf += full_ops * 8;
+
+		do {
+			u64 b = readq(addr);
+			*buffer++ = b;
+		} while (--full_ops);
+	}
+
+
+	while (len) {
+		u64 tmp_buf;
+
+		tmp_buf = readq(addr);
+		memcpy(buf, &tmp_buf, min(len, 8));
+		len = len > 8 ? len - 8 : 0;
+		buf += 8;
+	}
+}
+
+static void m_iowriteq(void __iomem *addr, const void *buf, int len)
+{
+	if (IS_ALIGNED((long)buf, 8) && len >= 8) {
+		u64 full_ops = len / 8;
+		const u64 *buffer = buf;
+
+		len -= full_ops * 8;
+		buf += full_ops * 8;
+
+		do {
+			writeq(*buffer++, addr);
+		} while (--full_ops);
+	}
+
+	while (len) {
+		u64 tmp_buf;
+
+		memcpy(&tmp_buf, buf, min(len, 8));
+		writeq(tmp_buf, addr);
+		len = len > 8 ? len - 8 : 0;
+		buf += 8;
+	}
+}
+
+static void marvell_xspi_sdma_handle(struct cdns_xspi_dev *cdns_xspi)
+{
+	u32 sdma_size, sdma_trd_info;
+	u8 sdma_dir;
+
+	sdma_size = readl(cdns_xspi->iobase + CDNS_XSPI_SDMA_SIZE_REG);
+	sdma_trd_info = readl(cdns_xspi->iobase + CDNS_XSPI_SDMA_TRD_INFO_REG);
+	sdma_dir = FIELD_GET(CDNS_XSPI_SDMA_DIR, sdma_trd_info);
+
+	switch (sdma_dir) {
+	case CDNS_XSPI_SDMA_DIR_READ:
+		m_ioreadq(cdns_xspi->sdmabase,
+			    cdns_xspi->in_buffer, sdma_size);
+		break;
+
+	case CDNS_XSPI_SDMA_DIR_WRITE:
+		m_iowriteq(cdns_xspi->sdmabase,
+			     cdns_xspi->out_buffer, sdma_size);
+		break;
+	}
+}
+
+static const struct spi_controller_mem_ops marvell_xspi_mem_ops = {
+	.supports_op = PTR_IF(IS_ENABLED(CONFIG_ACPI), cdns_xspi_supports_op),
+	.exec_op = marvell_xspi_mem_op_execute,
+	.adjust_op_size = cdns_xspi_adjust_mem_op_size,
+};
+
 static int cdns_xspi_prepare_generic(int cs, const void *dout, int len, int glue, u32 *cmd_regs)
 {
 	u8 *data = (u8 *)dout;
@@ -1155,15 +1155,14 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 			return -ENODEV;
 	}
 
+	host->mem_ops = &cadence_xspi_mem_ops;
+	cdns_xspi->sdma_handler = &cdns_xspi_sdma_handle;
+	cdns_xspi->set_interrupts_handler = &cdns_xspi_set_interrupts;
 	if (cdns_xspi->driver_data->mrvl_hw_overlay) {
 		host->mem_ops = &marvell_xspi_mem_ops;
 		host->transfer_one_message = cdns_xspi_transfer_one_message_b0;
 		cdns_xspi->sdma_handler = &marvell_xspi_sdma_handle;
 		cdns_xspi->set_interrupts_handler = &marvell_xspi_set_interrupts;
-	} else {
-		host->mem_ops = &cadence_xspi_mem_ops;
-		cdns_xspi->sdma_handler = &cdns_xspi_sdma_handle;
-		cdns_xspi->set_interrupts_handler = &cdns_xspi_set_interrupts;
 	}
 	host->dev.of_node = pdev->dev.of_node;
 	host->bus_num = -1;
-- 
2.53.0

