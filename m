Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF4C3FFF94
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 09:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786525894; cv=none; b=OxN6dRbv5iyBc8W2W/hPGL6+3hlUieGuCHzWS2e/rnEqMxfI3DSlucjn6k7vreeQCl4Bt2NML049PraP8790XBJ9yUEulPj+cHuHwDwmrUl4Li6t2F7oeYviW3PZh3HguAysWSFTxItOxkG7i/Mcbw7FnAwCFS7+pI3zr3RCX2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786525894; c=relaxed/simple;
	bh=oNzX8UrQwIGvg5S/zMDn5uT90WZBAXFANqe9hIDxcso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LzyQhyqLXubeqAYkPwNJfdKxMz+FPxvFaoovHjZX7299iKNSC32SsSqlMB+9CEE+aJaTbZjIRtOjcGb01SRhatN5z+GT2OTm0JFa3wfGz4XKByny1tNtqyJk6OIsR8mmKf+TjFu0M5sSyfi1geLczEqTo/cY3+ahngMo0hHAtSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9Cdz+n1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9Cdz+n1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957351F00A3E;
	Wed, 12 Aug 2026 09:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786525891;
	bh=BjodcFMYuOhiikfjK+97/i1nHHGLmkjAfEMMAERlw6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G9Cdz+n1kZ/ZDtOu4KymcgA0uCdontuTLbIOuevApmQT7zhZ4B2C/Q+o7+1gL2ldB
	 qkZV8FcbYXaSFaCexdBi5h9ybcO1mBAl5QJ1ulyIPTMFpehFSw16d2jKSOD4hhE+2e
	 R609CIHMwjE6eiH5qKNMh8HAyzT2UwLxtFePTN5QRO3yHdshV7ZJyevpSNi9tZb2dJ
	 6pXklRIzm0b3CH5DhPmIJjhr6G5440pU54yMhEQPCyHodPQRPzskIkRRLqruh2zEdL
	 cusJduCVRkszHlLj++Vky7tXgKyFCqzGzgbTfc+pYZhNLEIO6qsk03YIurh2SOQRV2
	 GvCwKqK8frdSA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guillaume Nault <gnault@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/5] vrf: Make pcpu_dstats update functions available to other modules.
Date: Wed, 12 Aug 2026 05:11:25 -0400
Message-ID: <20260812091127.1349673-3-sashal@kernel.org>
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
index 98140bff0e314..8f435f58a8886 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -121,16 +121,6 @@ struct net_vrf {
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
@@ -395,7 +385,7 @@ static bool qdisc_tx_is_default(const struct net_device *dev)
 static int vrf_local_xmit(struct sk_buff *skb, struct net_device *dev,
 			  struct dst_entry *dst)
 {
-	int len = skb->len;
+	unsigned int len = skb->len;
 
 	skb_orphan(skb);
 
@@ -408,15 +398,10 @@ static int vrf_local_xmit(struct sk_buff *skb, struct net_device *dev,
 
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
@@ -604,20 +589,14 @@ static netdev_tx_t is_ip_tx_frame(struct sk_buff *skb, struct net_device *dev)
 
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
@@ -1400,7 +1379,7 @@ static struct sk_buff *vrf_ip6_rcv(struct net_device *vrf_dev,
 	if (!is_ndisc) {
 		struct net_device *orig_dev = skb->dev;
 
-		vrf_rx_stats(vrf_dev, skb->len);
+		dev_dstats_rx_add(vrf_dev, skb->len);
 		skb->dev = vrf_dev;
 		skb->skb_iif = vrf_dev->ifindex;
 
@@ -1456,7 +1435,7 @@ static struct sk_buff *vrf_ip_rcv(struct net_device *vrf_dev,
 		goto out;
 	}
 
-	vrf_rx_stats(vrf_dev, skb->len);
+	dev_dstats_rx_add(vrf_dev, skb->len);
 
 	if (!list_empty(&vrf_dev->ptype_all)) {
 		int err;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index dfba3cec76b49..76191644aa0b5 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2795,6 +2795,46 @@ static inline void dev_lstats_add(struct net_device *dev, unsigned int len)
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

