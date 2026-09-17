Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29D53EA955
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 18:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789670390; cv=none; b=cK7uUpuBI6bLsTIwLNOZ05WrN/+OLmiwbEuXE+TJ+lwe1HlGjXebzHBbrys1aeQadAwxkM1LKql0y7xIpu0GCl7ohAPJ4027deAuPUr1IHMnrfUhKCBif8YtdEB96zT51cM/GbQk/ITX4A8k0tGZPXCPEGSW0sAdVf2Kb0lzC8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789670390; c=relaxed/simple;
	bh=30KD+ZbfS6bLiVi3AcIjxXNHuXSaMJ7nlDU6jkO9cVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T3ubezr/4U3v+T5odSx0q69q8kKW5G9cIJItJQncdn/r/ll4fDfvQPOAx2m9EdkRQ2hrKqoMYItr1av96b3aJOnAZv9NS09KysxJOVaxQjpSFPfW8ae7iI1FJ1ucejtGT1nP9KSaQTRUSITZ3TMzhn9tVHAxk7gCm08vUxHa6TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTWQ6aXK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTWQ6aXK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27EA1F00898;
	Thu, 17 Sep 2026 18:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789670388;
	bh=z9Rvy6zSpqSPujGPPitDAmUYAXJtCoLclI5c9RnmG/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aTWQ6aXKa9pdv3d7+ipm6p53fi1qvZ8wjJ26nquifBQd5AADPdCG56TxrIc8/aI5a
	 vRqihL4q1SqLY3x/BV9Mci1oG2dMj+2B7BS3g3n7H2bIoFuqePdNVqxCpk7QaUikyU
	 2352Kxp7rtT6xDkJTy/LlKEQ5f9DRNb9cDHyGJKSqGdrlo6GoNkhek2GAb9Bp6b5sZ
	 ShnguTSVc1ypA0H0dRYjYepbn7kpvAwcRyz5cR7dzWdVlOJD0Lc119Blq6ar0VgUZv
	 Sy+VaK1v99UFd1JJ1cntaS5TbA2qeAvbTsDln7HPWgY91oShzh2f6My3wp3TkpxcQP
	 nuLTdkMQSFSsw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] ipv6: start using dst_dev_rcu()
Date: Thu, 17 Sep 2026 14:39:45 -0400
Message-ID: <20260917183945.1201473-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917183945.1201473-1-sashal@kernel.org>
References: <2026091758-subsector-deity-17bd@gregkh>
 <20260917183945.1201473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit b775ecf1655cedbc465fd6699ab18a2bc4e7a352 ]

Refactor icmpv6_xrlim_allow() and ip6_dst_hoplimit()
so that we acquire rcu_read_lock() a bit longer
to be able to use dst_dev_rcu() instead of dst_dev().

__ip6_rt_update_pmtu() and rt6_do_redirect can directly
use dst_dev_rcu() in sections already holding rcu_read_lock().

Small changes to use dst_dev_net_rcu() in
ip6_default_advmss(), ipv6_sock_ac_join(),
ip6_mc_find_dev() and ndisc_send_skb().

Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://patch.msgid.link/20250828195823.3958522-3-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/anycast.c     | 2 +-
 net/ipv6/icmp.c        | 6 +++---
 net/ipv6/mcast.c       | 2 +-
 net/ipv6/ndisc.c       | 2 +-
 net/ipv6/output_core.c | 8 +++++---
 net/ipv6/route.c       | 7 +++----
 6 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/net/ipv6/anycast.c b/net/ipv6/anycast.c
