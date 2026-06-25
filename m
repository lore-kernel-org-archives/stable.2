Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51E331E84A
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 06:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782369089; cv=none; b=SHpfef25liKwz5lsEWcerP+KXqP2qCc2xMHXlhs5u7thqiiid2seeolBpB8idQDtyocv2Szgo54tZHRDjxasB8DFpYfDRCCnNcnlAtFSnK/Z8zunH1m2AAxi0cudr0ubnYMIVayxk2gQ7Ly1JMZ2YkIlpi7C+Byfcu5soRwkYhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782369089; c=relaxed/simple;
	bh=h9ayyCO19b4D8SnctXO7asTtcaRk3bUGigIyeLr8zQk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s0iNx9ctzKLKJBbtAeCTQtjYJn2hwfErd4EEN78cKD0IRxF0i9YPpFruMhdg7rPqYdKxfO6zdiSiUdtixn3GA0BROG0HWBOMkgKvKJSWTgnpBGsB959ItRu1ArSTM/Fa6f97x08sK6c2cDAu7YVGK2dIOUTA0CPdGyi0WPfSMWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Si/QbojX; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Si/QbojX"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49249072f03so10215865e9.0
        for <stable@vger.kernel.org>; Wed, 24 Jun 2026 23:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782369086; x=1782973886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/dL5E5/PAVvSoAmR+aoTsLP141NGqcao3RnOAEaH2u8=;
        b=Si/QbojXaDFSHvSiVuRjKnLzhJbR+gerUCNc93mGkvSQkbbK/jEpa9E39iu6hbbfhY
         aN9cWtvq4LdN6K4YqIF+T0POSlKQuW3Ilmb4mIhRji7uXwVcpXGosl27FfnDv59D2bSg
         oUwC3nAw8htMCCLroCundv8Hn6rRzUVdLXBrrIIEIHTyGDz1GUwCNjOoaWgSLn1tQgGy
         HIOs2mQ727C6Xd+sAgpll51lQl0000HqN83GtW9D/otXKQ//um2/znaHaJzrXGdY2Pz2
         uLieHFZv6TSI+tS/Vofkr84qNGfsuGpIReTVi8Ks5tWQ3LrDTUKujQSQ2OfGpur0uF1y
         He4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782369086; x=1782973886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dL5E5/PAVvSoAmR+aoTsLP141NGqcao3RnOAEaH2u8=;
        b=iZ4tScDAuviT2lPBmhNrkoVAIMQynvr2vTEMCDQUY1u56cBqgBV3mbtkC2pZTSwnYO
         2TJPie+aKKTVjvb6zu7Ko4IOxVpJyJGvuywIPNh0HssFdLnY600po91juv9XshNq4dAq
         pbNVSJ0wD/DWPeKAvnw+di9dsPRqLX2zRO6XcZJRSTS3MoSSp/Kf8yEurDIYcA/m3Sog
         SAcfBmF4wXwwT4XySBgUkrbZ2LigJgAOx/MBFg0n7E18yuX4nxjBHGH118j0xCxuXIZd
         BYHWlPQPFlPd7Hedy/bi3sn7hXj9b6Y2kMFTtP4h+t7u8bMowIiivhnnzi1zi05RByed
         0iaQ==
X-Forwarded-Encrypted: i=1; AFNElJ+jy/Y8V8cfrquuGwgMZh3/Pz4DXzdKHJAPeb/HbTqJYoNHd4uinSfcUqJtppozCHRwfMrHiOI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/kcncGS5GvumsAfpykclQvTS058FHfraqKeovxpgAdmsyanJH
	kDnGiETUYd7QODzgjRaLlCMswsmeSgGq5sMPjDN5dbuIjfmEd8VWX2uW
X-Gm-Gg: AfdE7ck4hhQgxMJ0VStV8mHKT+xf6D4OCKagf8au5dOa/jIwHh6ik6a+xn7AnB3xJm4
	NxLckYOvd3cZy4XFTmLOvtKSub8vnQIvJ5t+wjhSRVWUEy2PsdhMnpYNDzIY2CvRK009ujQqzi+
	PSFGKgIR9eeMxRjYCMfK+Vyb5AVE090go+nceE0H6g4cKeQxxqlwE6jsAjSo4i9UqlBFrpFwHZi
	tz1EPlB102sYpaCOhg7vGVUZmnFQYQe3CTDF9mTgaSsraVXct9Ct2wOW1EYFUWwmwLnk18V0oLC
	5J3VUSJRCE/0SPrYiNVJdmIbZxf7kwkozvF8UkpYgnbqluh7KvfQeMj3tP3pT+BeN3er/ituh05
	HfsRa3QpTN47FET9+bdWLuo82FDqIv8zm7rH4OUrnyK4khXtEZvohZAooQI59/H+EjcbQAeGKM+
	YubyHAgBoT3q8DshIEe+czdIruShWvb5ae/DivMw8lGdrZ2MV71d3wa4NSejDy57N0P2vpBXxK
