Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B53283CB5
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791209228; cv=none; b=DUtieAF6NkAUmgBgITsBLvpK+GHRkm3GySJ8Axbg2SElri25WKKC8WLnY7BJ2coZv0t7NR4bJx1unn1FoP5UeQaNZ7ZXcEjLpY+GGgKWZZN1Cg5osb72yobd5MyKuvDyklJREcitMArp4k/n/EwBI6EPRfwenECz7CdBKyPkmXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791209228; c=relaxed/simple;
	bh=cSrLbPa8yMhFswiIu8nZbh0Z/fVqSNFTpXvB9EPfxSk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oiOVdwBoDHeOhR51CIOzBZe3BBJFJpNs3O6q//CpYQdxNuy+6FpaJ+g0sek1C8nNAQlWyG8Eb5tDpB3l72fswA6sYULEH5GCdfuXrmX0zEOLBKCYoITTU6CYoaytbivhpmzEwLxEK4GYD3cuHGMMFl5cboHZWYskB4tHOOIsmhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=25q43wGU; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="25q43wGU"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 5F36F1A115C;
	Mon,  5 Oct 2026 14:07:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2CB93601A5;
	Mon,  5 Oct 2026 14:07:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5EE0810330663;
	Mon,  5 Oct 2026 16:06:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791209218; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=VMurarVFO5fcWLHGJv2DQHT+9wMqX3earc/IsfyESaI=;
	b=25q43wGUA0S84teMMDYFx5QFTGwhGA0XokY3Z239NMvwn1qMtEtNjPPIC/ztzymxb+2rM4
	tqsHdaqB+LiVzS8RtWxQ0+DWyBg2Zo9Dv/u3+pIJqXEA3JMyCF5+j+iC4bXd7VwbyHW+Pi
	X3mYo8v96dmDF5brBK/9NJDsvtwsJvpA9wKCkv7kIM7jzV67IscHq4ZGpQb69F5pvESXbm
	VLuawW2V64QoYgF38wNhr94caJ/b9Dlc8Ln5wYXGMbW6Shsfrd/H+rGs2Vx1Ad/NQBQdIo
	QhYBZY9lT9j7Ge+WNRJrlQJigjEvAkcD0I4UaownNmeCN9nDnCmJUMDo3hTgfg==
From: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Date: Mon, 05 Oct 2026 16:06:51 +0200
Subject: [PATCH] ipv6: use RCU in ip6_output()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-cve-2026-40158-v1-1-98505c5ee970@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBBA0avIrE3SNqq4ilhQU8YCaRGJuLti+
 Rb/XxDIMwWokgs8HRx4mSNkmoAd23kg5D4alFC5FEKjPQhfYCakLlCVRqvcmUI6AzFaPTk+v2H
 d/A57N5Hd3gvc9wMe6+lecgAAAA==
X-Change-ID: 20261005-cve-2026-40158-297526f781f7
To: stable@vger.kernel.org
Cc: Benjamin Robin <benjamin.robin@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Eric Dumazet <edumazet@google.com>, David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Sasha Levin <sashal@kernel.org>, 
 "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791209217; l=4145;
 i=miguel.gazquez@bootlin.com; s=20250708; h=from:subject:message-id;
 bh=k8FdyW4qDRTQyv9Bbs9SJM8X4LSe5spQEgSCFoYCab0=;
 b=fl0DklwxnbWfmKNprXnRgXhFWJhYgrhjLh7RcKnXPcZTTCRWB86ezf5mlG3kwSOj3tvVWkqyO
 88iNCMtUIUBAkT51tMdDmz1bwL2SVMvEL6TNHd/AeB/4u7FJIJaFqs3
X-Developer-Key: i=miguel.gazquez@bootlin.com; a=ed25519;
 pk=k/2KI9jkmayaF0ghZ8QYUH9Wm/kFHDhl8QoZ0RHbr4w=
X-Last-TLS-Session-Version: TLSv1.3

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 11709573cc4e48dc34c80fc7ab9ce5b159e29695 ]

Use RCU in ip6_output() in order to use dst_dev_rcu() to prevent
possible UAF.

