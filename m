Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B685402BA1
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 09:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786525896; cv=none; b=MvMWkrlZkMkDkHvqgeieRiHTccudHLQP2hu55KSjyvp7+kmlmfrNSdU57CAYa2ey16DHPjlvQXHSxotMH7LsHxXkXoDNZU4ZmgFOq2nMpG68DCD3kLD1/JJmgNAZvDpTF2rcn5e2EPJkPZpL6t5v5JZq59DOjBo7hPgYg1t19/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786525896; c=relaxed/simple;
	bh=xdeoSQaPM8KD7Qms8qrxkiuY82cACCBMERyqpFpFH58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SCMzYfySxnS31nwLvOFyX+ziM1TqJaQY5/AFzIorLGsf2U8UQLNZS4oz39gzVZvNQvJCUePk+39NPwzZNjUw7YqgQvuDjpsg4qssO4a0uzaiRJNBvICI15wM3KC7xP1Cg/+IcqmgUbJ1i3T6an/1szhxu3Og6SnjCdXba2tK6fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRKGRLPU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRKGRLPU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5680F1F00A3F;
	Wed, 12 Aug 2026 09:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786525891;
	bh=TbwJEibh1bV7+N/jfwDeo+Vr/JcDsP7FPEQHVFDfQPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dRKGRLPUA0I9kwDxphDsVHX49Mod7Z64H3EfsrV3N9QZ4VBuGFp2/UNbKKSVvgYvb
	 oFqhNM38/UmdV2EBg0sYvIDJnPvhcc4cl9SnpoI0si0NAXrwtFNhreiTtHOTvdRUdk
	 qVIYn5CrVFZsVgx/U2cpxkIsGiw1VgD2xcOZBesD1eO8VKK1HYSk5zN6G5uBRlU/fV
	 9ohJIv/LlMJyTZH7wUgkVlLVeCXPU3SNELgKgDaAhYS2WXUilvalbKgeZQ5P31VGO6
	 V0KKsbBtxqBN5Ctvtv/caUW5T+8tjCHDDrt5B+qo2++OnzJCcuAYjAkkHvAh3CAzJ0
	 7KyLrGDH5eaTA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guillaume Nault <gnault@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/5] vxlan: Handle stats using NETDEV_PCPU_STAT_DSTATS.
Date: Wed, 12 Aug 2026 05:11:26 -0400
Message-ID: <20260812091127.1349673-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812091127.1349673-1-sashal@kernel.org>
References: <2026080500-gloomily-getup-2a3e@gregkh>
 <20260812091127.1349673-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guillaume Nault <gnault@redhat.com>

[ Upstream commit be226352e8dc77d3313c096b2d8e7f69bf6980fc ]

VXLAN uses the TSTATS infrastructure (dev_sw_netstats_*()) for RX and
TX packet counters. It also uses the device core stats
(dev_core_stats_*()) for RX and TX drops.

Let's consolidate that using the DSTATS infrastructure, which can
handle both packet counters and packet drops. Statistics that don't
fit DSTATS are still updated atomically with DEV_STATS_INC().

While there, convert the "len" variable of vxlan_encap_bypass() to
unsigned int, to respect the types of skb->len and
dev_dstats_[rt]x_add().

Signed-off-by: Guillaume Nault <gnault@redhat.com>
Link: https://patch.msgid.link/145558b184b3cda77911ca5682b6eb83c3ffed8e.1733313925.git.gnault@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: b9553558b48d ("vxlan: use pskb_network_may_pull() for transmit path header pulls")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/vxlan/vxlan_core.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 752015accf586..d27f3ef2a0fb2 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1798,13 +1798,13 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 
 	if (unlikely(!(vxlan->dev->flags & IFF_UP))) {
 		rcu_read_unlock();
-		dev_core_stats_rx_dropped_inc(vxlan->dev);
+		dev_dstats_rx_dropped(vxlan->dev);
 		vxlan_vnifilter_count(vxlan, vni, vninode,
 				      VXLAN_VNI_STATS_RX_DROPS, 0);
 		goto drop;
 	}
 
-	dev_sw_netstats_rx_add(vxlan->dev, skb->len);
+	dev_dstats_rx_add(vxlan->dev, skb->len);
 	vxlan_vnifilter_count(vxlan, vni, vninode, VXLAN_VNI_STATS_RX, skb->len);
 	gro_cells_receive(&vxlan->gro_cells, skb);
 
