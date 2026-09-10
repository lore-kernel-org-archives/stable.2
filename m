Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA279484235
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 14:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789052209; cv=none; b=CVLW7HbMf+lC8KCxDoDbjAB6KU2Intes7WvfjroO6QXJjOcfhjZSnj9GhSpr2WFFeIAOAlrEPz51ucQnStGaWfBf3X28ksAGFQHE/fsCs3fm46FFyFg81wipLFnszzXxh5pOxQapyx5UQVhUbHVY0wLzH5PNzUqK7XzFdf/olpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789052209; c=relaxed/simple;
	bh=Upa2JgnxqmJ5H5bnfMxnzwCtyf7/gVQjYLuaFOVtxSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EtiXg05kQZHLf9Xaa+n3E/pJWQa0JN7gs327XHDvTUiIL/GkwAQo2FJxUILyvT4tZiP4KBeyTpdRYhnZYQ53ZJH6rvRRJyX7wbOPn8pUmEuG9mEbS67XRLGzTUrQKcUcQq7Y1JrbUFCbNojD80kwIfAuWcA6rXphh8iYqXkeZwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFcojfBz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFcojfBz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8431F1F000FF;
	Thu, 10 Sep 2026 14:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789052207;
	bh=DmIktePL3QEsttijBV8bYB5rVaNIuwVzIiGKZJrnFDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iFcojfBzO8EnJFpyoP6Iof9vb18lj0CkK1FWj1oy5LqfhdussZOYobi6AbWPT6IBq
	 qeOMqOc4SaTxqSwMCz+8vNl8SmjRDjsFI1tcCX27WBvrIgfTGNdY2FtW38fQKC4ccS
	 FLwUrsVGOuX9WKPKVTOHQzMTG3JcYTW02Iy31I1/0hN9vFYXgKF51SLGhLWcJPhZAn
	 edYeY1TVVC8934evaHk+qroEN+gr0Pweo4hNYwGknQj2fkNBWZhH770Qqukua7k1P0
	 ejqL5C1FeBZ9ZeLVV38JJwUxd46xwcdT5NWofhatkfBToXiomjy/vK8M/aNAPPkM4d
	 68q7Cjrcg3Daw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] dmaengine: dw-edma: Detach the private data and chip info structures
Date: Thu, 10 Sep 2026 10:56:44 -0400
Message-ID: <20260910145645.833070-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090852-humble-naturist-e0d0@gregkh>
References: <2026090852-humble-naturist-e0d0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Li <Frank.Li@nxp.com>

[ Upstream commit 203184571388a988283543f0fd7da1a0da7c3f91 ]

"struct dw_edma_chip" contains an internal structure "struct dw_edma" that
is used by the eDMA core internally and should not be touched by the eDMA
controller drivers themselves. But currently, the eDMA controller drivers
like "dw-edma-pci" allocate and populate this internal structure before
passing it on to the eDMA core. The eDMA core further populates the
structure and uses it. This is wrong!

Hence, move all the "struct dw_edma" specifics from controller drivers to
the eDMA core.

Link: https://lore.kernel.org/r/20220524152159.2370739-3-Frank.Li@nxp.com
Tested-by: Serge Semin <fancer.lancer@gmail.com>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-By: Vinod Koul <vkoul@kernel.org>

[5.10 dependency adaptation for 647217abea849]
Move controller configuration and IRQ-vector operations into dw_edma_chip,
and allocate the private dw_edma and IRQ array in the core as upstream.
Use the stable tree's existing chan->dw and dw->chip back pointers, and
replace its dw->core accesses with chip->ops.

Keep the 5.10 version/mode representation, static PCI platform data, and
register BAR offsets and size. Preserve the existing shared-register
locking and global debugfs teardown; pass the private dw pointer only to
the existing debugfs setup callbacks. Drop hunks for absent HDMA support,
64-bit register accessors, and per-controller debugfs state. No functions
are added.

Leave IRQ back-pointer initialization in channel setup for the target
commit to move before request_irq(). The unchanged target applies cleanly
with Git's three-way merge.

