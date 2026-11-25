Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602842;
	b=ynvOhVAwdzltu8bI/QhDXZ5ETlquQeBo2OKo5Ypt2LXiFu1X9p0VCNW0eY0LefCI0Cyq
	 IameR8xg7UdoFdkFUXEGRK5LdJ8Jau05zF0W7y2Kh0aDqEDoLkGMashWw/LKBPvXIMRqx
	 mGFe91lm73zBglPU7YVW9HPyP0pLGAoGqzSpB5rWjOV2oynvSmCoqibLDlduHTXWwcS+E
	 +nJKAtScynCdyhF1Q8vXBHej3qy8EfbzdOVIfh6lS+aZN8+mLWmcnqKDDJ/jOe/wmNyRB
	 rreqtVLQ1Y2fR98iJosHbb3GjpwHd7vBvrj5teXl1TQCeyCofTgQkaJmbBvL27GiKjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602842;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=dJ9/ICdSoYiYWTzTZ/bbRfMOmUb3DgPbE/C+kRp0b+4=;
	b=jHwR6O+slmCzV0bML6XFXXo125B8kQpjtrXXRbK/O4jrNJF+FW+Sv2u7slm3032PH2Q6
	 YAF+u6Y+YEOfoImxFytz8uToQfBm8m345KkfBtPkLLroQbPcELbrghf8+vIc0sQxrZjEq
	 3u88buxkfImXSNRVTpJFW1J881Zu2Yx+/zKRJdM9jlIemf7IV48I7aM+8NCQYctLprhUt
	 xg41ja8le69KQi+zNz4yHaBE+ZYqMDMeRGcErpuCdzZSIfMeBo9aaKK75NUH8igS6yRqN
	 ORVww0vrdznTvEAA3UR3wz3vU2H3eADhefnu9NWGvT5N/Q4GgmF11XW+l8O6ORxLCig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=E+ZQiBXl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DBD606A326
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=E+ZQiBXl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA861F00A3C;
	Wed, 25 Nov 2026 10:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795602841;
	bh=dJ9/ICdSoYiYWTzTZ/bbRfMOmUb3DgPbE/C+kRp0b+4=;
	h=Subject:To:Cc:From:Date;
	b=E+ZQiBXlLRPJxs44edVwXpKutqQIp2WPfzh2nY6i4ioCQwJcvwJBY/nAOaBjI8XlR
	 6og2UwLa7mldx6ZylyArTC05sfbUsVv7M+zoTRHKwX/iVzrBo9DafFyqjOXQKsEQoK
	 quBSeWOgYWS0jSqGm3faF4HVMVH93K7MhL+3GJ5A=
Subject: FAILED: patch "[PATCH] spi: tegra210-quad: Unmap DMA buffers on transfer timeout" failed to apply to 6.12-stable tree
To: va@nvidia.com,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:15:04 +0100
Message-ID: <2026112504-skewer-nebulizer-41ec@gregkh>
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


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x d04ad85dd8015713b0b2531b5b934fe67828d741
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112504-skewer-nebulizer-41ec@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d04ad85dd8015713b0b2531b5b934fe67828d741 Mon Sep 17 00:00:00 2001
From: Vishwaroop A <va@nvidia.com>
Date: Mon, 26 Oct 2026 11:14:12 +0000
Subject: [PATCH] spi: tegra210-quad: Unmap DMA buffers on transfer timeout

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

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 1cd65a71bd5a..87c0e80f0551 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1507,10 +1507,12 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
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
@@ -1624,8 +1626,10 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
 				WARN_ON(1);
 				dev_err(tqspi->dev, "transfer timeout\n");
 
-				if (tqspi->is_curr_dma_xfer)
+				if (tqspi->is_curr_dma_xfer) {
 					tegra_qspi_dma_stop(tqspi);
+					tegra_qspi_dma_unmap_xfer(tqspi, xfer);
+				}
 
 				tegra_qspi_handle_error(tqspi);
 				ret = -EIO;

