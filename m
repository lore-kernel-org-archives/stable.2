Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB58953FD28;
	Wed, 23 Sep 2026 14:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790174828; cv=none; b=MIhJShlqwpmTfMBJlaZSJgC3yRHFfTq0e9pCP6v2gMsIlaIgA6MM+uWy3llDdEyjWl4/C2fMtfK/GWPcUhqIdzdfXGHvIxIqS3A9/rv8D2wOSGIcGe+pea8YOnBUk+X0+UKQAAHqgHEtFwKaArXFrYTwsUos3qfGTyZsjSd5fvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790174828; c=relaxed/simple;
	bh=awIi2SW1S6jVTOUpTt7BOwVz9y44FEJZkTwgeTESkVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kPpWK1+J09LnkCCfP8VtJAb9oIs4ecQs94/uZ3YRN/Sjh/VeWMplGiFHTm6OOS83Y0Hy06a0Ic2FHxZd+2+MYuiO72EtigHmOMhgTQ4hsY/o1n0E7A+CrhQxp9/smNqc30lo/X6fgNPgrIK/rP7Ffu+8cYSkHOmZ7RXPL9dIEe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qJj1PIbs; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qJj1PIbs"
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 4FFE920B7168; Wed, 23 Sep 2026 07:46:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4FFE920B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790174778;
	bh=BdWvUD6PhTXpEULgXqv9ItmnLeR+T+Ojwl0P/kKONhM=;
	h=From:To:Cc:Subject:Date:From;
	b=qJj1PIbsphfBdS88Mg9ne0uT2rNOI9Ri0PRvbSfoJouMyvGIEhHvgJnf7VnMqvGcY
	 j3iS5g3Rr77YUyTNpzF+qQxVAiTiQnZEQA1FE4VLjj7/oIS5VTfQulR+sE1Q9LCpJr
	 deFM/Qr2D2NsGbeh1ukNnVgjhmzkiB/FB+tGRclU=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: netdev@vger.kernel.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Simon Horman <horms@kernel.org>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Aditya Garg <gargaditya@linux.microsoft.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net: mana: reserve RX buffer headroom to fix forwarding performance
