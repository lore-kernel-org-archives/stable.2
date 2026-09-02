Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6FD47798B
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 10:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788346435; cv=none; b=GW2Yaqn/tTzgPkGMw9qn8y8UJBDMtGWsxr5OXqYSvT9IjsgY7zUtV4dR4wXllh1ohoVYsQ3QMgHt88eqcX1lXo+Y9M+m2wMPNrAgS1sSAl1X8AUddj3GTDdJRRJaLdX3SybO+1rjhr/iFO2OplJryv8T3HM8zfGjq1tC5XS++DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788346435; c=relaxed/simple;
	bh=zv1EzDaa/heLomrWdYVDWGk3Brwv89uK//jZSWLyd+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sqBlAbDo64nce4EV4Lc27SKfWrBkXsmVWDiA2HYo0q+bqurVFuNGxmzcMqB2hzD1SS7VuVFWC8Oue7F3f3tPvUNr7AeM4DxHtSSDK1kaUHjpSuqkoQFk8gzdtJgm1ky6JXAvBDyAscOgOEjlFMARH0YAOfmD+iRPL6XM0R5+1H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GC1qDwOu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GC1qDwOu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506991F01558;
	Wed,  2 Sep 2026 10:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788346417;
	bh=o4Dpc/zFLu7TFPFlBFYDqQ/8BMpXyq5BbOt+xcGCOOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GC1qDwOuF37kQ5lpLg8zqRTT021KqZ4rA3ASZQkp8VQL0fR8PpwLrkkVAYCamECV0
	 8zSUW7M7yqbnQR5gSGV0bd4OY/OxhNgF5kpe5qO5koWimq1PV4uC12T7p6zAM5/J3K
	 pjxa6vIpE7kbgxznar1cloMyoBlv0X/gyrRaGGDx6XJE7aawLu3wGkStYLdVUBlNp5
	 2tPP0mUOhaxxb+Tr7/eYxkoIeKtXhaambyjiXOYuRGgag6WEKEIPOT8qKVhzkqBkYa
	 8izIqsnHZGJQVIoZoPYx/1W/XXd8QOR6qgnN5Usnn0RyEvhHOVNGDSASJcy1GtkcQm
	 dY38og7Ev5HKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/5] ipv6: use dst6_mtu() instead of dst_mtu()
Date: Wed,  2 Sep 2026 06:53:30 -0400
Message-ID: <20260902105332.2048804-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902105332.2048804-1-sashal@kernel.org>
References: <2026083106-glisten-superhero-188c@gregkh>
 <20260902105332.2048804-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit b40f0130a23b6bab8b359e158a40af81f11f14be ]

When we expect an IPv6 dst, use dst6_mtu() instead of dst_mtu()
to save some code space.

Due to current dst6_mtu() implementation, only convert
users in IPv6 stack.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20260130210303.3888261-7-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

