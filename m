Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B28D3FDC18
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 09:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786525894; cv=none; b=QRBq98axlK0jXZ8H8AONWmdhwDooaHhO5ijOCSHJr3GSLXrF6JL6gH2FgIKdWJlp6i2zVrHkNnMgh6TbrLKCUba4mCBoN80BPCj+g/bEu0wgBIAuku6f0WDZnhDlxVas2MGg1j67Jdb1qh+MsaQ7OZ5owLK8pIf8D7yizc0OAZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786525894; c=relaxed/simple;
	bh=wfYyDQUVLTGy4Z5Gq9H9mStok4P2Hny/TH2mRSNJDnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcqSwlpKFBmfU3ORXbiBpm6Q22Bfnrvd0LpAxHaKhPSNn7h3PQXIJuA2J3Y1BNDG6iqNNPLZM0m3xq/I8P6OR+ZPp+lH+UNu4EZdfjL6jjquQw6trDAH9h5Ms1GSR70UcfxHXhMRiYzQoL8dvZIdnWLJzSH/2bgOyGdHCdTfKNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTeg/D+I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTeg/D+I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B7E1F00ACA;
	Wed, 12 Aug 2026 09:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786525890;
	bh=2Bs6oZA5NiBSc4/LKM0sXsOJTJGQ/AIfBq8oA26b8gE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bTeg/D+IN0hi8woxhEF2HFnqgZir2orKBZWrKeF6Yc6bN+kZcm4316QrcFtYr8sI+
	 Fs9F3FTgtFmJSFjb+BZj2NbvUwXJu1+PeRkevWEdIelmO3lZbHzoJu9HtlVWEVd+GG
	 r7cS4sp+OrBH2shsh2xkwmd1OHMmW3kpF7zZ96TCx7gglT7NnSWLSqcpa31FN3YY5M
	 xURJTqOHlWzn1t7Wr1Woec44IG6tBSFLT/FDN3Ct7Rpuxggq5Qxm7pfLd/2LKKKnj2
	 h8ky74GPyl/P4suoPmOMwJ8oYQym7UOiq8vbAriQVtPao54k2urSBrrb9b8kPt1e3C
	 /Tf4ad/U5osiA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/5] net: core,vrf: Change pcpu_dstat fields to u64_stats_t
Date: Wed, 12 Aug 2026 05:11:24 -0400
Message-ID: <20260812091127.1349673-2-sashal@kernel.org>
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

From: Jeremy Kerr <jk@codeconstruct.com.au>

[ Upstream commit fa59dc2f6fc616fde3941f62ccd4adcaa21ccd47 ]

The pcpu_sw_netstats and pcpu_lstats structs both contain a set of
u64_stats_t fields for individual stats, but pcpu_dstats uses u64s
instead.

Make this consistent by using u64_stats_t across all stats types.

The per-cpu dstats are only used by the vrf driver at present, so update
that driver as part of this change.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://lore.kernel.org/r/20240607-dstats-v3-1-cc781fe116f7@codeconstruct.com.au
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: b9553558b48d ("vxlan: use pskb_network_may_pull() for transmit path header pulls")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/vrf.c         | 38 ++++++++++++++++++++++----------------
 include/linux/netdevice.h | 12 ++++++------
 2 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index bce55ad2bcd99..98140bff0e314 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -126,8 +126,8 @@ static void vrf_rx_stats(struct net_device *dev, int len)
 	struct pcpu_dstats *dstats = this_cpu_ptr(dev->dstats);
 
 	u64_stats_update_begin(&dstats->syncp);
-	dstats->rx_packets++;
-	dstats->rx_bytes += len;
+	u64_stats_inc(&dstats->rx_packets);
+	u64_stats_add(&dstats->rx_bytes, len);
 	u64_stats_update_end(&dstats->syncp);
 }
 
@@ -150,11 +150,11 @@ static void vrf_get_stats64(struct net_device *dev,
 		dstats = per_cpu_ptr(dev->dstats, i);
 		do {
 			start = u64_stats_fetch_begin(&dstats->syncp);
-			tbytes = dstats->tx_bytes;
-			tpkts = dstats->tx_packets;
-			tdrops = dstats->tx_drops;
-			rbytes = dstats->rx_bytes;
-			rpkts = dstats->rx_packets;
+			tbytes = u64_stats_read(&dstats->tx_bytes);
+			tpkts = u64_stats_read(&dstats->tx_packets);
+			tdrops = u64_stats_read(&dstats->tx_drops);
+			rbytes = u64_stats_read(&dstats->rx_bytes);
+			rpkts = u64_stats_read(&dstats->rx_packets);
 		} while (u64_stats_fetch_retry(&dstats->syncp, start));
 		stats->tx_bytes += tbytes;
 		stats->tx_packets += tpkts;
@@ -408,10 +408,15 @@ static int vrf_local_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	skb->protocol = eth_type_trans(skb, dev);
 
-	if (likely(__netif_rx(skb) == NET_RX_SUCCESS))
+	if (likely(__netif_rx(skb) == NET_RX_SUCCESS)) {
 		vrf_rx_stats(dev, len);
-	else
-		this_cpu_inc(dev->dstats->rx_drops);
+	} else {
+		struct pcpu_dstats *dstats = this_cpu_ptr(dev->dstats);
+
+		u64_stats_update_begin(&dstats->syncp);
+		u64_stats_inc(&dstats->rx_drops);
+		u64_stats_update_end(&dstats->syncp);
+	}
 
 	return NETDEV_TX_OK;
 }
@@ -599,19 +604,20 @@ static netdev_tx_t is_ip_tx_frame(struct sk_buff *skb, struct net_device *dev)
 
 static netdev_tx_t vrf_xmit(struct sk_buff *skb, struct net_device *dev)
 {
+	struct pcpu_dstats *dstats = this_cpu_ptr(dev->dstats);
+
 	int len = skb->len;
 	netdev_tx_t ret = is_ip_tx_frame(skb, dev);
 
+	u64_stats_update_begin(&dstats->syncp);
 	if (likely(ret == NET_XMIT_SUCCESS || ret == NET_XMIT_CN)) {
-		struct pcpu_dstats *dstats = this_cpu_ptr(dev->dstats);
 
-		u64_stats_update_begin(&dstats->syncp);
-		dstats->tx_packets++;
-		dstats->tx_bytes += len;
-		u64_stats_update_end(&dstats->syncp);
+		u64_stats_inc(&dstats->tx_packets);
+		u64_stats_add(&dstats->tx_bytes, len);
 	} else {
-		this_cpu_inc(dev->dstats->tx_drops);
+		u64_stats_inc(&dstats->tx_drops);
 	}
+	u64_stats_update_end(&dstats->syncp);
 
 	return ret;
 }
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 74474139fb9ac..dfba3cec76b49 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2746,12 +2746,12 @@ struct pcpu_sw_netstats {
 } __aligned(4 * sizeof(u64));
 
 struct pcpu_dstats {
-	u64			rx_packets;
-	u64			rx_bytes;
-	u64			rx_drops;
-	u64			tx_packets;
-	u64			tx_bytes;
-	u64			tx_drops;
+	u64_stats_t		rx_packets;
+	u64_stats_t		rx_bytes;
+	u64_stats_t		rx_drops;
+	u64_stats_t		tx_packets;
+	u64_stats_t		tx_bytes;
+	u64_stats_t		tx_drops;
 	struct u64_stats_sync	syncp;
 } __aligned(8 * sizeof(u64));
 
-- 
2.53.0

