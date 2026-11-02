Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.14.198.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793656448;
	b=4sHeY04IOR4QBXZ66x6wgP02Nrj9nBxcRmmSg3HDruT/h6fN6b0mJ94pwRyET+8JQv9A
	 3hPtqi7hjDZARUGKwWg9/uy8O+dW8jc2zupE9k5t6QYtoCZjfzLlFfbaaCd7PIZ0UJTdh
	 34xzy1f8400fWKXQpDyQMw5zDaslaiMNrGQ6lseJFs94z14E3lV24G9Cm0Kgff5UhrZKC
	 4vWdIaSMflc8QQHTzJrUEwUYvW4v3rPtu94Dhiv0crSrP2Z16cleyxpQvHXsdttjtoJu0
	 28qUf/N+MFAlL2iHH5A/jCooZqgQsCal+g266zIyKYjc33Wxs9AmY0yZavNdiLea1KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793656448;
	h=DMARC-Filter:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Received:DKIM-Signature;
	bh=Si1SlwaSuA8jJ/s8kmTXAZJRSzK+WvbYpL5ETHVz/ms=;
	b=KNyRI4av4yjyn1W9Gwae/ahcFIiwDw+MolH/RLYoR8+VhxtUrDGi6t2a6Nx2htKvRZ5Q
	 Rabvu1/DZUEj6ezL6e8ywgYQZVB5WuUtAV7Qx6kNneT8228sNA3oQMPEPBWr07SZd/brg
	 1+iUCbAu5EJGOdLtUhUt5mauaBFKk+eHi3E4MIMvO39iO3t6qk3W0UTuvg1AIHjNwgIxs
	 7Fh29QcUFMxPpGQxdQTCSsl4tq4oPJETit+iSqbGWRejhd9dcZmwq7c2YfL3P5fBXV4GZ
	 Okl8RhElQsxbaT4X0Vf/3DAJsEa9ExfQ1JJ5dLCs3c8oSUlq/x3WM2cEgKca3V3BOEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rimpianto.com;
	spf=pass smtp.mailfrom=rimpianto.com;
	dkim=pass header.d=rimpianto.com header.i=@rimpianto.com header.a=rsa-sha256 header.s=s20260314391 header.b=HNENlrZ9;
	arc=none smtp.remote-ip=46.14.198.178
