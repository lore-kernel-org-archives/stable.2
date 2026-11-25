Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602832;
	b=JSRvw/7W579VIDgYH5mCt/edqu6h1UtO0rSlwnNy3muuAOObug6r2UR/hTwtaeMNh1ZP
	 nd00ey6w2Lut3/RGc/pC83HmPNVJpqDKKxpST7eWSumSKGMadMvhC0kiW5JA20z0LN632
	 V1JL0QuWILgG2SmJOcidVsPpsfTV4uYr7MwLvr+Qt0fOOdoiIjegpnvJ5rouow52PU26I
	 JheqIq+oZjMI5xCrUrFAMndoRTCHinJcXcoBOELvNX0QNmFlJIRF21voZ03XB8EwbfcVB
	 1wFMpP28ctUHDGaiaOAEuUqM492cIQ+OSuLHPftsIQGKuClAMG9CO8cKZpbK1k/XoPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602832;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=KDYuyQXYRAL4v9T9ZMTw4IzfgHZ1wOXTtOjfavR8U88=;
	b=wmYiSUST16K/kEpJutFGFvfigldcb+TzjkelViIMeZhbe1u4e7qwQbNLqbZ7M6A/d27o
	 rUnvQCxhUWrrA6RjAZt+O7INV41TyMqEAjjVdkYKcXtDVbs3cSVkj0tKciCv3hFhi9r/W
	 6zU3RsA7DVQaDnRT4fOJBgBM702JpIJNOWD4d4+oT7irreBTwQOzUvEDgVrvDjwtlLLf1
	 ud+aKefyQ0UX0M/gqAzYp9n3INDGGwfLkbBxffelrMXSVVP7Ezn6y+yBEMSppIFQ4P+Hz
	 V40Az0STYD62iXQ3gKp8VDada6hrjfyERYoOfVNEWjPz3dDSjRZF6I8aBFsnrdl//Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=N43gFciO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E385606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=N43gFciO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D461F000C6;
	Wed, 25 Nov 2026 10:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795602832;
	bh=KDYuyQXYRAL4v9T9ZMTw4IzfgHZ1wOXTtOjfavR8U88=;
	h=Subject:To:Cc:From:Date;
	b=N43gFciOglatxBjgdlTNCw4Gi5Z1zzJLnarar5WnTRcrq9cHYeVEgapcZEmCVsqDL
	 p8tWejEQE8LodSoZmKGJCxnefUNhZ+Gwem3UIMacZrgBj68Aoiv4tuTIID6smg59yK
	 vFAUrPIyzj3DkriW/nKKHAI9lgU6IsA/kvgYhQMk=
Subject: FAILED: patch "[PATCH] spi: tegra210-quad: Track DMA mapping state" failed to apply to 6.1-stable tree
To: va@nvidia.com,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:14:54 +0100
Message-ID: <2026112554-tropics-manual-5667@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 7b9e6f7bc13c0259b192d0a964e802d4ad53b8b8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112554-tropics-manual-5667@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7b9e6f7bc13c0259b192d0a964e802d4ad53b8b8 Mon Sep 17 00:00:00 2001
From: Vishwaroop A <va@nvidia.com>
Date: Mon, 26 Oct 2026 11:14:11 +0000
Subject: [PATCH] spi: tegra210-quad: Track DMA mapping state

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

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 8b8b317e2078..1cd65a71bd5a 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -237,6 +237,17 @@ struct tegra_qspi {
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
@@ -606,24 +617,32 @@ static int tegra_qspi_dma_map_xfer(struct tegra_qspi *tqspi, struct spi_transfer
 	if (t->rx_buf) {
 		t->rx_dma = dma_map_single(tqspi->rx_dma_dev, (void *)rx_buf, len, DMA_FROM_DEVICE);
 		if (dma_mapping_error(tqspi->rx_dma_dev, t->rx_dma)) {
-			dma_unmap_single(tqspi->tx_dma_dev, t->tx_dma, len, DMA_TO_DEVICE);
+			if (t->tx_buf)
+				dma_unmap_single(tqspi->tx_dma_dev, t->tx_dma,
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
-
-	len = DIV_ROUND_UP(tqspi->curr_dma_words * tqspi->bytes_per_word, 4) * 4;
+	if (!tqspi->is_dma_mapped)
+		return;
 
 	if (t->tx_buf)
-		dma_unmap_single(tqspi->tx_dma_dev, t->tx_dma, len, DMA_TO_DEVICE);
+		dma_unmap_single(tqspi->tx_dma_dev, t->tx_dma,
+				 tqspi->dma_map_len, DMA_TO_DEVICE);
 	if (t->rx_buf)
-		dma_unmap_single(tqspi->rx_dma_dev, t->rx_dma, len, DMA_FROM_DEVICE);
+		dma_unmap_single(tqspi->rx_dma_dev, t->rx_dma,
+				 tqspi->dma_map_len, DMA_FROM_DEVICE);
+
+	tqspi->is_dma_mapped = false;
 }
 
 static int tegra_qspi_start_dma_based_transfer(struct tegra_qspi *tqspi, struct spi_transfer *t)

