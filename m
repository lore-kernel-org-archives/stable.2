Received: from out28-74.mail.aliyun.com (out28-74.mail.aliyun.com [115.124.28.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525772253B0;
	Fri, 16 Oct 2026 02:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792116049; cv=none; b=k3fspR1l/nK/KxoSUFk9Ipu4YTfCGW4Ftc4oFIX+uqhlD4WF0ZMGukCEV/IBnfuZkSXtQtSntYNTb5Q2LLozDI5BstjXETDVKW4h76gH0bPUI2fIAylJse7uKIN2pYwhatc1Z/aLgLy4JPaC7RdKU3d+vQym7Bv5Fq4H0WF45r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792116049; c=relaxed/simple;
	bh=hArVBtCRU/kLSKIowAlXZa5OjPzy2/gynG+cb3qky9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tzAuN+w0ebqKWe3HUMSEhPoVf52vuhyD+bDsnSian8F8MmgCxECnN6vqf8cJYpOjqSyjrEKJbuzoaBdbtwZ4EsHFJl0V8OUK3Qjpr5TnwB2YWoaZtn7US+GWani8mr+UgKUAmBEwDOwE4hi13eRS3gvIYQuYl0BvdbaFUIyfMDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=TOJkkKsh; arc=none smtp.client-ip=115.124.28.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="TOJkkKsh"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1792116038; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=8xHCseB7cd3CDn8Avktw7rEecUc/XA9e2G7G1JWOoSg=;
	b=TOJkkKshofp8JtUJZFQSqzYNEmh07fJzW3B2aMNxnVmpM6p0hBZJR3IVLzhx5M8DrFzJazKrELqTbJhrm3Ny1CC3zaE4b0HifDOLFrFWUELD464/qTBOvbM/uzgcb4wSxIthrbxsBsTIkw89P50pP51KunCeydueYatdpGKdrCs=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0809943-0.0735853-0.84542;FP=13569761818907788723|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045220102;MF=liuwb@xiaopeng.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.jfodWnf_1792116036;
Received: from localhost(mailfrom:liuwb@xiaopeng.com fp:SMTPD_---.jfodWnf_1792116036 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 16 Oct 2026 10:00:37 +0800
From: Weibin Liu <liuwb@xiaopeng.com>
To: broonie@kernel.org
Cc: thangaraj.s@microchip.com,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] spi: spi-pci1xxxx: quiesce DMA engines on transfer timeout
Date: Fri, 16 Oct 2026 10:00:36 +0800
Message-ID: <20261016020036.1333548-1-liuwb@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <a02880a9-f20f-45ad-b22b-c405fb7e74d0@sirena.org.uk>
References: <a02880a9-f20f-45ad-b22b-c405fb7e74d0@sirena.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a DMA-mapped transfer times out waiting for DMA_TERM and neither DMA
abort interrupt arrived, pci1xxxx_spi_transfer_with_dma() returns
through the error label while both DMA engines are still enabled, the
done/abort interrupt status is still armed and the transfer state
(p->xfer, p->tx_sgl, p->rx_sgl) is still registered.

The ISRs keep firing afterwards: they reprogram the DMA engines from
p->tx_sgl / p->rx_sgl and signal completion through p->xfer and
p->spi_xfer_done, all of which the SPI core is free to unmap or reuse
once transfer_one() has returned, which is a use-after-free. A late
done interrupt can also start the next transfer queued behind the
failed one.

Stop both DMA engines, drain the pending done/abort interrupt status
and synchronize the DMA IRQs before dropping the in-progress state and
the transfer pointers, and re-enable the engines afterwards so that
subsequent transfers keep working. The engines are only turned back on
once both were confirmed to have stopped: re-enabling an engine that
failed to stop would cancel the pending stop request and let it keep
running into buffers the SPI core is about to unmap or free, which is
exactly the window this patch closes. An engine that failed to stop is
left disabled, as the abort paths already do.

The DMA interrupt status and mask registers are shared between the two
SPI instances, so the cleanup drains only this instance's done/abort
status bits instead of masking the interrupt lines, which would also
suppress the peer instance's completion interrupts.

Also make the DMA ISRs ignore interrupts while no transfer is in
progress so that a stray MSI after the cleanup can no longer act on
the cleared state.

No PCI1XXXX hardware was available for testing and QEMU has no model
of this PCIe part, so the timeout path was exercised with a userspace
replica of the timeout branch and the DMA ISRs, with the register and
interrupt accesses mocked: on the unfixed code both a wedged engine
that clears after the timeout and a late done interrupt touch the
freed transfer state, while with this fix applied neither does and an
engine that failed to stop is left disabled.  The module was also
loaded and unloaded in a QEMU x86_64 guest running a kernel with this
fix applied.

Fixes: 9538edeb72c9 ("spi: mchp-pci1xxxx: DMA support for copying data to and from SPI Buf")
Cc: stable@vger.kernel.org # 6.8+
Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>
---
Changes in v2:

- Keep the engines disabled when the stop poll fails instead of
  re-enabling them unconditionally: re-enabling an engine that failed
  to stop would cancel the pending stop request and reopen the window
  this patch closes.  The engines are now only turned back on once
  both were confirmed to have stopped, which matches the abort paths,
  where a failed stop returns -ECANCELED and the engines are left
  disabled.

- Extend the commit message with why the interrupt lines are not
  masked during the cleanup (the status and mask registers are shared
  with the peer SPI instance on this part) and with a testing note.

 drivers/spi/spi-pci1xxxx.c | 71 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/spi/spi-pci1xxxx.c b/drivers/spi/spi-pci1xxxx.c
index af6ed78493e3..c50e6841de52 100644
--- a/drivers/spi/spi-pci1xxxx.c
+++ b/drivers/spi/spi-pci1xxxx.c
@@ -542,6 +542,8 @@ static int pci1xxxx_spi_transfer_with_dma(struct spi_controller *spi_ctlr,
 	struct pci1xxxx_spi_internal *p = spi_controller_get_devdata(spi_ctlr);
 	struct pci1xxxx_spi *par = p->parent;
 	dma_addr_t tx_dma_addr = 0;
+	unsigned long flags;
+	bool engines_stopped;
 	int ret = 0;
 	u32 regval;
 
@@ -618,12 +620,72 @@ static int pci1xxxx_spi_transfer_with_dma(struct spi_controller *spi_ctlr,
 			p->dma_aborted_wr = false;
 			ret = -ECANCELED;
 		}
+
+		/*
+		 * A timed out transfer leaves the DMA engines running and
+		 * the done/abort interrupt status armed with p->xfer,
+		 * p->tx_sgl and p->rx_sgl still registered.  Stop the
+		 * engines, drain the pending status and synchronize the
+		 * IRQs before dropping the transfer state, otherwise a
+		 * late interrupt makes the ISRs reprogram the engines
+		 * from or signal completion through memory which the SPI
+		 * core is about to unmap or free.
+		 */
+		writel(SPI_DMA_ENGINE_DIS,
+		       par->dma_offset_bar + SPI_DMA_GLOBAL_WR_ENGINE_EN);
+		writel(SPI_DMA_ENGINE_DIS,
+		       par->dma_offset_bar + SPI_DMA_GLOBAL_RD_ENGINE_EN);
+		engines_stopped =
+			!(readl_poll_timeout(par->dma_offset_bar +
+					     SPI_DMA_GLOBAL_WR_ENGINE_EN,
+					     regval, regval == 0x0, 0,
+					     USEC_PER_MSEC) ||
+			  readl_poll_timeout(par->dma_offset_bar +
+					     SPI_DMA_GLOBAL_RD_ENGINE_EN,
+					     regval, regval == 0x0, 0,
+					     USEC_PER_MSEC));
+		if (!engines_stopped)
+			dev_warn(&par->dev->dev,
+				 "SPI DMA engines failed to stop\n");
+
+		spin_lock_irqsave(&par->dma_wr_reg_lock, flags);
+		writel((SPI_DMA_DONE_INT_MASK(p->hw_inst) |
+			SPI_DMA_ABORT_INT_MASK(p->hw_inst)),
+		       par->dma_offset_bar + SPI_DMA_INTR_WR_CLR);
+		spin_unlock_irqrestore(&par->dma_wr_reg_lock, flags);
+		spin_lock_irqsave(&par->dma_rd_reg_lock, flags);
+		writel((SPI_DMA_DONE_INT_MASK(p->hw_inst) |
+			SPI_DMA_ABORT_INT_MASK(p->hw_inst)),
+		       par->dma_offset_bar + SPI_DMA_INTR_RD_CLR);
+		spin_unlock_irqrestore(&par->dma_rd_reg_lock, flags);
+
+		p->spi_xfer_in_progress = false;
+		synchronize_irq(p->irq[1]);
+		synchronize_irq(p->irq[2]);
+
+		/*
+		 * Turn the engines back on only once both are confirmed
+		 * to have stopped: re-enabling an engine that failed to
+		 * stop would cancel the pending stop request and let it
+		 * run into buffers the SPI core is about to unmap or
+		 * free.  An engine that failed to stop is left disabled,
+		 * as the abort paths already do.
+		 */
+		if (engines_stopped) {
+			writel(SPI_DMA_ENGINE_EN,
+			       par->dma_offset_bar + SPI_DMA_GLOBAL_WR_ENGINE_EN);
+			writel(SPI_DMA_ENGINE_EN,
+			       par->dma_offset_bar + SPI_DMA_GLOBAL_RD_ENGINE_EN);
+		}
 		goto error;
 	}
 	ret = 0;
 
 error:
 	p->spi_xfer_in_progress = false;
+	p->xfer = NULL;
+	p->tx_sgl = NULL;
+	p->rx_sgl = NULL;
 
 	return ret;
 }
@@ -695,6 +757,9 @@ static irqreturn_t pci1xxxx_spi_isr_dma_rd(int irq, void *dev)
 	unsigned long flags;
 	u32 regval;
 
+	if (!p->spi_xfer_in_progress)
+		return IRQ_NONE;
+
 	/* Clear the DMA RD INT and start spi xfer*/
 	regval = readl(p->parent->dma_offset_bar + SPI_DMA_INTR_RD_STS);
 	if (regval) {
@@ -723,6 +788,9 @@ static irqreturn_t pci1xxxx_spi_isr_dma_wr(int irq, void *dev)
 	unsigned long flags;
 	u32 regval;
 
+	if (!p->spi_xfer_in_progress)
+		return IRQ_NONE;
+
 	/* Clear the DMA WR INT */
 	regval = readl(p->parent->dma_offset_bar + SPI_DMA_INTR_WR_STS);
 	if (regval) {
@@ -755,6 +823,9 @@ static irqreturn_t pci1xxxx_spi_isr_dma(int irq, void *dev)
 	irqreturn_t spi_int_fired = IRQ_NONE;
 	u32 regval;
 
+	if (!p->spi_xfer_in_progress)
+		return IRQ_NONE;
+
 	/* Clear the SPI GO_BIT Interrupt */
 	regval = readl(p->parent->reg_base + SPI_MST_EVENT_REG_OFFSET(p->hw_inst));
 	if (regval & SPI_INTR) {
-- 
2.50.1

