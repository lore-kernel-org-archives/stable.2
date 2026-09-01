Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EF14A2605
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 19:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788290921; cv=none; b=YRZMYzKJBhZA8HzOKxi65j/n6SI3vCEZ0Odex9JuUqpeSWG/sKIZ/7DJd+6EnLxEDYP7RwoO7lFXK8m3N/xitShdHqXAEhn/ZVLi8QK5jvKqPWGxuPuUi0buXY711KzDnUelUX0Lh/55tUioeJooM5vhX3zMgHjvzC/Sqrs3LGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788290921; c=relaxed/simple;
	bh=k221c6neLI8uvxOri7VgoI20n6IN8bEUWdN3zZO62gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l9eA/HrU9tMpzbxlHAR+I31aqTF6yT+a6uNsUBA4sFf0oISyml4sPqFRRmB12ter+8UdCZBSSDJSBHJQwZrLmxXb04qcwlbLSTcQo1k2hnqBD9lsCCG9I+nNXejdsBJ03zILafIONkrok9cEKfa/UDywDG1HT/iVzhdyicD9m7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izjACg2Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izjACg2Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83DB01F00A3D;
	Tue,  1 Sep 2026 19:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788290920;
	bh=l5degComSAAB1ABHmuv2A3GiFRIDXhg76XKCWIqbXS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=izjACg2Y583KKVyE0pPzhLvLYrP0NbcQ14b3awkAx+/XbC7mRZg/njFP38XnSX3Rk
	 GGIP4NKsK4O6QD2TJ5W0L40pteLoedz/raXRfQcV8LR6ec81jkzny61ZYsKeE1gvSc
	 W2P2TuPXNCtwJkhuJbi+r8MmBVbz022Fu4yp/TVw8AzPQLjeYx0hvDP3aQDX76kmg0
	 TXm976ceZrvyA0kHt2cP3gLeBD6F+QjxiTDhC17KQSa0pznrWBZKFqkTq+Xwbd0bV7
	 AOxT2vn+NzlorrhDAf3PJ2TY4IyCR1zFq8KhGFcM0XK0Rbw0wsnXT6vOV/M3UIH2e4
	 Ek6q7lTzP3aAQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/4] net: dst: introduce dst->dev_rcu
Date: Tue,  1 Sep 2026 15:28:35 -0400
Message-ID: <20260901192838.1439895-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026083117-magnitude-talisman-5d78@gregkh>
References: <2026083117-magnitude-talisman-5d78@gregkh>
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
 include/net/dst.h       | 11 +++++++----
 include/net/ip6_route.h |  2 ++
 net/core/dst.c          |  2 +-
 net/ipv4/route.c        |  4 ++--
 net/ipv6/route.c        |  5 ++---
 5 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/include/net/dst.h b/include/net/dst.h
index 20a76e532afbb..d149ffa0948c0 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -23,7 +23,10 @@
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
@@ -557,11 +560,11 @@ static inline void skb_dst_update_pmtu_no_confirm(struct sk_buff *skb, u32 mtu)
 
 static inline struct net_device *dst_dev_rcu(const struct dst_entry *dst)
 {
-	/* In the future, use rcu_dereference(dst->dev) */
-	WARN_ON_ONCE(!rcu_read_lock_held());
-	return READ_ONCE(dst->dev);
+	return rcu_dereference(dst->dev_rcu);
 }
 
+#define dst_dev_net_rcu(dst)	dev_net_rcu(dst_dev_rcu(dst))
+
 static inline struct net_device *skb_dst_dev_rcu(const struct sk_buff *skb)
 {
 	return dst_dev_rcu(skb_dst(skb));
diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index 7c0184c09392f..ca67b63ae8866 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -270,6 +270,8 @@ static inline bool ipv6_anycast_destination(const struct dst_entry *dst,
 int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 		 int (*output)(struct net *, struct sock *, struct sk_buff *));
 
+#define dst6_mtu(dst)		dst_mtu(dst)
+
 static inline unsigned int ip6_skb_dst_mtu(const struct sk_buff *skb)
 {
 	const struct ipv6_pinfo *np = skb->sk && !dev_recursion_level() ?
diff --git a/net/core/dst.c b/net/core/dst.c
index 8db87258d1450..c6cd97cd7dd3f 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -151,7 +151,7 @@ void dst_dev_put(struct dst_entry *dst)
 		dst->ops->ifdown(dst, dev, true);
 	dst->input = dst_discard;
 	dst->output = dst_discard_out;
-	dst->dev = blackhole_netdev;
+	rcu_assign_pointer(dst->dev_rcu, blackhole_netdev);
 	netdev_ref_replace(dev, blackhole_netdev, &dst->dev_tracker,
 			   GFP_ATOMIC);
 }
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 783460ebfc471..0fd2d07dbc144 100644
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
index e198a5eb24c64..1f02a13481f1e 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3226,15 +3226,14 @@ EXPORT_SYMBOL_GPL(ip6_sk_redirect);
 
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

