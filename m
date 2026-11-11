Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794373523;
	b=fVwL5m15c2jiONNFwvZRelRmC14Szs1VtlQQlCOUdAnvSxO3zigDwDJImFpzF84Mo9Aa
	 r7Qf5PRIU9HdcsZ0OrrrmdWJuZJnGIAutwk7Vw0w1aKccVdQV0KUHY3vkZTQwfmYyyHRX
	 5R91xhmYzJEJBE6l9FtNjd++V7d4g3xZJT0I/iVYuoJYhvwCYkF9NHZyRWbeiR1H/0myM
	 kxiL/zbTQaAsqCl9M82Wx3FQZReeWxQ5NfLcYvUz7+VPRJ9m6gxDknAY35br9tuEdj1KM
	 Zc7My8GOCB5qyYy/RoRZCH2qEKsljD8E4BWn0+GTKy7YJnuSlAUS4MXJVpljHzgxYug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794373523;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/ylbcysKXKTzGnHH1MM9abp/IJKYxjqGr9JfXJrFidA=;
	b=mqclW1wwcMtwcKLiBhcc0nDp6pRBMq1L/pN5v3G89yeKalcGeZCrP7ljSUK7705scq6w
	 EbGQaQM24RvNn1ZYmVz8N6ynN3r26AnJJV++xBueTGtPCTYEDq6TS/vcvgM9d5vgBCACU
	 oYhcjlo6Gssj7s6zKFaPCdJ1RnKUqZzGKt1RR8CzZWokWrPBuapJLts+aRnYfbtn8mKpq
	 MsFWSdzzZZJxJDc4WM8BaJbCl0YOS6a5wKMx+iFC6mcrbW95H9SxmC3IsAk7XCmGCk1li
	 08HLCl9Ln7/9Fsvv0vdoGSCs3s56NMgEe+SBg5q5eXDIpCNlA0njx2U5ybhBIDJmOIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZQ2eBjsa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77204606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 05:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZQ2eBjsa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ADA51F0089F;
	Wed, 11 Nov 2026 05:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794373523;
	bh=/ylbcysKXKTzGnHH1MM9abp/IJKYxjqGr9JfXJrFidA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZQ2eBjsaVpRtwplHsRGAT6o+uLCgd7Jeno1SDZUNIe34VJsAb3Yb6LI7WyRMYdBmH
	 1l6U8wfrNFxb1fv+KFHRlYA0FXSUuwTMZ+32WXskB59Rgt3phxJAeBNsn0nyWWXRLu
	 Vu77G8wPYUSJ73j1vYaxO0q9KX2acXNvIxw5du371SMIlndQ/AjgajX/bt3l8Tp3UB
	 jjyhNRQJ7cyq/yJ2xWNV447g3ukU9/6WqTssmafGrE/ItGYzZaPAJdrzEocUiQtFqn
	 /Ow3He3HxQtSThn4xs3nF5gaiv0hzGX8n35WmcbhSB6fWj83iNohKL4YyExpkFWh6Z
	 Mpi7pAAshYBFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] ipv4: tunnels: use DEV_STATS_INC()
Date: Wed, 11 Nov 2026 00:05:19 -0500
Message-ID: <20261111050514.1221320-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055529-failed-6.1-aa1799e93f5e@kernel.org>
References: <20261107055529-failed-6.1-aa1799e93f5e@kernel.org>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit c4794d22251b979b12a6c8e2d3848b662a44fdb6 ]

Most of code paths in tunnels are lockless (eg NETIF_F_LLTX in tx).

Adopt SMP safe DEV_STATS_INC() to update dev->stats fields.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: aa1799e93f5e ("ipmr, ip6mr: validate packets injected into the register vif on xmit")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/ip_gre.c    | 10 +++++-----
 net/ipv4/ip_tunnel.c | 32 ++++++++++++++++----------------
 net/ipv4/ip_vti.c    | 20 ++++++++++----------
 net/ipv4/ipip.c      |  2 +-
 net/ipv4/ipmr.c      | 12 ++++++------
 5 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 66c35ced1e887..3648b9ca74410 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -515,7 +515,7 @@ static void gre_fb_xmit(struct sk_buff *skb, struct net_device *dev,
 
 err_free_skb:
 	kfree_skb(skb);
-	dev->stats.tx_dropped++;
+	DEV_STATS_INC(dev, tx_dropped);
 }
 
 static void erspan_fb_xmit(struct sk_buff *skb, struct net_device *dev)
