Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625184;
	b=qHAby0DT6wFYFzBcITU5fck28l0ZaFf/kHKkSmLwiYDMOdSR1pCohlyKyxcT0fL09I3H
	 Qd3kLWtb6xA3eX63HsL14FmhNf27hXWdKkOyf4oxIZQzaY6shrQkZ99qwBJc+qGg9kb5V
	 1CB0Dh3QcdGF72Qulolo0OJd4s9z9w9+FBcGtdzApivlJssuE6HNBgXRw0kKwVxWExhds
	 fQKm0PS6FBOq0WuPgL7xYklMMCQkpHCl/f1PSKky8EXne7bvItK9LYya6FywZcG6I4v8F
	 33p1E7Mfhpv4GHcFqAPKX3uviU/rG5Q9vQVQztCMlFquoBF+0N6F6HcVoWohpNjhnpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625184;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VU72rpOO5ddas+cFunqgy4ik+zVyuMSbRCton92hcTM=;
	b=tkFyBZWlYA0gyPr+R6m6pmtKD+7nr+90hWd6HhhiJ2osejcqsQr4kHCvS+k7Q0BnJ55U
	 FUJs22YMDL6BIbMystmCKkPI+nwn1pR8NXqTrpC0e0f0h9JqXNK3tRvwPPjsv4mJT6yv4
	 vAiby6kxyfeUHmKIPcxqzg6JXwA65PhNTHUA7iZJ5YxdYmIqnzPyMvCWmLqkfzye6lEW8
	 28KhNiVXjK2g3g6NYrbnm4rmmbQiN49+Zo6YOODOg9/Xvk3aJytFnlxgeK73A+rCWNda5
	 5QW+NCoYXjZy8G+rHaY3wiARtSRI4krPcwPP+DP9rydoYS/Uuxuq3/TDirJwZggCQdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nS5fF5SI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7CD606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nS5fF5SI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BCC41F000D0;
	Wed, 25 Nov 2026 16:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795625183;
	bh=VU72rpOO5ddas+cFunqgy4ik+zVyuMSbRCton92hcTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nS5fF5SIG0gcE8qxv3yVzITSwd/o+rtmkKsyWwpIiUcZj5Z2RRzcaU7NkKX+9NdLY
	 h9khlM00f+p73Px7KRGHIZHXFAHe7uuSVUvgYTHllLyHReByM2vJpQSwZAnf0hsjPH
	 Q79gi3XH373ZnsTM88jN/MOKiQ2fg+extk/rs/ARgxZzwbzrE8NZuORlSFws0yAo5d
	 aCx4jFqJ4TDhr6M9NmwHRkF3V8oEEfjVi6uuBUfU2BMOS8EaRsWQE82Df3LGAxfO5n
	 UVaZnJvG3U/X+Qd83xwHs+JgG8vlRmmiFYZsJUFCgIWA7nQJM+rWm+uUxQLiNK+b47
	 EeCpvM41vZAbw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vishwaroop A <va@nvidia.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] spi: tegra210-quad: Track DMA mapping state
Date: Wed, 25 Nov 2026 11:46:22 -0500
Message-ID: <20261125164549.857475-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112553-rudder-camera-262f@gregkh>
References: <2026112553-rudder-camera-262f@gregkh>
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

[ Upstream commit 7b9e6f7bc13c0259b192d0a964e802d4ad53b8b8 ]

tegra_qspi_dma_unmap_xfer() assumes a streaming mapping is always
outstanding and recomputes its length from the live
tqspi->curr_dma_words. Nothing records whether tegra_qspi_dma_map_xfer()
mapped anything, so neither assumption holds.

For a multi-chunk transfer, handle_dma_based_xfer() unmaps the chunk that
just completed, recalculates the parameters for the next chunk, which
overwrites curr_dma_words, and re-arms the hardware. If
tegra_qspi_start_dma_based_transfer() then fails at its
tegra_qspi_dma_map_xfer() call, nothing is mapped. That early return also
sits above the smp_store_release() that clears tqspi->trans_status, so the
previous chunk's QSPI_RDY survives, and the re-arm's return value is never
checked, so handle_dma_based_xfer() returns IRQ_HANDLED without completing
the transfer.

