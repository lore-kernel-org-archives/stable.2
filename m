Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745B12C21F4
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 22:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788301299; cv=none; b=iVAbeOtgDvEISIF9O+NyKVUSrsOO/Ojpanj4AuXQ+zkBy06zVyp5pWaWedNkad4E4JAtXihd2EqH0tXO1dKBJnwy4gCTKintwTFezeP5FKaRe0MuCke+30QheL6CQWBiQt1fw2B5RDYcxiOyOpslCleYF/fW8e4+vHmCsj9zDoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788301299; c=relaxed/simple;
	bh=6Zj7Fhnt3G2IAAlV0E03v+HEiySBfDdG1bj/sV6yF4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UyWt/5VZa0PcIRjtsxUQToBDaBPaPJmXXvfFP0lqmqCzM8dGtpZMXWCYHGWpxjwZikp6GvFaOeeSyUC1dPxnTWO4CYTP+XEWYWKXLs6B14bMb82gtdEwmIB6sN2flGcOur/ti2XgZP5uaa90HzUin1PN0hrmr/LWl7WHTkUeS4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cemhLu61; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cemhLu61"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8871F00A3E;
	Tue,  1 Sep 2026 22:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788301298;
	bh=qCnWGE/CGcVoiLekpTHzlhLG7t7ABULzwb1g2ysuFjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cemhLu61+ZE0tO4QV1Fut6dH5/sURGgE/dQIedrvsiXP4CQjga54P9QKr0VE8xihR
	 BHMJZufGIi99wCm8wBQT3bjfzayk8CS13Ozfz70BDgKv8+GTMsXfxkAgEaaIpmO+x9
	 M+l9xj9QmBUVsPdFdkVGoKwEm6ab2qzwI9qHiB1gIuOlDSQcbNSN5+pXfPvEU3XhTp
	 6dQORedN36x2aMPnAI0N3E9Eaatv8VS8/ffFMSSnwhyF2gbSvUESXlI2PA4ffSw/Ux
	 uUY6YlQN7JiRZ5lQPKG9q2PsjJCK5FCSim2wcAit12EBkRqpzyR2LjPwyd/oF1Ha50
	 7YDrXU06Q8Cgw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/4] ipv6: use dst6_mtu() instead of dst_mtu()
Date: Tue,  1 Sep 2026 18:21:32 -0400
Message-ID: <20260901222134.1700802-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901222134.1700802-1-sashal@kernel.org>
References: <2026083106-sterile-daunting-b716@gregkh>
 <20260901222134.1700802-1-sashal@kernel.org>
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
index f9c088cc94395..3ad4edba5f32b 100644
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
index ab745cda1179b..1dbcd79dd9bb0 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -323,7 +323,7 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 	skb->priority = priority;
 	skb->mark = mark;
 
-	mtu = dst_mtu(dst);
+	mtu = dst6_mtu(dst);
 	if ((skb->len <= mtu) || skb->ignore_df || skb_is_gso(skb)) {
 		IP6_UPD_PO_STATS(net, idev, IPSTATS_MIB_OUT, skb->len);
 
@@ -1364,10 +1364,10 @@ static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
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
index 45e0cec505c26..9f4c71889d911 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -643,7 +643,7 @@ ip4ip6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 
 	/* change mtu on this route */
 	if (rel_type == ICMP_DEST_UNREACH && rel_code == ICMP_FRAG_NEEDED) {
-		if (rel_info > dst_mtu(skb_dst(skb2)))
+		if (rel_info > dst6_mtu(skb_dst(skb2)))
 			goto out;
 
 		skb_dst_update_pmtu_no_confirm(skb2, rel_info);
@@ -1185,7 +1185,7 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 				     t->parms.name);
 		goto tx_err_dst_release;
 	}
-	mtu = dst_mtu(dst) - eth_hlen - psh_hlen - t->tun_hlen;
+	mtu = dst6_mtu(dst) - eth_hlen - psh_hlen - t->tun_hlen;
 	if (encap_limit >= 0) {
 		max_headroom += 8;
 		mtu -= 8;
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 41e8b02c12c83..3d598d7fde1f8 100644
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
index 43b8995142e2e..63e8435c4b82f 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1990,6 +1990,8 @@ static void rt6_update_exception_stamp_rt(struct rt6_info *rt)
 static bool rt6_mtu_change_route_allowed(struct inet6_dev *idev,
 					 struct rt6_info *rt, int mtu)
 {
+	u32 dmtu = dst6_mtu(&rt->dst);
+
 	/* If the new MTU is lower than the route PMTU, this new MTU will be the
 	 * lowest MTU in the path: always allow updating the route PMTU to
 	 * reflect PMTU decreases.
@@ -2000,10 +2002,10 @@ static bool rt6_mtu_change_route_allowed(struct inet6_dev *idev,
 	 * handle this.
 	 */
 
-	if (dst_mtu(&rt->dst) >= mtu)
+	if (dmtu >= mtu)
 		return true;
 
-	if (dst_mtu(&rt->dst) == idev->cnf.mtu6)
+	if (dmtu == idev->cnf.mtu6)
 		return true;
 
 	return false;
@@ -2867,7 +2869,7 @@ static void __ip6_rt_update_pmtu(struct dst_entry *dst, const struct sock *sk,
 
 	if (mtu < IPV6_MIN_MTU)
 		return;
-	if (mtu >= dst_mtu(dst))
+	if (mtu >= dst6_mtu(dst))
 		return;
 
 	if (!rt6_cache_allowed_for_pmtu(rt6)) {
@@ -3184,7 +3186,7 @@ EXPORT_SYMBOL_GPL(ip6_sk_redirect);
 static unsigned int ip6_default_advmss(const struct dst_entry *dst)
 {
 	struct net_device *dev = dst->dev;
-	unsigned int mtu = dst_mtu(dst);
+	unsigned int mtu = dst6_mtu(dst);
 	struct net *net;
 
 	mtu -= sizeof(struct ipv6hdr) + sizeof(struct tcphdr);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index dea59b123eb75..5c6b0d98730d9 100644
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
@@ -1394,7 +1395,7 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 
 	tcp_ca_openreq_child(newsk, dst);
 
-	tcp_sync_mss(newsk, dst_mtu(dst));
+	tcp_sync_mss(newsk, dst6_mtu(dst));
 	newtp->advmss = tcp_mss_clamp(tcp_sk(sk), dst_metric_advmss(dst));
 
 	tcp_initialize_rcv_mss(newsk);
-- 
2.53.0

