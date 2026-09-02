Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E3C47253F
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 10:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788346438; cv=none; b=DluBB/udLUO57qF88ruwTeZcG+lwSdmTT/aDN2UPQTyHwFo3C93HG30g97w8DuFxVu7nDb+jy1CR9gupf1sCauZk0WhE6cZVDichoEe6Hrnl4wHXdZnQuAi+lNreqEh3NkXgWzo8cMdegHoVntgToEFlaQ9aCAtbLrrXQPhGdXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788346438; c=relaxed/simple;
	bh=ObY30QfZsz1mXHmjjXDvM/glHllQGpL519lc+ezVMx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SfElqT51O1qyRqupN7s9hdZ3H4/4Pi+JpNfja8zgZ9LQJZhpgUlZ0nkHBZwiSHQbgf6hVsqviO7blFIYdCo6tdCDaW80eniBFvYWcasyGV21QDDn2S9uK1EdvK5KIoqfwL2AOv/JZOIjhPmrH8E/ezinblCcckJwVI+IHgCUcQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxhZVIoz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxhZVIoz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7921F00A3F;
	Wed,  2 Sep 2026 10:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788346423;
	bh=dyIeZX/7jU5uVsNIyQS9Gh9cHif4LhdQIj06sQw5Uew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gxhZVIoz0g8W/mWQn31uP3slejO8dHxDurEldXGzlrehNjRfLUNwMSXQoxIMV6HqL
	 k68HeZg8J7g+MBmEDIw/X3Zm+dxN9GsWCxVQxhvVMB1GLRO1iQE0MSTeV5AAuXMJPA
	 x4XmhXcV1uPTUnzpCUv0Ketm9VRX//B/sVJyTm9qsXjCb75pHXn2DNqisDJN60gfRW
	 QPGKlTAF9JneuZJ4xRH9oKZTH5et1ck6Lj2WxMtzhKtEI21j3XB1OcHBz3b3/B4pK+
	 Gbhnue3fg66Q9rNOF6FfvtvhSUViTOXf8EblClN6NEd5DwNdoSuOlAJZsJUBwwcTn2
	 Rsg9fwWFDt3Iw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/5] net: dst: introduce dst->dev_rcu
Date: Wed,  2 Sep 2026 06:53:37 -0400
Message-ID: <20260902105340.2049370-2-sashal@kernel.org>
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
 include/net/dst.h        | 11 +++++++----
 include/net/ip6_route.h  |  2 ++
 include/net/netns/ipv4.h |  1 +
 net/core/dst.c           |  2 +-
 net/ipv4/route.c         | 15 +++++++++++----
 net/ipv6/route.c         |  9 ++++-----
 6 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/include/net/dst.h b/include/net/dst.h
index b3522d3de8c8f..5b88d9ee277bd 100644
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
@@ -549,11 +552,11 @@ static inline void skb_dst_update_pmtu_no_confirm(struct sk_buff *skb, u32 mtu)
 
 static inline struct net_device *dst_dev_rcu(const struct dst_entry *dst)
 {
-	/* In the future, use rcu_dereference(dst->dev) */
-	WARN_ON_ONCE(!rcu_read_lock_held());
-	return READ_ONCE(dst->dev);
+	return rcu_dereference(dst->dev_rcu);
 }
 
