Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811723FFD
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 21:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785101305; cv=none; b=gVgvWwGOChOlL3Ya3tBXjgKVim0Bd+0833aIR4hE2Sc2cRNgCcpTmQDjx1NHil568IYS4zOiQ4IMj/8PrsxFhGEUObMppXPFOgeepqvoASax3wcuY/nxEreo6thnyvRBGsv0L+j8p+fZyKuAAtThCtn9EKMinzQsMHmu2xP8L3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785101305; c=relaxed/simple;
	bh=05OUwjzJ8mzxDhAmQClncBs3AKqoWHE60N8VSUfzOfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PGIuYYOovyaThGbq7kEf6Ik5c4TNspjPHEwTRrWc8EgVC3FqM79YzOAPtE1CmcQxSf2nu76KEj1A1zSvBW5qae3eAy2tmvsno1PrqxF2Qo9zdZFvpZ6Zdx9WN74xu6wjkRxrYMTonA6nNFK9cIRtB3slXZA1GMUpp+KAKYtzO2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajIE+x1a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajIE+x1a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91791F00A3A;
	Sun, 26 Jul 2026 21:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785101304;
	bh=GKzbSCsVXer5Gbod8+cjtlO6+j0lFenWrhcQRI4C2Gk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ajIE+x1athJzbu0A1V+U0ARM4d/F4c19+vKyr6ogQ8cDT1/JHSCPreaB6of4Cz0M+
	 +kHCswyjNsxXj3f7NAfTv4rHS6+zIjlYY4fxEo6XGFlfpNS9LkQw0n1KXj1tl66BMH
	 lTJFTdl3EoIAfqrU3BEld0pUvhPtv0KmmrOJL9IRoK3xmffTD2TxAh34xZH4R6VYTZ
	 bUVWg2TQk3y7IGPtRsCTjQcKvR9Ey1HTJ5TkU+G3OPY6zVBrQpvwK+BRr4PjBGKB+t
	 JDlKjrWB91UVQX0lduUhmg42iMT8rcdol35N+IpjFZTmoBVKQFWDkVqeaTld/XY1KN
	 OxEmBnLvgUgKw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>,
	Koichiro Den <den@valinux.co.jp>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/4] dmaengine: dw-edma: Add spinlock to protect DONE_INT_MASK and ABORT_INT_MASK
Date: Sun, 26 Jul 2026 17:28:19 -0400
Message-ID: <20260726212819.4022652-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260726212819.4022652-1-sashal@kernel.org>
References: <2026072058-sadly-hatchery-b25e@gregkh>
 <20260726212819.4022652-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Li <Frank.Li@nxp.com>

[ Upstream commit 8ffba0171c6bbce5f093c6dba5a02c0805b31203 ]

The DONE_INT_MASK and ABORT_INT_MASK registers are shared by all DMA
channels, and modifying them requires a read-modify-write sequence.
Because this operation is not atomic, concurrent calls to
dw_edma_v0_core_start() can introduce race conditions if two channels
update these registers simultaneously.

Add a spinlock to serialize access to these registers and prevent race
conditions.

Fixes: 7e4b8a4fbe2c ("dmaengine: Add Synopsys eDMA IP version 0 support")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Li <Frank.Li@nxp.com>
[den: update dw_edma.lock comment]
Link: https://lore.kernel.org/dmaengine/20260109-edma_ll-v2-1-5c0b27b2c664@nxp.com/
Signed-off-by: Koichiro Den <den@valinux.co.jp>
Link: https://patch.msgid.link/20260521142153.2957432-5-den@valinux.co.jp
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/dw-edma/dw-edma-core.h    | 2 +-
 drivers/dma/dw-edma/dw-edma-v0-core.c | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 29bb885aac6c26..e9d19910766870 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -131,7 +131,7 @@ struct dw_edma {
 
 	struct dw_edma_chan		*chan;
 
-	raw_spinlock_t			lock;		/* Only for legacy */
+	raw_spinlock_t			lock;		/* Protect v0 shared registers */
 
 	struct dw_edma_chip             *chip;
 
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 5ab27507bd3ea8..b021f6d96430cd 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -237,6 +237,7 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 {
 	struct dw_edma_chan *chan = chunk->chan;
 	struct dw_edma *dw = chan->dw;
+	unsigned long flags;
 	u32 tmp;
 
 	dw_edma_v0_core_write_chunk(chunk);
@@ -245,6 +246,8 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 		/* Enable engine */
 		SET_RW_32(dw, chan->dir, engine_en, BIT(0));
 		/* Interrupt unmask - done, abort */
+		raw_spin_lock_irqsave(&dw->lock, flags);
+
 		tmp = GET_RW_32(dw, chan->dir, int_mask);
 		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
 		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
@@ -253,6 +256,9 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
 		tmp |= FIELD_PREP(EDMA_V0_LINKED_LIST_ERR_MASK, BIT(chan->id));
 		SET_RW_32(dw, chan->dir, linked_list_err_en, tmp);
+
+		raw_spin_unlock_irqrestore(&dw->lock, flags);
+
 		/* Channel control */
 		SET_CH_32(dw, chan->dir, chan->id, ch_control1,
 			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
-- 
2.53.0

