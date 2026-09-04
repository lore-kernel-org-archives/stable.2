Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A35B50C2BB
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 16:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788540958; cv=none; b=nARUDSQu8+WDCNk50WfDzbVtWwXyD2Kt93c9VqrOWCj6QYKIoGzraWgDbdifo69Q/11wYDQfHXiKwR0BW1FdeVW8XpmCmQJSWHiqa+CZY/Q9+Q396/pOdGUt2+7E2rUpOMFDC7ySjLAcXfJCZ8v1SVfRVOmR+xx0Au+zwhnoIhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788540958; c=relaxed/simple;
	bh=7Ib8IcvKeHtblIcGzQNVS6oUxOoSw6QIGv40Sk/T8uQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ojPtm6MFUD9KJqNB5Xd7laH0bN0f5MX/lDUUA2pgbidJmYmiZRWMN5Q0+TSvNIfbtYKzwBAQmYiug0qmEsfgQ0C5JoF47379VqGyAJ8AbgWiEIBRVNuz/hlrVnRfbF2dMdHjGtYzFG8B+mas8TcG4cS+wsBUIQQvlhARG2+n3kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVGNI0cV; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVGNI0cV"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8523cc3d76eso7700b3a.2
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 09:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788540956; x=1789145756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8Pugumtiy8a7ud4fT7dQUu5IP2KC8hqTj50eSk7DgzY=;
        b=KVGNI0cVQiXO3Ys1406hyAujbA0cwj4dT2YHfOubzYCLBOt2tZUFkt6nHSI+zZoKXA
         4mGlpSfVGXpQfrAhqidx/2V5RNft2gT+JehUrMv2DOaErHk434nlY3hQnvhVStpO6ipN
         X9HUDx19sWKQds4dLRmRWg7w0RY9M68yl66k4+495iYO7BQtyUNiZ6JM9i1Q2D3YDOiQ
         ujLaMFBIbqagqC/6TJDawckDSvJnRdG4H8/Ekr3brP6f7rQPlSirfaXEibwAyQ5b+b8b
         PmICa7gpzeZ5btpb4I3Buf816Pq6B97JFwBMRQC3+xMr56hRYUXm2cYJ0KeE5cLC5/+d
         C2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788540956; x=1789145756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Pugumtiy8a7ud4fT7dQUu5IP2KC8hqTj50eSk7DgzY=;
        b=nB+xiPIUEw4Z/N8im96xLAWEJT+YyEwwtuWxr0iPtq7uxEBhDSSqzQeG6Ke1JyxwF4
         EEhyUsgGCf9Iam7roOP8grRpA7VeNOaFrYabAvGRUh/M6/wZrv3zUw4HjlHGMhsqTvvM
         drUufmWvcE6KOcQywqZE7TdrVz14Kd+FxyWwFAe4T2elgOhgvOFAMY7uqZoR7TNzkkCR
         Pg3Je5L0QjhwVGnWEBoqtlYM+NbG7vHD5L9l/Ul0Wy0+IERLXaErnLhkpgaFh4xktboi
         fmITCQ0C+EEWLymLTnqL3fKTVn8XPsscJDP5KhHQhityTIxaO/SOHgQuEPMTKNtdFw+r
         nk9w==
X-Forwarded-Encrypted: i=1; AKwUvByWhfg2mKr1ZH+a41IoINSK2d7pbS/JxSXmxIgQZNxobZ7H5KS55VDkEHfzg28t9TUO54s2xYM=@vger.kernel.org
X-Gm-Message-State: AFuF++mSxDdR1/GZV+mM8AdQ+7U38D7peocXw0vjq2aBLXRCCP6+P7oh
	6Dkrp7qmXaKmNcB1hHsBoSrzVxmdu2MCfPKEocbzNjfge0jqBQj8EdPB
