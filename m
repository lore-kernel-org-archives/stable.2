Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3FB2BE644
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 12:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785069273; cv=none; b=OoG+gQMy7oUcDuJEUF5eFiCP15eH7a7sXhD7OYwBw3fXmMYlg3O3oe73wqITiK96cddE+HlkjribgOC3VlHbnbxTRvHdo0x6BDc8XjFD3eenEGglqD5bGjY3bPXsQ626CeEwDDD8VPr+MkBfS5hz/UGhFbtP5RTYREgIbL/t/q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785069273; c=relaxed/simple;
	bh=seL588nCj+QHkQH+GbP7rp/joEiab0Fvl2xSrWFc2FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=prYzDD6sUsGBUM3xC1jgjnd1XdSU7qoEk+3i36ZVzIcdghjYDZn98QCfFQ1PJX5ae2MxS1qctOK/lHDo10n9A50OTTmF/Hd92A8wIXKv25ZwMAq+gyf6Le6vSlULrHJ2lHCN6xiv4LReO9P4oWk/1bnLM46EMEGyhb0oQadeX0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhHPURUg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhHPURUg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2AE1F00A3F;
	Sun, 26 Jul 2026 12:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785069271;
	bh=TPld1Q+RX3BDfk5Q/Qy27gJYFtiAlivci2JGUDMsn8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mhHPURUgEsZDLEOvx3xMUxeDjAeNs2Kw5LASywp/zMp1oimqSAxnOb4HqGSA1KTwP
	 D/AR1TXhApiyFx2w3RSHsIeyvNJsgVJ2ZJ2kkN/wGtMEZLVsJdp7O2py+ba4zzo4cj
	 jHog7AGHU23g0tSgP8GY1hYBPY1eqQ4yncuTwJXQu+dwN98CdASObZ8efWWq0UVqmp
	 kkoOVFpovV/HMTJHTf9l6x3Wm1RoN8RRenRJHIzcrW8eeuBczxrGXzkl+f5UiPT024
	 xiWd5sefhS3Wl5HHhFgHs+DziHN+LH9fYJDiygTMkqKADJinhtigjhRtVC8ZG1wJcs
	 hRV6V/Y4k+jEg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>,
	Koichiro Den <den@valinux.co.jp>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] dmaengine: dw-edma: Add spinlock to protect DONE_INT_MASK and ABORT_INT_MASK
Date: Sun, 26 Jul 2026 08:34:26 -0400
Message-ID: <20260726123426.18949-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260726123426.18949-1-sashal@kernel.org>
References: <2026072058-move-penny-29fb@gregkh>
 <20260726123426.18949-1-sashal@kernel.org>
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
index 85df2d511907b1..3965153a774819 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -109,7 +109,7 @@ struct dw_edma {
 
 	struct dw_edma_chan		*chan;
 
-	raw_spinlock_t			lock;		/* Only for legacy */
+	raw_spinlock_t			lock;		/* Protect v0 shared registers */
 
 	struct dw_edma_chip             *chip;
 #ifdef CONFIG_DEBUG_FS
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index a45564dbcf6896..86967d390dfb46 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -358,6 +358,7 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 {
 	struct dw_edma_chan *chan = chunk->chan;
 	struct dw_edma *dw = chan->dw;
+	unsigned long flags;
 	u32 tmp;
 
 	dw_edma_v0_core_write_chunk(chunk);
@@ -402,6 +403,8 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 			}
 		}
 		/* Interrupt unmask - done, abort */
+		raw_spin_lock_irqsave(&dw->lock, flags);
+
 		tmp = GET_RW_32(dw, chan->dir, int_mask);
 		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
 		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
@@ -410,6 +413,9 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
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