@@ -597,7 +597,7 @@ static void erspan_fb_xmit(struct sk_buff *skb, struct net_device *dev)
 
 err_free_skb:
 	kfree_skb(skb);
-	dev->stats.tx_dropped++;
+	DEV_STATS_INC(dev, tx_dropped);
 }
 
 static int gre_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
@@ -671,7 +671,7 @@ static netdev_tx_t ipgre_xmit(struct sk_buff *skb,
 
 free_skb:
 	kfree_skb(skb);
-	dev->stats.tx_dropped++;
+	DEV_STATS_INC(dev, tx_dropped);
 	return NETDEV_TX_OK;
 }
 
@@ -725,7 +725,7 @@ static netdev_tx_t erspan_xmit(struct sk_buff *skb,
 
 free_skb:
 	kfree_skb(skb);
-	dev->stats.tx_dropped++;
+	DEV_STATS_INC(dev, tx_dropped);
 	return NETDEV_TX_OK;
 }
 
@@ -753,7 +753,7 @@ static netdev_tx_t gre_tap_xmit(struct sk_buff *skb,
 
 free_skb:
 	kfree_skb(skb);
-	dev->stats.tx_dropped++;
+	DEV_STATS_INC(dev, tx_dropped);
 	return NETDEV_TX_OK;
 }
 
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 826bd0487aedf..d250ed84f32b4 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -382,23 +382,23 @@ int ip_tunnel_rcv(struct ip_tunnel *tunnel, struct sk_buff *skb,
 
 #ifdef CONFIG_NET_IPGRE_BROADCAST
 	if (ipv4_is_multicast(iph->daddr)) {
-		tunnel->dev->stats.multicast++;
+		DEV_STATS_INC(tunnel->dev, multicast);
 		skb->pkt_type = PACKET_BROADCAST;
 	}
 #endif
 
 	if ((!(tpi->flags&TUNNEL_CSUM) &&  (tunnel->parms.i_flags&TUNNEL_CSUM)) ||
 	     ((tpi->flags&TUNNEL_CSUM) && !(tunnel->parms.i_flags&TUNNEL_CSUM))) {
-		tunnel->dev->stats.rx_crc_errors++;
-		tunnel->dev->stats.rx_errors++;
+		DEV_STATS_INC(tunnel->dev, rx_crc_errors);
+		DEV_STATS_INC(tunnel->dev, rx_errors);
 		goto drop;
 	}
 
 	if (tunnel->parms.i_flags&TUNNEL_SEQ) {
 		if (!(tpi->flags&TUNNEL_SEQ) ||
 		    (tunnel->i_seqno && (s32)(ntohl(tpi->seq) - tunnel->i_seqno) < 0)) {
-			tunnel->dev->stats.rx_fifo_errors++;
-			tunnel->dev->stats.rx_errors++;
+			DEV_STATS_INC(tunnel->dev, rx_fifo_errors);
+			DEV_STATS_INC(tunnel->dev, rx_errors);
 			goto drop;
 		}
 		tunnel->i_seqno = ntohl(tpi->seq) + 1;
@@ -425,8 +425,8 @@ int ip_tunnel_rcv(struct ip_tunnel *tunnel, struct sk_buff *skb,
 			net_info_ratelimited("non-ECT from %pI4 with TOS=%#x\n",
 					&iph->saddr, iph->tos);
 		if (err > 1) {
-			++tunnel->dev->stats.rx_frame_errors;
-			++tunnel->dev->stats.rx_errors;
+			DEV_STATS_INC(tunnel->dev, rx_frame_errors);
+			DEV_STATS_INC(tunnel->dev, rx_errors);
 			goto drop;
 		}
 	}
@@ -612,7 +612,7 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	if (!rt) {
 		rt = ip_route_output_key(tunnel->net, &fl4);
 		if (IS_ERR(rt)) {
-			dev->stats.tx_carrier_errors++;
+			DEV_STATS_INC(dev, tx_carrier_errors);
 			goto tx_error;
 		}
 		if (use_cache)
@@ -621,7 +621,7 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	}
 	if (rt->dst.dev == dev) {
 		ip_rt_put(rt);
-		dev->stats.collisions++;
+		DEV_STATS_INC(dev, collisions);
 		goto tx_error;
 	}
 
@@ -656,10 +656,10 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 		      df, !net_eq(tunnel->net, dev_net(dev)));
 	return;
 tx_error:
-	dev->stats.tx_errors++;
+	DEV_STATS_INC(dev, tx_errors);
 	goto kfree;
 tx_dropped:
-	dev->stats.tx_dropped++;
+	DEV_STATS_INC(dev, tx_dropped);
 kfree:
 	kfree_skb(skb);
 }
