Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9DD24501D
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 00:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788222061; cv=none; b=gBVM17RYGNh1wVeahAL2qe3QkyZ2NzN7EjGtI0Pawss4nhLzQHnqe0xCNkBfDxKi6Tmddibr3seb8/FAqBxykOJTfUxyCitevYHvugGw1so8Btu09gMXlU7/Z2+9eAIkCWg85+SD0zB8m2T6VtKV+lz/2Lh6vN9bxANRLcPRLVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788222061; c=relaxed/simple;
	bh=3kkd4t2IAYKH6jZA7gXzuexMu+TY+8tuxFUKkM1M29g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qEycUh+0lLDzPx67OADjkWzEk8BRzvC+B5VbSAFe/2t4yC1QSBHdgSUbiSHVldCiPmf+Ga1V1pCwnMtk7hhRNCqEz43A0yJZhuZ+PqFGJmeKhylOgR4lEReg/MTZXbFVsSo7DkhU+ITNN7y4Lkx0X3dR1umUJI9cRuSdZ8SX/4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FH88hqZF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FH88hqZF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFC71F00A3E;
	Tue,  1 Sep 2026 00:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788222060;
	bh=OzbicoUZQriQSsX7TmF7gMWwrrSNyqWe3nTaL8BTF0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FH88hqZF40sO2JHPlK/oEV9//IEZfi4Hro70oK/16nbpt0qZ8bv3DY4c58rEqDQML
	 1UbVpqpVOJa57smwDPVxFVzCSPhZVQ2tm4UoliYsY5tX03P1vtTlXT/Q+zWoxZwr8a
	 1puiHhDur3t+c63n2DdjLz5ufz4G4j5zyoZ/rvIsAZoIxw+43b6ePl5F8oUhcYoled
	 4PYrYuwl1uKD3Nv6IIMbpAQBif0X9s2A9bTvAuUaskkjlTR5Bcv8bHw1FLwZugVq/m
	 tjlXONvxz8u6JqH5m9CigCOo6AbBW7VLLXRHc9jngZRwBev6wGQtqPSzk9NiaPIQI/
	 Tz3lBG1lhCmeA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/6] ipv6: add some unlikely()/likely() clauses in ip6_output.c
Date: Mon, 31 Aug 2026 20:20:53 -0400
Message-ID: <20260901002057.2024614-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901002057.2024614-1-sashal@kernel.org>
References: <2026083104-huddle-balancing-d57b@gregkh>
 <20260901002057.2024614-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 2855e4925416c5900a9c6cece11f4a2e56bf6e63 ]

1) daddr is unlikely a multicast in ip6_finish_output2().

2) ip6_finish_output_gso_slowpath_drop() should not be called often.

3) ip6_fragment() should not be called often.

4) opt is unlikely to be set.

5) ip6_xmit() and ip6_forward() mostly sends not too big packets.

6) Most __ip6_make_skb() calls are for UDP packets,
   not ICMPV6 ones.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20260130210303.3888261-3-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 870a9e42ecc6 ("tcp: clamp route advmss to TCP_MIN_MSS")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/ip6_output.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 351649874733e..d048321733b38 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -80,7 +80,7 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
 
 	hdr = ipv6_hdr(skb);
 	daddr = &hdr->daddr;
