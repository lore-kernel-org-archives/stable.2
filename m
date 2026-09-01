Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED21F35203D
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 14:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272288; cv=none; b=jiKLxTcGfEjPUnJcUzl0EVajnlSpsW35ByRsQtGmLerdJ2wmfPf2Et5kE9D7v9ubt/NHPOytHbkZdIRtpTakUEKmfCIaNoWrOOkL/+yUPcaZuYkz9wPxHBAdDR8Fz8MbaU8/yUhrB/mG6dCUF+oaaDd6CNR26efPgfdh6BGKhwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272288; c=relaxed/simple;
	bh=6v/pqyXz3XVAZ0cklkxgz1Cd2w+aJ93Ae5Lm/1sHEmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJU3NkSvV9bwqVNbNN6mOMxPKzN336eMWgWp+OldGJUIDSvBPf6dGqQAbYBmjdOfsLdqJ7yUQBDFPpfPukJGxoIB89p2XEybK1IamTuTAdxNX0klhQgcx+iDTQ0M4yStFQ8UBEcosrD9dT3DZoG0MBJ6XUbE85WsWyFyyTwBZfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HP4vwrdl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HP4vwrdl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8BF1F000E9;
	Tue,  1 Sep 2026 14:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788272286;
	bh=AND3C+gtz2I8JyxaAi6AKJK9XDv/BOsVJcOMDOfmJ4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HP4vwrdl2os1qdFjiOK9+GEUZuXSWuj3Q8WGxi81XhCnMQdmKi19uYJUGSEoFfeX8
	 o1PIN5eejxc/F2eYyrr96LFQDkQODa/9JFLNLQBWcYQxWbXJF7UFiqVskX0kt6XKw5
	 zq+/UDzdh/pDc+9/1uF1nkELePszBW8smZ487CWQObTrrE85o/KqSTWE6B1vz65fSu
	 flz5571F/3MzkURLC2xPpo3bE9DMglatLQJGmCilmj/Bi5XTFS6WI+ZVzFTz7O0QEZ
	 NUzTT+3Ex9F0JbZGMybsufB5SYFCvcac6KcX/I4wgSzzlGCByqjV1gP/SKqad2RrWo
	 xQHAi0tQo/Ygw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/5] ipv6: pass proto by value to ipv6_push_nfrag_opts() and ipv6_push_frag_opts()
Date: Tue,  1 Sep 2026 10:18:00 -0400
Message-ID: <20260901141804.1031618-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026083105-buddhist-verdict-4f97@gregkh>
References: <2026083105-buddhist-verdict-4f97@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 1bc46dd209667346c5aa56c351995e7c260696d0 ]

With CONFIG_STACKPROTECTOR_STRONG=y, it is better to avoid passing
a pointer to an automatic variable.

Change these exported functions to return 'u8 proto'
instead of void.

- ipv6_push_nfrag_opts()
- ipv6_push_frag_opts()

For instance, replace
	ipv6_push_frag_opts(skb, opt, &proto);
with:
	proto = ipv6_push_frag_opts(skb, opt, proto);

Note that even after this change, ip6_xmit() has to use a stack canary
because of @first_hop variable.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20260130210303.3888261-2-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 870a9e42ecc6 ("tcp: clamp route advmss to TCP_MIN_MSS")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/ipv6.h    | 10 ++++----
 net/ipv6/exthdrs.c    | 55 +++++++++++++++++++++++--------------------
 net/ipv6/ip6_output.c | 19 ++++++++-------
 net/ipv6/ip6_tunnel.c |  2 +-
 4 files changed, 46 insertions(+), 40 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 3645776d71c9c..7f7796ab320a6 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1154,11 +1154,11 @@ int ip6_local_out(struct net *net, struct sock *sk, struct sk_buff *skb);
  *	Extension header (options) processing
  */
 