Stable-dep-of: 647217abea84 ("dmaengine: dw-edma: Initialize IRQ data before requesting IRQs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/dw-edma/dw-edma-core.c       | 87 +++++++++++++-----------
 drivers/dma/dw-edma/dw-edma-core.h       | 29 --------
 drivers/dma/dw-edma/dw-edma-pcie.c       | 79 +++++++++------------
 drivers/dma/dw-edma/dw-edma-v0-core.c    | 20 +++---
 drivers/dma/dw-edma/dw-edma-v0-core.h    |  2 +-
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 16 ++---
 drivers/dma/dw-edma/dw-edma-v0-debugfs.h |  4 +-
 include/linux/dma/edma.h                 | 49 ++++++++++++-
 8 files changed, 149 insertions(+), 137 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 3830e9e989dd0..af3c551825cf1 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -64,8 +64,8 @@ static struct dw_edma_burst *dw_edma_alloc_burst(struct dw_edma_chunk *chunk)
 
 static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
 {
+	struct dw_edma_chip *chip = desc->chan->dw->chip;
 	struct dw_edma_chan *chan = desc->chan;
-	struct dw_edma *dw = chan->chip->dw;
 	struct dw_edma_chunk *chunk;
 
 	chunk = kzalloc(sizeof(*chunk), GFP_NOWAIT);
@@ -82,11 +82,11 @@ static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
 	 */
 	chunk->cb = !(desc->chunks_alloc % 2);
 	if (chan->dir == EDMA_DIR_WRITE) {
-		chunk->ll_region.paddr = dw->ll_region_wr[chan->id].paddr;
-		chunk->ll_region.vaddr = dw->ll_region_wr[chan->id].vaddr;
+		chunk->ll_region.paddr = chip->ll_region_wr[chan->id].paddr;
+		chunk->ll_region.vaddr = chip->ll_region_wr[chan->id].vaddr;
 	} else {
-		chunk->ll_region.paddr = dw->ll_region_rd[chan->id].paddr;
-		chunk->ll_region.vaddr = dw->ll_region_rd[chan->id].vaddr;
+		chunk->ll_region.paddr = chip->ll_region_rd[chan->id].paddr;
+		chunk->ll_region.vaddr = chip->ll_region_rd[chan->id].vaddr;
 	}
 
 	if (desc->chunk) {
@@ -642,7 +642,7 @@ static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
 	if (chan->status != EDMA_ST_IDLE)
 		return -EBUSY;
 
-	pm_runtime_get(chan->chip->dev);
+	pm_runtime_get(chan->dw->chip->dev);
 
 	return 0;
 }
@@ -664,15 +664,15 @@ static void dw_edma_free_chan_resources(struct dma_chan *dchan)
 		cpu_relax();
 	}
 
-	pm_runtime_put(chan->chip->dev);
+	pm_runtime_put(chan->dw->chip->dev);
 }
 
