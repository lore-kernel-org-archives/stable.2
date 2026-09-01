Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA064A2065
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 19:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788290918; cv=none; b=ZOMgoSJr3r0XVKxYbtyWywXRvMam5h59vwkizY8Jj7uAKVsMx2Pk6D2M51g5TNo5bBv+xpRsYtW4HT3tV71OEWTfPYyieD1XI0UljzOxebuRbA5iJBZ6BPG0qCWxv/cyZ36h0XAG+Eo4pJ9lNQJ0FCck+KqrO65RBvI26Jtttrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788290918; c=relaxed/simple;
	bh=MVGCb9U5nhur13OBh7qHdxIuH69pYoGQvRajQfOIDOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rHGybhEB+2HXpsQq8m7AnXsWnlvUhW+lEtwzMa2EDTca1eem+GSSXKiXCTxgyaLmTK3xTqQ0Ky8ZklntuW2MbTFdOREowb2pF4Ypx09jegr0ZgNJAD8UMlG3oz6fUZTDvY5PFH9pCQl4LANsr5hvEdIenof79mg3kvBe2Wa10lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxUwaK50; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxUwaK50"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDAA21F000E9;
	Tue,  1 Sep 2026 19:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788290916;
	bh=WMJswiLOITy4N7+RRMSbLmlK9ruzBl+6bljpLfNu9Hc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AxUwaK50a4yPmlwz3izUykb8TT1OBNO4+UujLCn6F3pvPRpXlQfqkM/ZV74NPeHoT
	 B3NQ76bBOXrpQrn+mBCDlPtLe8s7b+Wkw4kyLHfLJcCHEAFxsSoqI13WTKQGvIxJ9V
	 8ONYtxhK3xli3aGwSuAK9vmQz/8ucMItmUirr1m8isYz/ig9EXQZbfK0zkXIkneCL3
	 ESS+n5fhcPwgYlA3h6R2fnR9a4U55g6IKq2ggPpcCWeTMjCA57llZpHcJsRfu12tZA
	 X3ja4JY/vOf5vKEBslmXBxqu9Pe6n/GKsar55tT+3k8fh4hWc+u583rJH7Ymtj6XJ/
	 SelEVH+rB3C2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/8] net: dst: introduce dst->dev_rcu
Date: Tue,  1 Sep 2026 15:28:26 -0400
Message-ID: <20260901192833.1439569-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026083106-glider-shiftless-2e30@gregkh>
References: <2026083106-glider-shiftless-2e30@gregkh>
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

[ backport note: this tree predates upstream's dst_dev()/skb_dst_dev()/
  skb_dst_dev_net() helpers (added by commits not present here), so
  the skb_dst_dev_net()/skb_dst_dev_net_rcu() hunk was dropped and the
  two ipv4/route.c call sites were adapted from
  'dev_net_rcu(dst_dev(dst))' to 'dev_net_rcu(dst->dev)' ->
  'dst_dev_net_rcu(dst)' directly, since this tree calls dst->dev
  straight rather than through a dst_dev() wrapper. net/core/dst.c
  was similarly adapted to keep this tree's existing ifdown()/input/
  output assignments and only convert the dst->dev write to
  rcu_assign_pointer(dst->dev_rcu, ...). ]

Stable-dep-of: 870a9e42ecc6 ("tcp: clamp route advmss to TCP_MIN_MSS")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/dst.h | 14 ++++++++++----
 net/core/dst.c    |  2 +-
 net/ipv4/route.c  |  4 ++--
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/net/dst.h b/include/net/dst.h
index 20a76e532afbb..67ef21cff3f48 100644
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
@@ -557,9 +560,12 @@ static inline void skb_dst_update_pmtu_no_confirm(struct sk_buff *skb, u32 mtu)
 
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
-- 
2.53.0

