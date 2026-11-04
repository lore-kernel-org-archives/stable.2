Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802139;
	b=MVh2sXstaesEX+yilWaBCrq9j8hgzIx7+nqBmHAS3L2hj/Gu7mlF816xvzLE+3xymZT9
	 5LwKOv3UCkWjjWESKRIwvM9VWgvcbvhNJWXdRWFUe07jBx7FcBj8a0Ze6iTw2uJ1g1/0G
	 Na6TKVWqpwsz8aXpesCGROgeyprMAgvm6YeD7U4zDrs7ZkcitaHfGxb4ZTuf2HEPsdORP
	 mvnwYSrGDA8q6gpXxHOSulkFMLZvxk19KjwSATUeHlsazSg96r9v8+/1XAUwdq/SZUt/p
	 p5GUm8uD2E25Nx3hYvOa6IjgCJN9fZWkS4UOJTWLfBh5ZvmqZDucKVwhhJWnWSv7olQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802139;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Oc2YwK2n6z5kIikdySyzmvxO3PBadt4kaSvluqg47ls=;
	b=pyH3Du04YqxUwHA+vLkqyPXNRUSozW2cQisyAsTc/iFiCz8A5uEM03S0WCEBz3cuKqiE
	 36JRglbel2T3MIDMHDfoi+De0GG1+deUcXO5jl0sGWHKfXsQhKCicoMxlnBHWtOL0efQe
	 syWQpGCKvYZgWnPyM+V3QNmBQXwnozAb0pN0JnsnLrM5itm3EMWPExhBabMcCfdQvGHU+
	 5NDhvey9rJNfhNBMyBJk+dlXHAEI1cSyDhJXbwfsoEK02/w4fU1kr/ss41k86c9oqHi2t
	 Y7e8MlCJYc+hAHdHWSzz2RJGgwmf9qsX9VSSjWVCLVsmpb+rE8bxpG9LyYPveyie2CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=v7n0rZ9G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10A6606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=v7n0rZ9G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5191F000C1;
	Wed,  4 Nov 2026 14:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793802138;
	bh=Oc2YwK2n6z5kIikdySyzmvxO3PBadt4kaSvluqg47ls=;
	h=Subject:To:Cc:From:Date;
	b=v7n0rZ9Gz5EEje3I9hUxGJ99o4PhsHlVRS1sYqInddmHBoiI6IWTmSLIPZvaIFwr4
	 WNxxDvOzLnGLCpihRQ5it9gV53VOVwODfaVxiakg5eiZzEoHf/XbVYzCGMNNu2skef
	 MvjaJmaK3oRFFwvHsbfgPFZCIXdw6TQ4q8sAU7no=
Subject: FAILED: patch "[PATCH] spi: spi-pci1xxxx: quiesce DMA engines on transfer timeout" failed to apply to 6.12-stable tree
To: liuwb@xiaopeng.com,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:22:17 +0100
Message-ID: <2026110417-chatroom-stock-3229@gregkh>
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
git cherry-pick -x 0b591332a2bdc13d3f9163793131fe3651d1556a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110417-chatroom-stock-3229@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0b591332a2bdc13d3f9163793131fe3651d1556a Mon Sep 17 00:00:00 2001
From: Weibin Liu <liuwb@xiaopeng.com>
Date: Fri, 16 Oct 2026 10:00:36 +0800
Subject: [PATCH] spi: spi-pci1xxxx: quiesce DMA engines on transfer timeout

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
Link: https://patch.msgid.link/20261016020036.1333548-1-liuwb@xiaopeng.com
Signed-off-by: Mark Brown <broonie@kernel.org>

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

