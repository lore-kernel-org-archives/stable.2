Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029724570F9
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 13:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791293198; cv=none; b=fDciJGlnRpUrBMJyDdsmYIyYbzAvnVfyQzUnGbVM1DAtd0arWklF2oYOMuBi+cSfjrU9dPigvF+LScZT30I9npI6zhbEot4OQxg/F+iIgunyslb9bNbcNT9kVUla9vp95CDs6lC7yrE8qdWFdtbnRtHh18qMa6NdRFEJeQZ2tqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791293198; c=relaxed/simple;
	bh=cE0YDYInFJ0tZ4pWsoDFiUB0WSj9yVXs1KXHRUAcczQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FBeSZn3ZiScmxWeX/3UwBBw7/nT7XXvBnAU1251b4QwSv/mA76cm4FZVzT/FpaAfW8rfdTe8xhjthGHwnp2viAXU3IW9qwfohdL6AFtQFeAIRF4rmbtbBVLNG5T4g0tEat78j8N3v0O3em25Y56HcA64Wy7m0NMuxgQj05/TVfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hf6ufZkL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hf6ufZkL"
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 47B1620B7166; Tue,  6 Oct 2026 06:25:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 47B1620B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791293141;
	bh=SNxU3TmEMwV+ORpjb0N5Y6SR0ZR9UUekqU/kVjY30Ek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hf6ufZkL3kusNiyEfzbVshPkqF/oBduQGAvZWhYjgT66xuJXA1f6NKLG0bXliedfh
	 Ib78Z9e0VrNs5JRAgINi/v265W66LQWs9XEsUemTqJmwYnzB/Kv4u6OmN4YzlO7Mml
	 EYI109HPrmRRcvGbG90k2g1ramnm+9B7FIoTBcPM=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Subject: [PATCH 6.18.y 2/2] net: mana: Sync page pool RX frags for CPU
Date: Tue,  6 Oct 2026 09:25:23 -0400
Message-ID: <20261006132523.2742871-2-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261006132523.2742871-1-hamzamahfooz@linux.microsoft.com>
References: <20261006132523.2742871-1-hamzamahfooz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dexuan Cui <decui@microsoft.com>

[ Upstream commit c72a0f09c57f92113df69f9b902d11c9e4b132f5 ]

MANA allocates RX buffers from page pool fragments when frag_count is
greater than 1. In that case the buffers remain DMA mapped by page pool
and the RX completion path does not call dma_unmap_single(). As a result,
the implicit sync-for-CPU normally performed by dma_unmap_single() is
missing before the packet data is passed to the networking stack.

This breaks RX on configurations which require explicit DMA syncing, for
example when booted with swiotlb=force.

Fix this by recording the page pool page and DMA sync offset when the RX
buffer is allocated, and syncing the received packet range for CPU access
before handing the RX buffer to the stack.

