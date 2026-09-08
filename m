Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513025921E7
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 17:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788888334; cv=none; b=QAltMgSs13QD6a1c9a/E38YA+VoEHq3lW0XI3N6gb05Mx4PW5+gNKBf0bVW887IIBHPgUsj6BTCaUSL4Ttd89MuEDiKWjDJjRTz6HXW6i8+HS0DQl1XN1fccUt3gokQMjLWAO2s9MrewT0imIUmGtI/bQvhCQ6zPhMcgSEmJBpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788888334; c=relaxed/simple;
	bh=n9xt6Mf9kNPO1R+xunxDhmRSlOiSphyc9+o+aPAIRr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VWOyGmlk1mTaF58Vo+DnrWbXdO9Zzb6uuhl6S93sk10lrksp8vbGSbWCOgVxk3Fvctd7MgKxukOWhiBB6o9HKoaFU2AM15g6yU5IcIYmbx+xjfBtrJXmV0jdhAc7e24eCx6VLJdzBmLSVarU14i5G2htAPCyw71icO133PE50Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3wlRN8w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3wlRN8w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD531F00A3D;
	Tue,  8 Sep 2026 17:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788888333;
	bh=xpxBarfQ1mzj57jBEvnOWZcINFPqV9aK7dGVIoqHhkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L3wlRN8wQ/5ToIYqsOe5a+TcKw514RCOsNHr7PHyWphczhGkWbBy+Ai3DonumiSM7
	 A1bAhcDalqQSLzcKt/ME+Wuz1nkF5WfhsCrYbeNmRKXWAfzcWcge6NTWcEmR6uw0xT
	 QoF5Poj66kUVo4zZmB4B3Qfo+xqRnBDlpsMsUV97XDHO3nhw88NNGyFtUE4jKENYCW
	 cAw9P790+PuIZFoB6NkdN64rcLqgH5nbXFx8yE1bLGa0UY1R9ZXa02G5TAcjX5UT9u
	 SiHNe+swQwq84cmVPuA1hJtYbon+W6iWayOIDu8u1Nv2qIAO9ai/nhM8WErjNc5p06
	 M3ZRBGMezo7WA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] ipv6: ip6_mc_input() and ip6_mr_input() cleanups
Date: Tue,  8 Sep 2026 13:25:28 -0400
Message-ID: <20260908172529.78857-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908172529.78857-1-sashal@kernel.org>
References: <2026090318-afterglow-hash-e60c@gregkh>
 <20260908172529.78857-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 46a94e44b9ec4d8d20108a1748c410d71a8dc759 ]

Both functions are always called under RCU.

We remove the extra rcu_read_lock()/rcu_read_unlock().

We use skb_dst_dev_net_rcu() instead of skb_dst_dev_net().

We use dev_net_rcu() instead of dev_net().

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20250630121934.3399505-11-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: e36ce6e78fe3 ("ip: orphan prefetched skbs before multicast forwarding")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/ip6_input.c | 29 +++++++++++------------------
 net/ipv6/ip6mr.c     |  9 ++++-----
 2 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index a754aead9d56f..bc535e79bdc8d 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -497,38 +497,32 @@ EXPORT_SYMBOL_GPL(ip6_input);
 
 int ip6_mc_input(struct sk_buff *skb)
 {
+	struct net_device *dev = skb->dev;
 	int sdif = inet6_sdif(skb);
 	const struct ipv6hdr *hdr;
-	struct net_device *dev;
 	bool deliver;
 
-	__IP6_UPD_PO_STATS(skb_dst_dev_net(skb),
-			 __in6_dev_get_safely(skb->dev), IPSTATS_MIB_INMCAST,
-			 skb->len);
+	__IP6_UPD_PO_STATS(skb_dst_dev_net_rcu(skb),
+			   __in6_dev_get_safely(dev), IPSTATS_MIB_INMCAST,
+			   skb->len);
 
 	/* skb->dev passed may be master dev for vrfs. */
 	if (sdif) {
-		rcu_read_lock();
-		dev = dev_get_by_index_rcu(dev_net(skb->dev), sdif);
+		dev = dev_get_by_index_rcu(dev_net_rcu(dev), sdif);
 		if (!dev) {
-			rcu_read_unlock();
 			kfree_skb(skb);
 			return -ENODEV;
 		}
-	} else {
-		dev = skb->dev;
 	}
 
 	hdr = ipv6_hdr(skb);
 	deliver = ipv6_chk_mcast_addr(dev, &hdr->daddr, NULL);
-	if (sdif)
-		rcu_read_unlock();
 
 #ifdef CONFIG_IPV6_MROUTE
 	/*
 	 *      IPv6 multicast router mode is now supported ;)
 	 */
-	if (atomic_read(&dev_net(skb->dev)->ipv6.devconf_all->mc_forwarding) &&
+	if (atomic_read(&dev_net_rcu(skb->dev)->ipv6.devconf_all->mc_forwarding) &&
 	    !(ipv6_addr_type(&hdr->daddr) &
 	      (IPV6_ADDR_LOOPBACK|IPV6_ADDR_LINKLOCAL)) &&
 	    likely(!(IP6CB(skb)->flags & IP6SKB_FORWARDED))) {
@@ -569,22 +563,21 @@ int ip6_mc_input(struct sk_buff *skb)
 			/* unknown RA - process it normally */
 		}
 
-		if (deliver)
+		if (deliver) {
 			skb2 = skb_clone(skb, GFP_ATOMIC);
-		else {
+		} else {
 			skb2 = skb;
 			skb = NULL;
 		}
 
-		if (skb2) {
+		if (skb2)
 			ip6_mr_input(skb2);
-		}
 	}
 out:
 #endif
-	if (likely(deliver))
+	if (likely(deliver)) {
 		ip6_input(skb);
-	else {
+	} else {
 		/* discard */
 		kfree_skb(skb);
 	}
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 68bc518500f94..1f9653be58d4b 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -2222,21 +2222,20 @@ static void ip6_mr_forward(struct net *net, struct mr_table *mrt,
 
 int ip6_mr_input(struct sk_buff *skb)
 {
+	struct net_device *dev = skb->dev;
+	struct net *net = dev_net_rcu(dev);
 	struct mfc6_cache *cache;
-	struct net *net = dev_net(skb->dev);
 	struct mr_table *mrt;
 	struct flowi6 fl6 = {
-		.flowi6_iif	= skb->dev->ifindex,
+		.flowi6_iif	= dev->ifindex,
 		.flowi6_mark	= skb->mark,
 	};
 	int err;
-	struct net_device *dev;
 
 	/* skb->dev passed in is the master dev for vrfs.
 	 * Get the proper interface that does have a vif associated with it.
 	 */
-	dev = skb->dev;
-	if (netif_is_l3_master(skb->dev)) {
+	if (netif_is_l3_master(dev)) {
 		dev = dev_get_by_index_rcu(net, IPCB(skb)->iif);
 		if (!dev) {
 			kfree_skb(skb);
-- 
2.53.0

