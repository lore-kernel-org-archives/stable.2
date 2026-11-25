Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625207;
	b=Yht9YRNdOPlzf9MNbRXKg9tFHO907C+eLT5R+PiwKWC0No4Cv1z8UZ4zvC8yfVUjFQGc
	 wXNc5vXqZYF0MyCJLmehIz0dMVQAhiXyhyg7CLgABHG5puNMwWArrp4zNhsrggBy3JUtv
	 /tsOTDgINw/RMaKgHEd3G5Efqd3vIqfirKlndMKAE/wkDsTnBNfQpWW4pXhln1/yLK0Rq
	 4+ah1fRlLxyt2VfT/5jfh+YLbYlFN1qN6VYKrteH/2Ap/zQxYxHwH4MCM4+LB8FIR96uW
	 X85tAzlkAvqhgqeu0KSMB6/eJvoT47y+AE+aSQj7mIC/ToHYpXCMVzOeKHS4u7QTyMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625207;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kOrJTc2mjNNh8yTW23zqw3vyOqV/DPMVtwHhn27aF9k=;
	b=EeoeHkIpSq5atIqEiQjkonuNq00wGp0/qTOF9dWr1gkXk45bjcHwtOI7f+jSfwC3wjeW
	 BBKobnOIreYg4jIRSGI0jpTgx9MdCTVo03575HlK7ltrhnvriyL629FdBkzg3fcutNzfS
	 S0K+0v+5gegnrNPUhbdxFNcCa9Iw1i8geErLDsX0WR98VI2d65JLg3PX5g/RANS/o1M8R
	 UHfQq+faNsRVRfpVTZS9jM/ReXJpGZZ6puj6nJdzt/7LZXiAr5WLIDlVsVhbjWsb2cci0
	 LgDjssj0dciHkmTIwbEI8rxAnhUjK4Rei1L9b+PyCl8wKiGEoDXW1vlcj/sYUlIDafg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L4A1FQR2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F823606A326
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L4A1FQR2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C65A1F000D1;
	Wed, 25 Nov 2026 16:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795625206;
	bh=kOrJTc2mjNNh8yTW23zqw3vyOqV/DPMVtwHhn27aF9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L4A1FQR22IYE9E1Rq1mjdmYJQN67Phfen9D4TZV4mZTlm3kV8YJdvtL/BRvA04+Kc
	 krql9BcrqTruMpCLqkhQNinvDFAiVY7Kl6NWmo1gFHLgoV9hMpKeTztI3NjZc2bAIN
	 Gx5eiZ7SCjTFJK3xzyGkjHOGP4lYW3nIMf4VD7pTZsAaluul1gsTXkQSc0H0zRD6g4
	 rIT0fCExcCoNO1y+ISqJO9CaNnL8O+9ljJsKr/w+MWJ5+RPuDPvWG29GssDDjqEgpq
	 PtsYCb6NjHEKoChxqycW6kEynK/OT0+vQqnQosyU4vD148DFQ7EvwL386iVexUC9I2
	 /MfHfILnmTPvw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vishwaroop A <va@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] spi: tegra210-quad: Refactor error handling into helper functions
Date: Wed, 25 Nov 2026 11:46:42 -0500
Message-ID: <20261125164620.858638-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112504-attempt-reliant-a017@gregkh>
References: <2026112504-attempt-reliant-a017@gregkh>
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

From: Vishwaroop A <va@nvidia.com>

[ Upstream commit 6022eacdda8b0b06a2e1d4122e5268099b62ff5d ]

Extract common cleanup code into dedicated helper functions to simplify
the code and improve readability. This refactoring includes:

- tegra_qspi_reset(): Device reset and interrupt cleanup
- tegra_qspi_dma_stop(): DMA termination and disable
- tegra_qspi_pio_stop(): PIO mode disable

No functional changes. This is purely a code reorganization to prepare
for improved timeout handling in subsequent patches.

Signed-off-by: Vishwaroop A <va@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Link: https://patch.msgid.link/20251028155703.4151791-3-va@nvidia.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: d04ad85dd801 ("spi: tegra210-quad: Unmap DMA buffers on transfer timeout")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-tegra210-quad.c | 84 +++++++++++++++++----------------
 1 file changed, 44 insertions(+), 40 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index b91d0131acc51..a7f8fef7d8256 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1048,17 +1048,22 @@ static void tegra_qspi_dump_regs(struct tegra_qspi *tqspi)
 		tegra_qspi_readl(tqspi, QSPI_FIFO_STATUS));
 }
 
-static void tegra_qspi_handle_error(struct tegra_qspi *tqspi)
+static void tegra_qspi_reset(struct tegra_qspi *tqspi)
 {
-	dev_err(tqspi->dev, "error in transfer, fifo status 0x%08x\n", tqspi->status_reg);
-	tegra_qspi_dump_regs(tqspi);
-	tegra_qspi_flush_fifos(tqspi, true);
 	if (device_reset(tqspi->dev) < 0) {
 		dev_warn_once(tqspi->dev, "device reset failed\n");
 		tegra_qspi_mask_clear_irq(tqspi);
 	}
 }
 
