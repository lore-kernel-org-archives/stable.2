Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795454129;
	b=FlwCkEUy/QS7B/Zbaxw/yjYaMUoCJJ41v8zy6Vwn27lR979ZbMbrsCJV8L3DMtnxa1er
	 PFpsknYsc8q8/abmmATcOai1Fxh8T6+749jN7rLCM5xSpbCBkE5KMrzzqAbhRqlnYspOH
	 09LFeVA9MZvFlRNo7sgVc0LuSxrarJ8eLoR6PFn+vc6eCCfKlXuziQUObGSDlPtJcDFaM
	 uzV8Ztv7Pb6oJX0Iz1cxSV4OSA/0tfptor3V1WglS00/x5Gv0dG6JIu53mP/QoeDLgOxo
	 bIE9ZSE99WCjWTrMfflcD1t/h51c26F/+lyU+Uv/93HHze4Loey/MxvSjU0z8IigElw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795454129;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7HrXdAZvqoP2wKFdIA57K4p11FPgSibCIfOS3Ctnkzw=;
	b=d53garOrau906wY+uAXtA6ZuRWXUff0457bS2r2IrBUeOHOccSO9vUpgqe0mjT1yMzeC
	 ATnThiIJmAhNkVwPsqjANRENOD1zdULZPuspQOXIJPhdmXKqPxQF5FiKhxuEfJdouj/K9
	 AOafLrwqA/O6FpnQSA+fOsof/4I0ivqltXCYvJIjdVIKeJ+No5sHs4oessWZx87woT+wo
	 yk797LqL1LZZjvsEoLMoD5NevAO2e7njzq2330WodqF+oS4OPiFMJO3YszeLx0o/vmScz
	 hlF1qhn9/WGI8/LLyjLOxHxLs5raT3LwpB3yAsVZQZomAQ8aCVCNxVzsT9siGLwu8JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=mEiKiGo3;
	arc=none smtp.remote-ip=115.124.28.98
