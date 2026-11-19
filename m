Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795079954;
	b=fPUP0ax5qex5GckfjJ7NqK684btpJW6QtAKNZF4sKo/nw6MYovaDVKSrkTVnbBGbSidC
	 O7RTZQz1ePcrNGvuk7R+mcet27RZ4PoKgGzOOC55HEggJyxQqGqaGPvgqHaSDNbONKk6E
	 3+5OoF8/28z8rljt4EQUZ7AIOLzwKWdqnuP1AwQw3YhJWA3c2Z7z5O1p02Q3ZdAmPW0p5
	 3emPzlZuQrvnBVyFJ3Y3EHMY2JnDt33khXvz1lHZHpWdmsoxy2+gG2TK/RKiliF5zPwJK
	 I4ab9Upk/Md6rm7CiGdqyNlK0DgVMudGPPuUJQ25OlHs6mWD5TgaRBvFcUJbMGilbJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795079954;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zBJiwp2wWDrj/B4RvWE10jcGB1z0Sox6oHmVSi3ycQo=;
	b=069JZ3SwL2xccKfChKjUimEBz1rAr8NpQLRRpYyDKqWvSsQHGN81zpAvULcRTbWf/R0c
	 357ROHdu+biPNPFCTpLI3/YlA+tqU+CPhKxiXkFDiJ1QDUf8SAlSh/KwMcoh86S0dK2s/
	 Z3U3WNjlOxKyUoJnIAhC+9Zyw7EN4roJGjz8jLVchx/nXD1FxJI+b0CDE6jpFUpRQcFIz
	 gcg8WMN0sSJnswITc1Pc+kQFgqIr96qfZmuWeQf9XOUwskRWRl9UL/KYYI74JiO+fZj1J
	 rEN5IVfoHxI495S5l5URtN1YLsqd12zr7zL4gnodK5HIkZYcFbRrR8w61gqKd6HYBLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lixcimYr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D055606A320;
	Thu, 19 Nov 2026 09:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lixcimYr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D9A1F000C7;
	Thu, 19 Nov 2026 09:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795079953;
	bh=zBJiwp2wWDrj/B4RvWE10jcGB1z0Sox6oHmVSi3ycQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lixcimYrWxtOrPI8IoID28nrcPKaInR6ZKaeWIqbOFwwrJKgFXc2KWFgfsHfDptpJ
	 EQV9NBoTeocqkb/AUo2p1R8Lq+f/agvHXuHgUvsRyVl36kf5WjjeNgX83SzsH7Bgbj
	 2ICCgWnlwu+ozydKOX5kc/9bHYMfmcsxdVHleFRa+CeHXoxYXjZtJLUGdQa34g1JRv
	 Rs7EB3lczd3spFK1E0ZJGeOPzwHKd7oEz5kTXP0nt7IeBhCm66eIDWrcC53aGTrvPM
	 WqNeFR8HvMKNeg7bn0ffOJ9tTsNHWFznenEGlMQjsXpxJpin6Qof/d2Kwo7ddCsyVk
	 TnonrNeJ1W+jA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Han Xu <han.xu@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
	Suresh Gupta <suresh.gupta@nxp.com>,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 08/10] spi: fsl-qspi: Propagate clock errors from fsl_qspi_select_mem()
Date: Thu, 19 Nov 2026 09:17:20 +0000
Message-ID: <20261119091810.3440619-9-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
In-Reply-To: <20261119091810.3440619-1-lee@kernel.org>
References: <20261119091810.3440619-1-lee@kernel.org>
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

fsl_qspi_select_mem() returns void and silently gives up if either
clk_set_rate() or fsl_qspi_clk_prep_enable() fails.  fsl_qspi_exec_op()
then carries on with the operation regardless.

When switching between devices, a failed rate change leaves q->selected
pointing at the previously selected chip, so the operation is issued
through the previous device's SFAR and AHB window.  If the failure
happens on the first operation, q->selected is still -1 from probe, so
those offsets are derived from a negative chip select.  On controllers
which need the clocks disabled while the rate is changed, a
clk_set_rate() failure also leaves the clocks off while registers
continue to be accessed.

Re-enable the clocks even when setting the rate failed, return any error
to the caller, and have fsl_qspi_exec_op() abort the operation when
selecting the device fails.

Fixes: 84d043185dbe ("spi: Add a driver for the Freescale/NXP QuadSPI controller")
Closes: https://sashiko.dev/#/bug/linux-719261ef-312e-4a94-9a84-fd42a411bee0
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/spi/spi-fsl-qspi.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index d2c2090442f8..30f39adb5a6b 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -546,15 +546,15 @@ static void fsl_qspi_invalidate(struct fsl_qspi *q)
 	qspi_writel(q, reg, q->iobase + QUADSPI_MCR);
 }
 
-static void fsl_qspi_select_mem(struct fsl_qspi *q, struct spi_device *spi,
-				const struct spi_mem_op *op)
+static int fsl_qspi_select_mem(struct fsl_qspi *q, struct spi_device *spi,
+			       const struct spi_mem_op *op)
 {
 	unsigned long rate = op->max_freq;
 	int ret;
 
 	if (q->selected == spi_get_chipselect(spi, 0) &&
 	    q->selected_freq == op->max_freq)
-		return;
+		return 0;
 
 	if (needs_4x_clock(q))
 		rate *= 4;
@@ -563,19 +563,24 @@ static void fsl_qspi_select_mem(struct fsl_qspi *q, struct spi_device *spi,
 		fsl_qspi_clk_disable_unprep(q);
 
 	ret = clk_set_rate(q->clk, rate);
-	if (ret)
-		return;
 
 	if (needs_clk_disable(q)) {
-		ret = fsl_qspi_clk_prep_enable(q);
-		if (ret)
-			return;
+		int err;
+
+		err = fsl_qspi_clk_prep_enable(q);
+		if (!ret)
+			ret = err;
 	}
 
+	if (ret)
+		return ret;
+
 	q->selected = spi_get_chipselect(spi, 0);
 	q->selected_freq = op->max_freq;
 
 	fsl_qspi_invalidate(q);
+
+	return 0;
 }
 
 static void fsl_qspi_read_ahb(struct fsl_qspi *q, const struct spi_mem_op *op)
@@ -682,7 +687,9 @@ static int fsl_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	fsl_qspi_readl_poll_tout(q, base + QUADSPI_SR, (QUADSPI_SR_IP_ACC_MASK |
 				 QUADSPI_SR_AHB_ACC_MASK), 10, 1000);
 
-	fsl_qspi_select_mem(q, mem->spi, op);
+	err = fsl_qspi_select_mem(q, mem->spi, op);
+	if (err)
+		goto out_unlock;
 
 	if (needs_amba_base_offset(q))
 		addr_offset = q->memmap_phy;
@@ -725,6 +732,7 @@ static int fsl_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	/* Invalidate the data in the AHB buffer. */
 	fsl_qspi_invalidate(q);
 
+out_unlock:
 	mutex_unlock(&q->lock);
 
 	return err;
-- 
2.56.1.708.g77570a6a1d-goog

