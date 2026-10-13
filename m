Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FDE51A121
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 14:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902952; cv=none; b=L6AHizzZICCi+kJcg5g9SCB/xnEELdjJdkvzfYnhFqw8TFlIoPC6G2ro+DeTL15L59iDQWFMeCkh05xG4k97ZtqG2PwexV4fjS5+9jpEOtyhcZqxSJSGxU4KkmPWqC6HSuGkv45PufSz2ZOguowO0nMAtYqPjTQCX0y3Ew97MD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902952; c=relaxed/simple;
	bh=ySNQcrOXBe3v3jcsjBCEu4y+LzdNUbdoo8aFHI3R56Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pUr4/LfJSoBD0MkrpiGPIwPP6WZSQQPYQQ8OHm8U3LTY3Qh0O3AkrtlGcu6y5x/pmjsyaeai5wzBKmCDEinNlCqZ5DX4xcQPBoT/AT+7fgAR9FAn577H3Zjxo9kyXxcuVlDAeMjFHBW4MB9InDUQ24wt9k6RpAbmedPdSC8utP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ft874wua; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ft874wua"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D131F00893;
	Tue, 13 Oct 2026 14:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791902950;
	bh=KjBX3sBmXBsJDOHWC0F+q1wCkli7gFZ0/plbsXUgz94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ft874wuav8UZGUauFV0sqnHWL8VxPSoXNV2ZVFy49Lz3ZYM9SwMYS7bRXH+Je5lPh
	 UTP99eylV/ouIxJmjuWBdwaJPvD3U3ql1W57ZAdCQymUD2WW6rhYqJj4sSlwmSfsdD
	 N/xFuQMdJNdVy6a2vaSEcDObhY3LwoGgS+JCcg+U1RuGHKkeuu8CVM16ux6yjgD3gg
	 XRCtjIH/nfau1PZPJh3x+/lAkCYM2++1N4YIAL18+GhQParxsC/6Yqu8+AJe+jN7il
	 P+mhoekz6A0f8/UphIr76040c/0gcffkFoxEOtt8kKHN9FkcMskZ1BKpfV91zvw1d/
	 h5i8ODjzhJvoQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 2/2] net: mana: reserve RX buffer headroom to fix forwarding performance
Date: Tue, 13 Oct 2026 10:49:07 -0400
Message-ID: <20261013143851.3960965-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013143851.3960965-1-sashal@kernel.org>
References: <2026101213-empirical-glancing-002d@gregkh>
 <20261013143851.3960965-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>

[ Upstream commit 259c4a519100e9182f264f8009ee212b32774277 ]

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
both constants. Also, since LL_RESERVED_SPACE() tracks MANA_HEADROOM,
it grows with MAX_SKB_FRAGS and for MAX_SKB_FRAGS >= 19 it is greater
than 256, so we have to account for that by using the headroom the RX
queue actually uses (instead of assuming XDP_PACKET_HEADROOM) and
turning MANA_XDP_MTU_MAX into MANA_XDP_MTU_MAX(ndev) (note that at the
default CONFIG_MAX_SKB_FRAGS=17 they are equivalent).

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
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20261003013647.2051416-1-hamzamahfooz@linux.microsoft.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ sashal: called mana_single_rxbuf_per_page_forced() directly to accommodate missing full-page-rx support. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/microsoft/mana/mana_bpf.c    |  8 +--
 drivers/net/ethernet/microsoft/mana/mana_en.c | 60 ++++++++++++++-----
 include/net/mana/mana.h                       | 14 ++++-
 3 files changed, 63 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_bpf.c b/drivers/net/ethernet/microsoft/mana/mana_bpf.c
