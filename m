Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F7F4A64D4
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 14:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789052209; cv=none; b=FYxo2HlKSRm3YJSQfLr9SmGMJeGZToPHHawkvdqubJ9FdBbTGvUwNIAutjcLInLMVz5ota9swkigttQ7sh1WVN5+Gyn4QWmcZkkerBevrDYgGuG3JoQhzhZCDDLi1NX9gCWUsgi3PjYOVA9YUHIIUOZZwuvwJPeoL31038+XcNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789052209; c=relaxed/simple;
	bh=w0rWCLPsCgK5NXKMwMnmjt8Wiq697O17A07vmtLhMQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D9oIJT1ZOS5pEPaXUGWtwdNw8xMvQYXPZCPgjCYiMOy0DMeutemWFaESsjrvZfnH/JxR8L2aZ0fHM4AldUy9PKrbOCyA6DA9AyForDHj1cmI97uG7TrMFuaq31vTgq3nz5Nt5evIbjeZzdmyoWWIsJfx9eml/mv1IdqYZJR2Qf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ki4OWi/7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ki4OWi/7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB8C1F00893;
	Thu, 10 Sep 2026 14:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789052208;
	bh=rvw0XssWxsB3uuXRWOhx+NXC4nrr+2gee+v8mZaqnAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ki4OWi/7Yv/RHrZ6Qu/QbgvvqyzQIpIwa+Bpn+xVtCynr8FcL55uDRHwWgp5oiaUL
	 cH9aiZqzqFUCY4Vp23+xxzQ8M4PXVac4Hgq0uxAb5y0toH0/bzZjipDLhAg6bBIMxh
	 /IMCgyXczrUeHydMW80T39Uyh8m6r6eZB0qtjvlaLOknbJn3sSKkNcMB/I4WKmkUYh
	 RqI7mXvjivFiC2K8g2+8HLT/vVK0NheXBjxKKIt6QhvI/y5eD9RHLZCcN5R9CLCCFp
	 37I1+fAblmP5DfuNQ9RJzSFQr13HE8b3m9CLM3LucREp865TDkT4TxW6d/04lrsLhp
	 B/RJfXxAdaLPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Koichiro Den <den@valinux.co.jp>,
	Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] dmaengine: dw-edma: Initialize IRQ data before requesting IRQs
Date: Thu, 10 Sep 2026 10:56:45 -0400
Message-ID: <20260910145645.833070-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910145645.833070-1-sashal@kernel.org>
References: <2026090852-humble-naturist-e0d0@gregkh>
 <20260910145645.833070-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Koichiro Den <den@valinux.co.jp>

[ Upstream commit 647217abea849d3d45f8cb0b8ee5b78d50f26985 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/dw-edma/dw-edma-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index af3c551825cf1..176891050b4ed 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -733,7 +733,6 @@ static int dw_edma_channel_setup(struct dw_edma *dw, bool write,
 		else
 			irq->rd_mask |= BIT(j);
 
-		irq->dw = dw;
 		memcpy(&chan->msi, &irq->msi, sizeof(chan->msi));
 
 		dev_vdbg(dev, "MSI:\t\tChannel %s[%u] addr=0x%.8x%.8x, data=0x%.8x\n",
@@ -826,6 +825,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
 	if (chip->nr_irqs == 1) {
 		/* Common IRQ shared among all channels */
 		irq = chip->ops->irq_vector(dev, 0);
+		dw->irq[0].dw = dw;
 		err = request_irq(irq, dw_edma_interrupt_common,
 				  IRQF_SHARED, dw->name, &dw->irq[0]);
 		if (err) {
@@ -851,6 +851,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
 
 		for (i = 0; i < (*wr_alloc + *rd_alloc); i++) {
 			irq = chip->ops->irq_vector(dev, i);
+			dw->irq[i].dw = dw;
 			err = request_irq(irq,
 					  i < *wr_alloc ?
 						dw_edma_interrupt_write :
-- 
2.53.0