-	if (ipv6_addr_is_multicast(daddr)) {
+	if (unlikely(ipv6_addr_is_multicast(daddr))) {
 		if (!(dev->flags & IFF_LOOPBACK) && sk_mc_loop(sk) &&
 		    ((mroute6_is_socket(net, skb) &&
 		     !(IP6CB(skb)->flags & IP6SKB_FORWARDED)) ||
@@ -181,8 +181,8 @@ ip6_finish_output_gso_slowpath_drop(struct net *net, struct sock *sk,
 static int ip6_finish_output_gso(struct net *net, struct sock *sk,
 				 struct sk_buff *skb, unsigned int mtu)
 {
-	if (!(IP6CB(skb)->flags & IP6SKB_FAKEJUMBO) &&
-	    !skb_gso_validate_network_len(skb, mtu))
+	if (unlikely(!(IP6CB(skb)->flags & IP6SKB_FAKEJUMBO) &&
+	    !skb_gso_validate_network_len(skb, mtu)))
 		return ip6_finish_output_gso_slowpath_drop(net, sk, skb, mtu);
 
 	return ip6_finish_output2(net, sk, skb);
@@ -204,8 +204,8 @@ static int __ip6_finish_output(struct net *net, struct sock *sk, struct sk_buff
 	if (skb_is_gso(skb))
 		return ip6_finish_output_gso(net, sk, skb, mtu);
 
-	if (skb->len > mtu ||
-	    (IP6CB(skb)->frag_max_size && skb->len > IP6CB(skb)->frag_max_size))
+	if (unlikely(skb->len > mtu ||
+	    (IP6CB(skb)->frag_max_size && skb->len > IP6CB(skb)->frag_max_size)))
 		return ip6_fragment(net, sk, skb, ip6_finish_output2);
 
 	return ip6_finish_output2(net, sk, skb);
@@ -303,7 +303,7 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 		}
 	}
 
-	if (opt) {
+	if (unlikely(opt)) {
 		seg_len += opt->opt_nflen + opt->opt_flen;
 
 		if (opt->opt_flen)
@@ -356,7 +356,7 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 	skb->mark = mark;
 
 	mtu = dst_mtu(dst);
-	if ((skb->len <= mtu) || skb->ignore_df || skb_is_gso(skb)) {
+	if (likely((skb->len <= mtu) || skb->ignore_df || skb_is_gso(skb))) {
 		IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTREQUESTS);
 
 		/* if egress device is enslaved to an L3 master device pass the
@@ -656,7 +656,7 @@ int ip6_forward(struct sk_buff *skb)
 	if (mtu < IPV6_MIN_MTU)
 		mtu = IPV6_MIN_MTU;
 
-	if (ip6_pkt_too_big(skb, mtu)) {
+	if (unlikely(ip6_pkt_too_big(skb, mtu))) {
 		/* Again, force OUTPUT device used as source address */
 		skb->dev = dev;
 		icmpv6_send(skb, ICMPV6_PKT_TOOBIG, 0, mtu);
@@ -1370,7 +1370,7 @@ static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
 	/*
 	 * setup for corking
 	 */
-	if (opt) {
+	if (unlikely(opt)) {
 		if (WARN_ON(v6_cork->opt))
 			return -EINVAL;
 
@@ -1886,7 +1886,7 @@ static void ip6_cork_steal_dst(struct sk_buff *skb, struct inet_cork_full *cork)
 static void ip6_cork_release(struct inet_cork_full *cork,
 			     struct inet6_cork *v6_cork)
 {
-	if (v6_cork->opt) {
+	if (unlikely(v6_cork->opt)) {
 		struct ipv6_txoptions *opt = v6_cork->opt;
 
 		kfree(opt->dst0opt);
@@ -1942,7 +1942,7 @@ struct sk_buff *__ip6_make_skb(struct sock *sk,
 	__skb_pull(skb, skb_network_header_len(skb));
 
 	final_dst = &fl6->daddr;
-	if (opt) {
+	if (unlikely(opt)) {
 		if (opt->opt_flen)
 			proto = ipv6_push_frag_opts(skb, opt, proto);
 		if (opt->opt_nflen)
@@ -1970,7 +1970,7 @@ struct sk_buff *__ip6_make_skb(struct sock *sk,
 
 	ip6_cork_steal_dst(skb, cork);
 	IP6_INC_STATS(net, rt->rt6i_idev, IPSTATS_MIB_OUTREQUESTS);
-	if (proto == IPPROTO_ICMPV6) {
+	if (unlikely(proto == IPPROTO_ICMPV6)) {
 		struct inet6_dev *idev = ip6_dst_idev(skb_dst(skb));
 		u8 icmp6_type;
 
-- 
2.53.0