The caller times out, tegra_qspi_handle_timeout() sees the stale QSPI_RDY,
concludes the transfer completed and calls handle_dma_based_xfer() again.
No DMA completion arrives, so num_errors is incremented and
tegra_qspi_dma_unmap_xfer() runs with nothing mapped. t->tx_dma then holds
either the DMA_MAPPING_ERROR sentinel or, if the RX mapping was the one
that failed, the preceding chunk's address that has already been released.
Behind an IOMMU the latter frees an IOVA that may since have been
reallocated.

Record whether a mapping is outstanding and the length that was mapped,
and return early from tegra_qspi_dma_unmap_xfer() when there is nothing to
release. is_dma_mapped is only updated under tqspi->lock, or on the timeout
path after synchronize_irq() and cancel_work_sync() have quiesced the ISR
and the bottom half.

Also skip releasing the TX mapping on the RX failure path unless a TX
mapping was created; t->tx_dma is uninitialised when t->tx_buf is NULL.

Fixes: 921fc1838fb0 ("spi: tegra210-quad: Add support for Tegra210 QSPI controller")
Suggested-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Vishwaroop A <va@nvidia.com>
Link: https://patch.msgid.link/20261026111412.3843954-3-va@nvidia.com
Signed-off-by: Mark Brown <broonie@kernel.org>
[ sashal: Replaced the single tqspi->dev DMA device uses for the missing tx_dma_dev/rx_dma_dev split, keeping the upstream mapping-state tracking and unmap logic unchanged. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-tegra210-quad.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 14dd98b92bd93..ca91a69ea059e 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -207,6 +207,17 @@ struct tegra_qspi {
 	bool					is_packed;
 	bool					use_dma;
 
+	/*
+	 * Set while a streaming mapping created by
+	 * tegra_qspi_dma_map_xfer() is outstanding, together with the
+	 * length that was handed to dma_map_single(). is_curr_dma_xfer
+	 * only records that the last armed chunk took the DMA path,
+	 * which is not the same thing: a chunk whose mapping failed
+	 * leaves the DMA path flagged with nothing mapped.
+	 */
+	bool					is_dma_mapped;
+	unsigned int				dma_map_len;
+
 	u32					command1_reg;
 	u32					dma_control_reg;
 	u32					def_command1_reg;
@@ -586,22 +597,32 @@ static int tegra_qspi_dma_map_xfer(struct tegra_qspi *tqspi, struct spi_transfer
 	if (t->rx_buf) {
 		t->rx_dma = dma_map_single(tqspi->dev, (void *)rx_buf, len, DMA_FROM_DEVICE);
 		if (dma_mapping_error(tqspi->dev, t->rx_dma)) {
-			dma_unmap_single(tqspi->dev, t->tx_dma, len, DMA_TO_DEVICE);
+			if (t->tx_buf)
+				dma_unmap_single(tqspi->dev, t->tx_dma,
+						 len, DMA_TO_DEVICE);
 			return -ENOMEM;
 		}
 	}
 
+	tqspi->dma_map_len = len;
+	tqspi->is_dma_mapped = true;
+
 	return 0;
 }
 
 static void tegra_qspi_dma_unmap_xfer(struct tegra_qspi *tqspi, struct spi_transfer *t)
 {
-	unsigned int len;
+	if (!tqspi->is_dma_mapped)
+		return;
 
-	len = DIV_ROUND_UP(tqspi->curr_dma_words * tqspi->bytes_per_word, 4) * 4;
+	if (t->tx_buf)
+		dma_unmap_single(tqspi->dev, t->tx_dma,
+				 tqspi->dma_map_len, DMA_TO_DEVICE);
+	if (t->rx_buf)
+		dma_unmap_single(tqspi->dev, t->rx_dma,
+				 tqspi->dma_map_len, DMA_FROM_DEVICE);
 
-	dma_unmap_single(tqspi->dev, t->tx_dma, len, DMA_TO_DEVICE);
-	dma_unmap_single(tqspi->dev, t->rx_dma, len, DMA_FROM_DEVICE);
+	tqspi->is_dma_mapped = false;
 }
 
 static int tegra_qspi_start_dma_based_transfer(struct tegra_qspi *tqspi, struct spi_transfer *t)
-- 
2.53.0