X-Gm-Gg: AYBFou1KYMbNnxW2mh1QzSCDwo7BRvUeIwExtH8vVJqd8DYLF0ltDnUkGaQwUoUj9dr
	sk6SnIrSL6c/kciLjjTESF3hI1llJZ4ceWvwXzYEBb8VPctdndcQb/tZ7JFIeVQKfqPXt9hrH52
	A6HTQWelnYLSd3mny3b23N2uFdWoQHfznzC/v+gQeDur3Yhix0CRaPI+0QnySHvAsQwMSigwr30
	350owRU7oORx5mVSUyeba43g83xUmx1eXbq1YnSuYfko8kweHcD/JNGQoaNBfWoyC5vqEfTaYWU
	llxMDdDxH4ib8Al/Ls7MVgU086dGHotduGcuXd28qCr7+5dAoSIjKb1mnoVTecg3d0jLnewFUJT
	7rUj1AW9LFAphqbmE00jEtWQ10uqoN3Wl67G14PqoU5ftx48FnN8BfCIuZCt9KnDYFXFNPKBYOm
	t6rbdBa0yrUCUizpgZOPtPZ2Jg4hou2jVhHMr4B2gUYrNZXvc46Mj/w9LP8Ljphyx5rd2ih8YB/
	tW+L4GXDMK0Pw4R4wBgtRho4Wrf4z24/GF2vZUnPD4VuBki9G462mWjFA==
X-Received: by 2002:a17:90b:562b:b0:396:d27b:86a4 with SMTP id 98e67ed59e1d1-39b3d5f2c09mr392878a91.2.1788540956155;
        Fri, 04 Sep 2026 09:55:56 -0700 (PDT)
Received: from localhost.localdomain (45.78.64.189.16clouds.com. [45.78.64.189])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339befe870sm8685464eec.30.2026.09.04.09.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 09:55:55 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Xin Long <lucien.xin@gmail.com>,
	William Tu <u9012063@gmail.com>,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v4] ip_tunnel: reserve FOU/GUE headroom before encapsulation
Date: Sat,  5 Sep 2026 00:55:44 +0800
Message-ID: <20260904165544.1362052-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ip_tunnel_encap() expects its callers to reserve headroom based on
ip_encap_hlen(). ip_tunnel_xmit() currently pushes FOU and GUE headers
before it grows the skb headroom.

That becomes visible when ipgre_changelink() publishes UDP
encapsulation before it updates the device headroom. The transmit path
does not serialize with RTNL, so it can interleave as follows:

  CPU 0 (ipgre_changelink)        CPU 1 (ipgre_xmit)
  install GUE encapsulation
                                  reserve the old needed_headroom
  publish larger GRE flags
  update tunnel->tun_hlen
                                  push the larger GRE header
                                  push the GUE and UDP headers
  update dev->needed_headroom

With REMCSUM, the new layout can push 16 bytes of GRE and 20 bytes of
GUE/UDP headers into an skb with only 32 bytes of actual headroom. The
final UDP push writes four bytes before skb->head.

With the update window widened, the kernel reported:

  skbuff: skb_under_panic: ... len:128 put:8 ... dev:gre0poc
  kernel BUG at net/core/skbuff.c:214!
  Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
  Call Trace:
   skb_push
   fou_build_udp
   gue_build_header
   ip_tunnel_xmit
   __gre_xmit
   ipgre_xmit

Snapshot tunnel->encap, route and perform PMTU handling first, then
reserve the final headroom before ip_tunnel_encap() builds the UDP
tunnel headers. Because encapsulation is now delayed, pass the
snapshotted encap length into tnl_update_pmtu() so the inner packet
size stays skb->len + encap_hlen - tunnel_hlen.

ip_md_tunnel_xmit() is left unchanged. It takes FOU/GUE parameters
from the skb metadata dst, not from the device configuration, so it
is not exposed to this race. tnl_update_pmtu() still runs after
encapsulation there, so that path passes 0 for the extra length.

The IPv6 analogue of this headroom reservation is still work in
progress.

Link: https://lore.kernel.org/netdev/b58876297f7d45de008f2e94b6ecab8b2ed84d21.1786088695.git.petalzu987@gmail.com/
Fixes: dd9d598c6657 ("ip_gre: add the support for i/o_flags update via netlink")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
Changes in v4:
- Not restructure ip_md_tunnel_xmit(); only pass 0 into the new
  tnl_update_pmtu() argument.
- Snapshot tunnel->encap with data_race() and reuse the copy for both
  ip_encap_hlen() and ip_tunnel_encap().
- Fix tnl_update_pmtu() inner packet size after delaying the encap
  push: pkt_size = skb->len + encap_hlen - tunnel_hlen.
- Keep reverse xmas tree for the new locals.
- Note that the IPv6 FOU/GUE headroom fix is still WIP.

Changes in v3:
- Move the headroom reservation into ip_tunnel_xmit() instead of
  growing the skb inside the FOU/GUE builders.
- Use ip_encap_hlen() to reserve the final caller-side headroom before
  ip_tunnel_encap().