@@ -693,7 +693,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 		/* NBMA tunnel */
 
 		if (!skb_dst(skb)) {
-			dev->stats.tx_fifo_errors++;
+			DEV_STATS_INC(dev, tx_fifo_errors);
 			goto tx_error;
 		}
 
@@ -780,7 +780,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 		rt = ip_route_output_key(tunnel->net, &fl4);
 
 		if (IS_ERR(rt)) {
-			dev->stats.tx_carrier_errors++;
+			DEV_STATS_INC(dev, tx_carrier_errors);
 			goto tx_error;
 		}
 		if (use_cache)
@@ -793,7 +793,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	if (rt->dst.dev == dev) {
 		ip_rt_put(rt);
-		dev->stats.collisions++;
+		DEV_STATS_INC(dev, collisions);
 		goto tx_error;
 	}
 
@@ -834,7 +834,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	if (skb_cow_head(skb, max_headroom)) {
 		ip_rt_put(rt);
-		dev->stats.tx_dropped++;
+		DEV_STATS_INC(dev, tx_dropped);
 		kfree_skb(skb);
 		return;
 	}
@@ -850,7 +850,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	dst_link_failure(skb);
 #endif
 tx_error:
-	dev->stats.tx_errors++;
+	DEV_STATS_INC(dev, tx_errors);
 	kfree_skb(skb);
 }
 EXPORT_SYMBOL_GPL(ip_tunnel_xmit);
diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index 2e07592d8b966..cd61a417c44d9 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -107,8 +107,8 @@ static int vti_rcv_cb(struct sk_buff *skb, int err)
 	dev = tunnel->dev;
 
 	if (err) {
-		dev->stats.rx_errors++;
-		dev->stats.rx_dropped++;
+		DEV_STATS_INC(dev, rx_errors);
+		DEV_STATS_INC(dev, rx_dropped);
 
 		return 0;
 	}
@@ -183,7 +183,7 @@ static netdev_tx_t vti_xmit(struct sk_buff *skb, struct net_device *dev,
 			fl->u.ip4.flowi4_flags |= FLOWI_FLAG_ANYSRC;
 			rt = __ip_route_output_key(dev_net(dev), &fl->u.ip4);
 			if (IS_ERR(rt)) {
-				dev->stats.tx_carrier_errors++;
+				DEV_STATS_INC(dev, tx_carrier_errors);
 				goto tx_error_icmp;
 			}
 			dst = &rt->dst;
@@ -198,14 +198,14 @@ static netdev_tx_t vti_xmit(struct sk_buff *skb, struct net_device *dev,
 			if (dst->error) {
 				dst_release(dst);
 				dst = NULL;
-				dev->stats.tx_carrier_errors++;
+				DEV_STATS_INC(dev, tx_carrier_errors);
 				goto tx_error_icmp;
 			}
 			skb_dst_set(skb, dst);
 			break;
 #endif
 		default:
-			dev->stats.tx_carrier_errors++;
+			DEV_STATS_INC(dev, tx_carrier_errors);
 			goto tx_error_icmp;
 		}
 	}
