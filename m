Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9FB2E888A
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 11:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789644323; cv=none; b=uIqc7DPnHUtcMhQCcKtCJuKjYqbI8dK9wqI3muhl/aPLbCdoElNHBlFrekixE/3GKTRgDsyasdYrkY6j+UQfs0BwB4SgK1AYHsnNJh2VDMhKY9idA9EGjFa/Z2DievkKbfjOiFfR5vMZgRYRfHm0u8W9F/LS6Kg5PO3rDQF+67w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789644323; c=relaxed/simple;
	bh=4TNs8aBfeKg6tLbmDnTnIsJBE0B6cRhDjE/h8E+jhpE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MUzdbarwBKVWWbExy0fg6m4gQ8KawZAlx9Rn9SjVD30qmevIqvs5V6ZroXB3TUXgEEEWcbXpP0UPPDkL1F4Knd3dPSScRPoofynC3NQJ+vsApkbSY6aSGFWLGtqrBKi4tSmzCVH4EIFJSWFWj2lrvnu+ICdmr1sMJlVupHyPmZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l9aLVn/5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l9aLVn/5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7151F000FF;
	Thu, 17 Sep 2026 11:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789644322;
	bh=BsKafnQlRNNL0mxA9SXLlZPkEhLVlPVjR0R4XoiyXV0=;
	h=Subject:To:Cc:From:Date;
	b=l9aLVn/5JQg7Yrg2PsIqVPACpXYMZvUlyqp4kmRZbJyZ/Arx4mSflbpyI31M3hqgt
	 vUFhoWJ/U0VF5LD2ITO8ScFu1EzTG/nv2y+KJglCe3JBeFCMEGwq7q51049BYs+Bxp
	 A5QO6sajxX7Zytub6yGwhcIL3AAdnUOvQ0/PcgsA=
Subject: FAILED: patch "[PATCH] ipv6: start using dst_dev_rcu()" failed to apply to 6.12-stable tree
To: edumazet@google.com,dsahern@kernel.org,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Sep 2026 12:15:58 +0100
Message-ID: <2026091758-subsector-deity-17bd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x b775ecf1655cedbc465fd6699ab18a2bc4e7a352
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091758-subsector-deity-17bd@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b775ecf1655cedbc465fd6699ab18a2bc4e7a352 Mon Sep 17 00:00:00 2001
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 28 Aug 2025 19:58:17 +0000
Subject: [PATCH] ipv6: start using dst_dev_rcu()

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

diff --git a/net/ipv6/anycast.c b/net/ipv6/anycast.c
index f8a8e46286b8..52599584422b 100644
--- a/net/ipv6/anycast.c
+++ b/net/ipv6/anycast.c
@@ -104,7 +104,7 @@ int ipv6_sock_ac_join(struct sock *sk, int ifindex, const struct in6_addr *addr)
 		rcu_read_lock();
 		rt = rt6_lookup(net, addr, NULL, 0, NULL, 0);
 		if (rt) {
-			dev = dst_dev(&rt->dst);
+			dev = dst_dev_rcu(&rt->dst);
 			netdev_hold(dev, &dev_tracker, GFP_ATOMIC);
 			ip6_rt_put(rt);
 		} else if (ishost) {
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index 44550957fd4e..95cdd4cacb00 100644
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
index 55c49dc14b1b..016b572e7d6f 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -180,7 +180,7 @@ static struct net_device *ip6_mc_find_dev(struct net *net,
 		rcu_read_lock();
 		rt = rt6_lookup(net, group, NULL, 0, NULL, 0);
 		if (rt) {
-			dev = dst_dev(&rt->dst);
+			dev = dst_dev_rcu(&rt->dst);
 			dev_hold(dev);
 			ip6_rt_put(rt);
 		}
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 57aaa7ae8ac3..f427e41e9c49 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -505,7 +505,7 @@ void ndisc_send_skb(struct sk_buff *skb, const struct in6_addr *daddr,
 
 	ip6_nd_hdr(skb, saddr, daddr, READ_ONCE(inet6_sk(sk)->hop_limit), skb->len);
 
-	dev = dst_dev(dst);
+	dev = dst_dev_rcu(dst);
 	idev = __in6_dev_get(dev);
 	IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTREQUESTS);
 
diff --git a/net/ipv6/output_core.c b/net/ipv6/output_core.c
index d21fe27fe21e..1c9b283a4132 100644
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
index 3299cfa12e21..3371f16b7a3e 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2943,7 +2943,7 @@ static void __ip6_rt_update_pmtu(struct dst_entry *dst, const struct sock *sk,
 
 		if (res.f6i->nh) {
 			struct fib6_nh_match_arg arg = {
-				.dev = dst_dev(dst),
+				.dev = dst_dev_rcu(dst),
 				.gw = &rt6->rt6i_gateway,
 			};
 
@@ -3238,7 +3238,6 @@ EXPORT_SYMBOL_GPL(ip6_sk_redirect);
 
 static unsigned int ip6_default_advmss(const struct dst_entry *dst)
 {
-	struct net_device *dev = dst_dev(dst);
 	unsigned int mtu = dst_mtu(dst);
 	struct net *net;
 
@@ -3246,7 +3245,7 @@ static unsigned int ip6_default_advmss(const struct dst_entry *dst)
 
 	rcu_read_lock();
 
-	net = dev_net_rcu(dev);
+	net = dst_dev_net_rcu(dst);
 	if (mtu < net->ipv6.sysctl.ip6_rt_min_advmss)
 		mtu = net->ipv6.sysctl.ip6_rt_min_advmss;
 
@@ -4301,7 +4300,7 @@ static void rt6_do_redirect(struct dst_entry *dst, struct sock *sk, struct sk_bu
 
 	if (res.f6i->nh) {
 		struct fib6_nh_match_arg arg = {
-			.dev = dst_dev(dst),
+			.dev = dst_dev_rcu(dst),
 			.gw = &rt->rt6i_gateway,
 		};
 

