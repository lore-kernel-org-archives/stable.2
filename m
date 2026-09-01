Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F264435203D
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 14:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272282; cv=none; b=UKClQaTxxO/i0x7imCiHDc0mj0lGlOjAgcxbYyaymgbrvhJoygfsAllTUM1Gse1Abh9FDGB5nxg3tQgvNJbtSGwl5iwPNw/vRZVMiC2gF+cGv0LJjM2K0+alO6c9GlSeKQiiT38bIkknkLFHxhTDAm0IBeWGhuucLIjquH9s/dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272282; c=relaxed/simple;
	bh=Pvcr6aADTnlimuN6Y8PHuZXhXsrzfGr6b4JsTHSqvXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cTnmW19+M/JUDh0q9NMhM8tYjznDCEsj2QVkLWi36Zj/5dlcaoxuKN+Mik/UTtTje/671i4sppHjv2+T0OCZb7d4VEB+CexBF+q7sgVm6vsgkVoC8gGhb/m7S/XEK0PSQzi7xSSmaiB/vkihuiJpT5tP7e4ODtX877iiFlRR59c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmbqGC8R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmbqGC8R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F2C1F000E9;
	Tue,  1 Sep 2026 14:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788272280;
	bh=yuQF4khqmuXakRgo7yGoCR5LMVu2ibw5w/r+22W93Xc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RmbqGC8RCiETE2G3eBydzkH3T0K734Q2S9E1ynfEK/yGC1s5KhV3Gxd7z7E9fvNqX
	 zDktMo6oXMFf1Xw/646ZaC2O5SAJViaDI4M2oDWBDZP7XpbFR2aCLsFC9ZVzPyNkAr
	 bQe4yIHfzRKAghNS4u+6Hu0ibDi5RBfYXt/yCKH7u+8qgvhQuAlQ2YSHoGvHe4fFHC
	 Aip/B4EvW8K+3/MbLUVMW8CGJyEaQtc58zgM10GWvTBvLNzrO5qyQVkkS70L34n1BP
	 17GxzXW0lpSXTG0CxhPhK1Ww7E+6XGrjPAhXL3Q0k9V1vFHuY/M1jtg+Fb2euXckeY
	 nb6FOIIQvTmyA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] net: dst: introduce dst->dev_rcu
Date: Tue,  1 Sep 2026 10:17:56 -0400
Message-ID: <20260901141758.1030958-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026083115-payer-hate-2a8e@gregkh>
References: <2026083115-payer-hate-2a8e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit caedcc5b6df1b2e2b5f39079e3369c1d4d5c5f50 ]

Followup of commit 88fe14253e18 ("net: dst: add four helpers
to annotate data-races around dst->dev").

We want to gradually add explicit RCU protection to dst->dev,
including lockdep support.

Add an union to alias dst->dev_rcu and dst->dev.

Add dst_dev_net_rcu() helper.

Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://patch.msgid.link/20250828195823.3958522-2-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 2640e6419594 ("net: advertise TCP MSS from the configured MTU, not the learned PMTU")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/dst.h       | 14 ++++++++++----
 include/net/ip6_route.h |  3 +++
 net/core/dst.c          |  2 +-
 net/ipv4/route.c        |  4 ++--
 net/ipv6/route.c        |  5 ++---
 5 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/include/net/dst.h b/include/net/dst.h
index 55d1be268d243..13222e13014b1 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -24,7 +24,10 @@
 struct sk_buff;
 
 struct dst_entry {
-	struct net_device       *dev;
+	union {
+		struct net_device       *dev;
+		struct net_device __rcu *dev_rcu;
+	};
 	struct  dst_ops	        *ops;
 	unsigned long		_metrics;
 	unsigned long           expires;
@@ -571,9 +574,12 @@ static inline void skb_dst_update_pmtu_no_confirm(struct sk_buff *skb, u32 mtu)
 
 static inline struct net_device *dst_dev_rcu(const struct dst_entry *dst)
 {
-	/* In the future, use rcu_dereference(dst->dev) */
-	WARN_ON_ONCE(!rcu_read_lock_held());
-	return READ_ONCE(dst->dev);
+	return rcu_dereference(dst->dev_rcu);
+}
+
+static inline struct net *dst_dev_net_rcu(const struct dst_entry *dst)
+{
+	return dev_net_rcu(dst_dev_rcu(dst));
 }
 
 static inline struct net_device *skb_dst_dev_rcu(const struct sk_buff *skb)
diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index 392232fcd703c..2a87494cd2562 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -266,6 +266,9 @@ static inline bool ipv6_anycast_destination(const struct dst_entry *dst,
 int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 		 int (*output)(struct net *, struct sock *, struct sk_buff *));
 
+/* Compatibility spelling used by newer IPv6 route code. */
+#define dst6_mtu(dst) dst_mtu(dst)
+
 static inline unsigned int ip6_skb_dst_mtu(const struct sk_buff *skb)
 {
 	const struct ipv6_pinfo *np = skb->sk && !dev_recursion_level() ?
diff --git a/net/core/dst.c b/net/core/dst.c
index 5ed8cb10748f5..f14d27f0f6dbd 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -153,7 +153,7 @@ void dst_dev_put(struct dst_entry *dst)
 		dst->ops->ifdown(dst, dev);
 	WRITE_ONCE(dst->input, dst_discard);
 	WRITE_ONCE(dst->output, dst_discard_out);
-	dst->dev = blackhole_netdev;
+	rcu_assign_pointer(dst->dev_rcu, blackhole_netdev);
 	netdev_ref_replace(dev, blackhole_netdev, &dst->dev_tracker,
 			   GFP_ATOMIC);
 }
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 789953096c80d..3d2dc9bc62ab7 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1069,7 +1069,7 @@ static void __ip_rt_update_pmtu(struct rtable *rt, struct flowi4 *fl4, u32 mtu)
 		return;
 
 	rcu_read_lock();
-	net = dev_net_rcu(dst->dev);
+	net = dst_dev_net_rcu(dst);
 	if (mtu < net->ipv4.ip_rt_min_pmtu) {
 		lock = true;
 		mtu = min(old_mtu, net->ipv4.ip_rt_min_pmtu);
@@ -1367,7 +1367,7 @@ static unsigned int ipv4_default_advmss(const struct dst_entry *dst)
 	struct net *net;
 
 	rcu_read_lock();
-	net = dev_net_rcu(dst->dev);
+	net = dst_dev_net_rcu(dst);
 	advmss = max_t(unsigned int, ipv4_mtu(dst) - header_size,
 				   net->ipv4.ip_rt_min_advmss);
 	rcu_read_unlock();
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 24d097290dbc0..319467b855531 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3234,15 +3234,14 @@ EXPORT_SYMBOL_GPL(ip6_sk_redirect);
 
 static unsigned int ip6_default_advmss(const struct dst_entry *dst)
 {
-	struct net_device *dev = dst->dev;
-	unsigned int mtu = dst_mtu(dst);
+	unsigned int mtu = dst6_mtu(dst);
 	struct net *net;
 
 	mtu -= sizeof(struct ipv6hdr) + sizeof(struct tcphdr);
 
 	rcu_read_lock();
 
-	net = dev_net_rcu(dev);
+	net = dst_dev_net_rcu(dst);
 	if (mtu < net->ipv6.sysctl.ip6_rt_min_advmss)
 		mtu = net->ipv6.sysctl.ip6_rt_min_advmss;
 
-- 
2.53.0