Date: Wed, 23 Sep 2026 10:45:00 -0400
Message-ID: <20260923144500.4073380-1-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 730ff06d3f5c ("net: mana: Use page pool fragments for RX buffers
instead of full pages to improve memory efficiency.") started handing
out RX buffers with zero headroom so that two buffers fit into one page
at the default MTU.

The MANA TX path, however, stores the per scatter-gather entry DMA
mappings in `struct mana_skb_head` at skb->head, and mana_start_xmit()
therefore calls skb_cow_head(skb, MANA_HEADROOM). The port advertises
this requirement as ndev->needed_headroom = MANA_HEADROOM.

As a result every packet that is received and then forwarded out of a
MANA port fails the skb_cow() in ip_forward() and gets reallocated and
copied by pskb_expand_head(). This is invisible to a plain RX or TX
workload, but it puts a full skb reallocation plus memcpy on the hot
path of every single forwarded packet, which is exactly what a
router/NVA workload does.

Restore the headroom. Note that reserving MANA_HEADROOM (232) is not
enough: ip_forward() asks for LL_RESERVED_SPACE(dev), which rounds
hard_header_len + needed_headroom up to HH_DATA_MOD and is 256 bytes on
ethernet. Use LL_RESERVED_SPACE() directly so the value keeps tracking
both constants.

At the default MTU on a 4K page this means a buffer no longer fits twice
into a page (SKB_DATA_ALIGN(1500 + MANA_RXBUF_PAD + 256) = 2112), so the
frag-vs-single decision is now made by computing the real buffer size
instead of comparing the MTU against PAGE_SIZE / 2. The page_pool
fragment path is still used wherever at least two buffers genuinely fit,
e.g. on 16K and 64K page sizes.

Measured on an Azure VM with a MANA NIC acting as a forwarding NVA (UDP,
1400 byte payload, 4 streams, 8 Gbps offered, only the forwarding
node's kernel differs), 8 runs each, median:

                  forwarded pps    throughput
  before              272,830       3.06 Gbps
  after               390,560       4.37 Gbps   (+43%)

perf on the forwarding node, same workload:

                  memset_orig   __pi_memcpy   pskb_expand_head
  before             10.07%         3.96%         present
  after               0.94%         0.64%         gone

Cc: stable@vger.kernel.org
Fixes: 730ff06d3f5c ("net: mana: Use page pool fragments for RX buffers instead of full pages to improve memory efficiency.")
Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 58 ++++++++++++++-----
 1 file changed, 44 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 591fb4191d90d..e3f3b33ba9062 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -758,6 +758,36 @@ static void *mana_get_rxbuf_pre(struct mana_rxq *rxq, dma_addr_t *da)
 	return va;
 }
 
+/* RX buffers must be allocated with enough headroom for the TX path:
+ * mana_start_xmit() stores the SGE DMA mappings in struct mana_skb_head at
+ * skb->head, which is why the port advertises ndev->needed_headroom =
+ * MANA_HEADROOM.
+ *
+ * An skb that is forwarded out of a MANA port has to satisfy
+ * skb_cow(skb, LL_RESERVED_SPACE(dev) + ...) in ip_forward(), so reserve
+ * LL_RESERVED_SPACE() here rather than just MANA_HEADROOM - it rounds
+ * hard_header_len + needed_headroom up to HH_DATA_MOD and is therefore
+ * larger. Reserving less makes every forwarded packet get reallocated and
+ * copied by pskb_expand_head().
+ */
+static u32 mana_get_rxbuf_headroom(struct mana_port_context *apc)
+{
+	u32 headroom = LL_RESERVED_SPACE(apc->ndev);
+
+	if (mana_xdp_get(apc))
+		return max_t(u32, headroom, XDP_PACKET_HEADROOM);
+
+	return headroom;
+}
+
+static u32 mana_get_rxbuf_size(struct mana_port_context *apc, u32 mtu)
+{
+	u32 len = SKB_DATA_ALIGN(mtu + MANA_RXBUF_PAD +
+				 mana_get_rxbuf_headroom(apc));
+
+	return ALIGN(len, MANA_RX_FRAG_ALIGNMENT);
+}
+
 static bool
 mana_use_single_rxbuf_per_page(struct mana_port_context *apc, u32 mtu)
 {
@@ -770,11 +800,16 @@ mana_use_single_rxbuf_per_page(struct mana_port_context *apc, u32 mtu)
 	if (apc->priv_flags & BIT(MANA_PRIV_FLAG_USE_FULL_PAGE_RXBUF))
 		return true;
 
-	/* For xdp and jumbo frames make sure only one packet fits per page. */
-	if (mtu + MANA_RXBUF_PAD > PAGE_SIZE / 2 || mana_xdp_get(apc))
+	/* For xdp make sure only one packet fits per page. */
+	if (mana_xdp_get(apc))
 		return true;
 
-	return false;
+	/* Only use the page_pool fragment path when at least two buffers,
+	 * including the headroom each of them has to reserve, actually fit
+	 * into one page. Otherwise the fragment path degenerates into one
+	 * buffer per page while still paying the fragment accounting cost.
+	 */
+	return PAGE_SIZE / mana_get_rxbuf_size(apc, mtu) < 2;
 }
 
 /* Get RX buffer's data size, alloc size, XDP headroom based on MTU */
@@ -782,20 +817,19 @@ static void mana_get_rxbuf_cfg(struct mana_port_context *apc,
 			       int mtu, u32 *datasize, u32 *alloc_size,
 			       u32 *headroom, u32 *frag_count)
 {
-	u32 len, buf_size;
+	u32 buf_size;
 
 	/* Calculate datasize first (consistent across all cases) */
 	*datasize = mtu + ETH_HLEN;
 
+	*headroom = mana_get_rxbuf_headroom(apc);
+
 	if (mana_use_single_rxbuf_per_page(apc, mtu)) {
-		if (mana_xdp_get(apc)) {
-			*headroom = XDP_PACKET_HEADROOM;
+		if (mana_xdp_get(apc))
 			*alloc_size = PAGE_SIZE;
-		} else {
-			*headroom = 0; /* no support for XDP */
+		else
 			*alloc_size = SKB_DATA_ALIGN(mtu + MANA_RXBUF_PAD +
 						     *headroom);
-		}
 
 		*frag_count = 1;
 
@@ -809,11 +843,7 @@ static void mana_get_rxbuf_cfg(struct mana_port_context *apc,
 	}
 
 	/* Standard MTU case - optimize for multiple packets per page */
-	*headroom = 0;
-
-	/* Calculate base buffer size needed */
-	len = SKB_DATA_ALIGN(mtu + MANA_RXBUF_PAD + *headroom);
-	buf_size = ALIGN(len, MANA_RX_FRAG_ALIGNMENT);
+	buf_size = mana_get_rxbuf_size(apc, mtu);
 
 	/* Calculate how many packets can fit in a page */
 	*frag_count = PAGE_SIZE / buf_size;
-- 
2.55.0

