Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625210;
	b=n1sOlU3IAV2+PedcLDIrkPYCUer1ysHBl/xSwptit7k4asPm+CFi/avVqoTKuJKm+7jD
	 0+psz2w67MaIQv9oiGi3nDrdx4L+DQ6Tpgp31dfaFkYLLxQTGsxX6M2DOuQ4n8WcV3qTI
	 nwQz1bLS75hbtLhI6Jt+/fmEutHtqiRJzY2IBRemnFfFxUzBbm4rwQk78oeeWmcFq9k53
	 QicU1JVDxjGh8DTXfw+bK4XTqER4SkNFVxXHw3CQqs7ojI8AapzTlOYPIhicQmm4TzRSj
	 M6vBFxiSJDCUcldhkDoDbznxsE8I8lCx7V7e/lJOJi0/FMM9TjqJsVrhSVVpdKHG4cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625210;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jCYGES/H5LZ0b0IsjqOM6bf/Ja0eYO/RFbke6mIAV9Y=;
	b=NGeKb2ZcqhiLFQzWoAzViz2Fzt70cEVMlFLHbZpHQlh8jovPzTDWLLaZ643/+0pgtZQX
	 eomSmhQ00FI5JYvPUtenIGSNf4t8+FDcmj3W6ZE53hKXPeZfolU3eXYNGPOBMyTMP5p1L
	 udiiVcM1e65HmuFiL2bf2NqfprTS92+qCAoBqp4XttcyIg0SN9Z+mZGyZoV9wrEATEwux
	 /mPwfzSizUFuaeE+CzTnYkx6jBI2TS+WpusRXKrSuMCDFofCzAE9+rXYEf60Q1vFgexyH
	 K1twxiD1HytFznEq5c5G1fhyk2x04UwMRxFQEgvtDOLkM82m/AF1bm/E7wZ8NyTRy7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FlwoE9sK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A1F606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FlwoE9sK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308E01F000C4;
	Wed, 25 Nov 2026 16:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795625209;
	bh=jCYGES/H5LZ0b0IsjqOM6bf/Ja0eYO/RFbke6mIAV9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FlwoE9sKnwkVooO3PSL/OdobgCcCTlEx31K58u1Fb93b7mRlZ+zBcckTMvVAa4QIY
	 Vi+qTA0Mxg0Scd6VzursBmeurDwl2oBPYv8IWuvAFFsi8Xbq/GLioRnqJY5WlXJcpx
	 aVoMTaWq+6JisEn+akODViv/P8rKvpdhK+hidNlFPObOcz0oIXpZP0InY45L4QE5Bt
	 zZekaEljThB28jfMC04v1tqDMtWfSESXuz3hAad6WAlf6aSMZSgYn8hEy6ZkH3sRKE
	 oH3sjcvt0JpaI/c0rSKgT4Wq2+RrRdyaCsvXAdrUA9HJMYYZgnVs+3lz3P/X/vKtD1
	 rLSDWWXwTFktA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vishwaroop A <va@nvidia.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] spi: tegra210-quad: Unmap DMA buffers on transfer timeout
Date: Wed, 25 Nov 2026 11:46:44 -0500
Message-ID: <20261125164620.858638-3-sashal@kernel.org>
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

[ Upstream commit d04ad85dd8015713b0b2531b5b934fe67828d741 ]

tegra_qspi_start_dma_based_transfer() maps the client TX/RX buffers with
dma_map_single() via tegra_qspi_dma_map_xfer(). The matching unmap only
happens in handle_dma_based_xfer(), which runs from the interrupt bottom
half.

When wait_for_completion_timeout() expires and tegra_qspi_handle_timeout()
cannot establish that the hardware finished, it returns an error without
the bottom half ever having run. Both transfer paths then abort the
transfer with tegra_qspi_dma_stop(), reset the controller and clear
curr_xfer, but never unmap the buffers. Every genuine transfer timeout
therefore leaks the streaming DMA mappings for that chunk, which
gradually exhausts the IOVA space on systems with an IOMMU in front of
QSPI.

Unmap the transfer after stopping DMA on both timeout error paths. The
unmap is placed after tegra_qspi_dma_stop() so the DMA engine is
quiesced before the mappings go away.

The recovery paths that do reach handle_dma_based_xfer() unmap there
themselves. The preceding patch makes tegra_qspi_dma_unmap_xfer() a no-op
once the mapping is released, so this cleanup cannot unmap twice or run
against a chunk that was never mapped.

Fixes: 921fc1838fb0 ("spi: tegra210-quad: Add support for Tegra210 QSPI controller")
Cc: stable@vger.kernel.org # with "spi: tegra210-quad: Track DMA mapping state"
Signed-off-by: Vishwaroop A <va@nvidia.com>
Link: https://patch.msgid.link/20261026111412.3843954-4-va@nvidia.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-tegra210-quad.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 8caf17a32e397..1b28dcce8372e 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1261,10 +1261,12 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 					dev_err(tqspi->dev, "transfer timeout\n");
 
 					/* Abort transfer by resetting pio/dma bit */
-					if (tqspi->is_curr_dma_xfer)
+					if (tqspi->is_curr_dma_xfer) {
 						tegra_qspi_dma_stop(tqspi);
-					else
+						tegra_qspi_dma_unmap_xfer(tqspi, xfer);
+					} else {
 						tegra_qspi_pio_stop(tqspi);
+					}
 
 					/* Reset controller if timeout happens */
 					tegra_qspi_reset(tqspi);
@@ -1377,8 +1379,10 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
 				/* Real timeout - clean up and fail */
 				dev_err(tqspi->dev, "transfer timeout\n");
 
-				if (tqspi->is_curr_dma_xfer)
+				if (tqspi->is_curr_dma_xfer) {
 					tegra_qspi_dma_stop(tqspi);
+					tegra_qspi_dma_unmap_xfer(tqspi, xfer);
+				}
 
 				tegra_qspi_handle_error(tqspi);
 				ret = -EIO;
-- 
2.53.0

