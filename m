Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C3647886E
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 10:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788346441; cv=none; b=ASUNiGBRCudMPkCi3Psdg+b7xPhf0M1TpG65B4nJn4uWdq5wGRTu8ar1FcqEeNHDq+M2sSU07vQDjeX7L2rgCbAXrOx2l5o6NzjbzqpobxY1tqU3FdpQapDMERRnxHq2DOVfgaozoV0ja1IfgR4JMRIcIUCDqprLv1Mqnpy46Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788346441; c=relaxed/simple;
	bh=Q/k9v3Q+Dk43Faypv4K3rBFetT7b6Y2l9NL+OrPlobU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cLCumPdbTrRnhIgXlvDvqEQVMFRJBNRKvRd43Pd+95JbwsS1Ruv1BSJYYvOJzCdhe3wSc2XTmY9qKzIgC29/9yeFeRSOvy959nZormhGNDL3lF2JDUB/YESGYGpvesL/BnnwgkfAI5T5IZkYFWFUW5t65FI7aV/u8ww8Xn/WvAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8/Jrs1b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8/Jrs1b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0D81F0155A;
	Wed,  2 Sep 2026 10:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788346425;
	bh=bxfLCFVU9wvFHAVzVWmlm7ySbs8On95hRop6vEd6oW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U8/Jrs1biqns0UsFxlWl9s2g3CeRWkhpehqkTgHGw11Dwti/1FHsUW4f82PKjEhR7
	 6wNrxhDXyNKRdV0qmGy8Q8V1iZyjQT3D9cGVNMiByfiGj8TktEqXxbraDn8tMewDzK
	 xtpHVwp4z8tue5GBse8OnmjfInPIS3E1DgQOBHvln0INV49AI6l599g2DdeO3bPrD7
	 kDojOzNlmgqPKneAeGozpd9FoVoHPvTytHvgD/c49oS7xXWkXHYEXM3tc1BbnOc7XQ
	 3t8pf1KIUUldSdr0dM9DJ6LKDq3CZf4E0pmzDv8tFnaevNd8xcfApmxfAJEb1aHEK/
	 hpGJQS5b4Gi3A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/5] ipv6: use dst6_mtu() instead of dst_mtu()
Date: Wed,  2 Sep 2026 06:53:39 -0400
Message-ID: <20260902105340.2049370-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902105340.2049370-1-sashal@kernel.org>
References: <2026083120-unmoral-bovine-2668@gregkh>
 <20260902105340.2049370-1-sashal@kernel.org>
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
Stable-dep-of: 2640e6419594 ("net: advertise TCP MSS from the configured MTU, not the learned PMTU")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/ip6_gre.c       | 2 +-
 net/ipv6/ip6_output.c    | 6 +++---
 net/ipv6/ip6_tunnel.c    | 4 ++--
 net/ipv6/ipv6_sockglue.c | 4 ++--
 net/ipv6/route.c         | 8 +++++---
 net/ipv6/tcp_ipv6.c      | 9 +++++----
 6 files changed, 18 insertions(+), 15 deletions(-)

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
index f023bfe15e2e7..550ae492c6f3b 100644
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
index 302d460b520da..8939039cf151d 100644
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

