Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BAE4A207D
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 19:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788290919; cv=none; b=CmXJsmY+BYYvCVxyJWMPA/xMJqSNH5UwKaMYwb1MTKR8l0E0ovX3qKw+CV9j48sftTfmOR2w7F7D+nUBdbRB3FUzPx3IXMDlpC/fcwJ4b7CRUqwHESaJ1Ehk2eSGSiIwX2CIsu8da5UmE77ZlmTiJTZJDAZKzagqtuSv1fFJgJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788290919; c=relaxed/simple;
	bh=7QOE4TCrXj/xemdhDOcAQzDzwyTFimEKSQbvLK/wLJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3E2syHmWhPzNsgWk0QSTxHOFDVTztXMWkipKLVdjAsGxa//treTPPf/eRLHzmaw3aXZiXNX3A9JJ0aqScXnb0uNjACiwHv49HMP2HTrS+F8ufp1W71WHih+XygUM8Zri5sJ6yitbB18dWH/A2sQG61gOMHJL/zthC1rPFRlmrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tde7oP9K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tde7oP9K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7901F00A3F;
	Tue,  1 Sep 2026 19:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788290917;
	bh=qx2OM2dq2tpZraQ5rEbfqAStB+MEWYXTW/VRzN1mdZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tde7oP9KimIbYhS9V/lEyY6L27SmxJTjyaL3WooMbxIZTiBNpHMCgEoSVcpEbLvmG
	 +ay/VWGKD08fVNFeqfF4Wta+X2VvBsb/tQkx7m6ODpzFlEu5A55UoT9oxXkzhr2xKe
	 FjR85b/BLqodckcy9Hucr+vi4xh8oTyzyjTUbXztr9CvyVu/7eJ9fEcnWgvudMNGAr
	 nsVAqkD9AjXhLyYRWIXV184xmodDey3ANdRBbUn3/oFDEOq5uxMc2vLIfDZfxf2Gdq
	 0tsYT4JprwyGeG/ikhOfNpT/KTpmz7toMs/3oCAYlZUEl3xLDHGv4bsNwmthk+pJZe
	 fVXx07kZHAsDQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/8] ipv6: start using dst_dev_rcu()
Date: Tue,  1 Sep 2026 15:28:27 -0400
Message-ID: <20260901192833.1439569-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901192833.1439569-1-sashal@kernel.org>
References: <2026083106-glider-shiftless-2e30@gregkh>
 <20260901192833.1439569-1-sashal@kernel.org>
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

[ backport note: this tree lacks the dst_dev()/skb_dst_dev() wrapper
  helpers and the ip6_mc_find_dev()/netdev_tracker refactors that the
  upstream commit builds on, so the hunks were adapted per-site:
   - icmp.c: icmpv6_xrlim_allow() gained the 'dev' local and the
     widened rcu_read_lock() region, converting the dst->dev
     IFF_LOOPBACK check to dst_dev_rcu().
   - output_core.c: ip6_dst_hoplimit() widened rcu_read_lock() and
     switched to dst_dev_rcu(), dropping the now-redundant inner
     rcu_read_unlock().
   - route.c: __ip6_rt_update_pmtu(), ip6_default_advmss() and
     rt6_do_redirect() switched to dst_dev_rcu()/dst_dev_net_rcu()
     in the sections already under rcu_read_lock().
   - ndisc.c: ndisc_send_skb() switched its dst->dev read to
     dst_dev_rcu() since the whole function is already inside
     rcu_read_lock(); the differing stats macro there predates this
     commit and was left untouched.
   - anycast.c (ipv6_sock_ac_join()) and mcast.c (ip6_mc_find_dev())
     hunks were dropped: this tree still has the pre-refactor,
     RTNL-only code (dev = rt->dst.dev, no netdev_tracker, no
     ip6_mc_find_dev() helper), so dst_dev_rcu() does not apply
     there. ]