+#define dst_dev_net_rcu(dst) dev_net_rcu(dst_dev_rcu(dst))
+
 static inline struct net_device *skb_dst_dev_rcu(const struct sk_buff *skb)
 {
 	return dst_dev_rcu(skb_dst(skb));
diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index 44969d03debf8..2b6156b75d08a 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -262,6 +262,8 @@ static inline bool ipv6_anycast_destination(const struct dst_entry *dst,
 int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 		 int (*output)(struct net *, struct sock *, struct sk_buff *));
 
+#define dst6_mtu(dst) dst_mtu(dst)
+
 static inline unsigned int ip6_skb_dst_mtu(struct sk_buff *skb)
 {
 	unsigned int mtu;
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 9b0d8649ae5b8..09c263b95700a 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -69,6 +69,7 @@ struct netns_ipv4 {
 
 	struct sock  * __percpu	*icmp_sk;
 	struct sock		*mc_autojoin_sk;
+	int			ip_rt_min_advmss;
 
 	struct inet_peer_base	*peers;
 	struct fqdir		*fqdir;
diff --git a/net/core/dst.c b/net/core/dst.c
index 6d74b4663085f..0eeeef7b2b713 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -151,7 +151,7 @@ void dst_dev_put(struct dst_entry *dst)
 		dst->ops->ifdown(dst, dev, true);
 	dst->input = dst_discard;
 	dst->output = dst_discard_out;
-	dst->dev = blackhole_netdev;
+	rcu_assign_pointer(dst->dev_rcu, blackhole_netdev);
 	dev_hold(dst->dev);
 	dev_put(dev);
 }
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index b7db0255af6e1..86f2c18b9d364 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -126,7 +126,7 @@ static int ip_rt_error_cost __read_mostly	= HZ;
 static int ip_rt_error_burst __read_mostly	= 5 * HZ;
 static int ip_rt_mtu_expires __read_mostly	= 10 * 60 * HZ;
 static u32 ip_rt_min_pmtu __read_mostly		= 512 + 20 + 20;
-static int ip_rt_min_advmss __read_mostly	= 256;
+#define DEFAULT_MIN_ADVMSS			256
 
 static int ip_rt_gc_timeout __read_mostly	= RT_GC_TIMEOUT;
 
@@ -1377,8 +1377,14 @@ static void set_class_tag(struct rtable *rt, u32 tag)
 static unsigned int ipv4_default_advmss(const struct dst_entry *dst)
 {
 	unsigned int header_size = sizeof(struct tcphdr) + sizeof(struct iphdr);
-	unsigned int advmss = max_t(unsigned int, ipv4_mtu(dst) - header_size,
-				    ip_rt_min_advmss);
+	unsigned int advmss;
+	struct net *net;
+
+	rcu_read_lock();
+	net = dst_dev_net_rcu(dst);
+	advmss = max_t(unsigned int, ipv4_mtu(dst) - header_size,
+				   net->ipv4.ip_rt_min_advmss);
+	rcu_read_unlock();
 
 	return min(advmss, IPV4_MAX_PMTU - header_size);
 }
@@ -3490,7 +3496,7 @@ static struct ctl_table ipv4_route_table[] = {
 	},
 	{
 		.procname	= "min_adv_mss",
-		.data		= &ip_rt_min_advmss,
+		.data		= &init_net.ipv4.ip_rt_min_advmss,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
@@ -3558,6 +3564,7 @@ static __net_initdata struct pernet_operations sysctl_route_ops = {
 
 static __net_init int rt_genid_init(struct net *net)
 {
+	net->ipv4.ip_rt_min_advmss = DEFAULT_MIN_ADVMSS;
 	atomic_set(&net->ipv4.rt_genid, 0);
 	atomic_set(&net->fnhe_genid, 0);
 	atomic_set(&net->ipv4.dev_addr_genid, get_random_int());
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index bda1d39f0b2e5..302d460b520da 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3055,17 +3055,16 @@ EXPORT_SYMBOL_GPL(ip6_sk_redirect);
 
 static unsigned int ip6_default_advmss(const struct dst_entry *dst)
 {
-	struct net_device *dev = dst->dev;
-	unsigned int mtu = dst_mtu(dst);
+	unsigned int mtu = dst6_mtu(dst);
 	struct net *net;
 
 	mtu -= sizeof(struct ipv6hdr) + sizeof(struct tcphdr);
 
 	rcu_read_lock();
 
-	net = dev_net_rcu(dev);
-	if (mtu < net->ipv6.sysctl.ip6_rt_min_advmss)
-		mtu = net->ipv6.sysctl.ip6_rt_min_advmss;
+	net = dst_dev_net_rcu(dst);
+	mtu = max_t(unsigned int, mtu,
+		    READ_ONCE(net->ipv6.sysctl.ip6_rt_min_advmss));
 
 	rcu_read_unlock();
 
-- 
2.53.0

