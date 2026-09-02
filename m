Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FEE3ACA4E
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 10:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788346433; cv=none; b=nWDLZKk5kIpa3NZre+zfLbh5c9jGPmsOaJ/ocGnPiPW9stREHJHJdZ48wM3u1t0izYVg8N7ao3zM/wi56vK3UFfHxZBPjGcWc9LIjR/LtH4M4F3bdSQDdkpag81wDSTAi6DFojbToAkU2xwCwTe706s0lg2Wd114P62/ufSQP4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788346433; c=relaxed/simple;
	bh=5Q1J6n8LW2YfF55dDP0rjmq5Ztlp9wixefMhoPL6+ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yxmk9ISqZG62W7uhgm7+1nxu1gypnlLkj2Qq04F1nulAaS2SkfVa0wz80wwn6s8zRSc4PZ7++nQ1WPMEiRI5TDEd7CeqlE1tW60nXwF4PAw3jv3GM7KRe6uYMwCM1wH2pUvcCzm/8vTCSPfoZNOE168SiVO7oY99Iq45hUxmYAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLOeHijr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLOeHijr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC5E1F00ADB;
	Wed,  2 Sep 2026 10:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788346415;
	bh=t/lqVf+i6Y243jP5HNAUYFGu4Iz780lpRnbu8RhWThM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WLOeHijrx46tY63lD11i5opcFio+RD5+wAqT9AAVspQnVIGL3Mugsw0CF89W64kvY
	 D/XgahYL/w6kOYxeSYKBG7D7OjFu7T18G04SoymTYmYFgt7iUYQnHgKeb4Hoqg9O86
	 ntNC9VIyhXjv/ikQYmaf9kx7qhtxWYtxG6vWYM7K3Q1WnFvH/RLdUKDShWNyKmN/7z
	 VZgBmhERCGCQLxI0Rmvlif+ysc/TybTPRifzFgPZFgyEL1tQ3Xp3aFcy3WKCSVdUkv
	 tltLGai0ljJQYIG9hdtc9bNeT1s/fjFhC3pZ7tHUDJBoNC+d/1E/ejamY/9wVxFkAS
	 ROXn74i9LxHYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/5] ipv6: pass proto by value to ipv6_push_nfrag_opts() and ipv6_push_frag_opts()
Date: Wed,  2 Sep 2026 06:53:28 -0400
Message-ID: <20260902105332.2048804-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026083106-glisten-superhero-188c@gregkh>
References: <2026083106-glisten-superhero-188c@gregkh>
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

        ipv6_push_frag_opts(skb, opt, &proto);
with:
        proto = ipv6_push_frag_opts(skb, opt, proto);

Note that even after this change, ip6_xmit() has to use a stack canary
because of @first_hop variable.

[ 5.10 backport note: __ip6_make_skb() here still uses the older
  final_dst_buf/*final_dst = fl6->daddr pattern (the later refactor
  that reassigns final_dst = &fl6->daddr is not present in this tree),
  so that hunk was resolved by converting the calls to the by-value
  proto style while keeping the existing final_dst handling as-is. ]

Stable-dep-of: 870a9e42ecc6 ("tcp: clamp route advmss to TCP_MIN_MSS")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/ipv6.h    | 10 ++++----
 net/ipv6/exthdrs.c    | 55 +++++++++++++++++++++++--------------------
 net/ipv6/ip6_output.c | 12 ++++++----
 net/ipv6/ip6_tunnel.c |  2 +-
 4 files changed, 42 insertions(+), 37 deletions(-)

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
index c8d975749c2bd..8948c79504ce7 100644
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
@@ -1824,9 +1825,10 @@ struct sk_buff *__ip6_make_skb(struct sock *sk,
 	*final_dst = fl6->daddr;
 	__skb_pull(skb, skb_network_header_len(skb));
 	if (opt && opt->opt_flen)
-		ipv6_push_frag_opts(skb, opt, &proto);
+		proto = ipv6_push_frag_opts(skb, opt, proto);
 	if (opt && opt->opt_nflen)
-		ipv6_push_nfrag_opts(skb, opt, &proto, &final_dst, &fl6->saddr);
+		proto = ipv6_push_nfrag_opts(skb, opt, proto, &final_dst,
+					     &fl6->saddr);
 
 	skb_push(skb, sizeof(struct ipv6hdr));
 	skb_reset_network_header(skb);
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

