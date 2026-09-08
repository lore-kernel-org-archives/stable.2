Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EFD282F26
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 19:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788895724; cv=none; b=QXfUPQ+dTmTE1xEaRaDukpOysWZUnqbu6Vpxvrbn1TlG8XhaJZnOs4ZlXVANEikY2RsHBAh5YzgzNCxED6YeuuFYOda0vQUGekTyqnJVCGbkymXXR3dxgJyluoGX5GdbkG3JTQ824jHhPepodRzX6PKxvkRv0Q9C1CVs5poaNRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788895724; c=relaxed/simple;
	bh=q2ekKS0yTrIqcyKxn7zrvmnWYa0VbPEiMqNAoeJehZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B5UqrYkcRIKSa8k6CI0znsRWIHNnNfXNi4RUTUQXucSse/VDiUi58r+fS01TeXHteFDbG8DOhs767s9iQvbxLJ+g66RgNZAuq82Y+P3IqYDtWYvcEU0vjJW3q8/EZ4XPI/suave5diSWoyAa33YkS4OLWmPGJ6eyZrTSRKKpTaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foARK8Dk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foARK8Dk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2431F00ACA;
	Tue,  8 Sep 2026 19:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788895714;
	bh=gXkdZmaBF2xA3E7upL6htvr/B6IuiTxGGjxNOmvc51Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=foARK8Dkrm60QMX1vqj9lw/1IsUQD5BHtUL7cy5Jf51KAVnzEVgggrfiK7UHRJVyQ
	 PbJI6UcN/YIRf3LJfh0JwwxsPTkbSMrbGRKVKdRO/0SE0IE3zhAfQ+haDSgmDgFIlW
	 jqZ02LMAx3EuweMMhJa9Yc8JtCH2m1YjyEJ/NeDflUVrFm33wQOUGHtJM3w1CdLO8s
	 2QzbHUYfSVem1t9sqR0Gn7T7pgxkB82ITw8FM3tu4pqHK4Sul86NSKiZe3ubjV386T
	 t7NwTpNYC0gXDVNtKpJE5GniEcfocRcSShAzZrqelI+j0ZWugD+XILg7Q7noNDYywU
	 /sBOu3PRJPJKg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] ipv6: ip6_mc_input() and ip6_mr_input() cleanups
Date: Tue,  8 Sep 2026 15:28:30 -0400
Message-ID: <20260908192831.296595-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908192831.296595-1-sashal@kernel.org>
References: <2026090318-pusher-lucid-87ba@gregkh>
 <20260908192831.296595-1-sashal@kernel.org>
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
 net/ipv6/ip6_input.c | 25 +++++++++----------------
 net/ipv6/ip6mr.c     |  9 ++++-----
 2 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index 54146e280c2b7..e775a5a766692 100644
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
 
-	__IP6_UPD_PO_STATS(dev_net(skb_dst(skb)->dev),
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
@@ -576,15 +570,14 @@ int ip6_mc_input(struct sk_buff *skb)
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
index 18451dfeae682..cd2116862a4b4 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -2225,21 +2225,20 @@ static void ip6_mr_forward(struct net *net, struct mr_table *mrt,
 
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

