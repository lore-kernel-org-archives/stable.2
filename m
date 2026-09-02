Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACF947DD69
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 10:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788346442; cv=none; b=gCs+YJEL+lrZgUehLWM3dlD/MK7iYkhMc/FcNF/QpbvO0y1PYejGm3203kPyLoNUIsELSxbRgKabCkwEaJEzfUgOd2gZTDCen5Yz8llsSatE6c80avg9A8sjgtDILqlN4/czlH5CcKgSETy77gzjy0QMHNWDbHzjdRlXdRibZo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788346442; c=relaxed/simple;
	bh=RFuImkf9WZJyQHIsKQXTOPkPujHRIfZ4mvu/FYfZ6ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=auzq/Tnx0tsIUVbgtLO/mz9hY8tE3P+yxJDI6ks1CzOFMKfCoXlI++YtE+lfeafmvHM8HGuq9jgFauAs1BdcxMZaPHpFUSu/L3LoXXy5mc+MeXGhig7CKz3P5DMN/WxOiw5yNBcmOSxkNRsjPm9dlrDzL62u9BeeshM8qYyahZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvBVkoqB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvBVkoqB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD861F00ADF;
	Wed,  2 Sep 2026 10:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788346424;
	bh=dDdtsMmRZ2RmuXUD1q+FDZTkUMv75V+MAWZDSaWga78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GvBVkoqBO3V9WMhSLnapat6rPpw4pFJKnJQu1UitaE7G7rCyuujkaJEnMYJm+gEOD
	 AFGAy8ud8cAoQPGxmNlFhURffqJ8PxnNwsbIRyL2xVCaJ259Swlbi0wXLdbOCjihKc
	 iuePeKDyvogrrI4DOyoCejn9Wc861rO3VEHYYRatMmeLIbCIvDn/PDm1kpW86qxmqE
	 0mqld9DuLGHGm/oFOZWCw7irt6GFNfhuSSVcZM3g9Os5zLNIezStStXS9Oh1axPCBS
	 NnLihD8Q4rZ8fke6wicqwBzU8/ZWOzEAtQGDDUnL/uUOrRjT2fI5Ahb3GUJbnUVZOb
	 VLr9yNd6OKYLA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/5] ipv6: pass proto by value to ipv6_push_nfrag_opts() and ipv6_push_frag_opts()
Date: Wed,  2 Sep 2026 06:53:38 -0400
Message-ID: <20260902105340.2049370-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902105340.2049370-1-sashal@kernel.org>
References: <2026083120-unmoral-bovine-2668@gregkh>
 <20260902105340.2049370-1-sashal@kernel.org>
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

[ stable backport note: Retain the older final_dst buffer in
__ip6_make_skb(), since b60d4e58c615 ("ipv6: remove daddr temp buffer in
__ip6_make_skb") is not present.  Also make the existing
ip_dst_mtu_maybe_forward() RCU-safe so the follow-up MSS fix has its
expected insertion context. ]

Stable-dep-of: 2640e6419594 ("net: advertise TCP MSS from the configured MTU, not the learned PMTU")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/ip.h      | 24 ++++++++++++++-----
 include/net/ipv6.h    | 10 ++++----
 net/ipv6/exthdrs.c    | 55 +++++++++++++++++++++++--------------------
 net/ipv6/ip6_output.c | 13 +++++-----
 net/ipv6/ip6_tunnel.c |  2 +-
 5 files changed, 60 insertions(+), 44 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 9be2efe00f2c0..1911bcf6d94ed 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -440,20 +440,32 @@ static inline bool ip_sk_ignore_df(const struct sock *sk)
 static inline unsigned int ip_dst_mtu_maybe_forward(const struct dst_entry *dst,
 						    bool forwarding)
 {
-	struct net *net = dev_net(dst->dev);
-	unsigned int mtu;
+	const struct net_device *dev;
+	unsigned int mtu, res;
+	struct net *net;
+
+	rcu_read_lock();
 
+	dev = dst_dev_rcu(dst);
+	net = dev_net_rcu(dev);
 	if (READ_ONCE(net->ipv4.sysctl_ip_fwd_use_pmtu) ||
 	    ip_mtu_locked(dst) ||
-	    !forwarding)
-		return dst_mtu(dst);
+	    !forwarding) {
+		mtu = dst_mtu(dst);
+		goto out;
+	}
 
 	/* 'forwarding = true' case should always honour route mtu */
 	mtu = dst_metric_raw(dst, RTAX_MTU);
 	if (!mtu)
-		mtu = min(READ_ONCE(dst->dev->mtu), IP_MAX_MTU);
+		mtu = min(READ_ONCE(dev->mtu), IP_MAX_MTU);
+
+out:
+	res = mtu - lwtunnel_headroom(dst->lwtstate, mtu);
+
+	rcu_read_unlock();
 
-	return mtu - lwtunnel_headroom(dst->lwtstate, mtu);
+	return res;
 }
 
 static inline unsigned int ip_skb_dst_mtu(struct sock *sk,
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index c597596738754..134167086d61e 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1046,11 +1046,11 @@ int ip6_local_out(struct net *net, struct sock *sk, struct sk_buff *skb);
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
index 0230fa98a3482..a323f0405c202 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -1061,9 +1061,9 @@ int ipv6_parse_hopopts(struct sk_buff *skb)
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
@@ -1082,13 +1082,13 @@ static void ipv6_push_rthdr0(struct sk_buff *skb, u8 *proto,
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
@@ -1131,58 +1131,61 @@ static void ipv6_push_rthdr4(struct sk_buff *skb, u8 *proto,
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
index c8d975749c2bd..f023bfe15e2e7 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -290,11 +290,12 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
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
 
 	skb_push(skb, sizeof(struct ipv6hdr));
@@ -1824,10 +1825,10 @@ struct sk_buff *__ip6_make_skb(struct sock *sk,
 	*final_dst = fl6->daddr;
 	__skb_pull(skb, skb_network_header_len(skb));
 	if (opt && opt->opt_flen)
-		ipv6_push_frag_opts(skb, opt, &proto);
+		proto = ipv6_push_frag_opts(skb, opt, proto);
 	if (opt && opt->opt_nflen)
-		ipv6_push_nfrag_opts(skb, opt, &proto, &final_dst, &fl6->saddr);
-
+		proto = ipv6_push_nfrag_opts(skb, opt, proto, &final_dst,
+					     &fl6->saddr);
 	skb_push(skb, sizeof(struct ipv6hdr));
 	skb_reset_network_header(skb);
 	hdr = ipv6_hdr(skb);
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index b4c09cf33af8f..ff88f98289812 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1293,7 +1293,7 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 
 	if (encap_limit >= 0) {
 		init_tel_txopt(&opt, encap_limit);
-		ipv6_push_frag_opts(skb, &opt.ops, &proto);
+		proto = ipv6_push_frag_opts(skb, &opt.ops, proto);
 	}
 
 	skb_push(skb, sizeof(struct ipv6hdr));
-- 
2.53.0

