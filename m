Received: from out28-125.mail.aliyun.com (out28-125.mail.aliyun.com [115.124.28.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D958239AD34;
	Tue, 29 Sep 2026 08:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790669531; cv=none; b=dXUKWzTUd4LCFAlECati79xBg+yW4/+tWejaJ6ftcNshn/Or0tMX8n2vZt1bU32U5PbLGcbkVv5VWAcAAx1GAtq8EGHteylcT67onJ9291fZ9es69UtIibEdy5YslymUK1QQYi9k2tWAyHyc9PqU4gyLYCEZGFyuOlyUOZa57vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790669531; c=relaxed/simple;
	bh=2imljEwwzqlpnd8NAsxe8XkigXqwhnZYF1YW1xpA1sI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VzkKIebcNW6gM7PMfTXNT9HRAuicenLhucU+B4Gy56ADcof86FGjO0ituXe60T0lH1/63J1ZTR6eBfWOVlNG8k6vtmMxTOJEy78+1jmpreO+7bEdxxboEDQHC7zNPtfUYAGJ631/SWVuXWdbggSFJfeP0bHKLDNmiks0DYO/1Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=GWo4mvpA; arc=none smtp.client-ip=115.124.28.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="GWo4mvpA"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1790669517; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=BkeFtWqy/I7OSt7jQm57adu1C6/ziouesGUA5hrmyzE=;
	b=GWo4mvpAvSpvK8uwVZv2M8BI6pX9vYT10swbJ1+uosNv+OrPMjYmSWBqWMjrGWYl/rQq6kPp1eBEK0AZdCCvMuJ/9/2icZcjU0No5plXcTIGhRewMUz7cxmRdpTrS+9zVpEzdIGC0PiaMs87BgEsFjDDnriy/ND6vN90zMm7tc8=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0266958-0.0408523-0.932452;FP=13570289848629609651|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033040074035;MF=liuwb@xiaopeng.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.jR5Cs3F_1790669516;
Received: from localhost(mailfrom:liuwb@xiaopeng.com fp:SMTPD_---.jR5Cs3F_1790669516 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 29 Sep 2026 16:11:56 +0800
From: Weibin Liu <liuwb@xiaopeng.com>
To: broonie@kernel.org
Cc: thangaraj.s@microchip.com,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] spi: spi-pci1xxxx: quiesce DMA engines on transfer timeout
Date: Tue, 29 Sep 2026 16:11:56 +0800
Message-ID: <20260929081156.42124-1-liuwb@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
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
subsequent transfers keep working. Also make the DMA ISRs ignore
interrupts while no transfer is in progress so that a stray MSI after
the cleanup can no longer act on the cleared state.

Fixes: 9538edeb72c9 ("spi: mchp-pci1xxxx: DMA support for copying data to and from SPI Buf")
Cc: stable@vger.kernel.org # 6.8+
Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>
---
Reviewer notes:

- The quiesce sequence only runs on the DMA timeout branch, i.e. when
  neither DMA_TERM nor the two abort interrupts arrived; all other
  paths behave as before. Every path still passes through the error
  label, which now additionally drops the stale p->xfer, p->tx_sgl and
  p->rx_sgl pointers.
- Ordering matters: the done/abort status bits are drained under the
  same spinlocks the ISRs use, then p->spi_xfer_in_progress is dropped
  and the DMA IRQs are synchronized before the engines are turned back
  on, so an ISR can never observe a half-cleared state. The ISRs
  additionally return IRQ_NONE while no transfer is in progress, which
  also keeps the interrupt accounting right for stray MSIs after the
  cleanup.
- readl_poll_timeout() waits at most 1 ms per engine; it only runs
  after the transfer has already timed out, so the added latency stays
  on the failure path.

Tested on x86_64: with this patch applied the driver builds, loads and
unloads cleanly; no PCI1XXXX device is available to exercise the DMA
timeout path on hardware.

 drivers/spi/spi-pci1xxxx.c | 56 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/spi/spi-pci1xxxx.c b/drivers/spi/spi-pci1xxxx.c
index af6ed7849..b296d7f6e 100644
--- a/drivers/spi/spi-pci1xxxx.c
+++ b/drivers/spi/spi-pci1xxxx.c
@@ -542,6 +542,7 @@ static int pci1xxxx_spi_transfer_with_dma(struct spi_controller *spi_ctlr,
 	struct pci1xxxx_spi_internal *p = spi_controller_get_devdata(spi_ctlr);
 	struct pci1xxxx_spi *par = p->parent;
 	dma_addr_t tx_dma_addr = 0;
+	unsigned long flags;
 	int ret = 0;
 	u32 regval;
 
@@ -618,12 +619,58 @@ static int pci1xxxx_spi_transfer_with_dma(struct spi_controller *spi_ctlr,
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
+		if (readl_poll_timeout(par->dma_offset_bar +
+				       SPI_DMA_GLOBAL_WR_ENGINE_EN, regval,
+				       regval == 0x0, 0, USEC_PER_MSEC) ||
+		    readl_poll_timeout(par->dma_offset_bar +
+				       SPI_DMA_GLOBAL_RD_ENGINE_EN, regval,
+				       regval == 0x0, 0, USEC_PER_MSEC))
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
+		writel(SPI_DMA_ENGINE_EN,
+		       par->dma_offset_bar + SPI_DMA_GLOBAL_WR_ENGINE_EN);
+		writel(SPI_DMA_ENGINE_EN,
+		       par->dma_offset_bar + SPI_DMA_GLOBAL_RD_ENGINE_EN);
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
@@ -695,6 +742,9 @@ static irqreturn_t pci1xxxx_spi_isr_dma_rd(int irq, void *dev)
 	unsigned long flags;
 	u32 regval;
 
+	if (!p->spi_xfer_in_progress)
+		return IRQ_NONE;
+
 	/* Clear the DMA RD INT and start spi xfer*/
 	regval = readl(p->parent->dma_offset_bar + SPI_DMA_INTR_RD_STS);
 	if (regval) {
@@ -723,6 +773,9 @@ static irqreturn_t pci1xxxx_spi_isr_dma_wr(int irq, void *dev)
 	unsigned long flags;
 	u32 regval;
 
+	if (!p->spi_xfer_in_progress)
+		return IRQ_NONE;
+
 	/* Clear the DMA WR INT */
 	regval = readl(p->parent->dma_offset_bar + SPI_DMA_INTR_WR_STS);
 	if (regval) {
@@ -755,6 +808,9 @@ static irqreturn_t pci1xxxx_spi_isr_dma(int irq, void *dev)
 	irqreturn_t spi_int_fired = IRQ_NONE;
 	u32 regval;
 
+	if (!p->spi_xfer_in_progress)
+		return IRQ_NONE;
+
 	/* Clear the SPI GO_BIT Interrupt */
 	regval = readl(p->parent->reg_base + SPI_MST_EVENT_REG_OFFSET(p->hw_inst));
 	if (regval & SPI_INTR) {

base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
prerequisite-patch-id: e48582f6ffe124b3806593af6e22b74682c8a83f
prerequisite-patch-id: 369f74b9a7ecde56141b13ec671f9200345a3bab
prerequisite-patch-id: cbf6f60473c80add5b2cddf22d142f35a4e3c834
prerequisite-patch-id: b35e6ec691cd7a99f1ed86137a0ec101a8510c31
-- 
2.50.1