[ Adjusted for 5.10: this tree lacks several later upstream ip6_output.c
  and ip6_gre.c refactors (READ_ONCE()ification, dst_dev(), frag_size
  local, IP6_INC_STATS vs IP6_UPD_PO_STATS), so only the dst_mtu() ->
  dst6_mtu() substitution was applied on top of the existing 5.10 code
  shape.  dst6_mtu()'s INDIRECT_CALL_1() now references ip6_mtu from
  the ip6_gre.ko and ip6_tunnel.ko modules, so ip6_mtu needs to be
  exported. This tree predates upstream commit 0053859496baa1
  ("net: add EXPORT_INDIRECT_CALLABLE wrapper"), so that wrapper and
  its use for ip6_mtu in net/ipv6/route.c were folded in here too,
  avoiding a "static EXPORT_SYMBOL" warning on !CONFIG_RETPOLINE
  builds (e.g. arm64) while still exporting the symbol under
  CONFIG_RETPOLINE (e.g. x86_64), matching upstream's approach. ]

Stable-dep-of: 870a9e42ecc6 ("tcp: clamp route advmss to TCP_MIN_MSS")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/indirect_call_wrapper.h |  2 ++
 net/ipv6/ip6_gre.c                    |  2 +-
 net/ipv6/ip6_output.c                 |  6 +++---
 net/ipv6/ip6_tunnel.c                 |  4 ++--
 net/ipv6/ipv6_sockglue.c              |  4 ++--
 net/ipv6/route.c                      | 11 +++++++----
 net/ipv6/tcp_ipv6.c                   |  9 +++++----
 7 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/include/linux/indirect_call_wrapper.h b/include/linux/indirect_call_wrapper.h
index 6afdd080c7c1b..227cee5e2a98b 100644
--- a/include/linux/indirect_call_wrapper.h
+++ b/include/linux/indirect_call_wrapper.h
@@ -40,6 +40,7 @@
 
 #define INDIRECT_CALLABLE_DECLARE(f)	f
 #define INDIRECT_CALLABLE_SCOPE
+#define EXPORT_INDIRECT_CALLABLE(f)	EXPORT_SYMBOL(f)
 
 #else
 #define INDIRECT_CALL_1(f, f1, ...) f(__VA_ARGS__)
@@ -48,6 +49,7 @@
 #define INDIRECT_CALL_4(f, f4, f3, f2, f1, ...) f(__VA_ARGS__)
 #define INDIRECT_CALLABLE_DECLARE(f)
 #define INDIRECT_CALLABLE_SCOPE		static
+#define EXPORT_INDIRECT_CALLABLE(f)
 #endif
 
 /*
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 9e82e89a4d813..73aaa2890ea26 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1071,7 +1071,7 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 	gre_build_header(skb, 8, TUNNEL_SEQ, proto, 0, htonl(atomic_fetch_inc(&t->o_seqno)));
 
 	/* TooBig packet may have updated dst->dev's mtu */
-	if (!t->parms.collect_md && dst && dst_mtu(dst) > dst->dev->mtu)
+	if (!t->parms.collect_md && dst && dst6_mtu(dst) > dst->dev->mtu)
 		dst->ops->update_pmtu(dst, NULL, skb, dst->dev->mtu, false);
 
 	err = ip6_tnl_xmit(skb, dev, dsfield, &fl6, encap_limit, &mtu,
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 8948c79504ce7..55dcb7a021ab5 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -324,7 +324,7 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 	skb->priority = priority;
 	skb->mark = mark;
 
-	mtu = dst_mtu(dst);
+	mtu = dst6_mtu(dst);
 	if ((skb->len <= mtu) || skb->ignore_df || skb_is_gso(skb)) {
 		IP6_UPD_PO_STATS(net, idev, IPSTATS_MIB_OUT, skb->len);
 
@@ -1353,10 +1353,10 @@ static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
 	v6_cork->tclass = ipc6->tclass;
 	if (rt->dst.flags & DST_XFRM_TUNNEL)
 		mtu = np->pmtudisc >= IPV6_PMTUDISC_PROBE ?
-		      READ_ONCE(rt->dst.dev->mtu) : dst_mtu(&rt->dst);
+		      READ_ONCE(rt->dst.dev->mtu) : dst6_mtu(&rt->dst);
 	else
 		mtu = np->pmtudisc >= IPV6_PMTUDISC_PROBE ?
-			READ_ONCE(rt->dst.dev->mtu) : dst_mtu(xfrm_dst_path(&rt->dst));
+			READ_ONCE(rt->dst.dev->mtu) : dst6_mtu(xfrm_dst_path(&rt->dst));
 	if (np->frag_size < mtu) {
 		if (np->frag_size)
 			mtu = np->frag_size;
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index ff88f98289812..77ef185657d13 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -674,7 +674,7 @@ ip4ip6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 
 	/* change mtu on this route */
 	if (rel_type == ICMP_DEST_UNREACH && rel_code == ICMP_FRAG_NEEDED) {
-		if (rel_info > dst_mtu(skb_dst(skb2)))
+		if (rel_info > dst6_mtu(skb_dst(skb2)))
 			goto out;
 
 		skb_dst_update_pmtu_no_confirm(skb2, rel_info);
@@ -1215,7 +1215,7 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 				     t->parms.name);
 		goto tx_err_dst_release;
 	}
-	mtu = dst_mtu(dst) - eth_hlen - psh_hlen - t->tun_hlen;
+	mtu = dst6_mtu(dst) - eth_hlen - psh_hlen - t->tun_hlen;
 	if (encap_limit >= 0) {
 		max_headroom += 8;
 		mtu -= 8;
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index dbbe53260b008..3951fae361a13 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -1210,7 +1210,7 @@ static int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 		rcu_read_lock();
 		dst = __sk_dst_get(sk);
 		if (dst)
-			val = dst_mtu(dst);
+			val = dst6_mtu(dst);
 		rcu_read_unlock();
 		if (!val)
 			return -ENOTCONN;
@@ -1309,7 +1309,7 @@ static int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 		rcu_read_lock();
 		dst = __sk_dst_get(sk);
 		if (dst)
-			mtuinfo.ip6m_mtu = dst_mtu(dst);
+			mtuinfo.ip6m_mtu = dst6_mtu(dst);
 		rcu_read_unlock();
 		if (!mtuinfo.ip6m_mtu)
 			return -ENOTCONN;
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 138761f4cc747..6e73180e27b6e 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1988,6 +1988,8 @@ static void rt6_update_exception_stamp_rt(struct rt6_info *rt)
 static bool rt6_mtu_change_route_allowed(struct inet6_dev *idev,
 					 struct rt6_info *rt, int mtu)
 {
+	u32 dmtu = dst6_mtu(&rt->dst);
+
 	/* If the new MTU is lower than the route PMTU, this new MTU will be the
 	 * lowest MTU in the path: always allow updating the route PMTU to
 	 * reflect PMTU decreases.
@@ -1998,10 +2000,10 @@ static bool rt6_mtu_change_route_allowed(struct inet6_dev *idev,
 	 * handle this.
 	 */
 
-	if (dst_mtu(&rt->dst) >= mtu)
+	if (dmtu >= mtu)
 		return true;
 
-	if (dst_mtu(&rt->dst) == idev->cnf.mtu6)
+	if (dmtu == idev->cnf.mtu6)
 		return true;
 
 	return false;
@@ -2739,7 +2741,7 @@ static void __ip6_rt_update_pmtu(struct dst_entry *dst, const struct sock *sk,
 
 	if (mtu < IPV6_MIN_MTU)
 		return;
-	if (mtu >= dst_mtu(dst))
+	if (mtu >= dst6_mtu(dst))
 		return;
 
 	if (!rt6_cache_allowed_for_pmtu(rt6)) {
@@ -3056,7 +3058,7 @@ EXPORT_SYMBOL_GPL(ip6_sk_redirect);
 static unsigned int ip6_default_advmss(const struct dst_entry *dst)
 {
 	struct net_device *dev = dst->dev;
-	unsigned int mtu = dst_mtu(dst);
+	unsigned int mtu = dst6_mtu(dst);
 	struct net *net;
 
 	mtu -= sizeof(struct ipv6hdr) + sizeof(struct tcphdr);
@@ -3102,6 +3104,7 @@ INDIRECT_CALLABLE_SCOPE unsigned int ip6_mtu(const struct dst_entry *dst)
 
 	return mtu - lwtunnel_headroom(dst->lwtstate, mtu);
 }
+EXPORT_INDIRECT_CALLABLE(ip6_mtu);
 
 /* MTU selection:
  * 1. mtu on route is locked - use it
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 523aa2efdc499..89b53801660c6 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -354,7 +354,7 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr *uaddr,
 static void tcp_v6_mtu_reduced(struct sock *sk)
 {
 	struct dst_entry *dst;
-	u32 mtu;
+	u32 mtu, dmtu;
 
 	if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE))
 		return;
@@ -371,8 +371,9 @@ static void tcp_v6_mtu_reduced(struct sock *sk)
 	if (!dst)
 		return;
 
-	if (inet_csk(sk)->icsk_pmtu_cookie > dst_mtu(dst)) {
-		tcp_sync_mss(sk, dst_mtu(dst));
+	dmtu = dst6_mtu(dst);
+	if (inet_csk(sk)->icsk_pmtu_cookie > dmtu) {
+		tcp_sync_mss(sk, dmtu);
 		tcp_simple_retransmit(sk);
 	}
 }
@@ -1377,7 +1378,7 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 
 	tcp_ca_openreq_child(newsk, dst);
 
-	tcp_sync_mss(newsk, dst_mtu(dst));
+	tcp_sync_mss(newsk, dst6_mtu(dst));
 	newtp->advmss = tcp_mss_clamp(tcp_sk(sk), dst_metric_advmss(dst));
 
 	tcp_initialize_rcv_mss(newsk);
-- 
2.53.0

