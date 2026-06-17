Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D59175A8F
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 14:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708143; cv=none; b=VAQP8Rk4OzIyiiA0q83rKSJpNcWdY5PSA9rqNBot0fI+uWJhMI8nsuZ4/nh5F/fF8Y+reyNznZujEJrXV2fcayDmGZ/GR7LDantG2LOXR8DqC2wiZjpPK44ZvJJY1GQe2MXBE0WLQS2U/+uB/tODBDOP3E+IoAjk2dWVryU3WBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708143; c=relaxed/simple;
	bh=PnmxKTlpJQb2KxjuiY7dSnzOYIHqdAENUtAM+Ot8mM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZYeJshEWRVVMaZ8kCf0euNqrN6Hd/z10+E91UoiCsrZFEWc3DCDLtEo0+W+I6NUcVM3HQmUGWq3ICFVP/dzoU1Oi5XX1ermir8iH2+8FqiDBAMDen9EO+O50NatoRmCqrOegUoJ+X2yJcYec/6EfRSRx/aaRTOzwhGmtUT7agFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjpGlxYB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjpGlxYB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6196A1F00A3E;
	Wed, 17 Jun 2026 14:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781708142;
	bh=z/ZvHpn1bw0kZeo5Q+iEk7YnaiwCb/sPS3V7QUTIIbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EjpGlxYBdDFORT+vRGzItSYhUp0ecMJdeG6GID7Mh+iomKq0ARZ6u+FCsDsNIUqVi
	 WMkgkEZxrwahAtTb12YqK/RRmfD8AANb4bh3kO2NsozSvbuH3QyzE3CLo2x6eyioxM
	 kEN5UClc6LAYSOQhU7kAZUYnyvJKVbrDmMB66aiLWZBIlgmcnd9Re8VqldcJBVtNnc
	 RHAulxnbLjJKsihtMNbv+HtIc3uuBX5rMJ/PPPPnbZ80d4ieUjv8YhDAon3AW3aNiN
	 fKNV6gShPZR8aY5tBVmt23amKl0Sv2l26HA83vygS09N/0sZrcaMZEcTZLohYfi/K6
	 0CszU98wJtgjw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] phonet: Pass net and ifindex to phonet_address_notify().
Date: Wed, 17 Jun 2026 10:55:37 -0400
Message-ID: <20260617145538.157435-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617145538.157435-1-sashal@kernel.org>
References: <2026061549-equipment-myspace-2ba7@gregkh>
 <20260617145538.157435-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 68ed5c38b512b734caf3da1f87db4a99fcfe3002 ]

Currently, phonet_address_notify() fetches netns and ifindex from dev.

Once addr_doit() is converted to RCU, phonet_address_notify() will be
called outside of RCU due to GFP_KERNEL, and dev will be unavailable
there.

Let's pass net and ifindex to phonet_address_notify().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: 71de0177b28d ("net: phonet: free phonet_device after RCU grace period")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/phonet/pn_dev.h |  2 +-
 net/phonet/pn_dev.c         | 10 +++++++---
 net/phonet/pn_netlink.c     | 12 ++++++------
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/include/net/phonet/pn_dev.h b/include/net/phonet/pn_dev.h
index 05b49d4d2b1116..216677e56b41ee 100644
--- a/include/net/phonet/pn_dev.h
+++ b/include/net/phonet/pn_dev.h
@@ -33,7 +33,7 @@ int phonet_address_add(struct net_device *dev, u8 addr);
 int phonet_address_del(struct net_device *dev, u8 addr);
 u8 phonet_address_get(struct net_device *dev, u8 addr);
 int phonet_address_lookup(struct net *net, u8 addr);
-void phonet_address_notify(int event, struct net_device *dev, u8 addr);
+void phonet_address_notify(struct net *net, int event, u32 ifindex, u8 addr);
 
 int phonet_route_add(struct net_device *dev, u8 daddr);
 int phonet_route_del(struct net_device *dev, u8 daddr);
diff --git a/net/phonet/pn_dev.c b/net/phonet/pn_dev.c
index ac0fae06cc153f..5a8f3a7c2a6c8a 100644
--- a/net/phonet/pn_dev.c
+++ b/net/phonet/pn_dev.c
@@ -98,10 +98,13 @@ static void phonet_device_destroy(struct net_device *dev)
 	mutex_unlock(&pndevs->lock);
 
 	if (pnd) {
+		struct net *net = dev_net(dev);
+		u32 ifindex = dev->ifindex;
 		u8 addr;
 
 		for_each_set_bit(addr, pnd->addrs, 64)
-			phonet_address_notify(RTM_DELADDR, dev, addr);
+			phonet_address_notify(net, RTM_DELADDR, ifindex, addr);
+
 		kfree(pnd);
 	}
 }
@@ -245,8 +248,9 @@ static int phonet_device_autoconf(struct net_device *dev)
 	ret = phonet_address_add(dev, req.ifr_phonet_autoconf.device);
 	if (ret)
 		return ret;
-	phonet_address_notify(RTM_NEWADDR, dev,
-				req.ifr_phonet_autoconf.device);
+
+	phonet_address_notify(dev_net(dev), RTM_NEWADDR, dev->ifindex,
+			      req.ifr_phonet_autoconf.device);
 	return 0;
 }
 
diff --git a/net/phonet/pn_netlink.c b/net/phonet/pn_netlink.c
index 6b50e4d526682f..c4c9fda4c3de14 100644
--- a/net/phonet/pn_netlink.c
+++ b/net/phonet/pn_netlink.c
@@ -22,7 +22,7 @@
 static int fill_addr(struct sk_buff *skb, u32 ifindex, u8 addr,
 		     u32 portid, u32 seq, int event);
 
-void phonet_address_notify(int event, struct net_device *dev, u8 addr)
+void phonet_address_notify(struct net *net, int event, u32 ifindex, u8 addr)
 {
 	struct sk_buff *skb;
 	int err = -ENOBUFS;
@@ -32,17 +32,17 @@ void phonet_address_notify(int event, struct net_device *dev, u8 addr)
 	if (skb == NULL)
 		goto errout;
 
-	err = fill_addr(skb, dev->ifindex, addr, 0, 0, event);
+	err = fill_addr(skb, ifindex, addr, 0, 0, event);
 	if (err < 0) {
 		WARN_ON(err == -EMSGSIZE);
 		kfree_skb(skb);
 		goto errout;
 	}
-	rtnl_notify(skb, dev_net(dev), 0,
-		    RTNLGRP_PHONET_IFADDR, NULL, GFP_KERNEL);
+
+	rtnl_notify(skb, net, 0, RTNLGRP_PHONET_IFADDR, NULL, GFP_KERNEL);
 	return;
 errout:
-	rtnl_set_sk_err(dev_net(dev), RTNLGRP_PHONET_IFADDR, err);
+	rtnl_set_sk_err(net, RTNLGRP_PHONET_IFADDR, err);
 }
 
 static const struct nla_policy ifa_phonet_policy[IFA_MAX+1] = {
@@ -89,7 +89,7 @@ static int addr_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 	else
 		err = phonet_address_del(dev, pnaddr);
 	if (!err)
-		phonet_address_notify(nlh->nlmsg_type, dev, pnaddr);
+		phonet_address_notify(net, nlh->nlmsg_type, ifm->ifa_index, pnaddr);
 	return err;
 }
 
-- 
2.53.0

