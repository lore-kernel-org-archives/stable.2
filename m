Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625209;
	b=wsHpBhZzxaDCFEQepLw0X8wDRxQ2jQlz9lT019rVvlrv5NTC7Su9dPRtaG2tNAYt6YEy
	 s48BdOZ4oxNFfcDuUMW+ydiQ3h7iMdagvxuGLGCH0WRVpNGBGzpQyWjylfM9/oSs44pXC
	 8RZmHK2pX3Jf3eL6mT7Y7tf8zUN+VMkgtHqyrgklcxIfslpqW++T6gr0bd/VywtRVQraJ
	 iDg4Ntg/lYWLyCU5+L53JfarHUCf7Ns0iO2pcyqXK3PAFysL0WsPjwuQiv7BQ+x8668Ww
	 zp+46ZnrbccNtKslPYx6SZ6jaZinhaOSrfWS7lUKA6uQF/URHHLfBqOA7jbU8QAcMdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625209;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=r2Jsa7poyGTvWhNR0S3Bvc3z/jvAkdNAGysg6Icd2t8=;
	b=5YoYCGLxAC3nZOQ6awCTyt+ccW1ikH2z1C8oC+iGQALcAPnoOEgs6XryP7LS1ClXmSY5
	 f6KJWz5siC6iegphpEOjg9AKyPffzimhdbNhjcZ7yzRqN3nzW0i8v6aR3RuW4TTDXDu6A
	 0UhoZ64ymsROn5sthiVt5v/2jd2vuxbilx3EKzVW9Enti88ec6OTRVR7YSS2Z82ZM0KlE
	 qyUR4UijgGtfavonjbNZ4SvK3HMyYTEFE+SGcoG6L4mtS+6/26y2H0UfNINAXKOVyr9uu
	 NQxLHdnWWEucQJLtjcvyZ7+dTzH2by3KVW7bQI+LJG1gUMsZUDGJSVKbs/grXrBH/kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JZqkOJv4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A18606A326
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JZqkOJv4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E8A1F000CA;
	Wed, 25 Nov 2026 16:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795625208;
	bh=r2Jsa7poyGTvWhNR0S3Bvc3z/jvAkdNAGysg6Icd2t8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JZqkOJv4sZ939laloGol31yFqCp7Rr+Yh5dAsBXhiP62CkfEOiYsEut0OQNI5N9y7
	 UyQ41yGrmSd5Xm3/J8cPu9XyAFA3vWEfGP87uG1u8pEAnHgQSIB2MQsnahnPFpKs6/
	 msVToMJ6EFlLdnRyJ6L7QNSa5J4KKZsF7xR4WpSHzzWs5bTSjTTBZDx0Qfz+OHsjTW
	 imbBVseHB2tZW3wIpeowkvDV+WKPU91D4Y7nU6JXCXyeUMPkk8Bv0Jz/XubX/SwOpG
	 10diRusVhMNhjQdSOA7xJwBBp3aVBczq0m1fNUAJQsWbuwX9ORD91J7tnn+Pr7Yq4j
	 ldvavbyjnO/MA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vishwaroop A <va@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] spi: tegra210-quad: Check hardware status on timeout
Date: Wed, 25 Nov 2026 11:46:43 -0500
Message-ID: <20261125164620.858638-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125164620.858638-1-sashal@kernel.org>
References: <2026112504-attempt-reliant-a017@gregkh>
 <20261125164620.858638-1-sashal@kernel.org>
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

[ Upstream commit 380fd29d57abe6679d87ec56babe65ddc5873a37 ]

Under high system load, QSPI interrupts can be delayed or blocked on the
target CPU, causing wait_for_completion_timeout() to report failure even
though the hardware successfully completed the transfer.

When a timeout occurs, check the QSPI_RDY bit in QSPI_TRANS_STATUS to
determine if the hardware actually completed the transfer. If so, manually
invoke the completion handler to process the transfer successfully instead
of failing it.

This distinguishes lost/delayed interrupts from real hardware timeouts,
preventing unnecessary failures of transfers that completed successfully.

Signed-off-by: Vishwaroop A <va@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Link: https://patch.msgid.link/20251028155703.4151791-4-va@nvidia.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: d04ad85dd801 ("spi: tegra210-quad: Unmap DMA buffers on transfer timeout")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-tegra210-quad.c | 100 +++++++++++++++++++++++++-------
 1 file changed, 80 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index a7f8fef7d8256..8caf17a32e397 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1077,6 +1077,49 @@ static void tegra_qspi_transfer_end(struct spi_device *spi)
 	tegra_qspi_writel(tqspi, tqspi->def_command1_reg, QSPI_COMMAND1);
 }
 
