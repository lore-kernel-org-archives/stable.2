Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBF43F7A97
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 14:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781706514; cv=none; b=sSd4rYSKP+e2rEGf8mHbxEo4FfSeICVFcpA5x7Kz0g31VxdQ94GuvBooR8XDVIYnN+/Wx+8bu/qqB1Iz0Gta8NLIGkLBS9eHgxefcbFXTV/iZv7Ac3lnyTC9ywauHxTS7V5ttBX/yuS+QnM1UG5Rg26V5WbXdum2NIlqDPCoYc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781706514; c=relaxed/simple;
	bh=u6za2pQomzjrHXKVrEnhsnuXJe/YhTUfdNJ6xViSwJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sh7v5NKHuvBBcRaVMneyudGtuYE9xtVKQgA6H0NIZC81FBO0EaopFPD1X9KLMepHAJ6ZCxw/cLigXhs3JwHoEGWyAe37/wXBCk1f5AtYLgRKNRyw0xZOXlA54XXISJ9hZVuD09MqonT3WeChsNPMrTWS1LaMkC4AHUwDXSHIj7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oh/5DZcN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oh/5DZcN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8F31F000E9;
	Wed, 17 Jun 2026 14:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781706513;
	bh=n85baoOzuqnd+rVQs1BoTnxrQgBaBFs5Wg1Dp2HgvfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oh/5DZcN4TUH5kvhCOIQj9ipSM7dp6pdG9+O1ilBGBMdMlDPO/NqkW7RG2dUHstQh
	 zaUwJZZ5tvTR1rN4QIHT/d5pUoy8xqx7WnW2KyG68iPtJOAtlZFG16TU8hUCX1WlNk
	 g0Vhh5geRhoLsELgOgWxhFTzSxIe8kRhrysfT56HWjjkmzvqFzxY/bD25+fbF0ZABT
	 JFj9FseCuFbZG0852PLXiE6O1sMMs/f3oq2OgWDlFYOQ3bobR9FrHYXSdITToEpQ0M
	 cuM8/MVRRtWhQ57am7iQLFMOMPe8TnW/86utHwhura3MnEo/L02GH1bLGR8agPVhss
	 mCYE8ZbyX/yPg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] phonet: Pass ifindex to fill_addr().
Date: Wed, 17 Jun 2026 10:28:28 -0400
Message-ID: <20260617142830.3939916-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061541-expanse-aloft-6b99@gregkh>
References: <2026061541-expanse-aloft-6b99@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 08a9572be36819b5d9011604edfa5db6c5062a7a ]

We will convert addr_doit() and getaddr_dumpit() to RCU, both
of which call fill_addr().

The former will call phonet_address_notify() outside of RCU
due to GFP_KERNEL, so dev will not be available in fill_addr().

Let's pass ifindex directly to fill_addr().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: 71de0177b28d ("net: phonet: free phonet_device after RCU grace period")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/phonet/pn_netlink.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/phonet/pn_netlink.c b/net/phonet/pn_netlink.c
index 894e5c72d6bfff..3205d24574779f 100644
--- a/net/phonet/pn_netlink.c
+++ b/net/phonet/pn_netlink.c
@@ -19,7 +19,7 @@
 
 /* Device address handling */
 
-static int fill_addr(struct sk_buff *skb, struct net_device *dev, u8 addr,
+static int fill_addr(struct sk_buff *skb, u32 ifindex, u8 addr,
 		     u32 portid, u32 seq, int event);
 
 void phonet_address_notify(int event, struct net_device *dev, u8 addr)
@@ -31,7 +31,8 @@ void phonet_address_notify(int event, struct net_device *dev, u8 addr)
 			nla_total_size(1), GFP_KERNEL);
 	if (skb == NULL)
 		goto errout;
-	err = fill_addr(skb, dev, addr, 0, 0, event);
+
+	err = fill_addr(skb, dev->ifindex, addr, 0, 0, event);
 	if (err < 0) {
 		WARN_ON(err == -EMSGSIZE);
 		kfree_skb(skb);
@@ -92,8 +93,8 @@ static int addr_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 	return err;
 }
 
-static int fill_addr(struct sk_buff *skb, struct net_device *dev, u8 addr,
-			u32 portid, u32 seq, int event)
+static int fill_addr(struct sk_buff *skb, u32 ifindex, u8 addr,
+		     u32 portid, u32 seq, int event)
 {
 	struct ifaddrmsg *ifm;
 	struct nlmsghdr *nlh;
@@ -107,7 +108,7 @@ static int fill_addr(struct sk_buff *skb, struct net_device *dev, u8 addr,
 	ifm->ifa_prefixlen = 0;
 	ifm->ifa_flags = IFA_F_PERMANENT;
 	ifm->ifa_scope = RT_SCOPE_LINK;
-	ifm->ifa_index = dev->ifindex;
+	ifm->ifa_index = ifindex;
 	if (nla_put_u8(skb, IFA_LOCAL, addr))
 		goto nla_put_failure;
 	nlmsg_end(skb, nlh);
@@ -140,7 +141,7 @@ static int getaddr_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 			if (addr_idx++ < addr_start_idx)
 				continue;
 
-			if (fill_addr(skb, pnd->netdev, addr << 2,
+			if (fill_addr(skb, pnd->netdev->ifindex, addr << 2,
 					 NETLINK_CB(cb->skb).portid,
 					cb->nlh->nlmsg_seq, RTM_NEWADDR) < 0)
 				goto out;
-- 
2.53.0

