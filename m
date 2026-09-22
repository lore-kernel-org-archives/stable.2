Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6263856C634
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 16:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790095731; cv=none; b=YcPzBv5qgBXVuY5OXnVUqqcfeJkiyY1J5BYNgVwTr3gcI0KfR2CweBibsG8hnf+XF9YjaIGfJu2snGcJJq7ZySC1AHmrzumLDfEvh2hqL52zZIxcAbNwcqjreCSGJVpYxicNiQalYzlxotO69lPu2KvfAC4exCe60x/lIV9LZkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790095731; c=relaxed/simple;
	bh=qfZqrbd/jFoK/JcqvUXb/6LaI6fGulvY/LHcbGg+YS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P1tVU0O0WZb2nppqhq9THkKW3XhoCdpaM/r2+dwk3adOxd9uqZcJUJP1n+0jHQ8UNTgqLkxxzgZwRHqQ/up8Tsz+UnxupaXXr5bKS4wErKAlfLkoaxE+jeSaDVm5s1pA3S2DJjF5L2KxHDTKO0sneatlfATsM9HZJ+Mj3fZqYvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajMwro4+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajMwro4+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F341F00898;
	Tue, 22 Sep 2026 16:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790095725;
	bh=nIb8YkfW0vJJabmpLK5nsZoon1Zh5AP2wTDAi6xXAEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ajMwro4+gkGPw3AyHYbX0e+8hBPEvug9gUQtqQDc2RRe3HMgbBuevsmt7AZgr+dOn
	 mQLApPBHRrVfrYmsh82hxwspl6KfxLCtSRXrFmVUOMJnoEXl8r8m5nfmdAoxDfuMZ+
	 /PCz1JShPgS/Sq4ZCjMiH0e9z6pIFFdKaGJ9oC+PFj4EIz+/jvHiQJlNX13rDUUjvM
	 WpL2UhyWfzdhYdpJFibUXKudg5x2YVaNO79SmUOeazW+CXuNrZ3NefCb9XUexXm06Q
	 vRWXDeyz9tgX9JeyeI7jT/l1YmwbiImHerPLrbqQQZB4P+REEo7VgyvnX/FOSIePYF
	 XrQgHFTenJbhw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dong Chenchen <dongchenchen2@huawei.com>,
	Xu Chunxiao <xuchunxiao3@huawei.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] xfrm: Fix dev use-after-free in xfrm async resumption
Date: Tue, 22 Sep 2026 12:48:41 -0400
Message-ID: <20260922164842.3125154-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922164842.3125154-1-sashal@kernel.org>
References: <2026092226-ebony-armband-9098@gregkh>
 <20260922164842.3125154-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dong Chenchen <dongchenchen2@huawei.com>

[ Upstream commit 8045c0df98d4f14c54e5cb875f1c9c0ce89fe4ff ]

xfrm async resumption hold skb->dev refcnt until after transport_finish.
However, xfrm_rcv_cb may modify skb->dev to tunnel dev without taking
device reference, such as vti_rcv_cb. The subsequent async resumption
will decrement the tunnel device's reference count, which lead to uaf
of tunnel dev and refcnt leak of orig dev as below:

unregister_netdevice: waiting for vti1 to become free. Usage count = -2

Stash the original skb->dev to fix refcnt imbalance. The new skb->dev set
by xfrm_rcv_cb can race with device teardown. Extend rcu protection over
xfrm_rcv_cb and transport_finish to prevent races.

Fixes: 1c428b038400 ("xfrm: hold dev ref until after transport_finish NF_HOOK")
Reported-by: Xu Chunxiao <xuchunxiao3@huawei.com>
Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>

Backport to 6.12: retain the synchronous xfrm_inner_mode_input()
error handling. This tree lacks the mode_cbs infrastructure that
introduced the -EINPROGRESS branch, so omit the dev_put() conversion
for that absent branch. Keep the original-device reference handling
and extended RCU protection for the existing receive paths.

This supplies the receive, transport-finish and drop-path context for
3cf5cdecd99c ("xfrm: save input state data before secpath resets"),
which applies without further changes.

Stable-dep-of: 3cf5cdecd99c ("xfrm: save input state data before secpath resets")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/xfrm4_input.c |  2 --
 net/ipv6/xfrm6_input.c |  2 --
 net/xfrm/xfrm_input.c  | 27 +++++++++++++++------------
 3 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/net/ipv4/xfrm4_input.c b/net/ipv4/xfrm4_input.c
