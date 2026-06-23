Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DBB3D4119
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 11:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782213752; cv=none; b=gS52LtKlsDWGgTCc/vVtTkXIjglENoJdlhQXCMgns/9q+Y1o2HniOoda3XVVDRFvkZEDYzmUkKRMniCDj9DAyluJv5PH7ULbfUw6sr8PYcKLFfwdQ3k7eMeMBNuXGO+IUtJtwWTu1ZdIt/PVie9kP/SI7EFcvaw/Ng83AgJ3d8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782213752; c=relaxed/simple;
	bh=S2wixHTY5PpR7xzLsbG2IqKF1SaBjFwr2zTAieLWxXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GAGAQ4csOFmh+JGSPVVslkMRGTQfDCrQhwuJkCr6JojNV0kbWu2tjfspzrD0tMscGc1neKb+xjjhkhVqy57DEd8/Y8eSiGRqgASc64hE7sFRG2mUT5h0DPGEKDtJCXSjMVfrpcYQEC3YCwKIaX+IIGslOXlA2rS8rRRXCvpPcGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsfX8BvI; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsfX8BvI"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490cf3000f0so57378095e9.1
        for <stable@vger.kernel.org>; Tue, 23 Jun 2026 04:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782213750; x=1782818550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Ll5fGvrULmASpVjjrUyqyYpgppQmeYjrRkuEZdoatc=;
        b=bsfX8BvIuCEJWba8m1oEiK+IB3M/pO6Hb9OkWi3LFatWpOwH6zdPW1gfbPSAGYekuk
         d2V8hs6mhViIsZY/k5wlGzxMjbZOHDfbaC9GbSSTCusqGoIjlBoEmU7RNwMPq78CrrHf
         RDoowpBFRIufmJ00nvJm2NjjK6SR7M3uOymZB3Fo4uWVTH+cSC3s6WKRIeOru4z7wJAi
         mK6AEZ9I0AY7DzVDhCPgc2VX374u0JtFT8G0+WKPc4KLGH3cnvVcqh1Tv7lhqpnLKTA+
         O/2RZ8HuVXcvNUwlEYH5ECjeLpyINra7PtGrBhY6S0D86JuVuZidCIHmpfiMQlLZYDeC
         h85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782213750; x=1782818550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Ll5fGvrULmASpVjjrUyqyYpgppQmeYjrRkuEZdoatc=;
        b=Bahwh1mDEzixfdpbNPZ24RAGjs5ZVRjmqO3qNG6xPXfExzWibYXjyyczANIk1wmsq/
         W0obYU9rKycDzsh+5537oyOQu6yzZTz5aIlmYpXZAnO0YdHyjc/KpAIAwf1BJXuT/VtE
         hGNv6g0GyOQSB5wm6EXuvupNJ91VizZRJfaWYK1kFUiGFDpG/pMcXeiR0PaNEXPfRsWQ
         p0Wwu0MQUsGsIU7ejBLd1p8UfaKRwL3G2ndMoiFJ2ddXKTG0wUPUfEaN7iuv/LjIGU/o
         1rhzJQ4ylpQxqnutIqrcpjsA0Dfr+dwlDvcoCQ7DH6LodbTJ2H+8Ehvr/DyuDHXfrPBQ
         SgXg==
X-Forwarded-Encrypted: i=1; AFNElJ8NTruAOYIfnv4NSFTJ7dhLIMnHV42r745xPept1/HL4seh42m7wkMOBDm7FRPDF6O4xd4ofUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrN8FlABpAsRosK35pnmT+0OzVAMemcdzgCL+9mK4fifq291sW
	w61qY3gDmM7MZQQWdcqkuYlSa9fgkTNUSE+Y95RdYh3L0SMOsydhCgcJ
