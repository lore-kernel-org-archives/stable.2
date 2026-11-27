Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793583;
	b=CYNQmoZ9vBAN8MH56VCIBlMFw9c9z6leUt/RX+1BVfwwlA9OS3kAaTn9YLdxxT/CRkS2
	 3GCfUcDGkKSuFxlb12G5MpcRnko9w91OCETKtERxkiWsev36RLZ6RpnUOJXx9RTRtgj+N
	 eWG13LiKOgI0aFjuIznXCEWOF920WVwrx+cDORdvQvq+rpZUpBd1MEOYU/rhKG9KQLIWH
	 IbaMz9GEFkepX98uNStrz5uE3FPnTR2/VQswyhjKXfYI6jVkl/0mjoOBcxGjQDlxN70Ev
	 NtAP/yQMQdtqlGDf8dbfecxT5+zMnLzws0U3NG2sf5ckXz2LXvT7vLogzLjXRFBYD0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793583;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tCnEaPC2oCmP7Q+rm55UHdpXHqDiq1e0RzF0qFlhbB0=;
	b=pnYcL2EWy5c8TXE2FhCgAi6erQ1DciSVrMXpnreCdfE55bsDEsI6p5MfeISOw62TIrQr
	 R/FgjfiDHPAYTMzT3mEOqZ/T4nPkpjD8PQXb5Tky++WdP4v16nsEXb0yGr5UYZ6rAs/kr
	 DKsXExKF3kA0+BXQzDnZtgMLzWawOHtRoGxWXYrA5AveOoaxwxk0pzFShUwgvSBJfm0P9
	 nh3x0IT1IsGqHZDOXRG1vqckhAZzeftY//0CoFQZzUYHv6ENmrB3VOlA/eTMiCgKhYi2b
	 dpsHIUdXXgzJiWcrvPDjDMMY/JupFwwxIZUjp7LwiAhjCDP1PELAqxqOlSxX8kQTFNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=USxW0i1I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5BC606A31C;
	Fri, 27 Nov 2026 15:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=USxW0i1I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB831F000C1;
	Fri, 27 Nov 2026 15:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795793582;
	bh=tCnEaPC2oCmP7Q+rm55UHdpXHqDiq1e0RzF0qFlhbB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=USxW0i1IrI4otxPLbvI6FHvE9E2nTlyVgtvgfnKGo/Hq9ZYo9RNJKxYxWYLnNsFpV
	 8UQp1VuJZ4Ls/2rV2QTnIX8CAuru44AiKocbiqz7n1MFTtDwnMR3jTE3pB313Mxsn+
	 CcQdeMEmtnt1a+zLugnfLDkimsGtJvjxuqMTSChlqzzVsewles+3xnt/piy3ub+eK/
	 msAGi+7wDZAwXFIoG40MOjOEz6ADl5tlusn6hIsaCGdm5jlvB3gg4rpuEnbvfAF3ew
	 WvR+G8cyoOVbbVb/+FUY6cUOrIfj7GXb+RNE/mwYpi7ydMZ5ur7hIVUFk6CBxnHp6C
	 iBYBeFxrhk4mQ==
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
Subject: [PATCH v2 08/10] spi: fsl-qspi: Propagate clock errors from fsl_qspi_select_mem()
Date: Fri, 27 Nov 2026 15:31:11 +0000
Message-ID: <20261127153158.2969573-9-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127153158.2969573-1-lee@kernel.org>
References: <20261127153158.2969573-1-lee@kernel.org>
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
v1 => v2:
 - Rebase onto spi/for-next; no functional changes.

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
2.56.1.839.g22a8290db9-goog