Received: from mail.rimpianto.com (mail.rimpianto.com [46.14.198.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41870606A324;
	Mon,  2 Nov 2026 21:54:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41870606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rimpianto.com header.i=@rimpianto.com header.a=rsa-sha256 header.s=s20260314391 header.b=HNENlrZ9
Authentication-Results: mail.rimpianto.com;
	auth=pass (plain)
From: Federico Musto <federico@rimpianto.com>
To: Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Federico Musto <federico@rimpianto.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: atl1c: free the RX buffer when the descriptor reports an error
Date: Mon,  2 Nov 2026 22:52:53 +0100
Message-ID: <20261102215253.68185-1-federico@rimpianto.com>
X-Mailer: git-send-email 2.54.0
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
Received: from localhost (Unknown [127.0.0.1])
	by mail.rimpianto.com (Haraka) with ESMTPSA id 428EE241-5021-4E65-9566-B0993DB83854.1
	envelope-from <federico@rimpianto.com>
	tls TLS_AES_256_GCM_SHA384 (authenticated bits=0);
	Mon, 02 Nov 2026 22:52:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rimpianto.com;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=s20260314391; t=1793656373;
 bh=Si1SlwaSuA8jJ/s8kmTXAZJRSzK+WvbYpL5ETHVz/ms=;
 b=HNENlrZ9LBxVy+fUNXnLJtGsaGIM6QZRucljRInITP1uNoIwcEEdzQ4Ivhx8yqx3yrwepaEiN
 z11mY82BRH/xyUGiaDXl1N2Kxg+PrLAi8lIII574OsXz+Iow2UgDUjXWDoXOl/o9Dj27RvzO0Wi
 FcnbUNqcHa+bVH0DCQsQ++StUkcNbN6L8ejGyZL9Op9PKn6tcsTD8Y1WYbGOXFRoMsG1kHyJ4bR
 jwpax6lIIYDnvrVsWdI6M1fNcTl8oevpv2uom12f4rQ6AnOqCTGb4ck3axGeHgWPztow9D0wYL+
 qkqtRh2GLXWrniqLDiEC+hMoQZT0Fkj6KSJ2xtEOaSIA==

atl1c_clean_rx() drops a frame whose return descriptor carries
RRS_RX_ERR_SUM or RRS_802_3_LEN_ERR by calling atl1c_clean_rfd(), which
only marks the RFD free and clears the skb pointer.  Nothing unmaps the DMA
mapping and nothing frees the skb, so every errored frame - CRC, alignment,
truncation, runt - leaks one skb and one DMA mapping.  The driver uses a
32-bit DMA mask, so on a host without an IOMMU each of those mappings also
pins a swiotlb slot.

Unmap and free before the RFD is recycled.  Factor the RFD lookup and
DMA unmap into a helper shared with the good path, using le32_to_cpu() when
decoding the descriptor index.  The hardware already counts these frames in
its own error counters, which atl1c_get_stats() reports, so no software
counter is added here.

Fixes: 43250ddd75a3 ("atl1c: Atheros L1C Gigabit Ethernet driver")
Cc: stable@vger.kernel.org
Signed-off-by: Federico Musto <federico@rimpianto.com>
---
v1 -> v2, after Paolo Abeni's review:
 - decode rrs->word0 with le32_to_cpu() before extracting the RFD index;
   this fixes the sparse warning on the new code
 - factor the RFD lookup and DMA unmap into atl1c_unmap_rx_buffer(), shared
   by the error and good paths instead of duplicating them

v1: https://lore.kernel.org/netdev/20261027115156.17128-1-federico@rimpianto.com/

Spotted while reviewing a fix for a different problem in the same function
(skb_over_panic on oversized RX frames), by the Sashiko review bot.  It is
independent of that patch and applies on its own.

The guard on buffer_info->skb is there because the slot can be empty after a
reset; rfd_num != 1 stays on the old path, since multi-RFD is not supported
by this driver anywhere else either.
---
 .../net/ethernet/atheros/atl1c/atl1c_main.c   | 33 +++++++++++++++----
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
index eddd840..689941e 100644
--- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
@@ -1864,6 +1864,23 @@ static void atl1c_clean_rfd(struct atl1c_rfd_ring *rfd_ring,
 	rfd_ring->next_to_clean = rfd_index;
 }
 
+static struct atl1c_buffer *
+atl1c_unmap_rx_buffer(struct pci_dev *pdev, struct atl1c_rfd_ring *rfd_ring,
+		      struct atl1c_recv_ret_status *rrs)
+{
+	struct atl1c_buffer *buffer_info;
+	u16 rfd_index;
+
+	rfd_index = (le32_to_cpu(rrs->word0) >> RRS_RX_RFD_INDEX_SHIFT) &
+		    RRS_RX_RFD_INDEX_MASK;
+	buffer_info = &rfd_ring->buffer_info[rfd_index];
+	if (buffer_info->skb)
+		dma_unmap_single(&pdev->dev, buffer_info->dma,
+				 buffer_info->length, DMA_FROM_DEVICE);
+
+	return buffer_info;
+}
+
 /**
  * atl1c_clean_rx - NAPI Rx polling callback
  * @napi: napi info
@@ -1874,7 +1891,7 @@ static int atl1c_clean_rx(struct napi_struct *napi, int budget)
 	struct atl1c_rrd_ring *rrd_ring =
 		container_of(napi, struct atl1c_rrd_ring, napi);
 	struct atl1c_adapter *adapter = rrd_ring->adapter;
-	u16 rfd_num, rfd_index;
+	u16 rfd_num;
 	u16 length;
 	struct pci_dev *pdev = adapter->pdev;
 	struct net_device *netdev  = adapter->netdev;
@@ -1908,6 +1925,14 @@ static int atl1c_clean_rx(struct napi_struct *napi, int budget)
 rrs_checked:
 		atl1c_clean_rrd(rrd_ring, rrs, rfd_num);
 		if (rrs->word3 & (RRS_RX_ERR_SUM | RRS_802_3_LEN_ERR)) {
+			/* atl1c_clean_rfd() drops the only pointer to the skb. */
+			if (likely(rfd_num == 1)) {
+				buffer_info = atl1c_unmap_rx_buffer(pdev, rfd_ring,
+								    rrs);
+				if (buffer_info->skb)
+					kfree_skb_reason(buffer_info->skb,
+							 SKB_DROP_REASON_NOT_SPECIFIED);
+			}
 			atl1c_clean_rfd(rfd_ring, rrs, rfd_num);
 			if (netif_msg_rx_err(adapter))
 				dev_warn(&pdev->dev,
@@ -1920,11 +1945,7 @@ rrs_checked:
 				RRS_PKT_SIZE_MASK);
 		/* Good Receive */
 		if (likely(rfd_num == 1)) {
-			rfd_index = (rrs->word0 >> RRS_RX_RFD_INDEX_SHIFT) &
-					RRS_RX_RFD_INDEX_MASK;
-			buffer_info = &rfd_ring->buffer_info[rfd_index];
-			dma_unmap_single(&pdev->dev, buffer_info->dma,
-					 buffer_info->length, DMA_FROM_DEVICE);
+			buffer_info = atl1c_unmap_rx_buffer(pdev, rfd_ring, rrs);
 			skb = buffer_info->skb;
 		} else {
 			/* TODO */
-- 
2.54.0 (Apple Git-157)

