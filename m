Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E0E4349A7
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 19:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788895722; cv=none; b=QX2ratTgc8Y9ZVEZGsE4g6HMo+pfI32Nc04LdtNwxtWCvsbSlseMHzx52AalFDpbqxg6ML68Vct3j6uaP9buR+rRKw4ddW0VTnK6RVWS/neh1JpLv9U4fRCoHO698wQEDwWl69wCX3nw61gQpe5fRKaKAPiLwFLk9mCRK2Tmbww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788895722; c=relaxed/simple;
	bh=fyDVvMpO8QGiN3cqHes/KvZS2xoCmo/PhXNiRck8sJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxlXriATRHLJoqh7CELserHr45f+l7Atf9pq72ComSIvmHC0OLlPPemONOZxXFtmsQkIT2/yyXuaA58iqQIomBqxbijuOGiLCRbRvh6geCr1+srieU4Y2v7ff7Ps6kLVKO5K84uX1GpopW1c/j8b4ybDxghuOfkVGi3Weuny1Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVEC+Uhf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVEC+Uhf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972CE1F00ADB;
	Tue,  8 Sep 2026 19:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788895715;
	bh=panu0ejlY4lxJAi5w2fsBKqcquWLKnrhIUUbda2BP2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HVEC+UhfocWyx+v014j+M5K5+o5JWmdVfbOe/zTH9f+hcAufOILnFfzLhBjR0HlYV
	 eQuYurkuTx2E7uPe9FOLZKrT91ASJvb5jhmOGc8T8lSYGtd4TfCxPP+89vm3cWPLqJ
	 Wu5f90krzJl6vdhS+1380pLoNRhxtKlTlCbnEVc3Y8YSCIrTuT+HhRo2OKl1ooEq7B
	 J+LVZND/9L8La9vrVs4h8uz0i3fTgFswFC0fk35MQGdF+sRpgYYlDB6Z3W8BI59K59
	 4E79/ErQLzzssSWSs+V0GLqNm/ERz/svzGwL/3dIPmGdqN+Z1Jyjj6MHinOSjJc5S6
	 kE9dAmJXTNcOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] net: dst: add four helpers to annotate data-races around dst->dev
Date: Tue,  8 Sep 2026 15:28:30 -0400
Message-ID: <20260908192832.296634-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090318-pusher-lucid-87ba@gregkh>
References: <2026090318-pusher-lucid-87ba@gregkh>
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
Stable-dep-of: e36ce6e78fe3 ("ip: orphan prefetched skbs before multicast forwarding")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/dst.h    | 20 ++++++++++++++++++++
 net/core/dst.c       |  4 ++--
 net/core/sock.c      |  8 ++++----
 net/ipv6/ip6_input.c |  4 ++--
 4 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/include/net/dst.h b/include/net/dst.h
index 55d1be268d243..1983945dfcdf1 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -569,6 +569,11 @@ static inline void skb_dst_update_pmtu_no_confirm(struct sk_buff *skb, u32 mtu)
 		dst->ops->update_pmtu(dst, NULL, skb, mtu, false);
 }
 
+static inline struct net_device *dst_dev(const struct dst_entry *dst)
+{
+	return READ_ONCE(dst->dev);
+}
+
 static inline struct net_device *dst_dev_rcu(const struct dst_entry *dst)
 {
 	/* In the future, use rcu_dereference(dst->dev) */
@@ -576,11 +581,26 @@ static inline struct net_device *dst_dev_rcu(const struct dst_entry *dst)
 	return READ_ONCE(dst->dev);
 }
 
+static inline struct net_device *skb_dst_dev(const struct sk_buff *skb)
+{
+	return dst_dev(skb_dst(skb));
+}
+
 static inline struct net_device *skb_dst_dev_rcu(const struct sk_buff *skb)
 {
 	return dst_dev_rcu(skb_dst(skb));
 }
 
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
index 5ed8cb10748f5..f65e6be7e2571 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -153,7 +153,7 @@ void dst_dev_put(struct dst_entry *dst)
 		dst->ops->ifdown(dst, dev);
 	WRITE_ONCE(dst->input, dst_discard);
 	WRITE_ONCE(dst->output, dst_discard_out);
-	dst->dev = blackhole_netdev;
+	WRITE_ONCE(dst->dev, blackhole_netdev);
 	netdev_ref_replace(dev, blackhole_netdev, &dst->dev_tracker,
 			   GFP_ATOMIC);
 }
@@ -266,7 +266,7 @@ unsigned int dst_blackhole_mtu(const struct dst_entry *dst)
 {
 	unsigned int mtu = dst_metric_raw(dst, RTAX_MTU);
 
-	return mtu ? : dst->dev->mtu;
+	return mtu ? : dst_dev(dst)->mtu;
 }
 EXPORT_SYMBOL_GPL(dst_blackhole_mtu);
 
diff --git a/net/core/sock.c b/net/core/sock.c
index 846e95805c199..2f82dc45f93ec 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2454,8 +2454,8 @@ static u32 sk_dst_gso_max_size(struct sock *sk, struct dst_entry *dst)
 		   !ipv6_addr_v4mapped(&sk->sk_v6_rcv_saddr));
 #endif
 	/* pairs with the WRITE_ONCE() in netif_set_gso(_ipv4)_max_size() */
-	max_size = is_ipv6 ? READ_ONCE(dst->dev->gso_max_size) :
-			READ_ONCE(dst->dev->gso_ipv4_max_size);
+	max_size = is_ipv6 ? READ_ONCE(dst_dev(dst)->gso_max_size) :
+			READ_ONCE(dst_dev(dst)->gso_ipv4_max_size);
 	if (max_size > GSO_LEGACY_MAX_SIZE && !sk_is_tcp(sk))
 		max_size = GSO_LEGACY_MAX_SIZE;
 
@@ -2466,7 +2466,7 @@ void sk_setup_caps(struct sock *sk, struct dst_entry *dst)
 {
 	u32 max_segs = 1;
 
-	sk->sk_route_caps = dst->dev->features;
+	sk->sk_route_caps = dst_dev(dst)->features;
 	if (sk_is_tcp(sk))
 		sk->sk_route_caps |= NETIF_F_GSO;
 	if (sk->sk_route_caps & NETIF_F_GSO)
@@ -2480,7 +2480,7 @@ void sk_setup_caps(struct sock *sk, struct dst_entry *dst)
 			sk->sk_route_caps |= NETIF_F_SG | NETIF_F_HW_CSUM;
 			sk->sk_gso_max_size = sk_dst_gso_max_size(sk, dst);
 			/* pairs with the WRITE_ONCE() in netif_set_gso_max_segs() */
-			max_segs = max_t(u32, READ_ONCE(dst->dev->gso_max_segs), 1);
+			max_segs = max_t(u32, READ_ONCE(dst_dev(dst)->gso_max_segs), 1);
 		}
 	}
 	sk->sk_gso_max_segs = max_segs;
diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index 133610a49da6b..54146e280c2b7 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -569,9 +569,9 @@ int ip6_mc_input(struct sk_buff *skb)
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
-- 
2.53.0

