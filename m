Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DF75947EF
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 17:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788888330; cv=none; b=c2TIGAqQFYKr2midxrZ/tnzZAuUtBuDd4ASatCA5ux0yW65ZyWMgHwFeQ9DFHctjZd+K19CrM9ZRhCKYpVSq4msQrEY2f3gLX6cbESl2ixb2dRv+yzvKwZPLjHRhNwoBM9Vtm4dxXhN1PkYoXbTL+/F3DwBLfBJq6jAxy64Yil8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788888330; c=relaxed/simple;
	bh=QNVWON8BdsEzLBalc4ORWsGOakEO7eWA0iofky7riaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cz6A+5EUn88Au7nnJC2qJlvkHxECKMsUV08O+lrt30uOYPmf2QvdpBDrAIgBdU8mH22emX5pl0K+lb6ul8GjkOo2WR4NBZC+4fm/t1yjsknQPOSR0ATogFmlIevP97rXtstOjQjjQ0FoGl4vnWdPdXBL+rq8tSM6ASnwzNz54O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgtDvy8m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgtDvy8m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2FB81F00A3A;
	Tue,  8 Sep 2026 17:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788888328;
	bh=WGgEOh/oZ3gdxewfmwq4PCbrMui/sk0IufALHKDDqWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AgtDvy8mFR67GVVQjunUS13Grvp7tNKL2NmJP7XveMN0IWDliOZ6dbPJ3iUCQ672g
	 wOfneNWSqmsFgDdaVBLgVBiOGe2guHe3bzd0PMSRlNS/2dfnnVG2AwDj1UzfSLP4Lr
	 n8DcVAGp4x8H7ZCyqdhkaW9tfqYhft5sijzAzaFc9WvKbP3OPFO6WR+F/tUTWHUR3s
	 TNa7R+vIFUxz34apvS+Th12PpVMXagrYHS2tnFp5N3UJ7r86oSFZJiCYs4GGyxtWFW
	 1Vp+akf0UVoMgRxa4b/yDkE6AL3gaa4ArxMlWnam400EGmTzuJ9yi8rrzCzgZwU1k4
	 54c+l9Ug65k4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] ipv6: adopt skb_dst_dev() and skb_dst_dev_net[_rcu]() helpers
Date: Tue,  8 Sep 2026 13:25:23 -0400
Message-ID: <20260908172525.78441-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090318-afterglow-hash-e60c@gregkh>
References: <2026090318-afterglow-hash-e60c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 93d1cff35adc522a5d21e722eee1071f3f7dc716 ]

Use the new helpers as a step to deal with potential dst->dev races.

v2: fix typo in ipv6_rthdr_rcv() (kernel test robot <lkp@intel.com>)

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20250630121934.3399505-10-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: e36ce6e78fe3 ("ip: orphan prefetched skbs before multicast forwarding")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/inet6_hashtables.h      |  2 +-
 include/net/ip6_tunnel.h            |  2 +-
 net/ipv6/exthdrs.c                  |  8 ++++----
 net/ipv6/ioam6.c                    | 17 +++++++++--------
 net/ipv6/ip6_input.c                |  6 ++++--
 net/ipv6/ip6_output.c               |  5 +++--
 net/ipv6/ip6_tunnel.c               |  2 +-
 net/ipv6/ip6_vti.c                  |  2 +-
 net/ipv6/netfilter.c                |  4 ++--
 net/ipv6/netfilter/nf_reject_ipv6.c |  2 +-
 net/ipv6/output_core.c              |  2 +-
 net/ipv6/reassembly.c               | 10 +++++-----
 net/ipv6/route.c                    |  4 ++--
 net/ipv6/seg6_iptunnel.c            |  6 +++---
 net/ipv6/tcp_ipv6.c                 |  4 ++--
 net/ipv6/xfrm6_output.c             |  2 +-
 16 files changed, 41 insertions(+), 37 deletions(-)

diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
index c32878c69179d..ab3929a2a9569 100644
--- a/include/net/inet6_hashtables.h
+++ b/include/net/inet6_hashtables.h
@@ -150,7 +150,7 @@ static inline struct sock *__inet6_lookup_skb(struct inet_hashinfo *hashinfo,
 					      int iif, int sdif,
 					      bool *refcounted)
 {
-	struct net *net = dev_net_rcu(skb_dst(skb)->dev);
+	struct net *net = skb_dst_dev_net_rcu(skb);
 	const struct ipv6hdr *ip6h = ipv6_hdr(skb);
 	struct sock *sk;
 
diff --git a/include/net/ip6_tunnel.h b/include/net/ip6_tunnel.h
index 17913fca5445a..b4ddfe4b97508 100644
--- a/include/net/ip6_tunnel.h
+++ b/include/net/ip6_tunnel.h
@@ -170,7 +170,7 @@ static inline void ip6tunnel_xmit(struct sock *sk, struct sk_buff *skb,
 
 	memset(skb->cb, 0, sizeof(struct inet6_skb_parm));
 	pkt_len = skb->len - skb_inner_network_offset(skb);
-	err = ip6_local_out(dev_net(skb_dst(skb)->dev), sk, skb);
+	err = ip6_local_out(skb_dst_dev_net(skb), sk, skb);
 
 	if (dev) {
 		if (unlikely(net_xmit_eval(err)))
diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index e91afe5ec0b5d..ff8789d10b4f8 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -469,7 +469,7 @@ static int ipv6_srh_rcv(struct sk_buff *skb)
 		return -1;
 	}
 
-	if (skb_dst(skb)->dev->flags & IFF_LOOPBACK) {
+	if (skb_dst_dev(skb)->flags & IFF_LOOPBACK) {
 		if (ipv6_hdr(skb)->hop_limit <= 1) {
 			__IP6_INC_STATS(net, idev, IPSTATS_MIB_INHDRERRORS);
 			icmpv6_send(skb, ICMPV6_TIME_EXCEED,
@@ -633,7 +633,7 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
 		return -1;
 	}
 
-	if (skb_dst(skb)->dev->flags & IFF_LOOPBACK) {
+	if (skb_dst_dev(skb)->flags & IFF_LOOPBACK) {
 		if (ipv6_hdr(skb)->hop_limit <= 1) {
 			__IP6_INC_STATS(net, idev, IPSTATS_MIB_INHDRERRORS);
 			icmpv6_send(skb, ICMPV6_TIME_EXCEED,
@@ -795,7 +795,7 @@ static int ipv6_rthdr_rcv(struct sk_buff *skb)
 			kfree_skb(skb);
 			return -1;
 		}
-		if (!ipv6_chk_home_addr(dev_net(skb_dst(skb)->dev), addr)) {
+		if (!ipv6_chk_home_addr(skb_dst_dev_net(skb), addr)) {
 			__IP6_INC_STATS(net, idev, IPSTATS_MIB_INADDRERRORS);
 			kfree_skb(skb);
 			return -1;
@@ -821,7 +821,7 @@ static int ipv6_rthdr_rcv(struct sk_buff *skb)
 		return -1;
 	}
 
-	if (skb_dst(skb)->dev->flags&IFF_LOOPBACK) {
+	if (skb_dst_dev(skb)->flags & IFF_LOOPBACK) {
 		if (ipv6_hdr(skb)->hop_limit <= 1) {
 			__IP6_INC_STATS(net, idev, IPSTATS_MIB_INHDRERRORS);
 			icmpv6_send(skb, ICMPV6_TIME_EXCEED, ICMPV6_EXC_HOPLIMIT,
diff --git a/net/ipv6/ioam6.c b/net/ipv6/ioam6.c
index 868a25c57b924..bea2cf0163074 100644
--- a/net/ipv6/ioam6.c
+++ b/net/ipv6/ioam6.c
@@ -714,6 +714,7 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
 				    struct ioam6_schema *sc,
 				    unsigned int sclen, bool is_input)
 {
+	struct net_device *dev = skb_dst_dev(skb);
 	struct timespec64 ts;
 	ktime_t tstamp;
 	u64 raw64;
@@ -730,7 +731,7 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
 		if (is_input)
 			byte--;
 
-		raw32 = dev_net(skb_dst(skb)->dev)->ipv6.sysctl.ioam6_id;
+		raw32 = dev_net(dev)->ipv6.sysctl.ioam6_id;
 
 		*(__be32 *)data = cpu_to_be32((byte << 24) | raw32);
 		data += sizeof(__be32);
@@ -746,10 +747,10 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
 		*(__be16 *)data = cpu_to_be16(raw16);
 		data += sizeof(__be16);
 
-		if (skb_dst(skb)->dev->flags & IFF_LOOPBACK)
+		if (dev->flags & IFF_LOOPBACK)
 			raw16 = IOAM6_U16_UNAVAILABLE;
 		else
-			raw16 = (__force u16)READ_ONCE(__in6_dev_get(skb_dst(skb)->dev)->cnf.ioam6_id);
+			raw16 = (__force u16)READ_ONCE(__in6_dev_get(dev)->cnf.ioam6_id);
 
 		*(__be16 *)data = cpu_to_be16(raw16);
 		data += sizeof(__be16);
@@ -801,10 +802,10 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
 		struct Qdisc *qdisc;
 		__u32 qlen, backlog;
 
-		if (skb_dst(skb)->dev->flags & IFF_LOOPBACK) {
+		if (dev->flags & IFF_LOOPBACK) {
 			*(__be32 *)data = cpu_to_be32(IOAM6_U32_UNAVAILABLE);
 		} else {
-			queue = skb_get_tx_queue(skb_dst(skb)->dev, skb);
+			queue = skb_get_tx_queue(dev, skb);
 			qdisc = rcu_dereference(queue->qdisc);
 			qdisc_qstats_qlen_backlog(qdisc, &qlen, &backlog);
 
@@ -825,7 +826,7 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
 		if (is_input)
 			byte--;
 
-		raw64 = dev_net(skb_dst(skb)->dev)->ipv6.sysctl.ioam6_id_wide;
+		raw64 = dev_net(dev)->ipv6.sysctl.ioam6_id_wide;
 
 		*(__be64 *)data = cpu_to_be64(((u64)byte << 56) | raw64);
 		data += sizeof(__be64);
@@ -841,10 +842,10 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
 		*(__be32 *)data = cpu_to_be32(raw32);
 		data += sizeof(__be32);
 
-		if (skb_dst(skb)->dev->flags & IFF_LOOPBACK)
+		if (dev->flags & IFF_LOOPBACK)
 			raw32 = IOAM6_U32_UNAVAILABLE;
 		else
-			raw32 = READ_ONCE(__in6_dev_get(skb_dst(skb)->dev)->cnf.ioam6_id_wide);
+			raw32 = READ_ONCE(__in6_dev_get(dev)->cnf.ioam6_id_wide);
 
 		*(__be32 *)data = cpu_to_be32(raw32);
 		data += sizeof(__be32);
diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index 70c0e16c0ae68..a754aead9d56f 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -187,7 +187,9 @@ static struct sk_buff *ip6_rcv_core(struct sk_buff *skb, struct net_device *dev,
 	 * arrived via the sending interface (ethX), because of the
 	 * nature of scoping architecture. --yoshfuji
 	 */
-	IP6CB(skb)->iif = skb_valid_dst(skb) ? ip6_dst_idev(skb_dst(skb))->dev->ifindex : dev->ifindex;
+	IP6CB(skb)->iif = skb_valid_dst(skb) ?
+				ip6_dst_idev(skb_dst(skb))->dev->ifindex :
+				dev->ifindex;
 
 	if (unlikely(!pskb_may_pull(skb, sizeof(*hdr))))
 		goto err;
@@ -500,7 +502,7 @@ int ip6_mc_input(struct sk_buff *skb)
 	struct net_device *dev;
 	bool deliver;
 
-	__IP6_UPD_PO_STATS(dev_net(skb_dst(skb)->dev),
+	__IP6_UPD_PO_STATS(skb_dst_dev_net(skb),
 			 __in6_dev_get_safely(skb->dev), IPSTATS_MIB_INMCAST,
 			 skb->len);
 
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index fd25d5aadea27..5d64fde251eca 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -234,8 +234,9 @@ static int ip6_finish_output(struct net *net, struct sock *sk, struct sk_buff *s
 
 int ip6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	struct net_device *dev = skb_dst(skb)->dev, *indev = skb->dev;
-	struct inet6_dev *idev = ip6_dst_idev(skb_dst(skb));
+	struct dst_entry *dst = skb_dst(skb);
+	struct net_device *dev = dst_dev(dst), *indev = skb->dev;
+	struct inet6_dev *idev = ip6_dst_idev(dst);
 
 	skb->protocol = htons(ETH_P_IPV6);
 	skb->dev = dev;
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 4001acf569af1..2fe68e8c68d89 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -637,7 +637,7 @@ ip4ip6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 	} else {
 		if (ip_route_input(skb2, eiph->daddr, eiph->saddr,
 				   ip4h_dscp(eiph), skb2->dev) ||
-		    skb_dst(skb2)->dev->type != ARPHRD_TUNNEL6)
+		    skb_dst_dev(skb2)->type != ARPHRD_TUNNEL6)
 			goto out;
 	}
 
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index e8c60b7fb0120..3880662b6bc38 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -531,7 +531,7 @@ vti6_xmit(struct sk_buff *skb, struct net_device *dev, struct flowi *fl)
 xmit:
 	skb_scrub_packet(skb, !net_eq(t->net, dev_net(dev)));
 	skb_dst_set(skb, dst);
-	skb->dev = skb_dst(skb)->dev;
+	skb->dev = dst_dev(dst);
 
 	err = dst_output(t->net, skb->sk, skb);
 	if (net_xmit_eval(err) == 0)
diff --git a/net/ipv6/netfilter.c b/net/ipv6/netfilter.c
index 2fd2c3e315ee8..a6635e3987920 100644
--- a/net/ipv6/netfilter.c
+++ b/net/ipv6/netfilter.c
@@ -24,7 +24,7 @@ int ip6_route_me_harder(struct net *net, struct sock *sk_partial, struct sk_buff
 {
 	const struct ipv6hdr *iph = ipv6_hdr(skb);
 	struct sock *sk = sk_to_full_sk(sk_partial);
-	struct net_device *dev = skb_dst(skb)->dev;
+	struct net_device *dev = skb_dst_dev(skb);
 	struct flow_keys flkeys;
 	unsigned int hh_len;
 	struct dst_entry *dst;
@@ -72,7 +72,7 @@ int ip6_route_me_harder(struct net *net, struct sock *sk_partial, struct sk_buff
 #endif
 
 	/* Change in oif may mean change in hh_len. */
-	hh_len = skb_dst(skb)->dev->hard_header_len;
+	hh_len = skb_dst_dev(skb)->hard_header_len;
 	if (skb_headroom(skb) < hh_len &&
 	    pskb_expand_head(skb, HH_DATA_ALIGN(hh_len - skb_headroom(skb)),
 			     0, GFP_ATOMIC))
diff --git a/net/ipv6/netfilter/nf_reject_ipv6.c b/net/ipv6/netfilter/nf_reject_ipv6.c
index 84afa0cbc9021..3c56e94e6943b 100644
--- a/net/ipv6/netfilter/nf_reject_ipv6.c
+++ b/net/ipv6/netfilter/nf_reject_ipv6.c
@@ -330,7 +330,7 @@ void nf_send_reset6(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 		skb_dst_set(oldskb, dst);
 	}
 
-	fl6.flowi6_oif = l3mdev_master_ifindex(skb_dst(oldskb)->dev);
+	fl6.flowi6_oif = l3mdev_master_ifindex(skb_dst_dev(oldskb));
 	fl6.flowi6_mark = IP6_REPLY_MARK(net, oldskb->mark);
 	security_skb_classify_flow(oldskb, flowi6_to_flowi_common(&fl6));
 	dst = ip6_route_output(net, NULL, &fl6);
diff --git a/net/ipv6/output_core.c b/net/ipv6/output_core.c
index 90a178dd24aae..d21fe27fe21e3 100644
--- a/net/ipv6/output_core.c
+++ b/net/ipv6/output_core.c
@@ -141,7 +141,7 @@ int __ip6_local_out(struct net *net, struct sock *sk, struct sk_buff *skb)
 	skb->protocol = htons(ETH_P_IPV6);
 
 	return nf_hook(NFPROTO_IPV6, NF_INET_LOCAL_OUT,
-		       net, sk, skb, NULL, skb_dst(skb)->dev,
+		       net, sk, skb, NULL, skb_dst_dev(skb),
 		       dst_output);
 }
 EXPORT_SYMBOL_GPL(__ip6_local_out);
diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index 49740898bc137..e8e58875fc726 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -104,11 +104,11 @@ fq_find(struct net *net, __be32 id, const struct ipv6hdr *hdr, int iif)
 	return container_of(q, struct frag_queue, q);
 }
 
-static int ip6_frag_queue(struct frag_queue *fq, struct sk_buff *skb,
+static int ip6_frag_queue(struct net *net,
+			  struct frag_queue *fq, struct sk_buff *skb,
 			  struct frag_hdr *fhdr, int nhoff,
 			  u32 *prob_offset, int *refs)
 {
-	struct net *net = dev_net(skb_dst(skb)->dev);
 	int offset, end, fragsize;
 	struct sk_buff *prev_tail;
 	struct net_device *dev;
@@ -324,10 +324,10 @@ static int ip6_frag_reasm(struct frag_queue *fq, struct sk_buff *skb,
 
 static int ipv6_frag_rcv(struct sk_buff *skb)
 {
+	const struct ipv6hdr *hdr = ipv6_hdr(skb);
+	struct net *net = skb_dst_dev_net(skb);
 	struct frag_hdr *fhdr;
 	struct frag_queue *fq;
-	const struct ipv6hdr *hdr = ipv6_hdr(skb);
-	struct net *net = dev_net(skb_dst(skb)->dev);
 	u8 nexthdr;
 	int iif;
 
@@ -384,7 +384,7 @@ static int ipv6_frag_rcv(struct sk_buff *skb)
 		spin_lock(&fq->q.lock);
 
 		fq->iif = iif;
-		ret = ip6_frag_queue(fq, skb, fhdr, IP6CB(skb)->nhoff,
+		ret = ip6_frag_queue(net, fq, skb, fhdr, IP6CB(skb)->nhoff,
 				     &prob_offset, &refs);
 
 		spin_unlock(&fq->q.lock);
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 3e5bf8a5b32b2..38d646bf75021 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -4597,7 +4597,7 @@ static int ip6_pkt_discard(struct sk_buff *skb)
 
 static int ip6_pkt_discard_out(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	skb->dev = skb_dst(skb)->dev;
+	skb->dev = skb_dst_dev(skb);
 	return ip6_pkt_drop(skb, ICMPV6_NOROUTE, IPSTATS_MIB_OUTNOROUTES);
 }
 
@@ -4608,7 +4608,7 @@ static int ip6_pkt_prohibit(struct sk_buff *skb)
 
 static int ip6_pkt_prohibit_out(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	skb->dev = skb_dst(skb)->dev;
+	skb->dev = skb_dst_dev(skb);
 	return ip6_pkt_drop(skb, ICMPV6_ADM_PROHIBITED, IPSTATS_MIB_OUTNOROUTES);
 }
 
diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index fb5a701f8d255..ead677bca4901 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -365,7 +365,7 @@ static int __seg6_do_srh_inline(struct sk_buff *skb, struct ipv6_sr_hdr *osrh,
 
 #ifdef CONFIG_IPV6_SEG6_HMAC
 	if (sr_has_hmac(isrh)) {
-		struct net *net = dev_net(skb_dst(skb)->dev);
+		struct net *net = skb_dst_dev_net(skb);
 
 		err = seg6_push_hmac(net, &hdr->saddr, isrh);
 		if (unlikely(err))
@@ -540,7 +540,7 @@ static int seg6_input_core(struct net *net, struct sock *sk,
 
 static int seg6_input_nf(struct sk_buff *skb)
 {
-	struct net_device *dev = skb_dst(skb)->dev;
+	struct net_device *dev = skb_dst_dev(skb);
 	struct net *net = dev_net(skb->dev);
 
 	switch (skb->protocol) {
@@ -626,7 +626,7 @@ static int seg6_output_core(struct net *net, struct sock *sk,
 
 static int seg6_output_nf(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	struct net_device *dev = skb_dst(skb)->dev;
+	struct net_device *dev = skb_dst_dev(skb);
 
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 085fc97c5a5b3..e3284c9acbf49 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -862,7 +862,7 @@ static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32
 				 int oif, int rst, u8 tclass, __be32 label,
 				 u32 priority, u32 txhash, struct tcp_key *key)
 {
-	struct net *net = sk ? sock_net(sk) : dev_net_rcu(skb_dst(skb)->dev);
+	struct net *net = sk ? sock_net(sk) : skb_dst_dev_net_rcu(skb);
 	unsigned int tot_len = sizeof(struct tcphdr);
 	struct sock *ctl_sk = net->ipv6.tcp_sk;
 	const struct tcphdr *th = tcp_hdr(skb);
@@ -1036,7 +1036,7 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb,
 	if (!sk && !ipv6_unicast_destination(skb))
 		return;
 
-	net = sk ? sock_net(sk) : dev_net_rcu(skb_dst(skb)->dev);
+	net = sk ? sock_net(sk) : skb_dst_dev_net_rcu(skb);
 	/* Invalid TCP option size or twice included auth */
 	if (tcp_parse_auth_options(th, &md5_hash_location, &aoh))
 		return;
diff --git a/net/ipv6/xfrm6_output.c b/net/ipv6/xfrm6_output.c
index b3d5d1f266eee..512bdaf136997 100644
--- a/net/ipv6/xfrm6_output.c
+++ b/net/ipv6/xfrm6_output.c
@@ -106,7 +106,7 @@ static int __xfrm6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 int xfrm6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	return NF_HOOK_COND(NFPROTO_IPV6, NF_INET_POST_ROUTING,
-			    net, sk, skb,  skb->dev, skb_dst(skb)->dev,
+			    net, sk, skb,  skb->dev, skb_dst_dev(skb),
 			    __xfrm6_output,
 			    !(IP6CB(skb)->flags & IP6SKB_REROUTED));
 }
-- 
2.53.0