X-Received: by 2002:a05:600c:4e4b:b0:490:b724:5085 with SMTP id 5b1f17b1804b1-4926689ab05mr13119825e9.33.1782369085712;
        Wed, 24 Jun 2026 23:31:25 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c1ee01c6csm13625247f8f.14.2026.06.24.23.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 23:31:25 -0700 (PDT)
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
Subject: [PATCH net v3] net: ti: icssg-prueth: fix XDP_TX from the AF_XDP zero-copy RX path
Date: Thu, 25 Jun 2026 07:31:21 +0100
Message-ID: <20260625063121.24746-1-devnexen@gmail.com>
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
Reviewed-by: Meghana Malladi <m-malladi@ti.com>
---
v3:
 - address Meghana Malladi review nits: split the prueth_xmit_free()
   guard to stay under 80 columns, parenthesize the swdata->type
   ternary (and the matching tx_buff_type one for consistency).
 - no functional change; carry Reviewed-by.
v2: https://lore.kernel.org/netdev/20260623112225.303930-1-devnexen@gmail.com
v1: https://lore.kernel.org/netdev/20260620213756.87499-1-devnexen@gmail.com
 drivers/net/ethernet/ti/icssg/icssg_common.c | 21 +++++++++++++++++---
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |  1 +
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index 82ddef9c17d5..64ae3704481e 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -185,7 +185,8 @@ void prueth_xmit_free(struct prueth_tx_chn *tx_chn,
 	first_desc = desc;
 	next_desc = first_desc;
 	swdata = cppi5_hdesc_get_swdata(first_desc);
-	if (swdata->type == PRUETH_SWDATA_XSK)
+	if (swdata->type == PRUETH_SWDATA_XSK ||
+	    swdata->type == PRUETH_SWDATA_XDPF_TX)
 		goto free_pool;
 
 	cppi5_hdesc_get_obuf(first_desc, &buf_dma, &buf_dma_len);
@@ -259,6 +260,7 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
 			napi_consume_skb(skb, budget);
 			break;
 		case PRUETH_SWDATA_XDPF:
+		case PRUETH_SWDATA_XDPF_TX:
 			xdpf = swdata->data.xdpf;
 			dev_sw_netstats_tx_add(ndev, 1, xdpf->len);
 			total_bytes += xdpf->len;
@@ -769,7 +771,8 @@ u32 emac_xmit_xdp_frame(struct prueth_emac *emac,
 	k3_udma_glue_tx_dma_to_cppi5_addr(tx_chn->tx_chn, &buf_dma);
 	cppi5_hdesc_attach_buf(first_desc, buf_dma, xdpf->len, buf_dma, xdpf->len);
 	swdata = cppi5_hdesc_get_swdata(first_desc);
-	swdata->type = PRUETH_SWDATA_XDPF;
+	swdata->type = (buff_type == PRUETH_TX_BUFF_TYPE_XDP_TX ?
+		PRUETH_SWDATA_XDPF_TX : PRUETH_SWDATA_XDPF);
 	swdata->data.xdpf = xdpf;
 
 	/* Report BQL before sending the packet */
@@ -804,6 +807,7 @@ EXPORT_SYMBOL_GPL(emac_xmit_xdp_frame);
  */
 static u32 emac_run_xdp(struct prueth_emac *emac, struct xdp_buff *xdp, u32 *len)
 {
+	enum prueth_tx_buff_type tx_buff_type;
 	struct net_device *ndev = emac->ndev;
 	struct netdev_queue *netif_txq;
 	int cpu = smp_processor_id();
@@ -826,11 +830,21 @@ static u32 emac_run_xdp(struct prueth_emac *emac, struct xdp_buff *xdp, u32 *len
 			goto drop;
 		}
 
+		/* In AF_XDP zero-copy mode xdp_convert_buff_to_frame()
+		 * clones the xsk buffer into a fresh MEM_TYPE_PAGE_ORDER0
+		 * page that is not DMA mapped. Such a frame must be mapped
+		 * via the NDO path; only a page pool-backed frame already
+		 * carries a usable page_pool DMA address.
+		 */
+		tx_buff_type = (xdpf->mem_type == MEM_TYPE_PAGE_POOL ?
+				PRUETH_TX_BUFF_TYPE_XDP_TX :
+				PRUETH_TX_BUFF_TYPE_XDP_NDO);
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
@@ -1395,6 +1409,7 @@ void prueth_tx_cleanup(void *data, dma_addr_t desc_dma)
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

