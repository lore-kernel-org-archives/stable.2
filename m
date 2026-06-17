Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AA32F0661
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 14:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781707763; cv=none; b=p5sIkGubpgf+XPhekaNzbWQ/prnFk9dbLB5c5iTbPyVFEKPnhkMaAtL5NPNmqSWmMF92wu3r3TFH9jsdEVSpov7nOI1y5krG2kPN7/Rm2HxpNtqi1gR8VG2jBgAXuQ6N5uyp35lWH6EyMEDtbm/EbZsN8xhpbYovWUMJXF05ARs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781707763; c=relaxed/simple;
	bh=Y8kHXmLAMhxgayi0DOx7f9zMtYEZt2wMW5sMut12jHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YiIx/ek/vgdW75QSY1c1OBdqTbuZkhtiADcqUqupXgxo3x0Yn5atjkDtGfFkjLydgFS29K4wyilNDxkA37X22MV1BwZL1D0+ODGZRl0ckYHIcNxjIQQcFcg5m6PPpPtjujhPRw3Am7kpkj5PYDdzwsNo+yCUqI/de/F2dE56BdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFrsGHBh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFrsGHBh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981C41F00A3D;
	Wed, 17 Jun 2026 14:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781707762;
	bh=JsBvvxagRCRfK54ixJF4E4zzkwi4HsLudB3iVfreYJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jFrsGHBhOkz/EeJhLqXKLXMbrJWcCjODyHbDK1EkeiW/Iney9HkjNS3yPCd42WaL/
	 atPwNzyYiD8m1TINQ8WVHjBD9axDQhw2apSRsGYXpOrim0LImEzFXfx79GYnSfMflZ
	 qMv+zUZjntTHSt9dbhFpVu6JfC+LEfehsrIqlAsaNwRgqnY1Io3FF8/+0x+BFLaUzD
	 ZNZnhOYkOTabHeB3Kazw2S6sj6l5nkKc+vkeZDlYtqSgwy4AWga+z1OItnz72OY/5B
	 SC0/VfRjoOoEkpj7hgWV6AIYhx3+K9WLjHcfINN5robpAUHmzZStMwFEmOJ7G4Ts72
	 LwAPdicRz8HIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] phonet: Pass net and ifindex to phonet_address_notify().
Date: Wed, 17 Jun 2026 10:49:17 -0400
Message-ID: <20260617144918.39042-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617144918.39042-1-sashal@kernel.org>
References: <2026061547-discourse-faceless-4af5@gregkh>
 <20260617144918.39042-1-sashal@kernel.org>
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
index cde671d29d5dd3..2e7d850dc72668 100644
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
@@ -244,8 +247,9 @@ static int phonet_device_autoconf(struct net_device *dev)
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