X-Gm-Gg: AfdE7clj4KQ5f7+iG9/hMOrwN5uHvSZHF/pK3xYmysuTPrh0H89wsmzFsbBOd6A7D4J
	vfjtELa/Ma5WthILYgfV8Ynl1mR2wRqKY/P+ffFhU749Htv0dye522PL8VYYm1nFt7394M7c1vD
	m1HMAEAdEDjRIcs8UqvoxdipI616uvvugxSZDHCuaSeneDTU6qTcVfbl1GaN3BB8MrIwQdgW1AL
	sZ1BXBzflr8Wb6UBKDRubZE54B9if6y3fH5U5lXtP2MyjiCw/6MP1sJPuc+NM2l6FtRV4XUELlc
	l1R/6ogTyecsJ/JgEzHKMkjHQVppZLGrR9BljLdF+dwL+Nx4+0lPXtcdmlYri/2Zxj1GbAnC4VH
	5NKlce4TTTPt0KClBSxNnfiv1xkx19lc23FmaHiJrnnFy3U4avl/0sEhUMuuQeHMyhpRU9qCdkM
	ZgBOGZl8koOytmHXvZrKJv5ayKYivvO/aaX3OlCDUCZe3mXkpJwtd601X5N3w/6bmCzI2hhvZDC
	dyJF84Qq5E=
X-Received: by 2002:a05:600c:4455:b0:492:40f2:4d78 with SMTP id 5b1f17b1804b1-4925b34a2e6mr33035365e9.2.1782213749442;
        Tue, 23 Jun 2026 04:22:29 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4924923cbe7sm272220715e9.8.2026.06.23.04.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 04:22:29 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: danishanwar@ti.com,
	rogerq@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	m-malladi@ti.com,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH net v2] net: ti: icssg-prueth: fix XDP_TX from the AF_XDP zero-copy RX path
Date: Tue, 23 Jun 2026 12:22:25 +0100
Message-ID: <20260623112225.303930-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On XDP_TX from the zero-copy RX path, emac_run_xdp() converts the xsk
buffer via xdp_convert_zc_to_xdp_frame(), which clones the data into a
fresh MEM_TYPE_PAGE_ORDER0 page that is not DMA mapped. Transmitting it
as PRUETH_TX_BUFF_TYPE_XDP_TX derives the DMA address with
page_pool_get_dma_addr(), reading an uninitialized page->dma_addr, so
the device DMAs from a bogus address (corrupt TX, or an IOMMU fault).

Pick the TX buffer type from the frame's memory type: keep
PRUETH_TX_BUFF_TYPE_XDP_TX for page_pool frames and use
PRUETH_TX_BUFF_TYPE_XDP_NDO for the cloned zero-copy frame, which is then
DMA mapped through the NDO path and unmapped on completion.

While at it, fix the page_pool XDP_TX completion path. A
PRUETH_TX_BUFF_TYPE_XDP_TX frame carries a page_pool-owned DMA mapping
(established against rx_chn->dma_dev), yet prueth_xmit_free()
unconditionally calls dma_unmap_single() on it with tx_chn->dma_dev,
tearing down a mapping the driver does not own; xdp_return_frame()
already recycles the page back to the pool. Tag such frames with a
dedicated PRUETH_SWDATA_XDPF_TX type so the completion path skips the
unmap, the same way PRUETH_SWDATA_XSK buffers are handled.

Fixes: 7a64bb388df3 ("net: ti: icssg-prueth: Add AF_XDP zero copy for RX")
Fixes: 62aa3246f462 ("net: ti: icssg-prueth: Add XDP support")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
v2:
 - fold in the page_pool XDP_TX completion-path unmap fix raised by
   Meghana Malladi: tag page_pool TX frames with PRUETH_SWDATA_XDPF_TX
   so prueth_xmit_free() skips dma_unmap_single() on a pool-owned
   mapping; xdp_return_frame() already recycles the page.
 - add Fixes: 62aa3246f462 for that path.
 - no change to the original zero-copy fix.