Fixes: 730ff06d3f5c ("net: mana: Use page pool fragments for RX buffers instead of full pages to improve memory efficiency.")
Cc: stable@vger.kernel.org
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Link: https://patch.msgid.link/20260702041237.617719-3-decui@microsoft.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ hmahfooz: resolve conflict with the earlier backport of 55d20f50a221
  by passing pktlen to mana_refill_rx_oob() from
  mana_process_one_rx_pkt() ]
Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 40 +++++++++++++++----
 include/net/mana/mana.h                       |  8 ++++
 2 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 089bbe38feb9..be41e970b5ef 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2072,12 +2072,16 @@ static void mana_rx_skb(void *buf_va, bool from_pool,
 }
 
 static void *mana_get_rxfrag(struct mana_rxq *rxq, struct device *dev,
-			     dma_addr_t *da, bool *from_pool)
+			     dma_addr_t *da, bool *from_pool,
+			     struct page **pp_page, u32 *dma_sync_offset)
 {
 	struct page *page;
 	u32 offset;
 	void *va;
+
 	*from_pool = false;
+	*pp_page = NULL;
+	*dma_sync_offset = 0;
 
 	/* Don't use fragments for jumbo frames or XDP where it's 1 fragment
 	 * per page.
@@ -2115,31 +2119,47 @@ static void *mana_get_rxfrag(struct mana_rxq *rxq, struct device *dev,
 	va  = page_to_virt(page) + offset;
 	*da = page_pool_get_dma_addr(page) + offset + rxq->headroom;
 	*from_pool = true;
+	*pp_page = page;
+	*dma_sync_offset = offset + rxq->headroom;
 
 	return va;
 }
 
 /* Allocate frag for rx buffer, and save the old buf */
 static void mana_refill_rx_oob(struct device *dev, struct mana_rxq *rxq,
-			       struct mana_recv_buf_oob *rxoob, void **old_buf,
-			       bool *old_fp)
+			       struct mana_recv_buf_oob *rxoob, u32 pktlen,
+			       void **old_buf, bool *old_fp)
 {
+	struct page *pp_page;
+	u32 dma_sync_offset;
 	bool from_pool;
 	dma_addr_t da;
 	void *va;
 
-	va = mana_get_rxfrag(rxq, dev, &da, &from_pool);
+	va = mana_get_rxfrag(rxq, dev, &da, &from_pool, &pp_page,
+			     &dma_sync_offset);
 	if (!va)
 		return;
-	if (!rxoob->from_pool || rxq->frag_count == 1)
+	if (!rxoob->from_pool || rxq->frag_count == 1) {
 		dma_unmap_single(dev, rxoob->sgl[0].address, rxq->datasize,
 				 DMA_FROM_DEVICE);
+	} else {
+		/* The page pool maps the whole page and only syncs for device
+		 * automatically (PP_FLAG_DMA_SYNC_DEV). Sync the received bytes
+		 * for the CPU before they are read: this is required if DMA
+		 * is incoherent or bounce buffers are used.
+		 */
+		page_pool_dma_sync_for_cpu(rxq->page_pool, rxoob->pp_page,
+					   rxoob->dma_sync_offset, pktlen);
+	}
 	*old_buf = rxoob->buf_va;
 	*old_fp = rxoob->from_pool;
 
 	rxoob->buf_va = va;
 	rxoob->sgl[0].address = da;
 	rxoob->from_pool = from_pool;
+	rxoob->pp_page = pp_page;
+	rxoob->dma_sync_offset = dma_sync_offset;
 }
 
 static void mana_process_one_rx_pkt(struct device *dev, struct mana_rxq *rxq,
@@ -2165,7 +2185,8 @@ static void mana_process_one_rx_pkt(struct device *dev, struct mana_rxq *rxq,
 
 		/* Reuse the RX buffer since rxbuf_oob is unchanged. */
 	} else {
-		mana_refill_rx_oob(dev, rxq, rxbuf_oob, &old_buf, &old_fp);
+		mana_refill_rx_oob(dev, rxq, rxbuf_oob, pktlen,
+				   &old_buf, &old_fp);
 
 		/* Unsuccessful refill will have old_buf == NULL.
 		 * In this case, mana_rx_skb() will drop the packet.
@@ -2777,6 +2798,8 @@ static int mana_fill_rx_oob(struct mana_recv_buf_oob *rx_oob, u32 mem_key,
 			    struct mana_rxq *rxq, struct device *dev)
 {
 	struct mana_port_context *mpc = netdev_priv(rxq->ndev);
+	struct page *pp_page = NULL;
+	u32 dma_sync_offset = 0;
 	bool from_pool = false;
 	dma_addr_t da;
 	void *va;
@@ -2784,13 +2807,16 @@ static int mana_fill_rx_oob(struct mana_recv_buf_oob *rx_oob, u32 mem_key,
 	if (mpc->rxbufs_pre)
 		va = mana_get_rxbuf_pre(rxq, &da);
 	else
-		va = mana_get_rxfrag(rxq, dev, &da, &from_pool);
+		va = mana_get_rxfrag(rxq, dev, &da, &from_pool, &pp_page,
+				     &dma_sync_offset);
 
 	if (!va)
 		return -ENOMEM;
 
 	rx_oob->buf_va = va;
 	rx_oob->from_pool = from_pool;
+	rx_oob->pp_page = pp_page;
+	rx_oob->dma_sync_offset = dma_sync_offset;
 
 	rx_oob->sgl[0].address = da;
 	rx_oob->sgl[0].size = rxq->datasize;
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 7663bcd7ec19..f8120ae6d037 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -348,6 +348,14 @@ struct mana_recv_buf_oob {
 
 	void *buf_va;
 	bool from_pool; /* allocated from a page pool */
+	/* head page of the page_pool fragment; valid only when
+	 * from_pool && frag_count > 1.
+	 */
+	struct page *pp_page;
+	/* Fragment offset plus rxq->headroom, passed to
+	 * page_pool_dma_sync_for_cpu().
+	 */
+	u32 dma_sync_offset;
 
 	/* SGL of the buffer going to be sent as part of the work request. */
 	u32 num_sge;
-- 
2.56.0