[ sashal: Reduced backport -- upstream b775ecf1655ce touches 6 file(s), this
  backport carries 4. Not backported here:
  net/ipv6/anycast.c
  net/ipv6/mcast.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 870a9e42ecc6 ("tcp: clamp route advmss to TCP_MIN_MSS")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/icmp.c        |  8 +++++---
 net/ipv6/ndisc.c       |  6 ++++--
 net/ipv6/output_core.c | 10 ++++++----
 net/ipv6/route.c       |  7 +++----
 4 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index f8f7c1246f43b..983519cc8acef 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -196,6 +196,7 @@ static bool icmpv6_xrlim_allow(struct sock *sk, u8 type,
 			       struct flowi6 *fl6, bool apply_ratelimit)
 {
 	struct net *net = sock_net(sk);
+	struct net_device *dev;
 	struct dst_entry *dst;
 	bool res = false;
 
@@ -208,10 +209,12 @@ static bool icmpv6_xrlim_allow(struct sock *sk, u8 type,
 	 * this lookup should be more aggressive (not longer than timeout).
 	 */
 	dst = ip6_route_output(net, sk, fl6);
+	rcu_read_lock();
+	dev = dst_dev_rcu(dst);
 	if (dst->error) {
 		IP6_INC_STATS(net, ip6_dst_idev(dst),
 			      IPSTATS_MIB_OUTNOROUTES);
-	} else if (dst->dev && (dst->dev->flags&IFF_LOOPBACK)) {
+	} else if (dev && (dev->flags & IFF_LOOPBACK)) {
 		res = true;
 	} else {
 		struct rt6_info *rt = dst_rt6_info(dst);
@@ -222,11 +225,10 @@ static bool icmpv6_xrlim_allow(struct sock *sk, u8 type,
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
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 7d703a66c0a32..4c5b74868df38 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -473,6 +473,7 @@ void ndisc_send_skb(struct sk_buff *skb, const struct in6_addr *daddr,
 {
 	struct icmp6hdr *icmp6h = icmp6_hdr(skb);
 	struct dst_entry *dst = skb_dst(skb);
+	struct net_device *dev;
 	struct inet6_dev *idev;
 	struct net *net;
 	struct sock *sk;
@@ -507,11 +508,12 @@ void ndisc_send_skb(struct sk_buff *skb, const struct in6_addr *daddr,
 
 	ip6_nd_hdr(skb, saddr, daddr, inet6_sk(sk)->hop_limit, skb->len);
 
-	idev = __in6_dev_get(dst->dev);
+	dev = dst_dev_rcu(dst);
+	idev = __in6_dev_get(dev);
 	IP6_UPD_PO_STATS(net, idev, IPSTATS_MIB_OUT, skb->len);
 
 	err = NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT,
-		      net, sk, skb, NULL, dst->dev,
+		      net, sk, skb, NULL, dev,
 		      dst_output);
 	if (!err) {
 		ICMP6MSGOUT_INC_STATS(net, idev, type);
diff --git a/net/ipv6/output_core.c b/net/ipv6/output_core.c
index 2685c3f15e9d3..e745dc10b2a28 100644
--- a/net/ipv6/output_core.c
+++ b/net/ipv6/output_core.c
@@ -110,18 +110,20 @@ EXPORT_SYMBOL(ip6_find_1stfragopt);
 int ip6_dst_hoplimit(struct dst_entry *dst)
 {
 	int hoplimit = dst_metric_raw(dst, RTAX_HOPLIMIT);
+
+	rcu_read_lock();
 	if (hoplimit == 0) {
-		struct net_device *dev = dst->dev;
+		struct net_device *dev = dst_dev_rcu(dst);
 		struct inet6_dev *idev;
 
-		rcu_read_lock();
 		idev = __in6_dev_get(dev);
 		if (idev)
 			hoplimit = idev->cnf.hop_limit;
 		else
-			hoplimit = dev_net(dev)->ipv6.devconf_all->hop_limit;
-		rcu_read_unlock();
+			hoplimit = READ_ONCE(dev_net(dev)->ipv6.devconf_all->hop_limit);
 	}
+	rcu_read_unlock();
+
 	return hoplimit;
 }
 EXPORT_SYMBOL(ip6_dst_hoplimit);
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index e198a5eb24c64..d6706a49409bf 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2931,7 +2931,7 @@ static void __ip6_rt_update_pmtu(struct dst_entry *dst, const struct sock *sk,
 
 		if (res.f6i->nh) {
 			struct fib6_nh_match_arg arg = {
-				.dev = dst->dev,
+				.dev = dst_dev_rcu(dst),
 				.gw = &rt6->rt6i_gateway,
 			};
 
@@ -3226,7 +3226,6 @@ EXPORT_SYMBOL_GPL(ip6_sk_redirect);
 
 static unsigned int ip6_default_advmss(const struct dst_entry *dst)
 {
-	struct net_device *dev = dst->dev;
 	unsigned int mtu = dst_mtu(dst);
 	struct net *net;
 
@@ -3234,7 +3233,7 @@ static unsigned int ip6_default_advmss(const struct dst_entry *dst)
 
 	rcu_read_lock();
 
-	net = dev_net_rcu(dev);
+	net = dst_dev_net_rcu(dst);
 	if (mtu < net->ipv6.sysctl.ip6_rt_min_advmss)
 		mtu = net->ipv6.sysctl.ip6_rt_min_advmss;
 
@@ -4248,7 +4247,7 @@ static void rt6_do_redirect(struct dst_entry *dst, struct sock *sk, struct sk_bu
 
 	if (res.f6i->nh) {
 		struct fib6_nh_match_arg arg = {
-			.dev = dst->dev,
+			.dev = dst_dev_rcu(dst),
 			.gw = &rt->rt6i_gateway,
 		};
 
-- 
2.53.0

