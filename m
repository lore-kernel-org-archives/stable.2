Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E1136212D
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 14:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272290; cv=none; b=VlNXIFj60pUE440osELNjwOaLHtOxAHdgu3oXWWr5yurIeBCPF+MvVD31uLrpLGfUsgFMwYEX8Vt6VB2REHDph3YnKJe+KJpT8N/qlZd3LsE6LswxC7U0uJ/Fyl134E0FQMAYzKJAEaDLlo4mcmrY+kLQm2kSroq6HCuh1GmH/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272290; c=relaxed/simple;
	bh=QaCsPof1EQUaajwGMBVYzzzQG0Fx8OE5J3FKnRSGgfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9ARLcqXrWCkE6TpI+EIgVR81duRaSf/88qUZMQ71qTUJ0coHHxeIjW9oAQd0KpfCFNHzLTcU7/Ph2Aw9VDuGkRP5N+i2upcUOO6EuWOLE5VJRf6Ki6Q5i9Ff8sBDWhALD5aH1C2OEh8st3m07p6hZvvxcY03GeFNpn6qDUnPLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2T3fuIt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2T3fuIt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06ED91F00ACA;
	Tue,  1 Sep 2026 14:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788272288;
	bh=QUf/T8YZz9Xrqfl5PwP22fsQ7Mkai0foT/I5I0XkBg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U2T3fuItt+o+OOUEPmTobw5EMAuz/L99FK/pp54J007WFTjQjGUhc9qynpk/tKjDM
	 Re7sACl1YaYLs5QTl+Cg/QfLa2ptO/f6l8PafrQrFc7/gHIjv+kN3vceHxH+HLcIHm
	 YE+kfOYRWvVItWIFlb9CLPf9EIOA6rcRBuGCE4k9r01O3FVdch+2a61v3HidhXBaQB
	 8gvBJZWoLxVUiWutSC/+Py9hM+uV+CKxxWnE+WwMp/dcScA6w5hRTgg3XUX0ETz++S
	 UeWk0FHIG75vtqfHzGkYpyIb4z1pDaeSSxk0l6LFaTjl+E76UIws7KIOzAVo0wCzJV
	 pi6B0qR8GJNFg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/5] ipv6: use dst6_mtu() instead of dst_mtu()
Date: Tue,  1 Sep 2026 10:18:02 -0400
Message-ID: <20260901141804.1031618-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901141804.1031618-1-sashal@kernel.org>
References: <2026083105-buddhist-verdict-4f97@gregkh>
 <20260901141804.1031618-1-sashal@kernel.org>
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
Stable-dep-of: 870a9e42ecc6 ("tcp: clamp route advmss to TCP_MIN_MSS")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/ip6_gre.c       |  3 ++-
 net/ipv6/ip6_output.c    |  6 +++---
 net/ipv6/ip6_tunnel.c    |  4 ++--
 net/ipv6/ipv6_sockglue.c |  4 ++--
 net/ipv6/route.c         | 10 ++++++----
 net/ipv6/tcp_ipv6.c      |  9 +++++----
 6 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 74442c9fb4abc..3e635cc6d0646 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1071,9 +1071,10 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 	gre_build_header(skb, 8, TUNNEL_SEQ, proto, 0, htonl(atomic_fetch_inc(&t->o_seqno)));
 
 	/* TooBig packet may have updated dst->dev's mtu */
-	if (!t->parms.collect_md && dst && dst_mtu(dst) > dst->dev->mtu)
+	if (!t->parms.collect_md && dst && dst6_mtu(dst) > dst->dev->mtu)
 		dst->ops->update_pmtu(dst, NULL, skb, dst->dev->mtu, false);
 
+
 	err = ip6_tnl_xmit(skb, dev, dsfield, &fl6, encap_limit, &mtu,
 			   NEXTHDR_GRE);
 	if (err != 0) {
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index b065fc70037c4..856b1ab2d629f 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -347,7 +347,7 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 	skb->priority = priority;
 	skb->mark = mark;
 
-	mtu = dst_mtu(dst);
+	mtu = dst6_mtu(dst);
 	if ((skb->len <= mtu) || skb->ignore_df || skb_is_gso(skb)) {
 		IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTREQUESTS);
 
@@ -1396,10 +1396,10 @@ static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
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
index 9d4614622ea6a..712fa475c9664 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -641,7 +641,7 @@ ip4ip6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 
 	/* change mtu on this route */
 	if (rel_type == ICMP_DEST_UNREACH && rel_code == ICMP_FRAG_NEEDED) {
-		if (rel_info > dst_mtu(skb_dst(skb2)))
+		if (rel_info > dst6_mtu(skb_dst(skb2)))
 			goto out;
 
 		skb_dst_update_pmtu_no_confirm(skb2, rel_info);
@@ -1193,7 +1193,7 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 				     t->parms.name);
 		goto tx_err_dst_release;
 	}