- Drop the IPv4 raw-pointer refreshes that were only needed when
  skb_cow_head() could run inside the encapsulation builders.

Link: https://lore.kernel.org/netdev/20260824111944.187200-1-nicoyip.dev@gmail.com/ [v3]
Link: https://lore.kernel.org/netdev/20260808005956.3761487-1-nicoyip.dev@gmail.com/ [v2]
Link: https://lore.kernel.org/netdev/20260801060115.3538849-1-nicoyip.dev@gmail.com/ [v1]
---
 net/ipv4/ip_tunnel.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 9d114bd575f9..447b435b10cc 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -512,14 +512,15 @@ EXPORT_SYMBOL_GPL(ip_tunnel_encap_setup);
 static int tnl_update_pmtu(struct net_device *dev, struct sk_buff *skb,
 			    struct rtable *rt, __be16 df,
 			    const struct iphdr *inner_iph,
-			    int tunnel_hlen, __be32 dst, bool md)
+			    int tunnel_hlen, __be32 dst, bool md,
+			    int encap_hlen)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
 	int pkt_size;
 	int mtu;
 
 	tunnel_hlen = md ? tunnel_hlen : tunnel->hlen;
-	pkt_size = skb->len - tunnel_hlen;
+	pkt_size = skb->len + encap_hlen - tunnel_hlen;
 	pkt_size -= dev->type == ARPHRD_ETHER ? dev->hard_header_len : 0;
 
 	if (df) {
@@ -629,7 +630,7 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	if (test_bit(IP_TUNNEL_DONT_FRAGMENT_BIT, key->tun_flags))
 		df = htons(IP_DF);
 	if (tnl_update_pmtu(dev, skb, rt, df, inner_iph, tunnel_hlen,
-			    key->u.ipv4.dst, true)) {
+			    key->u.ipv4.dst, true, 0)) {
 		ip_rt_put(rt);
 		goto tx_error;
 	}
@@ -671,6 +672,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
 	struct ip_tunnel_info *tun_info = NULL;
+	struct ip_tunnel_encap ipencap;
 	const struct iphdr *inner_iph;
 	unsigned int max_headroom;	/* The extra header space needed */
 	struct rtable *rt = NULL;		/* Route to the other host */
@@ -680,6 +682,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	bool md = false;
 	bool connected;
 	int err_count;
+	int encap_hlen;
 	u8 tos, ttl;
 	__be32 dst;
 	__be16 df;
@@ -765,7 +768,10 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 			    tunnel->net, READ_ONCE(tunnel->parms.link),
 			    tunnel->fwmark, skb_get_hash(skb), 0);
 
-	if (ip_tunnel_encap(skb, &tunnel->encap, &protocol, &fl4) < 0)
+	/* Snapshot encap; ipgre_changelink() can update it concurrently. */
+	ipencap = data_race(tunnel->encap);
+	encap_hlen = ip_encap_hlen(&ipencap);
+	if (encap_hlen < 0)
 		goto tx_error;
 
 	if (connected && md) {
@@ -803,7 +809,8 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	if (payload_protocol == htons(ETH_P_IP) && !tunnel->ignore_df)
 		df |= (inner_iph->frag_off & htons(IP_DF));
 
-	if (tnl_update_pmtu(dev, skb, rt, df, inner_iph, 0, 0, false)) {
+	if (tnl_update_pmtu(dev, skb, rt, df, inner_iph, 0, 0, false,
+			    encap_hlen)) {
 		ip_rt_put(rt);
 		goto tx_error;
 	}
@@ -834,7 +841,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	}
 
 	max_headroom = LL_RESERVED_SPACE(rt->dst.dev) + sizeof(struct iphdr)
-			+ rt->dst.header_len + ip_encap_hlen(&tunnel->encap);
+			+ rt->dst.header_len + encap_hlen;
 
 	if (skb_cow_head(skb, max_headroom)) {
 		ip_rt_put(rt);
@@ -845,6 +852,11 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	ip_tunnel_adj_headroom(dev, max_headroom);
 
+	if (ip_tunnel_encap(skb, &ipencap, &protocol, &fl4) < 0) {
+		ip_rt_put(rt);
+		goto tx_error;
+	}
+
 	iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, protocol, tos, ttl,
 		      df, !net_eq(tunnel->net, dev_net(dev)), 0);
 	return;
-- 
2.43.0