-static int dw_edma_channel_setup(struct dw_edma_chip *chip, bool write,
+static int dw_edma_channel_setup(struct dw_edma *dw, bool write,
 				 u32 wr_alloc, u32 rd_alloc)
 {
+	struct dw_edma_chip *chip = dw->chip;
 	struct dw_edma_region *dt_region;
 	struct device *dev = chip->dev;
-	struct dw_edma *dw = chip->dw;
 	struct dw_edma_chan *chan;
 	struct dw_edma_irq *irq;
 	struct dma_device *dma;
@@ -705,7 +705,6 @@ static int dw_edma_channel_setup(struct dw_edma_chip *chip, bool write,
 
 		chan->vc.chan.private = dt_region;
 
-		chan->chip = chip;
 		chan->dw = dw;
 		chan->id = j;
 		chan->dir = write ? EDMA_DIR_WRITE : EDMA_DIR_READ;
@@ -714,9 +713,9 @@ static int dw_edma_channel_setup(struct dw_edma_chip *chip, bool write,
 		chan->status = EDMA_ST_IDLE;
 
 		if (write)
-			chan->ll_max = (dw->ll_region_wr[j].sz / EDMA_LL_SZ);
+			chan->ll_max = (chip->ll_region_wr[j].sz / EDMA_LL_SZ);
 		else
-			chan->ll_max = (dw->ll_region_rd[j].sz / EDMA_LL_SZ);
+			chan->ll_max = (chip->ll_region_rd[j].sz / EDMA_LL_SZ);
 		chan->ll_max -= 1;
 
 		dev_vdbg(dev, "L. List:\tChannel %s[%u] max_cnt=%u\n",
@@ -746,13 +745,13 @@ static int dw_edma_channel_setup(struct dw_edma_chip *chip, bool write,
 		vchan_init(&chan->vc, dma);
 
 		if (write) {
-			dt_region->paddr = dw->dt_region_wr[j].paddr;
-			dt_region->vaddr = dw->dt_region_wr[j].vaddr;
-			dt_region->sz = dw->dt_region_wr[j].sz;
+			dt_region->paddr = chip->dt_region_wr[j].paddr;
+			dt_region->vaddr = chip->dt_region_wr[j].vaddr;
+			dt_region->sz = chip->dt_region_wr[j].sz;
 		} else {
-			dt_region->paddr = dw->dt_region_rd[j].paddr;
-			dt_region->vaddr = dw->dt_region_rd[j].vaddr;
-			dt_region->sz = dw->dt_region_rd[j].sz;
+			dt_region->paddr = chip->dt_region_rd[j].paddr;
+			dt_region->vaddr = chip->dt_region_rd[j].vaddr;
+			dt_region->sz = chip->dt_region_rd[j].sz;
 		}
 
 		dw_edma_v0_core_device_config(chan);
@@ -804,11 +803,11 @@ static inline void dw_edma_add_irq_mask(u32 *mask, u32 alloc, u16 cnt)
 		(*mask)++;
 }
 
-static int dw_edma_irq_request(struct dw_edma_chip *chip,
+static int dw_edma_irq_request(struct dw_edma *dw,
 			       u32 *wr_alloc, u32 *rd_alloc)
 {
-	struct device *dev = chip->dev;
-	struct dw_edma *dw = chip->dw;
+	struct dw_edma_chip *chip = dw->chip;
+	struct device *dev = dw->chip->dev;
 	u32 wr_mask = 1;
 	u32 rd_mask = 1;
 	int i, err = 0;
@@ -817,12 +816,16 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
 
 	ch_cnt = dw->wr_ch_cnt + dw->rd_ch_cnt;
 
-	if (dw->nr_irqs < 1)
+	if (chip->nr_irqs < 1 || !chip->ops->irq_vector)
 		return -EINVAL;
 
-	if (dw->nr_irqs == 1) {
+	dw->irq = devm_kcalloc(dev, chip->nr_irqs, sizeof(*dw->irq), GFP_KERNEL);
+	if (!dw->irq)
+		return -ENOMEM;
+
+	if (chip->nr_irqs == 1) {
 		/* Common IRQ shared among all channels */
-		irq = dw->core->irq_vector(dev, 0);
+		irq = chip->ops->irq_vector(dev, 0);
 		err = request_irq(irq, dw_edma_interrupt_common,
 				  IRQF_SHARED, dw->name, &dw->irq[0]);
 		if (err) {
@@ -832,9 +835,11 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
 
 		if (irq_get_msi_desc(irq))
 			get_cached_msi_msg(irq, &dw->irq[0].msi);
+
+		dw->nr_irqs = 1;
 	} else {
 		/* Distribute IRQs equally among all channels */
-		int tmp = dw->nr_irqs;
+		int tmp = chip->nr_irqs;
 
 		while (tmp && (*wr_alloc + *rd_alloc) < ch_cnt) {
 			dw_edma_dec_irq_alloc(&tmp, wr_alloc, dw->wr_ch_cnt);
@@ -845,7 +850,7 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
 		dw_edma_add_irq_mask(&rd_mask, *rd_alloc, dw->rd_ch_cnt);
 
 		for (i = 0; i < (*wr_alloc + *rd_alloc); i++) {
-			irq = dw->core->irq_vector(dev, i);
+			irq = chip->ops->irq_vector(dev, i);
 			err = request_irq(irq,
 					  i < *wr_alloc ?
 						dw_edma_interrupt_write :
@@ -879,20 +884,22 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 		return -EINVAL;
 
 	dev = chip->dev;
-	if (!dev)
+	if (!dev || !chip->ops)
 		return -EINVAL;
 
-	dw = chip->dw;
-	if (!dw || !dw->irq || !dw->core || !dw->core->irq_vector)
-		return -EINVAL;
+	dw = devm_kzalloc(dev, sizeof(*dw), GFP_KERNEL);
+	if (!dw)
+		return -ENOMEM;
+
+	dw->chip = chip;
 
 	raw_spin_lock_init(&dw->lock);
 
-	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt,
+	dw->wr_ch_cnt = min_t(u16, chip->wr_ch_cnt,
 			      dw_edma_v0_core_ch_count(dw, EDMA_DIR_WRITE));
 	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, EDMA_MAX_WR_CH);
 
-	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt,
+	dw->rd_ch_cnt = min_t(u16, chip->rd_ch_cnt,
 			      dw_edma_v0_core_ch_count(dw, EDMA_DIR_READ));
 	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, EDMA_MAX_RD_CH);
 
@@ -914,17 +921,17 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 	dw_edma_v0_core_off(dw);
 
 	/* Request IRQs */
-	err = dw_edma_irq_request(chip, &wr_alloc, &rd_alloc);
+	err = dw_edma_irq_request(dw, &wr_alloc, &rd_alloc);
 	if (err)
 		return err;
 
 	/* Setup write channels */
-	err = dw_edma_channel_setup(chip, true, wr_alloc, rd_alloc);
+	err = dw_edma_channel_setup(dw, true, wr_alloc, rd_alloc);
 	if (err)
 		goto err_irq_free;
 
 	/* Setup read channels */
-	err = dw_edma_channel_setup(chip, false, wr_alloc, rd_alloc);
+	err = dw_edma_channel_setup(dw, false, wr_alloc, rd_alloc);
 	if (err)
 		goto err_irq_free;
 
@@ -932,15 +939,15 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 	pm_runtime_enable(dev);
 
 	/* Turn debugfs on */
-	dw_edma_v0_core_debugfs_on(chip);
+	dw_edma_v0_core_debugfs_on(dw);
+
+	chip->dw = dw;
 
 	return 0;
 
 err_irq_free:
 	for (i = (dw->nr_irqs - 1); i >= 0; i--)
-		free_irq(dw->core->irq_vector(dev, i), &dw->irq[i]);
-
-	dw->nr_irqs = 0;
+		free_irq(chip->ops->irq_vector(dev, i), &dw->irq[i]);
 
 	return err;
 }
@@ -958,7 +965,7 @@ int dw_edma_remove(struct dw_edma_chip *chip)
 
 	/* Free irqs */
 	for (i = (dw->nr_irqs - 1); i >= 0; i--)
-		free_irq(dw->core->irq_vector(dev, i), &dw->irq[i]);
+		free_irq(chip->ops->irq_vector(dev, i), &dw->irq[i]);
 
 	/* Power management */
 	pm_runtime_disable(dev);
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index e9d1991076687..78a6cc7cd11c0 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -15,19 +15,12 @@
 #include "../virt-dma.h"
 
 #define EDMA_LL_SZ					24
-#define EDMA_MAX_WR_CH					8
-#define EDMA_MAX_RD_CH					8
 
 enum dw_edma_dir {
 	EDMA_DIR_WRITE = 0,
 	EDMA_DIR_READ
 };
 
-enum dw_edma_mode {
-	EDMA_MODE_LEGACY = 0,
-	EDMA_MODE_UNROLL
-};
-
 enum dw_edma_request {
 	EDMA_REQ_NONE = 0,
 	EDMA_REQ_STOP,
@@ -51,12 +44,6 @@ struct dw_edma_burst {
 	u32				sz;
 };
 
-struct dw_edma_region {
-	phys_addr_t			paddr;
-	void				__iomem *vaddr;
-	size_t				sz;
-};
-
 struct dw_edma_chunk {
 	struct list_head		list;
 	struct dw_edma_chan		*chan;
@@ -81,7 +68,6 @@ struct dw_edma_desc {
 
 struct dw_edma_chan {
 	struct virt_dma_chan		vc;
-	struct dw_edma_chip		*chip;
 	struct dw_edma			*dw;
 	int				id;
 	enum dw_edma_dir		dir;
@@ -104,10 +90,6 @@ struct dw_edma_irq {
 	struct dw_edma			*dw;
 };
 
-struct dw_edma_core_ops {
-	int	(*irq_vector)(struct device *dev, unsigned int nr);
-};
-
 struct dw_edma {
 	char				name[20];
 
@@ -117,25 +99,14 @@ struct dw_edma {
 	struct dma_device		rd_edma;
 	u16				rd_ch_cnt;
 
-	struct dw_edma_region		rg_region;	/* Registers */
-	struct dw_edma_region		ll_region_wr[EDMA_MAX_WR_CH];
-	struct dw_edma_region		ll_region_rd[EDMA_MAX_RD_CH];
-	struct dw_edma_region		dt_region_wr[EDMA_MAX_WR_CH];
-	struct dw_edma_region		dt_region_rd[EDMA_MAX_RD_CH];
-
 	struct dw_edma_irq		*irq;
 	int				nr_irqs;
 
-	u32				version;
-	enum dw_edma_mode		mode;
-
 	struct dw_edma_chan		*chan;
 
 	raw_spinlock_t			lock;		/* Protect v0 shared registers */
 
 	struct dw_edma_chip             *chip;
-
-	const struct dw_edma_core_ops	*core;
 };
 
 struct dw_edma_sg {
diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 987ede1087ddd..f70fe7fd4e18c 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -14,8 +14,6 @@
 #include <linux/pci-epf.h>
 #include <linux/msi.h>
 
-#include "dw-edma-core.h"
-
 #define DW_BLOCK(a, b, c) \
 	{ \
 		.bar = a, \
@@ -101,7 +99,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	struct device *dev = &pdev->dev;
 	struct dw_edma_chip *chip;
 	int err, nr_irqs;
-	struct dw_edma *dw;
 	int i, mask;
 
 	/* Enable PCI device */
@@ -158,10 +155,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	if (!chip)
 		return -ENOMEM;
 
-	dw = devm_kzalloc(dev, sizeof(*dw), GFP_KERNEL);
-	if (!dw)
-		return -ENOMEM;
-
 	/* IRQs allocation */
 	nr_irqs = pci_alloc_irq_vectors(pdev, 1, pdata->irqs,
 					PCI_IRQ_MSI | PCI_IRQ_MSIX);
@@ -172,27 +165,25 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	}
 
 	/* Data structure initialization */
-	chip->dw = dw;
 	chip->dev = dev;
 	chip->id = pdev->devfn;
 
-	dw->chip = chip;
-	dw->version = pdata->version;
-	dw->mode = pdata->mode;
-	dw->nr_irqs = nr_irqs;
-	dw->core = &dw_edma_pcie_core_ops;
-	dw->wr_ch_cnt = pdata->wr_ch_cnt;
-	dw->rd_ch_cnt = pdata->rd_ch_cnt;
-
-	dw->rg_region.vaddr = pcim_iomap_table(pdev)[pdata->rg.bar];
-	dw->rg_region.vaddr += pdata->rg.off;
-	dw->rg_region.paddr = pdev->resource[pdata->rg.bar].start;
-	dw->rg_region.paddr += pdata->rg.off;
-	dw->rg_region.sz = pdata->rg.sz;
-
-	for (i = 0; i < dw->wr_ch_cnt; i++) {
-		struct dw_edma_region *ll_region = &dw->ll_region_wr[i];
-		struct dw_edma_region *dt_region = &dw->dt_region_wr[i];
+	chip->version = pdata->version;
+	chip->mode = pdata->mode;
+	chip->nr_irqs = nr_irqs;
+	chip->ops = &dw_edma_pcie_core_ops;
+	chip->wr_ch_cnt = pdata->wr_ch_cnt;
+	chip->rd_ch_cnt = pdata->rd_ch_cnt;
+
+	chip->rg_region.vaddr = pcim_iomap_table(pdev)[pdata->rg.bar];
+	chip->rg_region.vaddr += pdata->rg.off;
+	chip->rg_region.paddr = pdev->resource[pdata->rg.bar].start;
+	chip->rg_region.paddr += pdata->rg.off;
+	chip->rg_region.sz = pdata->rg.sz;
+
+	for (i = 0; i < chip->wr_ch_cnt; i++) {
+		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
+		struct dw_edma_region *dt_region = &chip->dt_region_wr[i];
 		const struct dw_edma_block *ll_block = &pdata->ll_wr[i];
 		const struct dw_edma_block *dt_block = &pdata->dt_wr[i];
 
@@ -209,9 +200,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		dt_region->sz = dt_block->sz;
 	}
 
-	for (i = 0; i < dw->rd_ch_cnt; i++) {
-		struct dw_edma_region *ll_region = &dw->ll_region_rd[i];
-		struct dw_edma_region *dt_region = &dw->dt_region_rd[i];
+	for (i = 0; i < chip->rd_ch_cnt; i++) {
+		struct dw_edma_region *ll_region = &chip->ll_region_rd[i];
+		struct dw_edma_region *dt_region = &chip->dt_region_rd[i];
 		const struct dw_edma_block *ll_block = &pdata->ll_rd[i];
 		const struct dw_edma_block *dt_block = &pdata->dt_rd[i];
 
@@ -229,40 +220,40 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	}
 
 	/* Debug info */
-	pci_dbg(pdev, "Version:\t%u\n", dw->version);
+	pci_dbg(pdev, "Version:\t%u\n", chip->version);
 
 	pci_dbg(pdev, "Mode:\t%s\n",
-		dw->mode == EDMA_MODE_LEGACY ? "Legacy" : "Unroll");
+		chip->mode == EDMA_MODE_LEGACY ? "Legacy" : "Unroll");
 
 	pci_dbg(pdev, "Registers:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
 		pdata->rg.bar, pdata->rg.off, pdata->rg.sz,
-		dw->rg_region.vaddr, &dw->rg_region.paddr);
+		chip->rg_region.vaddr, &chip->rg_region.paddr);
 
-	for (i = 0; i < dw->wr_ch_cnt; i++) {
+	for (i = 0; i < chip->wr_ch_cnt; i++) {
 		pci_dbg(pdev, "L. List:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
 			i, pdata->ll_wr[i].bar, pdata->ll_wr[i].off,
-			dw->ll_region_wr[i].sz, dw->ll_region_wr[i].vaddr,
-			&dw->ll_region_wr[i].paddr);
+			chip->ll_region_wr[i].sz, chip->ll_region_wr[i].vaddr,
+			&chip->ll_region_wr[i].paddr);
 
 		pci_dbg(pdev, "Data:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
 			i, pdata->dt_wr[i].bar, pdata->dt_wr[i].off,
-			dw->dt_region_wr[i].sz, dw->dt_region_wr[i].vaddr,
-			&dw->dt_region_wr[i].paddr);
+			chip->dt_region_wr[i].sz, chip->dt_region_wr[i].vaddr,
+			&chip->dt_region_wr[i].paddr);
 	}
 
-	for (i = 0; i < dw->rd_ch_cnt; i++) {
+	for (i = 0; i < chip->rd_ch_cnt; i++) {
 		pci_dbg(pdev, "L. List:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
 			i, pdata->ll_rd[i].bar, pdata->ll_rd[i].off,
-			dw->ll_region_rd[i].sz, dw->ll_region_rd[i].vaddr,
-			&dw->ll_region_rd[i].paddr);
+			chip->ll_region_rd[i].sz, chip->ll_region_rd[i].vaddr,
+			&chip->ll_region_rd[i].paddr);
 
 		pci_dbg(pdev, "Data:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
 			i, pdata->dt_rd[i].bar, pdata->dt_rd[i].off,
-			dw->dt_region_rd[i].sz, dw->dt_region_rd[i].vaddr,
-			&dw->dt_region_rd[i].paddr);
+			chip->dt_region_rd[i].sz, chip->dt_region_rd[i].vaddr,
+			&chip->dt_region_rd[i].paddr);
 	}
 
-	pci_dbg(pdev, "Nr. IRQs:\t%u\n", dw->nr_irqs);
+	pci_dbg(pdev, "Nr. IRQs:\t%u\n", chip->nr_irqs);
 
 	/* Validating if PCI interrupts were enabled */
 	if (!pci_dev_msi_enabled(pdev)) {
@@ -270,10 +261,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		return -EPERM;
 	}
 
-	dw->irq = devm_kcalloc(dev, nr_irqs, sizeof(*dw->irq), GFP_KERNEL);
-	if (!dw->irq)
-		return -ENOMEM;
-
 	/* Starting eDMA driver */
 	err = dw_edma_probe(chip);
 	if (err) {
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index b021f6d96430c..f1372a2effdca 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -25,7 +25,7 @@ enum dw_edma_control {
 
 static inline struct dw_edma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
 {
-	return dw->rg_region.vaddr;
+	return dw->chip->rg_region.vaddr;
 }
 
 #define SET(dw, name, value)				\
@@ -56,7 +56,7 @@ static inline struct dw_edma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
 static inline struct dw_edma_v0_ch_regs __iomem *
 __dw_ch_regs(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch)
 {
-	if (dw->mode == EDMA_MODE_LEGACY)
+	if (dw->chip->mode == EDMA_MODE_LEGACY)
 		return &(__dw_regs(dw)->type.legacy.ch);
 
 	if (dir == EDMA_DIR_WRITE)
@@ -68,7 +68,7 @@ __dw_ch_regs(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch)
 static inline void writel_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 			     u32 value, void __iomem *addr)
 {
-	if (dw->mode == EDMA_MODE_LEGACY) {
+	if (dw->chip->mode == EDMA_MODE_LEGACY) {
 		u32 viewport_sel;
 		unsigned long flags;
 
@@ -93,7 +93,7 @@ static inline u32 readl_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 {
 	u32 value;
 
-	if (dw->mode == EDMA_MODE_LEGACY) {
+	if (dw->chip->mode == EDMA_MODE_LEGACY) {
 		u32 viewport_sel;
 		unsigned long flags;
 
@@ -149,7 +149,7 @@ u16 dw_edma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
 
 enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan)
 {
-	struct dw_edma *dw = chan->chip->dw;
+	struct dw_edma *dw = chan->dw;
 	u32 tmp;
 
 	tmp = FIELD_GET(EDMA_V0_CH_STATUS_MASK,
@@ -165,7 +165,7 @@ enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan)
 
 void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan)
 {
-	struct dw_edma *dw = chan->chip->dw;
+	struct dw_edma *dw = chan->dw;
 
 	SET_RW_32(dw, chan->dir, int_clear,
 		  FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id)));
@@ -173,7 +173,7 @@ void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan)
 
 void dw_edma_v0_core_clear_abort_int(struct dw_edma_chan *chan)
 {
-	struct dw_edma *dw = chan->chip->dw;
+	struct dw_edma *dw = chan->dw;
 
 	SET_RW_32(dw, chan->dir, int_clear,
 		  FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id)));
@@ -275,7 +275,7 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 
 int dw_edma_v0_core_device_config(struct dw_edma_chan *chan)
 {
-	struct dw_edma *dw = chan->chip->dw;
+	struct dw_edma *dw = chan->dw;
 	u32 tmp = 0;
 
 	/* MSI done addr - low, high */
@@ -345,9 +345,9 @@ int dw_edma_v0_core_device_config(struct dw_edma_chan *chan)
 }
 
 /* eDMA debugfs callbacks */
-void dw_edma_v0_core_debugfs_on(struct dw_edma_chip *chip)
+void dw_edma_v0_core_debugfs_on(struct dw_edma *dw)
 {
-	dw_edma_v0_debugfs_on(chip);
+	dw_edma_v0_debugfs_on(dw);
 }
 
 void dw_edma_v0_core_debugfs_off(void)
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.h b/drivers/dma/dw-edma/dw-edma-v0-core.h
index abae1527f1f9b..5f13c3c09a459 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.h
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.h
@@ -22,7 +22,7 @@ u32 dw_edma_v0_core_status_abort_int(struct dw_edma *chan, enum dw_edma_dir dir)
 void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first);
 int dw_edma_v0_core_device_config(struct dw_edma_chan *chan);
 /* eDMA debug fs callbacks */
-void dw_edma_v0_core_debugfs_on(struct dw_edma_chip *chip);
+void dw_edma_v0_core_debugfs_on(struct dw_edma *dw);
 void dw_edma_v0_core_debugfs_off(void);
 
 #endif /* _DW_EDMA_V0_CORE_H */
diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
index 6f62711a4c949..39677a91a7637 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
@@ -55,7 +55,7 @@ struct debugfs_entries {
 static int dw_edma_debugfs_u32_get(void *data, u64 *val)
 {
 	void __iomem *reg = (void __force __iomem *)data;
-	if (dw->mode == EDMA_MODE_LEGACY &&
+	if (dw->chip->mode == EDMA_MODE_LEGACY &&
 	    reg >= (void __iomem *)&regs->type.legacy.ch) {
 		void __iomem *ptr = &regs->type.legacy.ch;
 		u32 viewport_sel = 0;
@@ -174,7 +174,7 @@ static void dw_edma_debugfs_regs_wr(struct dentry *dir)
 	nr_entries = ARRAY_SIZE(debugfs_regs);
 	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dir);
 
-	if (dw->mode == EDMA_MODE_UNROLL) {
+	if (dw->chip->mode == EDMA_MODE_UNROLL) {
 		nr_entries = ARRAY_SIZE(debugfs_unroll_regs);
 		dw_edma_debugfs_create_x32(debugfs_unroll_regs, nr_entries,
 					   regs_dir);
@@ -243,7 +243,7 @@ static void dw_edma_debugfs_regs_rd(struct dentry *dir)
 	nr_entries = ARRAY_SIZE(debugfs_regs);
 	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dir);
 
-	if (dw->mode == EDMA_MODE_UNROLL) {
+	if (dw->chip->mode == EDMA_MODE_UNROLL) {
 		nr_entries = ARRAY_SIZE(debugfs_unroll_regs);
 		dw_edma_debugfs_create_x32(debugfs_unroll_regs, nr_entries,
 					   regs_dir);
@@ -283,13 +283,13 @@ static void dw_edma_debugfs_regs(void)
 	dw_edma_debugfs_regs_rd(regs_dir);
 }
 
-void dw_edma_v0_debugfs_on(struct dw_edma_chip *chip)
+void dw_edma_v0_debugfs_on(struct dw_edma *_dw)
 {
-	dw = chip->dw;
+	dw = _dw;
 	if (!dw)
 		return;
 
-	regs = dw->rg_region.vaddr;
+	regs = dw->chip->rg_region.vaddr;
 	if (!regs)
 		return;
 
@@ -297,8 +297,8 @@ void dw_edma_v0_debugfs_on(struct dw_edma_chip *chip)
 	if (!base_dir)
 		return;
 
-	debugfs_create_u32("version", 0444, base_dir, &dw->version);
-	debugfs_create_u32("mode", 0444, base_dir, &dw->mode);
+	debugfs_create_u32("version", 0444, base_dir, &dw->chip->version);
+	debugfs_create_u32("mode", 0444, base_dir, &dw->chip->mode);
 	debugfs_create_u16("wr_ch_cnt", 0444, base_dir, &dw->wr_ch_cnt);
 	debugfs_create_u16("rd_ch_cnt", 0444, base_dir, &dw->rd_ch_cnt);
 
diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.h b/drivers/dma/dw-edma/dw-edma-v0-debugfs.h
index 5450a0a941938..6f10485523bdc 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.h
+++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.h
@@ -12,10 +12,10 @@
 #include <linux/dma/edma.h>
 
 #ifdef CONFIG_DEBUG_FS
-void dw_edma_v0_debugfs_on(struct dw_edma_chip *chip);
+void dw_edma_v0_debugfs_on(struct dw_edma *dw);
 void dw_edma_v0_debugfs_off(void);
 #else
-static inline void dw_edma_v0_debugfs_on(struct dw_edma_chip *chip)
+static inline void dw_edma_v0_debugfs_on(struct dw_edma *dw)
 {
 }
 
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index d4333e721588d..19007c0a26d7f 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -12,17 +12,64 @@
 #include <linux/device.h>
 #include <linux/dmaengine.h>
 
+#define EDMA_MAX_WR_CH                                  8
+#define EDMA_MAX_RD_CH                                  8
+
 struct dw_edma;
 
+struct dw_edma_region {
+	phys_addr_t	paddr;
+	void __iomem	*vaddr;
+	size_t		sz;
+};
+
+struct dw_edma_core_ops {
+	int (*irq_vector)(struct device *dev, unsigned int nr);
+};
+
+enum dw_edma_mode {
+	EDMA_MODE_LEGACY = 0,
+	EDMA_MODE_UNROLL
+};
+
 /**
  * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
  * @dev:		 struct device of the eDMA controller
  * @id:			 instance ID
- * @dw:			 struct dw_edma that is filed by dw_edma_probe()
+ * @nr_irqs:		 total number of DMA IRQs
+ * @ops:			 DMA channel to IRQ number mapping
+ * @wr_ch_cnt:		 DMA write channel number
+ * @rd_ch_cnt:		 DMA read channel number
+ * @rg_region:		 DMA register region
+ * @ll_region_wr:	 DMA descriptor link list memory for write channel
+ * @ll_region_rd:	 DMA descriptor link list memory for read channel
+ * @dt_region_wr:	 DMA data memory for write channel
+ * @dt_region_rd:	 DMA data memory for read channel
+ * @version:		 DMA controller version
+ * @mode:		 DMA register mode
+ * @dw:			 struct dw_edma that is filled by dw_edma_probe()
  */
 struct dw_edma_chip {
 	struct device		*dev;
 	int			id;
+	int			nr_irqs;
+	const struct dw_edma_core_ops   *ops;
+
+	struct dw_edma_region	rg_region;
+
+	u16			wr_ch_cnt;
+	u16			rd_ch_cnt;
+	/* link list address */
+	struct dw_edma_region	ll_region_wr[EDMA_MAX_WR_CH];
+	struct dw_edma_region	ll_region_rd[EDMA_MAX_RD_CH];
+
+	/* data region */
+	struct dw_edma_region	dt_region_wr[EDMA_MAX_WR_CH];
+	struct dw_edma_region	dt_region_rd[EDMA_MAX_RD_CH];
+
+	u32			version;
+	enum dw_edma_mode	mode;
+
 	struct dw_edma		*dw;
 };
 
-- 
2.53.0