@@ -213,7 +213,7 @@ static netdev_tx_t vti_xmit(struct sk_buff *skb, struct net_device *dev,
 	dst_hold(dst);
 	dst = xfrm_lookup_route(tunnel->net, dst, fl, NULL, 0);
 	if (IS_ERR(dst)) {
-		dev->stats.tx_carrier_errors++;
+		DEV_STATS_INC(dev, tx_carrier_errors);
 		goto tx_error_icmp;
 	}
 
@@ -221,7 +221,7 @@ static netdev_tx_t vti_xmit(struct sk_buff *skb, struct net_device *dev,
 		goto xmit;
 
 	if (!vti_state_check(dst->xfrm, parms->iph.daddr, parms->iph.saddr)) {
-		dev->stats.tx_carrier_errors++;
+		DEV_STATS_INC(dev, tx_carrier_errors);
 		dst_release(dst);
 		goto tx_error_icmp;
 	}
@@ -230,7 +230,7 @@ static netdev_tx_t vti_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	if (tdev == dev) {
 		dst_release(dst);
-		dev->stats.collisions++;
+		DEV_STATS_INC(dev, collisions);
 		goto tx_error;
 	}
 
@@ -267,7 +267,7 @@ static netdev_tx_t vti_xmit(struct sk_buff *skb, struct net_device *dev,
 tx_error_icmp:
 	dst_link_failure(skb);
 tx_error:
-	dev->stats.tx_errors++;
+	DEV_STATS_INC(dev, tx_errors);
 	kfree_skb(skb);
 	return NETDEV_TX_OK;
 }
@@ -304,7 +304,7 @@ static netdev_tx_t vti_tunnel_xmit(struct sk_buff *skb, struct net_device *dev)
 	return vti_xmit(skb, dev, &fl);
 
 tx_err:
-	dev->stats.tx_errors++;
+	DEV_STATS_INC(dev, tx_errors);
 	kfree_skb(skb);
 	return NETDEV_TX_OK;
 }
diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index ca853ab4591c5..4768904b1e620 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -311,7 +311,7 @@ static netdev_tx_t ipip_tunnel_xmit(struct sk_buff *skb,
 tx_error:
 	kfree_skb(skb);
 
-	dev->stats.tx_errors++;
+	DEV_STATS_INC(dev, tx_errors);
 	return NETDEV_TX_OK;
 }
 
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 948993a4f4157..f27f8b07a912e 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -518,8 +518,8 @@ static netdev_tx_t reg_vif_xmit(struct sk_buff *skb, struct net_device *dev)
 		return err;
 	}
 
-	dev->stats.tx_bytes += skb->len;
-	dev->stats.tx_packets++;
+	DEV_STATS_ADD(dev, tx_bytes, skb->len);
+	DEV_STATS_INC(dev, tx_packets);
 	rcu_read_lock();
 
 	/* Pairs with WRITE_ONCE() in vif_add() and vif_delete() */
@@ -1852,8 +1852,8 @@ static void ipmr_queue_xmit(struct net *net, struct mr_table *mrt,
 	if (vif->flags & VIFF_REGISTER) {
 		WRITE_ONCE(vif->pkt_out, vif->pkt_out + 1);
 		WRITE_ONCE(vif->bytes_out, vif->bytes_out + skb->len);
-		vif_dev->stats.tx_bytes += skb->len;
-		vif_dev->stats.tx_packets++;
+		DEV_STATS_ADD(vif_dev, tx_bytes, skb->len);
+		DEV_STATS_INC(vif_dev, tx_packets);
 		ipmr_cache_report(mrt, skb, vifi, IGMPMSG_WHOLEPKT);
 		goto out_free;
 	}
@@ -1911,8 +1911,8 @@ static void ipmr_queue_xmit(struct net *net, struct mr_table *mrt,
 	if (vif->flags & VIFF_TUNNEL) {
 		ip_encap(net, skb, vif->local, vif->remote);
 		/* FIXME: extra output firewall step used to be here. --RR */
-		vif_dev->stats.tx_packets++;
-		vif_dev->stats.tx_bytes += skb->len;
+		DEV_STATS_INC(vif_dev, tx_packets);
+		DEV_STATS_ADD(vif_dev, tx_bytes, skb->len);
 	}
 
 	IPCB(skb)->flags |= IPSKB_FORWARDED;
-- 
2.53.0