-void ipv6_push_nfrag_opts(struct sk_buff *skb, struct ipv6_txoptions *opt,
-			  u8 *proto, struct in6_addr **daddr_p,
-			  struct in6_addr *saddr);
-void ipv6_push_frag_opts(struct sk_buff *skb, struct ipv6_txoptions *opt,
-			 u8 *proto);
+u8 ipv6_push_nfrag_opts(struct sk_buff *skb, struct ipv6_txoptions *opt,
+			u8 proto, struct in6_addr **daddr_p,
+			struct in6_addr *saddr);
+u8 ipv6_push_frag_opts(struct sk_buff *skb, struct ipv6_txoptions *opt,
+		       u8 proto);
 
 int ipv6_skip_exthdr(const struct sk_buff *, int start, u8 *nexthdrp,
 		     __be16 *frag_offp);
diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index e024d8da431c4..9641c37cfd177 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -1107,9 +1107,9 @@ int ipv6_parse_hopopts(struct sk_buff *skb)
  *	for headers.
  */
 
-static void ipv6_push_rthdr0(struct sk_buff *skb, u8 *proto,
-			     struct ipv6_rt_hdr *opt,
-			     struct in6_addr **addr_p, struct in6_addr *saddr)
+static u8 ipv6_push_rthdr0(struct sk_buff *skb, u8 proto,
+			   struct ipv6_rt_hdr *opt,
+			   struct in6_addr **addr_p, struct in6_addr *saddr)
 {
 	struct rt0_hdr *phdr, *ihdr;
 	int hops;
@@ -1128,13 +1128,13 @@ static void ipv6_push_rthdr0(struct sk_buff *skb, u8 *proto,
 	phdr->addr[hops - 1] = **addr_p;
 	*addr_p = ihdr->addr;
 
-	phdr->rt_hdr.nexthdr = *proto;
-	*proto = NEXTHDR_ROUTING;
+	phdr->rt_hdr.nexthdr = proto;
+	return NEXTHDR_ROUTING;
 }
 
-static void ipv6_push_rthdr4(struct sk_buff *skb, u8 *proto,
-			     struct ipv6_rt_hdr *opt,
-			     struct in6_addr **addr_p, struct in6_addr *saddr)
+static u8 ipv6_push_rthdr4(struct sk_buff *skb, u8 proto,
+			   struct ipv6_rt_hdr *opt,
+			   struct in6_addr **addr_p, struct in6_addr *saddr)
 {
 	struct ipv6_sr_hdr *sr_phdr, *sr_ihdr;
 	int plen, hops;
@@ -1177,58 +1177,61 @@ static void ipv6_push_rthdr4(struct sk_buff *skb, u8 *proto,
 	}
 #endif
 
-	sr_phdr->nexthdr = *proto;
-	*proto = NEXTHDR_ROUTING;
+	sr_phdr->nexthdr = proto;
+	return NEXTHDR_ROUTING;
 }
 
-static void ipv6_push_rthdr(struct sk_buff *skb, u8 *proto,
-			    struct ipv6_rt_hdr *opt,
-			    struct in6_addr **addr_p, struct in6_addr *saddr)
+static u8 ipv6_push_rthdr(struct sk_buff *skb, u8 proto,
+			  struct ipv6_rt_hdr *opt,
+			  struct in6_addr **addr_p, struct in6_addr *saddr)
 {
 	switch (opt->type) {
 	case IPV6_SRCRT_TYPE_0:
 	case IPV6_SRCRT_STRICT:
 	case IPV6_SRCRT_TYPE_2:
-		ipv6_push_rthdr0(skb, proto, opt, addr_p, saddr);
+		proto = ipv6_push_rthdr0(skb, proto, opt, addr_p, saddr);
 		break;
 	case IPV6_SRCRT_TYPE_4:
-		ipv6_push_rthdr4(skb, proto, opt, addr_p, saddr);
+		proto = ipv6_push_rthdr4(skb, proto, opt, addr_p, saddr);
 		break;
 	default:
 		break;
 	}
+	return proto;
 }
 
-static void ipv6_push_exthdr(struct sk_buff *skb, u8 *proto, u8 type, struct ipv6_opt_hdr *opt)
+static u8 ipv6_push_exthdr(struct sk_buff *skb, u8 proto, u8 type, struct ipv6_opt_hdr *opt)
 {
 	struct ipv6_opt_hdr *h = skb_push(skb, ipv6_optlen(opt));
 
 	memcpy(h, opt, ipv6_optlen(opt));
-	h->nexthdr = *proto;
-	*proto = type;
+	h->nexthdr = proto;
+	return type;
 }
 
-void ipv6_push_nfrag_opts(struct sk_buff *skb, struct ipv6_txoptions *opt,
-			  u8 *proto,
-			  struct in6_addr **daddr, struct in6_addr *saddr)
+u8 ipv6_push_nfrag_opts(struct sk_buff *skb, struct ipv6_txoptions *opt,
+			u8 proto,
+			struct in6_addr **daddr, struct in6_addr *saddr)
 {
 	if (opt->srcrt) {
-		ipv6_push_rthdr(skb, proto, opt->srcrt, daddr, saddr);
+		proto = ipv6_push_rthdr(skb, proto, opt->srcrt, daddr, saddr);
 		/*
 		 * IPV6_RTHDRDSTOPTS is ignored
 		 * unless IPV6_RTHDR is set (RFC3542).
 		 */
 		if (opt->dst0opt)
-			ipv6_push_exthdr(skb, proto, NEXTHDR_DEST, opt->dst0opt);
+			proto = ipv6_push_exthdr(skb, proto, NEXTHDR_DEST, opt->dst0opt);
 	}
 	if (opt->hopopt)
-		ipv6_push_exthdr(skb, proto, NEXTHDR_HOP, opt->hopopt);
+		proto = ipv6_push_exthdr(skb, proto, NEXTHDR_HOP, opt->hopopt);
+	return proto;
 }
 
-void ipv6_push_frag_opts(struct sk_buff *skb, struct ipv6_txoptions *opt, u8 *proto)
+u8 ipv6_push_frag_opts(struct sk_buff *skb, struct ipv6_txoptions *opt, u8 proto)
 {
 	if (opt->dst1opt)
-		ipv6_push_exthdr(skb, proto, NEXTHDR_DEST, opt->dst1opt);
+		proto = ipv6_push_exthdr(skb, proto, NEXTHDR_DEST, opt->dst1opt);
+	return proto;
 }
 EXPORT_SYMBOL(ipv6_push_frag_opts);
 
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 2d18b2dcbafb1..b065fc70037c4 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -299,11 +299,12 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 		seg_len += opt->opt_nflen + opt->opt_flen;
 
 		if (opt->opt_flen)
-			ipv6_push_frag_opts(skb, opt, &proto);
+			proto = ipv6_push_frag_opts(skb, opt, proto);
 
 		if (opt->opt_nflen)
-			ipv6_push_nfrag_opts(skb, opt, &proto, &first_hop,
-					     &fl6->saddr);
+			proto = ipv6_push_nfrag_opts(skb, opt, proto,
+						     &first_hop,
+						     &fl6->saddr);
 	}
 
 	if (unlikely(seg_len > IPV6_MAXPLEN)) {
@@ -1930,11 +1931,13 @@ struct sk_buff *__ip6_make_skb(struct sock *sk,
 	__skb_pull(skb, skb_network_header_len(skb));
 
 	final_dst = &fl6->daddr;
-	if (opt && opt->opt_flen)
-		ipv6_push_frag_opts(skb, opt, &proto);
-	if (opt && opt->opt_nflen)
-		ipv6_push_nfrag_opts(skb, opt, &proto, &final_dst, &fl6->saddr);
-
+	if (opt) {
+		if (opt->opt_flen)
+			proto = ipv6_push_frag_opts(skb, opt, proto);
+		if (opt->opt_nflen)
+			proto = ipv6_push_nfrag_opts(skb, opt, proto,
+						     &final_dst, &fl6->saddr);
+	}
 	skb_push(skb, sizeof(struct ipv6hdr));
 	skb_reset_network_header(skb);
 	hdr = ipv6_hdr(skb);
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index dfabd9969b3f3..9d4614622ea6a 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1271,7 +1271,7 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 
 	if (encap_limit >= 0) {
 		init_tel_txopt(&opt, encap_limit);
-		ipv6_push_frag_opts(skb, &opt.ops, &proto);
+		proto = ipv6_push_frag_opts(skb, &opt.ops, proto);
 	}
 
 	skb_push(skb, sizeof(struct ipv6hdr));
-- 
2.53.0

