Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585683A5E71
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 02:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789613448; cv=none; b=TRBeTO9JMtdoypXQqnsBtewlBPKTungU7YtETHFe896/KV7tSS5sOkHGVzKuZ5w5Iwn8/lwXb5HE5QttM2wh4flQTu1WTSc8xtwj8WGjzMkbwaxP7mq1VQmkORX6NLlaCRXxUbC3uHr6ElDvO1mQwNm0Xdmzpr9PMQj6lNrG7ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789613448; c=relaxed/simple;
	bh=z9ZfZkrvo/mFNuyiuyOXaiUt+lXAoteKCUgna+fbzEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=enhs+7b2n1vetcw6WpeKfD2Nt2HZyKpdQbDOBckgGtYyIcgI+g0hXhgWgXvllfQohHkfByNTEFhQiHy92oUbrND9FBjvSJLIJFseMuF2nddBBJY3pN4VKSsde18wR8symPZLhuBT7QiDdpicKpyuzsz6qW6CLUwqUBv3j2aR+Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USiIizk6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USiIizk6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9741F008A6;
	Thu, 17 Sep 2026 02:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789613427;
	bh=pJLviyb9UhcbxMU83ydtedGrVV+1AsndwZllQpPGk68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=USiIizk6r+rM7FvNtuQatYWAbjcI+7NBFYmocwvqdKu83mlkbH6IiAseKxAoLqWq3
	 D0mYAOi7fdQgndmgSpoSSvftpCUvlRCQiN9HCIBv+38FsOEm+KSqOmokfvJBlf/IeB
	 KO1boyT2Pjsgwg+ayNzDeWSaP4DSfwzktYY2dVq0SAACDiUXfHI7PRasCXB0CP0rb3
	 a3jdp3/20I8D/Jtl07CBE84HCr5YkpfTFi4K19waM2xAwOmZFaGzWwMp3DwBSfD4Jf
	 W7phI/L7by/ewwIAiRfLIfzBL2THuHBmM+xbTdLsyTcAcYCHXz/SsVTmxDY0n2Rrdu
	 i+1WwAMTTXklA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] eth: bnxt: store rx buffer size per queue
Date: Wed, 16 Sep 2026 22:50:22 -0400
Message-ID: <20260917025024.3917679-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917025024.3917679-1-sashal@kernel.org>
References: <2026091604-recall-carnivore-5fe5@gregkh>
 <20260917025024.3917679-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavel Begunkov <asml.silence@gmail.com>

[ Upstream commit f57efb32aae1da5c0a25acf473ef4ab559894adf ]

Instead of using a constant buffer length, allow configuring the size
for each queue separately. There is no way to change the length yet, and
it'll be passed from memory providers in a later patch.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

Stable adaptation for 6.12:

Keep the per-queue buffer size change using the existing page-based RX
and XDP interfaces. Apply aggregation truesize accounting in
bnxt_rx_agg_pages_skb(), and program the size in the existing firmware
ring allocation path instead of adding the newer helper functions.

This tree has no unreadable netmem pools. Derive head-pool separation
from the queue buffer size, keep head allocations at order zero, and
use the same queue-specific decision for allocation and cleanup. Keep
the existing pool sizing and NAPI association. Queue sizes start at
BNXT_RX_PAGE_SIZE and are inherited by restart clones.

