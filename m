Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD6D55C319
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 13:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874286; cv=none; b=rDxdudzuKTAq0WNUgl/IRxGMQBGjtKevsVGgZEdz+/u348FrzrA1+rW6ahmDuXKqgDy4bGhnlDJzu2upMn8zXHsJnOTaic5j+iUMU2Ou2P+53L8+g1T4LxkfTmeEfSd3YM7MFr/72jI8fzP/fyy1wqMSRctCccddJGZL943OtSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874286; c=relaxed/simple;
	bh=ai+i4smxAB/1WEUzTtZXlzGusqAqjfAXWjLanlRv700=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YhQqXUP9f4xCUpZI5ASKI1Cia7WjnMd5gwaaF2UsHtk+iicNrcSn+hakvtPIV5kHM+lbMxx8iwZLtfCNVvd8TN2mBifNguXKT3Zkjf6DySszMdsFdWqrhojcXiWUh4ke1kSiHndsIZhwBoxpIVdM+e5d0sm9r0vk1Tr/8p3Q9wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BJDj3jX9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BJDj3jX9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778201F00ACF;
	Tue,  8 Sep 2026 13:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788874253;
	bh=UHwtjwp3j8+iZSO8QSmmAD+Jx0+LxHh9NSghgWFkW1s=;
	h=Subject:To:Cc:From:Date;
	b=BJDj3jX9GYL4NwtL4mZphQ2GJ8DFly7aPARff+Glu2lPZuoruqL4QJXexT+cjUcll
	 rRauwjjOTl6n4orRkY2XBEiz3SH9kEKjEWzEZjVFxupmidGV2ZJ4Au/IdvGqC/1Hdm
	 sWzxxeHDYCaE+vd/427oaYHU0V96T70tawoQWo6o=
Subject: FAILED: patch "[PATCH] dmaengine: dw-edma: Initialize IRQ data before requesting" failed to apply to 5.10-stable tree
To: den@valinux.co.jp,Frank.Li@nxp.com,vkoul@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 15:21:52 +0200
Message-ID: <2026090852-humble-naturist-e0d0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 647217abea849d3d45f8cb0b8ee5b78d50f26985
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090852-humble-naturist-e0d0@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 647217abea849d3d45f8cb0b8ee5b78d50f26985 Mon Sep 17 00:00:00 2001
From: Koichiro Den <den@valinux.co.jp>
Date: Tue, 21 Jul 2026 15:28:05 +0900
Subject: [PATCH] dmaengine: dw-edma: Initialize IRQ data before requesting
 IRQs

dw_edma_irq_request() passes struct dw_edma_irq to request_irq() before
dw_edma_channel_setup() fills the back pointer. A shared interrupt can
therefore enter the handler with dw_irq->dw still NULL, leading to a
NULL pointer dereference.

Set the back pointer before installing each handler.

Fixes: e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
Link: https://patch.msgid.link/20260721062815.4117887-5-den@valinux.co.jp
Signed-off-by: Vinod Koul <vkoul@kernel.org>

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 3a8610862cff..ee9a8c32adf4 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -969,7 +969,6 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 		else
 			bitmap_set(irq->rd_mask, chan->id, 1);
 
-		irq->dw = dw;
 		memcpy(&chan->msi, &irq->msi, sizeof(chan->msi));
 
 		dev_vdbg(dev, "MSI:\t\tChannel %s[%u] addr=0x%.8x%.8x, data=0x%.8x\n",
@@ -1051,6 +1050,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
 	if (chip->nr_irqs == 1) {
 		/* Common IRQ shared among all channels */
 		irq = chip->ops->irq_vector(dev, 0);
+		dw->irq[0].dw = dw;
 		err = request_irq(irq, dw_edma_interrupt_common,
 				  IRQF_SHARED, dw->name, &dw->irq[0]);
 		if (err) {
@@ -1073,6 +1073,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
 
 		for (i = 0; i < (*wr_alloc + *rd_alloc); i++) {
 			irq = chip->ops->irq_vector(dev, i);
+			dw->irq[i].dw = dw;
 			err = request_irq(irq,
 					  i < *wr_alloc ?
 						dw_edma_interrupt_write :