index adf21d6b6076c..9deee1558e3d6 100644
--- a/net/ipv4/xfrm4_input.c
+++ b/net/ipv4/xfrm4_input.c
@@ -76,8 +76,6 @@ int xfrm4_transport_finish(struct sk_buff *skb, int async)
 	NF_HOOK(NFPROTO_IPV4, NF_INET_PRE_ROUTING,
 		dev_net(dev), NULL, skb, dev, NULL,
 		xfrm4_rcv_encap_finish);
-	if (async)
-		dev_put(dev);
 	return 0;
 }
 
diff --git a/net/ipv6/xfrm6_input.c b/net/ipv6/xfrm6_input.c
index c9e208c57a6b5..07edef2589844 100644
--- a/net/ipv6/xfrm6_input.c
+++ b/net/ipv6/xfrm6_input.c
@@ -71,8 +71,6 @@ int xfrm6_transport_finish(struct sk_buff *skb, int async)
 	NF_HOOK(NFPROTO_IPV6, NF_INET_PRE_ROUTING,
 		dev_net(dev), NULL, skb, dev, NULL,
 		xfrm6_transport_finish2);
-	if (async)
-		dev_put(dev);
 	return 0;
 }
 
diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 01734b4b06578..9f98811d7815a 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -457,6 +457,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 {
 	const struct xfrm_state_afinfo *afinfo;
 	struct net *net = dev_net(skb->dev);
+	struct net_device *dev = skb->dev;
 	int err;
 	__be32 seq;
 	__be32 seq_hi;
@@ -483,7 +484,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 					       LINUX_MIB_XFRMINSTATEINVALID);
 
 			if (encap_type == -1)
-				dev_put(skb->dev);
+				dev_put(dev);
 			goto drop;
 		}
 
@@ -641,16 +642,16 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 
 		if (!crypto_done) {
 			spin_unlock(&x->lock);
-			dev_hold(skb->dev);
+			dev_hold(dev);
 
 			nexthdr = x->type->input(x, skb);
 			if (nexthdr == -EINPROGRESS) {
 				if (async)
-					dev_put(skb->dev);
+					dev_put(dev);
 				return 0;
 			}
 
-			dev_put(skb->dev);
+			dev_put(dev);
 			spin_lock(&x->lock);
 		}
 resume:
@@ -707,9 +708,12 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 		crypto_done = false;
 	} while (!err);
 
+	rcu_read_lock();
 	err = xfrm_rcv_cb(skb, family, x->type->proto, 0);
-	if (err)
+	if (err) {
+		rcu_read_unlock();
 		goto drop;
+	}
 
 	nf_reset_ct(skb);
 
@@ -720,8 +724,9 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 		if (skb_valid_dst(skb))
 			skb_dst_drop(skb);
 		if (async)
-			dev_put(skb->dev);
+			dev_put(dev);
 		gro_cells_receive(&gro_cells, skb);
+		rcu_read_unlock();
 		return 0;
 	} else {
 		xo = xfrm_offload(skb);
@@ -729,23 +734,21 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			xfrm_gro = xo->flags & XFRM_GRO;
 
 		err = -EAFNOSUPPORT;
-		rcu_read_lock();
 		afinfo = xfrm_state_afinfo_get_rcu(x->props.family);
 		if (likely(afinfo))
 			err = afinfo->transport_finish(skb, xfrm_gro || async);
-		rcu_read_unlock();
 		if (xfrm_gro) {
 			sp = skb_sec_path(skb);
 			if (sp)
 				sp->olen = 0;
 			if (skb_valid_dst(skb))
 				skb_dst_drop(skb);
-			if (async)
-				dev_put(skb->dev);
 			gro_cells_receive(&gro_cells, skb);
-			return err;
 		}
 
+		if (async)
+			dev_put(dev);
+		rcu_read_unlock();
 		return err;
 	}
 
@@ -753,7 +756,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 	spin_unlock(&x->lock);
 drop:
 	if (async)
-		dev_put(skb->dev);
+		dev_put(dev);
 	xfrm_rcv_cb(skb, family, x && x->type ? x->type->proto : nexthdr, -1);
 	kfree_skb(skb);
 	return 0;
-- 
2.53.0