@@ -1858,7 +1858,7 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 		goto out;
 
 	if (!pskb_may_pull(skb, arp_hdr_len(dev))) {
-		dev_core_stats_tx_dropped_inc(dev);
+		dev_dstats_tx_dropped(dev);
 		vxlan_vnifilter_count(vxlan, vni, NULL,
 				      VXLAN_VNI_STATS_TX_DROPS, 0);
 		goto out;
@@ -1916,7 +1916,7 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 		reply->pkt_type = PACKET_HOST;
 
 		if (netif_rx(reply) == NET_RX_DROP) {
-			dev_core_stats_rx_dropped_inc(dev);
+			dev_dstats_rx_dropped(dev);
 			vxlan_vnifilter_count(vxlan, vni, NULL,
 					      VXLAN_VNI_STATS_RX_DROPS, 0);
 		}
@@ -2077,7 +2077,7 @@ static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 			goto out;
 
 		if (netif_rx(reply) == NET_RX_DROP) {
-			dev_core_stats_rx_dropped_inc(dev);
+			dev_dstats_rx_dropped(dev);
 			vxlan_vnifilter_count(vxlan, vni, NULL,
 					      VXLAN_VNI_STATS_RX_DROPS, 0);
 		}
@@ -2370,8 +2370,8 @@ static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
 {
 	union vxlan_addr loopback;
 	union vxlan_addr *remote_ip = &dst_vxlan->default_dst.remote_ip;
+	unsigned int len = skb->len;
 	struct net_device *dev;
-	int len = skb->len;
 
 	skb->pkt_type = PACKET_HOST;
 	skb->encapsulation = 0;
@@ -2398,16 +2398,16 @@ static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
 	if ((dst_vxlan->cfg.flags & VXLAN_F_LEARN) && snoop)
 		vxlan_snoop(dev, &loopback, eth_hdr(skb)->h_source, 0, vni);
 
-	dev_sw_netstats_tx_add(src_vxlan->dev, 1, len);
+	dev_dstats_tx_add(src_vxlan->dev, len);
 	vxlan_vnifilter_count(src_vxlan, vni, NULL, VXLAN_VNI_STATS_TX, len);
 
 	if (__netif_rx(skb) == NET_RX_SUCCESS) {
-		dev_sw_netstats_rx_add(dst_vxlan->dev, len);
+		dev_dstats_rx_add(dst_vxlan->dev, len);
 		vxlan_vnifilter_count(dst_vxlan, vni, NULL, VXLAN_VNI_STATS_RX,
 				      len);
 	} else {
 drop:
-		dev_core_stats_rx_dropped_inc(dev);
+		dev_dstats_rx_dropped(dev);
 		vxlan_vnifilter_count(dst_vxlan, vni, NULL,
 				      VXLAN_VNI_STATS_RX_DROPS, 0);
 	}
@@ -2700,7 +2700,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 	return;
 
 drop:
-	dev_core_stats_tx_dropped_inc(dev);
+	dev_dstats_tx_dropped(dev);
 	vxlan_vnifilter_count(vxlan, vni, NULL, VXLAN_VNI_STATS_TX_DROPS, 0);
 	dev_kfree_skb(skb);
 	return;
@@ -2745,7 +2745,7 @@ static void vxlan_xmit_nh(struct sk_buff *skb, struct net_device *dev,
 	return;
 
 drop:
-	dev_core_stats_tx_dropped_inc(dev);
+	dev_dstats_tx_dropped(dev);
 	vxlan_vnifilter_count(netdev_priv(dev), vni, NULL,
 			      VXLAN_VNI_STATS_TX_DROPS, 0);
 	dev_kfree_skb(skb);
@@ -2783,7 +2783,7 @@ static netdev_tx_t vxlan_xmit_nhid(struct sk_buff *skb, struct net_device *dev,
 	return NETDEV_TX_OK;
 
 drop:
-	dev_core_stats_tx_dropped_inc(dev);
+	dev_dstats_tx_dropped(dev);
 	vxlan_vnifilter_count(netdev_priv(dev), vni, NULL,
 			      VXLAN_VNI_STATS_TX_DROPS, 0);
 	dev_kfree_skb(skb);
@@ -2881,7 +2881,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 			    !is_multicast_ether_addr(eth->h_dest))
 				vxlan_fdb_miss(vxlan, eth->h_dest);
 
-			dev_core_stats_tx_dropped_inc(dev);
+			dev_dstats_tx_dropped(dev);
 			vxlan_vnifilter_count(vxlan, vni, NULL,
 					      VXLAN_VNI_STATS_TX_DROPS, 0);
 			kfree_skb(skb);
@@ -3259,7 +3259,7 @@ static void vxlan_setup(struct net_device *dev)
 	dev->min_mtu = ETH_MIN_MTU;
 	dev->max_mtu = ETH_MAX_MTU;
 
-	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
 	INIT_LIST_HEAD(&vxlan->next);
 
 	timer_setup(&vxlan->age_timer, vxlan_cleanup, TIMER_DEFERRABLE);
-- 
2.53.0