Initialize the clone's rx_agg_bmap to NULL to separate it from the live
ring and provide the common initialization context needed to cherry-pick
5ce7f36c334d ("bnxt_en: Don't free the live ring's TPA state on queue
restart failure") cleanly. The target's TPA pointer resets are left to
that commit. No functions are added.

Stable-dep-of: 5ce7f36c334d ("bnxt_en: Don't free the live ring's TPA state on queue restart failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 60 +++++++++++--------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  2 +-
 4 files changed, 39 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 09306e706997d..1aa8c26bf71a1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -867,9 +867,9 @@ static void bnxt_tx_int(struct bnxt *bp, struct bnxt_napi *bnapi, int budget)
 		bnapi->events &= ~BNXT_TX_CMP_EVENT;
 }
 
-static bool bnxt_separate_head_pool(void)
+static bool bnxt_separate_head_pool(struct bnxt_rx_ring_info *rxr)
 {
-	return PAGE_SIZE > BNXT_RX_PAGE_SIZE;
+	return rxr->rx_page_size != PAGE_SIZE;
 }
 
 static struct page *__bnxt_alloc_rx_page(struct bnxt *bp, dma_addr_t *mapping,
@@ -879,9 +879,9 @@ static struct page *__bnxt_alloc_rx_page(struct bnxt *bp, dma_addr_t *mapping,
 {
 	struct page *page;
 
-	if (PAGE_SIZE > BNXT_RX_PAGE_SIZE) {
+	if (rxr->rx_page_size < PAGE_SIZE) {
 		page = page_pool_dev_alloc_frag(rxr->page_pool, offset,
-						BNXT_RX_PAGE_SIZE);
+						rxr->rx_page_size);
 	} else {
 		page = page_pool_dev_alloc_pages(rxr->page_pool);
 		*offset = 0;
@@ -1101,9 +1101,9 @@ static struct sk_buff *bnxt_rx_multi_page_skb(struct bnxt *bp,
 		return NULL;
 	}
 	dma_addr -= bp->rx_dma_offset;
-	dma_sync_single_for_cpu(&bp->pdev->dev, dma_addr, BNXT_RX_PAGE_SIZE,
+	dma_sync_single_for_cpu(&bp->pdev->dev, dma_addr, rxr->rx_page_size,
 				bp->rx_dir);
-	skb = napi_build_skb(data_ptr - bp->rx_offset, BNXT_RX_PAGE_SIZE);
+	skb = napi_build_skb(data_ptr - bp->rx_offset, rxr->rx_page_size);
 	if (!skb) {
 		page_pool_recycle_direct(rxr->page_pool, page);
 		return NULL;
@@ -1135,7 +1135,7 @@ static struct sk_buff *bnxt_rx_page_skb(struct bnxt *bp,
 		return NULL;
 	}
 	dma_addr -= bp->rx_dma_offset;
-	dma_sync_single_for_cpu(&bp->pdev->dev, dma_addr, BNXT_RX_PAGE_SIZE,
+	dma_sync_single_for_cpu(&bp->pdev->dev, dma_addr, rxr->rx_page_size,
 				bp->rx_dir);
 
 	if (unlikely(!payload))
@@ -1149,7 +1149,7 @@ static struct sk_buff *bnxt_rx_page_skb(struct bnxt *bp,
 
 	skb_mark_for_recycle(skb);
 	off = (void *)data_ptr - page_address(page);
-	skb_add_rx_frag(skb, 0, page, off, len, BNXT_RX_PAGE_SIZE);
+	skb_add_rx_frag(skb, 0, page, off, len, rxr->rx_page_size);
 	memcpy(skb->data - NET_IP_ALIGN, data_ptr - NET_IP_ALIGN,
 	       payload + NET_IP_ALIGN);
 
@@ -1253,7 +1253,7 @@ static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
 			return 0;
 		}
 
-		dma_sync_single_for_cpu(&pdev->dev, mapping, BNXT_RX_PAGE_SIZE,
+		dma_sync_single_for_cpu(&pdev->dev, mapping, rxr->rx_page_size,
 					bp->rx_dir);
 
 		total_frag_len += frag_len;
@@ -1268,6 +1268,7 @@ static struct sk_buff *bnxt_rx_agg_pages_skb(struct bnxt *bp,
 					     struct sk_buff *skb, u16 idx,
 					     u32 agg_bufs, bool tpa)
 {
+	struct bnxt_rx_ring_info *rxr = cpr->bnapi->rx_ring;
 	struct skb_shared_info *shinfo = skb_shinfo(skb);
 	u32 total_frag_len = 0;
 
@@ -1281,7 +1282,7 @@ static struct sk_buff *bnxt_rx_agg_pages_skb(struct bnxt *bp,
 
 	skb->data_len += total_frag_len;
 	skb->len += total_frag_len;
-	skb->truesize += BNXT_RX_PAGE_SIZE * agg_bufs;
+	skb->truesize += rxr->rx_page_size * agg_bufs;
 	return skb;
 }
 
@@ -2222,8 +2223,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 			if (!skb)
 				goto oom_next_rx;
 		} else {
-			skb = bnxt_xdp_build_skb(bp, skb, agg_bufs,
-						 rxr->page_pool, &xdp);
+			skb = bnxt_xdp_build_skb(bp, skb, agg_bufs, rxr, &xdp);
 			if (!skb) {
 				/* we should be able to free the old skb here */
 				bnxt_xdp_buff_frags_free(rxr, &xdp);
@@ -3647,7 +3647,7 @@ static void bnxt_free_rx_rings(struct bnxt *bp)
 			xdp_rxq_info_unreg(&rxr->xdp_rxq);
 
 		page_pool_destroy(rxr->page_pool);
-		if (bnxt_separate_head_pool())
+		if (bnxt_separate_head_pool(rxr))
 			page_pool_destroy(rxr->head_pool);
 		rxr->page_pool = rxr->head_pool = NULL;
 
@@ -3672,12 +3672,14 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 	pp.pool_size = bp->rx_agg_ring_size;
 	if (BNXT_RX_PAGE_MODE(bp))
 		pp.pool_size += bp->rx_ring_size;
+
+	pp.order = get_order(rxr->rx_page_size);
 	pp.nid = numa_node;
 	pp.napi = &rxr->bnapi->napi;
 	pp.netdev = bp->dev;
 	pp.dev = &bp->pdev->dev;
 	pp.dma_dir = bp->rx_dir;
-	pp.max_len = PAGE_SIZE;
+	pp.max_len = PAGE_SIZE << pp.order;
 	pp.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
 
 	pool = page_pool_create(&pp);
@@ -3685,7 +3687,9 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 		return PTR_ERR(pool);
 	rxr->page_pool = pool;
 
-	if (bnxt_separate_head_pool()) {
+	if (bnxt_separate_head_pool(rxr)) {
+		pp.order = 0;
+		pp.max_len = PAGE_SIZE;
 		pp.pool_size = max(bp->rx_ring_size, 1024);
 		pool = page_pool_create(&pp);
 		if (IS_ERR(pool))
@@ -4140,6 +4144,8 @@ static void bnxt_init_ring_struct(struct bnxt *bp)
 		if (!rxr)
 			goto skip_rx;
 
+		rxr->rx_page_size = BNXT_RX_PAGE_SIZE;
+
 		ring = &rxr->rx_ring_struct;
 		rmem = &ring->ring_mem;
 		rmem->nr_pages = bp->rx_nr_pages;
@@ -4299,7 +4305,7 @@ static void bnxt_init_one_rx_agg_ring_rxbd(struct bnxt *bp,
 	ring = &rxr->rx_agg_ring_struct;
 	ring->fw_ring_id = INVALID_HW_RING_ID;
 	if ((bp->flags & BNXT_FLAG_AGG_RINGS)) {
-		type = ((u32)BNXT_RX_PAGE_SIZE << RX_BD_LEN_SHIFT) |
+		type = ((u32)rxr->rx_page_size << RX_BD_LEN_SHIFT) |
 			RX_BD_TYPE_RX_AGG_BD;
 
 		/* On P7, setting EOP will cause the chip to disable
@@ -6864,6 +6870,7 @@ static void bnxt_hwrm_ring_grp_free(struct bnxt *bp)
 }
 
 static int hwrm_ring_alloc_send_msg(struct bnxt *bp,
+				    struct bnxt_rx_ring_info *rxr,
 				    struct bnxt_ring_struct *ring,
 				    u32 ring_type, u32 map_index)
 {
@@ -6936,7 +6943,7 @@ static int hwrm_ring_alloc_send_msg(struct bnxt *bp,
 			/* Association of agg ring with rx ring */
 			grp_info = &bp->grp_info[ring->grp_idx];
 			req->rx_ring_id = cpu_to_le16(grp_info->rx_fw_ring_id);
-			req->rx_buf_size = cpu_to_le16(BNXT_RX_PAGE_SIZE);
+			req->rx_buf_size = cpu_to_le16(rxr->rx_page_size);
 			req->stat_ctx_id = cpu_to_le32(grp_info->fw_stats_ctx);
 			req->enables |= cpu_to_le32(
 				RING_ALLOC_REQ_ENABLES_RX_RING_ID_VALID |
@@ -7092,7 +7099,7 @@ static int bnxt_hwrm_rx_ring_alloc(struct bnxt *bp,
 	u32 map_idx = bnapi->index;
 	int rc;
 
-	rc = hwrm_ring_alloc_send_msg(bp, ring, type, map_idx);
+	rc = hwrm_ring_alloc_send_msg(bp, rxr, ring, type, map_idx);
 	if (rc)
 		return rc;
 
@@ -7112,7 +7119,7 @@ static int bnxt_hwrm_rx_agg_ring_alloc(struct bnxt *bp,
 	int rc;
 
 	map_idx = grp_idx + bp->rx_nr_rings;
-	rc = hwrm_ring_alloc_send_msg(bp, ring, type, map_idx);
+	rc = hwrm_ring_alloc_send_msg(bp, rxr, ring, type, map_idx);
 	if (rc)
 		return rc;
 
@@ -7144,7 +7151,7 @@ static int bnxt_hwrm_ring_alloc(struct bnxt *bp)
 
 		vector = bp->irq_tbl[map_idx].vector;
 		disable_irq_nosync(vector);
-		rc = hwrm_ring_alloc_send_msg(bp, ring, type, map_idx);
+		rc = hwrm_ring_alloc_send_msg(bp, NULL, ring, type, map_idx);
 		if (rc) {
 			enable_irq(vector);
 			goto err_out;
@@ -7175,7 +7182,7 @@ static int bnxt_hwrm_ring_alloc(struct bnxt *bp)
 			ring = &cpr2->cp_ring_struct;
 			ring->handle = BNXT_SET_NQ_HDL(cpr2);
 			map_idx = bnapi->index;
-			rc = hwrm_ring_alloc_send_msg(bp, ring, type2, map_idx);
+			rc = hwrm_ring_alloc_send_msg(bp, NULL, ring, type2, map_idx);
 			if (rc)
 				goto err_out;
 			bnxt_set_db(bp, &cpr2->cp_db, type2, map_idx,
@@ -7184,7 +7191,7 @@ static int bnxt_hwrm_ring_alloc(struct bnxt *bp)
 		}
 		ring = &txr->tx_ring_struct;
 		map_idx = i;
-		rc = hwrm_ring_alloc_send_msg(bp, ring, type, map_idx);
+		rc = hwrm_ring_alloc_send_msg(bp, NULL, ring, type, map_idx);
 		if (rc)
 			goto err_out;
 		bnxt_set_db(bp, &txr->tx_db, type, map_idx, ring->fw_ring_id);
@@ -7208,7 +7215,7 @@ static int bnxt_hwrm_ring_alloc(struct bnxt *bp)
 
 			ring = &cpr2->cp_ring_struct;
 			ring->handle = BNXT_SET_NQ_HDL(cpr2);
-			rc = hwrm_ring_alloc_send_msg(bp, ring, type2, map_idx);
+			rc = hwrm_ring_alloc_send_msg(bp, NULL, ring, type2, map_idx);
 			if (rc)
 				goto err_out;
 			bnxt_set_db(bp, &cpr2->cp_db, type2, map_idx,
@@ -15381,6 +15388,7 @@ static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
 	clone->rx_agg_prod = 0;
 	clone->rx_sw_agg_prod = 0;
 	clone->rx_next_cons = 0;
+	clone->rx_agg_bmap = NULL;
 
 	rc = bnxt_alloc_rx_page_pool(bp, clone, rxr->page_pool->p.nid);
 	if (rc)
@@ -15439,7 +15447,7 @@ static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
 	xdp_rxq_info_unreg(&clone->xdp_rxq);
 err_page_pool_destroy:
 	page_pool_destroy(clone->page_pool);
-	if (bnxt_separate_head_pool())
+	if (bnxt_separate_head_pool(clone))
 		page_pool_destroy(clone->head_pool);
 	clone->page_pool = NULL;
 	clone->head_pool = NULL;
@@ -15458,7 +15466,7 @@ static void bnxt_queue_mem_free(struct net_device *dev, void *qmem)
 	xdp_rxq_info_unreg(&rxr->xdp_rxq);
 
 	page_pool_destroy(rxr->page_pool);
-	if (bnxt_separate_head_pool())
+	if (bnxt_separate_head_pool(rxr))
 		page_pool_destroy(rxr->head_pool);
 	rxr->page_pool = NULL;
 	rxr->head_pool = NULL;
@@ -15602,7 +15610,7 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
 	bnxt_hwrm_rx_agg_ring_free(bp, rxr, false);
 	rxr->rx_next_cons = 0;
 	page_pool_disable_direct_recycling(rxr->page_pool);
-	if (bnxt_separate_head_pool())
+	if (bnxt_separate_head_pool(rxr))
 		page_pool_disable_direct_recycling(rxr->head_pool);
 
 	memcpy(qmem, rxr, sizeof(*rxr));
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 24f777832ed62..c10f8ad8bfbd4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1098,6 +1098,7 @@ struct bnxt_rx_ring_info {
 
 	unsigned long		*rx_agg_bmap;
 	u16			rx_agg_bmap_size;
+	u32			rx_page_size;
 
 	dma_addr_t		rx_desc_mapping[MAX_RX_PAGES];
 	dma_addr_t		rx_agg_desc_mapping[MAX_RX_AGG_PAGES];
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 850dabebdbf22..2c16348d3b8cb 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -182,7 +182,7 @@ void bnxt_xdp_buff_init(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 			u16 cons, u8 *data_ptr, unsigned int len,
 			struct xdp_buff *xdp)
 {
-	u32 buflen = BNXT_RX_PAGE_SIZE;
+	u32 buflen = rxr->rx_page_size;
 	struct bnxt_sw_rx_bd *rx_buf;
 	struct pci_dev *pdev;
 	dma_addr_t mapping;
@@ -454,7 +454,7 @@ int bnxt_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 
 struct sk_buff *
 bnxt_xdp_build_skb(struct bnxt *bp, struct sk_buff *skb, u8 num_frags,
-		   struct page_pool *pool, struct xdp_buff *xdp)
+		   struct bnxt_rx_ring_info *rxr, struct xdp_buff *xdp)
 {
 	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
 
@@ -463,7 +463,7 @@ bnxt_xdp_build_skb(struct bnxt *bp, struct sk_buff *skb, u8 num_frags,
 
 	xdp_update_skb_shared_info(skb, num_frags,
 				   sinfo->xdp_frags_size,
-				   BNXT_RX_PAGE_SIZE * num_frags,
+				   rxr->rx_page_size * num_frags,
 				   xdp_buff_is_frag_pfmemalloc(xdp));
 	return skb;
 }
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
index 220285e190fcd..8933a0dec09a6 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
@@ -32,6 +32,6 @@ void bnxt_xdp_buff_init(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 void bnxt_xdp_buff_frags_free(struct bnxt_rx_ring_info *rxr,
 			      struct xdp_buff *xdp);
 struct sk_buff *bnxt_xdp_build_skb(struct bnxt *bp, struct sk_buff *skb,
-				   u8 num_frags, struct page_pool *pool,
+				   u8 num_frags, struct bnxt_rx_ring_info *rxr,
 				   struct xdp_buff *xdp);
 #endif
-- 
2.53.0

