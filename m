Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966DF204F8B
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 00:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786493351; cv=none; b=fPUoinajklEzDid9nYj8GjHJgTn/31d3sHeuikPR9Po+vZkflFNQ/pFmLMGpczkSnAI+7ACK3oxlS8TDEfHywzJ6o2Bl7Fi8kgaIUAZyi+RtwYql22+gf/m4eAQwF/m4GFOmaSNoKAg92lM0Ydr7BlX1yTBCiYNqyXORw9z/m3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786493351; c=relaxed/simple;
	bh=Irq/hiAFvy2LdoYJCMsPLXUcO4p5OER3VrJP7qh7nc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TRswqadRLREXFFnTo4SXZSvsiXth8kP6AlziE0grMTIsqCmruRHGKQxzPifUvjmc2gRpoZKuxHjqwDNVbpQp+qvgLY/E1kPw8qTq3JWeyeqlKmu7V0KeLb5FzvDA1SjuVhenajBKeyulEQMdtjxV+h0cMCjwzGq6vDOCdY7kdPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=La6pIbJd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="La6pIbJd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07ACF1F00A3A;
	Wed, 12 Aug 2026 00:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786493350;
	bh=pIESaLVo+a+cvIqSXsmMAkGa+pcbumKzvmMtL2NDj3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=La6pIbJdDiiu0mP/+mD0owCCkt5AppebosV84eAvLJiWcCGOSh7mISGF3ayacRFFL
	 NhcU9VpGa6EvSABErpM66NvSPQaolCbfK/09SJ7yRvP3zoh/0B8B48GyF8M1u0tFej
	 he8tHpJwREYJzSFpLQEnALWNw9hCU7FJjXWBtnjod2SUBEHg7nQqPlImENJTVt8uyK
	 ifUNJ5NAs1XPOgPTdulZ7GJf1fnZ2dU/xi4rfYPCGUS9qYdvT4THjoK/dK7F/V6wNx
	 MZcyfXt9eaCadF/xc7Venr44EcjY896O0KuezGixcLIt6qariTS9DE5UprwBn/Tq0R
	 BqiUjvCjOn0Ug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guillaume Nault <gnault@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] vrf: Make pcpu_dstats update functions available to other modules.
Date: Tue, 11 Aug 2026 20:09:06 -0400
Message-ID: <20260812000908.4156424-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080559-twins-crimson-3764@gregkh>
References: <2026080559-twins-crimson-3764@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guillaume Nault <gnault@redhat.com>

[ Upstream commit 18eabadd73ae60023ab05e376246bd725fb0c113 ]

Currently vrf is the only module that uses NETDEV_PCPU_STAT_DSTATS.
In order to make this kind of statistics available to other modules,
we need to define the update functions in netdevice.h.

Therefore, let's define dev_dstats_*() functions for RX and TX packet
updates (packets, bytes and drops). Use these new functions in vrf.c
instead of vrf_rx_stats() and the other manual counter updates.