v1: https://lore.kernel.org/netdev/20260620213756.87499-1-devnexen@gmail.com
 drivers/net/ethernet/ti/icssg/icssg_common.c | 20 +++++++++++++++++---
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |  1 +
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index 82ddef9c17d5..96c8bf5ef671 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -185,7 +185,7 @@ void prueth_xmit_free(struct prueth_tx_chn *tx_chn,
 	first_desc = desc;
 	next_desc = first_desc;
 	swdata = cppi5_hdesc_get_swdata(first_desc);
-	if (swdata->type == PRUETH_SWDATA_XSK)
+	if (swdata->type == PRUETH_SWDATA_XSK || swdata->type == PRUETH_SWDATA_XDPF_TX)
 		goto free_pool;
 
 	cppi5_hdesc_get_obuf(first_desc, &buf_dma, &buf_dma_len);
@@ -259,6 +259,7 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
 			napi_consume_skb(skb, budget);
 			break;
 		case PRUETH_SWDATA_XDPF:
+		case PRUETH_SWDATA_XDPF_TX:
 			xdpf = swdata->data.xdpf;
 			dev_sw_netstats_tx_add(ndev, 1, xdpf->len);
 			total_bytes += xdpf->len;
@@ -769,7 +770,8 @@ u32 emac_xmit_xdp_frame(struct prueth_emac *emac,
 	k3_udma_glue_tx_dma_to_cppi5_addr(tx_chn->tx_chn, &buf_dma);
 	cppi5_hdesc_attach_buf(first_desc, buf_dma, xdpf->len, buf_dma, xdpf->len);
 	swdata = cppi5_hdesc_get_swdata(first_desc);
-	swdata->type = PRUETH_SWDATA_XDPF;
+	swdata->type = buff_type == PRUETH_TX_BUFF_TYPE_XDP_TX ?
+		PRUETH_SWDATA_XDPF_TX : PRUETH_SWDATA_XDPF;
 	swdata->data.xdpf = xdpf;
 
 	/* Report BQL before sending the packet */
@@ -804,6 +806,7 @@ EXPORT_SYMBOL_GPL(emac_xmit_xdp_frame);
  */
 static u32 emac_run_xdp(struct prueth_emac *emac, struct xdp_buff *xdp, u32 *len)
 {
+	enum prueth_tx_buff_type tx_buff_type;
 	struct net_device *ndev = emac->ndev;
 	struct netdev_queue *netif_txq;
 	int cpu = smp_processor_id();
@@ -826,11 +829,21 @@ static u32 emac_run_xdp(struct prueth_emac *emac, struct xdp_buff *xdp, u32 *len
 			goto drop;
 		}
 
+		/* In AF_XDP zero-copy mode xdp_convert_buff_to_frame()
+		 * clones the xsk buffer into a fresh MEM_TYPE_PAGE_ORDER0
+		 * page that is not DMA mapped. Such a frame must be mapped
+		 * via the NDO path; only a page pool-backed frame already
+		 * carries a usable page_pool DMA address.
+		 */
+		tx_buff_type = xdpf->mem_type == MEM_TYPE_PAGE_POOL ?
+				PRUETH_TX_BUFF_TYPE_XDP_TX :
+				PRUETH_TX_BUFF_TYPE_XDP_NDO;
+
 		q_idx = cpu % emac->tx_ch_num;
 		netif_txq = netdev_get_tx_queue(ndev, q_idx);
 		__netif_tx_lock(netif_txq, cpu);
 		result = emac_xmit_xdp_frame(emac, xdpf, q_idx,
-					     PRUETH_TX_BUFF_TYPE_XDP_TX);
+					     tx_buff_type);
 		__netif_tx_unlock(netif_txq);
 		if (result == ICSSG_XDP_CONSUMED) {
 			ndev->stats.tx_dropped++;
@@ -1395,6 +1408,7 @@ void prueth_tx_cleanup(void *data, dma_addr_t desc_dma)
 		dev_kfree_skb_any(skb);
 		break;
 	case PRUETH_SWDATA_XDPF:
+	case PRUETH_SWDATA_XDPF_TX:
 		xdpf = swdata->data.xdpf;
 		xdp_return_frame(xdpf);
 		break;
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index df93d15c5b78..00bb760d68a9 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -153,6 +153,7 @@ enum prueth_swdata_type {
 	PRUETH_SWDATA_CMD,
 	PRUETH_SWDATA_XDPF,
 	PRUETH_SWDATA_XSK,
+	PRUETH_SWDATA_XDPF_TX,
 };
 
 enum prueth_tx_buff_type {
-- 
2.53.0