Received: from out28-98.mail.aliyun.com (out28-98.mail.aliyun.com [115.124.28.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94865606A321;
	Mon, 23 Nov 2026 17:15:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94865606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=mEiKiGo3
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1795454125; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=7HrXdAZvqoP2wKFdIA57K4p11FPgSibCIfOS3Ctnkzw=;
	b=mEiKiGo3FN+oN+AGBYc3wvuUn8CzfAX1akPPEa/O/yqZ00PNAMMZyxkUC/W/FL5iC3az1BwGbTCdRxOEu9jIxd3IWpYN8EUQLNPhx9eogzTkgJhZka1uqUy1906FDhYTPRFqceur4NsbGglgi/5KuLgHFt/ioHiEjmAO/hN+Ims=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.04436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00469832-0.00143452-0.993867;FP=12259131756606194868|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037032112;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.k8Vw2b2_1795454122;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.k8Vw2b2_1795454122 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 24 Nov 2026 01:15:24 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	netdev@vger.kernel.org
Cc: Liu Haijun <haijun.liu@mediatek.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Lin Qiaojie <linqj@xiaopeng.com>
Subject: [PATCH net v2] net: wwan: t7xx: validate PIT data before building RX skb
Date: Tue, 24 Nov 2026 01:15:19 +0800
Message-ID: <20261123171519.33975-1-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both normal and fragment RX paths derive a data offset from the
modem-supplied PIT address and the BAT DMA base. The unsigned 64-bit
difference was stored in an int without checking the address order,
so a backwards address could wrap into a non-negative offset. The
normal path could then pass an invalid offset to skb_reserve(), while
the fragment path could pass an invalid offset and PIT data length
to skb_add_rx_frag().

These invalid ranges can make the resulting skb or fragment refer
outside the allocated buffer or DMA-mapped page. The error paths
also left consumed BAT entries unmarked, preventing BAT release and
buffer replenishment. In addition, packet assembly errors shared
the return value with the final PIT notification, so dropping a
packet could prevent consumed PIT entries from being returned to
the hardware.

Validate the address order and complete offset/length range before
building either skb representation: check normal data against both
skb tailroom and the DMA mapping length, and fragment data against
the mapped page buffer, keeping DMA-relative and page-relative
offsets separate. Extract each PIT BID once, validate it before
indexing the BAT array, and use the same index for BAT access and
bitmap updates. Cast the fragment BAT void pointer to
struct dpmaif_bat_page before pointer arithmetic. On error, free
the normal BAT skb and mark its entry consumed; also consume
fragment entries of failed packets and failed assemblies while
keeping their pages mapped for reuse. Keep packet assembly errors
separate from PIT notification errors so consumed PIT entries are
returned even when a packet is dropped.

Fixes: d642b012df70 ("net: wwan: t7xx: Add data path interface")
Cc: stable@vger.kernel.org
Reviewed-by: Lin Qiaojie <linqj@xiaopeng.com>
Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
---
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c | 114 ++++++++++++++-------
 1 file changed, 79 insertions(+), 35 deletions(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
index 5af90ca6e063..da4b7cb05bf3 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
+++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
@@ -282,7 +282,7 @@ static int t7xx_frag_bat_cur_bid_check(struct dpmaif_rx_queue *rxq,
 	if (cur_bid >= DPMAIF_FRG_COUNT)
 		return -EINVAL;
 
-	bat_page = bat_frag->bat_skb + cur_bid;
+	bat_page = (struct dpmaif_bat_page *)bat_frag->bat_skb + cur_bid;
 	if (!bat_page->page)
 		return -EINVAL;
 
@@ -392,17 +392,15 @@ int t7xx_dpmaif_rx_frag_alloc(struct dpmaif_ctrl *dpmaif_ctrl, struct dpmaif_bat
 
 static int t7xx_dpmaif_set_frag_to_skb(const struct dpmaif_rx_queue *rxq,
 				       const struct dpmaif_pit *pkt_info,
-				       struct sk_buff *skb)
+				       unsigned int cur_bid, struct sk_buff *skb)
 {
-	unsigned long long data_bus_addr, data_base_addr;
+	unsigned long long data_bus_addr, data_base_addr, dma_offset;
 	struct skb_shared_info *shinfo = skb_shinfo(skb);
 	struct device *dev = rxq->dpmaif_ctrl->dev;
 	struct dpmaif_bat_page *page_info;
-	unsigned int data_len;
-	int data_offset;
+	unsigned int data_len, data_offset;
 
-	page_info = rxq->bat_frag->bat_skb;
-	page_info += t7xx_normal_pit_bid(pkt_info);
+	page_info = (struct dpmaif_bat_page *)rxq->bat_frag->bat_skb + cur_bid;
 
 	if (!page_info->page)
 		return -EINVAL;
@@ -410,14 +408,26 @@ static int t7xx_dpmaif_set_frag_to_skb(const struct dpmaif_rx_queue *rxq,
 	if (shinfo->nr_frags >= MAX_SKB_FRAGS)
 		return -EINVAL;
 
-	dma_unmap_page(dev, page_info->data_bus_addr, page_info->data_len, DMA_FROM_DEVICE);
-
 	data_bus_addr = le32_to_cpu(pkt_info->pd.data_addr_h);
 	data_bus_addr = (data_bus_addr << 32) + le32_to_cpu(pkt_info->pd.data_addr_l);
 	data_base_addr = page_info->data_bus_addr;
-	data_offset = data_bus_addr - data_base_addr;
-	data_offset += page_info->offset;
 	data_len = FIELD_GET(PD_PIT_DATA_LEN, le32_to_cpu(pkt_info->header));
+
+	if (data_bus_addr < data_base_addr) {
+		dev_err_ratelimited(dev, "Invalid PIT frag data address\n");
+		return -EINVAL;
+	}
+
+	dma_offset = data_bus_addr - data_base_addr;
+	if (dma_offset > page_info->data_len ||
+	    data_len > page_info->data_len - dma_offset) {
+		dev_err_ratelimited(dev, "Invalid PIT frag data offset or length\n");
+		return -EINVAL;
+	}
+
+	dma_unmap_page(dev, page_info->data_bus_addr, page_info->data_len, DMA_FROM_DEVICE);
+
+	data_offset = page_info->offset + dma_offset;
 	skb_add_rx_frag(skb, shinfo->nr_frags, page_info->page,
 			data_offset, data_len, page_info->data_len);
 
@@ -438,22 +448,44 @@ static int t7xx_dpmaif_get_frag(struct dpmaif_rx_queue *rxq,
 	if (ret < 0)
 		return ret;
 
-	ret = t7xx_dpmaif_set_frag_to_skb(rxq, pkt_info, skb_info->cur_skb);
+	ret = t7xx_dpmaif_set_frag_to_skb(rxq, pkt_info, cur_bid, skb_info->cur_skb);
+	/* Mark the entry consumed on failure too, so release can reuse it. */
+	t7xx_dpmaif_set_bat_mask(rxq->bat_frag, cur_bid);
 	if (ret < 0) {
-		dev_err(rxq->dpmaif_ctrl->dev, "Failed to set frag data to skb: %d\n", ret);
+		dev_err_ratelimited(rxq->dpmaif_ctrl->dev,
+				    "Failed to set frag data to skb: %d\n", ret);
 		return ret;
 	}
 
-	t7xx_dpmaif_set_bat_mask(rxq->bat_frag, cur_bid);
 	return 0;
 }
 
+/* Consume a fragment PIT belonging to a packet that is already dropped. */
+static int t7xx_dpmaif_drop_frag(struct dpmaif_rx_queue *rxq,
+				 const struct dpmaif_pit *pkt_info)
+{
+	unsigned int cur_bid = t7xx_normal_pit_bid(pkt_info);
+
+	if (t7xx_frag_bat_cur_bid_check(rxq, cur_bid))
+		return -EINVAL;
+
+	/*
+	 * The page is still mapped and owned by the BAT entry; marking it
+	 * consumed lets release advance and the allocator reuse the page.
+	 */
+	t7xx_dpmaif_set_bat_mask(rxq->bat_frag, cur_bid);
+	return -EINVAL;
+}
+
 static int t7xx_bat_cur_bid_check(struct dpmaif_rx_queue *rxq, const unsigned int cur_bid)
 {
-	struct dpmaif_bat_skb *bat_skb = rxq->bat_req->bat_skb;
+	struct dpmaif_bat_skb *bat_skb;
+
+	if (cur_bid >= DPMAIF_BAT_COUNT)
+		return -EINVAL;
 
-	bat_skb += cur_bid;
-	if (cur_bid >= DPMAIF_BAT_COUNT || !bat_skb->skb)
+	bat_skb = (struct dpmaif_bat_skb *)rxq->bat_req->bat_skb + cur_bid;
+	if (!bat_skb->skb)
 		return -EINVAL;
 
 	return 0;
@@ -627,38 +659,50 @@ static void t7xx_dpmaif_parse_msg_pit(const struct dpmaif_rx_queue *rxq,
 
 static int t7xx_dpmaif_set_data_to_skb(const struct dpmaif_rx_queue *rxq,
 				       const struct dpmaif_pit *pkt_info,
+				       unsigned int cur_bid,
 				       struct dpmaif_cur_rx_skb_info *skb_info)
 {
-	unsigned long long data_bus_addr, data_base_addr;
+	unsigned long long data_bus_addr, data_base_addr, data_offset;
 	struct device *dev = rxq->dpmaif_ctrl->dev;
 	struct dpmaif_bat_skb *bat_skb;
-	unsigned int data_len;
+	unsigned int data_len, tailroom, max_len;
 	struct sk_buff *skb;
-	int data_offset;
 
-	bat_skb = rxq->bat_req->bat_skb;
-	bat_skb += t7xx_normal_pit_bid(pkt_info);
+	bat_skb = (struct dpmaif_bat_skb *)rxq->bat_req->bat_skb + cur_bid;
 	dma_unmap_single(dev, bat_skb->data_bus_addr, bat_skb->data_len, DMA_FROM_DEVICE);
 
 	data_bus_addr = le32_to_cpu(pkt_info->pd.data_addr_h);
 	data_bus_addr = (data_bus_addr << 32) + le32_to_cpu(pkt_info->pd.data_addr_l);
 	data_base_addr = bat_skb->data_bus_addr;
-	data_offset = data_bus_addr - data_base_addr;
 	data_len = FIELD_GET(PD_PIT_DATA_LEN, le32_to_cpu(pkt_info->header));
 	skb = bat_skb->skb;
 	skb->len = 0;
 	skb_reset_tail_pointer(skb);
-	skb_reserve(skb, data_offset);
 
-	if (skb->tail + data_len > skb->end) {
-		dev_err(dev, "No buffer space available\n");
-		return -ENOBUFS;
+	if (data_bus_addr < data_base_addr) {
+		dev_err_ratelimited(dev, "Invalid PIT data address\n");
+		goto err_drop;
+	}
+
+	data_offset = data_bus_addr - data_base_addr;
+	tailroom = skb_tailroom(skb);
+	max_len = min(tailroom, bat_skb->data_len);
+	if (data_offset > max_len || data_len > max_len - data_offset) {
+		dev_err_ratelimited(dev, "Invalid PIT data offset or length\n");
+		goto err_drop;
 	}
 
+	skb_reserve(skb, (int)data_offset);
 	skb_put(skb, data_len);
 	skb_info->cur_skb = skb;
 	bat_skb->skb = NULL;
 	return 0;
+
+err_drop:
+	dev_kfree_skb_any(skb);
+	bat_skb->skb = NULL;
+	t7xx_dpmaif_set_bat_mask(rxq->bat_req, cur_bid);
+	return -ENOBUFS;
 }
 
 static int t7xx_dpmaif_get_rx_pkt(struct dpmaif_rx_queue *rxq,
@@ -672,9 +716,9 @@ static int t7xx_dpmaif_get_rx_pkt(struct dpmaif_rx_queue *rxq,
 	if (ret < 0)
 		return ret;
 
-	ret = t7xx_dpmaif_set_data_to_skb(rxq, pkt_info, skb_info);
+	ret = t7xx_dpmaif_set_data_to_skb(rxq, pkt_info, cur_bid, skb_info);
 	if (ret < 0) {
-		dev_err(rxq->dpmaif_ctrl->dev, "RX set data to skb failed: %d\n", ret);
+		dev_err_ratelimited(rxq->dpmaif_ctrl->dev, "RX set data to skb failed: %d\n", ret);
 		return ret;
 	}
 
@@ -726,7 +770,7 @@ static int t7xx_dpmaif_rx_start(struct dpmaif_rx_queue *rxq, const unsigned int
 	unsigned int cur_pit, pit_len, rx_cnt, recv_skb_cnt = 0;
 	struct device *dev = rxq->dpmaif_ctrl->dev;
 	struct dpmaif_cur_rx_skb_info *skb_info;
-	int ret = 0;
+	int ret = 0, pkt_ret;
 
 	pit_len = rxq->pit_size_cnt;
 	skb_info = &rxq->rx_data_info;
@@ -756,13 +800,13 @@ static int t7xx_dpmaif_rx_start(struct dpmaif_rx_queue *rxq, const unsigned int
 		} else { /* DES_PT_PD */
 			val = FIELD_GET(PD_PIT_BUFFER_TYPE, le32_to_cpu(pkt_info->header));
 			if (val != PKT_BUF_FRAG)
-				ret = t7xx_dpmaif_get_rx_pkt(rxq, pkt_info, skb_info);
-			else if (!skb_info->cur_skb)
-				ret = -EINVAL;
+				pkt_ret = t7xx_dpmaif_get_rx_pkt(rxq, pkt_info, skb_info);
+			else if (skb_info->err_payload || !skb_info->cur_skb)
+				pkt_ret = t7xx_dpmaif_drop_frag(rxq, pkt_info);
 			else
-				ret = t7xx_dpmaif_get_frag(rxq, pkt_info, skb_info);
+				pkt_ret = t7xx_dpmaif_get_frag(rxq, pkt_info, skb_info);
 
-			if (ret < 0) {
+			if (pkt_ret < 0) {
 				skb_info->err_payload = 1;
 				dev_err_ratelimited(dev, "RXQ%u error payload\n", rxq->index);
 			}
-- 
2.50.1