We can remove rcu_read_lock()/rcu_read_unlock() pairs
from ip6_finish_output2().

Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://patch.msgid.link/20250828195823.3958522-5-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>
---
 net/ipv6/ip6_output.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index e53dbf14873a..50ed10b448c4 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -60,7 +60,7 @@
 static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	struct dst_entry *dst = skb_dst(skb);
-	struct net_device *dev = dst_dev(dst);
+	struct net_device *dev = dst_dev_rcu(dst);
 	struct inet6_dev *idev = ip6_dst_idev(dst);
 	unsigned int hh_len = LL_RESERVED_SPACE(dev);
 	const struct in6_addr *daddr, *nexthop;
@@ -70,15 +70,12 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
 
 	/* Be paranoid, rather than too clever. */
 	if (unlikely(hh_len > skb_headroom(skb)) && dev->header_ops) {
-		/* Make sure idev stays alive */
-		rcu_read_lock();
+		/* idev stays alive because we hold rcu_read_lock(). */
 		skb = skb_expand_head(skb, hh_len);
 		if (!skb) {
 			IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTDISCARDS);
-			rcu_read_unlock();
 			return -ENOMEM;
 		}
-		rcu_read_unlock();
 	}
 
 	hdr = ipv6_hdr(skb);
@@ -125,7 +122,6 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
 
 	IP6_UPD_PO_STATS(net, idev, IPSTATS_MIB_OUT, skb->len);
 
-	rcu_read_lock();
 	nexthop = rt6_nexthop(dst_rt6_info(dst), daddr);
 	neigh = __ipv6_neigh_lookup_noref(dev, nexthop);
 
@@ -133,7 +129,6 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
 		if (unlikely(!neigh))
 			neigh = __neigh_create(&nd_tbl, nexthop, dev, false);
 		if (IS_ERR(neigh)) {
-			rcu_read_unlock();
 			IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTNOROUTES);
 			kfree_skb_reason(skb, SKB_DROP_REASON_NEIGH_CREATEFAIL);
 			return -EINVAL;
@@ -141,7 +136,6 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
 	}
 	sock_confirm_neigh(skb, neigh);
 	ret = neigh_output(neigh, skb, false);
-	rcu_read_unlock();
 	return ret;
 }
 
@@ -235,22 +229,29 @@ static int ip6_finish_output(struct net *net, struct sock *sk, struct sk_buff *s
 int ip6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	struct dst_entry *dst = skb_dst(skb);
-	struct net_device *dev = dst_dev(dst), *indev = skb->dev;
-	struct inet6_dev *idev = ip6_dst_idev(dst);
+	struct net_device *dev, *indev = skb->dev;
+	struct inet6_dev *idev;
+	int ret;
 
 	skb->protocol = htons(ETH_P_IPV6);
+	rcu_read_lock();
+	dev = dst_dev_rcu(dst);
+	idev = ip6_dst_idev(dst);
 	skb->dev = dev;
 
 	if (unlikely(!idev || READ_ONCE(idev->cnf.disable_ipv6))) {
 		IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTDISCARDS);
+		rcu_read_unlock();
 		kfree_skb_reason(skb, SKB_DROP_REASON_IPV6DISABLED);
 		return 0;
 	}
 
-	return NF_HOOK_COND(NFPROTO_IPV6, NF_INET_POST_ROUTING,
-			    net, sk, skb, indev, dev,
-			    ip6_finish_output,
-			    !(IP6CB(skb)->flags & IP6SKB_REROUTED));
+	ret = NF_HOOK_COND(NFPROTO_IPV6, NF_INET_POST_ROUTING,
+			   net, sk, skb, indev, dev,
+			   ip6_finish_output,
+			   !(IP6CB(skb)->flags & IP6SKB_REROUTED));
+	rcu_read_unlock();
+	return ret;
 }
 EXPORT_SYMBOL(ip6_output);
 

---
base-commit: 7aba70ab2e8d8ab3cd45abcaa15e1119a00dc42a
change-id: 20261005-cve-2026-40158-297526f781f7

Best regards,
--  
Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>

