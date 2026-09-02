Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F7E21FF23
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 00:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788309212; cv=none; b=b8DHqQyXjzoSjzRHDPRVA2ZstqGEZ3MxXff0R3+DNcFWs9KinQ+01XP2RV58NFSMRHpJja+Rxh8Z6ekDUBvg4F5eR4B2ngTVDPh6Ks0Rt4G84pKXALPU6fqo5bL9v9TmRhqs55/oitgKp5O+lomwL+mXihsGfDq/6Y6U4VSUuZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788309212; c=relaxed/simple;
	bh=47nrl0yTHtSSdhWUudLNPLxQ0ZnI7kfliMBmwRnoGDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNaXn/s+kCYNlSPfRjkw3/nI93ZeoJFv7jAQgBTW4ii3HLKcjavlXFhS+MqOusfXX0MlvA8Dsvk3ZvX8AIRmghEvOU8d1luvpw3SNAWvWwp6esGBSEPeIDDP65r0EBpora0UFvEu4pmKC8ZqoOIIiPNILqwokSZqveA+8VDp8jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XS9glPAI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XS9glPAI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D242E1F00A3A;
	Wed,  2 Sep 2026 00:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788309211;
	bh=EHc6u9HMTmiQHc1Zw1gU0PT4oiEDv17eGQCn4PFtyuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XS9glPAI+OoKFhy0FZaxTiUDrDT8voB13sdLF8r+3HklFzMlmubhsqKyOZJ27hXJM
	 ZqqKLf0tOHwKBdZOcS21uxrcVMNs2y1v1+derWpcH6BKb6mdOG1CazMd+hdh1m0WWu
	 wx6yyrSoPb85WTSH0Qu/CISvhdYRkDQBKeLybk46JubRthZdGQ1ddP5goo4tzQ6wmX
	 dqXdbOUV489b28QYLgAOAWM7hgDY6T9ktlUdpOmJL85psM0ujOshgSsriGjPHbAno1
	 J3kllqn3ygXa05JhsaHl/sQLYs3HwMnZNSrTBHaSSjDEQaAlJ+lxH3PSKk+itn+asz
	 tgDQRdMqXTlwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] net: dst: introduce dst->dev_rcu
Date: Tue,  1 Sep 2026 20:33:27 -0400
Message-ID: <20260902003328.1792382-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902003328.1792382-1-sashal@kernel.org>
References: <2026083119-uncoated-animal-60e3@gregkh>
 <20260902003328.1792382-1-sashal@kernel.org>
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
 include/net/dst.h | 11 ++++++-----
 include/net/ip.h  | 15 +++++++++++----
 net/core/dst.c    |  2 +-
 net/ipv4/route.c  |  2 +-
 4 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/include/net/dst.h b/include/net/dst.h
index 9de6b49cfd3dd..0b30871014742 100644
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
@@ -556,9 +559,7 @@ static inline void skb_dst_update_pmtu_no_confirm(struct sk_buff *skb, u32 mtu)
 
 static inline struct net_device *dst_dev_rcu(const struct dst_entry *dst)
 {
-	/* In the future, use rcu_dereference(dst->dev) */
-	WARN_ON_ONCE(!rcu_read_lock_held());
-	return READ_ONCE(dst->dev);
+	return rcu_dereference(dst->dev_rcu);
 }
 
 #define dst_dev_net_rcu(dst) dev_net_rcu(dst_dev_rcu(dst))
@@ -585,7 +586,7 @@ static inline struct net *skb_dst_dev_net(const struct sk_buff *skb)
 
 static inline struct net *skb_dst_dev_net_rcu(const struct sk_buff *skb)
 {
-	return dev_net_rcu(skb_dst_dev(skb));
+	return dev_net_rcu(skb_dst_dev_rcu(skb));
 }
 
 struct dst_entry *dst_blackhole_check(struct dst_entry *dst, u32 cookie);
diff --git a/include/net/ip.h b/include/net/ip.h
index e25a2d5519c5e..8c9f7b40d6fef 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -441,8 +441,13 @@ static inline unsigned int ip_dst_mtu_maybe_forward(const struct dst_entry *dst,
 						    bool forwarding)
 {
 	const struct rtable *rt = container_of(dst, struct rtable, dst);
-	struct net *net = dev_net(dst_dev(dst));
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
@@ -457,7 +462,7 @@ static inline unsigned int ip_dst_mtu_maybe_forward(const struct dst_entry *dst,
 	if (mtu)
 		goto out;
 
-	mtu = READ_ONCE(dst_dev(dst)->mtu);
+	mtu = READ_ONCE(dev->mtu);
 
 	if (unlikely(ip_mtu_locked(dst))) {
 		if (rt->rt_uses_gateway && mtu > 576)
@@ -466,8 +471,10 @@ static inline unsigned int ip_dst_mtu_maybe_forward(const struct dst_entry *dst,
 
 out:
 	mtu = min_t(unsigned int, mtu, IP_MAX_MTU);
+	res = mtu - lwtunnel_headroom(dst->lwtstate, mtu);
+	rcu_read_unlock();
 
-	return mtu - lwtunnel_headroom(dst->lwtstate, mtu);
+	return res;
 }
 
 static inline unsigned int ip_skb_dst_mtu(struct sock *sk,
diff --git a/net/core/dst.c b/net/core/dst.c
index 8707b7ffe4210..4376f04ac5145 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -151,7 +151,7 @@ void dst_dev_put(struct dst_entry *dst)
 		dst->ops->ifdown(dst, dev, true);
 	WRITE_ONCE(dst->input, dst_discard);
 	WRITE_ONCE(dst->output, dst_discard_out);
-	WRITE_ONCE(dst->dev, blackhole_netdev);
+	rcu_assign_pointer(dst->dev_rcu, blackhole_netdev);
 	dev_hold(dst->dev);
 	dev_put(dev);
 }
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index f61bc949f601a..65b539c94125f 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1074,7 +1074,7 @@ static void __ip_rt_update_pmtu(struct rtable *rt, struct flowi4 *fl4, u32 mtu)
 		return;
 
 	rcu_read_lock();
-	net = dev_net_rcu(dst_dev(dst));
+	net = dst_dev_net_rcu(dst);
 	if (mtu < net->ipv4.ip_rt_min_pmtu) {
 		lock = true;
 		mtu = min(old_mtu, net->ipv4.ip_rt_min_pmtu);
-- 
2.53.0