+static void tegra_qspi_handle_error(struct tegra_qspi *tqspi)
+{
+	dev_err(tqspi->dev, "error in transfer, fifo status 0x%08x\n", tqspi->status_reg);
+	tegra_qspi_dump_regs(tqspi);
+	tegra_qspi_flush_fifos(tqspi, true);
+	tegra_qspi_reset(tqspi);
+}
+
 static void tegra_qspi_transfer_end(struct spi_device *spi)
 {
 	struct tegra_qspi *tqspi = spi_controller_get_devdata(spi->controller);
@@ -1103,6 +1108,30 @@ static u32 tegra_qspi_addr_config(bool is_ddr, u8 bus_width, u8 len)
 	return addr_config;
 }
 
+static void tegra_qspi_dma_stop(struct tegra_qspi *tqspi)
+{
+	u32 value;
+
+	if ((tqspi->cur_direction & DATA_DIR_TX) && tqspi->tx_dma_chan)
+		dmaengine_terminate_all(tqspi->tx_dma_chan);
+
+	if ((tqspi->cur_direction & DATA_DIR_RX) && tqspi->rx_dma_chan)
+		dmaengine_terminate_all(tqspi->rx_dma_chan);
+
+	value = tegra_qspi_readl(tqspi, QSPI_DMA_CTL);
+	value &= ~QSPI_DMA_EN;
+	tegra_qspi_writel(tqspi, value, QSPI_DMA_CTL);
+}
+
+static void tegra_qspi_pio_stop(struct tegra_qspi *tqspi)
+{
+	u32 value;
+
+	value = tegra_qspi_readl(tqspi, QSPI_COMMAND1);
+	value &= ~QSPI_PIO;
+	tegra_qspi_writel(tqspi, value, QSPI_COMMAND1);
+}
+
 static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 					struct spi_message *msg)
 {
@@ -1110,7 +1139,7 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 	struct spi_transfer *xfer;
 	struct spi_device *spi = msg->spi;
 	u8 transfer_phase = 0;
-	u32 cmd1 = 0, dma_ctl = 0;
+	u32 cmd1 = 0;
 	int ret = 0;
 	u32 address_value = 0;
 	u32 cmd_config = 0, addr_config = 0;
@@ -1180,39 +1209,16 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 			if (WARN_ON_ONCE(ret == 0)) {
 				dev_err_ratelimited(tqspi->dev,
 						    "QSPI Transfer failed with timeout\n");
-				if (tqspi->is_curr_dma_xfer) {
-					if ((tqspi->cur_direction & DATA_DIR_TX) &&
-					    tqspi->tx_dma_chan)
-						dmaengine_terminate_all(tqspi->tx_dma_chan);
-					if ((tqspi->cur_direction & DATA_DIR_RX) &&
-					    tqspi->rx_dma_chan)
-						dmaengine_terminate_all(tqspi->rx_dma_chan);
-				}
 
 				/* Abort transfer by resetting pio/dma bit */
-				if (!tqspi->is_curr_dma_xfer) {
-					cmd1 = tegra_qspi_readl
-							(tqspi,
-							 QSPI_COMMAND1);
-					cmd1 &= ~QSPI_PIO;
-					tegra_qspi_writel
-							(tqspi, cmd1,
-							 QSPI_COMMAND1);
-				} else {
-					dma_ctl = tegra_qspi_readl
-							(tqspi,
-							 QSPI_DMA_CTL);
-					dma_ctl &= ~QSPI_DMA_EN;
-					tegra_qspi_writel(tqspi, dma_ctl,
-							  QSPI_DMA_CTL);
-				}
+				if (tqspi->is_curr_dma_xfer)
+					tegra_qspi_dma_stop(tqspi);
+				else
+					tegra_qspi_pio_stop(tqspi);
 
 				/* Reset controller if timeout happens */
-				if (device_reset(tqspi->dev) < 0) {
-					dev_warn_once(tqspi->dev,
-						      "device reset failed\n");
-					tegra_qspi_mask_clear_irq(tqspi);
-				}
+				tegra_qspi_reset(tqspi);
+
 				ret = -EIO;
 				goto exit;
 			}
@@ -1311,12 +1317,10 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
 						  QSPI_DMA_TIMEOUT);
 		if (WARN_ON(ret == 0)) {
 			dev_err(tqspi->dev, "transfer timeout\n");
-			if (tqspi->is_curr_dma_xfer) {
-				if ((tqspi->cur_direction & DATA_DIR_TX) && tqspi->tx_dma_chan)
-					dmaengine_terminate_all(tqspi->tx_dma_chan);
-				if ((tqspi->cur_direction & DATA_DIR_RX) && tqspi->rx_dma_chan)
-					dmaengine_terminate_all(tqspi->rx_dma_chan);
-			}
+
+			if (tqspi->is_curr_dma_xfer)
+				tegra_qspi_dma_stop(tqspi);
+
 			tegra_qspi_handle_error(tqspi);
 			ret = -EIO;
 			goto complete_xfer;
-- 
2.53.0