+static irqreturn_t handle_cpu_based_xfer(struct tegra_qspi *tqspi);
+static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi);
+
+/**
+ * tegra_qspi_handle_timeout - Handle transfer timeout with hardware check
+ * @tqspi: QSPI controller instance
+ *
+ * When a timeout occurs but hardware has completed the transfer (interrupt
+ * was lost or delayed), manually trigger transfer completion processing.
+ * This avoids failing transfers that actually succeeded.
+ *
+ * Returns: 0 if transfer was completed, -ETIMEDOUT if real timeout
+ */
+static int tegra_qspi_handle_timeout(struct tegra_qspi *tqspi)
+{
+	irqreturn_t ret;
+	u32 status;
+
+	/* Check if hardware actually completed the transfer */
+	status = tegra_qspi_readl(tqspi, QSPI_TRANS_STATUS);
+	if (!(status & QSPI_RDY))
+		return -ETIMEDOUT;
+
+	/*
+	 * Hardware completed but interrupt was lost/delayed. Manually
+	 * process the completion by calling the appropriate handler.
+	 */
+	dev_warn_ratelimited(tqspi->dev,
+			     "QSPI interrupt timeout, but transfer complete\n");
+
+	/* Clear the transfer status */
+	status = tegra_qspi_readl(tqspi, QSPI_TRANS_STATUS);
+	tegra_qspi_writel(tqspi, status, QSPI_TRANS_STATUS);
+
+	/* Manually trigger completion handler */
+	if (!tqspi->is_curr_dma_xfer)
+		ret = handle_cpu_based_xfer(tqspi);
+	else
+		ret = handle_dma_based_xfer(tqspi);
+
+	return (ret == IRQ_HANDLED) ? 0 : -EIO;
+}
+
 static u32 tegra_qspi_cmd_config(bool is_ddr, u8 bus_width, u8 len)
 {
 	u32 cmd_config = 0;
@@ -1207,20 +1250,28 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 					QSPI_DMA_TIMEOUT);
 
 			if (WARN_ON_ONCE(ret == 0)) {
-				dev_err_ratelimited(tqspi->dev,
-						    "QSPI Transfer failed with timeout\n");
-
-				/* Abort transfer by resetting pio/dma bit */
-				if (tqspi->is_curr_dma_xfer)
-					tegra_qspi_dma_stop(tqspi);
-				else
-					tegra_qspi_pio_stop(tqspi);
-
-				/* Reset controller if timeout happens */
-				tegra_qspi_reset(tqspi);
-
-				ret = -EIO;
-				goto exit;
+				/*
+				 * Check if hardware completed the transfer
+				 * even though interrupt was lost or delayed.
+				 * If so, process the completion and continue.
+				 */
+				ret = tegra_qspi_handle_timeout(tqspi);
+				if (ret < 0) {
+					/* Real timeout - clean up and fail */
+					dev_err(tqspi->dev, "transfer timeout\n");
+
+					/* Abort transfer by resetting pio/dma bit */
+					if (tqspi->is_curr_dma_xfer)
+						tegra_qspi_dma_stop(tqspi);
+					else
+						tegra_qspi_pio_stop(tqspi);
+
+					/* Reset controller if timeout happens */
+					tegra_qspi_reset(tqspi);
+
+					ret = -EIO;
+					goto exit;
+				}
 			}
 
 			if (tqspi->tx_status ||  tqspi->rx_status) {
@@ -1316,14 +1367,23 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
 		ret = wait_for_completion_timeout(&tqspi->xfer_completion,
 						  QSPI_DMA_TIMEOUT);
 		if (WARN_ON(ret == 0)) {
-			dev_err(tqspi->dev, "transfer timeout\n");
+			/*
+			 * Check if hardware completed the transfer even though
+			 * interrupt was lost or delayed. If so, process the
+			 * completion and continue.
+			 */
+			ret = tegra_qspi_handle_timeout(tqspi);
+			if (ret < 0) {
+				/* Real timeout - clean up and fail */
+				dev_err(tqspi->dev, "transfer timeout\n");
 
-			if (tqspi->is_curr_dma_xfer)
-				tegra_qspi_dma_stop(tqspi);
+				if (tqspi->is_curr_dma_xfer)
+					tegra_qspi_dma_stop(tqspi);
 
-			tegra_qspi_handle_error(tqspi);
-			ret = -EIO;
-			goto complete_xfer;
+				tegra_qspi_handle_error(tqspi);
+				ret = -EIO;
+				goto complete_xfer;
+			}
 		}
 
 		if (tqspi->tx_status ||  tqspi->rx_status) {
-- 
2.53.0

