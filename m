Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5481646DFFC
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 11:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784806633; cv=none; b=g0P3SD2MPLgn2w/EHcY4qiGz/17dlvApmoeSfN6NLbwxYViUS9N9cGNgJqh4pEcZLDY7C73WFKXj+iboEqQH+FofUT/GqI03sKVYYojy+HO435TOTX7f5dmY6Jf/DjPDgAVOeDZJNtTQ6kHJ3y5rmL8NqsZ5f/QvF2I2IoFs2AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784806633; c=relaxed/simple;
	bh=2FTrCzWIBgJVkU96otLyeDy8XFvbPx2kz9WXTFNQx60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oUc8qwIe0W6JfWpidb9zPhi9blfEJGgWwPr2E9N05y7Wmzoo65WScy6BHjR7GPM6B9NOnMsxZv3Tf6w37JwFuYA13VUA5PcC5ifDuyeFus/svoW6UgfNRnAabHh9lJtKfAqjH5//BArArLCiahtiCudxU2Iq6zhHYx92olcERgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJLeGwHZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJLeGwHZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95DC1F00ACA;
	Thu, 23 Jul 2026 11:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784806632;
	bh=6fjP6gaYCk5QXPzMtyDA4wBcn3jODZIiJTBYWhCinf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UJLeGwHZTvNuNeN7toOSegrRey9N9Zja3VLG1KqEoZ50fD1jzEOo7vlV4T3zVt/ZR
	 9x5sPXOLn6zoHZKYvZwIIJfgP9FhnKXElDUEySY/5uaEqCSuPIxdwyJfiTfvK0pO6m
	 waLaPr8y93mWbnJ2CiYKXi38ETWyYOqZOhDSDUL5LIy2YV8/j/vKDXJaxEXU0y7/K5
	 XRzlQwE4Ob4RNNnN+w9liW0PS7zybY3ttRPlURqMyZFX9ZQ415cCdew+WW8q6YoWl3
	 yXm2PtC3GTq/ObhdmknQbDy09y5Jmq/tvg+hdCRkCyGHU0aaYjWQmIeYEbDKUzIety
	 1I8ERznJhONJA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/6] net: dst: add four helpers to annotate data-races around dst->dev
Date: Thu, 23 Jul 2026 07:37:00 -0400
Message-ID: <20260723113702.3035088-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723113702.3035088-1-sashal@kernel.org>
References: <2026072042-collide-upturned-2e18@gregkh>
 <20260723113702.3035088-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 88fe14253e181878c2ddb51a298ae8c468a63010 ]

dst->dev is read locklessly in many contexts,
and written in dst_dev_put().

Fixing all the races is going to need many changes.

We probably will have to add full RCU protection.

Add three helpers to ease this painful process.

static inline struct net_device *dst_dev(const struct dst_entry *dst)
{
       return READ_ONCE(dst->dev);
}

static inline struct net_device *skb_dst_dev(const struct sk_buff *skb)
{
       return dst_dev(skb_dst(skb));
}

static inline struct net *skb_dst_dev_net(const struct sk_buff *skb)
{
       return dev_net(skb_dst_dev(skb));
}

static inline struct net *skb_dst_dev_net_rcu(const struct sk_buff *skb)
{
       return dev_net_rcu(skb_dst_dev(skb));
}

Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20250630121934.3399505-7-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: c9c9b37f8c55 ("netfilter: nf_queue: pin bridge device while NFQUEUE holds fake dst")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/dst.h | 20 ++++++++++++++++++++
 net/core/dst.c    |  4 ++--
 net/core/sock.c   |  6 +++---
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/include/net/dst.h b/include/net/dst.h
index 27494911d6a100..9a23986f1071a3 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -566,6 +566,26 @@ static inline struct net_device *skb_dst_dev_rcu(const struct sk_buff *skb)
 	return dst_dev_rcu(skb_dst(skb));
 }
 
+static inline struct net_device *dst_dev(const struct dst_entry *dst)
+{
+	return READ_ONCE(dst->dev);
+}
+
+static inline struct net_device *skb_dst_dev(const struct sk_buff *skb)
+{
+	return dst_dev(skb_dst(skb));
+}
+
+static inline struct net *skb_dst_dev_net(const struct sk_buff *skb)
+{
+	return dev_net(skb_dst_dev(skb));
+}
+
+static inline struct net *skb_dst_dev_net_rcu(const struct sk_buff *skb)
+{
+	return dev_net_rcu(skb_dst_dev(skb));
+}
+
 struct dst_entry *dst_blackhole_check(struct dst_entry *dst, u32 cookie);
 void dst_blackhole_update_pmtu(struct dst_entry *dst, struct sock *sk,
 			       struct sk_buff *skb, u32 mtu, bool confirm_neigh);
diff --git a/net/core/dst.c b/net/core/dst.c
index 42d7c04d409bd3..8707b7ffe42101 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -151,7 +151,7 @@ void dst_dev_put(struct dst_entry *dst)
 		dst->ops->ifdown(dst, dev, true);
 	WRITE_ONCE(dst->input, dst_discard);
 	WRITE_ONCE(dst->output, dst_discard_out);
-	dst->dev = blackhole_netdev;
+	WRITE_ONCE(dst->dev, blackhole_netdev);
 	dev_hold(dst->dev);
 	dev_put(dev);
 }
@@ -272,7 +272,7 @@ unsigned int dst_blackhole_mtu(const struct dst_entry *dst)
 {
 	unsigned int mtu = dst_metric_raw(dst, RTAX_MTU);
 
-	return mtu ? : dst->dev->mtu;
+	return mtu ? : dst_dev(dst)->mtu;
 }
 EXPORT_SYMBOL_GPL(dst_blackhole_mtu);
 
diff --git a/net/core/sock.c b/net/core/sock.c
index bf2bec10d5d6a3..af8e07c114920c 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2193,7 +2193,7 @@ void sk_setup_caps(struct sock *sk, struct dst_entry *dst)
 {
 	u32 max_segs = 1;
 
-	sk->sk_route_caps = dst->dev->features | sk->sk_route_forced_caps;
+	sk->sk_route_caps = dst_dev(dst)->features | sk->sk_route_forced_caps;
 	if (sk->sk_route_caps & NETIF_F_GSO)
 		sk->sk_route_caps |= NETIF_F_GSO_SOFTWARE;
 	sk->sk_route_caps &= ~sk->sk_route_nocaps;
@@ -2202,8 +2202,8 @@ void sk_setup_caps(struct sock *sk, struct dst_entry *dst)
 			sk->sk_route_caps &= ~NETIF_F_GSO_MASK;
 		} else {
 			sk->sk_route_caps |= NETIF_F_SG | NETIF_F_HW_CSUM;
-			sk->sk_gso_max_size = dst->dev->gso_max_size;
-			max_segs = max_t(u32, dst->dev->gso_max_segs, 1);
+			sk->sk_gso_max_size = dst_dev(dst)->gso_max_size;
+			max_segs = max_t(u32, dst_dev(dst)->gso_max_segs, 1);
 		}
 	}
 	sk->sk_gso_max_segs = max_segs;
-- 
2.53.0