index 5c9961ee9747a..b27fd9b8c4f6d 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_bpf.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_bpf.c
@@ -91,7 +91,7 @@ u32 mana_run_xdp(struct net_device *ndev, struct mana_rxq *rxq,
 		goto out;
 
 	xdp_init_buff(xdp, PAGE_SIZE, &rxq->xdp_rxq);
-	xdp_prepare_buff(xdp, buf_va, XDP_PACKET_HEADROOM, pkt_len, true);
+	xdp_prepare_buff(xdp, buf_va, rxq->headroom, pkt_len, true);
 
 	act = bpf_prog_run_xdp(prog, xdp);
 
@@ -183,9 +183,9 @@ static int mana_xdp_set(struct net_device *ndev, struct bpf_prog *prog,
 	if (!old_prog && !prog)
 		return 0;
 
-	if (prog && ndev->mtu > MANA_XDP_MTU_MAX) {
+	if (prog && ndev->mtu > MANA_XDP_MTU_MAX(ndev)) {
 		netdev_err(ndev, "XDP: mtu:%u too large, mtu_max:%lu\n",
-			   ndev->mtu, MANA_XDP_MTU_MAX);
+			   ndev->mtu, MANA_XDP_MTU_MAX(ndev));
 		NL_SET_ERR_MSG_MOD(extack, "XDP: mtu too large");
 
 		return -EOPNOTSUPP;
@@ -238,7 +238,7 @@ static int mana_xdp_set(struct net_device *ndev, struct bpf_prog *prog,
 		bpf_prog_put(old_prog);
 
 	if (prog)
-		ndev->max_mtu = min_t(unsigned int, MANA_XDP_MTU_MAX,
+		ndev->max_mtu = min_t(unsigned int, MANA_XDP_MTU_MAX(ndev),
 				      gc->adapter_mtu - ETH_HLEN);
 	else
 		ndev->max_mtu = gc->adapter_mtu - ETH_HLEN;
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 8fb29dcddf8e2..af5d4a4f56f16 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -755,26 +755,62 @@ static void *mana_get_rxbuf_pre(struct mana_rxq *rxq, dma_addr_t *da)
 	return va;
 }
 
-/* Get RX buffer's data size, alloc size, XDP headroom based on MTU */
+/* Reserve enough headroom to satisfy the skb_cow() in ip_forward() and avoid
+ * reallocation: the TX path keeps the SGE DMA mappings in struct mana_skb_head
+ * at skb->head, so the port advertises ndev->needed_headroom = MANA_HEADROOM.
+ */
+static u32 mana_get_rxbuf_headroom(struct mana_port_context *apc)
+{
+	if (mana_xdp_get(apc))
+		return mana_xdp_headroom(apc->ndev);
+
+	return LL_RESERVED_SPACE(apc->ndev);
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
+/* Returns true when one RX buffer per page is already required by XDP or by
+ * the buffer size implied by the MTU, i.e. regardless of the
+ * MANA_PRIV_FLAG_USE_FULL_PAGE_RXBUF private flag.
+ */
+bool mana_single_rxbuf_per_page_forced(struct mana_port_context *apc, u32 mtu)
+{
+	/* For xdp make sure only one packet fits per page. */
+	if (mana_xdp_get(apc))
+		return true;
+
+	/* Only use the page_pool fragment path when at least two buffers,
+	 * including the headroom each of them has to reserve, actually fit
+	 * into one page. Otherwise the fragment path degenerates into one
+	 * buffer per page while still paying the fragment accounting cost.
+	 */
+	return PAGE_SIZE / mana_get_rxbuf_size(apc, mtu) < 2;
+}
+
+/* Get RX buffer's data size, alloc size, headroom and frag count based on MTU */
 static void mana_get_rxbuf_cfg(struct mana_port_context *apc,
 			       int mtu, u32 *datasize, u32 *alloc_size,
 			       u32 *headroom, u32 *frag_count)
 {
-	u32 len, buf_size;
+	u32 buf_size;
 
 	/* Calculate datasize first (consistent across all cases) */
 	*datasize = mtu + ETH_HLEN;
 
-	/* For xdp and jumbo frames make sure only one packet fits per page */
-	if (mtu + MANA_RXBUF_PAD > PAGE_SIZE / 2 || mana_xdp_get(apc)) {
-		if (mana_xdp_get(apc)) {
-			*headroom = XDP_PACKET_HEADROOM;
+	*headroom = mana_get_rxbuf_headroom(apc);
+
+	if (mana_single_rxbuf_per_page_forced(apc, mtu)) {
+		if (mana_xdp_get(apc))
 			*alloc_size = PAGE_SIZE;
-		} else {
-			*headroom = 0; /* no support for XDP */
+		else
 			*alloc_size = SKB_DATA_ALIGN(mtu + MANA_RXBUF_PAD +
 						     *headroom);
-		}
 
 		*frag_count = 1;
 
@@ -788,11 +824,7 @@ static void mana_get_rxbuf_cfg(struct mana_port_context *apc,
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
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 04acb6791dbd9..cd44856fa474c 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -328,7 +328,18 @@ struct mana_recv_buf_oob {
 #define MANA_RXBUF_PAD (SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) \
 			+ ETH_HLEN)
 
-#define MANA_XDP_MTU_MAX (PAGE_SIZE - MANA_RXBUF_PAD - XDP_PACKET_HEADROOM)
+/* Headroom an RX buffer has to reserve while XDP is attached: the XDP program
+ * needs XDP_PACKET_HEADROOM, and the TX path needs LL_RESERVED_SPACE() (see
+ * mana_get_rxbuf_headroom()). LL_RESERVED_SPACE() grows with MAX_SKB_FRAGS and
+ * exceeds XDP_PACKET_HEADROOM once CONFIG_MAX_SKB_FRAGS is 19 or more.
+ */
+static inline u32 mana_xdp_headroom(struct net_device *ndev)
+{
+	return max_t(u32, LL_RESERVED_SPACE(ndev), XDP_PACKET_HEADROOM);
+}
+
+#define MANA_XDP_MTU_MAX(ndev) \
+	(PAGE_SIZE - MANA_RXBUF_PAD - mana_xdp_headroom(ndev))
 
 struct mana_rxq {
 	struct gdma_queue *gdma_rq;
@@ -625,6 +636,7 @@ int mana_query_link_cfg(struct mana_port_context *apc);
 int mana_set_bw_clamp(struct mana_port_context *apc, u32 speed,
 		      int enable_clamping);
 void mana_query_phy_stats(struct mana_port_context *apc);
+bool mana_single_rxbuf_per_page_forced(struct mana_port_context *apc, u32 mtu);
 int mana_pre_alloc_rxbufs(struct mana_port_context *apc, int mtu, int num_queues);
 void mana_pre_dealloc_rxbufs(struct mana_port_context *apc);
 void mana_unmap_skb(struct sk_buff *skb, struct mana_port_context *apc);
-- 
2.53.0

