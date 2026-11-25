Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602845;
	b=HL3N6YoKDtzubmTFKbIx4Zp0Z1PMZDHjd/REOilHZV+7cAjzRBr8CRb92Lb4XxHK9KmA
	 NBqSCcvQFDjiy14ar8wPS4IEmWTBJrkQ12AaN6aMbjeG3W2d/zgzz3pao88RXBFok1L1V
	 t3Rf2lnNTtpQnyTevM8VqME4Bu+vnyCflJ893DFmYfnqKBoHc4aIEIU03BHY4j2GZWXmN
	 eKfqN9SI3sKrABiVHLuNQbBwc6blqg6NUpMB1hpJH+qDP6TN09yhCOJNyUD0jRq1MtxBM
	 lyXFOw7YwHwjU+VGttdP8VFQNANUaFsrEwb8suj+hLqLAHssn0542CQ3qhFaYXwNJeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602845;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=zR/at58wdXnt56tvDk7nouG+w/HyxqaC0KGnGZvMfq0=;
	b=2dHuW2Z1dbeHuwrDJXM0Gw0k2JkisAY9rv4llSnRsjQ0d9Bh1vq4Quu1pSp8loWPjTZI
	 hmDM51IR6aOKwJGrm4QiyWzXy+4dDn0bczDCCisnfZL32aC7TonGcDJQNoKhQ66iYk7NP
	 oy+dO+I1viUlsC0UYqG640VzED/Tai1OKr7QnNk84Up8BHpAINKYneYEdvvl6SUqzbzMH
	 voo0tS/3UwpzgLNstdt9Oeyzux4JGvFGhpRbMZixPPm5toixPwPwyHSxH1A3ZKCJVsI7N
	 o7qY5I6YQ+MYS4XuNW+Eexl5ukSNsp1eFM3lk6U2samSLpKjtwk37AvBvNavpdw+mmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=lu7G2aBh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E3C606A336
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=lu7G2aBh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74461F000C6;
	Wed, 25 Nov 2026 10:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795602844;
	bh=zR/at58wdXnt56tvDk7nouG+w/HyxqaC0KGnGZvMfq0=;
	h=Subject:To:Cc:From:Date;
	b=lu7G2aBhdb8ZiTHifm9KPXOqo8sUTMoIWvrEt9nCDa++sRI/dLoMkxLjqMZ9+Tjn0
	 aS/IEYLXxO+hp4Zhp7KKTzFeu8gY2voushUF/SuLQy/3qzhnU+wPpfYIAZowlpVxfl
	 9CZIyLyVVXARkR6WxNvAWIl5IYorqt/l9RINkYAY=
Subject: FAILED: patch "[PATCH] spi: tegra210-quad: Unmap DMA buffers on transfer timeout" failed to apply to 6.18-stable tree
To: va@nvidia.com,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:15:04 +0100
Message-ID: <2026112504-attempt-reliant-a017@gregkh>
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


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x d04ad85dd8015713b0b2531b5b934fe67828d741
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112504-attempt-reliant-a017@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