-	mtu = dst_mtu(dst) - eth_hlen - psh_hlen - t->tun_hlen;
+	mtu = dst6_mtu(dst) - eth_hlen - psh_hlen - t->tun_hlen;
 	if (encap_limit >= 0) {
 		max_headroom += 8;
 		mtu -= 8;
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index f106b19b74dd7..65dcf08686795 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -1216,7 +1216,7 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 		rcu_read_lock();
 		dst = __sk_dst_get(sk);
 		if (dst)
-			val = dst_mtu(dst);
+			val = dst6_mtu(dst);
 		rcu_read_unlock();
 		if (!val)
 			return -ENOTCONN;
@@ -1315,7 +1315,7 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 		rcu_read_lock();
 		dst = __sk_dst_get(sk);
 		if (dst)
-			mtuinfo.ip6m_mtu = dst_mtu(dst);
+			mtuinfo.ip6m_mtu = dst6_mtu(dst);
 		rcu_read_unlock();
 		if (!mtuinfo.ip6m_mtu)
 			return -ENOTCONN;
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 24d097290dbc0..1367dcbd5c719 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2041,6 +2041,8 @@ static void rt6_update_exception_stamp_rt(struct rt6_info *rt)
 static bool rt6_mtu_change_route_allowed(struct inet6_dev *idev,
 					 struct rt6_info *rt, int mtu)
 {
+	u32 dmtu = dst6_mtu(&rt->dst);
+
 	/* If the new MTU is lower than the route PMTU, this new MTU will be the
 	 * lowest MTU in the path: always allow updating the route PMTU to
 	 * reflect PMTU decreases.
@@ -2051,10 +2053,10 @@ static bool rt6_mtu_change_route_allowed(struct inet6_dev *idev,
 	 * handle this.
 	 */
 
-	if (dst_mtu(&rt->dst) >= mtu)
+	if (dmtu >= mtu)
 		return true;
 
-	if (dst_mtu(&rt->dst) == idev->cnf.mtu6)
+	if (dmtu == idev->cnf.mtu6)
 		return true;
 
 	return false;
@@ -2917,7 +2919,7 @@ static void __ip6_rt_update_pmtu(struct dst_entry *dst, const struct sock *sk,
 
 	if (mtu < IPV6_MIN_MTU)
 		return;
-	if (mtu >= dst_mtu(dst))
+	if (mtu >= dst6_mtu(dst))
 		return;
 
 	if (!rt6_cache_allowed_for_pmtu(rt6)) {
@@ -3235,7 +3237,7 @@ EXPORT_SYMBOL_GPL(ip6_sk_redirect);
 static unsigned int ip6_default_advmss(const struct dst_entry *dst)
 {
 	struct net_device *dev = dst->dev;
-	unsigned int mtu = dst_mtu(dst);
+	unsigned int mtu = dst6_mtu(dst);
 	struct net *net;
 
 	mtu -= sizeof(struct ipv6hdr) + sizeof(struct tcphdr);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 689c0b383ebf9..243d398c35868 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -352,7 +352,7 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr *uaddr,
 static void tcp_v6_mtu_reduced(struct sock *sk)
 {
 	struct dst_entry *dst;
-	u32 mtu;
+	u32 mtu, dmtu;
 
 	if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE))
 		return;
@@ -369,8 +369,9 @@ static void tcp_v6_mtu_reduced(struct sock *sk)
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
@@ -1339,7 +1340,7 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 
 	tcp_ca_openreq_child(newsk, dst);
 
-	tcp_sync_mss(newsk, dst_mtu(dst));
+	tcp_sync_mss(newsk, dst6_mtu(dst));
 	newtp->advmss = tcp_mss_clamp(tcp_sk(sk), dst_metric_advmss(dst));
 
 	tcp_initialize_rcv_mss(newsk);
-- 
2.53.0