While there, update the type of the "len" variables to "unsigned int",
so that there're aligned with both skb->len and the new dstats update
functions.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
Link: https://patch.msgid.link/d7a552ee382c79f4854e7fcc224cf176cd21150d.1733313925.git.gnault@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: b9553558b48d ("vxlan: use pskb_network_may_pull() for transmit path header pulls")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/vrf.c         | 49 +++++++++++----------------------------
 include/linux/netdevice.h | 40 ++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 35 deletions(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 93ecd9577f4d3..e684d59291efc 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -122,16 +122,6 @@ struct net_vrf {
 	int			ifindex;
 };
 
-static void vrf_rx_stats(struct net_device *dev, int len)
-{
-	struct pcpu_dstats *dstats = this_cpu_ptr(dev->dstats);
-
-	u64_stats_update_begin(&dstats->syncp);
-	u64_stats_inc(&dstats->rx_packets);
-	u64_stats_add(&dstats->rx_bytes, len);
-	u64_stats_update_end(&dstats->syncp);
-}
-
 static void vrf_tx_error(struct net_device *vrf_dev, struct sk_buff *skb)
 {
 	vrf_dev->stats.tx_errors++;
@@ -367,7 +357,7 @@ static bool qdisc_tx_is_default(const struct net_device *dev)
 static int vrf_local_xmit(struct sk_buff *skb, struct net_device *dev,
 			  struct dst_entry *dst)
 {
-	int len = skb->len;
+	unsigned int len = skb->len;
 
 	skb_orphan(skb);
 
@@ -380,15 +370,10 @@ static int vrf_local_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	skb->protocol = eth_type_trans(skb, dev);
 
-	if (likely(__netif_rx(skb) == NET_RX_SUCCESS)) {
-		vrf_rx_stats(dev, len);
-	} else {
-		struct pcpu_dstats *dstats = this_cpu_ptr(dev->dstats);
-
-		u64_stats_update_begin(&dstats->syncp);
-		u64_stats_inc(&dstats->rx_drops);
-		u64_stats_update_end(&dstats->syncp);
-	}
+	if (likely(__netif_rx(skb) == NET_RX_SUCCESS))
+		dev_dstats_rx_add(dev, len);
+	else
+		dev_dstats_rx_dropped(dev);
 
 	return NETDEV_TX_OK;
 }
@@ -576,20 +561,14 @@ static netdev_tx_t is_ip_tx_frame(struct sk_buff *skb, struct net_device *dev)
 
 static netdev_tx_t vrf_xmit(struct sk_buff *skb, struct net_device *dev)
 {
-	struct pcpu_dstats *dstats = this_cpu_ptr(dev->dstats);
-
-	int len = skb->len;
-	netdev_tx_t ret = is_ip_tx_frame(skb, dev);
-
-	u64_stats_update_begin(&dstats->syncp);
-	if (likely(ret == NET_XMIT_SUCCESS || ret == NET_XMIT_CN)) {
+	unsigned int len = skb->len;
+	netdev_tx_t ret;
 
-		u64_stats_inc(&dstats->tx_packets);
-		u64_stats_add(&dstats->tx_bytes, len);
-	} else {
-		u64_stats_inc(&dstats->tx_drops);
-	}
-	u64_stats_update_end(&dstats->syncp);
+	ret = is_ip_tx_frame(skb, dev);
+	if (likely(ret == NET_XMIT_SUCCESS || ret == NET_XMIT_CN))
+		dev_dstats_tx_add(dev, len);
+	else
+		dev_dstats_tx_dropped(dev);
 
 	return ret;
 }
@@ -1371,7 +1350,7 @@ static struct sk_buff *vrf_ip6_rcv(struct net_device *vrf_dev,
 	if (!is_ndisc) {
 		struct net_device *orig_dev = skb->dev;
 
-		vrf_rx_stats(vrf_dev, skb->len);
+		dev_dstats_rx_add(vrf_dev, skb->len);
 		skb->dev = vrf_dev;
 		skb->skb_iif = vrf_dev->ifindex;
 
@@ -1427,7 +1406,7 @@ static struct sk_buff *vrf_ip_rcv(struct net_device *vrf_dev,
 		goto out;
 	}
 
-	vrf_rx_stats(vrf_dev, skb->len);
+	dev_dstats_rx_add(vrf_dev, skb->len);
 
 	if (!list_empty(&vrf_dev->ptype_all)) {
 		int err;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index ea9b40b196de2..83e7393055f48 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2791,6 +2791,46 @@ static inline void dev_lstats_add(struct net_device *dev, unsigned int len)
 	u64_stats_update_end(&lstats->syncp);
 }
 
+static inline void dev_dstats_rx_add(struct net_device *dev,
+				     unsigned int len)
+{
+	struct pcpu_dstats *dstats = this_cpu_ptr(dev->dstats);
+
+	u64_stats_update_begin(&dstats->syncp);
+	u64_stats_inc(&dstats->rx_packets);
+	u64_stats_add(&dstats->rx_bytes, len);
+	u64_stats_update_end(&dstats->syncp);
+}
+
+static inline void dev_dstats_rx_dropped(struct net_device *dev)
+{
+	struct pcpu_dstats *dstats = this_cpu_ptr(dev->dstats);
+
+	u64_stats_update_begin(&dstats->syncp);
+	u64_stats_inc(&dstats->rx_drops);
+	u64_stats_update_end(&dstats->syncp);
+}
+
+static inline void dev_dstats_tx_add(struct net_device *dev,
+				     unsigned int len)
+{
+	struct pcpu_dstats *dstats = this_cpu_ptr(dev->dstats);
+
+	u64_stats_update_begin(&dstats->syncp);
+	u64_stats_inc(&dstats->tx_packets);
+	u64_stats_add(&dstats->tx_bytes, len);
+	u64_stats_update_end(&dstats->syncp);
+}
+
+static inline void dev_dstats_tx_dropped(struct net_device *dev)
+{
+	struct pcpu_dstats *dstats = this_cpu_ptr(dev->dstats);
+
+	u64_stats_update_begin(&dstats->syncp);
+	u64_stats_inc(&dstats->tx_drops);
+	u64_stats_update_end(&dstats->syncp);
+}
+
 #define __netdev_alloc_pcpu_stats(type, gfp)				\
 ({									\
 	typeof(type) __percpu *pcpu_stats = alloc_percpu_gfp(type, gfp);\
-- 
2.53.0