index 19ab520ea049d..8bf06f8cf9d68 100644
--- a/net/ipv6/anycast.c
+++ b/net/ipv6/anycast.c
@@ -100,7 +100,7 @@ int ipv6_sock_ac_join(struct sock *sk, int ifindex, const struct in6_addr *addr)
 		rcu_read_lock();
 		rt = rt6_lookup(net, addr, NULL, 0, NULL, 0);
 		if (rt) {
-			dev = dst_dev(&rt->dst);
+			dev = dst_dev_rcu(&rt->dst);
 			netdev_hold(dev, &dev_tracker, GFP_ATOMIC);
 			ip6_rt_put(rt);
 		} else if (ishost) {
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index 229ae205450d3..e4e40f0694238 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -209,7 +209,8 @@ static bool icmpv6_xrlim_allow(struct sock *sk, u8 type,
 	 * this lookup should be more aggressive (not longer than timeout).
 	 */
 	dst = ip6_route_output(net, sk, fl6);
-	dev = dst_dev(dst);
+	rcu_read_lock();
+	dev = dst_dev_rcu(dst);
 	if (dst->error) {
 		IP6_INC_STATS(net, ip6_dst_idev(dst),
 			      IPSTATS_MIB_OUTNOROUTES);
@@ -224,11 +225,10 @@ static bool icmpv6_xrlim_allow(struct sock *sk, u8 type,
 		if (rt->rt6i_dst.plen < 128)
 			tmo >>= ((128 - rt->rt6i_dst.plen)>>5);
 
-		rcu_read_lock();
 		peer = inet_getpeer_v6(net->ipv6.peers, &fl6->daddr);
 		res = inet_peer_xrlim_allow(peer, tmo);
-		rcu_read_unlock();
 	}
+	rcu_read_unlock();
 	if (!res)
 		__ICMP6_INC_STATS(net, ip6_dst_idev(dst),
 				  ICMP6_MIB_RATELIMITHOST);
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 8a37e878e5f8e..298bf64899548 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -179,7 +179,7 @@ static struct inet6_dev *ip6_mc_find_dev(struct net *net,
 		rcu_read_lock();
 		rt = rt6_lookup(net, group, NULL, 0, NULL, 0);
 		if (rt) {
-			dev = dst_dev(&rt->dst);
+			dev = dst_dev_rcu(&rt->dst);
 			dev_hold(dev);
 			ip6_rt_put(rt);
 		}
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 87bed84a00532..26ad7cab0383f 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -508,7 +508,7 @@ void ndisc_send_skb(struct sk_buff *skb, const struct in6_addr *daddr,
 
 	ip6_nd_hdr(skb, saddr, daddr, READ_ONCE(inet6_sk(sk)->hop_limit), skb->len);
 
-	dev = dst_dev(dst);
+	dev = dst_dev_rcu(dst);
 	idev = __in6_dev_get(dev);
 	IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTREQUESTS);
 
diff --git a/net/ipv6/output_core.c b/net/ipv6/output_core.c
index 90a178dd24aae..5be101401a00e 100644
--- a/net/ipv6/output_core.c
+++ b/net/ipv6/output_core.c
@@ -104,18 +104,20 @@ EXPORT_SYMBOL(ip6_find_1stfragopt);
 int ip6_dst_hoplimit(struct dst_entry *dst)
 {
 	int hoplimit = dst_metric_raw(dst, RTAX_HOPLIMIT);
+
+	rcu_read_lock();
 	if (hoplimit == 0) {
-		struct net_device *dev = dst_dev(dst);
+		struct net_device *dev = dst_dev_rcu(dst);
 		struct inet6_dev *idev;
 
-		rcu_read_lock();
 		idev = __in6_dev_get(dev);
 		if (idev)
 			hoplimit = READ_ONCE(idev->cnf.hop_limit);
 		else
 			hoplimit = READ_ONCE(dev_net(dev)->ipv6.devconf_all->hop_limit);
-		rcu_read_unlock();
 	}
+	rcu_read_unlock();
+
 	return hoplimit;
 }
 EXPORT_SYMBOL(ip6_dst_hoplimit);
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 3e5bf8a5b32b2..f49b0578ae347 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2949,7 +2949,7 @@ static void __ip6_rt_update_pmtu(struct dst_entry *dst, const struct sock *sk,
 
 		if (res.f6i->nh) {
 			struct fib6_nh_match_arg arg = {
-				.dev = dst_dev(dst),
+				.dev = dst_dev_rcu(dst),
 				.gw = &rt6->rt6i_gateway,
 			};
 
@@ -3244,7 +3244,6 @@ EXPORT_SYMBOL_GPL(ip6_sk_redirect);
 
 static unsigned int ip6_default_advmss(const struct dst_entry *dst)
 {
-	struct net_device *dev = dst_dev(dst);
 	unsigned int mtu = dst_mtu(dst);
 	struct net *net;
 
@@ -3252,7 +3251,7 @@ static unsigned int ip6_default_advmss(const struct dst_entry *dst)
 
 	rcu_read_lock();
 
-	net = dev_net_rcu(dev);
+	net = dst_dev_net_rcu(dst);
 	if (mtu < net->ipv6.sysctl.ip6_rt_min_advmss)
 		mtu = net->ipv6.sysctl.ip6_rt_min_advmss;
 
@@ -4266,7 +4265,7 @@ static void rt6_do_redirect(struct dst_entry *dst, struct sock *sk, struct sk_bu
 
 	if (res.f6i->nh) {
 		struct fib6_nh_match_arg arg = {
-			.dev = dst_dev(dst),
+			.dev = dst_dev_rcu(dst),
 			.gw = &rt->rt6i_gateway,
 		};
 
-- 
2.53.0

